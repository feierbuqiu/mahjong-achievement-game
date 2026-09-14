# Contributing

Thank you for helping make this result inspectable and reproducible.
Use English for repository documentation, issues, pull requests, and commit
messages. Keep changes focused and explain any effect on the research claim.

The [v1.0.0 delivery](docs/PROJECT_STATUS.md) closes the maintainer's active
research phase. Substantive new findings, necessary corrections and reproducibility
improvements remain welcome, but routine progress or a review schedule is not promised.

## Workflow

1. Open an issue for a substantial change in the model, algorithm, evidence,
   or theorem. Small documentation fixes can go directly to a pull request.
2. Work on a topic branch. Preserve the stated rules and separate UNKNOWN
   from completed P/N outcomes.
3. Run `python tools/verify_repository.py` and the checks appropriate to the
   change. Changes to rules/index/search require meaningful differential or
   reproduction evidence, not just a successful compile.
4. Cryptographically sign **every commit** and ensure GitHub shows it as
   Verified. `git commit -s` adds a sign-off line and is not a signature;
   use `git commit -S` with a registered signing key.
5. Open a pull request with the evidence scope, commands, outcomes, and
   limitations. Required automated checks and branch rules must pass.

The default branch accepts changes through pull requests after bootstrap.
There is no mandatory human approval count; maintainers can still request
changes. The signed-commit rule applies to all repository branches.

## Research artifacts

Record source versions, inputs, budgets, toolchains, completed outcomes, and
hashes. Use `build/` and `runs/` for generated work and separate output paths
for concurrent experiments. Never overwrite a frozen result to make a check
pass. A changed artifact needs an explained provenance update and new checksum.

Do not submit private keys, credentials, personal workstation paths, large
tables, binaries, or active tool caches. Follow [data availability](docs/DATA_AVAILABILITY.md)
for publication of large evidence sets.

## License and credit

Submit only material you are authorized to contribute. Project contributions
are provided under the repository's MIT License unless an exception is
explicitly agreed and documented. Preserve third-party license notices and
identify external or AI-assisted sources where relevant.

See [signature setup](docs/SIGNING.md), [research integrity](docs/RESEARCH_INTEGRITY.md),
and the [code of conduct](CODE_OF_CONDUCT.md).
