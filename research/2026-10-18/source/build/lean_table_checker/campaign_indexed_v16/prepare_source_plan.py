"""Check the exact crash-tested baseline and save a minimal V16 source plan.

Only small Python/JSON sources are read. No Native ELF, label bank, directory,
WSL process, GPU, scheduler or production service is opened or started.
This deliberately does not emit a runnable, partially converted controller.
"""
from __future__ import annotations

import ast
import hashlib
import json
from pathlib import Path
import time

import integration_contract as rules

BASE = Path(__file__).resolve().parent
ROOT = BASE.parents[2]
OLD = "build/lean_table_checker/campaign_resident_v14_large/"
FREEZE = "build/lean_table_checker/controller_scratch_v15_review/SOURCE_FREEZE.json"
FREEZE_SHA = "aa523dfbdf185a16b2796a644f61a79f461e348f1dc7a60f0c3c52b18db2d021"
ACTUAL = "runs/lean_table_checker/campaign_resident_20261018_v14_large/functional/crash_44000b37/acceptance.json"
ACTUAL_SHA = "071f429429ef18ac7402eaf625b737b35daf98512d46f5f8e61dad3c9efe3667"
BRIDGE_FREEZE = "build/lean_table_checker/linux_bridge_test_indexed_v16/SOURCE_FREEZE.json"
BRIDGE_FREEZE_SHA = "586549d4c93f65b7731795f5c8cab532ac41b6c588d056284b7ae4b2c44c8264"
JOINT_REVIEW = "runs/lean_table_checker/joint_indexed_build_20261018_v16/actual104_kernel_C_review_1792283729925106300.json"
JOINT_REVIEW_SHA = "dabc72bf268f1cf250c4f05510648f2f2b7e7bd0b2e5ff060bb6d14dd86a3c13"

REUSE = (
    "finite_premises.py", "frame_planner.py", "frame_registry.py",
    "input_snapshot.py", "invocation_budget.py", "keep_awake.py", "ledger.py",
    "path_guard.py", "prior_import.py", "production_metrics.py", "resource_job.py",
    "scope_lifecycle.py",
)

ADAPT = {
    "campaign_io.py": ["New RUN/GPU_RUN namespace; same exact ReadLocks bootstrap and actual input helpers."],
    "campaign.py": [
        "Strict new manifest/backend/span/result104 identity and bound new source/candidate/helper set.",
        "Keep exact numbering, seed33/34 and imported32 validators and historical kind strings.",
        "New GPU1B revision/protocol/scratch8388608 bytes; payload_bytes_per_row=1.",
        "validate_item: actual Native gpu_source_packet_mode=False; indexed_byte_mode=True; compact_word_mode=False.",
        "Reuse shared native_receipts.worker plus exact canonical worker/frame/packed identity checks.",
        "source_decode_calls is actual per-block-run cursor sum, not old zero; source_r_guard_every_row and block cover required.",
        "Keep complete packed-source byte comparison, padding/popcount, frame work/T and full next-layer TargetCorrect registry."],
    "cache_transport.py": [
        "Bind new verifier/config/timing1B identity and original cache7b bytes; unchanged exact PREPARED/argv/DROP/STOP/EOF checks.",
        "Keep valid durable prefix provenance on abnormal exit; do not require a normal historical STOP to erase a checked prefix."],
    "fused_transport.py": [
        "New bridge/client config/event and hash-verified shared indexed GPU rules/native receipt rules.",
        "One byte per row, same24B native footer; new proposal identity, no Windows payload copies.",
        "Await Native READY+mandatoryDROP before any proposal; at most one prefetch, one carried packet across native rotation.",
        "Keep actual per-bucket parent locks, kernel-empty cleanup guardian, identity/start-time ownership and EOF/counter checks."],
    "compact_transport.py": [
        "Do not reactivate old standaloneGPU/WindowsNative fallback; reduce to still-used linux/expected/strict owned-stop utilities or keep explicitly unreachable.",
        "Any retained path must enforce indexed1B, never reinterpret old64-bit packets."],
    "cost_gate.py": [
        "New registeredV16 profile/accounting_projection/final authority exact manifest identities; oldV14 authority always rejected.",
        "Preserve measured first-plan once/epoch plus all steadyT, unknown-fees rejection, actual journal/validation/retry cost,25percent margin<=16h and hard20h.",
        "Current source plan has no positive cost authority and cannot launch full work."],
    "collect_fees.py": [
        "Bind104/1B/ctor/scalar/candidate and four actual same-profile phases; do not import old88 crash/control costs as fresh fees.",
        "Keep repeated strict validate_item/ledger/registry/hash/scope costs and cumulative deferred/pre-service invocation costs."],
    "launch_campaign.py": [
        "Strict new manifest identity; same direct-parent ticket/sameJob/parent actualonceSHA map and all code/input locks until kernel-empty.",
        "No requested gate can bypass the new positive resource and final empirical cost authorities."],
    "linux_worker_gate.py": [
        "New actual104 bundle(dict931 bindings) and one exact chosen build/tiny candidate record; no oldlist88/status fallback.",
        "Fresh selected1B tiny and resource matrix required; old min10/16/16/7 are not measurements of new Native.",
        "Resource contract must accept genuine max16 or RSS9GB rotations, not require the old allocator-growth signature.",
        "Full launch false; no opaque correctness assumptions or expected-only input map may replace finite actual bindings."],
    "local_reports.py": ["New run identity; preserve quiet no-model local progress/pause/failure reports."],
    "prepare_full_queue.py": [
        "Same6440slots/3686nonempty/778532864302rows and true32/33/34 imports.",
        "New104 checker/gate/profile/evaluator, planned-only no service side effects."],
    "run_functional.py": [
        "New104/1B exactidentity across crash-resume-NOOP, true small cross-layer chain, badN/packed/missing-tail0commit, strict prefix revalidation.",
        "BadN injection must corrupt the new actualnext INDEX byte (255 or invalidactualindex), not an8B j field.",
        "No success count, source hash, phase budget, cleanup reserve or certificate condition weakened."],
    "runner.py": [
        "Strict new manifest/backend104; unchanged ledger durability, certified dependencies, parent custody, STOP/deadline, refund only after confirmed all-owned-exit.",
        "Reuse fresh resource floor maps recomputed from full epochs, not fixed oldobservations; truncated trailingepoch excluded from lower-bound evidence."],
    "span_policy.py": [
        "New bridge and Native event schemas with104/1B/sourceguard/scalar/constructor4096 markers.",
        "Adaptive plan_prepare_workers=1 for fullT<=4096 else min(12,sourceblocks), using fullT before last-block reuse.",
        "Keep exact global epoch identities, max16/RSS9 policy, first reference=min(count,64) once per Native epoch and measured costfloor pause beforecommit."],
    "stop_unreceipted.py": [
        "If a standalone fallback remains, new exact script+unique ownedpidfile path+kernelstart identity required; do not retain obsolete gpu_bucket_v6 prefix.",
        "Fused scope cleanup must confirm the actual UUID cgroup empty before releasing any actual bank/input handle."],
    "test_epoch_controls.py": [
        "Derive new104/1B event fixtures; badbyte/index/source-r/cover/ctor/worker threshold, frame/epoch counts, padding and cleanup negatives.",
        "Pure controls are not actual Native/GPU or whole-game evidence."],
    "worker_gate.py": [
        "Legacy Windows-only gate is not selected by new backend. Keep byte-identical and unreachable, or remove imports with an explicit new-controller revision; never use its28 proof acceptance."],
}


def checked_small(name, expected_sha, limit=2_000_000):
    path = ROOT/name
    size = path.stat().st_size
    if size > limit:
        raise ValueError("Source plan only accepts bounded small sources: "+name)
    raw = path.read_bytes()
    if len(raw) != size or hashlib.sha256(raw).hexdigest() != expected_sha:
        raise ValueError("Exact frozen metadata/source changed: "+name)
    return json.loads(raw), dict(path=name, bytes=len(raw), sha256=expected_sha)


def build_plan():
    freeze, freeze_record = checked_small(FREEZE, FREEZE_SHA)
    actual, actual_record = checked_small(ACTUAL, ACTUAL_SHA)
    bridge, bridge_record = checked_small(BRIDGE_FREEZE, BRIDGE_FREEZE_SHA)
    _, audit_record = checked_small(JOINT_REVIEW, JOINT_REVIEW_SHA)
    source = freeze["controller_source_binding"]
    if len(source) != 29 or source != actual["source_binding"]:
        raise ValueError("Exact29 crash-tested source map differs")
    if actual["status"] != "PASS_ACTUAL_BOUNDED_PRODUCTION_PHASE_V14":
        raise ValueError("The baseline actual crash/resume receipt was not a PASS")
    if set(REUSE) | set(ADAPT) != {Path(name).name for name in source} or set(REUSE) & set(ADAPT):
        raise ValueError("Each of the29 actual baseline files needs one explicit disposition")
    source_bytes = 0
    for name, identity in source.items():
        if not name.startswith(OLD):
            raise ValueError("Unexpected source outside exact baseline")
        raw = (ROOT/name).read_bytes()
        if dict(bytes=len(raw), sha256=hashlib.sha256(raw).hexdigest()) != identity:
            raise ValueError("Current baseline source differs from actual old acceptance: "+name)
        ast.parse(raw, filename=name)
        source_bytes += len(raw)
    bridge_sources = {name: rec for name, rec in bridge["files"].items()
                      if name.startswith("build/lean_table_checker/linux_bridge_indexed_v16/")
                      or name.startswith("build/lean_table_checker/linux_bridge_test_indexed_v16/")}
    # These are exactly the staged helper's registered small source records.
    # No claim that its ELF, original97GB inputs or game rows were rehashed here.
    for name, rec in bridge_sources.items():
        if not name.endswith(".py"):
            continue
        raw = (ROOT/name).read_bytes()
        if dict(bytes=len(raw), sha256=hashlib.sha256(raw).hexdigest()) != rec:
            raise ValueError("New helper source no longer equals its freeze: "+name)
        ast.parse(raw, filename=name)
    projected, projected_record = checked_small(rules.PRODUCTION_CANDIDATE_RECORD["path"],
        rules.PRODUCTION_CANDIDATE_RECORD["sha256"])
    if projected_record != rules.PRODUCTION_CANDIDATE_RECORD:
        raise ValueError("Production projected candidate record differs")
    rules.validate_candidate(projected)
    return dict(schema="MINIMAL_JOINT_INDEXED_CONTROLLER_SOURCE_DERIVATION_PLAN_V16",
        status="SOURCE_PLAN_ONLY_NOT_A_RUNNABLE_CONTROLLER_OR_EXECUTION_GATE",
        baseline_freeze=freeze_record, baseline_actual_crash_resume=actual_record,
        baseline29_current_source_bindings=source,
        baseline29_current_source_bytes_read=source_bytes,
        actual104_independent_review=audit_record, new_bridge_tiny_source_freeze=bridge_record,
        selected_production_candidate=projected_record,
        new_helper_small_source_bindings=bridge_sources,
        byte_identical_reuse=list(REUSE), explicit_adaptations=ADAPT,
        interface=dict(backend=rules.BACKEND, profile=rules.PROFILE, manifest=rules.MANIFEST,
            span_protocol=rules.SPAN_PROTOCOL, span_protocol_peer_confirmed=True,
            bridge_config=rules.BRIDGE_CONFIG, bridge_event=rules.BRIDGE_EVENT,
            Native_event=rules.NATIVE_EVENT, result_schema=rules.RESULT_SCHEMA,
            result_status=rules.RESULT_STATUS, transport=rules.TRANSPORT,
            GPU_protocol=rules.GPU_PROTOCOL, GPU_revision=rules.GPU_REVISION,
            records_per_row_bytes=1, kernel_counts=rules.COUNTS,
            resources=rules.RESOURCES, plan_worker_policy=dict(fullT_threshold=4096,
                lower_or_equal=1, greater="min(12,source_blocks)",reuse_discount_applied=False)),
        preserved_historical_import_kind=rules.HISTORICAL_IMPORT_KIND,
        missing_actual_evidence=list(rules.MISSING_ACTUAL_EVIDENCE),
        current_source_plan_opens_original_bits=False,
        actual_new_Native_or_GPU_rows=0, current_script_starts_services=False,
        pure_controls_are_mathematical_or_runtime_evidence=False,
        source_plan_reuses_old_partial_prefix=False,
        full_launch_allowed=False, Native_execution_allowed=False,
        full_table_Lean="NOT_VERIFIED",
        recommended_next_step="Freeze the minimal source derivation only after selecting exact fresh104 tiny/resource/profile contracts; run all4 actual production phases before any positive empirical start authority")


def main():
    report = build_plan()
    report["created_time_ns"] = time.time_ns()
    path = ROOT/"runs/lean_table_checker/campaign_indexed_20261018_v16"/(
        "source_derivation_plan_"+str(report["created_time_ns"])+".json")
    path.parent.mkdir(parents=True, exist_ok=True)
    raw = (json.dumps(report, ensure_ascii=False, indent=2, sort_keys=True)+"\n").encode()
    with path.open("xb") as stream:
        stream.write(raw)
    print(json.dumps(dict(path=path.relative_to(ROOT).as_posix(), bytes=len(raw),
        sha256=hashlib.sha256(raw).hexdigest(), status=report["status"],
        baseline_files=29, source_only=True, full_launch_allowed=False)))


if __name__ == "__main__":
    main()
