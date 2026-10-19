# Additional portability and evidence notes

This delivery was cold-tested in a fresh directory on the same Linux/WSL host.
It has not been tested on a second physical machine or another toolchain.
Older glibc environments and non-x86_64 machines are not validated targets.

The default CPU-only `reproduce.py cold` needs no GPU and does not hold all
11,272 full-input files open. Optional `full_replay.py` uses advisory read
locks, including two nested input-lock scopes. Before the optional GPU or
full-input replay, provide a sufficiently large per-process open-file limit:

```sh
ulimit -n
ulimit -n 65536
```

The second command requires an adequate hard limit in the host environment.
The complete replay can have more than 23,000 input/source lock handles open.
A low limit causes an error; it is not an accepted partial verification.
Only the selected 56-row path of this new portable IO entry was tested; no
new all35 execution is claimed. Automatic resume is not implemented there.

The archive contains the exact recorded native executable, compiler runtime,
mathematical sources and historical evidence. A source-rebuilt executable has
its own hash; historical receipts continue to identify the original ELF.
The full input archive was streamed back through decompression and every raw
input member was hashed. This is data-integrity work, not a new game scan.

The historical all35 result uses kernel implication plus native evaluation
and explicitly trusted IO/finalization. Fresh kernel replay verifies generic
theorems, not a saved closed acceptance proof for the actual full input.
The new pure-kernel research is separate and does not alter these artifacts.
