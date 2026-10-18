"""Bounded WSL fallback for a launcher interrupted before its PID receipt.

Only the exact worker script plus this campaign's unique --pid-file argument
is eligible. Each signal rechecks the kernel start identity; PID reuse is safe.
The ordinary path continues to use the frozen stop_compact.py helper.
"""
from pathlib import Path
import argparse,json,os,signal,time

ROOT=Path(__file__).resolve().parents[3]
OWNED=ROOT/"runs/lean_table_checker/gpu_indexed_byte_20261018_v16/campaign_indexed_v16"

def main():
    parser=argparse.ArgumentParser();parser.add_argument("--pid-file",required=True);args=parser.parse_args()
    path=Path(args.pid_file).resolve()
    if path==OWNED.resolve() or not path.is_relative_to(OWNED.resolve()):raise ValueError("Unreceipted fallback restricted to the new compact campaign subtree")
    flag=b"--pid-file\x00"+str(path).encode()+b"\x00"
    def inspect(pid):
        try:
            p=Path("/proc")/str(pid);stat=(p/"stat").read_text().rsplit(")",1)[1].split();command=(p/"cmdline").read_bytes().replace(b"\\",b"/")
            return dict(start=int(stat[19]),state=stat[0],ours=flag in command and b"gpu_indexed_byte_v16/worker.py\x00" in command)
        except (FileNotFoundError,ProcessLookupError):return None
    owned=[]
    for entry in Path("/proc").iterdir():
        if not entry.name.isdecimal() or int(entry.name)==os.getpid():continue
        v=inspect(int(entry.name))
        if v and v["ours"] and v["state"]!="Z":owned.append((int(entry.name),v["start"]))
    def live(pid,start):
        value=inspect(pid)
        return bool(value and value["start"]==start and value["state"]!="Z" and value["ours"])
    for pid,start in owned:
        if live(pid,start):
            try:os.kill(pid,signal.SIGTERM)
            except ProcessLookupError:pass
    until=time.monotonic()+10
    while any(live(*x) for x in owned) and time.monotonic()<until:time.sleep(.025)
    for pid,start in owned:
        if live(pid,start):
            try:os.kill(pid,signal.SIGKILL)
            except ProcessLookupError:pass
    until=time.monotonic()+5
    while any(live(*x) for x in owned) and time.monotonic()<until:time.sleep(.025)
    if any(live(*x) for x in owned):raise TimeoutError("Exact owned Linux process did not exit")
    print(json.dumps(dict(status="CONFIRMED_OWNED_LINUX_PROCESS_EXITED",method="EXACT_UNIQUE_PID_ARGUMENT_AND_KERNEL_START",candidates=owned)),flush=True)

if __name__=="__main__":main()
