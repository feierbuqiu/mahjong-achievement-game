"""Per-bucket linear durable journals with fsynced immutable frame receipts.

A bucket head is the commit point. Root progress may lag a valid durable head,
but may never lead one. Unheaded journal bytes are quarantined before repair.
No P/N inference happens here; the caller verifies every native receipt/payload.
"""
from pathlib import Path
import hashlib,json,os,time
import campaign_io as c

HEADER="OWNED_BUCKET_LEDGER_HEADER_V4"
HEAD="OWNED_BUCKET_LEDGER_HEAD_V4"
ENTRY="OWNED_BUCKET_HASHCHAIN_ENTRY_V4"
MAX_LINE=2_000_000

def canonical(value):return json.dumps(value,sort_keys=True,separators=(",",":"),ensure_ascii=False).encode()
def chain(previous,payload):return hashlib.sha256(bytes.fromhex(previous)+canonical(payload)).hexdigest()
def binding(path):return dict(path=c.rel(path),bytes=path.stat().st_size,sha256=c.sha(path))
def counts(state):return tuple(state.get(k,0) for k in ("committed_chunks","committed_rows","packed_payload_bytes"))
def root_view(state):return {k:v for k,v in state.items() if not k.startswith("_") and k!="chunks"}
def save_root(folder,state):c.atomic(folder/"checkpoint.json",root_view(state))

class BucketLedger:
    def __init__(self,folder,manifest,request,identity=None,initialize=False):
        self.f=folder;self.m=manifest;self.request=request;self.key=c.stem(request["layer"],request["honor"])
        self.directory=folder/"ledgers"/self.key
        self.header_path=self.directory/"header.json";self.head_path=self.directory/"head.json";self.journal=self.directory/"journal.jsonl"
        if not self.directory.resolve().is_relative_to(folder.resolve()):raise ValueError("Ledger outside its campaign")
        if initialize:
            value=dict(schema=HEADER,manifest_sha256=c.sha(folder/"manifest.json"),request=request,worker_binding=manifest["worker"],identity=identity)
            if self.header_path.exists():
                if c.read(self.header_path)!=value:raise ValueError("Immutable bucket ledger identity changed")
            else:c.atomic(self.header_path,value)
            if not self.journal.exists():c.atomic(self.journal,b"")
        self.header=c.read(self.header_path)
        if self.header.get("schema")!=HEADER or self.header.get("manifest_sha256")!=c.sha(folder/"manifest.json") or self.header.get("request")!=request or self.header.get("worker_binding")!=manifest["worker"]:
            raise ValueError("Bucket ledger belongs to another manifest/request/checker")
        self.header_sha=c.sha(self.header_path)
        self.empty=dict(schema=HEAD,header_sha256=self.header_sha,sequence=0,last_global_sequence=0,chain_hash=self.header_sha,journal_bytes=0,
            next_start=request["start"],committed_rows=0,P_rows=0,N_rows=0,packed_payload_bytes=0)
        if initialize and not self.head_path.exists():
            if self.journal.stat().st_size:self.quarantine_tail(self.empty)
            c.atomic(self.head_path,self.empty)
        self.head=c.read(self.head_path) if self.head_path.exists() else None

    def quarantine_tail(self,head,guard=None):
        keep=head["journal_bytes"];size=self.journal.stat().st_size
        if size<=keep:return None
        owned=self.directory/"quarantine";owned.mkdir(parents=True,exist_ok=True)
        tail=owned/f"uncommitted_{time.time_ns()}.bin";tmp=tail.with_suffix(".tmp");digest=hashlib.sha256()
        with self.journal.open("rb") as source,tmp.open("wb") as target:
            source.seek(keep)
            while data:=source.read(1024*1024):
                if guard:guard()
                target.write(data);digest.update(data)
            target.flush();os.fsync(target.fileno())
        os.replace(tmp,tail)
        evidence=dict(schema="OWNED_UNCOMMITTED_LEDGER_TAIL_QUARANTINE_V4",journal=c.rel(self.journal),prior_head=head,
            before_bytes=size,committed_prefix_bytes=keep,tail=c.rel(tail),tail_bytes=size-keep,tail_sha256=digest.hexdigest(),never_certified=True)
        c.atomic(tail.with_suffix(".json"),evidence)
        # Evidence and exact tail bytes exist durably before discarding them.
        with self.journal.open("r+b") as f:f.truncate(keep);f.flush();os.fsync(f.fileno())
        return evidence

    def walk(self,callback=None,repair=False,guard=None,locks=None):
        if self.head is None:raise ValueError("MISSING_DURABLE_BUCKET_HEAD")
        head=self.head
        if head.get("schema")!=HEAD or head.get("header_sha256")!=self.header_sha:raise ValueError("Bucket head/header identity changed")
        length=head.get("journal_bytes",-1)
        if not isinstance(length,int) or length<0 or not self.journal.exists() or self.journal.stat().st_size<length:raise ValueError("Committed ledger prefix is missing/truncated")
        current=dict(self.empty);items=[] if callback is None else None
        with self.journal.open("rb") as stream:
            while stream.tell()<length:
                if guard:guard()
                line=stream.readline(MAX_LINE+1)
                if not line.endswith(b"\n") or len(line)>MAX_LINE or stream.tell()>length:raise ValueError("Committed journal contains a torn/oversized record")
                record=json.loads(line);payload=record["payload"]
                if record.get("schema")!=ENTRY or record.get("previous")!=current["chain_hash"] or record.get("chain_hash")!=chain(current["chain_hash"],payload):raise ValueError("Committed journal hash chain changed")
                if any(type(payload.get(k)) is not int for k in ("sequence","global_sequence","start","count")) or payload["sequence"]!=current["sequence"]+1 or payload["start"]!=current["next_start"] or not 0<payload["count"]<=self.m["frame_policy"]["max_rows"]:
                    raise ValueError("Committed ledger sequence has duplicate/hole/overlap")
                path=c.rootpath(payload["receipt"]["path"])
                if not path.is_relative_to((self.directory/"items").resolve()):raise ValueError("Frame receipt escaped its bucket ledger")
                if locks is not None:locks.append(c.ReadLocks([path]))
                c.check_fingerprint(path,payload["receipt"],guard);item=c.read(path)
                if any(item.get(k)!=payload[k] for k in ("start","count","global_sequence")):raise ValueError("Frame receipt differs from journal extent/global sequence")
                if (item["layer"],item["honor"])!=(self.request["layer"],self.request["honor"]):raise ValueError("Journal frame belongs to another source bucket")
                if any(item.get(k)!=value for k,value in self.header["identity"].items()):raise ValueError("Committed item differs from the immutable ledger premises")
                if item["P_rows"]+item["N_rows"]!=item["count"] or item["packed_binding"]["bytes"]!=(item["count"]+7)//8:raise ValueError("Invalid durable frame counters")
                current.update(sequence=payload["sequence"],last_global_sequence=payload["global_sequence"],chain_hash=record["chain_hash"],journal_bytes=stream.tell(),
                    next_start=current["next_start"]+item["count"],committed_rows=current["committed_rows"]+item["count"],
                    P_rows=current["P_rows"]+item["P_rows"],N_rows=current["N_rows"]+item["N_rows"],packed_payload_bytes=current["packed_payload_bytes"]+item["packed_binding"]["bytes"])
                descriptor=dict(bucket=self.key,sequence=current["sequence"],global_sequence=item["global_sequence"],chain_hash=current["chain_hash"])
                if callback is not None:callback(item,descriptor)
                else:items.append(item)
        if current!=head or current["next_start"]>self.request["start"]+self.request["count"]:raise ValueError("Durable bucket head disagrees with verified exact journal prefix")
        if repair:self.quarantine_tail(head,guard)
        return items if callback is None else current

    def commit(self,item,global_sequence):
        if self.head is None:raise ValueError("Cannot commit before bucket initialization/recovery")
        if c.read(self.head_path)!=self.head or self.journal.stat().st_size!=self.head["journal_bytes"]:raise ValueError("Mutable bucket head/journal changed before commit")
        if type(item.get("count")) is not int or not 0<item["count"]<=self.m["frame_policy"]["max_rows"] or item["start"]!=self.head["next_start"] or item["start"]+item["count"]>self.request["start"]+self.request["count"]:raise ValueError("Only the exact next requested frame may commit")
        if any(item.get(k)!=value for k,value in self.header["identity"].items()):raise ValueError("Cannot commit incompatible bucket premises")
        if global_sequence<=0 or (self.head["sequence"] and global_sequence!=self.head["last_global_sequence"]+1):raise ValueError("Noncontiguous global frame sequence")
        item=dict(item,global_sequence=global_sequence)
        receipt=self.directory/"items"/f"frame_{self.head['sequence']+1:08}_{time.time_ns()}.json"
        c.atomic(receipt,item)
        payload=dict(sequence=self.head["sequence"]+1,global_sequence=global_sequence,start=item["start"],count=item["count"],receipt=binding(receipt))
        hashed=chain(self.head["chain_hash"],payload)
        record=dict(schema=ENTRY,payload=payload,previous=self.head["chain_hash"],chain_hash=hashed)
        raw=canonical(record)+b"\n"
        with self.journal.open("ab") as f:f.write(raw);f.flush();os.fsync(f.fileno())
        new=dict(self.head,sequence=payload["sequence"],last_global_sequence=global_sequence,chain_hash=hashed,
            journal_bytes=self.head["journal_bytes"]+len(raw),next_start=item["start"]+item["count"],committed_rows=self.head["committed_rows"]+item["count"],
            P_rows=self.head["P_rows"]+item["P_rows"],N_rows=self.head["N_rows"]+item["N_rows"],packed_payload_bytes=self.head["packed_payload_bytes"]+item["packed_binding"]["bytes"])
        c.atomic(self.head_path,new);self.head=new
        return item,dict(bucket=self.key,sequence=new["sequence"],global_sequence=global_sequence,chain_hash=hashed)

    def snapshot(self,locks=None):
        if locks is not None:locks.append(c.ReadLocks([self.header_path,self.journal,self.head_path]))
        return dict(header=binding(self.header_path),journal=binding(self.journal),head=binding(self.head_path))

def open_snapshot(folder,manifest,request,record,guard=None,locks=None):
    directory=folder/"ledgers"/c.stem(request["layer"],request["honor"])
    paths=dict(header=directory/"header.json",journal=directory/"journal.jsonl",head=directory/"head.json")
    if locks is not None:locks.append(c.ReadLocks(list(paths.values())))
    for key,path in paths.items():
        if record[key]["path"]!=c.rel(path):raise ValueError("Certificate ledger snapshot path changed")
        c.check_fingerprint(path,record[key],guard)
    ledger=BucketLedger(folder,manifest,request)
    return ledger

def reconcile(folder,manifest,state,validate,guard=None,locks=None):
    """Recompute totals from all durable heads; stream old records, keep no list."""
    old_counts=counts(state);old_last=state.get("last_commit");seen_old=old_counts[0]==0
    if any(type(x) is not int or x<0 for x in old_counts):raise ValueError("Invalid root progress totals")
    if old_counts[0]==0 and (old_counts[1:]!=(0,0) or old_last is not None):raise ValueError("Root progress counters are not a valid zero prefix")
    if old_counts[0]>0:
        if not old_last or old_last.get("global_sequence")!=old_counts[0]:raise ValueError("Root lacks its durable last-commit identity")
        head=folder/"ledgers"/old_last["bucket"]/"head.json"
        if not head.exists() or c.read(head).get("sequence",-1)<old_last["sequence"]:raise ValueError("ROOT_AHEAD_OR_DURABLE_HEAD_MISSING")
    chunks=rows=packed=0;last=None
    def accept(item,descriptor):
        nonlocal chunks,rows,packed,last,seen_old
        if item["global_sequence"]!=chunks+1:raise ValueError("Global journal sequence has duplicate/hole/out-of-order bucket")
        validate(item)
        chunks+=1;rows+=item["count"];packed+=item["packed_binding"]["bytes"];last=descriptor
        if chunks==old_counts[0]:
            if (chunks,rows,packed)!=old_counts or descriptor!=old_last:raise ValueError("Root prefix counters/hash differ from actual durable evidence")
            seen_old=True
    prior_request_pending=False
    for request in manifest["requests"]:
        directory=folder/"ledgers"/c.stem(request["layer"],request["honor"])
        if not (directory/"header.json").exists():
            if not (folder/"registry"/(c.stem(request["layer"],request["honor"])+".json")).exists():prior_request_pending=True
            continue
        if locks is not None:locks.append(c.ReadLocks([directory/"header.json"]))
        value=BucketLedger(folder,manifest,request)
        if value.head is None:
            # No root checkpoint references it (checked above): retain and
            # discard unheaded bytes, then restore an explicit empty head.
            if value.journal.exists():value.quarantine_tail(value.empty,guard)
            else:c.atomic(value.journal,b"")
            c.atomic(value.head_path,value.empty);value.head=value.empty
        if prior_request_pending and value.head["sequence"]:raise ValueError("Later bucket progress precedes an unfinished manifest request")
        value.walk(accept,repair=True,guard=guard,locks=locks)
        if value.head["next_start"]!=request["start"]+request["count"]:prior_request_pending=True
    if not seen_old or chunks<old_counts[0]:raise ValueError("ROOT_AHEAD_OF_VERIFIED_DURABLE_LEDGERS")
    if (chunks,rows,packed)!=old_counts:
        event=folder/"recoveries"/(str(time.time_ns())+".json")
        c.atomic(event,dict(kind="VERIFIED_DURABLE_HEAD_ROLL_FORWARD",before=list(old_counts),after=[chunks,rows,packed]))
        state.update(recovery_count=state.get("recovery_count",0)+1,last_recovery=c.rel(event))
    state.update(committed_chunks=chunks,committed_rows=rows,packed_payload_bytes=packed,last_commit=last)
    return state
