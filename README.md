# Mahjong Achievement Game

**Exact computation and reproducible research on a shared-pool Mahjong game.**

[![Research checks](https://github.com/feierbuqiu/mahjong-achievement-game/actions/workflows/research.yml/badge.svg)](https://github.com/feierbuqiu/mahjong-achievement-game/actions/workflows/research.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Lean opening: NOT_VERIFIED](https://img.shields.io/badge/Lean_opening-NOT__VERIFIED-orange.svg)](research/2026-09-15/README.md)

> **Status: September 15, 2026.** The maintainer **will not undertake further
> end-to-end or full-scale Lean closure verification**. The computational
> result remains a **second-player win**; the empty-position Lean theorem
> remains **`NOT_VERIFIED`**. Contributors with formal-methods expertise and
> suitable compute are welcome to continue the work. **The repository remains
> open to updates; this update creates no release or tag and does not freeze
> current work.** A separate Lean progress report is planned. See the
> [current Lean status and available source](research/2026-09-15/README.md).

## Read the paper

**[Mahjong Achievement on a Shared Table: A Computational Second-Player Win and Partial Lean Certification](papers/manuscript.md)**
**feierbuqiu** · English research report · September 13, 2026

The full paper contains the mathematical arguments, computational results,
Lean milestones, references, and seven appendices. Formulas render directly
on GitHub. See the [paper overview](papers/README.md),
[evidence catalogue](papers/evidence/README.md), and [latest progress](CHANGELOG.md).

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
its complete proof trees are retained outside this public package. A newer
compiled-Lean checker completed layers 34 and 33, covering **22,512,356 rows**.
Neither route closes the 10-tile or empty-position theorem. See the
[complete-layer receipts](research/2026-09-14/README.md),
[published nonempty proofs](formal/README.md), and [evidence boundaries](docs/EVIDENCE.md).

The latest work adds **79 audited theorems across 10 finite algorithm-model
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

These computational results and the English paper are dated September 13,
2026. The [September 14 supplement](research/2026-09-14/README.md) records an
earlier stage of formal work; [September 15](research/2026-09-15/README.md)
records later model proofs and the current maintainer decision. The paper's partial opening
graph and later local registries describe different searches; their counts
are neither additive nor a formal-proof completion percentage.
The [acceptance receipt](results/acceptance.json), [opening queries](results/opening.jsonl),
and [machine-readable status](RESEARCH_STATUS.json) state their scope.

## Maintainer scope and contributions

The present workstation has an **Intel Core i7-10700KF (8 cores / 16 threads),
32 GiB installed RAM, and an NVIDIA RTX 2070 SUPER**. The checker uses the CPU;
there is no GPU implementation. The measured jobs were limited to 15.5 GB of
aggregate process memory and 80% of machine CPU capacity.

| General-row benchmark | Measured scan throughput |
| --- | ---: |
| Selected layer-32 buckets, 12 processes x 1 thread | 25,921 rows/second |
| Selected peak-layer-23 buckets, 2 processes x 6 threads | 2,567 rows/second |
| Average needed for all 778,532,864,302 rows in 30 days | 300,360 rows/second |

These September 14 measurements are bounded samples with file-loading time excluded, not a whole-table
runtime forecast. General-layer scaling is currently far below the 30-day
target, and the final coverage/aggregation proof is still incomplete. The
maintainer does not expect a near-term breakthrough with the current approach
and personal resources, and has stopped pursuing that verification campaign.
The maintainer will not undertake further end-to-end or full-scale Lean closure
verification. No full scan is running and no completion date is promised.

Contributions are welcome: a shorter independent argument, a complete Lean
certificate, profiling and checker improvements, or measured trials on a
larger compute host. More RAM or advertised core count alone does not establish
feasibility. Start with the [current proof boundaries and source](research/2026-09-15/README.md)
and [hardware and benchmark receipts](research/2026-09-14/README.md)
and discuss a concrete proposal in the
[issue tracker](https://github.com/feierbuqiu/mahjong-achievement-game/issues).
Existing proofs remain reproducible, and their CI checks continue. Documentation,
the planned separate Lean progress report, corrections, and contributed results
can still be added to `main`; current work is not frozen. Existing releases
remain historical records.

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

- [Full English paper](papers/manuscript.md): primary research report and appendices.
- [Current Lean status (September 15)](research/2026-09-15/README.md): finite
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
