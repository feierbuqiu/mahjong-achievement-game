# Data availability

Both [English research papers](../papers/README.md), their English audit memos,
and selected progress/reproduction receipts are distributed with v1.0.0.
The [paper source catalogue](../papers/evidence/README.md) separates public
copies from retained historical sources and records original/public hashes.
The Chinese manuscript, original-language historical notes, large SQLite
candidate checkpoints, compiler objects and toolchains are excluded.

The [September 14 handoff](../research/2026-09-14/README.md) adds a frozen
56-module checker source archive, current hardware specifications, selected
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
for the completed stage and future maintenance scope.

The latest [formal source](../formal/README.md) contains the complete replay
closure for the new 12-tile and 14-tile roots, the compressed 20-tile proof,
and the 757-entry proved registry. These additions belong to the current
publication; the original signed `v0.1.0` tag continues to identify its earlier
computational snapshot.

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

## Retained outside Git

The complete padded table payload is **97,316,623,312 bytes**. It is not included
in this Git repository or offered as a public download in version 0.1.0.
No external archive, DOI, or permanent table-hosting service is claimed.
Historical large search caches, the incomplete opening candidate-graph database,
and the full Lean working environment are also outside this publication.
The completed formal source snapshot is included; compiled Lean modules and
the Lean toolchain binaries are not stored in Git.

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
