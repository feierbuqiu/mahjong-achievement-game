# Trust and formal verification supplement

**[Read the English paper](manuscript.md)**

*Trust and Formal Verification in the Mahjong Achievement Game: Complete Native Checking and Progress towards End-to-End Kernel Proofs* — **feierbuqiu**, 19 October 2026.

**Published scientific text frozen in v2.0.0.** Read with the
[repository errata](../../docs/PAPER_ERRATA.md) and [review response](../../docs/REVIEW_RESPONSE.md).
The former working-edition paragraph alone was removed. Scientific text,
tables, theorem type, mathematical expressions, bibliography, declaration and
associated audit memos remain as published. [FREEZE.json](../FREEZE.json)
records their identities.

The paper reports completed native-component coverage, persistent nonempty
game and numerical proofs, and same-host local delivery tests. Its whole-input
production-check wording requires the errata: external assembly and custody
remain trusted, and historical production did not gate native bucket-cover
Booleans. The actual empty-game kernel proof and independent-machine/full
execution replication remain unfinished.

## Evidence and availability

- [Evidence catalogue](evidence-catalogue.md), [source map](source-map.json), [publication provenance](provenance.json) and [formula inventory](equations.json).
- Frozen authoring audit memos: [formal](kernel_evidence.md), [native](native_evidence.md), [reproduction](reproducibility_evidence.md) and [references](reference_verification.md). Their internal workflow language and original claims are historical, not new maintenance instructions.
- [Historical audit output](native_record_audit.json) and [archival script](native_record_audit.py). That script retains its original workspace requirements; use the new public ZIP auditor below for a reproducible saved-record audit.
- [v2 saved-record asset](../../research/2026-10-19-v2/assets.json) adds the root preflight, all bucket-close events, custody handover, runtime records and all resource reports omitted by the earlier asset.
- [Local delivery identities](delivery.json): 1.407 GB core, 8.088 GB full-input archive and 21.14 MB saved-pilot archive. These three archives remain local; no download link is claimed.

```bash
python3 tools/verify_trust_supplement.py
python3 tools/verify_repository.py
python3 tools/audit_native_evidence.py --archive /path/to/mahjong-v17-records-v2.0.0.zip
```

The first two check published identities, formulas, tables, links and recorded
scope. The last reconstructs the saved ledger graph, cover, close events and
custody handover. None starts a Lean/native/GPU research run or reads the full
table. Same-host tests and a selected 56-row execution are not a second full run.

`document_validation.json` is an archived drafting receipt for an earlier
manuscript hash. It is not validation of the frozen final paper. The current
provenance and formula checks identify the actual public text independently.
GitHub math follows the [documented syntax](https://docs.github.com/en/get-started/writing-on-github/working-with-advanced-formatting/writing-mathematical-expressions).
Later scientific corrections belong in repository errata or a new paper.
