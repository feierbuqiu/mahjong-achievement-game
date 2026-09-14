import Mahjong.CanonicalCoverage

set_option autoImplicit false

namespace Mahjong.SuitSorting
open PackedRules Generators LocalCacheEncoding Base5Coverage

def transposeBlock (a c : Fin 3) (b : Nat) : Nat :=
  if b = a.val then c.val else if b = c.val then a.val else b

def swapped (a c : Fin 3) (p : Packed) : Packed :=
  ⟨p.get (transposeBlock a c 0), p.get (transposeBlock a c 1),
   p.get (transposeBlock a c 2), p.get (transposeBlock a c 3)⟩

theorem swapped_get (a c : Fin 3) (p : Packed) (b : Nat) (hb : b < 4) :
    (swapped a c p).get b = p.get (transposeBlock a c b) :=
  get_four (fun k => p.get (transposeBlock a c k)) b hb

theorem unpack_value (p : Packed) (u : Tile) :
    unpack p u = p.get (u.val / 9) / powers[u.val % 9]! % 5 :=
  decode_digit _ _ u rfl

theorem swapped_state (a c : Fin 3) (p : Packed) :
    unpack (swapped a c p) = act (.swapSuits a c) (unpack p) := by
  funext u
  have ub : u.val / 9 < 4 := by have hu := u.isLt; omega
  have shape := (by decide : ∀ a c : Fin 3, ∀ u : Tile,
    (swapSuits a c u).val / 9 = transposeBlock a c (u.val / 9) ∧
    (swapSuits a c u).val % 9 = u.val % 9) a c u
  change unpack (swapped a c p) u = unpack p (swapSuits a c u)
  rw [unpack_value, unpack_value, swapped_get a c p _ ub, shape.1, shape.2]

def compareSwap (key : Nat → Nat) (a c : Fin 3) (p : Packed) : Packed :=
  if key (p.get a.val) > key (p.get c.val) then swapped a c p else p

/-- The production three-comparator network, in its actual 01,12,01 order. -/
def sort (key : Nat → Nat) (p : Packed) : Packed :=
  compareSwap key 0 1 (compareSwap key 1 2 (compareSwap key 0 1 p))

theorem compare01 (key : Nat → Nat) (p : Packed) :
    compareSwap key 0 1 p = if key p.a > key p.b then ⟨p.b,p.a,p.c,p.h⟩ else p := rfl

theorem compare12 (key : Nat → Nat) (p : Packed) :
    compareSwap key 1 2 p = if key p.b > key p.c then ⟨p.a,p.c,p.b,p.h⟩ else p := rfl

theorem sorted_order (key : Nat → Nat) (p : Packed) :
    key (sort key p).a ≤ key (sort key p).b ∧ key (sort key p).b ≤ key (sort key p).c := by
  simp only [sort, compare01, compare12]
  by_cases h : key p.a > key p.b
  all_goals simp only [h, ↓reduceIte]
  all_goals split
  all_goals try dsimp only at *
  all_goals first | omega | split
  all_goals try dsimp only at *
  all_goals omega

theorem numeric_bound (a c : Fin 3) (b : Nat) (hb : b < 3) : transposeBlock a c b < 3 := by
  unfold transposeBlock
  split
  · exact c.isLt
  · split
    · exact a.isLt
    · exact hb

theorem compare_preserves (key : Nat → Nat) (a c : Fin 3) (p : Packed) (Q : Nat → Prop)
    (h : ∀ b, b < 3 → Q (p.get b)) : ∀ b, b < 3 → Q ((compareSwap key a c p).get b) := by
  intro b hb
  unfold compareSwap
  split
  · rw [swapped_get a c p b (by omega)]
    exact h _ (numeric_bound a c b hb)
  · exact h b hb

theorem sort_preserves (key : Nat → Nat) (p : Packed) (Q : Nat → Prop)
    (h : ∀ b, b < 3 → Q (p.get b)) : ∀ b, b < 3 → Q ((sort key p).get b) :=
  compare_preserves key 0 1 _ Q (compare_preserves key 1 2 _ Q (compare_preserves key 0 1 p Q h))

theorem compare_honor (key : Nat → Nat) (a c : Fin 3) (p : Packed) : (compareSwap key a c p).h = p.h := by
  have ha := a.isLt
  have hc := c.isLt
  have na : 3 ≠ a.val := by omega
  have nc : 3 ≠ c.val := by omega
  unfold compareSwap
  split
  · simp [swapped, transposeBlock, na, nc, Packed.get]
  · rfl

theorem sort_honor (key : Nat → Nat) (p : Packed) : (sort key p).h = p.h := by
  simp only [sort, compare_honor]

theorem compare_path (key : Nat → Nat) (a c : Fin 3) (p : Packed) :
    ∃ path, unpack (compareSwap key a c p) = applyPath path (unpack p) := by
  unfold compareSwap
  split
  · exact ⟨[.swapSuits a c], swapped_state a c p⟩
  · exact ⟨[], rfl⟩

theorem sort_path (key : Nat → Nat) (p : Packed) :
    ∃ path, unpack (sort key p) = applyPath path (unpack p) := by
  obtain ⟨a, ha⟩ := compare_path key 0 1 p
  obtain ⟨b, hb⟩ := compare_path key 1 2 (compareSwap key 0 1 p)
  obtain ⟨c, hc⟩ := compare_path key 0 1 (compareSwap key 1 2 (compareSwap key 0 1 p))
  refine ⟨a ++ b ++ c, ?_⟩
  rw [CanonicalCoverage.path_append, CanonicalCoverage.path_append, ← ha, ← hb]
  exact hc

theorem encode_unpacked (p : Packed) (b : Nat) (t : CanonicalInventory.Candidate)
    (checked : CanonicalInventory.Checked b t) (inside : p.get b < t.size) : encodeBlock b (unpack p) = p.get b := by
  have same : MaskedLocalBound.SameBlock b (unpack p) (decodeBlock b (p.get b)) := by
    intro u hu
    simp only [unpack, hu]
  rw [CanonicalInventory.encode_same b _ _ same]
  exact (CanonicalInventory.checked_row b t checked _ inside).roundtrip

end Mahjong.SuitSorting

#print axioms Mahjong.SuitSorting.swapped_state
#print axioms Mahjong.SuitSorting.sorted_order
#print axioms Mahjong.SuitSorting.sort_preserves
#print axioms Mahjong.SuitSorting.sort_path
