"""Bounded production wrapper: Windows1.25GB/5percent, Linux14.25GB/75percent.

GPU6GB/global7GB/free1GB and GPU-host RSS3GB remain independently enforced.
An optional hidden-service outer memory-only Job adds64MiB to its enclosing
Windows cap and must be recorded separately by the actual host/fee authority.
No task is scheduled or started merely by importing this module.
"""
from pathlib import Path
import argparse,ctypes,json,os,subprocess,sys,time
from ctypes import wintypes as W
import campaign as s
import campaign_io as c
import invocation_budget as ib
import input_snapshot as inputs
import cost_gate as costs
import resource_job as resources
import finite_premises as finite
import local_reports
from keep_awake import SystemAwake

def cleanup_error(record,key,error):
    record[key+"_total"]=record.get(key+"_total",0)+1
    record[key]=(record.get(key,[])+[repr(error)])[-16:]

def job_peak(job):
    class Basic(ctypes.Structure):
        _fields_=[("ProcessTime",ctypes.c_int64),("JobTime",ctypes.c_int64),("Flags",W.DWORD),("MinWS",ctypes.c_size_t),("MaxWS",ctypes.c_size_t),
            ("Active",W.DWORD),("Affinity",ctypes.c_size_t),("Priority",W.DWORD),("Scheduling",W.DWORD)]
    class IO(ctypes.Structure):_fields_=[(x,ctypes.c_uint64) for x in ("ro","wo","oo","rb","wb","ob")]
    class Extended(ctypes.Structure):
        _fields_=[("Basic",Basic),("IO",IO),("ProcessMemory",ctypes.c_size_t),("JobMemory",ctypes.c_size_t),("PeakProcessMemory",ctypes.c_size_t),("PeakJobMemory",ctypes.c_size_t)]
    query=job.k.QueryInformationJobObject;query.argtypes=[W.HANDLE,ctypes.c_int,ctypes.c_void_p,W.DWORD,ctypes.c_void_p];query.restype=W.BOOL
    value=Extended()
    if not query(job.handle,9,ctypes.byref(value),ctypes.sizeof(value),None):raise ctypes.WinError(ctypes.get_last_error())
    return value.PeakJobMemory

def job_pids(job):
    # Exact OS job membership also finds a native child whose controller has
    # already died. Never infer full cleanup from the controller PID alone.
    capacity=1024;raw=ctypes.create_string_buffer(8+ctypes.sizeof(ctypes.c_size_t)*capacity)
    query=job.k.QueryInformationJobObject;query.argtypes=[W.HANDLE,ctypes.c_int,ctypes.c_void_p,W.DWORD,ctypes.c_void_p];query.restype=W.BOOL
    if not query(job.handle,3,raw,ctypes.sizeof(raw),None):raise ctypes.WinError(ctypes.get_last_error())
    assigned,count=(W.DWORD*2).from_buffer(raw)
    if count>capacity or assigned>capacity:raise ValueError("Too many owned Windows processes to confirm bounded cleanup")
    return list((ctypes.c_size_t*count).from_buffer(raw,8))

def confirm_cleanup(job,m,child,record,abort):
    confirmed=True;processes=[]
    # Kill our Windows controller first on abort. Linux recovery must never
    # --force a scope whose exact Windows PID/creation identity is still live.
    try:
        for pid in job_pids(job):
            if pid==os.getpid():continue
            try:processes.append(c.legacy.psutil.Process(pid))
            except c.legacy.psutil.NoSuchProcess:pass
        if abort:
            for process in processes:
                try:process.kill()
                except c.legacy.psutil.NoSuchProcess:pass
            c.legacy.psutil.wait_procs(processes,timeout=5)
    except BaseException as error:confirmed=False;cleanup_error(record,"Windows_cleanup_errors",error)
    if m["backend"]=="linux_fused_joint_indexed_byte_checked_constructor_native_cache_v16":
        try:
            from fused_transport import cleanup_scopes
            record["Linux_scope_recoveries"]=cleanup_scopes(s.folder(m["name"]),m)
        except BaseException as error:confirmed=False;cleanup_error(record,"Linux_cleanup_errors",error)
    else:
        for pid in list((c.GPU_RUN/m["name"]/"sessions").glob("*_gpu_*.pid.json")):
            try:s.stop_linux(pid)
            except BaseException as error:confirmed=False;cleanup_error(record,"Linux_cleanup_errors",error)
    try:
        gone,alive=c.legacy.psutil.wait_procs(processes,timeout=15)
        remaining=[pid for pid in job_pids(job) if pid!=os.getpid()]
        # Scope helpers are launched after the initial Windows snapshot. Their
        # short-lived relay descendants can finish a moment after wsl.exe.
        # Drain those exact Job members before declaring cleanup unconfirmed.
        if remaining:
            late=[]
            for pid in remaining:
                try:late.append(c.legacy.psutil.Process(pid))
                except c.legacy.psutil.NoSuchProcess:pass
            c.legacy.psutil.wait_procs(late,timeout=2)
            record["Windows_helper_descendants_drained"]=remaining
            remaining=[pid for pid in job_pids(job) if pid!=os.getpid()]
        record.update(Windows_owned_processes_checked=[p.pid for p in processes],Windows_owned_alive_after_wait=[p.pid for p in alive],Windows_job_remaining_processes=remaining)
        if alive or remaining:confirmed=False
        if child is not None and child.poll() is None:confirmed=False
    except BaseException as error:confirmed=False;cleanup_error(record,"Windows_cleanup_errors",error)
    record["all_owned_services_confirmed_exited"]=confirmed
    return confirmed

def main(args):
    if args.max_seconds<=0 or args.max_chunks<0:raise ValueError("Use positive bounded seconds and nonnegative chunks")
    f=s.folder(args.name);exclusive=c.legacy.a.Lock(f/"invocation.lock");ticket=None;locks=None
    try:
        with SystemAwake():return prepare(args,f)
    finally:exclusive.close()

def prepare(args,f):
    manifest_path=f/"manifest.json";manifest_raw=manifest_path.read_bytes();core=c.BASE/"campaign.py"
    manifest_lock=c.ReadLocks([manifest_path]);locks=None;ticket=None;m=None
    initial_committed=c.read(f/"checkpoint.json")["committed_rows"]
    try:
        if manifest_path.read_bytes()!=manifest_raw:raise ValueError("Manifest changed before the parent lock")
        m=json.loads(manifest_raw)
        if m.get("schema")!="INDEXED_BYTE_CHECKED_CONSTRUCTOR_CROSS_LAYER_LEAN_CAMPAIGN_MANIFEST_V16" or c.rel(core) not in m["code_binding"]:raise ValueError("Wrapper requires an explicitly bound owned controller")
        if m.get("backend")!=s.lwg.BACKEND or m.get("pure_kernel_theorem_count")!=104 or m.get("payload_bytes_per_row")!=1 or m.get("worker",{}).get("span_protocol")!=s.lwg.PROTOCOL:
            raise ValueError("The resource wrapper cannot adapt an old88/8B manifest to the new104 Native")
        costs.assert_bounded_scope(m,args.max_chunks,external_gate_requested=bool(getattr(args,"cost_gate",None)))
        ticket=ib.reserve(f,m,args.max_seconds)
        return validate_and_launch(args,f,m,core,ticket)
    finally:
        if ticket is not None:
            try:
                if m is not None:local_reports.write(f,m,c.read(f/"checkpoint.json"),ticket,initial_committed,ticket.cleanup_confirmed)
            finally:ticket.finish(cleanup_confirmed=ticket.cleanup_confirmed)
        manifest_lock.close()

def validate_and_launch(args,f,m,core,ticket):
    if m["backend"]!="linux_fused_joint_indexed_byte_checked_constructor_native_cache_v16":raise ValueError("Unsupported production resource profile")
    fused=m["backend"]=="linux_fused_joint_indexed_byte_checked_constructor_native_cache_v16"
    job=resources.NamedJob(1250000000 if fused else 12500000000,5 if fused else 80,ticket.ticket["token"])
    resources.bind_ticket(ticket,job)
    cost_path=c.rootpath(args.cost_gate) if getattr(args,"cost_gate",None) else None
    if costs.full_scope(m) and args.max_chunks>0 and cost_path is None:raise ValueError("Full-scope native work needs --cost-gate with the same manifest's weighted empirical PASS")
    cost_value,cost_assets=costs.discover(cost_path) if cost_path is not None else (None,[])
    seed_path=c.legacy.FOLDER/"e2e_manifest.json"
    banks=s.all_semantic_bank_inputs(m)
    paths=[Path(__file__),core,c.BASE/"campaign_io.py",f/"manifest.json",seed_path]+s.fixed_inputs()+[c.rootpath(k) for k in m["code_binding"]]+banks+cost_assets
    locks=c.ReadLocks(list(dict.fromkeys(paths)));parent_lock=None
    def guard():
        if (f/"STOP").exists() or (c.RUN/"STOP").exists():raise InterruptedError("STOP_REQUESTED")
        if time.monotonic()>=ticket.work_deadline:raise InterruptedError("BOUNDED_WORK_DEADLINE_WITH_RESERVED_CLEANUP")
        if c.legacy.psutil.virtual_memory().available<3_000_000_000:raise MemoryError("System available memory below three GB")
    try:
        c.atomic(f/"parent_preflight_activity.json",dict(phase="code_custody_actual_parent_SHA",reservation=ticket.ticket["token"],record_count=len(m["code_binding"])))
        checked_code=inputs.check_code_locked(m["code_binding"],guard)
        checked_code_seconds=time.monotonic()-ticket.ticket["began_monotonic"]
        if c.sha(seed_path)!=s.SEED_MANIFEST_SHA:raise ValueError("The certified fixed-input seed changed")
        seed=c.read(seed_path)["input_files"];fixed={c.rel(path):dict(bytes=path.stat().st_size,sha256=c.sha(path,guard)) for path in s.fixed_inputs()}
        for name,record in fixed.items():
            if seed.get(name)!=record:raise ValueError("Actual fixed input differs from the certified seed")
        began=time.monotonic();files=dict(fixed);done=bytes_done=0;last_report=began
        common=list(dict.fromkeys(s.fixed_inputs()+[c.INDEX/x for x in ("numeric.bin","numeric_ids.bin","groups.bin","honor_ids.bin","catalog.tsv")]))
        for path in common:files[c.rel(path)]=dict(checked_code[c.rel(path)])
        for path in banks:
            guard();record=dict(bytes=path.stat().st_size,sha256=c.sha(path,guard));files[c.rel(path)]=record
            done+=1;bytes_done+=record["bytes"]
            if time.monotonic()-last_report>=60:
                c.atomic(f/"parent_input_hash_progress.json",dict(state="HASHING_LOCKED_SEMANTIC_INPUTS",files_done=done,total_files=len(banks),bytes_hashed=bytes_done,model_calls=0));last_report=time.monotonic()
        c.atomic(f/"parent_preflight_activity.json",dict(phase="finite_validation",reservation=ticket.ticket["token"]))
        finite_clock=time.monotonic()
        finite_validation=finite.validate(m,{**checked_code,**files},guard)
        finite_seconds=time.monotonic()-finite_clock
        if cost_path is not None:
            cost_record=costs.validate_locked(cost_path,cost_value,m,f/"manifest.json",files,guard)
            costs.attach(ticket,cost_record)
        parent=f/"parent_inputs"/(ticket.ticket["token"]+".json")
        inputs.validate_file_map(files)
        manifest_sha256=c.sha(f/"manifest.json")
        c.atomic(parent,dict(schema=inputs.SCHEMA,manifest_sha256=manifest_sha256,reservation_token=ticket.ticket["token"],files=files,
            all_actual_files_readlocked_before_hash=True,parent_keeps_locks_until_kernel_empty=True,bank_file_count=len(banks),bank_bytes_hashed=bytes_done,
            hash_wall_seconds=time.monotonic()-began,finite_premise_validation=finite_validation,finite_premise_validation_seconds=finite_seconds,
            parent_code_validation_inclusive_setup_seconds=checked_code_seconds,
            **inputs.checked_code_fields(checked_code,manifest_sha256)))
        parent_lock=c.ReadLocks([parent]);digest=c.sha(parent)
        inputs.bind_reservation(ticket,parent)
        c.atomic(f/"parent_input_hash_progress.json",dict(state="COMPLETE_LOCKED_SEMANTIC_INPUT_HASHES",files_done=done,total_files=len(banks),bytes_hashed=bytes_done,
            wall_seconds=time.monotonic()-began,parent_inputs=c.rel(parent),parent_inputs_sha256=digest,model_calls=0))
        guard()
        return main_locked(args,f,m,core,fixed,ticket,len(banks),job,parent)
    except BaseException as setup_error:
        # Setup can stop before a child was created, while an abandoned prior
        # invocation still has a durable owned scope. Recover that scope before
        # releasing the semantic handles acquired by this parent.
        record=dict(state="PREFLIGHT_FAILED_RECOVERING_EXACT_OWNED_SCOPES",input_locks_retained=True,
            error=repr(setup_error),reservation_token=ticket.ticket["token"],manifest_sha256=c.sha(f/"manifest.json"))
        ticket.cleanup_confirmed=False
        while not ticket.cleanup_confirmed:
            try:ticket.cleanup_confirmed=confirm_cleanup(job,m,None,record,abort=True)
            except BaseException as error:cleanup_error(record,"cleanup_errors",error)
            if not ticket.cleanup_confirmed:
                try:c.atomic(f/"preflight_cleanup_guardian.json",record)
                except BaseException as error:
                    try:print("PREFLIGHT_INPUT_LOCK_GUARDIAN "+repr(error),file=sys.stderr,flush=True)
                    except BaseException:pass
                try:time.sleep(5)
                except BaseException:pass
        checkpoint=f/"checkpoint.json"
        if checkpoint.exists():
            state=c.read(checkpoint)
            if isinstance(setup_error,InterruptedError):state.update(state="PAUSED_SAFE_BOUND_OR_STOP",reason=str(setup_error))
            else:state.update(state="PAUSED_ERROR_NO_UNCHECKED_PROGRESS_COMMITTED",error=repr(setup_error))
            from ledger import save_root
            save_root(f,state)
        c.atomic(f/"preflight_failures"/(ticket.ticket["token"]+".json"),record)
        raise
    finally:
        # main_locked has a lock guardian on unconfirmed cleanup; this branch
        # is reached only before launch or after the owned subtree is empty.
        if ticket.cleanup_confirmed:
            if parent_lock:parent_lock.close()
            locks.close()
        else:raise RuntimeError("REFUSING_TO_RELEASE_PARENT_SEMANTIC_INPUT_LOCKS_WHILE_OWNED_EXIT_UNCONFIRMED")

def main_locked(args,f,m,core,fixed,ticket,bank_file_count,job,parent_inputs):
    fused=m["backend"]=="linux_fused_joint_indexed_byte_checked_constructor_native_cache_v16";gpu=m["backend"]=="gpu_compact"
    windows_cap=1_250_000_000 if fused else (12_500_000_000 if gpu else 15_500_000_000)
    linux_rss_cap=m["Linux_cgroup_hard_cap_bytes"] if fused else (3_000_000_000 if gpu else 0)
    directory=f/"launches";directory.mkdir(parents=True,exist_ok=True)
    stem=directory/str(time.time_ns());receipt=stem.with_suffix(".json");log=stem.with_suffix(".log")
    argv=[sys.executable,"-B",str(core),"run","--name",args.name,"--max-seconds",str(args.max_seconds),"--max-chunks",str(args.max_chunks),"--reservation",ticket.ticket["token"],"--parent-inputs",c.rel(parent_inputs)]
    bound=c.bind([Path(__file__),core,c.BASE/"campaign_io.py",f/"manifest.json"])
    began=time.monotonic();child=None;failure=None
    record=dict(schema="V4_RESOURCE_ENVELOPE_LAUNCH",state="RUNNING_BOUNDED",manifest_sha256=c.sha(f/"manifest.json"),argv=argv,
        Windows_subtree_hard_cap_bytes=windows_cap,GPU_Linux_RSS_producer_cap_bytes=m["linux_RSS_cap_bytes"],Linux_cgroup_hard_cap_bytes=linux_rss_cap if fused else None,
        combined_declared_task_memory_envelope_bytes=windows_cap+linux_rss_cap,CPU_cap_percent=5 if fused else 80,
        wrapper_code_binding=bound,checkpoint_before_sha256=c.sha(f/"checkpoint.json"),log=c.rel(log),auto_started=False)
    record.update(parent_fixed_input_bindings=fixed,parent_fixed_inputs_locked_before_dependency_discovery=True,
        parent_read_locks_held_through_entire_native_GPU_subtree=True,parent_semantic_bank_file_handles=bank_file_count,
        generated_manifests_parent_continuous_lock_claimed=False,cleanup_reserve_seconds=ib.CLEANUP_RESERVE_SECONDS)
    record.update(parent_inputs=c.rel(parent_inputs),parent_inputs_sha256=c.sha(parent_inputs),parent_inputs_whole_invocation_readlocked=True)
    record["weighted_cost_gate"]=ticket.ticket.get("weighted_cost_gate")
    record["entire_invocation_window_reserved_before_code_or_input_hashing"]=ticket.ticket
    c.atomic(receipt,record)
    try:
        with log.open("wb") as stream:
            ticket.cleanup_confirmed=False
            child=subprocess.Popen(argv,cwd=c.ROOT,stdout=stream,stderr=subprocess.STDOUT,creationflags=subprocess.CREATE_NO_WINDOW,
                env=dict(os.environ,PYTHONUTF8="1",PYTHONDONTWRITEBYTECODE="1"))
            while child.poll() is None:
                if time.monotonic()>=ticket.work_deadline:raise TimeoutError("WORK_WINDOW_ENDED_RESERVING_60S_FOR_OWNED_CLEANUP_INSIDE_TOTAL_BUDGET")
                time.sleep(.05)
            stream.flush();os.fsync(stream.fileno())
        record["controller_returncode"]=child.returncode
    except BaseException as e:
        failure=e;record["error"]=repr(e)
    finally:
        ticket.cleanup_confirmed=confirm_cleanup(job,m,child,record,abort=failure is not None)
        if not ticket.cleanup_confirmed and failure is None:
            failure=RuntimeError("WRAPPER_CLEANUP_UNCONFIRMED; invocation remains fully charged and must pause")
            record["error"]=repr(failure)
        # Do not unwind and release semantic input handles while a live owned
        # Linux leaf could still consume them. No new native/GPU work is ever
        # launched in this emergency, explicitly reported retention state.
        while not ticket.cleanup_confirmed:
            record.update(state="CLEANUP_UNCONFIRMED_INPUT_LOCK_GUARDIAN_NO_NEW_WORK",input_locks_retained=True,
                total_budget_elapsed=time.monotonic()>=ticket.deadline)
            try:
                c.atomic(receipt,record)
            except BaseException as guard_error:
                record["last_lock_guardian_error"]=repr(guard_error)
                try:print("INPUT_LOCK_GUARDIAN_RETAINS_CUSTODY "+repr(guard_error),file=sys.stderr,flush=True)
                except BaseException:pass
            try:ticket.cleanup_confirmed=confirm_cleanup(job,m,child,record,abort=True)
            except BaseException as guard_error:record["last_lock_guardian_error"]=repr(guard_error)
            if not ticket.cleanup_confirmed:
                try:time.sleep(5)
                except BaseException:pass
        if child is not None and child.poll() is not None:record["controller_returncode"]=child.returncode
        record.update(state="WRAPPER_CLEANUP_UNCONFIRMED" if not ticket.cleanup_confirmed else ("WRAPPER_ERROR_PAUSED" if failure else "EXITED_BOUNDED"),wall_seconds=time.monotonic()-began,
            Windows_peak_job_commit_bytes=job_peak(job),controller_confirmed_exited=child is None or child.poll() is not None,
            checkpoint_after_sha256=c.sha(f/"checkpoint.json"),log_sha256=c.sha(log) if log.exists() else None)
        c.atomic(receipt,record)
    print(json.dumps(dict(state=record["state"],receipt=c.rel(receipt),Windows_cap_bytes=windows_cap,combined_declared_envelope_bytes=windows_cap+linux_rss_cap,
        Windows_peak_commit_bytes=record["Windows_peak_job_commit_bytes"],controller_returncode=record.get("controller_returncode"))),flush=True)
    if failure:raise failure
    return child.returncode

if __name__=="__main__":
    p=argparse.ArgumentParser();p.add_argument("--name",required=True);p.add_argument("--max-seconds",type=float,default=900);p.add_argument("--max-chunks",type=int,default=1)
    p.add_argument("--cost-gate",help="External same-manifest weighted cost PASS; mandatory for any positive full-scope native work")
    raise SystemExit(main(p.parse_args()))
