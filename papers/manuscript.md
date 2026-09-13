# Mahjong Achievement on a Shared Table: A Computational Second-Player Win and Partial Lean Certification

**feierbuqiu**

*Research report · 13 September 2026 · English primary edition*

> Publication edition: formulas use GitHub math syntax. The [evidence catalogue](evidence/README.md) distinguishes downloadable public copies from retained historical sources; [provenance](provenance.json) records the transformations. The latest [portable Lean proofs](../formal/README.md) accompany this paper on `main`.

## Abstract

We study a finite, impartial achievement game played with the 136 tiles of a standard Mahjong set. Players alternately select an available tile and add it to one shared, cumulative table. The player whose addition first makes the table contain a legal fourteen-tile winning submultiset wins. The permitted targets are four melds and a pair, seven pairs of distinct kinds, and thirteen orphans. We present the complete research record at the current milestone: structural proofs, exact local classifications, a completed global computation, and a growing collection of Lean-certified strategies. The central reduction replaces achievement by normal play on SAFE positions, which contain neither a winning target nor a target completable in one move. We prove that nonwinning tables have at most 37 tiles and SAFE tables at most 34, while demonstrating why these bounds do not determine the winner by parity. Exact symmetry-aware enumeration yields 778,532,864,302 SAFE orbits. A layered Boolean retrograde computation classifies the empty table as P and all six opening orbits as N, giving a computational second-player win. A reverse algorithm checks every stored outcome with zero disagreements, although both algorithms share their foundational rule implementation and index. Separately, Lean verifies the rules, the SAFE reduction, certificate soundness, and concrete nonempty strategies, including the twelve-tile position `99m 6789p 456888s`. Its certificate contains 757 reusable P rows and covers 25,510 legal first actions. No closed Lean theorem for the empty table is yet available. We distinguish mathematical proofs, computation-dependent results, kernel-certified results, and unfinished proof work, and provide evidence locations, methodological failures, reproducibility instructions, and specific directions for completing the formal certification.

**Keywords:** impartial combinatorial games; Mahjong; achievement games; retrograde analysis; symmetry reduction; computer-assisted proof; Lean; reproducibility

## 1. Introduction

Ordinary Mahjong combines private information, random draws, discards, and scoring conventions. The game considered here removes those mechanisms. Both players choose deterministically from the same remaining stock and contribute to the same visible table. A player can exploit every tile placed by either participant. Consequently, familiar reasoning about improving a private hand does not describe the strategic problem.

The question is simple to state: **from an empty table, which player can force the first legal fourteen-tile winning subset?** A useful answer must preserve the original move choices and all three winning forms. It must also explain how a proposed strategy deals with every opposing move, including additional tile kinds and fourth copies.

The initial problem was suggested by the Bilibili creator [零之审判者 (2026)](https://www.bilibili.com/opus/1246853448736964611), whose contribution is acknowledged below. This report develops the resulting investigation independently of other participants' conclusions or computational outputs. General mathematical and verification methods are attributed to the relevant literature. The report does not claim that the underlying ideas of impartial games, retrograde analysis, symmetry enumeration, or proof certificates originate here.

The research proceeded through three substantially different stages. First, structural analysis established a faithful reduction and useful local theorems, while eliminating several plausible shortcuts. Second, regional solvers classified increasingly shallow positions and supplied independent historical checks. Finally, compact global indexing made exhaustive retrograde computation practical on the measured local machine. A separate formalisation programme is now replacing trust in selected computed outcomes with explicit proofs checked by Lean's kernel.

The distinction between these last two achievements is central. **The game has a completed computational solution, reporting a second-player win. Its opening has not yet received a complete Lean certification.** Earlier migration documents correctly recorded UNKNOWN at their own cut-off. They predate the global computation and are preserved unchanged. Reading them as the current result would omit a major completed achievement; treating the later computation as an already completed Lean theorem would overstate another.

### 1.1. Contributions and evidence conventions

This report makes six contributions: a precise model and achievement-to-SAFE reduction; structural bounds and endgame classifications; a documented sequence of local computational results; a lossless index and complete global P/N table; a checked interface that returns moves in the user's actual tile coordinates; and a formal certificate pipeline with certified nonempty roots.

We use the following evidence descriptions consistently.

| Description | What it establishes | Remaining basis of trust |
|---|---|---|
| **Mathematical proof** | A stated result follows from the rules by the argument provided | Human scrutiny of that argument |
| **Exact computational result** | Exhaustive evaluation of the specified finite domain completed | Rules, enumeration, implementation, stored data, and execution |
| **Computer-assisted theorem** | A mathematical implication is instantiated by completed finite computation | Both the proof and the specific computational premises |
| **Lean-certified theorem** | A closed theorem was checked in the identified successful dependency chain | Lean's kernel, accepted foundational axioms, and execution environment |
| **Cross-check or audit** | The explicitly described comparison or integrity check passed | Its stated coverage and degree of implementation independence |
| **Conjecture or open proof task** | A statement or certification objective remains unproved at the stated level | No classification is inferred from an incomplete run |

P and N always refer to the **player about to move**. P means that player loses under optimal play; N means that player wins. UNKNOWN is an epistemic status, never a third mathematical outcome. A candidate graph labelled `PARTIAL`, or a process stopped by a budget, supplies no proof of its root merely by existing. Local evidence identifiers E01–E18 are resolved in Appendix E. They are pointers into this research record, distinct from the external APA-style references.

## 2. Rules, definitions, and mathematical foundations

### 2.1. State space and legal play

Let

```math
T=\{1m,\ldots,9m,1p,\ldots,9p,1s,\ldots,9s,H_1,\ldots,H_7\}.
```

The letters $`m,p,s`$ denote the three numerical suits; $`H_i`$ denote the seven honours. A valid table is a function $`x:T\to\{0,1,2,3,4\}`$. Write $`|x|=\sum_{t\in T}x_t`$, and write $`u\le x`$ for coordinatewise multiset inclusion. A legal move selects $`t`$ with $`x_t<4`$ and replaces $`x`$ by $`x+e_t`$. The identity of the physical copy is strategically irrelevant; its kind and remaining multiplicity are sufficient.

The modelling assumptions are: two players, alternating turns, complete public information, unrestricted selection of any available tile kind, no removal, no random draw, and immediate victory on first achievement. They are the rules of this particular problem, not claims about every Mahjong variant. No scoring threshold, declared meld, kong bonus, riichi, or additional hand restriction is imposed.

A meld is either a triplet of one kind or a numerical sequence $`(r,r+1,r+2)`$ in one suit, for $`1\le r\le7`$. Let $`\mathcal W`$ be the valid fourteen-tile multisets of the following forms:

1. Four melds and one pair, with the combined target respecting the four-copy capacity.
2. Two copies of each of seven **distinct** tile kinds.
3. One copy of each of the thirteen terminals and honours, together with one extra copy of one of those thirteen kinds.

A four-copy kind contributes only one kind towards seven pairs. A formal meld decomposition that requires five or more copies of a kind is invalid. Winning is the upward-closed predicate

```math
\operatorname{Win}(x)\iff\exists w\in\mathcal W\;(w\le x).
\tag{1}
```

Thus a table may have more than fourteen tiles when the game ends. The unused tiles do not invalidate a winning subset. The records store the 34 coordinates in the order displayed above, with honours ordered East, South, West, North, White, Green, Red. Permuting honour names preserves these rules.

The game is finite because every move increases $`|x|`$. There is no nonwinning stock-exhaustion draw: the full stock contains winning targets. The sharper bounds below considerably reduce the relevant state space.

### 2.2. SAFE positions and the lower shadow

Define

```math
\operatorname{Safe}(x)\iff
\neg\operatorname{Win}(x)\ \land\
\forall t\,[x_t<4\Rightarrow\neg\operatorname{Win}(x+e_t)].
\tag{2}
```

Let $`\mathcal K`$ be the valid SAFE tables. A position with at most twelve tiles is automatically SAFE. The thirteen-tile lower shadow of the winning family is

```math
\partial\mathcal W=\{w-e_t:w\in\mathcal W,\ w_t>0\}.
```

**Proposition 1 (forbidden-submultiset characterisation; mathematical proof).** A valid table $`x`$ is SAFE if and only if it contains no member of $`\partial\mathcal W`$.

*Proof.* If $`x`$ is already winning, it contains a winning target and hence a member of its lower shadow. If a legal addition produces a target, either the target was present already or deleting the added tile gives a shadow member contained in $`x`$. Conversely, suppose $`w-e_t\le x`$. If $`w\le x`$, the table is winning. Otherwise, all coordinates except $`t`$ already satisfy the target, while $`x_t=w_t-1<4`$. The missing tile can therefore be added legally, producing a win. ∎

In particular, $`\mathcal K`$ is downward closed within valid tables. This fact later permits a SAFE proof for a larger table to certify any actual submultiset, provided the inclusion is checked. On labelled physical copies, the same construction gives a hypergraph avoidance game whose forbidden edges are thirteen-element near-winning targets. This connection places the model within the achievement and avoidance framework studied by [Sieben (2023)](https://doi.org/10.37236/11665).

### 2.3. The outcome-preserving reduction

The SAFE normal-play game permits exactly the additions $`x\to x+e_t`$ whose destinations remain in $`\mathcal K`$. A player with no such move loses.

**Theorem 2 (SAFE reduction; mathematical proof and Lean formalisation).** At every valid SAFE table, the original achievement game and the SAFE normal-play game have the same P/N outcome. A winning SAFE strategy can be converted into a strategy that actually achieves a winning subset in the original game.

*Proof.* From a SAFE source, the mover cannot win immediately. An addition that leaves SAFE produces a nonwinning table with an immediate winning move for the opponent. Such an addition is losing for its mover. All other additions are precisely the SAFE-game moves. Induction on the remaining stock therefore gives the same P/N recurrence after these losing alternatives are removed. If no SAFE move exists, every original move gives the opponent an immediate win. The stock cannot be exhausted at a nonwinning table. To implement a winning strategy in the original game, follow the SAFE response whenever the opponent stays SAFE and take an immediate win whenever the opponent leaves it. Finiteness guarantees eventual achievement. ∎

This is a P/N and strategy statement. We do not assign the original immediate-achievement convention the same full Sprague–Grundy values merely because its SAFE reduction has those values. The Lean development explicitly connects the normal-play outcome to a strategy ending in an actual winning hand; an abstract no-move convention alone would leave a semantic gap (E09).

For SAFE states define $`g(x)=\operatorname{mex}\{g(y):x\to y\text{ is SAFE}\}`$. The standard impartial normal-play theory identifies P with $`g=0`$ and N with $`g>0`$; see [Sprague (1935)](https://www.jstage.jst.go.jp/article/tmj1911/41/0/41_0_438/_article) and [Siegel (2013)](https://bookstore.ams.org/view?ProductCode=GSM%2F146). An N outcome does not specify the positive integer $`g`$.

### 2.4. Legal symmetries

The group used throughout the computation is

```math
G=S_7\times(C_2^3\rtimes S_3),\qquad |G|=241,920.
\tag{3}
```

Its generators permute the seven honours, permute the three numerical suits, and independently reflect each suit by $`r\mapsto10-r`$. Each generator preserves stock limits, legal additions, and all three winning forms; consequently it preserves SAFE and P/N. The corresponding generator actions and their finite compositions are formalised in Lean.

Arbitrary permutations of ranks within a suit are not symmetries: they generally destroy sequences. Nor is the number of orbits obtained by dividing the number of states by $`|G|`$; stabilisers vary. These distinctions affect both the mathematical classifications and the global index.

## 3. Structural results and failed shortcuts

### 3.1. Exact extremal bounds

**Theorem 3 (largest nonwinning and SAFE tables; mathematical proof, independently corroborated by enumeration).**

```math
\max_{\neg\operatorname{Win}(x)}|x|=37,
\qquad
\max_{x\in\mathcal K}|x|=34.
\tag{4}
```

Appendix A gives the full counting argument, including the capacity checks when a missing sequence tile is added. These are mathematical proofs in the research record; the current successful Lean certificate chain does not formalise the two global bounds.

Both lower bounds have concrete witnesses. Select ranks $`1,2,4,5,7,8`$ once in each suit. For the nonwinning 37-tile table, add four copies of four distinct honours and one copy of each remaining honour. For the SAFE 34-tile table, instead add four copies of three distinct honours and one copy of each of the remaining four honours. Neither numerical support contains a sequence. The first construction has four honour triplets but no disjoint pair after taking them; the second has three triplets and cannot gain both a fourth meld and a pair in one move. Seven pairs and thirteen orphans do not create exceptions.

**Corollary 3.1.** If neither player declines an available immediate win, play ends by move 36, and hence optimal play does so. Under unrestricted inefficient play, the nonwinning bound gives an end by move 38.

The first statement follows because play can remain SAFE for at most 34 additions; after the first departure from SAFE, the next player can win. It does not say every optimal game has length 36, nor does it determine the winner independently of a strategy.

### 3.2. Maximal SAFE positions have mixed parity

The table

```math
S_{13}=H^4(3m)^4(5m)^4(4m)
\tag{5}
```

is SAFE and has no SAFE extension (E01–E02). Its response can be checked directly. If the opponent adds another $`4m`$, add a third $`4m`$ and use a $`345m`$ sequence, triplets of $`3m,5m,H`$, and the remaining $`4m`$ pair. If the opponent adds a new kind $`u`$, add the same kind and use $`345m`$, those three triplets, and $`uu`$. The saturated kinds cannot be added. Thus this odd thirteen-tile table is a P terminal of the SAFE game. The 34-tile witness in Theorem 3 is an even P terminal.

The SAFE family is therefore not a matroid independence system on labelled copies: it has maximal independent sets of different sizes. Its maximum cardinality does not imply uniform terminal parity. The result rules out a direct matroid augmentation argument, without ruling out useful graph or hypergraph descriptions of particular endgames.

The minimum size of a maximal SAFE table is exactly twelve. Every table of at most eleven tiles can be extended to a SAFE table, whereas `123456789m 123p` already contains four disjoint sequences at size twelve. Any added kind can be copied to supply a pair while retaining those sequences, within the four-copy bound. Hence that twelve-tile table has no SAFE extension. Minimum maximal size, maximum SAFE size, and the parity of a selected maximal table describe different properties.

### 3.3. Fourth honours as independent moves

No valid fourteen-tile winning target uses four copies of an honour: ordinary hands use at most an honour triplet, and the other forms use at most a pair. Consequently changing an honour count from three to four does not change the current Win or SAFE predicates. More strongly, the unused fourth copy remains a separate optional one-move component throughout every continuation on other coordinates.

**Theorem 4 (honour-pass identity; mathematical proof).** For a SAFE state $`x`$, let $`B`$ replace all its honour counts equal to three by four, and let $`p`$ be the number of replaced coordinates. Then

```math
g(x)=g(B)\mathbin{\operatorname{xor}}(p\bmod2).
\tag{6}
```

*Proof.* The future game on all other coordinates is unchanged by any of these replacements. Each unplayed fourth honour is an independent component with one legal move and then none. The game is the disjunctive sum of the game at $`B`$ and $`p`$ copies of the one-move game. Its Grundy value follows by the sum rule. ∎

An earlier Mathlib-based Lean development proves the relevant honour-multiplicity and Win/SAFE invariance lemmas. The full disjunctive-sum argument and equation (6) have not been certified in the current Lean chain. Predicate invariance and the game-theoretic identity have different formalisation statuses (E10).

The same treatment is false for numerical fourth copies. For example, `111222333444m` is SAFE because it has twelve tiles. Adding a fourth $`1m`$ allows the opponent to add $`3m`$, producing

```math
111m+333m+444m+123m+22m.
```

That numerical upgrade leaves SAFE. Every numerical $`3\to4`$ transition is therefore retained as a real move.

Nor can one XOR a Boolean N label with pass parity. If $`g(B)=2`$, then $`g(x)=3`$ for one remaining pass; both positions are N. Historical solvers consequently retained masks for $`\{0,1,\ge2\}`$, or separate physical Boolean channels. The category $`\ge2`$ is not the exact value 2.

### 3.4. Present hand statistics do not determine future play

Local statistics describing obtainable melds, pairs, or current missing tiles are useful for deciding Win and SAFE. They do not automatically define a game quotient. The states

```math
X=789999s\;666777z,\qquad
Y=567999s\;666777z
\tag{7}
```

have the same recorded current profile, but $`X`$ is P and $`Y`$ is N. Here digits in $`z`$ name distinct honour kinds. The retained direct analysis finds two independent SAFE moves from the first endgame and three from the second (E02). This is a concrete counterexample to equating future games from a static winning profile.

A valid future quotient was instead built recursively from a local state's current colour and the complete set of successor quotient classes. Acyclicity permits the construction from saturated states backwards. Equal colours and equal successor-class sets support induction on future play; equal colours alone do not. The later global index uses statistics to organise exact members, while retaining those members individually.

### 3.5. Other rejected approaches

Matching the opponent's tile, or maintaining reflected rank pairs, is useful in some local response arguments but is not a global strategy merely because it looks symmetric. A reply can consume the last available copy, leave SAFE, or allow a sequence using the supposed invariant. Likewise, inclusion of a P subtable does not make a larger table P: P/N is not monotone under tile addition. Only SAFE itself has the downward-closure property used in certificate construction.

There is a stronger mathematical exclusion of **every response rule fixed in advance as one permutation from $`G`$**. An involution fixes some suit $`c`$ and some honour $`H`$; within that suit it preserves $`\{4c,6c\}`$ and fixes $`5c`$. Against the prescribed replies, the first player can build $`H^4(4c)^4(6c)^4`$ in twelve moves and then add $`5c`$. This thirteen-tile table is SAFE: every fourteen-tile extension still contains four copies of $`H`$, which no winning target can use. Whatever legal kind $`y`$ is added next, copying it wins on move fifteen with $`HHH+(4c)^3+(6c)^3+(4c,5c,6c)+yy`$. If $`y=5c`$, three copies of that kind suffice. All required copies are available, and all earlier subpositions are SAFE.

If the fixed permutation instead has a cycle of length at least three, choose a kind $`a`$ in that cycle on four consecutive first-player turns. The prescribed replies exhaust $`\pi(a)`$ while exhausting $`a`$. On move nine, adding the unused kind $`\pi^{-1}(a)`$ demands an illegal reply of $`a`$. This establishes failure before a fourteen-tile win could intervene. The exclusion covers fixed rule-symmetry responses and physical pairings that preserve such a kind map; it does not quantify over adaptive responses or arbitrary matchings of all physical tiles (E02).

The all-P guess for the 35 eight-tile two-numerical-pair orbits ultimately fails: three are N. The analogous all-P guess for three numerical pairs also fails: fourteen of its 179 orbits are N. These falsified generalisations are informative results, not unfinished proofs that should continue to be advertised as plausible conclusions.

## 4. Endgame bases and local classifications

The local work served two purposes. It supplied mathematical explanations for tractable regions and independent comparisons for the eventual global computation. A theorem about a sparse table always refers to the full 34-kind game after that table: all legal numerical and honour additions remain available.

Write $`q(x)=|\{t:x_t\ge2\}|`$, and $`T(x)=|\{t:x_t\ge3\}|`$. In expressions such as $`H222`$, the digits are multiplicities of distinct honours. Thus $`H222`$ means three honour pairs, while $`H33`$ means two honour triplets. Letters $`a,b,c`$ denote distinct numerical kinds unless a statement explicitly allows other kinds. A bare shape has no unlisted tiles.

### 4.1. Six-pair endgames

Seven distinct pair kinds immediately win. If a SAFE table has six pair kinds, it cannot also contain a singleton of a seventh kind, since duplicating that singleton would win. Its support is therefore exactly those six kinds. Legal SAFE play in this region only upgrades existing counts from two towards four, subject to ordinary-hand threats.

The retained six-pair theorem gives a complete classification by the lengths of maximal consecutive numerical runs in that support. If $`R`$ is the multiset of run lengths at least three, then the possible SAFE types are

```math
R\in\{\varnothing,[3],[4],[5],[6],[3,3]\}.
```

Writing $`\nu(x)=1`$ for N and $`0`$ for P, the classification is

```math
\nu(x)=(|x|\bmod2)\operatorname{xor}\mathbf1_{R=[3]}.
\tag{8}
```

This is a mathematical classification of the SAFE region, not a declaration that every positive Grundy value equals one. For the $`\binom{34}{6}=1,344,904`$ bare six-pair supports, the resulting count is 1,266,064 P and 78,840 N. Appendix B explains the local reduction and records its source, including the differing terminal sizes of the six support types.

### 4.2. Frozen five pair kinds

**Theorem 5 (two honour triplets and three other pairs; mathematical proof).** For any distinct honours $`H,J`$ and any three other distinct kinds $`X,Y,Z`$, the bare twelve-tile table

```math
H^3J^3X^2Y^2Z^2
\tag{9}
```

is P. The three other kinds may be numerical or honours.

Appendix B gives a constructive proof. Pair the two available fourth-honour moves; answer a pair promotion by completing another triplet and winning; and answer a SAFE new kind by copying it into an explicit six-pair P endgame. The latter step requires showing that the new support contains no numerical run. This theorem does not assert that arbitrary extra singletons can be appended to (9) while preserving P. The larger frozen-five region has its own separately justified support-mask recurrence (E03).

**Theorem 6 (two quads and three pairs; mathematical proof).** A SAFE table of the bare form $`A^4B^4C^2D^2E^2`$, with five distinct kinds, is P. The SAFE premise is essential: some numerical choices already form a winning hand or allow immediate completion. A shape alone cannot silently discharge that premise.

### 4.3. Four-meld SAFE endgames

**Proposition 7 (mathematical proof).** A SAFE table containing four disjoint melds has at most sixteen tiles.

*Proof.* Fix the twelve-tile meld union $`D`$. If an additional tile of kind $`u`$ remains and $`D_u\le2`$, then $`D+2e_u`$ is a valid ordinary target of which the table contains at least thirteen tiles. This contradicts SAFE. If $`D_u=4`$, no residual copy exists. Thus every residual tile belongs to a kind with $`D_u=3`$; there are at most four such kinds, each with at most one residual copy. ∎

The stronger statement that these concrete endgames have the observed Boolean-cube/parity structure is an exhaustive computational classification, supported by 10,573 roots and 53,487 root/subset checks. It should not be merged into the hand proof of the size bound. This distinction illustrates why a result catalogue needs evidence attached to each assertion, rather than one blanket label for a directory (E02–E03).

### 4.4. Regional results before the global computation

| Bare state or family | Result and exact scope | Original basis |
|---|---|---|
| $`H222`$, six tiles | P | Mathematical response composition with exact computed boundary premises |
| $`H33`$, six tiles | P | Complete two-honour-triplet regional computation |
| $`H23`$, five tiles | N, by adding the missing honour to reach $`H33`$ | Immediate mathematical consequence |
| $`H224`$, eight tiles | P | Completed regional computation |
| $`H223`$, seven tiles | N, by the fourth-honour move to $`H224`$ | Immediate mathematical consequence |
| $`a^2b^2H222`$, ten tiles | P for all distinct numerical $`a,b`$ | Response composition and exact adjacent-pair regional leaves |
| $`a^3b^3H22`$, ten tiles | All 35 symmetry orbits P | Complete cold-start regional classification |
| $`a^2b^2H33`$, ten tiles | P; the stronger theorem allows any two other distinct kinds | Mathematical response theorem |
| $`a^2b^2c^2H33`$, twelve tiles | P | Special case of Theorem 5 |
| $`a^3b^3H^3J^3`$ and $`a^4b^4H^2J^2`$ | P under the recorded bare-state scope | Mathematical response closures using established boundary facts |
| Same-suit $`3^34^2H^3J^2`$, ten tiles | P | Completed mixed $`q=4`$ regional computation and recurrence checks |

The table describes how the results were obtained, rather than recasting all of them as hand proofs after the global table became available. In particular, the historical proof of $`H222`$ has computational premises, and the 35 ten-tile all-P roots are not the 35 eight-tile roots discussed next.

### 4.5. Three numerical pairs with two honour pairs

The complete set of 179 bare ten-tile $`a^2b^2c^2H22`$ orbits contains **165 P and 14 N**. Its decomposition is:

| Distribution of the three numerical kinds | Orbits | P | N |
|---|---:|---:|---:|
| One suit | 44 | 32 | 12 |
| Two suits | 100 | 98 | 2 |
| Three suits | 35 | 35 | 0 |
| Total | 179 | 165 | 14 |

Representatives of the twelve one-suit N supports are

```math
\{1,2,3\},\{1,2,7\},\{1,2,9\},\{1,3,5\},\{1,4,5\},\{1,5,6\},
```
```math
\{1,6,7\},\{2,3,4\},\{2,5,6\},\{3,4,7\},\{3,5,6\},\{4,5,6\},
```

under whole-suit reflection. The two-suit exceptions have pairs at ranks 4 and 5 in one suit and a pair at rank 2 or 3 in another, interpreted under independent suit reflections. The final classification file, rather than earlier timed searches, establishes completeness (E04).

### 4.6. The shallow frontier and its eventual resolution

Let $`M=a^2b^2H22`$, an eight-tile table. There are 35 orbits. Adding a new numerical singleton $`c`$ produces a nine-tile $`S=a^2b^2cH22`$. The designated $`S`$ family contains 483 orbits. Copying $`c`$ reaches one of the known ten-tile three-pair states; this proves N whenever the copy target is P.

The initial completed composition gave 12 P and 23 UNKNOWN among the $`M`$ roots, and 442 N with 41 UNKNOWN among the $`S`$ roots. Round 9 solved shared twelve-tile boundary candidates first and propagated the results back through ten- and nine-tile responses. Its 318 newly evaluated boundary candidates comprised 109 P and 209 N; all 109 P roots passed complete physical SAFE-child checks over 2,350 edges. The round closed five more $`M`$ roots as P and six of the designated unknown $`S`$ roots as N. An independent audit checked 374 physical response rows, 143 P-response premises, and 316 inference-DAG facts for the selected response certificate (E05).

The five new eight-tile P representatives had same-suit pair supports $`\{1,9\},\{2,5\},\{2,6\},\{3,7\},\{4,6\}`$, together with two honour pairs. Combined with $`\{2,8\}`$, these established the bare reflected-pair family $`r^2(10-r)^2H^2J^2`$, $`1\le r\le4`$, as P. They did not establish a global reflection strategy.

The subsequent global database resolved the remaining cases. The current $`M`$ result is **32 P and 3 N**. The N supports are same-suit $`\{1,2\},\{1,4\},\{4,5\}`$, up to reflection and suit permutation. The original 41-element unknown $`S`$ list is now **3 P and 38 N**; together with the previous 442 N cases this gives **3 P and 480 N** for the 483-element family. The last total is arithmetic composition of those disjoint classifications. The pure-honour tables $`H22`$ and $`H24`$ are also P by the completed global computation. Appendix C identifies the exact exceptional nine-tile states.

The frontier was a useful, explicitly defined research target. Its size was never the number of nodes remaining in the entire opening game. Its historical UNKNOWN labels are retained for provenance, but no longer describe its current computational status.

### 4.7. Additional proved families and nontrivial Grundy values

A direct response strategy proves four distinct honour pairs P. An expanded even-count invariant gives **29,540,326 labelled P count vectors**, including that family. Its ordinary states have counts only 0, 2, and 4, at most two quads, and one of three support conditions: four supported kinds all honours; five supported kinds with any two numerical ranks in the same suit separated by at least three; or six supported kinds containing no numerical run. Four-honour `4433` and `4444` states complete the response family. These are labelled count vectors, not symmetry orbits, and the families overlap other results. The proof copies permitted new kinds, pairs permitted upgrades, and uses explicit winning replies in the exceptional cases (E03).

One more structured endgame has an actual disjunctive-sum description. The table $`3m\;7m\;H_1^3H_2^3H_3^3H_4^2`$ is P. Its SAFE continuation keeps these $`m`$-tiles and the honour pair fixed. The other two suits consist of singleton supports whose ranks are at pairwise distance at least three; these are Node Kayles positions on the square of a nine-vertex path. Three fourth-honour moves and three new-honour singleton moves provide six independent one-move components. Matching the two suit components and pairing the honour moves proves the stated root P. The fixed-domain description covers 107,584 labelled states, with values obtained from the interval recurrence recorded in Appendix B. This is a proved decomposition of that domain, not a decomposition of arbitrary Mahjong states.

The exact three-honour-triplet region gives $`g(H333)=0`$. Honour-pass transformations then yield P for $`H443`$ and N for $`H433`$ and $`H444`$. Separately, $`H233`$ is N because promoting its remaining pair reaches $`H333=P`$. These are full-game results. A different complete region classifies all 220 bare configurations consisting of three distinct triplets and a fourth-kind **honour pair** as N: 187 have Grundy value 1, 31 value 3, and two value 4. A numerical pair changes the conclusion; for example, $`(1m)^3(2m)^3(4m)^3(7m)^2`$ is P. This is a direct computed reason to retain distinctions among positive Grundy values.

For $`K_r=r^2H33`$, $`R_r=r^3H33`$, and $`Q_r=r^4H33`$, the completed regional matrix is:

| Numerical ranks $`r`$ | $`K_r`$, eight tiles | $`R_r`$, nine tiles | $`Q_r`$, ten tiles |
|---|---|---|---|
| 1, 2, 4, 6, 8, 9 | N | P | N |
| 3, 5, 7 | P | N | N |

The complementarity of $`K_r`$ and $`R_r`$ has a mathematical response proof using a common boundary family; the actual rank-dependent entries came from complete regional calculations. A related twelve-tile family has consecutive ranks $`a,b,c`$, two paired and one single, together with $`H_1^3H_2^2H_3^2`$. For windows 123, 234, 456, 678, and 789, all three singleton placements have Grundy zero. Window 345 gives values $`(1,4,2)`$, in order of singleton rank; window 567 gives $`(2,4,1)`$. These exceptions prevent a uniform copying argument (E04).

Finally, forcing entry to an upward-closed honour domain does not force entry to its favourable bare P root. Either player can fill the deficits of three fixed honour pairs within six of their own moves; the opponent may already have added numerical tiles, which cannot be removed. The controller and opponent also require different boundary outcomes depending on whose move achieves entry. The recorded greedy fixed-deficit policies are refuted for both players. This separates reachability of a region from the strategic quantifiers needed to win from it (E04).

## 5. Computational methodology

### 5.1. Rule evaluation and regional search

The reference implementation encodes each numerical suit and the honours in base five. Numerical Win/SAFE checks combine local information about obtainable melds, meld-plus-pair configurations, and pair-kind counts. The full decision also checks thirteen orphans. Local information is safe to use for deciding a predicate only when its sufficiency for that predicate has been established.

Early solvers used recursive search, transposition tables, proof-number variants, and specialised region evaluators. Proof-number search is an established way to direct effort towards proving a game-tree outcome; [Allis et al. (1994)](https://doi.org/10.1016/0004-3702(94)90004-3) supply the general method. This game is acyclic, although different move orders lead to the same count vector. Memoisation therefore saves repeated work without needing to preserve the order of earlier additions.

Regional decomposition followed the number $`q`$ of pair kinds and the number $`T`$ of triplet-or-quad kinds. Pair upgrades move to a higher $`T`$ region; a singleton becoming a pair exits to a higher $`q`$ region. A regional solver is exact only when every such exit is evaluated by a valid boundary procedure. Restricting attention to a convenient subset of moves would change the game.

The later $`q=4`$ implementation included no-triplet, one-triplet, and mixed two-triplet cases with at least two honour pair kinds. It retained all other 0/1 coordinates, all singleton-to-pair exits, and numerical fourth-copy moves. A specialised SAFE filter based only on already available melds was rejected after a mixed state, `1³2¹3²4¹H³J²`, showed that consuming fixed pairs can create additional sequences. The final filters use the exact recorded recurrence and boundary conditions (E06).

Storing only the information needed by a query proved useful. Separate physical P/N channels often avoided computing an unnecessary exact Grundy value. A 23,437,500-byte local projection was exhaustively compared over all 1,953,125 numerical suit codes. Differential checks covered 1,110 physical states, 5,683 edges, and 201 six-pair exits, including odd honour-pass parity and Grundy values at least two. These were targeted validation results, not universal performance guarantees.

### 5.2. Persistent evidence and resumption

The research preserves immutable delivered caches and places new executions in separate `build/` and `runs/` directories. A cache entry records a completed value, not the existence of an unfinished recursion. Interrupted stacks may be recomputed on resumption; only completed, successfully written records are reusable.

Several incompatible formats occur in the archive. `MJSG0601` stores nonempty masks for Grundy categories; `MJQ234B1` stores one physical Boolean channel; `MJDENS08` stores versioned dense regional tables. The global format introduced later, `MJGLOBAL_PN_V1`, uses the bit convention **P = 1, N = 0**, the reverse of some historical Boolean interfaces. Unknown sentinels, domain errors, masks, and physical values are never interchangeable. A key cannot be reinterpreted under a different quotient fingerprint.

Version identifiers, complete inputs, budgets, source hashes, outcomes, and separate output locations accompany resumable work. Format checks and checksums protect interpretation and file identity. They do not independently prove the minimax value of every cached state. The complete global recurrence replay and the Lean certificate checks supply different, stronger forms of evidence for their respective scopes.

### 5.3. Exact counting before evaluation

The first global contribution was an exact count, rather than a solved game. Local profiles were enumerated, reflection multiplicities were retained, and suit permutations were handled by orbit counting. Burnside's fixed-point average and the cycle-index approach provide the relevant general enumeration framework; see [Pólya (1937)](https://doi.org/10.1007/BF02546665). In this application, identical local statistics receive weights for the distinct local states they represent.

After individually quotienting numerical suits by reflection and honours by permutation, the suit-permutation count at size $`n`$ is $`(F_{1,n}+3F_{2,n}+2F_{3,n})/6`$. The three terms respectively allow independent suit codes, force two suits to use the same actual reflected code, or force all three to do so. A repeated code contributes its statistics several times but its choice weight once. Replacing it by independent members of the same statistical group would give a wrong fixed-point count.

The resulting totals are:

| Valid count vectors | Before rule symmetries | Orbits under $`G`$ | Maximum tile count |
|---|---:|---:|---:|
| Nonwinning | 19,077,162,130,853,393 | 8,970,524,587,826 | 37 |
| SAFE | 1,395,152,864,631,635 | 778,532,864,302 | 34 |

An alternative local-multiset counting formula reproduced both totals. Direct enumeration of 1,205,820 small-pool states provided an additional independent check. The largest SAFE layer is 23 tiles, with 96,268,928,092 orbits; layer 24 has 96,065,224,588. Their combined one-bit payload is 24,041,769,085 bytes, about 24.04 GB or 22.39 GiB.

At that stage, this payload was a feasibility estimate. It was not an implemented memory bound and did not include an index or successor processing. The critical next step was to replace a per-state key with a compact, verifiable rank.

### 5.4. Lossless global indexing

The implemented index retains 131,676 actual reflected numerical suit codes, organised into 1,104 statistical groups. It also retains 184 actual canonical honour multisets. The groups describe properties needed for SAFE filtering and tile counts; the individual numerical member identifiers remain part of the state identity. This resolves the static-profile objection of Section 3.4.

Sort the three suits by their group and within-group member identifiers. For a compatible triple of groups with member counts $`a,b,c`$, its block size is

```math
abc,\quad \binom{a+1}{2}c,\quad a\binom{b+1}{2},
\quad\text{or}\quad\binom{a+2}{3},
\tag{10}
```

according as all groups differ, the first two agree, the last two agree, or all three agree. Repetition is allowed because different suits may have the same local code. With indices $`0\le u\le v\le w`$, the repeated-group colex ranks are

```math
\operatorname{rank}_2(u,v)=\binom{v+1}{2}+u,
\quad
\operatorname{rank}_3(u,v,w)=\binom{w+2}{3}+\binom{v+1}{2}+u.
\tag{11}
```

Prefix sums of block sizes give a dense rank within each tile-count/honour bucket; the complete stored identity is $`(n,h,\mathrm{rank})`$. Mixed-radix indexing handles distinct groups. The actual layout contains 60,789,499 compatible blocks across all layers, stored in 3,686 nonempty buckets. The complete layer totals agree with the earlier independent count. Small-layer and terminal-layer rank/unrank and physical-edge checks test more than cardinality agreement; equal totals alone would not prove a bijection.

Honour bucketing also reduces working memory. Numerical moves preserve the honour bucket. Honour moves can change one occupied multiplicity class $`0,1,2,3`$ to the next, giving at most four distinct honour successor buckets. The counted maximum payload for one parent bucket and all required next-layer buckets is approximately 4.609 GiB, substantially below retaining both complete peak layers. Index structures, buffers, and concurrent work add to that payload; the measured complete process peak is reported separately.

Normalising all honour triplets to quads was assessed but was not the main global compression. It reduces the number of base states by only about 4.98%. Restoring correct physical outcomes requires the distinction between Grundy zero and one. A selective dual-channel layout saves only about 0.124% of global bit cells. The honour-pass theorem remains valuable locally, without being a major global memory reduction (E07).

### 5.5. Forward and reverse retrograde algorithms

Let $`K_n`$ be the SAFE orbits with $`n`$ tiles and $`P_n\subseteq K_n`$ their P orbits. Then

```math
N_n=\operatorname{Pre}(P_{n+1}),\qquad
P_n=K_n\setminus N_n.
\tag{12}
```

Every SAFE edge adds one tile. By Theorem 3, $`K_{35}=\varnothing`$, so all $`K_{34}`$ are P. Induction determines every earlier layer. The terminal base layer was also checked directly against physical SAFE successors.

The generating algorithm is parent-driven: enumerate each parent and look for a P successor. Finding one proves N and permits early termination. A parent is P only after all necessary successors have been excluded as P. Precomputed exact local transitions, target-block offsets, incremental enumeration, and 16-thread chunking reduce repeated work. If every possible successor bucket has already been proved entirely N, a whole parent bucket can be filled P; this shortcut depends on completed bucket facts, not on statistical sampling.

The replay algorithm is child-driven. It enumerates P children, deletes each present tile kind, canonically ranks the resulting predecessors, and marks them N. SAFE is downward closed, so these physical predecessors are SAFE. Enumerating one child representative covers predecessor orbits: a deletion from any symmetric child transports to the corresponding deletion from the chosen representative. Only after all relevant P-child deletions have been completed are the unmarked parents assigned P. The resulting entire bit array is compared with the stored layer.

The algorithms differ in direction and transition construction: reverse replay does not reuse the generator's forward transition tables. **They still share the foundational C++ rules and index.** This is independent recurrence replay, not two wholly independent formal models of the game. Both the achievement-to-SAFE argument and the implementation boundary are explicit parts of the computational result.

## 6. The completed global result

### 6.1. Outcome and coverage

**Computational Theorem 8 (complete finite computation).** Under the rules of Section 2 and the validated enumeration and evaluation implementation, the empty table is P. Every one-tile symmetry class is N. Hence the second player has a winning strategy in the original achievement game.

The evidence is the completed 0–34-layer table and its full reverse recurrence replay. The final acceptance record has status `PASS_COMPUTATION_AND_FULL_REVERSE_REPLAY`; the native replay terminates normally with `PASS_ALL_REQUESTED_LAYERS` and zero mismatches (E08). The table contains:

| Outcome | Number of SAFE orbits |
|---|---:|
| P | 203,051,492,021 |
| N | 575,481,372,281 |
| Total | 778,532,864,302 |

These are orbit counts, not counts of physical tile selections or play histories. Appendix D gives the complete layer distribution. The retained files occupy 97,316,623,312 bytes. Whole-bucket padding explains the small difference from an ideal globally contiguous bit array.

The historical local checks were selected before consulting the new table: 16,240 distinct known P/N states from 47 fixed sources all matched, with zero conflicts and zero UNKNOWN. Newly resolved frontier cases were recorded separately, preventing new table values from being presented as old independent expectations.

### 6.2. A concrete strategy interface

The second player's executable strategy is:

1. After the opponent's move, check for a legal immediate winning addition and take it if available.
2. Otherwise, the current table remains SAFE. Query its N value and choose a legal addition whose resulting table is P.
3. Repeat after every opponent response.

Equation (12) guarantees the required P successor in the second step. If the opponent departs from SAFE, Theorem 2 guarantees the first step. Since the number of tiles strictly increases, the strategy eventually wins. The strategy is table-based; it is not yet a short, table-free explanation of every move.

For illustration, symmetry translates the recorded opening witnesses into the following replies. A suit named differently in the fifth row is any of the other two suits.

| First tile, up to rule symmetry | One winning second move | Resulting P table |
|---|---|---|
| $`1m`$ | $`1m`$ | $`11m`$ |
| $`2m`$ | $`3m`$ | $`23m`$ |
| $`3m`$ | $`2m`$ | $`23m`$ |
| $`4m`$ | $`2m`$ | $`24m`$ |
| $`5m`$ | $`5p`$ | $`5m\;5p`$ |
| An honour $`H`$ | $`2m`$ | $`2m\;H`$ |

These are validated first responses, not a rule for matching every later move. The physical-coordinate strategy interface enumerates additions in the original 34-coordinate input and checks the chosen successor. It never returns a canonical tile index as though it were the user's original tile. Tests covered all 34 physical first moves, suit/reflection transformations, the three winning forms, and already-ended inputs: 44 principal cases passed. The recorded interface also distinguishes P, missing data, invalid input, and an already finished game. A P query relies on the validated table and does not independently replay every descendant (E08, E16).

### 6.3. Measured cost

All the reported global computation used the local CPU. The recorded hardware was an Intel Core i7-10700KF at 3.80 GHz, with 16 logical processors, running Windows 11 build 10.0.26200. The hardware record reports 34,253,983,744 bytes of physical memory. Private-memory figures below use decimal GB. These observations are bound to the recorded machine and workload, rather than inferred from a nominal resource budget (E07–E08).

| Measurement | Retained observation | Interpretation |
|---|---:|---|
| Generation stages contributing to the final table | 73.52 min | Sum of nonoverlapping retained stages, including their initialisation and I/O |
| Largest continuous generation stage | 69.10 min engine; 69.17 min supervised | One measured stage, not the total development time |
| Generator peak private memory | About 10.64 GB | Process working memory; full stored table is much larger |
| Mean CPU utilisation in the largest stage | 88.84% | Percentage of the 16-logical-processor capacity |
| Layer 24 / layer 23 generation | 529.58 s / 490.42 s | Measured complete layer times |
| Final resumed reverse replay, including supervisor | 192.08 min | New work plus validation of reusable records; earlier seed work is additional |
| Reverse replay peak private memory | 4.198 GB | Separate verification workload |
| Reverse replay mean CPU utilisation | 86.60% | Same 16-logical-processor denominator |

The 73.52-minute figure is not a claim that a single fresh run of one frozen version took precisely that time. It excludes development, discarded benchmarks, and later replay. The final reverse run newly verified 765,885,524,853 states in 3,236 buckets and reused 12,647,339,449 already verified states in 450 buckets after checking the actual inputs. New work executed 2,914,412,897,457 physical deletions. The 778,532,864,302 total counts each state once.

### 6.4. Verification and reproducibility limits

The global audit includes complete count agreement over 35 layers; 23,514,062 rank/unrank round trips and 36,292,659 physical SAFE edges across layers 0–8, 33, and 34; direct confirmation that all 587,901 layer-34 states lack SAFE successors; full reverse comparison of all 3,686 buckets; historical position checks; and a separate stream over all 97.32 GB checking hashes, P counts, padding, and lengths.

The integrity stream completed in 217.81 seconds with a small working set. It is an I/O validation, distinct from recurrence replay. An interrupted-generation test reused 1,586,233,344 completed states, and the resulting approximately 6.06-billion-state bucket was byte-identical to its uninterrupted comparison. A Windows atomic-replacement failure during replay was corrected before the accepted resumed run; interrupted runs remain recorded as incomplete.

For this manuscript audit, the final coverage records and relevant source/receipt hashes were read and checked again. The complete 97.32 GB game recurrence was **not rerun during manuscript preparation**. The claims of full replay refer to the retained, completed native execution, whose accepted records are identified in Appendix E. A new external reproduction using an independently written rule engine would reduce the principal remaining correlated implementation risk.

## 7. Formal verification in Lean

### 7.1. What has actually been formalised

Lean supports the separation of a candidate-producing program from the proof that its output is correct; its system architecture is described by [de Moura and Ullrich (2021)](https://doi.org/10.1007/978-3-030-79876-5_37). This project has two distinct formalisation lines. An earlier Lean 4.33.0 development uses Mathlib, whose library design is documented by [The mathlib Community (2020)](https://doi.org/10.1145/3372885.3373824). The later certificate pipeline uses a separate Lean 4.33.1 rules development and Lean/Std modules. Successful results from one line are not silently treated as compiled dependencies of the other.

The successful developments include:

| Formalised component | Certified scope |
|---|---|
| Rules and target size | Valid 34-kind states; legal additions; exact three winning forms; a target has fourteen tiles |
| Executable decisions | Boolean Win/SAFE decisions equivalent to their mathematical definitions; exact reference/optimised checker equivalence |
| Physical successors | Complete enumeration of legal SAFE additions in the original coordinates |
| SAFE reduction | Outcome preservation and a bridge to original-game strategies ending in a real winning hand |
| Closure properties | SAFE under valid submultisets and corresponding non-SAFE upward implications |
| Symmetry witnesses | Suit reflections, suit exchanges, honour exchanges, and finite compositions preserve the rules |
| Certificate soundness | Complete required responses, actual state equality, valid references, and well-founded induction |
| Some index arithmetic | Repeated-group colex range and injectivity facts; not the complete C++ index implementation |
| Earlier four-meld and honour lemmas | Capacity restrictions after four melds; at most four extendible kinds; honour Win/SAFE invariance |
| Concrete strategies | Closed nonempty roots and all certified table rows described below |

None of the following has a complete formalisation in the successful chain: the global maxima, the full honour-pass Grundy identity, the frozen-five theorem, the whole regional classification library, the complete C++ rank/unrank implementation, and the entire 97.32 GB table. The formalisation catalogue in Appendix F names the evidence rather than relying on the presence of a `.lean` file.

### 7.2. A response certificate in the original game

A response certificate consists of SAFE P states. For each row $`x`$ and **each legal first action** $`a`$, it supplies a legal second action $`b`$ satisfying one of two conditions:

```math
\operatorname{Win}(x+e_a+e_b),
\quad\text{or}\quad
x+e_a+e_b=\gamma(y)
\tag{13}
```

for an already proved P state $`y`$ and a checked rule symmetry $`\gamma`$. SAFE proves that the first action cannot itself win. The winning branch includes an explicit valid fourteen-tile target. Internal P references must have a strictly smaller proof-row identifier; an external reference must return a Lean value carrying a proof of the referenced state. These conditions permit well-founded induction on rows.

The row identifier orders proofs, not tile count in play. A reference points backwards in the proof dependency order while its target has two more physical tiles than the current row. Actual state equality is checked across all 34 coordinates. Missing entries, illegal second moves, cyclic references, omitted first actions, and incorrect symmetry paths cannot be accepted as successful certificates.

The implementation also reuses SAFE bounds. If $`x\le\gamma(z)`$ and $`z`$ is a separately certified SAFE state, downward closure proves $`x`$ SAFE. Every inclusion and symmetry path is checked. The source of the bound must already be proved; importing a SAFE fact that depends on the very table being justified would introduce a circular argument.

The independent SAFE leaves use formally proved negative capacity certificates. For each possible pair removed from a table, checked bounds on the numbers of melds in the four local blocks exclude an ordinary win when their sum is less than four. Seven pairs and thirteen orphans are checked separately. Masked and cached local-bound transfer theorems reuse successful local checks on appropriate smaller patterns. The total decision procedure falls back to the proved reference checker if a proposed bound fails; rejection of a shortcut is not evidence of safety. These local hand-capacity facts certify predicates, not future P/N equivalence.

This route avoids trusting the global table, canonicaliser, or index inside the final local theorem. Those tools propose responses. Lean checks the actual states and rules. It also avoids needing the global bound SAFE $`\le34`$ as a certificate axiom: actual winning responses and complete checked obligations establish termination and success.

### 7.3. Certified nonempty milestones

The first complete actual endgame in the new chain was a 34-tile table. Its 31 legal first actions all had checked winning replies, using ordinary hands or thirteen orphans. Larger proof experiments subsequently certified a twenty-tile root and compressed its P-state certificate from 610 nodes to 24 by changing response selection and sharing symmetric states. These are proofs of specified tables, not claims that every table with the same number of tiles is P.

An actual fourteen-tile branch of the opening candidate graph was then certified:

```text
0000011110001000020001120300000000
```

Its table contains 50 P rows and covers 1,700 legal first actions: 1,383 direct winning replies and 317 descending references. Six independent SAFE leaves, two with 24 tiles and four with 26, establish the necessary SAFE bounds. The accepted audit covered 40 modules, with 25 compiled and 15 previously checked modules reused; a four-process replay measured approximately 44.44 seconds and 5.64 GB aggregate private memory (E12).

The newest certified root is

```math
x_{12}=99m\;6789p\;456888s,
\tag{14}
```

with exact count string

```text
0000000020000011110001110300000000
```

**Theorem 9 (Lean-certified twelve-tile strategy).** From $`x_{12}`$, the player moving second from that state has a winning strategy under the original rules. Equivalently, $`x_{12}`$ is P for the player about to move.

The closed declaration is `Mahjong.Scale12V2.original_second_player_wins`, with the type

```lean
SafeGame.SecondPlayerWins Step Win original
```

where `original` is the exact 34-coordinate state above. The audit also checks that the theorem has no remaining P premise or unchecked database parameter. Its root has 34 legal first tile kinds, all covered by the certificate. Membership of this table in an opening candidate graph does not prove that the opponent can be forced to reach it from the empty table.

### 7.4. The twelve-tile certificate and its audit

The initial closed candidate contained 790 P nodes and continued to 26-tile states. Reusing existing fourteen-tile proofs cut the local table to 757 rows, with eleven actual external boundary cuts. The final action audit is:

| Response type | Legal first actions covered |
|---|---:|
| Ordinary four-meld-and-pair winning witness | 20,776 |
| Thirteen-orphans winning witness | 91 |
| Return to an earlier local proved row | 4,563 |
| Return to a proved external registry row | 80 |
| **Total** | **25,510** |

The present table happens not to use a seven-pairs positive witness. The general rules and sound checker still include seven distinct pair kinds; the absence of that witness type is a property of the selected strategy data.

There are 86 independent SAFE leaves. Together with SAFE projections from four earlier proved rows, they provide 90 bound sources. Each of the 757 rows is checked as a submultiset of its selected transformed bound. The 757 data rows are split into twelve modules: eleven contain 64 rows and the last 53. Ninety-five checked groups cover consecutive intervals of eight rows, with five rows in the last group. The final coverage proof joins the intervals and covers the complete database.

The final receipt records **326 of 326 modules passed**, comprising 231 exact reused modules and 95 newly compiled modules. Lean 4.33.1 ran with `--trust=0`. An audit of 1,438 theorem declarations found only the accepted foundational axioms `propext`, `Classical.choice`, and `Quot.sound`; it found no `sorryAx`, custom result axiom, or native decision axiom. Reuse was bound to source, object, log, and dependency identities. This is not a claim that all 326 modules were freshly compiled in that 67-second run.

The final run took 67.266 seconds, with at most nine concurrent Lean processes and a sampled aggregate private-memory peak of 12,719,529,984 bytes, or 12.72 GB. This was below the 16 GB working limit. The preceding independent-leaf stage used at most ten processes and peaked at approximately 8.84 GB. These are separate measurements and are not added as though simultaneous.

A subsequent wrapper turns all 757 proved rows into reusable registry entries. Its separate receipt passed 327 modules, of which 325 were reused and two newly compiled. A lookup returns both the state and its proof. The accompanying JSON registry is only a discovery index; it does not provide a logical premise. During manuscript preparation, the retained audit procedures were rerun to rehash 2,892 linked receipt files, check 1,514 dependency-exact reuse relationships, and recheck the 25,510 concrete responses. These were integrity and semantic rechecks of the retained evidence, not a newly authored independent checker or a fresh kernel compilation (E13–E14).

### 7.5. Proof-cost optimisations and failed attempts

Ordinary positive witnesses originally rebuilt a complete fourteen-tile target while checking each tile coordinate. The optimised checker instead verifies and subtracts the four given melds in order, then checks the pair against the remainder. The availability checks before subtraction are retained. Lean proves equality of the old and new checkers for every input; selected matching outputs alone would be insufficient.

On the same complete fifty-row fourteen-tile table, grouped proof CPU time fell from 35.015625 to 24.703125 seconds, a 29.45% reduction. Group wall time fell from 37.341191 to 24.954220 seconds, but the first baseline group had cold-import effects. An external-reference comparison gave a similar CPU reduction on eighteen rows. The performance claim is confined to these workloads (E15).

Batching reduced repeated module overhead, while excessively large batches raised peak memory. On eight fixed nodes, batching reduced measured module-body time from 25.208 to 15.441 seconds. A 32-node single-module attempt hit its 3 GB watchdog. Splitting a 24-row proof into groups reduced the measured peak to approximately 1.51 GB, without being faster than the corresponding whole-table proof. The twelve-tile monolithic data-module attempt likewise stopped at its configured per-process limit. Its accepted successor uses split data modules. The reported 4.71 GB pilot peak was aggregate memory; its largest individual process was approximately 2.42 GB. Failed attempts remain excluded from certification.

Candidate generation had a different bottleneck. Removing recoverable repeated state strings from persisted edges produced exactly matching logical output in two fixed-work comparisons with reversed run order. The combined speed ratio was 1.205, and the database size was approximately 0.665 of the previous schema. Thus the measured generator was about 20.5% faster, corresponding to about 17.0% less elapsed time; these percentages are not interchangeable. The optimisation was accepted only after logical equivalence and restart checks. It does not establish a proportional speed-up for Lean checking or for a complete opening proof.

### 7.6. What remains open in the formal proof

The generic theorem that a checked certificate containing the empty P root proves a second-player win is complete. Its required concrete empty-root certificate and the kernel proof that the complete certificate passes have not been supplied. A theorem with a hypothesis `check tree = true` does not establish that hypothesis for a proposed tree.

The retained compact opening candidate currently contains 9,765,237 discovered nodes and 16,179,951 edges, with 6,911,482 nodes expanded and 2,853,755 discovered nodes pending. It remains `PARTIAL`. Expanding pending nodes can discover more nodes, so these counts do not define a completion percentage. Candidate expansion averaged about 21.85 million nodes per hour in two measured bounded phases; this is not a Lean proof-checking rate.

Of three actual twelve-tile candidate descendants of the opening graph, the branch in Theorem 9 closed and was certified. The other two did not close within their 100,000-node search budgets, and their checkpoints were retained. A later ten-tile ancestor probe is also partial: 112,490 discovered nodes, 33,127 expanded, and 79,363 pending. The ten-tile state has no certified theorem from that incomplete probe (E17).

An end-to-end certification may therefore take either of two routes: a sufficiently compressed complete physical response certificate from the opening, or a formalised global table/index pipeline together with a checked full recurrence. The first needs all necessary strategic branches; the second additionally needs the complete index, coverage, and table-semantics bridge. Neither route has a measured completion date or a proved minimum resource requirement.

## 8. Interpretation, conjectures, and further work

### 8.1. What the solution explains

The global table answers the winner question and supports an executable strategy. The structural work explains why the game can be reduced, why a large table need not already be winning, and why some endgames admit parity or response arguments. The Lean work independently confirms that the implemented formal rules can support closed original-game strategies, rather than only abstract conditional theorems.

These results also explain the historical transition from difficult local search to tractable global evaluation. Early region solvers repeatedly revisited contextual boundaries and sometimes computed more Grundy information than an outcome query needed. Dense exact indexing, shared bucket scheduling, precomputed transitions, and early exit changed the unit cost of complete evaluation. A high state count alone did not determine the actual running time.

Conversely, a fast bit-table computation did not make kernel certification immediate. A strategy proof has a different representation, dependency graph, and reduction cost. Improving the selection of shared P responses can reduce the certificate substantially even when the already computed winner remains unchanged.

### 8.2. Remaining claims and their proper status

| Statement | Current status | Evidence that would settle it |
|---|---|---|
| The second player wins from empty | Completed computational result; full reverse replay agrees | Independent reimplementation would strengthen the computational evidence; a closed opening Lean theorem would complete formal certification |
| A closed Lean opening theorem can be delivered by the current pipeline within a particular budget | Unestablished feasibility claim | Complete certificate generation and measured successful kernel replay |
| There is a short human-readable invariant strategy for the opening | Open structural question | A precisely stated response-closed family covering the opening and every opposing choice |
| The current greedy response selection gives a minimal or near-minimal proof DAG | Unproved optimisation claim | A defined optimisation objective with a lower bound or comparison method |
| All 35 eight-tile $`M`$ roots are P | Refuted | Three explicit N orbits are listed in Section 4.6 |
| Static hand profiles determine P/N | Refuted | The two concrete states in equation (7) have different outcomes |
| Every fourth copy behaves as an independent pass | Refuted | The numerical example in Section 3.3 leaves SAFE |
| The maximum SAFE size alone determines the winner | Refuted as a proof method | Odd and even maximal SAFE tables both exist |

We do not invent a further winner conjecture merely to populate an open-problems section. The interesting unfinished work concerns explanation, independent validation, and formal proof of the already computed answer. Nor do we infer that local proof methods are impossible because some local searches stopped.

### 8.3. Concrete extensions

The immediate formalisation task is to reuse certified twelve- and fourteen-tile boundaries while choosing earlier responses that increase sharing. The relevant measurement is the size and check cost of the **complete required** graph, with all opposing choices covered. A smaller sample, a high expansion rate, or additional available RAM cannot establish that size in advance.

Symbolic response families may replace many repeated rows. A safe development order is to formulate an exact family, prove validity and SAFE, prove all legal action classes and responses, and only then connect it to an earlier certified state. The existing honour and frozen-five arguments provide candidates, but their membership in an opening strategy must be shown.

Residual forbidden targets offer another structural direction. On labelled copies, remove the already supplied part of each forbidden thirteen-tile edge, delete supersets of smaller residual edges, and exclude vertices forbidden by singleton edges. If every remaining minimal forbidden edge has size two, the residual game becomes Node Kayles on the resulting graph: selecting a vertex excludes it and its neighbours. The relationship between hypergraph avoidance and graph endgames is developed for a different family by [Huggan et al. (2022)](https://doi.org/10.1002/jcd.21809). Here it is a conditional modelling route, not a proved classification of all Mahjong endgames.

Decision diagrams could compress sets of P states or repeated certificate conditions. [Bryant (1986)](https://doi.org/10.1109/TC.1986.1676819) provides the standard Boolean decision-diagram framework. No complete BDD or multivalued decision-diagram solver was used to obtain the reported global answer, and no beneficial diagram size is claimed without an implementation and measurements.

Further useful deliverables include an independently authored Win/SAFE and index implementation, a clean full replay on another machine, full formalisation of the extremal and frozen-region theorems, a portable proof package containing the latest twelve-tile dependency closure, and a smaller interactive strategy interface with explicit fourteen-tile winning witnesses. Each has a concrete acceptance criterion. None requires guessing a deadline for the complete Lean opening proof.

Finally, no complexity classification for this fixed 34-kind, four-copy instance follows from a hardness theorem about a variable-size family of games, such as those investigated by [Schaefer (1978)](https://doi.org/10.1016/0022-0000(78)90045-4). A complexity claim about a generalised Mahjong family would first need a specified input parameter and a reduction. State counts and particular failed searches are not unconditional lower bounds on proof length or runtime.

## 9. Reproducibility and research integrity

### 9.1. Artefact availability and version boundaries

The public computational source is available as [*Mahjong achievement game*, version 0.1.0](https://github.com/feierbuqiu/mahjong-achievement-game/releases/tag/v0.1.0) (feierbuqiu, 2026). Its fixed tag targets commit `5a942090ac77fdf63a3d528054dd2c0cbaab138f`. It contains rule, index, generation, replay, strategy, and evidence material. The full approximately 97.32 GB bit table is retained locally and is not included in Git; the public source includes reconstruction commands and bucket hashes. Source availability and exact regeneration are distinct from downloading a ready-made full table.

Later Lean material has its own publication and local receipt chain. The version 0.1.0 computational citation should not be read as containing every later formalisation. In particular, this report identifies the newest twelve-tile evidence by its local source and receipt hashes. It does not claim that the latest twelve-tile dependency closure is already part of that tagged release. Appendix E records the relevant local paths, and the accompanying source ledger freezes the manuscript's evidence inputs.

The original migration manifests remain unchanged. New results live alongside them. A file called `STATUS.json` at the research root is therefore a dated historical snapshot, while the accepted global result is in `runs/global_retro/verification/final_v1/acceptance.json`. Likewise, `CANDIDATE_CLOSED`, module `PASS`, a closed nonempty theorem, and a closed empty theorem are separate states of progress.

### 9.2. Reproduction levels

Reproduction can be scaled to the reader's objective. Checking source hashes and compiling a smoke test verifies packaging and a limited execution path. Rebuilding the full table and replaying all layers verifies the computational claim with the supplied implementation. Replaying a frozen Lean dependency chain verifies the corresponding formal theorem. Inspecting rules independently addresses model fidelity. No one of these operations substitutes for all the others.

Appendix G gives commands and expected statuses. New runs must use their own output directories and retain exact source versions, input states, budgets, toolchain versions, logs, and completed outcomes. In particular, a timeout or missing table must propagate as UNKNOWN. The existing source contains deliberate failure-path checks for malformed states, corrupted checkpoints, incomplete coverage, and missing proof references.

### 9.3. Independence and attribution

The original challenge is credited to 零之审判者. No conclusion, strategy, proof, or computational result from another competitor is used as a proof premise, computational oracle, or research result in this article. The mathematical derivations, implementations, classifications, and proof artefacts reported here were developed within this project, with the substantial AI assistance disclosed below. This statement does not claim that every general method is new or that no prior literature exists. The cited literature supplies general concepts and methods; it does not supply the computed outcome of this particular instance.

The author accepts responsibility for the claims and the distinction between evidence levels. The report has not undergone external journal peer review. Checks described as independent within the project mean independent code, recurrence direction, or source review to the extent specified; they do not imply independent human research teams. Historical notes discussing suggestions or numerical claims from elsewhere are not incorporated as accepted premises.

## 10. Conclusion

The shared-table Mahjong achievement game has a completed computational second-player win. Exact retrograde analysis covers all 778,532,864,302 SAFE orbits, and full reverse recurrence replay agrees with every stored outcome. The structural results establish a faithful SAFE reduction, exact bounds of 37 nonwinning and 34 SAFE tiles, useful endgame families, and concrete counterexamples to several tempting simplifications. Local classifications both informed the investigation and supplied fixed comparisons for the global computation.

Formal verification has reached a separate, concrete milestone: original-rule certificates include a twelve-tile root, 757 reusable P rows, and complete coverage of 25,510 first actions. The opening Lean certificate remains incomplete. Completing it, or finding a compact symbolic strategy that explains the computed answer, would strengthen a result whose computational and partial formal evidence can already be inspected and reproduced.

## Author contribution and AI-use declaration

**feierbuqiu** is the sole named author and is responsible for the research question, project direction, interpretation, integrity of the reported claims, and the decision to release a final version after review.

**OpenAI's GPT-6 Astra made an exceptionally substantial contribution to this work.** Its assistance extended well beyond language editing: it contributed to mathematical exploration and derivations, conjecture generation and refutation, algorithm and software development, debugging, computation orchestration, evidence auditing, Lean formalisation, proof-cost optimisation, and the drafting and organisation of this manuscript. Parallel AI agents were used for bounded independent implementation and review tasks. The project is therefore described transparently as research developed by the named author with extensive AI assistance; it should not be represented as wholly unaided human derivation.

AI-generated reasoning was treated as a proposal requiring mathematical examination, executable evidence, or kernel checking at the level claimed. Agreement between AI agents was not itself accepted as a proof. The model is acknowledged as a tool rather than listed as an accountable author. The named author remains responsible for the final manuscript, references, and release claims.

## Acknowledgements

The author thanks the Bilibili creator **零之审判者** for providing the initial idea and problem starting point in the [Bilibili post supplied with the research request](https://www.bilibili.com/opus/1246853448736964611?spm_id_from=333.1365.0.0). This acknowledgement concerns the origin of the question. No other participant's conclusions or results were used as premises of the work reported here. The author also acknowledges the maintainers of Lean, Mathlib, and the open-source tools used to make the computations and proofs inspectable. The extensive contribution of OpenAI's GPT-6 Astra is detailed in the AI-use declaration above.

## References

Allis, L. V., van der Meulen, M., & van den Herik, H. J. (1994). Proof-number search. *Artificial Intelligence, 66*(1), 91–124. [https://doi.org/10.1016/0004-3702(94)90004-3](https://doi.org/10.1016/0004-3702(94)90004-3)

Bryant, R. E. (1986). Graph-based algorithms for Boolean function manipulation. *IEEE Transactions on Computers, C-35*(8), 677–691. [https://doi.org/10.1109/TC.1986.1676819](https://doi.org/10.1109/TC.1986.1676819)

de Moura, L., & Ullrich, S. (2021). The Lean 4 theorem prover and programming language. In A. Platzer & G. Sutcliffe (Eds.), *Automated deduction—CADE 28* (Lecture Notes in Computer Science, Vol. 12699, pp. 625–635). Springer. [https://doi.org/10.1007/978-3-030-79876-5_37](https://doi.org/10.1007/978-3-030-79876-5_37)

feierbuqiu. (2026). *Mahjong achievement game* (Version 0.1.0) [Computer software and research artefacts]. GitHub. [https://github.com/feierbuqiu/mahjong-achievement-game/releases/tag/v0.1.0](https://github.com/feierbuqiu/mahjong-achievement-game/releases/tag/v0.1.0)

Huggan, M. A., Huntemann, S., & Stevens, B. (2022). The combinatorial game Nofil played on Steiner triple systems. *Journal of Combinatorial Designs, 30*(1), 19–47. [https://doi.org/10.1002/jcd.21809](https://doi.org/10.1002/jcd.21809)

Pólya, G. (1937). Kombinatorische Anzahlbestimmungen für Gruppen, Graphen und chemische Verbindungen [Combinatorial enumerations for groups, graphs, and chemical compounds]. *Acta Mathematica, 68*, 145–254. [https://doi.org/10.1007/BF02546665](https://doi.org/10.1007/BF02546665)

Schaefer, T. J. (1978). On the complexity of some two-person perfect-information games. *Journal of Computer and System Sciences, 16*(2), 185–225. [https://doi.org/10.1016/0022-0000(78)90045-4](https://doi.org/10.1016/0022-0000(78)90045-4)

Sieben, N. (2023). Impartial hypergraph games. *The Electronic Journal of Combinatorics, 30*(2), Article P2.13. [https://doi.org/10.37236/11665](https://doi.org/10.37236/11665)

Siegel, A. N. (2013). *Combinatorial game theory* (Graduate Studies in Mathematics, Vol. 146). American Mathematical Society. [https://bookstore.ams.org/view?ProductCode=GSM%2F146](https://bookstore.ams.org/view?ProductCode=GSM%2F146)

Sprague, R. (1935). Über mathematische Kampfspiele [On mathematical combat games]. *Tôhoku Mathematical Journal, First Series, 41*, 438–444. [https://www.jstage.jst.go.jp/article/tmj1911/41/0/41_0_438/_article](https://www.jstage.jst.go.jp/article/tmj1911/41/0/41_0_438/_article)

The mathlib Community. (2020). The Lean mathematical library. In *Proceedings of the 9th ACM SIGPLAN International Conference on Certified Programs and Proofs* (pp. 367–381). Association for Computing Machinery. [https://doi.org/10.1145/3372885.3373824](https://doi.org/10.1145/3372885.3373824)

零之审判者. (2026). *呆饼问题* [Bilibili post]. Bilibili. [https://www.bilibili.com/opus/1246853448736964611](https://www.bilibili.com/opus/1246853448736964611)

## Appendix A. Complete proofs of the extremal bounds

### A.1. A common counting device

Let $`n=|x|`$, $`q=|\{i:x_i\ge2\}|`$, and $`t=|\{i:x_i\ge3\}|`$. Remove one triplet from each of the $`t`$ kinds. The residual multiset $`R`$ has every count at most two, exactly $`q-t`$ paired kinds, and some support size $`r`$. Thus

```math
n=3t+r+(q-t)=2t+q+r.
\tag{A1}
```

Partition each numerical suit into the fixed blocks 123, 456, and 789. Let $`s`$ count the blocks whose three ranks are all in the residual support. The blocks provide $`s`$ mutually disjoint sequences, also disjoint in physical copies from the removed triplets. The other blocks contain at most two supported ranks each. Including the seven honours gives

```math
r\le3s+2(9-s)+7=25+s.
\tag{A2}
```

The original table consequently contains $`t+s`$ disjoint melds. These inequalities do not assume that an arbitrary numerical rank permutation is legal.

### A.2. No nonwinning table has 38 tiles

Suppose $`n\ge38`$ and the table is nonwinning. Seven pairs forces $`q\le6`$. Five triplet kinds would supply four triplets and a pair, so $`t\le4`$. If $`t=4`$, no other paired kind can be present, giving $`q=4`$. Equations (A1)–(A2) imply

```math
t+s\ge13-t-q.
\tag{A3}
```

If $`t\ge1`$ and $`t+q\le8`$, at least five disjoint melds exist, including a triplet. Reserve two copies of that triplet as a pair and choose four other melds. Their copies are disjoint, so the target respects capacity and is already contained in the table.

If $`t=0`$, there are at least seven disjoint sequences. Some pair must exist because 38 tiles exceed the 34 available kinds. Selecting that pair destroys at most two of the selected disjoint sequences, leaving at least four to accompany it.

The only remaining possibility is $`t=3,q=6`$. Then $`R`$ has three paired kinds and contains a sequence. If that sequence misses one of the paired kinds, use the untouched pair with the sequence and the three removed triplets. If it uses all three paired kinds, $`R`$ contains two copies of the sequence; take those, two removed triplets, and a pair from the third removed triplet. Every case produces a valid winning target, a contradiction. Hence $`n\le37`$.

For equality, take `124578` once in each suit, four copies of each of four honours, and the other three honours once. The numerical support has no sequence. The four honour triplets leave no pair. There are only four paired kinds, and the suited nines required for thirteen orphans are absent. The table is nonwinning and has 37 tiles. Since Win is upward closed, its tiles may be placed in any order without an earlier winning subset. This also shows that the unrestricted move-38 termination bound is attainable.

### A.3. No SAFE table has 35 tiles

First, a SAFE table containing four disjoint melds with union $`D`$ has at most sixteen tiles, by Proposition 7. A residual tile at a coordinate $`D_i\le2`$ would provide the forbidden thirteen-tile submultiset $`D+e_i`$ of the valid target $`D+2e_i`$. A coordinate $`D_i=4`$ cannot have a residual copy. At most four coordinates can have $`D_i=3`$, and each contributes at most one residual tile.

Now suppose a SAFE table has $`n\ge35`$. It has $`q\le5`$: six pair kinds occupy at most 24 tiles, so there would be another supported kind whose duplication completes seven pairs. It cannot contain four melds, so $`t+s\le3`$. Consequently

```math
n\le2t+q+25+s\le28+t+q.
\tag{A4}
```

As $`t\le3`$ and $`q\le5`$, only $`(t,q)=(3,4),(3,5),(2,5)`$ remain.

For $`t=3`$ and $`q\ge4`$, select three triplets and a pair of a different kind. At least 24 residual tiles remain, with at most one paired kind, hence at least 23 distinct kinds and at least sixteen numerical kinds. Some one of the nine fixed blocks contains two residual ranks. Complete these to its sequence. The selected eleven-tile core uses each kind at most three times; the sequence contributes at most one additional copy of each kind. If the missing copy is already on the table, a target is already present; otherwise it is available to add without exceeding four copies. Either case contradicts SAFE.

For $`t=2,q=5`$, removing the two triplets leaves $`r=n-9\ge26`$ kinds and three pairs. Equation (A2) guarantees a residual sequence $`C`$. If $`C`$ uses all three paired kinds, two copies of $`C`$ and the two removed triplets give four disjoint melds, already excluded. Otherwise, choose a pair at a kind untouched by $`C`$. The two triplets, $`C`$, and that pair form an eleven-tile core $`D`$.

Removing $`C`$ and the pair from $`R`$ eliminates at most four supported kinds, leaving at least 22 kinds, of which at least fifteen are numerical. At most two numerical kinds are used four times in $`D`$: only a removed-triplet kind that also occurs in $`C`$ can be saturated in that way. If a fixed block contains two residual ranks and its missing third rank is not saturated in $`D`$, these residual tiles complete a legal sequence, giving a target present or completable in one move.

Under the SAFE assumption, therefore, each block without a saturated kind contains at most one residual numerical kind. Each block with a saturated kind contains at most two. At most two blocks can be exceptional, allowing at most $`9+2=11`$ residual numerical kinds. This contradicts the lower bound of fifteen. Hence $`n\le34`$.

Equality is witnessed by `124578` once in each suit, three honour quads, and the four other honours once. There are three triplets and no sequences. A duplicate of an existing singleton can provide a pair but cannot provide the missing fourth meld. A new numerical rank can provide a sequence, but the resulting four melds leave no pair. Seven pairs and thirteen orphans are more than one tile away. This valid 34-tile table is SAFE. ∎

## Appendix B. Explicit endgame arguments

### B.1. The six-pair pattern table

For a SAFE table with six pair kinds, no other kind is supported and no new kind can be added safely. Let $`R`$ be its multiset of maximal numerical run lengths at least three. A kind outside these runs may still be numerical; it simply participates in no sequence inside the fixed support.

| $`R`$ | Exactly the SAFE multiplicity patterns | Common terminal size $`L`$ | Patterns per fixed support |
|---|---|---:|---:|
| $`\varnothing`$ | At most two counts are 3 or 4; all other counts are 2 | 16 | 73 |
| $`[3]`$ | All outside counts 2; the three run counts are permutations of 222, 223, 224, 233, or 234 | 15 | 16 |
| $`[4]`$ | Outside counts and endpoints 2; the middle pair is (2,2), (3,2), (2,3), (4,2), or (2,4) | 14 | 5 |
| $`[5]`$ | All six counts 2 | 12 | 1 |
| $`[6]`$ | All six counts 2 | 12 | 1 |
| $`[3,3]`$ | All six counts 2 | 12 | 1 |

In the exclusion arguments below, whenever a required triplet already exists, the displayed winning target is already present; otherwise that kind has count two and its promotion is legal. Thus no argument requires adding a fifth copy.

With no run, only triplets are present. Three triplet kinds would allow a fourth pair kind to be promoted, yielding four triplets and a fifth-kind pair. Conversely, with at most two triplet kinds, adding one tile can increase the number of disjoint melds by at most one, so an ordinary win remains impossible. Every maximal SAFE continuation ends with two quads and four pairs.

For $`[3]`$, call the run $`abc`$ and the three outside kinds $`U,V,W`$. An outside triplet would allow promotion of another outside kind and a win using two $`abc`$ sequences, those two triplets, and the remaining pair. Three run counts at least three already provide three sequences. Two run counts equal to four provide two triplets and a sequence. In either case an outside promotion gives a fourth meld with a remaining pair. Excluding these cases leaves the sixteen listed permutations; each has at most two disjoint melds. Its maximal SAFE continuations end at a permutation of 234, of total size fifteen.

For $`[4]`$, write the run $`abcd`$ and outside kinds $`U,V`$. Both outside counts must be two: a promoted outside kind together with the other's promotion permits two $`abc`$ sequences and the remaining endpoint pair. Both endpoint counts must also be two: an endpoint triplet, two sequences on the other three ranks, and a promoted outside kind would win with the other outside pair. The middle counts cannot both exceed two, because two $`abc`$ sequences and one $`bcd`$ sequence can be completed with an outside triplet and the other pair. The five remaining middle patterns each have at most two melds, and their terminal size is fourteen.

For $`[5]`$, let the consecutive ranks be $`abcde`$, with outside kind $`U`$. The all-pairs table is SAFE by its size twelve. Every supported-kind promotion is unsafe, as these explicit two-step completions show:

| First added kind | Reply | Four melds and a pair |
|---|---|---|
| $`a`$ | $`U`$ | $`aaa+bcd+bcd+UUU+ee`$ |
| $`b`$ | $`U`$ | $`bbb+cde+cde+UUU+aa`$ |
| $`d`$ | $`U`$ | $`ddd+abc+abc+UUU+ee`$ |
| $`e`$ | $`U`$ | $`eee+bcd+bcd+UUU+aa`$ |
| $`U`$ | $`a`$ | $`aaa+bcd+bcd+UUU+ee`$ |
| $`c`$ | $`c`$ | $`abc+abc+cde+cde+UU`$ |

A new kind is answered by copying it to seven pairs. Thus the twelve-tile table is terminal SAFE, and downward closure excludes all larger patterns. For $`[6]`$ and $`[3,3]`$, the all-pairs table contains four disjoint sequences; any added kind can be copied to provide the pair, retaining those sequences and respecting capacity. These tables are also terminal SAFE.

This argument includes threats from outside the fixed support. In every non-four-meld SAFE pattern above, at most two disjoint melds exist before an addition. Removing the added tile from any later meld decomposition destroys at most one meld, so the addition cannot produce four. No seventh-kind singleton existed before that move, and at most seven supported kinds afterwards cannot yield thirteen orphans. Thus this analysis has not silently restricted the original game to six kinds.

Every complete SAFE play from a given pattern ends at its row's common size $`L`$. Backward induction gives

```math
g(x)=(L-|x|)\bmod2.
\tag{B1}
```

In this particular region the exact Grundy values really are only zero and one. Equation (8) follows because only $`L=15`$, the $`[3]`$ case, is odd. The retained checks cover 13,616 support orbits, all 9,926,064 assignments of counts 2/3/4 on those representatives, and 1,604,100 SAFE edges. Of the assignments, 891,815 are SAFE; this is not a separately deduplicated global orbit count. The mathematical classification is the reason for the formula, and the enumeration checks its implementation (E03).

### B.2. A constructive proof for two honour triplets and three pairs

Let $`F=H^3J^3X^2Y^2Z^2`$ with all five kinds distinct and $`H,J`$ honours. Maintain a table with the three pairs, no other kinds, and the honours either both at three or both at four. These tables are SAFE. Indeed, every valid target uses at most three copies of each honour; after discarding surplus fourth honours there are only twelve useful tiles, or thirteen after one addition.

If $`XYZ`$ form a numerical sequence, the table already contains two copies of that sequence and two honour triplets. Only the fourth honours are SAFE moves: adding any other kind allows the opponent to copy it and use those four melds with a pair. The even number of remaining honour passes can be paired, proving P.

If $`XYZ`$ do not form a sequence, the opponent has three kinds of legal action. Consuming one fourth honour is answered by consuming the other, restoring the maintained family. Promoting one of the three pairs is answered by promoting another; the two honour triplets, the two newly completed triplets, and the remaining pair win immediately.

The last case introduces a new kind $`u`$. If that move leaves SAFE, take an immediate win. Otherwise the new support has no numerical sequence. Any newly supported sequence would use $`u`$ and two of $`X,Y,Z`$; duplicating $`u`$ would then supply two copies of that sequence, the two honour triplets, and the unused third pair. That would contradict the assumption that the opponent's $`u`$ move was SAFE.

Duplicate $`u`$. The result has six pair kinds, exactly two honour triplet-or-quad kinds, four other pairs, and no numerical run. It is SAFE and P by the no-run case of Appendix B.1; more directly, its only SAFE moves are the even number of remaining fourth honours. Promoting any other pair allows a fourth-triplet response with a pair left over. Introducing another new kind allows seven-pairs copying. Pair the fourth honours and take the eventual immediate win.

The cases cover every physically legal kind. Each response wins or returns to an explicit P family. The bare twelve-tile table is therefore P, with a win by size eighteen at latest. This proof uses no unverified outcome from the larger frozen-five auxiliary table. ∎

### B.3. A fully decomposed graph endgame

In the fixed family rooted at $`3m\;7m\;H_1^3H_2^3H_3^3H_4^2`$, the other two numerical suits evolve as independent sets in squared paths. For an available interval of $`n`$ consecutive ranks, let $`f(n)`$ be its Grundy value. Playing rank $`r`$ removes that vertex and the two neighbouring ranks on either side, giving

```math
f(0)=0,\qquad
f(n)=\operatorname{mex}_{1\le r\le n}
\left\{f(\max(0,r-3))\operatorname{xor}f(\max(0,n-r-2))\right\}.
\tag{B2}
```

For $`n=0,\ldots,9`$, the values are $`(0,1,1,1,2,2,0,3,3,1)`$. XOR the remaining interval values with the parity of the available honour moves. Each nine-rank suit has 41 admissible singleton supports, so the fixed family has $`41^2 2^6=107,584`$ count vectors. The exact blocked-move and orphan exclusions establishing the decomposition are proved in `mahjong_round2/math/two_suit_family.md` (E03). The ordinary suits cannot be XOR-combined before those exclusions have been established.

### B.4. Why every SAFE two-quad, three-pair table is P

Let $`S=U^4V^4A^2B^2C^2`$, where all five kinds are distinct, and assume full-game SAFE. First suppose its support contains a numerical run. If the run uses both quad kinds, take $`UUU`$, $`VVV`$, and the run. At least two original pairs remain untouched; promoting one and retaining the other completes a winning target, contradicting SAFE. If the run uses one quad kind, write it as $`UAB`$. Two such sequences, $`VVV`$, a promoted $`CCC`$, and the remaining $`UU`$ again give an immediate win. If the run uses no quad kind, it is $`ABC`$. Then $`D=UUU+VVV+2(ABC)`$ comprises four melds. By the four-meld lemma, every SAFE continuation would have to add a fourth copy to a kind occurring three times in $`D`$. The only such kinds are $`U,V`$, both already exhausted in $`S`$. The table is therefore terminal SAFE and P.

It remains to consider support with no run. Promoting any pair is answered by promoting another: the resulting four triplets and remaining pair win. A new kind $`x`$ can create a run only if that run contains $`x`$. If it uses no quad kind, say $`ABx`$, copy $`x`$ and win with $`2(ABx)+UUU+VVV+CC`$. If it uses one or two quad kinds, $`UUU`$, $`VVV`$, and the new run can coexist: each affected quad contributes three copies to its triplet and one to the run. At least two original pairs remain intact. Promote one for the fourth meld and use another as the pair.

If adding $`x`$ creates no run, copy it into $`U^4V^4A^2B^2C^2x^2`$. This is the terminal no-run six-pair pattern of Appendix B.1. Every legal first move has therefore been answered by an immediate win or a return to a terminal SAFE P table, proving the assertion.

The SAFE hypothesis includes threats made with previously absent kinds. It cannot be replaced by inspecting existing runs alone: $`(1m)^4(2m)^4(1p)^2(2p)^2(3p)^2`$ has no existing run involving a quad kind, yet adding $`3m`$ wins with $`111m+123m+123p+123p+22m`$. The hand proof is independent of the accompanying enumeration, which finds 2,698,284 SAFE labelled tables among 2,782,560 tables of shape `44222`, including 7,974 terminal SAFE tables (E03).

## Appendix C. Exact exceptional shallow states

The following are the three N orbits in the complete eight-tile $`M`$ family. Numerical supports in the first two columns use the indicated physical coordinates; the last column gives the canonical successor stored in the result file. All unlisted $`M`$ orbits are P.

| Bare N table | A legal P move | Canonical nine-tile P successor |
|---|---|---|
| $`(1m)^2(2m)^2H^2J^2`$ | Add $`7m`$ | `0000000000000000000010000220000022` |
| $`(1m)^2(4m)^2H^2J^2`$ | Add $`5m`$ | `0000000000000000000000120020000022` |
| $`(4m)^2(5m)^2H^2J^2`$ | Add $`2p`$ | `0000000000000000100000220000000022` |

These successors are exactly the three P orbits of the original $`S41`$ frontier. They have respectively 16, 16, and 25 SAFE successor orbits, all checked N by one-step table recurrence. The associated final files retain the original and round-9 labels, source hashes, physical additions, canonical states, and witnesses. They are not separate Lean-certified roots merely because a one-step table query passed.

The round-8 route also considered $`T=S+H`$, promoting one existing honour pair in each of the 41 designated $`S`$ roots. During manuscript preparation these exact 41 ten-tile inputs were queried against the accepted table, with every one-step recurrence checked: **23 P and 18 N**. The query checked 7,504 bytes of relevant payload and took 1.1495 seconds in the recorded invocation. The old priority target `0000000000000000000000102020000023` is N. The exact state list and per-input results are preserved in the accompanying [computational evidence memo](evidence/computational_evidence.md), Section 13. This is a new small table query performed for this report; it is not an additional global recomputation or a Lean theorem.

The fourteen N representatives in the 179-class three-pair matrix are given in Section 4.5. Full final catalogues are linked through E04 and E08, so that the exceptional lists can be checked against the complete domains rather than treated as selected anecdotes.

## Appendix D. Complete global SAFE layer distribution

Each row below is aggregated from the accepted complete reverse-verification records. P + N equals the SAFE count in every row. The table counts rule-symmetry orbits; it does not count histories, regional cache entries, or Lean proof rows.

| Tiles | SAFE orbits | P | N | Nonempty buckets |
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
| **Total** | **778,532,864,302** | **203,051,492,021** | **575,481,372,281** | **3,686** |

## Appendix E. Evidence map and frozen identities

Links in this publication resolve either to public repository files or to explicit availability entries in the evidence catalogue. Original research paths and hashes remain recorded for provenance. Some historical sources are retained locally and are not included in this English publication. The three companion audit memos give additional source line numbers and describe the scope of each retained check. Hashes quoted below identify the original evidence; transformed public copies have their own hashes in the catalogue.

| ID | Claim or stage | Primary local evidence |
|---|---|---|
| E01 | Original model, lower shadow, extremal proofs | [Original problem and foundation development](evidence/README.md#source-021); [dated research handoff](evidence/README.md#source-002) |
| E02 | Early structural lemmas, symmetry, fourth-copy limits, profile counterexample | [Mathematical strategy](evidence/README.md#source-026); [four-meld audit](evidence/README.md#source-025); [future quotient and counterexample](evidence/README.md#source-027) |
| E03 | Hand-proved endgame families | [Six-pair theorem](evidence/README.md#source-034); [frozen five](evidence/README.md#source-033); [SAFE two quads and three pairs](evidence/README.md#source-037); [expanded even invariant](evidence/README.md#source-035); [Node Kayles family](evidence/README.md#source-031); [four honour pairs](evidence/README.md#source-030); [two honour triplets with two pairs](evidence/README.md#source-039) |
| E04 | Complete local matrices and compositions | [35 ten-tile roots](evidence/README.md#source-043); [179 final roots](evidence/archive/mahjong_round7/q5/all_three_numeric_pairs_complete.jsonl); [three-honour region](evidence/README.md#source-032); [220-root context](evidence/README.md#source-036); [exceptional sequence windows](evidence/README.md#source-038); [two-honour matrix](evidence/README.md#source-042); [controlled-prefix analysis](evidence/README.md#source-040); [greedy-prefix counterexamples](evidence/README.md#source-041) |
| E05 | Round-9 boundary closure and audit | [Round-9 status](evidence/archive/runs/round9/STATUS.json); [final facts](evidence/archive/runs/round9_math/round9_final_facts.json); [independent audit](evidence/archive/runs/round9_native/final_audit.json); [solver provenance](evidence/README.md#source-182) |
| E06 | Regional algorithms, exact filters, and persistence | [Mixed q4 review](evidence/README.md#source-045); [dense checkpoint specification](evidence/archive/mahjong_round8/regions/dense_checkpoint.md); [format and migration boundaries](evidence/README.md#source-001) |
| E07 | Global counts, index design, and hardware | [Original exact layer counts](evidence/archive/mahjong_feasibility_review/layer_counts.jsonl); [index audit](evidence/README.md#source-048); [implemented index](evidence/archive/build/global_retro/global_index.hpp.txt); [hardware record](evidence/archive/runs/global_feasibility_audit/resources_and_costs.json) |
| E08 | Complete global evaluation and full replay | [Result report](evidence/README.md#source-050); [final acceptance](../results/acceptance.json); [generation accounting](../results/generation-account.json); [payload hash manifest](../results/table-sha256.jsonl); [current shallow-frontier resolution](evidence/README.md#source-053) |
| E09 | Current Lean rules, reduction, and checker | [Kernel-verified foundations](evidence/README.md#source-167); [theory sources and description](evidence/archive/runs/lean_verification/theory_v1/README.md); [rule/index semantic audit](evidence/README.md#source-169); [final semantic review](evidence/README.md#source-168) |
| E10 | Earlier Lean/Mathlib definitions and lemmas | [SharedMahjong source](evidence/archive/mahjong_round2/lean/SharedMahjong.lean.txt); [additional honour lemmas](evidence/archive/lean_verification/existing_lean_audit/Lemmas.lean.txt); [successful local compilation](evidence/archive/lean_verification/existing_lean_audit/lemmas_compile.log) |
| E11 | Earlier complete nonempty certificates | [Continuation kernel receipt](../formal/evidence/kernel_v1.json); [fresh extraction pipeline receipt](../formal/evidence/pipeline_kernel_v1.json) |
| E12 | Fourteen-tile root and twenty-tile compression | [Milestone report](evidence/README.md#source-064); [fourteen-tile receipt](../formal/evidence/Actual14Audit.json); [fourteen-tile semantic review](evidence/README.md#source-086); [grouped twenty-tile receipt](evidence/archive/runs/lean_next/theory/groups/grouped20_v3/result.json) |
| E13 | Twelve-tile root, data, and complete kernel receipt | [Final root source](../formal/lean/MahjongScale/Actual12V2/Root.lean); [757-row response data](evidence/archive/runs/lean_scale/actual12/pruned_v1/responses.json); [326-module receipt](evidence/archive/runs/lean_scale/actual12_kernel_v1/result.json); [complete semantic review](evidence/README.md#source-164) |
| E14 | Reusable proved registry | [Registry source](../formal/lean/MahjongScale/Actual12Registry.lean); [327-module receipt](../formal/evidence/ScaleRegistryAudit.json); [discovery metadata](evidence/archive/runs/lean_scale/actual12/checked_registry.json) |
| E15 | Check-cost and candidate-storage experiments | [Checker optimisation measurements](evidence/README.md#source-121); [paired checker result](evidence/archive/runs/lean_scale/performance/fastpositive_summary.json); [compact-storage comparison and progress](../formal/STATUS.json) |
| E16 | Physical-coordinate strategy | [Interface and validation scope](evidence/README.md#source-056); [44-case results](evidence/README.md#source-057); [opening witnesses](../results/opening.jsonl) |
| E17 | Incomplete opening and earlier-ancestor proofs | [Main candidate progress](../formal/STATUS.json); [ten-tile partial graph](evidence/README.md#source-108); [other twelve-tile candidate A](evidence/README.md#source-109); [candidate B](evidence/README.md#source-110) |
| E18 | Publication provenance | [Computational release record](evidence/archive/runs/publication_20260913/publication.json); [separate Lean publication record](evidence/archive/runs/lean_publication_20260913/publication.json); [earlier public reproduction guide](evidence/archive/runs/competition_20260913/source/docs/REPRODUCIBILITY.md) |

The following identities bind the most important claims. SHA-256 identifies the recorded bytes; it is not itself a proof of their mathematical content.

| Artefact | SHA-256 |
|---|---|
| Global acceptance receipt | `1cc4b9dc7bd287e976d42d6b7fb41eb548651529016e53485008828c97d826a5` |
| Global payload SHA-256 manifest | `a590af16189fe9acf22fae18d8a95095bcb9f9926db2d6eaa585511eea21e88c` |
| Foundational C++ rules | `1194d941c55b48c4ac686f29518c3fe032723a431125610b2a3509f8db04242f` |
| Global index source | `b742e5bbb20ed0df50665c0d454d3bf4b7691dabc4d2d0380e7159766f8bf0c8` |
| Twelve-tile 757-row response input | `a917aa5649940f01c5ae6cf7ca4f69f5c988bd78fb0fa8d9ba55a4572c81c31b` |
| Twelve-tile final Root source | `3e4bce43c9466b74a4a14263c73c9751bcef570b889020654c524648c796151e` |
| Twelve-tile 326-module receipt | `528aa59d3590c29ed05a21dbfea088aefdd4de11c76853e2303beceb1f488a6d` |
| Twelve-tile reusable registry receipt | `9355a8cd9a7d54dd10e51873f47596f18c965df9667c74c800a9ddb7d0b42ff2` |

The global format is `MJGLOBAL_PN_V1`, with index fingerprint `5a45ff3ea0fcf356`. The historical regional formats are described in Section 5.2 and E06. Their counts, compressed sizes, and intermediate values must not be combined as though they were one database with one bit convention.

Companion files for this review are [the mathematical audit](evidence/mathematical_evidence.md), [the computational audit](evidence/computational_evidence.md), [the Lean audit](evidence/lean_evidence.md), [reference verification](evidence/reference_verification.md), and [the source hash ledger](evidence/archive/runs/paper_20260913/source_ledger.json). They preserve technical detail without placing thousands of generated source rows in the narrative.

## Appendix F. Formal theorem and dependency catalogue

The rows below identify selected closed roots, including the smallest currently certified actual branch of the opening candidate. They do not exhaust the individual P states certified inside the tables. Every coordinate string lists the entire state, including zeros.

| Tiles | Exact count string | Closed original-game declaration | Receipt |
|---:|---|---|---|
| 12 | `0000000020000011110001110300000000` | `Mahjong.Scale12V2.original_second_player_wins` | E13 |
| 14 | `0000011110001000020001120300000000` | `Mahjong.Actual14.original_second_player_wins` | E12 |
| 20 | `0110330311010110001010110000000000` | `Mahjong.AnchorDAG.N24086.original_second_player_wins`; also `Mahjong.ResponseTableFull20.original_second_player_wins` and `Mahjong.ResponseTableGrouped20.original_second_player_wins` | E11–E12 |
| 28 | `0110440411010110101010110000001111` | `Mahjong.AnchorDAG.N09818.original_second_player_wins` | E11 |
| 30 | `0110440411010110111010110000011111` | `Mahjong.AnchorDAG.N02076.original_second_player_wins` | E11 |
| 32 | `1010110110000440411010110111111111` | `Mahjong.Extracted32.original_second_player_wins` | E11 |
| 34 | `1010440410110110111010110111111111` | `Mahjong.ExtractedFresh34.original_second_player_wins` | E11 |
| 34 | `0110440411010110111010110111111111` | `Mahjong.ActualCertificateSmoke.candidate_original_second_player_wins` | E09 |

The 28- and 30-tile states already occur in the accepted earlier `AnchorDAG`; later raw candidate summaries with similar labels are not the evidence for those theorems. The 757 new registry entries have proof IDs 0–756, and ID 756 is the twelve-tile root. Missing ID 757 is formally rejected by lookup.

Key generic declarations include `Mahjong.original_safe_reduction`, `RuleChecker.winB_iff_valid_and_win`, `RuleChecker.safeB_iff_valid_and_safe`, `MoveEnumeration.safeSuccessors_iff`, `Generators.checked_reference_sound`, and `Quotient.normalStrategy_iff`. The quotient theorem requires both coverage of actual moves and realisability of quotient moves; it does not certify a supplied C++ quotient by name. `Ranking.rank2_injective` and `Ranking.rank3_injective` establish natural-number colex arithmetic, not machine-integer correctness of the whole index.

For negative certificates, `StandardBoundCertificate.checkNoWin_sound` and `checkSafe_sound` connect checked capacity bounds to the declared rules. `MaskedLocalBound.transfer_false` and `CachedLocalBound.sound` support reuse of suitable local bounds. For response tables, the checked database and strict reference order support `ExternalResponses.checkDatabase_sound`; the resulting `PFact` values are what later registries reuse. The optimisations `FastPositive.check_eq` and `FastExternal.checkRange_eq` establish pointwise checker equality before concrete reduction results are transferred.

The earlier Mathlib line also contains `SharedMahjong.four_meld_extension`, `four_meld_candidates`, `winning_honor_le_three`, `win_add_honor_iff`, and `safe_add_honor_iff`. Its successful compile records certify those exact statements. They do not by themselves prove the full Boolean-cube theorem, honour-pass Grundy formula, or the opening result.

The accepted latest toolchain identifies itself as Lean 4.33.1, `x86_64-w64-windows-gnu`, commit `819816b2e0a3bf405af45ae5c7af2491d8f5bee6`. Its executable SHA-256 is `af49bacfabaa1fea71332ca0feae0fa1a60912219d5902291adc79f905bffb8d`. The accepted axiom audit allows `propext`, `Classical.choice`, and `Quot.sound`. No game outcome is introduced as an axiom. The native global generator is outside the logical trust boundary of the closed twelve-tile theorem.

An eventual opening certification must close the exact original-game type

```lean
Mahjong.SafeGame.SecondPlayerWins Mahjong.Step Mahjong.Win Mahjong.empty
```

without an unchecked certificate, imported P hypothesis, or unproved result parameter. The current records explicitly retain `END_TO_END_NOT_VERIFIED`. Module-level PASS and this end-to-end status are compatible because they refer to different obligations.

## Appendix G. Reproduction recipes and expected outcomes

### G.1. Public computational source

The following commands are taken from the versioned public reproduction guide. They are instructions for a new reproduction, not commands executed to prepare this paper. A 64-bit environment, Python 3.10 or later, a C++17 compiler with thread support, and sufficient output storage are required. The public global tools use standard-library Python and do not require zlib; the older regional tools have their own zlib/POSIX or Windows compatibility requirements.

```bash
git clone https://github.com/feierbuqiu/mahjong-achievement-game.git
cd mahjong-achievement-game
git checkout v0.1.0
python3 tools/verify_repository.py
python3 tools/reproduce.py build
python3 tools/reproduce.py smoke
```

A smoke pass checks packaging, exact layer counts, small index/edge cases, the complete 34-tile terminal layer, and its reverse replay. It does not regenerate the full opening result. The public guide documents Linux/GCC and Windows/MinGW-w64; macOS is not claimed as a tested platform for that snapshot.

For a complete new table, use a fresh output directory with at least the documented 110 GB of free output space:

```bash
python3 tools/reproduce.py run global_retro --data runs/paper_reproduction/table --min-layer 0 --max-layer 34 --threads 8 --seconds 43200
```

Resume an incomplete run with the same unmodified build and output directory. Exit code 2 denotes incomplete work, and initialisation or saving can extend a soft time budget. Memory limits in the frozen native tools have platform-specific telemetry; the measured Windows working set is not a hard portable operating-system limit.

Replay the entire table using a new record directory:

```bash
python3 tools/reproduce.py run push_verify_parallel_v3 --data runs/paper_reproduction/table --verified-dir runs/paper_reproduction/replay --build-id public-v0.1.0 --layers 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34 --threads 8 --max-seconds 43200
python3 tools/reproduce.py run verify_oracles --data runs/paper_reproduction/table --opening --output runs/paper_reproduction/opening.jsonl
python3 tools/reproduce.py run verify_oracles --data runs/paper_reproduction/table --fixtures results/oracles.tsv --output runs/paper_reproduction/oracles.jsonl
python3 tools/check_table_hashes.py --data runs/paper_reproduction/table
```

Acceptance requires every requested layer and bucket, `PASS_ALL_REQUESTED_LAYERS`, zero mismatches, empty P, six N opening classes, and 16,240 matching historical oracle states with no conflicts or UNKNOWN. Hash checking is a separate full-payload I/O operation. Preserve the fresh source version, commands, logs, coverage, and hashes.

A physical strategy query after an initial $`1m`$ is:

```bash
python3 tools/reproduce.py run strategy_physical --data runs/paper_reproduction/table --state 1000000000000000000000000000000000
```

The returned tile must be interpreted in the original input coordinates. A result requesting an unavailable fifth copy, silently substituting a canonical coordinate, or treating missing data as P would fail the intended interface contract.

### G.2. Published nonempty Lean proofs

The latest full source closure is now distributed on `main`, separately from the fixed `v0.1.0` computational tag. Use a checkout of the exact publication commit, install the pinned Lean 4.33.1 toolchain, and run:

```bash
python3 tools/verify_lean.py --entry latest --workers 2
```

This portable standard-library Python runner copies source into a new output directory, rebuilds all 374 modules required by the new 12-tile, 14-tile and compressed 20-tile audits, and checks their theorem types and allowed axioms with `--trust=0`. It does not reuse project object files or require the global bit table. Omitting `--entry latest` replays all 1,008 published modules. On Windows, use the available Python executable; `--lean` selects the pinned Lean executable explicitly.

The expected local-proof outcome is `kernel_modules=PASS`, with the relevant closed-root markers and axiom audits. The separate `empty_game_lean=NOT_VERIFIED` status remains. Add `--require-opening` to request exit code 2 while that opening obligation is incomplete. The historical 67.266-second measurement in Section 7.4 includes reused dependencies and must not be presented as the timing of this cold command. See the [formal reproduction guide](../formal/README.md) for provenance, exact audit entrypoints and resource limits.

### G.3. Audit of this manuscript

The local review deliverables include this manuscript, the three evidence memos, the reference-verification note, and a machine-readable source ledger. The document audit checks local link targets, exact 34-digit state lengths and tile totals, the 35-layer arithmetic, selected frozen hashes, and the presence of the required author, acknowledgements, AI declaration, and formal-proof boundary. These checks validate the report's assembly and traceability; they are not an additional mathematical or game-tree proof.
