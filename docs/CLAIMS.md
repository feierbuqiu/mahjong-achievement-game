# Claim boundaries

**Current evidence level: a kernel-proved whole-input implication plus
complete native evaluation of its finite acceptance families.**
See the [completed run](../research/2026-10-19-v17/README.md) and
[machine-readable status](../RESEARCH_STATUS.json).

| Statement | Current assessment |
| --- | --- |
| The recorded empty-position label is P, so the second player wins under the stated computational trust boundary | Supported by the full computation, reverse replay and completed V17 native check |
| The Lean kernel proves that the six finite acceptance families imply `SecondPlayerWins Step Win empty` | Supported by the frozen generic theorem and recorded kernel replay |
| The compiled V17 check functions accepted the complete actual input, all 35 layers / 778,532,864,302 SAFE orbits | Supported by the completed native run and its exact-cover/identity records |
| The original actual-input opening theorem is a closed saved Lean declaration | **Not achieved** |
| The full native execution has been independently replicated | **Not achieved** |
| A separate AI reviewed source/records and cross-checked the saved ledger | Supported within the explicit scope of the supplied report |
| An independent human has peer-reviewed or certified the result | **Not claimed** |
| The 63.46 MB evidence ZIP contains the full 100.62 GB input dataset | **False**; it contains saved records and the empty-root payload only |
| The measured 7.6-hour run guarantees the time of a new run or a future strict-kernel proof | **Not supported** |
| A signature, SHA-256 match or green CI proves the mathematical result | **False**; each authenticates or checks a narrower artifact/operation |

## Suggested wording

> The Lean kernel proves that if six finite Boolean acceptance families hold,
> then the second player wins from the empty table in the stated game. The
> same check functions, compiled to native code, accepted the complete actual
> input in layers 0–34, covering all 778,532,864,302 SAFE positions up to
> symmetry. This is a kernel-proved implication plus native evaluation,
> with compiler/runtime, OS/hardware, rule modeling, input custody and
> external bookkeeping in the trust boundary. A closed actual-input Lean
> declaration and independent execution replication remain open.

Avoid unqualified descriptions such as "fully formally verified in Lean"
or "end-to-end kernel-checked opening proof". A complete native scan does
not become a closed proof term through JSON receipts or hashes.

## Review and independence

The [separate AI report](../research/2026-10-19-v17/review/INDEPENDENT_REVIEW.md)
did not rerun Lean/native code. Its independent script checks saved receipts,
coverage and identity references, plus a 62-file sample of actual inputs.
Build evidence comes from recorded receipts, and most trusted bookkeeping
was not reviewed line by line. "No defect found" applies to that inspected
scope. The report supplies neither independent execution replication nor
human peer review. These distinctions should be retained in a later paper.

The original forward/reverse C++ algorithms share rules and index. The V17
checker uses the separate Lean rule/check development and checks supplied
labels rather than trusting the C++ solver. Faithfulness of the formal rules
still merits human inspection. No implementation or AI review removes the
compiler, runtime, input-custody and bookkeeping assumptions of the native route.
