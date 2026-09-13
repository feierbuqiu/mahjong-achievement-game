# Lean verification status

**Status for v0.1.0: in progress. No end-to-end Lean theorem about the empty
position is published in this snapshot.**

The computational result is an empty-state P outcome, implying a
second-player win under the stated rules. Ongoing Lean work is maintained
separately from this frozen computational publication.

The formal evidence chain must connect:

1. The concrete legal-move and 14-tile winning predicates to the original game.
2. The SAFE normal-play reduction to original-game outcomes.
3. Symmetry normalization and state indexing to their mathematical definitions.
4. Complete legal successor enumeration and the P/N recurrence.
5. The concrete opening computation or a closed strategy certificate to checked
   data, without taking the external program's success as an unproved premise.

A future formal release should pin Lean and library versions, provide the
complete source and build command, and state the theorem's axioms and all
remaining trusted components. Prohibited shortcuts include presenting
`sorry`, an assumed table label, or an external JSON `PASS` as the completed
opening theorem.

The ordinary repository CI badge covers bounded software and artifact checks.
It must not be interpreted as a Lean verification badge.
