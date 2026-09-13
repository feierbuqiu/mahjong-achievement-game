#!/usr/bin/env python3
"""Check the published nonempty-position Lean proofs from fresh source copies."""
from concurrent.futures import FIRST_COMPLETED, ThreadPoolExecutor, wait
from datetime import datetime, timezone
import argparse
import hashlib
import json
import os
from pathlib import Path
import re
import shutil
import subprocess
import sys
import time

ROOT = Path(__file__).resolve().parents[1]
FORMAL = ROOT / "formal"
SOURCE = FORMAL / "lean"
VERSION = "4.33.1"
REQUIRED_MARKERS = {
    "ContinuationAudit": ["ACTUAL_20_TILE_CLOSED_THEOREM_PRESENT", "EXTRACTED_32_TILE_CLOSED_THEOREM_PRESENT"],
    "PipelineAudit": ["FRESH_34_TILE_CLOSED_THEOREM_PRESENT", "NO_PREVIOUS_ANCHOR_IMPORTED"],
    "Actual14Audit": ["ACTUAL_14_TILE_CLOSED_THEOREM_PRESENT", "NO_PREVIOUS_P_CERTIFICATE_IMPORTED"],
    "Reflected20Audit": ["REFLECTED_20_TILE_CLOSED_THEOREM_PRESENT", "NO_PREVIOUS_20_TILE_ROOT_IMPORTED"],
    "Scale12Audit": ["ACTUAL_12_TILE_CLOSED_THEOREM_PRESENT"],
    "ScaleRegistryAudit": ["ACTUAL_12_TILE_CLOSED_THEOREM_PRESENT", "CHECKED_12_TABLE_REGISTRY_PRESENT"],
    "Grouped20Audit": ["GROUPED_20_TILE_CLOSED_THEOREM_PRESENT"],
}


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def require(value, message):
    if not value:
        raise ValueError(message)


def read_json(path):
    return json.loads(path.read_text(encoding="utf-8"))


def dependency_graph(entries):
    dependencies = {}
    visiting = set()

    def visit(name):
        require(name not in visiting, f"Cyclic import: {name}")
        if name in dependencies:
            return
        visiting.add(name)
        path = SOURCE / (name.replace(".", "/") + ".lean")
        require(path.is_file(), f"Missing Lean source: {name}")
        imports = []
        for line in path.read_text(encoding="utf-8-sig").splitlines():
            if line.startswith("import "):
                for child in line.split("--", 1)[0].split()[1:]:
                    if child.split(".")[0] in {"Lean", "Std", "Init"}:
                        continue
                    require(re.fullmatch(r"Mahjong\w*(?:\.\w+)*", child), f"Unexpected local import: {child}")
                    imports.append(child)
        for child in imports:
            visit(child)
        visiting.remove(name)
        dependencies[name] = imports

    for entry in entries:
        visit(entry)
    return dependencies


def check_snapshot():
    provenance = read_json(FORMAL / "provenance.json")
    status = read_json(FORMAL / "STATUS.json")
    require(provenance["lean_version"] == VERSION and provenance["trust_level"] == 0,
            "Unexpected Lean toolchain or trust level")
    seen = set()
    for artifact in provenance["artifacts"]:
        relative = artifact["published_path"]
        path = (ROOT / relative).resolve()
        require(relative not in seen and path.is_relative_to(FORMAL) and path.is_file(),
                f"Invalid or duplicate formal artifact: {relative}")
        require(path.stat().st_size == artifact["published_bytes"] and sha(path) == artifact["published_sha256"],
                f"Formal artifact differs from its provenance: {relative}")
        if path.suffix == ".lean":
            require(all(s["sha256"] == artifact["published_sha256"] for s in artifact["sources"]),
                    f"Frozen Lean source was transformed: {relative}")
        seen.add(relative)
    sources = {p.relative_to(ROOT).as_posix() for p in SOURCE.rglob("*.lean")}
    require(sources == {p for p in seen if p.endswith(".lean")}, "Unmanifested or missing Lean source")
    require(len(sources) == status["source_modules"] == 1008, "Unexpected frozen source count")
    require(set(provenance["entrypoints"]) == set(REQUIRED_MARKERS), "Audit entrypoints changed")
    covered_sources = set()
    for entry, expected in provenance["entrypoints"].items():
        graph = dependency_graph([entry])
        require(len(graph) == expected["modules"], f"Import closure changed: {entry}")
        paths = {n.replace(".", "/") + ".lean" for n in graph}
        require(paths == {p.replace("\\", "/") for p in expected["source_files"]}, f"Source closure mismatch: {entry}")
        covered_sources.update("formal/lean/" + p for p in paths)
    require(covered_sources == sources, "Published source is outside the requested audit closures")
    require(status["empty_game_lean"] == "NOT_VERIFIED" and
            not status["end_to_end_Lean_theorem_published"], "This frozen snapshot has no closed opening theorem")
    roots = status["closed_nonempty_original_game_proofs"]
    require([r["tiles"] for r in roots] == [12, 14, 20, 28, 30, 32, 34, 34], "Unexpected audited roots")
    require(len({r["physical_state"] for r in roots}) == len(roots), "Duplicate physical root")
    for row in roots:
        digits = row["physical_state"]
        require(len(digits) == 34 and all(c in "01234" for c in digits), "Invalid physical root")
        require(sum(map(int, digits)) == row["tiles"] and row["remaining_premises"] == [], "Invalid root scope")
    graph = status["empty_candidate_graph"]
    require(graph["status"] == "PARTIAL" and not graph["formal_proof"], "Candidate graph misrepresented as a proof")
    require(graph["expanded_nodes"] + graph["pending_nodes"] == graph["nodes"], "Candidate graph count mismatch")
    return provenance


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--check-only", action="store_true", help="Check source provenance and import closure without running Lean")
    parser.add_argument("--entry", choices=["all", "latest", *REQUIRED_MARKERS], default="all",
                        help="All published proofs, the latest milestones, or one named audit")
    parser.add_argument("--lean", default=os.environ.get("LEAN", "lean"), help="Lean 4.33.1 executable or elan proxy")
    parser.add_argument("--workers", type=int, choices=range(1, 5), default=2)
    parser.add_argument("--module-timeout", type=int, default=300)
    parser.add_argument("--memory-mb", type=int, default=3072,
                        help="Per-process Lean memory ceiling in MB (default: 3072)")
    parser.add_argument("--priority-module", action="append", default=[],
                        help="Check this module's dependencies first, while retaining the complete requested replay")
    parser.add_argument("--output", help="New output directory under this repository's build/ or runs/")
    parser.add_argument("--require-opening", action="store_true", help="Return 2 when the empty-position theorem remains unproved")
    args = parser.parse_args()
    require(args.module_timeout > 0, "Module timeout must be positive")
    require(args.memory_mb > 0, "Memory ceiling must be positive")
    provenance = check_snapshot()
    if args.check_only:
        print(json.dumps({"status": "PASS_ARTIFACT_INTEGRITY", "source_modules": 1008, "empty_game_lean": "NOT_VERIFIED"}))
        return 0
    lean = shutil.which(args.lean)
    require(lean is not None, "Lean not found; install the pinned toolchain or pass --lean")
    version = subprocess.check_output([lean, "--version"], cwd=SOURCE, text=True, timeout=30).strip()
    require(re.search(r"\b4\.33\.1\b", version), f"Expected Lean {VERSION}, got: {version}")
    entries = list(REQUIRED_MARKERS) if args.entry == "all" else [args.entry]
    if args.entry == "latest":
        entries = [entry for entry, meta in provenance["entrypoints"].items() if meta.get("generation") == "latest"]
    dependencies = dependency_graph(entries)
    priority = dependency_graph(args.priority_module)
    require(set(priority) <= set(dependencies), "Priority module is outside the requested proof closure")
    stamp = datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%S%fZ")
    destination = (ROOT / (args.output or f"runs/lean-{stamp}")).resolve()
    require(any(destination.is_relative_to(ROOT / folder) and destination != ROOT / folder
                for folder in ("build", "runs")), "Output must be a new child of build/ or runs/")
    destination.mkdir(parents=True, exist_ok=False)
    frozen, modules = destination / "source", destination / "modules"
    frozen.mkdir()
    modules.mkdir()
    source_hashes = {}
    for name in dependencies:
        relative = name.replace(".", "/") + ".lean"
        target = frozen / relative
        target.parent.mkdir(parents=True, exist_ok=True)
        shutil.copyfile(SOURCE / relative, target)
        source_hashes[relative] = sha(target)
    env = os.environ.copy()
    env["LEAN_PATH"] = str(modules)
    report = {
        "schema": "MJ_PUBLIC_LEAN_REPLAY_V1", "created_utc": datetime.now(timezone.utc).isoformat(),
        "lean_version": version, "trust_level": 0, "workers": args.workers, "entries": entries,
        "memory_mb_per_process": args.memory_mb,
        "source_sha256": source_hashes, "runner_sha256": sha(Path(__file__)),
        "total_modules": len(dependencies), "passed_modules": 0, "kernel_modules": "INCOMPLETE",
        "empty_game_lean": "NOT_VERIFIED", "steps": [],
        "scope": "Fresh kernel replay of the requested nonempty-position proofs. Does not read or assume the external P/N table.",
    }
    started = time.monotonic()

    def save():
        report["wall_seconds"] = round(time.monotonic() - started, 3)
        (destination / "result.json").write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")

    def check(name):
        relative = Path(name.replace(".", "/"))
        obj = modules / relative.with_suffix(".olean")
        obj.parent.mkdir(parents=True, exist_ok=True)
        log = destination / (name + ".log")
        command = [lean, "--trust=0", f"-M{args.memory_mb}", "-j1", "-R", str(frozen),
                   "-o", str(obj), str(frozen / relative.with_suffix(".lean"))]
        begin = time.monotonic()
        timeout = False
        with log.open("wb") as stream:
            try:
                result = subprocess.run(command, cwd=SOURCE, env=env, stdout=stream,
                                        stderr=subprocess.STDOUT, timeout=args.module_timeout,
                                        creationflags=subprocess.CREATE_NO_WINDOW if os.name == "nt" else 0)
                code = result.returncode
            except subprocess.TimeoutExpired:
                code, timeout = 124, True
        step = {"module": name, "return_code": code, "timeout": timeout,
                "wall_seconds": round(time.monotonic() - begin, 3),
                "log": log.name, "log_sha256": sha(log)}
        if code == 0:
            step["olean_sha256"] = sha(obj)
        return step

    order = list(priority) + [name for name in dependencies if name not in priority]
    passed, pending, active = set(), order, {}
    failed = False
    with ThreadPoolExecutor(max_workers=args.workers) as pool:
        while pending or active:
            if not failed:
                ready = [name for name in pending if set(dependencies[name]) <= passed]
                for name in ready[:args.workers - len(active)]:
                    active[pool.submit(check, name)] = name
                    pending.remove(name)
            if not active:
                break
            completed, _ = wait(active, return_when=FIRST_COMPLETED)
            for future in completed:
                name = active.pop(future)
                step = future.result()
                report["steps"].append(step)
                if step["return_code"] == 0:
                    passed.add(name)
                else:
                    failed = True
                    detail = (destination / step["log"]).read_text(encoding="utf-8", errors="replace")
                    print(f"Lean failure in {name}:\n{detail[-12000:]}", file=sys.stderr, flush=True)
                report["passed_modules"] = len(passed)
                save()
                if len(passed) % 20 == 0 or name in entries or step["return_code"] != 0:
                    print(json.dumps({"passed": len(passed), "total": len(dependencies), **step}), flush=True)
    if len(passed) == len(dependencies):
        report["audits"] = {}
        for entry in entries:
            log = (destination / (entry + ".log")).read_text(encoding="utf-8")
            match = re.search(r"AXIOM_AUDIT_PASS theorem_count=(\d+)", log)
            require(match is not None, f"Axiom audit did not pass: {entry}")
            expected_count = provenance["entrypoints"][entry]["audited_theorems"]
            require(int(match[1]) == expected_count, f"Audited declaration count changed: {entry}")
            for marker in REQUIRED_MARKERS[entry] + ["END_TO_END_NOT_VERIFIED"]:
                require(marker in log, f"Missing audit marker: {marker}")
            report["audits"][entry] = {"audited_theorems": int(match[1]), "status": "PASS"}
        report["source_unchanged"] = all(sha(frozen / rel) == expected for rel, expected in source_hashes.items())
        require(report["source_unchanged"], "Source changed during replay")
        report["kernel_modules"] = "PASS"
    report["exit_code"] = 1 if report["kernel_modules"] != "PASS" else (2 if args.require_opening else 0)
    save()
    print(json.dumps({k: report[k] for k in ["kernel_modules", "passed_modules", "total_modules", "empty_game_lean", "wall_seconds", "exit_code"]}), flush=True)
    print("Replay receipt: " + (destination / "result.json").relative_to(ROOT).as_posix(), flush=True)
    return report["exit_code"]


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except (OSError, ValueError, KeyError, subprocess.SubprocessError) as error:
        print(str(error), file=sys.stderr)
        raise SystemExit(1)
