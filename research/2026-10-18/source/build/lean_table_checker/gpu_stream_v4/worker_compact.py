"""Compact binary stdout transport; every GPU record is untrusted by Lean.

The immutable CUDA rows plus a new compact suffix share one PTX/module/context.
Windows must hold exact input and digest-manifest read locks until the native
consumer has finished.  A manifest is an IO provenance assertion, not a proof
of GPU correctness.  This process never issues a formal certification receipt.
"""
from pathlib import Path
import argparse
import ctypes as C
import hashlib
import importlib.util
import json
import os
import signal
import struct
import sys
import threading
import time

BASE = Path(__file__).resolve().parent
ROOT = BASE.parents[2]
RUN = ROOT / "runs/lean_table_checker/gpu_stream_20261018_v4"
CAMPAIGNS = ROOT / "runs/lean_table_checker/campaign_20261018_v4"
OLD = BASE.parent / "gpu_spike_v1"
SOURCE_SCRIPT = BASE.parent / "cached_checker_v2/gpu_source_packets.py"
PROTOCOL = "GPU_COMPACT_STREAM_PROTOCOL_V4"
MAX_COUNT = 8_388_608
DEVICE_CAP = 6_000_000_000
GLOBAL_DEVICE_CAP = 7_000_000_000
GLOBAL_DEVICE_FREE_RESERVE = 1_000_000_000
HOST_CAP = 3_000_000_000
TRANSFER_BYTES = 32 * 1024 * 1024
MIN_REUSE_BYTES = 1_048_576
SEAL = ROOT / "runs/lean_table_checker/gpu_spike_20261018_v1/acceptance.json"
COMPACT_SUFFIX = '\n// Untrusted proposal transport only. Native Lean checks every decoded row.\n// coords A/B/C:12 bits each; b:2; actual j:18; Pflag:1; reserved:7.\nextern "C" __global__ void compact_rows(const U32* numeric,const U32* groups,\n    const U32* edges,const U32* honors,const Bucket* source,const Bucket* targets,\n    U32 ntarget,U64 start,U32 count,U32 mode,U64* output) {\n    U32 i=blockIdx.x*blockDim.x+threadIdx.x;\n    if(i>=count) return;\n    const U64 error=U64(1)<<63;\n    if(mode!=1) { output[i]=error; return; }\n    U64 row=start+i;\n    Result result=evaluate(numeric,groups,edges,honors,*source,targets,ntarget,row,1);\n    if(result.flags!=0 && result.flags!=2) { output[i]=error; return; }\n    U32 ids[3];\n    if(!decode(*source,groups,row,ids)) { output[i]=error; return; }\n    if(ids[0]>=131676 || ids[1]>=131676 || ids[2]>=131676) {\n        output[i]=error; return;\n    }\n    U32 a=numeric[ids[0]*3+2],b=numeric[ids[1]*3+2],c=numeric[ids[2]*3+2];\n    if(a>=4096 || b>=4096 || c>=4096) { output[i]=error; return; }\n    U32 isP=(result.flags>>1)&1,slot=0,j=0;\n    if(!isP) {\n        if(result.move==~0U) { output[i]=error; return; }\n        slot=result.move/131676; j=result.move%131676;\n        if(slot>=4 || j>=131676 || (slot==3 && j>=184)) {\n            output[i]=error; return;\n        }\n    }\n    output[i]=U64(a)|(U64(b)<<12)|(U64(c)<<24)|(U64(slot)<<36)|\n        (U64(j)<<38)|(U64(isP)<<56);\n}\n'
COMPACT_LAYOUT = {"coord_a": [0,11], "coord_b": [12,23], "coord_c": [24,35], "slot": [36,37], "actual_j": [38,55], "Pflag": [56,56], "reserved_zero": [57,63]}
PINNED = {
    "build/lean_table_checker/gpu_spike_v1/gpu_benchmark.py": "57ef41eee392b67c82cc8a7687b6944cdb61aee8999f60f44d276ab93111d066",
    "build/lean_table_checker/gpu_spike_v1/rows.cu": "060508cfb0ffa8898d0e409e2d442e724ccf4408b81433056c9c37ed280cf566",
    "build/lean_table_checker/gpu_spike_v1/deps/receipt.json": "fd886dcec753f4be5d5c9db8cea475895661cb39f624fb8b3f9b46065ef395de",
    "build/lean_table_checker/cached_checker_v2/gpu_source_packets.py": "c88ad619b3cbf9bef581caa9b987d0e39cce37385ce40f6035d2ab63b11535e2",
    "runs/lean_table_checker/gpu_spike_20261018_v1/acceptance.json": "268182262b09a773827266685fec4054d5f1ca28ed8c6a5558d64b0790a2d063",
}


def sha(path):
    with Path(path).open("rb") as stream:
        return hashlib.file_digest(stream, "sha256").hexdigest()


def canonical_json(value):
    return json.dumps(value, sort_keys=True, separators=(",", ":")).encode()


def relative(path):
    return Path(path).resolve().relative_to(ROOT).as_posix()


def owned_path(path):
    result = Path(path).resolve()
    if not any(result.is_relative_to(root.resolve()) and result != root.resolve()
               for root in (RUN, CAMPAIGNS)):
        raise ValueError("Output/PID paths must be inside the new owned v4 run")
    return result


def workspace_path(path):
    result = Path(path).resolve()
    if not result.is_relative_to(ROOT):
        raise ValueError("Input path is outside the research workspace")
    return result


def atomic(path, value):
    path = Path(path)
    path.parent.mkdir(parents=True, exist_ok=True)
    temporary = path.with_name(path.name + ".tmp")
    raw = value if isinstance(value, bytes) else (json.dumps(value, sort_keys=True, indent=2) + "\n").encode()
    with temporary.open("wb") as stream:
        stream.write(raw)
        stream.flush()
        os.fsync(stream.fileno())
    os.replace(temporary, path)


def event(name, **fields):
    value = dict(event=name, schema=PROTOCOL, **fields)
    if name == "ERROR":
        print(json.dumps(value, sort_keys=True), file=sys.stderr, flush=True)
        return
    raw = (json.dumps(value, sort_keys=True) + "\n").encode()
    sys.stdout.buffer.write(raw)
    sys.stdout.buffer.flush()


def integer(value, name):
    if isinstance(value, bool) or not isinstance(value, int):
        raise ValueError(name + " must be an integer")
    return value


class DigestResolver:
    """Only an exact canonical listed path and matching size can reuse a digest."""
    def __init__(self, path, expected):
        self.path = owned_path(path)
        if sha(self.path) != expected:
            raise ValueError("Locked manifest SHA mismatch")
        self.manifest_sha256 = expected
        value = json.loads(self.path.read_text(encoding="utf-8"))
        if value.get("schema") == "V4_READ_LOCKED_INPUT_DIGESTS":
            bindings = value["files"]
        elif value.get("schema") == "WINDOWS_HASHED_AND_READ_LOCKED_GPU_INPUTS_V3" and value.get("read_locks_held_through_native_completion") is True:
            bindings = value["input_files"]
        else:
            raise ValueError("Expected an exact Windows read-locked input manifest")
        if not isinstance(bindings, dict):
            raise ValueError("Manifest files must be a mapping")
        for name, item in bindings.items():
            candidate = (ROOT / name).resolve()
            if not candidate.is_relative_to(ROOT) or name != relative(candidate):
                raise ValueError("Manifest path must be exact canonical ROOT-relative")
            if not isinstance(item, dict) or integer(item["bytes"], "file size") < 0:
                raise ValueError("Invalid manifest byte length")
            digest = item["sha256"]
            if not isinstance(digest, str) or len(digest) != 64 or any(c not in "0123456789abcdef" for c in digest):
                raise ValueError("Invalid manifest SHA")
        self.bindings, self.used, self.cached = bindings, {}, {}

    def digest(self, path):
        path = Path(path).resolve()
        if path in self.cached:
            return self.cached[path]
        try:
            name = relative(path)
        except ValueError:
            return sha(path)
        item = self.bindings.get(name)
        if item is not None and item["bytes"] >= MIN_REUSE_BYTES:
            if path.stat().st_size != item["bytes"]:
                raise ValueError("Read-locked input size changed: " + name)
            digest = item["sha256"]
            self.used[name] = dict(item)
        else:
            digest = sha(path)
            if item is not None and (path.stat().st_size != item["bytes"] or digest != item["sha256"]):
                raise ValueError("Listed small input differs from locked digest: " + name)
        self.cached[path] = digest
        return digest

    def bind(self, paths):
        return {relative(p): dict(bytes=Path(p).stat().st_size, sha256=self.digest(p))
                for p in sorted(set(Path(p).resolve() for p in paths))}


def parse_catalog(path):
    rows = {}
    for line in Path(path).read_text(encoding="utf-8-sig").splitlines():
        if not line.strip():
            continue
        n, h, code, size, blocks = map(int, line.split())
        if not (0 <= n <= 34 and 0 <= h < 184 and 0 <= code < 78125 and
                0 <= size < 2**64 and 0 <= blocks < 2**32 and (size == 0) == (blocks == 0)):
            raise ValueError("Invalid full catalog row")
        if (n, h) in rows:
            raise ValueError("Duplicate catalog bucket")
        rows[n, h] = dict(n=n, h=h, code=code, size=size, blocks=blocks)
    return rows


def stem(n, h):
    return f"n{n:02}_h{h:03}"


def bucket_files(index, data, row):
    name = stem(row["n"], row["h"])
    directory, bits = index / (name + ".dir"), data / (name + ".bits")
    if directory.stat().st_size != row["blocks"] * 32 or bits.stat().st_size != ((row["size"] + 63) // 64) * 8:
        raise ValueError("Actual bucket length mismatch: " + name)
    metadata = data / (name + ".complete.json")
    files = [directory, bits]
    if metadata.exists():
        value = json.loads(metadata.read_text(encoding="utf-8-sig"))
        for key, expected in dict(completed=True, n=row["n"], h=row["h"], states=row["size"], honor_code=row["code"], index_fingerprint="5a45ff3ea0fcf356").items():
            if value.get(key) != expected:
                raise ValueError("Actual metadata mismatch: " + name)
        files.append(metadata)
    return files


def check_span(request, source_size, maximum, cursor):
    if not isinstance(request, dict) or set(request) != {"start", "count", "output_root"}:
        raise ValueError("A span requires exactly start/count/output_root")
    start, count = integer(request["start"], "start"), integer(request["count"], "count")
    if start < 0 or not 0 < count <= maximum or start + count > source_size:
        raise ValueError("Span exceeds the actual bucket or bounded 8M limit")
    if cursor is not None and start != cursor:
        raise ValueError("Resident spans must be consecutive and unique")
    return start, count, owned_path(request["output_root"])


def proc_identity(pid):
    path = Path("/proc") / str(pid)
    text = (path / "stat").read_text().rsplit(")", 1)[1].split()
    return dict(pid=pid, start_ticks=int(text[19]), process_state=text[0])


class RSSMonitor:
    def __init__(self, cap):
        self.cap, self.peak, self.current = cap, 0, 0
        self.done = threading.Event()
        self.thread = threading.Thread(target=self.watch, daemon=True)
        self.thread.start()

    def sample(self):
        for line in Path("/proc/self/status").read_text().splitlines():
            if line.startswith("VmRSS:"):
                self.current = int(line.split()[1]) * 1024
                self.peak = max(self.peak, self.current)
                return

    def watch(self):
        while not self.done.wait(.05):
            try:
                self.sample()
            except OSError:
                return

    def check(self):
        self.sample()
        if self.peak > self.cap:
            raise MemoryError("GPU host process exceeded its explicit RSS budget")

    def close(self):
        self.done.set()
        self.thread.join(timeout=1)


def import_module(name, path):
    spec = importlib.util.spec_from_file_location(name, path)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


class Session:
    def __init__(self, args):
        self.args, self.driver, self.rss = args, None, None
        self.completed, self.generated, self.rows, self.cursor = 0, 0, 0, None
        self.began, self.active_seconds = time.monotonic(), 0.0
        self.index = workspace_path(args.index)
        self.catalog = workspace_path(args.catalog or self.index / "catalog.tsv")
        self.data = workspace_path(args.data)
        self.edges = workspace_path(args.edges)
        self.pid_path = owned_path(args.pid_file)
        if self.pid_path.exists():
            raise ValueError("Preserve existing PID ownership receipt; controller must confirm old exit first")
        self.pid_path.parent.mkdir(parents=True, exist_ok=True)
        owner = dict(schema="OWNED_GPU_STREAM_PROCESS_V4", **proc_identity(os.getpid()),
                     script=relative(__file__), script_sha256=sha(__file__),
                     layer=args.layer, honor=args.honor)
        with self.pid_path.open("x", encoding="utf-8") as stream:
            self.owner, self.owns_pid = owner, True
            json.dump(self.owner, stream)
            stream.flush()
            os.fsync(stream.fileno())
        self.rss = RSSMonitor(args.host_rss_cap_bytes)
        self.resolver = DigestResolver(args.manifest, args.manifest_sha256)
        for name, expected in PINNED.items():
            if self.resolver.digest(ROOT / name) != expected:
                raise ValueError("Frozen GPU source/library receipt changed: " + name)
        rows = parse_catalog(self.catalog)
        self.source = rows.get((args.layer, args.honor))
        if self.source is None or self.source["size"] == 0:
            raise ValueError("Source must be an actual nonempty catalog bucket")
        honor_path = self.edges / "honors.bin"
        if honor_path.stat().st_size != 184 * 24:
            raise ValueError("Honor cache length mismatch")
        local = struct.unpack_from("<6I", honor_path.read_bytes(), args.honor * 24)
        if local[0] != self.source["code"] or local[1] > 4 or any(x >= 184 for x in local[2:2+local[1]]):
            raise ValueError("Actual honor cache/catalog mismatch")
        needed = {args.honor, *local[2:2+local[1]]}
        self.children = [rows[args.layer+1, h] for h in sorted(needed)
                         if (args.layer+1, h) in rows and rows[args.layer+1, h]["size"]]
        common = [self.index / "numeric.bin", self.index / "groups.bin", self.edges / "numeric.bin", honor_path]
        for path, size in zip(common, (131676*12, 1104*8, 131676*44, 184*24)):
            if path.stat().st_size != size:
                raise ValueError("Numeric/cache length mismatch: " + relative(path))
        files = common + [self.catalog, Path(__file__), SOURCE_SCRIPT, SEAL,
                          OLD / "gpu_benchmark.py", OLD / "rows.cu", OLD / "deps/receipt.json"]
        upload_files = list(common)
        for row in [self.source] + self.children:
            additions = bucket_files(self.index, self.data, row)
            files.extend(additions)
            upload_files.extend(additions[:2])
        dep_receipt = json.loads((OLD / "deps/receipt.json").read_text())
        files.extend(OLD / "deps" / name for name in dep_receipt["files"])
        self.bindings = self.resolver.bind(files)
        self.hash_seconds = time.monotonic() - self.began
        # Reserve one compact 8-byte-per-row output; no 16B temporary result.
        self.declared_device_bytes = sum(p.stat().st_size for p in set(upload_files)) + args.max_count*8 + 32*(2+len(self.children))
        if self.declared_device_bytes > args.device_cap_bytes:
            raise MemoryError("Actual bucket plus reusable output exceeds the 6GB device budget")
        self.rss.check()
        self.gpu = import_module("sealed_resident_gpu_helpers", OLD / "gpu_benchmark.py")
        source_gpu = import_module("sealed_resident_source_suffix", SOURCE_SCRIPT)
        # Dependency checks still compare their exact pinned digests.  The same
        # manifest resolver merely avoids hashing an identical locked file twice.
        source_gpu.sha = self.resolver.digest
        compile_began = time.monotonic()
        self.baseline_source_suffix_sha256 = hashlib.sha256(source_gpu.SUFFIX.encode()).hexdigest()
        source_gpu.SUFFIX = COMPACT_SUFFIX
        self.ptx, self.nvrtc_seconds, self.combined_source_sha256 = source_gpu.compile_source(self.gpu)
        self.ptx_sha256 = hashlib.sha256(self.ptx.raw).hexdigest()
        self.source_suffix_sha256 = hashlib.sha256(source_gpu.SUFFIX.encode()).hexdigest()
        # Reuse the pinned driver's CUDA calls and resource budget, but stream
        # file uploads in bounded chunks rather than mapping GB files into RSS.
        outer = self

        class StreamingDriver(self.gpu.Driver):
            def allocate(self, size):
                outer.guard()
                if sum(n for _, n in self.allocations)+size > args.device_cap_bytes or outer.global_device_used+size > GLOBAL_DEVICE_CAP or outer.global_device_free-size < GLOBAL_DEVICE_FREE_RESERVE:
                    raise MemoryError("Requested allocation exceeds explicit6GB/global7GB/oneGB-free budgets")
                return super().allocate(size)

            def upload_file(self, path):
                size = Path(path).stat().st_size
                pointer = self.allocate(size)
                buffer = bytearray(min(TRANSFER_BYTES, size))
                view = (C.c_char * len(buffer)).from_buffer(buffer)
                with Path(path).open("rb", buffering=0) as stream:
                    offset = 0
                    while offset < size:
                        take = min(len(buffer), size-offset)
                        got = stream.readinto(memoryview(buffer)[:take])
                        if got != take:
                            raise ValueError("Short streamed GPU input upload")
                        self.call("cuMemcpyHtoD_v2", pointer+offset, C.addressof(view), take)
                        offset += take
                        outer.guard()
                return pointer

        self.driver = StreamingDriver()
        self.module = C.c_void_p()
        self.driver.call("cuModuleLoadData", C.byref(self.module), self.ptx)
        self.scan = C.c_void_p()
        self.driver.call("cuModuleGetFunction", C.byref(self.scan), self.module, b"compact_rows")
        self.guard()
        if self.global_device_used+self.declared_device_bytes > GLOBAL_DEVICE_CAP or self.global_device_free-self.declared_device_bytes < GLOBAL_DEVICE_FREE_RESERVE:
            raise MemoryError("Actual resident bank plus output cannot fit global7GB and oneGB-free budgets")
        upload_began = time.monotonic()
        self.numeric, self.groups, self.numeric_edges, self.honor_edges = [self.driver.upload_file(p) for p in common]

        def load(row):
            name = stem(row["n"], row["h"])
            directory = self.driver.upload_file(self.index / (name + ".dir"))
            bits = self.driver.upload_file(self.data / (name + ".bits"))
            return struct.pack("<QQQII", directory, bits, row["size"], row["blocks"], row["h"])

        self.source_pointer = self.driver.upload(load(self.source))
        descriptors = b"".join(load(row) for row in self.children)
        self.targets_pointer = self.driver.upload(descriptors or bytes(32))
        self.output_pointer = self.driver.allocate(args.max_count*8)
        self.upload_seconds = time.monotonic()-upload_began
        self.guard()
        self.initialization_seconds = time.monotonic()-self.began
        self.active_seconds = self.initialization_seconds
        self.identity = dict(schema="UNTRUSTED_GPU_COMPACT_BUCKET_IDENTITY_V4", layer=args.layer, honor=args.honor,
                             source=self.source, targets=self.children, input_files=self.bindings,
                             locked_manifest_sha256=self.resolver.manifest_sha256,
                             combined_source_sha256=self.combined_source_sha256,
                             source_suffix_sha256=self.source_suffix_sha256,
                             CUDA_rows_sha256=PINNED["build/lean_table_checker/gpu_spike_v1/rows.cu"],
                             ptx_sha256=self.ptx_sha256, mode=1, record_bytes=8,
                             compact_layout=COMPACT_LAYOUT,
                             baseline_source_suffix_sha256=self.baseline_source_suffix_sha256)
        self.identity_sha256 = hashlib.sha256(canonical_json(self.identity)).hexdigest()
        self.provenance = dict(identity=self.identity, identity_sha256=self.identity_sha256,
                               input_digest_reuse=self.resolver.used, Windows_read_locks_required_through_native=True,
                               GPU_trusted_for_soundness=False, Lean_rows_verified=0)
        event("READY", layer=args.layer, honor=args.honor, source_size=self.source["size"], max_count=args.max_count,
              identity_sha256=self.identity_sha256, initialization_seconds=self.initialization_seconds,
              hash_seconds=self.hash_seconds, nvrtc_seconds=self.nvrtc_seconds, upload_seconds=self.upload_seconds,
              cold_work_in_READY=True, resources=self.resources(), provenance=self.provenance)

    def resources(self):
        allocated = sum(size for _, size in self.driver.allocations) if self.driver is not None else 0
        return dict(allocated_device_bytes=allocated, declared_device_bytes=getattr(self, "declared_device_bytes", 0),
                    device_cap_bytes=self.args.device_cap_bytes, global_device_cap_bytes=GLOBAL_DEVICE_CAP, global_device_free_reserve_bytes=GLOBAL_DEVICE_FREE_RESERVE, global_device_used_bytes=getattr(self, "global_device_used", None),
                    peak_host_rss_bytes=self.rss.peak if self.rss else 0,
                    host_rss_cap_bytes=self.args.host_rss_cap_bytes,
                    streamed_input_buffer_bytes=TRANSFER_BYTES, GPU_context_closed=self.driver is None)

    def guard(self):
        self.rss.check()
        if self.driver is not None:
            free, total = C.c_size_t(), C.c_size_t()
            self.driver.call("cuMemGetInfo_v2", C.byref(free), C.byref(total))
            self.global_device_used = total.value-free.value
            self.global_device_free = free.value
            if sum(size for _, size in self.driver.allocations) > self.args.device_cap_bytes or self.global_device_used > GLOBAL_DEVICE_CAP or self.global_device_free < GLOBAL_DEVICE_FREE_RESERVE:
                raise MemoryError("Explicit6GB/global7GB/oneGB-free device guard rejected; global usage includes other apps")

    def launch(self, function, values, count):
        parameters = (C.c_void_p*len(values))(*(C.cast(C.byref(value), C.c_void_p) for value in values))
        event0, event1 = C.c_void_p(), C.c_void_p()
        self.driver.call("cuEventCreate", C.byref(event0), 0)
        self.driver.call("cuEventCreate", C.byref(event1), 0)
        try:
            self.driver.call("cuEventRecord", event0, None)
            self.driver.call("cuLaunchKernel", function, (count+127)//128, 1, 1, 128, 1, 1, 0, None, parameters, None)
            self.driver.call("cuEventRecord", event1, None)
            self.driver.call("cuEventSynchronize", event1)
            milliseconds = C.c_float()
            self.driver.call("cuEventElapsedTime", C.byref(milliseconds), event0, event1)
            return milliseconds.value/1000
        finally:
            self.driver.call("cuEventDestroy_v2", event0)
            self.driver.call("cuEventDestroy_v2", event1)

    def download_output(self, count):
        copied = time.monotonic()
        buffer = C.create_string_buffer(count*8)
        self.driver.call("cuMemcpyDtoH_v2", buffer, self.output_pointer, count*8)
        self.guard()
        return buffer, time.monotonic()-copied

    def write_payload(self, buffer):
        view = memoryview(buffer).cast("B")
        offset = 0
        while offset < len(view):
            take = min(8*1024*1024, len(view)-offset)
            written = sys.stdout.buffer.write(view[offset:offset+take])
            if written is None or written <= 0:
                raise BrokenPipeError("Binary proposal pipe made no forward progress")
            offset += written
        sys.stdout.buffer.flush()
        del view

    def span(self, request):
        self.guard()
        start, count, out = check_span(request, self.source["size"], self.args.max_count, self.cursor)
        out.mkdir(parents=True, exist_ok=True)
        receipt = out/"receipt.json"
        if receipt.exists():
            raise ValueError("Compact output root already has a receipt; use a fresh owned attempt")
        self.frame_active = False
        began = time.monotonic()
        values = [C.c_uint64(x) for x in (self.numeric, self.groups, self.numeric_edges, self.honor_edges, self.source_pointer, self.targets_pointer)]
        values += [C.c_uint32(len(self.children)), C.c_uint64(start), C.c_uint32(count), C.c_uint32(1), C.c_uint64(self.output_pointer)]
        combined_kernel = self.launch(self.scan, values, count)
        compact, copy_seconds = self.download_output(count)
        self.guard()
        self.frame_active = True
        event("PAYLOAD", layer=self.args.layer, honor=self.args.honor,
              start=start, count=count, compact_bytes=count*8, record_bytes=8,
              endianness="little", transport="compact_source_witness_u64_v1",
              identity_sha256=self.identity_sha256, payload_hashes_required=False,
              completed_spans=self.completed+1)
        transferred = time.monotonic()
        self.write_payload(compact)
        del compact
        transfer_seconds = time.monotonic()-transferred
        self.guard()
        work = time.monotonic()-began
        value = dict(schema="UNTRUSTED_GPU_COMPACT_STREAM_SPAN_V4", status="STREAMED_NOT_LEAN_CERTIFIED",
                     layer=self.args.layer, honor=self.args.honor, start=start, count=count,
                     identity_sha256=self.identity_sha256, record_bytes=8, mode=1,
                     compact_bytes=count*8, transport="compact_source_witness_u64_v1",
                     endianness="little", compact_layout=COMPACT_LAYOUT,
                     payload_saved_to_disk=False, payload_hashed=False,
                     combined_kernel_seconds=combined_kernel, copy_seconds=copy_seconds,
                     kernel_timing="evaluate_mode1_plus_source_decode_and_pack",
                     stdout_transfer_seconds=transfer_seconds, proposal_work_seconds=work,
                     first_session_span=self.completed == 0,
                     initial_cold_seconds=self.initialization_seconds if self.completed == 0 else 0.0,
                     provenance=self.provenance, process_owner=self.owner, resources=self.resources(),
                     formal_verification="EVERY_RECORD_REQUIRES_NATIVE_LEAN_CHECKS", Lean_rows_verified=0)
        atomic(receipt, value)
        self.active_seconds += time.monotonic()-began
        self.cursor, self.completed = start+count, self.completed+1
        self.rows += count
        self.generated += 1
        event("PROPOSED", layer=self.args.layer, honor=self.args.honor, start=start, count=count,
              compact_bytes=count*8, record_bytes=8, endianness="little",
              transport="compact_source_witness_u64_v1", identity_sha256=self.identity_sha256,
              completed_spans=self.completed, proposed_unique_rows=self.rows,
              receipt=str(receipt), receipt_sha256=sha(receipt), payload_saved_to_disk=False,
              payload_hashed=False, request_work_seconds=time.monotonic()-began,
              combined_kernel_seconds=combined_kernel, copy_seconds=copy_seconds,
              stdout_transfer_seconds=transfer_seconds, resources=self.resources())
        self.frame_active = False

    def close(self, reason, failed=False):
        if self.driver is not None:
            try:
                self.driver.call("cuCtxSynchronize")
            finally:
                try:
                    self.driver.close()
                finally:
                    self.driver = None
        if self.rss is not None:
            self.rss.close()
        record = dict(schema="GPU_STREAM_CONTEXT_CLOSED_V4", owner=self.owner, reason=reason,
                      failed=failed, completed_spans=self.completed, generated_spans=self.generated,
                      proposed_unique_rows=self.rows, active_work_seconds=self.active_seconds,
                      session_wall_including_idle_seconds=time.monotonic()-self.began,
                      GPU_context_closed=True, OS_process_exit_must_be_confirmed_by_controller=True,
                      resources=self.resources(), Lean_rows_verified=0)
        atomic(self.pid_path.with_name(self.pid_path.name+".closed.json"), record)
        return record


class StopRequested(Exception):
    pass


def run(args):
    if sys.platform != "linux":
        raise ValueError("Actual CUDA worker requires WSL Linux; --selftest performs no CUDA work")
    if not 0 <= args.layer <= 34 or not 0 <= args.honor < 184 or not 0 < args.max_count <= MAX_COUNT:
        raise ValueError("Actual source scope must be layer 0..34, honor 0..183, span <=8M")
    if not 0 < args.device_cap_bytes <= DEVICE_CAP or not 0 < args.host_rss_cap_bytes <= HOST_CAP:
        raise ValueError("Explicit GPU<=6GB and hostRSS<=3GB limits required")
    session = Session.__new__(Session)
    initialized, reason, failed = False, "EOF", False
    def stop(signum, frame):
        raise StopRequested("SIGNAL_"+str(signum))
    signal.signal(signal.SIGTERM, stop)
    signal.signal(signal.SIGINT, stop)
    try:
        session.__init__(args)
        initialized = True
        while True:
            line = sys.stdin.readline(1_000_001)
            if not line:
                break
            if len(line) > 1_000_000:
                raise ValueError("Oversized JSONL request")
            request = json.loads(line)
            if request == {"stop": True}:
                reason = "STOP_COMMAND"
                break
            session.span(request)
    except StopRequested as error:
        reason = str(error)
        failed = bool(getattr(session, "frame_active", False))
    except BaseException as error:
        reason, failed = repr(error), True
        event("ERROR", layer=args.layer, honor=args.honor, error=reason, Lean_rows_verified=0)
        print(reason, file=sys.stderr, flush=True)
    finally:
        signal.signal(signal.SIGTERM, signal.SIG_IGN)
        signal.signal(signal.SIGINT, signal.SIG_IGN)
        if getattr(session, "owns_pid", False):
            try:
                record = session.close(reason, failed)
                if not failed:
                    event("STOPPED", layer=args.layer, honor=args.honor, **{key: record[key] for key in ("reason", "completed_spans", "generated_spans", "proposed_unique_rows", "active_work_seconds", "GPU_context_closed", "OS_process_exit_must_be_confirmed_by_controller", "resources")})
            except BaseException as error:
                failed = True
                print("GPU context cleanup failed: "+repr(error), file=sys.stderr, flush=True)
    return 1 if failed else 0


def selftest():
    """No CUDA, WSL, old runtime helper imports, or large file reads."""
    import tempfile
    RUN.mkdir(parents=True, exist_ok=True)
    tests = []
    with tempfile.TemporaryDirectory(prefix="protocol_controls_", dir=RUN) as temporary:
        out = Path(temporary)
        listed, small, unlisted = out/"large.bin", out/"small.bin", out/"unlisted.bin"
        listed.write_bytes(b"x"*MIN_REUSE_BYTES)
        small.write_bytes(b"small")
        unlisted.write_bytes(b"other")
        manifest = out/"locked.json"
        bindings = {relative(path):dict(bytes=path.stat().st_size, sha256=sha(path)) for path in (listed, small)}
        atomic(manifest, dict(schema="V4_READ_LOCKED_INPUT_DIGESTS", files=bindings))
        resolver = DigestResolver(manifest, sha(manifest))
        assert resolver.digest(listed) == bindings[relative(listed)]["sha256"] and relative(listed) in resolver.used
        tests.append("exact_listed_large_digest_reuse")
        assert resolver.digest(small) == sha(small) and relative(small) not in resolver.used
        assert resolver.digest(unlisted) == sha(unlisted) and relative(unlisted) not in resolver.used
        tests.extend(("small_input_fresh_hash", "unlisted_input_fresh_hash"))
        assert check_span(dict(start=7,count=9,output_root=str(out)), 40, 16, None)[:2] == (7,9)
        assert check_span(dict(start=16,count=1,output_root=str(out)), 40, 16, 16)[:2] == (16,1)
        tests.append("consecutive_unique_exact_coverage")
        for bad in (dict(start=16,count=1,output_root=str(out)), dict(start=0,count=True,output_root=str(out)), dict(start=39,count=2,output_root=str(out))):
            try:
                check_span(bad,40,16,17)
            except ValueError:
                pass
            else:
                raise AssertionError("Expected rejected exact-span control")
        tests.append("duplicate_gap_bool_and_overflow_rejected")
        try:
            DigestResolver(manifest,"0"*64)
        except ValueError:
            pass
        else:
            raise AssertionError("Wrong manifest digest accepted")
        tests.append("wrong_manifest_digest_rejected")
        listed.write_bytes(b"changed")
        try:
            DigestResolver(manifest,sha(manifest)).digest(listed)
        except ValueError:
            pass
        else:
            raise AssertionError("Wrong listed size accepted")
        tests.append("wrong_listed_size_rejected")
        assert struct.calcsize("<Q") == 8
        tests.append("compact_8byte_record_layout")
    result = dict(status="PASS_NON_CUDA_PROTOCOL_DIGEST_AND_RECORD_CONTROLS", tests=tests,
                  worker_sha256=sha(__file__), CUDA_executed=False, native_Lean_changed=False)
    atomic(RUN/"selftest_compact.json",result)
    print(json.dumps(result,indent=2))


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--selftest", action="store_true")
    for key in ("index", "manifest", "manifest-sha256", "pid-file"):
        parser.add_argument("--"+key)
    parser.add_argument("--catalog")
    parser.add_argument("--data", default=str(ROOT/"runs/global_retro/pilot_v1/data"))
    parser.add_argument("--edges", default=str(ROOT/"runs/lean_table_checker/successor_cache_v1/inputs"))
    parser.add_argument("--layer", type=int)
    parser.add_argument("--honor", type=int)
    parser.add_argument("--max-count", type=int, default=MAX_COUNT)
    parser.add_argument("--device-cap-bytes", type=int, default=DEVICE_CAP)
    parser.add_argument("--host-rss-cap-bytes", type=int, default=HOST_CAP)
    args = parser.parse_args()
    if args.selftest:
        selftest()
        return 0
    if any(getattr(args,key) is None for key in ("index","layer","honor","manifest","manifest_sha256","pid_file")):
        parser.error("A resident session requires index/layer/honor/manifest/manifest-sha256/pid-file")
    return run(args)


if __name__ == "__main__":
    raise SystemExit(main())
