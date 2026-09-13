#!/usr/bin/env python3
"""Build and run the frozen computation with standard-library Python."""
from __future__ import annotations

import argparse
import datetime as dt
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import time

ROOT = Path(__file__).resolve().parents[1]
BUILD = ROOT / "build"
TARGETS = ("global_retro", "push_verify_parallel_v3", "index_selftest",
           "verify_oracles", "verify_oracles_catalog", "verify_small", "strategy_physical")
SUFFIX = ".exe" if os.name == "nt" else ""


def stamp():
    return dt.datetime.now(dt.timezone.utc).strftime("%Y%m%dT%H%M%S.%fZ")


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def source_hashes():
    paths = [*ROOT.glob("src/retro/*.cpp"), *ROOT.glob("src/retro/*.hpp"),
             ROOT / "mahjong_progress/solver/solver.cpp", ROOT / "compat/sys/resource.h"]
    return {p.relative_to(ROOT).as_posix(): sha(p) for p in sorted(paths)}


def write_json(path, value):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(value, indent=2) + "\n", encoding="utf-8")


def execute(command, directory, env=None, expected=0):
    directory.mkdir(parents=True, exist_ok=False)
    started = time.monotonic()
    with (directory / "stdout.log").open("wb") as out, (directory / "stderr.log").open("wb") as err:
        proc = subprocess.run(command, cwd=ROOT, env=env, stdout=out, stderr=err)
    receipt = {"utc": stamp(), "command": [str(x) for x in command],
               "cwd": str(ROOT), "return_code": proc.returncode,
               "expected_return_code": expected, "elapsed_seconds": time.monotonic() - started,
               "python": sys.version, "source_sha256": source_hashes(),
               "stdout_sha256": sha(directory / "stdout.log"),
               "stderr_sha256": sha(directory / "stderr.log")}
    write_json(directory / "receipt.json", receipt)
    print(json.dumps({"log_directory": str(directory.relative_to(ROOT)),
                      "return_code": proc.returncode, "elapsed_seconds": receipt["elapsed_seconds"]}), flush=True)
    if proc.returncode != expected:
        print((directory / "stderr.log").read_text(encoding="utf-8", errors="replace")[-5000:], file=sys.stderr)
        print((directory / "stdout.log").read_text(encoding="utf-8", errors="replace")[-2000:], file=sys.stderr)
        raise RuntimeError(f"Unexpected exit code {proc.returncode}; expected {expected}. See {directory}")
    return proc.returncode


def build(compiler, names):
    resolved = shutil.which(compiler)
    if not resolved:
        raise RuntimeError("C++ compiler not found. Install GCC/MinGW-w64 and use --cxx or CXX.")
    compiler = str(Path(resolved).resolve())
    env = os.environ.copy()
    env["PATH"] = str(Path(compiler).parent) + os.pathsep + env.get("PATH", "")
    version = subprocess.check_output([compiler, "--version"], env=env, text=True).splitlines()[0]
    BUILD.mkdir(exist_ok=True)
    hashes = source_hashes()
    build_id = "public_" + hashlib.sha256(json.dumps(hashes, sort_keys=True).encode()).hexdigest()[:20]
    for name in names:
        cmd = [compiler, "-O3", "-std=c++17", "-pthread", f'-DRETRO_BUILD_ID="{build_id}"']
        if os.name == "nt":
            cmd += ["-I", str(ROOT / "compat")]
        cmd += [str(ROOT / "src/retro" / (name + ".cpp"))]
        if os.name == "nt":
            cmd += ["-lpsapi", "-static-libgcc", "-static-libstdc++"]
        binary = BUILD / (name + SUFFIX)
        cmd += ["-o", str(binary)]
        execute(cmd, BUILD / "logs" / (stamp() + "-" + name), env=env)
        write_json(BUILD / (name + ".build.json"), {"build_id": build_id, "compiler": compiler,
                   "compiler_version": version, "command": cmd, "source_sha256": hashes,
                   "binary_sha256": sha(binary), "utc": stamp()})


def binary_command(name):
    binary = BUILD / (name + SUFFIX)
    record = BUILD / (name + ".build.json")
    if not binary.is_file() or not record.is_file():
        raise RuntimeError(f"Build {name} first: python tools/reproduce.py build")
    meta = json.loads(record.read_text(encoding="utf-8"))
    if meta["source_sha256"] != source_hashes() or meta["binary_sha256"] != sha(binary):
        raise RuntimeError("Sources or executable changed since the recorded build; rebuild before running.")
    env = os.environ.copy()
    env["PATH"] = str(Path(meta["compiler"]).parent) + os.pathsep + env.get("PATH", "")
    return [str(binary)], env, meta["build_id"]


def smoke():
    out = ROOT / "runs" / ("smoke-" + stamp())
    data = out / "table"
    checks = [
        ("index", "index_selftest", ["--layers", "0,1,2,3,4", "--all-edges", "--seconds", "180"], 0),
        ("atomic", "push_verify_parallel_v3", ["--self-test"], 0),
        ("generate34", "global_retro", ["--data", str(data), "--min-layer", "34", "--max-layer", "34", "--threads", "2", "--seconds", "180"], 0),
        ("reverse34", "push_verify_parallel_v3", ["--data", str(data), "--verified-dir", str(out / "replay"), "--build-id", "SMOKE", "--layers", "34", "--threads", "2", "--max-seconds", "180"], 0),
        ("query34", "verify_oracles", ["--data", str(data), "--sample-layer", "34", "--seconds", "90"], 0),
        ("missing_opening", "verify_oracles", ["--data", str(out / "missing"), "--opening", "--seconds", "90"], 2),
        ("invalid_input", "strategy_physical", ["--data", str(data), "--state", "5" + "0" * 33], 1),
    ]
    for label, name, args, expected in checks:
        cmd, env, build_id = binary_command(name)
        args = [build_id if a == "SMOKE" else a for a in args]
        execute(cmd + args, out / label, env=env, expected=expected)
    write_json(out / "summary.json", {"status": "PASS", "checks": len(checks),
               "scope": "Bounded index/physical-edge checks and complete terminal-layer generation/replay; not an opening proof."})
    print("PASS: bounded reproduction checks; this does not recompute the opening.")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    subs = parser.add_subparsers(dest="action", required=True)
    b = subs.add_parser("build")
    b.add_argument("--cxx", default=os.environ.get("CXX", "g++"))
    b.add_argument("targets", nargs="*")
    subs.add_parser("smoke")
    r = subs.add_parser("run")
    r.add_argument("target", choices=TARGETS)
    r.add_argument("arguments", nargs=argparse.REMAINDER)
    args = parser.parse_args()
    if args.action == "build":
        names = args.targets or list(TARGETS)
        if any(x not in TARGETS for x in names):
            parser.error("Unknown build target")
        build(args.cxx, names)
    elif args.action == "smoke":
        smoke()
    else:
        command, env, build_id = binary_command(args.target)
        out = ROOT / "runs" / (stamp() + "-" + args.target)
        out.mkdir(parents=True, exist_ok=False)
        command += args.arguments
        # Stream long scientific runs rather than buffering their output.
        started = time.monotonic()
        with (out / "output.log").open("w", encoding="utf-8") as log:
            proc = subprocess.Popen(command, cwd=ROOT, env=env, stdout=subprocess.PIPE,
                                    stderr=subprocess.STDOUT, text=True, encoding="utf-8", errors="replace")
            for line in proc.stdout:
                print(line, end="", flush=True)
                log.write(line)
                log.flush()
            code = proc.wait()
        write_json(out / "receipt.json", {"command": command, "build_id": build_id,
                   "return_code": code, "elapsed_seconds": time.monotonic() - started,
                   "utc": stamp(), "source_sha256": source_hashes(), "output_sha256": sha(out / "output.log")})
        return code
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except (RuntimeError, OSError) as exc:
        print(str(exc), file=sys.stderr)
        raise SystemExit(1)
