# Computational methods

## Index and recurrence

The index enumerates each SAFE state orbit by tile-count layer and honor
configuration. Numeric states are organized into groups for efficient
counting and indexing, while their individual local states and transitions
are retained. A bucket supports compact rank/unrank operations with one
stored bit per state and word padding at the end.

The generator traverses layers from 34 down to 0. It uses precomputed local
additions, compact successor indices, early termination at a P child, and
parallel chunks. The complete table contains 778,532,864,302 bits of state
information, distributed over 3,686 padded bucket files.

The reverse verifier reconstructs N parents by visiting P children and
deleting one physical tile. It does not use the generator's numeric/honor
transition lists to generate these reverse moves. It compares every resulting
bucket against the saved table and publishes a reusable record only after
the whole bucket agrees.

Both implementations depend on the same rule code and global index. Their
agreement is strong cross-algorithm evidence, with those shared dependencies
remaining part of the computational trust boundary.

## Executable second-player strategy

After the opponent moves:

1. If a legal addition wins immediately, play it.
2. Otherwise, at an N SAFE state, choose a legal addition whose child is P.

The empty state is P. The opponent's SAFE move therefore gives the second
player an N state; a move leaving SAFE gives the second player an immediate
win. Each round restores a P state or ends the game. Tile counts strictly
increase, so play terminates.

This is a table-backed strategy, not a claimed short human-playable rule.
The adapter returns the actual tile in the supplied coordinate system, along
with the P witness. Missing data yields UNKNOWN rather than a guessed move.

## Measured resources

The retained table was produced by several disjoint generation stages whose
measured wall times total **73.52 minutes**. The largest continuous stage used
16 threads, took **69.10 minutes**, and peaked at **10.64 GB** of process private
memory. These figures exclude development, repeated calibration, and replay.
They are not a measurement of one fresh single-version run of that duration.

The final resumed reverse-replay stage took **192.08 minutes** including its
supervisor and peaked at **4.20 GB** of process private memory. It checked
765,885,524,853 new states and reused 12,647,339,449 states already checked by
the compatible earlier verifier. The combined coverage is the full table.

See [generation receipts](../results/generation-account.json),
[layer timings](../results/layer-timings.json), and
[replay completion](../results/replay-completion.json). Performance depends on
hardware, storage, compiler, and operating system; these are observations,
not promises about another machine.

The [September 14 handoff](../research/2026-09-14/README.md) separately records
the workstation specifications and compiled-Lean general-row benchmarks.
Those workloads have different costs and remaining proof obligations; the
above C++ timings are not a runtime estimate for end-to-end Lean verification.
