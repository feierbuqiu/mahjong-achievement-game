"""Untrusted indexed actual-next byte CUDA proposals with a fixed context across buckets.

SessionContext is an importable API. enter_bucket/propose/leave_bucket never
write stdout. The CLI adds JSONL and binary framing only. Every byte remains an untrusted proposal. The new Native must
check exactP128 or an actual successor-list position and source-r itself.
"""
from pathlib import Path
import argparse,ctypes as C,hashlib,importlib.util,json,os,signal,struct,sys,threading,time,uuid

BASE=Path(__file__).resolve().parent;ROOT=BASE.parents[2]
RUN=ROOT/"runs/lean_table_checker/gpu_indexed_byte_20261018_v16"
CAMPAIGNS=ROOT/"runs/lean_table_checker/campaign_indexed_byte_20261018_v16"
LEGACY=BASE.parent/"gpu_stream_v4/worker_compact.py"
LEGACY_SHA="fdffc1efcd34be5f700febb21934ade1a38c4a7bd544f4f5ebe8276c5c83865c"
PROTOCOL="GPU_CROSS_BUCKET_INDEXED_BYTE_PROTOCOL_V16"

def sha(path):
    with Path(path).open("rb") as f:return hashlib.file_digest(f,"sha256").hexdigest()

if sha(LEGACY)!=LEGACY_SHA:raise ValueError("The reused sealed CUDA transport helper changed")
spec=importlib.util.spec_from_file_location("_sealed_cross_bucket_compact_helpers",LEGACY)
old=importlib.util.module_from_spec(spec);spec.loader.exec_module(old)
# These modify only this private imported helper instance, never its file.
old.RUN=RUN;old.CAMPAIGNS=CAMPAIGNS;old.PROTOCOL=PROTOCOL
owned_path=old.owned_path;workspace_path=old.workspace_path;relative=old.relative;atomic=old.atomic;event=old.event
MAX_COUNT=67_108_864
SCRATCH_ROWS=8_388_608
IMPLEMENTATION_REVISION="INDEXED_ACTUAL_NEXT_BYTE_BOUNDED_8MI_SCRATCH_V16"
TRANSPORT="indexed_actual_next_byte_v16"
RECORD_BYTES=1
ORIGINAL_EVALUATE_SOURCE_SHA256="060508cfb0ffa8898d0e409e2d442e724ccf4408b81433056c9c37ed280cf566"
INDEXED_LAYOUT={'record_bytes': 1, 'P_exact': 128, 'N_less_than': 128, 'N_axis_divisor': 32, 'N_actual_next_list_index_modulus': 32, 'error': 255, 'source_coordinates_transmitted': False}
INDEXED_SUFFIX='\n// Untrusted1B proposal transport. Native derives source IDs and checks every row.\n// P is exactly128; N is32*axis+actual-next-list-index;255 always rejects.\nextern "C" __global__ void indexed_actual_next_rows(const U32* numeric,const U32* groups,\n    const U32* edges,const U32* honors,const Bucket* source,const Bucket* targets,\n    U32 ntarget,U64 start,U32 count,U32 mode,U8* output) {\n    U32 i=blockIdx.x*blockDim.x+threadIdx.x;\n    if(i>=count) return;\n    output[i]=255;\n    if(mode!=1 || source->honor>=184) return;\n    const U64 row=start+i;\n    Result result=evaluate(numeric,groups,edges,honors,*source,targets,ntarget,row,1);\n    if(result.flags==2) { output[i]=128; return; }\n    if(result.flags!=0 || result.move==~0U) return;\n    const U32 axis=result.move/131676;\n    const U32 actual_j=result.move%131676;\n    if(axis>=4 || actual_j>=131676 || (axis==3 && actual_j>=184)) return;\n    const U32* next=0;\n    U32 capacity=0;\n    if(axis<3) {\n        U32 ids[3];\n        if(!decode(*source,groups,row,ids)) return;\n        if(ids[0]>=131676 || ids[1]>=131676 || ids[2]>=131676) return;\n        next=edges+ids[axis]*11;\n        capacity=9;\n    } else {\n        next=honors+source->honor*6;\n        capacity=4;\n    }\n    const U32 length=next[1];\n    if(length>capacity || length>=32) return;\n    for(U32 index=0;index<length;++index) {\n        if(next[index+2]==actual_j) {\n            if(index>=32) return;\n            output[i]=U8(32*axis+index);\n            return;\n        }\n    }\n}\n'

def scratch_chunks(start,count,capacity):
    """Exact consecutive local launches; no table or CUDA work here."""
    for name,value in (("start",start),("count",count),("capacity",capacity)):
        if type(value) is not int:raise ValueError(name+" must be an integer")
    if start<0 or not 0<count<=MAX_COUNT or not 0<capacity<=SCRATCH_ROWS:
        raise ValueError("Invalid bounded scratch chunk extent")
    offset=0
    while offset<count:
        take=min(capacity,count-offset)
        yield start+offset,take,offset
        offset+=take



def configuration(*,index,fixed_manifest,fixed_manifest_sha256,pid_file,catalog=None,data=None,edges=None,
                  max_count=MAX_COUNT,device_cap_bytes=old.DEVICE_CAP,host_rss_cap_bytes=old.HOST_CAP):
    """Build the exact same arguments used by the CLI, without starting CUDA."""
    values=dict(index=index,fixed_manifest=fixed_manifest,fixed_manifest_sha256=fixed_manifest_sha256,pid_file=pid_file,
        catalog=catalog,data=data or ROOT/"runs/global_retro/pilot_v1/data",
        edges=edges or ROOT/"runs/lean_table_checker/successor_cache_v1/inputs",max_count=max_count,
        device_cap_bytes=device_cap_bytes,host_rss_cap_bytes=host_rss_cap_bytes)
    for name,maximum in (("max_count",MAX_COUNT),("device_cap_bytes",old.DEVICE_CAP),("host_rss_cap_bytes",old.HOST_CAP)):
        if not 0<old.integer(values[name],name)<=maximum:raise ValueError("Explicit bounded configuration required: "+name)
    return argparse.Namespace(**values)

def fixed_paths(args):
    index=workspace_path(args.index);edges=workspace_path(args.edges)
    catalog=workspace_path(args.catalog or index/"catalog.tsv")
    dependencies=old.OLD/"deps"
    receipt=json.loads((dependencies/"receipt.json").read_text())
    common=[index/"numeric.bin",index/"groups.bin",edges/"numeric.bin",edges/"honors.bin"]
    code=[Path(__file__),LEGACY,old.SOURCE_SCRIPT,old.SEAL,old.OLD/"gpu_benchmark.py",old.OLD/"rows.cu",dependencies/"receipt.json"]
    return common,catalog,code+[dependencies/name for name in receipt["files"]]

class SessionContext(old.Session):
    def __init__(self,args):
        self.args=args;self.driver=None;self.rss=None;self.owns_pid=False;self.closed=False;self.lock=threading.RLock()
        self.began=time.monotonic();self.active_seconds=0.;self.total_spans=0;self.total_rows=0;self.generation=0;self.source=None
        self.bucket_completed=0;self.cursor=None;self.frame_active=False;self.bucket_summaries=[]
        try:self._initialize(args)
        except BaseException as original:
            # Importing callers do not receive an object when __init__ raises.
            # Thus cleanup cannot be left solely to the CLI's outer finally.
            if self.owns_pid:
                try:self.close(reason="INITIALIZATION_FAILED: "+repr(original),failed=True)
                except BaseException as cleanup:raise RuntimeError("GPU initialization and exact context cleanup both failed: "+repr(cleanup)) from original
            elif self.rss is not None:self.rss.close()
            raise

    def _initialize(self,args):
        self.index=workspace_path(args.index);self.catalog=workspace_path(args.catalog or self.index/"catalog.tsv")
        self.data=workspace_path(args.data);self.edges=workspace_path(args.edges)
        self.pid_path=owned_path(args.pid_file)
        if self.pid_path.exists():raise ValueError("Preserve existing exact owned PID receipt")
        self.pid_path.parent.mkdir(parents=True,exist_ok=True)
        self.session_token=uuid.uuid4().hex
        self.owner=dict(schema="OWNED_CROSS_BUCKET_GPU_INDEXED_BYTE_PROCESS_V16",**old.proc_identity(os.getpid()),script=relative(__file__),
            script_sha256=sha(__file__),session_token=self.session_token,implementation_revision=IMPLEMENTATION_REVISION,
            launch_kind="CLI" if Path(sys.argv[0]).resolve()==Path(__file__).resolve() else "IMPORTED_API")
        with self.pid_path.open("x",encoding="utf-8") as f:json.dump(self.owner,f);f.flush();os.fsync(f.fileno())
        self.owns_pid=True;self.rss=old.RSSMonitor(args.host_rss_cap_bytes)
        self.fixed_resolver=old.DigestResolver(args.fixed_manifest,args.fixed_manifest_sha256)
        for name,expected in old.PINNED.items():
            if self.fixed_resolver.digest(ROOT/name)!=expected:raise ValueError("Sealed GPU dependency identity changed: "+name)
        self.common,self.catalog,code=fixed_paths(args)
        for path,size in zip(self.common,(131676*12,1104*8,131676*44,184*24)):
            if path.stat().st_size!=size:raise ValueError("Fixed compact input shape mismatch")
        self.fixed_bindings=self.fixed_resolver.bind(self.common+[self.catalog]+code)
        # All fixed files must be explicitly covered by Windows locks; a fixed
        # cache is never inferred merely because a path was seen previously.
        for path,value in self.fixed_bindings.items():
            if self.fixed_resolver.bindings.get(path)!=value:raise ValueError("Fixed context input is absent from the held Windows manifest: "+path)
        self.catalog_rows=old.parse_catalog(self.catalog)
        self.honor_bytes=self.common[3].read_bytes()
        self.fixed_hash_seconds=time.monotonic()-self.began
        self.gpu=old.import_module("_cross_fixed_cuda_driver",old.OLD/"gpu_benchmark.py")
        suffix=old.import_module("_cross_fixed_cuda_source",old.SOURCE_SCRIPT)
        suffix.sha=self.fixed_resolver.digest
        self.baseline_source_suffix_sha256=hashlib.sha256(suffix.SUFFIX.encode()).hexdigest();suffix.SUFFIX=INDEXED_SUFFIX
        self.ptx,self.fixed_nvrtc_seconds,self.combined_source_sha256=suffix.compile_source(self.gpu)
        outer=self
        class Driver(self.gpu.Driver):
            def allocate(self,size):
                outer.guard()
                if sum(n for _,n in self.allocations)+size>args.device_cap_bytes or outer.global_device_used+size>old.GLOBAL_DEVICE_CAP or outer.global_device_free-size<old.GLOBAL_DEVICE_FREE_RESERVE:
                    raise MemoryError("Fixed/bucket allocations exceed explicit device/global/free guards")
                return super().allocate(size)
            def upload_file(self,path):
                size=Path(path).stat().st_size;pointer=self.allocate(size)
                buffer=bytearray(min(old.TRANSFER_BYTES,size));view=(C.c_char*len(buffer)).from_buffer(buffer)
                with Path(path).open("rb",buffering=0) as f:
                    offset=0
                    while offset<size:
                        take=min(len(buffer),size-offset)
                        if f.readinto(memoryview(buffer)[:take])!=take:raise ValueError("Short streamed bucket input")
                        self.call("cuMemcpyHtoD_v2",pointer+offset,C.addressof(view),take);offset+=take;outer.guard()
                return pointer
        self.driver=Driver();self.driver.api.cuCtxSetCurrent.argtypes=[C.c_void_p]
        self.module=C.c_void_p();self.driver.call("cuModuleLoadData",C.byref(self.module),self.ptx)
        self.scan=C.c_void_p();self.driver.call("cuModuleGetFunction",C.byref(self.scan),self.module,b"indexed_actual_next_rows")
        began=time.monotonic()
        self.numeric,self.groups,self.numeric_edges,self.honor_edges=[self.driver.upload_file(p) for p in self.common]
        self.scratch_rows=min(args.max_count,SCRATCH_ROWS)
        self.output_pointer=self.driver.allocate(self.scratch_rows)
        self.fixed_allocation_count=len(self.driver.allocations);self.fixed_device_bytes=sum(n for _,n in self.driver.allocations)
        self.declared_device_bytes=self.fixed_device_bytes
        self.fixed_upload_seconds=time.monotonic()-began;self.guard()
        self.fixed_initialization_seconds=time.monotonic()-self.began
        self.fixed_identity=dict(schema="UNTRUSTED_FIXED_INDEXED_BYTE_CUDA_CONTEXT_V16",input_files=self.fixed_bindings,
            manifest_sha256=self.fixed_resolver.manifest_sha256,combined_source_sha256=self.combined_source_sha256,
            ptx_sha256=hashlib.sha256(self.ptx.raw).hexdigest(),indexed_byte_layout=INDEXED_LAYOUT,transport=TRANSPORT,record_bytes=RECORD_BYTES,max_count=args.max_count,
            original_evaluate_source_sha256=ORIGINAL_EVALUATE_SOURCE_SHA256,
            fixed_device_bytes=self.fixed_device_bytes,baseline_source_suffix_sha256=self.baseline_source_suffix_sha256,
            implementation_revision=IMPLEMENTATION_REVISION,scratch_rows=self.scratch_rows,
            device_output_scratch_bytes=self.scratch_rows,
            maximum_host_proposal_bytes=args.max_count)
        self.fixed_identity_sha256=hashlib.sha256(old.canonical_json(self.fixed_identity)).hexdigest()

    def _current(self):
        if self.closed or self.driver is None:raise ValueError("GPU context is closed")
        self.driver.call("cuCtxSetCurrent",self.driver.context)

    def ready(self):
        with self.lock:
            self._current();self.guard()
            return dict(event="SESSION_READY",schema=PROTOCOL,session_token=self.session_token,fixed_identity_sha256=self.fixed_identity_sha256,
                fixed_identity=self.fixed_identity,fixed_hash_seconds=self.fixed_hash_seconds,fixed_nvrtc_seconds=self.fixed_nvrtc_seconds,
                fixed_upload_seconds=self.fixed_upload_seconds,fixed_initialization_seconds=self.fixed_initialization_seconds,
                max_count=self.args.max_count,implementation_revision=IMPLEMENTATION_REVISION,
                transport=TRANSPORT,record_bytes=RECORD_BYTES,
                scratch_rows=self.scratch_rows,device_output_scratch_bytes=self.scratch_rows,
                resources=self.resources(),Lean_rows_verified=0)

    def _free_bucket_allocations(self):
        self._current();self.driver.call("cuCtxSynchronize")
        while len(self.driver.allocations)>self.fixed_allocation_count:
            pointer,_=self.driver.allocations[-1];self.driver.call("cuMemFree_v2",pointer);self.driver.allocations.pop()
        self.declared_device_bytes=self.fixed_device_bytes

    def enter_bucket(self,layer,honor,manifest,manifest_sha256):
        with self.lock:
            self._current()
            if self.source is not None:raise ValueError("Leave the previous bucket before entering another")
            layer=old.integer(layer,"layer");honor=old.integer(honor,"honor")
            if not 0<=layer<=34 or not 0<=honor<184:raise ValueError("Bucket outside original game inventory")
            began=time.monotonic();resolver=old.DigestResolver(manifest,manifest_sha256)
            source=self.catalog_rows.get((layer,honor))
            if source is None or not source["size"]:raise ValueError("Enter requires a nonempty actual bucket")
            local=struct.unpack_from("<6I",self.honor_bytes,honor*24)
            if local[0]!=source["code"] or local[1]>4 or any(h>=184 for h in local[2:2+local[1]]):raise ValueError("Honor inventory/catalog mismatch")
            needed={honor,*local[2:2+local[1]]}
            children=[self.catalog_rows[layer+1,h] for h in sorted(needed) if (layer+1,h) in self.catalog_rows and self.catalog_rows[layer+1,h]["size"]]
            for path in self.common+[self.catalog]:
                name=relative(path)
                if resolver.bindings.get(name)!=self.fixed_bindings[name]:raise ValueError("Fresh bucket manifest disagrees with fixed locked input: "+name)
            files=[];uploads=[]
            for row in [source]+children:
                add=old.bucket_files(self.index,self.data,row);files+=add;uploads+=add[:2]
            # Fresh resolver on every enter: labels and directories are never
            # served from the fixed cache, even if used by a prior bucket.
            bindings=resolver.bind(files)
            for path,value in bindings.items():
                if resolver.bindings.get(path)!=value:raise ValueError("Bucket file absent from fresh Windows locked manifest: "+path)
            hash_seconds=time.monotonic()-began
            declared=self.fixed_device_bytes+sum(p.stat().st_size for p in uploads)+32*(1+max(1,len(children)))
            if declared>self.args.device_cap_bytes:raise MemoryError("New bucket exceeds device cap before allocation")
            self.guard()
            if self.global_device_used+declared-self.fixed_device_bytes>old.GLOBAL_DEVICE_CAP or self.global_device_free-(declared-self.fixed_device_bytes)<old.GLOBAL_DEVICE_FREE_RESERVE:
                raise MemoryError("New bucket exceeds global GPU headroom before allocation")
            upload_began=time.monotonic()
            try:
                def load(row):
                    name=old.stem(row["n"],row["h"])
                    directory=self.driver.upload_file(self.index/(name+".dir"));bits=self.driver.upload_file(self.data/(name+".bits"))
                    return struct.pack("<QQQII",directory,bits,row["size"],row["blocks"],row["h"])
                source_pointer=self.driver.upload(load(source))
                targets_pointer=self.driver.upload(b"".join(load(r) for r in children) or bytes(32))
                self.guard()
            except BaseException:
                self._free_bucket_allocations();raise
            self.generation+=1;self.source,self.children,self.resolver=source,children,resolver
            self.source_pointer,self.targets_pointer=source_pointer,targets_pointer
            self.cursor=None;self.bucket_completed=0;self.bucket_rows=0;self.bucket_began=time.monotonic()
            self.declared_device_bytes=declared
            self.bucket_identity=dict(schema="UNTRUSTED_FRESH_INDEXED_BYTE_GPU_BUCKET_IDENTITY_V16",generation=self.generation,layer=layer,honor=honor,
                source=source,targets=children,input_files=bindings,locked_manifest_sha256=resolver.manifest_sha256,
                fixed_identity_sha256=self.fixed_identity_sha256,mode=1,record_bytes=RECORD_BYTES,transport=TRANSPORT)
            self.bucket_identity_sha256=hashlib.sha256(old.canonical_json(self.bucket_identity)).hexdigest()
            return dict(event="BUCKET_READY",schema=PROTOCOL,session_token=self.session_token,generation=self.generation,
                layer=layer,honor=honor,source_size=source["size"],identity_sha256=self.bucket_identity_sha256,
                bucket_identity=self.bucket_identity,hash_seconds=hash_seconds,upload_seconds=time.monotonic()-upload_began,
                bucket_enter_seconds=time.monotonic()-began,fixed_context_reused=True,resources=self.resources(),Lean_rows_verified=0)


    def resources(self):
        value=super().resources()
        value.update(implementation_revision=IMPLEMENTATION_REVISION,
            scratch_rows=getattr(self,"scratch_rows",min(self.args.max_count,SCRATCH_ROWS)),
            device_output_scratch_bytes=getattr(self,"scratch_rows",min(self.args.max_count,SCRATCH_ROWS)),
            maximum_proposal_rows=self.args.max_count,transport=TRANSPORT,record_bytes=RECORD_BYTES)
        return value

    def download_into(self,buffer,host_row_offset,count):
        """One byte per row. DtoH writes directly into one independent packet."""
        if type(host_row_offset) is not int or type(count) is not int or host_row_offset<0 or not 0<count<=self.scratch_rows:
            raise ValueError("Invalid bounded direct scratch download")
        if (host_row_offset+count)>C.sizeof(buffer):
            raise ValueError("Scratch download escaped independent host packet")
        copied=time.monotonic()
        destination=C.c_void_p(C.addressof(buffer)+host_row_offset)
        self.driver.call("cuMemcpyDtoH_v2",destination,self.output_pointer,count)
        self.guard()
        return time.monotonic()-copied

    def propose(self,start,count):
        """Return an independent host ctypes buffer plus untrusted metadata.

        The returned host buffer remains valid across later proposals/bucket
        changes. Callers must bound their queue; the CLI/controller use at most
        one current and one prefetched frame.
        """
        with self.lock:
            self._current();self.guard()
            if self.source is None:raise ValueError("No active bucket")
            start=old.integer(start,"start");count=old.integer(count,"count")
            if start<0 or not 0<count<=self.args.max_count or start+count>self.source["size"] or (self.cursor is not None and start!=self.cursor):raise ValueError("Proposal is outside exact consecutive bucket span")
            began=time.monotonic()
            allocated=time.monotonic()
            buffer=C.create_string_buffer(count)
            host_allocation_seconds=time.monotonic()-allocated
            self.guard()
            chunks=[];kernel=0.;copied=0.
            for chunk_start,take,offset in scratch_chunks(start,count,self.scratch_rows):
                self.guard();chunk_began=time.monotonic()
                values=[C.c_uint64(x) for x in (self.numeric,self.groups,self.numeric_edges,self.honor_edges,self.source_pointer,self.targets_pointer)]
                values += [C.c_uint32(len(self.children)),C.c_uint64(chunk_start),C.c_uint32(take),C.c_uint32(1),C.c_uint64(self.output_pointer)]
                chunk_kernel=self.launch(self.scan,values,take)
                chunk_copy=self.download_into(buffer,offset,take)
                kernel+=chunk_kernel;copied+=chunk_copy
                chunks.append(dict(start=chunk_start,count=take,host_row_offset=offset,
                    host_byte_offset=offset,compact_bytes=take,indexed_bytes=take,
                    kernel_seconds=chunk_kernel,copy_seconds=chunk_copy,
                    enclosing_chunk_wall_seconds=time.monotonic()-chunk_began))
            if sum(x["count"] for x in chunks)!=count or chunks[-1]["start"]+chunks[-1]["count"]!=start+count:
                raise ValueError("Incomplete scratch proposal")
            self.guard()
            self.cursor=start+count;self.bucket_completed+=1;self.total_spans+=1;self.bucket_rows+=count;self.total_rows+=count
            meta=dict(schema="UNTRUSTED_CROSS_BUCKET_INDEXED_BYTE_PROPOSAL_V16",status="STREAMED_NOT_LEAN_CERTIFIED",session_token=self.session_token,
                generation=self.generation,layer=self.source["n"],honor=self.source["h"],start=start,count=count,
                identity_sha256=self.bucket_identity_sha256,fixed_identity_sha256=self.fixed_identity_sha256,
                locked_manifest_sha256=self.resolver.manifest_sha256,completed_spans=self.bucket_completed,session_completed_spans=self.total_spans,
                compact_bytes=count,indexed_bytes=count,transport=TRANSPORT,record_bytes=RECORD_BYTES,endianness="little",mode=1,
                combined_kernel_seconds=kernel,copy_seconds=copied,proposal_work_seconds=time.monotonic()-began,
                implementation_revision=IMPLEMENTATION_REVISION,scratch_rows=self.scratch_rows,
                device_output_scratch_bytes=self.scratch_rows,actual_chunk_count=len(chunks),chunks=chunks,
                host_allocation_seconds=host_allocation_seconds,
                copy_timing_policy="SUM_CHUNK_DTOH_AND_GUARD_WALL_HOST_ALLOCATION_SEPARATE",
                host_output_buffer_allocations=1,intermediate_chunk_host_buffers=0,
                payload_saved_to_disk=False,payload_hashed=False,GPU_trusted_for_soundness=False,Lean_rows_verified=0,
                source_coordinates_transmitted=False,native_actual_next_membership_required=True,
                native_actual_source_r_guard_required=True,gpu_flags_trusted=False,
                per_row_timing_or_sampling_added=False,
                process_owner=self.owner,resources=self.resources())
            return buffer,meta

    def leave_bucket(self):
        with self.lock:
            self._current()
            if self.source is None:raise ValueError("No active bucket to leave")
            began=time.monotonic();layer,honor=self.source["n"],self.source["h"]
            generation=self.generation;identity=self.bucket_identity_sha256
            self._free_bucket_allocations();self.source=None;self.children=[];self.resolver=None;self.cursor=None
            value=dict(event="BUCKET_LEFT",schema=PROTOCOL,session_token=self.session_token,generation=generation,layer=layer,honor=honor,
                identity_sha256=identity,completed_spans=self.bucket_completed,rows=self.bucket_rows,
                bucket_allocations_released=True,fixed_allocations_retained=True,leave_seconds=time.monotonic()-began,resources=self.resources())
            self.bucket_summaries.append(value)
            return value

    def close(self,reason="EOF",failed=False):
        if self.closed:return
        with self.lock:
            cleanup_failure=None
            if self.driver is not None:
                try:
                    self._current()
                    try:self.driver.call("cuCtxSynchronize")
                    finally:self.driver.close();self.driver=None
                except BaseException as error:cleanup_failure=error
            self.closed=self.driver is None
            if self.rss is not None:self.rss.close()
            value=dict(schema="CROSS_BUCKET_GPU_INDEXED_BYTE_CONTEXT_CLOSED_V16",owner=self.owner,reason=reason,failed=failed,
                total_spans=self.total_spans,total_rows=self.total_rows,bucket_generations=self.generation,
                GPU_context_closed=self.driver is None,cleanup_error=None if cleanup_failure is None else repr(cleanup_failure),OS_process_exit_must_be_confirmed_by_controller=True,
                session_wall_including_idle_seconds=time.monotonic()-self.began,resources=self.resources(),Lean_rows_verified=0)
            if self.owns_pid:atomic(self.pid_path.with_name(self.pid_path.name+".closed.json"),value)
            if cleanup_failure:raise cleanup_failure
            return value

def emit(value):
    sys.stdout.buffer.write((json.dumps(value,sort_keys=True)+"\n").encode());sys.stdout.buffer.flush()

def span_cli(session,request):
    start,count,out=old.check_span(request,session.source["size"] if session.source else 0,session.args.max_count,session.cursor)
    out.mkdir(parents=True,exist_ok=True);receipt=out/"receipt.json"
    if receipt.exists():raise ValueError("Use a new owned proposal receipt path")
    buffer,meta=session.propose(start,count);common={k:meta[k] for k in ("session_token","generation","layer","honor","start","count","identity_sha256","fixed_identity_sha256","completed_spans","session_completed_spans","compact_bytes","indexed_bytes","transport","record_bytes","endianness")}
    session.frame_active=True;emit(dict(event="PAYLOAD",schema=PROTOCOL,**common))
    began=time.monotonic();session.write_payload(buffer);del buffer
    meta["stdout_transfer_seconds"]=time.monotonic()-began;atomic(receipt,meta)
    emit(dict(event="PROPOSED",schema=PROTOCOL,**common,receipt=str(receipt),receipt_sha256=sha(receipt)))
    session.frame_active=False

def run(args):
    if sys.platform!="linux":raise ValueError("Actual context requires WSL/Linux")
    if not 0<args.max_count<=MAX_COUNT or not 0<args.device_cap_bytes<=old.DEVICE_CAP or not 0<args.host_rss_cap_bytes<=old.HOST_CAP:raise ValueError("Explicit original GPU/host limits required")
    session=SessionContext.__new__(SessionContext);failed=False;reason="EOF"
    def interrupted(signum,frame):raise old.StopRequested("SIGNAL_"+str(signum))
    signal.signal(signal.SIGTERM,interrupted);signal.signal(signal.SIGINT,interrupted)
    try:
        session.__init__(args);emit(session.ready())
        while True:
            raw=sys.stdin.readline(1_000_001)
            if not raw:break
            if len(raw)>1_000_000:raise ValueError("Oversized cross-bucket request")
            value=json.loads(raw)
            if value=={"stop":True}:reason="STOP_COMMAND";break
            if value=={"leave_bucket":True}:emit(session.leave_bucket());continue
            if isinstance(value,dict) and set(value)=={"enter_bucket"}:
                enter=value["enter_bucket"]
                if not isinstance(enter,dict) or set(enter)!={"layer","honor","manifest","manifest_sha256"}:raise ValueError("Exact enter-bucket request required")
                emit(session.enter_bucket(**enter));continue
            span_cli(session,value)
    except BaseException as error:
        reason=repr(error);failed=not isinstance(error,old.StopRequested) or bool(getattr(session,"frame_active",False))
        print(json.dumps(dict(event="ERROR",schema=PROTOCOL,error=reason,Lean_rows_verified=0)),file=sys.stderr,flush=True)
    finally:
        signal.signal(signal.SIGTERM,signal.SIG_IGN);signal.signal(signal.SIGINT,signal.SIG_IGN)
        if getattr(session,"owns_pid",False):
            try:
                record=session.close(reason,failed)
                if not failed:emit(dict(event="STOPPED",schema=PROTOCOL,session_token=session.session_token,**{k:record[k] for k in ("total_spans","total_rows","bucket_generations","GPU_context_closed")}))
            except BaseException as error:failed=True;print(repr(error),file=sys.stderr,flush=True)
    return 1 if failed else 0

def main():
    p=argparse.ArgumentParser()
    for key in ("index","fixed-manifest","fixed-manifest-sha256","pid-file"):p.add_argument("--"+key,required=True)
    p.add_argument("--catalog");p.add_argument("--data",default=str(ROOT/"runs/global_retro/pilot_v1/data"));p.add_argument("--edges",default=str(ROOT/"runs/lean_table_checker/successor_cache_v1/inputs"))
    p.add_argument("--max-count",type=int,default=MAX_COUNT);p.add_argument("--device-cap-bytes",type=int,default=old.DEVICE_CAP);p.add_argument("--host-rss-cap-bytes",type=int,default=old.HOST_CAP)
    return run(p.parse_args())

if __name__=="__main__":raise SystemExit(main())
