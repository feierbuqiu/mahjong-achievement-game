# Data availability

The [primary English paper](../papers/manuscript.md), its English audit memos,
and selected later progress receipts are distributed with this checkout.
The [paper source catalogue](../papers/evidence/README.md) separates public
copies from retained historical sources and records original/public hashes.
The Chinese manuscript, original-language historical notes, large SQLite
candidate checkpoints, compiler objects and toolchains are excluded.

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
- Frozen Lean 4.33.1 source for three closed nonempty-position proofs, historical
  kernel-replay extracts, and a clean source-replay tool. See [formal materials](../formal/README.md).

## Retained outside Git

The complete padded table payload is **97,316,623,312 bytes**. It is not included
in this Git repository or offered as a public download in version 0.1.0.
No external archive, DOI, or permanent table-hosting service is claimed.
Historical large search caches, the incomplete opening candidate-graph database,
and the active Lean working environment are also outside this publication.
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
