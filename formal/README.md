# Lean verification progress

**Three concrete nonempty positions now have closed original-game theorems.
The empty-position Lean theorem remains `NOT_VERIFIED`.**

This update publishes the frozen source of the completed September 13, 2026
Lean work. The earlier signed `v0.1.0` tag remains the computational release.
The computational opening result is still P, implying a second-player win;
the new local proofs do not complete its formal verification.

## Closed theorems

Each theorem has type `SafeGame.SecondPlayerWins Step Win state` for the
specified physical state, with no remaining certificate or external-table
correctness premise. The digit order is 1m through 9m, 1p through 9p, 1s
through 9s, then East, South, West, North, White, Green, Red.

| Tiles | Physical state | Theorem |
| ---: | --- | --- |
| 20 | `0110330311010110001010110000000000` | [`Mahjong.AnchorDAG.N24086.original_second_player_wins`](lean/Mahjong/AnchorDAG/N24086.lean) |
| 32 | `1010110110000440411010110111111111` | [`Mahjong.Extracted32.original_second_player_wins`](lean/Mahjong/Extracted32/Root.lean) |
| 34 | `1010440410110110111010110111111111` | [`Mahjong.ExtractedFresh34.original_second_player_wins`](lean/Mahjong/ExtractedFresh34/Root.lean) |

The 20-tile proof closes a selected graph of 610 P nodes and seven two-ply
response levels. The 32-tile proof checks the transformation back to the
original physical coordinates. The fresh 34-tile proof uses its own generated
SAFE leaf and does not import the earlier endgame anchor.

The source includes concrete winning predicates, the SAFE reduction, move
enumeration, symmetry transport, SAFE certificates, and response certificates.
A response certificate covers every legal opponent addition with an immediate
winning reply or a return to a proved P position. SAFE is proved separately
to exclude an opponent win on the first addition. See
[ResponseCertificate](lean/Mahjong/ResponseCertificate.lean),
[its counterexample test](lean/Mahjong/ResponseCertificateTest.lean), and
[the original-game bridge](lean/Mahjong/Bridge.lean).

## Reproduce from source

Use Python 3.10+ and **Lean 4.33.1**. Only the Lean distribution's standard
libraries are needed; there are no Mathlib or other Lake package dependencies.
The [toolchain receipt](evidence/toolchain.json) records official Windows and
Linux download URLs and SHA-256 values. With Lean available on `PATH`, run
from the repository root:

```bash
python3 tools/verify_repository.py
python3 tools/verify_lean.py --workers 2
```

For an explicit installation, pass `--lean /path/to/lean`. On Windows use the
available Python command and the path to `lean.exe`. With elan, the tool runs
Lean from the directory containing the pinned `lean-toolchain` file.

The public runner first verifies the source hashes and dependency closures,
then copies the source into a new output directory. It compiles the requested
modules with `--trust=0 -M2048 -j1`, using only newly built project modules on
`LEAN_PATH`. No saved project `.olean`, external P/N table, or candidate-graph
database is required. Logs and a machine-readable receipt are written under
`runs/`. Two workers can use several GB of memory; use `--workers 1` when needed.

To check only the small, independently generated 34-tile pipeline:

```bash
python3 tools/verify_lean.py --entry PipelineAudit --workers 1
```

The full command compiles 686 distinct modules. The two entry-point closures
contain 680 and 20 modules respectively, with 14 shared modules. The audit
checks the exact theorem types and their transitive axioms. Only `propext`,
`Classical.choice`, and `Quot.sound` are allowed. No `sorry`, `native_decide`,
or additional axiom is accepted in these theorems.

Exit 0 means the **requested nonempty-position proofs passed**. The receipt
still says `empty_game_lean: NOT_VERIFIED`. Add `--require-opening` to return
exit 2 when the opening remains unproved. `--check-only` checks artifact
integrity without invoking Lean and does not count as a kernel replay.

The `Lean kernel (nonempty proofs)` CI job runs the complete public command.
Its success is scoped to these published proofs, not the opening.

## Recorded kernel replays

| Frozen replay | Modules passed | Audited theorem declarations | Recorded wall time |
| --- | ---: | ---: | ---: |
| [Main certificate chain](evidence/kernel_v1.json) | 680 / 680 | 14,760 | 548.516 s |
| [Fresh-leaf pipeline](evidence/pipeline_kernel_v1.json) | 20 / 20 | 522 | 33.797 s |

These historical runs used four workers and Lean's trust level 0. Their
runner returned 2 to preserve the incomplete-opening boundary; every Lean
module returned 0. The counts overlap and include generated declarations.
They are not counts of independent game positions or an estimate of global
formalization progress. Timing depends on hardware and does not predict
another machine's runtime.

The [provenance manifest](provenance.json) maps all imported sources and
receipt extracts to original paths and hashes. Lean source bytes and final
audit logs are unchanged. Receipt extracts omit private workstation paths,
process IDs, and compiled artifacts. Original receipt hashes identify the
original files; distributed hashes identify the public copies.

## Opening progress and remaining work

The last completed candidate-extraction snapshot contains 4,658,934 nodes
and 6,821,377 edges: 791,352 nodes expanded and 3,867,582 pending. Layers 0
through 11 are expanded, layer 12 is partial, and layer 13 has discovered
nodes. This graph is **`PARTIAL`, not a Lean proof**. Its P/N labels come from
the existing computational table. Expansion can discover more nodes, so the
pending count is not the total remaining proof work or a completion percentage.

To close the opening, the project must:

1. Produce a closed strategy graph from the empty state, or a smaller equivalent
   certificate.
2. Generate and kernel-check all required SAFE leaves, physical responses, and
   symmetry references.
3. Audit a premise-free theorem of
   `SafeGame.SecondPlayerWins Step Win empty`.

The original candidate database and ongoing working environment remain outside
Git. This publication contains completed proof source, reproducible checks,
and [machine-readable progress](STATUS.json). It does not claim a completed
formal opening proof or third-party contest acceptance.
