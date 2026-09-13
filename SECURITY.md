# Security policy

## Scope and reporting

This repository contains local research programs. The latest published
release is the supported version for security corrections; no response-time
or long-term maintenance guarantee is made.

For a vulnerability or exposed credential, use GitHub's private vulnerability
reporting at [Report a vulnerability](https://github.com/feierbuqiu/mahjong-achievement-game/security/advisories/new).
Include the affected commit, reproducible steps, and impact without posting
live secrets in a public issue. If that control is unavailable, ask the
maintainer for a private reporting route without disclosing sensitive details.

Scientific disagreements and ordinary reproduction failures belong in public
issues, where the evidence can be examined collaboratively.

## Handling artifacts

Do not commit private signing keys, access tokens, or personal data. Verify
source and data identities before using external tables. Treat downloaded
executables as code with the privileges of the invoking account. The standard
workflow builds from source and does not require privileged execution.
