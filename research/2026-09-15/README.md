# Lean status: September 15, 2026

**The maintainer will not undertake further end-to-end or full-scale Lean
closure verification.** Contributors with the necessary formal-methods
expertise, algorithmic ideas and suitable compute are welcome to continue.
**The repository remains open to updates.** This status synchronization creates
no release or tag and does not freeze current work. A separate Lean progress
report is planned; the existing [English paper](../../papers/manuscript.md)
retains its September 13 date.

## Current result and proof boundary

The computational conclusion remains **P at the empty position: the second
player wins under optimal play**, with all six first-move classes N and a
complete reverse replay of 778,532,864,302 SAFE orbits with zero mismatches.
The two implementations share rules and indexing. The empty-position and
10-tile Lean winner theorems remain **`NOT_VERIFIED`**.

| Evidence route | Current scope |
| --- | --- |
| Published concrete kernel proofs | Eight nonempty roots; the September 13 package has 1,008 modules |
| Later retained local P registry | 24,655 recorded P states; its complete later proof trees are outside Git |
| Complete compiled-Lean P/N checks | Layers 34 and 33: 22,512,356 unique historical rows, unchanged |
| Latest finite algorithm models | 10 core modules and 79 audited theorems; an 84-module dependency closure is published here |
| Latest production-routine tests | 102 synthetic configurations across 11 small buckets; 13,741,216 row comparisons and zero mismatches |
| New historical P/N coverage from the latest work | **0 rows** |

The latest [acceptance record](evidence/acceptance.json) is dated
September 14 at 16:38:57 UTC (September 15 in Sydney). It covers successor-list
models, duplicate-suit skipping, two-swap sorting, MovePlans offsets, cache
write coverage, zero/all-P bucket shortcuts, early exit, layer ordering and
64-bit chunk ownership. The reported theorem audit uses Lean 4.33.1 with
`--trust=0 -M3072 -j1` and only `propext`, `Classical.choice` and `Quot.sound`.

[`Mahjong.LayeredRetrograde.bottom_up_correct`](lean/Mahjong/LayeredRetrograde.lean)
starts from an empty **model** table and proves correct bottom-up labels under
complete enumeration and successors, decreasing edge rank, and valid processing
order. [`Mahjong.OptimizedRowBridge.optimized_cached_step`](lean/Mahjong/OptimizedRowBridge.lean)
connects a modeled cached row to the original SAFE game under explicit layout,
bucket-count, address-validity and child-strategy premises. These premises have
not been combined into a fully instantiated certificate for the historical run.

The production tests use **synthetic child labels**, including all-zero,
all-one and mixed patterns. One-thread and eight-thread outputs match in
51 pairs. The recorded checks include 21 corrupt/incomplete-input rejections,
four positive controls, and recovery of a saved non-prefix chunk. They are
bounded tests of the unchanged production routines, not a proof of all C++
execution, concurrent schedules, I/O behavior or power-failure scenarios.
Their approximately 10-second core runtime is not a full-table verification forecast.

## What remains open

- Universal refinement of the whole optimized C++ implementation, including
  its memory and I/O behavior: **`NOT_VERIFIED`**.
- A fully instantiated whole-solver kernel certificate: **`NOT_CONSTRUCTED`**.
- Formal binding of all historical output bits to the model and complete
  coverage/aggregation of the full P/N table: **not established**.
- An end-to-end Lean theorem for the original empty-position game: **`NOT_VERIFIED`**.

The finite-model milestone is complete within its stated contracts; the
global opening proof is not. Local proof counts, compiled row checks and
synthetic comparisons must not be added into a proof-completion percentage.

## Available material and bounded replay

[Provenance](provenance.json) lists 97 byte-preserved artifacts, including the
84-module closure of [`Mahjong.OptimizedRetroCertification`](lean/Mahjong/OptimizedRetroCertification.lean),
selected acceptance/build/test records and seven C++ source fragments.
The original acceptance SHA-256 is
`1f23e423794ce0f64a001367d59a41baab82fd517602e9c48046c95a96b14400`.
Its 5,329 referenced local files were rehashed for this publication; **the
complete local evidence collection is not distributed here**. Native test
inputs, operational harnesses, compiled objects and much intermediate evidence
remain outside Git. Original relative paths in receipts identify retained inputs.

From the repository root, check the public subset and optionally replay its
Lean source using a Lean 4.33.1 executable:

```bash
python3 research/2026-09-15/verify.py
python3 research/2026-09-15/verify.py --lean lean
```

The default command checks artifact identity, receipt consistency and source
correspondence. The optional replay creates fresh project objects with a
3 GiB per-process heap limit and runs one compiler process at a time. It does
not run native workers or replay historical P/N data. Earlier `PAUSED` fields
in imported receipts describe those recorded runs; the current maintainer
decision is stated above and in [RESEARCH_STATUS.json](../../RESEARCH_STATUS.json).

## Continuing the work

The [hardware and scan benchmarks](../2026-09-14/README.md) document the
i7-10700KF workstation, 32 GiB RAM, CPU-only checker and measured scaling limits.
More compute could help, but it does not discharge missing proof obligations.
Useful contributions include an independent mathematical argument, discharging
the remaining formal premises, a verifiable certificate that binds the actual
output, or checker improvements backed by representative measured throughput.

Use the [issue tracker](https://github.com/feierbuqiu/mahjong-achievement-game/issues)
or a [signed pull request](../../CONTRIBUTING.md), and include the exact source
commit, input hashes, resource limits, command, complete outcome and proof scope.
Documentation, the planned report, corrections and contributed results can
continue to enter `main`. Existing releases remain historical records.
