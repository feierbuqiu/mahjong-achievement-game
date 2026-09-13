# Rules and notation

## Original achievement game

The inventory contains 136 tiles: ranks 1 through 9 in each of three suits,
and seven honor kinds, with four copies of every kind. Both players add to
the same initially empty public pool. On each turn the player chooses one
remaining tile; there is no random draw or private hand.

A move wins immediately when the enlarged pool **contains** a winning
14-tile submultiset. The entire pool need not itself have 14 tiles. A winning
submultiset is any of:

1. Four melds and one pair. A meld is three identical tiles or three consecutive
   ranks in one suit. Honors cannot form sequences.
2. Seven pairs of seven distinct kinds. Four identical tiles do not count as
   two different pairs for this form.
3. Thirteen orphans: all six suit terminals and all seven honors, with one of
   those thirteen kinds duplicated.

No additional scoring, declaration, concealed-hand, or discard restrictions
are imposed. A run of four identical tiles is not a four-tile meld in the
14-tile winning predicate, although three of those tiles can form a triplet.

## State representation

A state is a string of exactly 34 digits in `0..4`, in this order:

```text
1m..9m, 1p..9p, 1s..9s, East, South, West, North, White, Green, Red
```

For example, `1000000000000000000000000000000000` is a single `1m`.
Indices reported by the physical strategy adapter are zero-based and refer
to the original input coordinates.

## SAFE normal-play reduction

`terminal(s)` means that `s` already contains a winning subset. `safe(s)` means
that `s` is nonterminal and no legal one-tile addition would win immediately.

At a SAFE state, a player cannot win on the current move. A move to a
nonterminal, non-SAFE state gives the opponent an immediate winning move.
Consequently, optimal play at SAFE states is captured by the normal-play game
whose moves add one tile while remaining SAFE. A player with no SAFE move
loses. The original and reduced games have the same P/N outcome on SAFE states.

- **P**: the player to move loses under optimal play; every SAFE successor is N.
- **N**: the player to move wins; at least one SAFE successor is P.
- **UNKNOWN**: the computation or required input is incomplete; no P/N claim follows.

Every move increases tile count, so the reduced graph is acyclic. The largest
SAFE layer has 34 tiles. All states in that layer are P. Descending through
the layers, mark a parent N if any SAFE child is P, and P otherwise.

The global bit tables encode **P as 1 and N as 0**. This storage convention
must not be confused with Boolean or Sprague-Grundy conventions used in other
programs. An N outcome does not determine the exact Sprague-Grundy value.

## Symmetries

The allowed group is `S7 x (C2^3 semidirect S3)`: permute honors, independently
reflect each suit by `r -> 10-r`, and permute suits. Arbitrary rank
permutations within a suit are not symmetries. Orbit sizes need not equal the
group order.

Numeric fourth copies remain actual moves. The index retains physical tile
counts; it does not identify positions solely by a static winning profile.
