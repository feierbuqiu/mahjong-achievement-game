> Archived evidence from the dated local research record. Historical progress and commands describe that record; current supported commands are in the repository reproduction guide. Links to retained attachments lead to their availability entries.

# Mathematical evidence audit for the September 2026 paper

Prepared for the manuscript on 13 September 2026. Scope: supplied definitions and rounds 1–8, read in place; no expensive searches repeated and no original source changed. Round 9, current global engineering, and recent concrete Lean certificates require the separate current-state audits. Source pointers below are relative to the research root and use one-based lines. Historical UNKNOWN statements are superseded only where a later completed result is explicitly identified.

## 1. Evidence language required in the manuscript

Use four distinct descriptions: **hand proof**, **exact finite computation**, **mathematical composition using computed lemmas**, and **Lean-checked theorem/certificate**. A mathematical statement can be rigorous without already being in Lean. Conversely, a generic verified checker does not establish a specific Mahjong root until its executable rules and data are connected to the declarative game. A cross-check of sampled states is implementation evidence, not exhaustive verification. A table checksum identifies bytes, not their mathematical truth.

Every state below specifies the complete table unless extra singletons or a closure domain are explicitly allowed. Letters naming different kinds must be distinct. H, J, and H_i denote honours; a, b, c, r denote suited kinds unless otherwise stated. All P/N labels refer to the player **to move**, not universally to the original first/second player. All SG values below belong to the SAFE normal-play game; only P/N equivalence with the achievement game has been established in the hand reduction.

The dates and old machine timings in historical reports describe those archived runs. Do not silently turn them into measurements of today's machine. The 41-root frontier and 12/35 eight-tile classification below describe the round-7/8 historical node and must be updated using round 9 in the final status section.

## 2. Definition, finiteness, and SAFE reduction

Primary source: `inputs/Description.txt:15–47,103–210,218–251`; concise final rule statement: `RESEARCH_HANDOFF.md:13–32` (line numbering should be rechecked if quoting the handoff in the final manuscript).

- T consists of 34 kinds: three suits of ranks 1,…,9 and seven honours. A state is x∈{0,…,4}^34. One move replaces x by x+e_i where x_i<4. Already played tiles are shared, retained, and available to both players.
- Let M be the 55 meld vectors: 34 triplets 3e_i and 21 suited runs e_r+e_(r+1)+e_(r+2). The ordinary winning vectors are h=2e_j+m_1+⋯+m_4 with each h_i≤4; the m_i need not be distinct. Seven pairs are 2Σ_(i∈I)e_i with |I|=7 and **distinct kinds**. Thirteen orphans are Σ_(i∈O)e_i+e_j for the 13 terminal/honour kinds O and j∈O. Let W be the union of these three families.
- Win(x) iff ∃h∈W, h≤x coordinatewise. This allows ignored surplus tiles. It excludes counting a four-of-a-kind as two pairs in seven pairs, treating a kong as a three-tile meld, yaku, scoring, draws, ownership, and restricted tile selection.
- Win is upward closed. The stock rank 136−|x| strictly decreases on every move. There is no exhausted, non-winning full inventory because the full inventory contains an ordinary winning vector. This gives a finite, deterministic, perfect-information impartial game with no draws. The later 37-tile theorem gives a much stronger stopping bound.
- Physical-tile hypergraph representation: 136 vertices, one 14-element edge for each physical instance of a winning multiset; both players build the same chosen set and the mover completing an edge wins. This is precisely the construction achievement game, rather than Maker–Breaker or individual-hand Mahjong. The source invokes Sieben's work, but all bibliographic details and theorem attributions must be checked externally.

**SAFE definition and equivalence (hand proof).** Define K={x: not Win(x) and ∀i with x_i<4, not Win(x+e_i)}. The reduced game permits only x→x+e_i∈K; a player with no such move loses. At x∈K, an original legal move cannot win immediately. A move outside K therefore hands the next player an immediate win. Deleting those losing options leaves the P/N recurrence unchanged. Backward induction on stock proves equivalence, including the case of no SAFE options. This is a statement of P/N and strategy preservation, not equality of original and reduced SG functions. Source: `inputs/Description.txt:740–815`.

An equivalent forbidden-family description is K={x: no u≤x with u=h−e_i, h∈W, h_i>0}. If x contains h−e_i but not h, then x_i=h_i−1<4, so the missing tile is physically available. This avoids an otherwise real capacity loophole. K is downward closed. Every table with at most 12 tiles is SAFE. Source: `inputs/Description.txt:778–813`.

**Exact P/N recurrence.** For SAFE x, P(x) iff every SAFE child is N; N(x) iff at least one SAFE child is P. SG(x)=mex{SG(y): y is a SAFE child}. UNKNOWN is a status of incomplete computation, not a game value. Outside-domain sentinels, unsafe sentinels, and budget exceptions are also distinct.

## 3. Extremal and elementary structural theorems

### 3.1 Maximum non-winning size: 37 (hand proof)

Source and full proof: `inputs/Description.txt:577–736`; independent written audit: `mahjong_progress/audit/audit_and_quartet_theorem.md:5–20`.

A 37-tile witness is 124578m 124578p 124578s H1⁴H2⁴H3⁴H4⁴H5H6H7. It has no suited meld; the only four available melds are the four honour triplets, which leave no pair. Only four kinds are paired, and all suited nines are absent. Adding an existing singleton makes a pair alongside the four triplets. Adding a missing suited rank 3,6,9 makes a run, used with three honour triplets and a pair from the fourth honour. Thus it is both non-winning and maximal non-winning.

For the upper bound, let q count kinds with at least two copies and t those with at least three. Remove one triplet of each of the t kinds. Let r be the number of kinds remaining and s the number of complete residual blocks among the nine fixed suited blocks 123/456/789. Then n=2t+q+r, r≤25+s, and the original table contains t+s disjoint melds. Non-winning implies q≤6, t≤4, and t=4 implies q=4. At n≥38, t+s≥13−t−q. If t≥1 and t+q≤8, obtain at least five melds including a triplet: use two tiles of that triplet as pair and four other melds. If t=0, there are at least seven disjoint runs; selecting an existing pair destroys at most two, still leaving four. The sole remaining case is t=3,q=6: the residual has three pairs and a run. If the run misses one paired kind, preserve it as pair with the three triplets; if it uses all three paired kinds, take two copies of the run, two triplets, and a pair from the third triplet. Contradiction in all cases.

Consequences: every legal original play ends by move 38; this bound is attained by an ordering of the 37-tile witness followed by any legal tile. It does **not** identify the optimally controlled game length or opening winner.

### 3.2 Maximum SAFE size: 34 (hand proof)

Source: `inputs/Description.txt:819–991`; audit: `mahjong_progress/audit/audit_and_quartet_theorem.md:16–20`.

A 34-tile SAFE witness is 124578m 124578p 124578s H1⁴H2⁴H3⁴H4H5H6H7. There are three triplets and no runs. One added existing singleton can make a pair but not the missing meld; one added missing suited rank can make a run but leaves no pair after four melds are selected. Seven pairs and orphans remain more than one tile away.

Suppose SAFE n≥35. Then q≤5, because six paired kinds occupy at most 24 tiles and any seventh singleton would complete seven pairs in one move. A SAFE table containing four disjoint melds D has size at most 16: every surplus kind must satisfy D_i=3 and contributes at most one fourth tile (otherwise D plus a pair gives a one-move completion). Hence t+s≤3. Combining n=2t+q+r and r≤25+s gives n≤28+t+q; only (t,q)=(3,4),(3,5),(2,5) remain.

For t=3,q≥4, select three triplets and a disjoint pair. The at-least-24 remaining tiles have at least 23 distinct kinds and hence at least 16 suited kinds. Some fixed block contains two residual ranks, which complete to a run with one tile. The chosen 11-tile core uses no kind more than three times, so the completion respects capacity.

For t=2,q=5, the residual after triplets has at least 26 kinds and three pairs, hence contains a fixed-block run C. If C uses all three paired kinds, duplicate it to obtain four melds, already excluded. Otherwise select an untouched pair together with C and the two triplets. At least 22 distinct residual kinds, including 15 suited kinds, remain. At most two suited kinds are saturated by the selected 11 tiles. If no legal completable residual two-tile block existed, each of the nine fixed blocks could hold at most one residual kind, except at most two blocks could hold two because of saturated missing kinds: at most 11 suited kinds, contradiction.

Consequences: if players never decline an immediate win, the game ends by move 36. There is no winner-parity conclusion. Maximal SAFE tables have mixed parity; the 13-tile H⁴3m⁴5m⁴4m and the 34-tile witness are explicit examples. K is not a matroid independence family, since it has maximal independent physical sets of different sizes (`inputs/Description.txt:995–1039`).

### 3.3 Minimum maximal SAFE size: 12 (hand proof)

Source: `mahjong_progress/audit/audit_and_quartet_theorem.md:22–32`. Every table of at most 11 tiles has a SAFE addition. The 12-tile four-run table 123456789m 123p is SAFE and any added kind i can be paired by another i while retaining the four runs; capacity is legal. Thus the minimum cardinality of a maximal SAFE table is exactly 12. Do not confuse minimum maximal size 12 with maximum SAFE size 34.

### 3.4 Four-meld tails: distinguish two theorems

**Hand theorem:** If SAFE x contains a fixed 12-tile four-meld vector D, every SAFE continuation can only consume a fourth copy of a kind with D_i=3. At most four such kinds exist; the full reachable SAFE game lies in a Boolean lattice with at most 16 states and depth at most four. Proof: D_i≤2 would allow D+2e_i as a winning vector; D_i=4 is exhausted; D_i=3 permits at most one additional tile. Sources: `mahjong_progress/mathematics/math_strategy.md:52–84`; `mahjong_progress/audit/audit_and_quartet_theorem.md:34–48`.

**Exhaustive computed strengthening:** For every valid D, all individually SAFE fourth-copy additions can be combined simultaneously while staying SAFE. Therefore every four-meld SAFE position has a unique maximal SAFE extension and its entire future is a full Boolean cube, with SG equal to the parity of remaining SAFE moves. The complete computation enumerated 10,573 symmetry representatives of four-meld roots and 53,487 root/subset pairs. An independent checker enumerating 14-tile submultisets verified every recorded pair, with zero differences. Roots: 6,020 P and 4,553 N. Distinct maximal extensions: 10,534 orbits, distributed as size 12: 2,778; 13: 3,587; 14: 2,796; 15: 951; 16: 422. Source: `mahjong_progress/audit/audit_and_quartet_theorem.md:50–140`. The second checker rechecked values, not an independent generator of every root; root completeness is justified by choosing four from the 55 meld types and applying valid symmetry.

Do not call the general full-cube property hand-proved. Round 2 proved only an additional necessary lemma: an individually SAFE fourth-copy candidate i must occur as triplet iii in **every** meld decomposition of D (`mahjong_round2/math/local_lemma.md:64–98`; round-2 report line 202 expressly says the full cube remains without a non-enumerative proof). The earlier Lean file formalised the expansion restriction and candidate bound, not a standalone cardinality theorem or full-cube result.

## 4. Exact compression and its mathematical limits

### 4.1 Rule symmetries

The verified symmetry subgroup is S7×(C2³⋊S3), of order 7!·2³·3!=241,920: permute honour kinds, independently reflect suited ranks r↦10−r, and permute suits. State canonicalisation reflects each suit to its smaller representative, sorts the suit blocks, and sorts honour counts. Arbitrary rank permutations are not valid. The source initially carefully describes a verified subgroup without asserting an exhaustive automorphism classification (`inputs/Description.txt:348–384`); safest manuscript wording is “the rule symmetries used”, rather than “the full automorphism group”, unless independently proven elsewhere. Orbit size is |G|/|Stab(x)|; group order is not a uniform compression factor. The empty state's one-tile continuations have six classes: one honour class and suited reflected ranks 1–5.

### 4.2 Honour fourth copies are independent passes

Hand proof: `mahjong_progress/mathematics/math_strategy.md:86–100`; implementation recurrence: `mahjong_progress/dead_passes/README.md:86–178`.

Let sat(x) replace each honour count 3 by 4, and let p be the number so replaced. No legal winning vector uses four copies of an honour. Those p remaining fourth copies affect neither present nor future SAFE legality of any other move. Thus the SAFE future is the disjunctive sum of the future of sat(x) and p independent one-move games, giving g(x)=g(sat(x)) xor (p mod2). New honour triplets created later remain part of the saturated base game; this does not invalidate independence of the initially available passes.

Store exact categories {0,1,≥2} rather than a single Boolean if pass parity is stripped. Xor 1 swaps categories 0/1 and preserves ≥2; ≥2 is **not** the numerical value 2. Nonempty masks represent partial knowledge and may only be narrowed by justified constraints. In the lazy version, P_p(y) means g(y)=p for p=0,1; pass-aware mex equations query only the required category. These are precise interfaces, not an assumption that any N becomes P after a pass. A fully physical two-channel Boolean recurrence is another correct implementation.

Numerical fourth copies remain genuine moves. E.g. D=111222333444m contains four triplets but adding the fourth 1m is not SAFE: the opponent adds 3m and takes 111+333+444+123+22. More generally, a suited fourth copy can join a run while the original triplet is retained. Source: `mahjong_progress/mathematics/math_strategy.md:82–84` and `mahjong_round5/math/two_honor_triplets_two_pairs.md:25–45`.

### 4.3 Current profiles do not preserve future values

Explicit hand-verifiable counterexample (`mahjong_progress/quotient/README.md:5–39`):

| State, with m and p empty | Complete SAFE moves | SG/P/N |
|---|---|---|
| X=789999s 666777z | the fourth copies of 6z and 7z | 0, P |
| Y=567999s 666777z | fourth 9s, fourth 6z, fourth 7z | 1, N |

Both 12-tile tables contain four melds. They have identical full current sets of achievable disjoint (meld, incomplete-meld, pair) triples, identical truncated-to-two missing-tile profiles for all (meld,pair) targets, and identical seven-pairs and orphans summaries. Nonetheless their future move sets differ. Thus even an exact hand-distance/shanten-style static profile is not a future game quotient. The detailed source proves their maximal extensions SAFE, so the argument does not require trusting a large minimax table.

The correct local quotient recursively uses signature(x)=(colour(x), sorted unique set of successor class labels). Compute from larger tile counts to smaller. Equal signatures give the coarsest strong bisimulation for the chosen colour, preserving the global product's safety and successor types. Duplicate moves to the same class do not affect mex. Hash equality alone is insufficient; full signatures are compared. The global game remains coupled through its winning predicate: local suit SG values cannot simply be xor-combined.

Exhaustive local figures (`mahjong_progress/quotient/README.md:41–136`): 5⁹=1,953,125 suited vectors; 978,125 reflection orbits; 590 static colours; 156,991 full coloured-DAG classes; 68,977 SAFE quotient classes including one UNSAFE absorber; 1,238,159 full edges and 540,058 SAFE-quotient edges including edges to UNSAFE. All local colours, complete successor sets, and reflection identities were checked. Layers 0–8 gain no compression beyond reflection. The count of full-game symmetry orbits at 12 tiles is 107,440,638; cumulative 0–12 is 155,511,067, all SAFE. These are exact orbit counts, not a lower bound on every possible game equivalence.

Contextual quotients strengthen colours only inside proved monotone domains and verify migrations on all 5⁹ local vectors. Final three-honour-pair strict classes are H222: 6,041; H223: 2,067; H233: 401 (`mahjong_round5/context/README.md:17–49`). Two-honour-pair classes are H22: 14,749; H23: 4,559; H33: 1,819 (`mahjong_round6/context/README.md:3–11,46–76`). These counts include absorber classes, differ from older looser 7,953/3,250 models, and are not whole-game node counts. Quotient keys must be tied to their exact fingerprint and migration map.

## 5. Hand-proved strategy families

### 5.1 Four honour pairs and expanded even-count invariant

`mahjong_round2/math/four_honor_pairs.md:5–101` proves H1²H2²H3²H4²=P with a complete response strategy; the opponent of the player to move wins by total table size 18 at latest. Maintain counts 0/2/4, support q=4…6 with at least four honours, and at most two four-of-a-kind kinds. Copy new kinds until seven pairs wins; copy a pair's promotion to its fourth tile while at most two quads result; if a third triplet arises and at least two pairs remain, promote another pair and win. The exceptional four-honour 4422 branch is answered by 4433, then pair the remaining fourth-copy passes or copy a new singleton to win. This covers all physical choices, not an honour-only subgame. Combinatorial family total: 298,984 P count vectors.

`mahjong_round3/pairing/expanded_invariant.md:6–91` expands the same strategy to 29,540,326 distinct labelled P vectors: all counts 0/2/4 with at most two quads and either (i) support q=4 entirely honours, (ii) q=5 with any two present suited ranks in the same suit separated by at least three, or (iii) q=6 with no supported suited run; plus four-honour 4433 and 4444 exceptions. The q=5 condition does not require any honour. Support generating functions are A(z)=1+9z+36z²+77z³+90z⁴+51z⁵+10z⁶ for no three consecutive selected ranks, and B(z)=1+9z+21z²+10z³ for pairwise distance ≥3. Multiply cube by (1+z)^7 and choose at most two quad kinds. The family counts overlap later theorem families and must not be added to them.

### 5.2 A solved Node Kayles endgame family

`mahjong_round2/math/two_suit_family.md:5–66` proves 3m7m H1³H2³H3³H4²=P. Its entire SAFE closure has fixed 3m,7m, fixed honour pair H4², three honour counts 3/4, three other honour counts 0/1, and p/s singleton supports with pairwise rank differences at least three. Every move leaving that description is a one-move completion for the opponent; in particular 3m and 7m block all m additions and keep both m terminals unavailable, eliminating orphans.

The p/s components are Node Kayles on the square of a nine-vertex path; six independent honour moves pair off. Mirror p/s moves and paired honour moves to prove the displayed root P. For all positions in the family, f(0)=0 and f(n)=mex{f(max(0,r−3)) xor f(max(0,n−r−2)):1≤r≤n}; f(0…9)=(0,1,1,1,2,2,0,3,3,1). Xor the remaining interval values and remaining honour-move parity. There are 41 possible independent supports per suit, so 41²·2⁶=107,584 labelled count vectors in this fixed family, before applying external rule symmetries. This disjunctive-sum description is proved only in that endgame, not for Mahjong's three suits in general.

### 5.3 Complete q6/six-paired-kind classification

Full hand proof and verification record: `mahjong_round3/opening_math/six_pairs_theorem.md:5–162`.

In SAFE q=6, no other singleton can exist, because duplicating it would win by seven pairs. No new kind can be added safely. Thus future support is fixed at six kinds. Let R be the multiset of lengths ≥3 of maximal consecutive runs in the suited support; R is one of [], [3], [4], [5], [6], [3,3]. Complete classification:

| R | SAFE count patterns | Common terminal size L | Fixed-support SAFE patterns |
|---|---|---:|---:|
| [] | At most two kinds are 3/4; others 2 | 16 | 73 |
| [3] | Three outside kinds 2; run counts are permutations of 222,223,224,233,234 | 15 | 16 |
| [4] | Outside kinds and run endpoints 2; middle pair is (2,2),(3,2),(2,3),(4,2),(2,4) | 14 | 5 |
| [5] | All six counts 2 | 12 | 1 |
| [6] | All six counts 2 | 12 | 1 |
| [3,3] | All six counts 2 | 12 | 1 |

Every maximal SAFE play within a row has length L−|x|. Consequently the **complete** SAFE SG is (L−|x|) mod2, and N(x)=(|x| mod2) xor 1_(R=[3]). Every SAFE edge reverses P/N. The proof excludes outside completion threats, not just internal supported moves: each non-four-meld SAFE pattern has at most two disjoint melds, and one added tile can increase that maximum by at most one.

The hand classification is independently checked over C(34,6)=1,344,904 bare six-pair supports: 1,266,064 P, 78,840 N; 13,616 rule-symmetry representatives. All 9,926,064 assignments of 2/3/4 to representative supports were tested; 891,815 SAFE assignments and 1,604,100 SAFE edges agree with the formula. The 891,815 count is not again globally symmetry-deduplicated.

### 5.4 Frozen-five family with two honour triplets

`mahjong_round3/five_pair/frozen_five_theorem.md:6–32` gives a hand response proof that H1³H2³X²Y²Z²=P for **any** three other distinct kinds X,Y,Z, without suited distance restrictions. Both honours saturated to 4 also gives P; exactly one saturated gives SG1/N. Labelled counts: 104,160 twelve-tile P, another 104,160 fourteen-tile double-saturated P, and 208,320 thirteen-tile single-saturated N.

Pair the two honour fourth-copy moves; a promoted pair hands the opponent four triplets and a remaining pair; copy a SAFE newly introduced kind to enter the solved q6 boundary. If X,Y,Z themselves form a suited run, the initial table already has four melds and only the two honour passes remain. Total winning size is at most 18.

The larger **region** additionally allows arbitrarily many singleton kinds, with exactly five paired kinds, two honour 3/4 kinds and three fixed pairs. SAFE iff no supported suited run and at most 11 distinct orphan kinds, apart from the no-singleton three-pairs-form-one-run four-meld exception. Pair promotions are unsafe; new singleton additions preserve the support restrictions; only a unique singleton can be safely duplicated to q6. After stripping passes, paired identities can be forgotten and the future depends on suited support masks and honour support count. This yields a 4,322,192-byte dense auxiliary table, with 4,270,954 entries filled in the recorded run, and 29,541 physical positions/424,333 edges checked. The auxiliary root is **not** the original empty table (`frozen_five_theorem.md:34–150`).

### 5.5 SAFE 44222 theorem

For any five distinct kinds U,V,A,B,C, if U⁴V⁴A²B²C² is SAFE, it is P. This is a hand proof, regardless of whether U,V are suited or honours (`mahjong_round4/math/safe_two_quads_three_pairs.md:3–91`).

If a supported run touches either quad kind, appropriate retained triplets and remaining pairs give a one-move ordinary completion, violating SAFE. If a run touches neither quad, it is ABC, so two copies of it plus the two triplets already form four melds and all permitted fourth copies are exhausted: terminal SAFE. If no run exists, a pair promotion permits immediate four-triplet-plus-pair response. For a newly introduced x, either it creates a run with an explicit immediate winning response (classified by using 0,1,2 quad kinds), or copying x gives terminal q6 with two quads and no run.

The SAFE premise cannot be replaced by checking only existing runs: 1m⁴2m⁴1p²2p²3p² has only a run in p, but adding 3m already wins as 111m+123m+123p+123p+22m. The supporting enumeration counted 2,698,284 SAFE members out of C(34,5)·C(5,2)=2,782,560 labelled 44222 vectors, of which 7,974 were terminal. The theorem is hand-proved; these population counts are computational (`safe_two_quads_three_pairs.md:93–102`).

### 5.6 Two honour triplets plus two pairs; related small families

`mahjong_round5/math/two_honor_triplets_two_pairs.md:3–105` hand-proves H1³H2³A²B²=P for any two other distinct kinds, with no distance restrictions. Pair honour passes to H1⁴H2⁴A²B²; pair promotions are answered by promoting the other pair to four triplets; new kinds are copied into frozen-five. Four-triplet target H1³H2³A³B³ is P: if A,B can share a run, their fourth copies are unsafe and only two honour passes survive; otherwise four independent fourth-copy moves survive.

For distinct suited a,b and distinct honours H,J, `mahjong_round7/design/two_quad_and_four_triplet_lemmas.md:7–68` hand-proves both a³b³H³J³=P and a⁴b⁴H²J²=P. The latter retains actual suited quads, does not strip them as passes; SAFE supported new kinds cannot make a run while the two suited quads and honour pairs are retained, and copying them gives a terminal q6 response. These lemmas supply two response classes of the later 35-root theorem, but do not handle every new-kind branch of that theorem.

## 6. Exact computed bases and mathematical compositions

### 6.1 Three-honour-triplet continuation domain

`mahjong_round3/abstraction/README.md:3–99` provides a complete finite recurrence for every SAFE table containing three honour triplets. Strip their independent fourth copies. Remaining ordinary targets reduce to “one meld and a disjoint pair” or “two melds”; orphans keeps at most eight of the ten still-relevant kinds. With no extra pair, use singleton supports without a run except for an isolated four-meld run leaf. With one extra pair, other singleton ranks form independent sets of path-square graphs; the paired suited vertex is deleted but its neighbours are **not** automatically blocked. Pair promotion and isolated-run exits are explicitly retained.

Recorded table: 2,650,132 no-extra-pair states plus 228,042 one-extra-pair states, 6,147,420 allocated bytes. The stripped bare root has SG1; three passes give H333 SG0/P. This is exact finite computation with a hand-proved recurrence, not a short hand strategy. Consequences: H233 is N; H333 and H443 are P; H433 and H444 are N. These are full-game positions, distinct from the restricted seven-honour-only game.

### 6.2 Three triplets plus a pair

`mahjong_round4/context/README.md:5–68` covers exactly three 3/4 kinds, one further paired kind, and arbitrary singleton kinds, with full original SAFE filtering. The residual singleton/fourth-numerical-copy supports must satisfy a path-square independent-set condition, used only as a **necessary** filter. A promoted pair exits to four-meld tails; all other moves are covered explicitly.

All 220 bare configurations “three arbitrary distinct triplets plus a different **honour** pair” (11 tiles) are N. Exact SG distribution: 187 classes SG1, 31 SG3, 2 SG4; 38,784,462 compressed states in the completed supporting domain, allocated 102,830,132 bytes. This is a useful direct demonstration that N is not uniformly SG1. A suited pair changes the conclusion: 1m³2m³4m³7m² is P, with further computed P examples (triplets; pair) (1,2,4;8), (1,3,4;7), (1,3,4;8), (1,3,5;8), up to suit/reflection. Those examples are **not** a complete classification of all suited-pair configurations.

### 6.3 Intermediate support-mask regions and exceptional windows

The mixed q5 region H1^(3/4)H2²H3²a^(3/4)b² plus singletons has exact SAFE conditions: orphan support ≤11; every present suited run contains a; if a=4 there is no run; if a=3 there cannot be two disjoint runs. In its future, b's precise location matters only when b=a±1 in the same suit. Honour fourth copies strip as passes; suited a's fourth copy remains an action. Source: `mahjong_round4/numerical_five/interior_theorem.md:3–75`. This region underlies many shallow response repairs.

For ABC consecutive suited ranks with two pairs and one singleton, plus H1³H2²H3² (12 tiles), all 21 exact SG values appear in `mahjong_round4/numerical_five/sequence_pair_theorem.md:43–69`: windows 123,234,456,678,789 all give (0,0,0) according to singleton position; 345 gives (1,4,2); 567 gives (2,4,1). The six exceptional N roots cannot be silently copied from the other fifteen P roots. They explicitly witness SG≥2. The regional reduction uses at most one disjoint suited run and orphan support ≤11, not a general static-profile game equivalence.

The expanded q5 H1^(3/4)H2²H3²A²B² with arbitrary singletons is SAFE exactly when there is at most one disjoint suited run and orphan support≤11. Honour-pair promotion requires no run and enters frozen-five, with the **new** honour pass contributing xor 1; suited-pair promotions require every run contain that kind and enter InteriorFive; unique-singleton copying is allowed only when no run and enters q6. Source: `mahjong_round5/q5/theorem.md:3–68`.

### 6.4 H222 and its supporting complete compositions

`mahjong_round4/dfs/all_rank_ten_strategy.md:3–80` establishes C(r)=r³H1³H2²H3²=P for all 27 suited kinds by complete responses and computed q5 leaves. New suited kinds are copied except the **directed same-suit** pairs (r,y)=(3,4),(5,4),(5,6),(7,6), which are repaired by promoting another honour pair. This is not a purely hand-proved all-rank result.

`mahjong_round5/math/eight_tile_and_six_tile_reduction.md:31–139` combines:

- D(a,b)=a²b²H222=P for any two distinct suited kinds. Spaced/different-suit cases have the hand invariant; gap-two and adjacent cases use finite response compositions. Last computed adjacent anchors are D(3,4) and D(4,5), with D(3,5) cross-supported; three-root calculation filled 195,791,749 auxiliary states, total table allocations including dependencies 330,104,972 bytes. No old full-state cache was used by that cold regional computation.
- B(r)=r²H222=P for every r. Old pair promotions enter C(r); every new kind is copied into the appropriate D or expanded invariant.
- H222=P. For an old honour-pair promotion, copy its fourth tile to H224=P; copy a new honour to four honour pairs; copy a new suited tile to B(r). H224 is a **computed leaf** from `mahjong_round4/search/honor_adaptive_final_run.json`, not a hand theorem. Thus the six-tile root is rigorous composition with computed lemmas.
- Consequences: rH222=N for all suited r; H221=N; H223=N by moving to H224=P.

Later extraction `mahjong_round6/math/pair_frontiers.md:5–17` also establishes L(r)=r²H224=P for all r, because the retained strict SG table gives r²H223 **exact SG1**, then one honour pass gives SG0. This uses exact SG evidence, not generic N xor 1.

### 6.5 H33 and the two-honour q3 matrix

Exact result and evidence: `mahjong_round6/math/two_honor_six_p_and_prefix.md:3–107`; `mahjong_round6/math/two_honor_matrix_mathematics.md:3–141`; final regional checkpoint `mahjong_round6/regions/q2_merged_checkpoint.bin` (physical B0 P/N format, not full SG).

H33=P was completed by the finite full SAFE two-honour q2/q3/q4 recurrence. H44=P follows by cancelling two passes; H34 has SG1; H23=N. Every seven-tile H33 child is N, with complete response representatives: fourth old honour→other fourth; new honour→suited terminal; suited1→same-suit9; suited2→9; suited3→7; suited4→7; suited5→5. Additional eight-tile P boundary: eH1³H2³H3 for suited terminal e and distinct third honour H3. The source explicitly avoids circularly using H44 derived from H33 as an independent premise: five independently computed eight-tile P boundaries plus two-pass transformations first prove H44, then H33.

Let K_r=r²H33, R_r=r³H33, Q_r=r⁴H33. The complete five-reflection-representative matrix is:

| Actual ranks r | K_r (8 tiles) | R_r (9 tiles) | Q_r (10 tiles) |
|---|---|---|---|
| 1,2,4,6,8,9 | N | P | N |
| 3,5,7 | P | N | N |

The P/N complementarity K_r=P iff R_r=N has a separate hand proof: simultaneously saturate both honours; all new-kind children of K'_r can be answered by copying into H1⁴H2⁴r²y²=P. Its only unaccounted option is R'_r. This explains complementarity but does not hand-prove the five R values or Q3/Q5. N roots have explicit P moves listed at matrix source lines 61–82. Rank parity or number of containing run windows does not explain the pattern: e.g. ranks 3,4,5 each lie in three windows but differ.

At the end of round 8, H22 and H24 remain UNKNOWN. All their honour moves are closed; five reflected suited singleton classes remain for each. H23=N only implies g(H24)≠1, not H24=P. Likewise the five r²H22 roots remained unresolved. These are historical labels to update only if newer evidence truly closes them.

### 6.6 Complete 35-root and 179-root matrices

**35-root computed theorem:** a³b³H²J²=P for every two distinct suited kinds and two distinct honours, exactly those ten tiles. `mahjong_round7/design/two_numeric_triplets_all_35_theorem.md:3–85`. There are 20 same-suit support orbits and 15 cross-suit orbits; these cover C(27,2)=351 suited supports, hence 351·C(7,2)=7,371 labelled physical count vectors. Exact full-region computation retains every new-kind action and numerical fourth copy. Original shared run: 13,239,301 q4 states plus 72,182,917 shared-q5 states; 973 physical states and 20,666 complete SAFE edges checked. A standalone source recomputes from rules and treats UNKNOWN separately. Migration independently cold-recomputed all 35 P roots (not all 179 roots). New-kind copying is not a universal hand strategy: copying 5 after same-suit triplets 3,4 gives 3³4³5²H22 with SG1/N.

**179-root computed theorem:** all bare a²b²c²H22 (10 tiles) for three distinct suited kinds, from `mahjong_round7/q5/complete_q5_layers.md:3–59,104–117`. Final file `all_three_numeric_pairs_complete.jsonl`: 165 P, 14 N, no UNKNOWN. Distribution: one suit 44=32P+12N; two suits 100=98P+2N; three suits 35=35P. Supports independently cross-checked from C(27,3)=2,925 labelled sets. Same-suit N support representatives are {1,2,3}, {1,2,7}, {1,2,9}, {1,3,5}, {1,4,5}, {1,5,6}, {1,6,7}, {2,3,4}, {2,5,6}, {3,4,7}, {3,5,6}, {4,5,6}, with reflection. Two-suit N: same-suit pair ranks 4 and5, plus another suit's rank2 or3, with independent reflections.

For example 1²2²7²H22=N with winning move same-suit3 to the eleven-tile P 1²2²3¹7²H22. Its 16 SAFE successor classes were checked N in the main solver; an independent sparse full recomputation hit a million-node limit, so the source expressly does not claim two independent complete solver proofs of that P child. This is a useful integrity qualification, even if later Lean certifies some related roots.

The full q5 solver covers T=0,1,2 where T counts kinds ≥3; T≥3 is necessarily unsafe because three triplets plus two pairs can be completed in one move. All count transitions 0→1,1→2,2→3,3→4 are covered. In q5, singleton-copy exits can be SAFE only when exactly one singleton exists; in q4, **every** singleton-copy must be considered. Source: `complete_q5_layers.md:61–102`.

### 6.7 Historical round-7/8 frontier and new q4 region

`mahjong_round7/math/four_pair_P_theorem.md:5–94` derives 12 P orbits among 35 M(a,b)=a²b²H22 roots, from the 35/179 matrices and prior theorems. Same-suit {2,8}; cross-suit reflected pairs (1,1),(1,2),(1,3),(1,4),(1,5),(2,2),(2,3),(3,3),(4,4),(4,5),(5,5). Labelled count 3,654. Remaining 23 were UNKNOWN, never N. The 483 nine-tile a²b²cH22 orbits had 442 N by copying c to q5 P and 41 UNKNOWN; this is one explicitly enumerated frontier, not the entire game. Round 9 should replace these as the current endpoint.

`mahjong_round8/regions/mixed_triplets_two_pairs.md:15–39,47–69` completes a q4 mixed-region implementation and one exact ten-tile P root: same-suit 3³4²H1³H2². The recorded run took 9.776 seconds, filled 1,037,860 states, and checked 403 physical states and 8,133 complete SAFE edges. It is not an all-mixed-q4 classification.

`mahjong_round8/audit/mixed_q4_and_T1_review.md:7–46` proves precise q4 SAFE formulas for q_H≥2,t_H≤1. Let A be maximum disjoint suited melds, B maximum suited melds while retaining a suited pair, and A⁺ the maximum A after one suited addition; e is orphan-kind support. With t_H=0: A≤2,e≤11. With t_H=1,q_H≥3: A≤1,e≤11. With t_H=1,q_H=2: A⁺≤2,B≤1,e≤11. These are domain-specific, not general Mahjong formulas. Counterexample to counting only fixed triplets is 1³2¹3²4¹H³J² (12 tiles): SAFE with suited A=2, B=1, A⁺=2 and total maximum meld count3. Audits compare formulas over 267,264 single-suit mixed cases, 500,000 cross-suit mixed cases, 500,000 general q4 cases, 294,890 successor classifications, plus 160 independently recursively solved tails; zero differences. They do not solve an unknown shallow root by themselves.

## 7. Failed strategies, refuted conjectures, and genuine open work

### 7.1 Refutations which can be stated as theorems

- **Permanent identical copying fails.** Source seed example H⁴3m⁴5m⁴4m (13 tiles): the next player cannot win at 14 because a 14-tile hand cannot contain H⁴; their legal y is copyable and the other player wins at15 using HHH+333+555+345+yy. `inputs/Description.txt:53–99`.
- **Every fixed rule-symmetry involution response fails.** Any involution on three suits fixes a suit and acts there as identity or reflection; any involution on seven honours fixes H. The first player forces H⁴4c⁴6c⁴ after six response pairs, then adds5c, yielding the same 15-move trap even if the second player abandons symmetry at14. Fixed non-involution rule permutations with a cycle≥3 become illegal by the tenth move after exhausting a kind and its image. This excludes predetermined symmetry responses, not adaptive strategies or arbitrary physical perfect matchings. `mahjong_progress/mathematics/math_strategy.md:7–50`. An alternate hand construction is H⁴3²4²5²6²7² at14 then3 at15 (`mahjong_round6/math/fixed_symmetry_mirror_counterexample.md:11–66`).
- **Copy first six rounds, then repair is too late.** The first player requests 1m,2m,3m,H1,H2,H3, producing q6 R=[3], an N root; promoting1 at13 gives P. Any later second-player strategy loses. This has a fully hand-proved q6 explanation. `mahjong_round6/math/pair_copy_refutation.md:3–50`.
- **Copy first five rounds, then repair is already too late**, using the computed q3 matrix: requests H1,H1,H2,H2,1m produce H1⁴H2⁴1m²=N; add the third1m to give P at11. `mahjong_round6/math/pair_q3_consequences.md:14–30`. Label its computed dependency.
- **All SAFE even-count tables are P is false.** Hand counterexample 1m²2m²3m²H1²H2²H3² is N by q6 R=[3]; all counts2, no quad. `six_pairs_theorem.md:125–131`. Another exactly computed/certified early counterexample is 9m²9p⁴8s²9s⁴=N with move7s to P (`mahjong_round3/pairing/expanded_invariant.md:93–108`).
- **Every 33222 root is P is false.** H³4m³1m²2m²3m² (state `2223000000000000000000000000000003`) is N with unique SAFE move the fourth H; then terminal SAFE P. Adding numerical fourth4 is unsafe: reply third1 wins as HHH+111+234+234+44. This is a hand counterexample; a two-state search confirms it. `mahjong_round4/math/two_triplets_counterexample.md:3–85`.
- **Every five-pair root is P is false.** The 14 N classes of the complete 179 table are counterexamples, including 1²2²7²H22. This does not decide the four-pair predecessor.
- **Fixed four-meld shape or maximal size parity determines the empty winner is false as a method.** Mixed-parity maximal SAFE examples and the static-profile X/Y pair refute the specific simplifications; they do not prove no short strategy exists.
- **A winning move found after bad copying cannot simply be played a move earlier.** If Q=S+c and Q+d=P, then S+d=N because its opponent can add c to reach that same P. The additions commute. `mahjong_round7/math/four_pair_P_theorem.md:96–116`. Useful exact exclusion of candidate repairs, not a global strategy impossibility theorem.

### 7.2 Reachable domains do not imply reachable favourable values

`mahjong_round6/math/controlled_prefix_and_boundary.md:8–51,136–174` is central to the manuscript's quantifier discussion. Neither player can force the table to be **exactly** H222: the other can put down a suited tile, which never disappears. Either player can force the upward domain of three fixed honour pairs within six own moves, by reducing the sum of deficits to two copies; at most move11 for first player or12 for second, safely before any win. Likewise the domain of two fixed honour triplets can be reached in six own moves. But entry may contain extra tiles and may occur on either player's move. A controlling-player entry requires a P boundary for the opponent; an opponent entry requires an N boundary for the controller.

The shallow q_H≥3 domain through12 tiles has 69,362 rule-symmetry classes: by sizes6…12, (1,7,55,358,2,123,11,332,55,486), with 13,876 through11. These are all possible boundary-domain states, not leaves reachable under one single policy and not the number of internal solve states. A particular archived policy had 12,679/62,179 leaves for the two controllers. The hand count and checked enumerator are in `controlled_prefix_and_boundary.md:54–134`.

Purely filling fixed honour-pair deficits until entry can be defeated for **both** controllers, even when deficit choice is adaptive. The first-player version is lured to rH222=N for the opponent, who copies r to B(r)=P; the second-player version is lured to H233=N and the opponent completes H333=P. `mahjong_round6/math/pair_greedy_counterexamples.md:13–69`. The analogous two-fixed-triplet policy is also refuted for both players using H33=P or r³H33=P (`two_honor_six_p_and_prefix.md:138–183`). The general entry domain is forceable; these specific entry policies are losing. A richer strategy is not ruled out.

### 7.3 What remains conjectural or unfinished

- Empty-table P/N and all six first-move classes are UNKNOWN in the delivered round-8 snapshot. No finite percentage of the opening is justified from cache count or this local frontier count.
- No successful opening response invariant or controlled-prefix strategy has been proved. A complete solution needs the correct existential/universal move quantifiers and exact leaves, not merely a set of local P roots.
- The full Boolean-cube four-meld property had an exhaustive computer proof but no short hand proof in rounds1–8. Local necessary decomposition lemmas are available.
- The arithmetic pattern K_r=P exactly at r=3,5,7 is computed; a simple geometry-based human proof of those specific roots is not present. Its K/R complementarity is hand-proved.
- A full q5 algorithm is not a constant-time solution to every q5 input; contexts and downstream tables can still be large, and a finite algorithm's existence is not a practical resource guarantee.
- Data-driven guesses such as “all M are P”, uniform pair/quad parity, pure copying, and arbitrary static-profile equivalence have either been refuted or were never established. Do not list refuted statements as promising unresolved conjectures.
- Historical random sampling found maximal SAFE witnesses of sizes12–16 and22–34; missing observed sizes17–21 were not proved absent. The archive explicitly forbids using that absence as a pruning rule (`mahjong_progress/audit/audit_and_quartet_theorem.md:148`). Check whether later global work resolves this before presenting it as current.

## 8. Early Lean foundation: historical scope only

Source: `mahjong_round2/lean/README.md:1–55`; actual source `mahjong_round2/lean/SharedMahjong.lean`. The 341-line file was checked in the official Lean4.33.0 Playground with a preserved source hash and diagnostic record; the report did not claim local compilation at that time. No `sorry`, self-added `axiom`, or `native_decide`; standard dependencies recorded as `propext`, `Classical.choice`, `Quot.sound`.

It defines the full declarative tile/game rules and proves stock descent, no inventory-exhaustion draw, the four-meld surplus restriction, at most four fourth-copy candidates, generic well-founded Boolean solve, complete/partial certificate soundness, executable finite label checker soundness, and response-invariant losing soundness. It did **not** at that node prove the SAFE reduction in Lean, connect a concrete Mahjong strategy certificate to executable rules, verify the full four-honour-pair strategy, prove full Boolean cubes, or solve the empty game. The current Lean audit should explain what has since been filled in, rather than copying these historical exclusions into current status unchanged.

## 9. Potential reporting traps identified in the archive

1. `mahjong_round2/math/four_honor_pairs.md:3` says the original search certificate had 1,026 nodes, while `mahjong_round2/RESEARCH_REPORT.md:89–91` describes an independently generated DFPN certificate with 1,002 nodes and a hand-strategy certificate with 1,061 nodes. These can be different runs, but the paper should use an actual named certificate and its JSON metrics if giving counts, not conflate them. The hand theorem itself is unaffected.
2. SG-category table row counts are not counts of exact numerical SG values. `CHECKPOINTS.md` distinguishes masks, physical Boolean P/N, and dense region formats. Old constraint-table keys must not be read under a new quotient fingerprint.
3. Layer/context allocations include unused/infeasible cells; cumulative fills can include LRU eviction and recomputation. They are not necessarily distinct physical states.
4. The source group's order is a valid symmetry order; completeness as the entire automorphism group was not proved in the reviewed text.
5. The input file's bibliographic statements are research inputs. They must be independently checked before APA7 citation, particularly exact ACV/AVD conventions and external proposition numbers.
6. Historical “no Lean proof” labels are relative to their round; the newer 12-tile certified root must be reported with current files and theorem names. It cannot automatically upgrade every generic P family or old million-state computation to Lean-certified status.
7. The formal rules should be presented as definitions and modelling assumptions. Do not call a desired winner or every imported computational value an axiom. Lean's foundational axioms should be declared separately from the chosen game's rules.

## 10. Suggested manuscript coverage and appendix allocation

Main narrative can follow: problem and related model; exact game definition; SAFE reduction and extremal bounds; four-meld/q6/frozen-five structure; response families and computed shallow matrices; future-preserving compression and solver architecture; latest local closure and concrete Lean evidence; limitations and research programme. Important negative results deserve a section because they explain why seemingly elementary parity/copying solutions failed.

Appendices can carry the full 37/34 proofs, q6 pattern table and completion witnesses, all14 N representatives of the179 matrix, a theorem-to-file-and-evidence ledger, exact Lean theorem/certificate manifest, and reproducibility commands. The archive's chronological process can be summarised as mathematical discovery plus targeted computation, followed by explicit response extraction and independent/formal checking; avoid an undifferentiated diary of every failed timeout.

This memo used the memory registry only to confirm the checkpoint-first, state-scoped evidence convention (`MEMORY.md:4`), not as proof of any numerical or mathematical result; every substantive result above was read from the current workspace. Corresponding memory rollout ID for orientation: `01a096ce-f352-7541-b7b3-21ebf98c2b9b`.

## 11. Ready-to-use appendix prose and strengthened Theorem 5 proof

The following is recommended manuscript prose, rather than another result claim. It can be incorporated into Appendices A and B with the manuscript's own numbering and evidence links.

### Appendix A. Proofs of the extremal bounds

**A.1. Largest nonwinning table.** Let n=|x|, q=|{i:x_i≥2}|, and t=|{i:x_i≥3}|. Remove one triplet from each of the t kinds. The residual multiset R has all counts at most two and has exactly q−t paired kinds. If r is its support size, then

```math
n=3t+r+(q-t)=2t+q+r.
\tag{A1}
```

Partition each suit into the three fixed blocks 123,456,789. Let s count the blocks all of whose ranks occur in R. These blocks provide s mutually disjoint runs, disjoint also from the removed triplets. The other nine−s blocks contain at most two supported ranks, while honours contribute at most seven. Therefore

```math
r\le3s+2(9-s)+7=25+s.
\tag{A2}
```

Suppose n≥38 and x is nonwinning. Seven pairs gives q≤6. Five triplets would supply four triplets and a pair, so t≤4; if t=4, an additional paired kind would win, hence q=4. Combining (A1)–(A2) yields

```math
t+s\ge13-t-q.
\tag{A3}
```

If t≥1 and t+q≤8, at least five disjoint melds exist, including a triplet. Reserve two tiles of that triplet as the pair and choose four other melds. If t=0, (A3) supplies at least seven disjoint runs. Because n≥38 exceeds the number of kinds, some pair exists; selecting it removes at most two of those runs and leaves at least four.

The only case not covered is t=3,q=6. Here R contains three paired kinds and, by (A2), at least one run. If that run does not touch all three paired kinds, one untouched pair can accompany the run and the three removed triplets. If it touches all three, the residual contains two copies of the run, which can accompany two triplets and a pair taken from the third triplet. All cases contradict nonwinning. Thus n≤37.

Equality is attained by taking ranks 124578 once in each suit, H1⁴H2⁴H3⁴H4⁴, and singletons H5,H6,H7. No numerical meld exists. The four honour triplets leave only singletons, so there is no ordinary target; fewer than seven kinds are paired, and the suited nines needed for orphans are absent. This is a valid 37-tile nonwinning table.

**A.2. Largest SAFE table.** First, if a SAFE table contains four disjoint melds with union D, it has at most16 tiles. Any residual tile e_i with D_i≤2 exhibits the forbidden thirteen-tile submultiset D+e_i of the valid winning target D+2e_i. If D_i=4 there is no residual copy available. Thus residual tiles can occur only at coordinates D_i=3, each at most once; D has at most four such coordinates.

Now suppose a SAFE table has n≥35. It must have q≤5: with six paired kinds, at least one of its more than24 tiles lies at a seventh kind, so duplicating that singleton immediately completes seven pairs. It cannot contain four melds by the preceding bound, so t+s≤3. Equations (A1)–(A2) imply

```math
n\le2t+q+25+s\le28+t+q.
\tag{A4}
```

Since t≤3 and q≤5, only (t,q)=(3,4),(3,5),(2,5) remain possible.

For t=3 and q≥4, select the three triplets and a pair of another kind. The at-least24 residual tiles have at most one paired kind, so at least23 kinds remain, at least16 of them suited. Among the nine fixed blocks, some contains two different residual ranks. Complete this pair of ranks to its block's run. The selected 11-tile core uses each kind at most three times, so adding the missing rank to the run never requires a fifth copy. If the required tile is already on the table the target is already present; otherwise the available missing copy wins in one move. Both contradict SAFE.

For t=2,q=5, after removing the two triplets the residual R has r=n−9≥26 supported kinds and three paired kinds. Equation (A2) guarantees a run C. If C touches all three paired kinds, two copies of C together with the two triplets give four melds, already impossible. Otherwise select a pair of a kind untouched by C. The two triplets, C, and this pair form an 11-tile core D.

Removing C and that pair from R removes at most four supported kinds. At least22 kinds, at least15 suited, remain. At most two numerical kinds are already used four times in D, namely a removed triplet kind that also occurs in C. Call these saturated kinds. If a fixed block contains two residual ranks and the missing third is not saturated in D, those two ranks can be completed to a legal run disjoint from the selected core's copies, again giving a target present or completable in one move. Thus, under the SAFE assumption, a block without a saturated kind contains at most one residual suited kind; a block containing a saturated kind contains at most two. At most two blocks can be exceptional, allowing at most9+2=11 residual suited kinds. This contradicts15. Hence no SAFE table has35 tiles.

Equality is attained by the same three suited supports124578, this time with H1⁴H2⁴H3⁴H4H5H6H7. The table has three triplets and no runs. One additional singleton copy can make a pair but cannot supply a fourth meld. A newly supported numerical rank can make one run, but the four selected melds then leave no pair. The seven-pairs and orphans targets are also more than one tile away. Its size is34 and it is SAFE. ∎

### Appendix B. Six-pair classification and a constructive frozen-five proof

**B.1. Six supported paired kinds.** Suppose x is SAFE and q(x)=6. There is no other singleton, since duplicating it would complete seven pairs. A new kind is never a SAFE move. Within the fixed six-kind support, all runs lie in a maximal consecutive numerical segment of length at least three. Its possible length multiset R is [],[3],[4],[5],[6], or[3,3]. Kinds outside these segments are called outside kinds; they may themselves be numerical, but cannot participate in a run inside the fixed support.

For R=[], the only current melds are triplets. At most two kinds may have counts≥3: if there are three, promote a fourth kind and use a fifth as pair to win. Conversely, with at most two triplet kinds, any one added tile can increase the maximum number of disjoint melds by at most one, so no ordinary target is obtainable in one move. Every maximal SAFE continuation ends with two counts4 and four counts2, at size16.

For R=[3], write the numerical segment as abc and the outside kinds as H,J,K. All outside counts must be2. If H≥3, promoting J permits two abc runs, HHH, JJJ, and KK. On abc, three counts at least3 provide three disjoint runs, while two counts4 provide two triplets and an abc run. In either case promoting an outside kind gives a fourth meld while another outside pair remains. Excluding these cases leaves exactly the permutations of222,223,224,233,234. These patterns contain at most two disjoint melds and are SAFE. Their only terminal pattern is234, at size15.

For R=[4], write the segment abcd and the outside kinds H,J. The outside counts must be2, because a promoted outside kind together with the other's promotion permits two abc runs and the remaining endpoint pair. Both endpoints must be2: an endpoint triplet plus two runs on the other three ranks and a promoted outside kind would win with the other outside pair. The middle counts cannot both exceed2, because then two abc runs and one bcd run can be combined with an outside promotion and the other outside pair. The only possibilities for the middle pair are (2,2),(3,2),(2,3),(4,2),(2,4). Each has at most two disjoint melds and is SAFE. Terminal patterns are (4,2) and (2,4), at total size14.

For R=[5], write the segment abcde and its outside kind H. The all2 table is SAFE by its size12. Every existing-kind promotion is unsafe, as shown by the following complete list; a new kind is answered by copying it to seven pairs.

| First added kind | Winning reply | Four melds and pair selected |
|---|---|---|
| a | H | aaa + bcd + bcd + HHH + ee |
| b | H | bbb + cde + cde + HHH + aa |
| d | H | ddd + abc + abc + HHH + ee |
| e | H | eee + bcd + bcd + HHH + aa |
| H | a | aaa + bcd + bcd + HHH + ee |
| c | c | abc + abc + cde + cde + HH |

Thus the all2 table is terminal SAFE, and downward closure excludes every larger pattern. For R=[6] or[3,3], the all2 support already gives four disjoint runs. Any added kind can be copied, retaining the runs and using the two added copies as pair; even an existing supported kind requires at most four copies. These all2 tables are likewise terminal SAFE.

This classification also verifies threats from **outside** the fixed support. In the non-four-meld patterns above, at most two disjoint melds can be selected before a move. Any decomposition after one added tile loses at most one meld when the added tile is removed, so at most three melds can exist afterwards. Seven pairs cannot be completed in one move because no seventh-kind singleton exists, and at most seven supported kinds after that move cannot give thirteen orphans. The four-meld all2 cases are SAFE by having only12 tiles. Thus checking the six supported upgrades has not silently restricted the original34-kind game.

Every SAFE play in a fixed row terminates at its common size L∈{16,15,14,12,12,12}. Backward induction shows its SG equals (L−|x|) mod2: terminal SG is0 and every child at the next size has the opposite parity. This proves equation(8), and in this particular region proves the stronger fact that the only SG values are0 and1. The counts of the six bare support classes can then be obtained independently by finite support enumeration or generating functions.

**B.2. Complete constructive proof of Theorem 5.** Consider F=H³J³X²Y²Z² with all five kinds distinct and H,J honours. Before each ordinary opponent turn, maintain the family in which X,Y,Z have count2, there are no other kinds, and H,J have either both count3 or both count4. The two possible honour modes have an even number of unconsumed fourth copies. These tables are SAFE. If XYZ do not form a run, they have only the two honour melds, and one tile can raise the maximum meld count to at most three. If XYZ form a run, the table consists of two copies of that run and two honour triplets, possibly with the two harmless fourth honours; its only SAFE moves are the available fourth honours. In either case seven pairs and orphans are impossible in one move. Equivalently, SAFE for the both4 mode follows from the fact that a target must omit both surplus fourth honours and has at most13 useful tiles after the next addition.

In the run case, pair the two honour fourth-copy moves; every other action is outside SAFE and is answered by immediate victory. Hence this case is P. In the non-run case the opponent has exactly three kinds of legal action:

1. **Consume an honour fourth copy.** Consume the other one. This restores the family with both counts4. The responding move is legal and SAFE by the preceding argument.
2. **Promote one of X,Y,Z from pair to triplet.** Promote a different one. Select the two honour triplets, the two newly completed triplets, and the remaining pair; this is an immediate legal ordinary win.
3. **Introduce a new kind u.** If the resulting table is not SAFE, take its immediate winning move. Otherwise the new support contains no suited run. Indeed, any newly present run must consist of u and two of X,Y,Z; duplicating u would then give two copies of that run, both honour triplets, and the unused third pair, an immediate win, contradicting that the opponent's u move was SAFE. Therefore duplicate u into a table with six paired kinds, two honour triplet/quad kinds, four other pairs, and no numerical run.

The response in case3 is SAFE: it has only two disjoint melds and no singleton, so one move cannot produce an ordinary win or seventh pair, while orphans is excluded by the support size. Its complete future is explicit. Promoting any other pair leaves three triplets and at least two other pairs, permitting an immediate fourth-triplet-plus-pair response. Introducing a new kind permits immediate seven-pairs copying. The only SAFE moves are therefore the available fourth honours, whose count is even; pair them and then answer any departure with an immediate win. This six-paired-kind target is P without assuming any unverified value from the larger frozen-five table.

The three cases cover all34 physical kind choices; H,J at4 are exhausted and there are no old singletons in F. Each response either wins or returns to a proved P family. At most the two honour passes and one newly copied pair are consumed before the opponent is forced to provide an immediate completion. Thus the twelve-tile root is P, with victory by total size18 at latest. This is a self-contained response proof of the bare theorem; the much larger support-mask region is useful computationally but is not a premise needed for the theorem. ∎

## 12. Review of manuscript sections 1–4 (draft read during this audit)

The current global result is outside this sub-audit; I observed the draft's newer P opening result and have not attempted to override it using historical UNKNOWN entries. Within the reviewed mathematical sections, Propositions1,7, Theorems2–6 and the local179-class table match the archived claims with these recommended changes:

- Section4.4 should describe a²b²H33 as a **mathematical response theorem**, not merely an exact regional result; the stronger theorem permits any two other distinct kinds, including honours (`mahjong_round5/math/two_honor_triplets_two_pairs.md`).
- Proposition7's proof is cleaner with “D_i=3 exactly”; D_i=4 allows no residual copy. The displayed16 bound and four-state-candidate argument otherwise hold.
- Theorem5 should use the explicit two-family response proof in B.2 above rather than vaguely referring to a controlled region or an unshown invariant.
- Section4.1 may state that within this particular proved q6 domain the complete SG is0/1; the caution that N does not **in general** specify SG1 remains necessary elsewhere.
- Broad-coverage additions still desirable: minimum maximal SAFE size12; the four-honour/expanded29,540,326-P response invariant; the107,584-position Node Kayles family; H333 and the two-honour q3 matrix; the345/567 exceptional SG windows; the predeclared-mirror and finite-copy-prefix refutations. These prevent the report's “from beginning to end” scope from omitting substantial earlier results.
- No mistake was found in the draft's exhibited13-tile terminal SAFE response, numerical fourth-copy counterexample, static-profile X/Y counterexample, or the bare-scope distinctions of its35/179 classifications.
