# Current algorithm-model source replay bundle

This is a **local review artifact**, not a published release. It contains the 84
byte-identical Lean sources in the dependency closure of
`Mahjong.OptimizedRetroCertification`, the source/import/hash manifest, the
expected axiom sets of 79 core declarations, and a standalone replay driver.
It does not require the original research tree, native workers, finite native
input binaries, a candidate graph, or the 97.32 GB historical P/N table.

Use Windows, Python 3.11+ with `psutil`, and **Lean 4.33.1**. The source proof
uses only the Lean distribution's standard libraries, with no Mathlib package.
The original fresh replay used Python 3.12.14 and psutil 7.2.2. Install an
appropriate Python environment separately; the matching package command is
`python -m pip install psutil==7.2.2`. The toolchain pin is in `lean-toolchain`.

From this extracted folder:

```powershell
python replay.py --check-only
python replay.py --lean C:/path/to/lean.exe --workers 2 --seconds 300 --label recipient_replay_new
```

If Lean is already on PATH, `--lean lean` also works. A different source location
can be supplied with `--source-root C:/path/to/source`; the manifest's exact 84
files, bytes and imports must still match. Output is written to a **new** folder
under this bundle; choose a new label for each cold run.

The driver creates fresh project objects and uses `--trust=0 -M3072 -j1` for each
Lean invocation, at most two compiler processes, a 300-second aggregate deadline,
and a Windows Job enforcing 15.5 billion bytes aggregate commit and 80% CPU.
It also samples process-tree private memory. A timeout or failure is preserved as
partial/failed, never promoted to PASS. The expected complete result is
`PASS_KERNEL_SOURCE`, 84 completed modules, and all 79 axiom declarations matching
the manifest. `empty_game_lean` remains `NOT_VERIFIED`.

Two distinct fresh source replays are retained. The initial research-source
replay passed all 84 modules in 94.172 s with two processes and 2,313,740,288 bytes
sampled peak private memory. A subsequent **recipient-path replay** extracted the
source ZIP into a new directory and executed its exact packaged `replay.py`,
without a source-root override or the original research source tree. All 84
modules and all 79 axiom records passed in **93.922 s**, with
at most two Lean processes and **2,305,208,320 bytes**
sampled aggregate process-tree private memory. The Job limits were installed.
`REPLAY.json` records the tested archive, executable, driver and full-result
hashes; `source_manifest.json` also identifies the initial replay.

After that recipient test, only this README, the source manifest, checksum list,
and replay-summary metadata were updated. Every source and `replay.py` byte is
unchanged from the tested archive. The final package integrity and help checks
were repeated; its unchanged proofs were not compiled a third time. Linux and
macOS execution of this Windows resource controller has not been validated and
is deliberately rejected. Path independence does not establish platform testing.

No native finite dataset is included or executed. General theorem premises still
need their separately described instances. This bundle supplies no whole-C++
refinement theorem or end-to-end certificate for the historical empty-position
result. Its proofs and source replay do not add historical P/N rows.

`FILES.sha256` identifies every packaged input file; hashes identify bytes, not
mathematical truth. This artifact may be copied to another local Windows folder
with its directory structure intact. A public distribution remains a separate
authorisation and publication action.
