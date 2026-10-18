# English research papers

Both reports by **feierbuqiu** were published in **v1.0.0** and retain their dated text. Read them together: the first develops the computational result; the second explains the subsequent Lean work and remaining obligations. The [October 19 V17 update](../research/2026-10-19-v17/README.md) records complete native verification under a kernel-proved implication and its remaining trust boundary.

| English report | Date | Contents |
| --- | --- | --- |
| **[Mahjong Achievement on a Shared Table: A Computational Second-Player Win and Partial Lean Certification](manuscript.md)** | 13 September 2026 | Rules, mathematical arguments, exhaustive computation, early concrete Lean proofs and seven appendices |
| **[Lean Verification of the Mahjong Achievement Game: Strategy Certificates, Enumeration, and Retrograde Models](lean-verification/manuscript.md)** | 15 September 2026 | Later strategy certification, finite models, compiled checks, implementation tests, proof boundaries and reproduction commands |

The computational conclusion is a second-player win. Complete V17 native
evaluation now supports it under a kernel-proved whole-input implication;
the closed actual-input opening Lean declaration remains **`NOT_VERIFIED`**.
The separate AI review is source/record inspection, not independent execution
replication or human peer review. A new paper has not yet been published.
These two reports retain their dated text, formulas and original scope.
See [current status](../docs/PROJECT_STATUS.md) and [claim boundaries](../docs/CLAIMS.md).

## Supporting material

- Original paper: [evidence catalogue](evidence/README.md), [source map](source-map.json), [publication provenance](provenance.json), [mathematical audit](evidence/mathematical_evidence.md), [computational audit](evidence/computational_evidence.md), and [Lean audit](evidence/lean_evidence.md).
- Lean paper: [publication overview and source companion](lean-verification/README.md), [evidence availability](lean-verification/evidence-catalogue.md), [publication provenance](lean-verification/provenance.json), and [reproduction audit](lean-verification/reproduction_evidence.md).
- [Published concrete formal proofs](../formal/README.md), [finite-model source replay](../research/2026-09-15/README.md), and [general reproduction guide](../docs/REPRODUCIBILITY.md).

Both Markdown papers use GitHub-compatible mathematics. The original report retains its published text and 370 expressions; the new report preserves its 26 expressions and numerical tables during publication. Check them using `python3 tools/verify_paper.py` and `python3 tools/verify_lean_supplement.py`.

Only English papers are distributed. Chinese manuscripts and their assembly files are excluded from Git and release assets. The reports include their attribution and AI-assistance disclosures. No journal peer review, contest acceptance or DOI is claimed.

Cite the relevant report(s), author, date, repository and exact release or commit. The root [CITATION.cff](../CITATION.cff) identifies the v1.0.0 software/evidence delivery and lists both reports. Historical tags remain useful for the earlier states they capture. Project-authored material uses the repository MIT License.
