#!/usr/bin/env python3
"""Verify the English supplement's bytes, formulas, tables and reproduction scope."""
import hashlib
import json
from pathlib import Path
import re
from urllib.parse import unquote
from verify_paper import normalise

ROOT = Path(__file__).resolve().parents[1]
BASE = ROOT / 'papers/lean-verification'


def read(path):
    return json.loads(path.read_text(encoding='utf-8-sig'))


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def require(value, message):
    if not value:
        raise ValueError(message)


def private_paths(value):
    if isinstance(value, dict):
        return any(private_paths(k) or private_paths(v) for k,v in value.items())
    if isinstance(value, list):
        return any(map(private_paths,value))
    return isinstance(value,str) and bool(re.search(r'[A-Za-z]:[\\/](?:Users|home)[\\/]',value))


def verify():
    provenance = read(BASE/'provenance.json')
    expected = read(BASE/'equations.json')
    require(provenance['primary_language'] == 'en' and not provenance['chinese_manuscript_published'],
            'English-only publication scope changed')
    require(sha(BASE/'manuscript.md') == provenance['published_manuscript_sha256'], 'Manuscript hash changed')
    require(expected['original_manuscript_sha256'] == provenance['original_manuscript_sha256'],
            'Original formula identity changed')
    copies = {}
    for item in provenance['artifacts']:
        rel = item['published_path'];path = (ROOT/rel).resolve()
        require(path.is_relative_to(BASE) and rel not in copies, f'Invalid publication path: {rel}')
        require(sha(path) == item['published_sha256'] and path.stat().st_size == item['published_bytes'],
                f'Public evidence changed: {rel}')
        if not item['transformations']:
            require(item['published_sha256'] == item['original_sha256'], f'Original copy changed: {rel}')
        copies[rel] = item
    expression_pattern = re.compile(r'^```math\n(?P<display>.*?)\n```|\$`(?P<inline>.*?)`\$', re.M|re.S)
    expression_count = 0
    for name, formulas in expected['documents'].items():
        text = (BASE/name).read_text(encoding='utf-8')
        observed = [dict(kind=m.lastgroup, tex=normalise(m[m.lastgroup])) for m in expression_pattern.finditer(text)]
        require(observed == [dict(kind=x['kind'],tex=normalise(x['tex'])) for x in formulas],
                f'Formula content or order changed: {name}')
        require(not re.search(r'\\[\[\]()]|\\tag\{|\\operatorname',text), f'Incompatible formula dialect: {name}')
        for line in text.splitlines():
            if line.startswith('|'):
                require(all('|' not in tex for tex in re.findall(r'\$`(.*?)`\$',line)), 'Unprotected math table delimiter')
        expression_count += len(observed)
    require(len(expected['documents']['manuscript.md']) == expression_count == 26, 'Formula count mismatch')
    text = (BASE/'manuscript.md').read_text(encoding='utf-8')
    table_text = '\n'.join(x for x in text.splitlines() if x.startswith('|'))
    table_text = re.sub(r'\[([^\]]+)\]\([^)]+\)',r'\1',table_text)
    require(re.findall(r'\d+(?:,\d{3})*(?:\.\d+)?',table_text) == expected['manuscript_table_numeric_tokens'],
            'Numerical table content changed')
    require(re.findall(r'\\qquad\s*\\text\{\(([^)]+)\)\}',text) == expected['manuscript_equation_tags'],
            'Equation labels changed')
    for path in BASE.rglob('*.md'):
        for url in re.findall(r'\]\(([^\s)]+)\)',path.read_text(encoding='utf-8-sig')):
            if re.match(r'[a-zA-Z]+:',url) or url.startswith('#'):
                continue
            target = (path.parent/unquote(url.split('#',1)[0])).resolve()
            require(target.is_relative_to(ROOT) and target.exists(), f'Broken paper resource: {url}')
            if '#source-' in url:
                require('## '+url.split('#',1)[1] in target.read_text(encoding='utf-8'), f'Broken evidence anchor: {url}')
    for path in BASE.rglob('*.json'):
        require(not private_paths(read(path)), f'Private path in JSON: {path.name}')
    source_manifest = read(BASE/'reproduction/model-source-manifest.json')
    source_hashes = {item['module']: item['sha256'] for item in source_manifest['sources']}
    require(len(source_hashes) == source_manifest['source_modules'] == 84, 'Companion source inventory mismatch')
    for item in source_manifest['sources']:
        require(sha(ROOT/'research/2026-09-15/lean'/item['path']) == item['sha256'],
                f"Companion and published source differ: {item['module']}")
    for name, seconds in [('source-replay.json',94.172),('recipient-replay.json',93.922)]:
        receipt = read(BASE/'reproduction'/name)
        require(receipt['status'] == 'PASS_KERNEL_SOURCE' and receipt['completed_source_modules'] == 84 and
                receipt['source_sha256'] == source_hashes and receipt['trust_level'] == 0 and
                receipt['wall_seconds'] == seconds, f'Replay identity/count mismatch: {name}')
        require(not receipt['reused_project_objects'] and not receipt['native_workers_executed'] and
                not receipt['historical_pn_payloads_read'] and receipt['historical_pn_rows_newly_checked'] == 0 and
                receipt['empty_game_lean'] == 'NOT_VERIFIED', f'Replay scope mismatch: {name}')
    companion = read(BASE/'companion.json')
    delivery = read(BASE/'reproduction/recipient_delivery_validation.json')
    require(companion['sha256'] == delivery['final_archive_sha256'] ==
            'fdd9e7ebaaaeac891e746b69f604ee9fc92ccdb85c4c03f92b4affd164f4da33' and
            companion['bytes'] == delivery['final_archive_bytes'] == 175554 and
            companion['input_files'] == delivery['packaged_input_files'] == 91 and
            delivery['audited_declarations'] == 79, 'Companion delivery identity mismatch')
    empirical = read(BASE/'empirical_evidence.json')
    require(empirical['current_status']['empty_game_Lean'] == 'NOT_VERIFIED' and
            empirical['current_status']['new_route_global_slots_checked'] == 22512356,
            'Empirical proof scope changed')
    return dict(status='PASS_ENGLISH_LEAN_SUPPLEMENT', formulas=expression_count,
                imported_artifacts=len(copies), source_modules=84, audited_declarations=79,
                companion_sha256=companion['sha256'], new_historical_pn_rows=0,
                scope='Publication and recorded-replay integrity; not a fresh kernel run, browser render or full historical P/N replay.')


if __name__ == '__main__':
    print(json.dumps(verify()))
