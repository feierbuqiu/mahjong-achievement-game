"""Read-only aggregation of saved V17 records; never executes a research worker.

Only this paper directory receives a new JSON summary. This is not a game run,
not an input-table rehash, and not an independent native verification.
"""
import collections
import datetime
import hashlib
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
OUT = Path(__file__).resolve().parent
RUN = ROOT / 'runs/lean_table_checker/v17_compute_finish_20261018/full_native_20261018_02'
PUB = ROOT / 'build/publication/mahjong-achievement-game/research/2026-10-19-v17'
problems = []
cache = {}

def load(p):
    return json.loads(Path(p).read_text(encoding='utf-8-sig'))

def sha(b):
    return hashlib.sha256(b).hexdigest()

def canonical(v):
    return json.dumps(v, sort_keys=True, separators=(',', ':'), ensure_ascii=False, allow_nan=False).encode()

def need(condition, message):
    if not condition:
        problems.append(message)

def readrecord(r):
    p = ROOT / r['path']
    k = (r['path'], r['bytes'], r['sha256'])
    if k not in cache:
        b = p.read_bytes()
        need(len(b) == r['bytes'] and sha(b) == r['sha256'], 'record hash: ' + r['path'])
        cache[k] = json.loads(b)
    return cache[k]

plan = load(RUN/'PLAN.json')
manifest = load(RUN/'MANIFEST.json')
final = load(RUN/'FINAL.json')
manifest_hash = sha((RUN/'MANIFEST.json').read_bytes())
ledger_raw = (RUN/'ledger.jsonl').read_bytes()
entries = [json.loads(line) for line in ledger_raw.splitlines()]
need(sha(ledger_raw) == final['ledger']['sha256'], 'final ledger hash')
need(manifest_hash == final['manifest']['sha256'], 'final manifest hash')
cells = {(x['layer'],x['honor']):x for x in plan['cells']}
need(list(cells) == [(n,h) for n in range(35) for h in range(184)], 'plan domain/order')
cursor = collections.defaultdict(int)
totals = collections.Counter()
layers = {n:collections.Counter() for n in range(35)}
session_ids = set()
source_ids = {}
targets = []
head = '0'*64
seen = set()
for i,e in enumerate(entries):
    body = {k:v for k,v in e.items() if k != 'entry_sha256'}
    need(e['sequence'] == i and e['previous_sha256'] == head, 'ledger order '+str(i))
    need(sha(canonical(body)) == e['entry_sha256'], 'ledger canonical hash '+str(i))
    need(e['manifest_sha256'] == manifest_hash, 'ledger manifest '+str(i))
    head = e['entry_sha256']
    fk = tuple(e['frame_key']); n,h,start,count = fk; key=(n,h)
    need(fk not in seen, 'duplicate frame '+str(fk)); seen.add(fk)
    need(start == cursor[key] and count > 0, 'gap/overlap '+str(fk))
    cursor[key] = start+count
    r=readrecord(e['receipt']); nr=readrecord(r['native_result'])
    need((r['layer'],r['honor'],r['start'],r['count']) == fk, 'receipt extent '+str(i))
    need((nr['layer'],nr['honor'],nr['start'],nr['count']) == fk, 'native extent '+str(i))
    need(r['native'] == manifest['native'] and r['manifest_sha256'] == manifest_hash, 'native binding '+str(i))
    need(r['input_identity_sha256'] == manifest['input_identity_sha256'], 'input binding '+str(i))
    need(r['status'] == 'COMMITTED_NATIVE_V17_FRAME' and nr['status'] == 'PASS_NATIVE_V17_FRAME' and nr['frameAccepted'] is True, 'status '+str(i))
    need(nr['checked_rows'] == count and nr['logical_fragments'] == 12 and nr['closed_kernel_table_theorem'] is False, 'native scope '+str(i))
    p,nt = r['P_rows'],r['N_rows']
    need(p+nt == count and p == nr['P_rows'] and nt == nr['N_rows'], 'P/N arithmetic '+str(i))
    need(r['source_span_P_rows'] == p and r['source_span_N_rows'] == nt, 'source span counts '+str(i))
    need(r['no_old_acceptance_imported'] is True, 'old acceptance '+str(i))
    expected = dict(base=True,successors=True,metadata=True,frames=True,target_identity=True,root_P=(key==(0,0)))
    need(r['acceptances'] == expected, 'scoped acceptances '+str(i))
    g=readrecord(r['global_ready']);b=readrecord(r['bucket_ready'])
    need(g['native_event']['baseChecked'] is True and g['native_event']['successorsChecked'] is True, 'global flags '+str(i))
    need(b['native_event']['metadataChecked'] is True and b['native_event']['targetIdentity'] is True, 'bucket flags '+str(i))
    need(b['native_event']['rootChecked'] == (True if key==(0,0) else None), 'root flag '+str(i))
    need(g['session_id'] == r['session_id'] == b['session_id'], 'session binding '+str(i))
    session_ids.add(r['session_id'])
    if key in source_ids: need(source_ids[key] == r['source_identity'], 'source identity changed '+str(key))
    else: source_ids[key] = r['source_identity']
    for child,identity in r['target_identities'].items(): targets.append(((n+1,int(child)),identity))
    totals.update(rows=count,P=p,N=nt,frames=1)
    totals['native_wall_ns'] += nr['wall_ns']; totals['native_plan_ns'] += nr['plan_ns']; totals['native_scan_ns'] += nr['scan_ns']; totals['payload_read_ns'] += nr['payload_read_ns']
    totals['helper_wall_seconds'] += r['complete_helper_wall_seconds']
    layers[n].update(rows=count,P=p,N=nt,frames=1)
    if i%5000 == 0: print('read saved frame records',i,flush=True)
for key,c in cells.items(): need(cursor[key] == c['size'], 'bucket exact cover '+str(key))
for key,identity in targets: need(source_ids.get(key) == identity, 'cross-layer identity '+str(key))
before=readrecord(load(RUN/'INPUTS_BEFORE.json')['identity_record'])
after=readrecord(load(RUN/'INPUTS_AFTER.json')['identity_record'])
need(before['files'] == after['files'] == manifest['inputs_before'], 'before/after/manifest maps')
need(sha(canonical(before['files'])) == manifest['input_identity_sha256'], 'canonical input map hash')
need(set(before['files']) == set(plan['input_inventory']), 'plan input paths')
for p,v in before['files'].items(): need(v['bytes'] == plan['input_inventory'][p]['bytes'], 'plan byte extent '+p)
pubcoverage=load(PUB/'coverage.json')
for c in pubcoverage['buckets']:
    key=(c['layer'],c['honor']);need(c['size'] == cells[key]['size'] == c['rows'],'public coverage size '+str(key))
    if c['size']: need(c['P']+c['N'] == c['rows'],'public P/N '+str(key))
reports=[load(p) for p in (RUN/'reports').glob('*.json')]
memory=[r for r in reports if isinstance(r.get('physical_memory',{}).get('available'),int)]
worst=min(memory,key=lambda r:r['physical_memory']['available'])
roles=collections.defaultdict(lambda:dict(files=0,bytes=0))
for p,role in plan['input_roles'].items():
    k='; '.join(role); roles[k]['files']+=1; roles[k]['bytes']+=before['files'][p]['bytes']
public_layers={n:collections.Counter() for n in range(35)}
for c in pubcoverage['buckets']:
    public_layers[c['layer']].update(rows=c['rows'],P=c['P'],N=c['N'],frames=c['frames'])
need(public_layers == layers,'published layer totals differ')
for n in range(35):
    layers[n]['nonempty_buckets']=sum(1 for k,c in cells.items() if k[0]==n and c['size'])
sept=22512356;total=totals['rows']
result=dict(
    schema='PAPER_READ_ONLY_SAVED_V17_RECORD_AUDIT_V1',
    observed_utc=datetime.datetime.now(datetime.timezone.utc).isoformat(),
    scope='Saved-record arithmetic, bindings and hash checks only; no Lean/native/GPU/compiler execution; no full input rehash',
    problems=problems,problem_count=len(problems),records_read=len(cache),totals=dict(totals),
    rows_sum_plan=sum(c['size'] for c in cells.values()),
    cells=len(cells),nonempty_buckets=len(source_ids),empty_cells=sum(not c['size'] for c in cells.values()),
    unique_frame_keys=len(seen),session_ids=sorted(session_ids),cross_layer_identity_references=len(targets),
    first_commit_utc=entries[0]['committed_utc'],last_commit_utc=entries[-1]['committed_utc'],
    layer_totals={str(n):dict(v) for n,v in layers.items()},
    input_files=len(before['files']),input_bytes=sum(v['bytes'] for v in before['files'].values()),
    input_roles=dict(roles),before_after_maps_equal=before['files']==after['files'],
    prior_full_hash=readrecord(before['prior_actual_identity'])['wall_seconds'],
    current_pre_hash_new_bytes=before['actual_bytes_hashed_this_invocation'],current_pre_hash_reused_bytes=before['hash_reused_bytes'],
    report_count=len(reports),memory_sample_count=len(memory),minimum_available_sample=worst,
    maximum_observed_swap_bytes=max(r['physical_memory'].get('swap_used') or 0 for r in memory),
    report_pool_threads=sorted(set(r['pool_threads'] for r in reports)),
    sept15_complete_rows=sept,additional_distinct_rows_beyond_sept15=total-sept,
    full_to_sept15_ratio=total/sept,sept15_percent=sept/total*100,
    final_sha256=sha((RUN/'FINAL.json').read_bytes()),manifest_sha256=manifest_hash,ledger_sha256=sha(ledger_raw),
)
(OUT/'native_record_audit.json').write_text(json.dumps(result,indent=2,ensure_ascii=False)+'\n',encoding='utf-8')
print(json.dumps({k:v for k,v in result.items() if k not in ('layer_totals','minimum_available_sample','input_roles')},indent=2))
raise SystemExit(0 if not problems else 1)
