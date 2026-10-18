"""One parent-held, once-hashed semantic input map per exact reservation.

These records borrow the outer launcher's live read handles. They do not
replace next-layer certificates or permit reuse across invocation identities.
"""
import re
import campaign_io as c
import invocation_budget as ib

SCHEMA="PARENT_LOCKED_NATIVE_AND_CHECKED_CODE_INPUTS_V12_V4"
CODE_CUSTODY="ACTUAL_PARENT_CODE_SHA256_UNDER_CONTINUOUS_READLOCKS_V12_V4"

def validate_file_map(files):
    if not isinstance(files,dict) or not files:raise ValueError("Empty parent semantic input map")
    for name,binding in files.items():
        if not isinstance(name,str) or c.rel(c.rootpath(name))!=name or not isinstance(binding,dict) or set(binding)!={"bytes","sha256"}:
            raise ValueError("Noncanonical parent input identity")
        if type(binding["bytes"]) is not int or binding["bytes"]<0 or not re.fullmatch("[0-9a-f]{64}",binding.get("sha256","") or ""):
            raise ValueError("Malformed parent semantic input digest")
    return files

def check_code_locked(expected,guard=None):
    """One actual parent SHA pass, while its exact source handles are held.

    Return records computed from current bytes, not an unchecked expected map.
    The caller owns those same handles until all owned services are gone.
    """
    validate_file_map(expected)
    actual={}
    for name,wanted in expected.items():
        if guard:guard()
        path=c.rootpath(name)
        got=dict(bytes=path.stat().st_size,sha256=c.sha(path,guard))
        if got!=wanted:raise ValueError("Actual parent code bytes differ from immutable manifest: "+name)
        actual[name]=got
    return actual

def checked_code_fields(actual,manifest_sha256):
    validate_file_map(actual)
    return dict(checked_code_binding={k:dict(v) for k,v in actual.items()},
        checked_code_binding_record_count=len(actual),checked_code_binding_manifest_sha256=manifest_sha256,
        checked_code_custody=CODE_CUSTODY,parent_completed_actual_code_SHA256_pass=True,
        all_code_files_readlocked_before_actual_hash=True,parent_keeps_code_locks_until_kernel_empty=True)

def read_locked(path,folder,ticket,manifest_sha256,code_binding):
    """Caller already holds the record lock; the reserving parent holds inputs."""
    wanted=folder/"parent_inputs"/(ticket["token"]+".json")
    if path.resolve()!=wanted.resolve() or c.rel(path)!=ticket.get("parent_inputs") or c.sha(path)!=ticket.get("parent_inputs_sha256"):
        raise ValueError("Parent input snapshot differs from its exact reservation")
    value=c.read(path)
    if value.get("schema")!=SCHEMA or value.get("manifest_sha256")!=manifest_sha256 or value.get("reservation_token")!=ticket["token"] or value.get("all_actual_files_readlocked_before_hash") is not True or value.get("parent_keeps_locks_until_kernel_empty") is not True:
        raise ValueError("Parent input custody assertion has wrong manifest/reservation")
    validate_file_map(value.get("files"))
    actual=value.get("checked_code_binding")
    validate_file_map(actual);validate_file_map(code_binding)
    if actual!=code_binding or type(value.get("checked_code_binding_record_count")) is not int or value["checked_code_binding_record_count"]!=len(code_binding) or value.get("checked_code_binding_manifest_sha256")!=manifest_sha256:
        raise ValueError("Parent actual checked code map/count differs from the current locked manifest")
    if value.get("checked_code_custody")!=CODE_CUSTODY or value.get("parent_completed_actual_code_SHA256_pass") is not True or value.get("all_code_files_readlocked_before_actual_hash") is not True or value.get("parent_keeps_code_locks_until_kernel_empty") is not True:
        raise ValueError("Parent actual code SHA/read-lock custody receipt is incomplete")
    return value

def bind_reservation(ticket,path):
    """Publish the immutable snapshot before the child may adopt this ticket."""
    value=c.read(ib.state_path(ticket.folder))
    if value.get("reservation")!=ticket.ticket:raise ValueError("Reservation changed while binding parent inputs")
    ticket.ticket=dict(ticket.ticket,parent_inputs=c.rel(path),parent_inputs_sha256=c.sha(path))
    value["reservation"]=ticket.ticket;c.atomic(ib.state_path(ticket.folder),value)
