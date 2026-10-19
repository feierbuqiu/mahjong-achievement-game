# Publication privacy policy

v2.0.0 redacts eight identifying workstation paths from the current September
operational receipt. Original evidence hashes are retained separately from
the hashes of public copies; see the [transformation record](../research/2026-10-19-v2/evidence/privacy-transformation.json).
It also redacts identifying prefixes in 24 members of the new saved-record
archive. The raw research workspace remains local.

The maintainer elected to preserve older commits, tags and releases. v2 does
not rewrite history or claim that previously public copies have disappeared.
The new release distributes the current source tree and sanitized evidence;
it does not distribute a full Git-history bundle containing older copies.

## Required checks before publication

```bash
python3 tools/privacy_guard.py
python3 tools/privacy_guard.py --archive /path/to/release-source.zip --archive /path/to/evidence.zip
python3 tools/test_privacy_guard.py
```

The guard checks current tracked/non-ignored publication files, JSON-decoded
strings, repeated separators, Unicode/URL escapes, private-key/token patterns,
ZIP member names and ZIP member contents. It reports the affected public
filename and reason without printing a private value. ZIP inspection is
bounded to 1 GB expanded content and 100 MB per member; larger datasets need
a separately designed streaming review and are not authorized for upload by
this policy alone. No archive is extracted by this check.

Keep public handles, proper scholarly attribution and reproducible
workspace-relative paths. Replace identifying home/research prefixes with
placeholders such as `<user-home>` and `<research-root>`. Do not publish
credentials, private keys, private URLs, identifying workstation paths or
machine/account details that are unnecessary to assess the research.

These pattern checks cover the documented disclosure classes. They are not
a guarantee of anonymity or a substitute for inspecting new material.
Historical receipt digests authenticate original inputs; they must not be
misrepresented as hashes of a redacted public copy.
