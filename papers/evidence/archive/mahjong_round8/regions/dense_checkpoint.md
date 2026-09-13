> Archived evidence from the dated local research record. Historical progress and commands describe that record; current supported commands are in the repository reproduction guide. Links to retained attachments lead to their availability entries.

# Dense regional checkpoint, version 1

The header saves completed regional P/N memo cells so a later process can resume without repeating those cells. Include `dense_checkpoint.hpp` after the desired regional modules and link with `-lz`:

```cpp
loadDenseCheckpoint(path); // optional, before search
// Run a bounded root query; let its recursion unwind on a budget exception.
saveDenseCheckpoint(path); // also save after a budget-limited UNKNOWN result
```

Both public functions return `void` and throw on an invalid file or I/O failure. Call only when no solver recursion is active; these global tables are not thread safe. `DenseCheckpoint::lastSave` and `lastLoad` report `contexts`, `rawBytes`, `known`, and `newKnown`; `known` counts completed P/N cells. Gzip level 1 and atomic temporary-file replacement are used for saving.

## Scope and correctness

Supported resident contexts are FourPairs (q4 T0), OneTripletThreePairs (q4 T1), MixedTripletsTwoPairs (q4 mixed T2), FivePairsShared (q5 T0), OneTripletFourPairsShared (q5 T1), and either TwoTripletThreePairsBool or TwoTripletThreePairsDual (q5 T2). Included module guards determine which modules are available. The actual Dual implementation guard determines flavor, even when the caller did not define `MAHJONG_USE_Q5_DUAL`.

Only byte values 0=P, 1=N, 254=unsafe, and 255=unknown are accepted. Unknown cells remain unknown; no in-progress search is promoted to a completed value. Existing completed values must agree when merging. Full Sprague–Grundy tables are never imported into Boolean tables. The old full-SG q5 solver, the paged SharedQ5 quotient, and older specialized q4/two-honor tables are outside this checkpoint's scope.

Restoration calls each original namespace's `context(p,t)` and compares memo size plus an FNV-1a layout fingerprint covering support masks, honor dimensions, all local codes, all inverse indices, and all successor indices. Record checksums, gzip CRC, module model versions, and separate old-Bool/Dual flavors reject corruption or incompatible layouts. Hashes are accidental-corruption checks, not a cryptographic authenticity mechanism. If solver semantics change without changing layout, increment the format or module model version before reusing saved results.

Loading validates and merges one record at a time. If a later record is rejected, earlier validated records can already be present; loading is not globally transactional. A header version/flavor mismatch is rejected before any record is installed.

## Memory and LRU limits

Saving includes only contexts still resident in memory, not previously evicted contexts. Loading respects the original per-module LRU caps (normally 512 MiB); records are saved oldest first so newer contexts survive if restoration needs eviction. A single record that exceeds the destination module's cap is rejected by its constructor. Loading temporarily stages one raw memo vector in addition to resident tables; the default hard staging limit is 1 GiB (`DenseCheckpoint::maxRecordBytes`). Statistics count all records processed, including any later evicted during the same load.

## On-disk format

The gzip payload is little endian: magic `MJDENS08` (8 bytes), global version (u32, currently 1), flavor (u32, 1=old Bool, 2=Dual), and record count (u32). Each record contains module ID and model version (u32 each), `p[3]` and `t[3]` masks (six u32), memo length, layout fingerprint, completed-cell count, raw-byte FNV-1a hash (four u64), then the original memo bytes. Module IDs are 1=FourPairs, 2=T1, 3=mixed T2, 4=q5 T0, 5=q5 T1, 6=q5 old Bool T2, 7=q5 Dual T2.

## Reproducible test

```sh
g++ -O2 -std=c++17 -DNDEBUG mahjong_round8/regions/dense_checkpoint_check.cpp -o mahjong_round8/regions/dense_checkpoint_check -lz
./mahjong_round8/regions/dense_checkpoint_check
```

The test uses one actual known T1 state and one actual known mixed state from the 199-fact file. It switches off fact callbacks before restoration, and verifies that both restored public queries return N without increasing solved-state counts. It also verifies that an unknown byte remains 255 and that incompatible version and Bool/Dual flavor headers are rejected.

Result: two contexts, 114,997,272 raw bytes, two completed cells, 501,984 gzip bytes, zero failures. See `dense_checkpoint_check.json`. The generated `dense_checkpoint_fixture.gz` is only this reproducible two-cell test fixture. It does **not** contain the earlier long-run 85-million-state computation; those processes ended before this checkpoint was installed. A future bounded run must explicitly save its actual resident tables.
