# v2.0.0: publication corrections and retained evidence

This release freezes the three English papers and the current research
publication. It corrects repository claims and privacy handling after a
[separate AI source review](../../docs/REVIEW_RESPONSE.md). There is no new
solver result, native run, actual opening kernel proof or independent-machine
replication. Paper bodies remain as published; the October working-edition
notice alone is removed. Read [paper errata](../../docs/PAPER_ERRATA.md).

## Newly public saved records

The [asset descriptor](assets.json) identifies
`mahjong-v17-records-v2.0.0.zip`: 46,202 payload files plus `CONTENTS.json`.
It retains all 38,329 payload files of the older native evidence asset and
adds 7,873 files, including:

- All 3,686 native bucket-close events, each recording `exactCoverage=true`.
- The root preflight, which accepts zero game rows and is not the root frame.
- Before/after identity pointers, the current/prior custody identity records,
  prior plan and lock-acquisition/handover evidence.
- All 3,700 resource reports and retained activity runtime/source records.

Twenty-four newly supplied members have identifying workstation prefixes
replaced with placeholders. The contents manifest separates their original
and public hashes; it does not claim byte identity after redaction. Base
asset files remain unchanged. The full 100.62 GB inputs, toolchain, executable
and local portable archives are not included.

```bash
python3 tools/audit_native_evidence.py --archive /path/to/mahjong-v17-records-v2.0.0.zip
python3 tools/privacy_guard.py --archive /path/to/mahjong-v17-records-v2.0.0.zip
```

The auditor checks asset/member hashes, the full saved ledger graph, Python
cursor cover, every close event and its frame/session/range binding, root
preflight scope, input-map handover arithmetic and resource-record inventory.
The [recorded audit](evidence/saved-record-audit.json) reports the completed
offline check. It starts no Lean/native/GPU process and reads no full table.
Its positive result does not retroactively change production acceptance gates.

## Additional trust-boundary source

[dependencies.json](dependencies.json) maps the Windows read-lock helper,
legacy GPU receipt rules, GPU package receipt and custody-handover source to
their public copies under [source/legacy](../2026-10-19-v17/source/legacy).
Original operations/mathematical sources are unchanged. These inspection
copies do not install `psutil`, a GPU environment or a native executable.

## Provenance, history and privacy

- [Record inventory and scope](evidence/record-inventory.json).
- [Historical kernel-status restoration](evidence/historical-kernel-status.json).
- [September privacy transformation](evidence/privacy-transformation.json).
- [Supplied AI review provenance](review-provenance.json).
- [Paper freeze manifest](../../papers/FREEZE.json) and [privacy policy](../../docs/PRIVACY.md).

The earlier immutable releases and signed tags remain unchanged. v2 source
archives contain the current sanitized tree, without a Git-history bundle.
Original digests retain provenance without publishing the original private
prefixes. Signatures authenticate this snapshot; they are not mathematical
proofs or independent execution replication.
