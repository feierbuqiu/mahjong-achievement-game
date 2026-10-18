"""Bounded real production phases; no outer Job or work on import.

Repeat a deferred phase with its reported --name. A simulated allocation error
is graceful owned cleanup after a durable commit, not a power-loss test. Every
resume/NOOP must actually finish before its corresponding control is PASS.
"""
from pathlib import Path
import argparse,json,math,os,subprocess,sys,time,uuid
import campaign_io as c
import campaign as s


def require(value,message):
    if not value:raise ValueError(message)


MAX_PHASE_SECONDS=600
MAX_INVOCATION_SECONDS=300
MINIMUM_REMAINING_SECONDS=90


def validate_phase_window(seconds):
    require(type(seconds) in (int,float) and math.isfinite(seconds) and 100<=seconds<=MAX_PHASE_SECONDS,
        "Use a bounded100..600-second functional phase window")


def invocation_window(remaining):
    require(type(remaining) in (int,float) and math.isfinite(remaining),"Finite phase time remaining is required")
    if remaining<=MINIMUM_REMAINING_SECONDS:
        raise InterruptedError("DEFER_WITHOUT_30S_SETUP_WORK_PLUS60S_CLEANUP; repeat phase with the same --name")
    return min(MAX_INVOCATION_SECONDS,remaining-1)


def binding(path):return dict(path=c.rel(path),bytes=path.stat().st_size,sha256=c.sha(path))


def main(args):
    require(args.execute_authorized_window,"An exclusive root-authorized hardware window is required")
    validate_phase_window(args.max_wall_seconds)
    require(args.threads==12,"Only the fresh104/one-byte 12-thread profile is accepted")
    began=time.monotonic();deadline=began+args.max_wall_seconds;tag=uuid.uuid4().hex[:8]
    out=c.RUN/"functional"/(args.phase+"_"+tag);out.mkdir(parents=True,exist_ok=False)
    steps=[];folders=[];name=args.name or ("g"+args.phase[:2]+tag[:6])
    s.folder(name)
    statefile=c.RUN/"functional_states"/(name+".json")
    test=c.read(statefile) if statefile.exists() else dict(phase=args.phase,name=name,cases=[],flags={})
    require(test["phase"]==args.phase,"A test name cannot be reused for another phase")
    def case(key,text):
        if key not in test["flags"]:test["cases"].append(dict(id=key,description=text,status="PASS_ACTUAL"))
        test["flags"][key]=True;c.atomic(statefile,test)
    def invoke(argv,label,allow_error=False):
        path=out/(label+".log");tick=time.monotonic()
        with path.open("xb") as log:
            result=subprocess.run([sys.executable,"-B",*map(str,argv)],cwd=c.ROOT,stdout=log,stderr=subprocess.STDOUT,
                env=dict(os.environ,PYTHONUTF8="1",PYTHONDONTWRITEBYTECODE="1"),creationflags=subprocess.CREATE_NO_WINDOW)
            log.flush();os.fsync(log.fileno())
        steps.append(dict(label=label,returncode=result.returncode,wall_seconds=time.monotonic()-tick,log=binding(path)))
        c.atomic(out/"progress.json",dict(state="ACTUAL_BOUNDED_PRODUCTION_PHASE",steps=steps,elapsed_seconds=time.monotonic()-began))
        if result.returncode and not allow_error:raise RuntimeError(label+": "+path.read_text(encoding="utf-8")[-3000:])
        return result.returncode
    def plan(local_name,buckets,chunk=67108864,fault=None,reuse=False,seed=True,count=None):
        folder=s.folder(local_name)
        if folder not in folders:folders.append(folder)
        if not (folder/"manifest.json").exists():
            argv=[c.BASE/"campaign.py","plan","--name",local_name,"--worker-gate",Path(args.worker_gate).resolve(),
                "--backend",s.lwg.BACKEND,"--protocol",s.lwg.PROTOCOL,"--threads",12,"--chunk",chunk]
            for n,h in buckets:argv += ["--bucket",n,h]
            if count is not None:argv += ["--count",count]
            if fault:argv += ["--fault-inject",fault]
            if reuse:argv += ["--reuse-layer32-v5"]
            invoke(argv,"plan_"+local_name)
            if seed:invoke([c.BASE/"campaign.py","seed-tail","--name",local_name],"seed_"+local_name)
        m=c.read(folder/"manifest.json")
        wanted={(n,h) for n,h in buckets}
        require({(r["layer"],r["honor"]) for r in m["requests"]}==wanted and m["backend"]==s.lwg.BACKEND and
            m["worker"]["checker_kind"]==s.lwg.MARKER and m["pure_kernel_theorem_count"]==104 and m["threads"]==12 and m["fault_inject"]==fault,
            "Existing phase manifest changed its source/worker/fault identity")
        test.setdefault("campaign_manifests",{})[local_name]=binding(folder/"manifest.json");c.atomic(statefile,test)
        return folder
    def run(folder,chunks,label,allow_error=False):
        remaining=deadline-time.monotonic()
        maximum=invocation_window(remaining)
        invoke([c.BASE/"launch_campaign.py","--name",folder.name,"--max-seconds",maximum,"--max-chunks",chunks],label,allow_error)
        budget=c.read(folder/"runtime_budget.json")
        require(budget["reservation"] is None,"A phase cannot continue while a previous owned service retains its reservation")
        for path in (folder/"launches").glob("*.json"):
            require(c.read(path).get("all_owned_services_confirmed_exited") is True,"Owned subtree exit is unconfirmed")
        return c.read(folder/"checkpoint.json")
    status="PASS_ACTUAL_BOUNDED_INDEXED_BYTE_PRODUCTION_PHASE_V16";deferred=None
    try:
        if args.phase=="crash":
            f=plan(name,[(31,148)],fault="simulated_memory_error_after_commit",reuse=True,count=3*67108864)
            cp=c.read(f/"checkpoint.json")
            if not test["flags"].get("allocation_prefix"):
                require(cp["committed_rows"]==0,"A new failure control must start before its first checked row")
                first=run(f,16,"simulated_allocation_failure_after_commit",True)
                require(first["committed_rows"]==67108864 and first.get("simulated_memory_error_consumed") is True and
                    "SIMULATED_MEMORY_ERROR" in first.get("error",""),"The actual simulated failure did not retain exactly its64Mi-row prefix")
                line=(f/"ledgers/n31_h148/journal.jsonl").read_bytes().splitlines()[0]
                receipt=c.rootpath(json.loads(line)["payload"]["receipt"]["path"])
                test["first_line_sha256"]=__import__("hashlib").sha256(line).hexdigest();test["first_receipt"]=binding(receipt)
                case("allocation_prefix","Simulated post-commit allocation error retained67108864 durable rows and confirmed owned cleanup; no power-loss claim")
            if not test["flags"].get("actual_resume_complete"):
                done=run(f,16,"actual_resume_after_failure")
                require(done["state"]=="COMPLETE_EXACT_REQUESTED_SCOPE" and done["committed_rows"]==3*67108864,"The actual same-manifest resume has not completed")
                first=(f/"ledgers/n31_h148/journal.jsonl").read_bytes().splitlines()[0]
                require(__import__("hashlib").sha256(first).hexdigest()==test["first_line_sha256"],"The original durable prefix changed")
                c.check_fingerprint(c.rootpath(test["first_receipt"]["path"]),test["first_receipt"])
                case("actual_resume_complete","Actual resume completed exact201326592 unique rows with the first receipt unchanged")
            if not test["flags"].get("actual_NOOP"):
                head=c.read(f/"ledgers/n31_h148/head.json");done=run(f,0,"actual_complete_NOOP")
                require(done["committed_rows"]==3*67108864 and c.read(f/"ledgers/n31_h148/head.json")==head and
                    c.read(c.rootpath(done["last_invocation"]))["executed_chunks"]==0,"Completed NOOP executed work or changed the durable head")
                case("actual_NOOP","Completed actual NOOP executed zero native rows and preserved the durable head")
        elif args.phase=="chain":
            f=plan(name,[(32,89),(32,165)])
            if not test["flags"].get("STOP_retains_prefix"):
                current=c.read(f/"checkpoint.json")
                if current["committed_rows"]==0:current=run(f,1,"first_chain_prefix")
                require(current["committed_rows"]==56,"STOP trial requires exactly the first56 durable rows")
                head=c.read(f/"ledgers/n32_h089/head.json");c.atomic(f/"STOP",b"bounded production STOP\n")
                try:
                    stopped=run(f,16,"actual_STOP",True)
                    require(stopped["committed_rows"]==56 and c.read(f/"ledgers/n32_h089/head.json")==head,"STOP changed the durable prefix")
                finally:
                    if (f/"STOP").exists():(f/"STOP").unlink()
                case("STOP_retains_prefix","Actual STOP launched no new native frame and preserved the original56-row prefix")
            if not test["flags"].get("actual_two_bucket_chain"):
                done=run(f,16,"actual_two_bucket_resume")
                require(done["state"]=="COMPLETE_EXACT_REQUESTED_SCOPE" and done["committed_rows"]==62,"The genuine33→32 two-bucket chain did not complete")
                for h in (89,165):s.validate_cert(f,c.read(f/"manifest.json"),32,h,s.slots())
                case("actual_two_bucket_chain","Both exact n32 buckets completed under the independently certified33 tail")
        elif args.phase=="negatives":
            for key,fault,seed,suffix in (("bad_N_index_zero_commit","bad_n_member",True,"n"),
                    ("bad_packed_zero_commit","bad_packed_label",True,"p"),("missing_tail_zero_commit",None,False,"t")):
                f=plan(name+suffix,[(32,89)],fault=fault,seed=seed)
                if not test["flags"].get(key):
                    done=run(f,1,key,True)
                    require(done["committed_rows"]==done["committed_chunks"]==0 and not s.certpath(f,32,89).exists(),"A negative case committed unchecked progress")
                    if fault=="bad_n_member":
                        sessions=[c.rootpath(c.read(p)["session_dir"]) for p in (f/"sessions").glob("*.config.json")]
                        stderr="\n".join(p.read_text(encoding="utf-8",errors="replace") for d in sessions for p in d.glob("*.stderr.log"))
                        require("REJECTED_INDEXED_BYTE_ROW" in stderr,"Bad actualnext ordinal was not rejected by the compiled new Native")
                        injections=[c.read(p) for d in sessions for p in d.glob("fault_*.json")]
                        require(len(injections)==1,"The new byte-index negative needs its exact one injection record")
                        x=injections[0];offset=x["offset"]
                        require(x["schema"]=="INDEXED_BYTE_UNTRUSTED_NEGATIVE_INJECTION_V16" and
                            x["fault"]=="bad_n_ordinal" and x["only_untrusted_proposal_bytes_modified"] is True and
                            (x["layer"],x["honor"],x["start"],x["count"])==(32,89,0,56) and
                            type(offset) is int and 0<=offset<56,"Wrong bounded source/ordinal injection provenance")
                        labels=c.bits_span(c.rootpath(s.slots()[32,89]["bits"]),0,56)
                        old,new=x["original_proposal_byte"],x["injected_byte"]
                        require(not ((int.from_bytes(labels,"little")>>offset)&1) and type(old) is int and 0<=old<128 and
                            new==(old//32)*32+31,"The negative did not select an actual sourceN and corrupt its list ordinal")
                    elif fault:require("packed labels differ" in done.get("error",""),"Bad packed data was not rejected by the actual source comparison")
                    else:
                        require(not list((f/"sessions").glob("*.scope.json")),"Missing complete target tail was not rejected before owned native/GPU launch")
                    case(key,"Actual "+key+" rejected with zero committed rows and owned cleanup confirmed")
        else:
            f=plan(name,[(31,148)],chunk=67108864,reuse=True)
            if not test["flags"].get("four_canonical_frames"):
                current=c.read(f/"checkpoint.json");remaining=4-current["committed_chunks"]
                require(0<=remaining<=4,"Prefix trial cannot execute more than four canonical native frames")
                done=run(f,remaining,"actual_four_canonical_frames") if remaining else current
                frames=c.read(f/"frames/n31_h148.json")["frames"]
                require(done["committed_chunks"]==4 and done["committed_rows"]==sum(x["count"] for x in frames[:4]) and
                    not s.certpath(f,31,148).exists(),"Four-frame prefix did not preserve exact coverage without full-bucket promotion")
                case("four_canonical_frames","Four actual complete canonical n31h148 frames checked under true imported32 targets; partial bucket remains uncertified")
            if not test["flags"].get("actual_full_frame_revalidation"):
                before=c.read(f/"checkpoint.json");done=run(f,0,"actual_strict_prefix_revalidation_zero_new_native")
                inv=c.read(c.rootpath(done["last_invocation"]));timing=inv["strict_item_revalidation_timings"]
                c.check_fingerprint(c.rootpath(timing["path"]),timing)
                entries=[json.loads(x) for x in c.rootpath(timing["path"]).read_bytes().splitlines()]
                require(len(entries)==4 and inv["executed_chunks"]==0 and done["committed_rows"]==before["committed_rows"] and
                    all(x["full_actual_validate_item_called"] is True and x["additional_Native_or_GPU_rows"]==0 for x in entries),
                    "Actual strict revalidation of all four accepted canonical frames is missing")
                case("actual_full_frame_revalidation","All four full canonical payloads were actually rehashed/revalidated in the single inherited5% Job, with zero additional native rows")
    except InterruptedError as error:
        status="PARTIAL_BOUNDED_PHASE_PENDING_ACTUAL_FOLLOWUP";deferred=repr(error)
    summaries=[]
    for folder in folders:
        cp=c.read(folder/"checkpoint.json");budget=c.read(folder/"runtime_budget.json")
        require(budget["reservation"] is None,"An unconfirmed cleanup cannot become a functional acceptance")
        summaries.append(dict(name=folder.name,manifest=binding(folder/"manifest.json"),checkpoint=binding(folder/"checkpoint.json"),
            state=cp["state"],committed_rows=cp["committed_rows"],committed_frames=cp["committed_chunks"],
            charged_invocation_wall_seconds=budget["charged_seconds"],all_owned_services_confirmed_exited=True,
            frame_timings=[binding(p) for p in sorted((folder/"timings").glob("*.json"))],
            bucket_timings=[binding(p) for p in sorted((folder/"bucket_timings").glob("*.json"))],
            scope_timings=[binding(p) for p in sorted((folder/"scope_timings").glob("*.json"))],
            revalidation_timings=[binding(p) for p in sorted((folder/"revalidation_timings").glob("*.jsonl"))],
            invocation_receipts=[binding(p) for p in sorted((folder/"invocations").glob("*.json"))]))
    report=dict(schema="ACTUAL_INDEXED_BYTE_PRODUCTION_CONTROLLER_BOUNDED_PHASE_V16",status=status,phase=args.phase,
        name=name,cases=test["cases"],deferred=deferred,steps=steps,campaigns=summaries,threads=12,
        backend=s.lwg.BACKEND,pure_kernel_theorem_count=104,transport="indexed_actual_next_byte_v16",record_bytes=1,
        plan_constructor_kind="PROVED_ONCE_CHECKED_TEMPLATE_CONSTRUCTOR_V16",small_plan_serial_template_threshold=4096,
        row_checker_kind="PROVED_INDEXED_NEXT_BYTE_SCALAR_SCAN_V16",
        simulated_error_is_not_power_loss_or_forced_kill=True,outer_harness_creates_no_Job=True,
        all_owned_services_confirmed_exited=True,full_campaign_started=False,full_launch_allowed=False,full_table_Lean="NOT_VERIFIED",
        wall_seconds=time.monotonic()-began,normal_phase_window_seconds=args.max_wall_seconds,
        maximum_individual_invocation_seconds=MAX_INVOCATION_SECONDS,cleanup_reserve_inside_each_invocation_seconds=60,
        source_binding=c.bind(list(c.BASE.glob("*.py"))))
    c.atomic(out/"acceptance.json",report)
    print(json.dumps(dict(status=status,name=name,repeat_deferred_phase_with_same_name=True,
        receipt=binding(out/"acceptance.json"),new_hardware_window_requires_root_coordination=True)),flush=True)
    return 0 if status.startswith("PASS") else 2


if __name__=="__main__":
    p=argparse.ArgumentParser();p.add_argument("--execute-authorized-window",action="store_true")
    p.add_argument("--phase",choices=("crash","chain","negatives","prefix31"),required=True)
    p.add_argument("--name",help="Resume the exact same test phase after a bounded deferred extension")
    p.add_argument("--worker-gate",default=str(s.WORKER_GATE));p.add_argument("--threads",type=int,choices=(12,),default=12)
    p.add_argument("--max-wall-seconds",type=float,default=600)
    raise SystemExit(main(p.parse_args()))
