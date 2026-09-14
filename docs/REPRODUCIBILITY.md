# Reproduction guide

## Requirements

- Python 3.10 or newer; no Python packages are required.
- A C++17 compiler with the C++ standard library and thread support.
- Linux with GCC, or Windows with a MinGW-w64 GCC toolchain on `PATH`.
  Windows builds use the included, project-authored telemetry adapter.
- A 64-bit environment. Full computation requires substantial RAM and at least
  110 GB of free output storage. The original peak was about 10.64 GB; allow
  additional memory for the operating system and other programs.

The core public tools do not need zlib, GPU libraries, API keys, or network
services. Compiler installation is separate. macOS has not been validated by
this publication; do not treat portability of C++17 as a completed platform test.

## Small checks

From the repository root:

```bash
python3 tools/verify_repository.py
python3 tools/reproduce.py build
python3 tools/reproduce.py smoke
```

On Windows, replace `python3` with the available Python executable. Select a
compiler with `--cxx /path/to/g++` or the `CXX` environment variable. The build
helper temporarily adds that compiler's directory to `PATH` for the compiler
and its helper programs.

Each invocation records its command, source hashes, tool versions, logs, and
outcome under `build/` or `runs/`. The smoke test checks all 35 layer counts,
rank/unrank and physical edges for layers 0 through 4, generates the entire
34-tile layer, and replays it with the reverse verifier. It also verifies
that missing opening data returns UNKNOWN and that invalid input is rejected.

A successful smoke test is a bounded execution check. It does not establish
the opening independently of the recorded full computation.

## Full forward generation

Use an output directory that is not shared with another search:

```bash
python3 tools/reproduce.py run global_retro --data runs/full/table --min-layer 0 --max-layer 34 --threads 8 --seconds 43200
```

Generation proceeds from layer 34 downwards. Exit code 2 denotes an incomplete
or budget-limited run. Retain the complete output and repeat the same command
to resume. Do not use `--force` on a retained result. The budget is soft:
initialization, reads, and checkpoint completion may take extra time.

The generator's memory telemetry is Windows-specific in this frozen version;
its internal memory-limit flag is not a hard cross-platform RAM limit. Set an
operating-system process/job limit separately if needed. Do not launch full
generation while another memory-intensive computation is using the machine.

## Full reverse replay

Use a new record directory for the public build. No legacy records are needed:

```bash
python3 tools/reproduce.py run push_verify_parallel_v3 --data runs/full/table --verified-dir runs/full/replay --build-id public-v0.1.0 --layers 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34 --threads 8 --max-seconds 43200
```

Repeat after a budget stop using the same unmodified source build and output
directory. Reusable records describe whole verified buckets. Only a final
`PASS_ALL_REQUESTED_LAYERS` covering all 35 layers with zero mismatches counts
as full replay. A partial run is not a pass for the whole game.

## Opening, historical positions, and strategy

```bash
python3 tools/reproduce.py run verify_oracles --data runs/full/table --opening --output runs/full/opening.jsonl
python3 tools/reproduce.py run verify_oracles --data runs/full/table --fixtures results/oracles.tsv --output runs/full/oracles.jsonl
python3 tools/reproduce.py run strategy_physical --data runs/full/table --state 1000000000000000000000000000000000
python3 tools/check_table_hashes.py --data runs/full/table
```

Expected opening: one P empty state and six N first-move orbits. Expected
historical comparison: 16,240 matches, zero conflicts, zero UNKNOWN. Strategy
output names the physical tile and a P child, or an immediate winning move.
It must preserve the original 34 input coordinates. Hash verification streams
all 97.32 GB, so it is a full I/O operation even without game search.

## Lean proofs for nonempty positions

The [formal reproduction guide](../formal/README.md) pins Lean 4.33.1 and
provides a clean kernel replay of eight indexed concrete nonempty-position roots:

```bash
python3 tools/verify_lean.py --workers 2
```

This does not require the 97.32 GB table. A successful replay establishes the
published local theorems under their audited Lean axioms; the empty-position
formal proof remains incomplete.

Use `--entry latest` for the 374-module closure of the new 12-tile, 14-tile,
compressed 20-tile and registry audits. The default covers all 1,008 source
modules, including the earlier proof DAG. Every run starts with fresh project
objects. Historical 67-second measurements include reused dependencies and
are not cold replay timings.

## English paper and document checks

Read both [English papers](../papers/README.md) directly on GitHub. Run
`python3 tools/verify_paper.py` to check its published hash, all 370 preserved
formulas, equation tags, tables, and evidence links. The source catalogue
explicitly identifies historical attachments not included in this publication.
This check validates publication integrity; it does not prove the mathematics.

Run `python3 tools/verify_lean_supplement.py` for the new Lean paper's 26
expressions, numerical tables, evidence links, provenance and replay records.
Its [publication overview](../papers/lean-verification/README.md) links the
exact Windows model-source companion ZIP supplied with v1.0.0. The archive
and its extracted replay controller preserve the original tested bytes;
the instructions distinguish source-only replay from unavailable large-input tasks.

## Reporting a reproduction

For the later compiled-checker work, see the
[September 14 handoff](../research/2026-09-14/README.md). It provides a separate
receipt-arithmetic check and fresh replay of 56 checker source modules. Its
native input preparation and scheduling are not yet a portable campaign.
The [September 15 update](../research/2026-09-15/README.md) adds a separate
84-module dependency closure for the finite algorithm models:

```bash
python3 research/2026-09-15/verify.py
python3 research/2026-09-15/verify.py --lean lean
```

The first command checks public bytes and receipt consistency. The optional
second command uses Lean 4.33.1, fresh project objects, trust level 0, one
thread and a 3 GiB heap limit per compiler process. It checks mathematical
source; it does not execute native workers or read the historical P/N table.
The native operational test harness and inputs are retained outside Git.
The maintainer will not undertake further end-to-end or full-scale Lean
closure verification; these commands remain available to independent
contributors. Reports, corrections and contributed results can still be published.

Include the commit/tag, operating system, CPU, RAM, compiler version, build
flags, exact input and command, elapsed time, peak memory, exit code, output
hashes, and final coverage. Keep complete runs separate from partial runs and
same-code checks separate from implementations with independent rule logic.
