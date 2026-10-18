# Evidence and limitations

## Published computational claim

For the rules in [RULES.md](RULES.md), the completed calculation classifies the
empty state as P and all six first-move orbits as N. This implies a
second-player winning strategy subject to the correctness of the reduction,
rules, index, recurrence, implementation, and stored values.

| Evidence | What it establishes | Boundary |
| --- | --- | --- |
| Complete forward generation | A value for every indexed SAFE orbit | Depends on rules, index, and generator |
| Full reverse replay | All 778,532,864,302 saved values match a different recurrence implementation | Shares rules and index with the generator |
| 16,240 historical checks | Agreement with retained results from earlier computational routes | Does not cover every state independently |
| Bucket counts and SHA-256 audit | Coverage, payload identity, padding, and stored P counts | File identity is not mathematical correctness |
| Opening queries | P at the empty state; N and P replies for all six first-move orbits | Reads the computed table; not a closed strategy certificate |
| Publication CI | Source builds, small execution checks, and evidence-file consistency | Does not recompute the 97.32 GB database |
| Lean kernel CI | Fresh source replay of eight indexed nonempty-position roots and their axiom audits | Does not establish the empty-position theorem or replay the entire later local registry |
| September 14 compiled-Lean scans | Complete layer-34 and layer-33 row checks, plus separate bounded general-layer samples | Native compilation/runtime trust; global coverage and final induction remain unfinished |
| September 15 finite algorithm proofs | Audited kernel theorems for successor, optimization, word ownership and bottom-up models under explicit premises | Does not universally refine the entire C++ implementation or instantiate a certificate for all historical values |
| September 15 production-routine probes | 102 synthetic configurations; 13,741,216 row comparisons with zero mismatches, plus concurrency and recovery controls | Synthetic child labels; zero new historical P/N coverage; bounded tests are not a language-semantics proof |
| October 18 layer-32 completion | 280,542,509 unique rows in 68 buckets; tail layers 32–34 total 303,054,865 | Compiled checker and reviewed IO/coverage; not a closed opening proof |
| October V16 calibration and resource controls | 34 cases / 107 calibration frames; 83 resource frames; four REV3 production acceptance records | Conditional execution evidence; full scan unstarted and independent review in progress |
| October time forecast | 13.0256 hours for known components including 25% margin; working expectation within 20 hours | Six production costs and final admission unresolved; not an observed full-run guarantee |
| SSH/GitHub signatures | A commit or tag was signed by the identified key | Does not prove its scientific claims |

## Formal verification

An end-to-end Lean theorem for this concrete opening is **not published**.
As of **October 18, 2026**, the improved V16 route is approaching a planned
final compiled-Lean campaign, with a conditional working finish expectation
within 20 hours of an authorized start. Correctness is under independent
review; the full scan has not started. Final whole-production costs and
admission checks remain outstanding. The earlier decision not to pursue
further verification is superseded by this new progress.

The [October update](../research/2026-10-18/README.md) publishes existing
132-module source, 104 recorded theorem fingerprints, the complete layer-32
audit and bounded execution records. The known-component estimate of
13.0256 hours includes 25% margin but excludes six production costs; it is
not an accepted total-cost bound. Complete layers 32–34 cover 303,054,865
unique rows; conditional samples add no complete global layer.

The campaign's finite premises, compiler/runtime and reviewed Python/OS
coverage/IO remain part of its trust boundary. There is no pure-kernel
whole-table aggregation finalizer. The [project status](PROJECT_STATUS.md)
keeps that distinction explicit. The immutable v1.0.0 snapshot records the
earlier delivery; the following concrete-proof package remains reproducible.

This repository now indexes closed original-game proofs for eight specific
nonempty states with 12, 14, 20, 28, 30, 32, and 34 tiles, with Lean 4.33.1 source and a clean
kernel replay. Their exact physical states, theorem names, allowed axioms,
and reproducible audit commands are listed in [formal status](../formal/README.md).
The opening candidate graph remains partial. Generic reduction lemmas,
executable checks, or a theorem that assumes an external checker succeeded
do not by themselves close the opening theorem.

The intended chain connects the original legal-move and winning predicates,
the SAFE reduction, symmetry/index correctness, complete successor coverage,
and checked concrete computational evidence. See [formal status](../formal/README.md).

## Provenance

[publication-provenance.json](../results/publication-provenance.json) maps every
imported artifact to its original relative path and original SHA-256, and to
the distributed path and SHA-256. Most core source files are byte-identical
copies. The strategy adapter has English display strings. Published JSON
copies remove private workstation root paths; the acceptance extract also
omits local process and scheduler metadata. Transformations are recorded.

Hashes embedded inside historical receipts continue to identify their
original inputs. They must not be used as hashes of a transformed publication
copy. [CHECKSUMS.sha256](../CHECKSUMS.sha256) identifies the distributed
research artifacts, and the signed Git history identifies the publication.

The later [Lean provenance manifest](../formal/provenance.json) separately
records the frozen formal source and the selected historical replay fields.
It preserves source bytes and distinguishes original receipt hashes from
the hashes of public extracts.

The [September 14 manifest](../research/2026-09-14/provenance.json) covers the
later checker source and selected run receipts. Its verification helper
recomputes benchmark counts and weighted rates. Public receipt consistency
does not establish native execution correctness or independently reproduce
the later registry's retained concrete proof trees.

The [September 15 manifest](../research/2026-09-15/provenance.json) publishes
the 84-module dependency closure of the finite algorithm entry point and
selected receipts without byte changes. Its historical acceptance record
references 5,329 local evidence files; only the explicitly listed publication
subset is supplied. All original digests were rechecked locally for this
publication. A public hash/receipt check covers the supplied subset, and the
optional Lean command freshly checks the published mathematical models.
Neither operation replays historical full-table P/N data.

The [Lean verification paper](../papers/lean-verification/manuscript.md) now
documents this development alongside the original computational paper. Its
[publication provenance](../papers/lean-verification/provenance.json) records
the new English audit material, selected replay records, public path placeholders
and the exact companion-archive identity. The two new paper-preparation
replays check the existing 84-module closure and 79 theorem declarations;
they do not extend the historical P/N coverage or establish independent human review.

Original research paths in receipt strings describe provenance. They do not
imply that every historical working file is included here. The public source
and reproduction guide form the supported path for a fresh run.

## Corrections

The [English paper](../papers/manuscript.md) gives the complete argument and
research history. Its [source catalogue](../papers/evidence/README.md) marks
each cited item as a public copy or a retained source. Original hashes in the
paper identify original evidence; selected or sanitised public copies have
separate hashes. Archival notes and source excerpts do not imply that every
historical runner or dependency is a supported portable reproduction package.

An earlier snapshot reported UNKNOWN. The complete computation supersedes
that opening status, without turning earlier timeouts into successful runs.
Report discrepancies with the exact commit, state, toolchain, command,
observed output, and expected result. Substantive corrections will be recorded
in [CHANGELOG.md](../CHANGELOG.md), with the affected claims identified.
