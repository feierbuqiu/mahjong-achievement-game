> **Historical snapshot.** The [October 19 V17 update](../2026-10-19-v17/README.md)
> records complete native verification under a kernel-proved implication.
> This page retains its dated scope; "current", "not started" and runtime
> forecasts below describe that earlier snapshot. The actual-input closed
> Lean theorem remains unproved. See [current status](../../docs/PROJECT_STATUS.md).

# Persistent kernel proofs and certificate compression

**Later October 18 update: the current work is proof-certificate research.**
The target is a saved, closed Lean theorem
`SecondPlayerWins Step Win empty` for the actual original game, together with
a cold replay of its complete proof dependencies using the standard kernel.
There is substantial component progress, including a closed small actual-game
pilot. **The actual empty-state theorem remains `NOT_VERIFIED`. No reliable
20-hour or 24-hour end-to-end completion bound has been established.**

The [earlier V16 update](../2026-10-18/README.md) concerns a different workload:
execution of a compiled checker whose proof fields are erased. Its 13.0256-hour
known-component estimate, including a 25% margin and still excluding six costs,
does not estimate the construction, persistence, assembly and cold kernel replay
of the current proof certificates. The previous expectation of an imminent
sub-20-hour finish is superseded. The legacy whole-table campaign remains stopped.

The September computation still reports a second-player win under its stated
implementation and input dependencies. The unfinished kernel research does
not provide a new opening classification. Both [English papers](../../papers/README.md)
and the immutable v1.0.0 release retain their historical text and scope.

## What has actually been obtained

| Work | Recorded result | Remaining boundary |
| --- | --- | --- |
| V17 generic composition | 13 new source modules; fresh replay of a 145-module project closure in 123.078 s | Actual full-input acceptance is not instantiated |
| V18 original-game pilot | An 11-node strategy certificate proves two explicit 32-tile P roots and one 32-tile N root | All three are nonempty positions |
| V18 hot-checker pilot | 56 distinct actual rows: 41 P / 15 N, plus two scalar scan equalities | Captured finite read footprints; not a complete V17 finite-input certificate |
| V18 saved proof replay | Frozen `PilotClosureV18` replayed with `leanchecker --fresh` in 176.562 s | Same Lean kernel, not an independent kernel implementation |
| V19 local certificate/layer bridges | Generic local checks compose back to the original strategy and empty-root statement | No actual whole certificate or root DAG instantiated |
| V19 28-block experiment | Numeric P/N and input-layout proofs for 1,077,270 Cartesian coordinates; combined cold replay 11.546 s | Supplied numeric relations do not establish complete SAFE successors or original-game semantics |
| V19 named-helper experiment | Three blocks / 125,772 Cartesian coordinates; representation equalities and cold replay, 7.187 s | Component representation experiment, not a global speed forecast |
| V19 local metadata experiment | 64 rows, nine captured pages; return to the original three ByteArray obligations; cold replay 8.907 s | Partial captured inputs, not all local rows or a full game certificate |

These quantities describe different objects. They are not additive global
coverage or a completion percentage. The two scalar scan cases overlap the
56-row pilot. The 28-block sample has 1,035,129 original colex rows and 1,077,270
Cartesian coordinates; those counts must not be exchanged. The historical
compiled-checker layers 32–34 still total **303,054,865 unique rows** under their
original compiled-execution/IO boundary. They have not automatically become
closed kernel certificates for this new route.

## V17: mathematical composition is available, the actual instance is not

The [V17 status](evidence/v17/status.json) and [fresh-replay receipt](evidence/v17/fresh-replay.json)
bind the 13 new sources and their successful compilation records. The generic
chain preserves SAFE and P/N strategy meaning, checks source/target identity
including bit tables, assembles the finite layer induction, checks the actual
root decoder fields and P bit, and connects acceptance to the original game.
The final fast interface derives its trace internally from six finite Boolean
acceptance equations; it does not ask the caller to assume arbitrary
`TargetCorrect`, `Trace` or strategy propositions.

Those actual acceptance equations still need closed proofs. Typed in-process
results such as `CheckedRange` or `Option (PLift ...)` have erased proof fields
after compilation. A saved interval, JSON PASS or successful return code cannot
recreate the erased proof on restart. Persistent proof terms/certificates and
the actual instance still have to be constructed and combined. Full SAFE-orbit
directory coverage is also a stronger claim than the generic strategy bridge
and needs its own actual data binding.

The [captured source review](evidence/v17/source-review.json) is a separate-agent
review of existing source/receipts. It is not a new kernel replay, human peer
review or a completed independent verification of the opening. The fresh
replay itself uses Lean's own kernel in an empty environment.

## V18: a saved actual-data closed pilot

The [pilot status](evidence/v18/status.json) separates three closed statements
in [PilotClosureV18.lean](source/v18/Mahjong/PilotClosureV18.lean):

- Original-game strategies for the explicit 32-tile roots P50, P55 and N35,
  using the finite 11-node certificate and all required physical move checks.
- Acceptance of 56 distinct captured rows by the original indexed hot checker.
- Exact successful scalar-scan equations for the P0 and N35 captured inputs.

The sparse original-game checker and the V17 production checker are different
functions. Neither the pilot's actual-data label nor its saved module implies
full-table coverage. The final recorded axiom dependencies are subsets of
`propext`, `Classical.choice` and `Quot.sound`; the pilot uses no extra native
evaluation-result axiom as a substitute for these closed proofs.

The frozen bundle metadata records 57,788,336 bytes of saved modules, of which
3,645,360 bytes are V18 modules. The final target's V18 source-import closure
accounts for 3,584,792 bytes. Its per-module construction wall times sum to
125.783 seconds, with some parallel execution; this sum is not end-to-end elapsed
time. [The cold replay](evidence/v18/fresh-replay.json) took 176.562 seconds with
a peak Job commit of 1,589,190,656 bytes. Binary modules are retained outside Git;
the source archive and original/public metadata identities are supplied here.

The pilot's 56-row construction took 17.844 seconds; the 8-row construction
took 7.187 seconds. Their sample incremental rate is about 4.50 rows/second.
A single traversal of 778,532,864,302 rows in 24 hours would require about
9,010,797 rows/second. This is a warning about that particular per-row method,
not a lower bound for all compressed proof representations and not a global
runtime forecast. The pilot did not admit a 24-hour full-table run.

## V19: compression components with narrower conclusions

The [28-block acceptance](evidence/v19/cartesian28/acceptance.json) covers
supplied finite numeric P/N recurrences and raw/padded/axis-layout equalities
for 402 input words. The source and candidate planes are data-linked, but the
complete actual SAFE move list and original-game interpretation are separate
obligations. The recorded Bool batching comparison did not establish a numeric
kernel speedup. Library construction, failed attempts, proof construction and
cold replay are different costs.

The [named global helpers](evidence/v19/global-helpers/acceptance.json) preserve
the original channel functions by equalities valid for every Nat width/input,
and check the actual three-block numeric equations. Selected component times
improved, while introducing 21,584 small declarations. Neither those timings
nor the declaration count establish a practical full-table architecture.

The [local metadata result](evidence/v19/local64/summary.json) transports the
encoded recurrence to the original three checks on the same 64 captured rows
and nine pages. Outside those pages the partial getter returns zero. Numerical
kernel checking took 1.453 seconds, and the saved dependency slice replay took
8.907 seconds. The source/axiom fingerprints and failed long-path bundle attempt
are retained separately. This does not certify all 1,953,125 local numeric rows.

The [local certificate](evidence/v19/local-certificate-acceptance.json) and
[local layer closure](evidence/v19/local-layer-closure-acceptance.json) provide
further generic connections to original-game strategies. They do not instantiate
the actual whole certificate or prove the actual empty root. Untrusted producers
may generate candidate declarations; acceptance rests on the final ordinary
kernel check and axiom audit. A deliberately false candidate remains rejected.

## Public subset and reproducibility boundary

[provenance.json](provenance.json) records every imported file, its original and
public hashes, and private-path or original-language annotation transformations.
[source-map.json](source-map.json) keeps source families separate. The V17/V18
sources reuse the already published 132-module V16 base; their complete mapped
source-import closure is checked by the publication helper.

The V19 archive is a **selected source/evidence subset**. Some successful
experiments use binary-emitted Nat data or exported dependency slices whose
complete reconstruction inputs are retained outside Git. The source-map
dependency report explicitly lists unresolved imports for this public subset.
It must not be described as a complete portable cold-replay distribution.
Original bundle/module hashes identify retained objects, not downloadable files.
Raw input banks, compiled `.olean` parts, toolchains and DLLs are excluded.

From the repository root, inspect the public bytes and receipt arithmetic:

```bash
python3 research/2026-10-18-kernel/verify.py
```

This starts no Lean, Native, GPU, WSL or full-table job. It checks artifact
identity, source mappings, scope flags and selected recorded outcomes; it does
not rerun the saved proofs or independently establish their mathematics.
Existing Lean CI replays the earlier concrete proof package. A green publication
check is not a new replay of every V19 experiment.

## Remaining work

The actual finite inputs, rule/cache/channel semantics and chosen certificate
must be connected, checked and persistently represented. Their original-game
interpretation, precise addressing, full required coverage and root binding
must survive the final assembly. Whole-task measurements must include proof
construction, metadata and layout preparation, serialization, dependency
loading, assembly and standard-kernel cold replay, as well as memory and disk.
Serialized byte size alone is not a RAM lower bound, and chunking alone is not
a demonstrated resource guarantee.

The whole-table STOP remains. No 20/24-hour launch has been admitted by these
results. Current experiments continue to investigate proof representations;
unfinished attempts are not silently promoted to PASS. Independent arguments,
deeper formal work, alternative certificate designs, corrections and carefully
measured contributions remain welcome.
