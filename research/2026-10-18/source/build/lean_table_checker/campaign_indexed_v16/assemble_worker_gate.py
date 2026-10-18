"""Metadata-only assembler for the fresh104/1B bounded worker prerequisite.

--plan-only reads small manifests and writes an explicitly unvalidated draft.
--seal rehashes all code/ELF/saved packed evidence under continuous ReadLocks,
then replays the actual tiny/resource receipts. It starts no Linux/GPU/Lean
service and opens no original game .bits file. Run only in Root's hash window.
"""
import argparse
import json
import time
from pathlib import Path
import campaign_io as c
import linux_worker_gate as g


def record(path):
    path = Path(path).resolve()
    return dict(path=c.rel(path), bytes=path.stat().st_size, sha256=c.sha(path))


def merge(assets, item):
    name, identity = item["path"], g._identity(item)
    g.require(name not in assets or assets[name] == identity, "Conflicting discovered source/evidence identity: " + name)
    assets[name] = identity


def candidate():
    """Create a draft from the fixed actual records; no custody is claimed."""
    selected = c.read(g.record(g.CANDIDATE_IDENTITY))
    bundle = c.read(g.record(selected["proof_bundle"]))
    small = c.read(g.record(g.TINY_IDENTITY))
    stable = c.read(g.record(g.RESOURCE_IDENTITY))
    assets = {}
    for item in g._fixed_records():
        merge(assets, item)
    for frozen in (g.TINY_SOURCE_IDENTITY, g.RESOURCE_SOURCE_IDENTITY,
        g.COST_SOURCE_IDENTITY, g.REPLAY_FREEZE, g.GPU_SOURCE_FREEZE_IDENTITY):
        for item in g._freeze_files(c.read(g.record(frozen))):
            merge(assets, item)
    merge(assets, selected["native"])
    merge(assets, selected["proof_bundle"])
    for name, identity in bundle["code_and_proof_bindings"].items():
        merge(assets, dict(path=name, **identity))
    for item in g._records(bundle):
        merge(assets, item)
    for item in g._records(small):
        merge(assets, item)
    for name, identity in small["evidence_files"].items():
        merge(assets, dict(path=name, **identity))
    for name, identity in g._runtime_code_closure(small, stable).items():
        merge(assets, dict(path=name, **identity))
    replay = g._pure(g.REPLAY_SOURCE)
    for name, identity in replay.discover(g.record(g.RESOURCE_IDENTITY)).items():
        merge(assets, dict(path=name, **identity))
    for path in (Path(__file__), Path(g.__file__)):
        merge(assets, record(path))
    bridge_prefix = "build/lean_table_checker/linux_bridge_indexed_v16/"
    tiny_sources = c.read(g.record(g.TINY_SOURCE_IDENTITY))["files"]
    io_paths = sorted({name for name in tiny_sources if name.startswith(bridge_prefix) and name.endswith(".py")} |
        {g.VERIFIER, "build/lean_table_checker/linux_native_cache_v7b/native_cache.py"})
    g.require(all(name in assets for name in io_paths), "Tiny frozen import closure omitted an IO adapter source")
    roots = ["runs/lean_table_checker/summary_full_v1/inputs", "runs/lean_table_checker/full_safe_local_v1/inputs",
        "runs/lean_table_checker/canonical_inventory_resume_v1/inputs", c.rel(c.INDEX),
        "runs/lean_table_checker/successor_cache_v1/inputs", c.rel(c.DATA), c.rel(c.INDEX/"catalog.tsv")]
    gate = dict(schema=g.SCHEMA, status=g.STATUS, backend=g.BACKEND,
        full_launch_allowed=False, full_table_Lean="NOT_VERIFIED", selected_template_budget=250000,
        native_candidate=g.CANDIDATE_IDENTITY, build=bundle["generated_build"], proof_bundle=selected["proof_bundle"],
        small_acceptance=g.TINY_IDENTITY, stability_report=g.RESOURCE_IDENTITY,
        tiny_source_freeze=g.TINY_SOURCE_IDENTITY, resource_source_freeze=g.RESOURCE_SOURCE_IDENTITY,
        resource_registration=g.RESOURCE_REGISTRATION, resource_replay_helper=g.REPLAY_SOURCE,
        GPU_source=g.GPU_SOURCE_IDENTITY, GPU_source_freeze=g.GPU_SOURCE_FREEZE_IDENTITY,
        resource_epoch_basis=stable["model_ready_stability"], resource_policy=g.RESOURCES,
        native_io_policy=g.IO_POLICY, bridge_payload_write_chunk_bytes=g.WRITE_CHUNK_BYTES,
        restart_policy=dict(schema="BOUNDED_LINUX_NATIVE_RECYCLING_INDEXED_BYTE_EPOCH16_V16", max_spans=16,
            rotate_before_next_frame_RSS_bytes=9000000000, guard_native_RSS_bytes=11250000000,
            guard_scope_memory_bytes=13000000000, STOP_EOF_and_OS_exit_required=True,
            GPU_context_survives_native_epochs=True, heap_leak_fixed_claimed=False),
        native_IO_adapter=dict(schema="CONTENT_IDENTICAL_NATIVE_EXT4_IO_ADAPTER_V7", native_semantics_changed=False,
            per_file_full_readback_SHA256=True, cache_stat_guard="SIZE_DEVICE_INODE_UID_MODE_MTIME_CTIME",
            cache_helper="build/lean_table_checker/linux_native_cache_v7b/native_cache.py", cache_verifier=g.VERIFIER,
            original_roots=roots, code_paths=io_paths),
        worker=dict(build=bundle["generated_build"]["path"], executable=selected["native"]["path"],
            sha256=selected["native"]["sha256"], schema=g.NATIVE_SCHEMA, status=g.NATIVE_STATUS,
            span_protocol=g.PROTOCOL, checker_kind=g.MARKER, row_rounds=1, **g.NATIVE_LIMITS),
        proof=dict(theorem_family_count=104, inherited_theorem_count=88, additional_theorem_count=16,
            source_preservation=True, all_original_P_N_source_member_checks_retained=True,
            checker_kind=g.MARKER, exact_Lean_commit=g.LEAN_COMMIT), evidence_files=assets,
        source_equality_basis="BOUND_ACTUAL_RUNNER_FULL_BYTE_COMPARISON_NOT_REPEATED_BY_METADATA_GATE",
        aggregation_boundary="Python/OS custody and receipt replay, not a Lean aggregation finalizer",
        missing_full_authority="fresh34 costs, actual production phases/fees, full inputs/finite closure and independent evaluated authority")
    return gate


def main(args):
    began = time.monotonic()
    g.require(args.plan_only != args.seal, "Choose exactly one of --plan-only and --seal")
    destination = (c.ROOT/args.output).resolve()
    g.require(destination.is_relative_to(c.RUN) and not destination.exists(), "New gate output inside this campaign run is required")
    draft_path = destination.with_name(destination.stem+".candidate_"+str(time.time_ns())+".json")
    gate = candidate()
    c.atomic(draft_path, gate)
    _, build, assets = g.discover(draft_path)
    if args.plan_only:
        summary = dict(schema="PLANNED_JOINT_INDEXED_BYTE_WORKER_GATE_ASSEMBLY_V16", status="DRAFT_NOT_VALIDATED",
            draft=record(draft_path), discovered_files=len(assets), full_launch_allowed=False,
            actual_game_Lean_GPU_or_WSL_processes_started=0, original_source_bits_read=0)
    else:
        locks = c.ReadLocks(assets)
        try:
            current = c.bind(assets)
            for name, identity in gate["evidence_files"].items():
                g.require(current.get(name) == identity, "Current immutable evidence SHA changed: "+name)
            g.validate_locked(draft_path, gate, build, current)
            # Keep all code/ELF/output locks held across publication and the
            # final-path validation. A candidate is never silently overwritten.
            c.atomic(destination, gate)
            final_lock = c.ReadLocks([destination])
            try:
                current.update(c.bind([destination]))
                g.validate_locked(destination, gate, build, current)
                final_record = dict(path=c.rel(destination), **current[c.rel(destination)])
            finally:
                final_lock.close()
            summary = dict(schema="JOINT_INDEXED_BYTE_WORKER_GATE_METADATA_SEAL_V16", status="PASS_LOCKED_ACTUAL_RECEIPT_REPLAY",
                gate=final_record, candidate=record(draft_path), files_hashed_under_continuous_ReadLocks=len(current),
                bytes_hashed_under_continuous_ReadLocks=sum(item["bytes"] for item in current.values()),
                tiny_positive_unique_rows=62, resource_rows=4597996387, resource_frames=83,
                original_source_bits_read=0, actual_game_Lean_GPU_or_WSL_processes_started=0,
                historical_source_equality_not_independently_repeated=True, full_launch_allowed=False)
        finally:
            locks.close()
    summary["wall_seconds"] = time.monotonic()-began
    receipt = draft_path.with_suffix(".assembly.json")
    c.atomic(receipt, summary)
    print(json.dumps(record(receipt)), flush=True)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--plan-only", action="store_true")
    parser.add_argument("--seal", action="store_true")
    parser.add_argument("--output", default="runs/lean_table_checker/campaign_indexed_20261018_v16/linux_worker_gate.json")
    main(parser.parse_args())
