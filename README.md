# Mahjong Achievement Game

**Exact computation and reproducible research on a shared-pool Mahjong game.**

[![Research checks](https://github.com/feierbuqiu/mahjong-achievement-game/actions/workflows/research.yml/badge.svg)](https://github.com/feierbuqiu/mahjong-achievement-game/actions/workflows/research.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![V17 native: COMPLETE](https://img.shields.io/badge/V17_native-COMPLETE-green.svg)](research/2026-10-19-v17/README.md)
[![Closed Lean opening: NOT_VERIFIED](https://img.shields.io/badge/Closed_Lean_opening-NOT__VERIFIED-orange.svg)](docs/CLAIMS.md)

> **October 19 update — complete V17 native verification.**
> The Lean kernel proves that six finite Boolean acceptance families imply
> `SecondPlayerWins Step Win empty`. The same check functions, compiled to
> native code, accepted the complete actual input: **778,532,864,302 SAFE
> orbits, all 35 layers, 3,686 buckets and 17,317 frames**, with no old PASS
> or seed import. The run took about **7.6 hours** on the recorded workstation.
> **This is a kernel-proved implication plus complete native evaluation;
> it is not a closed Lean declaration for the actual opening.** Compiler,
> runtime, OS/hardware, input custody and external bookkeeping remain trusted.
> A [separate AI review](research/2026-10-19-v17/review/INDEPENDENT_REVIEW.md)
> reports no defects within its inspected scope; independent execution
> replication and human peer review have not been completed.
> The [new working paper](papers/trust-verification/manuscript.md) adds
> later proof-component and local-reproduction evidence.
> Read the [completed native result](research/2026-10-19-v17/README.md),
> [claim boundaries](docs/CLAIMS.md) and [project status](docs/PROJECT_STATUS.md).

## Latest English paper

**[Trust and Formal Verification in the Mahjong Achievement Game: Complete Native Checking and Progress towards End-to-End Kernel Proofs](papers/trust-verification/manuscript.md)**

feierbuqiu — 19 October 2026. **Working manuscript on `main`; not frozen or released.**

The new supplement explains the complete native result, its trust boundary,
persistent nonempty-game and numerical proof components, and completed local
portable-delivery tests. The numerical pilot covers 28 fixed blocks / 402
words and 1,234 layout equalities, with a 273-module fresh replay; it does not
certify those coordinates as complete original-game positions. The physical
11-node pilot and numerical sample have not been joined into an actual empty-game
kernel proof. A new external review of this manuscript is pending.

| English report by feierbuqiu | Date | Scope |
| --- | --- | --- |
| [Trust and Formal Verification](papers/trust-verification/manuscript.md) | 19 October 2026 | Current working supplement: complete native checking, saved component proofs, trust and local reproduction |
| [Lean Verification: Strategy Certificates, Enumeration, and Retrograde Models](papers/lean-verification/manuscript.md) | 15 September 2026 | Dated formal and finite-model report, preserved in v1.0.0 |
| [Mahjong Achievement on a Shared Table](papers/manuscript.md) | 13 September 2026 | Original computational second-player result and early Lean milestones, preserved in v1.0.0 |

The papers use GitHub-compatible mathematical formatting. The new paper's
[overview](papers/trust-verification/README.md), [evidence catalogue](papers/trust-verification/evidence-catalogue.md)
and [delivery availability](papers/trust-verification/delivery.json) distinguish
public material from validated local archives. All three reports remain
accessible in the [paper collection](papers/README.md). Chinese manuscripts
are excluded. No new tag or release is created by this update.

## Result

The completed computation classifies the empty position as **P: the second
player wins under optimal play**. All six symmetry classes of first moves are
N. A second algorithm, using reverse physical-tile deletion, replayed the
complete P/N table with zero mismatches.

**The computational conclusion and incomplete formal proof are separate.**
The two full-table algorithms share the foundational rule implementation and
state index. The published September 13 proof package contains eight concrete
nonempty roots and 1,008 Lean modules with a clean kernel-replay command.
Later local work accumulated a registry reporting **24,655 certified P states**;
its complete proof trees are retained outside this public package. The earlier compiled-Lean route completed layers 34, 33 and 32, covering
**303,054,865 unique rows**; the [October update](research/2026-10-18/README.md)
records the new layer-32 audit and its retained verifier identities.
Neither route closes the 10-tile or empty-position theorem. See the
[complete-layer receipts](research/2026-09-14/README.md),
[published nonempty proofs](formal/README.md), and [evidence boundaries](docs/EVIDENCE.md).

The September 15 work added **79 audited theorems across 10 finite algorithm-model
modules** and bounded tests of the production C++ routines: **102 synthetic
configurations and 13,741,216 row comparisons, with zero mismatches**.
The [September 15 update](research/2026-09-15/README.md) publishes their
84-module Lean dependency closure and selected receipts. These tests add
**zero historical P/N rows**; universal C++ refinement, formal binding of the
historical full-table output, and the concrete opening theorem remain unfinished.

| Recorded result | Value |
| --- | ---: |
| SAFE positions modulo rule symmetries | 778,532,864,302 |
| Tile-count layers | 0 through 34 |
| Nonempty storage buckets | 3,686 |
| P positions / N positions | 203,051,492,021 / 575,481,372,281 |
| Full reverse replay mismatches | 0 |
| Historical position checks | 16,240 matches; 0 conflicts |
| Full table payload | 97,316,623,312 bytes |

These computational results and the original English paper are dated September 13,
2026. The [September 14 supplement](research/2026-09-14/README.md) records an
earlier stage of formal work; [September 15](research/2026-09-15/README.md)
records later model proofs and the earlier maintainer decision. The
[earlier October V16 update](research/2026-10-18/README.md) and
[later kernel-certificate update](research/2026-10-18-kernel/README.md)
record successive changes in methods and evidence boundaries. The paper's partial opening
graph and later local registries describe different searches; their counts
are neither additive nor a formal-proof completion percentage.
The [acceptance receipt](results/acceptance.json), [opening queries](results/opening.jsonl),
and [machine-readable status](RESEARCH_STATUS.json) state their scope.

## Verification status and contributions

| Result | Scope |
| --- | --- |
| September C++ computation and full reverse replay | Empty position P; both implementations share foundational rules and index |
| V17 whole-input implication | Kernel-proved original-game conclusion from six finite acceptance families |
| Completed V17 native evaluation | All 778,532,864,302 stored labels checked; P/N recurrence and full input/coverage controls accepted |
| Separate AI cross-check | Saved 17,317-frame ledger and 54,548 cross-layer identity references; no defects found in reviewed scope |
| Independent execution replication | Not completed |
| Closed actual-input opening Lean theorem | NOT_VERIFIED |

The complete run **checks the historical labels**; it does not regenerate the
table. A native PASS and a saved kernel proof have different trust boundaries.
The [evidence guide](docs/EVIDENCE.md) and [reproduction instructions](docs/REPRODUCIBILITY.md)
explain what readers can inspect or repeat. The 63.46 MB saved-record archive
is a [separate release asset](research/2026-10-19-v17/assets.json), with hashes
in Git; the 100.62 GB input set is currently represented by its complete hash map.

The earlier [V18/V19 proof-export experiments](research/2026-10-18-kernel/README.md)
remain dated small/component results. Later bounded component work completed
the fixed numerical sample and further nonempty-game proof trials; see the
[new paper](papers/trust-verification/manuscript.md). These are separate from
the completed native run. The old V16 campaign remains
stopped. No whole-task time bound for a future closed actual-input proof is claimed.

Independent replication on another machine or toolchain, human reading of
the rules and trusted bookkeeping, alternative proofs, corrections and
reproducibility improvements remain welcome through the
[issue tracker](https://github.com/feierbuqiu/mahjong-achievement-game/issues).
The two September English papers remain dated reports. The new October
paper is a working main-branch manuscript, awaiting further external review. See the [internal-version glossary](docs/INTERNAL_VERSIONS.md)
for V16/V17/V18/V19 and the distinction from release versions.

## The game

Two players alternate adding one available tile to a single public, cumulative
pool. There are 34 tile kinds and four copies of each kind. The player whose
addition first makes the pool contain a legal 14-tile winning subset wins;
extra tiles may be ignored.

Winning forms are four melds and a pair, seven pairs of **seven distinct
kinds**, or thirteen orphans. Selection is deterministic and all information
is public. Read the [complete rules and notation](docs/RULES.md).

## Start here

Python 3.10+ and a C++17 compiler are sufficient for the public reproduction
tools. Python uses only its standard library. On Linux:

```bash
git clone https://github.com/feierbuqiu/mahjong-achievement-game.git
cd mahjong-achievement-game
python3 tools/verify_repository.py
python3 tools/reproduce.py build
python3 tools/reproduce.py smoke
```

The smoke run checks the index against physical moves, recomputes the complete
34-tile terminal layer, and replays that layer in reverse. It is a small
reproduction check, not a fresh verification of the opening.

The [reproduction guide](docs/REPRODUCIBILITY.md) covers Windows, full-table
generation, full reverse replay, historical checks, and physical-coordinate
strategy queries. The 97.32 GB table is **not included in Git**; its per-bucket
hashes and exact reconstruction commands are included. See [data availability](docs/DATA_AVAILABILITY.md).

## Research materials

- [Current trust and verification paper](papers/trust-verification/manuscript.md): whole-game evidence, persistent components and tested local delivery.
- [Computational research paper](papers/manuscript.md): original full report and appendices.
- [Lean verification paper](papers/lean-verification/manuscript.md): subsequent formal development and reproduction evidence.
- [Current project status](docs/PROJECT_STATUS.md): completed native verification, explicit trust boundary and remaining replication/proof work.
- [V17 native completion](research/2026-10-19-v17/README.md): source, recorded checks, separate AI review and hash-pinned evidence asset.
- [Claim boundaries](docs/CLAIMS.md) and [internal-version glossary](docs/INTERNAL_VERSIONS.md).
- [Historical October kernel-source update](research/2026-10-18-kernel/README.md): V17/V18/V19 sources, saved-proof receipts and precise scope.
- [Earlier October V16 source and evidence](research/2026-10-18/README.md): historical compiled-checker work, layer 32 and the superseded forecast.
- [September 15 finite-model status](research/2026-09-15/README.md): finite
  algorithm proofs, bounded tests, remaining obligations, and maintainer scope.
- [September 14 research handoff](research/2026-09-14/README.md): complete-layer
  checks, hardware, performance evidence, and the earlier decision to pause.
- [Rules and SAFE reduction](docs/RULES.md): the exact game and normal-play recurrence.
- [Methods and strategy](docs/METHODS.md): symmetry indexing, forward generation, and reverse replay.
- [Evidence and limitations](docs/EVIDENCE.md): what each recorded check establishes.
- [Reproduction](docs/REPRODUCIBILITY.md): commands, expected outcomes, and resources.
- [Data availability](docs/DATA_AVAILABILITY.md): distributed artifacts and retained tables.
- [Research integrity](docs/RESEARCH_INTEGRITY.md): provenance, corrections, and AI assistance.
- [Formal verification](formal/README.md): eight indexed nonempty-position roots,
  source replay, and the remaining opening proof work.
- [Signed contributions](CONTRIBUTING.md) and [signature verification](docs/SIGNING.md).

## Citation and license

Use [CITATION.cff](CITATION.cff) or GitHub's **Cite this repository** control.
Record the exact commit or signed release tag in any reproducibility report.
No DOI or peer-reviewed publication is claimed by this snapshot.

Project-authored code, documentation, and research artifacts are distributed
under the [MIT License](LICENSE). Citation is appreciated as a scholarly
practice; it is not an additional license condition.
