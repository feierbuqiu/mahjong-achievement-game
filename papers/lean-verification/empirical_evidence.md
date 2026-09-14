# Empirical evidence audit for the Lean supplement, 15 September 2026

This is a source audit for the supplemental manuscript, not a new proof or computation. The source files were read without starting Lean, the solver, a scan controller, or an automation. `empirical_extract.py` independently recounts the preserved SQLite database, checks interval unions and count identities, hashes 51 selected evidence files, and checks eight adjacent acceptance-hash links. Its machine-readable output is `empirical_evidence.json`. The output records the exact audit time and all selected paths, byte lengths and SHA-256 values. It does **not** recompile the 283 accepted daemon batches, check all 5,329 latest dependency files, or reread the historical approximately 97 GB P/N payload.

All dates below are UTC unless explicitly marked Sydney time. Sydney was UTC+10. The latest `runs/lean_table_checker/STATUS.json` has a field named `utc` containing `2026-09-15T02:41:40.506769+10:00`; this means **14 September 16:41:40 UTC**, not 15 September UTC. The latest fixed acceptance was made at **14 September 16:38:57 UTC / 15 September 02:38:57 Sydney**. Decimal GB means 10^9 bytes; the Lean per-process setting `-M3072` is 3,072 MiB, or 3 GiB. Sampled private-memory peaks and operating-system hard limits are different measurements.

## 1. Changes since the first report

The 13 September report's explicit twelve-tile certificate had 757 reusable P rows for `99m 6789p 456888s`, with 25,510 legal first-action responses. The later work changed three independently reportable quantities:

1. **Explicit kernel-checked strategy facts:** 757 → 3,311 → **24,655 distinct P states**. There are now four certified twelve-tile roots, including the previous root. The designated ten-tile root and the empty root are still uncertified.
2. **Actual historical table positions checked by compiled Lean:** complete layers 34 and 33, totalling **22,512,356 distinct positions**. These are concrete row obligations checked under the compiler/runtime/input trust boundary, with kernel-proved checker soundness. They are not 22 million literal kernel-reduced input certificates.
3. **Formal algorithm models and finite input validation:** the SAFE filter, raw encoding, canonical inventories, grouping, directory coverage, global orbit enumeration, word-level index/decoder/cursor models, actual local successor caches and optimised retrograde models have progressively stronger evidence. Their finite checks add **zero historical P/N positions** to the second count.

The previous completed C++ global computation still supplies the computational empty-P conclusion. Neither the new enumeration proofs nor synthetic operational tests instantiate the historical empty-table result as a closed Lean theorem. The latest status explicitly says `universal_whole_cpp_refinement = NOT_VERIFIED`, `fully_instantiated_whole_solver_kernel_certificate = NOT_CONSTRUCTED`, and `historical_output_formally_bound = false`.

## 2. Explicit-certificate progression and retained failure evidence

### 2.1. Three additional twelve-tile roots

Source: `runs/lean_solo/FINAL_STATUS.json`, dated **13 September 12:44:56.837741 UTC**, and `runs/lean_solo/RESULT.md`.

| Root | Exact 34-coordinate input | New P rows | Legal first-action responses | New SAFE leaves | Successful dependency modules | New modules in final pass | Final-pass seconds | Sampled final-pass peak private bytes |
|---|---|---:|---:|---:|---:|---:|---:|---:|
| branch34 | `0000000030000001110001110300000000` | 2 | 66 | 1 | 31 | 10 | 23.219 | 2,284,871,680 |
| branch44 | `0000000020000001110001121200000000` | 1,061 | 36,074 | 103 | 383 | 133 | 112.109 | 12,293,799,936 |
| branch35 | `0000000030001110201000001110000000` | 1,491 | 50,170 | 162 | 562 | 187 | 122.375 | 11,702,251,520 |
| Increment | — | **2,554** | **86,310** | **266** | Do not sum overlapping dependencies | — | — | — |

These final-pass times reuse accepted dependencies. For branch44, a preceding leaf/data/edge-group pilot took 215.578 s, with a sampled private-memory peak of 9,888,903,168 bytes; branch35's corresponding pilot took 235.188 s and 11,099,971,584 bytes. The native closure stages for branch44 and branch35 took approximately 20.079 and 20.328 s. Branch34 reused an already closed four-node subgraph. The final branch34 check used at most two Lean processes; the other final checks used at most eight. None of these numbers is a cold rebuild of all preceding research.

The combined bank `Mahjong.Solo.Bank2.registry` contains **3,311 distinct states = 757 + 2,554**. The JSON registry is discovery metadata; the accepted Lean terms carry the proofs. The integration audit checked 5,247 exact dependency-reuse edges. Version 1 of the integration failed because a decidability instance for `Valid` did not unfold; version 2 used `validB_iff` and passed 1,236/1,236 modules, with 4,014 audited theorem declarations across its dependencies. These are audit/dependency counts, not counts of new mathematical results.

The recorded partial ten-tile result concerns `0000000020000001110001110200000000`. It proves replies for zero-based first-kind IDs `[8, 9, 14, 23, 24, 25]`, i.e. **6 of 34** first-kind choices at that milestone. It does not prove P for the ten-tile root; absence of a reply in the current bank does not prove N. The later daemon snapshot also leaves that root uncertified.

### 2.2. Autonomous explicit P-bank growth

Read-only primary source: `runs/lean_table_checker/old_certificate_pause_snapshot/progress.sqlite`, opened with SQLite `mode=ro&immutable=1`; cross-checked against its `status.json` and the identical dated live-run status `runs/lean_daemon/production_v1/status.json`.

| Quantity at pause | Exact count / value |
|---|---:|
| Initial accepted seed states, 13 September 13:20:05 UTC | 3,311 |
| Unique candidate states in retained graph | 26,139 |
| Expanded graph nodes | 21,530 |
| Accepted P states | **24,655** |
| New distinct states across all PASS batches | **21,344** |
| Completed proof batches | 283 |
| Unfinished batch with no receipt | 1; retained label `KERNEL_RUNNING` |
| Recorded legal first-response entries across PASS events | 725,696 |
| Last PASS event | 14 September 03:59:07 UTC |
| Pause event and status | 14 September 04:01:26 UTC, `PAUSED` |
| New states in the most recent resumed session only | 15,977 |
| Duration of that session at pause | 44,756.29351592064 s |
| Recorded session mean | 1,285.1198229705967 P states/hour |
| Sampled process-tree private-memory peak | 15,162,486,784 bytes |
| Operating-system memory / CPU caps | 15,500,000,000 bytes / 80% |

The SQL audit independently found 21,344 PASS-batch node IDs, all distinct and all marked certified. The remaining 3,311 certified IDs exactly match the solo seed bank's state strings. PASS-event row counts also sum to 21,344. Hence the total growth from the first paper's 757-row bank is **23,898 distinct P states**. The value 15,977 is a session counter and must not be reported as the whole daemon's increment. The field `new_certificates = 283` counts proof batches, not P states. The pending batch's name is a preserved workflow label; it does not indicate a currently running process and supplies no accepted certificate.

| Tile count | Certified P states |
|---:|---:|
| 12 | 4 |
| 14 | 43 |
| 16 | 277 |
| 18 | 693 |
| 20 | 860 |
| 22 | 1,401 |
| 24 | 3,621 |
| 26 | 6,028 |
| 28 | 5,831 |
| 30 | 4,458 |
| 32 | 1,439 |
| Total | **24,655** |

This bank has no overlap by layer with the layer-33/34 native scans, but the two totals should be presented separately because their proof and execution boundaries differ. Its growth rate is not an empty-game ETA or a fraction of a known necessary certificate tree.

A substantive resource failure occurred at batch 71. `runs/lean_daemon/repairs/20260914_memory_v2/migration.json` records that aggregate memory pressure caused read failures for existing, hash-correct `.olean` files to be treated as proof rejection. The repaired scheduler estimated memory from imported-object volumes and observed peaks, and allowed bounded retries only for verified-existing objects. Missing/changed objects and type errors remained fatal. The retained failed run is `production_v1/k/K0859526368300/result.json`; the independent repaired recheck `production_v1/k/Repair71v2/result.json` passed **1,804/1,804 modules**, in **56.437 s**, at most **four active Lean processes**, with sampled peak **11,323,506,688 bytes**. An intentionally false proof was still rejected. The migration preserved 8,678 already certified states and 70 accepted blocks; 8,678 + 15,977 gives the final 24,655. The subsequent resumed accepted run used another receipt, identified in `resume_acceptance.json`; the diagnostic repaired run and resumed run must not be counted twice as new P facts.

## 3. Complete scans of actual historical layers

Sources: `runs/lean_table_checker/ACTUAL_SCAN_ACCEPTANCE.json`, `terminal_layer34_v1/acceptance.json`, `layer33_v1/acceptance.json`, `ACTUAL_SCAN.md`.

| Layer | Unique actual rows | P | N | Chunks | Recorded start → completion, 14 September UTC | Elapsed seconds | Rows/hour | Sampled peak private bytes |
|---:|---:|---:|---:|---:|---|---:|---:|---:|
| 34 | 587,901 | 587,901 | 0 | 47 | 05:52:13 → 05:52:41 | 28.312 | 74,754,294.999 | 720,982,016 |
| 33 | 21,924,455 | 13,354,184 | 8,570,271 | 364 | 05:57:40 → 06:05:04 | 443.875 | 177,815,912.137 | 736,616,448 |
| Total | **22,512,356** | **13,942,085** | **8,570,271** | **411** | Aggregate acceptance 06:08:20 | Separate runs | — | Do not add peaks |

The denominator is 778,532,864,302 SAFE orbit positions. The completed-layer share is **0.0028916384949508375%**, not 2.89%. This is a coverage ratio of stored positions, not a completion estimate for kernel proof work.

The scans used fixed copies of real `MJGLOBAL_PN_V1` data. They checked compact decoding, both rank/unrank round trips, original-rule SAFE and the relevant P/N obligations. The specialised layer-33 checker verifies that every P source has no legal SAFE successor, and supplies a real terminal SAFE P child for each N source. It checks terminality directly, without assuming the 34-tile bound or importing an uncertified C++ child label. `TerminalBucket.row_sound` and `NearTerminalBucket.row_sound` give the mathematical bridge from successful row checks to strategies; span-composition theorems cover the chunks.

Concrete checking was performed by compiled Lean, not kernel reduction of the whole input. The historical output payloads were matched to their fixed input copies, and the aggregate receipt says all 411 chunk receipts and original payload matches passed. This sub-audit reads those receipts and hashes the selected aggregate files; it does not itself replay all rows.

At most 12 worker processes were allowed. Measured host CPU peaks were 77.9326% and 80.8190%; the latter is a sampled-window value around an 80% Job Object quota, not evidence that the configured quota was raised.

Negative tests rejected a flipped P/N bit, a bad directory and a truncated bit file; the valid control was accepted. A separate actual-table pause/resume experiment preserved 2,048 rows and two receipt hashes, completed 32,768 rows, and reran **zero committed chunks**. Its coverage credit was zero because those rows repeat existing coverage. Exact paths are `table_negative_probes_20260914T155729/result.json` and `scan_resume_test_20260914T160027/operational_acceptance.json`.

## 4. General-row feasibility and short rule benchmarks

### 4.1. Repeated rule benchmarks

`summary_full_v1/acceptance.json` records 5,937,500 four-block local-summary rows, 183 chunks, completed at 14 September 05:32:38 UTC in **45.672 s**, at most eight workers, with sampled peak **388,173,824 bytes**. These are local inputs, not global P/N rows.

For the same eight layer-23 fixture states and eight worker processes, the retained repeated rule-only benchmarks report:

| Entry | Repeated evaluations | Distinct states | Wall seconds | Evaluations/s | Sampled peak private bytes |
|---|---:|---:|---:|---:|---:|
| FactorBenchmark | 512 | 8 | 3.140 | 163.0573 | 308,113,408 |
| ExactMemoBenchmark | 512 | 8 | 1.515 | 337.9538 | 326,258,688 |
| PreloadedBenchmark | 8,192 | 8 | 0.953 | 8,596.0126 | 395,673,600 |

Sources: `exact_memo_benchmark_v1/result.json` and `preloaded_benchmark_v1/result.json`. The often quoted approximately 25-fold improvement compares the second and third rows. It concerns repeated rule/successor checks, excludes general bucket references and P/N table lookup, and uses unequal repetition counts. It is not a 25-fold full-table speedup. Additional fixtures comprise 48 fixture rows but 41 distinct states. The `FlatRules` alternative was proved equivalent and sampled, but its benchmark overlapped the production scan and did not establish a speed benefit; it was not substituted into the running scanner.

### 4.2. General adapter and the 30-day gate

`GENERAL_FEASIBILITY.json`, dated **14 September 07:01:29 UTC**, records **47 completed cases**, **745,472 row evaluations** and **356,352 distinct sampled source positions**. This sub-audit recomputed interval unions from all 38 general-benchmark cases and nine peak-parallel cases: **258,048 distinct positions in layer 32 and 98,304 in layer 23**. Repeat configurations and overlapping windows account for the difference between evaluations and positions. They receive no credit in the completed-layer count.

Each sampled row checks original SAFE, source rank/unrank consistency, all legal physical successor references with symmetry restoration, and the P/N recurrence. The general soundness theorem explicitly assumes correctness of the referenced target layer. Layer-32 target inputs were matched to the already scanned layer-33 data; layer-23 targets use layer-24 labels without a completed Lean layer certificate. The layer-23 measurements therefore show row-equation and reference-check success, not independent whole-game strategy certificates.

Observed hardware in the feasibility receipt is **Intel Core i7-10700KF, eight physical cores, 16 logical processors, 34,253,983,744 visible physical-memory bytes**, with 19,869,368,320 bytes available at the test's start. No GPU or cloud resource was used or included in the estimate.

| Quantity | Layer 32 | Layer 23 |
|---|---:|---:|
| Selected source buckets | 148, 106, 149, 151, 107, 152, 109, 70 | 15, 5, 35 |
| Fraction of layer capacity in those buckets | 0.961171770228946 | 0.3565727126014669 |
| Better measured configuration | 12 processes × 1 thread | 2 processes × 6 threads |
| Weighted scan rate, rows/s | 25,921.480222667513 | 2,567.3159882828045 |
| Weighted scan rate, rows/hour | 93,317,328.80160305 | 9,242,337.557818096 |
| Peak23 sampled process private memory | — | 10,193,907,712 bytes |

The selected-bucket capacity fractions **are not fractions of the layer actually checked**. Windows were selected systematically at quarter, midpoint and three-quarter positions, and parallel comparisons repeated windows. The rate is the reciprocal of the selected-bucket size-weighted mean seconds per row. It excludes repeated startup and input loading; the full logs retain end-to-end rates. This is not an IID sample or confidence interval and did not test sustained thermal behaviour.

Completing 778,532,864,302 rows in 30 days would require **300,359.9013510802 rows/s** throughout: about **11.5873 times** the layer-32 rate or **116.9937 times** the measured peak-layer rate. Arithmetic scenarios, expressly **not forecasts or strict lower bounds**, are 347.6189 days if every row cost the selected layer-32 mean, or 3,509.8122 days if every row cost the selected layer-23 mean. The measured peak-bucket range yields 2,639.6264–4,078.3179 days; the three selected peak buckets alone yield 154.7537 days under their measured rates. These scenarios cannot be converted directly to a cloud-core requirement.

In one peak window, one process improved only from approximately 705 rows/s at one thread to 1,906 at 12 threads; two processes with six threads reached approximately 2,406 rows/s. This is measured non-linear scaling, not a diagnosis of a particular lock or allocator. The general and peak campaigns took 117.812 and 139.266 s including their recorded initial hashing phases. Source-label flipping, deleting a target bucket and removing a symmetry-restoration path were all rejected. The accepted decision is **DO_NOT_START_FULL_SCAN_CURRENT_IMPLEMENTATION**; no general full campaign was launched.

## 5. Finite validation chronology and exact coverage units

The following accepted stages are incremental in scope, but their input domains often overlap. Times concern the stated native check stages, excluding theorem development and usually compilation/export/hash preparation. They must not be summed into a single from-scratch campaign time or used as P/N throughput.

| Fixed acceptance, UTC on 14 September | Actual finite data or probes | Native check timing | Failure/control evidence |
|---|---|---|---|
| `pruning_spike_v1`, 10:31:04 | 5,937,500 four-block raw rows; 2,031,250 distinct local codes; 46 chunks | 4.797 s | 5 corruptions rejected; 1 valid control |
| `full_safe_v1`, 11:01:53 | Same domain, now stronger full-SAFE equality checks; 46 chunks | 7.516 s | 9 corruptions rejected; 1 valid control |
| `canonical_inventory_v1`, 11:34:09 | 5,937,500 raw block rows; 395,212 block-member rows; 9,687,500 generator applications; 62 chunks | 5.204 s; sampled workers 566,693,888 bytes | 12 corruptions rejected; 2 controls; real stop/resume reuses 9 chunks and computes 53 |
| `group_directory_v1`, 12:48:14 | 1,104 groups, 131,676 numeric members, 37,852 bound-envelope pair checks; all 3,199,905 candidate triples; all 60,789,499 directory blocks and 588,782,520 candidate/honour membership tests | Structure 1.860 s; prefixes 10.484 s; semantics 33.953 s; maximum sampled workers 2,329,845,760 bytes | 37 corruptions rejected; 7 controls; structure resume 12 old + 11 new chunks; directory resume 1 old + 231 new |
| `index_algorithms_v1`, 13:36:47 | All 5,791,906 arithmetic-helper inputs; 1,104 group rows; C++ public APIs tested on all 3,199,905 candidate keys with 28,543,652 selected offsets and 85,630,873 cursor advances | 3.281 s finite controller; C++ probe internal 1.67912 s; peak 1,117,425,664 bytes | 10 corruptions rejected; 2 controls; resume 1 old + 24 new chunks |
| `global_orbit_v1`, 14:19:26 | Rechecks 60,789,499 directory rows, all 6,440 slices and 588,782,520 memberships, binding actual slices to the composed enumeration specification | 25.735 s continuation; 5.219 s pilot separately; peak 2,626,867,200 bytes | 9 kernel rejection controls, 2 kernel positive controls; resume 1 old + 183 new chunks |
| `word_refinement_v1`, 14:58:11 | 6,440 directory headers, 206,080 header bytes only; prior group/directory data reused; local C++ ABI probe | Header extraction 0.937 s; ABI compilation 4.031 s; sampled compile peak 445,739,008 bytes | 19 kernel control assertions |
| `decoder_refinement_v1`, 15:22:23 | Inherits the 5,791,906 checked helper outputs in 23 exact covering chunks, 1,104 groups and 6,440 headers; no new native finite run | No repeated helper/full-directory execution | 20 kernel control assertions |
| `successor_cache_v1`, 15:54:37 | All 131,860 distinct actual local records; all 743,869 cached edges; 1,186,372 candidate attempts, of which 1,099,983 are available additions; 10 chunks | Pilot 1.937 s + continuation 0.953 s = 2.890 s; exporter 1.906 s, export compile 4.704 s separately | 16 corruptions/illegal requests rejected; 2 valid controls; 1 old + 9 new chunks, old receipt unchanged |
| `optimized_retro_v1`, 16:38:57 | Optimised models plus bounded synthetic C++ operational tests detailed below | Inner exercise 10.0695 s; outer exercise 10.735 s | 8 kernel controls, 129 word-control cases; 21 operational rejections and 4 operational controls |

Every row adds **0 historical P/N certification positions**. The current aggregate retains the existing 22,512,356 scanned positions throughout.

Important count identities and overlap boundaries:

- Raw numeric codes: 5^9 = 1,953,125; raw honour codes: 5^7 = 78,125. Their distinct sum is **2,031,250**. Checking all three numeric block positions plus honours gives **3×5^9+5^7 = 5,937,500** records. Repeating that domain for stronger predicates does not create new distinct codes.
- Distinct retained local members: **131,676 + 184 = 131,860**. Three numeric blocks plus honours account for **3×131,676+184 = 395,212** member rows. The 9,687,500 generator applications equal 3×5^9 + 49×5^7; they count applications, not distinct group elements or orbit positions.
- **6,440 = 35×184** logical `(layer, honour-class)` buckets includes empty buckets. It must not replace the historical count of **3,686 nonempty P/N payload buckets**. The directory has 60,789,499 blocks across the whole logical family.
- **588,782,520 = 3,199,905×184** candidate/honour membership tests. They are tests of metadata semantics, not that many distinct full-game states. The later global-slice stage repeats this underlying domain with stronger slice bindings.
- The helper interval `[0, 5,791,906)` was exhaustively checked. The C++ index probes, by contrast, use selected offsets per candidate key, not every coordinate or every honour bucket. Their 60 terminal probes and mode-block counts `[3,138,840, 45,116, 15,833, 116]` document branch coverage, not full operational refinement.
- Word-stage maximum accepted bucket metadata was 416,551 blocks and 12,297,042,846 positions. Reading 32-byte headers does not reread the block payloads or P/N data. The accepted ABI probe observed 8-bit bytes, 2/4/8-byte unsigned words, 8-byte `size_t`, 4-byte `int` and little endianness; it explicitly did not construct `Index` or solve P/N.
- Actual successor arrays contain **743,423 numeric edges and 446 honour edges**. The three numeric suits use the same frozen numeric files, and a kernel transport theorem supplies all three blocks from this one local check, without pretending to have run it three times.

The local/full-SAFE and canonical proofs encountered slow simplification and the 3 GiB kernel memory ceiling during development. Generalised positional-value and parameterised block lemmas replaced large concrete unfolding. The final full-SAFE connection build took about 3.67 s and the final canonical connection about 1.86 s, after caching; these are final build times, not total proof-development durations. The finite optimized package similarly reduced imports after one broader dependency build hit `-M3072`. Failed attempts remain in the corresponding `attempts/` directories and are not successful proof evidence.

Three intentionally corrupted directories remained contiguous after their metadata was adjusted: an omitted legal entry, an altered block width with a correspondingly altered total, and entries swapped between layers. The interval checker accepted them as contiguous, while the semantic directory checker rejected them. This is particularly useful evidence for explaining why address coverage alone is insufficient to establish correct enumeration.

## 6. Frozen optimised solver: bounded operational evidence

Primary records: `optimized_retro_v1/operational-acceptance.json`, `operational-binding.json`, `operational/result.json`, and `source-map.json`. The operational acceptance is dated **14 September 16:12:51 UTC**, preceding the final theorem package.

The test includes unmodified frozen `global_retro.cpp` and calls its actual `MovePlans`, `solve_bucket`, `Work`, `Tables` and `valid_complete` routines. It supplies artificial child labels, never historical P/N outcomes. Configuration patterns are all-zero, all-one, mixed, numeric-child-only P and honour-child-only P. Ten source buckets use all five patterns; the terminal bucket needs only one. Each bucket-pattern case is run with one and eight threads, using 64- and 256-row chunks.

| Layer | Honour bucket | Distinct source addresses | Artificial patterns |
|---:|---:|---:|---:|
| 5 | 0 | 6,946 | 5 |
| 8 | 1 | 135,710 | 5 |
| 12 | 8 | 135,710 | 5 |
| 16 | 76 | 135,710 | 5 |
| 20 | 60 | 172,714 | 5 |
| 24 | 54 | 104,022 | 5 |
| 28 | 180 | 171,743 | 5 |
| 31 | 168 | 147,651 | 5 |
| 32 | 108 | 176,440 | 5 |
| 33 | 109 | 176,440 | 5 |
| 34 | 149 | 55,178 | 1 |
| Total | 11 buckets | **1,418,264** | **51 bucket-pattern pairs** |

These are complete selected small source buckets, not random samples of all rows. The independently recomputed distinct-address total differs from the workload counters:

| Work or control quantity | Count |
|---|---:|
| Paired one-/eight-thread solver configurations | 102 |
| Naïve reference row evaluations | 6,870,608 |
| Solver row outputs | 13,741,216 |
| Reference edge visits | 185,054,540 |
| Precomputed-plan group-block endpoint probes | 3,496 |
| Target-offset probes | 82,390 |
| Duplicate-suit occurrences | 235,845 |
| Occurrences requiring nontrivial sorting | 49,434,165 |
| Rejected corrupt/incomplete operational assertions | 21 |
| Accepted operational controls | 4 |
| Historical P/N inputs | 0 |
| New historical P/N certification | **0** |

All comparisons passed, including 51 byte-identical one-thread/eight-thread output pairs. The final read-only acceptance checked tails, P counts, checksums, checkpoint chunk layouts and progress for all 102 completed outputs. Its `operational-binding.json` explicitly records zero new solver-row replay and zero historical payload bytes read: it inspects retained synthetic outputs.

The resume test deliberately commits a **middle** 64-row chunk of the 6,946-row source bucket, not a prefix. It preserves those 64 rows and calculates only the remaining **6,882**, yielding the same final file as a normal solve. Other accepted controls cover dirty uncommitted data, a simulated payload-rename window, and valid dependency reads. This is evidence for these file states, not every operating-system crash or power-loss sequence.

Corruption rejections cover incomplete finalisation, wrong magic/header/version/layout/fingerprint, done flags, checksums, P counts, trailing bytes, truncation and data damage. Kernel controls separately cover correct and incorrect layer orders, missing dependencies, repeated processing, an omitted real move changing the answer, a forged zero-P bucket summary and a failure of two-swap sorting without the required increasing-ID premise. Word controls include all 64 tail masks and single-bit positions; the 129 cases are finite controls rather than another P/N census.

The internal exercise measured **10.0695 s**, versus **10.735 s** for the surrounding invocation. Compilation took **8.312 s** and inventory setup **1.594 s**, separately. Sampled maximum process-tree private memory was **1,273,151,488 bytes**. The hard limits were 15.5 GB and 80% CPU, with at most eight solver threads. These measurements establish practical bounded tests, not a projected Lean replay rate for historical outcomes.

The final package incorporates 17 rehashed primary historical receipts, with retained global figures 778,532,864,302 states, zero reverse-replay mismatches and 16,240 historical oracle matches. It records no new full historical-payload read. The two historical recurrence directions share foundational rules and indexing; their agreement remains computational cross-validation, not two independent formal models.

## 7. State, provenance and manuscript wording

The latest finite package is complete **within its declared scope**: mathematical model proofs, finite input checks under the compiled-execution boundary, source correspondence and bounded production-routine tests. `remaining_finite_scope = []` does not erase the separately listed uncompleted universal C++ refinement, literal whole-solver certificate and historical-output binding.

The explicit daemon's STOP and preserved database are retained; the old two-hour automation is reported paused. Actual scans of layers 34 and 33 have completed and exited. The general full scan was not launched. A/B full replay remains paused, and the latest acceptance reports no running workers, new background tasks, subagents or cloud launches. This audit did not invoke any of those mechanisms; statements about their settings refer to the dated retained status, not a new Windows scheduler inspection.

Avoid these possible overstatements in the supplement:

- Do not call 24,655 a newly certified increment, 15,977 the whole daemon increment, or 283 a count of P states.
- Do not combine 745,472 repeated evaluations with 22,512,356 complete-layer positions, or describe peak-layer row equations as independent strategies without target correctness.
- Do not turn selected-bucket mass fractions into checked-layer fractions, local-data rates into global P/N throughput, or short timing scenarios into forecasts.
- Do not treat every directory/helper/cache check as a fresh global state, or count inherited helper/metadata checks twice.
- Do not identify source-byte correspondence or limited actual-C++ tests with a universal proof of C++ pointer, vector, allocator, floating-point, compiler and I/O semantics.
- Do not describe the finite package's scope completion as a closed empty-game Lean proof. The computed second-player result and its remaining end-to-end formal certification are separate claims.

The 51-file SHA-256 ledger and the extracted acceptance objects are in `empirical_evidence.json`. Eight available immediately preceding acceptance links were recomputed and matched. The additional interval-union, seed-membership and PASS-batch disjointness checks all passed. To reproduce only this lightweight source audit, run the pinned Python on `runs/lean_supplement_20260915/empirical_extract.py`; it writes only this supplement's JSON and does not start a proof, scan or daemon.
