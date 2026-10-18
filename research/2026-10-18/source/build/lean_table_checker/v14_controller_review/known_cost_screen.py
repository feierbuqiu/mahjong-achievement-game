"""Read-only partial cost screening; never manufacture zero production fees.

Only after the actual matrix is complete, replay its bounded persisted output
with the exact Root helper and reproduce the nine already measured fb161 cost
components.  The six unknown production coefficients remain UNKNOWN; the
registered model's compute_components is intentionally never called here.
This is a lower bound on that registered empirical accounting total, not a
mathematical lower bound on future machine runtime or a launch authority.
"""
from pathlib import Path
import argparse
import collections
import copy
import ctypes
import datetime
import hashlib
import json
import math
import os
import re
import types

ROOT = Path(__file__).resolve().parents[3]
HELPER = dict(path="build/lean_table_checker/integration_v14/evaluate_cost_evidence.py", bytes=22287,
              sha256="3b674bfcf406270c053662cc96297cb920455e29a11b4f92776caa7a474b72d6")
RESOURCE = dict(path="runs/lean_table_checker/linux_bridge_resource_scratch_20261018_v15/rounds1_01d1e279caf1/acceptance.json",
                bytes=616245, sha256="caa7d25c0b52e4641ada0a72d11103be550c783f8c6c0780193a45c35198514d")
RESOURCE_REVIEW = dict(path="runs/lean_table_checker/v14_controller_review/scratch_resource_independent_20261017T234618779759Z.json",
                       bytes=53920, sha256="8dd62406af86f8e2c3a08fa02d9f8078e0352c4ee3b44c605697585bf380e237")
UNKNOWN = (
    "ledger_increment_per_frame_upper_seconds",
    "certificate_registry_per_bucket_upper_seconds",
    "shared_once_hash_setup_upper_seconds",
    "final_scope_cleanup_upper_seconds",
    "additional_scope_init_close_inclusive_upper_seconds",
    "retry_recovery_reserve_seconds",
)
MAX_BYTES = 32 * 1024 * 1024
HEX = re.compile(r"[0-9a-f]{64}\Z")


def need(value, message):
    if not value:
        raise ValueError(message)


def duration(value):
    need(type(value) in (int, float) and math.isfinite(value) and value >= 0, "Invalid measured duration")
    return float(value)


def known_components(geometry, plan, observations, observed_stability, model, interval_margin):
    """Exact nonproduction portion of registered fb161, without fee defaults."""
    need(type(interval_margin) is int and interval_margin in (0, 1), "Explicit observed or one-frame-conservative policy required")
    cases = {c["id"]: c for c in plan["cases"]}
    need(len(cases) == len(observations) == 34 and {o["case_id"] for o in observations} == set(cases),
         "All34 actual registered cases are mandatory")
    need(len({o["profile_sha256"] for o in observations}) == len({o["worker_executable_sha256"] for o in observations}) == 1,
         "A cost screen cannot mix actual profiles or executables")
    pending = sorted((b for b in geometry["buckets"] if b["layer"] <= 31), key=lambda b: (-b["layer"], b["honor"]))
    weights = collections.defaultdict(collections.Counter)
    by_stratum = collections.defaultdict(list)
    by_bank = collections.defaultdict(list)
    for b in pending:
        w = weights[model.stratum_key(b, plan["density_threshold"])]
        for target, source in (("rows", "rows"), ("frames", "frame_count"), ("edges", "raw_plan_edges"),
                               ("templates", "raw_templates"), ("frame_templates", "frame_templates_without_reuse")):
            w[target] += b[source]
        w["buckets"] += 1
    need(len(plan["strata"]) == len(weights), "Missing/duplicate registered stratum")
    for s in plan["strata"]:
        w = weights[s["key"]]
        need(all(w[k] == s[v] for k, v in (("rows", "rows"), ("edges", "raw_plan_edges"), ("buckets", "buckets"),
                                            ("templates", "raw_templates"), ("frame_templates", "frame_templates_without_reuse"))),
             "Registered exact geometry/stratum differs")
    for o in observations:
        c = cases[o["case_id"]]
        need((o["layer"], o["honor"]) == (c["layer"], c["honor"]) and o["rows"] > 0 and o["frames"] > 0,
             "Actual observation belongs to another selected case")
        need(c["minimum_completed_frames"] <= o["frames"] <= c["maximum_requested_frames"] and
             o["whole_bucket_seconds"] <= c["hard_case_seconds"], "Reduced or late actual observation")
        need(o["accounting_contract"] == model.CONTRACT and
             o["raw_plan_templates"] >= o["actual_materialized_plan_templates"] >= o["steady_actual_materialized_plan_templates"] >= 0,
             "Actual all-key work/accounting contract changed")
        if c.get("must_observe_native_recycle"):
            need(o["native_epochs"] >= 2, "Required actual native recycling was not observed")
        for key in c["covers_strata"]:
            by_stratum[key].append(o)
        by_bank[model.bankclass(c["source_and_child_bank_bytes"])].append(o)
    need(set(by_stratum) == set(weights), "Missing measured stratum")
    substantial = [o for o in observations if o["rows"] >= 1000000]
    need(substantial, "No substantial actual row observation")
    fallback = max(duration(o["row_seconds"]) / o["rows"] for o in substantial)
    row_cost = frame_cost = 0.0
    caps = []
    for key, w in sorted(weights.items()):
        useful = [o for o in by_stratum[key] if o["rows"] >= 1000000]
        row_cap = max((duration(o["row_seconds"]) / o["rows"] for o in useful), default=fallback)
        frame_cap = max(duration(o["conservative_noncore_frame_wall_seconds"]) / o["frames"] for o in by_stratum[key])
        row_cost += w["rows"] * row_cap
        frame_cost += w["frames"] * frame_cap
        caps.append(dict(stratum=key, rows=w["rows"], frames=w["frames"], row_ns=row_cap * 1e9,
                         noncore_seconds_per_frame=frame_cap))
    steady = [o for o in observations if o["steady_actual_materialized_plan_templates"]]
    need(steady, "No positive actual nonfirst template phase")
    template_cap = max(duration(o["steady_plan_phase_seconds_per_T_upper"]) for o in steady)
    need(observed_stability["profile_epoch_cap"] == 16, "Actual max16 resource policy required")
    observed_intervals = observed_stability["minimum_validated_full_epoch_frames_by_bank_class"]
    need(set(observed_intervals) == {"0", "1", "2", "3"} and
         all(type(v) is int and 1 <= v <= 16 for v in observed_intervals.values()), "Incomplete actual bank intervals")
    intervals = {k: max(1, v - interval_margin) for k, v in observed_intervals.items()}
    cold = leave = fill = reference = restart = first_plan = 0.0
    epoch_count = 0
    for b in pending:
        cls = model.bankclass(b["source_and_child_bank_bytes"])
        group = by_bank[cls]
        need(group, "Missing actual bank class")
        epochs = math.ceil(b["frame_count"] / intervals[str(cls)])
        epoch_count += epochs
        cold += max(duration(o["cold_bucket_seconds"]) for o in group)
        leave += max(duration(o["explicit_bucket_leave_seconds"]) for o in group)
        fill += max(duration(o["initial_nonprefetched_fill_seconds"]) for o in group)
        reference += max(duration(o["epoch_reference_upper_seconds"]) for o in group) * epochs
        first_cap = max([duration(o["epoch_first_plan_phase_upper_seconds"]) for o in group] +
                        [duration(observed_stability["maximum_epoch_first_plan_phase_seconds_by_bank_class"][str(cls)])])
        first_plan += first_cap * epochs
        restart_cap = max([duration(o["complete_native_restart_upper_seconds"]) for o in group] +
                          [duration(observed_stability["maximum_complete_native_restart_seconds_by_bank_class"][str(cls)])])
        restart += restart_cap * (epochs - 1)
    parts = dict(row_seconds=row_cost,
                 steady_plan_seconds=sum(b["frame_templates_without_reuse"] for b in pending) * template_cap,
                 entire_epoch_first_plan_phase_seconds=first_plan,
                 conservative_transport_verify_save_seconds=frame_cost,
                 cold_bucket_seconds=cold, explicit_bucket_leave_seconds=leave,
                 initial_nonprefetched_fill_per_bucket_seconds=fill,
                 once_per_native_epoch_reference_seconds=reference,
                 intermediate_native_restart_seconds=restart)
    known = sum(parts.values())
    return dict(known_components_before25percent_margin=parts,
                known_component_seconds_before25percent_margin=known,
                known_component_seconds_after25percent_margin=known * 1.25,
                known_component_hours_after25percent_margin=known * 1.25 / 3600,
                already_exceeds_internal16h_without_unknown_fees=known * 1.25 > 57600,
                charged_interval_margin_frames=interval_margin, charged_complete_epoch_intervals=intervals,
                actual_interval_native_epochs=epoch_count, pending_rows=sum(b["rows"] for b in pending),
                canonical_frames=sum(b["frame_count"] for b in pending), pending_buckets=len(pending),
                stratum_caps=caps, global_steady_plan_wall_seconds_per_actual_materialized_template=template_cap,
                missing_production_cost_coefficients={k: "UNKNOWN_NOT_IMPUTED" for k in UNKNOWN},
                missing_costs_are_nonnegative_but_not_passed_to_model=True,
                compute_components_called=False, full_launch_allowed=False)


class Evidence:
    """Retain write/delete-denying custody for bounded application evidence."""
    def __init__(self):
        need(os.name == "nt", "Actual evidence replay must run on the Windows custody host")
        self.handles, self.records, self.cache = [], {}, {}
        self.k = ctypes.WinDLL("kernel32", use_last_error=True)
        self.k.CreateFileW.argtypes = [ctypes.c_wchar_p, ctypes.c_uint32, ctypes.c_uint32, ctypes.c_void_p,
                                      ctypes.c_uint32, ctypes.c_uint32, ctypes.c_void_p]
        self.k.CreateFileW.restype = ctypes.c_void_p
        self.k.CloseHandle.argtypes = [ctypes.c_void_p]

    def path(self, name):
        p = (ROOT / name).resolve()
        need(p.is_relative_to(ROOT) and p != ROOT and p.relative_to(ROOT).as_posix() == name,
             "Noncanonical evidence path")
        return p

    def lock(self, path):
        h = self.k.CreateFileW(str(path), 0x80000000, 1, None, 3, 0x80, None)
        if h in (None, ctypes.c_void_p(-1).value):
            raise ctypes.WinError(ctypes.get_last_error())
        self.handles.append(h)

    def blob(self, rec):
        need(type(rec.get("bytes")) is int and 0 <= rec["bytes"] <= MAX_BYTES and
             HEX.fullmatch(rec.get("sha256", "")) is not None, "Exact bounded evidence identity required")
        name = rec["path"]
        p = self.path(name)
        if name in self.records:
            need(rec == self.records[name], "Mixed evidence identity")
            if name in self.cache:
                return self.cache[name]
        else:
            self.lock(p)
        with p.open("rb") as f:
            raw = f.read(MAX_BYTES + 1)
        need(len(raw) == rec["bytes"] and hashlib.sha256(raw).hexdigest() == rec["sha256"], "Changed actual evidence: " + name)
        self.records[name], self.cache[name] = dict(rec), raw
        return raw

    def capture(self, path):
        p = Path(path).resolve()
        need(p.is_relative_to(ROOT) and p != ROOT, "Evidence escaped workspace")
        self.lock(p)
        with p.open("rb") as f:
            raw = f.read(MAX_BYTES + 1)
        need(len(raw) <= MAX_BYTES, "Oversized evidence")
        rec = dict(path=p.relative_to(ROOT).as_posix(), bytes=len(raw), sha256=hashlib.sha256(raw).hexdigest())
        return rec, self.blob(rec)

    def local(self, path):
        rec, raw = self.capture(path)
        return rec, json.loads(raw.decode("utf-8-sig"))

    def read(self, rec):
        return json.loads(self.blob(rec).decode("utf-8-sig"))

    def close(self):
        for h in reversed(self.handles):
            self.k.CloseHandle(h)
        self.handles = []


def load_bound(e, rec, name):
    module = types.ModuleType(name)
    module.__file__ = str(e.path(rec["path"]))
    exec(compile(e.blob(rec), module.__file__, "exec"), module.__dict__)
    return module


def main(args):
    need(args.execute_completed_evidence_review, "Wait for Root's completed matrix and released metadata review window")
    e = Evidence()
    try:
        self_record, _ = e.capture(Path(__file__))
        helper = load_bound(e, HELPER, "_bound_final_v14_arithmetic_helper")
        matrix_rec, matrix = e.local(args.acceptance)
        profile = e.read(matrix["profile"])
        plan, geometry = e.read(helper.PLAN), e.read(helper.GEOMETRY)
        source = e.read(helper.CALIBRATION_SOURCE)
        need(source["files"].get(helper.RESOURCE_SOURCE["path"]) ==
             {k: helper.RESOURCE_SOURCE[k] for k in ("bytes", "sha256")}, "Fresh calibrated resource source changed")
        need(profile["source_freeze_sha256"] == matrix["source_freeze_sha256"] == helper.CALIBRATION_SOURCE["sha256"],
             "Actual calibration source identity differs")
        need(matrix["resource_matrix_acceptance"] == profile["resource_matrix_acceptance"] == RESOURCE,
             "The source-bound independently replayed resource matrix changed")
        resource, review = e.read(RESOURCE), e.read(RESOURCE_REVIEW)
        need(review["acceptance"] == RESOURCE and review["frames"] == 83 and
             review["all_owned_services_confirmed_exited"] is True and review["all_actual_scratch_chunks_verified"] is True,
             "The complete independent resource replay is missing")
        need(resource["source_revision"] == helper.RESOURCE_REVISION and
             resource["resource_source_freeze_sha256"] == helper.RESOURCE_SOURCE["sha256"], "Another resource revision")
        e.read(helper.RESOURCE_SOURCE)
        model = load_bound(e, helper.MODEL, "_bound_fb161_registered_cost_model")
        model.validate_profile(profile)
        observations = helper.actual_cases(e, matrix, profile, plan, model)
        observed = resource["model_ready_stability"]
        scenarios = {str(m): known_components(geometry, plan, observations, copy.deepcopy(observed), model, m) for m in (0, 1)}
        report = dict(schema="INDEPENDENT_PARTIAL_KNOWN_COST_SCREEN_V14", status="KNOWN_COMPONENTS_ONLY_NO_START_AUTHORITY",
                      reviewed_utc=datetime.datetime.now(datetime.timezone.utc).isoformat(), source=self_record,
                      matrix_acceptance=matrix_rec, profile=matrix["profile"], arithmetic_helper=HELPER,
                      accounting_model=helper.MODEL, selected_plan=helper.PLAN, geometry=helper.GEOMETRY,
                      source_bound_resource_matrix=RESOURCE, prior_independent_resource_replay=RESOURCE_REVIEW,
                      actual_complete_case_count=34, actual_frames=sum(o["frames"] for o in observations),
                      actual_conditional_rows=sum(o["rows"] for o in observations), scenarios=scenarios,
                      actual_current_source_bits_reread_here=False,
                      actual_saved_packed_PN_and_partition_and_complete_timing_replayed=True,
                      no_unknown_fee_imputed_to_zero=True, registered_compute_components_called=False,
                      conditional_performance_only=True, TargetCorrect_registry_entries_added=0,
                      starts_any_Native_GPU_WSL_compiler=False, full_launch_allowed=False, full_table_Lean="NOT_VERIFIED",
                      empirical_partial_total_is_not_a_guaranteed_actual_future_runtime_bound=True,
                      evidence_files=sorted(e.records.values(), key=lambda r: r["path"]))
        out = Path(args.output).resolve()
        need(out.is_relative_to(ROOT / "runs"), "Only new run evidence may be written")
        out.parent.mkdir(parents=True, exist_ok=True)
        with out.open("x", encoding="utf8") as f:
            json.dump(report, f, indent=2)
            f.write("\n")
            f.flush()
            os.fsync(f.fileno())
        print(json.dumps(dict(output=out.relative_to(ROOT).as_posix(), full_launch_allowed=False,
                              known_hours_with25percent_margin_by_interval_margin={k: v["known_component_hours_after25percent_margin"] for k, v in scenarios.items()})))
    finally:
        e.close()


if __name__ == "__main__":
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--acceptance", type=Path, required=True)
    p.add_argument("--output", type=Path, required=True)
    p.add_argument("--execute-completed-evidence-review", action="store_true")
    main(p.parse_args())
