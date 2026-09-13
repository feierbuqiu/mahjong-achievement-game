> Archived evidence from the dated local research record. Historical progress and commands describe that record; current supported commands are in the repository reproduction guide. Links to retained attachments lead to their availability entries.

# Computational evidence audit for the current-node paper

Prepared on 13 September 2026 (Australia/Sydney). This is an internal evidence memo for the paper, not a new global search. All cited paths are relative to the research root. No immutable research source, result or checkpoint was edited.

## 1. Essential correction to the historical handoff

The live research directory contains a completed global computation that supersedes the original root-level START_HERE.md, RESEARCH_HANDOFF.md and STATUS.json, and supersedes the local frontier counts in runs/round9/STATUS.json. The current numerical result is **a second-player win: the empty state is P, and all six first-move orbits are N**.

The controlling evidence is:

- runs/global_retro/RESULT.md.
- runs/global_retro/verification/final_v1/acceptance.json.
- runs/global_retro/verification/final_v1/reverse_coverage.json.
- runs/global_retro/independent_full_v3_0702/phases/01-independent_all_layers/engine.stdout.log, whose final native line is PASS_ALL_REQUESTED_LAYERS with zero mismatches and 778,532,864,302 verified states.
- The corresponding result-00.json and status.json, showing normal exit 0 and no forced termination.

Recommended scientific claim: **Exhaustive retrograde computation classifies the empty position as P; a second implementation using physical deletion and reverse propagation reproduces every stored P/N bit. The implementations share the rule tables and global index, so this is a computational solution with substantial cross-checking, not a completed Lean proof of the opening.**

Avoid retaining UNKNOWN as the current game-theoretic status merely because the immutable handoff says UNKNOWN. Equally, do not convert the entire computed table into a Lean-certified theorem by association with the subsequent certified local branches.

### Read-only checks performed for this paper audit

At 2026-09-13T07:29:08Z, the saved-evidence checker was run with:

~~~text
python runs/global_retro/verification/reverse_coverage.py --no-write
~~~

It accepted all 3,686 nonempty buckets, all 35 layers, and all 778,532,864,302 states; both the full-record-coverage and actual-full-run-PASS gates were true. It did not reread the 97.32 GB payload.

All 17 receipt files listed in acceptance.json were SHA-256 checked in this paper audit and matched. Its four frozen-artifact entries were also rehashed and matched: the reverse verifier executable, global_index.hpp, the foundational solver.cpp, and reverse_coverage.py. These checks establish that the retained small evidence and identified executable/source files have not drifted from the accepted snapshot. They do not constitute a new global recurrence run or a current reread of every database byte.

## 2. Current results and their exact scope

| Result set | Current count or classification | Evidence boundary |
|---|---:|---|
| Complete physical SAFE symmetry quotient | 778,532,864,302 states | All 35 layers computed and replayed |
| P states | 203,051,492,021 | P means the player to move loses |
| N states | 575,481,372,281 | N means the player to move wins |
| Empty state | P | Full table plus six-successor recurrence check |
| First-move orbits | 0 P, 6 N | Five numeric rank-reflection classes and one honour class |
| Eight-tile M = a²b²H²J² | 32 P, 3 N, 0 UNKNOWN among 35 orbits | Entire historical M35 family |
| Original nine-tile S41 frontier | 3 P, 38 N, 0 UNKNOWN | Only the specified 41 of 483 S orbits |
| Entire historical S = a²b²cH²J² family | 3 P, 480 N among 483 orbits | Inference combining prior 442 N with current S41 classification |
| H22, H24, H222, H33 and H224 | All P | Bare full-game positions, not an honour-only subgame |
| Ten-tile T obtained by upgrading an existing honour pair in each original S41 | 23 P, 18 N among 41 roots | Lightweight current paper-audit queries; detailed inputs below |

The 35 eight-tile M roots must not be confused with the earlier 35 ten-tile a³b³H²J² roots, all P. The original S41 frontier is not the set of all nine-tile positions and is not a count of the nodes remaining before solving the opening.

The first 81 selected table queries were frozen in runs/global_retro/verification/frontier_resolution_v1/: 35 M, 41 S and five named positions. All had a complete one-step recurrence check, using 7,312 bytes of relevant checked payload and 1.975 seconds of subprocess wall time. Of those 81, 55 had been UNKNOWN after round 9 and 26 reconfirmed known values. These new table answers were kept separate from the historical regression oracle.

## 3. Exact M35 and S41 exceptions

H and J are distinct honours. All displayed shapes are exact bare positions: no unspecified additional tiles. Suit permutations, whole-suit reflection and honour permutations supply the corresponding rule-symmetry instances.

The only N positions in M35 are:

| M shape | A P successor | Canonical parent | Canonical P successor |
|---|---|---|---|
| 1²2²H²J², one numeric suit | Add rank 7 in that suit | 0000000000000000000000000220000022 | 0000000000000000000010000220000022 |
| 1²4²H²J², one numeric suit | Add rank 5 in that suit | 0000000000000000000000020020000022 | 0000000000000000000000120020000022 |
| 4²5²H²J², one numeric suit | Add rank 2 in a different suit | 0000000000000000000000220000000022 | 0000000000000000100000220000000022 |

The three displayed P successors are precisely S41_02, S41_06 and S41_39. They are the only P roots in S41:

| P shape | Complete SAFE successor orbits |
|---|---:|
| 1²2²7H²J², numeric tiles in one suit | 16 |
| 1²4²5H²J², numeric tiles in one suit | 16 |
| 4²5² in one suit, rank-2 singleton in another suit, H²J² | 25 |

The canonical strings use the supplied ordering 1m–9m, 1p–9p, 1s–9s, East, South, West, North, White, Green, Red. They are often reflected relative to the more readable shapes in the first column. For example the first canonical P is 3s, 8s², 9s², Green², Red²; reflecting its numeric suit gives the displayed 1²2²7 shape.

Sources: runs/global_retro/verification/frontier_resolution_v1/M35_results.jsonl, S41_results.jsonl and README.md. All three N cases contradict a universal conjecture that every M position is P; this is a genuine negative result, not a failure to find a proof.

## 4. Six opening-response representatives

From runs/global_retro/verification/oracles_v1/opening_results.jsonl:

| First tile, expressed by rank-reflection representative | One winning second tile | Resulting P type |
|---|---|---|
| Numeric rank 1 | Same tile kind | A rank-1 pair |
| Numeric rank 2 | Rank 3 in the same suit | Same-suit rank-2 and rank-3 singletons |
| Numeric rank 3 | Rank 2 in the same suit | Same-suit rank-2 and rank-3 singletons |
| Numeric rank 4 | Rank 2 in the same suit | Same-suit rank-2 and rank-4 singletons |
| Numeric rank 5 | Rank 5 in a different suit | Two central singletons in different suits |
| Any honour | Numeric rank 2 in any suit | One honour and one rank-2 singleton |

For actual first ranks 6–9, apply the same whole-suit reflection to both the first tile and its response. These are example choices backed by P entries, not uniqueness claims and not a fixed mirror rule for the rest of the game.

The physical strategy CLI enumerates candidate additions in the original 34-position input coordinates rather than returning a tile index from a canonicalised state. Its retained validation covers all 34 actual first moves, transformed positions, all three immediate-win forms, finished positions, missing layers and invalid counts: 44 main cases. It provides either an immediate winning tile or, at an N SAFE position, a legal move to a P SAFE position. If its input is a P SAFE position it reports forced loss without replaying every successor; it relies on the accepted table for that classification.

The strategy-restoration argument is exact. After the second player leaves a P SAFE position, an opponent's SAFE move reaches N and admits a P response. An opponent's non-SAFE move cannot already be winning when made from a SAFE position, but it supplies an immediate win to the second player. Tile count increases, so this strategy terminates in a win.

Source/entry point: build/global_retro/strategy_physical.cpp and build/global_retro/strategy_physical_run.cjs; evidence in runs/global_retro/verification/strategy_v1/. The interface is table-based and does not provide a small closed-form strategy or a minimal proof DAG.

## 5. From static statistics to exact state counts

The rule automorphism group is S7 × (C2³ ⋊ S3), of order 241,920. Numeric ranks may be reflected in an entire suit; arbitrary rank permutations are not allowed. Raw state counts cannot be divided by the group order because stabilisers vary.

The counting labels retain (i) meld/pair extraction profile, (ii) the union of profiles after one local addition, (iii) the number of distinct pair-capable kinds, (iv) existence of a singleton, (v) missing orphan kinds, and (vi) existence of an orphan pair. Layer counting adds tile count. These are enough for present terminal/SAFE membership. They are not a future-game equivalence relation.

After quotienting each suit by reflection and honours by permutation, use the S3 cycle index:

```math
O_n = \frac{F_{1,n}+3F_{2,n}+2F_{3,n}}{6}.
```

F1 permits three independent reflected local codes, F2 forces two suits to use the same actual reflected local code, and F3 forces all three to use that same code. A k-cycle repeats the contribution of one code k times but counts the code-choice weight once. Replacing that repeated code by independent choices within its statistical label would be wrong.

| Set | Raw count vectors | Symmetry orbits | Maximum tiles |
|---|---:|---:|---:|
| Nonterminal | 19,077,162,130,853,393 | 8,970,524,587,826 | 37 |
| SAFE | 1,395,152,864,631,635 | 778,532,864,302 | 34 |

| Set | Sum of F1 | Sum of F2 | Sum of F3 |
|---|---:|---:|---:|
| Nonterminal | 53,810,356,539,069 | 4,263,532,579 | 195,075 |
| SAFE | 4,668,760,029,273 | 812,343,257 | 63,384 |

An alternative multiset-of-local-classes computation matches both orbit totals, without using the Burnside formula. Direct enumeration and rule evaluation match the weighted method on 1,205,820 small-pool physical states. Every layer total in the global index matches the original independent layer-count output. The count algorithms still reuse the foundational rule statistics and are not Lean-certified enumeration theorems.

Sources: mahjong_feasibility_review/count_states.cpp, count_layers.cpp, check_counts.cpp, check_multisets.cpp and their JSONL outputs.

## 6. Implemented lossless global index

The early feasibility report's statement that rank/unrank had not been implemented is historical. The implementation is build/global_retro/global_index.hpp, with index fingerprint 5a45ff3ea0fcf356.

The SAFE-compatible inventory contains:

| Index component | Size |
|---|---:|
| Actual reflection-canonical numeric local codes | 131,676 |
| Numeric statistical labels including tile count | 1,104 |
| Largest label's actual-code list | 3,403 |
| Actual canonical honour count histograms | 184 |
| Eligible sorted numeric-label triples | 3,199,905 |
| Distinct combined labels of such triples | 8,732 |
| Globally eligible honour/label-triple blocks | 60,789,499 |
| Maximum layer block count, at n = 22 | 6,606,828 |
| Dense colex triple-lookup entries | 224,871,920 |
| Dense colex triple-lookup bytes | 899,487,680 |
| Actual numeric transition entries | 743,423 |
| Actual honour transition entries | 446 |

A state preserves each numeric code's identity through a pair (group, member). The three such pairs are sorted, and the honour histogram identifies the bucket. SAFE membership and tile count are constant within a fixed group triple and honour histogram; individual member identity controls moves and remains in the rank.

For group sizes a,b,c, a block has size abc if all groups differ, C(a+1,2)c if only the first two agree, aC(b+1,2) if only the last two agree, and C(a+2,3) if all agree. Prefix sums give block offsets. Distinct-group coordinates use mixed radix. Repeated-group members 0 ≤ x ≤ y ≤ z use

```math
\mathrm{rank}_2(x,y)=x+\binom{y+1}{2},\qquad
\mathrm{rank}_3(x,y,z)=x+\binom{y+1}{2}+\binom{z+2}{3}.
```

The inverse chooses the greatest binomial prefix not exceeding the remainder, then decodes the remaining coordinates. Sorting by (group, member) instead of numerical base-5 code changes the chosen representative ordering but still bijectively represents the unordered multiset of the three reflected suit states.

Physical honour counts 3 and 4 are retained. A numeric fourth copy is also a real move. The global table does not use a mistaken N/SG=1 identification.

Completed exhaustive index checks cover all states and SAFE edges in layers 0–8, 33 and 34: 23,514,062 state round trips and 36,292,659 SAFE edges, with zero differences. The first earlier n=33/34 stride test overlaps with the full test and must not be added again. The full loop checks include rank/unrank, encoded physical state, canonical representative and equality of complete successor sets with the foundational moves routine. These finite test ranges are not an exhaustive independent round trip over all 778.5 billion states.

Source: runs/global_retro/index/provenance_v1.json and the full-edge/low-layer selftest logs.

## 7. Retrograde recurrence, memory and practical implementation

With K_n the n-tile SAFE orbits,

```math
N_n=\mathrm{Pre}(P_{n+1}),\qquad
P_n=K_n\setminus N_n.
```

K35 is empty. Thus K34 is entirely P, and descending layers determine a unique complete P/N labelling. The largest layer is n=23, with 96,268,928,092 orbits. Layers 23 and 24 together have 192,334,152,680 orbits, requiring 24,041,769,085 bytes for a simple unpadded one-bit pair of layers. That is a representation budget, not an incompressibility theorem or necessary total RAM.

The implemented engine processes an (n, honour histogram) bucket and loads its next-layer dependencies: the same honour histogram for numeric moves, plus at most four distinct honour-successor histograms. The largest single bucket has 12,297,042,846 states, and the largest parent-plus-all-dependencies bit payload is 39,588,434,170 bits, about 4.609 GiB. Directories, index tables, runtime, buffers and checkpointing add memory; the actual producer process peak was 10.641879040 GB of private memory.

The principal optimisations, present in the frozen v3 producer, were:

1. Precomputed physical local transitions and compact block/member ranks instead of full state hashing or explicit per-state edges.
2. Per-block target-group offsets: a transition whose target block is not SAFE is rejected before sorting child members or computing its rank. The first pilot rejected 93.34% of candidate actions only after costly lookups, exposing this hotspot.
3. Numeric local IDs ordered by increasing tile count, allowing one-way insertion when a local move increases an ID.
4. Early exit at the first P successor for an N parent.
5. Entire-bucket P filling where all legitimate complete successor buckets contain zero P entries. This is a sound bulk deduction from complete children, not arbitrary static-label P/N merging.
6. Word-aligned independent chunks for 16 worker threads, completion notification, honour-bucket scheduling and immutable completed layers.

The reported aggregate generation throughput includes sound bulk fills. It should not be described as 778.5 billion separate full 34-move expansions.

Data format MJGLOBAL_PN_V1 stores P=1 and N=0, the reverse of several legacy Boolean interfaces. Completion metadata, bit payloads, unfinished work and resumable chunks are different objects. An uninitialised zero bit is not a proved N.

The producer writes completed aligned chunks with their P counts and hashes, publishes done only after completion, flushes payload before atomically publishing resume metadata, and publishes a final complete record only once all chunks are done. Resume checks retain only complete, hash-consistent chunks. Tests reused 1,586,233,344 completed states after interruption and obtained a byte-identical completed approximately 6.06-billion-state bucket. This is evidence for tested interrupted-process behaviour, not a claim of power-loss durability testing.

Sources: runs/global_retro/RESULT.md, performance_review.md, CONTROL.md, index/INDEX_AUDIT.md in the feasibility audit, and build/global_retro/versions/v3/global_retro.cpp.

## 8. Actual resource measurements

Hardware/OS observations are from runs/global_feasibility_audit/resources_and_costs.json, dated 2026-09-12T18:35:25Z. They are observations of this machine at that time:

- Windows-11-10.0.26200-SP0.
- Intel Core i7-10700KF CPU at the reported 3.80 GHz model string.
- 16 logical processors; producer and parallel verifier used 16 threads for the large stages.
- 34,253,983,744 bytes visible physical memory; 21,835,415,552 bytes then available.
- NVIDIA GeForce RTX 2070 SUPER with 8,192 MiB observed VRAM. This work used the local CPU, not the GPU or cloud compute.
- Workspace disk then had 579,945,865,216 bytes free. Free space and available RAM are transient observations.

The source is C++17 with the workspace Windows toolchain and compatibility layer. Do not substitute the older Linux migration environment for these Windows global-run measurements.

| Measurement | Retained result |
|---|---:|
| Sum of disjoint generation stages that populate the retained table | 4,411.471922 s = 73.524532 min |
| Distinct states in those stages | 778,532,864,302 |
| Aggregate retained-generation throughput | 635,324,980,197.7 states/hour |
| Largest continuous generation stage, including supervisor | 4,150.063 s = 69.1677 min |
| That stage's engine time | 4,146.218582 s = 69.1036 min |
| That stage's average CPU, relative to all 16 logical processors | 88.8424% |
| Producer maximum private memory | 10,641,879,040 bytes |
| Producer maximum working set | 10,580,824,064 bytes |
| Layer 24 generation, including inter-layer setup and I/O | 529.578317 s |
| Layer 23 generation, including inter-layer setup and I/O | 490.421353 s |
| Final reverse-verification continuation, engine | 11,522.2 s |
| Same continuation, including supervisor | 11,525.047 s = 192.0841 min |
| New states verified in that continuation | 765,885,524,853 |
| Previously verified states reaccepted | 12,647,339,449 |
| Throughput using new verification work only | 239,234,416,091.4 states/hour |
| Reverse continuation average CPU | 86.5978% |
| Reverse maximum private memory | 4,197,928,960 bytes |
| Reverse maximum working set | 4,177,358,848 bytes |
| Physical deletion operations in the new verification work | 2,914,412,897,457 |
| Complete database bit-file bytes | 97,316,623,312 |
| Separate full payload-integrity scan | 217.806239 s, 32,677,888-byte peak working set |

The generation account combines four disjoint retained parts: the initial 34–32 pilot (303,054,865 states; 19.893651 s), one retained n31 calibration bucket (869,763,665 states; 10.590345 s), remaining layers 31–29 (26,032,139,298 states; 234.769344 s), and layers 28–0 (751,327,906,474 states; 4,146.218582 s). It is **not a claim that a single fresh run of one frozen version was measured at 73.52 minutes**. Development, discarded benchmarks, earlier verification seeds and the later full reverse replay are additional costs.

The difference between 69.10 and 69.17 minutes is engine versus supervisor wall time; do not mix them. A same-workload 8/16-thread comparison reported approximately 33% lower elapsed time with 16 threads, not linear twofold speed-up.

Sources: runs/global_retro/generation_account.json, layer_timings.json and verification/final_v1/acceptance.json. No new performance benchmark was run for this memo.

## 9. Verification architecture and its limits

### Foundational and legacy checks

The independent Python subset-extraction oracle agreed with the C++ rule implementation on 4,589 physical global states including 173 constructed winning targets. Local extraction profiles and quotient successors were exhaustively compared over 5^9 = 1,953,125 suit states. Four small unpruned achievement-game cases used 347 raw states. Six independent small strategy certificates covered 1,159 nodes. A finite four-element test checked 166 upward winning families and 283 SAFE positions against the SAFE normal-play reduction. These scopes overlap other tests and are not a count of all independently verified global positions.

The global table was checked against 16,240 unique historical expected P/N states extracted from 47 frozen source files, with zero conflicts or UNKNOWN. The 16,237 round-9 facts include the 35-root, 179-root, 445-boundary and latest M/S subsets; H222, H33 and H224 add three unique named states. The overlapping categories must not be summed as if independent. The new 55 frontier answers are intentionally not part of this historical expectation set.

### Full reverse recurrence replay

The primary engine is parent-driven. The second implementation scans next-layer P bits, decodes the corresponding physical position, deletes each available numeric tile or an appropriate honour representative, canonicalises and ranks the predecessor, and marks it N. It does not call Numeric.next or Honor.next to generate these verification edges. Atomic OR makes repeated predecessor marks harmless; comparison occurs after worker completion.

SAFE is downward closed: if y ≤ x and x is SAFE, then y is SAFE. A legal addition to y either remains a submultiset of x, or remains a submultiset of the same legal addition to x, so it cannot create a winning subset. Consequently deleted predecessors of SAFE children require no extra SAFE query. Symmetry preserves moves, so deleting physical representatives and canonicalising covers predecessor orbits.

Once all relevant P children have been processed, the complement of the N marks is compared against every stored parent bit. Doing this over every layer, together with the empty layer-35 boundary, validates the unique finite recurrence. The comparison order may be ascending if every parent/child relation is checked against the fixed table; the correctness argument is by descending induction after all equalities have been established.

The completed records comprise 450 v2 buckets with 12,647,339,449 states and 3,236 v3 buckets with 765,885,524,853 states. Reuse rechecked real source and parent payloads and an input signature; reused states are not newly replayed work in the final run's speed figure. The v3 compatibility audit fixes five identical mathematical/reader/core segments and unchanged shared dependency hashes.

The v2 interruption was a Windows progress-file atomic-replacement failure. Directed reproduction observed Win32 error 5 from a normal Python read handle; the historical failure did not log its exact error code, so identifying OneDrive or a particular reader as its unique cause would overclaim. v3 added bounded retries for errors 5, 32 and 33, preserved hard failure for permanent errors and retained accepted v2 records. Eleven directed tests passed. The final v3 continuation completed normally with no value mismatch.

### Integrity and evidence-record checks

All 3,686 bit files, totalling 97,316,623,312 bytes, were read by the separate full-integrity run. It checked exact catalogue sizes, metadata, word-FNV64, P popcounts, zero padding and generated SHA-256 digests. This integrity run is distinct from the reverse recurrence run.

The finalisation script read small evidence files and record manifests. It did not reread payloads or execute the P/N recurrence. Similarly, a live metadata summary is not a proof of payload or P/N correctness. These distinctions are explicitly retained in the JSON fields.

### Remaining correlated risks and unfinished proof work

Both global implementations use the same foundational rule tables and compact Index. Their agreement provides algorithmic cross-checking against move-plan, early-exit, forward-transition and bit-update errors, but cannot automatically expose a common modelling or indexing error. The independent Python rule checks and complete small-layer index checks reduce that risk within their stated scopes. A fully separate full rule/index implementation or a kernel-checked opening certificate remains a meaningful next verification step.

No current invalidation of the global result was found in the inspected completed records. Known earlier flaws were bounded and repaired: accepting a final bucket without checking its actual payload, and the Windows progress replacement issue. Do not label these historical repairs as unresolved P/N contradictions.

## 10. Round-9 local development, before global solution

Round 9 remains a useful methodological contribution even though the global table later closes its frontier.

The local proof chain was:

~~~text
exact 12-tile P responses
    -> 11-tile N
    -> 10-tile T is P by all-child coverage
    -> 9-tile S is N
    -> 8-tile M is P by all-child coverage.
~~~

The shared boundary batch had 246 candidate response relations and 319 distinct copy targets, of which 318 were newly queried. It returned 109 P, 209 N and no UNKNOWN in 217.828 seconds, with no external facts or loaded checkpoint. All 109 P roots had all their physical SAFE successor values checked: 2,350 edges. This increased relation coverage from 6 to 106 of 246, leaving 140 uncovered; copying alone did not close any full T. Mixed triplet upgrades, honour fourth copies and new singletons supplied the later gaps.

The final local fact closure has 16,237 facts from 12,253 source states and 4,139 verified inference edges:

| Inference form | Count |
|---|---:|
| Source | 12,253 |
| Exact SG honour-pass fact | 211 |
| P successor implying N | 2,933 |
| P predecessor relation | 649 |
| P honour-pass relation | 180 |
| All children N implying P | 11 |

The all-child proofs comprise six new ten-tile T roots and five new eight-tile M roots. The local M status advanced from 12 P/23 UNKNOWN to 17 P/18 UNKNOWN. The original S41 advanced from 41 UNKNOWN to 6 N/35 UNKNOWN. The five new M pair supports were {1,9}, {2,5}, {2,6}, {3,7}, {4,6}, in one suit plus two distinct honour pairs. Together with the old {2,8}, the four reflected-pair cases r²(10−r)²H²J², r=1,2,3,4, formed a closed finite P family.

The portable shallow response certificate covers all 34 physical actions at each of 11 new P roots: 374 rows. Its independent audit checked 143 P response premises and a 316-fact acyclic inference dependency graph; 36 source identities matched. The numeric leaf values remained premises from exact regional computations, so the certificate was not then a completely expanded terminal-leaf proof.

The round-9 fact distribution is:

| Tiles | P | N |
|---:|---:|---:|
| 7 | 0 | 42 |
| 8 | 17 | 0 |
| 9 | 0 | 932 |
| 10 | 281 | 33 |
| 11 | 4 | 6,385 |
| 12 | 493 | 2,638 |
| 13 | 427 | 4,985 |

Repeated q5-context eviction was a practical bottleneck in isolated shallow DFS. Grouping common concrete boundary supports and selectively increasing module caches reduced repeated work. One key 11-tile root finished in approximately 4.575 seconds with no evictions after adding eight N boundary facts and increasing cache allowance; this was not a single-factor cache-size benchmark. The final batch used a 1,536 MiB limit per module and approximately 2.72 GiB measured process working-set peak. Two move orders agreed on the first 20 roots (6 P/14 N) and had similar total time, providing no basis for a general speed-up claim.

Sources: runs/round9/RESEARCH_UPDATE.md, REPRODUCE.md, runs/round9_boundary/classification.json, runs/round9_math/round9_final_summary.json, round9_final_facts_verified.json and runs/round9_native/final_audit.json.

## 11. Checkpoints, identity and reproducibility

Delivered round-8 seeds were not altered; round 9 reverified all 1,105 delivered file hashes. Checkpoint record counts are completed internal values or constraints, not new distinct root theorems.

| Local checkpoint | Completed resident P/N cells | Contexts | Compressed bytes | SHA-256 |
|---|---:|---:|---:|---|
| runs/round9_solver/final2_probe.gz | 93,351,433 | 125 | 111,859,369 | 729b1c2d192cd7158b3f33a4c5571a179a8e7807bca9152c18b851bc0d9d3efe |
| runs/round9_boundary/all_targets.gz | 84,179,404 | 37 | 66,780,343 | 9eddeacbf39ba485e07fad66e584196e18c773e4ddd69852cda34fad3d699063 |
| runs/round9_boundary/endpoint_responses.gz | 126,472,717 | 44 | 80,174,020 | 8edd515d2c1a7d41de68bc320389206f19bbee2b7b9ca2841acfb96cb539dbdf |
| runs/round9_boundary/center_probe.gz | 6,527,147 | 23 | 8,421,055 | f5aa260152c624184b4193e632a5f6db0ebc23051802fe5e94a060cddcd811df |

These use MJDENS08 v1 flavour 2, retain only resident completed module values, and omit unfinished recursion stacks and evicted data. They are not interchangeable with SG mask files or the full global physical bit table.

Useful frozen global identities:

| Artifact | SHA-256 |
|---|---|
| Global Index source | b742e5bbb20ed0df50665c0d454d3bf4b7691dabc4d2d0380e7159766f8bf0c8 |
| Foundational rules source | 1194d941c55b48c4ac686f29518c3fe032723a431125610b2a3509f8db04242f |
| Frozen v3 producer source | 6664c16ab99d058478cc10d7b85edbf43328884f5c1a8d5abf12fecf274acee8 |
| Frozen v3 producer executable | 14b51a105924a20d925bccebb33ec85961760620b268ac67a96c335ffc124735 |
| Frozen v3 reverse executable | 0c091c3be5b0425e33dee2c56d586187d95fcbc83ec077c8b3b0a410fadb5612 |
| Final acceptance JSON | 1cc4b9dc7bd287e976d42d6b7fb41eb548651529016e53485008828c97d826a5 |
| Full payload SHA-256 manifest | a590af16189fe9acf22fae18d8a95095bcb9f9926db2d6eaa585511eea21e88c |

The local publication record identifies the source/lightweight-evidence release at github.com/feierbuqiu/mahjong-achievement-game, tag v0.1.0, target 5a942090ac77fdf63a3d528054dd2c0cbaab138f. According to runs/publication_20260913/publication.json, the full 97.32 GB table and active Lean working tree were outside that public release. The paper must not imply that a small public evidence bundle alone reproduces the full table or contains the latest Lean development. Web/public availability should be checked separately by the paper author before giving a current availability statement.

## 12. All 35 SAFE layers and P/N counts

This table was freshly aggregated for this paper audit from the 3,686 accepted .verified.json records in runs/global_retro/verification/full_v2_records/. It is a reaggregation of retained verified output, not a new global computation.

| n | SAFE orbits | P | N | Nonempty buckets |
|---:|---:|---:|---:|---:|
| 0 | 1 | 1 | 0 | 1 |
| 1 | 6 | 0 | 6 | 2 |
| 2 | 47 | 14 | 33 | 4 |
| 3 | 298 | 46 | 252 | 7 |
| 4 | 1,725 | 404 | 1,321 | 12 |
| 5 | 8,967 | 1,679 | 7,288 | 18 |
| 6 | 42,793 | 11,159 | 31,634 | 27 |
| 7 | 187,376 | 34,632 | 152,744 | 38 |
| 8 | 760,493 | 187,425 | 573,068 | 52 |
| 9 | 2,874,880 | 531,639 | 2,343,241 | 68 |
| 10 | 10,187,475 | 2,248,838 | 7,938,637 | 87 |
| 11 | 34,006,368 | 5,951,610 | 28,054,758 | 107 |
| 12 | 107,440,638 | 21,282,781 | 86,157,857 | 130 |
| 13 | 321,356,083 | 52,530,670 | 268,825,413 | 148 |
| 14 | 903,209,000 | 172,931,755 | 730,277,245 | 163 |
| 15 | 2,346,950,750 | 387,779,363 | 1,959,171,387 | 170 |
| 16 | 5,544,554,559 | 1,146,615,962 | 4,397,938,597 | 174 |
| 17 | 11,780,250,236 | 2,127,213,505 | 9,653,036,731 | 173 |
| 18 | 22,376,865,721 | 5,169,175,844 | 17,207,689,877 | 173 |
| 19 | 37,804,625,883 | 7,545,862,761 | 30,258,763,122 | 173 |
| 20 | 56,566,252,124 | 14,418,956,851 | 42,147,295,273 | 173 |
| 21 | 75,050,088,557 | 16,379,219,048 | 58,670,869,509 | 172 |
| 22 | 89,127,184,893 | 24,583,507,136 | 64,543,677,757 | 170 |
| 23 | 96,268,928,092 | 22,390,373,365 | 73,878,554,727 | 167 |
| 24 | 96,065,224,588 | 27,864,862,842 | 68,200,361,746 | 163 |
| 25 | 88,982,128,123 | 21,663,176,175 | 67,318,951,948 | 160 |
| 26 | 75,440,492,234 | 22,885,068,257 | 52,555,423,977 | 158 |
| 27 | 56,645,165,793 | 14,906,959,805 | 41,738,205,988 | 157 |
| 28 | 35,949,118,771 | 11,937,273,296 | 24,011,845,475 | 153 |
| 29 | 18,221,731,480 | 5,735,300,814 | 12,486,430,666 | 143 |
| 30 | 6,893,983,233 | 2,718,161,072 | 4,175,822,161 | 126 |
| 31 | 1,786,188,250 | 805,422,067 | 980,766,183 | 99 |
| 32 | 280,542,509 | 116,909,120 | 163,633,389 | 68 |
| 33 | 21,924,455 | 13,354,184 | 8,570,271 | 37 |
| 34 | 587,901 | 587,901 | 0 | 13 |
| Total | 778,532,864,302 | 203,051,492,021 | 575,481,372,281 | 3,686 |

## 13. Current table queries for the 41 honour-upgrade T roots

This small additional check was executed for the paper audit on 13 September 2026. Inputs were derived from each state in mahjong_round7/math/four_pair_unknown_frontier.json /rows: replace its final digit 2 with 3. All 41 source states end in the canonical honour histogram 0000022, so this is precisely one existing honour pair upgraded to a triplet, with no numerical changes or arbitrary restriction on future moves.

The wrapper build/global_retro/verify_oracles_run.cjs checked its frozen sources and executable identities. The query used the retained full data directory, no output-file argument, no search, and a 120-second query cap. The result was 23 P and 18 N; all one-step recurrences passed, zero UNKNOWN, 7,504 payload bytes checked, native query time 1.1495 seconds. The SHA-256 of the captured UTF-8 stdout with Python universal-newline normalisation was abefcf623805283771c542b76dcd50cc2adfe5c84e12439aad89abb3b2486563. Raw stdout was not written as a separate artifact; the complete requested-state/outcome list follows.

~~~text
0000000000000000000000001220000023 P
0000000000000000000000002120000023 P
0000000000000000000000002210000023 P
0000000000000000000000012200000023 P
0000000000000000000000021200000023 P
0000000000000000000000022100000023 N
0000000000000000000000102020000023 N
0000000000000000000000120020000023 N
0000000000000000000000201020000023 N
0000000000000000000000202010000023 P
0000000000000000000000210020000023 P
0000000000000000000000220010000023 N
0000000000000000000001200020000023 N
0000000000000000000001200200000023 P
0000000000000000000001202000000023 P
0000000000000000000001220000000023 P
0000000000000000000002100020000023 N
0000000000000000000002100200000023 P
0000000000000000000002102000000023 P
0000000000000000000002120000000023 P
0000000000000000000002200010000023 N
0000000000000000000002200100000023 P
0000000000000000000002201000000023 P
0000000000000000000010000220000023 N
0000000000000000000010022000000023 P
0000000000000000000012000020000023 N
0000000000000000000012002000000023 N
0000000000000000000020000120000023 N
0000000000000000000020000210000023 N
0000000000000000000020012000000023 P
0000000000000000000021000020000023 P
0000000000000000000022000010000023 N
0000000000000000001000000220000023 P
0000000000000000001200000020000023 P
0000000000000000002000000120000023 P
0000000000000000100000220000000023 N
0000000000000000200000120000000023 N
0000000000000000200000210000000023 P
0000000000000001000000220000000023 N
0000000000000002000000120000000023 N
0000000000000002000000210000000023 P
~~~

The formerly prioritised T = 0000000000000000000000102020000023 is therefore N, not still UNKNOWN. Failure of earlier 120-second searches was never evidence that it was P.

## 14. Future work and claims to exclude

Supported future directions are independent full-rule/index replay, compact reusable formal strategy certificates, reducing certificate graph growth through response selection and shared certified subgraphs, formalising the index bijection and SAFE-layer counts, and packaging the full table or a reproducible regeneration workflow. Do not promise a small opening certificate merely because local 12-tile roots now certify. A strategy DAG retains one action at the winning player's turns and all opponent choices; full-state counts are not a lower bound on the size of the smallest such DAG.

Decision diagrams remain a possible representation alternative but no MDD global solver was implemented. The physical one-bit implementation already completed the computation. Earlier speculative one-day/month/year resource projections belong in the historical method discussion, if included at all, with their historical uncertainty made clear.

The honour-pass abstraction remains mathematically useful locally. Normalising every honour 3 to 4 leaves 739,728,556,032 SAFE bases, about 95.0157% of the physical orbit count. Storing only actually required parity channels needs 777,570,698,880 logical bits, saving only 0.123587% against the physical table. Thus it did not supply a multiple-fold global reduction. A mathematically derived alternative base DP needs only SG classes 0, 1 and at least 2, with ordinary edges into n+1 and new-pass edges into n+2; it was tested only in a closed honour model, not used as this global physical-table solver.

The existing four-meld endgame theorem covers 33,542 SAFE orbits, distributed over 12–16 tiles as 10,573; 12,761; 7,417; 2,369; 422. It covers no states on the 23/24 peak layers. This explains why a valuable local theorem did not erase the global peak.

Do not claim general PSPACE-completeness for this one fixed 34-kind instance. General Node Kayles complexity applies to growing graph families, not automatically to this fixed game. Excluding a fixed symmetry-response construction is not excluding all adaptive strategies.

### Scholarly integrity and source independence

The historic feasibility document discusses an unnamed other person's 37-tile construction, MDD proposal and one-year/2 TB estimate. Therefore a blanket historical assertion that no other participant material was ever seen is not established by these artifacts. The paper can accurately state that **no result or conclusion from another competitor is used as a proof premise or as a computational regression oracle in the results reported; the presented derivations and computations were independently developed**, while acknowledging the problem's initial source and citing genuine general literature. This better matches the user's requested integrity than an absolute claim about all reading history.

The source/lightweight public release is an authored software/result source; textbook theory, Burnside counting, impartial-game methods, Node Kayles and proof-assistant background need independently verified genuine literature. This memo supplies no invented bibliographic records.

### Memory usage note for the parent response

A quick memory lookup was used only to locate the known round-9 update path and checkpoint-first caution. Every numerical claim in this memo was obtained from live local files or the described current read-only checks. The relevant memory citation, if the final parent answer needs it, is MEMORY.md:21-25, rollout 01a096ce-f352-7541-b7b3-21ebf98c2b9b. Do not insert memory citations into the academic manuscript.

## 15. Independent review of manuscript sections 4–6, 8 and 9

Review snapshot: manuscript.md SHA-256 9757d8da74b9f4918cdf09b37821c06dd7b919b4e8aa47fb6112b7d38c924d7e, read on 13 September 2026. The manuscript was not edited by this reviewer. This review found no numerical or game-theoretic defect in its computational solution, selected classifications, opening responses, or stated formalisation boundary.

### Corrections and precision edits recommended

1. **Section 5.4, “give a dense global rank”.** The implementation gives a dense rank inside each (tile count n, honour ID h) bucket. The global identity is the tuple (n,h,rank), not the rank alone. Suggested replacement: “Prefix sums give a dense rank within each bucket; the tuple (n,h,rank) identifies a global SAFE orbit.” The next statement should describe 60,789,499 logical compatible blocks across 3,686 buckets, without implying that every block directory is permanently stored: the engine builds directories for the required buckets.
2. **Section 5.5, whole-block P fill.** The frozen v3 production shortcut fills an entire parent bucket when every legitimate complete dependency bucket has zero P entries. The current wording says a parent block can be filled P. That implication is mathematically true, but changing “block” to “bucket” describes the measured implementation exactly and avoids conflating it with the stronger per-block summary optimisations that appeared as earlier proposals.
3. **Section 6.3, 69.10 minutes.** Label this explicitly as engine wall time. The engine observation is 4,146.218582 seconds (69.1036 min); the same stage including the supervisor is 4,150.063 seconds (69.1677 min). The reverse-replay row already explicitly includes supervisor overhead.
4. **Section 6.3, machine description.** The CPU model and OS are actually observed, not merely inferable. Replace the remarks about not inferring a model with the recorded platform: Intel Core i7-10700KF, Windows-11-10.0.26200-SP0, 16 logical processors and 34,253,983,744 bytes of visible physical memory. This is scientifically more useful than a processor-count-only performance claim. Identify the hardware record as an observation at its own timestamp; no need to imply current free RAM or disk space is unchanged.
5. **Section 5.3, optional methodological addition.** The totals are accurate but the exact counting mechanism would be more reproducible with the S3 formula (F1+3F2+2F3)/6 and the statement that a k-cycle repeats one actual reflected local code k times while counting the choice weight once. These details distinguish correct stabiliser-aware counting from simply dividing by the group order or treating repeated statistical labels as independently chosen states.
6. **Section 6.1, optional padding precision.** The stored difference is due to independently padding every bucket to 64-bit words. The exact total is sum over buckets of 8 ceil(states/64) = 97,316,623,312 bytes. The ideal contiguous byte-rounded array would have 97,316,608,038 bytes; the difference is only 15,274 bytes.

### Correctness checks that passed

- The group S7 × (C2³ ⋊ S3) and order 241,920 are correct for the stated symmetry actions. Local reflection canonicalisation followed by sorting the three retained actual suit members produces the intended suit-multiset quotient. Numerical member identities are preserved; no arbitrary rank permutation or static-profile merging is introduced.
- The four block-size cases and both repeated-member colex formulae are correct. Distinct-suit copies may use the same local code, so combinations with repetition are required.
- The forward recurrence, K35 boundary, P-successor early exit and complete-successor requirement for P are correct. The whole-dependency-zero shortcut is based on completely computed tables.
- Reverse physical deletion covers all predecessor orbits. For an honour histogram transition, the implementation can use one honour-deletion representative yielding the target histogram; deleting every equivalent physical honour kind is unnecessary. The manuscript's conceptual “delete each present kind” description is sound, but an optional parenthetical about equivalent honour deletions would describe the exact implementation more precisely.
- The common rule/index dependency is clearly disclosed. The text does not misrepresent full reverse replay as a wholly independent rule model or as Lean certification.
- All six first-response examples agree with retained canonical witnesses after legal suit/reflection transformations. The rank-5 reply may use either other suit; the honour reply may use rank 2 in any suit. Reflect the reply and first tile together for first ranks 6–9. These examples do not imply a fixed strategy on later moves.
- The second-player strategy loop is valid from the empty P invariant. If the opponent stays SAFE, the second player receives N; if the opponent leaves SAFE, an immediate win exists. Winning-first checking is correctly placed before SAFE table lookup.
- Counts in Section 4.5 sum correctly to 179 = 165 P + 14 N. The historical/current M and S counts in Section 4.6 are correctly distinguished. The current 483-family total 3 P + 480 N is a legitimate arithmetic combination of two disjoint classifications.
- The six-pair arithmetic also matches: C(34,6) = 1,344,904 = 1,266,064 + 78,840. This review checked its count arithmetic; the full structural proof audit remains the separate mathematical review.
- Reaggregation of all accepted records gives P+N = 778,532,864,302 and the exact stored-byte total above. The two peak layers give (96,268,928,092 + 96,065,224,588)/8 = 24,041,769,085 bytes.
- The Node Kayles route in Section 8.3 is correctly conditional: after singleton-forbidden vertices are removed, all remaining minimal forbidden edges must have size two. Its warning that variable-family hardness does not classify this fixed Mahjong instance is correct.
- Section 8's remaining-work statuses distinguish a computed winner from an unfinished certificate and do not interpret candidate node counts as a completion percentage.

### Availability and independence review

The local Git tag v0.1.0 was resolved read-only and is exactly 5a942090ac77fdf63a3d528054dd2c0cbaab138f, agreeing with Section 9.1. The repository's reproducibility/data-availability guides identify full reconstruction commands, per-bucket hashes and a full table excluded from Git. The later Lean publication record is distinct: runs/lean_publication_20260913/publication.json identifies merged PR 4 and main commit 6fc0c04ad3b5397893c3937560dab40d516d6c59. Therefore the manuscript correctly avoids attributing all later formalisation to v0.1.0 or claiming the newest twelve-tile closure is in that tagged release. This subreview verified retained/local publication evidence rather than refreshing the remote hosting state.

Hardware ledger entry re-read on 13 September 2026: runs/global_feasibility_audit/resources_and_costs.json, SHA-256 62d28c91ba8689ec72487418e30a6d66e631dfeb8e198a5fd753d4d7b336ff02. Its recorded observation is 2026-09-12T18:35:25.652335+00:00 (13 September 2026, 04:35:25 Australia/Sydney). The exact JSON fields are /hardware/platform = Windows-11-10.0.26200-SP0, /hardware/processor_name = Intel(R) Core(TM) i7-10700KF CPU @ 3.80GHz, /hardware/logical_processors = 16, and /hardware/physical_memory_bytes = 34253983744. These fields are recorded hardware observations; the current manuscript audit did not remeasure hardware.

Section 9.3's wording is academically appropriate and faithful to the user's requested independent-work declaration: it states that other competitors' conclusions are not proof premises, oracles or incorporated research results, while allowing prior general literature and acknowledging that historical notes discussed external suggestions. It does not assert that no such suggestion was ever seen. The introduction and acknowledgements are consistent with this qualified statement. No additional accusation, warning or competing-result citation is needed.
