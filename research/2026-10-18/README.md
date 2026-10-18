> **Earlier V16 snapshot; current outlook superseded.** The
> [later kernel-certificate update](../2026-10-18-kernel/README.md) targets saved
> proofs and cold kernel replay. The native 13.0256-hour estimate below does not
> estimate that workload; no current 20/24-hour completion bound is established.

# Approaching the final verification campaign

**18 October 2026: the project is approaching its final computational
verification stage. The maintainer's current working expectation is to finish
the remaining campaign within 20 hours of an authorized start.** The V16
GPU-assisted route brings the measured known-component estimate to
**13.0256 hours including a 25% margin**. This is a substantial improvement over
the September checker and supersedes the earlier decision to stop pursuing
this route.

**The full Lean-based scan has not started. Its correctness is undergoing
independent review.** The working expectation is conditional: the complete
production-cost assessment and final prelaunch review have not passed, and
the existing user-requested STOP remains in force. There is no countdown from
the date of this repository update. The full table and opening remain
`NOT_VERIFIED` by this route.

The September exhaustive computation still reports a second-player win;
the new audit's unresolved opening refers to this unfinished verification
route. It does not replace that recorded computational result with a new
game outcome. The [two English papers](../../papers/README.md) remain the
dated reports published in v1.0.0. This post-release update creates no new
release and leaves that immutable snapshot intact.

## What is new

| Material | Recorded result | Scope |
| --- | ---: | --- |
| Complete layer 32 | 280,542,509 unique rows in 68 buckets | Compiled checker and audited coverage/IO; includes 5,228,859 imported verified rows |
| Complete layers 32, 33 and 34 together | 303,054,865 unique rows | Each seed layer retains its actual verifier identity |
| Selected V16 checker build | 132 linked Lean source modules; 104 recorded theorem/axiom fingerprints | 88 inherited and 16 new checks; not 104 whole-table proofs |
| Indexed-byte GPU proposals | One byte per row, checked by compiled Lean | GPU is an untrusted proposer |
| Resource matrix | 83 frames; 4,597,996,387 conditional row executions | Adds no complete global layer |
| Fixed calibration | 34 cases; 107 frames; 5,843,582,753 conditional row executions | Adds no complete global layer |
| Production controls | Crash/resume/NOOP, STOP and layer-chain checks, negative controls and a bounded layer-31 prefix | Four actual REV3 acceptance records; not a whole-table run |
| Remaining plan | Layers 0–31; 778,229,809,437 rows; 3,568 buckets; 17,197 frames | Not started |

The row totals in the calibration and resource matrix overlap other work and
are execution counts, not additional certified global coverage. The layer-32
audit separately records 275,313,650 newly checked rows and 5,228,859 imported
verified rows. Repeated or uncommitted work is excluded from unique coverage.

## Time expectation and outstanding costs

The [known-cost screen](evidence/known-cost-screen.json) uses measured
calibration and resource observations, actual stratum sizes and frame geometry.
Its conservative one-frame-margin scenario reports:

| Quantity | Recorded value |
| --- | ---: |
| Known components before the 25% margin | 37,513.722344 seconds |
| Known components after the margin | 46,892.152930 seconds |
| Corresponding time | 13.025598 hours |
| Intended cumulative hard runtime budget | 72,000 seconds / 20 hours |
| Final empirical admission target | At most 57,600 seconds / 16 hours |
| Final complete-cost gate | Not evaluated or passed |

Six production costs are not yet incorporated into that screen: per-frame
ledger work, per-bucket certificate registration, shared setup/hash work,
final cleanup, additional scope startup/shutdown, and retry/recovery reserve.
[Raw fee observations](evidence/production-fee-observations.json) exist, but
they have not yet been accepted into the final whole-run assessment. They
must not be silently treated as zero. These remaining checks explain why
the sub-20-hour expectation is a forecast rather than a demonstrated full-run
bound or completion guarantee.

The earlier CPU-only rates in the [September 14 handoff](../2026-09-14/README.md)
describe that older implementation. The current experiments use the recorded
i7-10700KF / 32 GiB / RTX 2070 SUPER workstation, a GPU proposer and a Linux
compiled-Lean checker under Windows/WSL. Resource receipts describe tested
cases; operating-system/kernel cache memory is outside the reported process
caps, and the tests do not exhaust every unmeasured bucket.

## Correctness and review

The [theorem inventory](evidence/theorem-inventory.json) gives exact names,
source locations, premises and existing axiom logs for the 104 selected checks.
All 132 linked source modules are supplied under [lean/](lean/). The recorded
build used Lean 4.33.1, trust level 0 and the standard audited axioms
`propext`, `Classical.choice` and `Quot.sound` where required. This publication
does not rerun that build or claim independent review has already succeeded.

For a P row, the checker still requires every actual legal SAFE successor to
be N; an N row requires an actual P successor. GPU bytes do not certify
themselves. Correct finite inputs, complete enumeration and transition data,
the true higher-layer seeds, and exact source/row/target bindings remain
premises of the compiled checking chain.

Even a successful future full scan would retain the Lean compiler/runtime,
the finite premises and the reviewed Python/OS coverage and IO boundary.
There is currently no Lean-kernel finalizer combining the entire historical
table into a closed opening proof term. The intended near-term finish is the
complete compiled-Lean verification campaign within its declared trust
boundary. A stronger kernel-level opening certificate, an independent
mathematical argument, deeper verification, alternative methods and other
substantive contributions remain welcome.

## Public materials and safe inspection

- [Publication provenance](provenance.json): every supplied source/evidence
  file, its original and public hashes, and any publication transformations.
- [Prelaunch state](evidence/audit-status.json), [campaign plan](evidence/campaign-manifest.json),
  [V16 proof bundle](evidence/proof-bundle.json) and [REV3 source freeze](evidence/runtime-revision3.json).
- [Layer-32 audit](evidence/layer32-audit.json), [resource acceptance](evidence/resources.json),
  [calibration records](evidence/calibration/acceptance.json) and all 34 cases.
- [Selected controller, cost-model and GPU sources](source/build/lean_table_checker/).
  These preserve the historical layout for inspection; they are not a complete
  portable campaign installer or an instruction to launch a scan.
- [Retained-source catalogue](retained-sources.json): original-language audit
  documents and the large expected-input inventory remain outside this English
  publication. Large P/N payloads, native executables, compiled objects,
  toolchains and later proof banks are also excluded.

Private workstation roots in selected JSON copies are replaced by explicit
placeholders. One local progress-display helper has English presentation
strings. The provenance records separate original and public hashes, so
digests inside historical receipts are not misrepresented as public-copy
digests. The original evidence index and proof bundle also name retained
inputs; a listed identity is not a promise that the file is distributed here.

From the repository root, this command reads only public source and metadata:

```bash
python3 research/2026-10-18/verify.py
```

It checks hashes, import closure, recorded theorem/axiom bindings, layer and
sample arithmetic, forecast arithmetic and the retained launch hold. It does
not invoke Lean, a compiler, GPU/WSL services, a scheduler or the 97.32 GB table,
and does not establish the mathematical correctness of the campaign. Completing
the independent review does not itself release the user's hold; fresh input,
resource and full-cost acceptance still precede any separately authorized run.
