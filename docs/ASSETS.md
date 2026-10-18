# Evidence assets and retention

Small source, exact input identities, summaries and citation metadata belong
in Git. Large saved-record collections are published as separate release
assets, with their byte size, SHA-256, scope and download URL committed in
the repository. The publication tag is distinct from a software version.

## V17 native evidence

The [asset descriptor](../research/2026-10-19-v17/assets.json) pins the
63,456,055-byte `mahjong-v17-native-evidence-20261019.zip` and its full SHA-256.
Download it from the
[evidence release](https://github.com/feierbuqiu/mahjong-achievement-game/releases/tag/evidence-v17-native-20261019),
then run:

```bash
python3 research/2026-10-19-v17/verify.py --archive /path/to/mahjong-v17-native-evidence-20261019.zip
```

The helper reads the ZIP without extracting it, rejects a different hash,
validates every member and checks the full saved ledger/receipt graph. The
asset includes 38,329 original relative-path files, including all 17,317
native frame results. `CONTENTS.json` identifies every payload member.
The published verifier does not execute Lean, native code or a game scan.

The 100.62 GB actual input dataset and the original native/toolchain binaries
are not part of this asset. The code repository supplies their identities
where recorded; a digest is not a download service. See [data availability](DATA_AVAILABILITY.md).

## Publication rules

- Preserve existing signed tags and immutable releases. Publish a corrected
  asset under a new identity rather than silently replacing pinned bytes.
- Preserve original record bytes when practical. For sanitized copies,
  publish both original and distributed hashes and describe the transformation.
- Keep partial `.part` archives, private paths, credentials, Chinese manuscripts
  and unreviewed workstation dumps out of public assets.
- A release asset must have a usable descriptor and verification command.
  State whether it supplies saved evidence, input data, sources or a tested
  reproduction environment; do not substitute one for another.
- Preserve the small older evidence already cited by dated papers in Git.
  Moving it would break existing provenance/link contracts, and rewriting Git
  history would not improve reproducibility. The large new record graph is
  kept outside the source tree from its first publication.

GitHub hosting is an access route, not a claim of permanent archival custody
or a DOI. Cite the signed commit, asset digest and relevant report date.
