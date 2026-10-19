# Complete V17 native verification

**19 October 2026.** The Lean kernel proves a whole-input implication:
if six finite Boolean acceptance families are true, then
`SecondPlayerWins Step Win empty` holds for the original game. The same
check functions, compiled to native code, accepted the complete actual input.

**Evidence level: kernel-proved implication plus native evaluation.**
This is not a closed Lean declaration about the actual table. Native
compiler/runtime, OS/hardware, faithful rule modeling, input custody and
external bookkeeping remain trusted. Independent execution replication
and human peer review have not been completed.

## Completed computation

| Item | Recorded outcome |
| --- | --- |
| Run | `full_native_20261018_02` |
| Final status | `COMPLETE_FIXED_V17_NATIVE_COMPUTATION` |
| Completion | 2026-10-18 17:56:53 UTC / 19 October 04:56:53 Australia/Sydney |
| Layers / SAFE orbits | 0–34 / 778,532,864,302 |
| Nonempty buckets / empty cells | 3,686 / 2,754 out of 6,440 |
| Committed frames | 17,317 |
| P / N rows | 203,051,492,021 / 575,481,372,281 |
| Empty position | P: second player wins under the stated trust boundary |
| Old PASS records or seeds imported | None |
| Actual input files / bytes | 11,272 / 100,615,834,170 |
| Before/after input identity maps | Identical |
| Native execution sessions | One uninterrupted session |
| Measured elapsed time | About 7.6 hours for this run |
| Closed actual-input Lean declaration | **Not constructed** |

The checker verifies the stored historical labels; it does not regenerate
the table. The P/N counts agree with the September C++ computation because
those are the labels being checked. The new evidence is acceptance of the
recurrence and finite data by the compiled V17 functions, with complete
coverage and identity records. The GPU supplies untrusted proposals; a GPU
result alone cannot commit a verified frame.

The [final receipt](evidence/final.json), [coverage summary](coverage.json),
[input hashes](inputs.json), [runtime binding](evidence/runtime.json) and
[record index](evidence/record-index.json) retain exact identities. The
[performance record](evidence/performance.json) has a controller completion
timer of 27,304.5 seconds and a later display timer of 27,333.44 seconds.
These are different recorded timer scopes, both about 7.6 hours; neither
is a forecast for an independent rerun or a strict-kernel proof.

The recorded hardware is an i7-10700KF (8 cores / 16 logical processors),
32 GiB RAM and RTX 2070 SUPER, under Windows/WSL Linux. The initial native
pool used 12 execution threads and each frame retained 12 logical fragments.
See the [dated hardware receipt](../2026-09-14/hardware.json); its old benchmark
limits are not claimed as the enforcement policy of this later run.

## The six acceptance families

| Family | Frozen functions / evaluation boundary |
| --- | --- |
| Base finite data | `FiniteCertificateV17.checks`: local caches, inventories, groups, layer bounds, directories, layout and word limits |
| Successor lists | `FiniteMetadataV17.checkSuccessors`, once per native session |
| Per-bucket metadata | `checkSource`, `checkBank`, `GroupNextCoverage.check`, for all 3,686 buckets |
| Frames and exact cover | `RuntimeScanV17.prepare`, `scanFragment`, `assembleScanned`; finite range checks plus external exact-cover bookkeeping |
| Cross-layer target identity | `CrossLayerAssemblyV17.checkTargets`; native byte checks plus immutable file/hash binding and seven-field comparison by bookkeeping |
| Empty root and P bit | `EmptyRootV17.checkP`, for bucket `(0,0)` |

The whole implication is
`Mahjong.FastWholeInputV17.from_finite_input`; its conclusion is about the
original `Step`, `Win` and empty state. It constructs the strategy from finite
acceptance equations rather than assuming arbitrary row correctness,
`TargetCorrect` or a winning strategy. Its recorded axioms are `propext`,
`Classical.choice` and `Quot.sound`.

The typed in-process whole-input `finishWhole` route was not used for the
production table. Assembly is external. In-process target loading uses the
same file roots, so cross-layer identity depends on immutable inputs and
their hash binding as well as the native check. This is an explicit part
of the trust boundary, not a closed kernel derivation of the actual input.

## Separate AI review and controls

The original [independent review report](review/INDEPENDENT_REVIEW.md) identifies
its reviewer as Claude (Anthropic), model `claude-opus-5-5`. It states that the
reviewer did not author or modify the implementation and conducted read-only
inspection. Its separate ledger script reports:

- 17,317 committed receipts and native-result bindings checked;
- exact contiguous coverage of all 3,686 nonempty buckets;
- 54,548 cross-layer target references, zero identity mismatches;
- an empty-root bit of 1 (P), matching the input identity map;
- 62 sampled input files / 81,370,822 bytes rehashed, zero mismatches;
- no defect found within the inspected source/record scope.

The reviewer did **not** rerun Lean, `leanchecker`, the native checker or GPU;
it assessed build/replay claims from receipts. It did not rehash the full
100.62 GB set, and reviewed only `finalize.py` line by line among the trusted
Python bookkeeping. It is **not human peer review or independent execution
replication**. The report's confidence judgment is its author's assessment.

The [Appendix B script](review/independent_ledger_check.py) is extracted
verbatim, with [extraction identity](review/extraction.json). It requires the
original workspace, native binary and sampled inputs, and has its original
behavior: the printed problem count is significant; a zero process exit is
not by itself a pass. The publication's separate `verify.py --archive` adds
fail-closed exits and recomputation of each ledger entry's canonical hash;
it does not replace the original report or claim a new independent game run.

[Six native controls](evidence/native-controls.json) accepted the positive
full bucket and rejected a flipped source bit, deleted final row, swapped
target identity, truncated source payload and incorrect catalog honor.
[Thirty-six transport](evidence/transport-controls.json) and
[22 bookkeeping](evidence/bookkeeper-controls.json) cases are mocked controls,
not operating-system crash/recovery tests. The first production attempt
`full_native_20261018_01` stopped on a GPU resource declaration before any
game frame; the `_02` run is the completed production result.

## Source and evidence distribution

[source-map.json](source-map.json) maps **148 exact Lean source files**:
145 frozen mathematical/base files plus the worker, native main and replay root.
It reuses prior public byte-identical files, avoiding another duplicated tree.
The replay entry's reachable source closure is 146 files. The historical
`leanchecker` receipt reports 145 imported modules; those are different count
scopes. [Build/replay evidence](evidence/final-build.json) records successful
Linux kernel compilation and a fresh implication replay (114.644 seconds).
This publication did not execute those tools again.

The [source/operations archive](source/ops) contains the historical bookkeeping
implementation. It is supplied for inspection, not represented as a fully
portable installer. `prepare_sources.py` assembles the mapped Lean bytes in
a new directory without compiling or running them.

The full saved ledger and frame evidence live in a **63,456,055-byte ZIP**
with **38,329 original files**, supplied as a
[separate evidence release asset](https://github.com/feierbuqiu/mahjong-achievement-game/releases/tag/evidence-v17-native-20261019).
Git retains [asset size and SHA-256](assets.json). The asset preserves original
bytes and relative research paths, including all frame/native results,
bucket/global records, manifests and before/after input identity maps.
It includes only the eight-byte empty-root payload from the full input set.

This dated native-evidence publication predates the completed local portable
delivery. The [new working paper](../../papers/trust-verification/manuscript.md)
now records its successful same-host tests and [current availability](../../papers/trust-verification/delivery.json).
The full 100.62 GB input dataset, original native binary, toolchain and GPU
environment are **not** supplied by this saved-record asset. The complete
input hash map does not itself provide those inputs. Local `.part` packages
were unfinished at this earlier capture and were excluded; complete local
archives now exist, but are not newly hosted by the working-paper update. See [data availability](../../docs/DATA_AVAILABILITY.md)
and [artifact policy](../../docs/ASSETS.md).

```bash
python3 research/2026-10-19-v17/verify.py
python3 research/2026-10-19-v17/prepare_sources.py --output build/v17-source
# Download the ZIP from the release URL in assets.json, then:
python3 research/2026-10-19-v17/verify.py --archive /path/to/mahjong-v17-native-evidence-20261019.zip
```

The first command validates public hashes, source mappings and recorded
scopes. The second copies exact source only. The last verifies asset/member
hashes, ledger entry hashes, frame/native result bindings, six scoped flags,
exact coverage, root and cross-layer identities. It does **not** re-evaluate
the game recurrence, rerun Lean/native code, or rehash the unavailable full
inputs. All three use the Python standard library.

## Relation to earlier work and next steps

V17 native completion supersedes earlier public statements that the actual
finite checks had not been evaluated. V18/V19 remain separate strict-kernel
pilot/compression experiments; that work was stopped by a change of target.
The legacy V16 campaign STOP remains, and neither historical hold means the
separately authorized V17 native run did not finish. No V19 component is
silently inserted into this V17 runtime. Read the [version glossary](../../docs/INTERNAL_VERSIONS.md).

Independent execution on another stack, human rule/bookkeeping review,
alternative arguments and corrections are welcome. A closed actual-input
Lean proof remains future work with no established timeline. The two dated
English papers and immutable v1.0.0 retain their original contents; the
maintainer's [new trust paper](../../papers/trust-verification/manuscript.md) is
a working edition on main, without a new freeze or release.
