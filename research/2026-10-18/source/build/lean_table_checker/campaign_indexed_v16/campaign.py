"""Bounded, resumable cross-layer Lean certification scheduler.

Planning starts no computation.  Complete bucket certificates require exact
unique [0,size) coverage, complete numbering, current payload hashes, and all
conservative next-layer bucket certificates.  A partial checked span never
becomes TargetCorrect.  GPU proposals are optional and always untrusted.
"""
from pathlib import Path
import argparse,datetime,hashlib,json,os,queue,struct,subprocess,threading,time
from concurrent.futures import ThreadPoolExecutor,TimeoutError as FutureTimeout
import campaign_io as c
import frame_planner as fp
import frame_registry as fr
import worker_gate as wg
import ledger as ld
import invocation_budget as ib
import path_guard as paths
import prior_import as reuse_api
import linux_worker_gate as lwg
import keep_awake
import scope_lifecycle as scopes
import finite_premises as finite
import local_reports
import span_policy
import indexed_runtime as indexed

WORKER_GATE=c.ROOT/"runs/lean_table_checker/campaign_indexed_20261018_v16/linux_worker_gate.json"
DEFAULT_SCHEMA="PACKED_INDEXED_BYTE_FRAME_LEAN_PERSISTENT_SPAN_V16"
DEFAULT_STATUS="PASS_COMPILED_LEAN_PACKED_INDEXED_BYTE_FRAME_PERSISTENT_SPAN_V16"
SEED_MANIFEST_SHA="8ff438ccecaeb0c5e508a2554185fbc29ac1789ced62b8122816220c2eeb87c4"
TAILS={33:("layer33_v1","59d8e7c071c6e6a47004dad2451f7ef48103de1ca1dc8ddf8d42ee6f8796e960","PASS_COMPILED_NEAR_TERMINAL_LAYER",21924455),
       34:("terminal_layer34_v1","8fc25f06762f6799d0cdc1d1a95523552fc91624de2a68870874eef3b6b5ecfc","PASS_COMPILED_TERMINAL_LAYER",587901)}
MAX_CAMPAIGN_SECONDS=20*3600
GPU_BUCKET_PRODUCER=c.ROOT/"build/lean_table_checker/gpu_indexed_byte_v16/worker.py"
GPU_STOP=c.ROOT/"build/lean_table_checker/gpu_indexed_byte_v16/stop_owned.py"

def gpu_fixed_paths():
    """The only inputs whose GPU hashes may be reused across buckets.

    These paths are all code_binding assets locked for the entire invocation;
    source/child labels, directories and metadata deliberately never appear.
    """
    old=c.ROOT/"build/lean_table_checker/gpu_spike_v1";deps=old/"deps"
    names=list(c.read(deps/"receipt.json")["files"])
    return [c.INDEX/"numeric.bin",c.INDEX/"groups.bin",c.ROOT/"runs/lean_table_checker/successor_cache_v1/inputs/numeric.bin",
        c.ROOT/"runs/lean_table_checker/successor_cache_v1/inputs/honors.bin",c.INDEX/"catalog.tsv",GPU_BUCKET_PRODUCER,
        c.ROOT/"build/lean_table_checker/gpu_stream_v4/worker_compact.py",c.ROOT/"build/lean_table_checker/cached_checker_v2/gpu_source_packets.py",
        c.ROOT/"runs/lean_table_checker/gpu_spike_20261018_v1/acceptance.json",old/"gpu_benchmark.py",old/"rows.cu",deps/"receipt.json"]+[deps/name for name in names]

def folder(name):
    if not name.replace("_","").replace("-","").isalnum():raise ValueError("Use a simple campaign name")
    return c.RUN/"campaigns"/name
def slots():return {(r["layer"],r["honor"]):r for r in c.read(c.DATASET/"all_buckets.json")["slots"]}
def needed(n,h,table):
    if n>=34:return []
    raw=(c.ROOT/"runs/lean_table_checker/successor_cache_v1/inputs/honors.bin").read_bytes()
    code,count,*nexts=struct.unpack_from("<6I",raw,h*24)
    if code!=table[n,h]["honor_code"] or count>4:raise ValueError("Honor successor inventory mismatch")
    return [(n+1,j) for j in sorted({h,*nexts[:count]})]
def all_semantic_bank_inputs(m):
    """Open handles, not file contents: parent custody survives child death."""
    table=slots();coordinates=set()
    for request in m["requests"]:
        n,h=request["layer"],request["honor"];coordinates.add((n,h));coordinates.update(needed(n,h,table))
    active=[c.rootpath(table[n,h][key]) for n,h in sorted(coordinates) if table[n,h]["size"] for key in ("directory","bits","metadata")]
    return list(dict.fromkeys(active+finite.semantic_inputs(m)))
def certpath(f,n,h):return f/"registry"/(c.stem(n,h)+".json")
def numbering(row):
    if not row["size"]:return dict(kind="EMPTY_CERTIFIED_PREFIX",prefix_sha256=row["prefix_sha256"])
    path=c.DATASET/"directory_bindings"/(c.stem(row["layer"],row["honor"])+".json")
    if not path.exists():raise ValueError("MISSING_COMPILED_LEAN_NUMBERING_BINDING: "+path.stem)
    v=c.read(path);r=c.read(c.rootpath(v["result"]))
    if v["status"]!="PASS" or v["directory_sha256"]!=row["directory_binding"]["sha256"] or v["source_prefix_sha256"]!=row["prefix_sha256"]:
        raise ValueError("Numbering binding provenance mismatch")
    if any(r.get(k)!=val for k,val in dict(status="PASS_COMPILED_LEAN_EXACT_DIRECTORY_BINDING",layer=row["layer"],honor=row["honor"],rows=row["blocks"],represented_slots=row["size"]).items()):raise ValueError("Wrong native numbering receipt")
    if c.sha(c.rootpath(v["result"]))!=v["result_sha256"]:raise ValueError("Native numbering result changed")
    key=c.stem(row["layer"],row["honor"])
    index=c.read(c.DATASET/"binding_window_index.json")["buckets"]
    if key not in index:raise ValueError("Native directory check lacks a locked certified-prefix premise")
    window=index[key]
    if c.sha(c.rootpath(window["receipt"]))!=window["sha256"]:raise ValueError("Prefix binding window changed")
    w=c.read(c.rootpath(window["receipt"]))
    if w["status"]!="PASS" or w["bindings"][key]["certificate_sha256"]!=c.sha(path) or w["verified_prefix_files"].get(row["prefix_input"])!=row["prefix_sha256"]:
        raise ValueError("Actual prefix premise not bound to this production directory")
    return dict(kind="COMPILED_LEAN_COMPLETE_NUMBERING",receipt=c.rel(path),sha256=c.sha(path),prefix_window=window)
def covers(records,size):
    cursor=0
    for r in sorted(records,key=lambda v:v["start"]):
        if r["start"]!=cursor or not 0<r["count"]<=67108864:return False
        cursor+=r["count"]
    return cursor==size

def plan(args):
    f=folder(args.name);f.mkdir(parents=True,exist_ok=True)
    paths.preflight(f)
    target=f/"manifest.json"
    if target.exists():raise ValueError("Preserve existing manifest; a worker/config change requires a new campaign")
    table=slots()
    if args.bucket and args.only_layer is not None:raise ValueError("Select exact buckets or one complete layer")
    pending=getattr(args,"pending_layers_only",False)
    if pending and (args.bucket or args.only_layer is not None or not args.reuse_layer32_v5):raise ValueError("Pending global scope requires the true complete layer32 import and no other scope selector")
    selected=args.bucket or [[n,h] for n,h in table if (not pending or n<=31) and (args.only_layer is None or n==args.only_layer)]
    if (args.start or args.count is not None) and len(selected)!=1:raise ValueError("Partial spans require one exact bucket")
    requests=[]
    for n,h in selected:
        row=table[n,h]
        if not row["size"]:continue
        start=args.start;count=args.count if args.count is not None else row["size"]-start
        if start<0 or count<=0 or start+count>row["size"]:raise ValueError("Requested span outside exact bucket")
        requests.append(dict(layer=n,honor=h,start=start,count=count,size=row["size"]))
    if len({(r["layer"],r["honor"]) for r in requests})!=len(requests):raise ValueError("Repeated source bucket in manifest")
    requests.sort(key=lambda r:(-r["layer"],r["honor"]))
    if args.backend!=lwg.BACKEND or args.protocol!=lwg.PROTOCOL:raise ValueError("This new production candidate accepts only the independently gated new104/one-byte Linux backend")
    finite_bundle,finite_assets=finite.discover(args.finite_premises)
    evaluator=Path(args.start_evaluator).resolve() if getattr(args,"start_evaluator",None) else None
    if pending and evaluator is None:raise ValueError("A full pending manifest must first bind its independently reviewed final evaluator source")
    if evaluator is not None and (evaluator.suffix!=".py" or not evaluator.is_relative_to(c.ROOT/"build/lean_table_checker")):
        raise ValueError("The final start evaluator must be a task-owned Python source")
    linux=True;gate_api=lwg
    gate_path=Path(args.worker_gate).resolve();gate,build,candidate_assets=gate_api.discover(gate_path)
    if linux and args.threads!=gate["resource_policy"]["threads"]:raise ValueError("Use the independently bound Linux thread profile")
    bp=c.rootpath(gate["build"]["path"])
    exe=c.rootpath(gate["worker"]["executable"]) if linux else Path(build["executable"]);exe=exe if exe.is_absolute() else c.ROOT/exe
    if build.get("status")!="PASS":raise ValueError("Worker build not accepted")
    if not 1<=args.chunk<=67108864 or args.threads!=12 or not 0<args.budget<=MAX_CAMPAIGN_SECONDS:
        raise ValueError("Bounded chunk/thread/20h budget exceeded")
    if args.backend!="linux_fused_joint_indexed_byte_checked_constructor_native_cache_v16" or args.protocol!=("fused_linux_v16_joint_indexed_byte_checked_constructor_native_cache" if linux else "cross_bucket_compact_v6"):
        raise ValueError("This independently bound campaign requires compact GPU and binary native protocols")
    if args.label_format!="PACKED_LSB0":raise ValueError("Owned production family requires the independently checked packed output format")
    frame_policy=fp.policy(args.max_plan_templates)
    if args.chunk!=frame_policy["max_rows"]:raise ValueError("The new one-byte profile requires the registered64Mi row cap even for a short request")
    if args.report_seconds<=0:raise ValueError("Local report interval must be positive")
    producer=Path(args.gpu_producer).resolve()
    if producer!=GPU_BUCKET_PRODUCER or not producer.is_file():raise ValueError("Use the exact compact GPU producer; a change needs a new adapter identity")
    proof=c.ROOT/"runs/lean_table_checker/batch_fast_20261018_v4"
    assets=[Path(__file__),c.BASE/"campaign_io.py",c.BASE/"compact_transport.py",c.BASE/"launch_campaign.py",c.BASE/"stop_unreceipted.py",c.BASE/"frame_planner.py",c.BASE/"frame_registry.py",c.BASE/"worker_gate.py",c.BASE/"ledger.py",c.BASE/"invocation_budget.py",c.BASE/"runner.py",Path(c.legacy.__file__),Path(c.legacy.a.__file__),c.ROOT/"build/lean_daemon/common.py",
        c.DATASET/"all_buckets.json",c.DATASET/"numbering_acceptance.json",c.DATASET/"binding_window_index.json",c.DATASET/"scheduler_acceptance.json",c.INDEX/"catalog.tsv",bp,exe,producer,GPU_STOP,
        c.ROOT/"runs/lean_table_checker/gpu_stream_20261018_v4/compact_ready.json",proof/"compact_template_acceptance.json",proof/"template_theorem_bundle.json",
        proof/"Mahjong.CompactHotRow.build.json",proof/"packed_compact_acceptance.json",proof/"packed_writer_smoke.json",proof/"packed_checker_smoke.json",
        c.ROOT/"build/lean_table_checker/gpu_spike_v1/gpu_benchmark.py",c.ROOT/"build/lean_table_checker/gpu_spike_v1/rows.cu",
        c.ROOT/"build/lean_table_checker/gpu_spike_v1/deps/receipt.json",c.ROOT/"build/lean_table_checker/cached_checker_v2/gpu_source_packets.py",c.legacy.FOLDER/"e2e_manifest.json"]+candidate_assets
    reuse,reuse_assets=reuse_api.discover() if args.reuse_layer32_v5 else (None,[])
    fixed_gpu_paths=gpu_fixed_paths()
    assets.extend([c.BASE/"path_guard.py",c.BASE/"prior_import.py"]+reuse_assets+fixed_gpu_paths+fixed_inputs()+
        [c.INDEX/x for x in ("numeric.bin","numeric_ids.bin","groups.bin","honor_ids.bin","catalog.tsv")])
    assets.extend([c.BASE/"fused_transport.py",c.BASE/"linux_worker_gate.py",c.BASE/"keep_awake.py",c.BASE/"input_snapshot.py",c.BASE/"cache_transport.py",c.BASE/"cost_gate.py",c.BASE/"scope_lifecycle.py",c.BASE/"resource_job.py",c.BASE/"span_policy.py"])
    assets.extend([c.BASE/"finite_premises.py",c.BASE/"production_metrics.py",c.BASE/"local_reports.py",c.READ_LOCK_SOURCE]+finite_assets+([evaluator] if evaluator is not None else []))
    # The actual functional/fee reports bind this complete controller source
    # set, including their harnesses. The final manifest binds the same set.
    assets.extend(sorted(c.BASE.glob("*.py")))
    assets.append(c.ROOT/"build/lean_table_checker/gpu_indexed_byte_receipt_v16/rules.py")
    expected_replay_bindings={}
    if evaluator is not None:
        expected_evaluator=c.ROOT/"build/lean_table_checker/integration_indexed_v16/seal_start.py"
        if evaluator!=expected_evaluator:
            raise ValueError("The full evaluator must be the independently reviewed new V16 source")
        assets.append(expected_evaluator.with_name("evaluate_cost_evidence.py"))
        assets.append(c.ROOT/"build/lean_table_checker/linux_bridge_test_indexed_v16/row_schedule.py")
        replay_source=expected_evaluator.with_name("REPLAY_SOURCE_FREEZE.json")
        replay=c.read(replay_source)
        if replay.get("schema")!="JOINT_INDEXED_V16_COMPLETE_EVIDENCE_REPLAY_SOURCE" or replay.get("status")!="SOURCE_ONLY_NOT_EXECUTED":
            raise ValueError("The final full manifest needs the exact frozen V16 replay source")
        if not isinstance(replay.get("files"),dict) or not replay["files"]:
            raise ValueError("The final evidence replay source closure is empty")
        assets.append(replay_source)
        for name,identity in replay["files"].items():
            path=c.rootpath(name)
            if (not name.startswith(("build/lean_table_checker/","runs/lean_table_checker/")) or
                    path.suffix in (".bits",".dir",".bin",".exe") or
                    type(identity.get("bytes")) is not int or not 0<=identity["bytes"]<=32*1024*1024):
                raise ValueError("Only bounded exact replay sources may enter the full code closure")
            assets.append(path)
            expected_replay_bindings[name]=identity
        assets.extend([c.ROOT/"build/lean_table_checker/service_host_v16/service_host.py",
            c.ROOT/"build/lean_table_checker/service_host_v16/host_probe.py"])
    assets.extend([c.ROOT/"runs/lean_table_checker/gpu_bucket_20261018_v6/context_functional_acceptance_v2.json",
        c.ROOT/"runs/lean_table_checker/cost_review_overnight_20261018_v6/independent_gpu_context_audit.json"])
    bridge_paths=[]
    if linux:
        bridge=c.ROOT/"build/lean_table_checker/linux_bridge_indexed_v16"
        bridge_paths=[bridge/p for p in ("windows_client.py","bridge_worker.py","scope_launch.py","scope_stop.py","cgroup_scope.py","scope_cache_cleanup.py")]
        bridge_paths.extend(c.rootpath(p) for p in lwg.io_adapter(gate)["code_paths"])
        bridge_paths.append(bridge/"native_receipts.py")
        # The Linux descriptor is a projection of these paths, not of the
        # complete manifest assets. Its provenance validator must receive the
        # same parent-locked indexed-byte rules used by the GPU proposal.
        bridge_paths.append(c.ROOT/"build/lean_table_checker/gpu_indexed_byte_receipt_v16/rules.py")
        assets.extend(bridge_paths)
    assets=list(dict.fromkeys(assets))
    if args.fault_inject and args.fault_inject not in ("bad_n_member","bad_packed_label","bad_bucket_manifest","simulated_memory_error_after_commit"):raise ValueError("Unknown bounded negative control")
    if args.fault_inject:
        limit=3*67108864 if args.fault_inject=="simulated_memory_error_after_commit" else 512
        if len(requests)!=1 or requests[0]["count"]>limit:raise ValueError("Fault injection is bounded to one test bucket: <=512 rows for corruption, <=3 full64Mi frames for post-commit cleanup")
    if linux and args.fault_inject not in (None,"bad_n_member","bad_packed_label","simulated_memory_error_after_commit"):
        raise ValueError("Only the explicitly bounded new byte-index, packed and post-commit controls are supported")
    asset_locks=c.ReadLocks(assets)
    try:
        if c.read(bp)!=build:raise ValueError("Worker build changed while acquiring code locks")
        if slots()!=table:raise ValueError("Exact bucket inventory changed before code locks")
        code_binding=c.bind(assets)
        if any(code_binding.get(name)!=identity for name,identity in expected_replay_bindings.items()):
            raise ValueError("An actual frozen final-evidence source changed before immutable manifest acquisition")
        if any(code_binding.get(name)!=identity for name,identity in finite_bundle["metadata_bindings"].items()):
            raise ValueError("A finite-premise historical receipt changed before immutable manifest acquisition")
        finite_reference=finite.reference(args.finite_premises,finite_bundle)
        if code_binding[c.rel(exe)]["sha256"]!=(lwg.build_worker_sha(build) if linux else build["executable_sha256"]):raise ValueError("Locked worker binary/build mismatch")
        worker=gate_api.validate_locked(gate_path,gate,build,code_binding)
        reuse_api.verify_identity(reuse,code_binding,worker,requests)
        restart_policy=gate_api.restart_policy(gate["restart_policy"])
        epoch_cost_floor=span_policy.cost_floor_policy(gate["stability_report"],gate["resource_epoch_basis"])
        seed_path=c.legacy.FOLDER/"e2e_manifest.json"
        if c.sha(seed_path)!=SEED_MANIFEST_SHA:raise ValueError("Certified frame-work seed changed")
        seed=c.read(seed_path)["input_files"]
        frame_work_inputs={c.rel(p):seed[("runs/lean_table_checker/general_input_v1/groups.bin" if p==c.INDEX/"groups.bin" else c.rel(p))] for p in fr.work_paths()}
    finally:asset_locks.close()
    v=dict(schema="INDEXED_BYTE_CHECKED_CONSTRUCTOR_CROSS_LAYER_LEAN_CAMPAIGN_MANIFEST_V16",name=args.name,created_utc=datetime.datetime.now(datetime.timezone.utc).isoformat(),
        dataset=c.rel(c.DATASET/"all_buckets.json"),dataset_sha256=c.sha(c.DATASET/"all_buckets.json"),requests=requests,
        scope="EXACT_PENDING_LAYERS_0_THROUGH_31_WITH_TRUE_32_33_34_PREREQUISITES" if pending else "EXACT_EXPLICIT_REQUESTS",
        global_rows=778532864302,all_slots=6440,nonempty_buckets=3686,chunk_rows=args.chunk,
        native_checker_kind=lwg.MARKER,pure_kernel_theorem_count=104,original_kernel_theorem_count=28,additional_kernel_theorem_count=76,
        full_launch_allowed=False,native_io_policy=lwg.IO_POLICY,bridge_payload_write_chunk_bytes=lwg.WRITE_CHUNK_BYTES,
        worker=worker,worker_gate=dict(path=c.rel(gate_path),binding=code_binding[c.rel(gate_path)]),
        backend=args.backend,threads=args.threads,cpu_cap_percent=5 if linux else 80,memory_hard_cap_bytes=1250000000 if linux else 12500000000,linux_RSS_cap_bytes=3000000000,
        Linux_cgroup_hard_cap_bytes=lwg.RESOURCES["Linux_memory_max_bytes"] if linux else None,
        aggregate_declared_memory_cap_bytes=15500000000,GPU_hard_cap_bytes=6000000000,GPU_global_cap_bytes=7000000000,
        cumulative_runtime_budget_seconds=args.budget,cleanup_reserve_seconds=ib.CLEANUP_RESERVE_SECONDS,report_seconds=args.report_seconds,max_staging_bytes=600_000_000,
        max_packed_payload_bytes=110_000_000_000,min_free_disk_bytes=10_000_000_000,code_binding=code_binding,
        gpu_bucket_producer=dict(script=c.rel(producer),stop_helper=c.rel(GPU_STOP),schema="GPU_CROSS_BUCKET_INDEXED_BYTE_PROTOCOL_V16",transport="indexed_actual_next_byte_v16",
            implementation_revision="INDEXED_ACTUAL_NEXT_BYTE_BOUNDED_8MI_SCRATCH_V16",device_output_scratch_rows=8388608,
            device_output_scratch_bytes=8388608,Native_packet_rows=67108864,
            lifecycle="ONE_FIXED_CONTEXT_PER_INVOCATION_FRESH_BANK_PER_BUCKET",fixed_input_paths=[c.rel(p) for p in fixed_gpu_paths]),
        gpu_fixed_inputs=[c.rel(p) for p in fixed_gpu_paths],
        fused_bridge=dict(script=c.rel(bridge_paths[1]),client=c.rel(bridge_paths[0]),resource_policy=gate["resource_policy"],
            code_paths=list(dict.fromkeys([c.rel(p) for p in bridge_paths+fixed_gpu_paths]+[worker["executable"]]))) if linux else None,
        native_IO_adapter=lwg.io_adapter(gate) if linux else None,
        finite_premise_closure=finite_reference,start_evaluator=(dict(path=c.rel(evaluator),**code_binding[c.rel(evaluator)]) if evaluator is not None else None),
        scope_lifecycle_policy=scopes.policy(getattr(args,"scope_max_frames",4096),getattr(args,"scope_max_buckets",128)) if linux else None,
        frame_policy=frame_policy,frame_work_inputs=frame_work_inputs,restart_policy=restart_policy,resource_epoch_cost_floor=epoch_cost_floor,
        native_output_path_policy=paths.POLICY,complete_bucket_reuse=reuse,
        prefetch_chunks=1,payload_bytes_per_row=1,payloads_saved_or_hashed=False,fault_inject=args.fault_inject,label_format=args.label_format,
        previous_controller=c.rel(c.ROOT/"build/lean_table_checker/campaign_short_v5/campaign.py"),previous_controller_sha256="5871c9d3f092e5a12bbe3bf9f20b4aedc82332e037f7c4b4245d574970443594",
        awake_policy=keep_awake.POLICY,parent_semantic_inputs_lock_policy="ALL_POSSIBLE_ACTUAL_BANKS_CODE_COMMON_HELD_UNTIL_KERNEL_EMPTY",
        generated_manifests_lock_policy="CHILD_LOCKS_WHILE_CONSUMED_PLUS_DURABLE_SHA_NOT_PARENT_CONTINUOUS_LOCK_CLAIM",
        aggregation_boundary="Audited Python coverage/registry and OS IO; not a Lean kernel aggregation finalizer",full_table_Lean="NOT_VERIFIED",auto_started=False)
    c.atomic(target,v)
    c.atomic(f/"checkpoint.json",dict(schema="OWNED_CROSS_LAYER_LEAN_CHECKPOINT_V4",manifest_sha256=c.sha(target),state="PLANNED_NOT_STARTED",
        budget_used_seconds=0.0,invocation_reservation=None,invocation_count=0,committed_chunks=0,committed_rows=0,packed_payload_bytes=0,last_commit=None,imported_unique_rows=0))
    print(json.dumps(dict(state="PLANNED_NOT_STARTED",source_buckets=len(requests),requested_rows=sum(r["count"] for r in requests),full_campaign_launched=False)),flush=True)

def seed_tail(args):
    f=folder(args.name);lock=c.legacy.a.Lock(f/"controller.lock")
    try:return seed_tail_locked(args)
    finally:lock.close()

def seed_tail_locked(args):
    f=folder(args.name);m=c.read(f/"manifest.json");table=slots()
    for n in args.layers:
        name,expected,status,total=TAILS[n];prior=c.ROOT/"runs/lean_table_checker"/name
        acc=prior/"acceptance.json";a=c.read(acc);pm=prior/"manifest.json"
        if c.sha(acc)!=expected or a["status"]!=status or a["committed_rows"]!=total or c.sha(pm)!=a["manifest_sha256"]:
            raise ValueError("Prior complete layer certificate changed")
        manifest=c.read(pm);files={str(k).replace("\\","/"):v for k,v in manifest["files"].items()}
        for row in table.values():
            if row["layer"]!=n or not row["size"]:continue
            matches=[r for r in manifest["targets"] if r["layer"]==n and r["block"]==row["honor"]]
            if len(matches)!=1 or matches[0]["start"]!=0 or matches[0]["count"]!=row["size"]:raise ValueError("Prior certificate lacks full exact bucket")
            item=matches[0];copy=prior/item["input"];actual=c.rootpath(row["bits"])
            locks=c.ReadLocks([acc,pm,copy,actual])
            try:
                digest=c.sha(copy)
                if files.get(c.rel(copy))!=digest or c.sha(actual)!=digest:raise ValueError("Prior certified labels do not match actual table")
                cert=dict(schema="V4_COMPLETE_BUCKET_CERTIFICATE",kind="IMPORTED_COMPLETE_LAYER_BUCKET",layer=n,honor=row["honor"],size=row["size"],
                    dataset_sha256=m["dataset_sha256"],complete_unique_coverage=[0,row["size"]],bits=row["bits"],bits_binding=dict(bytes=actual.stat().st_size,sha256=digest),
                    prior_acceptance=c.rel(acc),prior_acceptance_sha256=expected,prior_manifest=c.rel(pm),prior_manifest_sha256=a["manifest_sha256"],
                    prior_input=c.rel(copy),prior_input_sha256=digest,scope="Original game label bucket from previously complete compiled-Lean layer")
                path=certpath(f,n,row["honor"])
                if path.exists() and c.read(path)!=cert:raise ValueError("Preserve existing different certificate")
                c.atomic(path,cert)
            finally:locks.close()
    print("SEEDED_IDENTICAL_ACTUAL_PREVIOUSLY_CERTIFIED_TAILS",flush=True)

def validate_cert(f,m,n,h,table,seen=None,guard=None,locks=None):
    if guard:guard()
    if seen is None:seen={}
    if (n,h) in seen:return seen[n,h]
    row=table[n,h]
    if not row["size"]:return dict(kind="EMPTY_CERTIFIED_PREFIX",layer=n,honor=h,sha256=row["prefix_sha256"])
    p=certpath(f,n,h)
    if not p.exists():raise ValueError("UNCERTIFIED_TARGET_LAYER_BUCKET: "+c.stem(n,h))
    if locks is not None:locks.append(c.ReadLocks([p]))
    v=c.read(p)
    if any(v.get(k)!=x for k,x in dict(schema="V4_COMPLETE_BUCKET_CERTIFICATE",layer=n,honor=h,size=row["size"],dataset_sha256=m["dataset_sha256"],complete_unique_coverage=[0,row["size"]],bits=row["bits"]).items()):
        raise ValueError("Incomplete/wrong dataset bucket certificate")
    if v["kind"]=="IMPORTED_COMPLETE_LAYER_BUCKET":
        if n not in TAILS:raise ValueError("Only independently certified terminal/near-terminal layers may be imported")
        prior_name,expected,status,total=TAILS[n];prior=c.ROOT/"runs/lean_table_checker"/prior_name
        if (v["prior_acceptance"],v["prior_acceptance_sha256"],v["prior_manifest"])!=(c.rel(prior/"acceptance.json"),expected,c.rel(prior/"manifest.json")):
            raise ValueError("Imported proof is not the fixed independently complete layer")
        if c.sha(c.rootpath(v["prior_acceptance"]))!=expected or c.sha(c.rootpath(v["prior_manifest"]))!=v["prior_manifest_sha256"]:
            raise ValueError("Prior layer proof identity changed")
        a=c.read(prior/"acceptance.json");pm=c.read(prior/"manifest.json")
        if a["status"]!=status or a["committed_rows"]!=total or a["manifest_sha256"]!=v["prior_manifest_sha256"]:raise ValueError("Imported layer completeness changed")
        targets=[x for x in pm["targets"] if x["layer"]==n and x["block"]==h]
        if len(targets)!=1 or targets[0]["start"]!=0 or targets[0]["count"]!=row["size"] or v["prior_input"]!=c.rel(prior/targets[0]["input"]):raise ValueError("Imported layer lacks this full exact bucket")
        bound={str(k).replace("\\","/"):x for k,x in pm["files"].items()}
        if bound.get(v["prior_input"])!=v["prior_input_sha256"] or v["bits_binding"]!=dict(bytes=c.rootpath(row["bits"]).stat().st_size,sha256=v["prior_input_sha256"]):raise ValueError("Imported payload is not the prior exact payload")
    elif v["kind"]=="IMPORTED_VERIFIED_COMPLETE_NATIVE_BUCKET_V12_BORROWED_NEXT_GENERATED_NATIVE_CACHE":
        import sys
        reuse_api.validate(v,f,m,row,sys.modules[__name__],seen,guard,locks)
    elif v["kind"]=="CHECKED_EXACT_NATIVE_LEDGER_COVERAGE":
        if v.get("worker_binding")!=m["worker"] or v.get("campaign_manifest_sha256")!=c.sha(f/"manifest.json"):raise ValueError("Complete bucket uses a different checker/campaign identity")
        request=next((r for r in m["requests"] if (r["layer"],r["honor"])==(n,h)),None)
        if request is None or request["start"]!=0 or request["count"]!=row["size"]:raise ValueError("Partial coverage cannot become a complete target bucket")
        journal=ld.open_snapshot(f,m,request,v["ledger_snapshot"],guard,locks)
        identity={k:v[k] for k in ("dependencies","numbering","frame_schedule_binding","source_directory_binding")};identity["source_bits_binding"]=v["bits_binding"]
        if journal.header["identity"]!=identity:raise ValueError("Certificate premises differ from the immutable ledger header")
        frame_cache={}
        def checked(item,descriptor):
            if locks is not None:locks.append(c.ReadLocks([c.rootpath(item[k]) for k in ("packed_labels","result","log")]))
            validate_item(m,item,guard,frame_cache,locks)
            if any(item.get(k)!=x for k,x in identity.items()):raise ValueError("Bucket combines incompatible checked spans")
        head=journal.walk(checked,guard=guard,locks=locks)
        if head["next_start"]!=row["size"] or head["committed_rows"]!=row["size"]:raise ValueError("Complete registry lacks exact unique [0,size) coverage")
        actual={c.stem(a,b):validate_cert(f,m,a,b,table,seen,guard,locks) for a,b in needed(n,h,table)}
        if actual!=v["dependencies"]:raise ValueError("Certified target dependency identity changed")
        if numbering(row)!=v["numbering"]:raise ValueError("Complete bucket numbering premise changed")
    else:raise ValueError("Unsupported certificate kind")
    answer=dict(kind="COMPLETE_CERTIFIED_BUCKET",layer=n,honor=h,receipt=c.rel(p),sha256=c.sha(p));seen[n,h]=answer
    return answer

class Runtime:
    def __init__(self,f,m,state,ticket):
        self.f,self.m,self.s,self.ticket=f,m,state,ticket;self.began=time.monotonic();self.deadline=ticket.work_deadline;self.last_report=0
        self.initial_committed=state["committed_rows"]
        self.cert_cache={};self.proof_locks=[];self.frame_cache={};self.frame_work=None;self.frame_work_binding=None;self.untracked_service_possible=False;self.cross_gpu=None
        self.unconfirmed_locks=[]
        ticket.mirror(state)
    def guard(self):
        if (self.f/"STOP").exists() or (c.RUN/"STOP").exists():raise InterruptedError("STOP_REQUESTED")
        if time.monotonic()>=self.deadline:raise InterruptedError("BOUNDED_INVOCATION_DEADLINE")
        if c.legacy.psutil.virtual_memory().available<3_000_000_000:raise MemoryError("System available memory below three GB")
        if time.monotonic()-self.last_report>=self.m["report_seconds"]:self.report()
    def report(self,force=False):
        if not force and time.monotonic()-self.last_report<self.m["report_seconds"]:return
        self.last_report=time.monotonic()
        return local_reports.write(self.f,self.m,self.s,self.ticket,self.initial_committed,
            cleanup_confirmed=self.ticket.cleanup_confirmed if force else None)
    def begin(self,description,cleanup=False):
        if not cleanup:self.guard()
        self.s["current_activity"]=description
        if cleanup:
            # A report/disk error must never prevent owned STOP/OS cleanup.
            try:ld.save_root(self.f,self.s)
            except BaseException as error:self.s["cleanup_activity_save_error"]=repr(error)
        else:ld.save_root(self.f,self.s)
    def wait(self,future):
        while True:
            self.guard()
            try:return future.result(timeout=.05)
            except FutureTimeout:
                if future.done():return future.result()

def fixed_inputs():
    runs=c.ROOT/"runs/lean_table_checker"
    return [runs/f"summary_full_v1/inputs/{x}" for x in ("numeric.bin","honors.bin","summary_numeric.bin","summary_honors.bin")]+[runs/f"full_safe_local_v1/inputs/{x}" for x in ("raw_numeric.bin","raw_honors.bin")]+[runs/f"canonical_inventory_resume_v1/inputs/{x}" for x in ("ids_numeric.bin","ids_honors.bin","members_numeric.bin","members_honors.bin")]+[runs/f"successor_cache_v1/inputs/{x}" for x in ("numeric.bin","honors.bin")]

def stop_linux(pidfile):
    from compact_transport import stop_owned
    return stop_owned(pidfile)

def validate_item(m,item,guard=None,frame_cache=None,locks=None):
    if guard:guard()
    if item.get("worker_binding")!=m["worker"]:raise ValueError("Committed span uses a different checker")
    if not 0<item["count"]<=m["frame_policy"]["max_rows"] or item["start"]<0:raise ValueError("Invalid committed span extent")
    if item["packed_binding"]["bytes"]!=(item["count"]+7)//8:raise ValueError("Packed label size differs from exact span")
    c.check_fingerprint(c.rootpath(item["packed_labels"]),item["packed_binding"],guard)
    labels=c.rootpath(item["packed_labels"]).read_bytes()
    if item["count"]%8 and labels[-1]>>(item["count"]%8):raise ValueError("Committed packed padding changed")
    if int.from_bytes(labels,"little").bit_count()!=item["P_rows"]:raise ValueError("Committed packed labels/P count differ")
    if c.sha(c.rootpath(item["result"]),guard)!=item["result_sha256"]:raise ValueError("Committed native result changed")
    w=c.read(c.rootpath(item["result"]))
    expected=dict(schema=m["worker"]["schema"],status=m["worker"]["status"],layer=item["layer"],honor=item["honor"],start=item["start"],checked_rows=item["count"],threads=m["threads"],P_rows=item["P_rows"],N_rows=item["N_rows"],plan_checker_kind=lwg.MARKER,actual_successors_all_checked=True,
        row_schedule_kind="PROVED_CONTIGUOUS_PARTITION_STRIDED_FIXED_ROUNDS_V13",row_rounds=1,row_partition_checked=True,
        row_partition_chunks=12,resident_count_cap=67108864,frame_block_cap=8192,frame_template_cap=500000,
        native_epoch_frame_cap=16,large_frame_policy="BOUNDED_64MI_ROWS_COMPLETE_T_INDEXED_BYTE_V16")
    if any(w.get(k)!=v for k,v in expected.items()) or item["P_rows"]<0 or item["N_rows"]<0 or item["P_rows"]+item["N_rows"]!=item["count"]:raise ValueError("Native receipt has wrong exact identity/P/N counts")
    proposed=item["proposal_provenance"]["kind"]!="NO_UNTRUSTED_PROPOSALS"
    if not proposed or w.get("gpu_witness_mode") is not True or w.get("gpu_source_packet_mode") is not False:
        raise ValueError("Indexed Native requires untrusted byte proposals, not old source-coordinate packets")
    if m["backend"]=="gpu_compact":
        origin=item["proposal_provenance"];header=origin.get("header",{});footer=origin.get("footer",{});proposal=origin.get("origin",{})
        exact=dict(schema="GPU_CROSS_BUCKET_INDEXED_BYTE_PROTOCOL_V16",layer=item["layer"],honor=item["honor"],start=item["start"],count=item["count"],
            compact_bytes=item["count"],record_bytes=1,transport="indexed_actual_next_byte_v16",endianness="little")
        if any(header.get(k)!=v or footer.get(k)!=v for k,v in exact.items()) or header.get("event")!="PAYLOAD" or footer.get("event")!="PROPOSED":raise ValueError("Committed proposal provenance has wrong bucket/span transport")
        for k in ("session_token","generation","identity_sha256","fixed_identity_sha256","completed_spans","session_completed_spans"):
            if header.get(k)!=footer.get(k) or header.get(k)!=proposal.get(k):raise ValueError("Cross-bucket identity/generation changed inside one frame")
        if not isinstance(header.get("generation"),int) or header["generation"]<=0 or proposal.get("locked_manifest_sha256")!=origin.get("locked_manifest_sha256"):raise ValueError("Missing fresh GPU bucket identity")
    elif m["backend"]=="linux_fused_joint_indexed_byte_checked_constructor_native_cache_v16":
        origin=item["proposal_provenance"];proposal=origin.get("origin",{})
        if origin.get("kind")!="FRESH_UNTRUSTED_INDEXED_BYTE_LINUX_FUSED_GPU" or origin.get("payload_crossed_Windows") is not False:raise ValueError("Committed Linux frame lost fused transport identity")
        expected_proposal=dict(layer=item["layer"],honor=item["honor"],start=item["start"],count=item["count"],compact_bytes=item["count"],
            transport="indexed_actual_next_byte_v16",record_bytes=1,GPU_trusted_for_soundness=False,Lean_rows_verified=0)
        if any(proposal.get(k)!=v for k,v in expected_proposal.items()) or proposal.get("locked_manifest_sha256")!=origin.get("locked_manifest_sha256"):raise ValueError("Committed Linux frame has another source identity")
        import cache_transport as cached
        cached.validate_frame(m,item,guard,frame_cache,locks)
    if m["backend"] in ("gpu_compact","linux_fused_joint_indexed_byte_checked_constructor_native_cache_v16"):
        if m["worker"]["span_protocol"]!=("fused_linux_v16_joint_indexed_byte_checked_constructor_native_cache" if m["backend"]=="linux_fused_joint_indexed_byte_checked_constructor_native_cache_v16" else "bucket_compact_v1") or w.get("compact_word_mode") is not False or w.get("indexed_byte_mode") is not True or w.get("compact_bytes")!=item["count"] or w.get("payload_end_bytes")!=24:
            raise ValueError("Native receipt is not the complete compact transport checker")
        indexed.validate_worker(m,w,item)
        if w.get("scan_ns")!=w.get("plan_phase_wall_ns",-1)+w.get("row_scan_ns",-1):raise ValueError("Native inclusive timing contract changed")
        if m["label_format"]=="PACKED_LSB0":
            fields=dict(label_format="PACKED_LSB0",label_bytes=(item["count"]+7)//8,label_valid_bits=item["count"],label_padding_bits=(-item["count"])%8)
            if any(w.get(k)!=v for k,v in fields.items()):raise ValueError("Packed label manifest/receipt mismatch")
    if c.sha(c.rootpath(item["log"]))!=item["log_sha256"]:raise ValueError("Committed native diagnostic log changed")
    fr.check_item(m,item,w,frame_cache,locks,guard)
    return w

def validate_commits(f,m,state,guard=None,locks=None,timing_sink=None):
    cache={}
    def validate(item):
        began=time.monotonic()
        if locks is not None:locks.append(c.ReadLocks([c.rootpath(item[k]) for k in ("packed_labels","result","log")]))
        validate_item(m,item,guard,cache,locks)
        if timing_sink is not None:timing_sink(item,time.monotonic()-began)
    ld.reconcile(f,m,state,validate,guard,locks)
    ld.save_root(f,state)

class BucketWorkspace:
    """Hash while locked once, retaining immutable inputs for the whole bucket."""
    def __init__(self,m,row,table,rt):
        self.rt=rt;self.locks=None;self.session=None;self.gpu=None;self.processor=None;self.pool=None;self.locked={};n,h=row["layer"],row["honor"]
        required=[(n,h)]+[(a,b) for a,b in needed(n,h,table) if table[a,b]["size"]]
        files=fixed_inputs()+[c.INDEX/x for x in ("numeric.bin","numeric_ids.bin","groups.bin","honor_ids.bin","catalog.tsv")]
        registry=[]
        for a,b in required:
            r=table[a,b];numbering(r);files.extend([c.rootpath(r["directory"]),c.rootpath(r["bits"]),c.rootpath(r["metadata"])])
            if (a,b)!=(n,h):registry.append(certpath(rt.f,a,b))
        files=list(dict.fromkeys(files));self.locks=c.ReadLocks(files+registry)
        try:
            seed_path=c.legacy.FOLDER/"e2e_manifest.json"
            if c.sha(seed_path)!=SEED_MANIFEST_SHA:raise ValueError("Certified finite input seed manifest changed")
            seed=c.read(seed_path)["input_files"]
            if not hasattr(rt,"parent_inputs"):raise ValueError("V7 requires the authenticated parent once-hashed input snapshot")
            self.locked={c.rel(p):dict(rt.parent_inputs[c.rel(p)]) for p in files}
            if any(p.stat().st_size!=self.locked[c.rel(p)]["bytes"] for p in files):raise ValueError("Actual locked file size differs from parent snapshot")
            for p in fixed_inputs():
                if self.locked[c.rel(p)]!=seed[c.rel(p)]:raise ValueError("Actual local finite data differs from certified seed")
            for leaf in ("numeric.bin","numeric_ids.bin","groups.bin","honor_ids.bin"):
                if self.locked[c.rel(c.INDEX/leaf)]!=seed[f"runs/lean_table_checker/general_input_v1/{leaf}"]:raise ValueError("Actual fixed numbering data differs from certified inventory")
            for a,b in required:
                r=table[a,b]
                if self.locked[r["directory"]]!=r["directory_binding"] or self.locked[r["metadata"]]["sha256"]!=r["metadata_sha256"]:raise ValueError("Numbering/table metadata changed")
                if (a,b)!=(n,h):
                    cv=c.read(certpath(rt.f,a,b))
                    if self.locked[r["bits"]]!=cv["bits_binding"]:raise ValueError("Actual target labels differ from complete certified target")
            # Validate registry identities after their read locks were acquired.
            self.dependencies={c.stem(a,b):validate_cert(rt.f,m,a,b,table,rt.cert_cache,rt.guard,rt.proof_locks) for a,b in needed(n,h,table)}
        except BaseException:self.close();raise
    def close(self,abort=False):
        try:
            if self.processor is not None:self.processor.close(abort=abort);self.processor=None
            if self.session is not None:self.session.close(abort=abort);self.session=None
        finally:
            try:
                if self.gpu is not None:self.gpu.close(abort=abort);self.gpu=None
            finally:
                try:
                    if self.pool is not None:self.pool.shutdown(wait=True,cancel_futures=True);self.pool=None
                finally:
                    if self.locks is not None:
                        safe=not self.rt.untracked_service_possible and ((self.processor is None and self.gpu is None) or (self.rt.cross_gpu is not None and self.rt.cross_gpu.exit_confirmed))
                        if safe:self.locks.close()
                        else:self.rt.unconfirmed_locks.append(self.locks)
                        self.locks=None

_BYTE_LABELS=tuple(bytes((v>>i)&1 for i in range(8)) for v in range(256))
def checked_packed_source(path,start,count,labels):
    # Expanding existing packed bits uses a small lookup table.  Equality means
    # the retained packed result is exactly the actual native output, without
    # a Python per-row bit packing loop on every eight-million-row span.
    packed=c.bits_span(path,start,count)
    if len(labels)!=count or labels!=b"".join(_BYTE_LABELS[x] for x in packed)[:count]:raise ValueError("Native labels differ from actual source table")
    return packed

def run(args):
    import sys
    from runner import run as execute
    return execute(args,sys.modules[__name__])

if __name__=="__main__":
    p=argparse.ArgumentParser();p.add_argument("action",choices=["plan","seed-tail","run","status"]);p.add_argument("--name",required=True)
    p.add_argument("--bucket",nargs=2,type=int,action="append");p.add_argument("--start",type=int,default=0);p.add_argument("--count",type=int)
    p.add_argument("--only-layer",type=int,choices=range(35))
    p.add_argument("--pending-layers-only",action="store_true",help="Plan exact layers0..31, using true complete32/33/34 as independently revalidated prerequisites")
    p.add_argument("--reuse-layer32-v5",action="store_true",help="Reuse all 68 exact complete v5 layer32 buckets, including the unchanged nested old13 proof")
    p.add_argument("--chunk",type=int,default=67108864);p.add_argument("--threads",type=int,choices=(12,),default=12);p.add_argument("--budget",type=float,default=MAX_CAMPAIGN_SECONDS)
    p.add_argument("--scope-max-frames",type=int,default=4096);p.add_argument("--scope-max-buckets",type=int,default=128)
    p.add_argument("--report-seconds",type=float,default=3600);p.add_argument("--backend",choices=["linux_fused_joint_indexed_byte_checked_constructor_native_cache_v16"],default="linux_fused_joint_indexed_byte_checked_constructor_native_cache_v16")
    p.add_argument("--gpu-producer",default=str(GPU_BUCKET_PRODUCER))
    p.add_argument("--worker-gate",default=str(WORKER_GATE))
    p.add_argument("--finite-premises",default=str(finite.DEFAULT))
    p.add_argument("--start-evaluator",help="Final reviewed evaluator source; bind before creating any full pending manifest")
    p.add_argument("--max-plan-templates",type=int,choices=(250000,500000),default=250000)
    # Source-block limit8192 is fixed by the registered complete-T profile.
    p.add_argument("--protocol",choices=["fused_linux_v16_joint_indexed_byte_checked_constructor_native_cache"],default="fused_linux_v16_joint_indexed_byte_checked_constructor_native_cache")
    p.add_argument("--label-format",choices=["PACKED_LSB0"],default="PACKED_LSB0")
    p.add_argument("--fault-inject",choices=["bad_n_member","bad_packed_label","bad_bucket_manifest","simulated_memory_error_after_commit"])
    p.add_argument("--layers",nargs="+",type=int,choices=[33,34],default=[33,34]);p.add_argument("--max-seconds",type=float,default=60);p.add_argument("--max-chunks",type=int,default=1)
    p.add_argument("--reservation",help=argparse.SUPPRESS)
    p.add_argument("--parent-inputs",help=argparse.SUPPRESS)
    a=p.parse_args()
    if a.action=="plan":plan(a)
    elif a.action=="seed-tail":seed_tail(a)
    elif a.action=="run":run(a)
    else:print(json.dumps(c.read(folder(a.name)/"checkpoint.json"),ensure_ascii=False,indent=2))
