"""Explicit immutable candidate selection; no name implies memory stability.

The long-session report is a reviewed performance prerequisite. It never
certifies historical target labels or replaces the unchanged 28 row theorems.
"""
from pathlib import Path
import campaign_io as c

SCHEMA="OWNED_PACKED_WORKER_GATE_V4"
STATUS="ACCEPTED_FOR_BOUNDED_PRODUCTION_FUNCTIONAL_TEST"
NATIVE_SCHEMA="PACKED_COMPACT_LARGE_FRAME_LEAN_PERSISTENT_SPAN_V14"
NATIVE_STATUS="PASS_COMPILED_LEAN_PACKED_COMPACT_LARGE_FRAME_PERSISTENT_SPAN"

def restart_policy(value=None):
    if value is None:value=dict(schema="OWNED_BOUNDED_NATIVE_EPOCH_POLICY_V4",max_spans=32,rotate_before_next_frame_private_bytes=9_000_000_000,
        STOP_EOF_and_OS_exit_required=True,GPU_session_survives_native_epochs=True,heap_leak_fixed_claimed=False)
    if value.get("schema")!="OWNED_BOUNDED_NATIVE_EPOCH_POLICY_V4" or isinstance(value.get("max_spans"),bool) or not isinstance(value.get("max_spans"),int) or not 1<=value["max_spans"]<=32:
        raise ValueError("Native epoch span policy exceeds its explicit stable envelope")
    if not isinstance(value.get("rotate_before_next_frame_private_bytes"),int) or not 0<value["rotate_before_next_frame_private_bytes"]<=9_000_000_000:raise ValueError("Native epoch private-memory policy exceeds its explicit envelope")
    fixed=dict(STOP_EOF_and_OS_exit_required=True,GPU_session_survives_native_epochs=True,heap_leak_fixed_claimed=False)
    if any(value.get(k)!=v for k,v in fixed.items()) or set(value)!={"schema","max_spans","rotate_before_next_frame_private_bytes",*fixed}:raise ValueError("Altered native epoch lifecycle contract")
    return value

def discover(path):
    path=Path(path).resolve();gate=c.read(path)
    if gate.get("schema")!=SCHEMA or gate.get("status")!=STATUS:raise ValueError("WORKER_LONG_SESSION_STABILITY_NOT_ACCEPTED; no native/GPU campaign may start")
    for key in ("build","small_acceptance","stability_report"):
        record=gate.get(key,{})
        if not isinstance(record.get("sha256"),str) or len(record["sha256"])!=64 or not isinstance(record.get("bytes"),int) or record["bytes"]<=0:raise ValueError("Candidate evidence needs exact path/bytes/SHA")
        c.rootpath(record["path"])
    build_path=c.rootpath(gate["build"]["path"]);build=c.read(build_path)
    if build.get("status")!="PASS" or not build.get("native"):raise ValueError("Candidate lacks a completed actual native build")
    exe=Path(build["executable"]);exe=exe if exe.is_absolute() else c.ROOT/exe
    if not exe.resolve().is_relative_to(c.ROOT.resolve()):raise ValueError("Native candidate outside workspace")
    assets=[path,build_path,c.rootpath(gate["small_acceptance"]["path"]),c.rootpath(gate["stability_report"]["path"]),exe]
    report=c.read(c.rootpath(gate["stability_report"]["path"]))
    assets.extend(c.rootpath(p) for p in report.get("evidence_files",{}))
    return gate,build,assets

def validate_locked(path,gate,build,binding):
    if c.read(path)!=gate:raise ValueError("Candidate gate changed before immutable code locks")
    for key in ("build","small_acceptance","stability_report"):
        record=gate[key]
        if binding.get(record["path"])!=dict(bytes=record["bytes"],sha256=record["sha256"]):raise ValueError("Locked candidate evidence does not match explicit gate")
    if c.read(c.rootpath(gate["build"]["path"]))!=build:raise ValueError("Candidate build changed during gate acquisition")
    exe=Path(build["executable"]);exe=exe if exe.is_absolute() else c.ROOT/exe
    if binding[c.rel(exe)]["sha256"]!=build["executable_sha256"] or gate.get("worker_executable_sha256")!=build["executable_sha256"]:raise ValueError("Native executable differs from accepted candidate identity")
    accepted=c.read(c.rootpath(gate["small_acceptance"]["path"]))
    if accepted.get("executable_sha256")!=build["executable_sha256"] or accepted.get("worker_build_sha256")!=gate["build"]["sha256"] or accepted.get("theorem_count")!=28:
        raise ValueError("Actual native controls/theorem family are not for this candidate")
    for key in ("pure_theorem_source_olean_C_native_fingerprints_unchanged","compact_framing_and_packed_writer_fingerprints_unchanged","bad_N_and_source_cases_zero_commits"):
        if accepted.get(key) is not True:raise ValueError("Candidate acceptance does not retain the checked packed family: "+key)
    if accepted.get("any_check_omitted") is not False:raise ValueError("Candidate may not omit any original row obligation")
    baseline=c.read(c.ROOT/"runs/lean_table_checker/batch_fast_20261018_v4/packed_compact_acceptance.json")
    steps={s["module"]:s for s in build["steps"]}
    for original in baseline["theorem_fingerprints_unchanged"]:
        step=steps.get(original["module"],{})
        if any(step.get(k)!=v for k,v in original.items() if k!="module"):raise ValueError("Candidate pure theorem/native-object fingerprint changed")
    stability=c.read(c.rootpath(gate["stability_report"]["path"]))
    for path,record in stability.get("evidence_files",{}).items():
        if binding.get(path)!=record:raise ValueError("Locked long-session evidence differs from its accepted identity")
    if stability.get("schema")!="OWNED_WORKER_LONG_SESSION_STABILITY_V4" or stability.get("status")!="PASS_LONG_SESSION_LABELS_AND_RETAINED_MEMORY" or stability.get("worker_executable_sha256")!=build["executable_sha256"]:
        raise ValueError("WORKER_LONG_SESSION_STABILITY_NOT_ACCEPTED")
    if stability.get("completed_spans",0)<128 or stability.get("unique_source_rows",0)<1_073_741_824:raise ValueError("Long-session scope below the explicit stability prerequisite")
    for key in ("all_source_packed_labels_equal","all_owned_services_confirmed_exited","native_epoch_rotation_exits_confirmed"):
        if stability.get(key) is not True:raise ValueError("Worker stability requirement failed: "+key)
    if stability.get("stability_kind")!="BOUNDED_NATIVE_RECYCLING" or stability.get("heap_leak_fixed_claimed") is not False:raise ValueError("Stability must explicitly describe bounded recycling, not an unproved allocator fix")
    accepted_policy=restart_policy(stability.get("restart_policy",{}));production_policy=restart_policy(gate.get("restart_policy",{}))
    if production_policy["max_spans"]>accepted_policy["max_spans"] or production_policy["rotate_before_next_frame_private_bytes"]>accepted_policy["rotate_before_next_frame_private_bytes"]:
        raise ValueError("Production native restart policy is weaker than the measured stability policy")
    for key,limit in (("Windows_subtree_cap_bytes",12_500_000_000),("Linux_RSS_cap_bytes",3_000_000_000),("threads",8),("CPU_cap_percent",80)):
        if not isinstance(stability.get(key),int) or not 0<stability[key]<=limit:raise ValueError("Stability evidence lacks the ordinary resource envelope: "+key)
    return dict(build=gate["build"]["path"],executable=c.rel(exe),sha256=build["executable_sha256"],schema=NATIVE_SCHEMA,status=NATIVE_STATUS,span_protocol="bucket_compact_v1")
