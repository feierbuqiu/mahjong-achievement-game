# Independent Review: V17 Compiled-Lean Verification of the Mahjong Achievement Game Opening

| | |
|---|---|
| Reviewer | Claude (Anthropic), model `claude-opus-5-5`, acting as an independent, read-only reviewer at the project owner's request |
| Review passes | Three on 2026-10-18 (before the run), one on 2026-10-19 (after the run) |
| Subject | The completed run `runs/lean_table_checker/v17_compute_finish_20261018/full_native_20261018_02` and the Lean development it relies on |
| Document date | 2026-10-19 |
| Path convention | All paths are relative to the research root (`mahjong_research/`) |

**Independence statement.** The reviewer did not write the project's Lean proofs, native worker, controller or finalizer, and did not change any project file. This document is the only file the reviewer added to the research tree. One exception should be noted: the owner started a side session from one of the reviewer's proposals and then stopped it. That session left the empty directory `build/lean_table_checker/composition_v17/`, which contains no files.

All checks described here were read-only. The reviewer did not re-run Lean, `leanchecker`, the native worker or the GPU code. Kernel and build evidence was assessed from the recorded receipts and logs.

---

## 1. Verdict

1. **The run followed the frozen V17 plan.** A native executable compiled from the frozen V17 Lean sources checked every one of the 778,532,864,302 SAFE-orbit positions in layers 0–34, across all 3,686 non-empty buckets. No earlier results or seeds were imported. The empty position's stored label is **P (second player wins)**, and that label was accepted.
2. **No defect was found.** The reviewer found no defect in the proof chain, the worker, the finalizer or the recorded evidence. The reviewer also re-verified the ledger with a script written independently of the project's finalizer; it found **0 problems** (Section 5.3).
3. **Evidence level.** The result is supported at the level of a **kernel-proved implication plus native evaluation**. It is **not** a closed Lean declaration about the actual table. It should not be described as "formally verified in Lean" without qualification.
4. **Where the remaining doubt lies.** It is concentrated in two places:
   - faithful execution by a single compiler, runtime, operating system and hardware stack, which has not yet been independently replicated;
   - the Python bookkeeping that drives the worker and assembles its records.

   The reviewer recommends an independent replication before final publication (Section 8.1).

### Statement the evidence supports (recommended public wording)

> The Lean kernel proves that if six finite Boolean checks all evaluate to true, then the second player wins from the empty table (`SecondPlayerWins Step Win empty`). The same check functions, compiled to native code, were evaluated on the complete actual input (layers 0–34, all 778,532,864,302 SAFE positions up to symmetry) and all returned true. Trust boundary: the Lean kernel and its three standard axioms; the formal statement of the rules (`Rules.lean`); the Lean compiler, runtime, operating system and hardware; and the run's bookkeeping code.

### Statements the evidence does not support

- "Lean has proved that the second player wins" (without qualification).
- "Fully formally verified" or "machine-checked end to end".
- Any claim that the result has been independently replicated.

---

## 2. What was computed

| Item | Value |
|---|---|
| Final record | `runs/lean_table_checker/v17_compute_finish_20261018/full_native_20261018_02/FINAL.json` |
| Final status | `COMPLETE_FIXED_V17_NATIVE_COMPUTATION` |
| Claim class | `FIXED_V17_KERNEL_IMPLICATION_PLUS_NATIVE_COMPUTATION` (`closed_actual_input_Lean_declaration: false`) |
| Positions checked | 778,532,864,302 (layers 0–34, all rows) |
| P / N rows | 203,051,492,021 / 575,481,372,281 |
| Buckets | 3,686 non-empty of 6,440 cells (2,754 empty) |
| Frames | 17,317, in a hash-chained ledger |
| Old PASS records or seeds imported | None |
| Root (layer 0, bucket 0) | Root check accepted; root frame has P = 1, N = 0 |
| Execution | One uninterrupted native session (`032a785eb75940aba28b930fdf0e026e`) |
| Production wall time | 7.593 h (27,333 s). Base checks took 528 s, successor checks 1.6 s |
| Completed | 2026-10-18T17:56:53Z |
| Inputs | 11,272 files, 100,615,834,170 bytes; identity hash identical before and after the run |

The P/N counts equal those of the September 2026 C++ computation. This is expected rather than independent evidence: the checker verifies the stored historical labels. The equality does confirm that every row was counted.

An earlier attempt, `full_native_20261018_01`, stopped before committing any game frame: a GPU resource declaration failed a validator. Run `_02` is the only production run.

---

## 3. The claim and its trust boundary

### 3.1 The theorem

- **Name and location.** `Mahjong.FastWholeInputV17.from_finite_input`, in `build/lean_table_checker/end_to_end_v17/source/Mahjong/FastWholeInputV17.lean`, line 153. The reference form is `Mahjong.FiniteWholeInputV17.accepted_sound`, in `FiniteWholeInputV17.lean`, line 153.
- **Conclusion.** `SecondPlayerWins Step Win empty`, about the original game and the original empty state.
  - `Step` and `Win` come from `Rules.lean`: 34 tile kinds with four copies each, a shared table, and a win when the table contains a legal 14-tile sub-multiset (four melds plus a pair, seven pairs of distinct kinds, or thirteen orphans).
  - `SecondPlayerWins` means: for every legal first move, the second player has a winning strategy, and every leaf of that strategy is an actual legal win.
- **Hypotheses.** Only acceptance equations of finite Boolean checks on raw input bytes. There is no `TargetCorrect`, `NormalStrategy`, `Certificate`, row-correctness or strategy hypothesis.
- **Axioms.** Only `propext`, `Classical.choice` and `Quot.sound`.

### 3.2 The six acceptance families and where each was evaluated

| # | Family | Lean function(s) | Where the worker evaluates it | Evidence |
|---|---|---|---|---|
| 1 | Base finite data: local caches, inventories, groups, layer bounds, triple and honor directories, layout, word limits | `FiniteCertificateV17.checks` | `V17NativeWorker.checkBase`, once per session, before any bucket | `native_base_checked.json`, `GLOBAL_READY` |
| 2 | Successor lists | `FiniteMetadataV17.checkSuccessors` | `checkEdges`, once per session | same |
| 3 | Per-bucket metadata | `checkSource`, `checkBank`, `GroupNextCoverage.check` | `openBucket`, for each of the 3,686 buckets | `BUCKET_READY` with `metadataChecked` |
| 4 | Frames and exact bucket cover | `RuntimeScanV17.prepare`, `scanFragment`, `assembleScanned`; `ScanFinalV17.checkRanges` | `scanFrame`, then bucket close | frame results written by the native process itself, plus ledger contiguity |
| 5 | Cross-layer target identity | `CrossLayerAssemblyV17.checkTargets` (`sameBucket`) | in-process `checkTargetSources`, plus the finalizer's seven-field identity comparison | `BUCKET_READY` with `targetIdentity`; frame receipts |
| 6 | Root decodes to the empty table, with P bit | `EmptyRootV17.checkP` | `openActual`, for bucket (0,0) | `rootChecked`; root frame P = 1 |

### 3.3 Trust boundary

Inside the boundary (must be trusted):

1. The Lean kernel and its three standard axioms.
2. `Rules.lean` faithfully formalizes the intended game. This is a human judgment; the reviewer compared it with `RESEARCH_HANDOFF.md`.
3. The execution stack: the Lean compiler (Lean to C), clang, the Lean runtime (including GMP and the task scheduler), Linux/WSL, Windows, CPU, memory and storage.
4. The planning and runtime bookkeeping code in `build/lean_table_checker/v17_compute_finish_20261018/ops/`: `plan_run.py`, `controller.py`, `service.py`, `fused_worker.py`, `common.py`, `runtime_identity.py`, `hash_inputs.py`, `recover.py` and `finalize.py`, 1,582 lines of Python in total. It builds the all-layer inventory, schedules buckets, supplies proposals, records native events, hashes inputs and checks coverage. The other files in `ops/` are not part of the soundness argument: `rules_v17.py` sets the GPU resource policy (the GPU path is untrusted), `freeze_ops.py` freezes identities, and `native_controls.py`, `test_bookkeeper.py` and `test_transport.py` are control and test harnesses (1,094 lines).

Outside the boundary (errors here cause a rejection, never a false pass):

- the C++ solver and its table, whose labels are checked rather than assumed;
- the GPU proposal generator;
- the index and catalog generators;
- all historical PASS records.

---

## 4. The evidence chain, link by link

| Link | Status | Basis | Reviewer verification |
|---|---|---|---|
| Rules match the intended game | Accepted | `Rules.lean` | Compared by hand with `RESEARCH_HANDOFF.md` (pass 1) |
| Rules → SAFE reduction → symmetry → per-row checker → cross-layer induction → root is the empty table → `SecondPlayerWins` | Kernel-proved | V17 modules and their 132 base modules | Source read (pass 2); recorded `leanchecker --fresh` replays; axiom output |
| The native program computes the theorem's functions | Supported | `V17NativeWorker.lean`, `V17ComputeMain.lean` (757 lines of Lean) | Line-by-line source review (pass 4); compiled sources byte-identical to the frozen V17 sources |
| The six families are true on the actual input | Executed | Native records and ledger | Independent ledger re-verification (Section 5.3) |
| All buckets and frames combine into one whole input | Executed (bookkeeping) | `finalize.py` (213 lines) plus the other `ops/` code | `finalize.py` reviewed line by line; independent re-verification (Section 5.3) |
| Inputs unchanged during the run | Supported | Hash map before and after, with continuous read locks | Maps compared; 62 files re-hashed now (Section 5.3) |

---

## 5. Reviewer's checks on the completed run

### 5.1 Source review of the native adapter

Files reviewed: `build/lean_table_checker/v17_compute_finish_20261018/source/Mahjong/V17NativeWorker.lean` (252 lines, SHA-256 `dadc7224…`) and `source/V17ComputeMain.lean` (505 lines, SHA-256 `19b87459…`).

**Calls frozen functions only.** All accepting computation goes through the frozen V17 functions listed in Section 3.2. The adapter contains no re-implementation of any check.

**Untrusted proposals are re-checked.** The V16 coverage producer, target proposals, block-run proposals and GPU bytes are used only as proposals. A V17 function re-checks each of them.

**Fails closed.** In production (`serve`) mode, any rejection raises an error and ends the process. Exceptions are caught only in the bounded `controls` mode, which is limited to layer 32, bucket 89 and at most 56 rows.

**Control flow implies the earlier families.** The base and successor checks finish before any bucket is served. A bucket is scanned only after `openBucket`, the in-process target-identity check and (for bucket (0,0)) the root check have all succeeded. So, by the reviewed control flow, a PASS frame result written by the native process implies that families 1–3 and 6 passed in that process, together with the in-process part of family 5.

**Frame results come from the native process.** Each per-frame PASS result is written by the native process itself (`scanFrame` writes the output file), not by Python.

**Whole-table assembly is external.** `finishWhole`, the typed in-process whole-table route, is not used. This is expected, because the full table does not fit in one process.

**In-process target identity is a self-comparison.** It compares the loaded target with a second load of the same file, because the target and source roots are the same paths. Cross-layer identity therefore rests on file immutability and hash binding, which Section 5.3 verifies. The `target_identity_mismatch` control shows the comparison is not vacuous when the files differ.

### 5.2 Build and replay evidence (assessed from records)

- **Recompilation.** The 11 V17 modules compiled into the executable were rebuilt on Linux from sources byte-identical to the frozen V17 sources, with flags `--trust=0 -Ddebug.skipKernelTC=false`. Every printed theorem depends only on the three standard axioms.
- **Linux replay.** `leanchecker --fresh` was run on `V17ComputeReplay`, a module that imports 145 modules, including `V17NativeWorker` and `V17ComputeMain`, and prints the axioms of `from_finite_input`. It returned 0.
- **Windows replay (pass 2).** The 132 base `.olean` files were confirmed byte-identical to those of the V16 build. A `leanchecker --fresh` replay of 145 modules on Windows returned 0 in 123 s.
- **Source sweep.** The V17 and adapter sources contain no `sorry`, `admit`, `axiom`, `native_decide`, `implemented_by`, `extern`, `unsafe` or `partial`.

### 5.3 Independent ledger re-verification

The reviewer wrote a separate read-only script, reproduced in Appendix B, that does not use the project's `finalize.py`. Results:

| Check | Result |
|---|---|
| Ledger hash chain (17,317 entries; sequence, previous-hash link, manifest hash) | Intact |
| Every frame receipt and native result file matches its recorded hash | 17,317 of 17,317 |
| Receipt status, executable hash, extent and P + N = count | All consistent |
| Exact contiguous cover of every non-empty bucket, from row 0 to its size | 3,686 of 3,686 |
| Total rows; P; N | 778,532,864,302; 203,051,492,021; 575,481,372,281 |
| Each cross-layer target identity equals that child bucket's own source identity | 54,548 references, 0 mismatches |
| Root bit read directly from `runs/global_retro/pilot_v1/data/n00_h000.bits` | 1 (P); file hash matches the input map |
| Post-run input identity map equals the pre-run map | Yes |
| Input files re-hashed by the reviewer (seeded sample of 62 files, 81,370,822 bytes) | 0 mismatches |
| Problems found | **0** |

### 5.4 Negative and positive controls

Six controls were run on the production executable (SHA-256 `775e05d2…`), in `runs/lean_table_checker/v17_compute_finish_20261018/native_controls_1060_v2/`:

- the positive full-bucket case was accepted;
- `source_bit_flip`, `deleted_last_row`, `target_identity_mismatch`, `truncated_source_bits` and `catalog_honor_mismatch` were all rejected, each for its registered cause. For example, the flipped label was rejected by the V17 row scan (`fragment_cover_source_address_or_indexed_row_rejected`), and the swapped target by `actual next-layer byte identity rejected`.

The project also reports 36 mocked transport cases and 22 bookkeeping cases. These are not process-crash experiments.

### 5.5 Input custody

All 11,272 input files (100.6 GB) were hashed before the run and held under continuous read locks. The post-run identity map is identical to the pre-run map. The native process read exactly the paths listed in the plan: the roots in `native_config.json` match the plan configuration, and no separate target data root was configured.

---

## 6. Findings and residual risks (ranked)

| # | Severity | Finding | Consequence or mitigation |
|---|---|---|---|
| F1 | Medium | **No independent replication.** All execution evidence comes from one machine and one toolchain build. | This is the main remaining doubt, and the cheapest to reduce (Section 8.1). |
| F2 | Low–Medium | **Most bookkeeping code was not reviewed.** Of the 1,582 lines of trusted planning and runtime bookkeeping (Section 3.3), only `finalize.py` (213 lines) was reviewed line by line. `plan_run.py`, `controller.py`, `service.py`, `fused_worker.py`, `common.py`, `runtime_identity.py`, `hash_inputs.py` and `recover.py` were not. | Mitigated: frame PASS results are written by the native process itself; the reviewed control flow ties them to the earlier families; and the independent re-verification checks the records for consistency. It cannot prove that the records reproduce every native output exactly. |
| F3 | Low | **In-process target identity is a self-comparison.** | Cross-layer identity rests on fixed paths, immutable files and the hash map. Verified; see Sections 5.3 and 5.5. |
| F4 | Low | **No real kill-and-resume experiment with this worker.** | Not relevant to this run, which was a single uninterrupted session. It matters only if a future run relies on resumption. |
| F5 | Process | **The stage-by-stage review gates were skipped.** The owner granted continuous authorization, so the stage gates in `SCOPE.json` were bypassed. | The post-hoc review found no deviation from the plan. The skip should be recorded in the project history. |
| F6 | Communication | **Public status predates the run.** The public repository (PR #10, commit `c7a0833`, 2026-10-18 19:20 +11:00) and `runs/lean_table_checker/STATUS.json` (last updated 2026-10-18 13:56 +11:00) do not yet reflect the completed run. PR #10 already removed the earlier "within 20 hours" framing and states `NOT_VERIFIED`. | When updating, distinguish the completed tier (Section 7) from the future goal of a closed kernel proof, and use the wording in Section 1. |
| F7 | Inherent | **No closed Lean declaration for the actual input.** The strict pure-kernel route (V18/V19) works on small samples, but at current measured rates it is orders of magnitude short of a practical budget. | State this explicitly. Treat the strict-kernel route as future work. |
| F8 | Inherent | **`Rules.lean` must be judged correct by a human.** | No computation can remove this. An independent human reading is recommended (Section 8.5). |

**Correction to an earlier remark.** In conversation, the reviewer described the bookkeeping as "about 230 lines of Python". In fact the finalizer alone is 213 lines, and the trusted planning and runtime bookkeeping as a whole is 1,582 lines (Section 3.3).

---

## 7. How much confidence is warranted

**The mathematical part.** Within the trust boundary, it is as reliable as any theorem checked by the Lean kernel.

**The computational part.** For it to have produced a false "pass", two things would have to happen together:
- a defect in the compiler, runtime, operating system, hardware or bookkeeping would have to turn a failing check into a passing one; and
- that defect would have to coincide with an actual error in the C++ table, so that the error is hidden.

Several things make this unlikely:
- The positive and negative controls, run on the same executable, make a vacuous or systematically broken checker unlikely.
- The independent ledger re-verification rules out the common bookkeeping failures: missing, duplicated or overlapping frames, mismatched identities, and changed inputs.
- The C++ computation and the Lean checker are independent implementations of the rules. A wrong conclusion would require them to fail together, in exactly matching ways.

In the reviewer's judgment, the conclusion that **the empty position is a second-player win is established beyond reasonable doubt for practical and scholarly purposes**, at the standard of a rigorous computer-assisted proof. It is not a fully formal proof: the final step, that the compiled program really evaluated the six checks to true on these bytes, was executed rather than proved.

### Evidence ladder

| Level | Description | Status |
|---|---|---|
| 0 | C++ retrograde computation and reverse replay (these share the rule and index code) | Done (2026-09-13) |
| 1 | Lean-proved per-row checker with informal cross-layer composition (original V16 plan) | Superseded |
| **2** | **Kernel-proved whole implication, plus native evaluation of the same functions, plus reviewed bookkeeping** | **Achieved by this run** |
| 2+ | Level 2, independently replicated on a different machine or toolchain | Recommended next step |
| 3 | Closed kernel-checked theorem for the actual input | Not achieved; no realistic timeline with current methods |

This level matches the trust model of the September 2026 "Route B" design (`lean_verification/table_checker/DESIGN.md`), which also trusted native execution at the level of `native_decide`. There is one difference: this run checks the historical labels instead of recomputing them. For soundness this makes no difference, because every label is verified against its successors and none is assumed.

---

## 8. Recommendations

### 8.1 Independent replication (highest priority)

1. **Rebuild on a different stack.** Rebuild `V17ComputeMain` from the same frozen sources, varying at least one of the following:
   - the Lean toolchain release;
   - the C compiler or its optimization level, for example `-O1` instead of `-O3`;
   - the machine, preferably one with ECC memory.

   Then run `leanchecker --fresh` on the rebuilt environment.
2. **Run a replication scope.** At minimum:
   - the base, successor and root checks;
   - every frame of layers 0–14 (about 1.38 billion rows, 864 buckets);
   - a seeded, layer-stratified random sample of at least 1–5% of all 17,317 frames.

   A full rerun is preferable if resources allow (the original took 7.6 hours).
3. **Compare frame by frame.** Compare acceptance, P/N counts and input identities. Stop and investigate on any disagreement.
4. **Keep the replication separate.** Record it as its own run directory, with its own manifest, so that it never overwrites the original evidence.

### 8.2 Reproduction package

Publish together:
- the frozen sources;
- the build scripts and toolchain identities;
- the executable hash;
- the input identity map;
- the ledger and the finalizer;
- the independent re-verification script in Appendix B;
- step-by-step instructions.

The large inputs (100.6 GB) can be published as hashes, with an access route for anyone who wishes to rerun.

### 8.3 Public communication

- Use the statement in Section 1, together with its trust boundary.
- Avoid "proved in Lean", "fully formally verified" and "end-to-end machine-checked" for the result as a whole.
- Update `runs/lean_table_checker/STATUS.json` and the public repository so that the completed tier and the open strict-kernel goal are clearly separated.

### 8.4 Bookkeeping review

Ask an independent person to review the remaining trusted bookkeeping code (`plan_run.py`, `controller.py`, `service.py`, `fused_worker.py`, `common.py`, `runtime_identity.py`, `hash_inputs.py`, `recover.py`). If a raw, hash-bound transcript of native standard output exists, reference it in the reproduction package. If it does not, keep one for future runs.

### 8.5 Rules review

Invite an independent human reading of `Rules.lean` against the game's informal definition. This is the one point of trust that no computation can remove.

### 8.6 Keep strict-kernel research separate

Keep the V18/V19 work, or any successor to it, out of the claims made for this run, and present it as future work.

### 8.7 Preserve evidence

Do not modify the completed run directory. Record this review's own hash in any package that cites it.

---

## 9. Review history

The owner was concerned that successive optimizations had gradually distorted the original proposition. The four passes show how that concern was resolved.

**Pass 1 — 2026-10-18, about 14:00 (+11:00). Planned 20-hour V16 run.**
- The per-row theorem `IndexedByteRowV16.original` was conditional on a `Certificate` and on `TargetCorrect`.
- No theorem anywhere concluded `TargetCorrect`.
- The exported row theorem dropped `IsSafe`.
- The root decoding and the whole-table composition were done in Python.
- The chain spanned at least five checker builds.
- The inherited `.olean` files had never been replayed.
- Verdict: even a complete V16 pass would not have yielded an end-to-end Lean theorem. The original proposition had drifted at the last step.

**Pass 2 — about 15:15. V17 proof layer.**
- V17 restored a single closed implication: `TargetCorrect` is produced by downward induction over 35 layers and 184 buckets with byte-identical cross-layer checks; `IsSafe` is kept; the root decoding is proved in Lean; and the `Certificate` is constructed from raw bytes.
- `leanchecker --fresh` replayed 145 modules, and the replayed `.olean` files were byte-identical to the V16 build.
- Remaining issue: V17 was not yet wired into any native worker, so the planned V16 run could not instantiate it.

**Pass 3 — about 19:00. Strict pure-kernel research (V18/V19).**
- The approach works on small actual samples: 56 rows, and 11 original-game nodes.
- Measured rates were far from a 20-hour budget. V18 checked about 4.5 rows per second. The best V19 figures were about 1.5 million Cartesian coordinates per second in exclusive kernel time (PN arithmetic only), and about 93,000 per second in cold replay.
- The table has 60.8 million blocks, and a single literal layout is 257.6 GB.
- Verdict: no end-to-end strict-kernel verification within 20 hours on current evidence.

**Pass 4 — 2026-10-19. Completed V17 native run (this document).**
- The run used exactly the V17 implication, re-checked all 35 layers with one executable, and imported no seeds.
- The final claim is therefore not weaker than the original objective, apart from the explicitly stated native-evaluation step.

---

## 10. Scope and limitations of this review

- **Not re-executed.** The reviewer did not re-run Lean, `leanchecker`, the native worker or the GPU code. The build and replay results come from recorded receipts.
- **Not fully re-hashed.** The reviewer did not re-hash all 100.6 GB of inputs; a seeded sample of 62 files was re-hashed.
- **Not reviewed.**
  - The GPU proposal code: it is untrusted, and it is irrelevant to soundness provided the checks are sound.
  - The Python bookkeeping files other than `finalize.py`.
- **Not inspected beyond the records.** The Linux build environment was not inspected beyond its records.
- **Owner's decisions.** The owner's acceptance of native evaluation, and the owner's continuous authorization that skipped the stage gates, were the owner's decisions. This review evaluates the evidence under those decisions.

---

## Appendix A. Key artifacts and hashes

| Artifact | Path | SHA-256 |
|---|---|---|
| Final record | `runs/lean_table_checker/v17_compute_finish_20261018/full_native_20261018_02/FINAL.json` | `413ced59dcfcc2825f6b17503e8690f895b6d9f0219ddb2eb4ce43cf992c957e` |
| Ledger (17,317 entries; 10,793,673 bytes) | `…/full_native_20261018_02/ledger.jsonl` | `255d3bf5fd74208bcac6d8b68b6804a52d4c1661b5afc2789994a8b270c12f4d` |
| Run manifest | `…/full_native_20261018_02/MANIFEST.json` | `bf46a286a78e7f1c8ba62611ac841c89e463542589acb443e15e53d9b66b76ed` |
| Input identity map digest | recorded in `MANIFEST.json` | `5e490342168211a9c0e3c1974bbe85a342d00a857a0019260b2e53e31113ccd6` |
| Native executable (121,190,888 bytes) | `build/lean_table_checker/v17_compute_finish_20261018/native/1060b5998a014be594e54ba64d3671d5/V17ComputeMain` | `775e05d2601e30847b14b017cb542ea23a8b629d8ebd403aa07bd5942b78f667` |
| Theorem source | `build/lean_table_checker/end_to_end_v17/source/Mahjong/FastWholeInputV17.lean` | `0e1108a2b0433b83f693e0648ac45448455abf6df222b53a835925c2c49ef08d` |
| Adapter | `build/lean_table_checker/v17_compute_finish_20261018/source/Mahjong/V17NativeWorker.lean` | `dadc722410875249f7d308c71c16ee7d1c71ebeb3e3fa3b9b078f63c9c02d6cb` |
| Native entry | `build/lean_table_checker/v17_compute_finish_20261018/source/V17ComputeMain.lean` | `19b87459bb70cf264089986a1d92f2e06757ad6c66f1674eadacf5fb12eee9ac` |
| Finalizer (213 lines) | `build/lean_table_checker/v17_compute_finish_20261018/ops/finalize.py` | `61adfc6d64c734cf2c30d16a3d1649e08c72c78e652a8f0f08798380885d6f41` |

## Appendix B. Independent re-verification script and its output

The script is read-only, uses only the Python standard library, and writes nothing inside the research tree. Run it with the research root as its single argument:

```text
python -I independent_ledger_check.py "<path to mahjong_research>"
```

Output on 2026-10-19:

```text
ledger entries: 17317 | native results checked: 17317
complete nonempty buckets: 3686 / 3686
rows: 778532864302  P: 203051492021  N: 575481372281
cross-layer target references checked: 54548 mismatches: 0
root bit: 1 (1 = P) | root frames: 1
input files re-hashed now: 62 | mismatches: 0 | bytes re-hashed: 81370822
problems: 0
```

```python
"""Independent read-only re-verification of the V17 production ledger.

Written separately from the project's finalize.py. Reads records only; writes nothing
inside the research tree.
"""
import hashlib, json, os, random, sys, collections

ROOT = sys.argv[1]
os.chdir(ROOT)
RUN = "runs/lean_table_checker/v17_compute_finish_20261018/full_native_20261018_02/"
NATIVE_SHA = "775e05d2601e30847b14b017cb542ea23a8b629d8ebd403aa07bd5942b78f667"

def sha_file(p):
    h = hashlib.sha256()
    with open(p, "rb") as f:
        for chunk in iter(lambda: f.read(1 << 20), b""):
            h.update(chunk)
    return h.hexdigest()

def load(p):
    with open(p, encoding="utf8") as f:
        return json.load(f)

problems = []
def need(cond, msg):
    if not cond:
        problems.append(msg)

manifest_sha = sha_file(RUN + "MANIFEST.json")
manifest = load(RUN + "MANIFEST.json")
plan = load(RUN + "PLAN.json")
inputs_before = manifest["inputs_before"]
need(sha_file(manifest["native"]["path"]) == NATIVE_SHA, "native executable hash differs now")

cells = {(c["layer"], c["honor"]): c for c in plan["cells"]}
nonempty = {k for k, c in cells.items() if c["size"] > 0}
need(len(cells) == 6440 and len(nonempty) == 3686, "plan cell counts")
need(sum(cells[k]["size"] for k in nonempty) == 778532864302, "plan total rows")

# 1. ledger hash chain
entries = [json.loads(line) for line in open(RUN + "ledger.jsonl", encoding="utf8")]
prev = "0" * 64
for i, e in enumerate(entries):
    need(e["sequence"] == i, f"sequence gap at {i}")
    need(e["previous_sha256"] == prev, f"hash chain break at {i}")
    need(e["manifest_sha256"] == manifest_sha, f"manifest sha differs at {i}")
    prev = e["entry_sha256"]

# 2-6. receipts
cursor = collections.defaultdict(int)
P = N = 0
source_ids = {}
target_refs = []  # (frame bucket, child honor, identity)
root_frames = []
native_results_checked = 0
seen = set()
for i, e in enumerate(entries):
    key = tuple(e["frame_key"])
    need(key not in seen, f"duplicate frame {key}")
    seen.add(key)
    rec = e["receipt"]
    raw = open(rec["path"], "rb").read()
    need(hashlib.sha256(raw).hexdigest() == rec["sha256"] and len(raw) == rec["bytes"], f"receipt file changed {key}")
    r = json.loads(raw)
    layer, honor, start, count = key
    need(r.get("status") == "COMMITTED_NATIVE_V17_FRAME", f"status {key}")
    need(r.get("native", {}).get("sha256") == NATIVE_SHA, f"native {key}")
    need(r.get("manifest_sha256") == manifest_sha, f"receipt manifest {key}")
    need((r["layer"], r["honor"], r["start"], r["count"]) == key, f"extent {key}")
    need(r["P_rows"] + r["N_rows"] == count, f"P+N {key}")
    need(r.get("no_old_acceptance_imported") is True, f"old import {key}")
    acc = r.get("acceptances", {})
    need(all(acc.get(k) is True for k in ("base", "successors", "metadata", "frames", "target_identity")), f"acceptances {key}")
    need(acc.get("root_P") is ((layer, honor) == (0, 0)), f"root flag {key}")
    # native result record
    nr = r["native_result"]
    nraw = open(nr["path"], "rb").read()
    need(hashlib.sha256(nraw).hexdigest() == nr["sha256"], f"native result changed {key}")
    n = json.loads(nraw)
    need(n.get("status") == "PASS_NATIVE_V17_FRAME" and n.get("frameAccepted") is True, f"native frame not PASS {key}")
    need((n["layer"], n["honor"], n["start"], n["count"]) == key and n["P_rows"] == r["P_rows"], f"native extent/P {key}")
    native_results_checked += 1
    # coverage
    need(start == cursor[(layer, honor)], f"gap/overlap {key}")
    cursor[(layer, honor)] = start + count
    P += r["P_rows"]; N += r["N_rows"]
    # identities
    sid = json.dumps(r["source_identity"], sort_keys=True)
    if (layer, honor) in source_ids:
        need(source_ids[(layer, honor)] == sid, f"source identity changes inside bucket {key}")
    else:
        source_ids[(layer, honor)] = sid
        cell = cells[(layer, honor)]
        s = r["source_identity"]
        need(s["bits"]["path"] == cell["bits"] and s["directory"]["path"] == cell["directory"], f"source paths differ from plan {key}")
        for fld in ("bits", "directory", "groups", "ids", "numeric"):
            rec2 = s[fld]
            need(inputs_before.get(rec2["path"], {}).get("sha256") == rec2["sha256"], f"source {fld} hash not in input map {key}")
    expected_children = sorted(h for h in cells[(layer, honor)]["needed_honors"]
                               if layer < 34 and cells.get((layer + 1, h), {"size": 0})["size"] > 0)
    got_children = sorted(int(h) for h in r["target_identities"])
    need(got_children == expected_children, f"target honors differ {key}")
    for h, ident in r["target_identities"].items():
        target_refs.append(((layer, honor), (layer + 1, int(h)), json.dumps(ident, sort_keys=True)))
    if (layer, honor) == (0, 0):
        root_frames.append((r, n))

complete = [k for k in nonempty if cursor.get(k, 0) == cells[k]["size"]]
need(len(complete) == 3686, f"complete buckets {len(complete)}")
need(set(cursor) <= nonempty, "frames outside nonempty cells")
need(P + N == 778532864302, "total rows")

# cross-layer: each target identity equals the identity recorded when that child bucket was itself checked
mismatch = 0
for parent, child, ident in target_refs:
    if source_ids.get(child) != ident:
        mismatch += 1
need(mismatch == 0, f"cross-layer identity mismatches: {mismatch}")

# root
need(len(root_frames) == 1, "root frames")
root_cell = cells[(0, 0)]
rb = open(root_cell["bits"], "rb").read()
need(len(rb) == 8 and hashlib.sha256(rb).hexdigest() == inputs_before[root_cell["bits"]]["sha256"], "root bits file identity")
root_bit = rb[0] & 1
need(root_bit == 1, "root bit is not P")
if root_frames:
    need(root_frames[0][0]["P_rows"] == 1, "root frame P count")

# post-run input identity record equals pre-run map
after = load(load(RUN + "INPUTS_AFTER.json")["identity_record"]["path"])
need(after.get("files") == inputs_before, "post-run input map differs from pre-run map")

# sample re-hash of actual input files
random.seed(20261019)
small = [p for p, v in inputs_before.items() if v["bytes"] <= 8_000_000]
sample = random.sample(small, min(60, len(small))) + [root_cell["bits"]]
medium = [p for p, v in inputs_before.items() if 50_000_000 <= v["bytes"] <= 400_000_000]
if medium:
    sample.append(random.choice(medium))
rehash_bad = [p for p in sample if sha_file(p) != inputs_before[p]["sha256"]]
need(not rehash_bad, f"re-hash mismatches: {rehash_bad[:5]}")

print("ledger entries:", len(entries), "| native results checked:", native_results_checked)
print("complete nonempty buckets:", len(complete), "/ 3686")
print("rows:", P + N, " P:", P, " N:", N)
print("cross-layer target references checked:", len(target_refs), "mismatches:", mismatch)
print("root bit:", root_bit, "(1 = P) | root frames:", len(root_frames))
print("input files re-hashed now:", len(sample), "| mismatches:", len(rehash_bad),
      "| bytes re-hashed:", sum(inputs_before[p]["bytes"] for p in sample))
print("problems:", len(problems))
for p in problems[:20]:
    print("  PROBLEM:", p)
```
