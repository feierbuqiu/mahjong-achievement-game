# Actual 28-block Cartesian kernel baseline

This family proves only the supplied finite numeric P/N recurrences and numeric
layout equalities. It does not establish that the supplied successor list is the
complete SAFE move list, bind the entire original table, or prove the empty game.
The whole-table campaign remains stopped.

The final saved sources, PLAN.json, generated inputs and successful receipts are
authoritative. The initial prepare.py is retained with its initial registration;
subsequent parser, declaration and conjunction revisions are separately archived.
It is not a one-command reproducer for the final revised sources.

The sample contains 28 distinct actual source blocks: 1,035,129 original colex
rows, expanded to 1,077,270 Cartesian coordinates. All 402 actual source/target
words have ordinary-kernel raw-to-padding and axis-layout checks. Nine Nat-only
data modules each contain at most 2 MiB of decoded literals. The safe untrusted
front end emits only closed Nat definitions through the official checked writer.

The original proof for each block checks the saved expected reach and both P/N
equations. The later Bool variants remove only the diagnostic expected-reach
equality, use the same source, targets and reach operations, and prove the two
P/N equations directly with Eq.refl true. Chunk sizes 1, 2, 4 and 8 cover the same
28 blocks. Their results do not support a numerical kernel speedup from batching.
The deliberately false union check was rejected by the ordinary kernel compiler.

The successful cold bundles contain only .olean module parts and source copies.
They contain no JSON, raw byte files, IR, DLLs or meta loaders. Standard fresh
leanchecker runs use an empty working directory and no native plugin. Compiler
and plugin setup, failed attempts, successful proof construction, and cold
rechecking are reported separately in ACCEPTANCE.json. The failed 3 GB bulk
writer attempt remains failed; its completed pages were preserved and the
remaining pages were subsequently emitted and cold checked.

Every Lean process uses trust 0, one Lean thread, a 3,000,000,000-byte Windows
Job, 20% CPU, and at most 120 seconds. Process exit is confirmed before input
locks are released. The only observed successful proof dependency axiom is
propext; no additional axiom is admitted. These sample timings are not a full
table estimate or launch authority.

Use seal.py once to capture final source/module/receipt identities and the
measured acceptance. SOURCE_FREEZE.json then marks this family immutable. New
operator representations belong in a separate directory.
