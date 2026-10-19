# Erratum to the retained AI review

19 October 2026; first distributed with v2.0.0.

The original [report](INDEPENDENT_REVIEW.md) remains byte-identical and
hash-pinned. Its name is historical: it records a separate AI review, not
human peer review or independent execution replication. The later
[supplied review](../../../docs/reviews/2026-10-19-ai-review.md) declares the
same model identifier, `claude-opus-5-5`; it is not independent in a strong sense.

Two factual statements in the original report require correction:

- **Second load.** When target and source roots match, `V17ComputeMain.lean`
  selects `pure loaded`. It does not perform a second load. The declared
  seven-field comparison in the external ledger is deterministic from the
  same manifest, not an independent comparison of bytes read in different roles.
- **All failures terminate production.** The native close operation emits an
  `exactCoverage` Boolean without throwing on false. Historical production
  checked row totals and ranges but did not gate that Boolean. The deleted-row
  control observes a gate production did not use. All 3,686 retained positive
  close events are now public and checked by a separate offline v2 auditor.

The report's historical no-defect verdict and confidence language are the
reviewer's original statements. They are not the repository's current
unqualified endorsement. The [review response](../../../docs/REVIEW_RESPONSE.md)
and [claim boundaries](../../../docs/CLAIMS.md) supersede those interpretations.
