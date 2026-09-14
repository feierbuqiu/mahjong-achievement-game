#!/usr/bin/env python3
"""Check published bytes, evidence consistency, English content, and local links."""
import hashlib
import json
from pathlib import Path
import re
import subprocess
import sys
from urllib.parse import unquote
from verify_lean import check_snapshot
from verify_paper import verify as verify_paper
from verify_lean_supplement import verify as verify_lean_supplement

ROOT = Path(__file__).resolve().parents[1]


def require(value, message):
    if not value:
        raise ValueError(message)


def read_json(rel):
    return json.loads((ROOT / rel).read_text(encoding="utf-8"))


def read_lines(rel):
    return [json.loads(line) for line in (ROOT / rel).read_text(encoding="utf-8").splitlines() if line.strip()]


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    manifest = ROOT / "CHECKSUMS.sha256"
    require(manifest.is_file(), "Missing distributed-artifact checksum manifest")
    hashed = set()
    for line in manifest.read_text(encoding="utf-8").splitlines():
        expected, rel = line.split("  ", 1)
        require(rel not in hashed, f"Duplicate checksum entry: {rel}")
        path = (ROOT / rel).resolve()
        require(path.is_relative_to(ROOT) and path.is_file(), f"Invalid artifact path: {rel}")
        require(sha(path) == expected, f"Checksum mismatch: {rel}")
        hashed.add(rel)
    for row in read_json("results/publication-provenance.json")["artifacts"]:
        path = ROOT / row["published_path"]
        require(path.stat().st_size == row["published_bytes"], f"Wrong artifact size: {path.name}")
        require(sha(path) == row["published_sha256"], f"Provenance mismatch: {path.name}")

    status = read_json("RESEARCH_STATUS.json")
    acceptance = read_json("results/acceptance.json")
    expected = 778532864302
    require(status["opening_outcome"] == acceptance["empty_state"] == "P", "Opening mismatch")
    require(status["first_move_orbit_outcomes"] == ["N"] * 6, "First-move mismatch")
    require(status["SAFE_symmetry_orbits"] == acceptance["states"] == expected, "State count mismatch")
    require(status["P_orbits"] + status["N_orbits"] == expected, "P/N total mismatch")
    require(not status["formal_verification"]["end_to_end_Lean_theorem_published"], "This snapshot has no published end-to-end Lean theorem")
    check_snapshot()
    verify_paper()
    verify_lean_supplement()
    formal = read_json("formal/STATUS.json")
    require(status["formal_verification"]["closed_nonempty_original_game_roots_published"] ==
            len(formal["closed_nonempty_original_game_proofs"]) == 8, "Formal root count mismatch")
    coverage = read_json("results/replay-coverage.json")
    rows = coverage["coverage"]["records"]
    require(coverage["full_run"]["full_run_pass"] and coverage["coverage"]["full_record_coverage"], "Replay incomplete")
    require(coverage["coverage"]["error_count"] == 0, "Replay has errors")
    require(len(rows) == len({(r["n"], r["h"]) for r in rows}) == 3686, "Duplicate/missing replay buckets")
    require(sum(r["states"] for r in rows) == expected, "Replay state sum mismatch")
    require(sum(r["P"] for r in rows) == status["P_orbits"], "Replay P sum mismatch")
    require(all(r["P"] + r["N"] == r["states"] for r in rows), "Invalid per-bucket P/N total")
    require(coverage["coverage"]["complete_layers"] == list(range(35)), "Layer coverage incomplete")
    tables = read_lines("results/table-sha256.jsonl")
    require(len(tables) == len({(r["n"], r["h"]) for r in tables}) == 3686, "Duplicate/missing table hashes")
    require(sum(r["bytes"] for r in tables) == status["table_payload_bytes"], "Payload sum mismatch")
    require(sum(r["states"] for r in tables) == expected, "Payload state count mismatch")
    by_bucket = {(r["n"], r["h"]): r for r in rows}
    for row in tables:
        other = by_bucket[(row["n"], row["h"])]
        require(row["status"] == "PASS" and row["tail_padding_zero"], "Incomplete integrity record")
        require(row["states"] == other["states"] and row["p_states"] == other["P"], "Integrity/replay discrepancy")
        require(row["bytes"] == ((row["states"] + 63) // 64) * 8, "Wrong padded byte count")
    opening = read_lines("results/opening.jsonl")
    queries = [r for r in opening if r["kind"] == "query"]
    require(len(queries) == 7 and queries[0]["outcome"] == "P", "Opening query coverage mismatch")
    require(all(r["outcome"] == "N" and r["recurrence_check"] == "PASS" for r in queries[1:]), "First-move query failure")
    oracles = read_lines("results/historical-oracles.jsonl")
    checks = [r for r in oracles if r["kind"] == "oracle"]
    require(len(checks) == 16240 and all(r["status"] == "MATCH" for r in checks), "Historical oracle mismatch")

    tracked = subprocess.check_output(["git", "ls-files", "--cached", "--others", "--exclude-standard", "-z"], cwd=ROOT)
    files = sorted(set(p.decode("utf-8") for p in tracked.split(b"\0") if p))
    for rel in files:
        path = ROOT / rel
        if not path.is_file():
            continue
        require(path.stat().st_size < 50_000_000, f"Unexpected large artifact: {rel}")
        data = path.read_text(encoding="utf-8-sig")
        language_text = data
        if rel in {"papers/manuscript.md", "papers/evidence/reference_verification.md",
                   "papers/lean-verification/manuscript.md", "papers/lean-verification/reference_verification.md"}:
            # Preserve the author's original source credit and bibliographic title.
            for proper_name in ["\u96f6\u4e4b\u5ba1\u5224\u8005", "\u5446\u997c\u95ee\u9898"]:
                language_text = language_text.replace(proper_name, "")
        require(not re.search(r"[\u3400-\u4dbf\u4e00-\u9fff]", language_text), f"Non-English CJK content: {rel}")
        require(not re.search(r"[A-Za-z]:[\\/](?:Users|home)[\\/]", data), f"Private workstation path: {rel}")
        require(not re.search(r"-----BEGIN (?:OPENSSH |RSA |EC )?PRIVATE KEY-----|gh[pousr]_[A-Za-z0-9]{30,}", data), f"Potential secret: {rel}")
        if path.suffix == ".md":
            for target in re.findall(r"\]\(([^\s)]+)\)", data):
                if re.match(r"[a-zA-Z]+:", target) or target.startswith("#"):
                    continue
                target = unquote(target.split("#", 1)[0])
                require((path.parent / target).exists(), f"Broken local link in {rel}: {target}")
    print(json.dumps({"status": "PASS", "distributed_artifacts_hashed": len(hashed),
                      "replay_buckets": len(rows), "SAFE_states": expected, "historical_matches": len(checks),
                      "files_checked": len(files), "lean_source_modules": formal["source_modules"],
                      "scope": "Published artifact and receipt consistency; no external table replay or Lean kernel replay"}))


if __name__ == "__main__":
    try:
        main()
    except (OSError, ValueError, KeyError, subprocess.CalledProcessError) as exc:
        print(str(exc), file=sys.stderr)
        raise SystemExit(1)
