"""Summarize the bounded 30-day gate; scenario extrapolations are not full-run forecasts."""
from pathlib import Path
import json, math, shutil
import autonomous_near_terminal as a

r=a.RUNS
base=a.read(r/'general_benchmark_v1/result.json')
peak=a.read(r/'peak_parallel_v1/result.json')
assert base['state']==peak['state']=='COMPLETE_BOUNDED_TEST'
for folder,report in [(r/'general_benchmark_v1',base),(r/'peak_parallel_v1',peak)]:
    assert a.sha(folder/'manifest.json')==report['manifest_sha256']
    for case in report['results']:
        receipt=a.read(folder/'cases'/case['case']/'receipt.json')
        assert receipt['accepted']==case and receipt['manifest_sha256']==report['manifest_sha256']
        for output in case['outputs']:
            assert a.sha(folder/output['path'])==output['sha256']
            assert a.read(folder/output['path'])==output['value']

# Tie the layer-32 targets to the exact common decoding inputs of the completed layer-33 scan.
for leaf in ['numeric.bin','numeric_ids.bin','groups.bin']:
    assert a.sha(r/'general_input_v1'/leaf)==a.sha(r/'layer33_v1/index'/leaf)
old=a.read(r/'layer33_v1/manifest.json')['files']
for leaf in ['BucketIndex','PackedRules','LocalCacheEncoding','SummaryEncoding']:
    p=a.BASE/'source/Mahjong'/(leaf+'.lean')
    assert a.sha(p)==old[str(p.relative_to(a.ROOT))]

catalog=a.read(a.ROOT/'runs/global_retro/index/bucket_catalog.json')['buckets']
counts={n:sum(x['states'] for x in catalog if x['n']==n) for n in range(35)}
total=sum(counts.values());assert total==778532864302
selected=base['selected_buckets']
samples32=[x for x in base['results'] if x['case'].startswith('layer32_')]
chosen_peak=[next(x for x in peak['results'] if x['case']==key)
    for key in ['peak_scale_p2_t6','peak_h005_p2_t6','peak_h035_p2_t6']]
w32=sum(x['size'] for x in selected['32']);w23=sum(x['size'] for x in selected['23'])
cost32=sum(row['size']/w32*sum(1/x['rows_per_second_scan'] for x in samples32 if x['bucket']==row['h'])/3 for row in selected['32'])
cost23=sum(row['size']/w23*next(1/x['rows_per_second_scan'] for x in chosen_peak if x['bucket']==row['h']) for row in selected['23'])
rate32,rate23=1/cost32,1/cost23
required=total/(30*86400)
intervals={}
for case in base['results']+peak['results']:
    intervals.setdefault((case['layer'],case['bucket']),[]).append((case['start'],case['start']+case['rows']))
unique=0
for spans in intervals.values():
    merged=[]
    for lo,hi in sorted(spans):
        if merged and lo<=merged[-1][1]:merged[-1]=(merged[-1][0],max(hi,merged[-1][1]))
        else:merged.append((lo,hi))
    unique+=sum(hi-lo for lo,hi in merged)

result=dict(schema='LEAN_HOME_30_DAY_GATE_V1',utc=a.utc(),decision='DO_NOT_START_FULL_SCAN_CURRENT_IMPLEMENTATION',
    full_scan_launched=False,full_table_Lean='NOT_VERIFIED',hardware=base['hardware'],
    test_evaluations=sum(x['rows'] for x in base['results']+peak['results']),unique_sampled_slots=unique,
    completed_cases=len(base['results'])+len(peak['results']),all_case_receipts_verified=True,
    layer32_target_common_inputs_match_completed_layer33=True,thirty_day_required_rows_per_second=required,
    method='Size-weighted mean seconds per row within selected buckets; systematic quarter/midpoint windows, not an IID sample or confidence interval. Scan timing excludes repeated startup/file loading.',
    representative_layer32=dict(rows_per_second=rate32,rows_per_hour=rate32*3600,selected_bucket_mass_fraction=w32/counts[32],
        source_buckets=[x['h'] for x in selected['32']],configuration='12 processes x 1 worker thread'),
    representative_peak23=dict(rows_per_second=rate23,rows_per_hour=rate23*3600,selected_bucket_mass_fraction=w23/counts[23],
        source_buckets=[x['h'] for x in selected['23']],configuration='2 processes x 6 worker threads',
        measured_bucket_rate_range=[min(x['rows_per_second_scan'] for x in chosen_peak),max(x['rows_per_second_scan'] for x in chosen_peak)],
        peak_private_bytes=max(x['peak_private_bytes'] for x in chosen_peak)),
    scenarios_not_forecasts=dict(all_rows_at_layer32_rate_days=total*cost32/86400,
        all_rows_at_weighted_peak_rate_days=total*cost23/86400,
        all_rows_at_observed_peak_rate_range_days=[total/max(x['rows_per_second_scan'] for x in chosen_peak)/86400,total/min(x['rows_per_second_scan'] for x in chosen_peak)/86400],
        selected_three_peak_buckets_alone_days=w23*cost23/86400),
    required_speed_factor=dict(relative_to_layer32=required/rate32,relative_to_peak23=required/rate23),
    ideal_single_worker_equivalents_at_peak=required/next(x['rows_per_second_scan'] for x in peak['results'] if x['case']=='peak_scale_p1_t1'),
    no_subagents=True,model_calls_for_computation=0,
    evidence=[dict(path='general_benchmark_v1/result.json',sha256=a.sha(r/'general_benchmark_v1/result.json')),
        dict(path='peak_parallel_v1/result.json',sha256=a.sha(r/'peak_parallel_v1/result.json')),
        dict(path='general_negative_20260914T165100/result.json',sha256=a.sha(r/'general_negative_20260914T165100/result.json'))])
a.atomic(r/'GENERAL_FEASIBILITY.json',result)
print(json.dumps({k:v for k,v in result.items() if k not in ['evidence','hardware','method']},indent=2))
