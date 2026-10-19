# Portable reproduction and kernel research progress — 2026-10-19

The portable V17 delivery and its independent-directory small cold test passed.
No full-table scan was rerun. The frozen 145 mathematical modules, their bound
source/snapshot copies, original native executable and original FINAL remain
unchanged. The sealed core files have not been replaced by research artifacts.

## Download sets and commands

- `mahjong_v17_core.tar.zst`: 1,407,097,086 bytes; sources, exact Linux Lean
  4.33.1 toolchain, unchanged original ELF, actual small inputs, complete
  original execution evidence, reproduction tools, environment and trust docs.
- `mahjong_v17_full_inputs.tar.zst`: 8,087,887,655 bytes; all 11,272 actual
  input files (100,615,834,170 bytes expanded). Every input member passed
  independent streamed decompression/hash verification. This did not scan games.
- `mahjong_kernel_pilots.tar.zst`: 21,136,243 bytes; optional saved pure-kernel
  pilots, mathematical sources, fixed sample inputs, manifests and rebuild tools.
  This research package proves no empty-game result.

SHA256SUMS covers all delivery members. Start with START_HERE.txt. README.md,
ENVIRONMENT.md and TRUST_BOUNDARY.md are inside the V17 core. Read the external
PORTABILITY_NOTES.md as well, including file-handle limits for optional GPU/full
replay. Only selected-bucket portable IO was tested; a second portable all35 run
and a second physical-machine test have not been performed.

The optional research archive shares the same bundled Lean toolchain. Its own
README gives `verify_kernel.py integrity` and `verify_kernel.py replay` commands.
It needs no global input table, GPU, game Native worker, source file or expression
builder plugin for saved-proof replay. Each lane uses an isolated LEAN_PATH.

## Actual portable cold test

The complete final candidate test took 1,948.532 seconds (32 min 29 s): clean
extraction/member hashes; 149 source modules compiled with trust zero and kernel
checking enabled; leanchecker --fresh; source-to-native rebuild; real positive
and negative controls for both original and rebuilt ELF; complete stored all35
evidence audit; and the new portable GPU entry on a complete 56-row bucket.

The generic source/kernel replay took 108.356 s. The original ELF's six controls
took 530.738 s; the rebuilt ELF's six took 516.224 s. The native process peak
RSS in the controls was 8,437,444,608 bytes (8.44 GB). This is not a system-wide
or GPU-memory peak. Common finite base and successor checks were recomputed at
every native process startup; dividing 56 rows by startup-inclusive time is not
a row-throughput measurement.

The positive bucket was n32_h089: 56 rows, 41 P / 15 N. Source label flip,
missing last row, target-bank replacement, truncated bits and wrong honor
metadata were all rejected. The GPU entry independently accepted the same
complete bucket, verified unchanged inputs, and confirmed normal Native/GPU
cleanup. The original finalizer also rejected three in-memory corruptions of
the actual complete ledger: missing final record, incorrect receipt hash and
duplicate/overlapping first frame. Original evidence files were not edited.

The six-check scope is explicit in VERIFICATION_LOGS.zip (validation/SIX_CHECK_SCOPE.json):
common finite base/successors were freshly evaluated; source/target metadata,
identity and row scanning were freshly exercised on the selected bucket.
The root P evaluation and complete all35 coverage were audited from the
original complete execution evidence, not re-evaluated on all game rows here.

## What the completed historical computation establishes

The original run covered all 778,532,864,302 rows, 17,317 frames and 3,686
nonempty buckets over layers 0..34. It took 27,303.9915 s (7 h 35 min 4 s),
ending at 2026-10-19 04:56:53 Australia/Sydney. All six finite families,
before/after input identity, exact coverage and service cleanup passed.

Original ELF SHA-256:
775e05d2601e30847b14b017cb542ea23a8b629d8ebd403aa07bd5942b78f667

Original FINAL SHA-256:
413ced59dcfcc2825f6b17503e8690f895b6d9f0219ddb2eb4ce43cf992c957e

Claim: the kernel proves that the six finite V17 checks imply
SecondPlayerWins Step Win empty; the fixed compiled Lean functions evaluated
those checks on the complete input and returned true. Native compilation,
runtime, raw-file IO and external identity/coverage bookkeeping are trusted.
This is kernel implication plus native evaluation. It is not a saved closed
pure-kernel theorem for the actual complete input. Rules.lean is the original
game specification; the standard three axioms remain the only mathematical
axioms. No new axiom, sorry or native_decide was introduced into accepted math.

## New bounded pure-kernel results

The previously incomplete full402 cached-layout study now has a fresh Linux
source build, saved ordinary proofs, a real flipped-label rejection and a
single fresh replay. All 28 fixed blocks, 402 words, 1,234 numeric layout facts,
601 arbitrary-input function equivalences and the PN equations were included.
The sample has 1,035,129 colex rows / 1,077,270 Cartesian coordinates. Its
actual SAFE and complete actual target-addressing certificates remain absent;
these coordinates are not fully certified original-game positions.

End-to-end construction and replay took 132.205 s; final replay took 61.828 s,
with 737,734,656 bytes peak RSS. Project certificate modules occupy 134,862,920
bytes, excluding the standard toolchain. The native input-expression decoder
is untrusted and absent from the final replay environment. All 273 mathematical
modules were checked by the standard kernel with standard axioms only.

Separately, a real 11-node physical game certificate proves three unconditional
original-game strategy statements at 32-tile starting positions. It includes
all legal replies at P nodes and actual winning subsets at terminal leaves.
It does not prove the empty position. Baseline construction took 20.348 s,
cold replay 128.852 s, project certificate 6,115,880 bytes. Replacing direct
Boolean proofs with reflexivity was sound but slower (34.212 s / 140.993 s),
so it was not adopted. An import-only Std-to-Init fork rebuilt all 24 modules
and replayed in 114.601 s at 1,066,545,152 bytes peak RSS. Definitions, proofs
and target statements were preserved. These are single observations, not a
controlled global speed claim.

The 21 MB research archive was independently extracted and all three lanes
fresh-replayed successfully, from empty working directories without generation
inputs/plugins. The parallel share test took 179.228 s overall; lane replays
were 88.751 s (packed), 176.809 s (game) and 127.461 s (game-slim). Parallel
resource contention makes these unsuitable for a direct speedup comparison.
This is the same physical host in new paths, not a second-machine test.

## Cost model and remaining mathematical work

Profiling the same 56 numeric theorem modules separately measured 0.28994 s
kernel type checking for PN and 0.96696 s for layout: 1.25690 s total, about
823,557 colex rows per kernel type-checking second for these components only.
The complete profiling invocation took 6.693 s including imports/frontend.

A purely mechanical scaling of only those arithmetic components to all
778,532,864,302 rows gives 262.592 core-hours per pass, or 32.824 hours at
ideal eight-core division. This is NOT an end-to-end prediction, lower bound
or upper bound: sample geometry is biased, reuse is not globally measured,
and SAFE/local finite certificates, actual addressing/completeness, data
loading, serialization and generic proof cost are excluded. Proof construction
and saved-proof replay both perform checks. The current final single-fresh
replay is serial and must not be divided by eight. No 20-hour pure-kernel
completion bound has been established.

Mask-sharing proof rewrites were also attempted. All proposed arithmetic mask
facts were checked, but generic rewriting/elaboration became too slow; the
latest attempt reached its 180-second child limit and cancelled sibling work.
These attempts are FAILED/ABORTED, not accepted certificates or mathematical
counterexamples. Failed diagnostics can contain Lean error-recovery placeholders;
no such environment is packaged as a successful lane.

The useful next milestone is a concrete packed block that simultaneously
instantiates actual SAFE/local checks, complete actual target addressing and
closed target strategies, then derives its original-game strategies. The
current packed and physical-game pilots are separate; joining them is real
remaining work. Only after representative complete blocks and an aggregate
replay/memory test can a defensible full empty-game pure-kernel estimate be made.

All whole-table activity remains stopped. No cloud, subagents, model-driven
monitor, old PowerShell notification or startup task was created or resumed.
