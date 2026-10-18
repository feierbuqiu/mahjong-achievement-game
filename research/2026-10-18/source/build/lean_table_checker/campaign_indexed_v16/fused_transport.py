"""Small RPC adapter; every compact payload byte stays inside the Linux scope.

The bridge never commits a frame. This adapter returns only the actual worker
result/proposal metadata; the caller still performs packed/source comparison,
P/N counts, fsync, exact coverage and the full target-certificate gate.
"""
from pathlib import Path
import ctypes,hashlib,importlib.util,json,re,subprocess,threading,time,types,uuid
import campaign_io as c
import cache_transport as cached
from span_policy import EpochTracker,bank_class_from_locked_files
import production_metrics as metrics
import indexed_runtime as indexed
from compact_transport import linux,expected

BRIDGE=c.ROOT/"build/lean_table_checker/linux_bridge_indexed_v16"
CLIENT=BRIDGE/"windows_client.py"
REMOVED_SCOPES={}
SCRATCH_RULES="build/lean_table_checker/gpu_indexed_byte_receipt_v16/rules.py"
SCRATCH_RULES_IDENTITY=dict(bytes=7584,sha256="9160915678016c51c74c87d1cb28cb9a1b5c9c14cfeaf094973d755ba0268f2a")


def scratch_rules(m):
    expected(m["code_binding"].get(SCRATCH_RULES,{}),SCRATCH_RULES_IDENTITY,"Unbound scratch receipt validator")
    raw=c.rootpath(SCRATCH_RULES).read_bytes()
    if len(raw)!=SCRATCH_RULES_IDENTITY["bytes"] or hashlib.sha256(raw).hexdigest()!=SCRATCH_RULES_IDENTITY["sha256"]:
        raise ValueError("Scratch receipt validator changed under code custody")
    api=types.ModuleType("_exact_bounded_scratch_provenance_v15")
    exec(compile(raw,str(c.rootpath(SCRATCH_RULES)),"exec"),api.__dict__)
    return api

def module():
    spec=importlib.util.spec_from_file_location("_bound_fused_client_v12_generated",CLIENT)
    api=importlib.util.module_from_spec(spec);spec.loader.exec_module(api);return api

def owner_is_dead(owner):
    """Exact Windows PID/creation FILETIME, including exited retained handles."""
    if type(owner.get("pid")) is not int or owner["pid"]<=0 or type(owner.get("creation_time_100ns")) is not int or owner["creation_time_100ns"]<=0:raise ValueError("Unknown Windows scope owner identity")
    k=ctypes.WinDLL("kernel32",use_last_error=True)
    k.OpenProcess.argtypes=[ctypes.c_ulong,ctypes.c_int,ctypes.c_ulong];k.OpenProcess.restype=ctypes.c_void_p
    k.GetProcessTimes.argtypes=[ctypes.c_void_p]+[ctypes.POINTER(ctypes.c_uint64)]*4;k.GetProcessTimes.restype=ctypes.c_int
    k.GetExitCodeProcess.argtypes=[ctypes.c_void_p,ctypes.POINTER(ctypes.c_ulong)];k.GetExitCodeProcess.restype=ctypes.c_int
    k.CloseHandle.argtypes=[ctypes.c_void_p]
    handle=k.OpenProcess(0x1000,0,owner["pid"])
    if not handle:
        error=ctypes.get_last_error()
        if error==87:return True
        raise ctypes.WinError(error)
    try:
        born,exited,kernel,user=[ctypes.c_uint64() for _ in range(4)];code=ctypes.c_ulong()
        if not k.GetProcessTimes(handle,ctypes.byref(born),ctypes.byref(exited),ctypes.byref(kernel),ctypes.byref(user)) or not k.GetExitCodeProcess(handle,ctypes.byref(code)):raise ctypes.WinError(ctypes.get_last_error())
        return born.value!=owner["creation_time_100ns"] or code.value!=259
    finally:k.CloseHandle(handle)

def cleanup_scopes(folder,m):
    """Recover only a durable scope intent for this exact campaign/ELF.

    A leaf without its post-create acknowledgement is never force-killed:
    creation must leave it empty before native/bridge launch is permitted.
    """
    results=[]
    def helper(script,args):
        # A damaged unrelated proof asset must not prevent safe recovery, but
        # never execute a changed privileged recovery helper on that account.
        for name in {script,"cgroup_scope.py"}:
            path=BRIDGE/name;binding=m["code_binding"].get(c.rel(path))
            if binding is None:raise ValueError("Orphan cleanup helper is not bound by the campaign")
            c.check_fingerprint(path,binding)
        p=subprocess.run(["wsl.exe","-d","Ubuntu","-u","root","--","python3","-B",linux(BRIDGE/script),*args],
            cwd=c.ROOT,capture_output=True,text=True,encoding="utf-8",timeout=25,creationflags=subprocess.CREATE_NO_WINDOW)
        if p.returncode:raise RuntimeError(dict(helper=script,stdout=p.stdout,stderr=p.stderr,returncode=p.returncode))
        return json.loads(p.stdout)
    for path in sorted((folder/"sessions").glob("*.scope.json")):
        value=c.read(path);name=value.get("scope","")
        if value.get("schema")!="DURABLE_FUSED_SCOPE_INTENT_V6" or not re.fullmatch("mahjong-lean-v6-[0-9a-f]{32}",name):raise ValueError("Unknown durable Linux owner intent")
        intent_sha=c.sha(path);cache=(str(path),intent_sha)
        if cache in REMOVED_SCOPES:results.append(REMOVED_SCOPES[cache]);continue
        descriptor=Path(str(path)[:-len(".scope.json")]+".config.json")
        config_ok=False;config_error=None
        try:
            config=c.read(descriptor)
            config_ok=value.get("config_sha256")==c.sha(descriptor) and config.get("native")==m["worker"]["executable"] and config.get("native_sha256")==m["worker"]["sha256"] and config.get("GPU_module")==m["gpu_bucket_producer"]["script"] and all(m["code_binding"].get(p)==v for p,v in config["code_binding"].items())
        except BaseException as error:config_error=repr(error)
        # A damaged dynamic descriptor is never used to identify another job.
        # Its already fsynced exact create ACK remains sufficient to stop this
        # UUID leaf; refusing cleanup here would leave a live leaf needlessly.
        ack=Path(str(path)[:-len(".scope.json")]+".scope.created.json")
        if c.rootpath(value["created_ack"])!=ack.resolve():raise ValueError("Scope acknowledgement escaped its exact intent")
        force=False;dead_owner=owner_is_dead(value["Windows_owner"])
        if ack.exists():
            made=c.read(ack)
            expected(made,dict(schema="DURABLE_CREATED_FUSED_SCOPE_V6",scope=name,intent_sha256=c.sha(path),configuration_sha256=value["config_sha256"],workload_not_started_before_this_marker=True),"Orphan scope acknowledgement mismatch")
            expected(made["create"],dict(schema="WSL_FIXED_VERIFICATION_CGROUP_V6",status="CREATED_EMPTY_FIXED_RESOURCE_LEAF",name=name),"Scope was not acknowledged as created by this fixed helper")
            force=dead_owner
        answer=helper("scope_stop.py",["--name",name]+(["--force"] if force else []))
        if answer.get("all_Linux_owned_processes_confirmed_exited") is not True:raise RuntimeError("No kernel confirmation of orphan scope exit")
        cache_answer=helper("scope_cache_cleanup.py",["--name",name])
        if cache_answer.get("cache_directory_confirmed_absent") is not True:raise RuntimeError("Own exact native cache cleanup was not confirmed")
        if answer.get("scope_absent") is not True:helper("cgroup_scope.py",["remove","--name",name])
        record=folder/"scope_recoveries"/(name+"_"+intent_sha[:16]+".json")
        if not record.exists():c.atomic(record,dict(schema="VERIFIED_EXACT_FUSED_SCOPE_RECOVERY_V6",intent=c.rel(path),intent_sha256=intent_sha,created_ack_verified=ack.exists(),original_Windows_owner_confirmed_dead=dead_owner,force_allowed=force,
            dynamic_configuration_currently_matches=config_ok,dynamic_configuration_error=config_error,cleanup_ownership_did_not_depend_on_mutable_configuration=True,answer=answer,native_cache_cleanup=cache_answer))
        if len(REMOVED_SCOPES)>=256:REMOVED_SCOPES.pop(next(iter(REMOVED_SCOPES)))
        # Removal is kernel-confirmed; this random per-Client UUID is never
        # reused. A remaining uid1000 workload cannot recreate the root leaf.
        REMOVED_SCOPES[cache]=c.rel(record)
        results.append(c.rel(record))
    return results

class FusedContext:
    def __init__(self,m,rt):
        construct_clock=time.monotonic()
        self.rt=rt;self.m=m;self.exit_confirmed=False;self.closed=False;self.client=None;self.input_lock=None;self.active=None;self.frames=0;self.buckets=0;self.last_native_epoch=0
        directory=rt.f/"sessions";directory.mkdir(parents=True,exist_ok=True)
        self.base=directory/("fused_"+str(time.time_ns()));descriptor=Path(str(self.base)+".config.json")
        # Cache receipt names must remain short, unique across resumed contexts
        # and independent of a long campaign name or large source rank.
        self.session_directory=c.RUN/"s"/uuid.uuid4().hex[:16];self.session_directory.mkdir(parents=True,exist_ok=False)
        self.gpu_directory=c.GPU_RUN/m["name"]/"sessions";self.gpu_directory.mkdir(parents=True,exist_ok=True)
        fixed=self.gpu_directory/(self.base.name+".fixed.json")
        fixed_files={p:m["code_binding"][p] for p in m["gpu_fixed_inputs"]}
        c.atomic(fixed,dict(schema="V4_READ_LOCKED_INPUT_DIGESTS",files=fixed_files))
        run=c.ROOT/"runs/lean_table_checker"
        roots=[run/"summary_full_v1/inputs",run/"full_safe_local_v1/inputs",run/"canonical_inventory_resume_v1/inputs",c.INDEX,run/"successor_cache_v1/inputs",c.DATA,c.INDEX/"catalog.tsv"]
        if [c.rel(p) for p in roots]!=m["native_IO_adapter"]["original_roots"]:raise ValueError("Configured cache roots differ from the independently accepted adapter")
        # A bridge's API PID is handled only by its whole-cgroup owner cleanup.
        api_pid=c.GPU_RUN/m["name"]/"sessions"/("api_"+str(time.time_ns())+".pid.json")
        config=dict(schema="FUSED_LINUX_INDEXED_BYTE_BRIDGE_CONFIGURATION_V16",transport_timing_profile="WALL_ENVELOPES_INDEXED_BYTE_V16_1",
            resident_count_cap=67108864,frame_block_cap=8192,frame_template_budget=m["frame_policy"]["max_plan_templates"],row_rounds=1,
            native_max_frames_per_epoch=16,pipe_capacity_bytes=1048576,max_seconds=min(72000,max(.001,rt.deadline-time.monotonic())),threads=m["threads"],
            native=m["worker"]["executable"],native_sha256=m["worker"]["sha256"],native_roots=[c.rel(p) for p in roots],
            code_binding={p:m["code_binding"][p] for p in m["fused_bridge"]["code_paths"]},
            session_dir=c.rel(self.session_directory),output_roots=[c.rel(rt.f/"t")],stop_files=[c.rel(rt.f/"STOP"),c.rel(c.RUN/"STOP")],
            owner_file=c.rel(Path(str(self.base)+".owner.json")),GPU_module=m["gpu_bucket_producer"]["script"],
            native_cache=dict(schema="BOUNDED_NATIVE_EXT4_CACHE_CONFIGURATION_V7",nonce_policy="DERIVED_FROM_ACTUAL_OWNED_SCOPE",
                original_roots=[c.rel(p) for p in roots],input_bindings=rt.parent_inputs,max_cached_bytes=8000000000),
            GPU_configuration=dict(index=linux(c.INDEX),catalog=linux(c.INDEX/"catalog.tsv"),data=linux(c.DATA),edges=linux(run/"successor_cache_v1/inputs"),
                fixed_manifest=linux(fixed),fixed_manifest_sha256=c.sha(fixed),pid_file=linux(api_pid),max_count=m["chunk_rows"],device_cap_bytes=m["GPU_hard_cap_bytes"],host_rss_cap_bytes=m["linux_RSS_cap_bytes"]))
        if m.get("fault_inject")=="bad_n_member":
            if len(m["requests"])!=1 or not 0<m["requests"][0]["count"]<=512:
                raise ValueError("Indexed-byte negative injection is restricted to one<=512-row test")
            config["test_only_fault_inject"]="bad_n_ordinal"
            config["max_seconds"]=min(config["max_seconds"],60.0)
        c.atomic(descriptor,config);self.config_path=descriptor;self.config_sha256=c.sha(descriptor)
        self.config=config;self.cache_api=cached.verifier(m)
        self.input_lock=c.ReadLocks([fixed,descriptor])
        self.fixed_sha256=c.sha(fixed);self.fixed_files=fixed_files
        def guard():
            if threading.current_thread() is threading.main_thread():return rt.guard()
            if (rt.f/"STOP").exists() or (c.RUN/"STOP").exists():raise InterruptedError("STOP_REQUESTED")
            if time.monotonic()>=rt.deadline:raise InterruptedError("BOUNDED_INVOCATION_DEADLINE")
            if c.legacy.psutil.virtual_memory().available<3000000000:raise MemoryError("System available memory below three GB")
        try:self.client=module().Client(descriptor,self.base,guard)
        except BaseException:
            if self.input_lock:rt.unconfirmed_locks.append(self.input_lock);self.input_lock=None
            raise
        try:
            ready=self.client.ready;GPU=ready["GPU"]
            self.scratch=scratch_rules(m)
            self.scratch.ready(GPU,m["chunk_rows"])
            expected(GPU,dict(event="SESSION_READY",schema="GPU_CROSS_BUCKET_INDEXED_BYTE_PROTOCOL_V16",max_count=m["chunk_rows"]),"Fused GPU session mismatch")
            expected(GPU["fixed_identity"],dict(input_files=fixed_files,manifest_sha256=self.fixed_sha256),"Fused fixed GPU inputs mismatch")
            self.token=GPU["session_token"];self.fixed_identity=GPU["fixed_identity_sha256"];self.generation=0
            rt.s["fused_scopes_started"]=rt.s.get("fused_scopes_started",0)+1
            self.construct_seconds=time.monotonic()-construct_clock
            metrics.scope(self,"construct",self.construct_seconds,CUDA_fixed_context_ready=True)
        except BaseException:self.close(abort=True);raise
    def enter(self,view):
        if self.active is not None:raise ValueError("Prior fused bank not released")
        value=self.client.enter_bucket(view.layer,view.honor,view.manifest,view.manifest_sha256)
        indexed.validate_ready(self.m,value["native"],view.layer,view.honor)
        gpu=value["GPU"];expected(gpu,dict(event="BUCKET_READY",schema="GPU_CROSS_BUCKET_INDEXED_BYTE_PROTOCOL_V16",session_token=self.token,
            generation=self.generation+1,layer=view.layer,honor=view.honor,source_size=view.row["size"]),"Fused fresh bank scope mismatch")
        bank=gpu["bucket_identity"];expected(bank,dict(locked_manifest_sha256=view.manifest_sha256,fixed_identity_sha256=self.fixed_identity),"Fused fresh locked manifest mismatch")
        for name,binding in bank["input_files"].items():
            if view.locked.get(name)!=binding:raise ValueError("Fused GPU claimed an unlocked bucket input")
        required_bank={name:v for name,v in view.locked.items() if name.endswith(('.bits','.dir'))}
        proposed_bank={name:v for name,v in bank["input_files"].items() if name.endswith(('.bits','.dir'))}
        if required_bank!=proposed_bank:raise ValueError("GPU bank omits a complete actual locked source/child file")
        bank_class=bank_class_from_locked_files(required_bank)
        floor=self.m["resource_epoch_cost_floor"]["minimum_complete_epoch_frames_by_bank_class"][bank_class]
        view.epoch_tracker.set_cost_floor(floor)
        cached.prepare(self,view,value)
        self.generation+=1;self.buckets+=1;self.active=view;view.generation=self.generation;view.identity=gpu["identity_sha256"];view.ready_event=value
        return value
    def close(self,abort=False):
        if self.closed:
            if not self.exit_confirmed:raise RuntimeError("Fused scope exit still unconfirmed")
            return
        self.closed=True;close_clock=time.monotonic()
        try:
            if self.client is not None:
                result=self.client.close(abort=abort)
                self.exit_confirmed=result.get("all_Linux_owned_processes_confirmed_exited") is True and result.get("Windows_client_confirmed_exited") is True
                if not self.exit_confirmed:raise RuntimeError("No exact whole-scope exit confirmation")
                metrics.scope(self,"confirmed_close",time.monotonic()-close_clock,abort=abort,
                    kernel_empty_and_native_cache_cleanup_confirmed=True)
        finally:
            if self.input_lock:
                if self.exit_confirmed:self.input_lock.close()
                else:self.rt.unconfirmed_locks.append(self.input_lock)
                self.input_lock=None

class FusedBucket:
    def __init__(self,m,row,rt,locked):
        self.rt=rt;self.row=row;self.layer=row["layer"];self.honor=row["honor"];self.locked=dict(locked);self.input_lock=None;self.closed=False
        self.generation=None;self.identity=None;self.completed=0;self.rows=0;self.epoch_frames=[];self.current_epoch_count=0;self.last_epoch=None
        if rt.cross_gpu is None:rt.cross_gpu=FusedContext(m,rt)
        self.context=rt.cross_gpu
        self.epoch_tracker=EpochTracker(self.context.last_native_epoch)
        self.manifest=self.context.gpu_directory/(self.context.base.name+f".bank_{self.context.generation+1:04}.json")
        c.atomic(self.manifest,dict(schema="V4_READ_LOCKED_INPUT_DIGESTS",files=self.locked))
        self.input_lock=c.ReadLocks([self.manifest]);self.manifest_sha256=c.sha(self.manifest)
    def ready(self):return self.context.enter(self)
    def span(self,start,count,output,log,following=None):
        value=self.context.client.span(start,count,output,following)
        self.context.cache_api.validate_transport_timing(value)
        self.epoch_tracker.accept(value,start,count)
        self.context.last_native_epoch=self.epoch_tracker.current
        proposal=value["proposal"]
        self.context.scratch.proposal(proposal,start,count,self.context.m["chunk_rows"])
        expected(proposal,dict(layer=self.layer,honor=self.honor,start=start,count=count,session_token=self.context.token,
            generation=self.generation,identity_sha256=self.identity,fixed_identity_sha256=self.context.fixed_identity,
            locked_manifest_sha256=self.manifest_sha256,compact_bytes=count,transport="indexed_actual_next_byte_v16",record_bytes=1,
            GPU_trusted_for_soundness=False,Lean_rows_verified=0),"Fused proposal crossed a bucket/session boundary")
        if value["worker"]!=c.read(output):raise ValueError("Fused RPC worker result differs from saved native result")
        self.completed+=1;self.rows+=count;self.context.frames+=1
        c.atomic(log,dict(ready=self.ready_event,event=value["native_event"],native_lifecycle=value["native_lifecycle"],
            transport_timing=value["transport_timing"],native_RSS_after_bytes=value["native_RSS_after_bytes"],Linux_scope=self.context.client.name,
            bridge_configuration_sha256=self.context.config_sha256,ephemeral_compact_payload_untrusted=True,payload_crossed_Windows=False))
        return dict(start=start,count=count,provenance=dict(kind="FRESH_UNTRUSTED_INDEXED_BYTE_LINUX_FUSED_GPU",origin=proposal,
            GPU_generation_this_invocation=True,GPU_trusted=False,locked_manifest_sha256=self.manifest_sha256,
            bridge_configuration_sha256=self.context.config_sha256,scope=self.context.client.name,payload_crossed_Windows=False,
            native_cache_proof=self.cache_proof,payloads_persisted_or_hashed=False,all_payload_records_require_actual_Lean_checks=True))
    def close(self,abort=False):
        if self.closed:return
        self.closed=True
        try:
            if abort:self.context.close(abort=True)
            elif self.context.active is self:
                left=self.context.client.leave_bucket();gpu=left["GPU"]
                expected(gpu,dict(event="BUCKET_LEFT",session_token=self.context.token,generation=self.generation,identity_sha256=self.identity,
                    bucket_allocations_released=True,fixed_allocations_retained=True),"Fused bucket did not release GPU bank")
                cached.finish(self.context,self,left)
                self.context.active=None
        finally:
            if self.input_lock:
                safe=self.context.exit_confirmed or (not abort and self.context.active is None)
                if safe:self.input_lock.close()
                else:self.rt.unconfirmed_locks.append(self.input_lock)
                self.input_lock=None
