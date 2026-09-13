> Archived evidence from the dated local research record. Historical progress and commands describe that record; current supported commands are in the repository reproduction guide. Links to retained attachments lead to their availability entries.

# Actual Lean proof-node batching experiment

The same eight actual P-node proof bodies compiled **38.7% faster** when placed in one module: 25.208 seconds as eight modules versus 15.441 seconds as one module. The measured body speed ratio is 1.633. Eight-node groups were also usable across multiple dependency levels: 32 actual nodes in four groups passed in 62.232 seconds of proof-body compilation, followed by a 7.532-second closed-theorem and axiom audit.

This is a useful reduction in compilation overhead, with substantial kernel work remaining. A 32-node single module exceeded the 3,000,000,000-byte process limit and was stopped; 64 nodes in one module were therefore not attempted. These results do not establish a faster proof of the empty state.

## The sample and invariant conclusions

The existing selected 20-tile proof DAG has **610 P nodes including one anchor**, hence 609 ordinary P-node sources available for repackaging. Its exact root is:

```text
0110330311010110001010110000000000
```

Original input sources are taken from the successful frozen `runs/lean_continuation/kernel_v1/source` snapshot, and each source SHA-256 is checked against that run's acceptance record. The fixed external dependencies use the corresponding already verified `.olean` files. Those imports are copied, with hash checks, into an isolated output tree under `build/lean_next/batch/modules`. They are not re-proved for each benchmark. The supplied DAG/source metadata select the sample; they do not serve as proof assumptions.

The producer retains every selected actual proof body. It removes duplicate file imports, repeated identical options and diagnostic print commands; renames selected node namespaces and direct references; and groups the declarations in their existing topological order. Intra-batch references use earlier declarations. References to another selected batch import that earlier batch. Nonselected dependencies remain explicitly imported original verified proofs.

For every selected node, the generated source also kernel-checks its literal 34-coordinate counts, exports a closed `SafeGame.SecondPlayerWins Step Win state` theorem, and retains its actual `ResponseCertificate.ProvedP state` theorem. The final audit checks their precise types, ensuring there are no additional premises, and checks every new theorem's axioms against `propext`, `Classical.choice` and `Quot.sound`. No new axiom, `sorry`, `native_decide`, P/N-table assumption, or new search result is introduced.

The separate `root_sample8` experiment contains seven original 32-tile nodes and the original 20-tile root. It reuses other original verified nodes as external dependencies. Its new theorem

```lean
Mahjong.BatchNext.RootSample8.Nodes.N24086.original_second_player_wins
```

passed both kernel compilation and closed-type/axiom checking, with the same literal 20-tile state above. This demonstrates preservation of an actual root conclusion under the transformation, while explicitly retaining the original external proof dependency chain. It is not a new independent closure from the empty table.

## Measurements

Every process used Lean 4.33.1, `--trust=0 --profile -M2400 -j1`, a 90-second per-module limit and a 3,000,000,000-byte private/RSS limit. No more than two owned Lean processes ran concurrently. The `chunked32x8` and `root_sample8` runs overlapped; the eight-node direct comparison ran sequentially. CPU times and individual commands are retained alongside wall times.

The proof-body columns exclude the explicit import-only control and the final audit module. The peak column includes all measured modules in that run. Reusable dependency copying and initial hash preparation occur before the reported compiler-process times.

| Experiment | Actual nodes / legal first branches | Proof-body seconds | Seconds/P | Amortized ms/branch | Final audit seconds | Peak private bytes | Result |
|---|---:|---:|---:|---:|---:|---:|---|
| Eight separate modules | 8 / 248 | 25.208 | 3.151 | 101.65 | 3.807 | 2,268,413,952 | PASS |
| One eight-node module | 8 / 248 | 15.441 | 1.930 | 62.26 | 7.047 | 2,265,141,248 | PASS |
| One 32-node module | 32 / 992 proposed | 34.424 before stop | — | — | Not run | 3,000,782,848 | UNVERIFIED: memory limit |
| Four eight-node modules | 32 / 992 | 62.232 | 1.945 | 62.73 | 7.532 | 2,330,767,360 | PASS |
| Eight-node sample including 20-tile root | 8 / 251 | 16.904 | 2.113 | 67.35 | 4.260 | 2,619,424,768 | PASS |

Per-branch numbers are amortized costs for these complete node proofs, not timings of isolated or interchangeable branches. The first 32-node sample contains 28 nodes at layer 32 and four at layer 30. The eight-node direct comparison uses the identical first eight layer-32 nodes, source IDs 120–127, in both modes.

The same-eight comparison reduced body CPU time by 36.0%. A module that only imported the shared proof foundations took 1.370 seconds. Omitting seven such process/import costs would save about 9.587 seconds; the observed body saving was 9.768 seconds. This supports launch/import overhead as the main source of the measured batching benefit.

It does **not** mean almost all verification time is startup. The merged eight-node profile still reports 9.2 seconds of kernel type checking and 2.45 seconds of tactic execution. In that run, eight large closed checks each required approximately 0.85–1.03 seconds of type checking, and each explicit `rcases` assembly reported approximately 0.17–0.19 seconds. Profiler categories can be cumulative/nested; their values must not be mechanically summed into wall time. In particular, `blocked (unaccounted)` is not a measured physical CPU duration.

The final audits load Lean's metaprogramming library as well as the compiled proofs. The first merged-eight audit spent 5.53 seconds in imports, while the later separate-module audit completed more quickly. These costs are retained rather than hidden; the claimed 38.7% reduction concerns the matched proof-body processes. Final audit cost should normally be paid once at the end of the intended certificate, not attributed once per node.

The historical 548.516-second clean replay used four workers, checked 680 total modules, and included foundations and the final audit. Its 609 ordinary-node process wall times sum to 1,894.570 seconds. That sum is not CPU time, and the eight-node experiment does not justify directly scaling the entire historical run or an empty-position certificate by 1.633. The current result supports modest grouping plus further work on proof-term/checker cost, not a claim that kernel verification has become negligible.

## Reusable scripts

Use the default isolated source/object roots for these scripts. For example, to generate eight-node batches of the 609 existing non-anchor proof nodes under a fresh namespace:

```powershell
node build/lean_next/batch/generate_batches.cjs `
  --count 609 --batch-size 8 `
  --name Mahjong.BatchNext.MyRepackedDAG `
  --evidence runs/lean_next/batch/my_repacked_dag
```

Generation does not compile or certify the result. That full 609-node repackaging has **not** been run in this experiment. To check a newly generated manifest:

```powershell
& build/lean_next/batch/compile_batches.ps1 `
  -Manifest runs/lean_next/batch/my_repacked_dag/generation.json `
  -WallSecondsPerModule 90
```

The compiler processes are sequential within one runner. `-SkipImportControl` omits the separate import-cost control. A new evidence directory/namespace is required for regeneration; a new `-RunName` is required for an independent measured replay. Existing proof sources and measured results are not overwritten. The runner stops on an error or budget failure and records an unverified result.

Eight is an observed workable batch size for these samples, not a universal memory guarantee. Each batch's dependency footprint and proof terms still determine its cost. Larger data should retain the watchdog and permit smaller batches if needed.

## Retained evidence and failed setup attempts

- `summary.json` gives all metrics, matching input identities, original-source provenance, theorem names, hashes, budgets and limits in machine-readable form.
- Each experiment's `generation.json` records the original and generated source hashes, exact node states, layer counts, branch counts, namespace mapping and external dependency closure.
- Every `kernel_v*/result.json` records the real command, resource observations, elapsed CPU/wall time, exit code, source snapshot and accepted object hash. The measured runner is copied beside it; stdout/stderr are retained separately.
- `merged8/kernel_v1` records a setup failure before selected proof checking: Lean selected the first `Mahjong` package root and could not find the anchor in a later search root. The successful runner uses hash-checked external `.olean` copies in one isolated package tree. It did not modify the original modules.
- `generator_initial_failure.json` records the initial count assertion correction: 610 includes the anchor. The rejected generation produced no proof output.
- `merged32/kernel_v1` preserves the actual memory-budget stop. Its partial work is not accepted.
- `merged64/generation.json` is explicitly generated but untested; no 64-node kernel result exists.

The completed proof modules, generator, runner and this evidence are now ready for review. The frozen `build/lean_verification` and `runs/lean_continuation` proof/evidence files were only read.
