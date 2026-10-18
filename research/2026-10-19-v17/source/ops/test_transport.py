"""Small actual-Python-body controls; no Native, WSL, CUDA or large reads."""
import argparse,ast,copy,ctypes,io,queue,sys,types,uuid
from pathlib import Path
import common as c
import fused_worker as worker
import service
import controller
import rules_v17 as rules

def main():
    out=c.RUNS/('transport_controls_'+uuid.uuid4().hex[:12]);out.mkdir(parents=True);tests=[]
    def yes(name,fn):fn();tests.append(dict(name=name,status='PASS'))
    def no(name,fn):
        try:fn()
        except (ValueError,EOFError,FileNotFoundError) as error:tests.append(dict(name=name,status='PASS_REJECTED',error=repr(error)));return
        raise AssertionError('Accepted invalid fixture: '+name)
    def ready(events,name):
        host=worker.Host.__new__(worker.Host);host.global_ready=None;host.session=out/name;host.session.mkdir()
        host.lines=queue.Queue()
        for event in events:host.lines.put(event)
        return host.ready()
    base=dict(event='BASE_CHECKED',baseChecked=True,successorsChecked=True)
    global_event=dict(event='GLOBAL_READY',baseChecked=True,successorsChecked=True,layers=35,honors=184)
    yes('actual_Host_ready_consumes_BASE_then_GLOBAL',lambda:c.need(ready([base,global_event],'good')==global_event,'Wrong sequence'))
    no('GLOBAL_without_actual_BASE_rejects',lambda:ready([global_event],'missing_base'))
    no('false_base_rejects',lambda:ready([dict(base,baseChecked=False),global_event],'false_base'))
    no('Native_EOF_does_not_mean_acceptance',lambda:ready([EOFError('fixture EOF')],'eof'))
    # Execute the actual main bytecode against a constructor that allocates a
    # stand-in child then raises. This catches assignment-after-init leaks.
    counter=dict(cleanups=0,started=0)
    class BrokenHost:
        def __init__(self,*args):
            counter['started']+=1;self.native=object();self.done=object();raise RuntimeError('synthetic post-Popen initialization failure')
        def cleanup(self):counter['cleanups']+=1
    signals=types.SimpleNamespace(SIGTERM=15,SIGINT=2,SIG_IGN=object(),signal=lambda *a:None)
    environment=dict(worker.main.__globals__,Host=BrokenHost,signal=signals,
        sys=types.SimpleNamespace(platform='linux',argv=['fixture','fixture']),emit=lambda value:None)
    actual_main=types.FunctionType(worker.main.__code__,environment)
    yes('actual_Host_constructor_exception_finally_retains_owner',lambda:c.need(actual_main()==1 and counter==dict(cleanups=1,started=1),'Constructor cleanup missed'))
    # The Windows supervisor has the same ownership issue at a different
    # process boundary; execute its actual main body with OS operations stubbed.
    counts=dict(cleanups=0)
    class Lock:
        def __init__(self,*a):pass
        def __enter__(self):return self
        def __exit__(self,*a):pass
    class Parser:
        def add_argument(self,*a,**k):pass
        def parse_args(self):return types.SimpleNamespace(run='fixture',native='fixture',native_sha256='a'*64,pool_threads=12)
    class BrokenSupervisor:
        def __init__(self,*a):self.child=object();self.failure=None;raise RuntimeError('synthetic supervisor post-Popen failure')
        def cleanup(self):counts['cleanups']+=1
    small_c=types.SimpleNamespace(need=c.need,sha_file=lambda p:dict(sha256='a'*64),owned=lambda p:Path('fixture'),OwnerLock=Lock)
    environment=dict(service.main.__globals__,c=small_c,Supervisor=BrokenSupervisor,
        argparse=types.SimpleNamespace(ArgumentParser=Parser),os=types.SimpleNamespace(name='nt'))
    def bad_supervisor():
        try:types.FunctionType(service.main.__code__,environment)()
        except RuntimeError:pass
        c.need(counts['cleanups']==1,'Supervisor constructor cleanup missed')
    yes('actual_Supervisor_constructor_exception_finally_retains_owner',bad_supervisor)
    # The row gate is inside the actual RPC method, before any child write.
    request_dir=out/'row_gate';request_dir.mkdir();owner=service.Supervisor.__new__(service.Supervisor)
    owner.run=request_dir;owner.native=dict(path='fixture',bytes=1,sha256='a'*64);owner.sid='fixture'
    owner.op_lock=__import__('threading').Lock();owner.requests=0;owner.child=types.SimpleNamespace(poll=lambda:None)
    no('missing_ROW_PERMISSION_rejects_before_GPU',lambda:owner.rpc(dict(op='initialize_gpu')))
    c.atomic(request_dir/'ROW_PERMISSION.json',dict(native=owner.native,session_id='other',required_controls_passed=True))
    no('wrong_session_ROW_PERMISSION_rejects',lambda:owner.rpc(dict(op='span')))
    # Execute the actual early-root IO method with only its RPC boundary mocked.
    # It must save metadata/P diagnostics while accepting exactly zero rows.
    plan=c.load(c.RUNS/'full_native_20261018_01/PLAN.json')
    pointer=c.load(c.RUNS/'full_native_20261018_01/INPUTS_BEFORE.json');before=c.load(c.checked_record(pointer['identity_record']))
    root=next(x for x in plan['cells'] if (x['layer'],x['honor'])==(0,0));children=controller.f.target_cells(plan,root)
    toy=types.SimpleNamespace(plan=plan,manifest=dict(inputs_before=before['files']),endpoint=None)
    def root_rpc(endpoint,op,**fields):
        if op=='open':return dict(native_event=dict(event='BUCKET_READY',layer=0,honor=0,size=root['size'],metadataChecked=True,
            targetIdentity=True,rootChecked=True,loaded_target_honors=sorted(x['honor'] for x in children)))
        c.need(op=='close','Root preflight attempted a row span')
        return dict(native_event=dict(event='BUCKET_CLOSED',ranges=[],checked_rows=0,exactCoverage=False,rootChecked=True))
    environment=dict(controller.Activity.root_preflight.__globals__,call=root_rpc)
    method=types.FunctionType(controller.Activity.root_preflight.__code__,environment)
    def root_good():
        rec=method(toy,out/'root_good','fixture',{},before['files']);value=c.load(c.path(rec['path']))
        c.need(value['actual_game_rows_accepted']==0 and value['game_winner_claimed'] is False and
               value['full_root_frame_still_required'] is True,'Early root preflight claimed a completed game')
    yes('actual_root_preflight_body_accepts_zero_rows_only',root_good)
    def root_bad(endpoint,op,**fields):
        value=root_rpc(endpoint,op,**fields)
        if op=='open':value['native_event']['rootChecked']=False
        return value
    environment=dict(controller.Activity.root_preflight.__globals__,call=root_bad)
    no('actual_root_preflight_body_rejects_false_root',lambda:types.FunctionType(controller.Activity.root_preflight.__code__,environment)(toy,out/'root_bad','fixture',{},before['files']))
    # Simulate a killed prior controller with a still-live, already-used
    # service. Execute both actual recovery methods: no second GPU initialize,
    # bucket open or row request may reach that old session.
    def recovery_fixture(name,*,bad_endpoint=None,bad_state=False,bad_cleanup=False,launch=False):
        activity=out/name;directory=activity/'sessions'/('a'*32);directory.mkdir(parents=True)
        invocation=activity/'invocation';invocation.mkdir()
        old_owner=dict(pid=111,creation_time=1.25);new_owner=dict(pid=222,creation_time=2.5)
        prior=dict(session_id='a'*32,session_dir=c.rel(directory),owner=old_owner)
        endpoint=dict(schema='V17_LOCAL_SERVICE_ENDPOINT_V1',host='127.0.0.1',port=12345,token='b'*64,
            session_id=prior['session_id'],owner=old_owner,native=controller.f.NATIVE)
        if bad_endpoint:endpoint.update(bad_endpoint)
        c.atomic(directory/'endpoint.json',endpoint);c.atomic(activity/'SERVICE_CURRENT.json',prior)
        events=[];live={111:True,222:True}
        item=types.SimpleNamespace(run=activity,invocation=invocation,endpoint=None,pool=12,
            report=lambda **kw:None,guard=lambda:None,session_process=None,session_logs=[])
        def rpc(ep,op,**fields):
            events.append(op);c.need(ep==endpoint,'Unexpected endpoint during old-session recovery')
            if op=='status':return dict(owner=new_owner if bad_state else old_owner,session_id=prior['session_id'],native=controller.f.NATIVE)
            c.need(op=='abort','A new invocation reused an old Native/GPU session')
            cleanup=dict(all_owned_services_confirmed_exited=not bad_cleanup,session_id=prior['session_id'],native=controller.f.NATIVE)
            c.atomic(directory/'aborted_cleanup.json',cleanup);live[111]=False;return cleanup
        environment=dict(controller.Activity.retire_prior_service.__globals__,call=rpc,alive=lambda owner:live[owner['pid']])
        retire=types.FunctionType(controller.Activity.retire_prior_service.__code__,environment)
        item.retire_prior_service=lambda value:retire(item,value)
        if not launch:
            retire(item,prior)
            c.need(events==['status','abort'] and item.endpoint is None and not live[111],
                'Old live service was reused or not reaped')
            return
        def popen(*args,**kwargs):
            c.need(not live[111] and events==['status','abort'],'Fresh service started before old service exit')
            events.append('Popen');new_dir=activity/'sessions'/('c'*32);new_dir.mkdir()
            new_value=dict(session_id='c'*32,session_dir=c.rel(new_dir),owner=new_owner)
            new_endpoint=dict(endpoint,session_id='c'*32,owner=new_owner,token='d'*64)
            c.atomic(new_dir/'endpoint.json',new_endpoint);c.atomic(activity/'SERVICE_CURRENT.json',new_value)
            return types.SimpleNamespace(pid=222,poll=lambda:None)
        def forbidden_run(*a,**k):raise AssertionError('Unexpected WSL recovery in pure fixture')
        environment=dict(controller.Activity.obtain_service.__globals__,call=rpc,alive=lambda owner:live[owner['pid']],
            subprocess=types.SimpleNamespace(Popen=popen,run=forbidden_run,CREATE_NO_WINDOW=0))
        try:types.FunctionType(controller.Activity.obtain_service.__code__,environment)(item)
        finally:
            for file in item.session_logs:file.close()
        c.need(events==['status','abort','Popen'] and item.endpoint['owner']==new_owner,
            'Fresh service did not follow exact old-owner abort/reap')
    yes('actual_killed_controller_live_service_is_aborted_and_reaped',lambda:recovery_fixture('old_live'))
    yes('actual_resume_launches_fresh_service_only_after_prior_exit',lambda:recovery_fixture('fresh_after_reap',launch=True))
    no('prior_endpoint_wrong_owner_rejects_before_abort',lambda:recovery_fixture('wrong_owner',bad_endpoint=dict(owner=dict(pid=999,creation_time=1.25))))
    no('prior_endpoint_wrong_native_rejects_before_abort',lambda:recovery_fixture('wrong_native',bad_endpoint=dict(native={})))
    no('prior_live_status_wrong_owner_rejects_before_abort',lambda:recovery_fixture('wrong_status',bad_state=True))
    no('prior_abort_without_actual_empty_confirmation_rejects',lambda:recovery_fixture('false_cleanup',bad_cleanup=True))
    # The V17 resource adapter must preserve the exact frozen ready/proposal
    # code, and only the two historical host-cap constants in resources differ.
    legacy={};legacy_path=c.path(rules.LEGACY_RULES_PATH);legacy_raw=legacy_path.read_bytes()
    exec(compile(legacy_raw,str(legacy_path),'exec'),legacy)
    def adapter_code():
        for name in ('ready','proposal'):
            c.need(getattr(rules,name).__code__.co_code==legacy[name].__code__.co_code and
                getattr(rules,name).__code__.co_consts==legacy[name].__code__.co_consts,'Frozen receipt body differs')
            c.need(getattr(rules,name).__globals__['resources'] is rules.resources,'Receipt did not call new host resource policy')
        old=next(x for x in ast.parse(legacy_raw).body if isinstance(x,ast.FunctionDef) and x.name=='resources')
        new=next(x for x in ast.parse((c.BASE/'rules_v17.py').read_bytes()).body if isinstance(x,ast.FunctionDef) and x.name=='resources')
        class HostOnly(ast.NodeTransformer):
            def visit_Constant(self,node):
                return ast.copy_location(ast.Name(id='HOST_RSS_CAP_BYTES',ctx=ast.Load()),node) if type(node.value) is int and node.value==3000000000 else node
        c.need(ast.dump(HostOnly().visit(old))==ast.dump(new),'Non-host resource rule changed')
    yes('adapter_preserves_frozen_ready_proposal_and_all_nonhost_resources_AST',adapter_code)
    cap=67108864;scratch=8388608
    resource=dict(implementation_revision=rules.REVISION,scratch_rows=scratch,device_output_scratch_bytes=scratch,
        maximum_proposal_rows=cap,transport=rules.TRANSPORT,record_bytes=1,device_cap_bytes=6000000000,
        global_device_cap_bytes=7000000000,global_device_free_reserve_bytes=1000000000,
        host_rss_cap_bytes=sys.maxsize,allocated_device_bytes=rules.FIXED_COMMON_DEVICE_BYTES+scratch,
        peak_host_rss_bytes=4000000000,global_device_used_bytes=2000000000)
    fixed=dict(schema='UNTRUSTED_FIXED_INDEXED_BYTE_CUDA_CONTEXT_V16',implementation_revision=rules.REVISION,
        scratch_rows=scratch,device_output_scratch_bytes=scratch,maximum_host_proposal_bytes=cap,max_count=cap,
        record_bytes=1,transport=rules.TRANSPORT,fixed_device_bytes=rules.FIXED_COMMON_DEVICE_BYTES+scratch,
        indexed_byte_layout=copy.deepcopy(rules.LAYOUT),original_evaluate_source_sha256=rules.ORIGINAL_EVALUATE_SOURCE_SHA256,
        combined_source_sha256=rules.KERNEL_SOURCE_SHA256)
    gpu_ready=dict(event='SESSION_READY',schema=rules.PROTOCOL,max_count=cap,implementation_revision=rules.REVISION,
        transport=rules.TRANSPORT,record_bytes=1,scratch_rows=scratch,device_output_scratch_bytes=scratch,
        resources=resource,fixed_identity=fixed,Lean_rows_verified=0)
    def unchanged_ready():
        prior=copy.deepcopy(gpu_ready);rules.ready(gpu_ready,cap)
        c.need(gpu_ready==prior and gpu_ready['resources']['peak_host_rss_bytes']==4000000000,'Actual host RSS was rewritten or clipped')
    yes('authorized_host_policy_accepts_true_RSS_above_legacy_3GB_without_mutation',unchanged_ready)
    no('legacy_ready_reproduces_actual_policy_mismatch',lambda:legacy['ready'](gpu_ready,cap))
    for key,value in (('host_rss_cap_bytes',3000000000),('allocated_device_bytes',6000000001),
            ('global_device_used_bytes',7000000001),('global_device_free_reserve_bytes',0),
            ('peak_host_rss_bytes',-1),('scratch_rows',scratch+1),('record_bytes',8)):
        wrong=copy.deepcopy(gpu_ready);wrong['resources'][key]=value
        no('new_host_adapter_still_rejects_'+key,lambda wrong=wrong:rules.ready(wrong,cap))
    wrong=copy.deepcopy(gpu_ready);wrong['fixed_identity']['combined_source_sha256']='0'*64
    no('new_host_adapter_still_rejects_wrong_CUDA_source_identity',lambda:rules.ready(wrong,cap))
    def proposal(count=56,start=0):
        chunks=[]
        for offset in range(0,count,scratch):
            take=min(scratch,count-offset);chunks.append(dict(start=start+offset,count=take,host_row_offset=offset,
                host_byte_offset=offset,compact_bytes=take,indexed_bytes=take,kernel_seconds=.001,
                copy_seconds=.002,enclosing_chunk_wall_seconds=.003))
        return dict(schema='UNTRUSTED_CROSS_BUCKET_INDEXED_BYTE_PROPOSAL_V16',status='STREAMED_NOT_LEAN_CERTIFIED',
            implementation_revision=rules.REVISION,start=start,count=count,scratch_rows=scratch,device_output_scratch_bytes=scratch,
            compact_bytes=count,indexed_bytes=count,record_bytes=1,transport=rules.TRANSPORT,mode=1,source_coordinates_transmitted=False,
            native_actual_next_membership_required=True,native_actual_source_r_guard_required=True,gpu_flags_trusted=False,
            per_row_timing_or_sampling_added=False,GPU_trusted_for_soundness=False,Lean_rows_verified=0,resources=copy.deepcopy(resource),
            actual_chunk_count=len(chunks),chunks=chunks,combined_kernel_seconds=len(chunks)*.001,copy_seconds=len(chunks)*.002,
            copy_timing_policy='SUM_CHUNK_DTOH_AND_GUARD_WALL_HOST_ALLOCATION_SEPARATE',host_output_buffer_allocations=1,
            intermediate_chunk_host_buffers=0,proposal_work_seconds=1.,host_allocation_seconds=.001)
    yes('unchanged_proposal_validator_covers_all_eight_64Mi_frame_chunks',lambda:rules.proposal(proposal(cap),0,cap,cap))
    wrong=proposal(cap);wrong['chunks'][1]['host_byte_offset']+=1
    no('new_host_adapter_rejects_chunk_overlap',lambda:rules.proposal(wrong,0,cap,cap))
    wrong=proposal();wrong['compact_bytes']+=1
    no('new_host_adapter_rejects_wrong_1B_packet_extent',lambda:rules.proposal(wrong,0,56,cap))
    # Execute the actual GPU initialization body with an untrusted producer
    # stand-in. No device is opened; this verifies identical policy plumbing.
    gpu_dir=out/'actual_initialize_method';gpu_dir.mkdir();manifest=c.once(gpu_dir/'manifest.json',dict(files={}))
    owner=worker.Host.__new__(worker.Host);owner.run=gpu_dir;owner.session=gpu_dir;owner.gpu=None;owner.rules=rules
    owner.config=dict(input_config={k:c.rel(gpu_dir) for k in ('index_root','catalog_file','data_root','successor_root')})
    owner.ready=lambda:None;calls=[];producer=types.SimpleNamespace(old=types.SimpleNamespace(HOST_CAP=3000000000))
    def configuration(**kwargs):
        c.need(kwargs['host_rss_cap_bytes']==producer.old.HOST_CAP==rules.HOST_RSS_CAP_BYTES and
            kwargs['max_count']==cap,'Actual GPU configuration retained a legacy host cap')
        calls.append('configuration');return kwargs
    def context(args):calls.append('SessionContext');return types.SimpleNamespace(ready=lambda:copy.deepcopy(gpu_ready),
        close=lambda **kwargs:dict(GPU_context_closed=True))
    producer.configuration=configuration;producer.SessionContext=context
    environment=dict(worker.create_gpu_context.__globals__,import_exact=lambda name,path,sha:producer)
    create_actual=types.FunctionType(worker.create_gpu_context.__code__,environment)
    initialize=types.FunctionType(worker.Host.initialize_gpu.__code__,dict(worker.Host.initialize_gpu.__globals__,create_gpu_context=create_actual))
    yes('actual_initialize_gpu_method_uses_same_authorized_host_policy_as_validator',lambda:c.need(
        initialize(owner,dict(manifest=manifest['path'],manifest_sha256=manifest['sha256']))==gpu_ready and
        calls==['configuration','SessionContext'],'Actual GPU initialization body failed'))
    def bad_constructed_context():
        directory=out/'rejected_constructed_gpu';directory.mkdir();closed=[]
        bad_ready=copy.deepcopy(gpu_ready);bad_ready['fixed_identity']['combined_source_sha256']='0'*64
        def close(**kwargs):closed.append(kwargs);return dict(GPU_context_closed=True)
        producer.SessionContext=lambda args:types.SimpleNamespace(ready=lambda:bad_ready,close=close)
        try:create_actual(directory,directory,owner.config['input_config'],manifest['path'],manifest['sha256'],rules)
        except ValueError:
            c.need(closed==[dict(reason='V17_GPU_SETUP_REJECTED',failed=True)],'Rejected actual ready leaked its constructed GPU context')
            c.need(not (directory/'gpu_ready.json').exists(),'Rejected GPU context was recorded as accepted');return
        raise AssertionError('Bad constructed GPU identity accepted')
    yes('actual_shared_GPU_creation_closes_context_when_full_ready_validator_rejects',bad_constructed_context)
    def mock_span(name,bad=False):
        host=worker.Host.__new__(worker.Host);host.active=True;host.session=out/name;host.session.mkdir();host.rules=rules
        meta=proposal();payload=ctypes.create_string_buffer(bytes(range(56)),56)
        if bad:meta['resources']['host_rss_cap_bytes']=3000000000
        host.gpu=types.SimpleNamespace(propose=lambda start,count:(payload,meta));writes=[];stream=io.BytesIO()
        host.native=types.SimpleNamespace(pid=999,stdin=stream)
        native=dict(event='FRAME_RESULT',frameAccepted=True,start=0,count=56)
        output=host.session/'result.json'
        def send(command):writes.append(command);c.atomic(output,native)
        host.send=send;host.take=lambda event:native
        environment=dict(worker.Host.span.__globals__,proc=lambda pid:dict(pid=pid),
            os=types.SimpleNamespace(fsync=lambda fd:None))
        method=types.FunctionType(worker.Host.span.__code__,environment)
        try:reply=method(host,dict(start=0,count=56,output=c.rel(output)))
        except ValueError:
            c.need(not writes and not stream.getvalue(),'Invalid GPU policy reached the Native packet pipe');raise
        c.need(len(writes)==1 and stream.getvalue()==bytes(range(56))+c.END and reply['native_event']==native,
            'Actual span body changed 1B payload/footer or skipped the receipt checks')
    yes('actual_span_body_keeps_1B_payload_and_footer_with_new_resource_adapter',lambda:mock_span('new_policy_span'))
    no('actual_span_body_rejects_wrong_host_policy_before_any_Native_pipe_write',lambda:mock_span('wrong_policy_span',True))
    def schedule():
        ordered=controller.scheduled_cells(plan['cells']);first=ordered[0]
        c.need((first['layer'],first['honor'],first['size'])==(32,89,56),'Real mixed P/N first production bucket differs')
        c.need(len(ordered)==6440 and len({(x['layer'],x['honor']) for x in ordered})==6440 and
            ordered[1:]==sorted([x for x in plan['cells'] if (x['layer'],x['honor'])!=(32,89)],key=lambda x:(-x['layer'],x['honor'])),
            'First-bucket schedule duplicates, omits or otherwise changes the full35 inventory')
        cursor={(32,89):56}
        remaining=[x for x in ordered if x['size'] and cursor.get((x['layer'],x['honor']),0)<x['size']]
        c.need(all((x['layer'],x['honor'])!=(32,89) for x in remaining) and
            remaining==sorted(remaining,key=lambda x:(-x['layer'],x['honor'])) and
            sum(x['size'] for x in remaining)+56==plan['total_rows'],'Resumed first bucket repeats or loses rows')
        c.need('scheduled_cells' in controller.Activity.execute.__code__.co_names,'Actual execute does not use this tested schedule')
    yes('actual_production_schedule_checks_56_rows_first_then_all35_exact_once_and_resumes',schedule)
    # Every included file parses. This is no claim that a parsed file has passed
    # a real Native test; those six cases are a separate mandatory prerequisite.
    for path in c.BASE.glob('*.py'):ast.parse(path.read_text(encoding='utf-8'),filename=str(path))
    tests.append(dict(name='all_ops_python_AST',status='PASS'))
    report=dict(schema='V17_TRANSPORT_ACTUAL_BODY_PURE_CONTROLS_V1',status='PASS_PURE_MOCK_CONTROLS_ONLY',tests=tests,
        source_binding={c.rel(p):c.sha_file(p) for p in [c.BASE/'fused_worker.py',c.BASE/'service.py',c.BASE/'recover.py',c.BASE/'controller.py',c.BASE/'rules_v17.py',c.BASE/'test_transport.py']},
        Native_processes_started=0,GPU_processes_started=0,WSL_processes_started=0,actual_game_rows_accepted=0)
    print(c.canonical(c.once(out/'controls.json',report)).decode())

if __name__=='__main__':main()
