# Reproducibility and delivery audit for the 19 October 2026 supplement

Audit scope: read-only inspection of existing sources, manifests, commands, publication receipts and completed validation records. No Lean, native worker, compiler, GPU process, full-table scan, cloud job, automation or publication was started. A bounded byte-consistency check read 22,229,027 bytes: 148 mapped public source files and ten delivery members smaller than 32 MiB. It passed; its receipt is `reproducibility_read_only_receipt.json`. The two large delivery archives and the 100.62 GB raw input set were not rehashed in this audit.

The manuscript and the new results are intended to be reviewed and frozen together in a future release. No release identifier for that future joint snapshot is assigned here. Historical public commits are useful provenance, not a substitute for the eventual article-associated snapshot. In particular, neither the old public V19 subset's incompleteness nor the current local delivery's existence should be presented as a permanent availability statement.

## 1. Distinct artefacts and their current scope

| Artefact | Verified location or identifier | What a reader obtains |
|---|---|---|
| Current local public checkout | `build/publication/mahjong-achievement-game`; clean HEAD `e75911f700d4e5e1b39df53273e9dde698bf4901`, tree `ed3ab65dc09903347a0c044f230b696cbda07207` | Public PR #11 materials for complete V17 native verification, previous papers, selected sources and recorded evidence |
| Historical public kernel snapshot | `research/2026-10-18-kernel/` in that checkout | 712 provenance-tracked artefacts; generic V17, V18 pilot and incomplete selected V19 research source subset |
| Public complete-native snapshot | `research/2026-10-19-v17/` | 148 exact Lean sources through a source map, input identities, coverage summaries and read-only verification tools |
| Public saved native evidence asset | `mahjong-v17-native-evidence-20261019.zip`, immutable evidence tag `evidence-v17-native-20261019` | 38,329 original evidence files; 63,456,055 compressed bytes and 145,559,336 uncompressed payload bytes; only the 8-byte empty-root table payload is included from the full game data |
| Local portable V17 delivery | `runs/lean_table_checker/portable_repro_20261019/package_02/deliverables/` | Core archive, complete raw input archive, exact Linux runtime and original ELF, small controls, evidence audit, and portable re-execution entry |
| Local portable pure-kernel pilots | `mahjong_kernel_pilots.tar.zst` in the same delivery | Three isolated saved-proof lanes, their sources and sample inputs, replay driver and reconstruction tools; no empty-position proof |

The repository origin is `https://github.com/feierbuqiu/mahjong-achievement-game.git`. The retained publication receipt `runs/publication_native_20261019/published-update-receipt.json` records a verified remote merge at the above HEAD, PR #11, successful C++ smoke checks on Linux and Windows and repository checks, verified public file bytes, and immutable evidence-asset publication. This audit checked the local checkout and receipt, not a new live remote fetch. A local Git signature query did not provide a new verification result (`gpg` wait error), so the prior receipt must not be relabelled as fresh signature verification by this audit. The semantic release remained `v1.0.0`; the new evidence tag is not a replacement semantic paper release. The retained `local-audit.json` states that both earlier manuscript files remained byte-identical to `v1.0.0`.

Public evidence asset URL recorded by both `assets.json` and publication receipt:

`https://github.com/feierbuqiu/mahjong-achievement-game/releases/download/evidence-v17-native-20261019/mahjong-v17-native-evidence-20261019.zip`

Its SHA-256 is `5e68d6382c6e68fd525cd52defdb1969007aaaeddd24d5fe8afabc299057bdc4`. This is the 63 MB evidence ZIP, not the 1.4 GB portable core or 8.1 GB full-input archive.

## 2. Exact public commands: integrity and source assembly, not execution

From the identified public repository checkout:

```sh
python3 research/2026-10-18-kernel/verify.py
python3 research/2026-10-19-v17/verify.py
python3 research/2026-10-19-v17/prepare_sources.py --output build/v17-source
python3 research/2026-10-19-v17/verify.py --archive /path/to/mahjong-v17-native-evidence-20261019.zip
```

All four use Python's standard library. The first audits the historical kernel-publication subset. The second checks public artefact hashes, source mappings, closure and recorded scope, and should print `PASS_V17_NATIVE_PUBLICATION`. The third verifies and copies the mapped source files into a new output directory, then prints `ASSEMBLED_EXACT_SOURCE_ONLY`; it does not compile. Its output must not already exist. The fourth additionally verifies the saved evidence graph and should print `PASS_SAVED_NATIVE_EVIDENCE_GRAPH`: exact recorded coverage, source/target identities, frame bindings, before/after input-map consistency and the stored empty-root bit. It does not re-evaluate the game recurrence, run Lean or native code, or rehash the absent full inputs.

The 148 mapped public Lean files occupy 998,419 bytes and passed this audit's fresh small hash check. The source-map counts are different scopes: 145 mathematical basis modules, 148 published source files including application/replay entries, a 146-file source import closure for `V17ComputeReplay`, and 145 imported modules in the recorded replay report. The portable build adds `ReproAuditRoot`, giving exactly 149 sources; direct set comparison of public module names with `cold_report.json` found this to be the only additional name.

The public Oct18 README explicitly says its selected V19 source subset has unresolved project imports and lacks some binary-emitted data and dependencies. That statement remains correct for that historical subset. It must not be used to deny the later local saved-proof archive's completed three-lane cold replay.

## 3. Exact local delivery identities and input requirements

The final delivery is sealed by `package_02/DELIVERY.json`, `DELIVERY_FINAL.json` and `deliverables/SHA256SUMS`.

| Archive | Compressed bytes | Expanded member bytes | SHA-256 |
|---|---:|---:|---|
| `mahjong_v17_core.tar.zst` | 1,407,097,086 | 5,021,617,870 | `45673cf14ffedd3a85367f29508ad7587ef370a90aace2ec2f4e00c82a38c24e` |
| `mahjong_v17_full_inputs.tar.zst` | 8,087,887,655 | 100,615,834,170 | `afa51a9e7202e2e2ae5381534b5d93c64bed6e155c9bd39306ee621d53bd933e` |
| `mahjong_kernel_pilots.tar.zst` | 21,136,243 | 331,033,631 | `e4bbdc9c00f1c3c40434f8d00893ca347a69519fda25772712533d141129d5dc` |

The core has 73,899 members; the full-input archive has all 11,272 original input files; the pilot archive has 1,679 members. Expanded byte totals are payload sizes, not complete disk-space budgets including archive copies, filesystem overhead and new outputs. The complete input set is 100.616 decimal GB; do not substitute the older approximately 97.32 GB outcome-payload figure for this larger dependency set.

The core contains exact mathematical/runtime sources, the complete pinned Linux Lean distribution, historical ELF, common finite inputs, a tiny real source/target bucket and deliberate malformed fixtures, complete historical execution evidence, and verification tools. Cold source compilation, small direct-ELF controls and evidence-only replay need the core but not the full-input archive. The full-input archive is required for full input hashing and a new whole-table native re-execution. Saved pilot replay needs the pilot archive and the exact toolchain from the core, but no global tables, GPU, game native worker, source-expression generation or plugin execution.

One machine-specific historical `native_config.json` is deliberately omitted; its 1,623-byte size and SHA-256 are retained in `metadata/omitted_historical_artifacts.json`, and portable path-neutral configurations are generated per new run. The mathematical sources, original ELF and original `FINAL.json` are unchanged. A recipient must not treat an omitted account-specific path configuration as an unavailable mathematical input.

Important identities:

```text
original native ELF: 775e05d2601e30847b14b017cb542ea23a8b629d8ebd403aa07bd5942b78f667
original FINAL:      413ced59dcfcc2825f6b17503e8690f895b6d9f0219ddb2eb4ce43cf992c957e
rebuilt test ELF:    353cf032601978e5cca85340243bed8d6cbdeaf6fcfc08c964880d2524ef5ce2
```

The historical ELF is 121,190,888 bytes; the relocated source rebuild is 121,191,056 bytes. Different build paths can change ELF bytes. Successful controls on the rebuilt ELF do not replace the original binary identity in the historical full-run receipts.

## 4. Recipient commands and their meanings

### 4.1 Core integrity, generic source replay and small native evaluation

After checking archive identities against the delivery's `SHA256SUMS`:

```sh
python3 unpack.py mahjong_v17_core.tar.zst --output /var/tmp/mahjong-clean
cd /var/tmp/mahjong-clean/mahjong_v17_repro
python3 verify.py integrity
python3 reproduce.py cold --output /var/tmp/mahjong-cold-run-001 --jobs 4
python3 verify.py evidence
```

`verify.py integrity` should print `PASS_BUNDLE_INTEGRITY`. It hashes packaged files only. `reproduce.py cold` creates fresh project objects, compiles with `--trust=0 -Ddebug.skipKernelTC=false -j1`, runs the supplied `leanchecker --fresh -v ReproAuditRoot`, then evaluates common finite base/successor checks and six real controls with the historical ELF. Successful completion prints `PASS_REQUESTED_SMALL_REPRODUCTION`. It is deliberately a mixed source/kernel plus small native test; do not describe the entire `cold` command as source-only.

The driver also supports an exact source-only mode:

```sh
python3 reproduce.py compile --output /var/tmp/mahjong-source-only-001 --jobs 4
```

This runs the source compilation and fresh kernel replay without small native controls. This command is supported by the inspected driver; the retained end-to-end recipient receipt exercised the larger `cold --native` path, not this standalone spelling as a separate experiment.

To rebuild the native executable from source and exercise both original and rebuilt small controls:

```sh
python3 reproduce.py cold --native --output /var/tmp/mahjong-native-build-001 --jobs 4
```

Every output location must be new. `verify.py evidence` imports the frozen original finalizer and verifies complete recorded ledger spans, frame/source/target links, saved post-input identity record, catalogue headers and service-exit records. Its expected status is `PASS_ORIGINAL_EXECUTION_EVIDENCE`, with `historical_game_rows_recomputed: 0`. This is more than a file-count check but still not a new recurrence evaluation.

### 4.2 Large input integrity and optional re-execution

```sh
python3 unpack.py mahjong_v17_full_inputs.tar.zst --output /var/tmp/mahjong-clean
cd /var/tmp/mahjong-clean/mahjong_v17_repro
python3 verify.py full-inputs
```

The last command reads and hashes all 100,615,834,170 bytes and should report `PASS_FULL_INPUT_HASHES_ONLY`, with zero game rows recomputed. It is intentionally not run for this paper audit.

Before optional GPU or full re-execution, the delivered portability notes require an adequate per-process open-file limit:

```sh
ulimit -n
ulimit -n 65536
```

The host hard limit must permit that setting. Two nested read-lock scopes can require more than 23,000 handles. Advisory file locks and raw-file/immutable-identity custody remain trusted IO conditions, not a kernel theorem about filesystem behaviour.

The default portable native/GPU path checks one complete 56-row bucket:

```sh
python3 full_replay.py --controls-report /var/tmp/mahjong-cold-run-001/small_controls/smoke_report.json
```

A fresh full execution is an explicit optional command, not work performed during packaging or this audit:

```sh
python3 full_replay.py --all --acknowledge-full-scan --threads 12 \
  --controls-report /var/tmp/mahjong-cold-run-001/small_controls/smoke_report.json
```

The new entry requires the fresh six-control report to match the historical ELF, control definition and bundle manifest, uses frozen original functions and adapter, creates a new ledger, and imports no old accepted game frames. The entire all35 path has not been recipient-tested. Only the selected bucket path has a completed new receipt. Automatic resume for this portable entry is not implemented. A command being supplied is not evidence of successful execution of that command's whole scope.

### 4.3 Saved pure-kernel pilot replay

Extract the pilot archive with the supplied `unpack.py`, then enter `mahjong_kernel_pilots/`. Assuming the core was extracted as above:

```sh
python3 verify_kernel.py integrity
python3 verify_kernel.py replay --lane packed --toolchain /var/tmp/mahjong-clean/mahjong_v17_repro/runtime/lean-4.33.1-linux --output /var/tmp/packed-new
python3 verify_kernel.py replay --lane game --toolchain /var/tmp/mahjong-clean/mahjong_v17_repro/runtime/lean-4.33.1-linux --output /var/tmp/game-new
python3 verify_kernel.py replay --lane game-slim --toolchain /var/tmp/mahjong-clean/mahjong_v17_repro/runtime/lean-4.33.1-linux --output /var/tmp/game-slim-new
```

Integrity reports `PASS_KERNEL_PILOT_BUNDLE_INTEGRITY`. Each replay uses a fresh empty working directory, an isolated lane-specific `LEAN_PATH`, one Lean thread and a 300-second timeout, and should report `PASS_STANDARD_FRESH_KERNEL_REPLAY`. Timeout is incomplete replay, not rejection of the theorem and not a successful verification. This wrapper replays saved proof objects; it does not rebuild source, regenerate data or execute the earlier expression-building plugin. It also does not itself recompute a fresh axiom-dependency report; the axiom scope rests on source/construction audits in addition to kernel replay.

Lane targets are `Mahjong.FreshPackedEvidenceV19` for `packed`, and `Mahjong.PilotActualGameV18` for `game` and `game-slim`. Keep the lanes separate: the slim lane has an import-only `Std` to `Init` foundation fork with the same game definitions and proof statements. It is not a replacement for frozen V17 sources.

The archive also documents a source reconstruction command:

```sh
python3 tools/run_packed.py --root frozen_workspace --toolchain /var/tmp/mahjong-clean/mahjong_v17_repro/runtime/lean-4.33.1-linux --output /var/tmp/packed-rebuilt-new
```

The fixed sample source/input set is included. Local packed construction from research sources passed previously, but the archive recipient test performed saved-object replay, not a fresh packaged-source reconstruction through this command. Keep those two evidence levels separate. Generated input expressions are untrusted; construction-time kernel checking and final plugin-free replay validate the resulting mathematical declarations.

## 5. Completed portability evidence, including failures

The authoritative final V17 test is `package_02/cold_test_03/REPORT.json`, bound to the final core archive SHA above. It reports:

| Stage or quantity | Completed result |
|---|---|
| Fresh extraction and all core member hashes | PASS |
| Source compilation | All 149 project modules, no reused project `.olean` |
| `leanchecker --fresh` for generic source closure | 108.355777852 s, exit 0 |
| Cold source/native build and controls command | 1,251.9976054 s internal wall time |
| Historical ELF six controls | 530.737992964 s; peak native RSS 8,325,414,912 bytes |
| Source-rebuilt ELF six controls | 516.224149705 s; peak native RSS 8,437,444,608 bytes |
| Complete historical evidence audit | `PASS_ORIGINAL_EXECUTION_EVIDENCE`; 17,317 frames, 3,686 buckets, one session; zero game rows recomputed |
| Portable native/GPU selected bucket | 56 rows (41 P, 15 N), one frame, 220 input files; `PASS_PORTABLE_SELECTED_BUCKET_ONLY` |
| Entire validation orchestration | 1,948.532424056 s, including extraction, hashes, source/build/controls, evidence audit and selected GPU entry |

The wrapper's individual stage timings include polling overhead; do not add or substitute these for the nested command's internal timer. RSS is process memory, not system-wide or GPU memory. The native startup rechecks the whole common finite base and successor caches, so 56 divided by startup-inclusive time is not a useful row-throughput estimate.

The selected bucket is `n32_h089`. Its five negative controls reject source-bit flipping, deleting the last row, a target-bank identity mismatch, truncated source bits and incorrect honour metadata. The small positive control does not freshly evaluate the empty-root P check or all35 coverage; those are rechecked as historical evidence. The portable GPU test confirms normal child exit, GPU-context closure and unchanged selected inputs, and explicitly reports `original_game_winner_claimed: false`.

Two earlier package trials failed and are retained. `cold_test_01` reached control execution but missed an exact catalogue path alias, prompting preflight dependency checks and an exact-byte alias repair. `cold_test_02` completed source/kernel/native controls and evidence checking, then failed the new GPU wrapper's working-directory contract. The wrapper was repaired and the separately extracted final `cold_test_03` passed. These were packaging/controller defects, not accepted partial computations or mathematical counterexamples. `PRECHECK_REGRESSION.json` records unchanged mathematical and native bytes; the final core corresponds to revision r4.

Additional completed controls: the integrity checker rejected a real temporary extracted-member mutation and the original bytes were restored; the frozen finalizer rejected three in-memory modifications to the complete historical ledger (removed last record, bad receipt hash, duplicate first frame). None edited original production evidence. The full-input archive was independently streamed through decompression and all 11,272 input member hashes checked in 396.858220185 s; that is data integrity, not a game scan.

The separate pilot recipient report `KERNEL_PILOTS_COLD_REPORT.json` records a new extraction of the 21 MB archive and all three saved-proof replays:

| Lane | Wall seconds | Sampled peak process RSS | Exact scope |
|---|---:|---:|---|
| packed | 88.751290352 | 785,555,456 bytes | Fixed 28-block/402-word numerical layout, function equivalences and PN equations; actual complete SAFE/addressing/game assembly not instantiated |
| game | 176.809048323 | 1,382,748,160 bytes | Three unconditional original-game strategy statements at 32-tile positions from an 11-node physical certificate |
| game-slim | 127.461217625 | 1,068,597,248 bytes | Same game statements, import-only foundation fork |

The three-lane extracted test ran concurrently and took 179.227892366 s overall. Parallel contention prevents interpreting those times as a controlled speed comparison. No lane proves the empty position, and the 1,035,129 colex rows / 1,077,270 Cartesian coordinates in the packed sample are not that many fully certified original-game positions.

All these recipient tests used different directories on the same Linux/WSL physical host. There is no second-machine, other-architecture or other-toolchain replication, and no second full all35 computation. The older September 15 paper's 84-module Windows source closure (94.172 s, separate ZIP-path replay 93.922 s) is a historical different experiment, not an alternative count or timing for this 149-source October delivery.

## 6. Environment and portability limits

The source/control/replay tools target Linux x86_64 including WSL2. The recorded environment is Ubuntu 26.04.1 LTS, glibc 2.43, Lean 4.33.1 commit `819816b2e0a3bf405af45ae5c7af2491d8f5bee6`, and bundled clang 22.1.4 commit `35990504507d79e0b9deb809c8ee5e1b34ceef20`. The native ELF dynamically depends on the Linux loader and glibc-family libraries. Older glibc, macOS, ARM and native Windows execution of these October wrappers have not been validated.

Integrity/evidence commands use Python >=3.10 standard library. Archive extraction needs Python 3.14's `compression.zstd`, or Python with `zstandard`, or a system `zstd` executable. Dependencies are not installed automatically. Use disk-backed `/var/tmp` or another suitably large disk filesystem; the core expands to about 5.02 GB. The recorded machine has 32 GB system RAM with about 16 GB exposed to WSL. Delivery guidance reserves at least 16 GB for the common native finite-base test and recommends 32 GB system RAM. This is environment guidance, not a proven upper bound on every optional full execution.

GPU re-execution additionally requires an NVIDIA driver exposing `libcuda.so.1`; NVRTC 12.4.127 libraries and the original untrusted GPU source are included. GPU proposals never authorise a row without the frozen native Lean checks. No cloud service, API key or model invocation is required. The compiler runtime's licences are included; bundling does not create a new licence for research sources.

## 7. Trust claims that require precise versioned citation

The relevant local primary implementation is `build/toolchain/lean-4.33.1-windows/src/lean/`. These source files were read, not executed. The Linux replay's exact pinned toolchain remains the operative executable; the inspected files are the same release's distributed source.

1. **Meaning of `leanchecker --fresh`.** `LeanChecker.lean:36–38` loads the target and calls `(mkEmptyEnvironment).replay env.constants.map₁`. Lines 64–68 distinguish replaying imported and local constants into a fresh environment and explicitly say this is not an external verifier. `Lean/Replay.lean:59–62` passes declarations to `env.addDeclCore 0 0`; lines 98–99 replay axiom declarations; lines 179–181 skip unsafe and partial constants. Thus fresh replay addresses the imported-declaration/environment gap using the standard kernel. It is neither an independent kernel implementation nor a blanket rejection of added axioms.
2. **Current `native_decide`, not a stale implementation description.** `Lean/Elab/Tactic/Decide.lean:57–69` uses `nativeEqTrue`; lines 190–193 set `native := true`. `Lean/Meta/Native.lean:31–36` specifies compilation/evaluation followed by a new axiom asserting the Boolean result. Lines 75–83 create a fresh `_native.<tactic>.ax` axiom after a true result. The older `Lean.trustCompiler`, `reduceBool` and `ofReduceBool` mechanism still appears in `Init/Core.lean:2375–2449` but is explicitly deprecated. A paper tied to 4.33.1 should not state that this version's tactic works only through the old `ofReduceBool` mechanism.
3. **`decide +kernel`.** `Lean/Elab/Tactic/Decide.lean:105–131` constructs the decidability proof and submits it through `mkAuxLemma` with asynchronous elaboration disabled; the kernel checks reduction. This is different from `nativeEqTrue` adding an evaluation axiom. Default `decide` also produces a proof term for kernel checking, with a preliminary elaborator reduction.
4. **Axiom scope.** A replay that accepts an axiom declaration has not proved that axiom. Successful replay must be combined with theorem-type and transitive axiom-dependency auditing. The accepted research targets are reported with only `propext`, `Classical.choice` and `Quot.sound` as mathematical dependencies. `sorryAx`, new `_native...ax` assumptions and changed target statements must be excluded explicitly. The absence of `native_decide` in a generic theorem does not remove the compiler/runtime/IO assumptions from a separate native data evaluation.
5. **Native all35 versus actual closed theorem.** Complete V17 runtime evidence checks fixed compiled functions against complete identified inputs. Its external ledger, hash/coverage bookkeeping and file-to-Lean decoding remain in the trusted execution boundary. Typed in-process `finishWhole` was not the production final assembly route. A saved JSON receipt is not a serialized Lean proof object, and proof erasure prevents inferring a persistent concrete theorem merely because a typed function returned at runtime.

Suggested primary-source references to verify for the article are the official Lean reference manual's “Validating a Lean Proof” page (`https://lean-lang.org/doc/reference/latest/ValidatingProofs/`) and the pinned Lean repository files `src/LeanChecker.lean`, `src/Lean/Replay.lean`, `src/Lean/Meta/Native.lean`, `src/Lean/Elab/Tactic/Decide.lean` at the above Lean commit or release. Cite the checked version rather than relying only on a moving `/latest/` description. This subtask did not perform a fresh web lookup of those official pages. If independent implementation checking is discussed, distinguish lean4lean or another genuinely separate checker from the standard `leanchecker`; no successful such independent replay is claimed here.

## 8. Source pointers for manuscript assembly

- Public scope and commands: `build/publication/mahjong-achievement-game/research/2026-10-19-v17/{README.md,assets.json,source-map.json,verify.py,prepare_sources.py}`.
- Public historical scope: `build/publication/mahjong-achievement-game/research/2026-10-18-kernel/README.md`.
- Publication evidence: `runs/publication_native_20261019/{published-update-receipt.json,local-audit.json}`.
- Local delivery seals and archive integrity: `runs/lean_table_checker/portable_repro_20261019/package_02/{DELIVERY.json,DELIVERY_FINAL.json,FULL_ARCHIVE_ROUNDTRIP.json,PRECHECK_REGRESSION.json}`.
- Environment, trust and runnable interfaces: `build/lean_table_checker/portable_repro_20261019/package/{README.md,ENVIRONMENT.md,TRUST_BOUNDARY.md,reproduce.py,verify.py,full_replay.py}` and delivered `PORTABILITY_NOTES.md`.
- Final recipient execution: `runs/lean_table_checker/portable_repro_20261019/package_02/cold_test_03/{REPORT.json,cold_report.json,SIX_CHECK_SCOPE.json,FINALIZER_NEGATIVE_CONTROLS.json}`.
- Pilot delivery/replay: `runs/lean_table_checker/kernel_exploration_20261019/kernel_bundle_01/README.md`, `kernel_share_cold_01/REPORT.json`, delivered `KERNEL_PILOTS_COLD_REPORT.json`, and `build/lean_table_checker/kernel_exploration_20261019/verify_kernel.py`.
- Older paper comparison: `runs/lean_supplement_20260915/manuscript.md`, Section 8 and Appendix C. It describes a smaller Windows 84-module source replay and explicitly distinguishes source replay from finite-data acceptance.

No actionable discrepancy was found between the final local delivery sizes, small member hashes and retained passing receipts. Remaining qualification is substantive: the current evidence establishes a complete compiled V17 evaluation and several ordinary kernel-proof pilots, but not a closed actual empty-game pure-kernel theorem, second full execution, independently implemented checker replay, or cross-machine portability validation. The future joint publication should preserve those distinctions and publish the final applicable bundle identities alongside the manuscript.
