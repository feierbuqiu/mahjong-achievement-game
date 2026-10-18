"""Compact campaign IO; immutable numbering inputs are read from frozen v4."""
from pathlib import Path
import hashlib,importlib.util,json,os,sys,time

BASE=Path(__file__).resolve().parent
ROOT=BASE.parents[2]
DATASET=ROOT/"runs/lean_table_checker/campaign_20261018_v4"
RUN=ROOT/"runs/lean_table_checker/campaign_indexed_20261018_v16"
GPU_RUN=ROOT/"runs/lean_table_checker/gpu_indexed_byte_20261018_v16/campaign_indexed_v16"
DATA=ROOT/"runs/global_retro/pilot_v1/data"
INDEX=DATASET/"index"
sys.path.insert(0,str(BASE.parent/"cached_checker_v2"))
import benchmark_e2e as legacy

# Execute the exact bytes that were hashed, without a second importer read.
# Every old file HANDLE is still independently acquired and kept; only the
# process-wide ctypes wrapper allocation changes. No frozen source is edited.
READ_LOCK_SOURCE=ROOT/"build/lean_table_checker/read_lock_footprint_v13/shared_read_locks.py"
READ_LOCK_SHA="66fc89d40ef604d0ae7c57ffcd4995b36cc24686b771f81b10d7051e4241f78d"
_lock_bytes=READ_LOCK_SOURCE.read_bytes()
if hashlib.sha256(_lock_bytes).hexdigest()!=READ_LOCK_SHA:raise ValueError("Shared read-lock wrapper identity changed")
_lock_spec=importlib.util.spec_from_file_location("_v12_v4_exact_shared_readlocks",READ_LOCK_SOURCE)
readlock_backend=importlib.util.module_from_spec(_lock_spec)
exec(compile(_lock_bytes,str(READ_LOCK_SOURCE),"exec"),readlock_backend.__dict__)
del _lock_bytes
ReadLocks=readlock_backend.ReadLocks

def read(path):return json.loads(Path(path).read_text(encoding="utf-8"))
def rel(path):return Path(path).resolve().relative_to(ROOT).as_posix()
def sha(path,guard=None):
    h=hashlib.sha256()
    with Path(path).open("rb") as stream:
        while raw:=stream.read(4*1024*1024):
            if guard:guard()
            h.update(raw)
    return h.hexdigest()
def atomic(path,value):
    path=Path(path);path.parent.mkdir(parents=True,exist_ok=True)
    tmp=path.with_name(path.name+".tmp")
    raw=value if isinstance(value,bytes) else (json.dumps(value,ensure_ascii=False,sort_keys=True,indent=2)+"\n").encode()
    with tmp.open("wb") as f:f.write(raw);f.flush();os.fsync(f.fileno())
    os.replace(tmp,path)
def bind(paths):return {rel(p):dict(bytes=Path(p).stat().st_size,sha256=sha(p)) for p in paths}
def stem(n,h):return f"n{n:02}_h{h:03}"
def rootpath(value):
    path=(ROOT/value).resolve()
    if not path.is_relative_to(ROOT):raise ValueError("Path outside research workspace")
    return path
def remove_temporary(path,temporary_root):
    p=Path(path).resolve();r=Path(temporary_root).resolve()
    if not r.is_relative_to(RUN.resolve()) or not p.is_relative_to(r) or p==r:
        raise ValueError("Cleanup is restricted to this campaign's own temporary files")
    if p.is_file():p.unlink()
def packed(labels):
    out=bytearray((len(labels)+7)//8)
    for i,x in enumerate(labels):
        if x not in (0,1):raise ValueError("Native label must be exactly 0 or 1")
        out[i//8]|=x<<(i%8)
    return bytes(out)
def bits_span(path,start,count):
    with Path(path).open("rb") as f:f.seek(start//8);raw=f.read((start%8+count+7)//8)
    if len(raw)!=(start%8+count+7)//8:raise ValueError("Truncated source bits")
    return ((int.from_bytes(raw,"little")>>(start%8))&((1<<count)-1)).to_bytes((count+7)//8,"little")
def check_fingerprint(path,record,guard=None):
    if Path(path).stat().st_size!=record["bytes"] or sha(path,guard)!=record["sha256"]:
        raise ValueError("Immutable artifact changed: "+str(path))
