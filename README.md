# Mahjong Achievement Game

**Exact computation and reproducible research on a shared-pool Mahjong game.**

[![Research checks](https://github.com/feierbuqiu/mahjong-achievement-game/actions/workflows/research.yml/badge.svg)](https://github.com/feierbuqiu/mahjong-achievement-game/actions/workflows/research.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Lean opening: NOT_VERIFIED](https://img.shields.io/badge/Lean_opening-NOT__VERIFIED-orange.svg)](research/2026-10-18/README.md)

> **October 18, 2026 — approaching the final verification campaign.** The
> current working expectation is to finish the remaining compiled-Lean campaign
> **within 20 hours of an authorized start**. The improved V16 route estimates
> **13.03 hours for known components, including a 25% margin**.
> **The full scan has not started; correctness is undergoing independent review.**
> Final production-cost/admission checks remain outstanding and the user's
> launch hold remains in force. This is a conditional forecast, not completed
> verification. Read the [new source and evidence](research/2026-10-18/README.md)
> and [current project status](docs/PROJECT_STATUS.md).
> The opening Lean theorem remains **`NOT_VERIFIED`**; the computational result
> remains a **second-player win**. The immutable
> [v1.0.0 snapshot](https://github.com/feierbuqiu/mahjong-achievement-game/releases/tag/v1.0.0)
> preserves the earlier delivery.

## Read the two English papers

| English report by feierbuqiu | Date | Focus |
| --- | --- | --- |
| [Mahjong Achievement on a Shared Table: A Computational Second-Player Win and Partial Lean Certification](papers/manuscript.md) | September 13, 2026 | Rules, mathematical arguments, exhaustive computation and early Lean milestones |
| [Lean Verification of the Mahjong Achievement Game: Strategy Certificates, Enumeration, and Retrograde Models](papers/lean-verification/manuscript.md) | September 15, 2026 | Later certification, finite algorithm models, bounded tests and reproducibility |

The reports are presented together, with GitHub-compatible mathematical
formatting. See the [paper collection](papers/README.md),
[original evidence catalogue](papers/evidence/README.md),
[Lean paper and companion replay package](papers/lean-verification/README.md),
and [changelog](CHANGELOG.md). Chinese manuscripts are excluded from the release.

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
its complete proof trees are retained outside this public package. The compiled-Lean route has now completed layers 34, 33 and 32, covering
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
[October 18 update](research/2026-10-18/README.md) supersedes that outlook
and records the improved checker, current review and planned final campaign. The paper's partial opening
graph and later local registries describe different searches; their counts
are neither additive nor a formal-proof completion percentage.
The [acceptance receipt](results/acceptance.json), [opening queries](results/opening.jsonl),
and [machine-readable status](RESEARCH_STATUS.json) state their scope.

## Current outlook and contributions

The improved **V16 GPU-assisted compiled-Lean checker** changes the earlier
feasibility outlook. The current working expectation is a sub-20-hour finish
for the remaining campaign after independent correctness review and an
authorized start. It has not started. The selected build records **104 theorem
fingerprints across a 132-module source closure**; this update publishes the
source and existing audit logs for inspection.

| Current evidence | Value |
| --- | ---: |
| Complete compiled-checker layers | 32, 33 and 34 |
| Unique rows in those layers | 303,054,865 |
| Remaining planned rows | 778,229,809,437 |
| V16 known-component estimate including 25% margin | 13.0256 hours |
| Working finish expectation after an authorized start | Within 20 hours |
| Full-cost gate and full scan | Not passed / not started |

The known-component screen still excludes six production-cost categories.
Calibration samples and bounded controls do not establish a full-run time
bound or complete global certification. The independent review and complete
prelaunch assessment remain necessary. See the [detailed evidence and trust
boundary](research/2026-10-18/README.md).

The recorded workstation has an **Intel Core i7-10700KF (8 cores / 16 threads),
32 GiB RAM and an NVIDIA RTX 2070 SUPER**. A GPU now proposes one-byte row
records; compiled Lean checks the actual obligations. GPU output is untrusted.
The older CPU-only throughput figures remain historical measurements in the
[September 14 handoff](research/2026-09-14/README.md).

Contributions remain welcome: independent correctness review, a stronger
kernel-level opening certificate, a shorter mathematical argument, deeper
verification, alternative approaches, reproducibility improvements and other
substantive additions. Share a concrete proposal in the
[issue tracker](https://github.com/feierbuqiu/mahjong-achievement-game/issues).
Both English papers and the frozen v1.0.0 release remain available; this main
update records subsequent progress and creates no new release.

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

- [Computational research paper](papers/manuscript.md): original full report and appendices.
- [Lean verification paper](papers/lean-verification/manuscript.md): subsequent formal development and reproduction evidence.
- [Current project status](docs/PROJECT_STATUS.md): approaching the final campaign; independent review and the conditional 20-hour expectation.
- [October 18 source and evidence](research/2026-10-18/README.md): V16 checker, GPU/controller sources, complete layer 32, calibration and prelaunch hold.
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
