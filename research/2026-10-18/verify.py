#!/usr/bin/env python3
"""Read-only public artifact/receipt checks; never starts a verifier campaign."""
import ast
import hashlib
import json
import math
from pathlib import Path
import re

BASE = Path(__file__).resolve().parent
ROOT = BASE.parents[1]
ALLOWED_AXIOMS = {'propext', 'Classical.choice', 'Quot.sound'}
PRIVATE = re.compile('(?:[A-Za-z]:[\\\\/]+(?:Users|home)[\\\\/]+[A-Za-z0-9][A-Za-z0-9_.-]*|/mnt/[a-z]/Users/[A-Za-z0-9][A-Za-z0-9_.-]*|/(?:home|Users)/[A-Za-z0-9][A-Za-z0-9_.-]*)', re.I)


def read(path):
    return json.loads(path.read_text(encoding='utf-8-sig'))


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def require(value, message):
    if not value:
        raise ValueError(message)


def near(left, right):
    require(math.isclose(left, right, rel_tol=1e-11, abs_tol=1e-8), 'Numeric inconsistency')


def strings(value):
    if isinstance(value, str):
        yield value
    elif isinstance(value, dict):
        for key, item in value.items():
            yield key
            yield from strings(item)
    elif isinstance(value, list):
        for item in value:
            yield from strings(item)


def verify():
    provenance = read(BASE / 'provenance.json')
    copies = {}
    originals = {}
    for item in provenance['artifacts']:
        rel = item['published_path']
        path = (BASE / rel).resolve()
        require(path.is_relative_to(BASE) and path.is_file() and rel not in copies, 'Invalid/duplicate artifact path')
        require(path.stat().st_size == item['published_bytes'] and sha(path) == item['published_sha256'], 'Artifact changed: ' + rel)
        if not item['transformations']:
            require(item['original_sha256'] == item['published_sha256'] and item['original_bytes'] == item['published_bytes'], 'Unrecorded transformation')
        text = path.read_text(encoding='utf-8-sig')
        require(not re.search(r'[\u3400-\u4dbf\u4e00-\u9fff]', text), 'Non-English publication')
        values = strings(json.loads(text)) if path.suffix == '.json' else [text]
        require(all(not PRIVATE.search(s) for s in values), 'Private workstation path: ' + rel)
        if path.suffix == '.py':
            ast.parse(text, filename=rel)  # Parse source for inspection without importing/executing it.
        copies[rel] = item
        originals[item['original_path']] = item

    inventory = read(BASE / 'evidence/theorem-inventory.json')
    modules = inventory['modules']
    names = {m['module'] for m in modules}
    require(len(names) == len(modules) == provenance['linked_source_modules'] == 132, 'Linked module count mismatch')
    require({p.relative_to(BASE / 'lean').as_posix() for p in (BASE / 'lean').rglob('*.lean')} ==
            {m.replace('.', '/') + '.lean' for m in names}, 'Source closure inventory mismatch')
    for module in modules:
        item = copies['lean/' + module['module'].replace('.', '/') + '.lean']
        require(not item['transformations'] and item['original_sha256'] == module['source']['sha256'], 'Source/build binding mismatch')
        require(all(not n.startswith('Mahjong.') or n in names for n in module['direct_imports']), 'Missing project import')
    theorems = inventory['theorem_inventory']
    require(len({t['name'] for t in theorems}) == len(theorems) == provenance['selected_recorded_theorems'] == 104, 'Selected theorem count mismatch')
    require(sum(inventory['theorem_counts_by_module'].values()) == 104 and
            inventory['recorded_trust_level'] == 0, 'Recorded theorem/trust mismatch')
    for theorem in theorems:
        require(set(theorem['axioms']) <= ALLOWED_AXIOMS, 'Unexpected recorded axiom')
        require(theorem['source']['path'] in originals, 'Missing theorem source')
        log_item = originals[theorem['kernel_log']['path']]
        require(log_item['original_sha256'] == theorem['kernel_log']['sha256'], 'Recorded log identity mismatch')
        log = (BASE / log_item['published_path']).read_text(encoding='utf-8')
        observed = {name: sorted(x.strip() for x in (axioms or '').split(',') if x.strip())
            for name,axioms in re.findall(r"'([^']+)'\s+(?:does not depend on any axioms|depends on axioms:\s*\[([^\]]*)\])", log)}
        require(observed.get(theorem['name']) == sorted(theorem['axioms']), 'Theorem/log mismatch: ' + theorem['name'])

    layer = read(BASE / 'evidence/layer32-audit.json')
    require(layer['status'] == 'PASS_COMPLETE_LAYER32' and layer['complete_buckets'] == 68, 'Layer 32 incomplete')
    require(layer['accepted_unique_rows'] == layer['P_rows'] + layer['N_rows'] ==
            layer['fresh_native_checked_rows'] + layer['imported_verified_rows'] == 280542509, 'Layer-32 row arithmetic mismatch')
    require(layer['conditional_benchmark_rows_counted_as_certified'] == 0, 'Conditional samples counted as certification')
    total = 280542509 + 21924455 + 587901
    require(total == 303054865, 'Seed coverage mismatch')

    calibration = read(BASE / 'evidence/calibration/acceptance.json')
    cases = [read(BASE / ('evidence/calibration/' + c['case_id'] + '.normalized.json')) for c in calibration['cases']]
    require(len(cases) == calibration['complete_case_count'] == 34 and
            sum(c['rows'] for c in cases) == calibration['conditional_rows_rechecked'] == 5843582753 and
            sum(c['frames'] for c in cases) == calibration['actual_frames_rechecked'] == 107, 'Calibration arithmetic mismatch')
    require(all(c['status'] == 'PASS' and c['conditional_performance_only'] and
                c['TargetCorrect_registry_entries_added'] == 0 for c in cases), 'Calibration scope changed')
    resource = read(BASE / 'evidence/resources.json')
    require(resource['completed_frames'] == 83 and resource['unique_conditional_rows'] == 4597996387 and
            resource['TargetCorrect_registry_entries_added'] == 0 and resource['all_owned_services_confirmed_exited'], 'Resource receipt mismatch')
    cost = read(BASE / 'evidence/known-cost-screen.json')
    scenario = cost['scenarios']['1']
    before = sum(scenario['known_components_before25percent_margin'].values())
    near(before, scenario['known_component_seconds_before25percent_margin'])
    near(before * 1.25, scenario['known_component_seconds_after25percent_margin'])
    near(before * 1.25 / 3600, scenario['known_component_hours_after25percent_margin'])
    near(scenario['known_component_hours_after25percent_margin'], 13.025598036171749)
    require(cost['unknown_production_fees_not_imputed'] and
            len(scenario['missing_production_cost_coefficients']) == 6 and
            all(v == 'UNKNOWN_NOT_IMPUTED' for v in scenario['missing_production_cost_coefficients'].values()), 'Unknown costs were silently accepted')
    require(scenario['pending_rows'] + total == 778532864302 and
            scenario['pending_buckets'] == 3568 and scenario['canonical_frames'] == 17197, 'Remaining plan mismatch')
    require(sum(x['rows'] for x in scenario['stratum_caps']) == scenario['pending_rows'] and
            sum(x['frames'] for x in scenario['stratum_caps']) == scenario['canonical_frames'], 'Stratum coverage mismatch')

    audit = read(BASE / 'evidence/audit-status.json')
    require(not audit['full_scan_started'] and audit['new_full_campaign_native_rows'] == 0 and
            audit['full_table_Lean'] == audit['empty_game_Lean'] == 'NOT_VERIFIED' and
            audit['full_20h_completion'] == 'NOT_ESTABLISHED' and not audit['new_phasezero_complete'] and
            audit['final_16h_cost_gate'] == 'NOT_EVALUATED_AND_NOT_PASSED' and
            audit['explicit_user_release_required'] and not audit['whole_table_one_shot_task_registered'], 'Prelaunch hold/scope changed')
    require(audit['certified_unique_seed_rows'] == total and audit['pending_rows_in_prepared_manifest'] == scenario['pending_rows'], 'Audit coverage mismatch')
    manifest_item = copies['evidence/campaign-manifest.json']
    require(manifest_item['original_sha256'] == audit['selected_manifest']['sha256'] ==
            provenance['original_selected_manifest_sha256'], 'Selected plan identity mismatch')
    bundle = read(BASE / 'evidence/proof-bundle.json')
    require(bundle['total_kernel_proof_count'] == 104 and bundle['actual_game_rows'] == 0 and not bundle['GPU_trusted'], 'Build scope mismatch')
    current = read(ROOT / 'RESEARCH_STATUS.json')
    # This verifier preserves the earlier V16 snapshot and its then-current outlook.
    formal = current['historical_progress']['2026-10-18-v16']
    require(formal['compiled_checker_complete_layer_rows'] == total and
            set(formal['compiled_checker_complete_layers']) == {32,33,34} and
            formal['current_checker']['selected_recorded_theorems'] == 104 and
            not formal['general_full_scan_launched'] and formal['empty_game_lean'] == 'NOT_VERIFIED', 'Current status mismatch')
    expectation = current['historical_outlooks']['2026-10-18-v16']
    require(expectation['working_expectation_hours'] == 20 and
            not expectation['guaranteed_completion'] and not expectation['full_cost_gate_passed'] and
            expectation['independent_review_status'] == 'IN_PROGRESS' and
            expectation['full_campaign_status'] == 'NOT_STARTED_AWAITING_INDEPENDENT_REVIEW', 'Current outlook mismatch')
    near(expectation['known_components_with_25_percent_margin_hours'], scenario['known_component_hours_after25percent_margin'])
    return dict(status='PASS_PUBLIC_OCTOBER_PROGRESS', artifacts=len(copies), linked_source_modules=132,
        selected_recorded_theorems=104, complete_layer_rows=total, complete_layers=[32,33,34],
        calibration_cases=34, calibration_frames=107, calibration_conditional_rows=5843582753,
        known_component_hours_with25percent_margin=scenario['known_component_hours_after25percent_margin'],
        full_scan_started=False, independent_review='IN_PROGRESS', empty_game_lean='NOT_VERIFIED',
        scope='Public artifact identity and recorded evidence arithmetic; no Lean/native execution or mathematical review.')


if __name__ == '__main__':
    print(json.dumps(verify()))
