"""Independent new all35 activity. No old accepted rows are imported.

The controller schedules untrusted proposals and durable Native results. It
does not implement checkBase, prepare, row checks, typed assembly or strategy.
"""
import argparse,hashlib,importlib.util,json,os,socket,subprocess,sys,threading,time,traceback,uuid
from pathlib import Path
import common as c
import finalize as f
import runtime_identity as ri
import service

PLANNER='build/lean_table_checker/campaign_indexed_v16/frame_planner.py'
PLANNER_SHA='276644a6296dfb9296a8122a6b7954c8c842af075d673fd38fe58321c6b9e259'

class AdaptiveRestart(Exception):pass

def scheduled_cells(cells):
    # Exercise a real mixed P/N production bucket first. Every cell remains
    # exactly once; committed per-bucket cursors still govern every resume.
    return sorted(cells,key=lambda x:(0 if (x['layer'],x['honor'])==(32,89) else 1,-x['layer'],x['honor']))

def alive(owner):
    import psutil
    try:return psutil.Process(owner['pid']).create_time()==owner['creation_time']
    except psutil.NoSuchProcess:return False

def call(endpoint,op,**fields):
    # The connect deadline detects a missing local supervisor, not a timeout of
    # any finite mathematical check. Accepted connections have no wall cap.
    with socket.create_connection((endpoint['host'],endpoint['port']),timeout=10) as connection:
        connection.settimeout(None);stream=connection.makefile('rwb')
        stream.write(c.canonical(dict(token=endpoint['token'],op=op,**fields))+b'\n');stream.flush()
        raw=stream.readline(2_000_001);c.need(raw and len(raw)<=2_000_000,'Missing/oversized local supervisor response')
        value=json.loads(raw);c.need(value.get('ok') is True,'Owned Native service failed: '+repr(value));return value['value']

def planner():
    p=c.path(PLANNER);raw=p.read_bytes();c.need(hashlib.sha256(raw).hexdigest()==PLANNER_SHA,'Frozen untrusted partitioner changed')
    spec=importlib.util.spec_from_file_location('_v17_proposal_schedule',p);module=importlib.util.module_from_spec(spec);sys.modules[spec.name]=module
    exec(compile(raw,str(p),'exec'),module.__dict__);return module

def source_counts(path,start,count):
    first=start//8;offset=start%8;length=(offset+count+7)//8
    with c.path(path).open('rb',buffering=0) as file:file.seek(first);raw=file.read(length)
    c.need(len(raw)==length,'Truncated original source label span')
    bits=(int.from_bytes(raw,'little')>>offset)&((1<<count)-1);p=bits.bit_count()
    return p,count-p

class Activity:
    def __init__(self,run):
        self.run=c.owned(run);self.plan=c.load(self.run/'PLAN.json');self.began=time.monotonic();self.endpoint=None
        self.invocation=self.run/'controller_invocations'/uuid.uuid4().hex;self.invocation.mkdir(parents=True)
        self.stage='STARTING';self.status='RUNNING';self.error=None;self.journal=None;self.manifest=None;self.manifest_record=None
        self.stats=dict(committed_frames=0,committed_rows=0,complete_nonempty_buckets=0,P_rows=0,N_rows=0)
        self.last_report=0.;self.last_archive=0.;self.stop_reporter=threading.Event();self.current_bucket=None;self.current_frame=None
        self.session_process=None;self.session_logs=[];self.locks=None;self.pool=12;self.frame_rows=67108864;self.code={}
        adaptive=self.run/'adaptive_execution.json'
        if adaptive.exists():
            prior=c.load(adaptive);c.need(prior['pool_threads'] in (1,2,4,8,12) and 1048576<=prior['frame_rows']<=67108864,'Invalid adaptive schedule')
            self.pool=prior['pool_threads'];self.frame_rows=prior['frame_rows']
        self.report(force=True)

    def report(self,force=False):
        now=time.monotonic()
        if not force and now-self.last_report<30:return
        rows=self.stats['committed_rows'];elapsed=now-self.began
        value=dict(schema='V17_LOCAL_PROGRESS_V1',status=self.status,stage=self.stage,updated_utc=c.utc(),
            elapsed_this_invocation_seconds=elapsed,verified_rows=rows,total_rows=self.plan['total_rows'],
            remaining_rows=self.plan['total_rows']-rows,percent=100*rows/self.plan['total_rows'],
            committed_frames=self.stats['committed_frames'],complete_nonempty_buckets=self.stats['complete_nonempty_buckets'],
            nonempty_buckets=3686,empty_cells=2754,all_cells=6440,P_rows=self.stats['P_rows'],N_rows=self.stats['N_rows'],
            current_bucket=self.current_bucket,current_frame=self.current_frame,pool_threads=self.pool,
            proposal_frame_row_limit=self.frame_rows,physical_memory=c.system_memory(),error=self.error,
            model_calls=0,notifications=False,old_PASS_or_seed_imported=False,closed_actual_input_Lean_declaration=False)
        c.atomic(self.run/'progress.json',value)
        lines=[f"V17 activity: {value['status']} / {value['stage']}",f"Updated: {value['updated_utc']}",
            f"Verified rows: {rows:,} / {value['total_rows']:,} ({value['percent']:.9f}%)",
            f"Remaining rows: {value['remaining_rows']:,}",f"Committed frames: {value['committed_frames']:,}",
            f"Complete nonempty buckets: {value['complete_nonempty_buckets']} / 3686; empty cells: 2754",
            f"P: {value['P_rows']:,}; N: {value['N_rows']:,}",f"This invocation elapsed: {elapsed:.1f}s",
            f"Current bucket/frame: {self.current_bucket} / {self.current_frame}",
            "Claim: fixed V17 kernel implication plus actual Native computation; no closed actual-input Lean theorem.",
            "Model calls: 0; notifications: false; old verified progress imported: false."]
        if self.error:lines.append('Error: '+self.error)
        c.atomic(self.run/'progress.txt',('\n'.join(lines)+'\n').encode())
        if force or now-self.last_archive>=3600:
            c.once(self.run/'reports'/(str(time.time_ns())+'.json'),value);self.last_archive=now
        self.last_report=now

    def guard(self):c.need(not (self.run/'STOP').exists(),'Own new activity STOP requested')

    def input_identities(self):
        pointer=self.run/'INPUTS_BEFORE.json'
        while not pointer.exists():self.stage='WAITING_ACTUAL_INPUT_HASH';self.report();self.guard();time.sleep(2)
        value=c.load(pointer)
        self.hash_record_lock=c.ReadLocks([pointer,value['identity_record']['path']])
        c.need(c.load(pointer)==value,'Input-custody pointer changed while locking')
        actual=c.load(c.checked_record(value['identity_record']))
        c.need(actual['schema']=='V17_ACTUAL_READLOCKED_INPUT_IDENTITIES_V1' and actual['plan']==c.record(self.run/'PLAN.json') and
            set(actual['files'])==set(self.plan['input_inventory']) and actual['files_sha256']==c.digest(actual['files']),
            'Actual input hash result differs from the new full plan')
        for name,rec in actual['files'].items():c.need(c.identity(rec)['bytes']==self.plan['input_inventory'][name]['bytes'],'Input extent mismatch')
        # Our own deny-write/delete locks are already held. Reusing the actual
        # hash is allowed only while the original custodian is still live.
        custody_closed=c.path(value['identity_record']['path']).parent/'closed.json'
        if alive(actual['owner']) and not custody_closed.exists() and actual.get('continuous_Windows_deny_write_delete_custody') is True:
            self.custodian=value;return actual['files']
        # A crashed or released custodian cannot turn an expected digest into
        # an actual one. Rehash under our own continuous locks before any row.
        self.stage='REHASHING_AFTER_CUSTODY_INTERRUPTION';self.report(force=True)
        got={}
        for name in sorted(self.plan['input_inventory']):
            self.guard();got[name]=c.sha_file(name,self.guard);self.report()
        c.need(got==actual['files'],'Resume inputs changed from the frozen input identity')
        c.once(self.invocation/'revalidated_input_identities.json',dict(files=got,prior_record=value['identity_record'],actual_rehashed=True))
        self.custodian=None;return got

    def stage_runtime(self):
        self.stage='ACQUIRING_ALL_INPUT_AND_CODE_READLOCKS';self.report(force=True)
        # All currently reviewed ops and all actual mathematical source inputs
        # are locked before dynamic service/proposer imports or row execution.
        source_map=ri.source_binding();ops=list(c.BASE.glob('*.py'));freeze_path=c.BASE/'SOURCE_FREEZE_REVISION3.json'
        paths=list(self.plan['input_inventory'])+ops+list(source_map)+service.code_paths()+[freeze_path,PLANNER,f.NATIVE['path'],f.BUILD['path'],f.BASELINE['path'],self.run/'PLAN.json',self.run/'native_config.json']
        self.locks=c.ReadLocks(paths)
        self.code={c.rel(c.path(p)):c.sha_file(p,self.guard) for p in sorted(set(map(str,paths))) if c.rel(c.path(p)) not in self.plan['input_inventory']}
        for name,value in source_map.items():c.need(self.code.get(name)==value,'Frozen current application/math source differs')
        freeze=c.load(freeze_path);c.need(freeze.get('schema')=='V17_EXTERNAL_OPS_SOURCE_FREEZE_V1' and freeze.get('native')==f.NATIVE,'Wrong ops source closure')
        c.need(set(freeze['files'])=={c.rel(p) for p in ops},'Ops source file set differs from frozen closure')
        for name,expected in freeze['files'].items():c.need(self.code.get(name)==expected,'Ops source changed after freeze')
        while not (self.run/'RUNTIME.json').exists():
            self.stage='WAITING_FRESH_NATIVE_AND_BOOKKEEPER_CONTROLS';self.report();self.guard();time.sleep(2)
        self.runtime_lock=c.ReadLocks([self.run/'RUNTIME.json'])
        self.runtime_rec=c.record(self.run/'RUNTIME.json');self.runtime=c.load(self.run/'RUNTIME.json')
        ri.validate_runtime(self.runtime,self.code)
        self.inputs=self.input_identities();self.stage='VERIFY_ALL6440_CATALOG_METADATA';self.report(force=True)
        headers=f.verify_catalog_headers(self.plan);c.once(self.invocation/'catalog_header_comparison.json',headers)
        value=dict(schema=f.MANIFEST_SCHEMA,plan=c.record(self.run/'PLAN.json'),runtime=self.runtime_rec,
            native=f.NATIVE,final_build=f.BUILD,baseline=f.BASELINE,application_source_binding=source_map,
            code_binding=self.code,inputs_before=self.inputs,input_identity_sha256=c.digest(self.inputs),
            native_config=c.record(self.run/'native_config.json'),ops_source_freeze=c.record(freeze_path),old_PASS_or_seed_imported=False,
            smoke_required_controls_passed=True,closed_actual_input_Lean_declaration=False,
            claim_class='FIXED_V17_KERNEL_IMPLICATION_PLUS_NATIVE_COMPUTATION',
            execution_bucket_schedule='ACTUAL_N32_H89_FIRST_THEN_DESCENDING_LAYER_HONOR_V1',
            maximum_proposal_policy=self.plan['frame_policy'],initial_pool_threads=12,
            physical_pressure_policy='REDUCE_POOL_AND_PROPOSAL_COUNT_WITHOUT_CHANGING_CHECKER',
            wall_hard_limit_seconds=None,RAM_hard_limit_bytes=None)
        manifest_path=self.run/'MANIFEST.json'
        if manifest_path.exists():
            self.manifest=c.load(manifest_path);c.need(self.manifest==value,'Resume manifest/code/executable/input identity differs')
        else:self.manifest=value;c.once(manifest_path,value)
        self.manifest_record=c.record(manifest_path);f.validate_build(self.manifest,f.disk_reader())
        self.journal=c.Journal(self.run,self.manifest_record['sha256'],repair_tail=True)
        self.stage='REVALIDATING_OWN_COMMITTED_PREFIX';self.report(force=True)
        self.stats=f.verify_entries(self.manifest,self.manifest_record['sha256'],self.plan,self.journal.entries,f.disk_reader())
        self.report(force=True)

    def retire_prior_service(self,value):
        # A new controller must not initialize a possibly half-used session a
        # second time. Reap its precisely identified owner before fresh base
        # checks, then resume solely from the durable committed journal.
        sid=value.get('session_id');directory=c.path(value['session_dir'])
        c.need(isinstance(sid,str) and len(sid)==32 and all(x in '0123456789abcdef' for x in sid) and
            directory==self.run/'sessions'/sid,'Prior service is outside this owned activity')
        owner=value['owner'];endpoint_path=directory/'endpoint.json'
        while alive(owner) and not endpoint_path.exists():
            self.stage='WAIT_PRIOR_OWNED_SERVICE_ENDPOINT';self.report();self.guard();time.sleep(1)
        if not alive(owner):return
        endpoint=c.load(endpoint_path)
        c.need(endpoint.get('owner')==owner and endpoint.get('session_id')==sid and endpoint.get('native')==f.NATIVE and
            endpoint.get('host')=='127.0.0.1' and type(endpoint.get('port')) is int and 0<endpoint['port']<65536 and
            isinstance(endpoint.get('token'),str) and len(endpoint['token'])==64 and
            all(x in '0123456789abcdef' for x in endpoint['token']),'Prior owned endpoint identity differs')
        state=call(endpoint,'status')
        c.need(state.get('owner')==owner and state.get('session_id')==sid and state.get('native')==f.NATIVE,
            'Live supervisor identity differs from its owned endpoint')
        self.endpoint=endpoint;self.stage='ABORT_PRIOR_OWNED_SESSION_BEFORE_RESUME';self.report(force=True)
        cleanup=call(endpoint,'abort')
        c.need(cleanup.get('all_owned_services_confirmed_exited') is True and cleanup.get('session_id')==sid and
            cleanup.get('native')==f.NATIVE and c.load(directory/'aborted_cleanup.json')==cleanup,
            'Prior owned session abort was not durably confirmed')
        # Abort confirms Linux/GPU exit first; also wait for the exact Windows
        # supervisor to exit and release its service_owner lock before launch.
        while alive(owner):self.report();time.sleep(.2)
        c.once(self.invocation/'retired_prior_service.json',dict(schema='V17_PRIOR_OWNED_SERVICE_REAPED_BEFORE_RESUME_V1',
            session_id=sid,owner=owner,endpoint=c.record(endpoint_path),cleanup=c.record(directory/'aborted_cleanup.json'),
            all_owned_services_confirmed_exited=True,prior_session_reused=False,new_actual_base_checks_required=True))
        self.endpoint=None

    def obtain_service(self):
        current=self.run/'SERVICE_CURRENT.json'
        if current.exists():
            self.retire_prior_service(c.load(current))
        self.stage='RECOVERING_PRIOR_OWNED_SERVICES';self.report(force=True)
        for directory in sorted((self.run/'sessions').glob('*')) if (self.run/'sessions').exists() else []:
            scope=directory/'linux_scope.json'
            if scope.exists() and not (directory/'confirmed_cleanup.json').exists():
                result=subprocess.run(['wsl.exe','--exec','/usr/bin/python3','-B',service.wsl(c.BASE/'recover.py'),service.wsl(scope)],
                    capture_output=True,text=True,creationflags=getattr(subprocess,'CREATE_NO_WINDOW',0))
                c.need(result.returncode==0,'Prior own Linux scope not empty: '+result.stdout+result.stderr)
                c.once(directory/('recovery_'+uuid.uuid4().hex+'.json'),json.loads(result.stdout))
        stdout=(self.invocation/'service.stdout.jsonl').open('xb',buffering=0);stderr=(self.invocation/'service.stderr.log').open('xb',buffering=0)
        self.session_logs=[stdout,stderr]
        self.session_process=subprocess.Popen([sys.executable,'-B','-X','utf8',str(c.BASE/'service.py'),'--run',str(self.run),
            '--native',str(c.path(f.NATIVE['path'])),'--native-sha256',f.NATIVE['sha256'],'--pool-threads',str(self.pool)],
            cwd=c.ROOT,stdout=stdout,stderr=stderr,creationflags=getattr(subprocess,'CREATE_NO_WINDOW',0))
        self.stage='NEW_NATIVE_GLOBAL_BASE_AND_SUCCESSORS';self.report(force=True)
        while True:
            c.need(self.session_process.poll() is None,'Supervisor exited during startup; inspect own service.stderr.log')
            if current.exists():
                value=c.load(current);endpoint_path=c.path(value['session_dir'])/'endpoint.json'
                if alive(value['owner']) and endpoint_path.exists():
                    endpoint=c.load(endpoint_path)
                    if endpoint['owner']['pid']==self.session_process.pid:
                        self.endpoint=endpoint;break
            self.guard();self.report();time.sleep(1)

    def stop_service(self):
        if self.endpoint is None:return
        self.stage='CONFIRMING_OWNED_NATIVE_GPU_EXIT';self.report(force=True)
        call(self.endpoint,'stop');directory=c.path(c.load(self.run/'SERVICE_CURRENT.json')['session_dir'])
        ack=c.load(directory/'confirmed_cleanup.json');c.need(ack.get('all_owned_services_confirmed_exited') is True,'Service shutdown not confirmed')
        if self.session_process is not None:c.need(self.session_process.wait()==0,'Supervisor nonzero exit')
        else:
            while alive(self.endpoint['owner']):time.sleep(.2)
        for file in self.session_logs:file.close()
        self.session_logs=[];self.session_process=None;self.endpoint=None

    def pressure(self):
        system=c.system_memory();linux=None
        if self.endpoint:
            directory=c.path(c.load(self.run/'SERVICE_CURRENT.json')['session_dir']);path=directory/'liveness.json'
            if path.exists():linux=c.load(path)['physical_memory']
        return system['available']<max(1_000_000_000,system['total']*.025) or (linux is not None and linux['available']<800_000_000)

    def root_preflight(self,directory,sid,fixed,all_files):
        root=next(x for x in self.plan['cells'] if (x['layer'],x['honor'])==(0,0))
        c.need(root['size']>0,'Missing actual nonempty root')
        children=f.target_cells(self.plan,root);names=list(fixed)
        for value in [root]+children:
            names.extend((value['directory'],value['bits']))
            if value.get('legacy_transport_metadata'):names.append(value['legacy_transport_metadata'])
        bid='root_preflight_'+uuid.uuid4().hex
        record=c.once(directory/'buckets'/(bid+'.manifest.json'),dict(schema='V4_READ_LOCKED_INPUT_DIGESTS',files={x:all_files[x] for x in names}))
        opened=call(self.endpoint,'open',layer=0,honor=0,bucket_open_id=bid,manifest=record['path'],manifest_sha256=record['sha256'])
        event=opened['native_event']
        c.need(event.get('event')=='BUCKET_READY' and event.get('layer')==0 and event.get('honor')==0 and
            event.get('size')==root['size'] and event.get('metadataChecked') is True and event.get('targetIdentity') is True and
            event.get('rootChecked') is True and event.get('loaded_target_honors')==sorted(x['honor'] for x in children),
            'Actual early empty-root metadata/identity/P check did not accept')
        closed=call(self.endpoint,'close');last=closed['native_event']
        c.need(last.get('event')=='BUCKET_CLOSED' and last.get('ranges')==[] and last.get('checked_rows')==0 and
            last.get('exactCoverage') is False and last.get('rootChecked') is True,'Root preflight must not claim row/full-bucket acceptance')
        return c.once(directory/'ROOT_PREFLIGHT.json',dict(schema='V17_ACTUAL_ROOT_PREFLIGHT_NO_ROWS_V1',session_id=sid,
            native=f.NATIVE,source_identity=f.source_identity(self.manifest,self.plan,root),
            target_identities={str(x['honor']):f.source_identity(self.manifest,self.plan,x) for x in children},
            opened=opened,closed=closed,actual_game_rows_accepted=0,game_winner_claimed=False,full_root_frame_still_required=True))

    def execute(self):
        self.stage_runtime();self.obtain_service();self.stage='WAIT_ACTUAL_GLOBAL_FINITE_ACCEPTANCE';self.report(force=True)
        native_ready=call(self.endpoint,'global_ready');directory=c.path(c.load(self.run/'SERVICE_CURRENT.json')['session_dir'])
        sid=self.endpoint['session_id'];global_value=dict(session_id=sid,native=f.NATIVE,native_event=native_ready)
        gp=directory/'global_evidence.json'
        if not gp.exists():c.once(gp,global_value)
        c.need(c.load(gp)==global_value,'Existing global evidence differs');global_rec=c.record(gp)
        permission=dict(schema='V17_NEW_NATIVE_ROW_PERMISSION_V1',session_id=sid,native=f.NATIVE,runtime=self.runtime_rec,
            manifest=self.manifest_record,required_controls_passed=True,created_utc=c.utc())
        c.atomic(self.run/'ROW_PERMISSION.json',permission)
        fp=planner();conf=self.plan['config'];work=fp.Work.from_bytes(c.path(conf['index_root']+'/groups.bin').read_bytes(),
             c.path(conf['successor_root']+'/numeric.bin').read_bytes(),c.path(conf['successor_root']+'/honors.bin').read_bytes())
        all_files={**self.inputs,**self.code};fixed_names=[c.rel(p) for p in service.code_paths()]+[
            conf['index_root']+'/numeric.bin',conf['index_root']+'/groups.bin',conf['successor_root']+'/numeric.bin',
            conf['successor_root']+'/honors.bin',conf['catalog_file']]
        fixed={name:all_files[name] for name in fixed_names}
        fixed_rec=c.once(self.invocation/'gpu_fixed_manifest.json',dict(schema='V4_READ_LOCKED_INPUT_DIGESTS',files=fixed))
        call(self.endpoint,'initialize_gpu',manifest=fixed_rec['path'],manifest_sha256=fixed_rec['sha256'])
        self.stage='ACTUAL_EMPTY_ROOT_METADATA_PREFLIGHT_NO_ROWS';self.report(force=True)
        self.root_preflight(directory,sid,fixed,all_files)
        index={(x['layer'],x['honor']):x for x in self.plan['cells']};budget=fp.policy(250000)
        for cell in scheduled_cells(self.plan['cells']):
            self.guard();n,h=cell['layer'],cell['honor'];cursor=self.stats['cursors'].get((n,h),0)
            if not cell['size'] or cursor==cell['size']:continue
            self.current_bucket=c.bucket_key(n,h);self.stage='OPEN_ACTUAL_BUCKET';self.report(force=True)
            bid=uuid.uuid4().hex;children=f.target_cells(self.plan,cell,index)
            names=list(fixed)
            for value in [cell]+children:
                names.extend((value['directory'],value['bits']))
                if value.get('legacy_transport_metadata'):names.append(value['legacy_transport_metadata'])
            bucket_manifest=c.once(directory/'buckets'/(bid+'.manifest.json'),dict(schema='V4_READ_LOCKED_INPUT_DIGESTS',files={x:all_files[x] for x in names}))
            opened=call(self.endpoint,'open',layer=n,honor=h,bucket_open_id=bid,manifest=bucket_manifest['path'],manifest_sha256=bucket_manifest['sha256'])
            open_value=dict(session_id=sid,bucket_open_id=bid,native=f.NATIVE,**opened)
            open_rec=c.once(directory/'buckets'/(bid+'.ready.json'),open_value)
            scanned=[]
            with fp.MappedDirectory(c.path(cell['directory'])) as actual_directory:
                while cursor<cell['size']:
                    self.guard()
                    # Smaller scheduling windows can lower transient memory.
                    # The exact Native checker and twelve logical fragments do
                    # not change; all resulting ranges still require acceptance.
                    if self.pressure():
                        close_reply=call(self.endpoint,'close')
                        c.need(close_reply['native_event'].get('ranges')==scanned,'Pressure close actual ranges differ')
                        c.once(directory/'buckets'/(bid+'.closed.json'),dict(session_id=sid,bucket_open_id=bid,**close_reply))
                        self.stop_service()
                        if self.pool==1 and self.frame_rows==1048576:
                            raise MemoryError('Physical memory pressure persists at minimum execution concurrency; paused with prefix preserved')
                        self.pool={12:8,8:4,4:2,2:1,1:1}[self.pool];self.frame_rows=max(1048576,self.frame_rows//2)
                        reduction=dict(schema='V17_ADAPTIVE_EXECUTION_CONCURRENCY_V1',pool_threads=self.pool,frame_rows=self.frame_rows,
                            unchanged_native=f.NATIVE,unchanged_logical_fragments=12,at_utc=c.utc(),physical_memory=c.system_memory())
                        c.atomic(self.run/'adaptive_execution.json',reduction);c.once(self.invocation/'pressure_reduction.json',reduction)
                        raise AdaptiveRestart('Reduce execution pool and proposal size; recompute actual base checks in a fresh process')
                    frame=next(fp.partition(actual_directory,work,h,cursor,min(cell['size']-cursor,self.frame_rows),cell['size'],budget))
                    start,count=frame['start'],frame['count'];self.current_frame=dict(start=start,count=count)
                    self.stage='ACTUAL_V17_PREPARE_SCAN_ASSEMBLE';self.report()
                    output=directory/'frames'/(self.current_bucket+'_'+str(start)+'_'+uuid.uuid4().hex+'.json')
                    reply=call(self.endpoint,'span',start=start,count=count,output=c.rel(output))
                    actual=c.load(c.checked_record(reply['native_result']));c.need(actual==reply['native_event'],'Native stdout/saved result differs')
                    c.need(actual.get('plan_blocks')==frame['source_blocks'],'Native prepared block count differs from actual directory range')
                    p,nn=source_counts(cell['bits'],start,count);c.need((actual.get('P_rows'),actual.get('N_rows'))==(p,nn),'Actual input bitspan differs from Native accepted P/N counts')
                    receipt=dict(schema=f.FRAME_SCHEMA,status='COMMITTED_NATIVE_V17_FRAME',manifest_sha256=self.manifest_record['sha256'],
                        native=f.NATIVE,input_identity_sha256=self.manifest['input_identity_sha256'],no_old_acceptance_imported=True,
                        layer=n,honor=h,start=start,count=count,P_rows=p,N_rows=nn,source_span_P_rows=p,source_span_N_rows=nn,
                        source_identity=f.source_identity(self.manifest,self.plan,cell),
                        target_identities={str(x['honor']):f.source_identity(self.manifest,self.plan,x) for x in children},
                        session_id=sid,bucket_open_id=bid,global_ready=global_rec,bucket_ready=open_rec,native_result=reply['native_result'],
                        GPU_proposal=reply['proposal'],frame_proposal=frame,complete_helper_wall_seconds=reply['complete_helper_wall_seconds'],
                        acceptances=dict(base=True,successors=True,metadata=True,frames=True,target_identity=True,root_P=(n==0 and h==0)))
                    f.validate_frame(receipt,self.manifest,self.manifest_record['sha256'],self.plan,cell,f.disk_reader(),index)
                    record=c.once(self.run/'frame_receipts'/(self.current_bucket+'_'+str(start)+'_'+str(count)+'_'+uuid.uuid4().hex+'.json'),receipt)
                    self.journal.append((n,h,start,count),record);cursor+=count;scanned.append([start,count])
                    self.stats['cursors'][n,h]=cursor;self.stats['committed_frames']+=1;self.stats['committed_rows']+=count
                    self.stats['P_rows']+=p;self.stats['N_rows']+=nn
                    if cursor==cell['size']:self.stats['complete_nonempty_buckets']+=1
                    c.atomic(self.run/'checkpoint.json',dict(schema='V17_ATOMIC_FRAME_CHECKPOINT_V1',manifest=self.manifest_record,
                        native=f.NATIVE,input_identity_sha256=self.manifest['input_identity_sha256'],ledger_head=self.journal.head,
                        committed_frames=self.stats['committed_frames'],committed_rows=self.stats['committed_rows'],
                        bucket=self.current_bucket,next_row=cursor,updated_utc=c.utc()))
                    self.report(force=self.stats['committed_frames']==1)
            closed=call(self.endpoint,'close');event=closed['native_event']
            c.need(event.get('ranges')==scanned and event.get('checked_rows')==sum(x[1] for x in scanned),'Native current-process closed ranges differ')
            c.once(directory/'buckets'/(bid+'.closed.json'),dict(session_id=sid,bucket_open_id=bid,**closed))
            self.current_frame=None
        self.current_bucket=None;self.stop_service()
        self.stage='FINAL_CURRENT_INPUT_SHA';self.report(force=True);after={}
        for name in sorted(self.inputs):self.guard();after[name]=c.sha_file(name,self.guard);self.report()
        c.need(after==self.inputs,'Current post-run inputs differ from immutable before identity')
        after_record=c.once(self.invocation/'inputs_after.json',dict(schema='V17_ACTUAL_POST_INPUT_IDENTITIES_V1',files=after,
            input_count=len(after),input_bytes=sum(x['bytes'] for x in after.values()),verified_utc=c.utc()))
        c.atomic(self.run/'INPUTS_AFTER.json',dict(identity_record=after_record))
        sessions=[];session_ids=[]
        for folder in sorted((self.run/'sessions').iterdir()):
            if not folder.is_dir():continue
            candidates=[folder/'confirmed_cleanup.json',folder/'aborted_cleanup.json']+sorted(folder.glob('*recovery_*.json'))+sorted(folder.glob('recovered_cleanup_*.json'))
            candidates=[p for p in candidates if p.exists()]
            c.need(candidates,'An owned session has no cleanup evidence: '+folder.name)
            sessions.append(c.record(candidates[0]));session_ids.append(folder.name)
        cleanup=dict(schema='V17_ALL_OWNED_SERVICES_CONFIRMED_EXITED_V1',all_owned_services_confirmed_exited=True,
            sessions=sessions,all_session_ids=session_ids,confirmed_utc=c.utc())
        f.verify_completion(self.manifest,self.plan,self.journal.entries,c.load(c.path(after_record['path'])),cleanup,f.disk_reader())
        c.atomic(self.run/'services_final_cleanup.json',cleanup)
        self.stage='FINAL_EXACT_ALL35_COVERAGE';self.report(force=True)
        final=f.verify_entries(self.manifest,self.manifest_record['sha256'],self.plan,self.journal.entries,f.disk_reader(),complete=True)
        final.pop('cursors');final.update(schema='V17_EXTERNAL_EXECUTION_COVERAGE_REPORT_V1',status='COMPLETE_FIXED_V17_NATIVE_COMPUTATION',
            manifest=self.manifest_record,ledger=c.record(self.journal.file),post_input_identities_verified=True,
            all_owned_services_confirmed_exited=True,six_acceptance_families_complete=True,
            claim_class='FIXED_V17_KERNEL_IMPLICATION_PLUS_NATIVE_COMPUTATION',closed_actual_input_Lean_declaration=False,
            old_PASS_or_seed_imported=False,completed_utc=c.utc())
        c.once(self.run/'FINAL.json',final);self.status='COMPLETE';self.stage='COMPLETE';self.report(force=True)

    def cleanup(self):
        # Keep source locks while a supervisor might still own a Linux child.
        # If cleanup cannot be confirmed, this guardian deliberately stays live.
        if self.endpoint is None and self.session_process is not None:
            # A STOP/error can arrive between Popen and endpoint publication.
            # The child retains its own custody; wait for its exact endpoint or
            # confirmed exit, rather than abandoning a just-started service.
            while self.session_process.poll() is None:
                current=self.run/'SERVICE_CURRENT.json'
                if current.exists():
                    value=c.load(current);p=c.path(value['session_dir'])/'endpoint.json'
                    if value['owner']['pid']==self.session_process.pid and p.exists():self.endpoint=c.load(p);break
                self.stage='CLEANUP_WAIT_SUPERVISOR_BOOT_OR_EXIT'
                try:self.report()
                except BaseException as error:print('Cleanup report diagnostic: '+repr(error),file=sys.stderr,flush=True)
                time.sleep(1)
        if self.endpoint is not None:
            errors=0
            while True:
                try:
                    call(self.endpoint,'abort');self.endpoint=None;break
                except BaseException as error:
                    errors+=1;self.error='Cleanup attempt '+str(errors)+': '+repr(error);self.stage='PAUSED_CLEANUP_GUARDIAN'
                    try:
                        if not alive(self.endpoint['owner']):
                            directory=c.path(c.load(self.run/'SERVICE_CURRENT.json')['session_dir'])
                            recovery=subprocess.run(['wsl.exe','--exec','/usr/bin/python3','-B',service.wsl(c.BASE/'recover.py'),service.wsl(directory/'linux_scope.json')],
                                capture_output=True,text=True,creationflags=getattr(subprocess,'CREATE_NO_WINDOW',0))
                            c.need(recovery.returncode==0,'Dead-owner Linux scope recovery unconfirmed: '+recovery.stdout+recovery.stderr)
                            c.once(directory/('controller_recovery_'+uuid.uuid4().hex+'.json'),json.loads(recovery.stdout))
                            self.endpoint=None;break
                        self.report(force=(errors==1))
                    except BaseException as log_error:print('Guardian log error: '+repr(log_error),file=sys.stderr,flush=True)
                    time.sleep(5)
        for file in self.session_logs:file.close()
        if getattr(self,'runtime_lock',None):self.runtime_lock.close()
        if getattr(self,'hash_record_lock',None):self.hash_record_lock.close()
        if self.locks:self.locks.close()

def main():
    a=argparse.ArgumentParser();a.add_argument('--run',required=True);v=a.parse_args();run=c.owned(v.run)
    with c.OwnerLock(run/'controller_owner.lock'):
        while True:
            activity=Activity(run)
            def reporter(current=activity):
                while not current.stop_reporter.wait(30):
                    try:current.report()
                    except BaseException as error:print('Progress diagnostic: '+repr(error),file=sys.stderr,flush=True)
            threading.Thread(target=reporter,daemon=True).start()
            try:activity.execute();return 0
            except AdaptiveRestart as error:
                activity.error=str(error);activity.stage='ADAPTIVE_RESTART_SAME_CHECKER';activity.report(force=True)
            except BaseException as error:
                activity.error=repr(error);activity.status='PAUSED_ERROR_NO_UNCHECKED_PROGRESS_COMMITTED';activity.stage='PAUSED_ERROR'
                c.atomic(activity.invocation/'failure.json',dict(error=repr(error),traceback=traceback.format_exc(),at_utc=c.utc(),
                    committed_frames=activity.stats['committed_frames'],committed_rows=activity.stats['committed_rows']))
                activity.report(force=True);raise
            finally:
                activity.stop_reporter.set();activity.cleanup()

if __name__=='__main__':raise SystemExit(main())
