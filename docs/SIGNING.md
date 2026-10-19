# Commit and release signatures

All commits published to repository branches must have a cryptographic
signature recognized by GitHub. Repository rules require signed commits;
the maintainer's publication checkout also signs commits and tags by default.

## Configure your own key

Generate a dedicated SSH signing key outside the repository and register its
**public** key in GitHub as a **signing key**. Keep the private key private.
Use your own identity and key; the maintainer's private key is never shared.

```bash
ssh-keygen -t ed25519 -f ~/.ssh/mahjong_signing -C "Mahjong commit signing"
gh ssh-key add ~/.ssh/mahjong_signing.pub --type signing --title "Mahjong signing"
git config --local gpg.format ssh
git config --local user.signingkey ~/.ssh/mahjong_signing
git config --local commit.gpgsign true
git config --local tag.gpgsign true
git commit -S -m "Describe the change"
```

Use an email associated with your GitHub account, including its verified
GitHub-provided no-reply address. Repository-local configuration avoids
changing the identity or signing policy of unrelated projects.

## Verify

Inspect a commit or annotated tag on GitHub and confirm **Verified**. To
verify SSH signatures locally, configure an `allowedSignersFile` containing
identities and public keys you have authenticated independently:

```bash
git config --local gpg.ssh.allowedSignersFile /path/to/allowed_signers
git verify-commit HEAD
git verify-tag v0.1.0
```

A line in that file has the form:

```text
your-verified-email namespaces="git" ssh-ed25519 YOUR_PUBLIC_KEY
```

The maintainer's public key and fingerprint are published in
[maintainer-signing-key.pub](../keys/maintainer-signing-key.pub) and
[keys/README.md](../keys/README.md). Compare them with the registered account
key; a key downloaded together with an untrusted commit is not an independent
trust anchor.

Release tags are annotated and signed. Signature verification establishes
artifact attribution, not the mathematical correctness of the result or
completion of Lean verification.

## Verify the v2 release files

The release supplies `SHA256SUMS` and its SSH signature, `SHA256SUMS.sig`.
After independently authenticating the maintainer public key, place it beside
the downloaded assets as `maintainer-signing-key.pub`. On a POSIX shell:

```bash
printf '%s ' '77802380+feierbuqiu@users.noreply.github.com namespaces="file"' > release-allowed-signers
cat maintainer-signing-key.pub >> release-allowed-signers
ssh-keygen -Y verify -f release-allowed-signers -I 77802380+feierbuqiu@users.noreply.github.com -n file -s SHA256SUMS.sig < SHA256SUMS
sha256sum --check SHA256SUMS
```

The checksum signature uses namespace `file`; Git commit/tag signatures use
namespace `git`. `SNAPSHOT.json` is covered by the signed checksum list and
identifies the exact tagged commit, source-tree comparison and check scope.
The source ZIP contains the sanitized current tree, without Git history.
The saved-record ZIP contains no full input dataset or actual opening proof.

Official references: [GitHub signature verification](https://docs.github.com/en/authentication/managing-commit-signature-verification/about-commit-signature-verification)
and [configuring Git signing](https://docs.github.com/en/authentication/managing-commit-signature-verification/telling-git-about-your-signing-key).
