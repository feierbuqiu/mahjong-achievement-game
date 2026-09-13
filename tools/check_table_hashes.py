#!/usr/bin/env python3
"""Stream the external table and compare the published per-bucket SHA-256 values."""
import argparse
import hashlib
import json
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[1]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--data", type=Path, required=True)
    args = parser.parse_args()
    total = 0
    count = 0
    with (ROOT / "results/table-sha256.jsonl").open(encoding="utf-8") as source:
        for line in source:
            row = json.loads(line)
            path = args.data / f"n{row['n']:02d}_h{row['h']:03d}.bits"
            if not path.is_file() or path.stat().st_size != row["bytes"]:
                raise ValueError(f"Missing file or wrong size: {path}")
            h = hashlib.sha256()
            with path.open("rb") as payload:
                for chunk in iter(lambda: payload.read(8 * 1024 * 1024), b""):
                    h.update(chunk)
                    total += len(chunk)
            if h.hexdigest() != row["sha256"]:
                raise ValueError(f"Payload SHA-256 mismatch: {path}")
            count += 1
            if count % 100 == 0:
                print(json.dumps({"verified_files": count, "bytes_read": total}), flush=True)
    if count != 3686 or total != 97316623312:
        raise ValueError("Manifest does not cover the complete expected payload")
    print(json.dumps({"status": "PASS", "files": count, "bytes": total,
                      "scope": "Payload identity only; not a recurrence proof"}))


if __name__ == "__main__":
    try:
        main()
    except (OSError, ValueError, KeyError) as exc:
        print(str(exc), file=sys.stderr)
        raise SystemExit(1)
