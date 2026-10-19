# Trust and formal verification supplement

**[Read the English paper](manuscript.md)**

*Trust and Formal Verification in the Mahjong Achievement Game: Complete Native Checking and Progress towards End-to-End Kernel Proofs* — **feierbuqiu**, 19 October 2026.

**Working manuscript on `main`, awaiting further user-supplied external review.**
It is not frozen, tagged or accompanied by a new release. The earlier
[September reports](../README.md) remain available with their original text.

The paper distinguishes the completed V17 native result from a closed actual
opening Lean proof; records the later 28-block / 402-word numerical pilot and
nonempty-game proof variants; and describes completed same-host reconstruction,
controls and saved-proof replay. The packed sample's 1,035,129 colex rows are
numerical coverage, not that many newly certified original-game positions.
The strict-kernel opening theorem and second-machine/full native replication
remain unfinished, without a pure-kernel completion-time promise.

## Evidence and availability

- [Evidence catalogue](evidence-catalogue.md), [source map](source-map.json), [publication provenance](provenance.json), and [formula inventory](equations.json).
- [Formal audit](kernel_evidence.md), [native audit](native_evidence.md), [reproduction audit](reproducibility_evidence.md), and [reference audit](reference_verification.md).
- [Read-only record audit](native_record_audit.json) and its [archival script](native_record_audit.py). The original script requires the retained research workspace and is not the public saved-ZIP checker.
- [Local delivery identities and availability](delivery.json): 1.407 GB core, 8.088 GB full-input archive and 21.14 MB kernel-pilot archive. They are validated local artefacts; **no public download is supplied for those three archives by this update**.
- The previously public [63.46 MB native saved-evidence asset](../../research/2026-10-19-v17/assets.json) remains usable with its [public verifier](../../research/2026-10-19-v17/README.md). It has a different scope from the three local archives.

The core recipient test rebuilt 149 sources and the native executable,
fresh-replayed the generic implication, checked native controls and executed
one complete 56-row bucket. The optional saved-proof lanes were extracted
and replayed on the same host. These tests are not a second all-layer run
or independent-machine replication. Their source-reconstruction and saved-object
replay scopes remain distinct.

## Publication checks

```bash
python3 tools/verify_trust_supplement.py
python3 tools/verify_repository.py
```

These validate the imported bytes, five display / eleven inline formulas,
equation numbers, numerical tables, resource links and recorded scope.
They launch no Lean, compiler, native/GPU worker or full-input scan.
GitHub math follows the [documented math fences and inline delimiter syntax](https://docs.github.com/en/get-started/writing-on-github/working-with-advanced-formatting/writing-mathematical-expressions).

The authoring `document_validation.json` names an earlier draft. It is retained
as historical evidence, not claimed as validation of this imported version.
The publication provenance pins the actual source and public hashes; the new
publication checks validate the final imported manuscript independently of
that earlier document receipt.

The publication copy changes math formatting, public resource paths and
availability/release wording. It preserves the scientific statements, tables,
explicit theorem type, physical states, bibliography and AI declaration.
Hashes embedded in audit text identify original retained artefacts; public
copies have separate hashes where transformed. Future review and any later
freeze/release will be handled only after a new maintainer instruction.
