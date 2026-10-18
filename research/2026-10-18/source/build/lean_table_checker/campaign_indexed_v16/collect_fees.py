"""Collect actual bounded production observations; never authorize a full run.

The separate evaluator recomputes conservative costs from this bound raw basis.
It must supply actual full-scope setup and a positive retry policy; neither is
invented by this collector. No Job, GPU, Native or WSL process is started.
"""
import argparse,json,math,uuid
from pathlib import Path
import campaign_io as c
import campaign as s
import linux_worker_gate as gate
import ledger as ld


def require(value,message):
    if not value:raise ValueError(message)


def binding(path):return dict(path=c.rel(path),bytes=path.stat().st_size,sha256=c.sha(path))


def number(value):return type(value) in (int,float) and math.isfinite(value) and value>=0


def collect(args):
    profile_path=Path(args.profile).resolve();profile=c.read(profile_path)
    measured_assets={v["path"]:v for v in profile.get("code_and_proof_bindings",[])}
    require(profile.get("schema")=="OVERNIGHT_V16_JOINT_INDEXED_REGISTERED_CALIBRATION_PROFILE" and profile.get("threads")==12 and
        profile.get("worker_executable_sha256")==measured_assets.get(profile.get("worker_executable"),{}).get("sha256") and
        profile.get("worker_executable_sha256")=="da0877df4d5be177516a405c93b62cac457a04ea40e479010fc70588a44438c6" and
        profile.get("pure_theorem_fingerprints")==104 and profile.get("backend")==gate.BACKEND and
        profile.get("transport")=="indexed_actual_next_byte_v16" and profile.get("record_bytes")==1 and
        profile.get("native_candidate")==gate.CANDIDATE_IDENTITY and
        profile.get("accounting_contract")=="ENTIRE_NATIVE_EPOCH_FIRST_PLAN_PLUS_ALL_STEADY_T_INDEXED_V16",
        "Use the actual final joint104/one-byte sampled profile")
    require(len(measured_assets)==len(profile["code_and_proof_bindings"]),"Repeated measured code bindings are not an exact profile")
    out=c.RUN/"fee_observations"/uuid.uuid4().hex[:12];out.mkdir(parents=True,exist_ok=False)
    reports=[];by_phase={};assets=[profile_path]
    for path in map(lambda p:Path(p).resolve(),args.functional):
        value=c.read(path)
        require(value.get("schema")=="ACTUAL_INDEXED_BYTE_PRODUCTION_CONTROLLER_BOUNDED_PHASE_V16" and
            value.get("status")=="PASS_ACTUAL_BOUNDED_INDEXED_BYTE_PRODUCTION_PHASE_V16" and value.get("threads")==12 and
            value.get("backend")==gate.BACKEND and value.get("pure_kernel_theorem_count")==104 and
            value.get("transport")=="indexed_actual_next_byte_v16" and value.get("record_bytes")==1 and
            value.get("plan_constructor_kind")=="PROVED_ONCE_CHECKED_TEMPLATE_CONSTRUCTOR_V16" and
            value.get("row_checker_kind")=="PROVED_INDEXED_NEXT_BYTE_SCALAR_SCAN_V16" and
            value.get("all_owned_services_confirmed_exited") is True and value.get("outer_harness_creates_no_Job") is True,
            "An unfinished or differently profiled phase cannot supply actual fee/readiness evidence")
        require(value["phase"] not in by_phase,"Select one final completed acceptance per phase")
        by_phase[value["phase"]]=value;reports.append(binding(path));assets.append(path)
        for name,identity in value["source_binding"].items():c.check_fingerprint(c.rootpath(name),identity)
    require(set(by_phase)=={"crash","chain","negatives","prefix31"},"Actual crash/resume/NOOP, STOP/chain, negatives and four-frame prefix phases are all required")
    expected={"allocation_prefix","actual_resume_complete","actual_NOOP","STOP_retains_prefix","actual_two_bucket_chain",
        "bad_N_index_zero_commit","bad_packed_zero_commit","missing_tail_zero_commit","four_canonical_frames","actual_full_frame_revalidation"}
    require(expected<={x["id"] for report in by_phase.values() for x in report["cases"]},"A required actual control never completed")
    frame_records=[];bucket_records=[];scope_records=[];invocations=[]
    for report in by_phase.values():
        for campaign in report["campaigns"]:
            manifest_record=campaign["manifest"];c.check_fingerprint(c.rootpath(manifest_record["path"]),manifest_record)
            folder=c.rootpath(manifest_record["path"]).parent;m=c.read(folder/"manifest.json")
            require(m["backend"]==gate.BACKEND and m["native_checker_kind"]==gate.MARKER and m["worker"]["sha256"]==profile["worker_executable_sha256"] and
                m["threads"]==12 and m["pure_kernel_theorem_count"]==104 and m["payload_bytes_per_row"]==1,
                "Production observations changed actual execution profile")
            if report["phase"]=="prefix31":require(m["frame_policy"]==profile["partition_policy"],"Full-frame fee observations changed canonical frame policy")
            for kind,target in (("bucket_timings",bucket_records),("scope_timings",scope_records),("invocation_receipts",invocations)):
                for item in campaign[kind]:c.check_fingerprint(c.rootpath(item["path"]),item);target.append(item)
            if report["phase"]!="prefix31":continue
            request=next(r for r in m["requests"] if (r["layer"],r["honor"])==(31,148))
            journal=ld.BucketLedger(folder,m,request);items=journal.walk()
            require(len(items)==4,"Only four actual full canonical production frames are used as the fee basis")
            repeated={}
            for source in campaign["revalidation_timings"]:
                c.check_fingerprint(c.rootpath(source["path"]),source)
                for line_index,line in enumerate(c.rootpath(source["path"]).read_bytes().splitlines()):
                    value=json.loads(line)
                    require(value["schema"]=="ACTUAL_GENERATED_STRICT_ITEM_REVALIDATION_WALL_V12" and value["full_actual_validate_item_called"] is True and
                        value["additional_Native_or_GPU_rows"]==0 and number(value["strict_item_revalidation_wall_seconds"]),"Unbound or missing actual strict revalidation timer")
                    key=(value["layer"],value["honor"],value["start"],value["count"])
                    old=repeated.get(key)
                    if old is None or old["value"]["strict_item_revalidation_wall_seconds"]<value["strict_item_revalidation_wall_seconds"]:
                        repeated[key]=dict(value=value,stream=source,line_index=line_index)
            timings={}
            for source in campaign["frame_timings"]:
                c.check_fingerprint(c.rootpath(source["path"]),source);value=c.read(c.rootpath(source["path"]))
                require(value.get("schema")=="ACTUAL_GENERATED_PRODUCTION_COMMIT_WALL_V12" and number(value.get("packed_validate_fsync_ledger_root_cleanup_report_seconds")),
                    "The actual complete production post-RPC pipeline was not timed")
                timings[value["layer"],value["honor"],value["start"],value["count"]]=(source,value)
            for item in items:
                key=(item["layer"],item["honor"],item["start"],item["count"])
                require(key in timings and key in repeated,"Every measured full frame needs an actual strict revalidation observation")
                source,value=timings[key];repeat=repeated[key]
                require(repeat["value"]["result"]==item["result"] and repeat["value"]["result_sha256"]==item["result_sha256"] and
                    repeat["value"]["packed_binding"]==item["packed_binding"],"Revalidation measured another payload")
                raw=dict(value,strict_item_revalidation_wall_seconds=repeat["value"]["strict_item_revalidation_wall_seconds"],
                    original_frame_timing=source,strict_revalidation_basis={k:repeat[k] for k in ("stream","line_index")},
                    actual_canonical_frame=item["frame"],actual_item_result=dict(path=item["result"],sha256=item["result_sha256"]),
                    conservative_ledger_fee_basis_seconds=value["packed_validate_fsync_ledger_root_cleanup_report_seconds"]+repeat["value"]["strict_item_revalidation_wall_seconds"],
                    sampler_baseline_post_RPC_cost_not_deducted=True)
                path=out/("f"+str(len(frame_records))+".json");c.atomic(path,raw);frame_records.append(binding(path))
    for source in bucket_records:
        value=c.read(c.rootpath(source["path"]))
        require(value["schema"]=="ACTUAL_GENERATED_PRODUCTION_BUCKET_CERTIFICATE_WALL_V12" and number(value["certificate_registry_wall_seconds"]),"Actual certificate/registry cost missing")
    for source in scope_records:
        value=c.read(c.rootpath(source["path"]))
        require(value["schema"]=="ACTUAL_GENERATED_PRODUCTION_SCOPE_WALL_V12" and value["phase"] in ("construct","confirmed_close") and number(value["wall_seconds"]),"Actual scope lifecycle timer missing")
        if value["phase"]=="confirmed_close":require(value["all_owned_services_confirmed_exited"] is True,"A partial scope close cannot supply a cleanup fee")
    require(frame_records and bucket_records and scope_records,"Unmeasured production components cannot be substituted with zero")
    result=dict(schema="ACTUAL_GENERATED_PRODUCTION_FEE_OBSERVATIONS_V12",status="MEASURED_RAW",profile=binding(profile_path),
        backend=gate.BACKEND,transport="indexed_actual_next_byte_v16",record_bytes=1,
        pure_kernel_theorem_count=104,worker_executable_sha256=profile["worker_executable_sha256"],
        native_candidate=profile["native_candidate"],accounting_contract=profile["accounting_contract"],
        source_binding=c.bind(list(c.BASE.glob("*.py"))),
        frame_timings=frame_records,bucket_timings=list({x["path"]:x for x in bucket_records}.values()),
        scope_timings=list({x["path"]:x for x in scope_records}.values()),functional_acceptances=reports,
        invocation_receipts=list({x["path"]:x for x in invocations}.values()),
        unmeasured_components_still_required=["fullscope_phasezero_whole_setup_charge","explicit_positive_retry_count_policy"],
        new_Native_or_GPU_rows=0,no_Job_created=True,allow_full_run=False,full_table_Lean="NOT_VERIFIED")
    c.atomic(out/"observations.json",result);print(json.dumps(binding(out/"observations.json")))


if __name__=="__main__":
    p=argparse.ArgumentParser();p.add_argument("--profile",required=True);p.add_argument("--functional",action="append",required=True)
    collect(p.parse_args())
