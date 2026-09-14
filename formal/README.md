# Lean verification progress

> **September 14, 2026: the maintainer's personal verification effort is
> paused.** The empty-position theorem remains `NOT_VERIFIED`. The
> [latest handoff](../research/2026-09-14/README.md) records the later local
> registry of 24,655 P states, completed compiled checks of layers 34 and 33,
> hardware benchmarks, and the remaining work. This page documents the frozen
> September 13 concrete-proof package, whose replay and CI remain available.

**Eight concrete nonempty roots are indexed, including the new 12- and 14-tile strategies.
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
| 12 | `0000000020000011110001110300000000` | [`Mahjong.Scale12V2.original_second_player_wins`](lean/MahjongScale/Actual12V2/Root.lean) |
| 14 | `0000011110001000020001120300000000` | [`Mahjong.Actual14.original_second_player_wins`](lean/MahjongNext/Actual14/Root.lean) |
| 20 | `0110330311010110001010110000000000` | [`Mahjong.AnchorDAG.N24086.original_second_player_wins`](lean/Mahjong/AnchorDAG/N24086.lean) |
| 28 | `0110440411010110101010110000001111` | [`Mahjong.AnchorDAG.N09818.original_second_player_wins`](lean/Mahjong/AnchorDAG/N09818.lean) |
| 30 | `0110440411010110111010110000011111` | [`Mahjong.AnchorDAG.N02076.original_second_player_wins`](lean/Mahjong/AnchorDAG/N02076.lean) |
| 32 | `1010110110000440411010110111111111` | [`Mahjong.Extracted32.original_second_player_wins`](lean/Mahjong/Extracted32/Root.lean) |
| 34 | `1010440410110110111010110111111111` | [`Mahjong.ExtractedFresh34.original_second_player_wins`](lean/Mahjong/ExtractedFresh34/Root.lean) |
| 34 | `0110440411010110111010110111111111` | [`Mahjong.ActualCertificateSmoke.candidate_original_second_player_wins`](lean/Mahjong/ActualCertificateSmoke.lean) |

The 28- and 30-tile roots and the earlier 34-tile anchor were already present
in the previous source; listing them here does not make them newly proved.

The new 12-tile certificate has **757 P rows** and covers **25,510 legal first
actions**: 20,867 winning replies, 4,563 internal references, and 80 references
to 11 proved boundary states. Its SAFE bounds include 86 independently checked
leaves. The [typed registry](lean/MahjongScale/Actual12Registry.lean) exposes
all 757 proved rows; JSON lookup metadata alone is not a logical premise.
The 14-tile proof has 50 P rows and 1,700 first actions.

The original 20-tile proof closes a selected graph of 610 P nodes and seven two-ply
response levels. The 32-tile proof checks the transformation back to the
original physical coordinates. New response selection compresses the same
20-tile root to 24 P rows: see the [whole-table proof](lean/MahjongNext/ResponseTableFull20.lean)
and [grouped proof](lean/MahjongNext/Grouped20/Root.lean). The fresh 34-tile proof uses its own generated
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
modules with `--trust=0 -M3072 -j1`, using only newly built project modules on
`LEAN_PATH`. No saved project `.olean`, external P/N table, or candidate-graph
database is required. Logs and a machine-readable receipt are written under
`runs/`. The memory ceiling is 3 GB per Lean process and can be set with
`--memory-mb`. A 2 GB ceiling failed on the Linux capacity-cache module;
allow at least 8 GB of available memory for two workers, or use `--workers 1`.
The ceiling does not change the kernel trust level or omit any proof check.

To check the **374-module closure of the latest milestones**, including the
12-tile theorem, the registry, the 14-tile theorem and both compressed 20-tile proofs:

```bash
python3 tools/verify_lean.py --entry latest --workers 2
```

To check only the small, independently generated 34-tile pipeline:

```bash
python3 tools/verify_lean.py --entry PipelineAudit --workers 1
```

The full command compiles **1,008 distinct modules** across seven audit
entrypoints. Individual closures overlap; the runner compiles shared dependencies
once per fresh run. The audit
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

A [fresh publication replay](evidence/latest-cold-replay.json) passed all
374 modules of the new milestone closure, with two workers, Lean 4.33.1,
trust level 0, no reused project objects, and 710.516 seconds wall time on
the recorded Windows environment. All five new audit entrypoints passed.
This is separate from the earlier mixed-reuse timings below.

The latest historical 12-tile audit passed 326 modules: 231 reused and 95
newly compiled, in 67.266 seconds. Its peak sampled aggregate private memory
was 12,719,529,984 bytes across at most nine Lean processes. This is **not a
cold replay timing**. A later dependency-exact audit and registry audit are
published as [Scale12Audit](evidence/Scale12Audit.json) and
[ScaleRegistryAudit](evidence/ScaleRegistryAudit.json). The 14-tile
[historical audit](evidence/Actual14Audit.json) likewise mixed 15 reused and
25 new modules. The public commands above always build fresh project objects.

The following earlier records remain part of the evidence:

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

The September 13 frozen candidate graph contains **9,765,237 nodes** and
**16,179,951 edges**: 6,911,482 nodes expanded and 2,853,755 discovered nodes
pending. Layer 12 is expanded, layer 13 is partial, and layer 14 has pending
nodes. Its 2,119,254,016-byte SQLite checkpoint remains outside Git.
This graph is **`PARTIAL`, not a Lean proof**. Expansion can discover further
nodes, so its pending count is not a completion percentage.

The 10-tile ancestor probe remains partial: 112,490 nodes, 33,127 expanded,
79,363 pending. No closed 10-tile theorem is claimed. Measured compact-storage
speed-ups and candidate expansion rates concern native candidate generation,
not Lean certification throughput. The [English paper](../papers/manuscript.md)
and [machine-readable status](STATUS.json) explain these boundaries.

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
