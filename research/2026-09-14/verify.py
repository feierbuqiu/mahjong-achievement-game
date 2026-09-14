#!/usr/bin/env python3
"""Verify the dated public handoff; optionally kernel-check its frozen source."""
import argparse
from datetime import datetime, timezone
import hashlib
import json
import math
import os
from pathlib import Path
import re
import shutil
import subprocess
import time

BASE = Path(__file__).resolve().parent
ROOT = BASE.parents[1]


def read(path):
    return json.loads(path.read_text(encoding='utf-8-sig'))


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def require(condition, message):
    if not condition:
        raise ValueError(message)


def near(actual, expected):
    require(math.isclose(actual, expected, rel_tol=1e-10), f'Numeric mismatch: {actual} != {expected}')


def verify():
    provenance = read(BASE / 'provenance.json')
    by_path = {}
    for item in provenance['artifacts']:
        rel = item['published_path']
        path = (BASE / rel).resolve()
        require(path.is_relative_to(BASE) and rel not in by_path, f'Invalid manifest path: {rel}')
        require(path.stat().st_size == item['published_bytes'] and
                sha(path) == item['published_sha256'], f'Published artifact changed: {rel}')
        if not item['transformations']:
            require(item['published_sha256'] == item['original_sha256'], f'Original copy changed: {rel}')
        by_path[rel] = item
    sources = {p.relative_to(BASE).as_posix() for p in (BASE / 'lean').rglob('*.lean')}
    require(sources == {p for p in by_path if p.startswith('lean/')}, 'Unmanifested source')
    require(len(sources) == provenance['source_modules'] == 56, 'Source count mismatch')
    # Connect the measured worker to the exact source archived here.
    build = read(BASE / 'evidence/build/GeneralWorker.json')
    require(build['status'] == 'PASS' and build['native'], 'Worker build incomplete')
    for step in build['steps']:
        require(sha(BASE / 'lean' / (step['module'].replace('.', '/') + '.lean')) ==
                step['source_sha256'], f"Measured source mismatch: {step['module']}")

    reports = []
    for name in ['general_benchmark_v1', 'peak_parallel_v1']:
        folder = BASE / 'evidence' / name
        report = read(folder / 'result.json')
        require(report['state'] == 'COMPLETE_BOUNDED_TEST', 'Benchmark incomplete')
        require(not report['full_scan_authorized_by_this_test'], 'Unexpected full scan')
        manifest = by_path[f'evidence/{name}/manifest.json']
        require(report['manifest_sha256'] == manifest['original_sha256'], 'Original manifest mismatch')
        require(read(folder / 'manifest.json')['build_sha256'] ==
                by_path['evidence/build/GeneralWorker.json']['original_sha256'], 'Build identity mismatch')
        for case in report['results']:
            receipt = read(folder / 'cases' / case['case'] / 'receipt.json')
            require(receipt['manifest_sha256'] == report['manifest_sha256'] and
                    receipt['accepted'] == case, f"Case receipt mismatch: {case['case']}")
            spans = []
            for output in case['outputs']:
                path = (folder / output['path'].replace('\\', '/')).resolve()
                require(path.is_relative_to(folder), 'Invalid output path')
                value = read(path)
                require(sha(path) == output['sha256'] and value == output['value'], 'Worker output changed')
                require(value['status'] == 'PASS' and value['layer'] == case['layer'] and
                        value['bucket'] == case['bucket'], 'Worker scope mismatch')
                spans.append((value['start'], value['start'] + value['count']))
            edge = case['start']
            for lo, hi in sorted(spans):
                require(lo == edge and hi > lo, 'Overlapping or missing worker range')
                edge = hi
            require(edge == case['start'] + case['rows'], 'Case coverage mismatch')
            near(case['rows_per_second_scan'], case['rows'] / case['scan_critical_seconds'])
        reports.append(report)

    base, peak = reports
    cases = base['results'] + peak['results']
    feasibility = read(BASE / 'evidence/GENERAL_FEASIBILITY.json')
    require(len(cases) == feasibility['completed_cases'] == 47, 'Case count mismatch')
    require(sum(c['rows'] for c in cases) == feasibility['test_evaluations'] == 745472, 'Evaluation mismatch')
    intervals = {}
    for case in cases:
        intervals.setdefault((case['layer'], case['bucket']), []).append((case['start'], case['start'] + case['rows']))
    unique = 0
    for spans in intervals.values():
        merged = []
        for lo, hi in sorted(spans):
            if merged and lo <= merged[-1][1]:
                merged[-1] = (merged[-1][0], max(hi, merged[-1][1]))
            else:
                merged.append((lo, hi))
        unique += sum(hi - lo for lo, hi in merged)
    require(unique == feasibility['unique_sampled_slots'] == 356352, 'Distinct interval mismatch')
    selected = base['selected_buckets']
    samples32 = [c for c in base['results'] if c['case'].startswith('layer32_')]
    chosen_peak = [next(c for c in peak['results'] if c['case'] == name)
                   for name in ['peak_scale_p2_t6', 'peak_h005_p2_t6', 'peak_h035_p2_t6']]
    mass32, mass23 = (sum(r['size'] for r in selected[layer]) for layer in ['32', '23'])
    cost32 = sum(r['size'] / mass32 * sum(1 / c['rows_per_second_scan'] for c in samples32
                 if c['bucket'] == r['h']) / 3 for r in selected['32'])
    cost23 = sum(r['size'] / mass23 * next(1 / c['rows_per_second_scan'] for c in chosen_peak
                 if c['bucket'] == r['h']) for r in selected['23'])
    total = 778532864302
    required = total / (30 * 86400)
    near(1 / cost32, feasibility['representative_layer32']['rows_per_second'])
    near(1 / cost23, feasibility['representative_peak23']['rows_per_second'])
    near(required, feasibility['thirty_day_required_rows_per_second'])
    scenarios = feasibility['scenarios_not_forecasts']
    near(total * cost32 / 86400, scenarios['all_rows_at_layer32_rate_days'])
    near(total * cost23 / 86400, scenarios['all_rows_at_weighted_peak_rate_days'])
    near(mass23 * cost23 / 86400, scenarios['selected_three_peak_buckets_alone_days'])
    near(required * cost32, feasibility['required_speed_factor']['relative_to_layer32'])
    near(required * cost23, feasibility['required_speed_factor']['relative_to_peak23'])
    coverage = read(BASE / 'evidence/ACTUAL_SCAN_ACCEPTANCE.json')
    require(coverage['unique_production_slots'] == sum(r['rows'] for r in coverage['runs']) ==
            22512356, 'Complete-layer coverage mismatch')
    for run in coverage['runs']:
        receipt = read(BASE / 'evidence' / run['run'] / 'acceptance.json')
        require(receipt['committed_rows'] == run['rows'] == receipt['target_rows'], 'Layer receipt mismatch')
    registry = read(BASE / 'evidence/paused-registry.json')
    require(registry['state'] == 'PAUSED' and registry['certified'] ==
            sum(r['count'] for r in registry['certified_by_layer']) == 24655, 'Registry mismatch')
    require(feasibility['full_table_Lean'] == registry['empty_game_Lean'] == 'NOT_VERIFIED', 'Opening status mismatch')
    require(not feasibility['full_scan_launched'], 'Unexpected campaign launch')
    negative = read(BASE / 'evidence/general-negative-tests.json')
    require(negative['status'] == 'PASS' and negative['production_coverage_credit'] == 0,
            'Negative-test scope mismatch')
    require([(r['case'], r['accepted_output']) for r in negative['outcomes']] ==
            [('valid', True), ('source_label_flip', False), ('missing_target_bucket', False),
             ('missing_symmetry_path', False)], 'Negative-test result mismatch')
    resume = read(BASE / 'evidence/pause-resume.json')
    require(resume['status'] == 'PASS' and resume['committed_chunks_reexecuted'] == 0 and
            resume['production_coverage_credit'] == 0, 'Pause/resume result mismatch')
    replay = read(BASE / 'evidence/checker-kernel-replay.json')
    require(replay['status'] == 'PASS_KERNEL_SOURCE' and replay['trust_level'] == 0 and
            len(replay['steps']) == 56 and all(s['return_code'] == 0 for s in replay['steps']),
            'Publication source replay incomplete')
    for name, digest in replay['source_sha256'].items():
        require(sha(BASE / 'lean' / (name.replace('.', '/') + '.lean')) == digest,
                f'Publication replay source mismatch: {name}')
    hardware = read(BASE / 'hardware.json')
    require(hardware['installed_memory_bytes'] == 32 * 1024**3 and
            hardware['cpu']['NumberOfCores'] == 8 and hardware['cpu']['NumberOfLogicalProcessors'] == 16,
            'Hardware summary mismatch')
    status = read(ROOT / 'RESEARCH_STATUS.json')
    require(status['formal_verification']['status'] == 'incomplete_personal_effort_paused' and
            status['formal_verification']['compiled_checker_complete_layer_rows'] == 22512356,
            'Homepage status mismatch')
    return dict(status='PASS_PUBLIC_HANDOFF', artifacts=len(by_path), checker_source_modules=len(sources),
                benchmark_cases=len(cases), evaluations=745472, unique_sampled_slots=unique,
                scope='Artifact identity and receipt arithmetic; no large data scan or opening proof.')


def kernel_replay(executable):
    lean = shutil.which(executable)
    require(lean is not None, 'Lean not found')
    version = subprocess.check_output([lean, '--version'], text=True, timeout=30).strip()
    require(re.search(r'\b4\.33\.1\b', version), 'Expected Lean 4.33.1')
    source = BASE / 'lean'
    modules = {p.relative_to(source).with_suffix('').as_posix().replace('/', '.'): p
               for p in source.rglob('*.lean')}
    ordered, seen, visiting = [], set(), set()

    def visit(name):
        if name in seen:
            return
        require(name not in visiting and name in modules, f'Invalid dependency: {name}')
        visiting.add(name)
        for line in modules[name].read_text(encoding='utf-8-sig').splitlines():
            if line.startswith('import '):
                for child in line.split('--', 1)[0].split()[1:]:
                    if child.split('.')[0] not in {'Std', 'Init', 'Lean', 'Lake'}:
                        visit(child)
        visiting.remove(name)
        seen.add(name)
        ordered.append(name)

    for name in sorted(modules):
        visit(name)
    destination = ROOT / 'runs' / ('checker-kernel-' + datetime.now(timezone.utc).strftime('%Y%m%dT%H%M%S%fZ'))
    destination.mkdir(parents=True, exist_ok=False)
    frozen, objects = destination / 'source', destination / 'modules'
    shutil.copytree(source, frozen)
    objects.mkdir()
    env = os.environ.copy()
    env['LEAN_PATH'] = str(objects)
    report = dict(status='INCOMPLETE', lean_version=version, trust_level=0,
                  source_sha256={n: sha(p) for n, p in modules.items()}, steps=[],
                  empty_game_lean='NOT_VERIFIED', scope='Fresh source checking; compiled workers are not executed.')
    started = time.monotonic()
    for name in ordered:
        rel = Path(name.replace('.', '/'))
        obj = objects / rel.with_suffix('.olean')
        obj.parent.mkdir(parents=True, exist_ok=True)
        command = [lean, '--trust=0', '-M3072', '-j1', '-R', str(frozen), '-o', str(obj),
                   str(frozen / rel.with_suffix('.lean'))]
        log = destination / (name + '.log')
        begin = time.monotonic()
        with log.open('wb') as stream:
            try:
                code = subprocess.run(command, cwd=frozen, env=env, stdout=stream,
                    stderr=subprocess.STDOUT, timeout=300,
                    creationflags=subprocess.CREATE_NO_WINDOW if os.name == 'nt' else 0).returncode
            except subprocess.TimeoutExpired:
                code = 124
        report['steps'].append(dict(module=name, command=command, return_code=code,
                                   seconds=round(time.monotonic() - begin, 3), log=log.name, log_sha256=sha(log)))
        report['wall_seconds'] = round(time.monotonic() - started, 3)
        (destination / 'result.json').write_text(json.dumps(report, indent=2) + '\n', encoding='utf-8')
        require(code == 0, f'Lean failed: {name}; see {log}')
        print(f'PASS {len(report["steps"])}/{len(ordered)} {name}', flush=True)
    report['status'] = 'PASS_KERNEL_SOURCE'
    (destination / 'result.json').write_text(json.dumps(report, indent=2) + '\n', encoding='utf-8')
    print(json.dumps(dict(status=report['status'], modules=len(ordered), wall_seconds=report['wall_seconds'],
                         receipt=str(destination / 'result.json'), empty_game_lean='NOT_VERIFIED')))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--lean', help='Optional path to Lean 4.33.1; replay the 56-module checker source')
    args = parser.parse_args()
    print(json.dumps(verify()))
    if args.lean:
        kernel_replay(args.lean)
