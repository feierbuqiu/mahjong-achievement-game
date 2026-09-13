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
| Lean kernel CI | Fresh source replay of three published nonempty-position proofs and their axiom audits | Does not establish the empty-position theorem |
| SSH/GitHub signatures | A commit or tag was signed by the identified key | Does not prove its scientific claims |

## Formal verification

An end-to-end Lean theorem for this concrete opening is **not published**.
This repository now includes closed original-game proofs for three specific
nonempty states with 20, 32, and 34 tiles, with Lean 4.33.1 source and a clean
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

Original research paths in receipt strings describe provenance. They do not
imply that every historical working file is included here. The public source
and reproduction guide form the supported path for a fresh run.

## Corrections

An earlier snapshot reported UNKNOWN. The complete computation supersedes
that opening status, without turning earlier timeouts into successful runs.
Report discrepancies with the exact commit, state, toolchain, command,
observed output, and expected result. Substantive corrections will be recorded
in [CHANGELOG.md](../CHANGELOG.md), with the affected claims identified.
