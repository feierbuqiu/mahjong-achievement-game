"""Untrusted CUDA source-ID proposals; correctness is checked by Lean's guard.

Only a source directory and the 1104 group records are uploaded. No P/N table,
models, system packages, drivers or scheduled services are installed.
"""
from pathlib import Path
import argparse
import ctypes as C
import hashlib
import importlib.util
import json
import os
import struct
import time

BASE = Path(__file__).resolve().parent
ROOT = BASE.parents[2]
OLD = BASE.parent / "gpu_spike_v1"
RUN = ROOT / "runs/lean_table_checker/cached_checker_20261018_v2/e2e_sources"
SUFFIX = r'''
struct SourceProposal { U32 block, a, b, c; };
extern "C" __global__ void propose_sources(const Bucket* source, const U32* groups,
    U64 start, U32 count, SourceProposal* output) {
    U32 i=blockIdx.x*blockDim.x+threadIdx.x;
    if(i>=count) return;
    U64 row=start+i; U32 ids[3];
    SourceProposal bad={~0U,~0U,~0U,~0U};
    if(!decode(*source,groups,row,ids)) { output[i]=bad; return; }
    const U32* directory=(const U32*)source->directory;
    U32 lo=0,hi=source->blocks;
    while(lo+1<hi) { U32 m=(lo+hi)/2; if(off(directory,m)<=row) lo=m; else hi=m; }
    SourceProposal p={lo,ids[0],ids[1],ids[2]}; output[i]=p;
}
'''


def sha(path):
    with Path(path).open("rb") as stream:
        return hashlib.file_digest(stream,"sha256").hexdigest()


def atomic(path, raw):
    temporary = path.with_name(path.name+".tmp")
    with temporary.open("wb") as stream:
        stream.write(raw)
        stream.flush()
        os.fsync(stream.fileno())
    os.replace(temporary,path)


def compile_source(gpu):
    dep = OLD / "deps"
    for name, digest in json.loads((dep/"receipt.json").read_text())["files"].items():
        assert sha(dep/name) == digest, "Pinned NVRTC library changed"
    C.CDLL(str(dep/"libnvrtc-builtins.so.12.4"),mode=C.RTLD_GLOBAL)
    nvrtc = C.CDLL(str(dep/"libnvrtc.so.12"))
    source = (OLD/"rows.cu").read_bytes()+SUFFIX.encode()
    program = C.c_void_p()
    gpu.require(nvrtc.nvrtcCreateProgram(C.byref(program), C.c_char_p(source),
                b"source_proposals.cu",0,None,None),"create NVRTC source program")
    options = (C.c_char_p*3)(b"--gpu-architecture=compute_75",b"--std=c++14",b"-DGPU_BUILD=1")
    began = time.monotonic()
    code = nvrtc.nvrtcCompileProgram(program,3,options)
    size = C.c_size_t()
    nvrtc.nvrtcGetProgramLogSize(program,C.byref(size))
    log = C.create_string_buffer(size.value)
    nvrtc.nvrtcGetProgramLog(program,log)
    if code:
        raise RuntimeError(log.value.decode())
    gpu.require(nvrtc.nvrtcGetPTXSize(program,C.byref(size)),"PTX source size")
    ptx = C.create_string_buffer(size.value)
    gpu.require(nvrtc.nvrtcGetPTX(program,ptx),"source PTX")
    gpu.require(nvrtc.nvrtcDestroyProgram(C.byref(program)),"destroy source program")
    return ptx,time.monotonic()-began,hashlib.sha256(source).hexdigest()


def main():
    import resource
    parser = argparse.ArgumentParser()
    parser.add_argument("--layer",type=int,choices=[23,32],required=True)
    parser.add_argument("--honor",type=int,required=True)
    parser.add_argument("--start",type=int,required=True)
    parser.add_argument("--count",type=int,required=True)
    args = parser.parse_args()
    if not 0 < args.count <= 1_048_576 or args.start < 0:
        raise ValueError("Source proposal experiment exceeds bounded scope")
    began = time.monotonic()
    spec = importlib.util.spec_from_file_location("sealed_cuda_helpers",OLD/"gpu_benchmark.py")
    gpu = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(gpu)
    seal = ROOT/"runs/lean_table_checker/gpu_spike_20261018_v1/acceptance.json"
    assert sha(seal) == "268182262b09a773827266685fec4054d5f1ca28ed8c6a5558d64b0790a2d063"
    index = ROOT/"runs/lean_table_checker"/("general_input_v1" if args.layer==32 else "general_peak_input_v1")
    entries = [list(map(int,line.split())) for line in (index/"catalog.tsv").read_text().splitlines()]
    n,h,_,total,blocks = next(e for e in entries if e[0]==args.layer and e[1]==args.honor)
    assert args.start+args.count <= total
    directory = index/f"n{n:02}_h{h:03}.dir"
    groups = index/"groups.bin"
    assert directory.stat().st_size == blocks*32 and groups.stat().st_size == 1104*8
    name = f"n{n:02}_h{h:03}_{args.start}_{args.count}"
    RUN.mkdir(parents=True,exist_ok=True)
    target = RUN/(name+".json")
    assert not target.exists(), "Preserve completed source proposal receipts"
    bound = {str(p.relative_to(ROOT)):dict(bytes=p.stat().st_size,sha256=sha(p))
             for p in [directory,groups,Path(__file__),OLD/"gpu_benchmark.py",OLD/"rows.cu",seal]}
    for p in [directory,groups]:
        key = str(p.relative_to(ROOT)).replace("\\","/")
        assert sha(p) == json.loads(seal.read_text())["evidence_files"][key]
    ptx,compile_seconds,source_digest = compile_source(gpu)
    driver = gpu.Driver()
    try:
        upload = time.monotonic()
        d = driver.upload_file(directory)
        g = driver.upload_file(groups)
        descriptor = driver.upload(struct.pack("<QQQII",d,0,total,blocks,h))
        output = driver.allocate(args.count*16)
        upload_seconds = time.monotonic()-upload
        assert sum(size for _,size in driver.allocations) < 64_000_000
        module = C.c_void_p()
        driver.call("cuModuleLoadData",C.byref(module),ptx)
        function = C.c_void_p()
        driver.call("cuModuleGetFunction",C.byref(function),module,b"propose_sources")
        values = [C.c_uint64(descriptor),C.c_uint64(g),C.c_uint64(args.start),
                  C.c_uint32(args.count),C.c_uint64(output)]
        parameters = (C.c_void_p*len(values))(*(C.cast(C.byref(v),C.c_void_p) for v in values))
        event0,event1 = C.c_void_p(),C.c_void_p()
        driver.call("cuEventCreate",C.byref(event0),0)
        driver.call("cuEventCreate",C.byref(event1),0)
        try:
            driver.call("cuEventRecord",event0,None)
            driver.call("cuLaunchKernel",function,(args.count+127)//128,1,1,128,1,1,0,None,parameters,None)
            driver.call("cuEventRecord",event1,None)
            driver.call("cuEventSynchronize",event1)
            ms = C.c_float()
            driver.call("cuEventElapsedTime",C.byref(ms),event0,event1)
            copied = time.monotonic()
            raw = driver.download(output,args.count*16)
            copy_seconds = time.monotonic()-copied
        finally:
            driver.call("cuEventDestroy_v2",event0)
            driver.call("cuEventDestroy_v2",event1)
        # These are diagnostics only; Lean independently checks every source proposal.
        assert all(b < blocks and a <= bb <= c < 131676 for b,a,bb,c in struct.iter_unpack("<4I",raw))
        output_path = RUN/(name+".source.bin")
        save = time.monotonic()
        atomic(output_path,raw)
        report = dict(schema="UNTRUSTED_GPU_SOURCE_PROPOSALS_V2",status="PASS_BOUNDED_GPU_PROPOSAL_GENERATION",
            layer=n,honor=h,start=args.start,count=args.count,input_files=bound,
            source_sha256=source_digest,ptx_sha256=hashlib.sha256(ptx.raw).hexdigest(),
            compile_seconds=compile_seconds,upload_seconds=upload_seconds,kernel_seconds=ms.value/1000,
            copy_seconds=copy_seconds,save_seconds=time.monotonic()-save,
            total_seconds=time.monotonic()-began,allocated_device_bytes=sum(size for _,size in driver.allocations),
            peak_host_rss_bytes=resource.getrusage(resource.RUSAGE_SELF).ru_maxrss*1024,
            output=str(output_path.relative_to(ROOT)),output_sha256=sha(output_path),
            gpu_trusted_for_soundness=False,Lean_rows_verified=0,full_table_Lean="NOT_VERIFIED")
        atomic(target,(json.dumps(report,indent=2)+"\n").encode())
        print(json.dumps({k:v for k,v in report.items() if k!="input_files"}),flush=True)
    finally:
        driver.close()


if __name__ == "__main__":
    main()
