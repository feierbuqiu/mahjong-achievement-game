# Data availability

Both [English research papers](../papers/README.md), their English audit memos,
and selected progress/reproduction receipts are distributed with v1.0.0.
The [paper source catalogue](../papers/evidence/README.md) separates public
copies from retained historical sources and records original/public hashes.
The Chinese manuscript, original-language historical notes, large SQLite
candidate checkpoints, compiler objects and toolchains are excluded.

The [September 14 handoff](../research/2026-09-14/README.md) adds a frozen
56-module checker source archive, hardware specifications recorded on that date, selected
compiled-scan receipts and all 47 general-benchmark case receipts. Its
[manifest](../research/2026-09-14/provenance.json) explicitly identifies retained
input binaries, controllers and later concrete proof trees. The paused local
registry's 24,655 P states are a recorded local milestone; the public concrete
proof replay still covers the eight indexed roots below.

The [September 15 status update](../research/2026-09-15/README.md) supplies
84 Lean modules forming the dependency closure of the finite algorithm
entry point, selected unmodified acceptance/build/test records, seven C++
source fragments, and a hash/receipt checker with optional fresh kernel replay.
Its [manifest](../research/2026-09-15/provenance.json) identifies every public
copy. The 5,329 files named by the original local acceptance record are not
all distributed: native test inputs, compiled objects, operational harnesses
and the complete intermediate evidence chain remain outside this package.
The [new Lean paper](../papers/lean-verification/manuscript.md) and its
[supporting records](../papers/lean-verification/README.md) are now published.
The release also supplies the exact tested 175,554-byte standalone model-source
ZIP as a separate asset; its [identity and scope](../papers/lean-verification/companion.json)
distinguish it from the full source ZIP and Git history bundle. The two new
paper-preparation replay receipts concern the same 84-module closure and do
not add historical P/N coverage. See [project status](PROJECT_STATUS.md)
for the current outlook and the subsequent October progress.

The September concrete [formal source](../formal/README.md) contains the complete replay
closure for the new 12-tile and 14-tile roots, the compressed 20-tile proof,
and the 757-entry proved registry. These additions belong to the current
publication; the original signed `v0.1.0` tag continues to identify its earlier
computational snapshot.

## Later October kernel-certificate materials

The [historical kernel-certificate update](../research/2026-10-18-kernel/README.md)
adds the V17 generic bridges, V18 closed pilot sources, and selected completed
V19 numeric/layout/local-certificate sources and receipts. It preserves failed
attempt records and separates original hashes from path-redacted public copies.
The V17/V18 source-import map reuses the earlier 132-module base; the V19 public
subset explicitly lists unresolved dependencies and is not a complete portable
replay bundle. Binary-emitted Nat data, saved .olean module parts, toolchains,
raw banks and some reconstruction inputs remain outside Git.

Cold-replay sizes and timings describe the original retained bundles. The
publication helper validates public bytes and receipt consistency; it does not
rerun the proofs. The [earlier V16 archive](../research/2026-10-18/README.md) and
its native-execution forecast remain dated evidence for a different workload.

## October 18 post-release materials

The [October update](../research/2026-10-18/README.md) adds the 132 linked V16
Lean sources, 104 selected recorded theorem/axiom fingerprints and their
existing logs, selected controller/cost-model/GPU source, all 34 calibration
cases, resource and production-control receipts, and the layer-32 audit.
Its [provenance](../research/2026-10-18/provenance.json) separates original
hashes from public hashes after private-path removal and one English display
translation. This publication performs no new Lean or whole-table run.

The supplied campaign plan and receipt indexes also name retained inputs.
Those references do not imply that the 97.32 GB table, executable workers,
compiled objects, complete finite-input banks or all historical evidence
files are downloadable here. The full local expected-input inventory names
23,905 items / 100,500,253,135 bytes; it is retained separately. Original-language
audit documents are catalogued and summarized in English. This is an
inspectable source/evidence update, not a complete portable GPU campaign.

## Included in this repository

- Frozen core rules, compact index, forward generator, reverse verifier,
  index checks, table-query code, and an English physical-strategy adapter.
- The computational acceptance extract and seven opening query results.
- Complete per-bucket replay coverage and original record hashes.
- All 16,240 historical expected values, their provenance records, and query results.
- Per-bucket table SHA-256 values, integrity-audit summary, build provenance,
  and measured generation/replay receipts.
- Source/artifact checksums and scripts for bounded checks and full reconstruction.
- Frozen Lean 4.33.1 source for eight indexed closed nonempty-position roots, historical
  kernel-replay extracts, and a clean source-replay tool. See [formal materials](../formal/README.md).

## October 19 completed V17 native verification

The [current V17 publication](../research/2026-10-19-v17/README.md) adds the
native-worker/main/replay source, a 148-file source map reusing earlier exact
sources, the trusted bookkeeping code, recorded build/control evidence and
the original separate AI review with its Appendix B script. Public JSON copies
redact identifying paths where necessary and retain original/public hashes.

The **63,456,055-byte saved-record ZIP** is a separate
[evidence release asset](../research/2026-10-19-v17/assets.json). It contains
38,329 original files: the ledger, all 17,317 committed frame receipts, all
17,317 native results, bucket/global records, run manifests, before/after
input identities and the eight-byte empty-root payload. Every member has a
hash in its contents manifest. It contains no full input dataset, toolchain,
native executable, closed actual-input Lean proof or Chinese manuscript.
The code repository retains the asset size/SHA-256 and a bounded verifier.
See [artifact policy](ASSETS.md) for download verification and retention rules.

All **11,272 input identities / 100,615,834,170 bytes** are listed in
[inputs.json](../research/2026-10-19-v17/inputs.json). The actual full dataset
is **not currently a public download**. Local portable archives were still
in progress at capture and are not published as completed packages. The
historical full P/N table is the main part of this input set; it is not an
additional 97.32 GB to add to the 100.62 GB figure.

## Retained outside Git

The complete padded P/N table payload is **97,316,623,312 bytes**. It is not
stored in Git or supplied as a public full-table download by this update.
The saved-record evidence archive above is much smaller and has a different
purpose. No external permanent table archive, DOI or completed all-input
native-reproduction installer is claimed.
Historical large caches, incomplete candidate-graph databases, most binary
metadata banks, native/toolchain binaries and the full Lean working environment
remain outside this publication. Exact source is supplied for the mapped
modules; selected V19 extracts retain their explicitly incomplete distribution.

The full table is reconstructible using the [documented generator](REPRODUCIBILITY.md).
Plan for at least 110 GB of free output storage, with additional space for
logs and any retained checkpoints. Avoid full generation in a synchronizing
folder. Use a new output directory for each independent run.

## Validating a reconstructed table

Run the full reverse replay, query the opening, and compare the historical
fixtures. Use `tools/check_table_hashes.py` to compare bucket payloads with
the published SHA-256 manifest. The payload encoding is deterministic for
the published index and values; timestamps, build IDs, and timing fields in
new metadata will differ from the original run.

Individual `nNN_hHHH.bits` files contain padded little-endian 64-bit words,
where bit 1 is P and bit 0 is N. A bucket's corresponding `.complete.json`
and its layer's completion metadata are required by the table reader.
Do not interpret an absent, partial, incompatible, or corrupt bucket as P.

The publication checksum manifest validates the **distributed artifacts**.
The table manifest validates the **external payload files**. Neither operation
alone checks the P/N recurrence.
