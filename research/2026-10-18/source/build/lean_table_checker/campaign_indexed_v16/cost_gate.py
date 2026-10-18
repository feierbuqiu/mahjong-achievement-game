"""Exact external authority; samples and accounting drafts cannot start full work.

The manifest itself remains full_launch_allowed:false. Only an independently
reviewed, read-locked final authority can bind permission to a bounded ticket.
This is an operational trust boundary, not a Lean aggregation theorem or a
mathematical promise that wall-clock completion fits the empirical estimate.
"""
import hashlib,json,math
import campaign_io as c
import invocation_budget as ib
import linux_worker_gate as worker_gate

SCHEMA="OVERNIGHT_V16_INDEXED_EVALUATED_EMPIRICAL_START_GATE"
READINESS="OVERNIGHT_V16_INDEXED_PRODUCTION_READINESS_AUDIT"
AUTHORITY_PATH="runs/lean_table_checker/campaign_indexed_20261018_v16/final_authority.json"
AUTHORITY_SCHEMA="OVERNIGHT_V16_INDEXED_FINAL_EMPIRICAL_START_AUTHORITY"
MODEL=dict(path="build/lean_table_checker/cost_large_frames_v14/registered_cost_model.py",bytes=22755,
    sha256="fb161b78a5617223f6f77d7e28b0ca11ca4c743fd9229591631976678fadac37")
PROFILE="OVERNIGHT_V16_JOINT_INDEXED_REGISTERED_CALIBRATION_PROFILE"
PROJECTION=dict(path="build/lean_table_checker/cost_indexed_frames_v16/model_projection.py",bytes=7527,
    sha256="3825b1b45eff5eb6b3a1f17b8a1788391ae4ec5bc3279f3834754df8630166e5")


def require(value,message):
    if not value:raise ValueError(message)


def identity(value):return {k:value[k] for k in ("bytes","sha256")}


def digest(value):return hashlib.sha256(json.dumps(value,sort_keys=True,separators=(",",":"),ensure_ascii=False).encode()).hexdigest()


def record(value,allow_empty=False):
    if allow_empty and type(value.get("bytes")) is int and value["bytes"]==0:
        worker_gate.record(dict(value,bytes=1))
    else:worker_gate.record(value)
    require(c.rel(c.rootpath(value["path"]))==value["path"],"Cost evidence paths must be canonical")
    return value


def full_scope(m):
    table=c.read(c.DATASET/"all_buckets.json")["slots"]
    expected={(r["layer"],r["honor"],0,r["size"],r["size"]) for r in table if r["size"]}
    requests=m["requests"]
    actual={(r["layer"],r["honor"],r["start"],r["count"],r["size"]) for r in requests}
    require(len(actual)==len(requests),"Duplicate full-scope request")
    return actual==expected or actual=={r for r in expected if r[0]<=31}


def assert_bounded_scope(manifest,max_chunks,external_gate_requested=False):
    require(manifest.get("full_launch_allowed") is False,"The immutable manifest itself cannot grant full-run permission")
    if full_scope(manifest) and max_chunks>0:
        require(external_gate_requested,"GENERATED_V12_FULL_SCOPE_REQUIRES_EXACT_EXTERNAL_COST_AND_READINESS_GATE")


def positive(gate):
    upper=gate.get("conservative_empirical_upper_seconds")
    require(gate.get("schema")==SCHEMA and gate.get("status")=="PASS_EMPIRICAL_16H_GATE" and
        gate.get("allow_full_run") is True and gate.get("hard_cumulative_seconds")==72000 and
        type(upper) in (int,float) and math.isfinite(upper) and 0<upper<=57600,
        "NEW104_PROFILE_NEEDS_ACTUAL_MARGIN_INCLUDED_16H_GATE_WITHIN_20H_HARD_BUDGET")
    for key in ("authority","profile","readiness","evaluator","production_increment","independent_review","replay_source"):
        record(gate.get(key,{}))
    require(gate["authority"]["path"]==AUTHORITY_PATH,
        "Only the fixed separately sealed newV16 authority may select an evaluator")
    margin=gate.get("margin_fraction")
    require(gate.get("accounting_model")==MODEL and gate.get("accounting_projection")==PROJECTION and
        gate.get("unmeasured_cost_components")==[] and gate.get("all_34_required_cases_measured") is True and
        type(margin) in (int,float) and math.isfinite(margin) and margin>=.25,
        "Fresh104 measured projection, all costs and25percent margin are mandatory")
    require(isinstance(gate.get("sample_receipts"),list) and len(gate["sample_receipts"])==34,
        "All34 fresh actual normalized cases are mandatory")
    for item in gate["sample_receipts"]:record(item)
    require(len({item["path"] for item in gate["sample_receipts"]})==34,
        "Repeated receipts cannot fill missing measurements")


def discover(path):
    gate=c.read(path);positive(gate)
    records=[gate[k] for k in ("authority","profile","readiness","evaluator","production_increment","independent_review","accounting_model","accounting_projection","replay_source")]+gate["sample_receipts"]
    profile=c.read(c.rootpath(gate["profile"]["path"]))
    records+=profile.get("code_and_proof_bindings",[])
    authority=c.read(c.rootpath(gate["authority"]["path"]))
    records+=authority.get("evidence_files",[])
    assets=[path]+[c.rootpath(record(item,allow_empty=True)["path"]) for item in records]
    return gate,list(dict.fromkeys(assets))


def validate_locked(path,gate,m,manifest_path,parent_inputs,guard=None):
    require(c.read(path)==gate,"Cost decision changed before source locks")
    positive(gate)
    records=[gate[k] for k in ("authority","profile","readiness","evaluator","production_increment","independent_review","accounting_model","accounting_projection","replay_source")]+gate["sample_receipts"]
    for item in records:c.check_fingerprint(c.rootpath(item["path"]),item,guard)
    authority=c.read(c.rootpath(gate["authority"]["path"]))
    require(authority.get("schema")==AUTHORITY_SCHEMA and authority.get("status")=="PASS_INDEPENDENTLY_REVIEWED_FINAL_AUTHORITY" and
        authority.get("evaluator")==gate["evaluator"] and authority.get("accounting_model")==MODEL and
        authority.get("accounting_projection")==PROJECTION and authority.get("replay_source")==gate["replay_source"] and
        authority.get("independent_review")==gate["independent_review"] and authority.get("evaluation_reproduced") is True,
        "No independently reviewed final evaluator authority exists for this exact decision")
    require(authority.get("gate_payload_sha256")==digest({key:value for key,value in gate.items() if key!="authority"}) and
        authority.get("conservative_empirical_upper_seconds")==gate["conservative_empirical_upper_seconds"],
        "The final sealed authority does not bind this exact upper bound/fees/samples/readiness decision")
    require(m.get("start_evaluator")==gate["evaluator"] and m["code_binding"].get(gate["evaluator"]["path"])==identity(gate["evaluator"]),
        "The final evaluator must be an audited source already bound by this exact immutable manifest")
    for item in (PROJECTION,gate["replay_source"]):
        require(m["code_binding"].get(item["path"])==identity(item),
            "Final registered projection/replay source was not locked before this manifest")
    for item in authority.get("evidence_files",[]):c.check_fingerprint(c.rootpath(item["path"]),record(item),guard)
    profile=c.read(c.rootpath(gate["profile"]["path"]));ready=c.read(c.rootpath(gate["readiness"]["path"]))
    required_profile=dict(schema=PROFILE,backend=worker_gate.BACKEND,threads=12,Lean_version="4.33.1",
        pure_theorem_fingerprints=104,worker_executable=m["worker"]["executable"],worker_executable_sha256=m["worker"]["sha256"])
    require(all(profile.get(k)==v for k,v in required_profile.items()),"Actual calibrated profile does not describe this V12 worker")
    require(ready.get("schema")==READINESS and ready.get("status")=="PASS" and ready.get("profile_sha256")==gate["profile"]["sha256"],
        "Actual production readiness is missing or belongs to another profile")
    exact_manifest=dict(path=c.rel(manifest_path),bytes=manifest_path.stat().st_size,sha256=c.sha(manifest_path,guard))
    require(ready.get("production_manifest")==exact_manifest,"Evaluated permission names another immutable production manifest")
    require(ready.get("production_code_binding")==m["code_binding"] and ready.get("worker_gate")==m["worker_gate"] and
        ready.get("production_input_bindings")==parent_inputs,"Current locked code/worker/input identities differ from the actual readiness audit")
    require(ready.get("replay_source")==gate["replay_source"] and ready.get("hidden_host_additional_reserve_bytes")==67108864 and
        isinstance(ready.get("hidden_host_basis"),dict) and ready.get("hidden_host_probe_whole_wall_seconds",0)>0,
        "New raw replay and actual hidden-host capacity/cost evidence are mandatory")
    require(ready.get("finite_premise_closure")==m["finite_premise_closure"] and
        ready.get("finite_premise_runtime_bindings_checked") is True,"Finite enumeration/cache/numbering premises were not explicitly bound")
    for key in ("frame_policy","frame_work_inputs","restart_policy","scope_lifecycle_policy","resource_epoch_cost_floor"):
        require(ready.get(key)==m[key],"Readiness changed production policy: "+key)
    for key in ("frame_policy","frame_work_inputs","restart_policy"):
        measured_key="partition_policy" if key=="frame_policy" else key
        require(profile.get(measured_key)==m[key],"Measured profile changed execution policy: "+key)
    require(profile.get("resource_policy")==m["fused_bridge"]["resource_policy"] and
        profile.get("native_roots")==m["native_IO_adapter"]["original_roots"] and
        profile.get("native_max_frames_per_epoch")==m["native_io_policy"]["native_max_frames_per_epoch"] and
        profile.get("native_stdin_pipe_capacity_bytes")==m["native_io_policy"]["pipe_capacity_bytes"] and
        profile.get("bridge_payload_write_chunk_bytes")==m["bridge_payload_write_chunk_bytes"],"Runtime resource/IO adapter differs from measurements")
    require(ready.get("additional_GPU_scope_initialization_and_cleanup_cost_included") is True and
        ready.get("actual_crash_resume_and_commit_controls_passed") is True and ready.get("capacity_preflight_passed") is True,
        "Production lifecycle/recovery/capacity costs and controls are required")
    production=c.read(c.rootpath(gate["production_increment"]["path"]))
    required_costs=("ledger_increment_per_frame_upper_seconds","certificate_registry_per_bucket_upper_seconds",
        "shared_once_hash_setup_upper_seconds","final_scope_cleanup_upper_seconds",
        "additional_scope_init_close_inclusive_upper_seconds","retry_recovery_reserve_seconds")
    require(production.get("status")=="PASS_MEASURED_PRODUCTION_INCREMENT_SAME_PROFILE" and
        production.get("profile_sha256")==gate["profile"]["sha256"] and production.get("backend")==worker_gate.BACKEND and
        production.get("accounting_contract")=="ENTIRE_NATIVE_EPOCH_FIRST_PLAN_PLUS_ALL_STEADY_T_INDEXED_V16" and
        production.get("native_candidate")==worker_gate.CANDIDATE_IDENTITY and
        production.get("worker_executable_sha256")==m["worker"]["sha256"],
        "Production fees must be actual fresh104 same-profile measurements")
    for key in required_costs:
        value=production.get(key)
        require(type(value) in (int,float) and math.isfinite(value) and value>=0,"Unmeasured production cost: "+key)
    require(production.get("scope_max_frames")==m["scope_lifecycle_policy"]["max_completed_frames_before_next_bucket"] and
        production.get("scope_max_buckets")==m["scope_lifecycle_policy"]["max_completed_buckets_before_next_bucket"],"Measured scope lifecycle differs")
    measured={v["path"]:identity(v) for v in profile["code_and_proof_bindings"]}
    for name,binding in measured.items():c.check_fingerprint(c.rootpath(name),binding,guard)
    for name in m["fused_bridge"]["code_paths"]:
        require(measured.get(name,profile.get("native_cache_input_bindings",{}).get(name))==m["code_binding"][name],"Measured runtime asset differs: "+name)
    for name,binding in profile.get("native_cache_input_bindings",{}).items():
        require(parent_inputs.get(name,m["code_binding"].get(name,measured.get(name)))==binding,"Measured semantic input changed: "+name)
    require(profile.get("native_cache_input_bindings"),"Measured profile omitted actual semantic identities")
    return dict(path=c.rel(path),bytes=path.stat().st_size,sha256=c.sha(path,guard),profile=gate["profile"],
        conservative_empirical_upper_seconds=gate["conservative_empirical_upper_seconds"],
        estimate_is_not_a_mathematical_completion_guarantee=True)


def attach(ticket,value):
    state=c.read(ib.state_path(ticket.folder))
    require(state.get("reservation")==ticket.ticket,"Cost permission cannot attach to a changed invocation")
    ticket.ticket=dict(ticket.ticket,weighted_cost_gate=value)
    state["reservation"]=ticket.ticket;c.atomic(ib.state_path(ticket.folder),state)
