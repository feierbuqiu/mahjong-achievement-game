"""Owned execution: linear journals, bounded work frames and native epochs.

This module does no work on import. All original game/target/numbering gates
remain in campaign.py. It never treats a historical conditional row as a
complete certified target bucket.
"""
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor
import datetime,json,os,shutil,struct,time,uuid
import campaign_io as c
import frame_registry as fr
import frame_planner as fp
import ledger as ld
import invocation_budget as ib
import worker_gate as wg
import path_guard as paths
import prior_import as prior
import linux_worker_gate as lwg
import input_snapshot as inputs
import cost_gate as costs
import scope_lifecycle as scopes
import resource_job as resources
import finite_premises as finite
import production_metrics as metrics
from keep_awake import SystemAwake

MANIFEST="INDEXED_BYTE_CHECKED_CONSTRUCTOR_CROSS_LAYER_LEAN_CAMPAIGN_MANIFEST_V16"

def run(args,s):
    if not getattr(args,"reservation",None):raise ValueError("V6_RUN_REQUIRES_LAUNCH_CAMPAIGN_RESOURCE_WRAPPER_AND_PARENT_INPUT_CUSTODY")
    f=s.folder(args.name);outer=None;ticket=None;manifest_lock=None;awake=None
    try:
        if not getattr(args,"reservation",None):outer=c.legacy.a.Lock(f/"invocation.lock");awake=SystemAwake();awake.__enter__()
        manifest_path=f/"manifest.json";raw=manifest_path.read_bytes()
        manifest_lock=c.ReadLocks([manifest_path])
        if manifest_path.read_bytes()!=raw:raise ValueError("Manifest changed before lock acquisition")
        m=json.loads(raw)
        if m.get("schema")!=MANIFEST or m.get("name")!=args.name:raise ValueError("Wrong owned campaign identity")
        if m.get("backend")!=lwg.BACKEND or m.get("native_checker_kind")!=lwg.MARKER or m.get("pure_kernel_theorem_count")!=104 or m.get("native_io_policy")!=lwg.IO_POLICY or m.get("bridge_payload_write_chunk_bytes")!=lwg.WRITE_CHUNK_BYTES or m.get("full_launch_allowed") is not False:raise ValueError("Wrong independently gated generated V12 execution family")
        if m.get("payload_bytes_per_row")!=1 or m.get("worker",{}).get("span_protocol")!=lwg.PROTOCOL or m["worker"].get("schema")!=lwg.NATIVE_SCHEMA or m["worker"].get("status")!=lwg.NATIVE_STATUS:
            raise ValueError("Only the actual104 one-byte Native protocol is eligible for this controller")
        if m.get("native_output_path_policy")!=paths.POLICY:raise ValueError("Unknown native output path policy")
        paths.preflight(f)
        fused=m.get("backend")=="linux_fused_joint_indexed_byte_checked_constructor_native_cache_v16"
        caps=dict(cpu_cap_percent=5 if fused else 80,memory_hard_cap_bytes=1250000000 if fused else 12500000000,linux_RSS_cap_bytes=3000000000,aggregate_declared_memory_cap_bytes=15500000000,
            GPU_hard_cap_bytes=6000000000,GPU_global_cap_bytes=7000000000,label_format="PACKED_LSB0",prefetch_chunks=1)
        if fused:caps["Linux_cgroup_hard_cap_bytes"]=lwg.RESOURCES["Linux_memory_max_bytes"]
        if any(m.get(k)!=v for k,v in caps.items()) or type(m.get("threads")) is not int or m["threads"]!=12:raise ValueError("Immutable campaign exceeds the accepted selected12-thread resource or transport envelope")
        if args.max_seconds<=0 or args.max_chunks<0:raise ValueError("Use positive bounded seconds and nonnegative chunk count")
        costs.assert_bounded_scope(m,args.max_chunks,external_gate_requested=bool(getattr(args,"reservation",None)))
        ticket=ib.adopt(f,m,args.reservation) if getattr(args,"reservation",None) else ib.reserve(f,m,args.max_seconds)
        controller=c.legacy.a.Lock(f/"controller.lock")
        immutable=None
        try:
            immutable=c.ReadLocks([c.rootpath(x) for x in m["code_binding"]])
            return run_locked(args,s,f,m,ticket)
        finally:
            if immutable:immutable.close()
            controller.close()
    finally:
        if ticket is not None and outer is not None:ticket.finish(cleanup_confirmed=ticket.cleanup_confirmed)
        if manifest_lock:manifest_lock.close()
        if outer:outer.close()
        if awake:awake.__exit__()

def private_bytes(session):
    value=getattr(c.legacy.psutil.Process(session.p.pid).memory_info(),"private",None)
    if not isinstance(value,int) or value<=0:raise ValueError("Native private-memory telemetry unavailable; safe epoch policy cannot be enforced")
    return value

def rotate_if_needed(ws,m,rt,n,h):
    if ws.session is not None:
        policy=m["restart_policy"];private=private_bytes(ws.session)
        reasons=[]
        if ws.session.completed>=policy["max_spans"]:reasons.append("MAX_NATIVE_EPOCH_SPANS")
        if private>=policy["rotate_before_next_frame_private_bytes"]:reasons.append("NATIVE_PRIVATE_THRESHOLD")
        if reasons:
            old=ws.session;old.close();ws.session=None
            c.atomic(old.log_path.with_suffix(".rotation.json"),dict(schema="OWNED_CONFIRMED_NATIVE_EPOCH_ROTATION_V4",reasons=reasons,
                worker_binding=m["worker"],restart_policy=policy,completed_spans=old.completed,private_bytes_before_exit=private,
                exit_confirmed=old.p.poll() is not None,session_receipt=c.rel(old.log_path.with_suffix(".session.json")),GPU_session_reused=True))
    if ws.session is None:
        from compact_transport import CompactNative
        rt.untracked_service_possible=True
        ws.session=CompactNative(m,n,h,rt)
        rt.untracked_service_possible=False

def run_locked(args,s,f,m,ticket):
    state=c.read(f/"checkpoint.json")
    if state.get("schema")!="OWNED_CROSS_LAYER_LEAN_CHECKPOINT_V4" or state["manifest_sha256"]!=c.sha(f/"manifest.json"):raise ValueError("Checkpoint identity changed; create a new campaign")
    rt=s.Runtime(f,m,state,ticket);table=s.slots();executed=0
    invocation=dict(schema="OWNED_BOUNDED_INVOCATION_V4",started_utc=datetime.datetime.now(datetime.timezone.utc).isoformat(),
        rows_before=state["committed_rows"],reservation_token=ticket.ticket["token"])
    inherited_job=resources.verify_child(ticket.ticket,m)
    invocation["Windows_resource_job"]=inherited_job
    revalidation=None
    try:
        parent=c.rootpath(args.parent_inputs)
        rt.begin("code_custody")
        rt.proof_locks.append(c.ReadLocks([parent]))
        snapshot=inputs.read_locked(parent,f,ticket.ticket,state["manifest_sha256"],m["code_binding"])
        rt.parent_inputs=snapshot["files"];rt.parent_input_snapshot=dict(path=c.rel(parent),sha256=c.sha(parent))
        invocation["checked_code_custody"]=dict(kind=inputs.CODE_CUSTODY,record_count=snapshot["checked_code_binding_record_count"],
            parent_inputs=rt.parent_input_snapshot,child_second_code_SHA256_pass_performed=False,
            exact_named_Job_and_live_direct_parent_ticket_checked=True)
        if costs.full_scope(m) and args.max_chunks>0:
            permit=ticket.ticket.get("weighted_cost_gate")
            if not isinstance(permit,dict):raise ValueError("Full-scope native work has no parent-bound weighted empirical PASS")
            permit_path=c.rootpath(permit["path"]);cost_value,cost_assets=costs.discover(permit_path)
            rt.proof_locks.append(c.ReadLocks(cost_assets))
            if costs.validate_locked(permit_path,cost_value,m,f/"manifest.json",rt.parent_inputs,rt.guard)!=permit:raise ValueError("Delegated full-run cost decision changed after its parent ticket")
            invocation["weighted_cost_gate"]=permit
        rt.begin("finite_validation")
        finite_clock=time.monotonic()
        finite_validation=finite.validate(m,{**snapshot["checked_code_binding"],**rt.parent_inputs},rt.guard)
        invocation.update(finite_premise_validation=finite_validation,finite_premise_validation_seconds=time.monotonic()-finite_clock)
        rt.begin("worker_gate_validation")
        gate_api=lwg if m["backend"]=="linux_fused_joint_indexed_byte_checked_constructor_native_cache_v16" else wg
        gate_path=c.rootpath(m["worker_gate"]["path"]);gate,build,assets=gate_api.discover(gate_path)
        if gate_api.validate_locked(gate_path,gate,build,m["code_binding"])!=m["worker"] or gate_api.restart_policy(gate["restart_policy"])!=m["restart_policy"]:
            raise ValueError("Runtime candidate/restart policy differs from accepted immutable gate")
        if s.span_policy.cost_floor_policy(gate["stability_report"],gate["resource_epoch_basis"])!=m["resource_epoch_cost_floor"]:
            raise ValueError("Resource epoch cost floor differs from actual independently accepted evidence")
        if m["threads"]!=gate["resource_policy"]["threads"]:raise ValueError("Actual execution threads differ from the independently accepted sparse resource profile")
        fp.validate_policy(m["frame_policy"])
        if m["backend"]=="linux_fused_joint_indexed_byte_checked_constructor_native_cache_v16":scopes.validate(m["scope_lifecycle_policy"])
        if c.sha(c.DATASET/"all_buckets.json")!=m["dataset_sha256"]:raise ValueError("Complete dataset inventory changed")
        rt.begin("prefix_validation")
        revalidation=metrics.RevalidationStream(f,ticket.ticket["token"],m)
        s.validate_commits(f,m,state,rt.guard,rt.proof_locks,revalidation.append)
        invocation["strict_item_revalidation_timings"]=revalidation.close()
        rt.begin("prior_install")
        prior.verify_identity(m.get("complete_bucket_reuse"),m["code_binding"],m["worker"],m["requests"])
        prior.install(f,m,s,table,rt)
        rt.begin("cleanup_prior_owned_services")
        ticket.cleanup_confirmed=False
        if m["backend"]=="linux_fused_joint_indexed_byte_checked_constructor_native_cache_v16":
            from fused_transport import cleanup_scopes
            cleanup_scopes(f,m)
        else:
            for pid in (c.GPU_RUN/m["name"]/"sessions").glob("*_gpu_*.pid.json"):rt.guard();s.stop_linux(pid)
        ticket.cleanup_confirmed=True
        # These are recomputable outputs only. Durable orphan attempts remain
        # distinct; no uncommitted artifact is ever adopted by its filename.
        for tmp in (f/"t").glob("*"):
            rt.guard()
            if not tmp.is_dir():raise ValueError("Unexpected staging object")
            for pid in tmp.glob("*.pid.json"):
                ticket.cleanup_confirmed=False;s.stop_linux(pid);ticket.cleanup_confirmed=True
            for path in tmp.iterdir():
                if path.is_file():c.remove_temporary(path,tmp)
        state.update(state="RUNNING_BOUNDED_CROSS_LAYER");state.pop("reason",None);state.pop("error",None)
        for request in m["requests"]:
            n,h=request["layer"],request["honor"];row=table[n,h];cp=s.certpath(f,n,h)
            rt.guard()
            if cp.exists():
                lock=c.ReadLocks([cp,c.rootpath(row["bits"])])
                try:
                    s.validate_cert(f,m,n,h,table,rt.cert_cache,rt.guard,rt.proof_locks)
                    c.check_fingerprint(c.rootpath(row["bits"]),c.read(cp)["bits_binding"],rt.guard)
                finally:lock.close()
                continue
            if n==34:raise ValueError("TERMINAL_LAYER_REQUIRES_PRIOR_CERTIFIED_SEED")
            geometry=s.numbering(row)
            dependencies={c.stem(a,b):s.validate_cert(f,m,a,b,table,rt.cert_cache,rt.guard,rt.proof_locks) for a,b in s.needed(n,h,table)}
            ws=None;failed=True
            try:
                rt.begin(c.stem(n,h)+":immutable_bucket_inputs");ws=s.BucketWorkspace(m,row,table,rt)
                if dependencies!=ws.dependencies:raise ValueError("Dependency identity changed before its read locks")
                locked=ws.locked;schedule,schedule_binding=fr.prepare(f,m,state,row,request,locked,rt)
                if m["backend"]=="linux_fused_joint_indexed_byte_checked_constructor_native_cache_v16" and len(schedule["frames"])>m["scope_lifecycle_policy"]["maximum_single_bucket_frames"]:
                    raise ValueError("SOURCE_BUCKET_FRAME_COUNT_EXCEEDS_BOUNDED_SCOPE_POLICY; choose a supported frame policy before native work")
                identity=dict(source_bits_binding=locked[row["bits"]],dependencies=dependencies,numbering=geometry,
                    frame_schedule_binding=schedule_binding,source_directory_binding=locked[row["directory"]])
                journal=ld.BucketLedger(f,m,request,identity,initialize=True)
                if journal.header["identity"]!=identity:raise ValueError("Immutable durable bucket premises changed")
                def checked_old(item,descriptor):
                    if any(item.get(k)!=v for k,v in identity.items()):raise ValueError("Prior frame premises differ from current locked bucket/dependencies")
                    if item["frame"]["index"]!=descriptor["sequence"]-1:raise ValueError("Durable frames are not the exact canonical prefix")
                journal.walk(checked_old,repair=True,guard=rt.guard)
                pending=schedule["frames"][journal.head["sequence"]:]
                if pending and executed>=args.max_chunks:raise InterruptedError("BOUNDED_CHUNK_COUNT")
                eligible=pending[:max(0,args.max_chunks-executed)];packet_future=None
                fused=m["backend"]=="linux_fused_joint_indexed_byte_checked_constructor_native_cache_v16"
                if eligible:
                    ticket.cleanup_confirmed=False
                    ws.pool=ThreadPoolExecutor(max_workers=2);rt.untracked_service_possible=True
                    if fused:
                        from fused_transport import FusedBucket
                        ws.processor=FusedBucket(m,row,rt,locked);rt.untracked_service_possible=False
                        rt.wait(ws.pool.submit(ws.processor.ready))
                    else:
                        from compact_transport import CompactGPU
                        ws.gpu=CompactGPU(m,row,rt,locked);rt.untracked_service_possible=False
                        gpu_ready=ws.pool.submit(ws.gpu.ready)
                        rotate_if_needed(ws,m,rt,n,h);rt.wait(gpu_ready)
                        first=eligible[0];packet_future=ws.pool.submit(ws.gpu.span,first["start"],first["count"])
                for position,frame in enumerate(eligible):
                    rt.begin(c.stem(n,h)+":"+str(frame["start"]));start,count=frame["start"],frame["count"]
                    following=eligible[position+1] if position+1<len(eligible) else None
                    if not fused:
                        packet=rt.wait(packet_future)
                        if (packet["start"],packet["count"])!=(start,count):raise ValueError("Compact prefetch belongs to another canonical frame")
                        packet_future=ws.pool.submit(ws.gpu.span,following["start"],following["count"]) if following is not None else None
                    if m.get("fault_inject")=="simulated_memory_error_after_commit" and journal.head["sequence"] and not state.get("simulated_memory_error_consumed"):
                        state["simulated_memory_error_consumed"]=True;ld.save_root(f,state)
                        raise MemoryError("SIMULATED_MEMORY_ERROR_AFTER_DURABLE_PREFIX_BEFORE_NEXT_NATIVE_SPAN")
                    proposal=None if fused else packet["provenance"]
                    if m.get("fault_inject")=="bad_n_member" and not fused:
                        source_bits=c.bits_span(c.rootpath(row["bits"]),start,count)
                        offset=next((i for i in range(count) if not ((source_bits[i//8]>>(i%8))&1)),None)
                        if offset is None:raise ValueError("Bad-N control requires an actual N row")
                        word=struct.unpack_from("<Q",packet["compact"],offset*8)[0]
                        if (word>>56)&1:raise ValueError("GPU flag differs from actual N row")
                        struct.pack_into("<Q",packet["compact"],offset*8,(word&~(((1<<20)-1)<<36))|(131676<<38))
                        proposal["negative_control"]=dict(kind="BAD_N_ACTUAL_MEMBER",offset=offset,expected_commit_rows=0)
                    attempt=uuid.uuid4().hex;tmp=paths.attempt(f,attempt)
                    output=tmp/"w.json";log=tmp/"l.json"
                    frame_clock=time.monotonic();rpc_clock=frame_clock
                    if fused:
                        packet=rt.wait(ws.pool.submit(ws.processor.span,start,count,output,log,following));proposal=packet["provenance"]
                    else:
                        rotate_if_needed(ws,m,rt,n,h)
                        rt.wait(ws.pool.submit(ws.session.span,packet,output,log))
                    rpc_seconds=time.monotonic()-rpc_clock
                    commit_clock=time.monotonic()
                    w=c.read(output)
                    expected=dict(schema=m["worker"]["schema"],status=m["worker"]["status"],layer=n,honor=h,start=start,checked_rows=count,threads=m["threads"],plan_checker_kind=lwg.MARKER,actual_successors_all_checked=True)
                    if any(w.get(k)!=v for k,v in expected.items()) or w.get("P_rows",-1)+w.get("N_rows",-1)!=count:raise ValueError("Native checker did not check the exact P/N frame")
                    fp.check_native_work(w,frame,m["frame_policy"])
                    labels_path=Path(str(output)+".labels.bin");labels=labels_path.read_bytes()
                    if m.get("fault_inject")=="bad_packed_label":
                        changed=bytearray(labels);changed[0]^=1;labels=bytes(changed);c.atomic(labels_path,labels)
                    if len(labels)!=(count+7)//8 or (count%8 and labels[-1]>>(count%8)):raise ValueError("Native packed length/padding changed")
                    packed=c.bits_span(c.rootpath(row["bits"]),start,count)
                    if labels!=packed or int.from_bytes(labels,"little").bit_count()!=w["P_rows"]:raise ValueError("Native packed labels differ from actual source table or P count")
                    if state["packed_payload_bytes"]+len(packed)>m["max_packed_payload_bytes"] or shutil.disk_usage(f).free<m["min_free_disk_bytes"]:raise ValueError("LOCAL_PACKED_PAYLOAD_DISK_BUDGET")
                    if sum(p.stat().st_size for p in tmp.iterdir() if p.is_file())>m["max_staging_bytes"]:raise ValueError("Bounded staging disk budget exceeded")
                    durable=f/"c"/c.stem(n,h)/attempt[:16];durable.mkdir(parents=True,exist_ok=False)
                    labelpath=durable/"p.bits";resultpath=durable/"r.json";logpath=durable/"l.json"
                    c.atomic(labelpath,packed);c.atomic(resultpath,output.read_bytes());c.atomic(logpath,log.read_bytes())
                    item=dict(layer=n,honor=h,start=start,count=count,result=c.rel(resultpath),result_sha256=c.sha(resultpath),packed_labels=c.rel(labelpath),
                        packed_binding=dict(bytes=len(packed),sha256=c.sha(labelpath)),P_rows=w["P_rows"],N_rows=w["N_rows"],worker_binding=m["worker"],
                        proposal_provenance=proposal,log=c.rel(logpath),log_sha256=c.sha(logpath),frame=frame,**identity)
                    s.validate_item(m,item,rt.guard,rt.frame_cache,rt.proof_locks)
                    rt.proof_locks.append(c.ReadLocks([labelpath,resultpath,logpath]))
                    item,last=journal.commit(item,state["committed_chunks"]+1)
                    state.update(committed_chunks=state["committed_chunks"]+1,committed_rows=state["committed_rows"]+count,
                        packed_payload_bytes=state["packed_payload_bytes"]+len(packed),last_commit=last)
                    executed+=1;ld.save_root(f,state)
                    for path in tmp.iterdir():
                        if path.is_file():c.remove_temporary(path,tmp)
                    packet=None;rt.report()
                    # Diagnostic timing is outside the mathematical commit.
                    # A crash before this small receipt cannot revoke the
                    # already fsynced ledger head or claim unmeasured speed.
                    c.atomic(f/"timings"/(c.stem(n,h)+f"_{state['committed_chunks']:08}_{attempt[:8]}.json"),
                        dict(schema="ACTUAL_GENERATED_PRODUCTION_COMMIT_WALL_V12",layer=n,honor=h,start=start,count=count,
                            last_commit=last,worker_binding=m["worker"],native_checker_kind=lwg.MARKER,
                            root_RPC_wall_seconds=rpc_seconds,packed_validate_fsync_ledger_root_cleanup_report_seconds=time.monotonic()-commit_clock,
                            root_frame_wall_before_diagnostic_save_seconds=time.monotonic()-frame_clock,
                            sample_prefix_is_not_used_as_production_ledger=True,
                            timing_receipt_save_itself_is_additionally_in_invocation_wall=True))
                if len(eligible)<len(pending):raise InterruptedError("BOUNDED_CHUNK_COUNT")
                # A normal full-bucket certificate is issued only after this
                # invocation's native STOP/EOF and content-identical cache IO
                # lifecycle has been checked. An interrupted accepted prefix
                # remains valid without fabricating normal epoch accounting.
                bucket_close_clock=time.monotonic();processor=ws.processor
                ws.close(abort=False);ws=None
                normal_leave_seconds=time.monotonic()-bucket_close_clock
                normal_io=getattr(processor,"normal_close_evidence",None)
                if fused:scopes.after_bucket(rt,m)
                if request["start"]==0 and request["count"]==row["size"] and journal.head["next_start"]==row["size"]:
                    certificate_clock=bucket_close_clock
                    # All head entries were validated on resume or in this run;
                    # snapshot and walk enforce exact unique full-bucket cover.
                    journal.walk(checked_old,guard=rt.guard)
                    snapshot=journal.snapshot(rt.proof_locks)
                    cert=dict(schema="V4_COMPLETE_BUCKET_CERTIFICATE",kind="CHECKED_EXACT_NATIVE_LEDGER_COVERAGE",layer=n,honor=h,size=row["size"],
                        dataset_sha256=m["dataset_sha256"],complete_unique_coverage=[0,row["size"]],bits=row["bits"],bits_binding=identity["source_bits_binding"],
                        dependencies=dependencies,numbering=geometry,frame_schedule_binding=schedule_binding,source_directory_binding=identity["source_directory_binding"],
                        ledger_snapshot=snapshot,worker_binding=m["worker"],campaign_manifest_sha256=state["manifest_sha256"],
                        current_invocation_normal_IO_lifecycle=normal_io)
                    c.atomic(cp,cert)
                    c.atomic(f/"bucket_timings"/(c.stem(n,h)+"_"+str(time.time_ns())+".json"),
                        dict(schema="ACTUAL_GENERATED_PRODUCTION_BUCKET_CERTIFICATE_WALL_V12",layer=n,honor=h,
                            worker_binding=m["worker"],manifest_sha256=state["manifest_sha256"],
                            certificate_registry_wall_seconds=time.monotonic()-certificate_clock,
                            normal_leave_STOP_EOF_cache_validation_wall_seconds=normal_leave_seconds,
                            certificate=c.rel(cp),certificate_sha256=c.sha(cp),frames=journal.head["sequence"],size=row["size"],
                            current_invocation_normal_IO_lifecycle=normal_io,
                            sequential_ledger_walk_snapshot_and_certificate_save_included=True,
                            normal_IO_lifecycle_and_native_shutdown_included=True,
                            conservative_surcharge_without_deducting_sampler_bucket_leave=True))
                failed=False
            finally:
                if ws is not None:
                    ws.close(abort=failed)
                    if not rt.untracked_service_possible and (rt.cross_gpu is None or rt.cross_gpu.exit_confirmed):ticket.cleanup_confirmed=True
        expected={(n,h,0,r["size"]) for (n,h),r in table.items() if r["size"]};actual={(r["layer"],r["honor"],r["start"],r["count"]) for r in m["requests"]}
        pending_expected={x for x in expected if x[0]<=31}
        if actual==expected or (actual==pending_expected and m.get("complete_bucket_reuse")):
            opening_request=next(r for r in m["requests"] if (r["layer"],r["honor"])==(0,0));opening=ld.BucketLedger(f,m,opening_request).walk()[0]
            assertions=finite.final(m,lambda n,h:s.validate_cert(f,m,n,h,table,rt.cert_cache,rt.guard,rt.proof_locks),
                c.rootpath(opening["packed_labels"]).read_bytes(),finite_validation)
            registry=assertions["complete_bucket_registry"];counts=assertions["geometry"]
            c.atomic(f/"full_table_acceptance.json",dict(schema="V4_COMPLETE_COMPILED_LEAN_CROSS_LAYER_DAG",status="PASS_COMPLETE_FROZEN_PREMISE_DAG",
                manifest_sha256=state["manifest_sha256"],exact_unique_rows=counts["total_rows"],nonempty_buckets=counts["nonempty_buckets"],empty_prefix_buckets=counts["empty_prefix_buckets"],complete_bucket_registry=registry,
                finalizer_assertions=assertions,finite_premise_validation=finite_validation,
                trust_boundary="Compiled Lean checker, frozen finite premises, audited Python scheduler/IO and native compiler",
                empty_state_label=assertions["empty_state_label"]))
            state["full_table_verification"]="PASS_COMPLETE_FROZEN_PREMISE_DAG"
        else:state["full_table_verification"]="NOT_VERIFIED"
        state["state"]="COMPLETE_EXACT_REQUESTED_SCOPE"
    except InterruptedError as error:state.update(state="PAUSED_SAFE_BOUND_OR_STOP",reason=str(error))
    except BaseException as error:state.update(state="PAUSED_ERROR_NO_UNCHECKED_PROGRESS_COMMITTED",error=repr(error));raise
    finally:
        rt.begin("cleanup",cleanup=True)
        cleanup_failure=None
        cleanup_clock=time.monotonic()
        try:
            if rt.cross_gpu is not None:rt.cross_gpu.close(abort=state["state"]!="COMPLETE_EXACT_REQUESTED_SCOPE")
            if not rt.untracked_service_possible:ticket.cleanup_confirmed=True
        except BaseException as cleanup_error:
            ticket.cleanup_confirmed=False
            state.update(state="PAUSED_OWNED_GPU_CLEANUP_UNCONFIRMED",cleanup_error=repr(cleanup_error))
            cleanup_failure=cleanup_error
        if revalidation is not None:invocation["strict_item_revalidation_timings"]=revalidation.close()
        invocation.update(final_owned_cleanup_wall_seconds=time.monotonic()-cleanup_clock,
            wall_seconds=time.monotonic()-rt.began,executed_chunks=executed,state=state["state"],all_owned_services_confirmed_exited=ticket.cleanup_confirmed)
        event=f/"invocations"/(ticket.ticket["token"]+".json");c.atomic(event,invocation)
        state.update(invocation_count=state.get("invocation_count",0)+1,last_invocation=c.rel(event));ld.save_root(f,state);rt.report(True)
        if ticket.cleanup_confirmed:
            for lock in reversed(rt.proof_locks+rt.unconfirmed_locks):lock.close()
            rt.unconfirmed_locks.clear()
        else:rt.unconfirmed_locks.extend(rt.proof_locks)
        print(json.dumps(dict(state=state["state"],executed_chunks=executed,committed_rows=state["committed_rows"],committed_chunks=state["committed_chunks"],budget_used_seconds=state["budget_used_seconds"])),flush=True)
        if cleanup_failure:raise cleanup_failure
