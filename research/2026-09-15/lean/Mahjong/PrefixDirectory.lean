import Mahjong.WeightedBlocks

set_option autoImplicit false

namespace Mahjong.PrefixDirectory
open CanonicalInventory

/-- The finite directory contains interval metadata, not one row per position. -/
structure Data where
  blocks : Nat
  total : Nat
  offset : Nat → Nat
  size : Nat → Nat

def checkRow (d : Data) (b : Nat) : Bool :=
  decide (0 < d.size b) && decide (d.offset b + d.size b ≤ d.total) &&
  (if b = 0 then decide (d.offset b = 0) else true) &&
  (if b + 1 < d.blocks then decide (d.offset (b+1) = d.offset b + d.size b)
   else decide (d.offset b + d.size b = d.total))

def check (d : Data) : Bool :=
  (if d.blocks = 0 then decide (d.total = 0) else true) && checkSpan (checkRow d) 0 d.blocks

structure Facts (d : Data) (b : Nat) : Prop where
  positive : 0 < d.size b
  bound : d.offset b + d.size b ≤ d.total
  first : b = 0 → d.offset b = 0
  next : b + 1 < d.blocks → d.offset (b+1) = d.offset b + d.size b
  last : b + 1 = d.blocks → d.offset b + d.size b = d.total

theorem row_facts (d : Data) (checked : check d = true) (b : Nat) (hb : b < d.blocks) : Facts d b := by
  have all : checkSpan (checkRow d) 0 d.blocks = true := by
    simp only [check, Bool.and_eq_true] at checked
    exact checked.2
  have h := checkSpan_each (checkRow d) d.blocks 0 all b hb
  simp only [Nat.zero_add, checkRow, Bool.and_eq_true, decide_eq_true_eq] at h
  refine ⟨h.1.1.1,h.1.1.2,?_,?_,?_⟩
  · intro eq
    simpa [eq] using h.1.2
  · intro next
    simpa [next] using h.2
  · intro last
    have notNext : ¬ b+1 < d.blocks := by omega
    simpa [notNext] using h.2

theorem offset_mono (d : Data) (checked : check d = true) (a b : Nat)
    (ab : a ≤ b) (hb : b < d.blocks) : d.offset a ≤ d.offset b := by
  induction b with
  | zero =>
    have eq : a = 0 := by omega
    subst a
    exact Nat.le_refl _
  | succ b ih =>
    by_cases eq : a = b+1
    · subst a; exact Nat.le_refl _
    · have prev := ih (by omega) (by omega)
      have next := (row_facts d checked b (by omega)).next (by omega)
      omega

theorem separated (d : Data) (checked : check d = true) (a b : Nat)
    (ab : a < b) (hb : b < d.blocks) : d.offset a + d.size a ≤ d.offset b := by
  have next := (row_facts d checked a (by omega)).next (by omega)
  have order := offset_mono d checked (a+1) b (by omega) hb
  omega

theorem address_bound (d : Data) (checked : check d = true) (b r : Nat)
    (hb : b < d.blocks) (hr : r < d.size b) : d.offset b + r < d.total := by
  have limit := (row_facts d checked b hb).bound
  omega

/-- Different block/local-offset pairs cannot refer to the same address. -/
theorem address_injective (d : Data) (checked : check d = true) (a b x y : Nat)
    (ha : a < d.blocks) (hb : b < d.blocks) (hx : x < d.size a) (hy : y < d.size b)
    (eq : d.offset a + x = d.offset b + y) : a = b ∧ x = y := by
  by_cases ab : a < b
  · have sep := separated d checked a b ab hb
    omega
  · by_cases ba : b < a
    · have sep := separated d checked b a ba ha
      omega
    · have same : a = b := by omega
      subst b
      exact ⟨rfl,by omega⟩

theorem initial_coverage (d : Data) (checked : check d = true) (b r : Nat)
    (hb : b < d.blocks) (hr : r < d.offset b + d.size b) :
    ∃ a x, a ≤ b ∧ x < d.size a ∧ d.offset a + x = r := by
  induction b with
  | zero =>
    have start := (row_facts d checked 0 hb).first rfl
    exact ⟨0,r,Nat.le_refl _,by omega,by omega⟩
  | succ b ih =>
    by_cases before : r < d.offset (b+1)
    · have next := (row_facts d checked b (by omega)).next hb
      obtain ⟨a,x,ab,hx,eq⟩ := ih (by omega) (by omega)
      exact ⟨a,x,by omega,hx,eq⟩
    · exact ⟨b+1,r-d.offset (b+1),Nat.le_refl _,by omega,by omega⟩

/-- Checking one record per interval suffices to prove every address is covered. -/
theorem address_surjective (d : Data) (checked : check d = true) (r : Nat) (hr : r < d.total) :
    ∃ b x, b < d.blocks ∧ x < d.size b ∧ d.offset b + x = r := by
  have nonempty : 0 < d.blocks := by
    by_cases empty : d.blocks = 0
    · have zero : d.total = 0 := by
        simp only [check, Bool.and_eq_true] at checked
        simpa [empty] using checked.1
      omega
    · omega
  have lastBound : d.blocks-1 < d.blocks := by omega
  have last := (row_facts d checked (d.blocks-1) lastBound).last (by omega)
  obtain ⟨b,x,hb,hx,eq⟩ := initial_coverage d checked (d.blocks-1) r lastBound (by omega)
  exact ⟨b,x,by omega,hx,eq⟩

end Mahjong.PrefixDirectory

#print axioms Mahjong.PrefixDirectory.row_facts
#print axioms Mahjong.PrefixDirectory.address_bound
#print axioms Mahjong.PrefixDirectory.address_injective
#print axioms Mahjong.PrefixDirectory.address_surjective
