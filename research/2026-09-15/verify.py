#!/usr/bin/env python3
"""Check the public progress records; optionally replay models and audit axioms."""
import argparse
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import re
import shutil
import subprocess

BASE = Path(__file__).resolve().parent
ROOT = BASE.parents[1]
ALLOWED_AXIOMS = {'propext', 'Classical.choice', 'Quot.sound'}


def read(path):
    return json.loads(path.read_text(encoding='utf-8-sig'))


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def require(condition, message):
    if not condition:
        raise ValueError(message)


def verify():
    provenance = read(BASE / 'provenance.json')
    acceptance = read(BASE / 'evidence/acceptance.json')
    require(sha(BASE / 'evidence/acceptance.json') == provenance['acceptance_sha256'],
            'Acceptance identity changed')
    copies = {}
    for item in provenance['artifacts']:
        rel = item['published_path']
        path = (BASE / rel).resolve()
        require(path.is_relative_to(BASE) and rel not in copies, f'Invalid artifact path: {rel}')
        require(path.stat().st_size == item['published_bytes'] == item['original_bytes'] and
                sha(path) == item['published_sha256'] == item['original_sha256'] and
                not item['transformations'], f'Artifact changed: {rel}')
        if item['original_path'] in acceptance['evidence_files']:
            require(sha(path) == acceptance['evidence_files'][item['original_path']],
                    f'Acceptance binding mismatch: {rel}')
        copies[rel] = item
    sources = {p.relative_to(BASE).as_posix() for p in (BASE / 'lean').rglob('*.lean')}
    require(sources == {p for p in copies if p.startswith('lean/')} and
            len(sources) == provenance['source_modules'] == 84, 'Source inventory mismatch')
    for rel in sources:
        require(copies[rel]['original_path'] in acceptance['evidence_files'],
                f'Source absent from original acceptance: {rel}')
    build = read(BASE / 'evidence/kernel-build.json')
    require(build['status'] == 'PASS' and not build['native'] and
            build['entry'] == provenance['entry_module'], 'Wrong model build')
    build_sources = set()
    for step in build['steps']:
        rel = 'lean/' + step['module'].replace('.', '/') + '.lean'
        require(rel not in build_sources and sha(BASE / rel) == step['source_sha256'],
                f'Build/source mismatch: {rel}')
        build_sources.add(rel)
    require(build_sources == sources, 'Build closure mismatch')
    require(len(acceptance['proof_modules']) == 10 and len(acceptance['printed_axioms']) == 79 and
            all(set(v) <= ALLOWED_AXIOMS for v in acceptance['printed_axioms'].values()) and
            acceptance['kernel_limits'] == dict(trust=0, max_heap_mib=3072, threads=1),
            'Reported theorem audit mismatch')
    require(acceptance['status'] == 'PASS_FINITE_RETROGRADE_MODELS_AND_BOUNDED_PRODUCTION_AUDIT' and
            acceptance['empty_game_Lean'] == acceptance['universal_whole_cpp_refinement'] == 'NOT_VERIFIED' and
            acceptance['fully_instantiated_whole_solver_kernel_certificate'] == 'NOT_CONSTRUCTED' and
            not acceptance['historical_output_formally_bound'] and acceptance['new_pn_rows'] == 0,
            'Proof boundary changed')
    operational = read(BASE / 'evidence/operational-acceptance.json')
    require(operational['result'] == acceptance['operational'], 'Operational receipt mismatch')
    result = operational['result']
    binding = read(BASE / 'evidence/operational-binding.json')
    pairs = binding['thread_pairs']
    require(len(pairs) * 2 == result['cases'] == 102 and
            len({(p['n'], p['h']) for p in pairs}) == result['selected_buckets'] == 11 and
            sum(p['rows'] for p in pairs) * 2 == result['solver_rows'] == 13741216 and
            len({(p['n'], p['h'], p['synthetic_pattern']) for p in pairs}) == len(pairs),
            'Synthetic configuration or row count mismatch')
    require(binding['synthetic_only'] and binding['replayed_solver_rows'] == 0 and
            binding['historical_payload_bytes_read'] == 0 and not result['historical_pn_inputs'] and
            result['global_pn_rows'] == 0, 'Synthetic/historical scope mismatch')
    for fragment in acceptance['source_fragments']:
        public_source = ROOT / 'src/retro' / Path(fragment['source']).name
        contents = public_source.read_bytes()
        data = contents[fragment['offset']:fragment['offset'] + fragment['length']]
        require(sha(public_source) == fragment['source_sha256'] and
                hashlib.sha256(data).hexdigest() == fragment['sha256'] and
                data == (BASE / 'source/fragments' / Path(fragment['fragment']).name).read_bytes(),
                f"C++ source correspondence mismatch: {fragment['name']}")
    current = read(ROOT / 'RESEARCH_STATUS.json')['formal_verification']
    require(current['empty_game_lean'] == acceptance['empty_game_Lean'] and
            current['compiled_checker_complete_layer_rows'] == acceptance['existing_pn_unique_rows'] == 22512356 and
            current['latest_new_historical_pn_rows'] == acceptance['new_pn_rows'] and
            current['latest_finite_algorithm_audited_theorems'] == len(acceptance['printed_axioms']) and
            current['latest_synthetic_row_comparisons'] == result['solver_rows'],
            'Current status/evidence mismatch')
    return dict(status='PASS_PUBLIC_LEAN_PROGRESS', artifacts=len(copies), source_modules=len(sources),
                reported_theorems=79, synthetic_configurations=102, synthetic_row_comparisons=13741216,
                new_historical_pn_rows=0, empty_game_lean='NOT_VERIFIED',
                scope='Public artifact, receipt and source consistency; no kernel or native execution.')


def kernel_replay(executable):
    # Share the existing bounded, fresh-object source replay implementation.
    spec = importlib.util.spec_from_file_location('checker_replay', BASE.parent / '2026-09-14/verify.py')
    helper = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(helper)
    helper.BASE = BASE
    destination = helper.kernel_replay(executable)
    acceptance = read(BASE / 'evidence/acceptance.json')
    audit = destination / 'source/ProgressAxiomAudit.lean'
    text = 'import Mahjong.OptimizedRetroCertification\n' + ''.join(
        '#print axioms ' + name + '\n' for name in acceptance['printed_axioms'])
    audit.write_bytes(text.encode('utf-8'))
    env = os.environ.copy()
    env['LEAN_PATH'] = str(destination / 'modules')
    log = destination / 'axioms.log'
    with log.open('wb') as stream:
        completed = subprocess.run([shutil.which(executable), '--trust=0', '-M3072', '-j1', str(audit)],
            cwd=audit.parent, env=env, stdout=stream, stderr=subprocess.STDOUT, timeout=300,
            creationflags=subprocess.CREATE_NO_WINDOW if os.name == 'nt' else 0)
    require(completed.returncode == 0, f'Axiom audit failed; see {log}')
    records = re.findall(r"'([^']+)'\s+(?:does not depend on any axioms|depends on axioms:\s*\[([^\]]*)\])",
                         log.read_text(encoding='utf-8'))
    observed = {name: sorted(v.strip() for v in axioms.split(',') if v.strip())
                for name, axioms in records}
    require(len(records) == len(observed) == 79 and observed.keys() == acceptance['printed_axioms'].keys(),
            f'Incomplete axiom audit; see {log}')
    require(all(set(v) <= ALLOWED_AXIOMS for v in observed.values()), f'Unexpected axioms; see {log}')
    report = dict(status='PASS_KERNEL_MODELS_AND_AXIOMS', source_modules=84, audited_theorems=79,
                  trust_level=0, axioms=observed, log_sha256=sha(log),
                  new_historical_pn_rows=0, empty_game_lean='NOT_VERIFIED',
                  scope='Fresh kernel replay of published source and axiom audit; no historical P/N replay.')
    (destination / 'axiom-result.json').write_bytes((json.dumps(report, indent=2) + '\n').encode('utf-8'))
    print(json.dumps(dict(status=report['status'], source_modules=84, audited_theorems=79,
                         receipt=str(destination / 'axiom-result.json'), empty_game_lean='NOT_VERIFIED')))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--lean', help='Optional Lean 4.33.1 executable for fresh source and axiom replay')
    args = parser.parse_args()
    print(json.dumps(verify()))
    if args.lean:
        kernel_replay(args.lean)
