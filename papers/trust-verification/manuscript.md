# Trust and Formal Verification in the Mahjong Achievement Game: Complete Native Checking and Progress towards End-to-End Kernel Proofs

**feierbuqiu**

*19 October 2026*

## Abstract

This paper supplements two earlier reports on the Mahjong Achievement Game and examines how far its computational and formal results can be trusted. The principal new computational achievement is complete native evaluation of a Lean-specified verification procedure over all 778,532,864,302 recorded SAFE symmetry orbits. The completed run checks 35 layers, 3,686 nonempty buckets, and 17,317 frames, and confirms the empty position's P label under an explicit compiler, runtime, input-custody, and bookkeeping trust boundary. A kernel-checked whole-input theorem connects six finite acceptance families to a second-player winning strategy in the original game. Separately, persistent pure-kernel experiments now save and replay concrete nonempty-game strategies and compressed numerical certificates. An eleven-node physical certificate supports three named thirty-two-tile starting-position conclusions. A numerical certificate covers all 28 fixed sample blocks, 402 words, and 1,234 layout equalities, representing 1,035,129 colex rows; its 273-module closure passes fresh kernel replay. The numerical and game proofs have not yet been joined into an actual empty-position kernel certificate. A validated local portable delivery now includes the exact toolchain, the complete historical input set, and saved proof pilots, with successful same-host tests from independent extraction directories. We distinguish logical implication, native evaluation, persistent proof, artefact auditing, and independent replication. The resulting assurance is substantial and precisely scoped, but no numerical confidence percentage or end-to-end pure-kernel completion-time bound is established. We identify the remaining concrete proof obligations and propose milestones for extending the current work.

**Keywords:** Lean; formal verification; computer-assisted proof; trusted computing base; proof certificates; retrograde analysis; proof persistence; reproducibility

## 1. Introduction and relation to the earlier papers

The Mahjong Achievement Game asks which player can force the first legal fourteen-tile winning subset on a shared cumulative table. The first report presented a completed C++ retrograde computation and a full reverse check, giving a computational second-player win. It also documented structural results and concrete Lean-certified nonempty strategies ([feierbuqiu, 2026c](https://github.com/feierbuqiu/mahjong-achievement-game/blob/v1.0.0/papers/manuscript.md)). The September supplement subsequently explained the growing local proof bank, compiled Lean checks of the terminal and near-terminal layers, and general proofs of representation, enumeration, successors, and retrograde models ([feierbuqiu, 2026b](https://github.com/feierbuqiu/mahjong-achievement-game/blob/v1.0.0/papers/lean-verification/manuscript.md)).

The present paper addresses two questions left open by that supplement. How strong is the verification evidence for the actual complete computational result? What progress has been made towards a saved proof of that result which can be checked through ordinary kernel reasoning? Both questions now have materially different answers, although the final pure-kernel opening theorem remains unfinished.

The first change is a completed whole-input native verification. The kernel proves an implication from concrete finite checks to the original-game conclusion; the compiled checking functions have now evaluated the complete historical input successfully. This replaces the earlier partial scan with full recorded coverage under a stated execution boundary. It does not regenerate the historical solution table, and its output counts are not a second independent discovery of those same labels.

The second change is proof persistence. Small concrete game proofs and substantial numerical component proofs have been saved as ordinary Lean modules and rechecked in fresh processes. They demonstrate that selected actual instances can be represented by durable proofs rather than solely by native acceptance reports. Their exact scope matters: the numerical sample still lacks the complete game-specific premises needed to turn it into original-game strategies, and the physical-game pilot does not instantiate the full production checker.

The third change concerns reproduction. A locally prepared portable delivery now contains the exact Linux toolchain, source and execution evidence, the complete historical input files in a separate archive, and optional saved pure-kernel pilots. Tests have rebuilt sources and the native executable, exercised a complete small bucket and negative controls, and replayed saved proof lanes from new directories on the same host. A second complete portable verification and replication on another physical machine remain separate tasks.

These developments warrant a new supplement rather than an amended completion percentage. A native checker can cover every historical row while a persistent kernel proof remains incomplete; a compact arithmetic proof can cover many numerical coordinates without certifying that many game positions. We therefore state every result in terms of its proposition, domain, checking method, and remaining assumptions. This approach reflects the broader distinction between believing a formal derivation and establishing that its interpretation and execution justify the intended mathematical claim ([Pollack, 1997](https://doi.org/10.7146/brics.v4i18.18945)).

### 1.1. Contributions and evidence cut-off

This supplement contributes a documented transition from partial to complete native verification; an account of the whole-input theorem that discharges previously external strategy assumptions; an analysis of persistent game and numerical certificates; and a reproducibility and trust assessment grounded in completed records. The engineering and formalisation are contributions to this particular investigation. The paper does not claim to originate proof by reflection, proof-carrying artefacts, or kernel-based checking.

The evidence cut-off is 19 October 2026 in Australia/Sydney. The complete native run finished at 17:56:53 UTC on 18 October, corresponding to 04:56:53 on 19 October in Sydney. Later completed kernel and portable-delivery records are included individually. Older status files are read at their own dates: an October 18 statement that full native acceptance had not yet been evaluated is superseded by the completed run, whereas its statement that no actual closed empty-position kernel theorem existed remains consistent with the later evidence.

The present manuscript was prepared by reading retained source, proof and execution records, with additional read-only consistency audits. No new full-table verification or proof-construction campaign was run for this paper. Evidence identifiers T01–T12, resolved in Appendix B, distinguish project records from the external references.

**Table 1. What changed after the September supplement.**

| Topic | September supplement | Present completed result | Remaining boundary |
|---|---|---|---|
| Computational outcome | Empty position P in the historical C++ solution | Historical outcome retained and accepted by complete V17 native checking | A recorded native evaluation still has execution assumptions |
| Actual table coverage by compiled Lean | Layers 34 and 33: 22,512,356 recorded SAFE orbits | Layers 0–34: 778,532,864,302 recorded SAFE orbits | Coverage bookkeeping and concrete execution are externally recorded |
| Whole-input formal composition | General checking and model theorems with explicit outstanding premises | A theorem from six finite acceptance families to `SecondPlayerWins Step Win empty` | Actual acceptance equations have not all been supplied as saved kernel proofs |
| Concrete nonempty proofs | A retained bank of 24,655 P facts, including four twelve-tile roots | Inherited results plus a new persistence pilot with three named thirty-two-tile starting-position conclusions | The pilot tests a different certificate route and does not advance the earliest certified opening depth |
| Numerical kernel certificates | General index and optimisation results; concrete large checks mainly native | All 28 fixed sample blocks, 402 words, 1,234 layout equalities, saved proofs and fresh replay | Actual SAFE, complete target addressing, and game-strategy assembly remain absent for that sample |
| Distribution and reproduction | Selected source closures and local finite-input evidence | Portable core, complete input archive, and optional saved kernel pilots | Same-host relocation is demonstrated; a second physical machine and a second all-layer execution are not |
| Pure-kernel opening conclusion | Not constructed | Not constructed | End-to-end completion time also remains unestablished |

## 2. Mathematical target and verification vocabulary

### 2.1. Rules and the original-game conclusion

There are 34 tile kinds and four copies of each. A valid table is a vector $`x\in\{0,1,2,3,4\}^{34}`$. Players alternately add any available tile to the same cumulative table. A player wins when their addition first makes the table contain a legal fourteen-tile winning submultiset. The allowed targets are four melds and a pair, seven pairs of seven distinct kinds, and thirteen orphans. Numerical sequences are suit-local consecutive triples; triplets and every complete target obey the four-copy limit. Surplus tiles outside the winning subset do not invalidate it.

Let $`\mathcal W`$ be the target family and $`e_t`$ one tile of kind $`t`$. The relevant predicates are

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

The SAFE normal-play game retains additions whose destinations remain SAFE. The established reduction connects its P/N strategies to the original achievement game. P means that the player about to act loses under optimal play; N means that player wins. UNKNOWN denotes an unfinished inference or computation and is not an outcome value. N does not imply a Sprague–Grundy value of one.

Writing $`p(x)=1`$ for P, the recurrence is

```math
p(x)=1\iff\forall y\,[x\longrightarrow_{\mathrm{SAFE}}y\Rightarrow p(y)=0].
\qquad\text{(3)}
```

Every edge adds a tile. The established SAFE bound of 34 supplies the last possible layer. Symmetry uses suit permutations, independent numerical rank reversals, and honour permutations; it does not permit arbitrary numerical rank permutations. Counts of represented orbits, physical positions, proof rows, and repeated executions remain different quantities.

The desired final theorem concerns the original rules and exact empty state:

```lean
SecondPlayerWins Step Win empty
```

A theorem with this conclusion may still be conditional. Its parameters and hypotheses must be inspected before calling it a completed proof of the actual opening.

### 2.2. Four meanings of verification

Lean is both a theorem prover and an executable language ([de Moura & Ullrich, 2021](https://lean-lang.org/papers/lean4.pdf)). We distinguish a **kernel-checked implication**, a **native evaluation of its finite premises**, a **saved concrete kernel proof**, and an **audit of retained records**.

A kernel-checked implication establishes that the displayed assumptions entail a conclusion. Native evaluation provides execution evidence that particular checking functions returned true on particular inputs. A saved concrete proof supplies a proof term for a specified instance, whose mathematical dependencies can be checked again. An artefact audit checks identities, relationships, and coverage in saved records; it need not execute the original mathematical checker at all.

For the whole-input result, a useful schematic form is

```math
\left(\bigwedge_{j=1}^{6} C_j(D)=\mathrm{true}\right)
\Longrightarrow\mathrm{SecondPlayerWins}(\mathrm{empty}),
\qquad\text{(4)}
```

where $`D`$ includes finite rules and metadata, outcome bits, and frame information. Equation (4) summarises a dependent Lean interface rather than reproducing its exact type. The theorem is proved. The completed native execution supports its actual acceptance premises under the execution assumptions. A closed strict-kernel instance would additionally supply those premises as concrete proof terms and compose them into the opening theorem.

Here **pure-kernel** means that the relevant saved proposition is justified by ordinary Lean proof checking with only the declared standard foundational axioms, without an added native-computation axiom or a trusted external acceptance flag. It does not mean axiom-free logic, a verified operating system, or an independently implemented kernel. The specification's meaning and the faithful operation of the proof checker remain part of the assurance argument.

## 3. The new whole-input theorem

### 3.1. Replacing an assumed child strategy with finite composition

The earlier general row adapter exposed `TargetCorrect`: every loaded child label needed an associated strategy justification. Loading a correct-looking historical bit file did not provide that proof. V17 supplies the missing general composition. It retains both SAFE and strategy information, composes the 35 layers across 184 possible honour buckets per layer, and constructs target correctness from the already established next layer (T02).

Cross-layer identity is checked rather than inferred from a matching bucket name. A nonempty target bucket must agree with the next layer's source in seven actual fields, including its bits. Layer 35 and out-of-range buckets must be empty. The root checker verifies directory information, local indexing, data length, and the P bit, then proves that the decoded root is the exact empty state. The caller does not supply empty-state equality as an unsupported hypothesis.

Finite base inputs include the local caches and inventories, groups, bounds, directories, layout and machine-word limits. Their checks construct the formal metadata and cache obligations. The pure reference interface does not accept an arbitrary `Checked`, `TargetCorrect`, or winning-strategy proof as a substitute for those checks.

### 3.2. The six acceptance families

The final theorem is `Mahjong.FastWholeInputV17.from_finite_input`. Table 2 describes its six acceptance families and the corresponding completed native execution. The exact signature is given in Appendix A.

**Table 2. Formal obligations and their execution connection.**

| Acceptance family | Principal Lean interface | Role |
|---|---|---|
| Finite base data | `FiniteWholeInputV17.baseChecks`, using `FiniteCertificateV17.checks` | Establish rules, inventories, groups, directories, bounds and representation conditions |
| Successor lists | `FiniteWholeInputV17.successorChecks`, using `FiniteMetadataV17.checkSuccessors` | Establish complete retained local additions and their identities |
| Bucket metadata | `FiniteWholeInputV17.checkMetadata`; `checkSource`, `checkBank`, `GroupNextCoverage.check` | Bind each source and target representation to the accepted finite metadata |
| Frame scanning and coverage | `FastWholeInputV17.checkWhole`; `RuntimeScanV17.prepare`, `scanFragment`, `assembleScanned` | Derive row checks from prepared fragments and complete ranges |
| Cross-layer identity | `ExecutionAssemblyV17.targetChecks`; `CrossLayerAssemblyV17.checkTargets` | Ensure the child data are the same data justified by the next-layer result |
| Exact empty P root | `EmptyRootV17.checkP` | Bind the conclusion to the actual empty state and its P bit |

The theorem internally constructs its trace and row-check consequences. Prepared frames still contain real finite checking obligations; a raw file cannot simply be reinterpreted as a proof-bearing object. The typed model permits completed fragments to be combined without rerunning their row checks. It also permits proof fields to be erased during execution.

Erasure is an execution advantage and a persistence problem. A runtime value whose logical fields are erased can help a compiled program return a result, but printing its interval endpoints or saving a success log does not preserve the missing proof fields. After restart, those bytes are not automatically a Lean proof. The native production run used external assembly of its accepted records rather than the model's complete typed `finishWhole` route. Its coverage and custody records therefore belong explicitly to the native trust boundary.

### 3.3. What the general proof does and does not require

For a P row, every actual legal SAFE successor must be justified as N; for an N row, an actual P successor suffices. With finite, decreasing cross-layer dependencies, these checks can prove a strategy from the empty state without requiring a separate theorem that the supplied directory globally enumerates every SAFE orbit. A missing necessary response must fail the relevant row obligation. The stronger global enumeration claim remains a distinct proposition with its own concrete input-binding requirements.

This matters when interpreting completeness. The completed run's catalogue covers the entire recorded 778,532,864,302-slot domain. The generic strategy theorem establishes soundness through accepted physical moves and finite induction. Neither fact licenses deletion of the theorem's actual acceptance premises, nor does it automatically instantiate every earlier global enumeration certificate as a single literal kernel term.

The recorded final V17 implication replay checked 145 imported project modules in 123.078 seconds. A later Linux replay attached to the production build records 114.644 seconds. These are replay measurements of the implication and its dependencies, not proof construction for the full concrete table. Selected transitive axiom reports contain only `propext`, `Classical.choice`, and `Quot.sound`, or subsets thereof. Failed construction attempts remain outside the successful proof environments (T02–T03).

## 4. Complete native verification of the historical table

### 4.1. Completed scope and result

The completed production run is `full_native_20261018_02`, whose final claim class is kernel implication plus native computation. It evaluates the fixed verification functions against the historical table; it does not solve the game again by generating replacement labels. Its result is documented in the public V17 evidence record as well as the retained execution files ([feierbuqiu, 2026a](https://github.com/feierbuqiu/mahjong-achievement-game/blob/e75911f700d4e5e1b39df53273e9dde698bf4901/research/2026-10-19-v17/README.md)).

**Table 3. Whole-input native verification.**

| Quantity | Completed record |
|---|---:|
| Tile layers | 0–34 |
| Recorded SAFE orbits checked | 778,532,864,302 |
| Nonempty buckets | 3,686 |
| Empty cells | 2,754 |
| Total layer/bucket cells | 6,440 |
| Committed frames | 17,317 |
| P rows | 203,051,492,021 |
| N rows | 575,481,372,281 |
| Actual input files | 11,272 |
| Actual input bytes | 100,615,834,170 |
| Native sessions in the completed production run | 1 |
| Imported old PASS records or solution seeds | 0 |
| Empty position | P |
| One-tile symmetry orbits | All six N |
| Closed actual-input kernel declaration | Not constructed |

The P and N counts sum to the recorded orbit count. Their agreement with the original solution is expected because those historical labels are the verification input. The new contribution is complete acceptance of the recurrence and associated finite data by the V17 checking route, with identity and coverage records. It extends the earlier compiled Lean coverage of 22,512,356 recorded SAFE orbits to the entire recorded domain.

### 4.2. Untrusted proposals and native checking

The GPU supplies proposals and accelerates preparation. It is not trusted to decide the soundness of a committed frame: a proposal must satisfy the native checks. N witnesses require actual successor membership; P obligations retain complete successor coverage. A fast proposal that omits a necessary condition cannot be counted as accepted merely because its GPU stage returned successfully.

The checking theorem's formal semantics are connected to an executable through native compilation and the recorded runtime build. The run therefore relies on compilation, runtime operation, raw-file interpretation, and the faithful connection between actual inputs and the functions being evaluated. A positive native return is strong execution evidence within that boundary. It is not a proof term for the same Boolean equation checked by ordinary kernel reduction.

### 4.3. Input custody and exact coverage

Input identity was checked before and after execution, with equal maps for the completed input set. There is an important timing qualification. The first attempt performed the full prehash and stopped on a GPU resource declaration before any game frame was committed. The second attempt inherited continuously read-locked identities for 11,271 files, totalling 100,615,716,067 bytes, and newly hashed its 118,103-byte catalogue. Reusing those held identities is not importing an old mathematical PASS; it is an input-custody handover whose correctness remains part of the operational assumptions (T03).

The external ledger records frame ranges, native results, and identities. A read-only audit for this manuscript recomputed the canonical hashes of all 17,317 entries, checked their result bindings and exact interval cover, and reconciled 54,548 cross-layer target references. The independently summed row and outcome counts agree with the final record, with no discrepancy in the audited relationships. This audit examines recorded evidence; it does not repeat the native checking of the game rows.

The completed production timer and the full setup history have different scopes. The controller completion record reports 27,304.5 seconds, approximately 7.6 hours; the later display reports 27,333.44 seconds. A more narrowly scoped final record gives 27,303.9915 seconds. These closely related production measurements exclude earlier build and pilot work and the first attempt's full prehash. The accepted-frame time sum of approximately 17,710.80 seconds further excludes base-data and bucket loading and finalisation. No one of these values is a pure-kernel completion time.

### 4.4. Resources, controls, and separate review

The recorded machine has an Intel Core i7-10700KF, eight cores and sixteen logical processors, 32 GiB of RAM, and an RTX 2070 SUPER, running Windows with WSL Linux. The native pool used twelve execution threads. The final production plan does not record an enforced aggregate 16 GB RAM cap. Host-memory samples include a minimum available value of approximately 2.335 GB; these are system observations, not a measurement of the checker's own peak RSS. Resource limits from earlier pilots must not be attributed to this run.

Six native controls accepted a valid complete small bucket and rejected a source-bit flip, a missing final row, a substituted target identity, truncated source bits, and incorrect honour metadata. Thirty-six transport cases and 22 bookkeeping cases are mocked controls, not operating-system power-loss experiments. The later portable test also exercised the actual stored ledger finaliser with missing, corrupted and overlapping records. Their exact scopes are retained in T03 and T09.

A separate report identifies its reviewer as Claude, from Anthropic, using model `claude-opus-5-5`. It describes read-only review without authorship of the implementation. Its ledger script checked recorded coverage and identities and rehashed 62 sampled inputs, totalling 81,370,822 bytes. It did not rerun Lean, the native checker, or the GPU, did not rehash the entire input set, and reviewed only the finaliser line by line among the trusted Python bookkeeping. We treat it as separate AI-assisted scrutiny with those stated limits, not human peer review or independent execution replication (T04).

## 5. What can be trusted, and on what basis?

### 5.1. The current whole-game claim

The completed record supports a computer-assisted verification of the second-player result under the stated execution assumptions. Its strength is the combination of a proved checking implication, complete recorded acceptance, exact coverage, input custody, and retained controls. It is considerably stronger than sampled agreement or a proposed strategy extracted from an unfinished search. The relevant limitation is the remaining trust boundary, not missing native coverage.

The claim is conditional in two different senses. Every formal theorem is interpreted in a logic with its declared axioms and definitions. In addition, the actual whole-table result currently uses native execution and external assembly to justify finite acceptance. Removing the latter dependency is the purpose of the persistent pure-kernel programme. It would be misleading either to describe the completed native result as merely a conjecture or to describe its trust as already confined to a saved kernel proof.

There is no defensible percentage such as “99.9% formally certain” in these records. The controls do not estimate a statistical distribution of all possible implementation, modelling, or hardware errors. Zero disagreements within the audited domain is an observed result with a specified scope. Assurance should instead be assessed through explicit dependencies and the checks that reduce particular failure risks.

**Table 4. Assurance arguments for the principal claims.**

| Claim | Direct support | Dependencies that remain |
|---|---|---|
| The checking conditions imply the original-game result | V17 theorem and fresh kernel replay | Intended meaning of the formal rules; Lean's logic, allowed axioms and checking implementation |
| The complete historical input passed those checks | Fixed native execution, runtime/source binding and accepted records | Compiler/runtime behaviour, actual I/O, input custody, external coverage and cross-layer assembly |
| The saved record has the reported coverage and identities | Canonical-hash and interval audits, source/target reconciliation | Faithful preservation of the record; the audits do not reproduce the original row evaluations |
| The concrete pilot game strategies hold | Closed original-game theorem declarations and saved-proof replay | Interpretation of their explicit states and rules; ordinary proof-checking environment |
| The fixed numerical pilot equations hold | Saved layout, equivalence and bit-equation proofs | Their stated numerical inputs; connecting them to complete game semantics remains additional work |
| The whole empty-position result has a saved pure-kernel proof | No such completed artefact at this cut-off | Concrete acceptance proofs and their final composition remain to be constructed |

### 5.2. Specification, identities, and execution are separate obligations

The specification must encode the intended shared-table game, including subset winning, all three target families, and the distinction between numerical and honour moves. Kernel checking proves the chosen proposition; it cannot determine whether a human intended a different game. The physical-game pilot and the original-game conclusion therefore retain the same `Step` and `Win` definitions rather than silently replacing them with a convenient restricted game.

File hashes identify bytes and permit provenance and change detection. They do not prove that those bytes satisfy the recurrence. Likewise, equality of aggregate P counts cannot establish per-row correctness. The verification record uses hashes to bind data and executable identities, row checks for mathematical acceptance, and exact interval cover to show that the intended execution domain was not skipped. Each serves a different purpose.

External input custody also has an operational meaning. Read locks, path resolution, before/after maps, and cross-layer comparisons support the claim that a child table read during verification is the table later used as that layer's source. They are not a Lean theorem about the operating system. The final mathematical interface checks equality of actual fields; the production connection to files and sessions is supplied by native checks and bookkeeping. Independent replication should inspect and exercise that connection as well as the row algorithm.

### 5.3. Fresh replay and axiom auditing

The pinned Lean 4.33.1 implementation of `leanchecker --fresh` replays imported and local constants into an empty environment. It uses Lean's own kernel, rather than a second kernel implementation. Its source also makes clear that fresh replay alone is not an external verification procedure ([Morrison & Ullrich, 2026](https://github.com/leanprover/lean4/blob/v4.33.1/src/LeanChecker.lean)). A declaration can still depend on admitted axioms. Accordingly, the saved-proof records combine replay with inspection of target types, source declarations, and transitive axiom dependencies.

The accepted targets in the current pure-kernel pilots use subsets of `propext`, `Classical.choice`, and `Quot.sound`. Neither `sorryAx` nor a native-computation axiom is accepted for those claims. A failed negative fixture can contain error-recovery placeholders in its diagnostic environment; that environment is excluded from the successful replay package. These distinctions follow the official guidance to examine both proof validity and theorem meaning ([“Validating a Lean Proof,” n.d.](https://lean-lang.org/doc/reference/latest/ValidatingProofs/)).

Version specificity matters for `native_decide`. In Lean 4.33.1, native evaluation can add an auxiliary axiom asserting that the evaluated Boolean is true; the relevant implementation constructs a name in the `_native` family. It does not meet the strict standard-axiom-only criterion used here ([Breitner, 2026](https://github.com/leanprover/lean4/blob/v4.33.1/src/Lean/Meta/Native.lean)). This is a declared alternative execution boundary, not a way to turn the current native result into the desired strict-kernel instance. Conversely, native code used only to propose expressions need not be trusted for a proposition if the resulting ordinary proof is subsequently checked without that code in its proof environment.

### 5.4. Replication and review

The current record contains several distinct independence claims. The original C++ forward solver and deletion-based reverse replay differ in recurrence direction but share foundational components. The V17 checker uses a formal checking argument and a different verification architecture while inspecting the existing table. The separate AI review and this manuscript's record audits scrutinise preserved sources and evidence. None is a second physical-machine execution of the complete V17 process.

Same-host extraction tests nevertheless have real value. They test path assumptions, missing dependencies, source reconstruction, and whether saved proof objects survive outside the generation directory. Their success closes practical delivery gaps. It does not establish operating-system diversity, toolchain independence, or independent interpretation of the game. These are worthwhile further checks rather than reasons to erase the evidence already obtained.

## 6. Progress towards persistent pure-kernel verification

### 6.1. From an executable result to a durable certificate

An executable may return a value whose type carries a proof in the source language while compilation erases that proof. Saving its return code or serialising the remaining fields does not restore the proof after restart. A persistent route must instead provide mathematical declarations or a finite certificate whose acceptance is itself justified through ordinary kernel checking.

This design separates potentially complex proof production from the smaller task of validating a delivered proof. It is related to the general proof-carrying-code principle of an untrusted producer supplying a checkable justification, although the objects and goals here are mathematical game certificates rather than executable safety policies ([Necula, 1997](https://doi.org/10.1145/263699.263712)). Reflection similarly motivates proving reusable checking principles and computing finite instances within an explicitly chosen trust boundary ([Boutin, 1997](https://doi.org/10.1007/BFb0014565)). The project-specific difficulty is making the complete actual instance both persistent and affordable.

### 6.2. Closed physical-game pilots

V18 constructs an eleven-node certificate in the original physical count coordinates. Its highlighted conclusions are two second-player wins and one first-player win at specified thirty-two-tile positions. The relevant declarations have no outstanding acceptance hypotheses; the actual trace check is itself a closed proof. Every P node covers all 34 tile kinds, with legality and actual SAFE successors checked. N nodes supply actual P successors in a strict trace tail. Terminality and source SAFE predicates are proved rather than inferred from an external terminal label (T05).

The named conclusions are `actual_p50_second_player_wins`, `actual_p55_second_player_wins`, and `actual_n35_first_player_wins` under `Mahjong.PilotActualGameV18`. Their exact count vectors are given in Appendix A. They are three highlighted starting-position conclusions from the eleven-node trace, not a claim that the trace certifies only three positions.

A separate hot-checker experiment saves acceptance proofs for 56 captured actual rows in four blocks, with 41 P and 15 N labels, and two scalar scan results that overlap those rows. These are finite captured read footprints. They do not instantiate every cache, address, and cross-layer premise of the full V17 theorem. The sparse physical certificate and the hot indexed checker must therefore remain separate achievements.

The September bank already contained concrete proofs beginning at twelve tiles. The new thirty-two-tile pilots do not improve that opening depth. Their contribution is to demonstrate and measure a persistent proof path for actual data in the newer architecture, including cold replay after saving the proof objects.

### 6.3. Numerical compression and the completed 28-block pilot

The subsequent work changes the representation and organisation of finite proofs. Generic theorems establish bit compaction, checked padding, and equivalence of optimised layout and channel functions under their stated hypotheses. For example, a compaction lemma relates bits extracted at a source stride to packed output positions, with explicit spacing and range conditions. It is not an arbitrary gather theorem for unproved target addresses.

The completed numerical pilot, `packed_05`, includes all 28 fixed sample blocks and all 402 words. It contains 1,234 concrete layout equalities and 601 arbitrary-input layout-function equivalences, with additional arbitrary-input channel equivalences. The saved top-level theorem is `Mahjong.FreshPackedEvidenceV19.pn`. Its 273-module project closure comprises 233 mathematical source modules and 40 generated data modules (T06–T07).

For each block, the numerical P/N statement is a pair of bit-set equations. If $`P`$ is the supplied P mask, $`R`$ the numerically constructed channel union, and $`M`$ the supplied valid-coordinate mask, the proved conditions are

```math
P\mathbin{\mathrm{AND}}R=0,
\qquad
P\mathbin{\mathrm{OR}}R=M.
\qquad\text{(5)}
```

They establish disjointness and complementary coverage for these particular numerical sets. To interpret them as the original game recurrence, one must additionally show that $`M`$ represents the actual domain and that $`R`$ represents the complete required SAFE successor queries with correctly justified target labels. The current sample does not supply the complete actual SAFE and target-addressing certificates or the final original-game assembly.

The sample represents 1,035,129 colex rows and 1,077,270 Cartesian coordinates. These describe different numerical views of the fixed sample; they are not additive counts or that many newly certified original-game positions. Calling the saved bit equations “P/N proofs” is accurate only with this numerical scope attached.

The complete construction and replay took 132.205 seconds; the final fresh replay alone took 61.828 seconds, with a sampled peak RSS of 737,734,656 bytes. The project certificate occupies 134,862,920 bytes, excluding the standard toolchain. A flipped-label fixture was rejected. A native expression builder assisted data emission, but it is absent from the final replay environment. The final claims are ordinary mathematical declarations rather than accepted native-computation axioms.

### 6.4. Proof organisation, local certificates, and unsuccessful attempts

The physical-game construction also tested a direct-reflexivity proof rewrite. It remained sound but took 34.212 seconds to construct and 140.993 seconds to replay, compared with 20.348 and 128.852 seconds for the baseline. Both construction measurements compile eleven new pilot modules while reusing thirteen existing mathematical module objects; fresh replay checks the full 24-module closure. A smaller term or a simpler-looking tactic is therefore not automatically a faster checked artefact. These are individual observations, not a general theorem about proof style.

An import-only foundation fork replaces selected `Std` dependencies with `Init`, preserves the game definitions and target proofs, and rebuilds all 24 project modules. Its recorded replay took 114.601 seconds. This experiment concerns dependency and import cost. It does not replace the frozen V17 mathematics or establish a global speedup for the complete game.

The general `LocalCertificateV19` and local-layer closure results offer another direction: a root strategy can use a smaller set of local correctness obligations without proving every stronger global directory or uniqueness property again. The certificate still requires actual local SAFE, canonical inventory, successor and finite-family conditions. Removing unnecessary fields is a reduction in proof obligations, not a proof of the remaining fields. The concrete complete local certificate and root family have not yet been instantiated.

Failed mask-sharing rewrites and unfinished branches are retained. In the latest recorded attempt, arithmetic mask facts were checked, but general rewriting and elaboration exceeded a 180-second child limit and sibling work was cancelled. Those outcomes concern feasibility of that proof organisation. They are neither accepted certificates nor mathematical counterexamples. The successful fixed-sample package supersedes earlier incomplete numerical attempts only in its own scope.

### 6.5. The remaining join

The current persistent results form two complementary pieces. The physical pilot proves actual original-game strategies on a small trace. The numerical pilot proves much larger fixed bit and layout obligations efficiently, but does not yet prove that its complete inputs implement the corresponding game transitions. They have not been joined.

A decisive next experiment is one actual packed block whose local SAFE conditions, complete target addressing, target strategy labels, numerical recurrence, and original-game bridge are all supplied as saved kernel proofs. Its saved proof should be replayable without the native proposer, expression plugin, original research process, or a trusted PASS marker. That would extend the persistence result from separate components to a complete block in the intended solution route.

## 7. Feasibility: what the measurements permit

### 7.1. Native completion is measured; kernel completion is not

The completed native verification took about 7.6 hours on the recorded machine for its production scope. That result is an observation, not a forecast. It does not include the entire development and packaging effort, and it does not measure the construction and replay of a saved pure-kernel opening proof. Older compiled-checker extrapolations and the actual native timing must not be repurposed as bounds for that different task.

For scale, a single traversal of 778,532,864,302 rows in 24 hours would require approximately 9,010,797 rows per second, before extra work. The earlier direct V18 comparison between eight and 56 row proofs gave about 4.50 incremental rows per second. That measurement motivated compression research; it is not a lower bound for every possible proof representation, nor the throughput of the later packed certificates.

### 7.2. A numerical component model

Profiling 56 numerical theorem modules on the fixed sample measured 0.28994 seconds of kernel type checking for the bit equations and 0.96696 seconds for layout, totalling 1.25690 seconds. The corresponding profiling invocation took 6.693 seconds including imports and frontend work. The numerical ratio is about 823,557 colex rows per kernel type-checking second for those components alone (T11).

Mechanical scaling of those components to the global row count gives about 262.592 core-hours per pass, or 32.824 hours under ideal division over eight cores. This is a limited cost model, not an end-to-end prediction, upper bound, or lower bound. The sample geometry is selected; global reuse is unmeasured; actual SAFE and local finite certificates, complete addressing, data loading, serialisation, generic proof costs, and final assembly are excluded. Both proof construction and saved-proof replay perform checking work. The measured final fresh replay is serial and cannot simply be divided by eight.

The useful conclusion is methodological. Proof representation can reduce repeated arithmetic work dramatically, while the dominant remaining semantic and delivery costs still require measurement. Neither a favourable component rate nor a successful numerical pilot establishes a twenty-hour pure-kernel completion bound. The current end-to-end time remains unestablished.

## 8. Reproducibility and artefact delivery

### 8.1. Reproduce the proposition, not just a status word

A reader should choose the verification target before running a command. Table 5 distinguishes the principal tasks. Their costs and outputs differ, and a PASS in one category cannot discharge another category's obligations.

**Table 5. Reproduction tasks.**

| Task | Principal inputs | Meaning of success |
|---|---|---|
| Audit public provenance and saved records | Mapped sources, manifests and native evidence ZIP | Recorded bytes, relations, identities and coverage reconcile |
| Rebuild the generic V17 proof | Exact mathematical sources and pinned toolchain | The whole-input implication and dependencies check again |
| Rebuild and test the native executable | Core package, compiler/runtime, actual small inputs | The rebuilt and original executables pass the defined small controls |
| Replay the saved kernel pilots | Pilot archive and exact toolchain | Specified saved mathematical declarations pass fresh kernel replay |
| Reconstruct the packed proof from source | Pilot sources, sample data, expression-building tools and toolchain | A new proof construction completes; this is distinct from saved-object replay |
| Repeat complete native verification | Complete raw inputs, executable and operational environment | A new complete execution accepts every required check with a fresh ledger |
| Recheck a pure-kernel opening theorem | A saved complete actual-input proof or equivalent finite certificate | This artefact has not yet been constructed |

The reproducibility reference for this paper is the repository version and artefact manifests accompanying the article. The article and new results may be frozen together later; this main-branch publication is a working edition, and historical commits identify earlier records without assigning a future release name. Distribution paths, archive parts, checksums and any later additions should be resolved through that associated manifest.

### 8.2. The completed portable delivery

The final local delivery separates three archives (T09–T10). Their [availability descriptor](delivery.json) records validated local custody, not public download hosting; no new release or archive upload accompanies this working-paper update.

**Table 6. Portable archive scopes. Sizes are decimal bytes.**

| Archive | Compressed size | Scope |
|---|---:|---|
| `mahjong_v17_core.tar.zst` | 1,407,097,086 | Sources, exact Linux Lean 4.33.1 distribution, original native ELF, common finite and small control inputs, execution evidence and reproduction tools |
| `mahjong_v17_full_inputs.tar.zst` | 8,087,887,655 | All 11,272 historical input files, expanding to 100,615,834,170 bytes |
| `mahjong_kernel_pilots.tar.zst` | 21,136,243 | Three saved pure-kernel lanes, their sources and fixed numerical sample, manifests and reconstruction tools |

The approximately 100.62 GB complete input set includes more than the approximately 97.32 GB historical P/N payload. A source archive or input hash list alone does not supply those raw inputs. Conversely, saved-proof replay does not require the global table or GPU. Separating the archives permits a reader to inspect and replay the smaller formal results without starting a full verification campaign.

The recorded environment is Linux x86_64 under WSL, with the pinned toolchain and runtime dependencies. The core uses Python-based integrity and reconstruction tools; archive extraction needs the documented Zstandard support. The current October wrappers have not been validated on macOS, ARM, older incompatible Linux runtimes, or native Windows. Requirements and optional full-run file-handle settings are recorded in the delivery's environment and portability notes, rather than inferred from the September Windows experiments.

### 8.3. What was actually reproduced

The final portable cold test took 1,948.532 seconds overall. It performed clean extraction and member checks, compiled all 149 project source modules with fresh project objects and kernel checking enabled, replayed the generic proof through `leanchecker --fresh`, rebuilt the native executable from source, and exercised the defined controls on both the original and rebuilt executables. It also audited the complete historical evidence and ran the portable GPU/native entry on one complete 56-row bucket, containing 41 P and 15 N rows.

After source compilation, the `leanchecker --fresh` invocation took 108.356 seconds; this timer excludes the source compilation and native rebuild. The original executable's six controls took 530.738 seconds; the rebuilt executable's controls took 516.224 seconds. The largest native-process RSS observed in those controls was 8,437,444,608 bytes. That is not a production-run, whole-system, or GPU-memory peak. Common finite base and successor checks run at process startup, so dividing 56 by a startup-inclusive control time is not a row-throughput estimate.

The selected-bucket execution freshly exercised source/target metadata, identities and scanning. The empty-root result and complete all-layer coverage were audited from the original evidence rather than recomputed on all rows during this test. Earlier packaging attempts exposed a missing catalogue alias and a working-directory contract error. Both were repaired, and the final test started from a separate clean extraction. Failed attempts remain recorded rather than being counted as successful partial replications.

The separate pilot archive was extracted into new paths and all three saved lanes passed fresh replay. The concurrent test took 179.228 seconds overall: approximately 88.751 seconds for `packed`, 176.809 for `game`, and 127.461 for `game-slim`. These are concurrent measurements with resource contention, not controlled speed comparisons. The underlying numerical proof had previously been constructed locally; the archive recipient test replayed its saved objects and did not rerun the packaged numerical source-construction command.

All these tests used new directories on the same physical host. They establish a working relocation and reconstruction path within that environment. They do not constitute a second complete all-layer verification or an independent-machine replication.

### 8.4. Integrity checks performed for this manuscript

The manuscript audit rechecked saved native-record relationships as described in Section 4. It also verified all manifested members of the saved-pilot archive, inspected the successful source and axiom records, and rehashed the mapped public source files and selected small delivery artefacts. The two large portable archives and complete raw data set were not rehashed again for this paper. Their completed original integrity checks remain identified by their own receipts.

Public `verify.py` commands validate provenance and recorded evidence; `prepare_sources.py` copies exact source. Neither operation executes Lean merely because its output refers to a kernel proof. The appendix supplies commands with their distinct expected results. The public evidence ZIP and the larger portable delivery are different artefacts; the smaller ZIP alone does not include the complete runtime and inputs required for a new whole-table run.

## 9. Conclusions and research outlook

The verification programme now has three substantial forms of evidence. The historical game result has complete native checking tied to a kernel-proved whole-input implication. Selected concrete game and numerical results have durable standard-axiom proofs and fresh replay. The associated delivery has a tested same-host path for reconstructing sources, exercising native controls and replaying saved proofs, with the complete historical inputs retained in a separate local archive.

The strongest whole-game claim is a complete computer-assisted verification with explicit execution assumptions. The strongest strict-kernel claims concern their specified nonempty strategies and numerical components. The latter do not yet compose into a saved actual empty-position proof. This is the remaining research objective, not an omitted percentage of a single uniform task.

The next priorities follow directly from the unresolved interfaces:

1. **Close one complete packed game block.** Combine actual local SAFE facts, complete addresses, justified child labels and the saved numerical equations, and derive original-game strategies in a replayable module.
2. **Instantiate and share the local finite certificates.** Demonstrate complete coverage and bindings, retain the required proof fields, and measure their construction and replay costs on representative inputs.
3. **Make block proofs persist and compose.** Bind each saved certificate to its input instance, preserve its dependencies across processes, and combine complete ranges and layers without replacing proof objects with log entries.
4. **Measure complete representative proof workloads.** Include preparation, generic imports, proof construction, serialisation, saved replay and final composition. Investigate the actual scheduling and memory limits before assigning a full-kernel completion bound.
5. **Broaden independent checking.** Repeat the portable controls and then the full native execution on another machine, review the remaining trusted bookkeeping, and consider independent proof checkers where compatible with the exact logic and artefacts.

A new full native replication and a pure-kernel opening proof would strengthen different parts of the assurance argument. Both remain useful directions. The reported version preserves completed results and failed attempts while leaving further formalisation, compression and independent review open. It makes no permanent commitment to terminate the research programme or to finish it within an unmeasured deadline.

## Acknowledgements and research integrity

The author thanks the Bilibili creator **零之审判者** for the originating question in *呆饼问题* ([零之审判者, 2026](https://www.bilibili.com/opus/1246853448736964611)). The creator, title and year follow the author's supplied origin record; the post is not used as evidence for the mathematical results or quoted here. The project-specific investigation was developed independently of other participants' or competitors' conclusions, proof artefacts and computational outputs. Established verification methods are attributed to their sources.

The separate AI review is identified by the claims and limits of its own report. It is not represented as external human peer review. Empirical measurements are reported at their actual scopes, failures are retained, and incomplete certificates do not count as proofs. Source and receipt identities in Appendix B provide the audit trail for the project-specific claims.

## AI contribution declaration

**OpenAI's GPT 6.1 Sol model provided very substantial assistance to this research.** Its contribution included analysis of verification methods and formal proof obligations, evidence and source auditing, interpretation of computational records, reproducibility analysis, and the preparation and revision of this manuscript. The assistance was extensive and materially shaped the research presentation and its assurance analysis; it was not confined to language editing.

The author, **feierbuqiu**, retains authorship and responsibility for the final statements, references and publication decisions. AI-generated text, code, proofs and reviews are assessed through the identified source, execution and checking evidence. An AI's endorsement does not supply a missing proof or establish a numerical confidence level. Earlier reports acknowledge their own AI contributions; this declaration records the substantial GPT 6.1 Sol contribution to the work reported here.

## References

Boutin, S. (1997). Using reflection to build efficient and certified decision procedures. In M. Abadi & T. Ito (Eds.), *Theoretical aspects of computer software* (Lecture Notes in Computer Science, Vol. 1281, pp. 515–529). Springer. [https://doi.org/10.1007/BFb0014565](https://doi.org/10.1007/BFb0014565)

Breitner, J. (2026). *Native.lean* (Lean 4.33.1) [Computer software]. GitHub. [https://github.com/leanprover/lean4/blob/v4.33.1/src/Lean/Meta/Native.lean](https://github.com/leanprover/lean4/blob/v4.33.1/src/Lean/Meta/Native.lean)

de Moura, L., & Ullrich, S. (2021). The Lean 4 theorem prover and programming language. In A. Platzer & G. Sutcliffe (Eds.), *Automated deduction—CADE 28* (Lecture Notes in Computer Science, Vol. 12699, pp. 625–635). Springer. [https://doi.org/10.1007/978-3-030-79876-5_37](https://doi.org/10.1007/978-3-030-79876-5_37)

feierbuqiu. (2026a). *Complete V17 native verification* [Research software and validation records]. GitHub. [https://github.com/feierbuqiu/mahjong-achievement-game/blob/e75911f700d4e5e1b39df53273e9dde698bf4901/research/2026-10-19-v17/README.md](https://github.com/feierbuqiu/mahjong-achievement-game/blob/e75911f700d4e5e1b39df53273e9dde698bf4901/research/2026-10-19-v17/README.md)

feierbuqiu. (2026b). *Lean verification of the Mahjong achievement game: Strategy certificates, enumeration, and retrograde models* [Supplementary research paper]. GitHub. [https://github.com/feierbuqiu/mahjong-achievement-game/blob/v1.0.0/papers/lean-verification/manuscript.md](https://github.com/feierbuqiu/mahjong-achievement-game/blob/v1.0.0/papers/lean-verification/manuscript.md)

feierbuqiu. (2026c). *Mahjong achievement on a shared table: A computational second-player win and partial Lean certification* [Research report]. GitHub. [https://github.com/feierbuqiu/mahjong-achievement-game/blob/v1.0.0/papers/manuscript.md](https://github.com/feierbuqiu/mahjong-achievement-game/blob/v1.0.0/papers/manuscript.md)

Morrison, K., & Ullrich, S. (2026). *LeanChecker.lean* (Lean 4.33.1) [Computer software]. GitHub. [https://github.com/leanprover/lean4/blob/v4.33.1/src/LeanChecker.lean](https://github.com/leanprover/lean4/blob/v4.33.1/src/LeanChecker.lean)

Necula, G. C. (1997). Proof-carrying code. In *Proceedings of the 24th ACM SIGPLAN-SIGACT symposium on Principles of programming languages* (pp. 106–119). Association for Computing Machinery. [https://doi.org/10.1145/263699.263712](https://doi.org/10.1145/263699.263712)

Pollack, R. (1997). How to believe a machine-checked proof. *BRICS Report Series, 4*(18). [https://doi.org/10.7146/brics.v4i18.18945](https://doi.org/10.7146/brics.v4i18.18945)

Validating a Lean proof. (n.d.). In *The Lean language reference*. Retrieved October 19, 2026, from [https://lean-lang.org/doc/reference/latest/ValidatingProofs/](https://lean-lang.org/doc/reference/latest/ValidatingProofs/)

零之审判者. (2026). *呆饼问题* [Bilibili post]. Bilibili. [https://www.bilibili.com/opus/1246853448736964611](https://www.bilibili.com/opus/1246853448736964611)

## Appendix A. Exact formal interfaces and concrete game targets

### A.1. The whole-input implication

The following type is reproduced from `Mahjong.FastWholeInputV17`, with its namespace context retained. It exposes the actual dependent inputs and all six acceptance hypotheses.

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

The prepared frame objects carry checked finite preparation fields. Removing their construction obligations or replacing the six equations with file names would change the theorem's meaning. The raw reference route, `Mahjong.FiniteWholeInputV17.accepted_sound`, instead takes its finite `Inputs` and a proof that `accepted i = true`. Its existence does not establish that evaluating the actual global instance by kernel reduction is practical.

### A.2. The three named physical-game conclusions

The declarations in Table A1 are under `Mahjong.PilotActualGameV18`. Their literal states use the count order `1m..9m, 1p..9p, 1s..9s, East, South, West, North, White, Green, Red`. Each contains 32 tiles. The full eleven-node trace includes additional proved nodes.

**Table A1. Closed original-game pilot statements.**

| Declaration | Literal state | Conclusion |
|---|---|---|
| `actual_p50_second_player_wins` | `1101101011101101101101101104441100` | `SecondPlayerWins Step Win (state node2)` |
| `actual_p55_second_player_wins` | `1101101101101101101101101104441100` | `SecondPlayerWins Step Win (state node3)` |
| `actual_n35_first_player_wins` | `1101101011101101011101101104441100` | `WinningStrategy Step Win (state node1)` |

These targets have no unproved acceptance hypotheses. They certify the displayed positions, not an arbitrary position with 32 tiles and not forced reachability from the empty table.

### A.3. The numerical certificate's exact role

`Mahjong.FreshPackedEvidenceV19.pn` conjoins `checks = true` for blocks B00 through B27. Each block's check expresses the two concrete bit-set equations in Equation (5). Imported layout and arbitrary-input equivalence theorems justify the numerical transformations used to establish these equations. Their hypotheses and the actual generated constants should be read alongside the final conjunction.

The missing semantic connection is not an axiom that the final P bit is correct. It is the construction of the actual local SAFE, complete successor-address and target-strategy facts needed to interpret the numerical channel union as the original game relation. The generic local-layer closing theorem describes how such accepted finite data would yield an empty-game strategy, but the required complete actual instance has not yet been constructed.

## Appendix B. Evidence index and selected identities

Paths in Table B1 identify retained research artefacts relative to this manuscript. This working repository edition maps them through its evidence catalogue while retaining original identities; no accompanying release has yet been created. Dated audit memos preserve their observation scopes; they do not define a permanently current repository version.

**Table B1. Primary project evidence.**

| ID | Record | Use |
|---|---|---|
| T01 | [September report](../manuscript.md) and [September supplement](../lean-verification/manuscript.md) | Previous claims and comparison baseline |
| T02 | [V17 proof status](../../research/2026-10-18-kernel/evidence/v17/status.json), [V17 explanation (availability)](evidence-catalogue.md#source-r005), and [formal audit](kernel_evidence.md) | Exact theorem, selected axiom reports, dependencies and replay |
| T03 | [Native final record](../../research/2026-10-19-v17/evidence/final.json), [runtime binding](../../research/2026-10-19-v17/evidence/runtime.json), and [native evidence audit](native_evidence.md) | Completed run, custody, performance and execution assumptions |
| T04 | [Separate AI review](../../research/2026-10-19-v17/review/INDEPENDENT_REVIEW.md) | Reviewer-reported inspection and sampled input checks |
| T05 | [V18 pilot status](../../research/2026-10-18-kernel/evidence/v18/status.json) and [pilot explanation (availability)](evidence-catalogue.md#source-r014) | Original-game and hot-checker persistence pilots |
| T06 | [Formal audit, including V19 source and acceptance catalogue](kernel_evidence.md) | General compaction/local-certificate theorems and scoped component experiments |
| T07 | [Completed packed report](evidence/packed/report.json) and [certificate manifest](evidence/packed/certificate-manifest.json) | Fixed numerical sample, saved proofs and replay |
| T08 | [Physical-game report](evidence/game/report.json) and [slim-foundation report](evidence/game/slim-report.json) | Proof organisation experiments and exact retained measurements |
| T09 | [Final portable cold test](evidence/delivery/cold-test.json), [delivery progress explanation](evidence/delivery/progress.md), and [portability notes](evidence/delivery/portability.md) | Source/native reconstruction, selected-bucket controls, platform limits and delivery scope |
| T10 | [Extracted pilot replay report](evidence/delivery/kernel-pilots.json) | Three isolated saved-proof replay lanes |
| T11 | [Packed profiling report](evidence/packed/profile.json) | Component-only cost model |
| T12 | [Saved-record audit output](native_record_audit.json), [audit script](native_record_audit.py), [reproduction audit](reproducibility_evidence.md), and [small identity-check receipt](reproducibility_read_only_receipt.json) | Additional read-only checks for this manuscript |

The saved-record audit read and hash-checked 38,323 referenced JSON records. It found zero discrepancies in the audited ledger chain, frame/result bindings, exact cover, and source/target identities. The kernel audit rehashed the 145 named saved V17 modules and verified the pilot archive's 1,679 manifested payload members. These operations do not add new checked game rows or constitute new proof construction.

**Table B2. Selected SHA-256 identities. Large-archive identities are tied to the delivery receipts; the pilot archive was additionally rehashed during this manuscript audit.**

| Artefact | SHA-256 |
|---|---|
| Original V17 `FINAL.json` | `413ced59dcfcc2825f6b17503e8690f895b6d9f0219ddb2eb4ce43cf992c957e` |
| Original native ELF | `775e05d2601e30847b14b017cb542ea23a8b629d8ebd403aa07bd5942b78f667` |
| `FastWholeInputV17.lean` | `0e1108a2b0433b83f693e0648ac45448455abf6df222b53a835925c2c49ef08d` |
| `packed_05/REPORT.json` | `57043889402740d65d9cf4e21e589d39bcb66ac46b2a1c6bd905fe34b884b721` |
| `mahjong_v17_core.tar.zst` | `45673cf14ffedd3a85367f29508ad7587ef370a90aace2ec2f4e00c82a38c24e` |
| `mahjong_v17_full_inputs.tar.zst` | `afa51a9e7202e2e2ae5381534b5d93c64bed6e155c9bd39306ee621d53bd933e` |
| `mahjong_kernel_pilots.tar.zst` | `e4bbdc9c00f1c3c40434f8d00893ca347a69519fda25772712533d141129d5dc` |
| Public saved-native-evidence ZIP | `5e68d6382c6e68fd525cd52defdb1969007aaaeddd24d5fe8afabc299057bdc4` |

The full input archive's 100,615,834,170 expanded payload bytes and the core's approximately 5.02 GB payload are not complete disk-space budgets for keeping archives, outputs and filesystem metadata. The pilot certificate's 134,862,920-byte total includes project proof-object companions; the smaller physical-game totals use a different manifest scope. None is claimed to be a minimal certificate-size bound.

## Appendix C. Reproduction procedures

### C.1. Inspect public source and saved native records

From the version of the repository accompanying the article, the recorded public tools support:

```sh
python3 research/2026-10-19-v17/verify.py
python3 research/2026-10-19-v17/prepare_sources.py --output build/v17-source
python3 research/2026-10-19-v17/verify.py --archive /path/to/mahjong-v17-native-evidence-20261019.zip
```

Replace the example archive path with the downloaded asset's actual location. The source output directory must be new. Expected statuses are respectively `PASS_V17_NATIVE_PUBLICATION`, `ASSEMBLED_EXACT_SOURCE_ONLY`, and `PASS_SAVED_NATIVE_EVIDENCE_GRAPH`. These are provenance, source-assembly and saved-record operations. They do not execute Lean or re-evaluate the game rows. The historical evidence asset and source mapping are cited in feierbuqiu (2026a); the article-associated manifest determines any later distribution mapping.

The published source map contains 148 source files, including the worker, native entry and replay root. Its reachable source closure and its historical imported-module count differ. The portable build adds a reproduction audit root and compiles 149 sources. These counts describe source and replay scopes; they are not counts of separately proved positions.

### C.2. Rebuild the generic proof and exercise the native controls

Obtain the delivery members specified by the article's manifest and check their identities against `SHA256SUMS`. From that delivery directory:

```sh
python3 unpack.py mahjong_v17_core.tar.zst --output /var/tmp/mahjong-clean
cd /var/tmp/mahjong-clean/mahjong_v17_repro
python3 verify.py integrity
python3 reproduce.py cold --native --output /var/tmp/mahjong-native-build-001 --jobs 4
python3 verify.py evidence
```

The tested cold command combines source compilation, fresh kernel replay, native reconstruction and small controls. Its expected success is `PASS_REQUESTED_SMALL_REPRODUCTION`. The integrity command reports `PASS_BUNDLE_INTEGRITY`; the evidence command reports `PASS_ORIGINAL_EXECUTION_EVIDENCE`, with zero historical game rows recomputed by that evidence audit. Use a new output path for each cold attempt.

The exact pinned toolchain is Lean 4.33.1 for Linux x86_64. Integrity and evidence tools use Python's standard library; extracting Zstandard archives requires the documented Python or system decompression support. A CPU-only cold control run needs no GPU and does not need the full global input archive. A standalone source-only mode, `reproduce.py compile`, is also provided; the documented final recipient experiment exercised the larger cold path rather than measuring that standalone command as a separate experiment.

### C.3. Replay saved pure-kernel pilots

From the delivery directory, extract the optional pilot archive and enter its root:

```sh
python3 unpack.py mahjong_kernel_pilots.tar.zst --output /var/tmp/mahjong-pilots
cd /var/tmp/mahjong-pilots/mahjong_kernel_pilots
python3 verify_kernel.py integrity
python3 verify_kernel.py replay --lane packed --toolchain /var/tmp/mahjong-clean/mahjong_v17_repro/runtime/lean-4.33.1-linux --output /var/tmp/packed-new
python3 verify_kernel.py replay --lane game --toolchain /var/tmp/mahjong-clean/mahjong_v17_repro/runtime/lean-4.33.1-linux --output /var/tmp/game-new
python3 verify_kernel.py replay --lane game-slim --toolchain /var/tmp/mahjong-clean/mahjong_v17_repro/runtime/lean-4.33.1-linux --output /var/tmp/game-slim-new
```

Expected statuses are `PASS_KERNEL_PILOT_BUNDLE_INTEGRITY` and `PASS_STANDARD_FRESH_KERNEL_REPLAY`. Each replay uses an isolated lane and a new output directory. A timeout is incomplete verification; it is not a successful replay or a refutation of the proposition. The wrapper replays saved objects rather than rebuilding them and does not independently print a fresh complete axiom inventory, so the source and target-dependency audits remain relevant.

The packed lane targets `Mahjong.FreshPackedEvidenceV19`; the other two target `Mahjong.PilotActualGameV18`. Do not combine the game and slim lane search paths: their foundation imports differ. Saved-proof replay needs neither global inputs, GPU, game native worker, nor an expression-building plugin.

The archive additionally supplies:

```sh
python3 tools/run_packed.py --root frozen_workspace --toolchain /var/tmp/mahjong-clean/mahjong_v17_repro/runtime/lean-4.33.1-linux --output /var/tmp/packed-rebuilt-new
```

This command is for reconstructing the packed proof from the supplied sample source and data. Its route was documented and the underlying local construction succeeded, but the extracted-archive recipient test did not execute this command. Its existence must not be reported as a completed packaged-source rebuild.

### C.4. Input integrity and a future complete native replication

The full-input archive can be extracted into the same clean parent directory. From the resulting core root, `python3 verify.py full-inputs` hashes all 100,615,834,170 input bytes and reports `PASS_FULL_INPUT_HASHES_ONLY`; it recomputes no game rows. This is substantial I/O work rather than proof evaluation.

The optional portable native/GPU entry defaults to the selected small bucket. Its explicitly requested all-layer mode requires the complete inputs, the documented NVIDIA environment, an adequate open-file limit, a fresh matching control report, and new output and ledger locations. More than 23,000 lock handles may be used by the nested custody scopes. The portability notes explain that this new entry does not implement automatic resume.

Only the selected 56-row entry has a completed recipient-path execution at this cut-off. A second all-layer run, a second physical machine and an actual whole-input pure-kernel certificate are not implied by any of the commands above. Each would need its own completed evidence and scope statement.
