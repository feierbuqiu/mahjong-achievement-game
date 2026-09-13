> Archived evidence from the dated local research record. Historical progress and commands describe that record; current supported commands are in the repository reproduction guide. Links to retained attachments lead to their availability entries.

# Lean evidence memo for the 13 September 2026 paper

Prepared by the delegated Lean audit agent. Scope: read-only inspection of retained Lean sources, successful compilation receipts, independent semantic reviews and measured runs. No game search or Lean compilation was rerun. Only this memo was written. Paths below are relative to the research root unless stated otherwise.

## Findings that should govern the paper

1. A **specific 12-tile position is an unconditionally proved P position in the original achievement game**. The exact theorem is `Mahjong.Scale12V2.original_second_player_wins : Mahjong.SafeGame.SecondPlayerWins Mahjong.Step Mahjong.Win Mahjong.Scale12V2.original`. Its counts are `0000000020000011110001110300000000`, or **99m 6789p 456888s**. Here m/p/s denote characters/circles/bamboos. It contains two 9m; one each of 6p, 7p, 8p, 9p, 4s, 5s, 6s; and three 8s. It has no honours.
2. This is a real branch of the native opening candidate graph, not a proof that either player can force that branch from the empty position. No premise-free empty-state Lean theorem is present in the audited import closure. `empty_wins` and similarly named bridges taking a `ProvedP empty` or certificate argument are **conditional lemmas**, not a solved opening.
3. The latest certificate is independent of the correctness of the C++ labels, the global bit payload, its rank/unrank implementation, SAFE ≤ 34, and the older SG reductions. The native program proposes data; Lean checks physical legal moves, actual winning subsets, SAFE bounds, exact symmetry references and well-founded proof dependencies. Thus possible objections to global-table evidence do not invalidate this concrete Lean theorem. This memo makes no fresh acceptance claim about the 97 GB native table; that is a separate computational audit.
4. Two formalisation lines exist. The older `SharedMahjong` line uses **Lean 4.33.0 and Mathlib**, and has useful completed foundation theorems, including the four-meld extension and predicate invariance of an honour's fourth copy. The latest independently defined `Mahjong` line uses **Lean 4.33.1 and Lean/Std**, plus local modules. Do not silently merge their toolchain claims or claim that all historical mathematical results have been ported.
5. The final root has only `propext`, `Classical.choice`, and `Quot.sound` in its transitive axiom set. There is no Mahjong-specific axiom, `sorryAx`, or native decision axiom. These logical foundations should be separated from the **game's stipulated rules**, which are definitions, not asserted P/N facts.

Historical `START_HERE.md`, `RESEARCH_HANDOFF.md`, `STATUS.json`, and `AGENTS.md` describe the migration-era UNKNOWN snapshot. Conversely, `lean_verification/README.md` describes a later global computational claim and links a nonexistent `FINAL_REPORT.md`. Neither is an adequate sole authority for the paper's current Lean status. Use the exact completed receipts below.

## Rechecks actually performed for this memo

The retained `runs/lean_scale/verify_evidence.py` was imported with Python `-B` and only its read-only `kernel` functions called, not its writing `main`. This independently rehashed **2,892 retained files across seven linked successful receipts**, and checked **1,514 dependency-exact object reuse edges**. Both the 326-module root receipt and 327-module registry receipt passed. This is a receipt/object/source integrity recheck, not a new Lean proof run.

The entire checking portion of `runs/lean_scale/theory/review_actual12_sources.py` was also re-executed in memory with its final report-writing statements omitted. All 757 row definitions, SAFE containment assignments, 25,510 physical first moves, legal second moves, explicit targets, internal references, external references, data-tree row coverage, 95 group slices and the root's exact digits passed again; sources remained unchanged. It reported 0.750 seconds for this read-only semantic recheck. No game solver or Lean process was invoked. The script's retained version and output remain unchanged.

Current source hashes of both copies of historical `SharedMahjong.lean` match the successful old Basic compilation log; the current historical `Lemmas.lean` matches its logged source hash. A source scan of the latest 327-module closure found imports only from `Lean`, `Std`, `Mahjong`, `MahjongNext`, and `MahjongScale`, and no noncomment occurrences of `sorry`, `admit`, `native_decide`, `implemented_by`, or custom `axiom` declarations. The transitive axiom audit, rather than this supplementary text scan, is the relevant logical acceptance evidence.

The earlier 680-module `runs/lean_continuation/kernel_v1` chain was also rehashed separately: **680 source snapshots, 680 objects and 680 successful command logs** all match its receipt. This covers the concrete 20/28/30/32-tile theorems named below. Its receipt SHA-256 is `724532e50026bf98a26e98859f0c5d633415b809f560f327b95470456f5dc241`. Again, this was read-only integrity verification, not recompilation.

## Definitions and foundational results already formalised

### Current Lean 4.33.1 line

Source modules are under `build/lean_verification/Mahjong/`; accepted frozen copies are in the `source/` directories of the cited receipts.

| Topic | Exact declarations or module | What is established; relevant conditions |
|---|---|---|
| Physical stock and states | `Rules.lean`: `Tile := Fin 34`, `Copy := Fin 4`, `State := Tile → Nat`, `Valid`, `LegalAdd`, `Step` | Validity is count ≤ 4; a move adds one kind with remaining stock. There are 136 physical copies. |
| Containment and shapes | `Contains small large`, `Meld`, `Standard`, `SevenPairs`, `ThirteenOrphans`, `WinningHand`, `Win` | 34 triplets and 21 same-suit sequences; four melds plus pair; seven **distinct** kinds paired; exact 13 terminal/honour kinds plus one repeated kind. `WinningHand` requires Valid. `Win` is containment of a target, allowing extra shared-table tiles. |
| Target sizes | `winningHand_total`, `win_iff_contains_14`, `win_total_ge_14`, `not_win_of_total_lt_14` | Every admitted winning target has exactly 14 tiles; no table below 14 can contain one. |
| Finite game and genuine achievement | `step_stock_strict`, `total_le_136`, `full_win`, `nonwinning_has_legal_add`, `nonwinning_has_step` | Stock decreases, and a valid nonwinning state always has a legal move. The full stock explicitly contains a legal winning hand, eliminating exhausted-stock draws. |
| Monotonicity and SAFE base | `win_mono`; `DownwardClosure.safe_of_contains`, `unsafe_superset`; `Bridge.safe_of_total_le_12`, `empty_safe`, `first_move_safe` | Winning is upward closed; SAFE is downward closed under containment in a valid SAFE upper state. Any table of at most 12 tiles is SAFE in the current predicate; physical conclusions also require validity. No P/N monotonicity is claimed. |
| Abstract P/N | `SafeGame.NormalStrategy`, `PNCertificate.sound`, `normalStrategy_not_both`, `local_certificate_sound` | P covers every child with N, N supplies a P child; exact local equations with a decreasing natural rank give finite strategies. P and N cannot both hold. Generic assumptions remain visible in the theorem types. |
| SAFE reduction | `SafeGame.safe_reduction`; `Bridge.original_safe_reduction` | At a SAFE source, normal play restricted to SAFE successors has the same P/N strategy meaning as the original achievement game. |
| Actual winning semantics | `SafeGame.WinningStrategy`, `achievement_meaning`, `SecondPlayerWins`, `safe_p_second_player_wins` | Leaves are actual winning achievements, not merely no-move states. The bridge explicitly needs domain closure and the no-stuck property; `Rules` supplies both for physical Mahjong. |
| Complete quotient condition | `Quotient.TransitionQuotient`, `normalStrategy_lift`, `normalStrategy_descend`, `normalStrategy_iff`, `quotient_certificate_sound` | Forward coverage of **every physical move** and physical realisability of every quotient move preserve strategies. Injectivity is unnecessary. This is a generic theorem, not formal acceptance of the existing C++ quotient/index. A three-state omitted-edge counterexample is formalised. |
| Rank arithmetic | `Ranking.twice_tri`, `six_times_tet`, `rank2_bounds`, `rank3_bounds`, `rank2_injective`, `rank3_injective`, `rank2_lt_group_size`, `rank3_lt_group_size` | Sorted colex pair/triple ranks have the proved bounds and injectivity over unbounded naturals. No complete C++ rank/unrank proof, overflow proof, or all-state enumeration proof follows automatically. |
| Symmetry | `Symmetry.lean`, `Generators.lean`, `Generators.checked_reference_sound` | Tile renamings with explicit target-shape witnesses preserve validity, all three winning forms, legal moves, SAFE and P/N. All three numeric suit reflections, all suit swaps, all honour swaps and all finite words in these generators are covered. References compare all 34 actual counts; canonicaliser correctness is not assumed. |
| Rule decisions and moves | `RuleChecker.winB_iff`, `safeB_iff`, `winB_iff_valid_and_win`, `safeB_iff_valid_and_safe`; `MoveEnumeration.safeSuccessors_iff` | Executable hand and SAFE checks are equivalent to the independent definitions. Physical successor-list membership is equivalent to a legal SAFE step, including complete coverage. Invalid states are handled by explicit guards. |
| Faster rule checks | `FastRuleChecker.lean` equality theorems | Local availability and subtraction improvements are pointwise equal to the reference rules, not merely matched on samples. |
| Explicit positive witnesses | `FullWinWitness.shape_sound`, `sound` | A checked supplied four-meld, seven-distinct-pair or thirteen-orphans target yields Win when contained in the valid resulting state. A repeated pair kind is explicitly rejected as a seven-pairs witness even if its aggregate tile counts are valid. |
| Negative local capacities | `StandardBoundCertificate.local_negative_bound`, `checkStandardBound_sound`, `checkNoWin_sound`, `checkSafe_sound` | After every available pair is removed, four local meld-capacity bounds with sum < 4 exclude every ordinary hand. Each bound is independently checked by local search. Seven pairs and orphans are excluded separately. Rejection is inconclusive. |
| Safe total optimisations | `certifiedStandardB_eq`, `certifiedWinB_eq`, `certifiedSafeB_eq` | The optimised total decision procedures fall back to proved reference checks when an untrusted capacity certificate is rejected; equality holds for arbitrary proposals. |
| Reusable local capacity patterns | `MaskedLocalBound.search_local_eq`, `search_mask_eq`, `transfer_false`; `CachedStandardBounds.transfer_upper`, `CachedLocalBound.sound` | Local search depends only on its 9- or 7-kind block; a checked negative capacity bound transfers to componentwise smaller patterns. This is **not** a P/N game-state quotient. |

The important source explanations are `runs/lean_verification/theory_v1/README.md`, `runs/lean_verification/rules/README.md`, `runs/lean_verification/final_review.md`, and `runs/lean_continuation/rules/README.md`. Current closure integrity was checked through the latest receipts. The rule-execution cross-check of 185 C++/Lean test states in `runs/lean_verification/FINAL_STATUS.json` is explicitly **execution-only**, not 185 kernel-certified table entries or a complete proof of C++ profile equivalence.

### Historical Lean 4.33.0 + Mathlib line

`mahjong_round2/lean/SharedMahjong.lean` and `deliverables_round2/SharedMahjong.lean` have SHA-256 `fdebb17ad9bf8a8917a47da435bd294f16d63bd4b84a35215a8903fea81f84d9`, exactly the Basic source recorded by `lean_verification/existing_lean_audit/basic_compile.log`. The successful recorded compile took 34.224 seconds. Its base definitions use `Contains large small`, opposite argument order to the current line.

The particularly useful historical results are:

- `SharedMahjong.four_meld_extension`: if valid SAFE x contains a 12-tile four-meld multiset D, every strictly larger coordinate satisfies D_i = 3 and x_i = 4. Its proof shows that any excess over a D_i ≤ 2 either already supplies a pair or allows a one-step pair completion.
- `SharedMahjong.four_meld_candidates`: a four-meld multiset has at most four coordinates equal to 3. Together these supply a precise four-meld endgame base; they do not prove every subset of upgrades SAFE or a global SAFE maximum.
- `nonwinning_has_legal_move`, `stock_strict`, general ranked `solve`, `certificate_sound`, `partial_certificate_sound`, `checkCertificate_sound`, and `response_invariant_losing`.

`lean_verification/existing_lean_audit/Lemmas.lean` has SHA-256 `f71bf6cd4d22391b90777aa118e410e625bd5987827db58535a190abb1d242d9`, matching `lemmas_compile.log` (exit 0; 36.172 seconds). It adds `contains_trans`, `win_mono`, `add_add_comm`, `safe_downward`, target-size lemmas, `safe_of_size_le_12`, `safe_empty`, `safe_single`, `safe_reduction`, `empty_reduction`, and `first_move_reduction`.

It also proves `winning_honor_le_three`, `win_add_honor_iff`, and `safe_add_honor_iff`: **adding the fourth copy to an honour already counted three preserves Win and SAFE**, the latter with source Valid. Its source expressly says that the game-theoretic xor identity is not formalised. The logged axiom reports for both old modules contain only the same standard three axioms. This older line is reported from retained successful logs and matching source hashes; it was not recompiled for this paper and is not silently part of the latest 4.33.1 certificate closure.

## Certificate architecture and why the root is unconditional

`ResponseCertificate.ProvedP s` packages Valid, SAFE and `NormalStrategy SafeMove s P`. `Responses s` quantifies over **every** `first : Fin 34` for which `LegalAdd s first`; it is not restricted to only exported SAFE graph edges. Each `Reply` requires a legal second step and either an actual Win proof or a previously proved physical P state. `node` assembles this into P, and `ProvedP.secondPlayerWins` supplies original achievement meaning.

SAFE must be proved for the source: otherwise an opponent can already win on the first step before the proposed reply. A specific 13-tile counterexample is checked in `runs/lean_continuation/theory/ResponseCertificateTest.lean`. SAFE can be inherited from any componentwise valid SAFE upper state through `node_of_safe_extension`; that upper state need not be reached by the chosen strategy.

`Mahjong.ResponseTable.checkDatabase_sound` reflects these facts into a balanced-tree table. Every P row covers all legal physical first kinds; N nodes need not be stored. A return checks second-move stock, successful exact ID lookup, **ref < current row ID**, and equality of the physical two-step successor with a proved state after a finite symmetry path. The strictly decreasing proof ID prevents circular assumptions. `ResponseGroups.checkRange_append` and `checkDatabase_of_full_range` combine disjoint adjacent slices of the full tree and check coverage of its entire row list.

`Mahjong.ExternalResponses.PFact` stores both a state and its actual `ProvedP` proof. The registry is constructed from an already checked table's soundness theorem, not from JSON P labels. External overrides check physical equality and legal stock against these typed facts. A selected missing registry entry fails; it cannot silently fall back to another action. External IDs and local decreasing IDs are separate namespaces.

`Mahjong.Scale.FastPositive.check_eq` and the FastExternal row/range/database equality theorems justify the improved checkers on **all inputs**. Ordinary hand witnesses use sequential availability and subtraction of the supplied melds/pair, avoiding repeated reconstruction of the same 14-tile target. The 12-tile groups prove the faster Boolean equality by `decide +kernel`, then transfer it to the original checker through the equivalence theorem.

## Completed concrete roots and certified scope

Do not add counts from different certificates: the roots, internal states, dependencies and generated declarations overlap. A count of audited declarations is not a count of new mathematical discoveries.

| Tiles | Exact physical state | Original-game theorem | Retained successful evidence |
|---:|---|---|---|
| 12 | `0000000020000011110001110300000000` = 99m 6789p 456888s | `Mahjong.Scale12V2.original_second_player_wins` | `runs/lean_scale/actual12_kernel_v1/result.json` |
| 14 | `0000011110001000020001120300000000` = 6789m 499p 4566888s | `Mahjong.Actual14.original_second_player_wins` | `runs/lean_next/actual14_kernel_v2/result.json` |
| 20 | `0110330311010110001010110000000000` = 235556668889m 1356p 1356s | `Mahjong.AnchorDAG.N24086.original_second_player_wins`; later `Mahjong.ResponseTableFull20.original_second_player_wins` and `Mahjong.ResponseTableGrouped20.original_second_player_wins` | `runs/lean_continuation/kernel_v1/result.json`; `runs/lean_next/reflected20_kernel_v1/result.json`; `runs/lean_next/theory/groups/grouped20_v3/result.json` |
| 28 | `0110440411010110101010110000001111` = 235555666688889m 13568p 1356s 4567z | `Mahjong.AnchorDAG.N09818.original_second_player_wins` | `runs/lean_continuation/kernel_v1/result.json` and `Mahjong.AnchorDAG.N09818.log` |
| 30 | `0110440411010110111010110000011111` = 235555666688889m 135689p 1356s 34567z | `Mahjong.AnchorDAG.N02076.original_second_player_wins` | `runs/lean_continuation/kernel_v1/result.json` and `Mahjong.AnchorDAG.N02076.log` |
| 32 | `1010110110000440411010110111111111` | `Mahjong.Extracted32.original_second_player_wins` | `runs/lean_continuation/kernel_v1/result.json` |
| 34 | `1010440410110110111010110111111111` | `Mahjong.ExtractedFresh34.original_second_player_wins` | `runs/lean_continuation/pipeline_kernel_v1/result.json` |
| 34 | `0110440411010110111010110111111111` | `Mahjong.ActualCertificateSmoke.candidate_original_second_player_wins` | `runs/lean_verification/kernel_v2/result.json` |

The first 34-tile anchor has 31 legal first kinds; each receives an explicit winning second move: after 2m or 3m, play 4m; after any other legal first kind, play 1m. Its original witness data use 18 ordinary and 13 thirteen-orphans hands. This provides a readable concrete strategy base.

For the two z strings above the internal convention is 1–7 = East, South, West, North, White, Green, Red. The 28- and 30-tile statements are actual unconditional internal-root theorems in the earlier 610-P-node certified DAG. Separate `runs/lean_next/endgames/raw28_v1` and `raw30_v1` summaries report candidate-closed graphs of 15 nodes/27 edges and 10 nodes/14 edges; those native summary files are not themselves Lean certificates. Their exact requested root states nevertheless match the older certified nodes above. Their accepted root objects have SHA-256 `09a52f7ac1ad6e1789f38ed039ba96f6d6de45a309ec0f6f24ec2a0d80357a53` (28 tiles) and `41737a6e2142e9dcc4bbe1f3cd10ee7ba39ea5f3c3156cc16a945fabb7ca7cab` (30 tiles).

The original 20-tile proof used 610 selected P nodes and seven two-ply levels; the clean receipt reports 680/680 modules, 14,760 audited declarations, 548.516 seconds, four workers. A different response choice plus symmetry sharing reduced the **same exact root** to 24 P rows. The 24-row whole-table proof took 15.484 seconds with 2,246,823,936 peak private bytes; grouping took 23.969 seconds with 1,513,234,432 peak private bytes. Grouping lowered memory in this sample but was slower; neither measurement bounds the empty-state certificate. The 14-tile certificate has 50 P rows, 1,700 legal first kinds, 1,383 positive replies, 317 internal returns and six independent SAFE leaves (two of 24 tiles, four of 26). Its accepted v2 receipt has 40 modules, 15 reused/25 new, 606 audited declarations, 44.438 seconds. These earlier measurements are retained, not rerun here.

## Exact 12-tile result

Its opening-candidate ID is **652738**, extracted graph source ID **0**, local proof row **756**. These are different ID spaces. The closed candidate graph has 2,753 nodes, 6,756 one-tile edges, **790 candidate P nodes**, and reaches the 26-tile layer. The graph's own `formal_proof=false` was correct at generation; subsequent Lean acceptance, not that status flag, proves the root.

Reusing the prior Actual14 table removed 33 candidate P rows. The new table retains **757 local P rows**, cuts at **11 external boundary states**, and uses **80 external returns**. There are 13 local rows containing external overrides. It has the following complete reply decomposition:

| Item | Count |
|---|---:|
| Legal physical first moves over all 757 rows | 25,510 |
| Ordinary winning replies | 20,776 |
| Thirteen-orphans winning replies | 91 |
| Internal returns to a smaller local ID | 4,563 |
| Returns to proved Actual14 registry facts | 80 |
| Seven-pairs replies in this particular data | 0 |

The four nonzero reply counts sum exactly to 25,510. All 34 first kinds are legal at the 12-tile root itself. Seven pairs remain part of the game and the proved generic witness checker, despite absence from this concrete positive-witness sample.

SAFE origins consist of **86 independent raw leaves** (39 at 24 tiles, 47 at 26) and SAFE projections of **four** already proved Actual14 rows (20, 21, 23, 26). Those sources do not depend on the current root. Each current row is independently checked contained in its assigned transformed SAFE upper state. The SAFE leaf API proves validity and SAFE only; being a SAFE leaf does not by itself mean P.

V2 partitions row data into **12 modules** (11 × 64 + 53 rows), and checker computations into **95 contiguous groups** (94 × 8 + 5 rows). The root imports all groups and combines them with 94 adjacent-range compositions to cover [0,757); a further kernel fact confirms complete actual-tree coverage. The V1 monolithic data attempt exceeded its process memory budget and is not accepted proof evidence.

| Accepted stage | Modules; reused/new | Wall time | Sampled aggregate private peak | Maximum concurrent Lean processes |
|---|---|---:|---:|---:|
| Independent 86 SAFE leaves | 183; 9/174 | 120.953 s | 8,844,169,216 B | 10 |
| Split-data V2 pilot | 232; 211/21 | 55.750 s | 4,712,509,440 B | 4 |
| Complete root | 326; 231/95 | 67.266 s | 12,719,529,984 B | 9 |
| 757-row reusable registry | 327; 325/2 | 6.375 s | 2,432,184,320 B | 1 |

The pilot's 4.71 GB is an **aggregate** figure, not a single Lean process: its largest recorded process private value is 2,421,895,168 B. The final root run configured 12 workers, a 15.5-billion-byte aggregate monitor ceiling, a 3-billion-byte per-process private limit and 120-second per-module limit. Actual concurrency peaked at nine. The 67.266 seconds measures a run with substantial certified object reuse; it is not a cold compile of all 326 modules. These measurements include the runner's monitored private memory, are sampled, and do not include memory of every unrelated application on the computer.

The final audit checks **1,438 theorem declarations** for allowed transitive axioms and checks the exact unconditional root type. The process runner's exit code 2 deliberately denotes that the empty theorem is absent; it is not a failure of `actual_12_tiles=PASS`. The main and registry logs explicitly state `END_TO_END_NOT_VERIFIED`.

`Mahjong.Actual12Registry.registry` now constructs a `PFact` for each successful lookup of the checked 757-row table through `ExternalResponses.checkDatabase_sound`. The root is ID 756, and `missing_row757` proves that ID 757 returns none. `checked_registry.json` is only discovery metadata; the Lean wrapper imports the actual Root theorem. It permits later certificates to reuse all 757 local P states without re-proving the subgraphs, subject to exact new response checks.

The detailed semantic reviews and their machine-readable records are `runs/lean_scale/theory/actual12_review.md`, `actual12_source_hashes.json`, `actual12_kernel_receipt_checks.json`, and `actual12_registry_checks.json`.

## Optimisations with measured scope

The `FastPositive` comparison uses the same actual 50-row, 1,700-first-move Actual14 table and seven groups. Aggregate process CPU was **35.015625 → 24.703125 s**, a **29.45% reduction**; grouped wall time was 37.341191 → 24.954220 s, but cold import affected the older first group. Both alternatives were kernel-reduced and assembled into the same unconditional root theorem. Highest group private memory fell from 1,584,852,992 to 1,349,435,392 B. See `runs/lean_scale/performance/README.md`, `fastpositive_summary.json`, `paired_v1/result.json`.

Compact native edge storage is a producer optimisation, not a Lean soundness theorem. Two equal-work runs, with order reversed, measured v4/v6 wall times of 32.484/24.078 s and 28.735/26.735 s: combined speed ratio **1.205**, while the database was about **0.665** of its earlier size. A 20.5% speed increase corresponds to about a 17.0% reduction in time, so avoid interchanging those percentages. These runs compare complete newly produced logical fields. See `runs/lean_scale/producer/ROUND_RESULT.md` and `round_result.json`. Neither sample supports an empty-proof completion forecast.

## Explicit formalisation gaps and next work

Not formalised by the current successful chain: the exact SG xor identity for saturated honours; frozen-five/H222/H33 and q4 region P classifications as generic region theorems; the enumerated global SAFE/nonwinning counts and sharp maxima 34/37; concrete full C++ local profiles and partial filters; the complete global rank/unrank/orbit index and machine-word arithmetic; the entire native P/N payload; and the empty-state original-game winner. The older formal honour predicate lemma is narrower than the SG identity. The generic rank and quotient theorems are narrower than a verified concrete index.

The 12-tile root advances the smallest currently certified *actual opening candidate branch* from 14 to 12; it is not a percentage completion of the empty proof. Its two other 12-tile candidates remain PARTIAL after 100,000-new-node budgets: candidate A has 103,170 discovered/48,901 expanded/54,269 pending; candidate B has 101,471/54,018/47,453. Their checkpoints do not prove P.

The retained 10-tile probe has advanced beyond selection but is still PARTIAL: root `0000000020000001110001110200000000` = **99m 789p 45688s**, opening ID 60591, 112,490 nodes, 173,085 edges, 33,127 expanded, 79,363 pending. One verified-candidate connection reaches the new 12-tile P by first adding 6p then 8s, but other opponent branches remain. See `runs/lean_scale/frontier/actual10_candidates.json` and `runs/lean_scale/endgames/actual10_a_v1/summary.latest.md`; the selector's earlier text saying the 12-tile audit was ongoing is superseded by its completed receipt.

The frozen main opening extraction is also PARTIAL: 9,765,237 discovered nodes, 16,179,951 edges, 6,911,482 expanded, 2,853,755 pending, with a 2,119,254,016-byte SQLite checkpoint. Pending counts cover only nodes already discovered; unexpanded nodes can introduce further states. Necessary further work is a complete empty-root candidate graph or smaller equivalent certificate, acceptance of every required SAFE/response/reference dependency, and an audited premise-free theorem exactly of `SecondPlayerWins Step Win empty`. No small-certificate guarantee, completion date, or measured need for larger hardware has been established.

## Key hashes and reproduction

| Artifact | SHA-256 |
|---|---|
| Official v4.33.1 Windows archive | `c39360867edfff6b090f20c16e18581c969ce839b71e813d76022ec04ec73e4d` |
| Lean executable used by latest receipts | `af49bacfabaa1fea71332ca0feae0fa1a60912219d5902291adc79f905bffb8d` |
| `runs/lean_scale/kernel_audit.py` and retained runner | `3e49679c177048a23b66ac4490f02832891a7d949832ca728fee071e1422edf9` |
| `build/lean_scale/proof/MahjongScale/Actual12V2/Root.lean` | `3e4bce43c9466b74a4a14263c73c9751bcef570b889020654c524648c796151e` |
| Final Root `.olean` | `3f6ef0b8e9c734fc98340f9a69f0b41fdc4c2b13f6b64e39822a257d5994e8fd` |
| `runs/lean_scale/actual12_kernel_v1/result.json` | `528aa59d3590c29ed05a21dbfea088aefdd4de11c76853e2303beceb1f488a6d` |
| `runs/lean_scale/actual12/pruned_v1/responses.json` | `a917aa5649940f01c5ae6cf7ca4f69f5c988bd78fb0fa8d9ba55a4572c81c31b` |
| `build/lean_scale/proof/MahjongScale/Actual12Registry.lean` | `63b19f9cfc7134e97ade7af3c1359566cc938843f584a598ae48c2b112343140` |
| `runs/lean_scale/actual12_registry_kernel_v1/result.json` | `9355a8cd9a7d54dd10e51873f47596f18c965df9667c74c800a9ddb7d0b42ff2` |

The version string is `Lean (version 4.33.1, x86_64-w64-windows-gnu, commit 819816b2e0a3bf405af45ae5c7af2491d8f5bee6, Release)`. Complete exact source/object/log hashes and per-module argument arrays are in each result receipt. The latest local runner is `runs/lean_scale/kernel_audit.py`, requiring Python with `psutil`. From this research root a new **cold** verification directory can be created by:

```powershell
python runs/lean_scale/kernel_audit.py --entry Scale12Audit --output paper_cold_replay_new --workers 8 --memory-budget 15500000000 --timeout 120
```

The output tag must be unused. This command is documented, not executed for the paper. It rebuilds the dependency closure without `--reuse`; the measured 67-second run instead used `--reuse runs/lean_scale/actual12_pilot_v2`. The runner recursively freezes source copies, establishes import order, invokes the fixed Lean executable with `--trust=0`, checks return codes, monitors resources, and saves final audit output. Portability beyond this Windows research layout requires an explicitly pinned toolchain and reproducing its saved import closure; do not promise a platform-independent one-command replay merely because a local receipt exists. The publication work may provide a separately tested portable package and should cite that evidence independently.

## Manuscript review: formal claims and attribution

Reviewed the currently drafted `runs/paper_20260913/manuscript.md`, especially §§7.1–7.6, the related statements in §§2–4, and the authorship/AI declaration. No manuscript changes were made by this agent.

**Accepted as accurate:** the exact `Mahjong.Scale12V2.original_second_player_wins` name and original-game type; 12-tile digits and notation; all response counts; 86 independent leaves plus four prior SAFE projections; the data/group partition; 326 = 231 reused + 95 new; 327 = 325 reused + 2 new; all 25,510 first actions rather than only SAFE exported edges; standard axiom scope; the 4.71 GB aggregate pilot versus 2.42 GB largest individual process; failed experiments excluded; no closed empty theorem; native candidate expansion distinguished from Lean throughput; and the 1.205× speed versus 17.0% time-reduction distinction. The explanation of smaller proof IDs pointing to physically larger states is correct.

Recommended corrections or additions, in order:

1. **§7.1, final paragraph:** replace “are not all formalised by this list” with “None of the following has a complete formalisation in the accepted chains: …”, or equivalent precise wording. Every listed global maximum/full SG identity/frozen-five region/complete classification/global C++ index/full payload lacks the relevant complete formalisation. The existing wording can be read as suggesting an unspecified subset is completely formalised. Preserve the explicit narrower older honour-predicate result.
2. **§7.1 or §7.2:** add the formal negative-certificate mechanism used to establish the SAFE leaves. Suggested text: “For each available pair, the certificate removes that pair and supplies upper bounds on meld packing in the three suits and honours. Lean checks each local bound; a sum below four rules out an ordinary hand. Seven pairs and thirteen orphans are excluded separately. The accepted StandardBoundCertificate, MaskedLocalBound and CachedStandardBounds lemmas justify this checking and the reuse of local negative bounds without identifying their P/N game values.” This is a significant completed theoretical/engineering contribution currently omitted from the main formal-method explanation.
3. **§7.3 or Appendix F:** give the exact older 20/28/30/32/34 root catalogue from the table above. In particular the 28- and 30-tile roots already have unconditional theorems `Mahjong.AnchorDAG.N09818.original_second_player_wins` and `Mahjong.AnchorDAG.N02076.original_second_player_wins`. Their later raw native-probe directories remain candidate-only records; use the earlier certified AnchorDAG receipt as the proof citation. The 32-tile root is `Mahjong.Extracted32.original_second_player_wins`.
4. **§7.4, final paragraph:** tighten “independent manuscript audit”. The 2,892-file/1,514-edge figure is a manuscript-preparation **integrity recheck using retained verification code**, not a newly authored independent implementation or a fresh Lean replay. The 25,510-response check reran the retained independent semantic-check script in read-only mode. Suggested wording: “During manuscript preparation, a read-only integrity audit rehashed 2,892 retained files across seven linked successful receipts and checked 1,514 dependency-exact reuse relationships. A separate rerun of the retained independent semantic checker revalidated the 25,510 physical responses. These checks did not run Lean or repeat the game search.” This preserves the useful evidence without inflating independence.
5. **§7.4, resource paragraph, optional precision:** the root's configured aggregate monitor limit was 15.5 billion bytes within the 16 GB task cap. “Below its configured 15.5 GB aggregate limit and the 16 GB task cap” is more exact than merely “below the 16 GB working limit”. The reported peak includes the monitored runner and concurrent owned Lean processes, not all applications on the machine.
6. **Appendix reproduction recipe:** use a fresh output tag with `runs/lean_scale/kernel_audit.py`; the proposed cold command above omits reuse and should not be advertised as the measured 67-second run. The old `runner.py` snapshot inside a receipt is not a drop-in script location: its path-relative root resolution was designed for `runs/lean_scale/kernel_audit.py`. Keep the old receipts unchanged.

**AI and author declaration:** the requested recognition of OpenAI's GPT-6Astra is explicit and appropriately substantial, covering mathematical work, code, proof development and drafting. It distinguishes AI contributions from accountable named authorship and makes final author review pending. No correction is needed on the audited facts. The assertion of independence from other competitors is explicitly scoped in §9.3 to adopted premises/results, acknowledges historical notes, and does not pretend that separate AI agents are independent human teams. This audit did not independently reconstruct every historical interaction or verify every cited bibliographic entry; those are separate author/evidence responsibilities.

At this review point the manuscript references Appendices A–G, while the material read ended with the References section. This is an assembly-stage observation, not a substantive defect if those appendices are being appended; verify all promised appendices, E-number evidence references and relative file links before delivery.
