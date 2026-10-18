"""Fail-closed external execution ledger checks, not a Lean proof generator."""
import argparse,copy,json,struct
from pathlib import Path
import common as c

MANIFEST_SCHEMA='V17_NATIVE_ACTIVITY_MANIFEST_V1'
FRAME_SCHEMA='V17_COMMITTED_FRAME_V1'
NATIVE=dict(path='build/lean_table_checker/v17_compute_finish_20261018/native/1060b5998a014be594e54ba64d3671d5/V17ComputeMain',
            bytes=121190888,sha256='775e05d2601e30847b14b017cb542ea23a8b629d8ebd403aa07bd5942b78f667')
BASELINE=dict(path='runs/lean_table_checker/v17_compute_finish_20261018/BASELINE.json',bytes=133761,
              sha256='6dd21a8d52497738ad87ca93bc942ff5e678936f721b6cf4b0687022a74fdd0f')
BUILD=dict(path='runs/lean_table_checker/v17_compute_finish_20261018/native_builds/1060b5998a014be594e54ba64d3671d5/phase_finalize_9a88469a8585/final_build.json',
           bytes=54612,sha256='c896362695703f411aa7ba548323e784efe8e1bcfeea93e0f862fb87a5b2c9ed')
APPLICATION_SOURCES={
 'build/lean_table_checker/v17_compute_finish_20261018/source/V17ComputeMain.lean':dict(bytes=26709,sha256='19b87459bb70cf264089986a1d92f2e06757ad6c66f1674eadacf5fb12eee9ac'),
 'build/lean_table_checker/v17_compute_finish_20261018/source/Mahjong/V17NativeWorker.lean':dict(bytes=13624,sha256='dadc722410875249f7d308c71c16ee7d1c71ebeb3e3fa3b9b078f63c9c02d6cb')}

def validate_build(manifest,read_record):
    c.need(manifest.get('native')==NATIVE and c.identity(manifest['native'])==c.identity(NATIVE),'Different or malformed executable authority')
    c.need(manifest.get('final_build')==BUILD and manifest.get('baseline')==BASELINE,'Different frozen build/baseline authority')
    build=read_record(BUILD);baseline=read_record(BASELINE)
    c.need(build.get('schema')=='V17_NATIVE_WORKER_AND_FROZEN_MATH_COLD_BUILD' and
           build.get('status')=='PASS_NATIVE_LINK_AND_STANDARD_FRESH_IMPLICATION_ONLY' and
           build.get('executable')==NATIVE and build.get('baseline')==BASELINE,'Native build provenance differs')
    c.need(build['replay'].get('returncode')==0 and build['replay'].get('child_exit_confirmed') is True and
           build['replay'].get('failure') is None,'Standard fresh fixed-implication replay failed')
    c.need(baseline.get('schema')=='FROZEN_V17_NATIVE_COMPUTE_FINISH_BASELINE' and
           baseline.get('target_theorem')=='Mahjong.FastWholeInputV17.from_finite_input' and
           baseline.get('base_sources')==132 and baseline.get('frozen_source_count')==145,'Fixed V17 implication basis differs')
    source_map=manifest.get('application_source_binding',{})
    for name,rec in APPLICATION_SOURCES.items():c.need(source_map.get(name)==rec,'Current application source not bound: '+name)
    for item in baseline['source_records']:
        for field in ('source','snapshot'):
            rec=item[field];c.need(source_map.get(rec['path'])==c.identity(rec),'Frozen mathematical source binding differs')
    for module in build['modules']:
        if module.get('module') in ('V17ComputeMain','Mahjong.V17NativeWorker'):
            snap=module['source_snapshot'];c.need(source_map.get(snap['path'])==c.identity(snap),'Actual compiled application snapshot differs')
        for phase in ('kernel','native'):
            c.need(module[phase].get('returncode')==0 and module[phase].get('child_exit_confirmed') is True,'New application compilation failed')
    return True

def target_cells(plan,cell,index=None):
    if cell['layer']==34:return []
    if index is None:index={(v['layer'],v['honor']):v for v in plan['cells']}
    return [index[cell['layer']+1,h] for h in cell['needed_honors'] if index[cell['layer']+1,h]['size']]

def source_identity(manifest,plan,cell):
    return c.seven_fields(cell,manifest['inputs_before'],plan['common_identity_fields'])

def validate_manifest(manifest,plan):
    c.need(manifest.get('schema')==MANIFEST_SCHEMA,'Wrong new activity manifest')
    c.need(manifest.get('old_PASS_or_seed_imported') is False,'Old acceptances cannot authorize this activity')
    c.need(manifest.get('closed_actual_input_Lean_declaration') is False,'Execution receipt cannot claim a closed input theorem')
    actual=manifest['inputs_before'];expected=plan['input_inventory']
    c.need(set(actual)==set(expected),'Full input map has missing or extra paths')
    for name,v in expected.items():c.need(c.identity(actual[name])['bytes']==v['bytes'],'Input extent differs: '+name)
    c.need(manifest['input_identity_sha256']==c.digest(actual),'Input map digest differs')
    c.need(plan['total_cells']==6440 and plan['nonempty_buckets']==3686 and plan['empty_cells']==2754 and
           plan['total_rows']==778532864302,'All35 actual inventory must be explicit')
    c.need(manifest['native']['sha256'] and manifest['native']['bytes']>0,'Missing frozen native executable identity')
    c.need(manifest.get('smoke_required_controls_passed') is True,'New Main smoke prerequisites not passed')
    cells=plan['cells'];c.need(len(cells)==6440,'All35 cell list required')
    c.need([(x['layer'],x['honor']) for x in cells]==[(n,h) for n in range(35) for h in range(184)],'Whole cell order/domain differs')
    c.need(sum(bool(x['size']) for x in cells)==3686 and sum(x['size'] for x in cells)==plan['total_rows'],'Incorrect physical inventory')

def validate_frame(receipt,manifest,manifest_sha,plan,cell,read_record,cell_index=None):
    c.need(receipt.get('schema')==FRAME_SCHEMA and receipt.get('status')=='COMMITTED_NATIVE_V17_FRAME','Not a committed V17 frame')
    c.need(receipt.get('manifest_sha256')==manifest_sha and receipt.get('native')==manifest['native'],'Frame manifest/executable differs')
    c.need(receipt.get('input_identity_sha256')==manifest['input_identity_sha256'],'Frame input identity differs')
    c.need(receipt.get('no_old_acceptance_imported') is True,'Frame imports old progress')
    start=c.uint(receipt['start'],'frame start');count=c.uint(receipt['count'],'frame count')
    c.need(0<count<=67108864 and start+count<=cell['size'],'Frame outside source')
    c.need((receipt.get('layer'),receipt.get('honor'))==(cell['layer'],cell['honor']),'Frame bucket differs')
    c.need(receipt.get('source_identity')==source_identity(manifest,plan,cell),'Source seven fields differ')
    children=target_cells(plan,cell,cell_index)
    expected={str(x['honor']):source_identity(manifest,plan,x) for x in children}
    c.need(receipt.get('target_identities')==expected,'Target bank differs from actual next-layer seven fields')
    session=read_record(receipt['global_ready']);opened=read_record(receipt['bucket_ready'])
    sid=receipt['session_id'];bid=receipt['bucket_open_id']
    c.need(session.get('session_id')==sid and session.get('native')==manifest['native'],'Global session/executable differs')
    global_event=session['native_event']
    c.need(global_event.get('event')=='GLOBAL_READY' and global_event.get('baseChecked') is True and
           global_event.get('successorsChecked') is True and global_event.get('layers')==35 and
           global_event.get('honors')==184,'Actual base/successor finite acceptance missing')
    c.need(opened.get('session_id')==sid and opened.get('bucket_open_id')==bid and
           opened.get('native')==manifest['native'],'Bucket session/executable differs')
    event=opened['native_event']
    c.need(event.get('event')=='BUCKET_READY' and (event.get('layer'),event.get('honor'))==(cell['layer'],cell['honor']) and
           event.get('size')==cell['size'] and event.get('metadataChecked') is True and event.get('targetIdentity') is True,
           'Actual source/target/coverage metadata acceptance missing')
    c.need(event.get('loaded_target_honors')==sorted(x['honor'] for x in children),'Native loaded target list differs')
    if cell['layer']==0 and cell['honor']==0:c.need(event.get('rootChecked') is True,'Actual empty root P check missing')
    else:c.need(event.get('rootChecked') is None,'Spurious root acceptance outside empty root')
    result=read_record(receipt['native_result'])
    c.need(result.get('schema')=='V17_NATIVE_FRAME_RESULT_V1' and result.get('event')=='FRAME_RESULT' and
           result.get('status')=='PASS_NATIVE_V17_FRAME' and result.get('frameAccepted') is True,'Actual V17 scan/frame acceptance missing')
    c.need((result.get('layer'),result.get('honor'),result.get('start'),result.get('count'))==
           (cell['layer'],cell['honor'],start,count),'Native frame extent/bucket differs')
    c.need(result.get('checked_rows')==count and result.get('logical_fragments')==12 and
           result.get('closed_kernel_table_theorem') is False,'Native row count or proof claim differs')
    p=c.uint(result['P_rows'],'P count');n=c.uint(result['N_rows'],'N count')
    c.need(p+n==count and receipt.get('P_rows')==p and receipt.get('N_rows')==n,'Native P/N count mismatch')
    c.need(receipt.get('source_span_P_rows')==p and receipt.get('source_span_N_rows')==n,'Actual original span P/N check missing')
    c.need(receipt.get('acceptances')==dict(base=True,successors=True,metadata=True,frames=True,target_identity=True,
                                           root_P=(cell['layer']==0 and cell['honor']==0)),
           'Six scoped actual acceptances differ')
    return dict(start=start,count=count,P_rows=p,N_rows=n,session_id=sid,bucket_open_id=bid)

def verify_entries(manifest,manifest_sha,plan,entries,read_record,*,complete=False):
    validate_manifest(manifest,plan)
    validate_build(manifest,read_record)
    by_cell={(x['layer'],x['honor']):x for x in plan['cells']};cursor={};p=n=0;frames=0;seen=set()
    for entry in entries:
        key=entry['frame_key'];c.need(len(key)==4 and all(type(x) is int for x in key),'Malformed frame key')
        layer,honor,start,count=key;cell=by_cell.get((layer,honor));c.need(cell is not None and cell['size']>0,'Frame for empty/outside cell')
        c.need(tuple(key) not in seen,'Duplicate frame key');seen.add(tuple(key))
        receipt=read_record(entry['receipt'])
        value=validate_frame(receipt,manifest,manifest_sha,plan,cell,read_record,by_cell)
        c.need((value['start'],value['count'])==(start,count),'Ledger/receipt extent differs')
        current=cursor.get((layer,honor),0)
        c.need(start==current,'Frame gap or overlap at '+c.bucket_key(layer,honor))
        cursor[layer,honor]=start+count;p+=value['P_rows'];n+=value['N_rows'];frames+=1
    finished=sum(x['size']>0 and cursor.get((x['layer'],x['honor']),0)==x['size'] for x in plan['cells'])
    if complete:
        c.need(finished==3686,'Not all nonempty buckets have exact frame coverage')
        c.need(p+n==plan['total_rows'],'Whole-table row count differs')
    return dict(committed_frames=frames,committed_rows=p+n,P_rows=p,N_rows=n,complete_nonempty_buckets=finished,
                empty_cells=2754,all_cells=6440,remaining_rows=plan['total_rows']-p-n,cursors=cursor)

def verify_catalog_headers(plan):
    """Check all6440 catalog extents against actual bound header metadata.

    These IO format checks do not replace the native finite semantic checks.
    The actual complete header/entry files are in the before/after SHA map.
    """
    cells={(x['layer'],x['honor']):x for x in plan['cells']};checked=0
    prefix=c.path(plan['config']['prefix_root'])
    for h in range(184):
        with (prefix/f'h{h}.bin').open('rb') as f:
            for n in range(35):
                header=f.read(32);c.need(len(header)==32,'Truncated honor header')
                magic,hh,nn,count,reserved,total=struct.unpack('<Q4IQ',header)
                c.need(magic==0x31524944584a4d and hh==h and nn==n and reserved==0,'Honor header identity differs')
                cell=cells[n,h];c.need((count,total)==(cell['blocks'],cell['size']),'Catalog differs from actual finite directory extent')
                f.seek(count*20,1);checked+=1
            c.need(f.read(1)==b'','Honor directory has trailing data')
    return dict(schema='V17_ALL6440_ACTUAL_CATALOG_HEADER_COMPARISON_V1',checked_cells=checked,
                native_finite_semantics_still_required=True)

def disk_reader():
    cache={}
    def read(record):
        name=record['path'];key=(name,record['bytes'],record['sha256'])
        if key not in cache:
            with c.ReadLocks([name]):
                p=c.checked_record(record);cache[key]=c.load(p)
        return cache[key]
    return read

def verify_completion(manifest,plan,entries,after,cleanup,read_record):
    c.need(after.get('schema')=='V17_ACTUAL_POST_INPUT_IDENTITIES_V1' and after.get('files')==manifest['inputs_before'],
           'Current post-input SHA map missing or different')
    c.need(cleanup.get('schema')=='V17_ALL_OWNED_SERVICES_CONFIRMED_EXITED_V1' and
           cleanup.get('all_owned_services_confirmed_exited') is True,'Final service cleanup not confirmed')
    acknowledged={}
    for rec in cleanup['sessions']:
        value=read_record(rec);sid=value['session_id'];c.need(sid not in acknowledged,'Duplicate session cleanup')
        c.need(value.get('all_owned_services_confirmed_exited') is True and value.get('native')==manifest['native'],
               'Session exit/executable identity differs')
        scope=read_record(value['scope']);c.need(scope.get('session_id')==sid and scope.get('native')==manifest['native'],'Cleanup scope binding differs')
        if value['schema']=='V17_SUPERVISOR_CONFIRMED_CLEANUP_V1':
            c.need(value.get('adapter_returncode')==0 and value.get('native_stop_event',{}).get('event')=='GLOBAL_STOPPED','Native normal EOF/stop missing')
            linux=read_record(value['linux_cleanup'])
            c.need(linux.get('schema')=='V17_LINUX_SERVICE_CLEANUP_V1' and linux.get('session_id')==sid and
                   linux.get('native_exited') is True and linux.get('GPU_context_closed') is True and
                   linux.get('native_returncode')==0 and not linux.get('errors'),'Normal Linux shutdown not confirmed')
        else:
            c.need(value['schema'] in ('V17_SUPERVISOR_ABORTED_CLEANUP_V1','V17_EXACT_SCOPE_RECOVERY_V1'),
                   'Unknown session cleanup proof')
        acknowledged[sid]=value
    c.need(set(acknowledged)==set(cleanup['all_session_ids']),'Some owned session exits were omitted')
    for entry in entries:
        receipt=read_record(entry['receipt']);c.need(receipt['session_id'] in acknowledged,'Accepted frame belongs to an unclosed owned session')
    return dict(post_input_identities_verified=True,all_owned_services_confirmed_exited=True,
                confirmed_session_count=len(acknowledged))

def main():
    a=argparse.ArgumentParser();a.add_argument('--run',required=True);a.add_argument('--complete',action='store_true');v=a.parse_args()
    run=c.owned(v.run);manifest_path=run/'MANIFEST.json';manifest=c.load(manifest_path);mrec=c.record(manifest_path)
    plan=c.load(c.checked_record(manifest['plan']));journal=c.Journal(run,mrec['sha256'])
    with c.OwnerLock(run/'finalizer_owner.lock'):
        import runtime_identity as ri
        with c.ReadLocks(list(manifest['code_binding'])+[manifest['runtime']['path'],f"{manifest['native']['path']}"]):
            for name,expected in manifest['code_binding'].items():c.need(c.sha_file(name)==expected,'Current frozen code/source differs: '+name)
            c.need(c.record(manifest['native']['path'])==manifest['native'],'Actual current executable differs')
            ri.validate_runtime(c.load(c.checked_record(manifest['runtime'])),manifest['code_binding'])
        result=verify_entries(manifest,mrec['sha256'],plan,journal.entries,disk_reader(),complete=v.complete)
        if v.complete:
            after=c.load(c.checked_record(c.load(run/'INPUTS_AFTER.json')['identity_record']))
            cleanup=c.load(run/'services_final_cleanup.json')
            done=verify_completion(manifest,plan,journal.entries,after,cleanup,disk_reader())
            c.need(set(cleanup['all_session_ids'])=={x.name for x in (run/'sessions').iterdir() if x.is_dir()},'An actual session directory was omitted')
            result.update(status='COMPLETE_FIXED_V17_NATIVE_COMPUTATION',six_acceptance_families_complete=True,
                **done,
                claim_class='FIXED_V17_KERNEL_IMPLICATION_PLUS_NATIVE_COMPUTATION',closed_actual_input_Lean_declaration=False)
        else:result['status']='VERIFIED_OWN_COMMITTED_PREFIX_ONLY'
        result.pop('cursors');result.update(schema='V17_EXTERNAL_EXECUTION_COVERAGE_REPORT_V1',manifest=mrec,
             ledger=c.record(journal.file) if journal.file.exists() else None,catalog_headers=verify_catalog_headers(plan),verified_utc=c.utc(),
             model_calls=0,notifications=False,old_PASS_or_seed_imported=False)
        c.atomic(run/('FINAL.json' if v.complete else 'PREFIX_VERIFIED.json'),result)
        print(c.canonical(result).decode())

if __name__=='__main__':main()
