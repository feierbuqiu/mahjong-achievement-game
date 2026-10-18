"""Exact-source bridge receipt reuse and complete V16 production metadata.

The caller owns all code/input read handles. This module starts no process and
does not replace the Native checker or the commit's actual source-bit compare.
"""
import hashlib
import types
import campaign_io as c
import integration_contract as contract

RULES_PATH = "build/lean_table_checker/linux_bridge_indexed_v16/native_receipts.py"
RULES_RECORD = dict(bytes=4351,
    sha256="f8781fc73fc85b33eacaee9336682182a7498f14459351b882e8206c3c8c865c")
_verified_rules = None


def native_rules(m):
    global _verified_rules
    if m["code_binding"].get(RULES_PATH) != RULES_RECORD:
        raise ValueError("Unbound actual104 Native receipt rules")
    if _verified_rules is None:
        raw = c.rootpath(RULES_PATH).read_bytes()
        if dict(bytes=len(raw), sha256=hashlib.sha256(raw).hexdigest()) != RULES_RECORD:
            raise ValueError("Native receipt source changed under continuous code custody")
        api = types.ModuleType("_current_hash_checked_joint104_native_receipts")
        exec(compile(raw, str(c.rootpath(RULES_PATH)), "exec"), api.__dict__)
        _verified_rules = api
    return _verified_rules


def validate_ready(m, value, layer, honor):
    return contract.validate_ready(value, layer, honor, native_rules(m))


def validate_worker(m, value, item):
    if m.get("backend") != contract.BACKEND or m.get("pure_kernel_theorem_count") != 104:
        raise ValueError("Wrong new104 production manifest family")
    frame = item["frame"]
    exact = dict(frame, count=item["count"], start=item["start"],
        layer=item["layer"], honor=item["honor"],
        template_budget=m["frame_policy"]["max_plan_templates"])
    result = contract.validate_span_metadata(value, exact, native_rules(m))
    calls=value["source_decode_calls"];nonempty=value["worker_nonempty_chunk_initializations"]
    if not exact["source_blocks"]<=calls<=exact["source_blocks"]+nonempty-1:
        raise ValueError("Actual source-block cursor count differs from the canonical contiguous frame")
    if value.get("constructor_build_and_check_task_sum_ns")!=value.get("plan_check_ns"):
        raise ValueError("Constructor check task sum was confused with another preparation phase")
    for key in ("plan_phase_wall_ns","row_scan_ns","reference_ns","raw_plan_build_ns",
                "hot_snapshot_build_ns","plan_check_ns","constructor_build_and_check_task_sum_ns",
                "scan_ns","work_ns","effective_work_ns"):
        if type(value.get(key)) is not int or value[key]<0:
            raise ValueError("Missing actual nonnegative Native timer: "+key)
    if value["scan_ns"]!=value["work_ns"] or value["scan_ns"]!=value["effective_work_ns"]:
        raise ValueError("Actual inclusive work/scan envelopes differ")
    if (value["P_rows"], value["N_rows"]) != (item["P_rows"], item["N_rows"]):
        raise ValueError("Committed packed P/N differs from actual104 worker metadata")
    return result
