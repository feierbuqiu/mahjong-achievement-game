# English research papers

Both reports by **feierbuqiu** were published in **v1.0.0** and retain their dated text. Read them together: the first develops the computational result; the second explains the subsequent Lean work and remaining obligations. The [later October kernel-certificate update](../research/2026-10-18-kernel/README.md) records subsequent methods, results and remaining gaps.

| English report | Date | Contents |
| --- | --- | --- |
| **[Mahjong Achievement on a Shared Table: A Computational Second-Player Win and Partial Lean Certification](manuscript.md)** | 13 September 2026 | Rules, mathematical arguments, exhaustive computation, early concrete Lean proofs and seven appendices |
| **[Lean Verification of the Mahjong Achievement Game: Strategy Certificates, Enumeration, and Retrograde Models](lean-verification/manuscript.md)** | 15 September 2026 | Later strategy certification, finite models, compiled checks, implementation tests, proof boundaries and reproduction commands |

The computational conclusion is a second-player win. The end-to-end opening Lean theorem remains **`NOT_VERIFIED`**. Version 1 marks completion of this research delivery, not a complete formal proof. Current work targets persistent kernel certificates and compression. Generic bridges and a small actual-data closed pilot are recorded; the actual opening instance and a reliable 20/24-hour whole-task bound remain open. Deeper and alternative contributions remain welcome. See [project status](../docs/PROJECT_STATUS.md).

## Supporting material

- Original paper: [evidence catalogue](evidence/README.md), [source map](source-map.json), [publication provenance](provenance.json), [mathematical audit](evidence/mathematical_evidence.md), [computational audit](evidence/computational_evidence.md), and [Lean audit](evidence/lean_evidence.md).
- Lean paper: [publication overview and source companion](lean-verification/README.md), [evidence availability](lean-verification/evidence-catalogue.md), [publication provenance](lean-verification/provenance.json), and [reproduction audit](lean-verification/reproduction_evidence.md).
- [Published concrete formal proofs](../formal/README.md), [finite-model source replay](../research/2026-09-15/README.md), and [general reproduction guide](../docs/REPRODUCIBILITY.md).

Both Markdown papers use GitHub-compatible mathematics. The original report retains its published text and 370 expressions; the new report preserves its 26 expressions and numerical tables during publication. Check them using `python3 tools/verify_paper.py` and `python3 tools/verify_lean_supplement.py`.

Only English papers are distributed. Chinese manuscripts and their assembly files are excluded from Git and release assets. The reports include their attribution and AI-assistance disclosures. No journal peer review, contest acceptance or DOI is claimed.

Cite the relevant report(s), author, date, repository and exact release or commit. The root [CITATION.cff](../CITATION.cff) identifies the v1.0.0 software/evidence delivery and lists both reports. Historical tags remain useful for the earlier states they capture. Project-authored material uses the repository MIT License.
