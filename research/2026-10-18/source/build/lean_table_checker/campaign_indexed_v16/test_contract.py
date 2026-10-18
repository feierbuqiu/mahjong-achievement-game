"""Small synthetic contract controls, no process/GPU/Native/label-bank work."""
from __future__ import annotations

import ast
import copy
import hashlib
import json
from pathlib import Path
import time
import types

import integration_contract as rules
import prepare_source_plan as plan


def load_shared():
    freeze, _ = plan.checked_small(plan.BRIDGE_FREEZE, plan.BRIDGE_FREEZE_SHA)
    identity = freeze["files"][rules.NATIVE_RECEIPTS]
    raw = (plan.ROOT/rules.NATIVE_RECEIPTS).read_bytes()
    rules.bind_checked_source(raw, identity)
    ast.parse(raw, filename=rules.NATIVE_RECEIPTS)
    module = types.ModuleType("_pure_shared_native_receipts_controls_only")
    exec(compile(raw, rules.NATIVE_RECEIPTS, "exec"), module.__dict__)
    return module, dict(path=rules.NATIVE_RECEIPTS, **identity)


def fixture(count=71, start=12345, templates=4096, blocks=8):
    frame = dict(count=count, start=start, layer=23, honor=35,
                 template_budget=250000, templates=templates, source_blocks=blocks)
    workers = []
    for number in range(12):
        first = start+count*number//12
        size = start+count*(number+1)//12-first
        workers.append(dict(worker=number, assigned_rows=size, chunk_count=1,
            nonempty_chunks=int(size > 0), chunks=[dict(chunk=number, first=first, count=size)],
            P_rows=size//2, N_rows=size-size//2, source_cursor_initializations=int(size > 0), wall_ns=10))
    value = dict(schema=rules.RESULT_SCHEMA, status=rules.RESULT_STATUS,
        **{k:frame[k] for k in ("layer", "honor", "start", "count")},
        checked_rows=count, resident_count_cap=rules.ROW_CAP, frame_block_cap=8192,
        frame_template_cap=500000, native_epoch_frame_cap=16,
        large_frame_policy=rules.LARGE_FRAME_POLICY, transport=rules.TRANSPORT,
        threads=12, row_rounds=1, input_fragment_count=12,
        input_memory_lifetime="MAIN_PIECE_OWNERS_UNTIL_ALL_TASKS_JOIN_V16",
        input_fragment_max_bytes=(count+11)//12,
        plan_constructor_kind=rules.CONSTRUCTOR, small_plan_serial_template_threshold=4096,
        row_checker_kind=rules.ROW_CHECKER, pure_checker_theorem_fingerprints=104,
        indexed_byte_mode=True, compact_word_mode=False, gpu_source_packet_mode=False,
        gpu_witness_mode=True, source_r_guard_every_row=True, source_block_cover_checked=True,
        source_decode_calls_kind="ONCE_PER_CHECKED_SOURCE_BLOCK_RUN",
        actual_successors_all_checked=True, template_plan_checker=True,
        frame_template_count_includes_SAFE_and_unsafe=True,
        plan_check_ns_includes_constructor_build=True, raw_plan_build_ns_is_context_only=True,
        label_format="PACKED_LSB0", payload_end_bytes=24, compact_bytes=count,
        plan_blocks=blocks, frame_full_templates_without_reuse=templates,
        plan_prepare_workers=1 if templates<=4096 else min(12, blocks),
        row_worker_diagnostics=workers, source_decode_calls=sum(w["source_cursor_initializations"] for w in workers),
        worker_nonempty_chunk_initializations=sum(w["nonempty_chunks"] for w in workers),
        P_rows=sum(w["P_rows"] for w in workers), N_rows=sum(w["N_rows"] for w in workers),
        plan_checker_kind=rules.PLAN_CHECKER, row_schedule_kind=rules.SCHEDULE,
        row_partition_checked=True, row_partition_chunks=12,
        per_row_timing_or_sampling_added=False,
        scan_ns=30, plan_phase_wall_ns=10, row_scan_ns=20,
        label_bytes=(count+7)//8, label_valid_bits=count, label_padding_bits=(-count)%8)
    return value, frame


def main():
    shared, shared_record = load_shared()
    controls = []
    def yes(name, call):
        call(); controls.append(dict(name=name, status="PASS"))
    def no(name, call):
        try:
            call()
        except (ValueError, TypeError, KeyError):
            controls.append(dict(name=name, status="PASS_EXPECTED_REJECTION"))
        else:
            raise AssertionError("Did not reject: "+name)
    def mutate(name, patch):
        v, f = fixture(); patch(v, f)
        no(name, lambda: rules.validate_span_metadata(v, f, shared))

    for count in (1, 7, 8, 12, 13, 71, 67108864):
        v, f = fixture(count)
        yes("exact_partition_count_"+str(count), lambda v=v, f=f: rules.validate_span_metadata(v, f, shared))
    for t, b in ((0, 1), (4096, 8192), (4097, 8), (210147, 8192)):
        v, f = fixture(templates=t, blocks=b)
        yes("fullT_threshold_"+str(t), lambda v=v, f=f: rules.validate_span_metadata(v, f, shared))
    ready, _ = fixture()
    ready.update(event="READY", schema=rules.NATIVE_EVENT, record_bytes=1)
    yes("exact104_ready",lambda: rules.validate_ready(ready,23,35,shared))
    for key,bad in (("schema","LARGE_FRAME_RESIDENT_PROTOCOL_V14"), ("record_bytes",8),
        ("pure_checker_theorem_fingerprints",88), ("layer",24), ("honor",34),
        ("source_block_cover_checked",False)):
        wrong=dict(ready, **{key:bad})
        no("ready_"+key,lambda v=wrong: rules.validate_ready(v,23,35,shared))
    for key, bad in (
        ("schema", "PACKED_COMPACT_LARGE_FRAME_LEAN_PERSISTENT_SPAN_V14"),
        ("status", "PASS_COMPILED_LEAN_PACKED_COMPACT_LARGE_FRAME_PERSISTENT_SPAN"),
        ("pure_checker_theorem_fingerprints", 88), ("compact_bytes", 568),
        ("indexed_byte_mode", False), ("compact_word_mode", True),
        ("gpu_source_packet_mode", True), ("source_decode_calls", 0),
        ("source_r_guard_every_row", False), ("source_block_cover_checked", False),
        ("plan_constructor_kind", rules.PLAN_CHECKER), ("small_plan_serial_template_threshold", 8192),
        ("plan_prepare_workers", 8), ("frame_template_count_includes_SAFE_and_unsafe", False),
        ("row_partition_chunks", 11), ("payload_end_bytes", 23),
        ("per_row_timing_or_sampling_added", True), ("label_padding_bits", 0),
        ("scan_ns", 999), ("threads", True), ("input_fragment_count", 1),
    ):
        mutate("reject_"+key, lambda v, f, k=key, b=bad: v.update({k:b}))
    mutate("wrong_absolute_source_r", lambda v, f: v["row_worker_diagnostics"][0]["chunks"][0].update(first=0))
    mutate("duplicate_worker", lambda v, f: v["row_worker_diagnostics"][1].update(worker=0))
    mutate("wrong_worker_PN", lambda v, f: v["row_worker_diagnostics"][0].update(P_rows=50))
    mutate("missing_worker_cursor", lambda v, f: v["row_worker_diagnostics"][0].update(source_cursor_initializations=0))
    mutate("false_aggregate_P", lambda v, f: v.update(P_rows=0, N_rows=v["count"]))
    no("full_authority_is_not_implemented", rules.reject_full_authority)
    no("bounded_execution_gate_is_not_implemented", rules.reject_execution_until_fresh_gate)
    raw=b"exact current source"
    ident=dict(bytes=len(raw), sha256=hashlib.sha256(raw).hexdigest())
    yes("source_actual_bytes_match", lambda: rules.bind_checked_source(raw, ident))
    no("expected_map_cannot_excuse_changed_source", lambda: rules.bind_checked_source(raw+b"!", ident))
    numeric=dict(hard_cumulative_seconds=72000, full_launch_allowed=False,
        conservative_empirical_upper_seconds=57600, margin_fraction=.25, unmeasured_cost_components=[])
    yes("numerical_limit_is_not_authority", lambda: rules.validate_cost_limits(numeric))
    for key, bad in (("conservative_empirical_upper_seconds",57601),
        ("margin_fraction",.24), ("unmeasured_cost_components",["fees"]),
        ("hard_cumulative_seconds",72001), ("full_launch_allowed",True)):
        bad_value=dict(numeric, **{key:bad})
        no("cost_"+key, lambda v=bad_value: rules.validate_cost_limits(v))
    candidate=plan.ROOT/"runs/lean_table_checker/joint_indexed_build_20261018_v16/b_b1f377d7b5384300af48ad2508bc46d2/native_candidate.json"
    value=json.loads(candidate.read_bytes())
    yes("actual_build_candidate_shape",lambda: rules.validate_build_candidate(value))
    bad=copy.deepcopy(value);bad["pure_kernel_theorem_count"]=88
    no("old88_candidate_rejected",lambda: rules.validate_build_candidate(bad))
    bad=copy.deepcopy(value);bad["status"]="BOUND_ACTUAL_KERNEL_AND_LINUX_BUILD_ONLY"
    no("separate_projected_tiny_candidate_is_not_the_build_record",lambda: rules.validate_build_candidate(bad))
    projected=json.loads((plan.ROOT/rules.PRODUCTION_CANDIDATE_RECORD["path"]).read_bytes())
    yes("explicit_production_candidate_projection",lambda: rules.validate_candidate(projected))
    no("original_build_candidate_cannot_substitute_for_production_record",lambda: rules.validate_candidate(value))
    result=plan.build_plan()
    yes("exact29_baseline_all_files_have_disposition",lambda: result["baseline29_current_source_bindings"])
    for path in Path(__file__).parent.glob("*.py"):
        ast.parse(path.read_bytes(),filename=str(path))
    report=dict(schema="JOINT_INDEXED_CONTROLLER_SOURCE_PLAN_PURE_CONTROLS_V16",
        status="PASS_SOURCE_ONLY_NO_RUNTIME_ADMISSION", controls=controls,
        control_count=len(controls), shared_native_rules=shared_record,
        baseline_file_count=29, source_file_AST_count=len(list(Path(__file__).parent.glob("*.py"))),
        actual_Native_or_GPU_rows=0, WSL_processes_started=0,
        execution_permitted=False, full_launch_allowed=False,
        missing_actual_evidence=list(rules.MISSING_ACTUAL_EVIDENCE))
    path=plan.ROOT/"runs/lean_table_checker/campaign_indexed_20261018_v16"/("source_controls_"+str(time.time_ns())+".json")
    path.parent.mkdir(parents=True,exist_ok=True)
    raw=(json.dumps(report,indent=2,sort_keys=True)+"\n").encode()
    with path.open("xb") as stream:stream.write(raw)
    print(json.dumps(dict(path=path.relative_to(plan.ROOT).as_posix(),bytes=len(raw),sha256=hashlib.sha256(raw).hexdigest(),controls=len(controls),status=report["status"])))


if __name__=="__main__":
    main()
