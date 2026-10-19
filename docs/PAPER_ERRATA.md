# Repository errata for the frozen papers

**Version 2.0.0, 19 October 2026.** This file corrects the interpretation of
published material without rewriting its scientific text. The three
[English papers](../papers/README.md) and their associated audit memos are
identified by [FREEZE.json](../papers/FREEZE.json). The October paper differs
from commit `d290627` only by removal of its editorial working-edition notice.
Earlier papers and all listed audit memos retain their bytes.

## Trust and formal verification report

These corrections apply to the October report and its native-evidence memo.

1. **Production cross-layer identity (sections 3 and 4).** Equal target/source
   roots reuse the target-role load. There is no second native source load for
   this comparison. The 54,548 declared-reference equalities are deterministic
   bookkeeping; they are not independent content observations. Cross-session
   identity rests on input custody, fixed paths and before/after hash maps.
   The changed-target negative control uses a configuration with different roots.
2. **Bucket cover and controls (sections 3 and 4).** Historical production did
   not gate the emitted native `exactCoverage` Boolean. Python reconstructed
   contiguous frame cover. v2 additionally publishes all 3,686 retained close
   events and verifies their true flags offline. This does not change what the
   original controller required. The deleted-final-row control must be read with
   that difference in mind.
3. **Whole-input acceptance (including the abstract).** Production evaluated
   decomposed native adapter functions, with external assembly; it did not call
   `finishWhole` on one actual `Candidate`/trace. Earlier wording about the
   same check functions accepting the complete actual input overstates this
   relationship. The generic implication, complete recorded component coverage
   and actual closed opening proof remain distinct claims.
4. **Trust boundary.** Include faithful modeling of `Step`/`Win`, the Lean/native
   compiler and runtime, OS/hardware, the IO/input adapter, custody and external
   bookkeeping. The abstract's shorter list must not be read as exhaustive.
5. **Evidence availability.** The earlier saved-record ZIP omitted the root
   preflight, bucket-close and resource records, and the custody handover.
   These are now in the [v2 asset](../research/2026-10-19-v2/assets.json).
   The full input dataset, toolchain, executable and local portable archives
   remain unavailable as public downloads. A preflight accepts zero game rows.
6. **AI review.** The cited earlier report has a [factual erratum](../research/2026-10-19-v17/review/ERRATA.md).
   The later supplied review declares the same model identifier. Neither is
   human peer review, independent execution replication or an authority for a
   numerical probability of correctness.
7. **Precision and hardware.** The selected-sample cost extrapolation is not
   a global completion-time bound. September hardware observations do not
   become contemporaneous October measurements by being cited in that run.
8. **Citations and disclosure.** The 11-reference bibliography is preserved.
   [Repository reading notes](LITERATURE.md) add earlier work on certifying
   algorithms, large formal proofs, SAT certificates, game solving and alternate
   Lean checkers. The moving documentation URL is contextual; the recorded
   implementation is Lean 4.33.1 and its exact tag/source hashes. Model names
   in papers are author declarations, not independently authenticated identities.

## September papers

The computational and Lean-model papers retain their original reference lists.
The review flags incomplete historical attribution for the name
Sprague-Grundy and asks for checks of the Huggan/Huntemann/Stevens and Siegel
entries. This release makes no unverified bibliographic substitution into
those frozen papers. Their reference audits and the later reading notes should
be used together. A future primary-source bibliographic erratum can be added
without changing the published text.

All three papers describe different dates and scopes. Their old outlooks,
local proof counts and timing estimates are not current promises or additive
progress percentages. The [current claims](CLAIMS.md) and
[review response](REVIEW_RESPONSE.md) give the repository's present position.
