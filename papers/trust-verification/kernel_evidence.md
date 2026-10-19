# Pure-kernel evidence audit for the 19 October 2026 supplement

Read-only audit of retained sources, successful and failed receipts, logs, and the saved-proof archive. No Lean, native game worker, GPU, compiler, scheduler or research scan was started. This memo concerns the pure-kernel route; the completed V17 native all35 evaluation is a separate, stronger-than-September computational result with a larger execution trust boundary. It is not an actual closed pure-kernel opening theorem.

All paths below are relative to the research root unless explicitly identified as archive member paths. Line numbers refer to the current retained source. The audit independently checked the identities described in Section 8; other timing measurements are read from the cited original receipts, not remeasured.

## 1. Current conclusions and chronology

| Evidence | Completed scope | Claim that it does not establish |
|---|---|---|
| `end_to_end_20261018_v17` | General composition from finite checks, through all cross-layer obligations, to `SecondPlayerWins Step Win empty`; 145-module fresh replay | Acceptance equations for the actual complete input as saved closed kernel proofs |
| `kernel_pilot_20261018_v18` | Saved closed original-game proofs from an 11-node physical certificate; three named 32-tile starting-position conclusions; separately, 56 captured hot-checker rows and two scalar scans | Full V17 input acceptance; a more advanced opening frontier than the previously certified 12-tile root |
| `acceleration_20261018_v19` | General bit-layout and local-certificate theorems, numerical component pilots, selected actual local metadata rows, measured proof-organisation improvements | Complete local certificate, complete actual addressing, complete game-table proof or a 20-hour bound |
| `kernel_exploration_20261019/packed_05` | All 28 fixed numerical sample blocks; 402 words; 1234 layout equalities; arbitrary-input function equivalences; saved PN equations; single fresh replay | Original-game strategies for the 1035129 colex rows / 1077270 Cartesian coordinates |
| `kernel_exploration_20261019/game_01`, `game_slim_01` | Linux construction and fresh replay of the same concrete 11-node original-game proof; a smaller foundation-import experiment | Empty-game theorem or a new collection of earlier opening states |
| `kernel_share_cold_01` | Independently extracted portable packed/game/game-slim lanes all fresh-replayed | Independent kernel implementation, second physical machine, complete opening verification |
| `portable_repro_20261019/package_02` | Same-host, fresh-directory source/kernel/native/control reproduction; recorded full-input archive integrity; portable proof packages | A second full all35 run or a closed full-input kernel acceptance proof |

The V17 `PROOF_STATUS.json` is dated 18 October and says actual full-input acceptance was then unverified. Its native-execution status has been superseded by the completed all35 run recorded in the 19 October delivery. Its **absence of a closed pure-kernel opening theorem remains current**. Similarly, the old V19 cached-full402 study was stopped incomplete; `packed_05` subsequently completes that fixed numerical-component experiment, not its missing actual SAFE/addressing/game semantics.

The final delivery explicitly records `empty_closed_pure_kernel_theorem = false`. The project should be described as continuing kernel-proof and certificate-compression research; historical STOP files or stopped experimental branches do not establish permanent closure of the research programme.

## 2. V17: precise general theorem and its six checks

Source prefix: `build/lean_table_checker/end_to_end_v17/source/Mahjong/`.

The final theorem is `Mahjong.FastWholeInputV17.from_finite_input`, `FastWholeInputV17.lean:153`. Its exact type, with namespace openings as in the source, is:

```lean
theorem from_finite_input (i : FiniteWholeInputV17.Inputs)
    (baseChecked : FiniteWholeInputV17.baseChecks i = true)
    (successorsChecked : FiniteWholeInputV17.successorChecks i = true)
    (metadataChecked : FiniteWholeInputV17.checkMetadata i = true)
    (frames : RawFrames (FiniteWholeInputV17.buildTable i baseChecked metadataChecked))
    (framesChecked : checkWhole (FiniteWholeInputV17.buildTable i baseChecked metadataChecked) frames = true)
    (targetIdentity : ExecutionAssemblyV17.targetChecks
      (FiniteWholeInputV17.buildTable i baseChecked metadataChecked) = true)
    (rootChecked : EmptyRootV17.checkP
      (RuntimeBindingV17.root (FiniteWholeInputV17.buildTable i baseChecked metadataChecked)).data
      (RuntimeBindingV17.root (FiniteWholeInputV17.buildTable i baseChecked metadataChecked)).bits = true) :
    SecondPlayerWins Step Win empty
```

The six accepting equations are not six arbitrary trusted booleans. They concern specified pure functions on the same finite input/prepared-frame objects:

1. `baseChecks`: local rule/SAFE data, canonical inventories, group/link data, finite SAFE-bound envelopes, triple/honour directory data and relevant layout/word bounds. `FiniteCertificateV17.Inputs` contains raw finite data, and `FiniteCertificateV17.build` constructs `GlobalEnumeration.Certificate` from `checks i = true` (`FiniteCertificateV17.lean:33,126,177`).
2. `successorChecks`: exact local successor-cache validation, constructed into `GlobalSuccessorBridge.Checked` rather than assumed as a semantic oracle.
3. `checkMetadata`: every positive source cell, its actual source/index data, loaded target-bank metadata and complete reachable-key coverage, including SAFE-false keys (`FiniteWholeInputV17.lean:70–98`).
4. `checkWhole`: exact source-frame coverage and successful frozen scalar scans. `checkBucket` checks the cover from zero to the source size and all frame results (`FastWholeInputV17.lean:47`); `RuntimeScanV17.pureFrameB_each` turns scan acceptance into every covered actual row's acceptance (`RuntimeScanV17.lean:263`).
5. `targetChecks`: target-bank identity with the strictly next layer. `CrossLayerAssemblyV17.sameBucket` compares numeric data, IDs, groups, directory, honour code, size and **bits** (`CrossLayerAssemblyV17.lean:122`). Cross-layer induction constructs target correctness; it is not a premise asserting that proposed P/N labels are already correct.
6. `EmptyRootV17.checkP`: actual root decoding/shape/bounds and its proposed P bit. The empty-state decoding identity is derived from finite checks, not supplied as an unproved caller equality.

`RawFrames` is important: its `RawFrame` objects contain `RuntimeScanV17.Fragment`, hence `PreparedPlan` objects. `PreparedPlan` has finite `honor`, `sourceAccepted`, `planAccepted` and `hotBuilt` proof fields (`RuntimeScanV17.lean:41–53`). These are supplied by checked preparation, not by deserialising a JSON PASS. They do not assume `NormalStrategy`, `TargetCorrect` or accepted rows. Thus the final theorem has six named boolean acceptances plus prepared finite frame data, rather than an arbitrary semantic strategy hypothesis. It would be imprecise to call the entire fast input “proof-free raw bytes”.

The purely raw reference entry is `Mahjong.FiniteWholeInputV17.accepted_sound` (`FiniteWholeInputV17.lean:153`):

```lean
theorem accepted_sound (i : Inputs) (result : accepted i = true) :
    SecondPlayerWins Step Win empty
```

Its `Inputs` and `RawCell` structures contain finite data and raw row proposals, not semantic strategy proofs. This reference model's per-row arrays and repeated preparation are not a demonstrated practical production allocation. `certify : Inputs → Option (PLift (SecondPlayerWins Step Win empty))` is mathematically proof-producing, but compiled proof erasure means an external `some`, a receipt or a process exit code is not a persistent Lean proof object.

The fast theorem builds its `Trace` internally (`FastWholeInputV17.buildTrace`, line 115); `ScanFinalV17.CheckedRange` (line 28) retains chunk endpoints at runtime and carries row facts in erased proof fields. Persistent declarations checking actual data are needed to recover those facts across independent processes.

The intrinsic V17 strategy theorem does not by itself say the supplied physical source directories contain every SAFE orbit. P rows cover every actual SAFE successor, N rows provide actual successors, and the strictly layered proof is sufficient for the root strategy. A stronger “this exact directory is the complete global SAFE enumeration” statement requires the separate directory-slice binding. Do not infer that stronger claim merely from the root theorem's conclusion.

Recorded final V17 replay: `end_to_end_20261018_v17/replays/50a0cdc49875425cb1c12ee205f15c8f/receipt.json`, return code 0, `leanchecker --fresh -v Mahjong.ReplayClosureV17`, 145 project modules (132 inherited plus 13 new), 123.078 s. The selected final theorem axiom output is exactly `[propext, Classical.choice, Quot.sound]`. The status records 94 selected axiom-fingerprint observations, **not an exhaustive inventory of every declaration** (`all_theorem_axioms_inventory_complete = false`).

## 3. V18 and the named concrete original-game conclusions

Source prefix: `build/lean_table_checker/kernel_pilot_v18/source/Mahjong/`.

All names below are under `Mahjong.PilotActualGameV18`. `state` is `Mahjong.PilotGameV18.state`; `node1`, `node2`, `node3` are literal `Mahjong.PilotActualDataV18` values. `SecondPlayerWins` and `WinningStrategy` are in `Mahjong.SafeGame`; `Step` and `Win` are the original `Mahjong` rules.

| Declaration and line in `PilotActualGameV18.lean` | Exact conclusion | Literal 34-count state |
|---|---|---|
| `actual_p50_second_player_wins`, line 20 | `SecondPlayerWins Step Win (state node2)` | `1101101011101101101101101104441100` |
| `actual_p55_second_player_wins`, line 23 | `SecondPlayerWins Step Win (state node3)` | `1101101101101101101101101104441100` |
| `actual_n35_first_player_wins`, line 26 | `WinningStrategy Step Win (state node1)` | `1101101011101101011101101104441100` |

Decoded numerical suits respectively are `(124579m,124578p,124578s)`, `(124578m,124578p,124578s)`, and `(124579m,124579p,124578s)`. Each has the same honours vector `[4,4,4,1,1,0,0]` in East, South, West, North, White, Green, Red order. Each has 32 tiles, also certified by `sampled_positions_have_32_tiles` (line 30).

These declarations have **no acceptance hypotheses**. `actual_checked : checkTrace actualTrace = true` is closed (line 13). `all_actual_nodes` (line 16) gives, for every member of the literal trace, `Valid ∧ IsSafe ∧ NormalStrategy SafeMove` with its actual label. The trace consists of 11 nodes, six P and five N, at sizes 32–34. Node 0 is also a terminal 32-tile P node; therefore “three named starting-position conclusions” is more exact than “only three 32-tile positions certified”. The three highlighted statements are combined by `Mahjong.PilotClosureV18.actual_game_closed` (`PilotClosureV18.lean:15`).

`PilotGameV18` is a separate sparse physical checker, not the V17 hot indexed checker. Its `checkRule` (line 86) checks all 34 physical tile kinds for P: every legal SAFE addition must match an N node in the strict trace tail. N must give an actual legal addition matching a P node in that tail. `known` (line 51) compares all physical counts and the label; out-of-range references fail. `checkNode` (line 102) checks the 34-entry shapes and actual source SAFE predicate. `trace_sound` (line 156) has no initial assumed facts, so purported terminal leaves must pass the same exhaustive SAFE-successor check. Concrete unsafe branches can be discharged by checked actual winning-subset witnesses through `PilotGameCheckBridgeV18`; this avoids repeated search without weakening the predicate. The original-game bridge then produces the stated strategies.

The independent hot-checker experiment remains separate:

* `Mahjong.PilotClosureV18.original_hot_checker_closed` (`PilotClosureV18.lean:23`) proves `PilotScanDataV18.checkPrefix 56 = true` for 56 distinct captured rows in four blocks, 41 P and 15 N. These are finite captured read footprints, not complete global finite-cache/index certificates.
* `Mahjong.PilotClosureV18.actual_scalar_scans_closed` (line 26) conjoins actual `GuardedByteScanV16.scan` results for rows 0 and 35, returning `.ok 1` and `.ok 0` respectively. Those scalar samples overlap the 56 rows; do not add them as new distinct rows.

V18 Windows persistence experiment: frozen replay receipt `kernel_pilot_20261018_v18/attempts/90dd086fec074a54889ea9fb2442a447/receipt.json`; target `Mahjong.PilotClosureV18`; return code 0; 176.562 s measured controller wall time (176.188 s child wall time); 1589190656 B peak Job committed memory. Bundle manifest: `kernel_pilot_20261018_v18/bundles/fb92822a7dba4b33b147e5005769327f/manifest.json`.

The bundle totals 57788336 B of saved project modules, of which V18 modules total 3645360 B; the final target's V18 source-import closure uses 3584792 B. Successful construction wall times sum to 125.783 s, **not elapsed parallel end-to-end time**. The selected original-game targets use the three standard axioms; the hot-row and scalar-scan conjunctions use only `propext` and `Quot.sound`.

The 56-versus-8-row construction comparison gave approximately 4.504 incremental rows per wall second (4.531 per CPU second). This exposes the cost of that direct row-evaluation method. It is neither a lower bound for all proof representations nor the throughput of the later packed method.

## 4. V19 general compression mathematics and actual limits

The following source prefix is `build/lean_table_checker/acceleration_v19/compression/source/Mahjong/`.

* `Mahjong.BitCompactV19.compact_read` (`BitCompactV19.lean:216`) proves the precise extraction equation `testBit (compact k stride width input) (i*width+b) = testBit input (i*stride+b)`, under `stride = width ∨ 2*width ≤ stride`, `i < 2^k`, `b < width`. `compact_outside` (line 233) proves all output bits beyond the output extent are zero. The spacing condition is essential; this is not arbitrary target-address gathering.
* `Mahjong.CanonicalPadV19.check_refines` (`CanonicalPadV19.lean:270`) and `raw_read` (line 290) connect checked padded layouts to the older word representation. The actual full game input is not instantiated by `canonical_pad_acceptance.json`.
* `Mahjong.LocalCertificateV19.Certificate` (`LocalCertificateV19.lean:13`) removes the need for a global directory/uniqueness/maximum-layer certificate, while retaining core sizes, full local SAFE checking and canonical-inventory checked proof fields. `GroupedCertificate` (line 28) adds shared-member, group and link proofs. This is a smaller logical certificate, **not a raw structure with no proof obligations**.
* `Mahjong.LocalLayerClosureV19.empty_second_player_wins` (`LocalLayerClosureV19.lean:243`) has the exact general shape:

```lean
theorem empty_second_player_wins
    (c : LocalCertificateV19.GroupedCertificate)
    (data : Nat → SuccessorCache.Data)
    (family : Family) (channels : GroupChannelV19.Channels)
    (choose : Nat → Nat → Nat → Nat → Nat)
    (depth : Nat) (root : Root)
    (accepted : checkAll c data family channels choose depth root = true) :
    SecondPlayerWins Step Win empty
```

Its checks cover exact successors, all required global channels, finite layer recurrence ending at an empty bank, and physical root identity plus P bit. It internally derives next-layer correctness and needs no `TargetCorrect` assumption. Nevertheless, the local certificate and actual accepted finite family remain uninstantiated. `local_layer_closure_acceptance.json` explicitly has `actual_local_certificate_instantiated = false`, `actual_root_DAG_instantiated = false`, and `actual_empty_game_verified = false`.

* `Mahjong.LocalBisimulationV19.strategy_same_class` (`LocalBisimulationV19.lean:134`) requires a finite checker ensuring both observation equality and matching **actual successor class sets**. Static profiles alone remain insufficient. The generic prototype and toy counterexamples are not a new proven whole-game quotient.

Selected retained component measurements (all scoped, not whole-program speedups):

| Experiment | Same numerical obligation | Retained evidence |
|---|---|---|
| 28-block no-let PN rewrite | kernel type-checking 2.15382 → 0.44837 s, about 4.804×; 265 arbitrary-input channel equalities; 1234 preparation equalities | `cartesian_nolet_full28_v19/final_14c8065e8c6d4eac898b7c854e25db2a/ACCEPTANCE.json` |
| B00 cached-layout masks | 0.0815 → 0.0234 s, about 3.483×; 10 raw words; 31 numerical equalities; 21 arbitrary-input equalities | `cartesian_cached_layout_v19/final_dd533cd0d0e94c82bb860a021fba32a3/ACCEPTANCE.json` |
| Actual partial canonical inventory | 64 numeric raw rows starting at 20000 and 64 member rows starting at zero; original type checking 2.26 → 0.217 s, about 10.415×; generic three-numeric-suit lifting | `canonical_inventory_v19/summary.json` |

These paths are under `runs/lean_table_checker/acceleration_20261018_v19/`. The canonical inventory report expressly does not certify whole input files or full `LocalCertificate`; the three numeric suits are derived from shared data, not three independently captured samples. Byte compression, grammar round trips, mmap/backing-store experiments and selected strategy-DAG sharing are also retained, but they establish neither semantic recurrence nor a global proof-size bound. The observed sparse prefix stopped at its work limit in layer 10; an unfinished layer is not a closed strategy certificate.

## 5. The completed 19 October numerical pilot

Primary receipt: `runs/lean_table_checker/kernel_exploration_20261019/packed_05/REPORT.json`; supporting `receipts.json`, `certificate_manifest.json`, and `logs/`. This supersedes earlier incomplete attempts only for the same fixed numerical sample.

The archive's root is `Mahjong.FreshPackedEvidenceV19.pn`, at `mahjong_kernel_pilots/packed/source/Mahjong/FreshPackedEvidenceV19.lean:144`. Its conclusion is the conjunction, for `B00` through `B27`, of:

```lean
Mahjong.NoletFullPNB00V19.checks = true ∧
-- ... the same equality for B01 through B26 ...
Mahjong.NoletFullPNB27V19.checks = true
```

Each block's `checks` is the conjunction of two concrete Nat-bit equations. For B00 (`NoletFullPNB00V19.lean:49–50`), writing its supplied source word as `P`, numerically constructed channel union as `R`, and its supplied valid-coordinate mask as `M`:

```text
(P AND R) = 0
(P OR R) = M
```

These prove disjointness and exact complementary coverage of the two **numerical** bit sets. They are appropriate recurrence equations only after the channels are proved to represent every required actual SAFE successor and to read the actual correct target values. The complete actual SAFE/target-lookup certificates and original-game assembly are absent here. `saved_PN_proof = true` therefore must not be paraphrased as a million original-game P/N states being certified.

Other imported proofs include 1234 concrete layout equalities, 601 arbitrary-input layout-function equivalences, and 265 arbitrary-input no-let channel equivalences. For example, archive `packed/source/Mahjong/FullLayoutEquivalence000V19.lean:15` proves, for every `input : Nat`,

```lean
Mahjong.FullLayoutFunctions000V19.pad0 input =
  Mahjong.CartesianMathV19.pad 7 47 100 3 6 7 input
```

The theorem `Mahjong.NoletFullExact00V19.all_inputs0` (line 15 of the corresponding archive source) proves equality between the optimised and original channel functions for arbitrary `width input : Nat`. `Mahjong.FullLayoutNumericB00V19.every_layout_and_valid_mask` (line 17) proves the specific supplied layout equalities, including the specific mask. These are stronger than external numerical tests, but their mathematical meanings remain layout/channel equalities.

| Quantity | Recorded value and scope |
|---|---:|
| Fixed blocks / raw words | 28 / 402 |
| Sample colex rows / Cartesian coordinates | 1035129 / 1077270 |
| Mathematical import closure | 273 project modules |
| Closure composition, independently reconstructed | 233 mathematical source modules plus 40 generated data modules |
| Saved project certificate bytes | 134862920, excluding standard toolchain; 819 files including `.olean.private` and `.olean.server` companions |
| Whole bounded construction/replay experiment | 132.205101013 s |
| Final single fresh replay | 61.828391958 s |
| Final replay sampled process peak RSS | 737734656 B |
| Real source-label flip | Rejected, return code 1 |

Data emission uses a native, untrusted expression builder, but the resulting Nat declarations are kernel-checked and the builder/plugin is absent from the final replay environment. The driver invokes ordinary Lean with `--trust=0`, `-Ddebug.skipKernelTC=false` and no `native_decide`. It copies only successful mathematical/data modules to a fresh replay directory, removes source/raw-input/plugin dependence, and verifies that module bytes do not change during replay (`build/lean_table_checker/kernel_exploration_20261019/run_packed.py:240–255`). The final target is replayed with the standard `leanchecker --fresh`, not a custom faster checker.

The root `pn` axiom output is `[propext]`. The successful build logs contain 923 printed axiom observations, all subsets of the three standard axioms; no successful log contains `sorryAx` or an unfinished-proof warning. This count is an observation count, not a new theorem count.

## 6. Game variants, failed experiments and cost interpretation

`game_01/REPORT.json` compares the same game statements, same 11 physical nodes and same three named roots:

| Variant | Construction wall sum | Fresh replay | Replay sampled RSS | Project certificate bytes |
|---|---:|---:|---:|---:|
| Baseline | 20.348072786 s | 128.852179959 s | 1383059456 B | 6115880 |
| Direct Boolean reflexivity | 34.211590039 s | 140.992511805 s | 1382977536 B | 6110768 |
| Init-only foundation import | 31.133564617 s | 114.600500291 s | 1066545152 B | 6146624 |

The last row is from `game_slim_01/REPORT.json`. It rebuilds all 24 project modules. The two other variants each rebuild 11 pilot modules and retain a 24-module mathematical closure. The import-only fork retains rule definitions, theorem statements and proofs; it is isolated from the frozen V17 rules. The same actual SAFE-flip negative control is rejected. These are single observations with different import/rebuild scope, not a controlled global speedup estimate. In particular, direct reflexivity was slower in this test.

The copied game certificate manifests list `.olean` files, whereas the packed certificate totals include private/server companions. These reported storage totals should retain their stated scope rather than be treated as directly comparable minimal-certificate sizes.

Retained failures are informative, not achievements:

* Earlier packed attempts `packed_03` and `packed_04` have explicit `FAILURE.json`; only `packed_05` is the completed fixed-sample result.
* `packed_maskfacts_01` failed; `_02` was aborted for slow elaboration; `_03` for slow simplifier expansion; `_04` reached the bounded time/memory-reserve guard on a generic-equivalence worker. No accepted new full proof is recorded for these branches. All proposed individual mask equalities being checkable does not establish successful composition or an improved runtime.
* The intentional wrong-label log prints a type mismatch for `Eq.refl true`, then an error-recovery `sorryAx` fingerprint, and exits 1. That failed declaration/environment is not shipped in any successful lane. Negative source fixtures are retained intentionally; an indiscriminate grep across failed logs would mischaracterise the accepted proof boundary.

The separate `profile_packed_01/REPORT.json` profiles the same 56 numeric theorem modules: PN type checking 0.28994 s plus layout 0.96696 s, total 1.25690 s. The complete profiling invocation takes 6.6928909 s. Dividing sample rows by type-checking time gives 823557.164 colex rows per kernel type-checking second **for those components only**. Mechanical scaling to all rows gives 262.5915 core-hours per pass, or 32.82394 h at ideal eight-way division. This is neither an end-to-end prediction nor a lower/upper bound: geometry is selected, global reuse is unmeasured, actual SAFE/local checks, actual addressing/completeness, generation, loading, serialisation and general-proof cost are excluded. Construction and replay both perform checking. The final single-fresh replay is serial and must not simply be divided by eight. No 20-hour pure-kernel completion bound has been established.

## 7. Persistence, portability and trust

The optional saved-proof archive is `runs/lean_table_checker/portable_repro_20261019/package_02/deliverables/mahjong_kernel_pilots.tar.zst`, 21136243 B. `kernel_share_cold_01/REPORT.json` records independent extraction and successful fresh replay of all three lanes, with no input/source generation during replay:

| Lane | Fresh replay wall time | Sampled process peak RSS |
|---|---:|---:|
| packed | 88.751290352 s | 785555456 B |
| game | 176.809048323 s | 1382748160 B |
| game-slim | 127.461217625 s | 1068597248 B |

The parallel share experiment totals 179.227892366 s. Resource contention prevents direct speedup comparison with the isolated measurements. It ran on the same physical Linux/WSL host in new directories, not a second machine. Exact Linux x86_64 Lean 4.33.1 is supplied in the companion V17 core archive. These saved-proof lanes need neither global input tables nor a game Native worker/GPU/plugin for replay.

The standard Lean kernel remains the checker; “fresh” means importing/replaying the declaration closure into a fresh environment, not an independent implementation of type theory. Mathematical axioms in accepted targets are only subsets of `propext`, `Classical.choice`, and `Quot.sound`. Parsing/loading, operating system and hardware remain part of the practical trust boundary. Human correspondence between `Rules.lean` and the intended game also remains a specification issue.

In this installed Lean 4.33.1, `native_decide` generates an extra computed-result axiom. `--trust=0` does not turn that axiom into a reduction proof. Likewise, `leanchecker --fresh` alone does not reject all arbitrary axioms: axiom inventory matters in addition to replay. The accepted strict-kernel lanes avoid that route. Directly inspected implementation evidence, under `build/toolchain/lean-4.33.1-windows/src/lean/`, is `Lean/Meta/Native.lean:32–35,76–82` (computed-result axiom), `Lean/Replay.lean:98–99` (replaying an axiom declaration) and `LeanChecker.lean:36–38` (fresh-environment replay).

The 19 October core portability receipt separately records 149 source project modules, generic source/kernel replay in 108.355777852 s, a fresh native rebuild, real positive/negative controls on a 56-row bucket, and audit of the old full execution. It explicitly says its kernel scope is frozen implication/generic checker correctness, not a saved actual full-input acceptance theorem. Its complete 1948.532424056 s cold test is not a new full-table proof run. The full input archive was independently decompressed/hashed in the original test (11272 files, 100615834170 B); that data-integrity operation recomputed zero game rows. It has not been validated on another physical machine or different toolchain.

The full original native run now supplies important evidence beyond the September baseline: the retained delivery reports all 778532864302 rows, 17317 frames, 3686 nonempty buckets and 27303.9915 s. Its claim is **kernel implication plus compiled finite evaluation and trusted IO/finalisation**, not a pure-kernel closing of the actual whole input. These native figures should be tied to the main task's separate full-execution audit before publication; they are not newly independently replayed by this memo.

Recommended forward milestone: instantiate a concrete packed block with actual local SAFE certificates, complete actual target addressing, and already closed target strategies; derive its original-game strategy; then measure aggregate saved-proof replay and memory across representative blocks. That would connect the two currently separate achievements—fast numerical components and small closed physical strategies—before a defensible whole-opening resource estimate.

## 8. Read-only identity checks and important hashes

This audit independently performed:

* V17: 68 current identity checks covering all 13 new source files, their successful compilation receipts, saved modules and stdout/stderr, plus the final replay receipt/logs; zero mismatches.
* V17: all 145 saved project modules named by the final replay receipt rehashed against that receipt; zero mismatches.
* Pure-kernel archive: current archive SHA-256 matched the recorded value; all 1679 manifested payload members were streamed from the archive and individually hashed, with zero mismatches. Including its manifest, 1680 records totalled 331316957 uncompressed bytes. No extraction or source modification was required.
* Archive manifest versus the three independently saved certificate manifests: exact matches for packed 819 files / 134862920 B, game 24 files / 6115880 B, and game-slim 24 files / 6146624 B.
* Reconstructed project import closures: packed 273 modules (233 source + 40 generated data); game and game-slim 24 source modules each. No active `sorry`, `native_decide`, custom `axiom`, `unsafe` or `partial` declarations were found in those reachable mathematical source closures. Untrusted builder sources and intentional negative fixtures are outside these replay closures.
* Successful-log axiom observations: packed 923, game baseline 25, game-slim 67; all standard subsets and no successful unfinished-proof markers. There were 239 successful packed command receipts plus one intentionally rejected label flip; baseline game 12 successful plus one rejected SAFE flip; game-slim 25 successful plus one rejected SAFE flip.

These are identity/static/receipt checks, not a newly executed Lean verification, and they do not inspect every kernel-internal declaration in generated data modules independently of the retained fresh replay.

| Item | SHA-256 |
|---|---|
| V17 `PROOF_STATUS.json` | `c32c34c2941836a203cb2909c51ca3680da375d1104e183eb00a48b92fc9b4e9` |
| V17 final replay receipt | `1c0e225773a9589f8f90296f4bdd0a171598183981013f5a6f629974613664fa` |
| `FastWholeInputV17.lean` | `0e1108a2b0433b83f693e0648ac45448455abf6df222b53a835925c2c49ef08d` |
| `FiniteWholeInputV17.lean` | `aa131c488ffd3c9073dd87b93537aeb5b52ba872b3e9f33525c76f9725c04b47` |
| V18 `PILOT_STATUS.json` | `4402bee8f02d720e84b70fc224ae5ee793aec00f5d5e614e8168f4bd0f5b530b` |
| `PilotActualGameV18.lean` | `9ba8d33a9e86a06c9717c7af9f668523a9cf5f2f09763ecd7c6ae0846edfed39` |
| `PilotActualDataV18.lean` | `cdcd54e55cbb758e779eee31ea208b4e4ccac6cc011d0097f0d2a4fc779e4b92` |
| `LocalLayerClosureV19.lean` | `5e584e4ad5a6ed1cc5e1a721c6414e42a8c9a4a62a183d888f840d37d7913643` |
| `LocalCertificateV19.lean` | `171ec017b89ccb54bd3e88f949e1611116fdaa5bb89d42a3c7cbaefee6d0ea2e` |
| `packed_05/REPORT.json` | `57043889402740d65d9cf4e21e589d39bcb66ac46b2a1c6bd905fe34b884b721` |
| `packed_05/certificate_manifest.json` | `853df813fee7d42c89334a8358b0084ca8cdf3a9030b7d7f633e7049a4d60d97` |
| Archived `packed/source/Mahjong/FreshPackedEvidenceV19.lean` | `14076f35a248cd3be994b58a58778493b4471b17a3f2f527a6da12eef3aaa6ab` |
| `game_01/REPORT.json` | `2f687d52441dc9314bcc2a0ce3ca02c766cb63517b49967748d9feabdcbc31f3` |
| `game_slim_01/REPORT.json` | `3b4b1f6161542533cadddfa5991fc840a9aa2663a9634101bc852230422a9830` |
| `profile_packed_01/REPORT.json` | `73e7107a27bbf5ac3b64c553635597305c4325cf720574c93719871e32b3d0ac` |
| `kernel_share_cold_01/REPORT.json` | `537839a925a28b73e429d4bb6f3cf67344f8b99be92f76fe111b1cc2fe7df8f6` |
| `mahjong_kernel_pilots.tar.zst` | `e4bbdc9c00f1c3c40434f8d00893ca347a69519fda25772712533d141129d5dc` |
| Portable `DELIVERY_FINAL.json` | `37874428ab32a5ead2249a7327c2625f3f7b42b5e79e028bbbf55cb5b895d4e9` |
| Portable `deliverables/VALIDATION_REPORT.json` | `4009d3d8018fba4229c1a1cae52ff89292fd8eaadbf999d28c77b66433ecd206` |

The archive README supplies explicit integrity/replay/rebuild commands. They were inspected but **not run in this audit**. Integrity checks do not prove theorem statements; the retained successful source checks, exact-type declarations, axiom observations and fresh replay receipts supply the corresponding formal evidence.
