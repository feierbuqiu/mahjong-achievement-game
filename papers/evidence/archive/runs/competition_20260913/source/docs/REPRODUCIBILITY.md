> Archived evidence from the dated local research record. Historical progress and commands describe that record; current supported commands are in the repository reproduction guide. Links to retained attachments lead to their availability entries.

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

## Reporting a reproduction

Include the commit/tag, operating system, CPU, RAM, compiler version, build
flags, exact input and command, elapsed time, peak memory, exit code, output
hashes, and final coverage. Keep complete runs separate from partial runs and
same-code checks separate from implementations with independent rule logic.
