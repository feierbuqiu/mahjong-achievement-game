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
| October V16 calibration and resource controls | 34 cases / 107 calibration frames; 83 resource frames; four REV3 production acceptance records | Historical conditional execution evidence; not the current persistent-proof cost model |
| Historical V16 cost screen | 13.0256 hours for known compiled-execution components including 25% margin | Six costs excluded; superseded as a forecast for the current persistent-proof workload |
| V17 generic kernel composition | Finite-acceptance hypotheses connect to original-game strategies and root | Actual full-input acceptance not instantiated |
| V18 closed actual-data pilot | Three nonempty 32-tile game roots and separate finite checker equalities; saved proof cold replay | Not the empty opening or complete V17 input |
| V19 compression and layout experiments | Supplied numeric relations, partial local metadata and generic bridges | Not complete actual SAFE/game semantics or a global runtime bound |
| V17 complete native verification | Six finite acceptance families evaluated on all 35 layers / 778,532,864,302 stored labels | Compiler/runtime, IO/input custody and external bookkeeping trusted; no closed actual-input Lean declaration |
| Separate AI review | 17,317-frame ledger, 54,548 target identity references, 62-file input sample; no problems reported in inspected scope | No Lean/native rerun, no full input rehash, no human peer review |
| Later packed numerical certificate | Saved equations for 28 fixed blocks / 402 words, 1,234 layout equalities and a 273-module fresh replay | No complete actual SAFE/target-address/game join; numerical coordinates are not newly certified game positions |
| Same-host portable tests | 149-source/native reconstruction, small controls and selected 56-row execution; separately extracted saved pilots | No second all-layer native execution or second physical machine; complete archives remain local |
| SSH/GitHub signatures | A commit or tag was signed by the identified key | Does not prove its scientific claims |

## Current V17 verification

The [completed V17 run](../research/2026-10-19-v17/README.md) evaluates all six
finite acceptance families of a kernel-proved whole-input implication on the
complete actual table. It covers all 778,532,864,302 rows, with no old PASS or
seed import. It is stronger than the earlier partial compiled-layer milestone.
It remains **native execution under an explicit trust boundary**: it is not a
closed Lean declaration for these actual input bytes.

A [separate AI review](../research/2026-10-19-v17/review/INDEPENDENT_REVIEW.md)
reports no defect within its inspected scope and independently checks the
saved ledger/identity graph. It did not rerun Lean/native code or rehash the
whole input set. The finalizer was inspected line by line; most other trusted
bookkeeping files were not. This is not human peer review or independent
execution replication. See [claim boundaries](CLAIMS.md).

The September formal package separately indexes eight closed nonempty roots;
V18 adds a small actual-data pilot with a different scope. No aggregate novel-root
count is inferred. The actual original-game empty-state Lean declaration is
still **not published**. A hypothetical closed proof must retain the actual
finite premises through proof construction, saving and cold kernel replay.

The earlier V18/V19 whole-table optimization was stopped. Later bounded
component work completed the numerical sample and nonempty-game variants;
the [new paper](../papers/trust-verification/manuscript.md) gives their exact scopes. Their performance limits do not invalidate the separately
completed V17 native computation and do not establish a future strict-kernel
deadline. The old V16 STOP remains unchanged. See [current status](PROJECT_STATUS.md).

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
