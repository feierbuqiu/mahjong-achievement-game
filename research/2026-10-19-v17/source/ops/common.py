"""IO bookkeeping for the new V17 activity; never a mathematical checker."""
from pathlib import Path
import contextlib, datetime, hashlib, json, os, re, time, uuid

ROOT=Path(__file__).resolve().parents[4]
BASE=Path(__file__).resolve().parent
RUNS=ROOT/'runs/lean_table_checker/v17_compute_finish_20261018'
HEX=re.compile(r'[0-9a-f]{64}\Z')
SIX=('base','successors','metadata','frames','target_identity','root_P')
WIRE='indexed_actual_next_byte_v16'
END=b'\nCOMPACT_PAYLOAD_END_V1\n'

def need(v,m):
    if not v:raise ValueError(m)

def uint(v,m='integer'):
    need(type(v) is int and v>=0,'Invalid '+m);return v

def canonical(v):return json.dumps(v,sort_keys=True,separators=(',',':'),ensure_ascii=False,allow_nan=False).encode()
def digest(v):return hashlib.sha256(canonical(v)).hexdigest()
def utc():return datetime.datetime.now(datetime.timezone.utc).isoformat()
def rel(p):return Path(p).resolve().relative_to(ROOT).as_posix()

def path(name):
    p=Path(name)
    p=p if p.is_absolute() else ROOT/p
    p=p.resolve();need(p.is_relative_to(ROOT) and p!=ROOT,'Path outside workspace')
    return p

def owned(name):
    p=path(name);need(p.is_relative_to(RUNS) and p!=RUNS,'Only new V17 run output is writable');return p

def load(p):return json.loads(Path(p).read_text(encoding='utf-8-sig'))

def atomic(p,value):
    p=owned(p);p.parent.mkdir(parents=True,exist_ok=True)
    raw=value if isinstance(value,bytes) else canonical(value)+b'\n'
    tmp=p.with_name(p.name+'.'+uuid.uuid4().hex+'.tmp')
    with tmp.open('xb') as f:f.write(raw);f.flush();os.fsync(f.fileno())
    os.replace(tmp,p)

def once(p,value):
    p=owned(p);p.parent.mkdir(parents=True,exist_ok=True)
    raw=value if isinstance(value,bytes) else canonical(value)+b'\n'
    with p.open('xb') as f:f.write(raw);f.flush();os.fsync(f.fileno())
    return record(p)

def sha_file(p,guard=lambda:None,progress=None):
    p=path(p);before=p.stat();h=hashlib.sha256();done=0
    with p.open('rb',buffering=0) as f:
        while True:
            guard();b=f.read(8*1024*1024)
            if not b:break
            h.update(b);done+=len(b)
            if progress:progress(done)
    after=p.stat()
    need((before.st_size,before.st_mtime_ns,before.st_ino)==(after.st_size,after.st_mtime_ns,after.st_ino),'Input changed while hashing: '+rel(p))
    return dict(bytes=done,sha256=h.hexdigest())

def record(p,guard=lambda:None):return dict(path=rel(p),**sha_file(p,guard))

def identity(v):
    need(isinstance(v,dict) and type(v.get('bytes')) is int and v['bytes']>=0 and HEX.fullmatch(v.get('sha256','')),'Bad file identity')
    return dict(bytes=v['bytes'],sha256=v['sha256'])

def checked_record(v):
    need(isinstance(v,dict) and 'path' in v,'Missing file record');p=path(v['path'])
    need(record(p)==v,'Artifact identity mismatch: '+str(p));return p

class ReadLocks:
    """Windows deny-write/delete custody; Linux fallback is advisory only."""
    def __init__(self,files):
        self.objects=[];self.handles=[];self.platform=os.name
        if os.name=='nt':
            helper=ROOT/'build/lean_table_checker/read_lock_footprint_v13/shared_read_locks.py'
            b=helper.read_bytes();need(hashlib.sha256(b).hexdigest()=='66fc89d40ef604d0ae7c57ffcd4995b36cc24686b771f81b10d7051e4241f78d','Read-lock helper changed')
            ns=dict(__name__='_v17_owned_readlocks',__file__=str(helper));exec(compile(b,str(helper),'exec'),ns)
            try:self.objects.append(ns['ReadLocks']([path(p) for p in sorted(set(map(str,files)))]))
            except BaseException:self.close();raise
        else:
            import fcntl
            try:
                for p in sorted(set(map(str,files))):
                    f=path(p).open('rb');fcntl.flock(f.fileno(),fcntl.LOCK_SH);self.handles.append(f)
            except BaseException:self.close();raise
    def close(self):
        for x in reversed(self.objects):x.close()
        for x in reversed(self.handles):x.close()
        self.objects=[];self.handles=[]
    def __enter__(self):return self
    def __exit__(self,*args):self.close()

class OwnerLock:
    def __init__(self,p):
        self.p=owned(p);self.p.parent.mkdir(parents=True,exist_ok=True);self.f=self.p.open('a+b')
        self.f.seek(0);self.f.write(b'0');self.f.flush();self.f.seek(0)
        try:
            if os.name=='nt':
                import msvcrt;msvcrt.locking(self.f.fileno(),msvcrt.LK_NBLCK,1)
            else:
                import fcntl;fcntl.flock(self.f.fileno(),fcntl.LOCK_EX|fcntl.LOCK_NB)
        except BaseException:self.f.close();raise RuntimeError('Another controller owns this run')
    def close(self):self.f.close()
    def __enter__(self):return self
    def __exit__(self,*args):self.close()

def bucket_key(n,h):return f'n{uint(n):02}_h{uint(h):03}'

def seven_fields(cell,files,common):
    if not cell['size']:return None
    return dict(numeric=dict(path=common['numeric'],**identity(files[common['numeric']])),
                ids=dict(path=common['ids'],**identity(files[common['ids']])),
                groups=dict(path=common['groups'],**identity(files[common['groups']])),
                directory=dict(path=cell['directory'],**identity(files[cell['directory']])),
                honor_code=cell['code'],size=cell['size'],
                bits=dict(path=cell['bits'],**identity(files[cell['bits']])))

def system_memory():
    try:
        import psutil
        v=psutil.virtual_memory()
        try:
            s=psutil.swap_memory();swap=dict(swap_used=s.used,swap_diagnostic_error=None)
        except Exception as error:
            swap=dict(swap_used=None,swap_diagnostic_error=repr(error))
        return dict(total=v.total,available=v.available,percent=v.percent,**swap)
    except ImportError:
        if os.name=='nt':raise
        d={x.split(':')[0]:int(x.split()[1])*1024 for x in Path('/proc/meminfo').read_text().splitlines() if len(x.split())>=2}
        return dict(total=d['MemTotal'],available=d['MemAvailable'],percent=100*(1-d['MemAvailable']/d['MemTotal']),swap_used=d.get('SwapTotal',0)-d.get('SwapFree',0))

class Journal:
    def __init__(self,run,manifest_sha,repair_tail=False):
        self.run=owned(run);self.file=self.run/'ledger.jsonl';self.manifest_sha=manifest_sha
        self.entries=[];self.head='0'*64;self.keys={}
        if self.file.exists():
            raw=self.file.read_bytes()
            if raw and not raw.endswith(b'\n'):
                need(repair_tail,'Truncated ledger tail')
                cut=raw.rfind(b'\n')+1
                once(self.run/'recovery'/('tail_'+uuid.uuid4().hex+'.bin'),raw[cut:])
                atomic(self.file,raw[:cut]);raw=raw[:cut]
            for line in raw.splitlines():
                item=json.loads(line);body={k:v for k,v in item.items() if k!='entry_sha256'}
                need(item['entry_sha256']==digest(body) and item['previous_sha256']==self.head,'Ledger chain mismatch')
                need(item['sequence']==len(self.entries) and item['manifest_sha256']==manifest_sha,'Ledger sequence/manifest mismatch')
                key=tuple(item['frame_key']);need(key not in self.keys,'Duplicate frame ledger key')
                self.entries.append(item);self.keys[key]=item;self.head=item['entry_sha256']
    def append(self,key,receipt):
        key=tuple(key);need(key not in self.keys,'Never commit a frame twice')
        body=dict(sequence=len(self.entries),previous_sha256=self.head,manifest_sha256=self.manifest_sha,
                  frame_key=list(key),receipt=receipt,committed_utc=utc())
        item=dict(body,entry_sha256=digest(body));raw=canonical(item)+b'\n'
        with self.file.open('ab') as f:f.write(raw);f.flush();os.fsync(f.fileno())
        self.entries.append(item);self.keys[key]=item;self.head=item['entry_sha256'];return item
