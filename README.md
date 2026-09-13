# Mahjong Achievement Game

**Exact computation and reproducible research on a shared-pool Mahjong game.**

[![Research checks](https://github.com/feierbuqiu/mahjong-achievement-game/actions/workflows/research.yml/badge.svg)](https://github.com/feierbuqiu/mahjong-achievement-game/actions/workflows/research.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Formal verification: in progress](https://img.shields.io/badge/Lean-verification_in_progress-yellow.svg)](formal/README.md)

## Result

The completed computation classifies the empty position as **P: the second
player wins under optimal play**. All six symmetry classes of first moves are
N. A second algorithm, using reverse physical-tile deletion, replayed the
complete P/N table with zero mismatches.

**End-to-end Lean verification is in progress.** The two computational
algorithms share the foundational rule implementation and state index. This
release provides a computational result and its evidence; it does not claim a
kernel-checked theorem about the opening. See the [evidence boundaries](docs/EVIDENCE.md).

| Recorded result | Value |
| --- | ---: |
| SAFE positions modulo rule symmetries | 778,532,864,302 |
| Tile-count layers | 0 through 34 |
| Nonempty storage buckets | 3,686 |
| P positions / N positions | 203,051,492,021 / 575,481,372,281 |
| Full reverse replay mismatches | 0 |
| Historical position checks | 16,240 matches; 0 conflicts |
| Full table payload | 97,316,623,312 bytes |

These are the recorded results of the September 13, 2026 research snapshot.
The [acceptance receipt](results/acceptance.json), [opening queries](results/opening.jsonl),
and [machine-readable status](RESEARCH_STATUS.json) state their scope.

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

- [Rules and SAFE reduction](docs/RULES.md): the exact game and normal-play recurrence.
- [Methods and strategy](docs/METHODS.md): symmetry indexing, forward generation, and reverse replay.
- [Evidence and limitations](docs/EVIDENCE.md): what each recorded check establishes.
- [Reproduction](docs/REPRODUCIBILITY.md): commands, expected outcomes, and resources.
- [Data availability](docs/DATA_AVAILABILITY.md): distributed artifacts and retained tables.
- [Research integrity](docs/RESEARCH_INTEGRITY.md): provenance, corrections, and AI assistance.
- [Formal verification status](formal/README.md): the remaining Lean evidence chain.
- [Signed contributions](CONTRIBUTING.md) and [signature verification](docs/SIGNING.md).

## Citation and license

Use [CITATION.cff](CITATION.cff) or GitHub's **Cite this repository** control.
Record the exact commit or signed release tag in any reproducibility report.
No DOI or peer-reviewed publication is claimed by this snapshot.

Project-authored code, documentation, and research artifacts are distributed
under the [MIT License](LICENSE). Citation is appreciated as a scholarly
practice; it is not an additional license condition.
