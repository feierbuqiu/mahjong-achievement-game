# Research integrity and attribution

## Status and scope

This is an independent computational-mathematics research project. The
public release is not represented as a peer-reviewed article, an institutional
publication, or a completed formal proof. No affiliation or endorsement by a
Mahjong organization, university, GitHub, or a proof-assistant project is implied.

The [two English reports](../papers/README.md) are fixed together in v1.0.0.
This major version marks completion of the maintainer's current research
delivery, with the unresolved Lean obligations retained. The
[maintenance policy](PROJECT_STATUS.md) does not promise routine new research.

The rules describe the specific deterministic game in this repository.
The results are not claims about ordinary multiplayer Mahjong strategy or
gambling outcomes.

## Evidence and reproducibility

Every reported computation should identify its source version, exact input,
budget, output, and completed coverage. UNKNOWN and timeouts must remain
distinct from P/N. Preserve failed and superseded experiments as historical
records when they matter to a claim; do not silently relabel them as success.

Separate a theoretical argument, a completed program run, cross-algorithm
agreement, an independently implemented checker, and a kernel-checked theorem.
Signatures and hashes authenticate artifacts; they do not replace those checks.

## AI assistance

This repository was prepared with AI assistance. AI assistance in code,
documentation, and research reasoning does not establish correctness or
independent review. The inspectable source, explicit evidence boundaries,
and reproducible checks are the basis for evaluating claims.

Contributors should describe material AI assistance where it affects a proof,
algorithm, implementation, or interpretation. Contributors remain responsible
for the material they submit; tools are not listed as scholarly authors.

## Authorship and citation

The maintainer is identified by the public handle **feierbuqiu**. No private
identity or unconfirmed affiliation is added to the citation metadata. Git
history records contributions, while scholarly credit should reflect actual
intellectual contributions and agreements among participants.

Citation requests do not add restrictions to the MIT License. Cite a specific
version and disclose changes when reproducing or extending the result.

## Corrections and concerns

Use an issue to report a scientific discrepancy or reproduction failure with
enough evidence to inspect it. Handle credential exposure or vulnerabilities
through [SECURITY.md](../SECURITY.md). Material corrections should identify the
affected release, claim, reason, and replacement evidence.
