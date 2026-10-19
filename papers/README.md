# English research papers

The three reports by **feierbuqiu** are frozen in v2.0.0. Their scientific
text and listed audit memos are preserved. Only the October paper's former
editorial working-edition notice was removed. Read the papers with the
[repository errata](../docs/PAPER_ERRATA.md) and [current claims](../docs/CLAIMS.md).
[FREEZE.json](FREEZE.json) pins their identities.

| Report | Date | Scope |
| --- | --- | --- |
| **[Trust and Formal Verification in the Mahjong Achievement Game: Complete Native Checking and Progress towards End-to-End Kernel Proofs](trust-verification/manuscript.md)** | 19 October 2026 | Native-component evidence, trust, persistent game/numeric pilots and same-host local delivery; read with v2 errata |
| [Lean Verification of the Mahjong Achievement Game: Strategy Certificates, Enumeration, and Retrograde Models](lean-verification/manuscript.md) | 15 September 2026 | Formal development, finite models, bounded execution and reproducibility; unchanged |
| [Mahjong Achievement on a Shared Table: A Computational Second-Player Win and Partial Lean Certification](manuscript.md) | 13 September 2026 | Original computation and early concrete proofs; unchanged |

The whole-game evidence is a generic kernel implication plus complete recorded
native-component coverage and external assembly. The actual-input opening
kernel declaration and independent-machine/full execution replication remain
unfinished. Some original production-check wording is corrected in the errata;
preserving a paper does not endorse every original interpretation.

## Supporting material

- October supplement: [overview](trust-verification/README.md), [evidence catalogue](trust-verification/evidence-catalogue.md), [provenance](trust-verification/provenance.json) and [local delivery availability](trust-verification/delivery.json).
- Original report: [source catalogue](evidence/README.md), [source map](source-map.json) and [provenance](provenance.json).
- Lean report: [overview](lean-verification/README.md), [evidence catalogue](lean-verification/evidence-catalogue.md) and [reproduction audit](lean-verification/reproduction_evidence.md).
- v2: [review response](../docs/REVIEW_RESPONSE.md), [additional saved evidence](../research/2026-10-19-v2/README.md), [privacy policy](../docs/PRIVACY.md) and [selected scholarly context](../docs/LITERATURE.md).

GitHub mathematics preserves the original report's 370 expressions, the Lean
report's 26, and the October report's five display / eleven inline expressions.
Run `python3 tools/verify_repository.py` for publication consistency checks.
They do not prove the mathematics or execute a new research campaign.

Only English manuscripts are distributed. Original proper-name credits and
bibliographic titles are retained. No human peer-review acceptance, contest
acceptance, institutional endorsement or DOI is claimed. Cite the author,
date and signed release or exact commit; [CITATION.cff](../CITATION.cff) lists
all three reports. Project-authored material uses the MIT License.
