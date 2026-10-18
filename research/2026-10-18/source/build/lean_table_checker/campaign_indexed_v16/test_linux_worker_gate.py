"""Small pure/metadata controls, no hardware and no original source arrays.

Expected identity maps in these fixtures are NOT actual ReadLock/SHA custody.
Only an actual --seal invocation can report locked evidence replay success.
"""
import copy
import hashlib
import json
import time
from pathlib import Path
import campaign_io as c
import linux_worker_gate as g
import assemble_worker_gate as a


def main():
    checks = []
    def passed(name, callback):
        callback()
        checks.append(dict(name=name, passed=True))
    def rejects(name, callback):
        try:
            callback()
        except (ValueError, KeyError):
            checks.append(dict(name=name, passed=True))
        else:
            raise AssertionError("Missing rejection: "+name)
    def modified(value, key, changed):
        out = copy.deepcopy(value)
        out[key] = changed
        return out
    def yes(value):
        if not value:
            raise AssertionError("Control expectation did not hold")
    draft = a.candidate()
    candidate = c.read(g.record(g.CANDIDATE_IDENTITY))
    bundle = c.read(g.record(candidate["proof_bundle"]))
    build = c.read(g.record(bundle["generated_build"]))
    binding = copy.deepcopy(draft["evidence_files"])
    tiny = c.read(g.record(g.TINY_IDENTITY))
    stable = c.read(g.record(g.RESOURCE_IDENTITY))
    rules = g._configured_rules(draft, candidate, bundle, binding)
    tiny_sources = c.read(g.record(g.TINY_SOURCE_IDENTITY))
    passed("API_actual104_12threads_and1B", lambda: yes(g.THEOREM_COUNT == 104 and g.resources_for(12)["threads"] == 12))
    for threads in (8, 16, True):
        rejects("reject_other_thread_identity_"+str(threads), lambda value=threads: g.resources_for(value))
    passed("exact16_RSS9GB_restart_policy", lambda: g.restart_policy(draft["restart_policy"]))
    for field, changed in (("max_spans",128), ("rotate_before_next_frame_RSS_bytes",9500000000), ("heap_leak_fixed_claimed",True)):
        rejects("reject_restart_"+field, lambda k=field, v=changed: g.restart_policy(modified(draft["restart_policy"],k,v)))
    for name in ("../outside", "runs//alias.json", "runs/./alias.json", "runs\\alias.json", "C:/outside", "/outside"):
        rejects("reject_noncanonical_"+name, lambda v=name: g.record(dict(path=v,bytes=1,sha256="0"*64)))
    passed("empty_native_compile_logs_are_valid_records", lambda: g.record(dict(path="runs/empty.log",bytes=0,sha256=hashlib.sha256(b"").hexdigest())))
    passed("actual_dictionary931_bundle_candidate_shape", lambda: g._candidate(draft,binding))
    rejects("old88_candidate_not_accepted", lambda: g._candidate(modified(draft,"native_candidate",dict(g.CANDIDATE_IDENTITY,sha256="0"*64)),binding))
    passed("actual104_kernel_log_build_inventory_shape", lambda: g._proofs(draft,build,bundle,candidate,binding))
    for field, value in (("trust_level",1), ("old_Main_or_entry_or_control_object_linked",True), ("total_kernel_proof_count",88), ("linked_own_entry_objects",2)):
        rejects("reject_compiled_identity_"+field, lambda k=field,v=value: g._proofs(draft,modified(build,k,v),bundle,candidate,binding))
    bad_bundle = copy.deepcopy(bundle)
    bad_bundle["proofs"][-1]["axioms"].append("sorryAx")
    rejects("reject_added_axiom", lambda: g._proofs(draft,build,bad_bundle,candidate,binding))
    bad_bundle = copy.deepcopy(bundle)
    bad_bundle["proofs"][-1]["name"] = bad_bundle["proofs"][0]["name"]
    rejects("reject_duplicate_proof_footprint", lambda: g._proofs(draft,build,bad_bundle,candidate,binding))
    passed("tiny_actual7cases_smallpacked_and_cache_receipts_replay", lambda: g._tiny(draft,tiny,candidate,binding,rules,tiny_sources))
    lifecycle = c.read(c.rootpath(tiny["cases"][0]["raw_client_session"]))
    bad_life = copy.deepcopy(lifecycle)
    bad_life["create"]["limits_and_counters"]["memory.max"] = "16000000000"
    rejects("kernel_memory_cap_cannot_be_relabelled", lambda: g._scope(bad_life,binding))
    bad_life = copy.deepcopy(lifecycle)
    bad_life["scope_stop"]["after"]["cgroup.events"] = "populated 1\nfrozen 0"
    rejects("exit_flag_without_kernel_empty_rejected", lambda: g._scope(bad_life,binding))
    bad_life = copy.deepcopy(lifecycle)
    bad_life["joined"]["saved_uids"] = [0,1000,0]
    rejects("saved_root_uid_rejected", lambda: g._scope(bad_life,binding))
    bad_tiny = copy.deepcopy(tiny)
    bad_tiny["cases"][1]["actual_unique_accepted_rows"] = 1
    rejects("negative_control_must_commit_zero", lambda: rules.validate_tiny(bad_tiny,g.TINY_SOURCE_IDENTITY["sha256"]))
    rejects("old88_tiny_identity_rejected", lambda: rules.validate_tiny(modified(tiny,"pure_kernel_theorem_count",88),g.TINY_SOURCE_IDENTITY["sha256"]))
    bad_tiny = copy.deepcopy(tiny)
    bad_tiny["cases"][0]["accepted"][0]["bridge_event"]["worker"]["source_decode_calls"] = 0
    rejects("bad_source_cursor_diagnostic_rejected", lambda: g._tiny(draft,bad_tiny,candidate,binding,rules,tiny_sources))
    passed("actual83_resource_header_and_observed_maps_metadata_only", lambda: rules.validate_resources(stable,g.TINY_IDENTITY,g.RESOURCE_SOURCE_IDENTITY["sha256"]))
    projection = rules.validate_resources(stable,g.TINY_IDENTITY,g.RESOURCE_SOURCE_IDENTITY["sha256"])
    summary_fixture = dict(actual_frames_replayed=83,native_row_executions=4597996387,
        model_ready_stability=stable["model_ready_stability"],parent_continuous_ReadLock_actual_map_supplied=True,
        original_source_bits_read_by_this_review=0,full_launch_allowed=False)
    passed("basis_projection_preserves_full_raw_epoch_metadata", lambda: g._resource_basis(draft,stable,projection,summary_fixture))
    rejects("unbound_replay_summary_cannot_claim_parent_custody", lambda: g._resource_basis(draft,stable,projection,modified(summary_fixture,"parent_continuous_ReadLock_actual_map_supplied",False)))
    rejects("resource_replay_cannot_add_global_permission", lambda: g._resource_basis(draft,stable,projection,modified(summary_fixture,"full_launch_allowed",True)))
    rejects("old8B_resource_rejected", lambda: rules.validate_resources(modified(stable,"record_bytes",8),g.TINY_IDENTITY,g.RESOURCE_SOURCE_IDENTITY["sha256"]))
    bad_stable = copy.deepcopy(stable)
    bad_stable["model_ready_stability"]["minimum_validated_full_epoch_frames_by_bank_class"]["3"] = 7
    rejects("resource_interval_is_recomputed_not_invented", lambda: rules.validate_resources(bad_stable,g.TINY_IDENTITY,g.RESOURCE_SOURCE_IDENTITY["sha256"]))
    bad_stable = copy.deepcopy(stable)
    bad_stable["cases"][4]["resource_epoch_observations"][-1]["eligible_for_interval_lower_bound"] = True
    rejects("last_censored_tail_never_supplies_interval", lambda: rules.validate_resources(bad_stable,g.TINY_IDENTITY,g.RESOURCE_SOURCE_IDENTITY["sha256"]))
    passed("newcache_adapter_exact7roots", lambda: g.io_adapter(draft))
    bad_adapter = copy.deepcopy(draft)
    bad_adapter["native_IO_adapter"]["cache_verifier"] = "build/lean_table_checker/linux_bridge_test_scratch_v15/cache_evidence.py"
    rejects("old8B_cache_receipt_verifier_rejected", lambda: g.io_adapter(bad_adapter))
    rejects("gate_never_allows_full", lambda: g.validate_bound_evidence(modified(draft,"full_launch_allowed",True),build,binding))
    missing = dict(binding)
    missing.pop(g.REPLAY_SOURCE["path"])
    rejects("absent_parent_code_binding_rejected_before_replay", lambda: g.validate_bound_evidence(draft,build,missing))
    out = c.RUN/"worker_gate_source_controls"/("controls_"+str(time.time_ns())+".json")
    report = dict(schema="JOINT_INDEXED_BYTE_WORKER_GATE_SOURCE_CONTROLS_V16",status="PASS_PURE_AND_SMALL_SAVED_METADATA_CONTROLS",
        control_count=len(checks), controls=checks,
        source_binding=c.bind([Path(__file__),Path(g.__file__),Path(a.__file__)]),
        current_metadata_fixtures_not_actual_OS_ReadLock_custody=True,
        actual83_saved_packed_outputs_not_replayed_by_these_controls=True,
        actual83_header_and_epoch_maps_only=True,
        original_source_bit_tables_read=0,Native_GPU_WSL_Lean_processes_started=0,
        full_launch_allowed=False)
    c.atomic(out, report)
    print(json.dumps(a.record(out)), flush=True)


if __name__ == "__main__":
    main()
