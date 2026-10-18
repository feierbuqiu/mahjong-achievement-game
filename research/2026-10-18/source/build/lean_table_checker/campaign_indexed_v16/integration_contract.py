"""Source-only V16 production integration contract, never an execution permit.

The unchanged journal and prior certificates can be reused. A new104-proof
Native, byte proposal and source-block cursor need fresh runtime/cost evidence.
This module performs no process creation and cannot admit a production run.
"""
from __future__ import annotations

import hashlib
import math
import re


SCHEMA = "SOURCE_ONLY_JOINT_INDEXED_PRODUCTION_INTEGRATION_CONTRACT_V16"
BACKEND = "linux_fused_joint_indexed_byte_checked_constructor_native_cache_v16"
PROFILE = "OVERNIGHT_V16_JOINT_INDEXED_REGISTERED_CALIBRATION_PROFILE"
MANIFEST = "INDEXED_BYTE_CHECKED_CONSTRUCTOR_CROSS_LAYER_LEAN_CAMPAIGN_MANIFEST_V16"
SPAN_PROTOCOL = "fused_linux_v16_joint_indexed_byte_checked_constructor_native_cache"
BRIDGE_CONFIG = "FUSED_LINUX_INDEXED_BYTE_BRIDGE_CONFIGURATION_V16"
BRIDGE_EVENT = "FUSED_LINUX_INDEXED_BYTE_LEAN_BRIDGE_V16"
NATIVE_EVENT = "INDEXED_BYTE_LARGE_FRAME_RESIDENT_PROTOCOL_V16"
RESULT_SCHEMA = "PACKED_INDEXED_BYTE_FRAME_LEAN_PERSISTENT_SPAN_V16"
RESULT_STATUS = "PASS_COMPILED_LEAN_PACKED_INDEXED_BYTE_FRAME_PERSISTENT_SPAN_V16"
TRANSPORT = "indexed_actual_next_byte_v16"
GPU_PROTOCOL = "GPU_CROSS_BUCKET_INDEXED_BYTE_PROTOCOL_V16"
GPU_REVISION = "INDEXED_ACTUAL_NEXT_BYTE_BOUNDED_8MI_SCRATCH_V16"
PLAN_CHECKER = "PROVED_BORROWED_NEXT_GLOBAL_NEXT_GENERATED_PLAN_V12"
CONSTRUCTOR = "PROVED_ONCE_CHECKED_TEMPLATE_CONSTRUCTOR_V16"
ROW_CHECKER = "PROVED_INDEXED_NEXT_BYTE_SCALAR_SCAN_V16"
SCHEDULE = "PROVED_CONTIGUOUS_PARTITION_STRIDED_FIXED_ROUNDS_V13"
LARGE_FRAME_POLICY = "BOUNDED_64MI_ROWS_COMPLETE_T_INDEXED_BYTE_V16"
TIMING_PROFILE = "WALL_ENVELOPES_INDEXED_BYTE_V16_1"
TIMING_SCHEMA = "FUSED_LINUX_INDEXED_BYTE_FRAME_WALL_ENVELOPES_V16"
COUNTS = dict(inherited=88, checked_constructor=4, indexed_byte=6,
              input_offsets_and_block_runs=5, guarded_scan=1, total=104)
RECORD_BYTES = 1
ROW_CAP = 67108864
BLOCK_CAP = 8192
TEMPLATE_HARD_CAP = 500000
EPOCH_CAP = 16
THREADS = 12
ROUNDS = 1
SERIAL_T_THRESHOLD = 4096
PIPE_CAPACITY_BYTES = 1048576
WRITE_CHUNK_BYTES = 4194304
GPU_SCRATCH_ROWS = 8388608
GPU_SCRATCH_BYTES = GPU_SCRATCH_ROWS
PAYLOAD_END_BYTES = 24

NATIVE_RECEIPTS = "build/lean_table_checker/linux_bridge_indexed_v16/native_receipts.py"
PRODUCTION_CANDIDATE_RECORD = dict(
    path="runs/lean_table_checker/linux_bridge_test_indexed_20261018_v16/native_candidate.json",
    bytes=1365, sha256="09f7f31d49a514c3279fabc6223c282ba6ca88653c492664e13555f40f78c104")
GPU_RULES = "build/lean_table_checker/gpu_indexed_byte_receipt_v16/rules.py"
GPU_RULES_IDENTITY = dict(bytes=7584,
    sha256="9160915678016c51c74c87d1cb28cb9a1b5c9c14cfeaf094973d755ba0268f2a")

RESOURCES = dict(Windows_job_cap_bytes=1250000000, Windows_CPU_percent=5,
    Linux_memory_max_bytes=14250000000//4096*4096,
    Linux_memory_high_bytes=13000000000//4096*4096, Linux_CPU_percent=75,
    Linux_swap_max_bytes=0, Linux_pids_max=128, GPU_task_cap_bytes=6000000000,
    GPU_global_cap_bytes=7000000000, GPU_min_free_bytes=1000000000,
    GPU_host_RSS_cap_bytes=3000000000, threads=THREADS)

# Historical certificate names are statements about their original checker.
# They must not be globally renamed to the new checker/profile identity.
HISTORICAL_IMPORT_KIND = "IMPORTED_VERIFIED_COMPLETE_NATIVE_BUCKET_V12_BORROWED_NEXT_GENERATED_NATIVE_CACHE"
HISTORICAL_COMPLETE_KIND = "CHECKED_EXACT_NATIVE_LEDGER_COVERAGE"
MISSING_ACTUAL_EVIDENCE = (
    "fresh104_native_tiny_and_negative_controls",
    "fresh104_same_profile_registered_resource_matrix",
    "fresh104_same_profile_registered34_cost_matrix",
    "fresh104_four_actual_production_functional_phases",
    "actual_production_validation_registry_ledger_and_retry_costs",
    "exact_full_manifest_runtime_finite_premise_input_custody",
    "independent16h_with25percent_margin_and20h_hard_budget_authority",
)


def need(value, message):
    if not value:
        raise ValueError(message)


def exact(value, wanted, message):
    need(isinstance(value, dict) and all(type(value.get(k)) is type(v) and value[k] == v
         for k, v in wanted.items()), message)


def bind_checked_source(raw, expected):
    """Check exact supplied source bytes, not merely their expected digest map.

    The operational caller must have acquired the continuous read handles
    before reading these bytes and retain them until kernel-empty cleanup.
    This pure function does not manufacture or assert OS custody.
    """
    need(isinstance(raw, bytes), "Source must be actual bytes")
    exact(dict(bytes=len(raw), sha256=hashlib.sha256(raw).hexdigest()), expected,
          "Actual source bytes do not match the frozen identity")
    return raw


def validate_build_candidate(value):
    exact(value, dict(schema="JOINT_INDEXED_BYTE_ACTUAL_NATIVE_CANDIDATE_V16",
        status="BOUND_ACTUAL104_KERNEL_AND_LINUX_BUILD_ONLY", pure_kernel_theorem_count=104,
        native_protocol=NATIVE_EVENT, transport=TRANSPORT, record_bytes=1,
        row_rounds=1, threads=12, resident_count_cap=ROW_CAP, frame_block_cap=BLOCK_CAP,
        frame_template_cap=TEMPLATE_HARD_CAP, native_epoch_frame_cap=EPOCH_CAP,
        input_fragment_count=12, maximum_piece_bytes=5592406, full_launch_allowed=False),
        "Only the actual new joint104/one-byte candidate is eligible")
    for role in ("native", "proof_bundle"):
        rec = value.get(role, {})
        need(isinstance(rec.get("path"), str) and type(rec.get("bytes")) is int and rec["bytes"] > 0
             and re.fullmatch("[0-9a-f]{64}", rec.get("sha256", "")),
             "Candidate must bind exact Native and proof bundle records")
    return dict(value)


def validate_candidate(value):
    """The separately pinned tiny/resource/34 production candidate projection.

    It has the same ELF/proof bundle as the original build candidate, but is a
    different immutable JSON record. Never substitute one record for the other.
    """
    exact(value, dict(schema="JOINT_INDEXED_BYTE_ACTUAL_NATIVE_CANDIDATE_V16",
        status="BOUND_ACTUAL_KERNEL_AND_LINUX_BUILD_ONLY", backend=BACKEND,
        pure_kernel_theorem_count=104, native_protocol=NATIVE_EVENT,
        transport=TRANSPORT, record_bytes=1, row_rounds=1, threads=12,
        resident_count_cap=ROW_CAP, frame_block_cap=BLOCK_CAP,
        frame_template_cap=TEMPLATE_HARD_CAP, native_epoch_frame_cap=EPOCH_CAP,
        input_fragment_count=12, plan_constructor_kind=CONSTRUCTOR,
        row_checker_kind=ROW_CHECKER, small_plan_serial_template_threshold=4096,
        full_launch_allowed=False), "Use only the exactly pinned production candidate projection")
    for role in ("native", "proof_bundle"):
        rec = value.get(role, {})
        need(isinstance(rec.get("path"), str) and type(rec.get("bytes")) is int and rec["bytes"] > 0
             and re.fullmatch("[0-9a-f]{64}", rec.get("sha256", "")),
             "Candidate must bind exact Native and proof bundle records")
    return dict(value)


def validate_span_metadata(value, frame, shared_native_receipts):
    """Extend, do not replace, the frozen bridge's pure Native receipt rules.

    Only the caller's locked/hash-verified module may be passed as
    shared_native_receipts. Actual packed/source bytes and certified targets
    must still be checked by the original commit/registry path.
    """
    count, start = frame["count"], frame["start"]
    need(type(count) is int and 0 < count <= ROW_CAP and type(start) is int and start >= 0,
         "Invalid exact frame")
    budget = frame["template_budget"]
    need(type(budget) is int and budget in (250000, 500000), "Use the registered full-template budget")
    checked = shared_native_receipts.worker(value, budget)
    exact(value, dict(schema=RESULT_SCHEMA, status=RESULT_STATUS, start=start, count=count,
        checked_rows=count, layer=frame["layer"], honor=frame["honor"],
        plan_blocks=frame["source_blocks"],
        frame_full_templates_without_reuse=frame["templates"],
        plan_checker_kind=PLAN_CHECKER, row_schedule_kind=SCHEDULE,
        row_partition_checked=True, row_partition_chunks=12,
        per_row_timing_or_sampling_added=False), "Worker/frame/profile identity differs")
    need(value.get("scan_ns") == value.get("plan_phase_wall_ns", -1) + value.get("row_scan_ns", -1),
         "Inclusive plan+row timer contract differs")
    exact(value, dict(label_bytes=(count+7)//8, label_valid_bits=count,
        label_padding_bits=(-count)%8), "Packed label extent/padding identity differs")

    # The schedule and r checks are Lean/runtime checks. These extra metadata
    # checks prevent a reused/mismatched diagnostic report from being accepted.
    workers = value["row_worker_diagnostics"]
    need(len({w.get("worker") for w in workers}) == 12, "Worker diagnostics duplicate or omit an assignment")
    totals = dict(P_rows=0, N_rows=0, assigned_rows=0, cursors=0, nonempty=0)
    for number, worker in enumerate(workers):
        first = start + count*number//12
        stop = start + count*(number+1)//12
        size = stop-first
        exact(worker, dict(worker=number, assigned_rows=size, chunk_count=1,
            nonempty_chunks=int(size > 0)), "Actual worker partition differs")
        need(worker.get("chunks") == [dict(chunk=number, first=first, count=size)],
             "Actual absolute worker chunk range differs")
        p, n = worker.get("P_rows"), worker.get("N_rows")
        need(type(p) is int and type(n) is int and p >= 0 and n >= 0 and p+n == size,
             "Worker P/N does not cover its exact assigned rows")
        cursor = worker.get("source_cursor_initializations")
        need(type(cursor) is int and (1 <= cursor <= size if size else cursor == 0),
             "Actual per-block source cursor count missing")
        totals["P_rows"] += p
        totals["N_rows"] += n
        totals["assigned_rows"] += size
        totals["cursors"] += cursor
        totals["nonempty"] += int(size > 0)
    exact(value, dict(P_rows=totals["P_rows"], N_rows=totals["N_rows"],
        source_decode_calls=totals["cursors"],
        worker_nonempty_chunk_initializations=totals["nonempty"]),
        "Native aggregate differs from actual twelve worker reports")
    return dict(checked, exact_worker_schedule_reconciled=True,
        packed_source_bytes_still_require_complete_comparison=True,
        TargetCorrect_still_requires_complete_next_layer_registry=True,
        full_launch_allowed=False)


def validate_ready(value, layer, honor, shared_native_receipts):
    exact(value, dict(event="READY", schema=NATIVE_EVENT, layer=layer, honor=honor),
          "READY does not belong to the actual requested Native bucket")
    shared_native_receipts.ready(value)
    return dict(record_bytes=1, exact104_READY_identity_only=True,
                game_rows_certified_by_this_metadata_check=0, full_launch_allowed=False)


def reject_execution_until_fresh_gate(*args, **kwargs):
    raise ValueError("V16_SOURCE_ONLY_NO_EXECUTION_GATE: " + ",".join(MISSING_ACTUAL_EVIDENCE))


def reject_full_authority(*args, **kwargs):
    raise ValueError("V16_FULL_RUN_BLOCKED: old V12/V14 authority and unknown production fees cannot authorize the new104/one-byte profile")


def validate_cost_limits(value):
    """Pure numerical contract; returning here never authorizes a run."""
    exact(value, dict(hard_cumulative_seconds=72000, full_launch_allowed=False),
          "The immutable manifest cannot grant permission or extend20h")
    upper, margin = value.get("conservative_empirical_upper_seconds"), value.get("margin_fraction")
    need(type(upper) in (int, float) and math.isfinite(upper) and 0 < upper <= 57600,
         "Known complete upper bound, including all costs, must be<=16h")
    need(type(margin) in (int, float) and math.isfinite(margin) and margin >= .25,
         "At least25percent measured safety margin is mandatory")
    need(value.get("unmeasured_cost_components") == [], "Missing production fees cannot become zero")
    return dict(numerical_limits_only=True, full_launch_allowed=False)
