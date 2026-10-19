# English research papers

The latest report by **feierbuqiu** is a working manuscript on `main`.
The two September reports retain their dated text and immutable v1.0.0
delivery. No new tag, release or frozen paper version accompanies this update.

| Report | Date | Contents and status |
| --- | --- | --- |
| **[Trust and Formal Verification in the Mahjong Achievement Game: Complete Native Checking and Progress towards End-to-End Kernel Proofs](trust-verification/manuscript.md)** | 19 October 2026 | Current working supplement: complete V17 native checking, trust boundaries, persistent game/numerical pilots and same-host portable delivery; pending further external review |
| [Lean Verification of the Mahjong Achievement Game: Strategy Certificates, Enumeration, and Retrograde Models](lean-verification/manuscript.md) | 15 September 2026 | Dated formal development, finite models, bounded native checks and reproducibility |
| [Mahjong Achievement on a Shared Table: A Computational Second-Player Win and Partial Lean Certification](manuscript.md) | 13 September 2026 | Original exhaustive computation, mathematical arguments and early concrete Lean proofs |

The whole-game claim is a kernel-proved implication plus complete native
evaluation under its stated execution/bookkeeping trust boundary. The new
packed numerical certificates and concrete nonempty-game proofs retain their
separate scopes. They do not yet compose into a closed actual-input opening
Lean theorem, and a second physical-machine/full native replication is absent.
See [current status](../docs/PROJECT_STATUS.md) and [claim boundaries](../docs/CLAIMS.md).

## Supporting material

- Latest supplement: [overview](trust-verification/README.md), [evidence catalogue](trust-verification/evidence-catalogue.md), [provenance](trust-verification/provenance.json), and [delivery availability](trust-verification/delivery.json).
- Original paper: [evidence catalogue](evidence/README.md), [source map](source-map.json), [provenance](provenance.json) and its retained mathematical/computational/formal audits.
- September Lean paper: [overview](lean-verification/README.md), [evidence availability](lean-verification/evidence-catalogue.md), [provenance](lean-verification/provenance.json), and [reproduction audit](lean-verification/reproduction_evidence.md).
- [Concrete formal source](../formal/README.md), [finite-model replay](../research/2026-09-15/README.md), [completed V17 native evidence](../research/2026-10-19-v17/README.md), and [reproduction guide](../docs/REPRODUCIBILITY.md).

All papers use GitHub-compatible math. The existing 370 and 26 expressions
are preserved in the dated reports. The new paper has five display and
eleven inline expressions, checked for preserved content and equation numbering.
Run `python3 tools/verify_repository.py` for all publication checks, or
`python3 tools/verify_trust_supplement.py` for the latest paper.

Only English manuscripts are distributed. Proper-name origin credits and
bibliographic titles are preserved. The new working manuscript awaits later
user-supplied external AI review; no new independent review, journal acceptance,
contest acceptance or DOI is claimed. The existing separate AI source/record
review of V17 retains its original narrower scope.

Cite the relevant report, author, date and exact commit. [CITATION.cff](../CITATION.cff)
lists all three reports; its software version/date still identify v1.0.0.
Project-authored material uses the repository MIT License.
