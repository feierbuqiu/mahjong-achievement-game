"""Bind existing finite enumeration evidence without promoting a staged bundle.

The helper verifies finite historical receipts; this adapter adds live input
custody and routes final assertions through the existing strict bucket validator.
Nothing runs or hashes large files on import.
"""
import importlib.util
from pathlib import Path
import campaign_io as c

HELPER="build/lean_table_checker/final_chain_review_v12/evidence_closure.py"
HELPER_SHA="0a88c3d676a81f6b36e02618e846757428edc86c1e5c6630cb59f5ec2a1c23b3"
DEFAULT=c.ROOT/"runs/lean_table_checker/final_chain_review_20261018_v12/staged_v2/finite_premise_closure.json"
CLOSURE_SHA="11829edce1deb31d473be13e1d04dde3081b344f03b9d5caf80782844d677416"


def require(value,message):
    if not value:raise ValueError(message)


def record(path):return dict(path=c.rel(path),bytes=path.stat().st_size,sha256=c.sha(path))


def api():
    path=c.rootpath(HELPER)
    held=c.ReadLocks([path])
    try:
        require(c.sha(path)==HELPER_SHA,"The reviewed finite-premise helper is not finalized or changed")
        spec=importlib.util.spec_from_file_location("_bound_final_finite_premises_v12",path)
        module=importlib.util.module_from_spec(spec);spec.loader.exec_module(module)
        return module
    finally:held.close()


def discover(path):
    path=Path(path).resolve();held=c.ReadLocks([path,c.rootpath(HELPER)])
    try:
        require(path==DEFAULT.resolve() and c.sha(path)==CLOSURE_SHA,"Use the independently collected exact final finite-premise archive")
        value=c.read(path);module=api();module.required_paths(value)
        require(value.get("native_or_GPU_or_kernel_started") is False and value.get("large_data_rehashed") is False,
            "Expected the explicitly staged existing finite evidence closure")
        assets=[path,c.rootpath(HELPER)]+[c.rootpath(p) for p in value["metadata_bindings"]]
        return value,list(dict.fromkeys(assets))
    finally:held.close()


def reference(path,bundle):
    return dict(closure=record(Path(path)),helper=record(c.rootpath(HELPER)),
        closure_identity_sha256=bundle["identity_sha256"],status="STAGED_PENDING_RUNTIME_BINDINGS",
        full_runtime_validation_required_before_global_work=True)


def locked_bundle(m):
    ref=m["finite_premise_closure"];path=c.rootpath(ref["closure"]["path"])
    require(path==DEFAULT.resolve() and ref["closure"]["sha256"]==CLOSURE_SHA,"The manifest cannot replace the uniquely frozen finite archive")
    require(ref["helper"]["path"]==HELPER and ref["helper"]["sha256"]==HELPER_SHA,"Finite helper identity changed")
    for item in (ref["closure"],ref["helper"]):
        require(m["code_binding"].get(item["path"])=={k:item[k] for k in ("bytes","sha256")},"Finite closure is not bound by this manifest")
    value=c.read(path);module=api();module.required_paths(value)
    require(value["identity_sha256"]==ref["closure_identity_sha256"],"Finite closure identity changed")
    require(all(m["code_binding"].get(p)==identity for p,identity in value["metadata_bindings"].items()),
        "All existing finite-premise metadata must be immutable campaign assets")
    return module,value


def semantic_inputs(m):
    """Actual all-table bytes are only needed when the requested scope is global."""
    import cost_gate
    if not cost_gate.full_scope(m):return []
    module,value=locked_bundle(m)
    return [c.rootpath(p) for p in module.required_paths(value) if p not in m["code_binding"]]


def validate(m,actual_bindings,guard=None):
    import cost_gate
    module,value=locked_bundle(m)
    if cost_gate.full_scope(m):
        return module.validate_for_launch(value,actual_bindings,root=c.ROOT,guard=guard)
    # A bounded trial has no global coverage claim. It still cannot replace
    # any finite input/metadata it actually consumes under this manifest.
    expected={**value["metadata_bindings"],**value["expected_runtime_bindings"]}
    for name,identity in expected.items():
        if name in actual_bindings:require(actual_bindings[name]==identity,"A consumed finite premise changed: "+name)
    for name,identity in value["label_binding_requirements"].items():
        if name in actual_bindings:require(actual_bindings[name]["bytes"]==identity["bytes"],"A consumed label table has another extent")
    for seed in value["exact_seed_provenance"].values():
        if seed["bits"] in actual_bindings:require(actual_bindings[seed["bits"]]==seed["bits_binding"],"A consumed genuine seed label table changed")
    return dict(schema="BOUNDED_FINITE_PREMISE_SUBSET_CUSTODY_V12",status="STAGED_BOUNDED_SUBSET_ONLY_NOT_GLOBAL_FINITE_PASS",
        closure_identity_sha256=value["identity_sha256"],full_runtime_validation_still_required=True)


def final(m,validate_bucket,root_labels,launch_validation):
    module,value=locked_bundle(m)
    return module.assert_final_coverage(value,m,validate_bucket,root_labels,launch_validation=launch_validation,root=c.ROOT)
