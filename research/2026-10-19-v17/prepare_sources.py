#!/usr/bin/env python3
"""Assemble the exact mapped Lean source files; never compile or execute them."""
import argparse
import hashlib
import json
from pathlib import Path
import sys

BASE=Path(__file__).resolve().parent
ROOT=BASE.parents[1]


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output',required=True,type=Path)
    args=parser.parse_args();output=args.output.resolve()
    if output.exists():raise ValueError('Output must be a new directory')
    mapping=json.loads((BASE/'source-map.json').read_text(encoding='utf-8'))
    files=[]
    for row in mapping['modules']:
        original=(ROOT/row['public_path']).resolve()
        if not original.is_relative_to(ROOT):raise ValueError('Source path outside repository')
        raw=original.read_bytes()
        if len(raw)!=row['bytes'] or hashlib.sha256(raw).hexdigest()!=row['sha256']:
            raise ValueError('Source identity differs: '+row['module'])
        target=(output/'source'/Path(*row['module'].split('.'))).with_suffix('.lean')
        if not target.is_relative_to(output):raise ValueError('Invalid module name')
        files.append((target,raw))
    output.mkdir(parents=True,exist_ok=False)
    for target,raw in files:
        target.parent.mkdir(parents=True,exist_ok=True)
        with target.open('xb') as f:f.write(raw)
    (output/'source-map.json').write_bytes((BASE/'source-map.json').read_bytes())
    print(json.dumps(dict(status='ASSEMBLED_EXACT_SOURCE_ONLY',modules=len(files),
        entry='V17ComputeReplay',compiled=False,Lean_or_native_execution_started=False)))


if __name__=='__main__':
    try:main()
    except (ValueError,OSError,KeyError) as exc:
        print(str(exc),file=sys.stderr);raise SystemExit(1)
