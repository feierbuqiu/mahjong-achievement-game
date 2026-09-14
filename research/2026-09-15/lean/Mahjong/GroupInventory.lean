import Mahjong.CanonicalInventory
import Mahjong.EnumerationBlocks

set_option autoImplicit false

namespace Mahjong.GroupInventory
open PruningAlgebra CanonicalInventory

structure Data where
  count : Nat
  groups : Nat
  code : Nat → Nat
  group : Nat → Nat
  member : Nat → Nat
  first : Nat → Nat
  size : Nat → Nat
  label : Nat → Label
  raw : Nat → Label
  retained : Nat → Nat

def checkMember (d : Data) (i : Nat) : Bool :=
  let g := d.group i
  decide (d.code i = d.retained i) && decide (g < d.groups) &&
  decide (d.member i < d.size g) && decide (i = d.first g + d.member i) &&
  decide (d.raw (d.code i) = d.label g)

def checkGroup (d : Data) (g : Nat) : Bool :=
  decide (0 < d.size g) && decide (d.first g + d.size g ≤ d.count) &&
  (if g = 0 then decide (d.first g = 0) else true) &&
  (if g + 1 < d.groups then decide (d.first (g+1) = d.first g + d.size g)
   else decide (d.first g + d.size g = d.count))

def Checked (d : Data) : Prop :=
  CanonicalInventory.checkSpan (checkMember d) 0 d.count = true ∧
  CanonicalInventory.checkSpan (checkGroup d) 0 d.groups = true

structure MemberFacts (d : Data) (i : Nat) : Prop where
  code : d.code i = d.retained i
  group : d.group i < d.groups
  member : d.member i < d.size (d.group i)
  offset : i = d.first (d.group i) + d.member i
  label : d.raw (d.code i) = d.label (d.group i)

structure GroupFacts (d : Data) (g : Nat) : Prop where
  positive : 0 < d.size g
  bound : d.first g + d.size g ≤ d.count
  next : g + 1 < d.groups → d.first (g+1) = d.first g + d.size g

theorem member_facts (d : Data) (checked : Checked d) (i : Nat) (hi : i < d.count) : MemberFacts d i := by
  have h := CanonicalInventory.checkSpan_each (checkMember d) d.count 0 checked.1 i hi
  simp only [Nat.zero_add, checkMember, Bool.and_eq_true, decide_eq_true_eq] at h
  exact ⟨h.1.1.1.1, h.1.1.1.2, h.1.1.2, h.1.2, h.2⟩

theorem group_facts (d : Data) (checked : Checked d) (g : Nat) (hg : g < d.groups) : GroupFacts d g := by
  have h := CanonicalInventory.checkSpan_each (checkGroup d) d.groups 0 checked.2 g hg
  simp only [Nat.zero_add, checkGroup, Bool.and_eq_true, decide_eq_true_eq] at h
  refine ⟨h.1.1.1, h.1.1.2, ?_⟩
  intro next
  simpa [next] using h.2

theorem first_mono (d : Data) (checked : Checked d) (a b : Nat)
    (hab : a ≤ b) (hb : b < d.groups) : d.first a ≤ d.first b := by
  induction b with
  | zero =>
    have eq : a = 0 := by omega
    subst a
    exact Nat.le_refl _
  | succ b ih =>
    by_cases eq : a = b+1
    · subst a; exact Nat.le_refl _
    · have before := ih (by omega) (by omega)
      have next := (group_facts d checked b (by omega)).next (by omega)
      omega

theorem separated (d : Data) (checked : Checked d) (a b : Nat)
    (hab : a < b) (hb : b < d.groups) : d.first a + d.size a ≤ d.first b := by
  have next := (group_facts d checked a (by omega)).next (by omega)
  have order := first_mono d checked (a+1) b (by omega) hb
  omega

theorem intervals_unique (d : Data) (checked : Checked d) (a b i : Nat)
    (ha : a < d.groups) (hb : b < d.groups)
    (ia : d.first a ≤ i ∧ i < d.first a + d.size a)
    (ib : d.first b ≤ i ∧ i < d.first b + d.size b) : a = b := by
  by_cases lt : a < b
  · have sep := separated d checked a b lt hb; omega
  · by_cases gt : b < a
    · have sep := separated d checked b a gt ha; omega
    · omega

theorem group_monotone (d : Data) (checked : Checked d) (i j : Nat)
    (hi : i < d.count) (hj : j < d.count) (order : i ≤ j) : d.group i ≤ d.group j := by
  have a := member_facts d checked i hi
  have b := member_facts d checked j hj
  by_cases good : d.group i ≤ d.group j
  · exact good
  · have sep := separated d checked (d.group j) (d.group i) (by omega) a.group
    have ao := a.offset
    have bo := b.offset
    have bm := b.member
    omega

/-- Every in-range local coordinate returns the original group and member ID.
No unvisited coordinate or group is assumed to exist. -/
theorem coordinate_inverse (d : Data) (checked : Checked d) (g x : Nat)
    (hg : g < d.groups) (hx : x < d.size g) :
    d.first g + x < d.count ∧ d.group (d.first g + x) = g ∧ d.member (d.first g + x) = x := by
  have limit := (group_facts d checked g hg).bound
  have inside : d.first g + x < d.count := by omega
  have row := member_facts d checked _ inside
  have eq := intervals_unique d checked (d.group (d.first g + x)) g (d.first g + x) row.group hg
    ⟨by have h := row.offset; omega, by have h := row.offset; have m := row.member; omega⟩ ⟨by omega, by omega⟩
  refine ⟨inside, eq, ?_⟩
  have h := row.offset
  rw [eq] at h
  omega

theorem group_label_at_coordinate (d : Data) (checked : Checked d) (g x : Nat)
    (hg : g < d.groups) (hx : x < d.size g) :
    d.raw (d.retained (d.first g + x)) = d.label g := by
  have coords := coordinate_inverse d checked g x hg hx
  have row := member_facts d checked _ coords.1
  have label := row.label
  rwa [row.code, coords.2.1] at label

def candidate (numeric groups raw retained : ByteArray) : Data where
  count := numeric.size / 12
  groups := groups.size / 8
  code := fun i => read32 numeric (12*i)
  group := fun i => read32 numeric (12*i+4)
  member := fun i => read32 numeric (12*i+8)
  first := fun g => read32 groups (8*g)
  size := fun g => read32 groups (8*g+4)
  label := fun g => PruningData.rawLabel raw (read32 numeric (12*read32 groups (8*g)))
  raw := PruningData.rawLabel raw
  retained := fun i => read32 retained (4*i)

end Mahjong.GroupInventory

#print axioms Mahjong.GroupInventory.member_facts
#print axioms Mahjong.GroupInventory.group_facts
#print axioms Mahjong.GroupInventory.intervals_unique
#print axioms Mahjong.GroupInventory.group_monotone
#print axioms Mahjong.GroupInventory.coordinate_inverse
#print axioms Mahjong.GroupInventory.group_label_at_coordinate
