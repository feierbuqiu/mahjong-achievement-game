import Mahjong.IndexSearch
import Mahjong.WeightedBlocks

set_option autoImplicit false

namespace Mahjong.IndexDecoder
open Ranking EnumerationBlocks IndexSearch GroupCandidates

def pair (seed : Nat → Nat) (r : Nat) : Nat × Nat :=
  let y := pairFloor r (seed r)
  (r-c2 y,y)

theorem pair_spec (seed : Nat → Nat) (r n : Nat) (bound : r < c2 n) :
    (pair seed r).1 ≤ (pair seed r).2 ∧ (pair seed r).2 < n ∧
    rank2 (pair seed r).1 (pair seed r).2 = r := by
  have f := pairFloor_spec r (seed r)
  have next := c2_succ (pairFloor r (seed r))
  have inside := pairFloor_bounded r (seed r) n bound
  simp only [pair,rank2]
  exact ⟨by omega,inside,by omega⟩

def allThree (seed : Nat → Nat) (n r : Nat) : Triple :=
  let z := tripleFloor r n
  let p := pair seed (r-c3 z)
  (p.1,p.2,z)

theorem allThree_spec (seed : Nat → Nat) (n r : Nat) (bound : r < c3 n) :
    (allThree seed n r).1 ≤ (allThree seed n r).2.1 ∧
    (allThree seed n r).2.1 ≤ (allThree seed n r).2.2 ∧
    (allThree seed n r).2.2 < n ∧
    rank3 (allThree seed n r).1 (allThree seed n r).2.1 (allThree seed n r).2.2 = r := by
  have z := tripleFloor_spec r n bound
  have step := c3_succ (tripleFloor r n)
  have residual : r-c3 (tripleFloor r n) < c2 (tripleFloor r n+1) := by omega
  have p := pair_spec seed (r-c3 (tripleFloor r n)) (tripleFloor r n+1) residual
  simp only [allThree]
  refine ⟨p.1,by have h := p.2.1; omega,z.1,?_⟩
  have eq := p.2.2
  unfold rank2 at eq
  unfold rank3
  omega

def distinct (a b r : Nat) : Triple := (r%a,(r/a)%b,(r/a)/b)

theorem distinct_spec (a b c r : Nat) (pa : 0 < a) (pb : 0 < b) (bound : r < a*(b*c)) :
    (distinct a b r).1 < a ∧ (distinct a b r).2.1 < b ∧ (distinct a b r).2.2 < c ∧
    radix a (distinct a b r).1 (radix b (distinct a b r).2.1 (distinct a b r).2.2) = r := by
  have q : r/a < b*c := (Nat.div_lt_iff_lt_mul pa).mpr (by simpa [Nat.mul_comm] using bound)
  have last : (r/a)/b < c := (Nat.div_lt_iff_lt_mul pb).mpr (by simpa [Nat.mul_comm] using q)
  exact ⟨Nat.mod_lt r pa,Nat.mod_lt (r/a) pb,last,by simp only [distinct,radix,Nat.mod_add_div]⟩

def firstTwo (seed : Nat → Nat) (a r : Nat) : Triple :=
  let p := pair seed (r%c2 a)
  (p.1,p.2,r/c2 a)

theorem firstTwo_spec (seed : Nat → Nat) (a c r : Nat) (pa : 0 < a) (bound : r < c2 a*c) :
    (firstTwo seed a r).1 ≤ (firstTwo seed a r).2.1 ∧ (firstTwo seed a r).2.1 < a ∧
    (firstTwo seed a r).2.2 < c ∧
    radix (c2 a) (rank2 (firstTwo seed a r).1 (firstTwo seed a r).2.1) (firstTwo seed a r).2.2 = r := by
  have pp := WeightedBlocks.c2_positive a pa
  have p := pair_spec seed (r%c2 a) a (Nat.mod_lt r pp)
  have last : r/c2 a < c := (Nat.div_lt_iff_lt_mul pp).mpr (by simpa [Nat.mul_comm] using bound)
  simp only [firstTwo]
  refine ⟨p.1,p.2.1,last,?_⟩
  rw [p.2.2]
  exact Nat.mod_add_div r (c2 a)

def lastTwo (seed : Nat → Nat) (a r : Nat) : Triple :=
  let p := pair seed (r/a)
  (r%a,p.1,p.2)

theorem lastTwo_spec (seed : Nat → Nat) (a b r : Nat) (pa : 0 < a) (bound : r < a*c2 b) :
    (lastTwo seed a r).1 < a ∧ (lastTwo seed a r).2.1 ≤ (lastTwo seed a r).2.2 ∧
    (lastTwo seed a r).2.2 < b ∧
    radix a (lastTwo seed a r).1 (rank2 (lastTwo seed a r).2.1 (lastTwo seed a r).2.2) = r := by
  have q : r/a < c2 b := (Nat.div_lt_iff_lt_mul pa).mpr (by simpa [Nat.mul_comm] using bound)
  have p := pair_spec seed (r/a) b q
  simp only [lastTwo]
  refine ⟨Nat.mod_lt r pa,p.1,p.2.1,?_⟩
  rw [p.2.2]
  exact Nat.mod_add_div r a

/-- Control-flow model of Index::decode_block, with arbitrary square-root seeds. -/
def decode (seed : Nat → Nat) (d : GroupInventory.Data) (a b c r : Nat) : Triple :=
  if a = c then allThree seed (d.size a) r
  else if a = b then firstTwo seed (d.size a) r
  else if b = c then lastTwo seed (d.size a) r
  else distinct (d.size a) (d.size b) r

theorem decode_correct (seed : Nat → Nat) (d : GroupInventory.Data) (checked : GroupInventory.Checked d)
    (a b c r : Nat) (ha : a < d.groups) (hb : b < d.groups) (hc : c < d.groups)
    (ab : a ≤ b) (bc : b ≤ c) (bound : r < WeightedBlocks.size d a b c) :
    let q := decode seed d a b c r
    Coordinates d a b c q.1 q.2.1 q.2.2 ∧ WeightedBlocks.rank d a b c q.1 q.2.1 q.2.2 = r := by
  have pa := (GroupInventory.group_facts d checked a ha).positive
  have pb := (GroupInventory.group_facts d checked b hb).positive
  by_cases ac : a = c
  · have ba : b = a := by omega
    subst b; subst c
    simp only [WeightedBlocks.size,↓reduceIte] at bound
    have q := allThree_spec seed (d.size a) r bound
    simp only [decode,WeightedBlocks.rank,↓reduceIte,Coordinates]
    exact ⟨⟨by omega,by omega,q.2.2.1,fun _ => q.1,fun _ => q.2.1⟩,q.2.2.2⟩
  · by_cases same : a = b
    · subst b
      simp only [WeightedBlocks.size,ac,↓reduceIte] at bound
      have q := firstTwo_spec seed (d.size a) (d.size c) r pa bound
      simp only [decode,WeightedBlocks.rank,ac,↓reduceIte,Coordinates]
      exact ⟨⟨by omega,q.2.1,q.2.2.1,fun _ => q.1,fun h => False.elim h⟩,q.2.2.2⟩
    · by_cases same2 : b = c
      · subst c
        simp only [WeightedBlocks.size,same,↓reduceIte] at bound
        have q := lastTwo_spec seed (d.size a) (d.size b) r pa bound
        simp only [decode,WeightedBlocks.rank,same,↓reduceIte,Coordinates]
        exact ⟨⟨q.1,by omega,q.2.2.1,fun h => False.elim h,fun _ => q.2.1⟩,q.2.2.2⟩
      · simp only [WeightedBlocks.size,ac,same,same2,↓reduceIte] at bound
        have q := distinct_spec (d.size a) (d.size b) (d.size c) r pa pb bound
        simp only [decode,WeightedBlocks.rank,ac,same,same2,↓reduceIte,Coordinates]
        exact ⟨⟨q.1,q.2.1,q.2.2.1,fun h => False.elim h,fun h => False.elim h⟩,q.2.2.2⟩

theorem decode_rank (seed : Nat → Nat) (d : GroupInventory.Data) (checked : GroupInventory.Checked d)
    (a b c x y z : Nat) (ha : a < d.groups) (hb : b < d.groups) (hc : c < d.groups)
    (ab : a ≤ b) (bc : b ≤ c) (coords : Coordinates d a b c x y z) :
    decode seed d a b c (WeightedBlocks.rank d a b c x y z) = (x,y,z) := by
  have correct := decode_correct seed d checked a b c (WeightedBlocks.rank d a b c x y z)
    ha hb hc ab bc (WeightedBlocks.rank_bound d a b c x y z ab bc coords)
  have eq := WeightedBlocks.rank_injective d a b c _ _ _ x y z ab bc correct.1 coords correct.2
  apply Prod.ext
  · exact eq.1
  · exact Prod.ext eq.2.1 eq.2.2

end Mahjong.IndexDecoder

#print axioms Mahjong.IndexDecoder.pair_spec
#print axioms Mahjong.IndexDecoder.allThree_spec
#print axioms Mahjong.IndexDecoder.distinct_spec
#print axioms Mahjong.IndexDecoder.firstTwo_spec
#print axioms Mahjong.IndexDecoder.lastTwo_spec
#print axioms Mahjong.IndexDecoder.decode_correct
#print axioms Mahjong.IndexDecoder.decode_rank
