"""Locked-input frame schedules and exact durable schedule identities."""
from pathlib import Path
import campaign_io as c
import frame_planner as p

def work_paths():
    root=c.ROOT/"runs/lean_table_checker/successor_cache_v1/inputs"
    return (c.INDEX/"groups.bin",root/"numeric.bin",root/"honors.bin")

def runtime_work(locked,rt):
    files=work_paths();binding={c.rel(x):locked[c.rel(x)] for x in files}
    if rt.frame_work is None:
        rt.frame_work=p.Work.from_bytes(*(x.read_bytes() for x in files));rt.frame_work_binding=binding
    elif rt.frame_work_binding!=binding:raise ValueError("Fixed frame-work inputs changed within invocation")
    if binding!=rt.m["frame_work_inputs"]:raise ValueError("Actual frame-work bytes differ from the immutable certified seed")
    return rt.frame_work,binding

def make_schedule(m,row,request,locked,work,work_binding,guard=None):
    if work.honor_codes[row["honor"]]!=row["honor_code"]:raise ValueError("Frame honor cost does not match actual canonical inventory")
    frames=[]
    with p.MappedDirectory(c.rootpath(row["directory"])) as directory:
        if directory.blocks!=row["blocks"]:raise ValueError("Actual production block count differs from complete numbering")
        for frame in p.partition(directory,work,row["honor"],request["start"],request["count"],row["size"],m["frame_policy"]):
            if guard:guard()
            frames.append(frame)
    p.validate_frames(frames,request["start"],request["count"],m["frame_policy"])
    return dict(schema=p.SCHEDULE,layer=row["layer"],honor=row["honor"],start=request["start"],count=request["count"],size=row["size"],
        dataset_sha256=m["dataset_sha256"],policy=m["frame_policy"],policy_sha256=p.policy_sha(m["frame_policy"]),
        source_directory=row["directory"],source_directory_binding=locked[row["directory"]],work_inputs=work_binding,frames=frames)

def prepare(f,m,state,row,request,locked,rt):
    work,binding=runtime_work(locked,rt)
    value=make_schedule(m,row,request,locked,work,binding,rt.guard)
    path=f/"frames"/(c.stem(row["layer"],row["honor"])+".json")
    if not path.exists():c.atomic(path,value)
    rt.proof_locks.append(c.ReadLocks([path]))
    if c.read(path)!=value:raise ValueError("Existing immutable frame schedule differs from actual locked geometry or policy")
    record=dict(path=c.rel(path),bytes=path.stat().st_size,sha256=c.sha(path,rt.guard))
    prior=state.get("active_frame_schedule")
    if prior is not None and prior.get("path")!=record["path"]:prior=None
    if prior is not None and prior!=record:raise ValueError("Frame schedule identity changed after an earlier commit")
    state["active_frame_schedule"]=record
    from ledger import save_root
    save_root(f,state)
    store_cache(rt.frame_cache,cache_key(record,m),value)
    return value,record

def load(record,m,cache=None,locks=None,guard=None):
    if cache is None:cache={}
    key=cache_key(record,m)
    if key in cache:return cache[key]
    path=c.rootpath(record["path"])
    if not path.is_relative_to((c.RUN/"campaigns"/m["name"]/"frames").resolve()):raise ValueError("Frame schedule escaped its own campaign")
    if locks is not None:locks.append(c.ReadLocks([path]))
    c.check_fingerprint(path,record,guard);v=c.read(path)
    request=next((r for r in m["requests"] if (r["layer"],r["honor"])==(v.get("layer"),v.get("honor"))),None)
    if request is None or any(v.get(k)!=request[k] for k in ("start","count","size")):raise ValueError("Frame schedule extent differs from exact manifest request")
    if v.get("schema")!=p.SCHEDULE or v.get("dataset_sha256")!=m["dataset_sha256"] or v.get("policy")!=m["frame_policy"] or v.get("policy_sha256")!=p.policy_sha(m["frame_policy"]):
        raise ValueError("Frame schedule policy or dataset identity changed")
    p.validate_frames(v["frames"],request["start"],request["count"],m["frame_policy"])
    if v.get("work_inputs")!=m["frame_work_inputs"]:raise ValueError("Schedule raw successor/group identity differs from certified work inputs")
    store_cache(cache,key,v);return v

def cache_key(record,m):return (record["path"],record["sha256"],m["dataset_sha256"],p.policy_sha(m["frame_policy"]),m["name"])
def store_cache(cache,key,value):
    if key in cache:cache.pop(key)
    while len(cache)>=8:cache.pop(next(iter(cache)))
    cache[key]=value

def check_item(m,item,value,cache=None,locks=None,guard=None):
    schedule=load(item["frame_schedule_binding"],m,cache,locks,guard)
    frame=item["frame"];index=frame["index"]
    if not 0<=index<len(schedule["frames"]) or schedule["frames"][index]!=frame:raise ValueError("Committed chunk is not the exact canonical bounded frame")
    if (item["layer"],item["honor"],item["start"],item["count"])!=(schedule["layer"],schedule["honor"],frame["start"],frame["count"]):
        raise ValueError("Committed frame belongs to another source address")
    if item["source_directory_binding"]!=schedule["source_directory_binding"]:raise ValueError("Committed frame source geometry changed")
    p.check_native_work(value,frame,m["frame_policy"])
