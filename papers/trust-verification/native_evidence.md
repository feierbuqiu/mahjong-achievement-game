# Native V17 evidence audit for the 19 October 2026 supplement

Audit date: 19 October 2026 (Australia/Sydney). Scope: read-only examination of retained sources, receipts and logs. The audit did not execute Lean, `leanchecker`, a compiler, a native game checker, a GPU worker or a full-table input scan. It did not mutate a research job or publish anything. The small audit program in this paper directory reads saved JSON records and performs arithmetic/hash checks only.

## 1. Main finding and precise claim

`runs/lean_table_checker/v17_compute_finish_20261018/full_native_20261018_02/FINAL.json` records `COMPLETE_FIXED_V17_NATIVE_COMPUTATION` at `2026-10-18T17:56:53.715184+00:00`, which is 19 October 2026, 04:56:53 Australia/Sydney. Its claim class is `FIXED_V17_KERNEL_IMPLICATION_PLUS_NATIVE_COMPUTATION`, and `closed_actual_input_Lean_declaration` is explicitly `false`.

The completed run accepted all 778532864302 SAFE-orbit rows in layers 0–34, comprising 203051492021 P rows and 575481372281 N rows, in 17317 committed frames. All 3686 nonempty buckets were covered exactly; 2754 other cells were empty, giving 6440 cells = 35 layers × 184 honour classes. The empty root was accepted as P. No historical game PASS records or certified seeds were imported to authorise row acceptance. The run checked the historical table labels; it did not regenerate those labels.

The supported mathematical/computational statement is that the Lean kernel proves the frozen whole-input implication `Mahjong.FastWholeInputV17.from_finite_input`, and compiled evaluation of the corresponding finite checks accepted the complete actual input. The implication concludes `SecondPlayerWins Step Win empty` under the original formalised game rules. The actual acceptance equalities have not been supplied as a closed saved Lean declaration. The original rule model, kernel and standard axioms, native compilation/runtime, OS/hardware, I/O binding, input custody and external assembly/bookkeeping remain in the trust boundary.

The current paper should call this a complete computer-assisted verification at this explicit evidence level. Unqualified phrases such as “fully formally verified”, “a closed Lean proof of the actual empty position”, “independently replicated”, or “all trust is confined to the kernel” are unsupported.

## 2. Independent saved-record arithmetic performed for this paper

`native_record_audit.py` was written in this paper directory without importing or calling the project finalizer. Its result is retained in `native_record_audit.json` (observation `2026-10-18T23:27:19.822122+00:00`). It read and hash-checked 38323 referenced JSON records and found zero discrepancies in the following checks:

- Every one of 17317 ledger entries has its expected sequence, previous-hash link, manifest hash and independently recomputed canonical SHA-256. There are 17317 unique frame keys.
- Every committed frame receipt and native-result record has its recorded byte length and SHA-256; the extents, P/N counts, source-span counts, executable binding, input-map binding, acceptance flags and session bindings agree.
- The ranges cover each nonempty bucket contiguously from zero to its declared size, without gaps, overlaps or duplicates. Every empty cell has zero covered rows.
- All frames refer to the single native session `032a785eb75940aba28b930fdf0e026e`.
- All 54548 recorded cross-layer target references have the same seven-field identity as the referenced child bucket's own source. These are repeated references across frames, not 54548 distinct child buckets.
- The before-input map, after-input map and manifest's input map are identical; their canonical map digest agrees. Their file paths and extents match the complete plan.
- Independently summed per-layer totals agree with the local publication's per-layer aggregates, and the global sums agree with `FINAL.json`.

This is an additional inspection of the same saved execution evidence. It does not independently rerun the game checks, establish that every native output faithfully reflects an execution, or rehash the full input dataset. No independence claim about execution should be inferred from this audit.

Arithmetic:

```math
203051492021+575481372281=778532864302,
```
```math
3686+2754=6440=35\times184.
```

The complete per-layer table appears in Section 10 below.

## 3. What changed since the 15 September supplement

`runs/lean_table_checker/ACTUAL_SCAN_ACCEPTANCE.json` is dated `2026-09-14T06:08:20Z`; its results were reported in the 15 September supplement. It completed only layers 34 and 33: 587901 + 21924455 = 22512356 distinct production rows, with P = 13942085 and N = 8570271. That was 0.0028916384949508375% of the global table. The two old runs contained 47 and 364 chunks, respectively, and their proof status explicitly left the empty game unverified.

V17 now verifies all layers 0–34 with a whole-input soundness implication and explicit base, metadata, cross-layer and root checks. The increase in distinct covered global addresses beyond the old two layers is

```math
778532864302-22512356=778510351946.
```

The full coverage is approximately 34582.46948 times the old row count; this is a coverage ratio, **not a speed-up factor**. V17's complete run rechecked the old top-layer addresses as part of its own scan. Do not add 22512356 to the new total. V17's layer-33 and layer-34 work used 37 + 13 = 50 frames; the old 411 chunks and new 50 frames are different partitioning schemes.

The global P/N counts agree with the September C++ result because V17 checks that retained table. Agreement of the totals is bookkeeping consistency, not a second independent table generation. The stronger evidence is that a different, Lean-defined checker accepts every stored label under its verified recurrence and complete-input assembly assumptions. The old concrete kernel-certified P bank and the V18/V19 strict-kernel pilots are separate evidence populations, not extra rows to add to this table total.

## 4. Exact timing scopes and operational observations

| Quantity | Recorded value | Scope |
|---|---:|---|
| Production start used by performance display | `2026-10-18T10:21:49.723696+00:00` | Derived from `production_start_unix` |
| First frame commit | `2026-10-18T10:31:23.053180+00:00` | Layer 32, honour 89, all 56 rows |
| Last frame commit | `2026-10-18T17:46:30.528607+00:00` | Ledger's final entry |
| Controller completion timer | 27304.5 s = 7.5845833 h | Controller invocation, including its base checks, scan and finalisation |
| Later display timer | 27333.44182062149 s = 7.5926227 h | Display sampled about 29 s after completion |
| Sum of accepted-frame helper wall intervals | 17710.799751821934 s | Excludes base, bucket loading and finalisation; includes helper work around native frames |
| Sum of native frame `wall_ns` | 14610.333236399 s | Sum of native frame timers; not full production wall time or CPU time |
| Sum of native frame `plan_ns` | 1471.104206740 s | Frame plan timing component |
| Sum of native frame `scan_ns` | 12298.804689334 s | Frame scan timing component |
| Sum of frame payload-read time | 817.493796443 s | Payload-read timing component |
| Base-input load | 14.138185500 s | `native_base_checked.json` |
| Base checks | 528.295152749 s | `FiniteCertificateV17.checks` evaluation in the production session |
| Successor checks | 1.568232601 s | Production session's successor acceptance |
| Average rows/s in later display | 28482796.62002325 | Total rows / later display timer |
| Accepted-frame helper rate | 43958086.32085692 rows/s | Total rows / helper-wall sum; excludes other phases |

“About 7.6 hours for this completed production run” is defensible. It is not a future runtime guarantee, an all-project elapsed time, a strict-kernel proof estimate, or an independent-replication cost. The display explicitly marks itself `DISPLAY_ONLY_NOT_A_CERTIFICATE`. The timer does not include all prior source development, compilation, initial full-input hashing, controls, the failed first attempt, independent review or publication.

Post-scan stages were observed at `17:47:05.344980Z` (`FINAL_CURRENT_INPUT_SHA`), `17:52:57.598380Z` (`FINAL_EXACT_ALL35_COVERAGE`) and `17:56:53.723194Z` (`COMPLETE`). The actual post-input map records `verified_utc=17:51:11.882739Z`. Do not conflate the interval to the later exact-cover report with hashing alone: completion verification also occurs between these stage records.

There are 3700 saved controller reports. They are mostly one report per bucket, not a high-frequency process-memory trace. All report `pool_threads=12`; each accepted native frame records 12 logical fragments. The minimum sampled host available memory is 2334924800 bytes at `2026-10-18T10:50:23.398178Z`, out of 34253983744 visible bytes, with 93.2% host memory usage. The maximum observed host swap value in these reports is 1724686336 bytes. These are host-level samples and do **not** establish the native process's peak RSS or a continuous bound.

The final `PLAN.json` and `MANIFEST.json` explicitly have `RAM_hard_limit_bytes=null` and `wall_hard_limit_seconds=null`, with physical-memory monitoring and possible concurrency reduction as policy. The initial scope document's 16000000000-byte target and the September benchmark's 15500000000-byte cap do not describe an enforced cap of this production run. In particular, the paper must not claim that this full run stayed within 16 GB.

Recorded hardware is Intel Core i7-10700KF, 8 cores / 16 logical processors, 34359738368 installed memory bytes (32 GiB), 34253983744 OS-visible bytes, and NVIDIA GeForce RTX 2070 SUPER. The exact retained hardware observation is dated **14 September 2026**, in `build/publication/mahjong-achievement-game/research/2026-09-14/hardware.json`; it reports Windows 11 Education, version `10.0.26200`, 64-bit. The October native build/execution receipts show Linux/WSL and Lean 4.33.1. Hardware statements should identify the dated observation rather than pretend that a fresh October CIM inventory was performed. The older hardware receipt's `gpu_used_by_published_checker=false` applies to the September checker; V17 did use an untrusted GPU proposal path.

## 5. Input identities, continuous custody and the failed first attempt

The complete input map contains 11272 files and 100615834170 bytes (100.615834170 GB decimal). Of these, the 3686 P/N `.bits` files contain 97316623312 bytes. This is a larger input set than the bit payload alone: source directories, finite local data, group/bound inventories, successor caches and catalogues are also checked or used as identified input.

| Input role | Files | Bytes |
|---|---:|---:|
| Unverified historical source labels | 3686 | 97316623312 |
| Untrusted proposer extent metadata, not imported acceptance | 3686 | 945460 |
| Source directories | 3686 | 1945263968 |
| Finite honour directories | 184 | 1215996060 |
| Finite bound entries | 5 | 4528 |
| Finite bound lookups | 5 | 1310720 |
| Common index files | 4 | 9713944 |
| Common inventory files | 4 | 8652440 |
| Common local-cache files | 4 | 10156250 |
| Common raw files | 2 | 24375000 |
| Common successor files | 2 | 5798160 |
| Original catalogue | 1 | 78505 |
| Finite triple keys | 1 | 38398860 |
| Finite triple labels | 1 | 38398860 |
| New complete all-layer catalogue | 1 | 118103 |
| Total | 11272 | 100615834170 |

The before-map for `_02` is **not** a fresh rehash of all input bytes during that invocation. Its receipt says `all_input_bytes_rehashed_in_this_invocation=false`, `hash_reused_count=11271`, `hash_reused_bytes=100615716067`, and `actual_bytes_hashed_this_invocation=118103`. It reused identities from `_01` while recorded Windows deny-write/delete locks remained continuously held, acquired its own locks before the handoff, verified the earlier custodian was alive, and freshly hashed only the new `_02/catalog_all35.tsv`. This handoff took 3.297 seconds. The original full hash receipt under `_01/input_custody/e25c8e79b5c54e37adf9e3b83d5f2c20/identities.json` records 11272 files, the same total bytes, and 281.25 seconds for that full prehash.

This reuse is identity/custody reuse, not import of a previous game's PASS result or a certified P seed. It must be described accurately when claiming a fresh all-row check. The controller's post-run loop calls `sha_file` for every input and compares the result to the locked before-map. The saved after-map is identical. This paper audit compared the maps and hashes of their records but did not reread the 100.62 GB input files.

`full_native_20261018_01` stopped before accepting any game frame or row. `RECOVERY_REASON.json` explains that a GPU resource declaration used `sys.maxsize` while the older GPU-only validator required `host_rss_cap_bytes=3000000000`. The correction was an authorised I/O/resource-policy change; the 145 frozen mathematical sources and native executable remained unchanged. `_02` is the completed all-row run. An actual GPU-connection smoke test preceded production and explicitly reported zero Lean rows verified by that probe.

The final service cleanup and later closeout records confirm that the single owned native/GPU session exited. A later auxiliary review records release acknowledgements for both `_01` and `_02` input custodians. The final result was preserved. The closeout's read-only process inventory reported no project Python process and WSL Ubuntu stopped at that observation; this is historical closeout evidence, not a present process inventory.

## 6. Six acceptance families and division of responsibility

| Family | Native/Lean function boundary | Retained evidence and limitation |
|---|---|---|
| Base finite data | `FiniteCertificateV17.checks` through `V17NativeWorker.checkBase` | Once per session; `native_base_checked.json`, then `GLOBAL_READY`. Covers finite local caches/inventories, groups, bounds, directories, layout and word limits. |
| Successor lists | `FiniteMetadataV17.checkSuccessors` through `checkEdges` | Once per session, before bucket service. |
| Per-bucket metadata | `checkSource`, `checkBank`, `GroupNextCoverage.check` | Accepted on opening every nonempty bucket; bucket-ready records bind its size and loaded targets. |
| Frames and exact cover | `RuntimeScanV17.prepare`, `scanFragment`, `assembleScanned`, range checks | Native process writes frame PASS results; exact whole-input extent composition also depends on external ledger/coverage bookkeeping. |
| Cross-layer target identity | `CrossLayerAssemblyV17.checkTargets` via target/source checks | In-process comparison plus fixed paths, immutable inputs, hash binding and external seven-field identity equality. |
| Empty root and P bit | `EmptyRootV17.checkP` | Root preflight and root bucket `(0,0)`; the root frame is P = 1, N = 0. |

The compiled worker calls the frozen checks. The supplied `finishWhole` typed in-process assembly route was not used for this enormous production table; the assembly actually used is external. The in-process target identity check reloads the same file roots, so its production equality is a self-comparison under the file-identity/custody assumptions. This does not make the check itself vacuous—the changed-target control rejects—but it makes the file-binding assumptions essential to the reported whole-input conclusion.

The GPU produces untrusted compact proposals. The retained `gpu_ready.json` labels its context as `UNTRUSTED_FIXED_INDEXED_BYTE_CUDA_CONTEXT_V16` and says `Lean_rows_verified=0`. The proposal format is one byte per source address, with 8388608-row scratch batches and a maximum proposal frame of 67108864 rows. An N proposal selects a candidate successor; a P proposal requests the universally checked alternative. The CPU native checker must validate the relevant row condition, source address, supplied plan and frame coverage before committing. A GPU-ready event or proposal is not a mathematical acceptance. Historical V16-labelled transport code in this untrusted producer does not mean that V19 mathematics entered the frozen V17 acceptance path.

The native program is compiled Lean code; its execution trusts the Lean-to-C compiler, C compiler, runtime, scheduler, OS and hardware. Python plans/schedules the run, binds the actual bytes, records native events, maintains the ledger, hashes inputs and finalises coverage. Its success reports are execution evidence, not Lean proof terms. The kernel checks the generic mathematical implication and its proof closure; it did not reduce all of the 778532864302 actual-row checks in this run.

The native build receipt is `PASS_NATIVE_LINK_AND_STANDARD_FRESH_IMPLICATION_ONLY`. It retains `actual_game_rows=0` and `actual_full_input_acceptance=NOT_EVALUATED`, correctly describing that build-stage receipt rather than the subsequent completed campaign. The recorded `leanchecker --fresh V17ComputeReplay` run succeeded in 114.643794581 seconds (CPU 114.52027 seconds; sampled process-group peak RSS 1392345088 bytes). These are replay metrics for the implication, not actual-table proof metrics. The recorded executable is 121190888 bytes, SHA-256 `775e05d2601e30847b14b017cb542ea23a8b629d8ebd403aa07bd5942b78f667`.

## 7. Controls, separate Claude review and their limitations

The final executable passed six actual-native controls, all on the small layer-32, honour-89 setting:

| Control | Native behaviour | Scope |
|---|---|---|
| `positive_full_bucket` | 56 rows accepted; complete typed bucket accepted | Valid whole small bucket |
| `source_bit_flip` | 0 accepted rows; `fragment_cover_source_address_or_indexed_row_rejected` | Changed source label rejected |
| `deleted_last_row` | 55 row checks accepted, whole bucket rejected with `BUCKET_CLOSED_EXACT_COVERAGE_FALSE` | Partial rows do not imply complete bucket |
| `target_identity_mismatch` | 0 accepted rows; `actual next-layer byte identity rejected` | Different target bytes rejected |
| `truncated_source_bits` | 0 accepted rows; `bucket length mismatch: n32_h089` | Missing source payload rejected |
| `catalog_honor_mismatch` | 0 accepted rows; `source catalog honor binding rejected` | Incorrect catalogue honour rejected |

The 55 valid partial rows in the deletion control must not be called a failed row check or zero accepted rows. These controls overlap the production dataset and do not enlarge the distinct global coverage total.

There are also 36 mocked transport controls and 22 pure bookkeeping controls. They test actual function bodies with synthetic/mocked event/process boundaries, including EOF, missing permission, wrong executable/source/input identity, gaps, overlaps, duplicated frames, missing post-input hashes, unconfirmed exits and incomplete journal tails. They started zero native/GPU research processes and accepted zero actual game rows. Test names containing “actual” or “killed controller” do not transform these into real OS crash/recovery experiments. The completed production run was uninterrupted; no real kill-and-resume experiment with this worker is claimed.

The separate report at `build/publication/mahjong-achievement-game/research/2026-10-19-v17/review/INDEPENDENT_REVIEW.md` names its reviewer as Claude (Anthropic), model `claude-opus-5-5`. It records three pre-run review passes on 18 October and one post-run pass on 19 October. It states that the reviewer did not author or modify the Lean proofs, worker, controller or finalizer. It notes one earlier suggestion led the owner to a subsequently stopped side session, leaving only an empty directory. Therefore “separate AI review with stated non-authorship” is accurate; anonymous human peer review or wholly uninvolved external execution is not.

The reviewer reports no defect in its inspected source/record scope and zero problems in its independent ledger script. It checked all 17317 receipt/native bindings, all 3686 bucket covers and 54548 target references, read the root bit, compared before/after maps, and rehashed a seeded sample of 62 input files totalling 81370822 bytes with zero mismatches. This is a sample of the input dataset, not a second full-input rehash.

Limitations stated by that report:

- It did not rerun Lean, `leanchecker`, native verification or GPU computation. Build/proof replay claims were examined through receipts/logs.
- Of 1582 lines of trusted planning/runtime Python as counted by the reviewer, only the 213-line `finalize.py` was reviewed line by line. The other planning/runtime bookkeeping was not.
- One machine/toolchain supplied the execution evidence; no independent execution replication or human peer review had been completed.
- Production target identity additionally depends on immutability/hash binding.
- The original Appendix B script's printed problem count matters: a zero exit code alone is not a pass. It checks hash links but did not itself recompute every ledger entry's canonical hash. The publication's separate archive verifier and this paper's independent saved-record audit add canonical-entry-hash recomputation.
- The report's “beyond reasonable doubt” language is the reviewer's confidence assessment, not a proved numerical error bound or a replacement for the stated trust boundary.

The report's finding F6 about public status predating the run is a historical observation before the later publication update. Do not repeat it as the present repository state. Likewise the stage gates in the early `SCOPE.json` were superseded by the owner's continuous authorisation, as the report records; that is a process-history fact, not a mathematical defect. The immutable preliminary scope/preparation/build files retain their earlier `NOT_EVALUATED`/incomplete fields and must be read in chronology.

## 8. Local publication package and archival publication receipt

The inspected local package is `build/publication/mahjong-achievement-game/research/2026-10-19-v17/`. It exposes the explicit trust boundary, coverage and input maps, review, source mappings and recorded runtime/build/control evidence. Its source map identifies 148 logical Lean source files: 145 frozen mathematical/base files plus worker, native main and replay root. The replay root's reachable source closure is 146 files; the historical `leanchecker` receipt's 145 imported modules is a different scope. Refer to the formal/reproduction audit for these source-closure checks.

The declared evidence ZIP is 63456055 bytes, SHA-256 `5e68d6382c6e68fd525cd52defdb1969007aaaeddd24d5fe8afabc299057bdc4`. `assets.json` states 38329 original payload files, 145559336 uncompressed payload bytes, including 17317 native frame results, 3686 bucket-ready records and one global-ready record. It includes only the eight-byte empty-root payload from the large table. The full 100615834170-byte input set, native binary and toolchain/GPU environment are not distributed in that saved-record asset. Input hashes identify unavailable data; they do not supply it. The operations snapshot is not represented as a portable installer.

`verify.py --archive` validates saved member/ledger hashes, frame/result bindings, scoped flags, exact coverage, root and cross-layer identities. It does not re-evaluate the game recurrence, execute Lean/native verification or rehash the unavailable full input set. `prepare_sources.py` assembles exact mapped source bytes without compiling. These actions are different reproduction tiers and should be named separately.

`runs/publication_native_20261019/published-update-receipt.json` records publication through PR #11, merged at `2026-10-18T21:12:00Z`, with main commit `e75911f700d4e5e1b39df53273e9dde698bf4901` and source commit `3c295e4b5010e6a5add3565bba746226e10f1b14`. It records successful repository/C++ smoke checks, byte verification of listed public files, signed commit/tag checks, and an immutable evidence release `evidence-v17-native-20261019`. This audit read the receipt and local files but did not independently query the current remote branch. Thus this is an archival publication observation, not a live claim that this commit remains public `main`. The separate immutable `v1.0.0` release and the two earlier papers were retained; the new forthcoming paper was not part of that update.

## 9. Editorial cautions for the manuscript

1. Lead with the stronger completed native verification while keeping `closed_actual_input_Lean_declaration=false` explicit. Do not retain the old broad statement that no complete native input evaluation exists.
2. Distinguish an accepted implication from supplying all actual-input hypotheses as kernel proof terms. The production whole-table assembly is external, even though the logical soundness chain is formalised.
3. Do not report 7.6 hours as including all setup, compilation, prehash, failure recovery, controls or review; distinguish controller and display timers.
4. Do not claim a 16 GB production cap or a process memory peak from host-memory reports. The final limits are uncapped and the host samples reached 93.2% usage.
5. “No earlier PASS imported” does not mean “no earlier input identity reused”: preserve the continuously locked identity handoff distinction.
6. The C++ P/N table is the input under verification. Matching its P/N totals is not independent re-computation of those totals from newly generated labels.
7. The Claude review is a separate AI review with limited source coverage, no native replay, no human peer review and a sampled input rehash.
8. Do not sum reused/overlapping September rows, controls, concrete proof-bank positions or V18/V19 pilots into the 778532864302 unique address coverage.
9. Avoid describing raw row counts as physical positions. These are SAFE positions **up to the specified symmetry**, indexed by layer and honour class.
10. Root `STATUS.json` and the early scope/build receipts are dated snapshots; the final complete records resolve their older provisional status. The absence of a closed actual-input kernel theorem remains current within the inspected evidence.

## 10. Full layer arithmetic from saved committed frame receipts

Generated below directly from `native_record_audit.json`; frames and buckets are different partitions. This table repeats the table's stored labels as accepted by V17, not a new table generation.

| Tiles | Recorded SAFE orbits | P | N | Frames | Nonempty buckets |
|---:|---:|---:|---:|---:|---:|
| 0 | 1 | 1 | 0 | 1 | 1 |
| 1 | 6 | 0 | 6 | 2 | 2 |
| 2 | 47 | 14 | 33 | 4 | 4 |
| 3 | 298 | 46 | 252 | 7 | 7 |
| 4 | 1,725 | 404 | 1,321 | 12 | 12 |
| 5 | 8,967 | 1,679 | 7,288 | 18 | 18 |
| 6 | 42,793 | 11,159 | 31,634 | 27 | 27 |
| 7 | 187,376 | 34,632 | 152,744 | 38 | 38 |
| 8 | 760,493 | 187,425 | 573,068 | 52 | 52 |
| 9 | 2,874,880 | 531,639 | 2,343,241 | 69 | 68 |
| 10 | 10,187,475 | 2,248,838 | 7,938,637 | 90 | 87 |
| 11 | 34,006,368 | 5,951,610 | 28,054,758 | 115 | 107 |
| 12 | 107,440,638 | 21,282,781 | 86,157,857 | 150 | 130 |
| 13 | 321,356,083 | 52,530,670 | 268,825,413 | 192 | 148 |
| 14 | 903,209,000 | 172,931,755 | 730,277,245 | 250 | 163 |
| 15 | 2,346,950,750 | 387,779,363 | 1,959,171,387 | 322 | 170 |
| 16 | 5,544,554,559 | 1,146,615,962 | 4,397,938,597 | 418 | 174 |
| 17 | 11,780,250,236 | 2,127,213,505 | 9,653,036,731 | 556 | 173 |
| 18 | 22,376,865,721 | 5,169,175,844 | 17,207,689,877 | 753 | 173 |
| 19 | 37,804,625,883 | 7,545,862,761 | 30,258,763,122 | 1,006 | 173 |
| 20 | 56,566,252,124 | 14,418,956,851 | 42,147,295,273 | 1,287 | 173 |
| 21 | 75,050,088,557 | 16,379,219,048 | 58,670,869,509 | 1,540 | 172 |
| 22 | 89,127,184,893 | 24,583,507,136 | 64,543,677,757 | 1,699 | 170 |
| 23 | 96,268,928,092 | 22,390,373,365 | 73,878,554,727 | 1,734 | 167 |
| 24 | 96,065,224,588 | 27,864,862,842 | 68,200,361,746 | 1,667 | 163 |
| 25 | 88,982,128,123 | 21,663,176,175 | 67,318,951,948 | 1,509 | 160 |
| 26 | 75,440,492,234 | 22,885,068,257 | 52,555,423,977 | 1,279 | 158 |
| 27 | 56,645,165,793 | 14,906,959,805 | 41,738,205,988 | 986 | 157 |
| 28 | 35,949,118,771 | 11,937,273,296 | 24,011,845,475 | 671 | 153 |
| 29 | 18,221,731,480 | 5,735,300,814 | 12,486,430,666 | 403 | 143 |
| 30 | 6,893,983,233 | 2,718,161,072 | 4,175,822,161 | 220 | 126 |
| 31 | 1,786,188,250 | 805,422,067 | 980,766,183 | 120 | 99 |
| 32 | 280,542,509 | 116,909,120 | 163,633,389 | 70 | 68 |
| 33 | 21,924,455 | 13,354,184 | 8,570,271 | 37 | 37 |
| 34 | 587,901 | 587,901 | 0 | 13 | 13 |

## 11. Path and SHA-256 ledger

The following small/medium evidence files were hashed directly for this memo. The 100.62 GB input dataset and the executable were **not** rehashed by this memo; their identities are recorded in the linked receipt/map chain. Paths are relative to the research root, not public URLs. Source `SCOPE.json` and preparation receipts are historical stage records, whereas `FINAL.json` is the completed-run authority.

| Research-relative path | Bytes | SHA-256 |
|---|---:|---|
| `runs/lean_table_checker/v17_compute_finish_20261018/full_native_20261018_02/FINAL.json` | 1,017 | `413ced59dcfcc2825f6b17503e8690f895b6d9f0219ddb2eb4ce43cf992c957e` |
| `runs/lean_table_checker/v17_compute_finish_20261018/full_native_20261018_02/MANIFEST.json` | 1,787,496 | `bf46a286a78e7f1c8ba62611ac841c89e463542589acb443e15e53d9b66b76ed` |
| `runs/lean_table_checker/v17_compute_finish_20261018/full_native_20261018_02/PLAN.json` | 3,306,441 | `bc9b6f02c66b4556b1e9a189d9950d95b994f5bb82170736aa09b1abe0e71baa` |
| `runs/lean_table_checker/v17_compute_finish_20261018/full_native_20261018_02/RUNTIME.json` | 55,378 | `4a274d7dac9fbc924777973984119dc47b5317ec457cc20531b03051c6b3ada6` |
| `runs/lean_table_checker/v17_compute_finish_20261018/full_native_20261018_02/ledger.jsonl` | 10,793,673 | `255d3bf5fd74208bcac6d8b68b6804a52d4c1661b5afc2789994a8b270c12f4d` |
| `runs/publication_native_20261019/published-update-receipt.json` | 2,259 | `0c1c26e52f02b78abbc8eba9d79fcfb28d16dbdccd9d3cf632ac4352754788c9` |
| `runs/lean_trust_supplement_20261019/native_record_audit.py` | 8,860 | `fe506e98de029b61896e62b51ed53b4f98d086c9912fa2ae7c0295e1da0433ad` |
| `runs/lean_trust_supplement_20261019/native_record_audit.json` | 9,201 | `80a962e5bc71f8729b1a249c713048fc14f9130565ba3a0cd45664e88313c834` |

The independent saved-record script and its machine-readable result are accompanying paper artefacts, not modifications to the original research evidence. Their hashes are included above so that the arithmetic audit can be reproduced separately from the native campaign.
