#!/usr/bin/env python3
"""Check public kernel-research bytes and recorded scopes, without execution."""
import hashlib
import json
import math
from pathlib import Path
import re

BASE=Path(__file__).resolve().parent
ROOT=BASE.parents[1]
ALLOWED={'propext','Classical.choice','Quot.sound'}
PRIVATE=re.compile(r'(?:[A-Za-z]:[\\/](?:Users|home)[\\/]|/mnt/[a-z]/Users/|/home/[^/\s]+/|/Users/[^/\s]+/)')


def require(value,message):
    if not value: raise ValueError(message)


def read(path): return json.loads(path.read_text(encoding='utf-8-sig'))
def sha(path): return hashlib.sha256(path.read_bytes()).hexdigest()


def strings(value):
    if isinstance(value,str): yield value
    elif isinstance(value,dict):
        for k,v in value.items():
            yield k
            yield from strings(v)
    elif isinstance(value,list):
        for v in value: yield from strings(v)


def near(a,b): require(math.isclose(a,b,rel_tol=1e-10,abs_tol=1e-7),'Recorded arithmetic mismatch')


def verify():
    provenance=read(BASE/'provenance.json');copies={};originals={}
    for item in provenance['artifacts']:
        rel=item['published_path'];path=(BASE/rel).resolve()
        require(path.is_relative_to(BASE) and path.is_file() and rel not in copies,'Invalid/duplicate publication path')
        require(path.stat().st_size==item['published_bytes'] and sha(path)==item['published_sha256'],'Changed artifact: '+rel)
        if not item['transformations']:
            require(item['published_sha256']==item['original_sha256'] and item['published_bytes']==item['original_bytes'],'Unrecorded transformation')
        text=path.read_text(encoding='utf-8-sig')
        require(not re.search(r'[\u3400-\u4dbf\u4e00-\u9fff]',text),'Non-English artifact')
        values=strings(json.loads(text)) if path.suffix=='.json' else [text]
        require(all(not PRIVATE.search(v) for v in values),'Private execution root: '+rel)
        copies[rel]=item;originals[item['original_path']]=item

    def binding(record):
        item=originals.get(record['path'])
        require(item is not None and item['original_sha256']==record['sha256'] and
                item['original_bytes']==record['bytes'],'Original receipt/source binding missing')
        return item

    mapping=read(BASE/'source-map.json');groups=mapping['groups']
    require(len(groups['base-v16-reused'])==132 and len(groups['v17'])==13 and len(groups['v18'])==20,'Primary source counts changed')
    common={x['module'] for g in ['base-v16-reused','v17','v18'] for x in groups[g]}
    require(len(common)==165,'Primary source module collision')
    for family,entries in groups.items():
        names=common|{x['module'] for x in entries}
        if family=='local-layer-closure':names|={x['module'] for x in groups['local-certificate']}
        missing=set()
        for entry in entries:
            path=(ROOT/entry['public_path']).resolve()
            require(path.is_relative_to(ROOT) and sha(path)==entry['sha256'],'Mapped source identity mismatch')
            for line in path.read_text(encoding='utf-8').splitlines():
                if line.startswith('import '):
                    for module in line.split()[1:]:
                        if module=='all' or module.startswith(('Lean','Std','Init')) or module in names:continue
                        if module.startswith('Mahjong.') or module.endswith(('V17','V18','V19')):missing.add(module)
        report=mapping['dependency_report'][family]
        require(report['unresolved_public_project_imports']==sorted(missing) and
                report['mapped_import_closure_complete']==(not missing),'Source subset report mismatch')
        if family in ['v17','v18','base-v16-reused']:require(not missing,'Primary source closure missing')

    v17=read(BASE/'evidence/v17/status.json');replay17=read(BASE/'evidence/v17/fresh-replay.json')
    require(v17['new_source_files']==13 and v17['total_project_modules_replayed']==145 and
            v17['actual_full_input_acceptance']=='NOT_VERIFIED' and not v17['final_kernel_empty_theorem'] and
            not v17['TargetCorrect_assumed_by_final_theorem'] and not v17['RowChecks_or_Trace_assumed_by_final_fast_theorem'],
            'Generic V17 scope changed')
    require(replay17['status']=='PASS_KERNEL_REPLAY_ONLY' and replay17['returncode']==0 and
            replay17['input_module_count']==145 and not replay17['timed_out'],'V17 replay receipt mismatch')
    binding(v17['replay_receipt']);near(replay17['elapsed_seconds'],v17['replay_seconds'])
    for item in v17['sources']:
        binding(item);binding(item['compilation_receipt'])
    require(all(set(x['axioms'])<=ALLOWED for x in v17['selected_print_fingerprints']),'Unexpected selected V17 axiom')

    pilot=read(BASE/'evidence/v18/status.json');scope=pilot['exact_scope']
    require(pilot['small_pilot_closed'] and not pilot['final_kernel_empty_theorem'] and
            not pilot['full_v17_input_instantiated'] and not pilot['full_table_24h_admitted'], 'Pilot scope changed')
    require(scope['original_game_nodes']==11 and scope['original_game_start_tile_count']==32 and
            scope['P_start_rows']==[50,55] and scope['N_start_rows']==[35] and
            scope['P_rows']+scope['N_rows']==scope['original_hot_checker_distinct_rows']==56 and
            scope['samples_overlap'],'Pilot row/game scopes changed')
    require(len(pilot['closed_theorem_axioms'])==3 and
            all(set(v)<=ALLOWED for v in pilot['closed_theorem_axioms'].values()),'Closed pilot axiom scope changed')
    cold=pilot['frozen_cold_replay'];binding(cold['receipt'])
    require(cold['status']=='PASS' and cold['returncode']==0 and not cold['timed_out'],'Pilot cold replay missing')
    near(cold['wall_seconds'],176.562)
    near(pilot['full_24h_required_rows_per_second'],pilot['total_global_rows']/86400)
    near(pilot['ideal_16_lane_gap_factor'],pilot['full_24h_required_rows_per_second']/pilot['ideal_16_lane_sample_rate'])
    require(pilot['extrapolation_is_not_a_bound_or_a_global_runtime_prediction'],'Pilot timing extrapolation overclaimed')
    require(len(pilot['negative_controls'])==2 and all(x['false_proposition_rejected_by_lean'] and
            x['returncode']!=0 for x in pilot['negative_controls']),'Pilot negatives overclaimed')
    for negative in pilot['negative_controls']:binding(negative['receipt'])

    cart=read(BASE/'evidence/v19/cartesian28/acceptance.json')
    require(cart['actual_blocks']==28 and cart['source_Cartesian_rows']==1077270 and
            cart['source_original_colex_rows']==1035129 and not cart['global_game_or_SAFE_semantics_proved'] and
            not cart['numeric_kernel_batch_speedup_observed'] and not cart['full_scan_started'],'Cartesian numeric scope changed')
    near(cart['cold_replays']['PN_and_preparation']['wall_seconds'],11.546)
    helper=read(BASE/'evidence/v19/global-helpers/acceptance.json')
    require(helper['actual_blocks']==3 and helper['source_Cartesian_rows']==125772 and
            not helper['global_SAFE_or_game_semantics_proved'] and helper['whole_table_STOP_preserved'], 'Helper scope changed')
    near(helper['cold']['wall_seconds'],7.187)
    require(any(x['status']!='PASS' for x in cart['all_attempts']),'Failed attempts must remain distinguishable')
    for collection in [cart['all_attempts'],helper['all_attempts']]:
        for attempt in collection:binding(attempt['receipt'])

    local=read(BASE/'evidence/v19/local64/summary.json')
    require(local['same_count']==64 and local['same_pages']==9 and local['partial_getter_outside_frozen_pages_returns_zero'] and
            not local['full_LocalCertificate_certified'] and not local['game_conclusion_proved'] and
            local['ordinary_leanchecker_fresh'],'Local64 scope changed')
    near(local['cold_child_wall_seconds'],8.907);binding(local['cold_receipt'])
    certificate=read(BASE/'evidence/v19/local-certificate-acceptance.json')
    layer=read(BASE/'evidence/v19/local-layer-closure-acceptance.json')
    require(not certificate['actual_local_certificate_instantiated'] and not certificate['root_DAG_instantiated'] and
            not layer['actual_empty_game_verified'] and not layer['actual_local_certificate_instantiated'] and
            layer['next_TargetCorrect_premise_removed'],'Generic/local actual-instance distinction changed')

    current=read(ROOT/'RESEARCH_STATUS.json');outlook=current['verification_outlook']
    require(current['opening_outcome']=='P' and current['formal_verification']['empty_game_lean']=='NOT_VERIFIED' and
            not current['formal_verification']['end_to_end_Lean_theorem_published'],'Computational/formal opening conflated')
    require(outlook['completion_time_estimate_hours'] is None and outlook['working_expectation_hours'] is None and
            not outlook['twenty_hour_end_to_end_bound_established'] and not outlook['twenty_four_hour_full_run_admitted'] and
            not outlook['historical_native_cost_estimate_applies_to_current_proof_workload'] and
            not outlook['full_campaign_started'] and outlook['pause_retained'],'Current outlook overclaimed')
    require(current['formal_verification']['compiled_checker_complete_layer_rows']==303054865,'Historical compiled coverage changed')
    publication=read(BASE/'status.json')
    require(publication['actual_empty_game_Lean']=='NOT_VERIFIED' and
            not publication['V19_public_source_subset_is_complete_portable_replay'] and
            not publication['new_Lean_or_native_or_GPU_jobs_started_for_publication'],'Publication/replay scope changed')
    return dict(status='PASS_KERNEL_RESEARCH_PUBLICATION',artifacts=len(copies),
        V17_sources=13,V17_recorded_replay_modules=145,V18_mapped_source_closure=165,
        V18_actual_game_nodes=11,V18_nonempty_game_roots=3,V18_captured_checker_rows=56,
        V19_numeric_sample_blocks=28,V19_numeric_Cartesian_coordinates=1077270,
        actual_empty_game_lean='NOT_VERIFIED',end_to_end_completion_time='NOT_ESTABLISHED',
        scope='Published byte identity, source mapping and recorded evidence consistency; no new kernel/native execution or mathematical review.')


if __name__=='__main__': print(json.dumps(verify()))
