"""Reuse the complete v5 layer32 using its unchanged isolated verifier.

No partial prefix is imported. The v5 verifier also rechecks its nested import
of the original thirteen complete v4 buckets. All evidence is held read-locked.
"""
import importlib.util,sys
import campaign_io as c
OLD=c.ROOT/"runs/lean_table_checker/campaign_short_20261018_v5/campaigns/l32_v5b"
SOURCE=c.ROOT/"build/lean_table_checker/campaign_short_v5"
EXPECTED="08e176ffab2940efd16081d7ae2dec68d726dfb752b1a6662ff6c1dad22f523a"
ACCEPTANCE=c.ROOT/"runs/lean_table_checker/campaign_short_20261018_v5/controller_acceptance_v5.json"
ACCEPTANCE_SHA="7bbf3df330df78cb9478e973ccad90d945778e29695f9bfb9b4a18803f0d732f"
AUDIT=c.ROOT/"runs/lean_table_checker/campaign_short_20261018_v5/layer32_complete_independent_audit.json"
AUDIT_SHA="01b4fbbb0547f9cf7a0719b438a42fe8237a9ab43fb5961c49d41535c95bafa7"
API=None

def discover():
    manifest=OLD/"manifest.json"
    for p,digest in ((manifest,EXPECTED),(ACCEPTANCE,ACCEPTANCE_SHA),(AUDIT,AUDIT_SHA)):
        if c.sha(p)!=digest:raise ValueError("Fixed complete layer32 provenance changed: "+c.rel(p))
    m=c.read(manifest);records={};assets=[manifest,ACCEPTANCE,AUDIT]+[c.rootpath(p) for p in m["code_binding"]]
    for p in OLD.rglob("*"):
        if p.is_file() and p.suffix not in (".lock",".tmp"):assets.append(p)
    for p in (OLD/"registry").glob("*.json"):
        value=c.read(p);assets.append(c.rootpath(value["bits"]))
        if value["kind"]=="IMPORTED_COMPLETE_LAYER_BUCKET":assets.extend(c.rootpath(value[k]) for k in ("prior_acceptance","prior_manifest","prior_input"))
        if value["layer"]==32 and value["kind"] in ("CHECKED_EXACT_NATIVE_LEDGER_COVERAGE","IMPORTED_VERIFIED_COMPLETE_NATIVE_BUCKET_V5"):
            records[c.stem(32,value["honor"])]=dict(layer=32,honor=value["honor"],size=value["size"],receipt=c.rel(p),sha256=c.sha(p))
    if len(records)!=68 or sum(v["size"] for v in records.values())!=280542509:raise ValueError("Reuse requires all 68 complete actual layer32 buckets")
    return dict(schema="EXACT_COMPLETE_LAYER32_BUCKET_REUSE_V7_NATIVE_CACHE",source_manifest=c.rel(manifest),source_manifest_sha256=EXPECTED,
        source_folder=c.rel(OLD),acceptance=c.rel(ACCEPTANCE),acceptance_sha256=ACCEPTANCE_SHA,independent_audit=c.rel(AUDIT),
        independent_audit_sha256=AUDIT_SHA,buckets=records,unique_rows=280542509,nested_old13_import_rows=5228859),list(dict.fromkeys(assets))

def old_api():
    global API
    if API is not None:return API
    names=("campaign_io","frame_planner","frame_registry","worker_gate","ledger","invocation_budget","runner","prior_import","path_guard","compact_transport")
    saved={name:sys.modules.get(name) for name in names};paths=list(sys.path)
    try:
        for name in names:sys.modules.pop(name,None)
        sys.path.insert(0,str(SOURCE));name="_frozen_complete_short_prior_api_v5"
        spec=importlib.util.spec_from_file_location(name,SOURCE/"campaign.py")
        module=importlib.util.module_from_spec(spec);sys.modules[name]=module;spec.loader.exec_module(module);API=module
    finally:
        sys.path[:]=paths
        for name,value in saved.items():
            if value is None:sys.modules.pop(name,None)
            else:sys.modules[name]=value
    return API

def verify_identity(reuse,binding,worker,requests):
    if reuse is None:return
    if reuse["source_manifest_sha256"]!=EXPECTED or reuse["source_folder"]!=c.rel(OLD):raise ValueError("Unsupported complete layer32 identity")
    for p,digest in ((OLD/"manifest.json",EXPECTED),(ACCEPTANCE,ACCEPTANCE_SHA),(AUDIT,AUDIT_SHA)):
        if binding[c.rel(p)]["sha256"]!=digest:raise ValueError("Locked prior complete provenance changed")
    old=c.read(OLD/"manifest.json")
    # The imported proposition concerns an already certified bucket. Its
    # original worker is revalidated below with the original manifest; a new
    # checker for lower layers need not be the same executable or OS.
    for path,value in old["code_binding"].items():
        if binding.get(path)!=value:raise ValueError("Frozen original verifier/proof identity changed: "+path)
    selected={(r["layer"],r["honor"]):(r["start"],r["count"],r["size"]) for r in requests}
    for record in reuse["buckets"].values():
        if (32,record["honor"]) in selected and selected[32,record["honor"]]!=(0,record["size"],record["size"]):raise ValueError("Reused bucket request must be exact full coverage")
        if binding[record["receipt"]]["sha256"]!=record["sha256"]:raise ValueError("Prior complete certificate changed before locks")

def original(record,guard=None,locks=None):
    api=old_api();m=c.read(OLD/"manifest.json")
    answer=api.validate_cert(OLD,m,record["layer"],record["honor"],api.slots(),guard=guard,locks=locks)
    if answer.get("receipt")!=record["receipt"] or answer.get("sha256")!=record["sha256"]:raise ValueError("Original complete proof did not revalidate")
    value=c.read(c.rootpath(record["receipt"]));c.check_fingerprint(c.rootpath(value["bits"]),value["bits_binding"],guard)
    return value

def validate(v,f,m,row,s,seen,guard,locks):
    reuse=m.get("complete_bucket_reuse") or {};key=c.stem(row["layer"],row["honor"]);record=reuse.get("buckets",{}).get(key)
    if record is None or v.get("prior_complete_certificate")!=record or v.get("prior_manifest_sha256")!=EXPECTED:raise ValueError("Native import not bound by this manifest")
    old=original(record,guard,locks)
    if v.get("imported_certificate_worker")!=c.read(OLD/"manifest.json")["worker"] or v.get("current_execution_worker")!=m["worker"] or v.get("new_native_rows")!=0:
        raise ValueError("Imported proof was relabeled as new native computation")
    if v["bits_binding"]!=old["bits_binding"] or v["numbering"]!=old["numbering"] or s.numbering(row)!=old["numbering"]:raise ValueError("Prior labels/numbering differ from current inputs")
    actual={c.stem(a,b):s.validate_cert(f,m,a,b,s.slots(),seen,guard,locks) for a,b in s.needed(row["layer"],row["honor"],s.slots())}
    if actual!=v["dependencies"] or set(actual)!=set(old["dependencies"]):raise ValueError("Complete prior target scope changed")
    for key,value in actual.items():
        if value["kind"]!=old["dependencies"][key]["kind"] or value.get("sha256")!=old["dependencies"][key].get("sha256"):raise ValueError("Actual next-layer proof differs from original complete proof")

def install(f,m,s,table,rt):
    reuse=m.get("complete_bucket_reuse")
    if not reuse:return
    for key,record in reuse["buckets"].items():
        rt.guard();n,h=record["layer"],record["honor"];row=table[n,h];p=s.certpath(f,n,h)
        if p.exists():s.validate_cert(f,m,n,h,table,rt.cert_cache,rt.guard,rt.proof_locks);continue
        old=original(record,rt.guard,rt.proof_locks)
        deps={c.stem(a,b):s.validate_cert(f,m,a,b,table,rt.cert_cache,rt.guard,rt.proof_locks) for a,b in s.needed(n,h,table)}
        v=dict(schema="V4_COMPLETE_BUCKET_CERTIFICATE",kind="IMPORTED_VERIFIED_COMPLETE_NATIVE_BUCKET_V12_BORROWED_NEXT_GENERATED_NATIVE_CACHE",layer=n,honor=h,size=row["size"],
            dataset_sha256=m["dataset_sha256"],complete_unique_coverage=[0,row["size"]],bits=row["bits"],bits_binding=old["bits_binding"],
            numbering=old["numbering"],dependencies=deps,prior_complete_certificate=record,prior_manifest_sha256=EXPECTED,
            imported_certificate_worker=c.read(OLD/"manifest.json")["worker"],current_execution_worker=m["worker"],new_native_rows=0)
        validate(v,f,m,row,s,rt.cert_cache,rt.guard,rt.proof_locks);c.atomic(p,v)
    requested={(r["layer"],r["honor"]) for r in m["requests"]}
    rt.s["imported_unique_rows"]=sum(v["size"] for v in reuse["buckets"].values() if (v["layer"],v["honor"]) in requested)
    rt.s["imported_complete_buckets"]=sum((v["layer"],v["honor"]) in requested for v in reuse["buckets"].values())
    rt.s["reused_prerequisite_layer32_rows"]=reuse["unique_rows"]
    from ledger import save_root
    save_root(f,rt.s)
