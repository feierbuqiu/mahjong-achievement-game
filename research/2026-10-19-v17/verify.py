#!/usr/bin/env python3
"""Check published identities and recorded native coverage, without executing Lean."""
import argparse
from collections import defaultdict
import hashlib
import json
from pathlib import Path, PurePosixPath
import re
import sys
import zipfile

BASE=Path(__file__).resolve().parent
ROOT=BASE.parents[1]
RUN='runs/lean_table_checker/v17_compute_finish_20261018/full_native_20261018_02/'
TOTAL=778532864302
NATIVE='775e05d2601e30847b14b017cb542ea23a8b629d8ebd403aa07bd5942b78f667'


def need(value,message):
    if not value:raise ValueError(message)


def sha(path):
    h=hashlib.sha256()
    with Path(path).open('rb') as f:
        for block in iter(lambda:f.read(8*1024*1024),b''):h.update(block)
    return h.hexdigest()


def digest(raw):return hashlib.sha256(raw).hexdigest()
def load(path):return json.loads(Path(path).read_text(encoding='utf-8-sig'))
def canonical(value):return json.dumps(value,sort_keys=True,separators=(',',':'),ensure_ascii=False,allow_nan=False).encode()


def verify_archive(path):
    """Recompute the full saved ledger/receipt graph, not the game recurrence."""
    descriptor=load(BASE/'assets.json')['assets'][0]
    need(Path(path).stat().st_size==descriptor['bytes'] and sha(path)==descriptor['sha256'],'Archive SHA-256/size mismatch')
    with zipfile.ZipFile(path) as z:
        names=z.namelist()
        need(len(names)==len(set(names)),'Duplicate ZIP members')
        for name in names:
            part=PurePosixPath(name)
            need(not part.is_absolute() and '..' not in part.parts and '\\' not in name,'Unsafe ZIP member')
        contents_raw=z.read('CONTENTS.json')
        need(digest(contents_raw)==descriptor['contents_manifest_sha256'],'Contents manifest changed')
        contents=json.loads(contents_raw);members={x['path']:x for x in contents['files']}
        need(set(names)==set(members)|{'CONTENTS.json'} and len(members)==descriptor['payload_files'],'Archive member set differs')
        for name,item in members.items():
            raw=z.read(name)
            need(len(raw)==item['bytes'] and digest(raw)==item['sha256'],'Changed member: '+name)
        def raw(name):return z.read('workspace/'+name)
        def read(name):return json.loads(raw(name))
        cache={}
        def record(item):
            name=item['path']
            need('workspace/'+name in members,'Missing evidence record: '+name)
            identity=members['workspace/'+name]
            need(identity['bytes']==item['bytes'] and identity['sha256']==item['sha256'],'Record binding differs: '+name)
            if name not in cache:cache[name]=read(name)
            return cache[name]

        final=read(RUN+'FINAL.json');manifest=record(final['manifest']);plan=record(manifest['plan'])
        msha=final['manifest']['sha256'];inputs=manifest['inputs_before']
        need(digest(canonical(inputs))==manifest['input_identity_sha256'],'Input-map digest differs')
        need(inputs==load(BASE/'inputs.json')['files'],'Archive/Git input map differs')
        need(manifest['native']['sha256']==NATIVE and not manifest['old_PASS_or_seed_imported'],'Executable/seed boundary differs')
        cells={(c['layer'],c['honor']):c for c in plan['cells']}
        need(set(cells)=={(n,h) for n in range(35) for h in range(184)},'Incomplete cell domain')
        nonempty={k for k,c in cells.items() if c['size']>0}
        need(len(nonempty)==3686 and sum(c['size'] for c in cells.values())==TOTAL,'Plan size differs')
        ledger_raw=raw(RUN+'ledger.jsonl')
        need(len(ledger_raw)==final['ledger']['bytes'] and digest(ledger_raw)==final['ledger']['sha256'],'Ledger identity differs')
        entries=[json.loads(x) for x in ledger_raw.splitlines()]
        need(len(entries)==17317,'Frame count differs')
        cursor=defaultdict(int);counts=defaultdict(lambda:[0,0,0]);sources={};targets=[];seen=set();sessions=set();head='0'*64
        native_files=set();bucket_files=set();global_files=set();root_frames=0
        for sequence,e in enumerate(entries):
            need(e['sequence']==sequence and e['previous_sha256']==head and e['manifest_sha256']==msha,'Ledger chain/sequence differs')
            body={k:v for k,v in e.items() if k!='entry_sha256'}
            need(digest(canonical(body))==e['entry_sha256'],'Ledger entry hash differs')
            head=e['entry_sha256'];key=tuple(e['frame_key'])
            need(key not in seen and len(key)==4,'Duplicate/malformed frame')
            seen.add(key);n,h,start,count=key;bucket=(n,h)
            need(bucket in nonempty and 0<count<=67108864 and start==cursor[bucket] and start+count<=cells[bucket]['size'],'Frame gap/overlap/extent differs')
            r=record(e['receipt'])
            need(r['status']=='COMMITTED_NATIVE_V17_FRAME' and r['manifest_sha256']==msha and r['native']==manifest['native'],'Frame authority differs')
            need((r['layer'],r['honor'],r['start'],r['count'])==key,'Receipt extent differs')
            need(r['no_old_acceptance_imported'] is True and r['input_identity_sha256']==manifest['input_identity_sha256'],'Frame custody differs')
            expected=dict(base=True,successors=True,metadata=True,frames=True,target_identity=True,root_P=(bucket==(0,0)))
            need(r['acceptances']==expected,'Scoped acceptance flags differ')
            native=record(r['native_result']);native_files.add(r['native_result']['path'])
            need(native['status']=='PASS_NATIVE_V17_FRAME' and native['frameAccepted'] is True and not native['closed_kernel_table_theorem'],'Native acceptance/scope differs')
            need((native['layer'],native['honor'],native['start'],native['count'])==key and native['checked_rows']==count and native['logical_fragments']==12,'Native extent differs')
            p,q=r['P_rows'],r['N_rows']
            need(type(p) is int and type(q) is int and p>=0 and q>=0 and p+q==count,'P/N count differs')
            need((native['P_rows'],native['N_rows'])==(p,q) and (r['source_span_P_rows'],r['source_span_N_rows'])==(p,q),'Native/receipt/span counts differ')
            global_=record(r['global_ready']);opened=record(r['bucket_ready'])
            global_files.add(r['global_ready']['path']);bucket_files.add(r['bucket_ready']['path']);sessions.add(r['session_id'])
            need(global_['session_id']==r['session_id'] and global_['native']==manifest['native'],'Global session differs')
            event=global_['native_event']
            need(event['event']=='GLOBAL_READY' and event['baseChecked'] is True and event['successorsChecked'] is True and event['layers']==35 and event['honors']==184,'Global acceptances differ')
            need(opened['session_id']==r['session_id'] and opened['bucket_open_id']==r['bucket_open_id'] and opened['native']==manifest['native'],'Bucket session differs')
            event=opened['native_event']
            need(event['event']=='BUCKET_READY' and (event['layer'],event['honor'],event['size'])==(n,h,cells[bucket]['size']) and event['metadataChecked'] is True and event['targetIdentity'] is True,'Bucket acceptances differ')
            children=sorted(k for k in cells[bucket]['needed_honors'] if n<34 and cells[n+1,k]['size'])
            need(event['loaded_target_honors']==children and sorted(map(int,r['target_identities']))==children,'Child-bucket inventory differs')
            if bucket==(0,0):
                need(event['rootChecked'] is True and p==1 and q==0,'Root acceptance differs');root_frames+=1
            else:need(event['rootChecked'] is None,'Root flag outside empty bucket')
            source=r['source_identity']
            need(source['size']==cells[bucket]['size'] and source['honor_code']==cells[bucket]['code'],'Source extent/code differs')
            for field in ['numeric','ids','groups','directory','bits']:
                v=source[field];need(inputs[v['path']]=={k:v[k] for k in ['bytes','sha256']},'Source input binding differs')
            need(source['bits']['path']==cells[bucket]['bits'] and source['directory']['path']==cells[bucket]['directory'],'Source paths differ')
            if bucket in sources:need(source==sources[bucket],'Source identity changed within bucket')
            else:sources[bucket]=source
            for ch,identity in r['target_identities'].items():targets.append(((n+1,int(ch)),identity))
            cursor[bucket]+=count;counts[bucket][0]+=1;counts[bucket][1]+=p;counts[bucket][2]+=q
        need(set(cursor)==nonempty and all(cursor[k]==cells[k]['size'] for k in nonempty),'Incomplete whole-table cover')
        need(all(sources.get(k)==v for k,v in targets),'Cross-layer target identity differs')
        need(len(targets)==54548 and len(sessions)==1 and root_frames==1,'Target/session/root counts differ')
        need(len(native_files)==17317 and len(bucket_files)==3686 and len(global_files)==1,'Evidence record counts differ')
        p=sum(v[1] for v in counts.values());q=sum(v[2] for v in counts.values())
        need((p,q)==(203051492021,575481372281),'Whole P/N totals differ')
        after=record(read(RUN+'INPUTS_AFTER.json')['identity_record'])
        need(after['files']==inputs,'Before/after input maps differ')
        root=raw(cells[0,0]['bits']);identity=inputs[cells[0,0]['bits']]
        need(len(root)==identity['bytes']==8 and digest(root)==identity['sha256'] and root[0]&1==1,'Root payload identity/bit differs')
        summary=load(BASE/'coverage.json')
        for row in summary['buckets']:
            k=(row['layer'],row['honor']);fr,pc,nc=counts[k]
            need((row['size'],row['rows'],row['frames'],row['P'],row['N'])==(cells[k]['size'],cursor[k],fr,pc,nc),'Git/asset coverage summary differs')
    return dict(status='PASS_SAVED_NATIVE_EVIDENCE_GRAPH',frames=17317,rows=TOTAL,nonempty_buckets=3686,
        cross_layer_target_references=54548,problems=0,
        scope='Saved record hashes, exact coverage and identity links; no native/Lean execution, full-input rehash or independent game replication')


def verify():
    provenance=load(BASE/'provenance.json')
    for item in provenance['artifacts']:
        p=(BASE/item['published_path']).resolve()
        need(p.is_relative_to(BASE) and p.is_file(),'Invalid publication path')
        need(p.stat().st_size==item['published_bytes'] and sha(p)==item['published_sha256'],'Changed public artifact: '+item['published_path'])
        if not item['transformations']:need(item['published_sha256']==item['original_sha256'],'Unrecorded transformation')
    final=load(BASE/'evidence/final.json');coverage=load(BASE/'coverage.json');inputs=load(BASE/'inputs.json')
    need(final['status']=='COMPLETE_FIXED_V17_NATIVE_COMPUTATION' and final['six_acceptance_families_complete'] and not final['closed_actual_input_Lean_declaration'],'Final scope differs')
    need(final['committed_rows']==coverage['rows']==TOTAL and final['committed_frames']==coverage['frames']==17317,'Coverage totals differ')
    need(len(coverage['buckets'])==6440 and sum(x['size']>0 for x in coverage['buckets'])==3686,'Coverage cell count differs')
    need(sum(x['rows'] for x in coverage['buckets'])==TOTAL and all(x['rows']==x['size']==x['P']+x['N'] for x in coverage['buckets']),'Per-bucket rows differ')
    need(sum(x['P'] for x in coverage['buckets'])==final['P_rows']==203051492021 and sum(x['N'] for x in coverage['buckets'])==final['N_rows']==575481372281,'P/N totals differ')
    need(len(inputs['files'])==inputs['input_count']==11272 and sum(x['bytes'] for x in inputs['files'].values())==inputs['input_bytes']==100615834170,'Input counts differ')
    need(digest(canonical(inputs['files']))==inputs['identity_sha256'] and inputs['post_map_equals_pre_map'],'Input-map digest differs')
    source=load(BASE/'source-map.json');need(len(source['modules'])==148 and source['unresolved_project_imports']==[],'Source map differs')
    names={x['module'] for x in source['modules']};need(len(names)==148,'Duplicate modules')
    for row in source['modules']:
        p=(ROOT/row['public_path']).resolve();need(p.is_relative_to(ROOT) and sha(p)==row['sha256'] and p.stat().st_size==row['bytes'],'Mapped source differs')
        imports=[m for line in p.read_text(encoding='utf-8').splitlines() if line.startswith('import ') for m in line.split()[1:]]
        need(all(m in names or m.startswith(('Lean','Std','Init')) for m in imports),'Unresolved source import')
    build=load(BASE/'evidence/final-build.json')
    need(build['replay']['returncode']==0 and build['replay']['failure'] is None and build['executable']['sha256']==NATIVE,'Recorded build/replay differs')
    controls=load(BASE/'evidence/native-controls.json')
    need(controls['required_controls_passed'] and len(controls['cases'])==6 and not controls['whole_table_verified'],'Native controls scope differs')
    need(load(BASE/'evidence/bookkeeper-controls.json')['test_count']==22 and len(load(BASE/'evidence/transport-controls.json')['tests'])==36,'Mock control counts differ')
    review=load(BASE/'review/extraction.json');text=(BASE/'review/INDEPENDENT_REVIEW.md').read_text(encoding='utf-8')
    code=text.split('```python\n',1)[1].rsplit('\n```',1)[0]+'\n'
    need(sha(BASE/'review/INDEPENDENT_REVIEW.md')==review['source_original_sha256'] and digest(code.encode())==review['extracted_sha256']==sha(BASE/'review/independent_ledger_check.py'),'Review/script identity differs')
    need(review['reviewer_is_AI'] and not review['human_peer_review'] and not review['independent_native_replication'],'Review type conflated')
    current=load(ROOT/'RESEARCH_STATUS.json')
    need(current['native_verification']['status']==final['status'] and current['native_verification']['rows']==TOTAL and not current['native_verification']['independent_execution_replication_completed'],'Current native status differs')
    need(current['formal_verification']['empty_game_lean']=='NOT_VERIFIED' and not current['formal_verification']['end_to_end_Lean_theorem_published'],'Native acceptance/closed theorem conflated')
    return dict(status='PASS_V17_NATIVE_PUBLICATION',artifacts=len(provenance['artifacts']),mapped_source_modules=148,
        recorded_native_rows=TOTAL,recorded_frames=17317,closed_actual_input_Lean_declaration=False,
        scope='Public artifact and recorded-scope consistency only; use --archive for saved full-ledger checking')


def main():
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('--archive',type=Path);args=parser.parse_args()
    print(json.dumps(verify()))
    if args.archive:print(json.dumps(verify_archive(args.archive)))


if __name__=='__main__':
    try:main()
    except (ValueError,OSError,KeyError,zipfile.BadZipFile) as exc:
        print(str(exc),file=sys.stderr);raise SystemExit(1)
