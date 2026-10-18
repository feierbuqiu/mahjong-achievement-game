# Mahjong Achievement Game

**Exact computation and reproducible research on a shared-pool Mahjong game.**

[![Research checks](https://github.com/feierbuqiu/mahjong-achievement-game/actions/workflows/research.yml/badge.svg)](https://github.com/feierbuqiu/mahjong-achievement-game/actions/workflows/research.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Lean opening: NOT_VERIFIED](https://img.shields.io/badge/Lean_opening-NOT__VERIFIED-orange.svg)](research/2026-10-18-kernel/README.md)

> **Later October 18 update — persistent kernel proofs and certificate compression.**
> The current goal is a saved, closed Lean proof of the actual original-game
> empty position, with cold standard-kernel replay. Generic composition theorems
> and a small actual-data closed pilot have been obtained; compressed numeric
> and local-metadata certificates are being studied.
> **The actual opening theorem remains `NOT_VERIFIED`; no reliable 20/24-hour
> end-to-end completion bound is established.** The earlier 13.03-hour estimate
> concerns a different, compiled-checker workload and is not a forecast for this
> proof-certificate route. The legacy whole-table scan remains stopped.
> Read the [current evidence and source](research/2026-10-18-kernel/README.md)
> and [project status](docs/PROJECT_STATUS.md).

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

## Current proof work and contributions

The project now studies **saved kernel-checkable certificates**, with the
actual original-game theorem `SecondPlayerWins Step Win empty` as the target.
Current results include V17 generic composition, V18 closed proofs for three
specific nonempty 32-tile roots and captured checker inputs, and V19 certificate
compression/numeric-layout experiments. The new
[source and receipt catalogue](research/2026-10-18-kernel/README.md) describes
what each result establishes and what remains open.

| Current result | Exact scope |
| --- | --- |
| V17 generic composition | 13 new sources; 145-module fresh kernel replay; actual full input not instantiated |
| V18 original-game pilot | 11 nodes, two 32-tile P roots and one 32-tile N root |
| V18 checker pilot | 56 distinct captured rows; saved proof and cold replay |
| V19 numeric/layout experiments | Supplied finite relations and local metadata; complete original-game binding remains separate |
| Actual empty-state kernel proof | NOT_VERIFIED |
| End-to-end completion time | No established 20/24-hour bound |

The earlier V16 estimate of **13.0256 hours including 25% margin** covered
known components of compiled-checker execution and omitted six production
costs. Proof construction, persistence, dependency loading, assembly and cold
kernel replay are a different workload. The previous imminent/sub-20-hour
finish expectation is superseded. Successful small samples do not establish
whole-task time, storage or memory feasibility.

The historical compiled checks of layers 32–34 cover 303,054,865 unique rows;
this is not a count of newly closed kernel-certified global rows. The recorded
i7-10700KF / 32 GiB / RTX 2070 SUPER machine and its old GPU/native timings
remain useful context, with their original trust and measurement boundaries.
The legacy whole-table STOP remains; bounded proof research is a separate activity.

Contributions remain welcome: independent arguments, deeper formal review,
alternative sparse or compressed certificates, original-game data binding,
reproducibility improvements and careful performance measurements. Share a
concrete proposal in the [issue tracker](https://github.com/feierbuqiu/mahjong-achievement-game/issues).
Both English papers and the immutable v1.0.0 release retain their historical
scope; current progress is recorded in main.

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
- [Current project status](docs/PROJECT_STATUS.md): persistent kernel-proof research, closed pilot and remaining actual-instance/runtime gaps.
- [Later October kernel-source update](research/2026-10-18-kernel/README.md): V17/V18/V19 sources, saved-proof receipts and precise scope.
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
