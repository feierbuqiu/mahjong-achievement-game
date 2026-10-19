#!/usr/bin/env python3
"""Inspect current publication files and ZIP members without printing private values."""
import argparse
import html
import json
from pathlib import Path, PurePosixPath
import re
import subprocess
import sys
from urllib.parse import unquote
import zipfile

ROOT = Path(__file__).resolve().parents[1]
USER = r'[A-Za-z0-9][A-Za-z0-9_.-]*'
PERSONAL_PATH = re.compile(
    r'(?:[A-Za-z]:[\\/]+(?:Users|home|Documents and Settings)[\\/]+' + USER +
    r'|/(?:Users|home)/' + USER + r'|/mnt/[a-z]/Users/' + USER + r')', re.I)
SECRET = re.compile(
    r'-----BEGIN (?:(?:OPENSSH|RSA|EC) )?PRIVATE KEY-----|gh[pousr]_[A-Za-z0-9]{30,}')


def strings(value):
    if isinstance(value, str):
        yield value
    elif isinstance(value, dict):
        for key, item in value.items():
            yield from strings(key)
            yield from strings(item)
    elif isinstance(value, list):
        for item in value:
            yield from strings(item)


def inspect_text(text):
    """Scan text plus decoded JSON/JSONL strings and common escaped representations."""
    values = [text]
    try:
        values.extend(strings(json.loads(text)))
    except ValueError:
        for line in text.splitlines():
            if line.lstrip().startswith(('{', '[')):
                try:
                    values.extend(strings(json.loads(line)))
                except ValueError:
                    pass
    reasons = set()
    for value in values:
        for _ in range(3):
            if PERSONAL_PATH.search(value):
                reasons.add('personal-home-path')
            if SECRET.search(value):
                reasons.add('credential-or-private-key')
            decoded = html.unescape(unquote(value))
            decoded = re.sub(r'\\u([0-9a-fA-F]{4})', lambda m: chr(int(m[1], 16)), decoded)
            if decoded == value:
                break
            value = decoded
    return sorted(reasons)


def check_bytes(raw, label):
    problems = inspect_text(raw.decode('utf-8-sig', errors='replace'))
    if problems:
        raise ValueError('Privacy check failed in ' + label + ': ' + ', '.join(problems))


def check_zip(path):
    count = 0
    with zipfile.ZipFile(path) as archive:
        names = archive.namelist()
        if len(names) != len(set(names)):
            raise ValueError('Duplicate ZIP members')
        if sum(info.file_size for info in archive.infolist()) > 1_000_000_000:
            raise ValueError('Archive exceeds this bounded inspection limit')
        for info in archive.infolist():
            name = info.filename
            part = PurePosixPath(name)
            if part.is_absolute() or '..' in part.parts or '\\' in name or ':' in name:
                raise ValueError('Unsafe archive member name')
            check_bytes(name.encode(), 'archive member name')
            if info.is_dir():
                continue
            if info.file_size > 100_000_000:
                raise ValueError('Archive member exceeds the inspection limit')
            check_bytes(archive.read(info), 'archive member ' + name)
            count += 1
    return count


def check_files(root=ROOT):
    listed = subprocess.check_output(
        ['git', 'ls-files', '--cached', '--others', '--exclude-standard', '-z'], cwd=root)
    names = sorted({name.decode('utf-8') for name in listed.split(b'\0') if name})
    count = 0
    for name in names:
        path = root / name
        if path.is_file():
            check_bytes(name.encode(), 'publication filename')
            check_bytes(path.read_bytes(), name)
            count += 1
    return count


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--archive', type=Path, action='append', default=[])
    parser.add_argument('--archives-only', action='store_true')
    args = parser.parse_args()
    files = 0 if args.archives_only else check_files()
    archives = [dict(name=p.name, files=check_zip(p)) for p in args.archive]
    print(json.dumps(dict(status='PASS_PUBLICATION_PRIVACY_PATTERNS', files=files, archives=archives,
        scope='Current files and supplied ZIP contents; no Git history rewrite and no guarantee against every form of identifying data')))


if __name__ == '__main__':
    try:
        main()
    except (OSError, ValueError, zipfile.BadZipFile, subprocess.CalledProcessError) as error:
        print(str(error), file=sys.stderr)
        raise SystemExit(1)
