"""Bounded WSL CUDA spike over real historical labels, not a formal receipt.

Uses only Python's standard library, the CUDA driver, and a private pinned NVRTC.
No global campaign, background service, notifications, or writes to old inputs.
"""
from pathlib import Path
import argparse
import ctypes as C
import hashlib
import json
import mmap
import resource
import struct
import time

BASE = Path(__file__).resolve().parent
ROOT = BASE.parents[2]
RUNS = ROOT / "runs/lean_table_checker"
DATA = ROOT / "runs/global_retro/pilot_v1/data"
EDGES = RUNS / "successor_cache_v1/inputs"

def sha(path):
    with path.open("rb") as stream:
        return hashlib.file_digest(stream, "sha256").hexdigest()

def atomic(path, value):
    temporary = path.with_suffix(path.suffix + ".tmp")
    temporary.write_text(json.dumps(value, indent=2), encoding="utf-8")
    temporary.replace(path)

def require(code, operation):
    if code:
        raise RuntimeError(f"{operation}: CUDA/NVRTC error {code}")

class Driver:
    def __init__(self):
        self.api = C.CDLL("/usr/lib/wsl/lib/libcuda.so.1")
        self.allocations = []
        types = {
            "cuInit": [C.c_uint],
            "cuCtxCreate_v2": [C.POINTER(C.c_void_p), C.c_uint, C.c_int],
            "cuCtxDestroy_v2": [C.c_void_p],
            "cuMemGetInfo_v2": [C.POINTER(C.c_size_t), C.POINTER(C.c_size_t)],
            "cuMemAlloc_v2": [C.POINTER(C.c_uint64), C.c_size_t],
            "cuMemFree_v2": [C.c_uint64],
            "cuMemcpyHtoD_v2": [C.c_uint64, C.c_void_p, C.c_size_t],
            "cuMemcpyDtoH_v2": [C.c_void_p, C.c_uint64, C.c_size_t],
            "cuModuleLoadData": [C.POINTER(C.c_void_p), C.c_void_p],
            "cuModuleGetFunction": [C.POINTER(C.c_void_p), C.c_void_p, C.c_char_p],
            "cuLaunchKernel": [C.c_void_p, C.c_uint, C.c_uint, C.c_uint, C.c_uint, C.c_uint, C.c_uint, C.c_uint, C.c_void_p, C.POINTER(C.c_void_p), C.c_void_p],
            "cuCtxSynchronize": [],
            "cuEventCreate": [C.POINTER(C.c_void_p), C.c_uint],
            "cuEventRecord": [C.c_void_p, C.c_void_p],
            "cuEventSynchronize": [C.c_void_p],
            "cuEventElapsedTime": [C.POINTER(C.c_float), C.c_void_p, C.c_void_p],
            "cuEventDestroy_v2": [C.c_void_p],
        }
        for name, arguments in types.items():
            getattr(self.api, name).argtypes = arguments
        self.call("cuInit", 0)
        self.context = C.c_void_p()
        self.call("cuCtxCreate_v2", C.byref(self.context), 0, 0)
        self.free_at_start = self.free()

    def call(self, name, *arguments):
        require(getattr(self.api, name)(*arguments), name)

    def free(self):
        free, total = C.c_size_t(), C.c_size_t()
        self.call("cuMemGetInfo_v2", C.byref(free), C.byref(total))
        return free.value

    def allocate(self, size):
        if sum(x[1] for x in self.allocations) + size > 6_000_000_000 or size + 512_000_000 > self.free():
            raise MemoryError("Explicit 6 GB allocation budget / 512 MB free reserve")
        pointer = C.c_uint64()
        self.call("cuMemAlloc_v2", C.byref(pointer), size)
        self.allocations.append((pointer.value, size))
        return pointer.value

    def upload(self, data):
        pointer = self.allocate(len(data))
        temporary = C.create_string_buffer(data)
        self.call("cuMemcpyHtoD_v2", pointer, temporary, len(data))
        return pointer

    def upload_file(self, path):
        size = path.stat().st_size
        pointer = self.allocate(size)
        with path.open("rb") as stream, mmap.mmap(stream.fileno(), 0, access=mmap.ACCESS_COPY) as mapped:
            view = (C.c_char * size).from_buffer(mapped)
            try:
                self.call("cuMemcpyHtoD_v2", pointer, C.addressof(view), size)
            finally:
                del view
        return pointer

    def download(self, pointer, size):
        data = C.create_string_buffer(size)
        self.call("cuMemcpyDtoH_v2", data, pointer, size)
        return data.raw

    def close(self):
        for pointer, _ in reversed(self.allocations):
            self.call("cuMemFree_v2", pointer)
        self.call("cuCtxDestroy_v2", self.context)

def compile_kernel():
    dependencies = BASE / "deps"
    receipt = json.loads((dependencies / "receipt.json").read_text())
    for leaf, digest in receipt["files"].items():
        assert sha(dependencies / leaf) == digest
    C.CDLL(str(dependencies / "libnvrtc-builtins.so.12.4"), mode=C.RTLD_GLOBAL)
    nvrtc = C.CDLL(str(dependencies / "libnvrtc.so.12"))
    program = C.c_void_p()
    source = (BASE / "rows.cu").read_bytes()
    require(nvrtc.nvrtcCreateProgram(C.byref(program), C.c_char_p(source), b"rows.cu", 0, None, None), "create NVRTC program")
    options = (C.c_char_p * 3)(b"--gpu-architecture=compute_75", b"--std=c++14", b"-DGPU_BUILD=1")
    began = time.monotonic()
    code = nvrtc.nvrtcCompileProgram(program, 3, options)
    size = C.c_size_t()
    nvrtc.nvrtcGetProgramLogSize(program, C.byref(size))
    log = C.create_string_buffer(size.value)
    nvrtc.nvrtcGetProgramLog(program, log)
    if code:
        raise RuntimeError(log.value.decode())
    require(nvrtc.nvrtcGetPTXSize(program, C.byref(size)), "PTX size")
    ptx = C.create_string_buffer(size.value)
    require(nvrtc.nvrtcGetPTX(program, ptx), "get PTX")
    require(nvrtc.nvrtcDestroyProgram(C.byref(program)), "destroy NVRTC program")
    return ptx, time.monotonic() - began, log.value.decode()

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--layer", type=int, choices=[23, 32], required=True)
    parser.add_argument("--honor", type=int, required=True)
    parser.add_argument("--start", type=int, required=True)
    parser.add_argument("--count", type=int, default=131072)
    parser.add_argument("--run", default="gpu_spike_20261018_v1")
    args = parser.parse_args()
    assert 0 < args.count <= 1_048_576 and args.start >= 0
    assert args.run.replace("_", "").replace("-", "").isalnum()
    folder = RUNS / args.run
    folder.mkdir(exist_ok=True)
    case = f"n{args.layer}_h{args.honor}_{args.start}_{args.count}"
    output = folder / (case + ".gpu.json")
    assert not output.exists(), "Preserve the existing case; use a fresh run/window"
    report = dict(schema="CUDA_REAL_TABLE_BOUNDED_SPIKE_V1", state="STARTING", layer=args.layer,
        honor=args.honor, start=args.start, count=args.count, gpu_allocation_limit_bytes=6_000_000_000,
        historical_pn_formal_certification=False, full_scan_launched=False, cases=[])
    atomic(output, report)
    began = time.monotonic()
    index = RUNS / ("general_input_v1" if args.layer == 32 else "general_peak_input_v1")
    catalog = [dict(zip(["n", "h", "code", "size", "blocks"], map(int, line.split())))
        for line in (index / "catalog.tsv").read_text().splitlines()]
    source = next(r for r in catalog if r["n"] == args.layer and r["h"] == args.honor)
    assert args.start + args.count <= source["size"]
    honor_edges = (EDGES / "honors.bin").read_bytes()
    raw = struct.unpack_from("<6I", honor_edges, args.honor * 24)
    required = {args.honor, *raw[2:2 + raw[1]]}
    children = [r for r in catalog if r["n"] == args.layer + 1 and r["h"] in required]
    report["targets"] = children
    files = [BASE / "rows.cu", Path(__file__), BASE / "deps/receipt.json", index / "numeric.bin",
        index / "groups.bin", EDGES / "numeric.bin", EDGES / "honors.bin", index / "catalog.tsv"]
    for row in [source] + children:
        name = f"n{row['n']:02}_h{row['h']:03}"
        files += [index / (name + ".dir"), DATA / (name + ".bits"), DATA / (name + ".complete.json")]
    declared = sum(p.stat().st_size for p in files if p.suffix in (".bin", ".dir", ".bits"))
    if declared + args.count * 16 + 1024 > 6_000_000_000:
        report.update(state="SKIPPED_DEVICE_BUDGET", declared_bytes=declared)
        atomic(output, report)
        print(json.dumps(report, indent=2))
        return
    report["input_files"] = {str(p.relative_to(ROOT)): dict(bytes=p.stat().st_size, sha256=sha(p)) for p in files}
    report["input_hash_seconds"] = time.monotonic() - began
    atomic(output, report)
    driver = None
    try:
        ptx, compile_seconds, compile_log = compile_kernel()
        (folder / "rows.ptx").write_bytes(ptx.raw)
        driver = Driver()
        module = C.c_void_p()
        driver.call("cuModuleLoadData", C.byref(module), ptx)
        function = C.c_void_p()
        driver.call("cuModuleGetFunction", C.byref(function), module, b"scan_rows")
        upload_started = time.monotonic()
        numeric = driver.upload_file(index / "numeric.bin")
        groups = driver.upload_file(index / "groups.bin")
        edges = driver.upload_file(EDGES / "numeric.bin")
        honors = driver.upload_file(EDGES / "honors.bin")
        def load(row):
            name = f"n{row['n']:02}_h{row['h']:03}"
            directory = driver.upload_file(index / (name + ".dir"))
            bits = driver.upload_file(DATA / (name + ".bits"))
            return struct.pack("<QQQII", directory, bits, row["size"], row["blocks"], row["h"]), bits
        src, source_bits = load(source)
        descriptors = [load(row)[0] for row in children]
        src_pointer = driver.upload(src)
        target_pointer = driver.upload(b"".join(descriptors))
        result_pointer = driver.allocate(args.count * 16)
        report.update(state="RUNNING", upload_seconds=time.monotonic() - upload_started,
            nvrtc_seconds=compile_seconds, compile_log=compile_log, free_device_bytes_at_start=driver.free_at_start,
            allocated_device_bytes=sum(n for _, n in driver.allocations), ptx_sha256=hashlib.sha256(ptx.raw).hexdigest())
        atomic(output, report)
        def launch(mode, start=args.start, count=args.count):
            values = [C.c_uint64(x) for x in [numeric, groups, edges, honors, src_pointer, target_pointer]]
            values += [C.c_uint32(len(children)), C.c_uint64(start), C.c_uint32(count), C.c_uint32(mode), C.c_uint64(result_pointer)]
            parameters = (C.c_void_p * len(values))(*(C.cast(C.byref(x), C.c_void_p) for x in values))
            driver.call("cuLaunchKernel", function, (count + 127) // 128, 1, 1, 128, 1, 1, 0, None, parameters, None)
        for mode in range(3):
            launch(mode, count=min(args.count, 4096))
            driver.call("cuCtxSynchronize")
            start_event, end_event = C.c_void_p(), C.c_void_p()
            driver.call("cuEventCreate", C.byref(start_event), 0)
            driver.call("cuEventCreate", C.byref(end_event), 0)
            elapsed = []
            for repeat in range(3):
                driver.call("cuEventRecord", start_event, None)
                launch(mode)
                driver.call("cuEventRecord", end_event, None)
                driver.call("cuEventSynchronize", end_event)
                ms = C.c_float()
                driver.call("cuEventElapsedTime", C.byref(ms), start_event, end_event)
                elapsed.append(ms.value / 1000)
                if elapsed[-1] > 1:
                    break
            driver.call("cuEventDestroy_v2", start_event)
            driver.call("cuEventDestroy_v2", end_event)
            copied = time.monotonic()
            result = driver.download(result_pointer, args.count * 16)
            copy_seconds = time.monotonic() - copied
            failures = sum(bool(flags & ~2) for _, _, flags in struct.iter_unpack("<QII", result))
            p_rows = sum(bool(flags & 2) for _, _, flags in struct.iter_unpack("<QII", result))
            binary = folder / (case + f".gpu.mode{mode}.bin")
            binary.write_bytes(result)
            seconds = sorted(elapsed)[len(elapsed) // 2]
            report["cases"].append(dict(mode=mode, rows=args.count, kernel_seconds_all=elapsed,
                median_kernel_seconds=seconds, rows_per_second_resident=args.count / seconds,
                result_copy_seconds=copy_seconds, failures=failures, p_rows=p_rows,
                output=binary.name, output_sha256=hashlib.sha256(result).hexdigest()))
            atomic(output, report)
            print(f"mode={mode} rows/s={args.count/seconds:,.0f} failures={failures}", flush=True)
            if failures:
                raise RuntimeError("Historical row/roundtrip mismatch; preserve diagnostics")
        # Corrupt only the device copy of one source label; no historical file is written.
        with (DATA / f"n{args.layer:02}_h{args.honor:03}.bits").open("rb") as stream:
            stream.seek(args.start // 8)
            original = stream.read(1)
        changed = C.create_string_buffer(bytes([original[0] ^ (1 << (args.start % 8))]))
        driver.call("cuMemcpyHtoD_v2", source_bits + args.start // 8, changed, 1)
        launch(2, count=1)
        driver.call("cuCtxSynchronize")
        _, _, flags = struct.unpack("<QII", driver.download(result_pointer, 16))
        assert flags & 1, "Flipped source label was not rejected"
        restored = C.create_string_buffer(original)
        driver.call("cuMemcpyHtoD_v2", source_bits + args.start // 8, restored, 1)
        launch(2, count=1)
        driver.call("cuCtxSynchronize")
        _, _, flags = struct.unpack("<QII", driver.download(result_pointer, 16))
        assert not flags & ~2
        report.update(state="PASS_BOUNDED_CUDA_ENGINEERING_SPIKE", fault_controls=dict(device_source_bit_flip="REJECTED", restored="PASS"),
            wall_seconds=time.monotonic() - began, peak_host_rss_bytes=resource.getrusage(resource.RUSAGE_SELF).ru_maxrss * 1024)
        for path in files:
            assert path.stat().st_size == report["input_files"][str(path.relative_to(ROOT))]["bytes"]
        atomic(output, report)
        print(json.dumps({k: report[k] for k in ["state", "layer", "honor", "count", "allocated_device_bytes", "upload_seconds", "wall_seconds", "peak_host_rss_bytes"]}, indent=2))
    except Exception as exception:
        report.update(state="FAILED_NO_CERTIFICATION", error=str(exception))
        atomic(output, report)
        raise
    finally:
        if driver is not None:
            driver.close()

if __name__ == "__main__":
    main()
