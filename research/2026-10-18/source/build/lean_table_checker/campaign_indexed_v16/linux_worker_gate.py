"""Exact joint104/one-byte worker prerequisite; never a full-run authority.

The caller acquires continuous deny-write/delete ReadLocks and computes the
actual SHA map for every discovered asset before validate_locked. Saved tiny
and resource outputs are replayed here; original game bit tables are not read.
Their historical equality comes from the exact bound actual runner, while the
production input/TargetCorrect/finite/coverage gates remain separate.
"""
import hashlib
import re
import struct
from pathlib import PurePosixPath
from types import SimpleNamespace
import campaign_io as c

SCHEMA = "FUSED_LINUX_PROVED_JOINT_INDEXED_BYTE_WORKER_GATE_V16"
STATUS = "ACCEPTED_FUSED_LINUX_BOUNDED_PRODUCTION"
BACKEND = "linux_fused_joint_indexed_byte_checked_constructor_native_cache_v16"
PROTOCOL = "fused_linux_v16_joint_indexed_byte_checked_constructor_native_cache"
MARKER = "PROVED_BORROWED_NEXT_GLOBAL_NEXT_GENERATED_PLAN_V12"
SCHEDULE = "PROVED_CONTIGUOUS_PARTITION_STRIDED_FIXED_ROUNDS_V13"
CONSTRUCTOR = "PROVED_ONCE_CHECKED_TEMPLATE_CONSTRUCTOR_V16"
ROW_MARKER = "PROVED_INDEXED_NEXT_BYTE_SCALAR_SCAN_V16"
TRANSPORT = "indexed_actual_next_byte_v16"
NATIVE_SCHEMA = "PACKED_INDEXED_BYTE_FRAME_LEAN_PERSISTENT_SPAN_V16"
NATIVE_STATUS = "PASS_COMPILED_LEAN_PACKED_INDEXED_BYTE_FRAME_PERSISTENT_SPAN_V16"
NATIVE_EVENT = "INDEXED_BYTE_LARGE_FRAME_RESIDENT_PROTOCOL_V16"
THEOREM_COUNT = 104
LEAN_COMMIT = "819816b2e0a3bf405af45ae5c7af2491d8f5bee6"
IO_POLICY = dict(native_max_frames_per_epoch=16, pipe_capacity_bytes=1048576)
WRITE_CHUNK_BYTES = 4194304
NATIVE_LIMITS = dict(resident_count_cap=67108864, frame_block_cap=8192,
    frame_template_cap=500000, native_epoch_frame_cap=16,
    large_frame_policy="BOUNDED_64MI_ROWS_COMPLETE_T_INDEXED_BYTE_V16")
VERIFIER = "build/lean_table_checker/linux_bridge_test_indexed_v16/cache_evidence.py"
TINY_SOURCE_IDENTITY = dict(path="build/lean_table_checker/linux_bridge_test_indexed_v16/SOURCE_FREEZE.json", bytes=8669,
    sha256="586549d4c93f65b7731795f5c8cab532ac41b6c588d056284b7ae4b2c44c8264")
RESOURCE_SOURCE_IDENTITY = dict(path="build/lean_table_checker/linux_bridge_resource_indexed_v16/SOURCE_FREEZE.json", bytes=4814,
    sha256="d724dd78544566e45b57683cf6898264a75f310548f9f76af144ae7ce95d7237")
CANDIDATE_IDENTITY = dict(path="runs/lean_table_checker/linux_bridge_test_indexed_20261018_v16/native_candidate.json", bytes=1365,
    sha256="09f7f31d49a514c3279fabc6223c282ba6ca88653c492664e13555f40f78c104")
TINY_IDENTITY = dict(path="runs/lean_table_checker/linux_bridge_test_indexed_20261018_v16/tiny_rounds1_4143672ccef9/normalized_receipt.json", bytes=106147,
    sha256="035cf1a5bc641a7b0d991b107569a1de4c80e2572a5f1d8024b1c585ebb5e949")
RESOURCE_IDENTITY = dict(path="runs/lean_table_checker/linux_bridge_resource_indexed_20261018_v16/rounds1_38fe3103df9a/acceptance.json", bytes=641123,
    sha256="9230b1bc0bcecaac3aa6686c868c0b3d9824c8cb8493be3bd9c10914d835da9e")
RESOURCE_REGISTRATION = dict(path="runs/lean_table_checker/linux_bridge_resource_indexed_20261018_v16/RESOURCE_REGISTRATION.json", bytes=16520,
    sha256="f322ebe5c5633708a3d82dd746e7b28383c2f2f49e4069a73fc25144d5b4c69a")
COST_REGISTRATION = dict(path="runs/lean_table_checker/cost_indexed_frames_20261018_v16/PREREGISTRATION.json", bytes=5703,
    sha256="4ef9a6f0684641e9e0b6f7b4f5d6fd122e40c6493d4124e95d2c6a5ca8927f27")
COST_RULES = dict(path="build/lean_table_checker/cost_indexed_frames_v16/profile_rules.py", bytes=33066,
    sha256="99a0d44687727058a24c1ba101b9b68a75db5cacc17272e1e041cadd3265ac60")
COST_SOURCE_IDENTITY = dict(path="build/lean_table_checker/cost_indexed_frames_v16/SOURCE_FREEZE.json", bytes=3655,
    sha256="ce67ec2ec1209d226ed4710b7b7dce53111834e504ad5fd77bce2e4832456b66")
REPLAY_SOURCE = dict(path="build/lean_table_checker/indexed_evidence_review_v16/replay_resource.py", bytes=17781,
    sha256="f43dbab81c173ea3b5e69d36e1c6e3cc4888b91d836c066b87dbf18edc99cea1")
REPLAY_FREEZE = dict(path="build/lean_table_checker/indexed_evidence_review_v16/SOURCE_FREEZE.json", bytes=1936,
    sha256="9e333f4d28aacbb9ac6c7f98769c8beda046f2b50c6ea28a1c2ab2a50830d933")
GPU_SOURCE_IDENTITY = dict(path="build/lean_table_checker/gpu_indexed_byte_v16/worker.py", bytes=29179,
    sha256="adce9593d5dbbb7937abf6f392d751ad551e189af7daa6b8c6f5bea87584404f")
GPU_SOURCE_FREEZE_IDENTITY = dict(path="build/lean_table_checker/gpu_indexed_byte_v16/SOURCE_FREEZE.json", bytes=4380,
    sha256="6f2057b197cfe19c00716353e2191dff74a6385622aea67d9c19cb676c83c5c6")
GPU_RULES = dict(path="build/lean_table_checker/gpu_indexed_byte_receipt_v16/rules.py", bytes=7584,
    sha256="9160915678016c51c74c87d1cb28cb9a1b5c9c14cfeaf094973d755ba0268f2a")
GPU_IMPLEMENTATION_REVISION = "INDEXED_ACTUAL_NEXT_BYTE_BOUNDED_8MI_SCRATCH_V16"
_BASE_RESOURCES = dict(Windows_job_cap_bytes=1250000000, Windows_CPU_percent=5,
    Linux_memory_max_bytes=14250000000//4096*4096, Linux_memory_high_bytes=13000000000//4096*4096,
    Linux_CPU_percent=75, Linux_swap_max_bytes=0, Linux_pids_max=128,
    GPU_task_cap_bytes=6000000000, GPU_global_cap_bytes=7000000000,
    GPU_min_free_bytes=1000000000, GPU_host_RSS_cap_bytes=3000000000)


def require(value, message):
    if not value:
        raise ValueError(message)


def exact(value, expected, message):
    require(isinstance(value, dict) and all(type(value.get(k)) is type(v) and value[k] == v
        for k, v in expected.items()), message)


def resources_for(threads):
    require(type(threads) is int and threads == 12, "Only the fresh actual12-thread joint104 profile is eligible")
    return dict(_BASE_RESOURCES, threads=threads)


RESOURCES = resources_for(12)


def restart_policy(value):
    expected = dict(schema="BOUNDED_LINUX_NATIVE_RECYCLING_INDEXED_BYTE_EPOCH16_V16", max_spans=16,
        rotate_before_next_frame_RSS_bytes=9000000000, guard_native_RSS_bytes=11250000000,
        guard_scope_memory_bytes=13000000000, STOP_EOF_and_OS_exit_required=True,
        GPU_context_survives_native_epochs=True, heap_leak_fixed_claimed=False)
    require(value == expected, "The exact16-frame/9GB RSS bounded recycling policy is mandatory")
    return value


def record(value):
    require(isinstance(value, dict) and isinstance(value.get("path"), str) and
        type(value.get("bytes")) is int and value["bytes"] >= 0 and
        re.fullmatch("[0-9a-f]{64}", value.get("sha256", "")) is not None,
        "An exact path/size/SHA evidence record is required")
    name = value["path"]
    lexical = PurePosixPath(name)
    require("\\" not in name and ":" not in name and "\x00" not in name and
        not lexical.is_absolute() and str(lexical) == name and
        all(p not in ("", ".", "..") for p in name.split("/")), "Noncanonical evidence path")
    path = c.rootpath(name)
    require(c.rel(path) == name, "Evidence escaped its canonical workspace path")
    return path


def _identity(value):
    record(value)
    return dict(bytes=value["bytes"], sha256=value["sha256"])


def _bound(value, binding):
    path = record(value)
    require(binding.get(value["path"]) == _identity(value) and path.stat().st_size == value["bytes"],
        "Parent actual continuous ReadLock/SHA binding omitted or changed " + value["path"])
    return path


def _read_bound(value, binding):
    return c.read(_bound(value, binding))


def _records(value):
    if isinstance(value, dict):
        if {"path", "bytes", "sha256"} <= set(value):
            yield value
        for child in value.values():
            yield from _records(child)
    elif isinstance(value, list):
        for child in value:
            yield from _records(child)


def _pure(identity, binding=None):
    path = record(identity) if binding is None else _bound(identity, binding)
    raw = path.read_bytes()
    require(len(raw) == identity["bytes"] and hashlib.sha256(raw).hexdigest() == identity["sha256"],
        "Exact captured pure validator source changed: " + identity["path"])
    space = dict(__name__="_v16_gate_"+path.stem, __file__=str(path))
    exec(compile(raw, str(path), "exec"), space)
    return SimpleNamespace(**space)


def io_adapter(gate):
    value = gate.get("native_IO_adapter", {})
    exact(value, dict(schema="CONTENT_IDENTICAL_NATIVE_EXT4_IO_ADAPTER_V7", native_semantics_changed=False,
        per_file_full_readback_SHA256=True, cache_stat_guard="SIZE_DEVICE_INODE_UID_MODE_MTIME_CTIME",
        cache_helper="build/lean_table_checker/linux_native_cache_v7b/native_cache.py", cache_verifier=VERIFIER),
        "The unchanged verified ext4 IO adapter is required")
    paths = value.get("code_paths")
    require(isinstance(paths, list) and len(paths) == len(set(paths)) and value["cache_helper"] in paths
        and VERIFIER in paths, "Unique complete IO adapter source paths are required")
    for name in paths:
        require(c.rel(c.rootpath(name)) == name, "Noncanonical IO code path")
    roots = ["runs/lean_table_checker/summary_full_v1/inputs", "runs/lean_table_checker/full_safe_local_v1/inputs",
        "runs/lean_table_checker/canonical_inventory_resume_v1/inputs", c.rel(c.INDEX),
        "runs/lean_table_checker/successor_cache_v1/inputs", c.rel(c.DATA), c.rel(c.INDEX/"catalog.tsv")]
    require(value.get("original_roots") == roots, "Seven exact original logical Native roots are required")
    return value


def _candidate(gate, binding=None):
    require(gate.get("native_candidate") == CANDIDATE_IDENTITY, "Only the fixed actual joint104 production candidate is eligible")
    candidate = c.read(record(CANDIDATE_IDENTITY)) if binding is None else _read_bound(CANDIDATE_IDENTITY, binding)
    bundle = c.read(record(gate["proof_bundle"])) if binding is None else _read_bound(gate["proof_bundle"], binding)
    rules = _pure(COST_RULES, binding)
    native = rules.validate_candidate(candidate, CANDIDATE_IDENTITY, bundle, gate["proof_bundle"])
    require(native["path"].endswith("/bin/MainOwnedJointIndexedRows1WorkerV16") and
        candidate["proof_bundle"] == gate["proof_bundle"], "Candidate entry/bundle differs")
    return candidate


def build_worker_sha(build):
    worker = build.get("worker", {})
    exact(worker, dict(entry="MainOwnedJointIndexedRows1WorkerV16", row_rounds=1), "Exactly one actual joint104 round1 compiled entry is required")
    require(re.fullmatch("[0-9a-f]{64}", worker.get("sha256", "")), "Compiled entry SHA is absent")
    return worker["sha256"]


def _fixed_records():
    return (CANDIDATE_IDENTITY, TINY_IDENTITY, RESOURCE_IDENTITY, TINY_SOURCE_IDENTITY,
        RESOURCE_SOURCE_IDENTITY, RESOURCE_REGISTRATION, COST_REGISTRATION, COST_RULES,
        COST_SOURCE_IDENTITY, REPLAY_SOURCE, REPLAY_FREEZE, GPU_SOURCE_IDENTITY,
        GPU_SOURCE_FREEZE_IDENTITY, GPU_RULES)


def _freeze_files(value):
    files = value.get("files")
    require(isinstance(files, (dict, list)) and bool(files), "Source-freeze closure is empty")
    return [dict(path=name, **identity) for name, identity in files.items()] if isinstance(files, dict) else files


def _runtime_code_closure(small, stable):
    """Actual locked descriptors bind their transitive runtime import closure."""
    descriptors = [c.read(c.rootpath(case["descriptor"])) for case in small["cases"]]
    descriptors.append(c.read(record(stable["descriptor"])))
    entries = {}
    for descriptor in descriptors:
        roots = descriptor["native_roots"]
        metadata = {name: descriptor["native_cache"]["input_bindings"][name]
            for name in (roots[4]+"/honors.bin", roots[6])}
        for name, identity in dict(descriptor["code_binding"], **metadata).items():
            require(name not in entries or entries[name] == identity, "Actual descriptors used different runtime source bytes")
            require(not name.endswith(".bits"), "Runtime code closure must not include original large bit tables")
            entries[name] = identity
    return entries


def discover(path):
    """Discover paths only; this does not claim custody or execute services."""
    gate = c.read(path)
    exact(gate, dict(schema=SCHEMA, status=STATUS, full_launch_allowed=False), "Fresh actual joint104 worker gate is absent")
    candidate = _candidate(gate)
    bundle = c.read(record(gate["proof_bundle"]))
    require(bundle.get("generated_build") == gate.get("build"), "Bundle/build identities differ")
    build = c.read(record(gate["build"]))
    small = c.read(record(gate["small_acceptance"]))
    stable = c.read(record(gate["stability_report"]))
    assets = [path, record(candidate["native"])]
    values = list(_fixed_records()) + [gate["build"], gate["proof_bundle"]]
    values += [dict(path=name, **identity) for name, identity in bundle["code_and_proof_bindings"].items()]
    values += list(_records(bundle))
    values += [dict(path=name, **identity) for name, identity in small["evidence_files"].items()]
    values += [dict(path=name, **identity) for name, identity in _runtime_code_closure(small, stable).items()]
    values += list(_records(small))
    values += [dict(path=name, **identity) for name, identity in gate.get("evidence_files", {}).items()]
    for frozen in (TINY_SOURCE_IDENTITY, RESOURCE_SOURCE_IDENTITY, COST_SOURCE_IDENTITY, REPLAY_FREEZE, GPU_SOURCE_FREEZE_IDENTITY):
        values += _freeze_files(c.read(record(frozen)))
    replay = _pure(REPLAY_SOURCE)
    values += [dict(path=name, **identity) for name, identity in replay.discover(record(gate["stability_report"])).items()]
    assets += [record(value) for value in values]
    assets += [c.rootpath(name) for name in io_adapter(gate)["code_paths"]]
    # Descriptor historical input_bindings are not pulled recursively: original
    # game arrays belong to the production input gate, not this metadata gate.
    unique = list(dict.fromkeys(assets))
    require(not any(p.suffix == ".bits" for p in unique), "Worker metadata gate must not acquire original large bit tables")
    return gate, build, unique


def _linux_record(value):
    """Normalize only the exact workspace mount used by the actual build."""
    name = value["path"]
    workspace = c.ROOT.as_posix()
    if c.ROOT.drive:
        workspace = "/mnt/"+c.ROOT.drive[0].lower()+"/"+workspace[3:]
    require(name.startswith(workspace+"/"), "Build record is not the exact workspace mount")
    return dict(path=name[len(workspace)+1:], bytes=value["bytes"], sha256=value["sha256"])


def _proofs(gate, build, bundle, candidate, binding):
    exact(build, dict(schema="LINUX_JOINT_INDEXED_BYTE_KERNEL_EXTENSION_BUILD_V16", status="PASS", trust_level=0,
        Lean_commit=LEAN_COMMIT, handwritten_C_or_FFI_added=False, old_Main_or_entry_or_control_object_linked=False,
        linked_common_objects=131, linked_own_entry_objects=1, constructor_plan_proof_count=4,
        indexed_byte_proof_count=6, input_proof_count=5, scan_proof_count=1, total_kernel_proof_count=104,
        native_protocol=NATIVE_EVENT, record_bytes=1, transport=TRANSPORT, full_launch_allowed=False),
        "Actual Linux trust0 joint104 build/source/link identity differs")
    exact(bundle, dict(schema="JOINT_INDEXED_BYTE_PROOF_BUNDLE_V16", status="PASS_ACTUAL_LINUX_KERNEL_AND_NATIVE_COMPILER_ONLY",
        total_kernel_proof_count=104, inherited_kernel_proof_count=88, Lean_commit=LEAN_COMMIT, trust_level=0,
        CLI_argument_count=10, native_protocol=NATIVE_EVENT, transport=TRANSPORT, proposal_record_bytes=1,
        GPU_trusted=False, handwritten_C_or_FFI_added=False, compiler_scope_kernel_empty_and_removed=True,
        GroupNextCoverage_and_TargetCorrect_and_finite_enumeration_premises_retained=True,
        P_all_actual_successors_N_actual_next_membership_source_r_guards_required=True, full_launch_allowed=False),
        "Actual104 proof bundle/finite/source/P-all/N-member obligations differ")
    require(bundle.get("new_kernel_proof_counts") == dict(checked_constructor=4, guarded_scan=1, indexed_byte=6, input_offsets_and_block_runs=5)
        and bundle.get("policy") == dict(block_cap=8192, complete_T_hard_cap=500000, epoch_frame_cap=16,
            individual_piece_byte_cap=5592406, pieces=12, row_cap=67108864, row_rounds=1, threads=12)
        and bundle.get("generated_build") == gate["build"], "Exact104 proof allocation/pieces/policy changed")
    proofs = bundle.get("proofs", [])
    require(len(proofs) == len({p["name"] for p in proofs}) == 104 and
        all(set(p.get("axioms", [])) <= {"propext", "Classical.choice", "Quot.sound"} for p in proofs),
        "104 distinct standard-axiom kernel footprints are required")
    old, new = build.get("inherited_proofs", []), build.get("new_proofs", [])
    require(len(old) == 88 and len(new) == 16 and {p["name"] for p in old+new} == {p["name"] for p in proofs},
        "Actual inherited88+new16 kernel proof inventory differs")
    for name, identity in bundle["code_and_proof_bindings"].items():
        _bound(dict(path=name, **identity), binding)
    for proof in proofs:
        log = _bound(proof["kernel_log"], binding).read_text(encoding="utf-8")
        require(proof["name"] in log and "sorryAx" not in log, "Proof footprint is not present in its bound actual kernel log")
    steps = build.get("new_steps", [])
    require(len(steps) == 7 and len({s["module"] for s in steps}) == 7, "All seven new actual kernel/native modules are required")
    for step in steps:
        require(step["kernel"]["returncode"] == step["native"]["returncode"] == 0 and
            "--trust=0" in step["kernel"]["argv"] and "-j1" in step["kernel"]["argv"], "Actual trust0 kernel/native module did not complete")
        for stage in ("kernel", "native"):
            _bound(_linux_record(step[stage]["log"]), binding)
        _bound(_linux_record(step["source"]), binding)
        for item in step["published"].values():
            _bound(_linux_record(item), binding)
    native = candidate["native"]
    require(_linux_record(build["worker"]) == native and build_worker_sha(build) == native["sha256"] and
        bundle.get("worker") == native and bundle.get("workers") == [dict(native, row_rounds=1)],
        "Actual build/bundle/candidate ELF identity differs")
    with _bound(native, binding).open("rb") as stream:
        require(stream.read(4) == b"\x7fELF", "Worker is not an actual Linux ELF")
    exact(gate.get("proof", {}), dict(theorem_family_count=104, inherited_theorem_count=88, additional_theorem_count=16,
        source_preservation=True, all_original_P_N_source_member_checks_retained=True,
        checker_kind=MARKER, exact_Lean_commit=LEAN_COMMIT), "Gate proof obligations differ")


def _sources(binding):
    for item in _fixed_records():
        _bound(item, binding)
    freezes = {}
    for item in (TINY_SOURCE_IDENTITY, RESOURCE_SOURCE_IDENTITY, COST_SOURCE_IDENTITY, REPLAY_FREEZE, GPU_SOURCE_FREEZE_IDENTITY):
        value = _read_bound(item, binding)
        for entry in _freeze_files(value):
            _bound(entry, binding)
        freezes[item["path"]] = value
    return freezes[TINY_SOURCE_IDENTITY["path"]]


def _configured_rules(gate, candidate, bundle, binding):
    rules = _pure(COST_RULES, binding)
    rules.configure(dict(candidate_record=CANDIDATE_IDENTITY, candidate=candidate,
        bundle_record=gate["proof_bundle"], bundle=bundle), dict(registration=COST_REGISTRATION,
        resource_plan=RESOURCE_REGISTRATION, tiny_freeze=TINY_SOURCE_IDENTITY,
        resource_freeze=RESOURCE_SOURCE_IDENTITY, runtime_freeze=TINY_SOURCE_IDENTITY))
    return rules


def _descriptor(value, candidate):
    exact(value, dict(schema="FUSED_LINUX_INDEXED_BYTE_BRIDGE_CONFIGURATION_V16", native=candidate["native"]["path"],
        native_sha256=candidate["native"]["sha256"], threads=12, native_max_frames_per_epoch=16,
        pipe_capacity_bytes=1048576, transport_timing_profile="WALL_ENVELOPES_INDEXED_BYTE_V16_1",
        GPU_module=GPU_SOURCE_IDENTITY["path"]), "Actual descriptor/ELF/transport differs")


def _scope(lifecycle, binding):
    """Check actual kernel/uid/limit/empty records, not a synthetic exit flag."""
    scope = lifecycle.get("scope", "")
    require(re.fullmatch("mahjong-lean-v6-[0-9a-f]{32}", scope), "Non-owned scope identity")
    exact(lifecycle["create"], dict(schema="WSL_FIXED_VERIFICATION_CGROUP_V6",status="CREATED_EMPTY_FIXED_RESOURCE_LEAF",
        name=scope,workload_uid=1000,limits_root_owned=True,membership_root_owned=True,global_settings_changed=False),
        "Actual resource scope was not the fixed root-owned uid1000 leaf")
    expected = {"memory.max": str(RESOURCES["Linux_memory_max_bytes"]),
        "memory.high": str(RESOURCES["Linux_memory_high_bytes"]), "memory.swap.max": "0",
        "memory.oom.group": "1", "cpu.max": "1200000 100000", "pids.max": "128"}
    require(all(lifecycle["create"]["limits_and_counters"].get(k) == v for k,v in expected.items()),
        "Actual kernel memory/CPU/pid limits differ")
    exact(lifecycle["joined"], dict(event="FIXED_SCOPE_JOINED_UNPRIVILEGED",scope=scope,uid=1000,saved_uids=[1000,1000,1000]),
        "Bridge did not enter its exact scope and irreversibly drop uid")
    answer = lifecycle["scope_stop"]
    exact(answer, dict(scope=scope,all_Linux_owned_processes_confirmed_exited=True), "Kernel-owned scope exit not confirmed")
    if not answer.get("scope_absent", False):
        require("populated 0" in answer["after"]["cgroup.events"] and answer["after"]["cgroup.procs"] == "",
            "Kernel leaf still contains an owned process")
        counts = dict(row.split() for row in answer["after"]["memory.events"].splitlines())
        require(all(int(counts.get(k,-1)) == 0 for k in ("oom","oom_kill","oom_group_kill")), "Actual scope encountered OOM")
    exact(lifecycle, dict(all_Linux_owned_processes_confirmed_exited=True,Windows_client_confirmed_exited=True),
        "Owned client/leaf was not fully exited")
    cleanup = lifecycle.get("native_cache_cleanup", {})
    require(cleanup.get("scope") == scope and cleanup.get("cache_directory_confirmed_absent") is True,
        "Actual owned UUID cache absence was not confirmed")
    if lifecycle.get("accounted_STOP_and_counts_confirmed"):
        stopped = lifecycle["stopped"]
        require(stopped.get("native_descendants_confirmed_exited") is True and
            stopped.get("scope_memory_peak_bytes", RESOURCES["Linux_memory_max_bytes"]+1) <= RESOURCES["Linux_memory_max_bytes"],
            "Normal STOP omitted Native exit or exceeded the kernel resource cap")
        closed = _read_bound(stopped["native_cache_close"], binding)
        exact(closed, dict(schema="VERIFIED_NATIVE_EXT4_CACHE_RECEIPT_V7",event="CLOSED",scope_name=scope,
            all_native_epochs_confirmed_exited_by_caller=True,cache_directory_confirmed_absent=True,
            only_instance_created_paths_removed=True), "Normal cache close receipt is incomplete")


def _expected_bank_files(descriptor, layer, honor, binding):
    """Reconstruct all loaded source/actual next buckets from small inventories."""
    roots = descriptor["native_roots"]
    inventory_name, catalog_name = roots[4]+"/honors.bin", roots[6]
    for name in (inventory_name, catalog_name):
        _bound(dict(path=name, **descriptor["native_cache"]["input_bindings"][name]), binding)
    raw = c.rootpath(inventory_name).read_bytes()
    require(len(raw) == 184*24, "Exact184-row honor successor inventory required")
    row = struct.unpack_from("<6I", raw, honor*24)
    require(row[1] <= 4 and all(h < 184 for h in row[2:2+row[1]]), "Honor successor IDs/arity differ")
    needed = {honor, *row[2:2+row[1]]}
    catalog = {}
    for line in c.rootpath(catalog_name).read_text(encoding="utf-8").splitlines():
        if not line.strip():
            continue
        values = [int(v) for v in line.split("\t")]
        require(len(values) == 5, "Actual catalog row extent differs")
        n, h, code, size, blocks = values
        require((n, h) not in catalog, "Duplicate actual catalog coordinate")
        catalog[n, h] = (code, size, blocks)
    require((layer, honor) in catalog and catalog[layer, honor][0] == row[0], "Source honor/catalog binding differs")
    coordinates = [(layer, honor)] + [(layer+1, h) for h in sorted(needed)
        if catalog.get((layer+1, h), (0, 0, 0))[1] > 0]
    return {roots[axis]+f"/n{n:02}_h{h:03}"+suffix
        for n, h in coordinates for axis, suffix in ((3, ".dir"), (5, ".bits"))}


def _tiny(gate, small, candidate, binding, rules, sources):
    rules.validate_tiny(small, TINY_SOURCE_IDENTITY["sha256"])
    ce = _pure(dict(path=VERIFIER, **sources["files"][VERIFIER]), binding)
    native_name = "build/lean_table_checker/linux_bridge_indexed_v16/native_receipts.py"
    rows_name = "build/lean_table_checker/linux_bridge_test_indexed_v16/row_schedule.py"
    native = _pure(dict(path=native_name, **sources["files"][native_name]), binding)
    rows = _pure(dict(path=rows_name, **sources["files"][rows_name]), binding)
    gpu = _pure(GPU_RULES, binding)
    for name, identity in small["evidence_files"].items():
        _bound(dict(path=name, **identity), binding)
    expected_ranges = [(32, 89, 0, 8), (32, 89, 8, 48), (32, 165, 0, 6)]
    positive = small["cases"][0]
    require([(i["layer"], i["honor"], i["start"], i["count"]) for i in positive["accepted"]] == expected_ranges,
        "Actual tiny positive ranges differ")
    totals = [0, 0, 0]
    for case in small["cases"]:
        life_name, desc_name = case["raw_client_session"], case["descriptor"]
        require(binding[life_name]["sha256"] == case["raw_client_session_sha256"] and
            binding[desc_name]["sha256"] == case["descriptor_sha256"], "Actual tiny session/descriptor identity differs")
        life, desc = c.read(c.rootpath(life_name)), c.read(c.rootpath(desc_name))
        _descriptor(desc, candidate)
        _scope(life, binding)
        sessions = [c.read(c.rootpath(name)) for name in small["evidence_files"] if
            name.startswith(desc["session_dir"]+"/") and name.endswith(".stderr.session.json")]
        if not case["positive"]:
            needles = {"negative_bad_N_ordinal": "REJECTED_INDEXED_BYTE_ROW", "negative_bad_P_byte": "REJECTED_INDEXED_BYTE_ROW",
                "negative_truncated_payload": "STREAM_TRUNCATED_COMPACT_FRAGMENT", "negative_truncated_footer": "STREAM_TRUNCATED_PAYLOAD_END"}
            if case["name"] in needles:
                require(len(sessions) == 1 and sessions[0]["checked_rows"] == sessions[0]["completed_spans"] == 0,
                    "Rejected Native control retained a completed span")
                logs = [c.rootpath(name).read_text(encoding="utf-8") for name in small["evidence_files"] if
                    name.startswith(desc["session_dir"]+"/") and name.endswith(".stderr.log")]
                require(any(needles[case["name"]] in log for log in logs), "Actual compiled rejection diagnostic missing")
            else:
                require(not sessions, "Input-binding negative unexpectedly started Native")
                needle = "Locked manifest SHA mismatch" if case["name"] == "negative_bad_fixed_manifest_SHA" else "Copied original bytes do not match"
                require(needle in case["error"], "Input-binding negative rejected at another boundary")
            continue
        exact(life, dict(accounted_STOP_and_counts_confirmed=True, stdout_EOF_confirmed=True,
            completed_frames=3, checked_rows=62, returncode=0), "Positive tiny STOP/EOF/counts differ")
        gpu_events = [v["GPU"] for v in life["initial_events"] if v.get("event") == "READY"]
        require(len(gpu_events) == 1, "Tiny has no unique initial GPU context READY")
        context = gpu_events[0]
        gpu.ready(context, 64)
        for item in case["accepted"]:
            event, n, h = item["bridge_event"], item["layer"], item["honor"]
            worker_path = c.rootpath(item["output"])
            require(binding[item["output"]]["sha256"] == item["output_sha256"], "Tiny saved result changed")
            worker = c.read(worker_path)
            require(worker == event["worker"], "Tiny RPC/saved actual result differs")
            exact(worker, dict(schema=NATIVE_SCHEMA, status=NATIVE_STATUS, layer=n, honor=h,
                start=item["start"], count=item["count"], checked_rows=item["count"],
                plan_checker_kind=MARKER, row_schedule_kind=SCHEDULE), "Tiny result extent/checker identity differs")
            native.worker(worker, 250000)
            label_name = item["output"]+".labels.bin"
            require(binding[label_name]["sha256"] == item["packed_sha256"], "Tiny saved packed bytes changed")
            packed = c.rootpath(label_name).read_bytes()
            rows.validate(worker, 1, packed)
            frame = dict(start=item["start"], count=item["count"], source_blocks=worker["plan_blocks"], templates=worker["frame_full_templates_without_reuse"])
            rules.validate_worker(worker, frame, packed)
            require(gpu.proposal(event["proposal"], item["start"], item["count"], 64) == item["indexed_provenance"],
                "Tiny proposal provenance is not exact1B coverage")
            ce.validate_transport_timing(event)
            totals = [x+y for x, y in zip(totals, (worker["checked_rows"], worker["P_rows"], worker["N_rows"]))]
        require(len(sessions) == 2, "Tiny actual two-bucket Native session list differs")
        owners = {(s["owner"]["pid"], s["owner"]["start_ticks"]) for s in sessions}
        require(len(owners) == 2, "Tiny reused Native owner identity")
        for session in sessions:
            native.ready(session["events"][0])
            n, h = session["layer"], session["honor"]
            drop = c.read(_bound(session["native_cache_drop"], binding))
            prepared = c.read(_bound(session["native_cache_identity"]["cache_receipt"], binding))
            bank = _expected_bank_files(desc, n, h, binding)
            normalized = ce.validate_prepared(c.ROOT, desc, session["native_cache_identity"], n, h, bank, life["scope"])
            ce.validate_epochs(c.ROOT, desc, normalized, [session])
            released = [dict(path=name, **identity) for name, identity in small["evidence_files"].items()
                if name.startswith(normalized["receipt_directory"]+"/") and name.endswith("_released_bucket.json") and
                c.read(c.rootpath(name)).get("previous_bucket") == [n, h]]
            require(len(released) == 1, "Every positive tiny bucket requires one actual cache-release receipt")
            ce.validate_released(c.ROOT, normalized, released[0])
            items = [i for i in case["accepted"] if (i["layer"], i["honor"]) == (n, h)]
            replies = [i["bridge_event"] for i in items]
            frames = [dict(start=i["start"], count=i["count"]) for i in items]
            ce.validate_span_epoch_schedule(replies, [session], frames, n, h,
                first_global_epoch=replies[0]["native_lifecycle"]["native_epochs"])
            require(drop["event"] == "DROP_CLEAN_PAGES", "Mandatory actual page drop missing")
    require(totals == [62, 47, 15], "Tiny full actual packed P/N totals differ")


def _resource_basis(gate, stable, projection, summary):
    require(all(stable["model_ready_stability"].get(k) == v for k, v in projection.items()) and
        summary["actual_frames_replayed"] == 83 and summary["native_row_executions"] == 4597996387 and
        summary["model_ready_stability"] == stable["model_ready_stability"] == gate.get("resource_epoch_basis") and
        summary["parent_continuous_ReadLock_actual_map_supplied"] is True and
        summary["original_source_bits_read_by_this_review"] == 0 and summary["full_launch_allowed"] is False,
        "Fresh actual83 resource/epoch/cache/P-N replay differs")


def validate_bound_evidence(gate, build, binding):
    exact(gate, dict(schema=SCHEMA, status=STATUS, backend=BACKEND, full_launch_allowed=False,
        selected_template_budget=250000), "This bounded prerequisite never grants full-run permission")
    expected = dict(native_candidate=CANDIDATE_IDENTITY, small_acceptance=TINY_IDENTITY,
        stability_report=RESOURCE_IDENTITY, tiny_source_freeze=TINY_SOURCE_IDENTITY,
        resource_source_freeze=RESOURCE_SOURCE_IDENTITY, resource_registration=RESOURCE_REGISTRATION,
        resource_replay_helper=REPLAY_SOURCE, GPU_source=GPU_SOURCE_IDENTITY, GPU_source_freeze=GPU_SOURCE_FREEZE_IDENTITY)
    require(all(gate.get(k) == v for k, v in expected.items()), "Gate selected different historical/fresh actual evidence")
    for identity in _fixed_records():
        _bound(identity, binding)
    for name, identity in gate["evidence_files"].items():
        _bound(dict(path=name, **identity), binding)
    sources = _sources(binding)
    require(_read_bound(gate["build"], binding) == build, "Compiled build changed after discovery")
    candidate = _candidate(gate, binding)
    bundle = _read_bound(gate["proof_bundle"], binding)
    _proofs(gate, build, bundle, candidate, binding)
    worker = gate["worker"]
    exact(worker, dict(schema=NATIVE_SCHEMA, status=NATIVE_STATUS, span_protocol=PROTOCOL,
        build=gate["build"]["path"], executable=candidate["native"]["path"], sha256=candidate["native"]["sha256"],
        checker_kind=MARKER, row_rounds=1, **NATIVE_LIMITS), "Exact actual indexed-byte worker/profile differs")
    require(gate.get("resource_policy") == RESOURCES and gate.get("native_io_policy") == IO_POLICY and
        gate.get("bridge_payload_write_chunk_bytes") == WRITE_CHUNK_BYTES, "Resource/pipe/write policy differs")
    restart_policy(gate["restart_policy"])
    adapter = io_adapter(gate)
    for name in adapter["code_paths"]:
        require(gate["evidence_files"].get(name) == binding.get(name), "IO adapter is not explicitly code-bound")
    rules = _configured_rules(gate, candidate, bundle, binding)
    small, stable = _read_bound(TINY_IDENTITY, binding), _read_bound(RESOURCE_IDENTITY, binding)
    for name, identity in _runtime_code_closure(small, stable).items():
        _bound(dict(path=name, **identity), binding)
    _tiny(gate, small, candidate, binding, rules, sources)
    basis = rules.validate_resources(stable, TINY_IDENTITY, RESOURCE_SOURCE_IDENTITY["sha256"])
    descriptor = _read_bound(stable["descriptor"], binding)
    _descriptor(descriptor, candidate)
    require(descriptor["native_roots"] == adapter["original_roots"], "Resource descriptor changed the original logical roots")
    ce = _pure(dict(path=VERIFIER, **sources["files"][VERIFIER]), binding)
    lifecycle = _read_bound(stable["scope_lifecycle"], binding)
    _scope(lifecycle, binding)
    for case in stable["cases"]:
        n, h = case["layer"], case["honor"]
        bank = _expected_bank_files(descriptor, n, h, binding)
        ce.validate_prepared(c.ROOT, descriptor, case["ready"]["native_cache"], n, h, bank, lifecycle["scope"])
    replay = _pure(REPLAY_SOURCE, binding)
    summary = replay.replay(record(RESOURCE_IDENTITY), binding=binding)
    _resource_basis(gate, stable, basis, summary)
    return worker


def validate_locked(path, gate, build, binding):
    require(c.read(path) == gate, "Gate changed before continuous input locks")
    require(binding.get(c.rel(path)) == dict(bytes=path.stat().st_size, sha256=c.sha(path)),
        "Actual gate bytes were not hashed under the caller's ReadLocks")
    return validate_bound_evidence(gate, build, binding)
