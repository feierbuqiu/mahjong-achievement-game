"""Rebind the native-only ext4 mirror to each row's original IO premises.

The producer is untrusted. The unchanged compiled Lean checker consumes the
same bytes through a separately audited, content-identical IO adapter.
"""
from pathlib import Path
import importlib.util,json,re
import campaign_io as c

def verifier(m):
    path=c.rootpath(m["native_IO_adapter"]["cache_verifier"])
    spec=importlib.util.spec_from_file_location("_bound_native_cache_evidence_v7",path)
    api=importlib.util.module_from_spec(spec);spec.loader.exec_module(api);return api

def record(path):return dict(path=c.rel(path),bytes=path.stat().st_size,sha256=c.sha(path))

def session_directory(path):
    p=Path(path).resolve();base=(c.RUN/"s").resolve()
    if p.parent!=base or re.fullmatch("[0-9a-f]{16}",p.name) is None:raise ValueError("Cache evidence escaped its short unique owned session")
    return p

def exact_bank_files(locked):
    return sorted(name for name in locked if name.endswith((".dir",".bits")))

def prepare(context,view,ready):
    api=context.cache_api;bank=exact_bank_files(view.locked)
    receipt=c.rootpath(ready["native_cache"]["cache_receipt"]["path"])
    held=c.ReadLocks([receipt]);context.rt.proof_locks.append(held)
    summary=api.validate_prepared(c.ROOT,context.config,ready["native_cache"],view.layer,view.honor,bank,context.client.name)
    for item in summary["files"]:
        wanted=dict(bytes=item["bytes"],sha256=item["sha256"])
        if view.locked.get(item["original"])!=wanted:raise ValueError("Prepared native mirror is not the current locked source/target/common input")
    proof=session_directory(context.session_directory)/(c.stem(view.layer,view.honor)+f"_g{context.generation+1:04}.prepared.json")
    value=dict(schema="BOUND_INDEXED_BYTE_NATIVE_CACHE_PREPARED_FRAME_PREMISES_V16",layer=view.layer,honor=view.honor,
        descriptor=record(context.config_path),ready_cache=ready["native_cache"],scope=context.client.name,
        expected_bank_files=bank,prepared_receipt=summary["cache_receipt"],all_copied_inputs_equal_current_locked_inputs=True)
    c.atomic(proof,value);context.rt.proof_locks.append(c.ReadLocks([proof]))
    view.cache_prepared=summary;view.cache_proof=record(proof)
    return summary

def finish(context,view,left):
    """Normal epoch accounting is separate from validity of a crashed prefix."""
    files=sorted(context.session_directory.glob(c.stem(view.layer,view.honor)+"_*.stderr.session.json"))
    if not files:raise ValueError("Normal bucket leave has no actual native epoch receipts")
    context.rt.proof_locks.append(c.ReadLocks(files))
    values=[c.read(p) for p in files]
    drops=[c.rootpath(v["native_cache_drop"]["path"]) for v in values]
    release=c.rootpath(left["native_cache_release"]["path"])
    context.rt.proof_locks.append(c.ReadLocks(drops+[release]))
    checks=context.cache_api.validate_epochs(c.ROOT,context.config,view.cache_prepared,values)
    if [value["completed_spans"] for value in values]!=view.epoch_tracker.completed_counts():
        raise ValueError("Actual16/RSS native epochs differ from this bucket's checked frame counters")
    context.cache_api.validate_released(c.ROOT,view.cache_prepared,left["native_cache_release"])
    if sum(v["completed_spans"] for v in values)!=view.completed or sum(v["checked_rows"] for v in values)!=view.rows:
        raise ValueError("Normal native epochs do not account for the exact accepted invocation bucket spans")
    path=context.session_directory/(c.stem(view.layer,view.honor)+f"_g{view.generation:04}.normal-close.json")
    c.atomic(path,dict(schema="NORMAL_INDEXED_BYTE_NATIVE_CACHE_BUCKET_LIFECYCLE_V16",prepared_frame_proof=view.cache_proof,
        completed_spans=view.completed,checked_rows=view.rows,epochs=[record(p) for p in files],epoch_mappings=checks,
        released_receipt=left["native_cache_release"],all_actual_native_epochs_accounted_and_exited=True,
        resource_accounting_is_not_a_new_mathematical_premise_for_an_abruptly_interrupted_valid_prefix=True))
    context.rt.proof_locks.append(c.ReadLocks([path]));view.normal_close_evidence=record(path)
    return view.normal_close_evidence

def validate_frame(m,item,guard=None,cache=None,locks=None):
    """Cache only while the caller retains the evidence read handles."""
    identity=item["proposal_provenance"].get("native_cache_proof")
    if not isinstance(identity,dict):raise ValueError("V7 frame lacks its exact prepared IO proof")
    premise=json.dumps([item["layer"],item["honor"],item["source_bits_binding"],item["source_directory_binding"],item["dependencies"]],sort_keys=True,separators=(",",":"))
    origin=item["proposal_provenance"]
    key=("V16_INDEXED_BYTE_CACHE_PREPARED",identity.get("path"),identity.get("sha256"),identity.get("bytes"),origin.get("scope"),origin.get("bridge_configuration_sha256"),premise)
    if cache is not None and locks is not None and key in cache:return cache[key]
    path=c.rootpath(identity["path"]);session_directory(path.parent)
    temporary=[]
    def lock(paths):
        held=c.ReadLocks(paths)
        (locks if locks is not None else temporary).append(held)
    try:
        lock([path]);c.check_fingerprint(path,identity,guard);proof=c.read(path)
        if proof.get("schema")!="BOUND_INDEXED_BYTE_NATIVE_CACHE_PREPARED_FRAME_PREMISES_V16" or (proof.get("layer"),proof.get("honor"))!=(item["layer"],item["honor"]):raise ValueError("Native cache proof belongs to another source bucket")
        descriptor_record=proof["descriptor"];descriptor_path=c.rootpath(descriptor_record["path"])
        owned=(c.RUN/"campaigns"/m["name"]/"sessions").resolve()
        if descriptor_path.parent!=owned:raise ValueError("Native cache descriptor escaped its exact campaign")
        lock([descriptor_path]);c.check_fingerprint(descriptor_path,descriptor_record,guard);descriptor=c.read(descriptor_path)
        if descriptor["native"]!=m["worker"]["executable"] or descriptor["native_sha256"]!=m["worker"]["sha256"] or descriptor["threads"]!=m["threads"] or descriptor["native_roots"]!=m["native_IO_adapter"]["original_roots"]:
            raise ValueError("Prepared cache descriptor changed checker/root/thread identity")
        if descriptor.get("schema")!="FUSED_LINUX_INDEXED_BYTE_BRIDGE_CONFIGURATION_V16" or descriptor.get("transport_timing_profile")!="WALL_ENVELOPES_INDEXED_BYTE_V16_1" or any(descriptor.get(k)!=v for k,v in dict(m["native_io_policy"],resident_count_cap=67108864,frame_block_cap=8192,frame_template_budget=m["frame_policy"]["max_plan_templates"],row_rounds=1).items()):
            raise ValueError("Prepared descriptor changed the actual16-frame/1MiB native IO policy")
        if session_directory(c.rootpath(descriptor["session_dir"]))!=path.parent:raise ValueError("Prepared cache proof moved between bridge sessions")
        if descriptor["code_binding"]!={name:m["code_binding"][name] for name in m["fused_bridge"]["code_paths"]}:raise ValueError("Prepared IO code identity differs from this campaign")
        wanted={}
        table={(r["layer"],r["honor"]):r for r in c.read(c.DATASET/"all_buckets.json")["slots"]}
        n,h=item["layer"],item["honor"];row=table[n,h]
        wanted[row["bits"]]=item["source_bits_binding"];wanted[row["directory"]]=item["source_directory_binding"]
        for dep in item["dependencies"].values():
            if dep.get("kind")=="EMPTY_CERTIFIED_PREFIX":continue
            dep_path=c.rootpath(dep["receipt"]);lock([dep_path])
            if c.sha(dep_path,guard)!=dep["sha256"]:raise ValueError("Prepared frame target certificate changed")
            cert=c.read(dep_path);r=table[cert["layer"],cert["honor"]]
            if r["size"]:
                wanted[r["bits"]]=cert["bits_binding"];wanted[r["directory"]]=r["directory_binding"]
        bank=sorted(wanted)
        if proof["expected_bank_files"]!=bank:raise ValueError("Prepared native cache omitted or added a semantic source/target bucket")
        receipt=c.rootpath(proof["ready_cache"]["cache_receipt"]["path"]);lock([receipt])
        summary=verifier(m).validate_prepared(c.ROOT,descriptor,proof["ready_cache"],n,h,bank,proof["scope"])
        for value in summary["files"]:
            name=value["original"];binding=dict(bytes=value["bytes"],sha256=value["sha256"])
            if (wanted.get(name) if name in wanted else m["code_binding"].get(name))!=binding:raise ValueError("Copied IO bytes differ from the row's original certified premises")
        if proof["prepared_receipt"]!=summary["cache_receipt"]:raise ValueError("Prepared receipt identity was substituted")
        if proof["scope"]!=item["proposal_provenance"].get("scope") or descriptor_record["sha256"]!=item["proposal_provenance"].get("bridge_configuration_sha256"):
            raise ValueError("Prepared cache proof crossed a frame scope or descriptor")
        if cache is not None and locks is not None:
            while len(cache)>=8:cache.pop(next(iter(cache)))
            cache[key]=summary
        return summary
    finally:
        for held in reversed(temporary):held.close()
