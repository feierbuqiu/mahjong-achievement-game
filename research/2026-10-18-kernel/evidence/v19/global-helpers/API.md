# Small named global helpers

This isolated experiment changes only the representation of the original group
channel functions for actual blocks B00, B01 and B27. It moves every cut, lane
OR and concatenation node into a small global function with width/input
parameters. There are no local let chains and no diagonal rewrite. The 42
functions require 21,584 small declarations, so this is a representation test,
not a claim that this declaration count is a practical final architecture.

The ordinary kernel proved each new function equal to its original function
for every Nat width and input. The successful exact modules use import all to
access both definition bodies. The initial proof without this body access was
rejected and remains in the attempt history. No mathematical obligation was
removed. The three actual PN proofs do not import the old functions, old PN
oracles, or these representation equality proofs.

Measured numeric kernel times (one sample per representation):

| Block | Original long let | Named helpers |
|---|---:|---:|
| B00 | 12.3 ms | 10.3 ms |
| B01 | 298 ms | 78 ms |
| B27 | 339 ms | 116 ms |

The same two PN equations are checked. The wrong-valid-mask negative is
rejected. A clean ordinary fresh kernel replay of all three proofs succeeded
without JSON, DLLs, raw data files, IR or loader modules. Library construction,
symbolic equivalence proofs and cold replay are separate costs in ACCEPTANCE.

The sample has 125,772 Cartesian source coordinates. This proves the numeric
recurrences for the supplied candidate lists only. Complete SAFE successor
coverage, original table semantics and the empty-game conclusion are separate
obligations. No full-table forecast or launch permission follows.

All processes keep the unchanged 3 GB/20%/120-second boundary. SOURCE_FREEZE
records all saved sources and artifacts, including unsuccessful source forms.
Successful cold bundles contain only their actual dependency closure. New
representations must use a new directory.
