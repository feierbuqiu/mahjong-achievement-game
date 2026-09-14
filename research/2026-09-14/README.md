# Research handoff: personal Lean work paused

**September 14, 2026.** The maintainer has put personal end-to-end Lean
verification on hold. The completed computation still gives **P at the empty
state: the second player wins under optimal play**. The empty-position and
10-tile Lean winner theorems remain **`NOT_VERIFIED`**. No near-term completion
date is offered. This is a dated update to `main`; no new release is created.

The [English paper](../../papers/manuscript.md) remains the primary report,
dated September 13. This supplement records subsequent results without
retroactively changing that paper or the signed release snapshots.

## Conclusions and evidence

The original shared-pool game, including seven pairs of seven distinct kinds,
is unchanged. [Complete computation and reverse replay](../../docs/EVIDENCE.md)
cover 778,532,864,302 SAFE symmetry orbits: 203,051,492,021 P and
575,481,372,281 N. All six first-move orbits are N. Reverse replay found zero
mismatches, and 16,240 historical checks agreed. A table-backed strategy returns
to P after each opponent move, or wins immediately when available.

The two computational algorithms share their underlying rules and state
index. Their agreement is strong computational evidence, with those shared
dependencies still needing independent scrutiny. We do not claim an independent
human verification, a closed opening Lean theorem, or a short human-playable
strategy. Signatures and hashes identify material; they do not prove its claims.

| Milestone | Recorded result | Verification boundary |
| --- | --- | --- |
| Published September 13 kernel package | Eight indexed nonempty roots; 1,008 source modules | Reproducible from [formal/](../../formal/README.md); no opening theorem |
| Later explicit-certificate work | Three additional 12-tile roots; 2,554 additional P rows; 86,310 legal first-action responses; combined registry of 3,311 states | [Historical receipt](evidence/solo-continuation.json); later proof closures retained outside Git |
| Paused local certification registry | 24,655 P states; 283 new certificate blocks recorded by the daemon | [Paused status](evidence/paused-registry.json); includes earlier facts, not an additional 24,655 states; full later proof trees are not replayed by public CI |
| Ten-tile partial coverage | Legal P-return responses established for first tiles 8, 9, 14, 23, 24, 25 (zero-based) | Six covered actions do not establish the root P; uncovered actions are not classified N |
| Local profile summaries | All 5,937,500 patterns checked by compiled Lean | [Acceptance](evidence/summary_full_v1/acceptance.json); supporting cache, not game-state coverage |
| Actual table layers 34 and 33 | 587,901 + 21,924,455 = 22,512,356 rows passed | [Acceptance](evidence/ACTUAL_SCAN_ACCEPTANCE.json); compiled execution trust boundary; only these two complete layers |
| General-layer checker | Rules, references, row equations and original-game soundness implemented; bounded tests passed | Explicit higher-layer correctness premises; full campaign aggregation unfinished |

The three later 12-tile physical roots are
`0000000030000001110001110300000000`,
`0000000020000001110001121200000000`, and
`0000000030001110201000001110000000`.
The still-unclosed 10-tile target is `0000000020000001110001110200000000`.
The later local registry includes four 12-tile states in total. Counts from
different candidate graphs, proof registries and table scans must not be added
or interpreted as an opening-proof completion percentage.

## What the newer checker establishes

The [56 frozen Lean source files](provenance.json) include the original rules,
SAFE bridge, packed-state interpretation, local-summary equivalences, compact
bucket index, terminal and near-terminal checks, and general-layer checks.
They are separate from the September 13 concrete-proof package.

- [`TerminalBucket`](lean/Mahjong/TerminalBucket.lean) checks terminal SAFE rows.
- [`NearTerminalBucket`](lean/Mahjong/NearTerminalBucket.lean) checks P rows with
  no SAFE successor, and N rows with an explicitly checked terminal P successor.
  It does not assume a C++ successor label or a maximum SAFE layer.
- [`GeneralLayer`](lean/Mahjong/GeneralLayer.lean) checks all physical SAFE
  successors, symmetry restoration, target indices and the P/N recurrence.
- [`GeneralIndex`](lean/Mahjong/GeneralIndex.lean) adds source rank/unrank
  checks. [`GeneralOriginalSoundness`](lean/Mahjong/GeneralOriginalSoundness.lean)
  bridges accepted rows to the original achievement game, **assuming the
  referenced higher-layer values are correct** and the local summaries are checked.

The mathematical soundness lemmas were checked by the Lean kernel. The large
data scans ran compiled Lean executables and therefore additionally trust the
Lean-to-native compilation/runtime chain and the execution receipts. They
are not individual kernel proof terms for all table rows. No `native_decide`
opening assertion or closed empty-state theorem is supplied.

The complete layer-34/33 scans cover about **0.002892% of table slots**; this
is an index-coverage fraction, not an estimate of remaining proof effort.
The general adapter was added *after* those scans. Their older receipts still
say the adapter was pending; [the later status](evidence/STATUS.json)
supersedes that engineering status, while retaining the original scan results.

Layer-32 tests use target inputs checked against the completed layer-33 scan.
The layer-23 benchmark reads layer-24 labels whose full Lean validation has
not been completed. For the latter, passing row equations does not establish
unconditional original-game strategies. The enumeration coverage, inductive
connection between all layers, and final opening theorem remain unfinished.

## Workstation and measured feasibility

The [hardware receipt](hardware.json) records a fresh, nonidentifying Windows
CIM query. The machine has:

| Component | Configuration |
| --- | --- |
| CPU | Intel Core i7-10700KF, 8 physical cores / 16 logical processors, nominal 3.8 GHz |
| RAM | 32 GiB installed; 34,253,983,744 bytes visible to the OS |
| GPU | NVIDIA GeForce RTX 2070 SUPER; unused by this checker |
| Storage | Samsung SSD 980 PRO 1 TB and WDC WDS500G2B0C 500 GB |
| OS / theorem toolchain | Windows 11 Education, 64-bit / Lean 4.33.1 |
| Job limits during the reported benchmarks | 15,500,000,000 bytes aggregate memory; 80% machine CPU |

The [bounded feasibility results](evidence/GENERAL_FEASIBILITY.json) contain
**47 completed cases, 745,472 row evaluations and 356,352 distinct sampled
slots**. Repeated intervals compare parallel configurations; these samples
are not added to complete-layer coverage.

| Test | Selected configuration | Size-weighted scan rate |
| --- | --- | ---: |
| Layer 32: eight selected buckets | 12 processes x 1 thread | 25,921 rows/second |
| Peak layer 23: three selected buckets | 2 processes x 6 threads | 2,567 rows/second |
| Average needed for the entire table in 30 days | Whole-campaign sustained rate | 300,360 rows/second |

Layer-32 windows sample quarter, midpoint and three-quarter offsets. Selected
buckets hold 96.12% of that layer, but **96.12% of its rows have not been
checked**. The three selected layer-23 buckets hold 35.66% of that layer.
Rates are reciprocals of size-weighted mean seconds per row, using scan time
and excluding repeated process startup and file loading. This favors a long
run. These systematic short windows are not a random sample, confidence
interval, sustained thermal test, or full-table forecast.

The measured layer-23 range was 2,209-3,414 rows/second. Selected peak cases
used at most about 10.2 GB of sampled aggregate private memory. On the same
peak window, increasing one process from 1 to 12 threads improved throughput
only from about 705 to 1,906 rows/second; two processes with six threads each
reached about 2,406 rows/second. The 2,567 figure above weights three buckets.
Scaling is not linear. Profiling has not yet isolated the relative costs of
allocation, reference counting, contention and other work.

As **arithmetic scenarios only**, all rows at the layer-32 sample rate would
take about 348 days; all rows at the measured peak-bucket range would take
about 7-11 years. The three selected peak buckets alone extrapolate to about
155 days. These are neither exact forecasts nor rigorous lower bounds.
The 30-day target is about 11.6 times the layer-32 sample rate and 117 times
the weighted peak sample rate. No general full-table scan was launched.

Earlier C++ timings describe a different computation: recorded generation
stages total 73.52 minutes, and the final resumed reverse-replay stage took
192.08 minutes. See [methods and original receipts](../../docs/METHODS.md).
Those times and the easier layer-33/34 scan rates cannot be used as the runtime
of the general Lean checker. More RAM alone has not been shown to solve the
current throughput bottleneck, and no GPU acceleration is implemented.

## Rechecking the public evidence

From the repository root, using Python 3.10+ and its standard library:

```bash
python3 tools/verify_repository.py
python3 research/2026-09-14/verify.py
```

The supplement check verifies published/original hash mappings, all 47 case
receipts and their worker outputs, distinct interval counts, weighted rates,
and the 30-day arithmetic. It does not rerun the large data scans.

To replay the checker source from fresh objects with Lean 4.33.1:

```bash
python3 research/2026-09-14/verify.py --lean /path/to/lean
```

This checks the 56-module source archive and records the source hashes,
toolchain, commands, logs and axiom output under a new `runs/` directory.
The [publication replay](evidence/checker-kernel-replay.json) passed all 56
modules from fresh objects in 105.266 seconds on the recorded workstation.
It does not run a full table scan or resume the paused research campaign.
For the existing concrete nonempty strategies, use the separate
[formal replay command](../../formal/README.md).

The provenance manifest lists original research-relative paths and SHA-256
values alongside public paths and hashes. Private root/runtime paths in JSON
commands are replaced with placeholders. Historical hashes continue to refer
to original bytes; they are not hashes of sanitized copies. Worker output
JSON and Lean source are preserved byte for byte.

The later concrete proof trees, paused graph databases, binary local summaries,
full table and original Windows controllers are **retained outside Git**.
The public archive includes the checker source, three C++ data exporters,
selected catalogue and performance receipts; it is not yet a portable native
benchmark campaign. Reproducing the measured timings on another host requires
rebuilding the native worker and adapting or replacing that input-generation
and scheduling layer. The full P/N table is reconstructible with the
[existing public tools](../../docs/REPRODUCIBILITY.md). No public download or
permanent hosting for the retained artifacts is promised.

## Handoff priorities

The maintainer's personal verification effort is paused. The explicit-certificate
daemon is already paused; the two near-terminal scans and bounded benchmarks
have completed and exited. Existing files and checkpoints are preserved.
Routine CI replay of published proofs continues, but it does not resume the
research campaign. The repository remains open for contributions.

Useful next contributions are:

1. Independently scrutinize the rules, SAFE reduction, symmetry/index coverage,
   and the computational second-player conclusion; a shorter mathematical
   argument or a fundamentally smaller certificate could change the problem.
2. Profile the general-row checker and improve its algorithm and parallel
   scaling while preserving every current check and correctness premise.
3. Complete campaign coverage, layer induction and the original empty-state
   theorem. Passing general rows with assumed target correctness is insufficient.
4. Port a bounded, equivalent benchmark to a larger compute host. Measure the
   peak buckets and more intermediate layers before committing a large run.
   A 30-day campaign needs a defensible whole-table, row-weighted rate above
   about 300,360 rows/second, with additional room for I/O, startup, recovery
   and performance variation. Core counts alone do not demonstrate that rate.

People with Lean expertise, high-performance verification experience or access
to substantially larger compute are welcome to take this further. The present
resource and algorithm gap motivates the pause; it is not a proof that closure
is impossible or that a particular machine would succeed. No cloud resources
have been rented for this work. Propose a measured plan through the
[issue tracker](https://github.com/feierbuqiu/mahjong-achievement-game/issues),
including the exact commit, method, hardware, scope and expected evidence.
