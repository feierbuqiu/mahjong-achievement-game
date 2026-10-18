import Mahjong.Ranking

set_option autoImplicit false

namespace Mahjong.IndexSearch
open Ranking

/-- Natural-number model of the production lower/upper bracketing loop. -/
def bracketSearch (f : Nat → Nat) (r lo hi : Nat) : Nat :=
  if lo+1 < hi then
    let mid := (lo+hi)/2
    if f mid ≤ r then bracketSearch f r mid hi else bracketSearch f r lo mid
  else lo
termination_by hi-lo
decreasing_by all_goals omega

theorem bracketSearch_spec (f : Nat → Nat) (r lo hi : Nat)
    (ordered : lo < hi) (lower : f lo ≤ r) (upper : r < f hi) :
    let z := bracketSearch f r lo hi
    lo ≤ z ∧ z < hi ∧ f z ≤ r ∧ r < f (z+1) := by
  rw [bracketSearch]
  split
  · rename_i span
    dsimp only
    split
    · rename_i middle
      have result := bracketSearch_spec f r ((lo+hi)/2) hi (by omega) middle upper
      exact ⟨by have h := result.1; omega,result.2⟩
    · rename_i middle
      have result := bracketSearch_spec f r lo ((lo+hi)/2) (by omega) lower (by omega)
      exact ⟨result.1,by have h := result.2.1; omega,result.2.2⟩
  · rename_i span
    have endPoint : hi = lo+1 := by omega
    exact ⟨Nat.le_refl _,ordered,lower,by rwa [← endPoint]⟩
termination_by hi-lo
decreasing_by all_goals omega

theorem c2_at_least (n : Nat) : n ≤ c2 n := by
  induction n with
  | zero => simp [c2]
  | succ n ih => rw [c2_succ]; omega

/-- Integer correction upward; the initial floating estimate is abstracted out. -/
def adjustUp (r y : Nat) : Nat :=
  if c2 (y+1) ≤ r then adjustUp r (y+1) else y
termination_by r+1-y
decreasing_by
  have h := c2_at_least (y+1)
  omega

theorem adjustUp_upper (r y : Nat) : r < c2 (adjustUp r y + 1) := by
  rw [adjustUp]
  split
  · exact adjustUp_upper r (y+1)
  · omega
termination_by r+1-y
decreasing_by
  have h := c2_at_least (y+1)
  omega

def adjustDown (r : Nat) : Nat → Nat
  | 0 => 0
  | y+1 => if r < c2 (y+1) then adjustDown r y else y+1

theorem adjustDown_spec (r y : Nat) (upper : r < c2 (y+1)) :
    c2 (adjustDown r y) ≤ r ∧ r < c2 (adjustDown r y + 1) := by
  induction y with
  | zero => simpa [adjustDown,c2] using upper
  | succ y ih =>
    simp only [adjustDown]
    split
    · rename_i smaller
      exact ih smaller
    · exact ⟨by omega,upper⟩

def pairFloor (r seed : Nat) : Nat := adjustDown r (adjustUp r seed)

/-- The two correction loops are correct for every natural-number seed. -/
theorem pairFloor_spec (r seed : Nat) :
    c2 (pairFloor r seed) ≤ r ∧ r < c2 (pairFloor r seed+1) :=
  adjustDown_spec r (adjustUp r seed) (adjustUp_upper r seed)

theorem pairFloor_bounded (r seed n : Nat) (bound : r < c2 n) : pairFloor r seed < n := by
  have lower := (pairFloor_spec r seed).1
  by_cases inside : pairFloor r seed < n
  · exact inside
  · have monotone := c2_mono (a:=n) (b:=pairFloor r seed) (by omega)
    omega

theorem pairFloor_seed_independent (r a b : Nat) : pairFloor r a = pairFloor r b := by
  have x := pairFloor_spec r a
  have y := pairFloor_spec r b
  by_cases xy : pairFloor r a < pairFloor r b
  · have step := c2_mono (a:=pairFloor r a+1) (b:=pairFloor r b) (by omega)
    omega
  · by_cases yx : pairFloor r b < pairFloor r a
    · have step := c2_mono (a:=pairFloor r b+1) (b:=pairFloor r a) (by omega)
      omega
    · omega

def tripleFloor (r n : Nat) : Nat := bracketSearch c3 r 0 n

theorem tripleFloor_spec (r n : Nat) (bound : r < c3 n) :
    tripleFloor r n < n ∧ c3 (tripleFloor r n) ≤ r ∧ r < c3 (tripleFloor r n+1) := by
  have positive : 0 < n := by
    by_cases zero : n = 0
    · simp [zero,c3] at bound
    · omega
  exact (bracketSearch_spec c3 r 0 n positive (by simp [c3]) bound).2

end Mahjong.IndexSearch

#print axioms Mahjong.IndexSearch.bracketSearch_spec
#print axioms Mahjong.IndexSearch.adjustUp_upper
#print axioms Mahjong.IndexSearch.adjustDown_spec
#print axioms Mahjong.IndexSearch.pairFloor_spec
#print axioms Mahjong.IndexSearch.pairFloor_bounded
#print axioms Mahjong.IndexSearch.pairFloor_seed_independent
#print axioms Mahjong.IndexSearch.tripleFloor_spec
