"""Cross-bucket CUDA context, exact per-bucket identities, unchanged native checks.

One GPU session per invocation retains only fixed common arrays/module/output.
Each bucket has a fresh locked manifest; its bank is synchronized and freed
before its input locks can be released. Only current + one prefetch is buffered.
"""
from pathlib import Path
import json,os,queue,subprocess,threading,time
import campaign_io as c
import path_guard as paths

GPU_SCRIPT=c.ROOT/"build/lean_table_checker/gpu_indexed_byte_v16/worker.py"
STOP_SCRIPT=c.ROOT/"build/lean_table_checker/gpu_indexed_byte_v16/stop_owned.py"
GPU_SCHEMA="GPU_CROSS_BUCKET_INDEXED_BYTE_PROTOCOL_V16"
NATIVE_SCHEMA="INDEXED_BYTE_LARGE_FRAME_RESIDENT_PROTOCOL_V16"
TRANSPORT="indexed_actual_next_byte_v16"
END=b"\nCOMPACT_PAYLOAD_END_V1\n"

def linux(path):
    p=Path(path).resolve()
    if p.drive.lower()!="c:":raise ValueError("WSL compact paths must be on the bound C drive")
    return "/mnt/c/"+p.as_posix()[3:]

def expected(value,fields,message):
    if any(value.get(k)!=v for k,v in fields.items()):raise ValueError(message+": "+repr(value))

def stop_owned(pidfile):
    path=Path(pidfile).resolve()
    if not path.is_relative_to(c.GPU_RUN.resolve()):raise ValueError("Stop path outside the owned resident campaign subtree")
    def call(script):
        result=subprocess.run(["wsl.exe","-d","Ubuntu","--cd",linux(c.ROOT),"python3","-B",c.rel(script),"--pid-file",linux(path)],
            cwd=c.ROOT,capture_output=True,text=True,encoding="utf-8",check=True,timeout=25,creationflags=subprocess.CREATE_NO_WINDOW)
        value=json.loads(result.stdout)
        expected(value,dict(status="CONFIRMED_OWNED_LINUX_PROCESS_EXITED"),"Exact Linux exit not confirmed")
        return value
    if path.exists():
        try:return call(STOP_SCRIPT)
        except BaseException:return call(c.BASE/"stop_unreceipted.py")
    return call(c.BASE/"stop_unreceipted.py")

class CrossGPU:
    def __init__(self,m,rt):
        raise ValueError("UNSUPPORTED_STANDALONE_GPU_FALLBACK: this campaign requires its bound fused Linux context and V15 scratch producer")
        self.rt=rt;self.m=m;self.closed=False;self.exit_confirmed=False;self.p=None;self.input_lock=None;self.log=None
        self.events=[];self.event_count=0;self.event_lock=threading.Lock();self.active=None;self.total_spans=0;self.total_rows=0;self.generation=0;self.token=None
        directory=c.GPU_RUN/m["name"]/"sessions";directory.mkdir(parents=True,exist_ok=True)
        self.base=directory/("context_gpu_"+str(time.time_ns()))
        self.events_path=Path(str(self.base)+".events.jsonl");self.events_log=self.events_path.open("xb")
        self.pidfile=Path(str(self.base)+".pid.json");manifest=Path(str(self.base)+".fixed.json")
        # All of these code/common/library files are held by the outer immutable
        # ReadLocks before this digest cache is created; no bucket data is cached.
        self.fixed={name:m["code_binding"][name] for name in m["gpu_fixed_inputs"]}
        c.atomic(manifest,dict(schema="V4_READ_LOCKED_INPUT_DIGESTS",files=self.fixed))
        self.input_lock=c.ReadLocks([manifest]);self.manifest_sha256=c.sha(manifest)
        self.log_path=Path(str(self.base)+".stderr.log");self.log=self.log_path.open("wb")
        producer=c.rootpath(m["gpu_bucket_producer"]["script"])
        if producer!=GPU_SCRIPT:raise ValueError("Resident GPU script mismatch")
        argv=["wsl.exe","-d","Ubuntu","--cd",linux(c.ROOT),"python3","-B","-u",c.rel(producer),
            "--index",linux(c.INDEX),"--catalog",linux(c.INDEX/"catalog.tsv"),"--data",linux(c.DATA),
            "--fixed-manifest",linux(manifest),"--fixed-manifest-sha256",self.manifest_sha256,"--pid-file",linux(self.pidfile),
            "--max-count",str(m["chunk_rows"]),"--device-cap-bytes",str(m["GPU_hard_cap_bytes"]),"--host-rss-cap-bytes",str(m["linux_RSS_cap_bytes"])]
        try:self.p=subprocess.Popen(argv,cwd=c.ROOT,stdin=subprocess.PIPE,stdout=subprocess.PIPE,stderr=self.log,creationflags=subprocess.CREATE_NO_WINDOW)
        except BaseException:self.close(abort=True);raise
    def line(self):
        raw=self.p.stdout.readline(1_000_001)
        if not raw or len(raw)>1_000_000:raise ValueError("Resident GPU EOF or oversized JSONL: "+repr(raw[:1000]))
        try:value=json.loads(raw)
        except (ValueError,UnicodeError) as error:raise ValueError("Invalid resident GPU JSONL: "+repr(raw[:1000])) from error
        with self.event_lock:
            self.events_log.write((json.dumps(value,sort_keys=True)+"\n").encode());self.event_count+=1
            if len(self.events)<2:self.events.append(value)
        return value
    def send(self,value):
        self.p.stdin.write((json.dumps(value)+"\n").encode());self.p.stdin.flush()
    def session_ready(self):
        if self.token is not None:return
        value=self.line();expected(value,dict(event="SESSION_READY",schema=GPU_SCHEMA,max_count=self.m["chunk_rows"]),"Cross-bucket SESSION_READY mismatch")
        identity=value["fixed_identity"]
        expected(identity,dict(schema="UNTRUSTED_FIXED_COMPACT_CUDA_CONTEXT_V6",input_files=self.fixed,manifest_sha256=self.manifest_sha256),"Fixed GPU lock identity mismatch")
        owner=c.read(self.pidfile)
        expected(owner,dict(schema="OWNED_CROSS_BUCKET_GPU_PROCESS_V6",script=c.rel(GPU_SCRIPT),script_sha256=self.m["code_binding"][c.rel(GPU_SCRIPT)]["sha256"]),"Exact GPU process identity mismatch")
        if type(owner.get("pid")) is not int or owner["pid"]<=1 or type(owner.get("start_ticks")) is not int or owner["start_ticks"]<=0:raise ValueError("Missing exact owned GPU PID")
        self.token=value["session_token"]
        if owner.get("session_token")!=self.token:raise ValueError("GPU ownership token mismatch")
        self.fixed_identity=value["fixed_identity_sha256"]
    def enter(self,view):
        self.session_ready()
        if self.active is not None:raise ValueError("Prior bucket bank still active")
        self.send(dict(enter_bucket=dict(layer=view.layer,honor=view.honor,manifest=linux(view.manifest),manifest_sha256=view.manifest_sha256)))
        value=self.line();expected(value,dict(event="BUCKET_READY",schema=GPU_SCHEMA,session_token=self.token,generation=self.generation+1,
            layer=view.layer,honor=view.honor,source_size=view.row["size"],fixed_context_reused=True),"Fresh bucket READY mismatch")
        bank=value["bucket_identity"]
        expected(bank,dict(schema="UNTRUSTED_FRESH_GPU_BUCKET_IDENTITY_V6",generation=self.generation+1,layer=view.layer,honor=view.honor,
            locked_manifest_sha256=view.manifest_sha256,fixed_identity_sha256=self.fixed_identity,mode=1,record_bytes=1),"Bucket manifest binding mismatch")
        for name,binding in bank["input_files"].items():
            if view.locked.get(name)!=binding:raise ValueError("GPU bucket claimed an unlocked input")
        self.generation+=1;self.active=view;view.generation=self.generation;view.identity=value["identity_sha256"]
        return value
    def exact(self,size):
        data=bytearray(size);view=memoryview(data);offset=0
        while offset<size:
            count=self.p.stdout.readinto(view[offset:min(offset+4*1024*1024,size)])
            if not count:raise EOFError("Truncated untrusted cross-bucket compact frame")
            offset+=count
        return data
    def span(self,view,start,count):
        if self.active is not view or view.generation!=self.generation or not 0<count<=self.m["chunk_rows"]:raise ValueError("Wrong active bucket or bounded compact span")
        temporary=Path(str(view.base)+f"_span_{view.completed:06}");temporary.mkdir(parents=True,exist_ok=True)
        self.send(dict(start=start,count=count,output_root=linux(temporary)))
        common=dict(schema=GPU_SCHEMA,session_token=self.token,generation=self.generation,layer=view.layer,honor=view.honor,start=start,count=count,
            transport=TRANSPORT,compact_bytes=count,record_bytes=1,endianness="little",identity_sha256=view.identity,
            fixed_identity_sha256=self.fixed_identity,completed_spans=view.completed+1,session_completed_spans=self.total_spans+1)
        header=self.line();expected(header,dict(event="PAYLOAD",**common),"Cross-bucket compact header mismatch")
        compact=self.exact(count);footer=self.line();expected(footer,dict(event="PROPOSED",**common),"Cross-bucket compact footer mismatch")
        receipt=temporary/"receipt.json"
        if footer.get("receipt")!=linux(receipt) or c.sha(receipt)!=footer.get("receipt_sha256"):raise ValueError("GPU origin receipt path/hash mismatch")
        origin=c.read(receipt)
        expected(origin,dict(schema="UNTRUSTED_CROSS_BUCKET_COMPACT_PROPOSAL_V6",status="STREAMED_NOT_LEAN_CERTIFIED",session_token=self.token,
            generation=self.generation,layer=view.layer,honor=view.honor,start=start,count=count,compact_bytes=count,
            identity_sha256=view.identity,fixed_identity_sha256=self.fixed_identity,locked_manifest_sha256=view.manifest_sha256,
            transport=TRANSPORT,payload_saved_to_disk=False,payload_hashed=False,completed_spans=view.completed+1,session_completed_spans=self.total_spans+1),"Per-bucket proposal provenance mismatch")
        view.completed+=1;view.rows+=count;self.total_spans+=1;self.total_rows+=count
        return dict(start=start,count=count,compact=compact,provenance=dict(kind="FRESH_UNTRUSTED_COMPACT_BUCKET_STREAM_GPU",header=header,footer=footer,
            receipt=c.rel(receipt),receipt_sha256=c.sha(receipt),origin=origin,GPU_generation_this_invocation=True,GPU_trusted=False,
            locked_manifest_sha256=view.manifest_sha256,fixed_locked_manifest_sha256=self.manifest_sha256,context_reused_across_buckets=True,
            payloads_persisted_or_hashed=False,all_payload_records_require_actual_Lean_checks=True))
    def leave(self,view):
        if self.active is not view:raise ValueError("Wrong bucket bank leave request")
        self.send(dict(leave_bucket=True));value=self.line()
        expected(value,dict(event="BUCKET_LEFT",schema=GPU_SCHEMA,session_token=self.token,generation=view.generation,
            layer=view.layer,honor=view.honor,identity_sha256=view.identity,completed_spans=view.completed,rows=view.rows,
            bucket_allocations_released=True,fixed_allocations_retained=True),"GPU bank not synchronously released")
        self.active=None;return value
    def close(self,abort=False):
        if self.closed:
            if not self.exit_confirmed:raise RuntimeError("Prior cross-bucket cleanup did not confirm OS exit")
            return
        self.closed=True;confirmed=False
        try:
            if self.p is not None and not abort and self.p.poll() is None:
                if self.active is not None:raise RuntimeError("Cannot cleanly stop a context with an unreleased bank")
                self.send(dict(stop=True));self.p.stdin.close()
                value=self.line();expected(value,dict(event="STOPPED",schema=GPU_SCHEMA,session_token=self.token,total_spans=self.total_spans,
                    total_rows=self.total_rows,bucket_generations=self.generation,GPU_context_closed=True),"Cross-bucket STOPPED accounting mismatch")
                if self.p.wait(timeout=15)!=0:raise ValueError("Cross-bucket GPU process returned failure")
        finally:
            try:stop_owned(self.pidfile);confirmed=True;self.exit_confirmed=True
            finally:
                if self.p is not None:
                    if self.p.poll() is None:self.p.kill();self.p.wait(timeout=15)
                    self.p.stdin.close();self.p.stdout.close()
                if self.log is not None:self.log.flush();os.fsync(self.log.fileno());self.log.close()
                with self.event_lock:self.events_log.flush();os.fsync(self.events_log.fileno());self.events_log.close()
                if self.input_lock is not None:self.input_lock.close()
                c.atomic(Path(str(self.base)+".session.json"),dict(schema="CROSS_BUCKET_CAMPAIGN_OWNED_GPU_CONTEXT_V6",total_spans=self.total_spans,
                    total_rows=self.total_rows,bucket_generations=self.generation,first_two_events=self.events,event_count=self.event_count,
                    events_jsonl=c.rel(self.events_path),events_sha256=c.sha(self.events_path),requested_abort=abort,
                    linux_process_exit_confirmed=confirmed,pidfile=c.rel(self.pidfile),fixed_manifest_sha256=self.manifest_sha256,
                    windows_client_confirmed_exited=self.p is None or self.p.poll() is not None,
                    stderr_sha256=c.sha(self.log_path) if self.log_path.exists() else None))

class CompactGPU:
    """One fresh bucket view on the invocation's fixed CUDA context."""
    def __init__(self,m,row,rt,locked):
        self.row=row;self.layer=row["layer"];self.honor=row["honor"];self.rt=rt;self.completed=0;self.rows=0;self.closed=False
        self.generation=None;self.identity=None;self.locked=dict(locked);self.input_lock=None
        if rt.cross_gpu is None:rt.cross_gpu=CrossGPU(m,rt)
        self.context=rt.cross_gpu
        self.base=Path(str(self.context.base)+f"_bucket_{self.context.generation+1:04}")
        self.manifest=Path(str(self.base)+".inputs.json")
        proposed_inputs=dict(self.locked)
        if m.get("fault_inject")=="bad_bucket_manifest":
            proposed_inputs[row["bits"]]=dict(bytes=locked[row["bits"]]["bytes"],sha256="0"*64)
        c.atomic(self.manifest,dict(schema="V4_READ_LOCKED_INPUT_DIGESTS",files=proposed_inputs))
        self.input_lock=c.ReadLocks([self.manifest]);self.manifest_sha256=c.sha(self.manifest)
    def ready(self):return self.context.enter(self)
    def span(self,start,count):return self.context.span(self,start,count)
    def close(self,abort=False):
        if self.closed:return
        self.closed=True
        try:
            if abort:self.context.close(abort=True)
            elif self.context.active is self:self.context.leave(self)
            elif self.generation is not None:raise ValueError("Bucket identity lost before releasing its locks")
        finally:
            if self.input_lock:self.input_lock.close()

class CompactNative:
    def __init__(self,m,n,h,rt):
        self.rt=rt;self.layer=n;self.honor=h;self.worker=m["worker"];self.completed=0;self.rows=0;self.events=[];self.closed=False;self.q=queue.Queue()
        directory=rt.f/"sessions";directory.mkdir(parents=True,exist_ok=True)
        self.log_path=directory/(c.stem(n,h)+f"_native_{time.time_ns()}.stderr.log");self.log=self.log_path.open("wb")
        r=c.ROOT/"runs/lean_table_checker"
        roots=[r/"summary_full_v1/inputs",r/"full_safe_local_v1/inputs",r/"canonical_inventory_resume_v1/inputs",c.INDEX,r/"successor_cache_v1/inputs",c.DATA,c.INDEX/"catalog.tsv"]
        argv=[str(c.rootpath(self.worker["executable"]))]+list(map(str,roots))+[str(n),str(h),str(m["threads"])]
        self.p=subprocess.Popen(argv,cwd=c.ROOT,stdin=subprocess.PIPE,stdout=subprocess.PIPE,stderr=self.log,
            creationflags=subprocess.CREATE_NO_WINDOW,env=dict(os.environ,PATH=str(c.legacy.a.TOOL)+os.pathsep+os.environ["PATH"]))
        def reader():
            try:
                while True:
                    raw=self.p.stdout.readline(1_000_001)
                    if not raw:break
                    if len(raw)>1_000_000:raise ValueError("Oversized native response")
                    self.q.put(json.loads(raw))
                self.q.put(None)
            except BaseException as e:self.q.put(e)
        self.reader=threading.Thread(target=reader,daemon=True);self.reader.start()
        try:expected(self.receive(),dict(event="READY",schema=NATIVE_SCHEMA,layer=n,honor=h,threads=m["threads"]),"Native READY scope mismatch")
        except BaseException:self.close(abort=True);raise
    def receive(self,closing=False):
        deadline=time.monotonic()+15 if closing else None
        while True:
            if not closing:
                if threading.current_thread() is threading.main_thread():self.rt.guard()
            elif time.monotonic()>=deadline:raise TimeoutError("Native did not stop within bounded cleanup")
            try:value=self.q.get(timeout=.05)
            except queue.Empty:continue
            if isinstance(value,BaseException):raise value
            if value is None:raise RuntimeError("Native exited without expected event")
            self.events.append(value);return value
    def span(self,packet,output,log):
        start,count=packet["start"],packet["count"]
        relative=paths.check(output)
        raw=(json.dumps(dict(transport=TRANSPORT,start=start,count=count,compact_bytes=count,output=relative))+"\n").encode()
        self.p.stdin.write(raw);view=memoryview(packet["compact"]);position=0
        while position<len(view):
            written=self.p.stdin.write(view[position:min(position+4*1024*1024,len(view))])
            if not written:raise EOFError("Native compact stdin made no progress")
            position+=written
        self.p.stdin.write(END);self.p.stdin.flush();value=self.receive()
        expected(value,dict(event="SPAN_DONE",schema=NATIVE_SCHEMA,start=start,count=count,completed_spans=self.completed+1),"Native exact span mismatch")
        if c.rootpath(value.get("output","")).resolve()!=output.resolve():raise ValueError("Native result path mismatch")
        self.completed+=1;self.rows+=count
        c.atomic(log,dict(ready=self.events[0],event=value,session_stderr=c.rel(self.log_path),ephemeral_compact_payload_untrusted=True))
        return value
    def close(self,abort=False):
        if self.closed:
            if self.p.poll() is None:raise RuntimeError("Previous compact native cleanup did not confirm process exit")
            return
        self.closed=True
        try:
            if not abort and self.p.poll() is None:
                self.p.stdin.write(b'{"stop":true}\n');self.p.stdin.flush();self.p.stdin.close()
                expected(self.receive(closing=True),dict(event="STOPPED",schema=NATIVE_SCHEMA,completed_spans=self.completed,checked_rows=self.rows),"Native STOPPED accounting mismatch")
                if self.p.wait(timeout=15)!=0:raise RuntimeError("Native compact checker exited unsuccessfully")
        finally:
            if self.p.poll() is None:self.p.kill();self.p.wait(timeout=15)
            self.p.stdin.close();self.p.stdout.close();self.reader.join(timeout=2);self.log.flush();os.fsync(self.log.fileno());self.log.close()
            c.atomic(self.log_path.with_suffix(".session.json"),dict(schema="COMPACT_CAMPAIGN_OWNED_NATIVE_SESSION_V4",worker_binding=self.worker,
                layer=self.layer,honor=self.honor,pid=self.p.pid,process_confirmed_exited=self.p.poll() is not None,returncode=self.p.returncode,
                completed_spans=self.completed,checked_rows=self.rows,requested_abort=abort,events=self.events,stderr_sha256=c.sha(self.log_path)))
