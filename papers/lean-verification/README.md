# Lean verification paper

**[Read the English paper](manuscript.md)**

*Lean Verification of the Mahjong Achievement Game: Strategy Certificates,
Enumeration, and Retrograde Models* — **feierbuqiu**, 15 September 2026.

This paper is published alongside the [September 13 computational paper](../manuscript.md)
in **v1.0.0**, the release closing the maintainer's active research phase.
It explains the later concrete strategy bank, compiled checks of layers 33/34,
finite enumeration and algorithm proofs, implementation tests, and remaining
obligations. It preserves the computational second-player conclusion and the
**`NOT_VERIFIED`** status of the empty-position Lean theorem. The Chinese
edition is excluded from this repository and its release assets.

## Paper and supporting material

- [Full English manuscript](manuscript.md), including the selected theorem interfaces,
  evidence identities, references and reproduction commands.
- [Formal evidence audit](formal_evidence.md), [empirical audit](empirical_evidence.md),
  [empirical data extract](empirical_evidence.json), [reproduction audit](reproduction_evidence.md)
  and [reference verification](reference_verification.md).
- [Publication provenance](provenance.json), [formula-preservation inventory](equations.json)
  and [retained-source catalogue](evidence-catalogue.md).
- [Fresh source replay receipt](reproduction/source-replay.json),
  [recipient-path replay receipt](reproduction/recipient-replay.json) and
  [final package validation](reproduction/recipient_delivery_validation.json).
- [84-module source closure in Git](../../research/2026-09-15/lean/Mahjong/OptimizedRetroCertification.lean)
  and the [bounded repository replay command](../../research/2026-09-15/README.md).

The paper preserves 26 mathematical expressions and all numerical table tokens.
The publication uses GitHub math fences and code-form inline math, with protected
table delimiters and equation numbers inside each display. See
[GitHub's mathematical-expression documentation](https://docs.github.com/en/get-started/writing-on-github/working-with-advanced-formatting/writing-mathematical-expressions).

## Standalone model replay package

**[Download current_model_source_bundle.zip](https://github.com/feierbuqiu/mahjong-achievement-game/releases/download/v1.0.0/current_model_source_bundle.zip)**
from the [v1.0.0 release](https://github.com/feierbuqiu/mahjong-achievement-game/releases/tag/v1.0.0).
The archive is 175,554 bytes, contains 91 input files including 84 Lean modules,
and retains the exact bytes tested for the paper. SHA-256:
`fdd9e7ebaaaeac891e746b69f604ee9fc92ccdb85c4c03f92b4affd164f4da33`.
Its proof sources match the existing September 15 source closure; this is an
additional delivery/reproduction route, with **zero new historical P/N rows**.

The [bundled instructions](reproduction/model-bundle-instructions.md) describe
the **extracted ZIP**, using Windows, Python 3.11+, `psutil` 7.2.2 and Lean 4.33.1.
The model-only replay does not require the 97.32 GB P/N table. The controller's
Linux/macOS execution is not claimed; the separate repository replay command
has Linux CI coverage. See the [companion identity](companion.json),
[source manifest](reproduction/model-source-manifest.json), and
[retained package replay summary](reproduction/model-bundle-replay.json).

## Availability and limits

The full later 24,655-state proof bank, large finite native inputs, complete
operational harness collection and historical P/N payload remain outside Git
and this release. Their recorded counts are not a claim that all those proof
trees or input sets can be reconstructed from the small companion archive.
The original acceptance names 5,329 retained files; only the explicitly listed
publication subset is distributed.

Two replay receipts contain public path placeholders. Four redundant non-English
free-text fields are omitted from the empirical JSON extract. The
[provenance manifest](provenance.json) records every transformation and both
original and public hashes. Original hashes in the manuscript and historical
receipts identify retained originals, not transformed public copies.

Replaying the model source, checking a receipt, and signing a release each have
their stated scope. None establishes universal C++ refinement, a complete
historical-output certificate, or an empty-position Lean strategy theorem.

## Citation

feierbuqiu. (2026). *Lean verification of the Mahjong achievement game:
Strategy certificates, enumeration, and retrograde models* [Research report].
Mahjong Achievement Game, v1.0.0. Cite the exact release or commit used.

This is an English research report with explicit AI-assistance disclosure;
no independent human peer review, journal acceptance or DOI is claimed.
Project-authored material is distributed under the repository MIT License.
