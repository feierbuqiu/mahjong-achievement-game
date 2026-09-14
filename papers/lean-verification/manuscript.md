# Lean Verification of the Mahjong Achievement Game: Strategy Certificates, Enumeration, and Retrograde Models

**feierbuqiu**

*15 September 2026*

> **Publication edition: v1.0.0.** This English supplement is published alongside the [September 13 paper](../manuscript.md). The release closes the maintainer's active research phase; further updates are expected only for substantive new results or necessary corrections. The end-to-end empty-position Lean theorem remains `NOT_VERIFIED`. See the [publication and evidence catalogue](README.md).

## Abstract

This paper supplements the September 2026 report on the Mahjong Achievement Game, which presented a computational second-player win on a shared table and partial Lean certification. The subsequent formalisation has developed in two directions. Explicit response certificates now support a retained registry of 24,655 distinct P positions, including four twelve-tile roots. A complementary programme proves general theorems about the finite representation and solution method: exact local predicates, canonical representatives, complete orbit enumeration, rank and inverse rank, bounded machine arithmetic, cached successors, optimisations, and bottom-up retrograde evaluation. Completed compiled Lean checks also cover 22,512,356 distinct historical P/N positions, comprising the entire thirty-three- and thirty-four-tile layers. The latest development adds ten core modules with 79 audited theorem declarations and a dependency closure of 84 source modules. Bounded tests exercise the frozen production C++ implementation on synthetic child labels, including parallel execution and checkpoint recovery. We explain how these results fit together, distinguish kernel proofs from compiled finite evaluation and implementation tests, and specify reproducible verification procedures and their input requirements. The historical empty-table outcome remains a computational result: neither an end-to-end Lean certificate for that outcome nor a universal refinement proof of the complete optimised C++ solver has been obtained. The supplement identifies the remaining obligations without treating incomplete work, repeated benchmark evaluations, or general algorithm correctness as a completed opening proof.

**Keywords:** formal verification; Lean; computer-assisted proof; impartial games; retrograde analysis; symmetry reduction; proof certificates; reproducibility

## 1. Purpose, baseline, and evidence cut-off

The earlier paper, *Mahjong Achievement on a Shared Table: A Computational Second-Player Win and Partial Lean Certification*, reported a complete Boolean retrograde computation over 778,532,864,302 SAFE symmetry orbits. It classified the empty table as P and the six first-move orbits as N. A reverse computation reproduced the historical table without disagreement, although the two computations shared their foundational rules and index. Its strongest reported explicit Lean strategy began from a particular twelve-tile table and used 757 reusable P rows. It expressly left the empty-table Lean proof incomplete ([feierbuqiu, 2026b](https://github.com/feierbuqiu/mahjong-achievement-game/blob/v0.3.0/papers/manuscript.md)).

This supplement documents what changed after that paper's 13 September cut-off. It concentrates on verification rather than repeating the structural analysis, regional classifications, or full computational history. Those earlier results remain part of the research record. In particular, an old migration document stating UNKNOWN describes its own earlier checkpoint; it does not undo the subsequent computational solution. Conversely, a later computational result does not close a missing Lean theorem.

The present cut-off is 15 September 2026 in Sydney. Several final receipts are dated 14 September in UTC; for example, the current verification status was recorded at 16:41:40 UTC, corresponding to 02:41:40 on 15 September in Sydney. We use the latest completed acceptance records, frozen source identities, and the preserved certificate registry. An unfinished batch, even if its database status still says `KERNEL_RUNNING`, is excluded. No paused global verification campaign was resumed in preparing this paper.

The principal changes are summarised in Table 1. The evidence identifiers S01–S13 refer to the local sources in Appendix B. They distinguish project evidence from the published works in the APA reference list.

**Table 1. Verification progress relative to the earlier paper.**

| Subject | Earlier paper, 13 September | Present supplement |
|---|---|---|
| Computational opening result | Empty table P; full reverse replay agrees | Result retained; no new full-table computation is claimed |
| Explicit twelve-tile strategies | One highlighted root, with 757 reusable P rows | Four twelve-tile roots; 24,655 distinct P facts in the retained cumulative registry |
| Shallower explicit certificates | No closed empty-table theorem | Neither a ten-tile root nor the empty root has closed |
| Historical labels checked by compiled Lean | Not the main certificate route reported there | Complete near-terminal and terminal layers, 33 and 34 tiles: 22,512,356 distinct positions |
| Representation and enumeration | Mathematical description, computational audits, and some formal index arithmetic | General formal coverage, uniqueness, rank, decoding, and scan theorems, with explicit finite-data premises |
| Actual cached transitions | Used by computation; local strategies checked physical moves separately | Complete finite checks of 131,860 records and 743,869 edges, linked to a formal SAFE transition quotient |
| Retrograde algorithm and optimisations | Recurrence justified mathematically; implementation audited computationally | Kernel-checked models of bottom-up evaluation, key optimisations, cache use, and word ownership |
| Production implementation | Historical global run and full reverse replay | Additional bounded tests of actual C++ routines, synthetic labels, concurrency, and recovery |
| End-to-end Lean opening status | Incomplete | `NOT_VERIFIED` |

The contribution is therefore substantial even though the final opening status has not changed. The project now explains and checks much more of the machinery between the original game and a dense retrograde table. The scope of each connection, and the kind of evidence supporting it, are the subject of the following sections.

## 2. Formal problem and levels of assurance

### 2.1. The original game and the SAFE reduction

There are 34 tile kinds, with four copies of each kind. A valid table is a vector $`x\in\{0,1,2,3,4\}^{34}`$, and $`\vert x\vert `$ denotes its total number of tiles. Players alternately add one available tile to the same cumulative table. A player wins immediately when their addition first makes the table contain a legal fourteen-tile winning submultiset.

The allowed targets are four melds and one pair, seven pairs of seven distinct kinds, and thirteen orphans. A meld is a triplet or a numerical sequence of three consecutive ranks in one suit. Every target must obey the four-copy constraint. Seven pairs cannot count a quad as two distinct pair kinds. Tiles outside a winning submultiset do not invalidate that target. These are the modelling assumptions of this achievement game; they are not a claim about all forms of ordinary Mahjong.

Writing $`\mathcal W`$ for the family of targets and $`e_t`$ for one tile of kind $`t`$, define

```math
\mathrm{Win}(x)\iff\exists w\in\mathcal W\;(w\leq x),
\qquad\text{(1)}
```

```math
\mathrm{Safe}(x)\iff
\neg\mathrm{Win}(x)\ \land\
\forall t\,[x_t<4\Rightarrow\neg\mathrm{Win}(x+e_t)].
\qquad\text{(2)}
```

The SAFE normal-play graph retains only legal additions whose destinations are SAFE. The earlier reduction, formalised as `Mahjong.original_safe_reduction`, preserves the P/N outcome and provides a bridge back to strategies in the original achievement game. A departure from SAFE gives the responding player an actual winning addition. Thus a SAFE strategy is useful only because its connection to the original rules has been proved.

P denotes a loss for the player about to move, and N a win for that player, under optimal play. These are Boolean outcome classes. N is not a claim that the Sprague–Grundy value equals one. UNKNOWN records missing knowledge or an unfinished computation; it must never be inserted into the recurrence as P or N.

Let $`S_n`$ be the SAFE orbits with $`n`$ tiles. The relevant symmetry group allows permutation of the numerical suits, independent rank reversal within each numerical suit, and permutation of the honours. For a P bit $`p`$, the finite recurrence is

```math
p(x)=1\iff
\forall y\,[x\longrightarrow_{\mathrm{SAFE}}y\Rightarrow p(y)=0].
\qquad\text{(3)}
```

Equivalently, a position is N precisely when it has a SAFE P successor. Every edge adds one tile. The established upper bound $`\vert x\vert \leq34`$ for SAFE positions supplies a terminal layer, but the bound alone says nothing about the parity of every possible play or the outcome of the empty table.

### 2.2. What a Lean result establishes

Lean combines a programming language with a proof assistant whose elaborated proofs are checked against a small logical kernel ([de Moura & Ullrich, 2021](https://lean-lang.org/papers/lean4.pdf)). That combination makes two different uses possible here: Lean can construct proof terms, and compiled Lean can execute a finite checker. The two uses need separate descriptions.

We distinguish five forms of evidence.

| Evidence class | What the accepted artefact establishes | What is still required |
|---|---|---|
| **General kernel theorem** | A proposition follows from its displayed definitions and hypotheses | The hypotheses must be instantiated for the intended concrete data or implementation |
| **Concrete kernel certificate** | A specified finite position has the stated strategy in the formal game | Interpretation of the formal rules, the kernel, and the allowed foundational axioms |
| **Compiled finite check** | A particular executable checker accepted the identified input domain | Compiler, runtime, parsing and I/O behaviour, as well as the soundness theorem and input binding |
| **Implementation correspondence and tests** | Frozen code matches the inspected model at documented points, and selected executions agree with controls | Unexamined executions and unproved implementation semantics remain outside this evidence |
| **Historical exhaustive computation** | The identified global computation and replay completed with the recorded outcomes | Their implementation, enumeration, data integrity, and execution assumptions |

An axiom audit checks what a theorem actually depends on. The official guidance also emphasises that validating a proof and interpreting its statement are separate tasks ([“Validating a Lean Proof,” n.d.](https://lean-lang.org/doc/reference/latest/ValidatingProofs/)). In this project the audited theorem dependencies are confined to `propext`, `Classical.choice`, and `Quot.sound`, where needed. The new model modules use no `sorry`, added axioms, or `native_decide`. The retained builds use `--trust=0`; the new model replay uses a 3 GiB Lean heap limit per process and one Lean thread per compilation.

Those checks do not turn an external native run into a kernel proof of its output. A theorem of the form

```math
\mathrm{check}(D)=\mathrm{true}
\quad\Longrightarrow\quad
\mathrm{Specification}(D)
\qquad\text{(4)}
```

is a kernel theorem. A receipt saying that a compiled executable returned `true` on the bytes of $`D`$ is evidence for its premise at a broader execution boundary. Unless that premise has itself been supplied as a kernel-checked proof for the concrete data, the fully instantiated statement is a computer-assisted conclusion. In particular, the absence of `native_decide` in a general theorem does not remove the native-execution dependency of a separate data check.

The design follows the established separation between computation and a proved checking procedure associated with reflective verification ([Boutin, 1997](https://link.springer.com/chapter/10.1007/BFb0014565)). Here, however, the paper labels each concrete evaluation route explicitly instead of using “reflection” as a blanket assurance claim.

## 3. Growth of explicit strategy certification

### 3.1. The inherited certificate method

The original local route certifies responses directly in the 34 physical count coordinates. For each SAFE P row $`x`$, and for every legal first addition $`a`$, the certificate supplies a legal reply $`b`$. That reply either produces an explicitly checked winning fourteen-tile target or reaches a previously certified P position, possibly after a checked rule symmetry.

Internal references decrease in proof-row order; external references return a value carrying an already established proof. Their targets have two more tiles in actual play, although their proof identifiers occur earlier in the dependency graph. The checker verifies the complete first-action coverage, legality, target coordinates, symmetry action, and reference discipline. It therefore rejects a response list that merely covers selected opponent moves.

SAFE facts can be reused by downward closure: if $`x\leq\gamma(z)`$ and $`z`$ is already known SAFE, the corresponding checked inclusion and symmetry establish SAFE for $`x`$. Independent SAFE leaves avoid circular use of the strategy table being certified. Bounds on meld capacity accelerate ordinary-hand exclusion, while seven pairs and thirteen orphans remain separately checked. The ordinary winning witness checks the actual target under the four-copy rule. These mechanisms were already present in the earlier twelve-tile milestone; the subsequent growth uses them as established infrastructure (S01–S03).

This route gives a particularly useful assurance boundary. The search engine and global table may suggest a response, but the final local proof checks the original move and hand definitions. It does not assume that the global P/N table, its canonical index, or its proposed root label is correct.

### 3.2. Three additional twelve-tile roots

The earlier root was

```text
0000000020000011110001110300000000
```

or `99m 6789p 456888s`. The 34 digits give the counts of ranks 1–9 in the three numerical suits, followed by East, South, West, North, White, Green, and Red. Three further actual twelve-tile branches subsequently received complete response certificates (Table 2).

**Table 2. Explicit twelve-tile root certificates. Module and timing counts describe each retained audit, not disjoint proof libraries.**

| Root identifier | Full count vector | P rows | Legal first-action responses | Independent SAFE leaves | Dependency modules |
|---|---|---:|---:|---:|---:|
| Earlier twelve-tile root | `0000000020000011110001110300000000` | 757 | 25,510 | 86 | 326 |
| Solo branch 34 | `0000000030000001110001110300000000` | 2 | 66 | 1 | 31 |
| Solo branch 44 | `0000000020000001110001121200000000` | 1,061 | 36,074 | 103 | 383 |
| Solo branch 35 | `0000000030001110201000001110000000` | 1,491 | 50,170 | 162 | 562 |

The three additions contribute 2,554 distinct P facts to the previous 757-row registry, producing a 3,311-fact seed bank. They supply 86,310 additional first-action response obligations. The final recorded audits took approximately 23.219, 112.109, and 122.375 seconds respectively. Their sampled aggregate memory peaks were approximately 2.285, 12.294, and 11.702 GB. These are measured executions with dependency reuse and distinct preceding compilation work; they are not promises of the time required for a cold reconstruction on another computer (S02).

The small two-row certificate is informative. Certificate size depends on available previously proved facts and response selection, not simply on how early the physical position occurs. A root with few new rows can still rely on a substantial existing dependency chain. Accordingly, row count, newly compiled module count, full dependency count, and elapsed audit time should be reported separately.

### 3.3. The retained 24,655-fact bank

A later certificate daemon expanded the seed bank. A read-only audit of the preserved registry finds 24,655 distinct certified P states: 3,311 seed facts plus 21,344 additions supported by 283 successful batch receipts. Relative to the earlier 757-row registry, the cumulative increase is 23,898. A session report of 15,977 additions describes only the last resumed process session and is not the total increase (S03).

**Table 3. Distinct certified P states by tile count in the preserved registry.**

| Tiles | 12 | 14 | 16 | 18 | 20 | 22 | 24 | 26 | 28 | 30 | 32 | Total |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| P facts | 4 | 43 | 277 | 693 | 860 | 1,401 | 3,621 | 6,028 | 5,831 | 4,458 | 1,439 | 24,655 |

The preserved database also has one unfinished batch labelled `KERNEL_RUNNING`. It lacks a completed acceptance receipt and contributes nothing to this count. The latest successful batch precedes the recorded pause. This distinction matters when reading operational metadata left by an interrupted process.

The four twelve-tile roots remain the smallest certified P states in this bank. A ten-tile candidate had coverage for six of its 34 legal first-tile cases at an intermediate checkpoint, but its response graph was incomplete. Neither it nor the empty table is thereby certified. The 24,655 facts offer reusable local premises for later work; they do not prove that an opponent can be forced into one of these regions from the initial position.

## 4. Compiled checking of historical P/N layers

### 4.1. A second route and its completed coverage

Explicit response certificates require the construction and checking of many individual proof objects. The complementary route uses a compiled Lean checker to evaluate the recurrence against finite table data, while proving the checking principles separately. Its general nonterminal adapter keeps target correctness as an explicit premise. A successful general row check states a relation to the child labels it read; unconditional strategy soundness requires those child labels to have a valid basis.

The complete terminal and near-terminal layers supply a controlled instance. All 587,901 positions of layer 34 were checked, followed by all 21,924,455 positions of layer 33. Together these are **22,512,356 distinct historical positions**. The specialised terminal checker directly verifies the absence of SAFE children. The near-terminal checker accepts a P row only after the same terminal check, and an N row only with an actual SAFE successor that is itself checked to have no SAFE children. Thus this stage does not merely trust a loaded child P bit. The retained acceptance record describes the completed coverage as `PARTIAL_LAYERS_34_33_COMPLETE` (S04).

These counts are distinct from the explicit P-fact bank. They include historical P/N labels and use the compiled finite-evaluation boundary described in Section 2. The two totals should not be added into a single number of kernel-certified strategies. The formal top-level opening status remains `NOT_VERIFIED`.

There is also a general whole-table implication, `Mahjong.WholeTable.checked_empty_wins`. It concludes a second-player win from complete table acceptance and an exactly checked empty P root. Its row checker validates the actual SAFE successor references and their restored physical states, using a decreasing stock measure to prevent cyclic justification. It therefore does not simply assume a correct C++ rank/unrank implementation. The cached variant additionally requires correct local caches. Both are proved checking theorems; neither has received the full concrete historical input acceptance needed to instantiate the opening conclusion.

### 4.2. Why the project turned towards finite structural verification

The entire historical domain contains 778,532,864,302 positions. Checking that many positions within 30 days would require an average of approximately 300,360 rows per second before additional overhead. Bounded measurements on the recorded Intel Core i7-10700KF system, with eight cores, sixteen hardware threads, and 32 GiB of RAM, fell far below that target (S05).

The feasibility study ran 47 bounded configurations. It performed 745,472 row evaluations on 356,352 distinct sampled addresses; repeated configurations account for the difference. A favourable layer-32 configuration gave about 25,921.5 rows per second, and a selected layer-23 configuration about 2,567.3 rows per second. These are reciprocals of size-weighted mean scan times per row within the selected buckets, excluding repeated startup and loading; they are not measured whole-layer throughput. The selected layer-23 bucket rates were roughly 2,209–3,414 rows per second. Layer 23 is near the peak of the global state distribution, so its substantially lower rate is material.

Selection by bucket capacity must not be confused with checking the whole selected capacity. Eight selected layer-32 buckets contain 96.12% of that layer's slots, but the benchmark checked only windows within them. Three selected layer-23 buckets contain 35.66% of that layer's slots, again with only short windows checked. These percentages describe the strata chosen for timing, not the proportion of positions verified.

The layer-32 sample used the completed layer-33 data as its target. The layer-23 sample read historical layer-24 labels that had not themselves received complete Lean validation. Consequently, the latter measured row-equation agreement and execution cost; it did not independently certify a layer-23 strategy. Deliberate label corruption, a missing target bucket, and a missing symmetry path were rejected in negative controls.

Dividing the total domain by selected sample rates gives arithmetic extrapolations of hundreds of days or several years. These are not forecasts, lower bounds, or confidence intervals: work per row varies by layer, bucket, successor structure, and execution configuration. The justified decision was narrower. The tested setup did not pass the stated 30-day feasibility gate, so a full campaign was not launched. The subsequent work concentrated on finite representation checks and general model proofs. The latest algorithm-verification stage added **zero** historical P/N positions to the completed two-layer count.

## 5. From physical tables to complete finite enumeration

### 5.1. Local decision procedures and base-five coverage

The global representation separates each numerical suit and the honours into local base-five codes. The full raw local domain consists of $`5^9`$ numerical codes and $`5^7`$ honour codes, or 2,031,250 distinct patterns. Checking the numerical domain in each of its three suit roles and the honour domain once gives 5,937,500 row evaluations. Reporting both numbers avoids treating repeated suit roles as new raw inputs.

The formal development proves coverage and injectivity for valid base-five states and connects optimised local information to the mathematical hand predicates. The pruning and full-SAFE checks each cover the stated local domain in 46 chunks. Their retained native-check stage times are approximately 4.797 and 7.516 seconds respectively, excluding proof development, compilation, export, and preceding validation. Neither timing describes reconstruction of every global state (S06).

Pruning is justified only for the property proved. Local capacities and pair-kind summaries can decide the relevant Win/SAFE predicates once their sufficiency has been established. They do not identify states with the same future game tree. The numerical code and member identifier remain part of the state representation. In particular, numerical fourth-copy moves remain genuine transitions; the independent-pass argument for an honour upgrade cannot be transferred to a numerical upgrade.

`Mahjong.Base5Coverage.checked_filter_on_every_valid_state` is one bridge from a finite code-domain check to a statement about every valid original state. Its role is to make the quantifier over physical states explicit, rather than assuming that a traversal of machine codes happens to enumerate the intended domain.

### 5.2. Canonical representatives and grouped inventories

The canonical inventory retains 131,676 numerical representatives, organised into 1,104 groups, and 184 honour representatives. A group collects statistics used for compatibility and indexing; its individual members remain distinguishable. The three numerical suits are then sorted to remove suit permutations.

Finite inventory checks verify membership, identifiers, and the action of symmetry generators. The recorded stage evaluates 5,937,500 local rows, 395,212 member rows across the suit roles and honours, and 9,687,500 generator checks. General theorems establish that every valid SAFE state has a retained representative; the later global development establishes uniqueness at the global orbit level (S06–S08).

The central distinction is between *equal statistics* and *the same canonical member*. Repeated-group blocks admit equal local members in different suits, but those repeated choices have to be counted as a multiset. Replacing them by independent choices having the same statistics would alter the index. This is why the later development includes both group-level and member-level binding conditions.

The SAFE upper bound is also connected to the executable representation. Checked local envelopes are joined across the four blocks, and the final envelope excludes SAFE states above 34 tiles. The general envelope and transfer theorems are kernel proofs; the particular finite envelope checks are compiled evaluations. This is a new formal route to the bound's use in enumeration, rather than a claim that the earlier handwritten extremal proof has been transcribed verbatim into Lean.

### 5.3. Directory completeness and orbit uniqueness

The directory identifies a global slot by a tile layer, a canonical honour identifier, and an offset in a compatible numerical block. The retained directory contains 60,789,499 metadata rows in 3,686 nonempty buckets. It describes the 778,532,864,302 global slots compactly.

For three different numerical groups, a block uses mixed-radix indexing. For repeated groups it uses combinations with repetition. For example, with local member indices $`0\leq u\leq v\leq w`$, the familiar colex expressions are

```math
r_2(u,v)=u+\binom{v+1}{2},\qquad
r_3(u,v,w)=u+\binom{v+1}{2}+\binom{w+2}{3}.
\qquad\text{(5)}
```

Prefix sums place these blocks in a dense range. Formal range, injectivity, coverage, and decoding results establish more than agreement of total counts. In the actual directory checks, 588,782,520 membership conditions and all 60,789,499 metadata rows are inspected. Later global enumeration checks bind the directory's semantics and its 6,440 verification slices to the same data objects (S07–S08).

The principal theorem, `Mahjong.GlobalEnumeration.enumeration_correct`, has a `Certificate` parameter containing local table sizes, SAFE checks, canonical inventory checks, shared-member conditions, group links, the SAFE-bound envelopes, and directory checks. Under these explicit premises it proves all three parts of a bijection:

1. Every valid directory address decodes to a valid SAFE state.
2. Every valid SAFE state is in the orbit of some decoded address.
3. Two valid addresses decode to states in the same orbit if and only if the addresses are equal.

There is no assumption about the historical P/N labels or the winner in this theorem. Equally, the theorem's existence is not itself a closed kernel instance for the multi-gigabyte finite inputs. The actual data premises have the completed native-check receipts described above. Taken together, the formal implication and the identified finite checks provide a computer-assisted justification of the concrete enumeration.

The number 778,532,864,302 denotes slots represented by this structure. Verifying its compact description is not the same operation as evaluating the game outcome at every slot. This distinction explains how enumeration verification can be practical while a fresh Lean-based P/N scan remains expensive.

### 5.4. Cursor traversal, machine words, and initial decoding

A bijective mathematical rank is insufficient if the implementation starts a chunk at the wrong state or advances its cursor incorrectly. The later modules therefore prove that the model cursor agrees with unranking, visits every valid position in its specified range, and stops at the total. They also connect bounded `UInt32` and `UInt64` operations to the natural-number specification under explicit range and no-overflow conditions (S08–S09).

The inverse-rank development covers the four block forms: three distinct groups, either placement of a repeated pair of groups, and three equal groups. It proves the relevant division, remainder, subtraction, narrowing, and search steps. The binary-search model includes interval and fuel conditions. The square-root-based estimate is corrected by integer adjustment loops, with a bounded helper domain of 5,791,906 inputs and an initial estimate bounded by 3,403. Exhaustive helper checks cover that domain; later stages reuse those accepted checks rather than counting them as new runs.

This result deliberately stops short of proving the semantics of the host floating-point expression used to obtain the initial estimate. The adjustment theorem and checked bounds explain why an admissible estimate suffices. Source correspondence and finite tests bind that reasoning to the particular C++ helper. Likewise, a theorem about a model of `upper_bound` does not automatically verify every standard-library iterator or pointer operation.

`Mahjong.WordInitialization.initialize_correct` supplies the previously assumed starting-state condition for a scan. The subsequent `Mahjong.WordDecodedGlobal.every_original_safe_is_visited` combines initial decoding with traversal and global coverage. Its conclusion remains conditional on the representation certificates and arithmetic contracts. Removing an explicit initialisation assumption is real progress; it does not remove the separate compiler and I/O boundary of the native execution.

## 6. Exact successors and verified retrograde models

### 6.1. Checking the actual successor cache

The next connection concerns transitions rather than states. A representation can enumerate every SAFE orbit correctly while still omit a legal successor or invent an impossible one. The successor stage therefore exports and checks the actual local `next` arrays constructed by the frozen C++ index. The exporter includes `global_index.hpp` and constructs the production `retro::Index`; it does not substitute a second implementation of the cache under examination (S10).

The complete finite data comprise 131,676 numerical records with 743,423 edges and 184 honour records with 446 edges: **131,860 records and 743,869 edges** in total. The checker examines 1,186,372 candidate addition positions. It verifies valid source and target identities, bounds, increasing target identifiers, list order, and both directions of membership against legal one-tile additions followed by canonicalisation and retention. Missing, spurious, repeated, unordered, and out-of-range edges are rejected. Shared numerical files serve the three suits through a proved sharing lemma.

Ten accepted chunks cover the data. A resumed check reused one completed chunk and produced nine further chunks; its coverage is accounted for by intervals rather than by counting each process invocation anew. Sixteen deliberately invalid inputs were rejected and two valid controls accepted. The recorded native checking time across pilot and resumed execution is approximately 2.890 seconds, with export and compilation separately timed. None of these local edge checks adds a historical global P/N row.

The formal result has a useful two-sided form. `Mahjong.GlobalSuccessorBridge.edge_sound` maps a cached edge to a legal original SAFE move, up to the permitted symmetry. `edge_complete` ensures that every original SAFE move has a cached representative. Together they yield `Mahjong.CachedTransitionQuotient.transition_quotient`, and then `strategy_iff` transfers normal-play strategies in both directions for every valid SAFE representative.

This is stronger than showing that two positions share a current winning-hand profile. It addresses the future transition graph. The remaining premises are visible: the enumeration certificate, the complete successor checks, and the representation bindings. The subsequent theorem `original_result_of_certificate` would transfer an accepted quotient P/N certificate with an empty P root to a second-player win in the original game. It does not supply that missing full certificate.

### 6.2. Optimisations and the hypotheses they need

The latest stage adds ten core modules containing 79 theorem declarations selected for explicit axiom audit. Their complete dependency closure contains 84 modules. The principal optimisation results are listed in Table 4 (S11).

**Table 4. Kernel-proved model properties in the latest algorithm stage.**

| Implementation idea | Formal guarantee | Essential condition |
|---|---|---|
| Skip equivalent numerical suits | Optimised and full successor lists have the same orbit members | Equality is applied to canonical suit identities, preserving the actual move classes |
| Restore sorted IDs with two swaps | The fast result equals the full three-comparison sort | The source is ordered and the replaced successor ID satisfies the proved increase condition |
| Precompute `MovePlans` offsets | Group-leader preparation gives the actual destination group and offset, including ties | Valid group membership, block forms, and index relationships |
| Reuse the plan cache | Every offset used by this iteration is freshly prepared | Coverage of all groups that the current moves can use |
| Skip a child bucket with zero P bits | No omitted candidate is P | Correct bucket P count and in-range candidate addresses |
| Use an all-P bucket or whole-parent shortcut | Constant evaluation agrees with the complete candidate scan | Correct counts, candidate coverage, and relevant nonemptiness conditions |
| Stop after finding a P child | Early exit gives the same parent label as a full scan | Exact successor membership and the same child-label function |
| Assign aligned chunks to workers | Distinct chunks do not own the same 64-bit output word | Alignment and disjoint ranges; this is a model of ownership |
| Mask the final output word | All 64 tail cases and single-bit positions satisfy the intended mask identities | The stated word representation |

`MoveNormalization.optimized_mem_iff` proves a membership equivalence, so duplicates do not affect the existential search for a P child. The equivalence survives subsequent orbit-dependent SAFE filtering and arbitrary child labels. This is important because it avoids proving the optimisation only for one conveniently chosen outcome table.

The two-swap result is deliberately conditional. In an arbitrary triple, a replacement can require a movement that the shortened sort does not perform. The checked successor-ID order establishes the particular condition under which two swaps suffice. A retained kernel counterexample demonstrates why dropping that condition is invalid. Similar controls show that omitting a real successor or trusting a false zero-P summary can change the outcome.

Plan-cache reuse has a different obligation. It is unnecessary to clear every stale cache cell if every cell that will actually be read has already been written for the current source. `PlanCacheCoverage.every_used_offset_fresh` proves precisely that coverage property in the model. It does not presume that all cache memory is fresh, and it does not by itself formalise the production program's pointer semantics.

### 6.3. Bottom-up evaluation from an initially uncomputed table

A recurrence certificate says that supplied labels satisfy a relation. The new algorithm theorem goes further: it proves correctness of a finite evaluator that starts with no labels. Its table type is

```math
\mathrm{Table}(\alpha)=\alpha\to\mathrm{Option}\;\mathrm{Bool},
\qquad\text{(6)}
```

where `none` means uncomputed. A row can be evaluated only after every listed successor has a value. Missing child data cause rejection, preventing an uncomputed entry from silently acting as N.

**Theorem 1 (finite bottom-up evaluation; general kernel theorem).** Suppose a finite list covers the state type, its successor lists are exact, every edge decreases a natural-number rank, and the processing list is ordered so that dependencies occur earlier. Then the model evaluator, started from the everywhere-uncomputed table, succeeds and assigns every state a P/N label carrying a normal-play strategy proof.

The corresponding declaration is `Mahjong.LayeredRetrograde.bottom_up_correct`. Its exact interface is reproduced in Appendix A. A finite covering list is a hypothesis: the theorem does not assert that every arbitrary type is finite. It does not require a historical table or assume that an external table already satisfies the recurrence.

*Proof outline.* Initially the table is truthful vacuously, because it contains no assigned labels. Exact successors and readiness provide strategy proofs for every child of an evaluated row. The P/N recurrence then provides the parent strategy, and storing it preserves truthfulness. The rank order ensures that every required child has been computed when its parent is reached. Induction over the finite processing list proves successful execution and coverage. These steps are formalised as readiness, step-soundness, run-soundness, dependency-order, and run-completeness lemmas. ∎

For Mahjong, the rank $`34-\vert x\vert `$ decreases along every SAFE edge, given the certified SAFE bound. Descending tile count consequently gives the required processing order. Layer 34 has no SAFE successors and supplies the P base. The theorem proves the correctness of this computation when instantiated and executed; its existential conclusion does not select the empty table's bit without that additional work.

The row bridge `Mahjong.OptimizedRowBridge.optimized_cached_step` connects the optimised bucket evaluator to the original SAFE graph. Its hypotheses include correct bucket summaries, exact candidate-piece layout, in-range addresses, checked local successors, and already justified child strategies. These are concrete obligations to discharge. They are not hidden assumptions that the historical parent output is already correct.

### 6.4. The remaining implementation connection

The model proofs support the mathematical design of the algorithm and its optimisations. The source map identifies corresponding frozen C++ expressions and routines, and the finite tests below exercise those routines directly. A universal proof that the entire C++ execution refines the Lean model has not been supplied. Pointer operations, vectors, iterators, allocation, all casts and memory accesses, compiler behaviour, and file-system effects are not jointly covered by a single operational-semantics theorem.

This distinction is standard in program verification: a semantics-preservation theorem concerns the relationship between specified executions, as illustrated by verified compilation work ([Leroy, 2009](https://xavierleroy.org/bibrefs/Leroy-Compcert-CACM.html)). A hash-bound source map identifies which implementation was inspected; it does not establish such a theorem by itself. The current project combines model proofs, finite input checks, source correspondence, and tests, and states that combined assurance level explicitly.

## 7. Bounded tests of the production implementation

### 7.1. What was executed

The latest harness directly includes the unchanged frozen `global_retro.cpp` and calls its actual `MovePlans`, `solve_bucket`, `Work`, `Tables`, and `valid_complete` routines. It generates synthetic child-label files in an isolated test directory. The purpose is to test whether the optimised implementation produces the same parent bits as a simple reference recurrence under controlled inputs, including unusual bucket summaries and partially completed files (S11).

The test set contains one complete small bucket from each of layers 5, 8, 12, 16, 20, 24, 28, 31, 32, 33, and 34. These eleven buckets contain 1,418,264 distinct source addresses. Ten buckets use five artificial child-label patterns: all zero, all one, mixed, P children only in numerical buckets, and P children only in honour buckets. The terminal bucket uses one pattern. Each of the 51 bucket-pattern cases runs with one and eight threads, giving 102 runs. The configurations also exercise 64- and 256-row chunking.

**Table 5. Latest production-routine test results. These are repeated synthetic workloads, not new historical strategy certificates.**

| Measure | Recorded result |
|---|---:|
| Distinct source addresses in the selected buckets | 1,418,264 |
| Bucket-pattern reference cases | 51 |
| Production executions | 102 |
| Reference row evaluations | 6,870,608 |
| Production row outputs compared | 13,741,216 |
| Reference edge visits | 185,054,540 |
| Repeated-suit cases exercised | 235,845 |
| Cases requiring an actual ID swap | 49,434,165 |
| Group-block endpoints compared | 3,496 |
| Target offsets compared with ordinary index queries | 82,390 |
| Output disagreements | 0 |
| Negative rejection assertions / valid controls | 21 / 4 |

All 102 completed files were subsequently checked for tail bits, P counts, checksums, checkpoint layout, and progress metadata. Each of the 51 one-thread/eight-thread pairs produced byte-identical P/N payload files; checkpoint layouts and metadata can differ between configurations. The core C++ test took approximately 10.07 seconds, with separate compilation, initialisation, and evidence-audit costs. The sampled process-tree private-memory peak was approximately 1.273 GB. A Windows Job constrained the work to 15.5 GB and 80% CPU, with no more than eight solver threads.

### 7.2. Checkpoints, recovery, and negative controls

The negative controls cover incomplete finalisation, bad headers or versions, layout or fingerprint mismatches, incorrect completion markers, invalid digests or P counts, extra bytes, truncation, and data corruption. A rejection demonstrates the tested check; it is not a proof of every possible malformed-input case.

One recovery control deliberately commits only a middle block of 64 rows, leaving a non-prefix completion pattern. Recovery preserves those 64 rows and recomputes the remaining 6,882, yielding the same final file as a fresh solve. Other controls cover dirty uncommitted output, valid dependency loading, and a payload-renaming window. The renaming case constructs the corresponding file state; it does not simulate all hardware failures or all operating-system crash behaviours.

Eight kernel controls separately examine correct and incorrect processing orders, missing dependencies, duplicate processing, omitted moves, false zero-P summaries, and the necessity of the sorting condition. Their role differs from the C++ tests: they show that the formal model expresses the intended acceptance or rejection behaviour in the selected examples.

### 7.3. Relationship to the historical global result

The new production tests did not read the historical P/N payload as their outcome input. They test the algorithm under artificial labels and therefore add zero historical positions to the 22,512,356-position compiled Lean scan. The 13,741,216 output comparisons must not be advertised as that many newly proved game positions.

The latest acceptance also rechecks seventeen principal retained receipts and their bound frozen files from the historical computation. It does not re-read the full approximately 97.32 GB outcome payload. The earlier full reverse replay remains relevant evidence: it examined every historical outcome using a different recurrence direction and matched 16,240 historical oracle cases. Its shared rules and index continue to limit implementation independence. A receipt rehash in this supplement is an integrity check on that record, not a new execution of the historical replay.

## 8. Reproducibility and availability

### 8.1. Verification must identify its target

“Reproduce the Lean verification” can mean several different tasks. Table 6 states the inputs and the expected result of each. A successful source build does not imply that data-dependent native checks have been rerun. A checksum match identifies bytes; it does not prove their mathematical content.

**Table 6. Reproduction tasks and their acceptance boundaries.**

| Task | Necessary inputs | Expected result | What it does not establish |
|---|---|---|---|
| Replay general model proofs | Exact source dependency closure, pinned Lean toolchain, replay driver | All modules build from fresh project objects; theorem axiom output matches the audit | Concrete acceptance of every large finite input |
| Replay a concrete root | Root module, all generated response and SAFE modules, all external proof dependencies | The exact original-rule root theorem is accepted | Reachability or forced entry from an earlier unproved root |
| Re-run finite representation checks | Checkers, complete local/directory/cache/helper inputs, commands, manifests | All specified intervals accept and input hashes agree | Historical P/N labels outside the completed scan |
| Re-run production controls | Frozen C++ code, harnesses, artificial inputs or generators, build environment | Reference agreement, expected rejections, paired output agreement | Universal C++ refinement or historical table certification |
| Audit retained receipts | Receipts and every file they bind | Identity and consistency checks pass | Fresh mathematical evaluation of those files |
| Validate all historical labels | Complete table and dependencies, scalable adapter, complete aggregation | All required rows and the exact empty P root accepted | This task has not been completed in Lean |

### 8.2. The version accompanying this article

The reproducibility reference for this supplement is the signed `v1.0.0` release. The English manuscript, selected research evidence and accompanying model-source archive are frozen together in that release. The associated release manifest records the version identifier, commit, distributed files, and their hashes, allowing readers to obtain the matching paper, source, and evidence. These release identifiers belong to that manifest rather than being inferred from the state of a moving repository branch during manuscript preparation.

The earlier `v0.3.0` release remains a historical reference for the preceding paper ([feierbuqiu, 2026a](https://github.com/feierbuqiu/mahjong-achievement-game/releases/tag/v0.3.0)). It contains 1,008 source modules for eight selected nonempty root proofs, including the original twelve-tile root, and a separate 56-module checker archive. Those counts describe that earlier package. The present supplement reports the later 24,655-fact bank and the expanded formal development; reproducing these additions requires their corresponding artefacts in the version accompanying this article.

The release manifest distinguishes included sources and evidence from any separately supplied datasets or reconstruction instructions. A Git bundle or clone retains commit metadata; an extracted source ZIP supports source inspection and compilation without supplying Git history. Appendix C separates reproduction of the accompanying model bundle from optional checks of the historical baseline. Subsequent releases may add results while retaining the identities of the experiments reported here.

### 8.3. Fresh replay performed for this supplement

For this manuscript, the dependency closure of `Mahjong.OptimizedRetroCertification` was copied into a new isolated directory and rebuilt with Lean **4.33.1**. All 84 project modules passed. The 79 core theorem axiom reports matched the previous acceptance records individually. The replay reused no project `.olean` files, executed no native data workers, and read no historical P/N payloads (S12).

The successful replay took **94.172 seconds**, using at most two Lean processes and one Lean thread per process. Its sampled process-tree private-memory peak was **2,313,740,288 bytes**, approximately 2.314 GB. The 15.5 GB Windows Job memory limit and 80% CPU cap were installed, and each compiler used `--trust=0 -M3072 -j1`. The bundled standard Lean toolchain remains part of the trusted environment; “fresh” here refers to the project's proof objects.

An earlier replay attempt stopped after 39 modules because the newly written orchestration driver incorrectly diagnosed a scheduling gap. There was no Lean proof failure in that attempt. The driver was corrected and a separate cold run completed all 84 modules. Both receipts are retained, so the successful 94.172-second run is not presented as an uninterrupted continuation of the failed orchestration attempt.

The replay's 84 source files occupy 487,370 bytes. The companion source bundle allows a reader to reconstruct these general model proofs without the large research data tree. Its manifest, replay instructions, source files, and retained successful receipt identify exactly what was checked. The tested controller requires Windows, Python 3.11 or later with `psutil`, and Lean 4.33.1; it has not been validated on Linux or macOS.

A separate recipient-path test extracted the ZIP into another directory and ran the packaged driver with no source-path override. It also passed all 84 modules and all 79 core axiom checks, taking **93.922 seconds** with at most two Lean processes and a sampled private-memory peak of **2,305,208,320 bytes**. The final bundle adds this receipt and updated documentation; its proof sources and replay-driver bytes are unchanged from those tested. This second run verifies the delivered reconstruction path on the same host, rather than constituting independent verification on another machine. Its [receipt and package validation](reproduction/recipient_delivery_validation.json) are retained separately from the first source audit.

This new replay concerns the algorithm closure. It does not freshly rebuild every one of the 24,655 explicit P facts or every native-checking worker. The larger proof bank's counts and successful batch relationships were audited from retained records. A reader who wishes to replay that entire bank needs its complete generated source and external dependency closure; the earlier public package alone is insufficient.

### 8.4. Data-dependent checks and retained-evidence audits

The final algorithm acceptance binds 5,329 local files across source, finite-check results, operational tests, and earlier receipts. Its SHA-256 digest is recorded in Appendix B. A local read-only entry point is

```powershell
python -B build/lean_table_checker/accept_optimized_retro.py --check-only
```

This command is intended for the complete research workspace with the required files present. It checks retained identities and acceptance relationships; it does not start a full solver or replace a native data replay. The small proof-source companion is insufficient for this command.

To reproduce the finite input checks, a recipient needs the exact rule tables, canonical inventories, directory slices, arithmetic-helper outputs, successor-cache exports, checker sources, executable build commands, and chunk manifests. A defensible replay verifies input sizes and hashes, checks every declared interval, verifies that the accepted intervals cover the intended domain, and tests the recorded invalid controls. Resuming a job may reuse only completed chunks whose inputs and checker identity match. Retained failures and unfinished chunks cannot serve as acceptance premises.

The model-only source bundle contains the selected proof closure. Replaying the native input checks or the complete later strategy bank additionally requires the larger artefacts identified in Appendix B. Those larger inputs and complete later proof trees remain retained outside this public release, as marked in the accompanying evidence catalogue; a complete public reconstruction workflow for those tasks is not claimed. The distinction concerns the inputs needed for each task: a source-only replay cannot substitute for a data-dependent check, regardless of whether those materials are supplied in one archive or several.

## 9. Current conclusions and further work

### 9.1. What is established now

The present verification record supports three distinct conclusions.

First, specific nonempty strategies have concrete kernel proofs in the original game. The retained bank contains 24,655 distinct P facts, with four twelve-tile roots as its earliest completed examples. These are reusable facts with explicit proof dependencies, not inferred labels from an unfinished search.

Second, the mathematical machinery for a complete finite solution has substantial formal support. Theorems connect valid physical states to canonical inventories and a complete, unique directory; connect rank, decoding, and scanning; establish a transition-preserving quotient; and prove the correctness of finite bottom-up evaluation and major optimisations. The large concrete representation inputs are supported by complete, identified compiled checks. The latest general model closure has also been replayed from fresh source for this supplement.

Third, the frozen production implementation has several complementary forms of evidence: source correspondence, finite input checks, the earlier exhaustive forward computation and reverse replay, and new bounded concurrency and recovery tests. The conclusion that the empty table is P remains a computational second-player win under that evidence chain. The latest work considerably strengthens and explains the chain without changing its final Lean status.

### 9.2. What has not been completed

No closed Lean theorem has yet certified the historical empty-table outcome. The whole-table checker has not accepted the entire historical output, and the general layer adapter has not been aggregated into a complete opening proof. The large finite representation checks have not been assembled as a literal, fully instantiated kernel certificate for all their concrete bytes. The complete optimised C++ solver has not been universally refined to the formal model. The latest explicit bank has not produced a ten-tile P root.

These are different remaining tasks. A universal algorithm theorem establishes what a correctly instantiated computation will produce. A completed execution establishes particular output values under its execution assumptions. A concrete strategy certificate proves a particular position without certifying every other state. Progress in one category should be reported in that category.

The completed finite programme comprises model proofs, checked inputs, source correspondence, and bounded implementation tests within the scope described here. Further certification, implementation refinement, and computational work remain open research directions. Freezing the version accompanying this article preserves a reproducible record of these results; it does not close the project or preclude additional contributions. The priorities below describe possible extensions without presuming their outcome or completion date.

### 9.3. Recommended priorities

**Maintain versioned research artefacts.** The publication snapshot should join the theorem sources, manifests, native-check inputs or deterministic generators, and exact replay commands. Later additions should retain the provenance of the earlier results. A reader should be able to choose source-only kernel replay, concrete-root replay, finite input replay, or implementation tests and identify the corresponding inputs and costs. A documented clean reconstruction using the distributed artefacts and declared dependencies provides a concrete acceptance criterion for each scope.

**Review the formal interfaces independently.** Particular attention should go to `GlobalEnumeration.Certificate`, the successor quotient, word bounds and initialisation contracts, and the candidate-layout premise of `optimized_cached_step`. A useful review checks whether these statements express the original game and the intended concrete representation, in addition to recompiling them. An independently implemented proof checker or a second proof assistant could further diversify the proof-checking path, but neither has been used to validate this supplement.

**Strengthen selected concrete data bindings.** Compact kernel certificates for local checks or individual directory chunks could replace some native-execution assumptions without attempting a monolithic proof object for the whole historical table. The work should state which premise is being discharged, measure proof construction and checking cost, and preserve exact byte and interval coverage. It should not claim completion merely because another generic soundness theorem has been added.

**Refine a bounded implementation component.** A complete refinement theorem for one decoder, plan-cache operation, or row evaluator would close a specific source-correspondence gap. Its acceptance criterion should include the actual representation and memory obligations of that component. Such a project is different from testing additional sample buckets or promising a whole-program C++ proof.

**Extend explicit strategy certification towards earlier positions.** The existing P bank can reduce duplication if a future ten-tile or earlier certificate reaches already proved states. A complete root must nevertheless cover every legal opponent action and supply every dependency. The six-case ten-tile checkpoint offers reusable progress but no basis for projecting how close a full opening strategy is.

**Evaluate options for a full historical scan.** Faster hardware, a different checker representation, compressed certificates, or better proof reuse could alter feasibility. Any renewed campaign should benchmark representative peak-layer workloads and the full cost of data movement, then specify resource limits and a complete aggregation theorem. The current sample rates do not justify an optimistic deadline or imply that the remaining fraction of the proof is proportional to the unscanned row count.

## 10. Conclusion

The Lean development has advanced from a collection of local strategy certificates to a much broader verification of the finite solution architecture. Its concrete P-fact bank has grown to 24,655 states, compiled Lean has checked the complete terminal and near-terminal layers, and the representation, enumeration, successor quotient, index operations, retrograde model, and important optimisations now have explicit formal interfaces and substantial kernel proofs. The latest 84-module algorithm closure passed a fresh source replay during preparation of this supplement.

The remaining distinction is precise. The original game has a completed computational second-player result and many concrete Lean-certified nonempty strategies. Its historical empty-table result has not yet become an end-to-end Lean theorem, and the complete C++ implementation has not received a universal refinement proof. The present supplement records the completed finite verification work, the evidence needed to reproduce it, and the separate obligations that any stronger future claim must discharge.

## Acknowledgements and research integrity

The author thanks the Bilibili creator **零之审判者** for the initial problem idea in the post *呆饼问题* ([零之审判者, 2026](https://www.bilibili.com/opus/1246853448736964611)). This acknowledgement concerns the starting question. The investigation and the present formalisation did not use any other participant's or competitor's conclusions, proof artefacts, or computational results. The author and the AI-assisted research process developed the project-specific results independently. Established ideas in theorem proving and program verification are attributed to their sources; no claim of priority is made for those general methods.

The Bilibili attribution and bibliographic title and year follow the author's supplied record. No inaccessible text from the post is quoted or used as mathematical evidence. The recorded computational and formal results are supported by the project artefacts identified below.

## AI contribution declaration

**OpenAI's GPT-6 Astra model provided extensive and indispensable assistance** to this work. Its contribution included mathematical exploration, formulation and revision of proof approaches, Lean and C++ development, verification tooling, analysis of failed attempts, experiment design, evidence auditing, reproducibility work, and preparation and editing of this manuscript. The contribution was substantial and is expressly acknowledged; it is not limited to language polishing.

The author, **feierbuqiu**, retains authorship and responsibility for the final claims, citations, and release decisions. AI-generated arguments and code are not treated as evidence merely because they were generated or reviewed by an AI system. Formal claims are tied to their actual theorem statements and accepted checks; empirical claims are tied to completed runs and recorded inputs. The AI-assisted audits used in preparing this supplement do not constitute independent human peer review. No model-generated citation is included without an identified bibliographic source or the explicitly attributed author-supplied origin record above.

## References

Boutin, S. (1997). Using reflection to build efficient and certified decision procedures. In M. Abadi & T. Ito (Eds.), *Theoretical aspects of computer software* (Lecture Notes in Computer Science, Vol. 1281, pp. 515–529). Springer. [https://doi.org/10.1007/BFb0014565](https://doi.org/10.1007/BFb0014565)

de Moura, L., & Ullrich, S. (2021). The Lean 4 theorem prover and programming language. In A. Platzer & G. Sutcliffe (Eds.), *Automated deduction—CADE 28* (Lecture Notes in Computer Science, Vol. 12699, pp. 625–635). Springer. [https://doi.org/10.1007/978-3-030-79876-5_37](https://doi.org/10.1007/978-3-030-79876-5_37)

feierbuqiu. (2026a). *Mahjong achievement game* (Version 0.3.0) [Computer software and research artefacts]. GitHub. [https://github.com/feierbuqiu/mahjong-achievement-game/releases/tag/v0.3.0](https://github.com/feierbuqiu/mahjong-achievement-game/releases/tag/v0.3.0)

feierbuqiu. (2026b). *Mahjong achievement on a shared table: A computational second-player win and partial Lean certification* [Research report]. GitHub. [https://github.com/feierbuqiu/mahjong-achievement-game/blob/v0.3.0/papers/manuscript.md](https://github.com/feierbuqiu/mahjong-achievement-game/blob/v0.3.0/papers/manuscript.md)

Leroy, X. (2009). Formal verification of a realistic compiler. *Communications of the ACM, 52*(7), 107–115. [https://doi.org/10.1145/1538788.1538814](https://doi.org/10.1145/1538788.1538814)

Validating a Lean proof. (n.d.). In *The Lean language reference*. Retrieved September 15, 2026, from [https://lean-lang.org/doc/reference/latest/ValidatingProofs/](https://lean-lang.org/doc/reference/latest/ValidatingProofs/)

零之审判者. (2026). *呆饼问题* [Bilibili post]. Bilibili. [https://www.bilibili.com/opus/1246853448736964611](https://www.bilibili.com/opus/1246853448736964611)

## Appendix A. Selected theorem interfaces and source catalogue

### A.1. Whole-table acceptance is an explicit hypothesis

The following declaration is reproduced from `Mahjong.WholeTable`, with its surrounding namespace understood:

```lean
theorem checked_empty_wins (table : Candidate) (i : Nat)
    (checked : check table = true) (root : checkRoot table i = true) :
    SecondPlayerWins Step Win empty
```

This is a proved implication. It must not be quoted after deleting `checked` and `root`. `checkRoot` checks the exact empty state and P label; `check` checks the complete finite obligations. The cached variant adds explicit correctness of the local rule caches. Neither declaration names a successfully accepted whole historical table.

For comparison, the general layer adapter's premise is

```lean
def TargetCorrect (tables : Tables) (target : Target) : Prop :=
  ∀ b i, i < target.size b →
    NormalStrategy SafeMove (state tables (target.unrank b i))
      (outcome (target.labelP b i))
```

Loading a target file supplies values of `target.labelP`; it does not supply a proof of `TargetCorrect`.

### A.2. Exactly-once enumeration

The exported conjunction from `Mahjong.GlobalEnumeration` is

```lean
theorem enumeration_correct (seed : Nat → Nat) (c : Certificate) :
    (∀ a, ValidSlot c a → Valid (decode seed c a) ∧ IsSafe (decode seed c a)) ∧
    (∀ s, Valid s → IsSafe s →
      ∃ a, ValidSlot c a ∧ SameOrbit s (decode seed c a)) ∧
    (∀ a b, ValidSlot c a → ValidSlot c b →
      (SameOrbit (decode seed c a) (decode seed c b) ↔ a = b))
```

Its certificate contains finite input checks and representation links. A reviewer should inspect that structure together with the theorem. Merely supplying filenames where the theorem expects proofs would not instantiate it. The arbitrary seed belongs to the mathematical decoder; bounded machine implementations introduce their own checked helper contracts.

### A.3. Correct evaluation without a pre-existing output table

In `Mahjong.LayeredRetrograde`, with `[DecidableEq α]`, the principal declaration is

```lean
theorem bottom_up_correct (move : α → α → Prop)
    (succ : α → List α) (rank : α → Nat)
    (exactSucc : ∀ s t, move s t ↔ t ∈ succ s)
    (decreases : ∀ s t, move s t → rank t < rank s)
    (states : List α) (covers : ∀ s, s ∈ states)
    (sorted : states.Pairwise (fun s t => rank s ≤ rank t)) :
    ∃ result, run succ states (fun _ => none) = some result ∧
      ∀ s, ∃ b, result s = some b ∧
        NormalStrategy move s (outcome b)
```

The Boolean convention in this model is `true` for P and `false` for N. Other historical interfaces may use integer zero for P, so a reader must use the relevant encoding definition rather than transfer conventions between formats. The theorem proves existence and correctness of a complete evaluation under its finite hypotheses; it leaves the value of a particular unexecuted instance unspecified.

### A.4. Source entry points

All paths in Table A1 are relative to the research root. The prefix for the generic files is `build/lean_table_checker/source/Mahjong/`. The [formal audit memo](formal_evidence.md) gives source lines, full premises, and additional declarations. Some declarations belong to other entry-point closures and are not among the 84 modules replayed for the latest algorithm audit.

**Table A1. Compact source-to-claim catalogue.**

| Declaration, prefixed by `Mahjong.` | File or source family | Scope to inspect |
|---|---|---|
| `original_safe_reduction` | `Bridge.lean` | Original achievement game and SAFE normal play |
| `Solo.Branch34.original_second_player_wins`, and corresponding Branch44/Branch35 declarations | `runs/lean_solo/*_kernel_v1/source/MahjongSolo/*/Root.lean` | Exact state-specific winner theorems |
| `WholeTable.checked_empty_wins` / `CachedWholeTable.checked_empty_wins` | `WholeTable.lean`, `CachedWholeTable.lean` | Complete acceptance and exact empty-root premises |
| `GeneralOriginalSoundness.row_original` | `GeneralOriginalSoundness.lean` | Explicit correctness of the target layer |
| `TerminalBucket.row_sound` / `NearTerminalBucket.row_sound` | Respective files | Direct terminal and near-terminal row checks |
| `Base5Coverage.checked_filter_on_every_valid_state` | `Base5Coverage.lean` | Correct local data and exhaustive valid-state interpretation |
| `CanonicalCoverage.every_safe_has_retained_representative` | `CanonicalCoverage.lean` | Existence of a retained representative under checked inventories |
| `SafeLayerBound.original_safe_bound` | `SafeLayerBound.lean` | Checked local and joined envelopes |
| `GlobalEnumeration.enumeration_correct` | `GlobalEnumeration.lean` | Validity, global coverage, and orbit uniqueness |
| `IndexOperations.rank_unrank`; `IndexWalk.walk_covers_every_valid` | `IndexOperations.lean`, `IndexWalk.lean` | Mathematical index and traversal contracts |
| `WordDecodedGlobal.every_original_safe_is_visited` | `WordDecodedGlobal.lean` | Machine-word bounds, helper correctness, slice binding, and initial decoding |
| `CachedTransitionQuotient.transition_quotient`; `strategy_iff` | `CachedTransitionQuotient.lean` | Two-sided transition and strategy transfer |
| `CachedSuccessorList.exact_moves` | `CachedSuccessorList.lean` | Finite successor lists match the quotient relation |
| `MoveNormalization.optimized_mem_iff`; `cached_fast_eq_sort` | `MoveNormalization.lean` | Duplicate removal and the necessary sorting hypotheses |
| `MovePlanRefinement.planned_offset`; `PlanCacheCoverage.every_used_offset_fresh` | Respective files | Prepared offsets and coverage of actually used cache cells |
| `OptimizedRowBridge.optimized_cached_step` | `OptimizedRowBridge.lean` | Optimised row result under bucket, layout, and child-strategy premises |
| `LayeredRetrograde.bottom_up_correct` | `LayeredRetrograde.lean` | Complete finite evaluation from the uncomputed table |
| `ChunkWordOwnership.chunk_word_disjoint` | `ChunkWordOwnership.lean` | Aligned, disjoint model word ownership |

The earlier nonwinning bound of 37, general honour-pass Sprague–Grundy result, and frozen-region mathematical classifications retain their previous evidence labels. No newly completed formalisation of all those results was found in the current Lean route. This supplement does not relabel every theorem in the earlier paper as kernel-certified.

## Appendix B. Primary evidence and frozen identities

The following project artefacts are the primary evidence for the reported results. The index identifies them by their research paths and roles; the accompanying release manifest records their distribution paths or reconstruction procedures. The relative links resolve within the research workspace. The companion audit memos distinguish direct source inspection, receipt verification, and fresh execution.

**Table B1. Evidence index.**

| ID | Primary record | Use in this paper |
|---|---|---|
| S01 | [Earlier local manuscript](../manuscript.md), with the immutable published edition cited in the references | Baseline claims and original twelve-tile milestone |
| S02 | [Solo final status](../../research/2026-09-14/evidence/solo-continuation.json) and [result](evidence-catalogue.md#source-001) | Three new root certificates, integration, and selected ten-tile replies |
| S03 | [Preserved daemon status](evidence-catalogue.md#source-002), accompanying `progress.sqlite`, and [formal audit](formal_evidence.md) | Deduplicated P bank, successful batches, unfinished batch exclusion |
| S04 | [Actual scan acceptance](../../research/2026-09-14/evidence/ACTUAL_SCAN_ACCEPTANCE.json) and [scan report](evidence-catalogue.md#source-003) | Complete 34/33 historical-label checks |
| S05 | [General feasibility study](evidence-catalogue.md#source-004) and [empirical audit](empirical_evidence.md) | Sample intervals, target trust, performance, and feasibility gate |
| S06 | [Pruning](evidence-catalogue.md#source-005), [full SAFE and encoding](evidence-catalogue.md#source-006), and [canonical inventory](evidence-catalogue.md#source-007) | Exhaustive local checks and general predicate/canonicalisation theorems |
| S07 | [Groups and directory](evidence-catalogue.md#source-008) | Groups, SAFE envelopes, directory and prefix checks |
| S08 | [Index algorithms](evidence-catalogue.md#source-009) and [global enumeration](evidence-catalogue.md#source-010) | Rank/unrank, coverage, uniqueness, and slice binding |
| S09 | [Word refinement](evidence-catalogue.md#source-011) and [decoder refinement](evidence-catalogue.md#source-012) | Bounded arithmetic, helper domain, decoding, and initialisation |
| S10 | [Successor-cache certification](evidence-catalogue.md#source-013) | Actual exported local edges and transition quotient |
| S11 | [Finite algorithm review](evidence-catalogue.md#source-014), [acceptance](../../research/2026-09-15/evidence/acceptance.json), [source map](../../research/2026-09-15/evidence/source-map.json), and [operational binding](../../research/2026-09-15/evidence/operational-binding.json) | Latest theorems, synthetic C++ controls, and frozen implementation links |
| S12 | [Fresh source replay](reproduction/source-replay.json), [reproduction audit](reproduction_evidence.md), and [companion source bundle](https://github.com/feierbuqiu/mahjong-achievement-game/releases/download/v1.0.0/current_model_source_bundle.zip) | New kernel-source replay and recipient reproduction |
| S13 | [Verification status](../../research/2026-09-15/evidence/STATUS.json) and [retained-file audit](reproduction/current_retained_evidence_check.log) | Reported verification scope and identity checks |

The latest retained-file audit rehashed all 5,329 acceptance-listed files, totalling 3,139,914,649 bytes. It returned `PASS_READ_ONLY_FINITE_RETROGRADE_AUDIT`. That collection includes tooling, finite-check artefacts, and synthetic outputs, but no historical `runs/global_retro/*.bits` payload. The original acceptance digest remained unchanged. The separate [machine-readable empirical audit](empirical_evidence.json) records selected file hashes, receipt relationships, deduplicated registry counts, and sample interval unions.

**Table B2. Selected SHA-256 identities.**

| Artefact | SHA-256 |
|---|---|
| Earlier local manuscript, S01 | `f1d521177f2270e4340703faddaa6f9426108e939cd19cfeb71b4f2fc5fbe2e5` |
| `group_directory_v1/acceptance.json` | `01a69fedec1063a9ecad33135492449ca7c32ef5bc83bb213b7d066f4b9935c6` |
| `global_orbit_v1/acceptance.json` | `ec71a9c7746b582e1d56dfed2cabbd95f36b7b8a39955a4a73092f092f920aeb` |
| `successor_cache_v1/acceptance.json` | `60d0b661766e7121c9798277b48a2dc2024bdc601fb307ad330e7c603f60cdb9` |
| `optimized_retro_v1/acceptance.json` | `1f23e423794ce0f64a001367d59a41baab82fd517602e9c48046c95a96b14400` |
| Frozen production `global_retro.cpp` | `6664c16ab99d058478cc10d7b85edbf43328884f5c1a8d5abf12fecf274acee8` |
| Frozen production `global_index.hpp` | `b742e5bbb20ed0df50665c0d454d3bf4b7691dabc4d2d0380e7159766f8bf0c8` |
| New `optimized_source_v2/result.json` | `b77ccc01b5f1c2fcaf09f116068daa3631cd0f51d7e74df0ba470301b6648cef` |
| Recipient-path replay `result.json` | `df7371b2d6d3cc3780c9a7052fd026765f047e8178e2f980c70d2a9f7d4a9ba3` |
| Model-source ZIP used for this paper, 175,554 bytes | `fdd9e7ebaaaeac891e746b69f604ee9fc92ccdb85c4c03f92b4affd164f4da33` |

These hashes identify versions of evidence, not theorem truth. Complete per-source identities and import relationships for the delivered model closure are in its `source_manifest.json`; the bundle's `FILES.sha256` also identifies its driver and instructions. The larger local evidence chain remains separately indexed by its own acceptance manifests.

## Appendix C. Reproduction commands and expected outcomes

### C.1. Select the version accompanying the article

For this publication, select the signed `v1.0.0` tag and check the two-paper collection:

```bash
git clone --branch v1.0.0 https://github.com/feierbuqiu/mahjong-achievement-game.git
cd mahjong-achievement-game
python3 tools/verify_repository.py
python3 tools/verify_lean_supplement.py
```

Use the source archive, Git bundle, or repository commit identified by the release accompanying this article. Its manifest supplies the version and content hashes and identifies the verification entry points for the included artefacts. When using a clone, select that recorded commit before running the associated checks. The model-source replay in Section C.3 is self-contained once its declared toolchain and Python dependency are installed.

For comparison with the preceding paper only, the following commands retrieve its historical baseline. They are not the entry point for the new results in this supplement. They require Git and Python 3.10 or later; on Windows, use `python` instead of `python3` if that is the installed command.

```bash
git clone https://github.com/feierbuqiu/mahjong-achievement-game.git
cd mahjong-achievement-game
git checkout --detach 691d2400d09d5ddfb18d4721835d464b0f4ecebb
python3 tools/verify_repository.py
python3 tools/verify_lean.py --check-only
python3 research/2026-09-14/verify.py
```

The concrete-proof integrity check should report `PASS_ARTIFACT_INTEGRITY` for 1,008 modules. The separate checker-archive integrity command should report `PASS_PUBLIC_HANDOFF` for its 56 source modules and retained evidence. These two integrity commands were rerun on the untouched local copy of the public baseline during this audit. Neither result is a fresh kernel replay.

The historical release's `SNAPSHOT.json` supplies its checksum and signature instructions. Its identifiers remain useful for reproducing the earlier baseline. Reproduction of the new results uses the version accompanying this supplement and the corresponding artefact manifests.

### C.2. Recheck the historical nonempty strategy proofs

Install the pinned Lean toolchain, `leanprover/lean4:v4.33.1`. The proof sources use the standard Lean distribution and do not require a separate mathlib package. From the pinned checkout, the following are alternative scopes:

```bash
# All 1,008 distinct modules across the seven audit entry points.
python3 tools/verify_lean.py --lean /path/to/lean --workers 2

# The frozen September 13 milestone group: 374 modules.
python3 tools/verify_lean.py --lean /path/to/lean --entry latest --workers 2

# The smaller, original 34-tile pipeline.
python3 tools/verify_lean.py --lean /path/to/lean --entry PipelineAudit --workers 1
```

Replace `/path/to/lean` with the actual Lean executable. The command named `latest` is a group in the frozen runner; it does not mean the latest research described in this supplement. These commands were inspected here, not all rerun. The expected successful kernel status is `kernel_modules: PASS`, with `empty_game_lean: NOT_VERIFIED` unchanged. The optional `--require-opening` flag deliberately returns an incomplete-opening exit status when that requirement is unmet; it is not appropriate for claiming that the selected nonempty proofs failed.

The separate public checker archive can be rebuilt using

```bash
python3 research/2026-09-14/verify.py --lean /path/to/lean
```

That command compiles the public 56-module source set with fresh project objects and does not execute the native data workers. The fresh 84-module result in this paper concerns a different, later closure and must not be relabelled as a replay of those 56 files.

### C.3. Replay the accompanying model-source bundle

Extract [current_model_source_bundle.zip](https://github.com/feierbuqiu/mahjong-achievement-game/releases/download/v1.0.0/current_model_source_bundle.zip) into a new local folder. The tested controller requires **Windows**, **Python 3.11 or later**, `psutil`, and **Lean 4.33.1**. The recorded environment used Python 3.12.14 and `psutil` 7.2.2. Linux and macOS execution of this controller has not been validated. The source files can be separated from the controller for a future platform-specific replay, but such a replay is not claimed here.

From the extracted folder, with a suitable Python environment and Lean on `PATH`:

```powershell
python -m pip install psutil==7.2.2
python replay.py --check-only
python replay.py --lean lean --workers 2 --seconds 300 --label reviewer_run_01
```

An explicit path to `lean.exe` may replace `lean`. The integrity command should report `PASS_SOURCE_PACKAGE_INTEGRITY`, 84 source modules, and `kernel_replayed: false`. The subsequent replay should report `PASS_KERNEL_SOURCE`, all 84 completed modules, and all 79 expected axiom declarations matching. Its receipt also preserves `empty_game_lean: NOT_VERIFIED` and zero newly checked historical P/N rows.

The driver uses only the bundled source and manifests plus the declared external toolchain and Python dependency. Each replay creates a new output directory; use a new label for another cold run. The 300-second value is a resource deadline, not a portable runtime guarantee. On a slower machine a timeout records an incomplete run, for which an explicitly larger bounded deadline may be chosen. The recorded success and memory figures in Section 8 refer to their exact retained receipts.

The complete current research source tree has 148 Lean files, including workers and other proof entry points. This companion contains only the 84-file algorithm dependency closure. The full-tree local driver and the unexecuted `--all-source` option are documented in [reproduction_evidence.md](reproduction_evidence.md). A claim to have replayed all 148 sources, or all later explicit strategies, would require a separate completed receipt.

### C.4. Audit the larger retained evidence locally

For a holder of the full research workspace and its local finite-check artefacts:

```powershell
python -B build/lean_table_checker/accept_optimized_retro.py --check-only
```

The expected result is `PASS_READ_ONLY_FINITE_RETROGRADE_AUDIT`, 5,329 files, 79 audited core declarations, and the fixed acceptance digest in Table B2. The `-B` option prevents Python bytecode-cache writes. The command is an integrity audit. Omitting `--check-only` invokes a different workflow and is not a substitute for these read-only instructions. The small source ZIP intentionally does not satisfy this larger command's input requirements.

For a new finite native run, consult the corresponding S06–S11 record and provide its complete input set and dependencies. For a new complete historical-label run, provide the necessary full P/N payload and a complete aggregation route. No command in this appendix purports to generate the still-missing end-to-end opening proof.
