# Formal evidence for the 15 September 2026 Lean supplement

Prepared by the formal-audit subtask on 15 September 2026 (Australia/Sydney). This is a source-and-retained-evidence review, not a fresh Lean compilation, global replay, independent human peer review, or publication. No research job was started, resumed, or changed.

The comparison baseline is runs/paper_20260913/manuscript.md, SHA-256 f1d521177f2270e4340703faddaa6f9426108e939cd19cfeb71b4f2fc5fbe2e5. The current route's STATUS.json is timestamped 2026-09-14T16:41:40.506769+00:00 (15 September in Sydney), SHA-256 70622758b1f590786307667cca8e1c464afb50eb422c865e4e224df7371c9abb. Older migration/handoff UNKNOWN labels and older adapter-readiness fields are historical, rather than the latest status.

## 1. Main conclusions for the supplementary paper

1. **The explicit proof library has increased from the old 757-row bank to 24,655 distinct certified P states.** The increase is 23,898, composed of 2,554 Solo rows and 21,344 subsequent daemon facts. The shortest completely certified states still have 12 tiles: four such states, comprising the old root and three new Solo roots. Neither the ten-tile target nor the empty state has a completed Lean winner theorem.
2. **The generic formalisation has expanded substantially.** It now covers a candidate whole-table checker, checked local rule caches, exact SAFE filtering, raw base-five coverage, local canonical inventories, a SAFE upper-bound mechanism, groups/directories/prefixes, global orbit enumeration, natural-number and machine-word index/decoder/walk models, complete cached transitions, optimisation equivalences, and correctness of finite bottom-up evaluation from an initially empty table.
3. **These are several distinct logical and evidential achievements.** Generic Lean theorems have explicit premises. The large concrete local/directory/helper checks are compiled Lean executions and hash-bound receipts; they have not been assembled into one literal GlobalEnumeration.Certificate term accepted in the kernel. Source correspondence and bounded tests of frozen C++ routines provide a further, distinct layer.
4. **The current formal conclusion is not an unconditional empty-game result.** WholeTable.checked_empty_wins, CachedWholeTable.checked_empty_wins, and CachedTransitionQuotient.original_result_of_certificate are genuine checked implication theorems; their finite acceptance/certificate premises remain necessary. A complete C++ operational-semantics refinement, a fully instantiated whole-solver kernel certificate, and formal binding of the historical P/N output remain explicitly unfinished.
5. **The actual-label scan has checked 22,512,356 distinct historical production slots by compiled Lean execution**, specifically complete layers 34 and 33. The subsequent model/finite-data/C++ test package adds zero historical P/N rows. Local data rows, directory rows, bounded test rows, explicit P facts, and historical P/N slots should never be added together as a common coverage count.

The current finite package may accurately be described as complete **within its declared scope: kernel proofs of models, checked finite inputs, source correspondence, and bounded production-routine tests**. It should not be called a completed formal proof of the entire C++ program or the historical opening result.

## 2. Old versus new theorem matrix

All source paths in this section are relative to the research root. Unless another path is stated, the source prefix is build/lean_table_checker/source/Mahjong/. Line numbers were read directly from the current files.

| Subject | Baseline of 13 September | Current precise declaration and source | Current conclusion and essential premises |
| --- | --- | --- | --- |
| Physical game and SAFE reduction | Original rules, executable checker, symmetry transport, SAFE/original-game bridge already formalised | Mahjong.original_safe_reduction, Bridge.lean; underlying Rules/RuleChecker/SafeGame imports retained | Foundation is reused. Do not present the original rules or SAFE reduction as newly invented in this supplement. |
| Concrete P strategy facts | Old 12-tile root, 757 local rows; earlier larger roots | Mahjong.Solo.Branch34/Branch44/Branch35.original_second_player_wins; daemon concrete roots and typed row terms | New unconditional state-specific original-rule winner proofs; four minimum 12-tile roots, no ten-tile or empty winner proof. |
| Whole-table certificate checker | Response-table and abstract certificate soundness existed; whole global result not certified | Mahjong.WholeTable.check_sound, WholeTable.lean:85; Mahjong.WholeTable.checked_empty_wins, :134 | Acceptance of all finite rows and an exact empty P root implies original SecondPlayerWins. No separate global rank/unrank bijection, global SAFE bound, or C++ profile axiom is needed by this checker. Every referenced child is checked and a decreasing stock measure prevents circular justification. The actual complete table acceptance is not supplied. |
| Checked rule caches | Earlier SAFE-bound certificates and positive-witness optimisations | Mahjong.LocalCache.check_sound and lookup_eq, LocalCache.lean:75/:114; Mahjong.FactorizedRules.winB_eq, FactorizedRules.lean:49, safeSuccessors_iff, :83 | Cache checks imply equality with complete local meld search; failed bounds/reference checks fall back to the reference predicate. Rule optimisation is proved, and cannot silently suppress a legal move. Concrete cache acceptance is compiled finite evidence. |
| Cached whole-table checker | Not present in the baseline catalogue | Mahjong.CachedWholeTable.checked_empty_wins, CachedWholeTable.lean:46 | Cache checks plus actual whole-table acceptance and an empty P root imply SecondPlayerWins. Still an implication awaiting complete finite acceptance. |
| General higher-layer adapter | No complete global Lean scan | Mahjong.GeneralLayer.row_sound, GeneralLayer.lean:97; Mahjong.GeneralOriginalSoundness.row_original, GeneralOriginalSoundness.lean:10 | Accepted row plus checked local rules and explicit TargetCorrect for every higher-layer target implies its original-game strategy label. TargetCorrect is not established merely by loading C++ bits. |
| Complete near-terminal scans | Not part of the baseline's 757-row kernel certificate | Mahjong.TerminalBucket.row_sound, TerminalBucket.lean:37; Mahjong.NearTerminalBucket.row_sound, NearTerminalBucket.lean:23 | Kernel proves row-checker soundness. Compiled executions check actual layers 34/33. The terminal checker proves no SAFE child directly; near-terminal N rows provide an actual SAFE child with no SAFE children. This does not rely on trusting an arbitrary child P label. |
| Raw encoding and full SAFE test | C++ counting/filtering outside the earlier certification | Mahjong.Base5Coverage.unpack_pack, :275; pack_injective, :282; checked_filter_on_every_valid_state, Base5Coverage.lean:311 | For every valid physical state, the packed fullSafe predicate is equivalent to IsSafe, assuming proper local input sizes and FullSafeData.Checked. Base-five encode/decode identities are generic kernel results; large concrete checks use compiled execution. |
| Early pruning | Earlier mathematical/computational pruning arguments | Mahjong.PruningPackedBridge.checked_original_safe_survives; PruningAlgebra/PruningSemantics/PruningData | SAFE originals cannot be lost by the checked partial-label filter. This is not merely agreement on sampled global states. Concrete local label checks are finite compiled evidence. |
| Local canonical inventory | C++ canonicalisation/indexing not globally certified in baseline | Mahjong.CanonicalCoverage.every_safe_has_retained_representative, CanonicalCoverage.lean:161; retained_orbit_injective, :107 | Correct local inventory checks establish a retained representative and uniqueness within the allowed local symmetry orbits. Requires exact sizes, full local checks and the retained-membership bindings. |
| SAFE upper bound | SAFE maximum 34 established mathematically/computationally, not in the earlier Lean catalogue | Mahjong.SafeLayerBound.original_safe_bound, SafeLayerBound.lean:98; Mahjong.LayerOrderBridge.safe_bound, LayerOrderBridge.lean:8 | A generic kernel upper-bound theorem gives total s ≤ limit from checked raw labels and joined finite envelopes. The current finite envelope instantiates limit 34 by compiled checks. Do not omit these premises or call it an unconditional standalone concrete kernel theorem. |
| Concrete directory coverage | C++ grouped weighted enumeration and compact indexing | Mahjong.DirectoryCoverage.original_safe_has_actual_entry, DirectoryCoverage.lean:26 | Every original SAFE state has a concrete directory entry under local-cache, canonical-inventory, group-link, SAFE-envelope, triple-directory and honour-directory checks. |
| Exactly-once global orbit enumeration | Computational enumeration only | Mahjong.GlobalEnumeration.enumeration_correct, GlobalEnumeration.lean:74 | For any Certificate c: every valid address decodes to a valid SAFE state; every original valid SAFE state is covered up to SameOrbit; two valid addresses represent the same orbit iff they are equal. A concrete complete Certificate term is not constructed. |
| Mathematical rank/unrank and walking | Generic small ranking lemmas plus C++ implementation | Mahjong.IndexOperations.rank_unrank, IndexOperations.lean:49; rank_injective, :61; unrank_rank, :75; Mahjong.IndexWalk.walk_is_unrank, IndexWalk.lean:68, walk_covers_every_valid, :86, walk_stops_at_total, :99 | Correct groups, weighted block cardinalities, ordered valid group keys and prefix intervals imply a bijection and complete finite sequential walk. These prove the model for every valid index, not an execution trace for the entire C++ scan. |
| Machine-word arithmetic and initial decoder | C++ bounded integers, floating-seed helper not formalised in baseline | Mahjong.WordDecodedGlobal.every_original_safe_is_visited, WordDecodedGlobal.lean:9; Mahjong.WordPair.checked_chunks_correct, WordPair.lean:111 | Word scan/refinement uses GroupsFit, 32/64-bit bucket bounds, exact file slices and an explicit WordPair.Correct helper contract. Full finite helper outputs can discharge that contract under the compiled-evaluation boundary; no unproved floating-point behaviour is hidden in the theorem. |
| Exact cached transitions and game quotient | Generic TransitionQuotient theorem, but concrete global successor cache not connected | Mahjong.CachedSuccessorList.exact_moves, CachedSuccessorList.lean:83; Mahjong.CachedTransitionQuotient.transition_quotient, CachedTransitionQuotient.lean:67; strategy_iff, :72 | Complete checked local successor lists, SAFE filtering and orbit keys give forward and backward moves from every valid SAFE representative. This proves a P/N strategy-preserving quotient, not just a static winning-profile equivalence. |
| Optimisation semantics | Selected performance optimisations already checked in response-table route | Mahjong.MoveNormalization.cached_fast_eq_sort, MoveNormalization.lean:65; optimized_mem_iff, :114; Mahjong.MovePlanRefinement.planned_offset, MovePlanRefinement.lean:125; Mahjong.PlanCacheCoverage.every_used_offset_fresh, PlanCacheCoverage.lean:43 | Repeated-suit elimination preserves successor-orbit membership; two comparisons equal full sorting under sorted-source and increasing-target-ID conditions; group/offset preparation and cache overwrites preserve every used lookup under explicit group conditions. |
| Bucket shortcuts and row evaluation | C++ engineering evidence | Mahjong.RetrogradeEvaluation.optimized_correct, RetrogradeEvaluation.lean:113; evaluate_sound, :153; Mahjong.OptimizedRowBridge.optimized_cached_step, OptimizedRowBridge.lean:59 | Exact bucket counts and valid candidate membership justify zero-P/all-P shortcuts and early return. Cached row evaluation connects to original SAFE strategies under exact layout and previously justified child strategies. |
| Bottom-up algorithm from empty table | Abstract recurrence certificate soundness, no complete native-program refinement | Mahjong.LayeredRetrograde.bottom_up_correct, LayeredRetrograde.lean:147 | Complete exact successors, a decreasing rank, complete state list and correctly sorted processing order imply that finite computation from all-none succeeds and assigns a correct strategy label to every state. No historical output bits are premises; no particular opening label is concluded. |
| Layer order and terminal start | Mathematical game finiteness and computational layer 34 | Mahjong.LayerOrderBridge.move_decreases, :15; terminal_layer_p, LayerOrderBridge.lean:27 | Given the finite-bound certificate, rank 34−total decreases along SAFE edges, descending tile count has the required processing order, and a 34-tile SAFE state has no SAFE successor and is P. |
| Concurrent output words | Engineering concurrency checks | Mahjong.ChunkWordOwnership.chunk_word_disjoint, ChunkWordOwnership.lean:15; tail_mask64, :24 | Disjoint aligned chunks cannot own the same 64-bit output word. All 64 tail masks and all 64 single-bit positions are checked in the kernel. This is not a theorem about the full C++ thread/file-system memory model. |

The matrix is about newly supported *scope*, not a count of independent foundational discoveries. Many declarations reuse the original game definitions, the existing SAFE bridge, and earlier general certificate theorems.

## 3. Exact logical interfaces and remaining premises

### 3.1 The generic whole-table checker is sound but not instantiated for the opening

The current source states:

~~~lean
theorem checked_empty_wins (table : Candidate) (i : Nat)
    (checked : check table = true) (root : checkRoot table i = true) :
    SecondPlayerWins Step Win empty
~~~

This is Mahjong.WholeTable.checked_empty_wins (WholeTable.lean:134). Candidate contains size, unrank, rank, canonical, restore and label. checkRow requires valid/SAFE source, every actual SAFE successor's valid finite reference, exact state equality, checked generator restoration, decreasing stock, and the appropriate P/N recurrence. checkRoot requires the selected index to be in range, its exact state to be empty, and its label to be P.

It is therefore inaccurate to say that rank/unrank correctness is simply assumed by this route. The checker validates each used reference. Equally, the existence of this implication does not establish its unchecked finite input.

The cached counterpart (CachedWholeTable.lean:46) adds checked local caches to the same full acceptance. The general layer adapter takes:

~~~lean
def TargetCorrect (tables : Tables) (target : Target) : Prop :=
  ∀ b i, i < target.size b →
    NormalStrategy SafeMove (state tables (target.unrank b i))
      (outcome (target.labelP b i))
~~~

This definition is GeneralLayer.lean:84. A successful general row check with historical labels alone is insufficient without that higher-layer strategy premise or a completed aggregation of accepted layers.

### 3.2 GlobalEnumeration.Certificate exposes the concrete finite obligations

GlobalEnumeration.lean:10 defines the Certificate structure. It contains:

- ByteArray families core, summary, raw, ids and members.
- Exact base-five sizes and FullSafeData.Checked for the local rule/summary/raw-label tables.
- Canonical inventory proper sizes, checked rows/members/generator invariance, and shared numeric member/key families.
- Checked numerical group records and an explicit link to the inventory/raw records.
- Numeric, honour, two-block, three-block and four-block bound envelopes; all local raw-bound checks, three joins and the final bound check at 34.
- Checked triple-directory records and, for every retained honour ID, a completely checked honour-directory instance.

The global theorem is exactly:

~~~lean
theorem enumeration_correct (seed : Nat → Nat) (c : Certificate) :
    (∀ a, ValidSlot c a → Valid (decode seed c a) ∧ IsSafe (decode seed c a)) ∧
    (∀ s, Valid s → IsSafe s →
      ∃ a, ValidSlot c a ∧ SameOrbit s (decode seed c a)) ∧
    (∀ a b, ValidSlot c a → ValidSlot c b →
      (SameOrbit (decode seed c a) (decode seed c b) ↔ a = b))
~~~

The seed is arbitrary in the mathematical decoder; correction establishes the same integer result. The word-level initialized scan separately requires an explicit helper contract, exact slice bindings and size bounds. Thus the theorem gives complete, exactly-once orbit enumeration **for every input satisfying the certificate**, but the concrete files are currently connected through compiled finite checks and receipts, not a monolithic kernel literal certificate.

GroupsFit fixes 1,104 groups, 131,676 numeric inventory records, each group size in 1…3,403, and its first+size within 131,676 (WordLimits.lean:11). bucketFits requires directory block count < 2^32 and total < 2^64 (WordLimits.lean:43).

WordPair.Correct f means:

~~~lean
∀ r : UInt64, r.toNat < c2 3403 →
  (f r).toNat = pairFloor r.toNat 0
~~~

There are c2 3403 = 5,791,906 integer inputs. WordPair.checked_chunks_correct derives this contract from a covering list of accepted finite output-check chunks. This does not automatically turn a native process receipt into a Lean proof of those chunk equations.

### 3.3 Complete transitions are stronger than static profile agreement

GlobalSuccessorBridge.Checked c data quantifies over all four local blocks and requires a complete successful checkSpan across each inventory. SuccessorCache.checkRow checks the source code, arity limit, actual list length, every target range, strictly increasing IDs, strict list order, and both directions of membership against all available one-tile additions followed by canonicalisation/retention.

The cache's numeric row/span checks are definitionally shared across the three suits for identical input files (SuccessorCache.numeric_row_shared and numeric_span_shared). Therefore one full numeric cache plus one honour cache can supply the four-block predicate via SuccessorCoverage.checked_from_two_files, rather than treating repeated suit data as three independent discoveries.

The quotient declaration is:

~~~lean
theorem transition_quotient (c : Certificate) (data : Nat → SuccessorCache.Data)
    (checked : GlobalSuccessorBridge.Checked c data) :
    Quotient.TransitionQuotient RestrictedSafeMove
      (Move c data) (encode c)
~~~

The next theorem is strategy_iff, for every SafePosition and Outcome. The opening bridge at CachedTransitionQuotient.lean:79 additionally requires a PNCertificate of the complete quotient graph and rootP. It is explicitly conditional and does not supply either premise from the historical table.

### 3.4 The new algorithm theorem computes from an initially empty table

LayeredRetrograde.Table is α → Option Bool. none represents not computed; ready rejects any missing child dependency before a row can be evaluated. The source uses Boolean true for P, false for N; these bits must not be confused with the earlier solver interfaces whose numeric 0 denotes P.

The theorem (LayeredRetrograde.lean:147) is:

~~~lean
theorem bottom_up_correct (move : α → α → Prop)
    (succ : α → List α) (rank : α → Nat)
    (exactSucc : ∀ s t, move s t ↔ t ∈ succ s)
    (decreases : ∀ s t, move s t → rank t < rank s)
    (states : List α) (covers : ∀ s, s ∈ states)
    (sorted : states.Pairwise (fun s t => rank s ≤ rank t)) :
    ∃ result, run succ states (fun _ => none) = some result ∧
      ∀ s, ∃ b, result s = some b ∧
        NormalStrategy move s (outcome b)
~~~

The ambient variable has [DecidableEq α]. Completeness of a finite states list is an explicit premise, not a theorem that every arbitrary type can be enumerated. The result supplies correct labels but does not select P for the Mahjong empty state without computing/binding the actual instance.

The original-row bridge, OptimizedRowBridge.optimized_cached_step, takes c, checked local successor data, a valid SAFE retained state, a child-label function, a list of buckets, exact bucket summary counts and candidate membership (ValidBucket), exact candidate-piece layout, and actual child NormalStrategy proofs. Its conclusion is a RestrictedSafeMove strategy for the evaluated parent label. The cached-list game equivalence and original SAFE reduction supply the route back to the physical achievement game.

## 4. Explicit state certificates added since the first paper

The following are genuine no-extra-hypothesis original-rule winner theorems. In each row the fully qualified theorem concludes Mahjong.SafeGame.SecondPlayerWins Mahjong.Step Mahjong.Win <namespace>.original.

| New root | Exact 34-digit counts | Human-readable suits | P rows / legal first responses / new SAFE leaves | Source and theorem line |
| --- | --- | --- | --- | --- |
| Mahjong.Solo.Branch34 | 0000000030000001110001110300000000 | 999m 789p 456888s | 2 / 66 / 1 | runs/lean_solo/branch34_kernel_v1/source/MahjongSolo/Branch34/Root.lean:28 |
| Mahjong.Solo.Branch44 | 0000000020000001110001121200000000 | 99m 789p 4566788s | 1,061 / 36,074 / 103 | runs/lean_solo/branch44_kernel_v1/source/MahjongSolo/Branch44/Root.lean:556 |
| Mahjong.Solo.Branch35 | 0000000030001110201000001110000000 | 999m 45688p 1789s | 1,491 / 50,170 / 162 | runs/lean_solo/branch35_kernel_v1/source/MahjongSolo/Branch35/Root.lean:773 |

All have 12 tiles and no honours. Their names end in original_second_player_wins. The human-readable strings were decoded from the actual count strings; the source's original definitions were also inspected.

Solo's FINAL_STATUS.json records 2,554 new P rows and 86,310 complete legal-first-response entries. Adding the old 757 rows gives 3,311 distinct registered states. Mahjong.Solo.Bank2.registry is a Lean typed-fact registry; bank2_registry.json is discovery metadata, not an axiom.

The combined Coverage10V2Audit.lean was accepted with 1,236 modules and 4,014 audited theorem declarations, according to the retained final receipts. Its namespace Mahjong.Solo.Coverage10V2 proves:

- valid, belowFour and safe for 0000000020000001110001110200000000 = 99m 789p 45688s.
- exact_coverage at line 32: allTiles.filter covered = [8, 9, 14, 23, 24, 25].
- covered_reply at line 35: for any tile whose selected candidate check passes, Reply original first.

The six zero-based first tiles are 9m, 1p, 6p, 6s, 7s and 8s. The remaining 28 tiles are unproved by this selected-reply certificate; that failure is not an N proof. The exact_coverage theorem concerns the supplied candidate function. The separate generator searched the then-current bank for possible two-addition returns, but the kernel theorem should not be described as a maximality result over every future strategy or every possible proof.

Daemon state was independently checked through read-only SQL:

| Tiles | Distinct registered P states |
| ---: | ---: |
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
| Total | 24,655 |

The SQLite database has 26,139 candidate nodes, 21,530 expanded nodes, 283 PASS batches and one retained KERNEL_RUNNING batch row while the controller is PAUSED. The last row is not a success receipt and must not be included in certified work. There are exactly 3,311 seed facts, 21,344 newly registered facts, and 283 distinct successful receipt paths in those new fact entries. The daemon report's 15,977 is only the last process session's gain, not the total daemon increase.

A concrete late batch demonstrates the acceptance boundary: runs/lean_daemon/production_v1/k/K7886638144400/source/A4457d00011bfcaeAudit.lean checks the exact 34 counts, collects axioms from all Mahjong theorem declarations, and uses Meta.isDefEq to require the no-extra-hypothesis original SecondPlayerWins type. It records 128 accepted rows for original root 0211110111000002121010110120000012 (24 tiles). The root module is MahjongAuto.A4457d00011bfcae.Root, namespace Mahjong.Auto.A4457d00011bfcae. Individual rows are exposed by ExternalResponses.checkDatabase_sound applied to that complete checked table. The retained result is PASS, 7,428 dependency modules, 62,753 audited theorem declarations; these are dependency totals with extensive reuse, not 7,428 new modules or independent results.

## 5. Concrete finite evaluations and their exact numerical scope

| Evidence package | Retained scope | Classification |
| --- | --- | --- |
| Early-pruning local checks | 5,937,500 block rows; 2,031,250 distinct raw local codes; 46 chunks | Compiled Lean finite checks of local predicates, supporting generic no-false-pruning theorem |
| Full-SAFE local checks | Same block-row and distinct-code counts; 46 chunks | Compiled local-instance checks for a generic full-predicate equivalence |
| Canonical inventory | 5,937,500 raw block rows; 395,212 member rows; 9,687,500 generator checks; 62 chunks | Compiled complete local inventory checks, not global P/N rows |
| Group/directory/prefix package | 60,789,499 directory rows; 588,782,520 membership checks | Compiled complete metadata semantics/coverage/interval checks |
| Index helper and C++ bounded index audit | 5,791,906 exhaustive helper inputs; 3,199,905 candidate group keys; 28,543,652 selected offset probes; 85,630,873 cursor-advance checks | Complete helper domain plus explicitly bounded C++ probes; not a full global P/N replay |
| Global directory slice binding | 6,440 slices; 60,789,499 directory rows; 588,782,520 membership tests | Compiled concrete slice checks used by generic scan bridge |
| Word refinement | 6,440 headers and an ABI probe (8-bit bytes, 16/32/64-bit unsigned integers, 64-bit size_t, 32-bit int, little endian) | Integer-model theorems plus concrete input/host checks |
| Actual successor cache | 131,860 distinct stored local records = 131,676 numeric + 184 honour; 743,869 edges; 1,186,372 candidate attempts; 10 chunks | Complete compiled check of the actual finite local successor lists |
| Historical production layer 34 | 587,901 slots: 587,901 P, 0 N; 47 chunks | Actual-label compiled Lean row checks |
| Historical production layer 33 | 21,924,455 slots: 13,354,184 P, 8,570,271 N; 364 chunks | Actual-label compiled Lean near-terminal checks |
| General-row performance samples | 745,472 evaluations across 356,352 distinct sampled slots, 47 completed cases | Bounded benchmark only; excluded from complete-layer P/N coverage |
| Optimised production-routine tests | 102 configurations, 11 selected buckets; 6,870,608 reference rows versus 13,741,216 solver row outputs; 185,054,540 reference edge visits | Synthetic-child-label finite differential tests, zero added historical P/N rows |

The 5,937,500 count equals 3×5^9 + 5^7; the distinct raw-code domains are 5^9 + 5^7 = 2,031,250 because the three numeric suits share the local domain. Similarly, 395,212 canonical member checks count three numeric copies plus honours, whereas the successor-cache count reports the single shared numeric data set plus honours. These are deliberately different counting conventions and should be explained if placed in one table.

ACTUAL_SCAN_ACCEPTANCE.json binds the two complete historical layers, original payload equality and all retained receipts. Its earlier general_nonterminal_adapter_ready=false field is superseded by the later general adapter/status and does not invalidate the completed two-layer result. The current status still says full_campaign_aggregation_ready=false and whole_table_adapter_ready=false: a row adapter exists, but the complete accepted campaign has not been composed.

The latest acceptance's 5,329 evidence files include inherited evidence. Do not add all successive acceptance manifest sizes as if they were disjoint. The final ten modules list 79 audited core theorem declarations; this is not the total number of Lean lemmas in the whole project.

## 6. What the optimiser proofs do and do not establish

- MoveNormalization.optimized_mem_iff is universal in the abstract next function and Packed inputs because it compares canonical successor signatures. It does not by itself say that two comparisons produce a sorted raw ID tuple for arbitrary decreasing replacements. The stronger cached_fast_eq_sort requires an initially sorted triple and an accepted local-cache row giving a strictly larger target ID. RetrogradeControls contains a counterexample when that condition is violated.
- RetrogradeEvaluation.ValidBucket explicitly requires reportedP = countP isP rows and every candidate to belong to those rows. Thus zero-P skips and all-P lookups do not assume the correctness of an arbitrary summary. The compiler/runtime and file-binding work must still connect the real header/count to this model.
- PlanCacheCoverage.fill models overwriting all target groups reachable from the current group. every_used_offset_fresh proves that an actual edge uses a refreshed entry. It is not a proof of every C++ allocation, aliasing or lifetime behaviour.
- ChunkWordOwnership proves mathematical word disjointness under a positive width divisible by 64, ordered chunk numbers and valid row ranges. It does not prove arbitrary memory accesses race-free.
- The 102 C++ configurations invoke frozen production routines with synthetic child labels. They cover layers 5, 8, 12, 16, 20, 24, 28, 31, 32, 33 and 34; 1 versus 8 threads; 64 versus 256-row chunks. They include all-zero, all-one, mixed, numeric-only-P and honour-only-P child-label situations.
- The retained operational audit rejects 21 corrupt/incomplete cases and accepts four recovery/reading controls. The non-prefix resume case retains a committed middle block of 64 rows and computes the remaining 6,882; it is not a claim to have tested every power-failure interleaving.
- The seven source-map fragments identify exact byte offsets in the frozen C++ and their corresponding theorems. Every entry explicitly says SOURCE_AND_MODEL_AUDIT_NOT_CPP_LANGUAGE_SEMANTICS. In particular, completed_guard has no corresponding Lean theorem listed.

The historic physical-deletion reverse recurrence covers the full 778,532,864,302-state computational table with zero differences and 16,240 oracle matches. The current package rehashes 17 major retained receipts, not all historical payload bytes anew. That replay shares rules and Index with the forward solver, so it is stronger computational evidence with a different recurrence direction, but not a fully independent formalisation.

## 7. Trust, provenance and preservation

The new route uses the local Lean 4.33.1 Windows toolchain. build/lean_table_checker/build.py sets --trust=0 -M3072 -j1. Native workers are produced from emitted C using leanc with -O3; native check execution and IO remain in the trusted computational boundary. The Lean executable SHA-256 is af49bacfabaa1fea71332ca0feae0fa1a60912219d5902291adc79f905bffb8d.

The audited model theorem logs list only propext, Classical.choice and Quot.sound, with some declarations depending on fewer or no axioms. Source search over build/lean_table_checker/source/*.lean found no sorry, native_decide, newly declared axiom, unsafe declaration or opaque declaration. The models do not import Mathlib; they use Lean/Std/Init plus local modules. This is distinct from the earlier separate Lean 4.33.0/Mathlib lemmas preserved in the first paper.

Neither “no native_decide” nor “--trust=0” makes the large compiled evaluations kernel proof terms. The soundness theorem is kernel checked; the large Boolean input instance is evaluated by an executable. A theorem whose parameters include accepted finite checks remains conditional until those concrete equations are supplied under the chosen trust regime.

The latest model acceptance records --trust=0, maximum heap 3,072 MiB, one thread per Lean module. Its bounded C++ tests have a Windows Job cap of 15.5 GB and 80% CPU, with at most eight solver threads; these resource settings do not prove theorem soundness. The daemon historically used a different adaptive module-admission policy and should not be assigned the new route's per-module 3 GiB cap.

Key retained acceptance hashes (all were read and their own bytes rehashed during this audit; the reproduction subtask is responsible for any full transitive manifest verification):

| Acceptance path below runs/lean_table_checker/ | SHA-256 |
| --- | --- |
| pruning_spike_v1/acceptance.json | f40d0e3fe9b4d7e50fb577ddf66e53a8b00d62e38b56105ef5b8467d40d35fef |
| full_safe_v1/acceptance.json | 7f54d4b82651c453a0257a3702a01dcd5fdb6d5c9f4b9563fed396a96f1024d8 |
| canonical_inventory_v1/acceptance.json | fcef7c1e6040c4636ad0b6830acd5c3f40522a4b214c53db215e971c7b5c3861 |
| group_directory_v1/acceptance.json | 01a69fedec1063a9ecad33135492449ca7c32ef5bc83bb213b7d066f4b9935c6 |
| index_algorithms_v1/acceptance.json | 73543815c347d52af1ef0011d3f0cd9ce412d666c1022d078fb18f28f9ff0df8 |
| global_orbit_v1/acceptance.json | ec71a9c7746b582e1d56dfed2cabbd95f36b7b8a39955a4a73092f092f920aeb |
| word_refinement_v1/acceptance.json | d276d2990a608c31a203abd7bbe5fd58b62e2e3e72a13082b1b0f7ef7c413490 |
| decoder_refinement_v1/acceptance.json | 3736ea289eee1f1cf90409763a790abb3a8f987695e4a87421259b766bc3e37c |
| successor_cache_v1/acceptance.json | 60d0b661766e7121c9798277b48a2dc2024bdc601fb307ad330e7c603f60cdb9 |
| optimized_retro_v1/acceptance.json | 1f23e423794ce0f64a001367d59a41baab82fd517602e9c48046c95a96b14400 |

Selected source hashes independently read:

| Source below build/lean_table_checker/source/Mahjong/ | SHA-256 |
| --- | --- |
| WholeTable.lean | 8f979afe5bd4135dcb655d326c6f876002f03196b5c1dfa6d759264c5a4a9e4c |
| GlobalEnumeration.lean | f776505585e3d77447bed55889b86ff7f025f4fb859468d45638ec0ea3d6568f |
| CachedTransitionQuotient.lean | a4031c2b221cdf59ce2de4f90118b239c8063c61a95c36b9bf8bedc21a8908c9 |
| LayeredRetrograde.lean | 517b017070102ab8e109c6398463baa4ff321a48e8f8861121d292eba651a9f1 |
| OptimizedRowBridge.lean | d1419402725cae2847cd6dbe3e123f6d99e6344611d34785f9d85a8e93b5a485 |

Frozen production sources are global_retro.cpp SHA-256 6664c16ab99d058478cc10d7b85edbf43328884f5c1a8d5abf12fecf274acee8 and global_index.hpp SHA-256 b742e5bbb20ed0df50665c0d454d3bf4b7691dabc4d2d0380e7159766f8bf0c8, as bound by source-map.json.

The existing documentation's read-only reproduction entry is build/lean_table_checker/accept_optimized_retro.py --check-only. This audit did not run it or any proof/solver. All old research files were left unchanged; only this memo was created.

## 8. Recommended boundaries in the paper

Appropriate statements:

- “We extend state-specific kernel certificates from a 757-state bank to a preserved library of 24,655 distinct P states, while the shallowest certified roots remain at 12 tiles.”
- “We prove generic enumeration, transition and retrograde models, including semantic preservation of key optimisations, and check their finite local inputs by compiled Lean execution.”
- “The algorithm theorem begins with an empty model table, rejects missing dependencies, and establishes correctness of every computed label under complete enumeration and exact successor hypotheses.”
- “The concrete implementation is supported by hash-bound source correspondence and bounded production-routine tests; it has not been universally refined into the Lean model.”

Statements that would overclaim:

- “Lean has proved the empty-state second-player win,” or “the historical table is fully Lean-certified.”
- “All 778,532,864,302 states were individually checked by Lean.” The actual-label scan covers only complete layers 34 and 33.
- “All finite premises have kernel proof terms.” The large local/directory/helper checks use compiled execution; the literal full Certificate is not constructed.
- “The optimisation model proves the whole C++ program, pointer arithmetic, threading, and file system.” These remain separate operational boundaries.
- “The new model package adds further historical P/N labels.” Its new_pn_rows is zero.
- “Six of 34 replies give 17.6% of a complete ten-tile/empty strategy.” A local selected-reply coverage count is not an overall search/proof completion percentage.

No newly completed proof was found in this route for the general honour-pass SG XOR theorem, frozen-five regional theorem, or the non-winning global maximum 37. The SAFE upper-bound *model plus concrete finite-envelope evidence* has advanced since the first paper; the other broad mathematical/computational results should retain their prior formalisation labels.
