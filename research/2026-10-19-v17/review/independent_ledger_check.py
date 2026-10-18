"""Independent read-only re-verification of the V17 production ledger.

Written separately from the project's finalize.py. Reads records only; writes nothing
inside the research tree.
"""
import hashlib, json, os, random, sys, collections

ROOT = sys.argv[1]
os.chdir(ROOT)
RUN = "runs/lean_table_checker/v17_compute_finish_20261018/full_native_20261018_02/"
NATIVE_SHA = "775e05d2601e30847b14b017cb542ea23a8b629d8ebd403aa07bd5942b78f667"

def sha_file(p):
    h = hashlib.sha256()
    with open(p, "rb") as f:
        for chunk in iter(lambda: f.read(1 << 20), b""):
            h.update(chunk)
    return h.hexdigest()

def load(p):
    with open(p, encoding="utf8") as f:
        return json.load(f)

problems = []
def need(cond, msg):
    if not cond:
        problems.append(msg)

manifest_sha = sha_file(RUN + "MANIFEST.json")
manifest = load(RUN + "MANIFEST.json")
plan = load(RUN + "PLAN.json")
inputs_before = manifest["inputs_before"]
need(sha_file(manifest["native"]["path"]) == NATIVE_SHA, "native executable hash differs now")

cells = {(c["layer"], c["honor"]): c for c in plan["cells"]}
nonempty = {k for k, c in cells.items() if c["size"] > 0}
need(len(cells) == 6440 and len(nonempty) == 3686, "plan cell counts")
need(sum(cells[k]["size"] for k in nonempty) == 778532864302, "plan total rows")

# 1. ledger hash chain
entries = [json.loads(line) for line in open(RUN + "ledger.jsonl", encoding="utf8")]
prev = "0" * 64
for i, e in enumerate(entries):
    need(e["sequence"] == i, f"sequence gap at {i}")
    need(e["previous_sha256"] == prev, f"hash chain break at {i}")
    need(e["manifest_sha256"] == manifest_sha, f"manifest sha differs at {i}")
    prev = e["entry_sha256"]

# 2-6. receipts
cursor = collections.defaultdict(int)
P = N = 0
source_ids = {}
target_refs = []  # (frame bucket, child honor, identity)
root_frames = []
native_results_checked = 0
seen = set()
for i, e in enumerate(entries):
    key = tuple(e["frame_key"])
    need(key not in seen, f"duplicate frame {key}")
    seen.add(key)
    rec = e["receipt"]
    raw = open(rec["path"], "rb").read()
    need(hashlib.sha256(raw).hexdigest() == rec["sha256"] and len(raw) == rec["bytes"], f"receipt file changed {key}")
    r = json.loads(raw)
    layer, honor, start, count = key
    need(r.get("status") == "COMMITTED_NATIVE_V17_FRAME", f"status {key}")
    need(r.get("native", {}).get("sha256") == NATIVE_SHA, f"native {key}")
    need(r.get("manifest_sha256") == manifest_sha, f"receipt manifest {key}")
    need((r["layer"], r["honor"], r["start"], r["count"]) == key, f"extent {key}")
    need(r["P_rows"] + r["N_rows"] == count, f"P+N {key}")
    need(r.get("no_old_acceptance_imported") is True, f"old import {key}")
    acc = r.get("acceptances", {})
    need(all(acc.get(k) is True for k in ("base", "successors", "metadata", "frames", "target_identity")), f"acceptances {key}")
    need(acc.get("root_P") is ((layer, honor) == (0, 0)), f"root flag {key}")
    # native result record
    nr = r["native_result"]
    nraw = open(nr["path"], "rb").read()
    need(hashlib.sha256(nraw).hexdigest() == nr["sha256"], f"native result changed {key}")
    n = json.loads(nraw)
    need(n.get("status") == "PASS_NATIVE_V17_FRAME" and n.get("frameAccepted") is True, f"native frame not PASS {key}")
    need((n["layer"], n["honor"], n["start"], n["count"]) == key and n["P_rows"] == r["P_rows"], f"native extent/P {key}")
    native_results_checked += 1
    # coverage
    need(start == cursor[(layer, honor)], f"gap/overlap {key}")
    cursor[(layer, honor)] = start + count
    P += r["P_rows"]; N += r["N_rows"]
    # identities
    sid = json.dumps(r["source_identity"], sort_keys=True)
    if (layer, honor) in source_ids:
        need(source_ids[(layer, honor)] == sid, f"source identity changes inside bucket {key}")
    else:
        source_ids[(layer, honor)] = sid
        cell = cells[(layer, honor)]
        s = r["source_identity"]
        need(s["bits"]["path"] == cell["bits"] and s["directory"]["path"] == cell["directory"], f"source paths differ from plan {key}")
        for fld in ("bits", "directory", "groups", "ids", "numeric"):
            rec2 = s[fld]
            need(inputs_before.get(rec2["path"], {}).get("sha256") == rec2["sha256"], f"source {fld} hash not in input map {key}")
    expected_children = sorted(h for h in cells[(layer, honor)]["needed_honors"]
                               if layer < 34 and cells.get((layer + 1, h), {"size": 0})["size"] > 0)
    got_children = sorted(int(h) for h in r["target_identities"])
    need(got_children == expected_children, f"target honors differ {key}")
    for h, ident in r["target_identities"].items():
        target_refs.append(((layer, honor), (layer + 1, int(h)), json.dumps(ident, sort_keys=True)))
    if (layer, honor) == (0, 0):
        root_frames.append((r, n))

complete = [k for k in nonempty if cursor.get(k, 0) == cells[k]["size"]]
need(len(complete) == 3686, f"complete buckets {len(complete)}")
need(set(cursor) <= nonempty, "frames outside nonempty cells")
need(P + N == 778532864302, "total rows")

# cross-layer: each target identity equals the identity recorded when that child bucket was itself checked
mismatch = 0
for parent, child, ident in target_refs:
    if source_ids.get(child) != ident:
        mismatch += 1
need(mismatch == 0, f"cross-layer identity mismatches: {mismatch}")

# root
need(len(root_frames) == 1, "root frames")
root_cell = cells[(0, 0)]
rb = open(root_cell["bits"], "rb").read()
need(len(rb) == 8 and hashlib.sha256(rb).hexdigest() == inputs_before[root_cell["bits"]]["sha256"], "root bits file identity")
root_bit = rb[0] & 1
need(root_bit == 1, "root bit is not P")
if root_frames:
    need(root_frames[0][0]["P_rows"] == 1, "root frame P count")

# post-run input identity record equals pre-run map
after = load(load(RUN + "INPUTS_AFTER.json")["identity_record"]["path"])
need(after.get("files") == inputs_before, "post-run input map differs from pre-run map")

# sample re-hash of actual input files
random.seed(20261019)
small = [p for p, v in inputs_before.items() if v["bytes"] <= 8_000_000]
sample = random.sample(small, min(60, len(small))) + [root_cell["bits"]]
medium = [p for p, v in inputs_before.items() if 50_000_000 <= v["bytes"] <= 400_000_000]
if medium:
    sample.append(random.choice(medium))
rehash_bad = [p for p in sample if sha_file(p) != inputs_before[p]["sha256"]]
need(not rehash_bad, f"re-hash mismatches: {rehash_bad[:5]}")

print("ledger entries:", len(entries), "| native results checked:", native_results_checked)
print("complete nonempty buckets:", len(complete), "/ 3686")
print("rows:", P + N, " P:", P, " N:", N)
print("cross-layer target references checked:", len(target_refs), "mismatches:", mismatch)
print("root bit:", root_bit, "(1 = P) | root frames:", len(root_frames))
print("input files re-hashed now:", len(sample), "| mismatches:", len(rehash_bad),
      "| bytes re-hashed:", sum(inputs_before[p]["bytes"] for p in sample))
print("problems:", len(problems))
for p in problems[:20]:
    print("  PROBLEM:", p)
