import Mahjong.MoveNormalization
import Mahjong.GroupInventory
import Mahjong.IndexWordArithmetic

set_option autoImplicit false

namespace Mahjong.MovePlanRefinement
open PackedRules SuitSorting GlobalOrbitKey MoveNormalization GroupInventory

def mapNumeric (f : Nat → Nat) (p : Packed) : Packed := ⟨f p.a,f p.b,f p.c,p.h⟩
def Inside (d : Data) (p : Packed) : Prop := p.a < d.count ∧ p.b < d.count ∧ p.c < d.count
def shadow (d : Data) (p : Packed) : Packed := mapNumeric (fun i => d.first (d.group i)) p

theorem map_swap (f : Nat → Nat) (p : Packed) (a b : Fin 3) :
    mapNumeric f (swapped a b p) = swapped a b (mapNumeric f p) := by
  rcases fin_three a with rfl | rfl | rfl <;> rcases fin_three b with rfl | rfl | rfl <;> rfl

theorem map_compare_signature (f key : Nat → Nat) (a b : Fin 3) (p : Packed) :
    signature (mapNumeric f (compareSwap key a b p)) = signature (mapNumeric f p) := by
  unfold compareSwap
  split
  · rw [map_swap,signature_swap]
  · rfl

theorem map_sort_signature (f : Nat → Nat) (p : Packed) :
    signature (mapNumeric f (sort id p)) = signature (mapNumeric f p) := by
  simp only [sort,map_compare_signature]

theorem sort_inside (d : Data) (p : Packed) (inside : Inside d p) : Inside d (sort id p) := by
  have all : ∀ b, b < 3 → p.get b < d.count := by
    intro b hb
    have choices : b = 0 ∨ b = 1 ∨ b = 2 := by omega
    rcases choices with rfl | rfl | rfl
    · exact inside.1
    · exact inside.2.1
    · exact inside.2.2
  have h := sort_preserves id p (fun i => i < d.count) all
  exact ⟨h 0 (by decide),h 1 (by decide),h 2 (by decide)⟩

theorem group_order (d : Data) (checked : Checked d) (p : Packed) (inside : Inside d p)
    (ab : p.a ≤ p.b) (bc : p.b ≤ p.c) :
    (mapNumeric d.group p).a ≤ (mapNumeric d.group p).b ∧
      (mapNumeric d.group p).b ≤ (mapNumeric d.group p).c :=
  ⟨group_monotone d checked _ _ inside.1 inside.2.1 ab,
   group_monotone d checked _ _ inside.2.1 inside.2.2 bc⟩

theorem same_sorted_groups (d : Data) (checked : Checked d) (p q : Packed)
    (ip : Inside d p) (iq : Inside d q)
    (same : signature (mapNumeric d.group p) = signature (mapNumeric d.group q)) :
    mapNumeric d.group (sort id p) = mapNumeric d.group (sort id q) := by
  have po := sorted_order id p
  have qo := sorted_order id q
  have pg := group_order d checked _ (sort_inside d p ip) po.1 po.2
  have qg := group_order d checked _ (sort_inside d q iq) qo.1 qo.2
  apply signature_sorted_injective _ _ pg.1 pg.2 qg.1 qg.2
  rw [map_sort_signature,map_sort_signature,same]

theorem first_of_group (d : Data) (checked : Checked d) (i : Nat) (hi : i < d.count) :
    d.first (d.group i) < d.count ∧ d.group (d.first (d.group i)) = d.group i := by
  have m := member_facts d checked i hi
  have positive := (group_facts d checked _ m.group).positive
  have inverse := coordinate_inverse d checked _ 0 m.group positive
  simpa only [Nat.add_zero] using ⟨inverse.1,inverse.2.1⟩

theorem shadow_inside_and_groups (d : Data) (checked : Checked d) (p : Packed) (inside : Inside d p) :
    Inside d (shadow d p) ∧ mapNumeric d.group (shadow d p) = mapNumeric d.group p := by
  have a := first_of_group d checked _ inside.1
  have b := first_of_group d checked _ inside.2.1
  have c := first_of_group d checked _ inside.2.2
  refine ⟨⟨a.1,b.1,c.1⟩,?_⟩
  simp only [shadow,mapNumeric,a.2,b.2,c.2]

theorem map_replace (f : Nat → Nat) (p : Packed) (b : Fin 3) (target : Nat) :
    mapNumeric f (replace p b target) = replace (mapNumeric f p) b (f target) := by
  rcases fin_three b with rfl | rfl | rfl <;> rfl

theorem replace_inside (d : Data) (p : Packed) (b : Fin 3) (target : Nat)
    (inside : Inside d p) (ht : target < d.count) : Inside d (replace p b target) := by
  rcases fin_three b with rfl | rfl | rfl
  · exact ⟨ht,inside.2.1,inside.2.2⟩
  · exact ⟨inside.1,ht,inside.2.2⟩
  · exact ⟨inside.1,inside.2.1,ht⟩

/-- The changed actual ID and the precomputed first-ID representative produce
exactly the same sorted group triple, including ties between groups. -/
theorem prepared_groups (d : Data) (checked : Checked d) (p : Packed) (b : Fin 3) (target : Nat)
    (inside : Inside d p) (ht : target < d.count) :
    mapNumeric d.group (sort id (replace p b target)) =
      mapNumeric d.group (sort id (replace (shadow d p) b (d.first (d.group target)))) := by
  have sh := shadow_inside_and_groups d checked p inside
  have ft := first_of_group d checked target ht
  apply same_sorted_groups d checked _ _ (replace_inside d p b target inside ht)
    (replace_inside d (shadow d p) b _ sh.1 ft.1)
  rw [map_replace,map_replace,sh.2,ft.2]

theorem shadow_order (d : Data) (checked : Checked d) (p : Packed) (inside : Inside d p)
    (ab : p.a ≤ p.b) (bc : p.b ≤ p.c) :
    (shadow d p).a ≤ (shadow d p).b ∧ (shadow d p).b ≤ (shadow d p).c := by
  have groups := group_order d checked p inside ab bc
  exact ⟨first_mono d checked _ _ groups.1 (member_facts d checked _ inside.2.1).group,
    first_mono d checked _ _ groups.2 (member_facts d checked _ inside.2.2).group⟩

theorem shadow_increases (d : Data) (checked : Checked d) (p : Packed) (b : Fin 3) (target : Nat)
    (inside : Inside d p) (ht : target < d.count) (inc : p.get b.val ≤ target) :
    (shadow d p).get b.val ≤ d.first (d.group target) := by
  have hi : p.get b.val < d.count := by
    rcases fin_three b with rfl | rfl | rfl
    · exact inside.1
    · exact inside.2.1
    · exact inside.2.2
  have ord := group_monotone d checked _ target hi ht inc
  have fm := first_mono d checked _ _ ord (member_facts d checked target ht).group
  rcases fin_three b with rfl | rfl | rfl <;> exact fm

theorem prepared_fast_groups (d : Data) (checked : Checked d) (p : Packed) (b : Fin 3) (target : Nat)
    (inside : Inside d p) (ht : target < d.count) (ab : p.a ≤ p.b) (bc : p.b ≤ p.c)
    (inc : p.get b.val ≤ target) :
    mapNumeric d.group (fast p b target) =
      mapNumeric d.group (fast (shadow d p) b (d.first (d.group target))) := by
  have order := shadow_order d checked p inside ab bc
  rw [fast_eq_sort p b target ab bc inc,
    fast_eq_sort (shadow d p) b _ order.1 order.2 (shadow_increases d checked p b target inside ht inc)]
  exact prepared_groups d checked p b target inside ht

theorem planned_offset (d : Data) (checked : Checked d) (p : Packed) (b : Fin 3) (target : Nat)
    (inside : Inside d p) (ht : target < d.count) (ab : p.a ≤ p.b) (bc : p.b ≤ p.c)
    (inc : p.get b.val ≤ target) (lookup : Packed → Option Nat) :
    lookup (mapNumeric d.group (fast p b target)) =
      lookup (mapNumeric d.group (fast (shadow d p) b (d.first (d.group target)))) :=
  congrArg lookup (prepared_fast_groups d checked p b target inside ht ab bc inc)

/-- Machine addition after the shared offset lookup; the bound is supplied by
the already checked bucket and within-rank range. -/
theorem offset_add64 (offset within : UInt64) (bound : offset.toNat+within.toNat < 2^64) :
    (offset+within).toNat = offset.toNat+within.toNat := IndexWordArithmetic.add64 offset within bound

end Mahjong.MovePlanRefinement

#print axioms Mahjong.MovePlanRefinement.map_swap
#print axioms Mahjong.MovePlanRefinement.map_sort_signature
#print axioms Mahjong.MovePlanRefinement.sort_inside
#print axioms Mahjong.MovePlanRefinement.group_order
#print axioms Mahjong.MovePlanRefinement.same_sorted_groups
#print axioms Mahjong.MovePlanRefinement.first_of_group
#print axioms Mahjong.MovePlanRefinement.shadow_inside_and_groups
#print axioms Mahjong.MovePlanRefinement.prepared_groups
#print axioms Mahjong.MovePlanRefinement.shadow_order
#print axioms Mahjong.MovePlanRefinement.shadow_increases
#print axioms Mahjong.MovePlanRefinement.prepared_fast_groups
#print axioms Mahjong.MovePlanRefinement.planned_offset
#print axioms Mahjong.MovePlanRefinement.offset_add64
