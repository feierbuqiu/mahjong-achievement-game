> Archived evidence from the dated local research record. Historical progress and commands describe that record; current supported commands are in the repository reproduction guide. Links to retained attachments lead to their availability entries.

# Abstract game, quotient, ranking and symmetry proofs

All five owned modules in `sources/Mahjong/` were compiled by official Lean
4.33.1 with `--trust=0`. The exact executable, argument arrays, source hashes,
module hashes, dependency hashes and successful exit codes are in
`provenance.json`. Each `*_trust0.log` records the actual `#print axioms` output.
Earlier unsuccessful development logs, including the explicitly named
`symmetry_trust0_attempt_001.log` import-path failure, are retained and are not
accepted verification results. The additional `Rules.lean`/`Rules.olean`
snapshots record the dependency developed and verified by the rules agent.

## What is proved

- `SafeGame.lean` defines finite normal-play strategies with all children at
  P nodes and one legal P child at N nodes. Exact local P/N equations and a
  decreasing natural rank imply such strategies. The SAFE normal game is
  equivalent to the original achievement game at SAFE states. Its genuine
  `WinningStrategy` has an actual achievement at every leaf. Translating a
  SAFE P result into second-player victory explicitly requires closure of
  valid states and a legal move at every valid nonwinning state, excluding a
  vacuous exhausted-stock draw.
- `Quotient.lean` proves strategy equivalence through an encoding with full
  forward coverage of physical moves and physical realizability of every
  quotient move. Injectivity is not required. A three-state example proves
  that omitting a single P successor can flip the root from N to P; checking
  only that listed moves are legal does not suffice.
- `Ranking.lean` proves the triangular and tetrahedral formulas as symbolic
  equalities over arbitrary naturals. Sorted pair/triple colex ranks lie in
  the correct disjoint blocks and are injective, and fit inside blocks of
  size `c2(n)`/`c3(n)` for a local group of size `n`.
- `Symmetry.lean` proves that a tile bijection with explicit forward and
  inverse target-shape witnesses preserves all three winning-hand forms,
  containment, legal additions, Win, SAFE, SAFE transitions and P/N
  strategies. Seven-pair distinctness follows from injectivity; thirteen
  orphans use a checked permutation of the exact terminal/honor list.
  Concrete generators are first-suit reflection, first/second-suit exchange,
  and East/South exchange. Their involutions, all 55 meld images and orphan
  permutations are verified by kernel `decide` on finite domains.
- `Generators.lean` extends this to every parameterized numeric-suit
  reflection (3 choices), suit transposition (all 3×3 parameter pairs), and
  honor transposition (all 7×7 parameter pairs). Every finite word in these
  generators preserves the outcome. `applyPath` applies the head first,
  proceeding left to right. `checkReference path proved physical` checks all
  34 counts for equality with the transformed already-proved state, and
  `checked_reference_sound` lifts its proof. No hash equality or assumption
  about the C++ canonicalizer is substituted for this physical comparison.

## Trust and remaining boundary

There is no `sorry`, `admit`, custom `axiom`, `native_decide`, or
`implemented_by` in these five sources. The quotient lift/descend and abstract
P/N-certificate soundness theorems depend on no axioms at all. Other reported
dependencies are only Lean's ordinary foundations `propext`, `Quot.sound`,
and in some proofs `Classical.choice`; see the actual logs rather than
treating all declarations as axiom-free.

These proofs do not establish the Mahjong empty-state P label. They also do
not establish complete C++ local enumeration, SAFE profile equivalence,
canonicalizer/orbit correspondence, complete rank/unrank coverage, payload
loading correctness, or a kernel-checked complete root certificate. Ranking
uses unbounded naturals and does not itself prove absence of C++ overflow.
Every instance of the relevant reflection/transposition families and every
finite word is covered by `Generators.lean`; each actual certificate reference
still has to provide and pass its physical equality check. The missing global
connections are not premises silently supplied by external solver logs.

Only the newly assigned modules and this dedicated evidence directory were
written. Original research snapshots and rule definitions were preserved.
