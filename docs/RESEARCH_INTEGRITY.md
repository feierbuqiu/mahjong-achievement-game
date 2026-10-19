# Research integrity and attribution

## Status and scope

This is an independent computational-mathematics research project. The
public release is not represented as a peer-reviewed article, an institutional
publication, or a completed formal proof. No affiliation or endorsement by a
Mahjong organization, university, GitHub, or a proof-assistant project is implied.

The three English reports and their associated audit memos are frozen in
v2.0.0. Scientific bodies are preserved, with known interpretation issues in
[PAPER_ERRATA.md](PAPER_ERRATA.md). The V17 native-component run covers the
recorded full table; whole-input assembly, exact cover and input identity
retain the boundaries in [CLAIMS.md](CLAIMS.md). An actual closed opening Lean
declaration remains NOT_VERIFIED. Both supplied review reports are AI
inspections, with the same declared model identifier. The earlier report has
a factual erratum. Neither supplies human peer review or independent execution.
No independent replication, contest acceptance or institutional endorsement is claimed.

Historical stage gates were skipped under continuous owner authorization,
as disclosed in the earlier AI report. This release records that deviation;
it does not retrospectively certify a completed gate. New records and source
copies improve inspectability without changing historical execution.

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

Model names in the published papers are transcribed author declarations:
"GPT-6 Astra" in the September reports and "GPT 6.1 Sol" in the October paper.
One older memo uses the variant "GPT-6Astra". They are retained rather than
silently normalized. Both review reports declare Claude (Anthropic), model
`claude-opus-5-5`. v2 repository maintenance used OpenAI Codex assistance.
These names/dates do not independently authenticate the actual model served.
The maintainer remains responsible for published interpretations.

The [privacy policy](PRIVACY.md) requires raw/decoded-string and archive-content
checks. Identifying workstation prefixes are removed from current copies;
original/public hashes are separate and old history is preserved.

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
