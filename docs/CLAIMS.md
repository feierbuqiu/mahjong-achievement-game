# Claim boundaries

**Current evidence: a kernel-proved generic implication, a complete recorded
native-component run and external assembly under explicit trust assumptions.**
This is a computational second-player-win result, not a closed actual-input
opening kernel proof. Read the [review response](REVIEW_RESPONSE.md) and
[paper errata](PAPER_ERRATA.md) before reusing older publication wording.

| Statement | Current assessment |
| --- | --- |
| Empty position P / second-player win under the stated trust boundary | Supported by the original full calculation, reverse replay and later component-native evidence |
| The kernel proves six finite acceptance families imply `SecondPlayerWins Step Win empty` | Supported by the generic theorem and recorded kernel replay |
| Native components processed all 778,532,864,302 recorded rows | Supported by the 17,317-frame ledger and recorded results for all 35 layers / 3,686 buckets |
| All whole-input Boolean premises ran together over one actual typed `Candidate` | **Not established; `finishWhole` was not used** |
| Production cross-layer byte comparison independently checked different reads | **False for the equal-root production configuration** |
| The 54,548 declared target-reference equalities independently detect read substitutions | **False**; both sides are deterministically constructed from the same manifest |
| Production gated native `exactCoverage` | **False**; it checked row totals/ranges externally |
| All retained bucket-close events record native exact coverage | Supported by all 3,686 true close flags, additionally checked offline in v2 |
| Python frame ranges exactly cover the recorded plan | Supported by complete cursor/range reconstruction; it remains external bookkeeping |
| The actual empty-input conclusion is a closed saved Lean declaration | **Not achieved** |
| Full native execution has been independently replicated | **Not achieved** |
| Separate AI inspections are human peer review or independent execution | **False** |
| The public evidence ZIP contains the full input dataset | **False**; full 100.62 GB inputs remain local |
| Signatures, hashes, green CI or numeric-component coordinates prove the opening | **False**; each has a narrower scope |

## Evaluation boundary of the six theorem families

| Theorem family | What ran / remaining obligation |
| --- | --- |
| Base finite data | Native component checks of inventories, local data, directories, bounds and layout |
| Successor lists | Native component check within the session |
| Per-bucket metadata | Native source/bank/coverage components for each nonempty bucket |
| Frames and exact cover | Native frame scans; external cursor reconstruction. Native close flags were emitted, not gated by production; v2 checks the retained flags offline |
| Cross-layer target identity | Equal-root native comparison reuses `loaded`; declared graph is deterministic. Identity between reads relies on fixed paths and recorded deny-write/delete custody with equal maps |
| Empty root / P bit | Native root component and recorded payload binding; root preflight is not a completed row frame |

The native comparison has a meaningful distinct-roots control, but that
configuration was not production. The missing-final-row control observed a
native Boolean that historical production did not gate. Neither should be
cited as a stronger production guarantee.

## Suggested wording

> The Lean kernel proves a generic implication from six finite acceptance
> families to a second-player win in the original game. Natively compiled
> component checks processed all 778,532,864,302 recorded SAFE symmetry
> orbits. Their assembly into whole-input premises, exact cover and cross-layer
> input identity retain external bookkeeping and custody assumptions. The
> typed whole-input route was not executed. A closed actual-input opening
> declaration and independent full execution replication remain open.

The trust boundary includes faithful formal modeling, Lean/native compilation
and runtime, OS/hardware, IO/input adaptation, scheduling, input custody and
external bookkeeping. Equal recorded maps do not independently verify OS locks
or every read. The [new offline audit](../research/2026-10-19-v2/evidence/saved-record-audit.json)
checks saved records, not the original recurrence or complete input bytes.

The [retained earlier AI review](../research/2026-10-19-v17/review/INDEPENDENT_REVIEW.md)
has a [factual erratum](../research/2026-10-19-v17/review/ERRATA.md). Its historical
no-defect verdict does not supersede the corrected mechanism description.
The later supplied review declares the same model identifier. No human review,
numerical confidence percentage or independent full execution is claimed.
