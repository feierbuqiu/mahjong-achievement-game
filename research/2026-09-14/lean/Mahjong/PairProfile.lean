import Mahjong.CapacityComplete
import Mahjong.MemoRules

namespace Mahjong.PairProfile

def maxMap (xs : List Tile) (f : Tile → Nat) : Nat :=
  xs.foldr (fun t n => max (f t) n) 0

theorem le_maxMap (xs : List Tile) (f : Tile → Nat) (t : Tile) (ht : t ∈ xs) :
    f t ≤ maxMap xs f := by
  induction xs with
  | nil => simp at ht
  | cons x xs ih =>
    rcases List.mem_cons.mp ht with rfl | ht
    · exact Nat.le_max_left _ _
    · exact Nat.le_trans (ih ht) (Nat.le_max_right _ _)

theorem maxMap_witness (xs : List Tile) (f : Tile → Nat) (positive : 0 < maxMap xs f) :
    ∃ t, t ∈ xs ∧ f t = maxMap xs f := by
  induction xs with
  | nil => simp [maxMap] at positive
  | cons t ts ih =>
    change 0 < max (f t) (maxMap ts f) at positive
    by_cases top : maxMap ts f ≤ f t
    · exact ⟨t, by simp, (Nat.max_eq_left top).symm⟩
    · have pos : 0 < maxMap ts f := by omega
      obtain ⟨u, hu, eq⟩ := ih pos
      refine ⟨u, List.mem_cons_of_mem t hu, ?_⟩
      change f u = max (f t) (maxMap ts f)
      rw [Nat.max_eq_right (by omega), eq]

def blockTiles (b : Nat) : List Tile := allTiles.filter (fun p => decide (p.val / 9 = b))

theorem mem_blockTiles (b : Nat) (p : Tile) : p ∈ blockTiles b ↔ p.val / 9 = b := by
  simp [blockTiles, mem_allTiles p]

def pairedValue (b : Nat) (s : State) (p : Tile) : Nat :=
  if FastRuleChecker.pairAvailableB s p then
    FactorizedRules.capacity b (FastRuleChecker.removePair s p) + 1 else 0

def paired (b : Nat) (s : State) : Nat := maxMap (blockTiles b) (pairedValue b s)

def cap (b : Nat) (s : State) : Nat := FactorizedRules.capacity b s

theorem cap_removePair_other (s : State) (p : Tile) (b : Nat) (other : p.val / 9 ≠ b) :
    cap b (FastRuleChecker.removePair s p) = cap b s := by
  have same : MaskedLocalBound.SameBlock b (FastRuleChecker.removePair s p) s := by
    intro u hu
    have ne : u ≠ p := by intro eq; subst u; exact other hu
    simp only [FastRuleChecker.removePair, if_neg ne]
  have eqn (k : Nat) := MaskedLocalBound.search_local_eq b k _ _ same
  simp only [cap, FactorizedRules.capacity, eqn]

def others (b : Nat) (s : State) : Nat :=
  match b with
  | 0 => cap 1 s + cap 2 s + cap 3 s
  | 1 => cap 0 s + cap 2 s + cap 3 s
  | 2 => cap 0 s + cap 1 s + cap 3 s
  | _ => cap 0 s + cap 1 s + cap 2 s

theorem afterPair_total (s : State) (p : Tile) :
    (FactorizedRules.capacities (FastRuleChecker.removePair s p)).total =
      cap (p.val / 9) (FastRuleChecker.removePair s p) + others (p.val / 9) s := by
  have hp := p.isLt
  have cases : p.val / 9 = 0 ∨ p.val / 9 = 1 ∨ p.val / 9 = 2 ∨ p.val / 9 = 3 := by omega
  have eqn := cap_removePair_other s p
  change cap 0 _ + cap 1 _ + cap 2 _ + cap 3 _ = _
  rcases cases with h | h | h | h
  all_goals simp [others, eqn 0, eqn 1, eqn 2, eqn 3, h]
  all_goals omega

theorem paired_all_iff (b : Nat) (s : State) :
    (paired b s = 0 ∨ paired b s + others b s ≤ 4) ↔
      ∀ p, p ∈ blockTiles b → FastRuleChecker.pairAvailableB s p = true →
        cap b (FastRuleChecker.removePair s p) + others b s < 4 := by
  constructor
  · intro bounded p hp available
    have upper := le_maxMap (blockTiles b) (pairedValue b s) p hp
    change pairedValue b s p ≤ paired b s at upper
    simp only [pairedValue, available, ↓reduceIte] at upper
    dsimp [cap]
    rcases bounded with zero | bound <;> omega
  · intro all
    by_cases zero : paired b s = 0
    · exact Or.inl zero
    · right
      obtain ⟨p, hp, top⟩ := maxMap_witness (blockTiles b) (pairedValue b s) (by
        change 0 < paired b s; omega)
      change pairedValue b s p = paired b s at top
      have available : FastRuleChecker.pairAvailableB s p = true := by
        cases h : FastRuleChecker.pairAvailableB s p
        · simp only [pairedValue, h, Bool.false_eq_true, ↓reduceIte] at top
          omega
        · rfl
      have bound := all p hp available
      simp only [pairedValue, available, ↓reduceIte] at top
      dsimp [cap] at bound
      omega

def noStandardB (s : State) : Bool :=
  [0, 1, 2, 3].all (fun b => decide (paired b s = 0 ∨ paired b s + others b s ≤ 4))

theorem noStandardB_eq (s : State) :
    noStandardB s = allTiles.all (fun p => if FastRuleChecker.pairAvailableB s p then
      decide ((FactorizedRules.capacities (FastRuleChecker.removePair s p)).total < 4) else true) := by
  apply Bool.eq_iff_iff.2
  change _ = true ↔ _ = true
  simp only [noStandardB, List.all_eq_true, decide_eq_true_eq]
  constructor
  · intro all p _
    by_cases available : FastRuleChecker.pairAvailableB s p = true
    · simp only [available, ↓reduceIte, decide_eq_true_eq, afterPair_total]
      have hp := p.isLt
      have mem : p.val / 9 ∈ [0, 1, 2, 3] := by
        have cases : p.val / 9 = 0 ∨ p.val / 9 = 1 ∨ p.val / 9 = 2 ∨ p.val / 9 = 3 := by omega
        rcases cases with h | h | h | h <;> simp [h]
      exact (paired_all_iff _ s).mp (all _ mem) p ((mem_blockTiles _ _).mpr rfl) available
    · simp [available]
  · intro all b _
    apply (paired_all_iff b s).mpr
    intro p hp available
    have h := all p (mem_allTiles p)
    simp only [available, ↓reduceIte, decide_eq_true_eq, afterPair_total] at h
    simpa only [(mem_blockTiles b p).mp hp] using h

end Mahjong.PairProfile

#print axioms Mahjong.PairProfile.noStandardB_eq
