import Mahjong.GroupCandidates

set_option autoImplicit false

namespace Mahjong.WeightedBlocks
open GroupInventory GroupCandidates Ranking EnumerationBlocks

def size (d : Data) (a b c : Nat) : Nat :=
  if a = c then c3 (d.size a)
  else if a = b then c2 (d.size a) * d.size c
  else if b = c then d.size a * c2 (d.size b)
  else d.size a * (d.size b * d.size c)

def rank (d : Data) (a b c x y z : Nat) : Nat :=
  if a = c then rank3 x y z
  else if a = b then radix (c2 (d.size a)) (rank2 x y) z
  else if b = c then radix (d.size a) x (rank2 y z)
  else radix (d.size a) x (radix (d.size b) y z)

theorem rank_bound (d : Data) (a b c x y z : Nat) (ab : a ≤ b) (bc : b ≤ c)
    (coords : Coordinates d a b c x y z) : rank d a b c x y z < size d a b c := by
  by_cases ac : a = c
  · have ba : b = a := by omega
    subst b; subst c
    simp only [rank, size, ↓reduceIte]
    exact rank3_lt_group_size (coords.2.2.2.1 rfl) (coords.2.2.2.2 rfl) coords.2.2.1
  · by_cases same : a = b
    · subst b
      simp only [rank, size, ac, ↓reduceIte]
      exact first_two_bound (coords.2.2.2.1 rfl) coords.2.1 coords.2.2.1
    · by_cases same2 : b = c
      · subst c
        simp only [rank, size, same, ↓reduceIte]
        exact last_two_bound coords.1 (coords.2.2.2.2 rfl) coords.2.2.1
      · simp only [rank, size, ac, same, same2, ↓reduceIte]
        exact distinct_groups_bound coords.1 coords.2.1 coords.2.2.1

theorem rank_injective (d : Data) (a b c x y z x' y' z' : Nat) (ab : a ≤ b) (bc : b ≤ c)
    (u : Coordinates d a b c x y z) (v : Coordinates d a b c x' y' z')
    (eq : rank d a b c x y z = rank d a b c x' y' z') : x = x' ∧ y = y' ∧ z = z' := by
  by_cases ac : a = c
  · have ba : b = a := by omega
    subst b; subst c
    simp only [rank, ↓reduceIte] at eq
    exact rank3_injective (u.2.2.2.1 rfl) (u.2.2.2.2 rfl) (v.2.2.2.1 rfl) (v.2.2.2.2 rfl) eq
  · by_cases same : a = b
    · subst b
      simp only [rank, ac, ↓reduceIte] at eq
      exact first_two_injective (u.2.2.2.1 rfl) u.2.1 (v.2.2.2.1 rfl) v.2.1 eq
    · by_cases same2 : b = c
      · subst c
        simp only [rank, same, ↓reduceIte] at eq
        exact last_two_injective u.1 v.1 (u.2.2.2.2 rfl) (v.2.2.2.2 rfl) eq
      · simp only [rank, ac, same, same2, ↓reduceIte] at eq
        exact distinct_groups_injective u.1 v.1 u.2.1 v.2.1 eq

theorem c2_positive (n : Nat) (positive : 0 < n) : 0 < c2 n := by
  have bound := c2_mono (a := 1) (b := n) (by omega)
  change 1 ≤ c2 n at bound
  omega

theorem rank_surjective (d : Data) (checked : GroupInventory.Checked d) (a b c r : Nat)
    (ha : a < d.groups) (hb : b < d.groups) (hc : c < d.groups) (ab : a ≤ b) (bc : b ≤ c)
    (inside : r < size d a b c) : ∃ x y z, Coordinates d a b c x y z ∧ rank d a b c x y z = r := by
  by_cases ac : a = c
  · have ba : b = a := by omega
    subst b; subst c
    simp only [size, ↓reduceIte] at inside
    obtain ⟨x,y,z,xy,yz,hz,eq⟩ := rank3_surjective (d.size a) r inside
    refine ⟨x,y,z,⟨by omega,by omega,hz,fun _ => xy,fun _ => yz⟩,?_⟩
    simpa only [rank, ↓reduceIte] using eq
  · by_cases same : a = b
    · subst b
      simp only [size, ac, ↓reduceIte] at inside
      obtain ⟨x,y,z,xy,hy,hz,eq⟩ := first_two_surjective (d.size a) (d.size c) r
        (c2_positive _ (group_facts d checked a ha).positive) inside
      refine ⟨x,y,z,⟨by omega,hy,hz,fun _ => xy,fun h => False.elim (ac h)⟩,?_⟩
      simpa only [rank, ac, ↓reduceIte] using eq
    · by_cases same2 : b = c
      · subst c
        simp only [size, same, ↓reduceIte] at inside
        obtain ⟨x,y,z,hx,yz,hz,eq⟩ := last_two_surjective (d.size a) (d.size b) r
          (group_facts d checked a ha).positive inside
        refine ⟨x,y,z,⟨hx,by omega,hz,fun h => False.elim (same h),fun _ => yz⟩,?_⟩
        simpa only [rank, same, ↓reduceIte] using eq
      · simp only [size, ac, same, same2, ↓reduceIte] at inside
        obtain ⟨x,y,z,hx,hy,hz,eq⟩ := distinct_groups_surjective (d.size a) (d.size b) (d.size c) r
          (group_facts d checked a ha).positive (group_facts d checked b hb).positive inside
        refine ⟨x,y,z,⟨hx,hy,hz,fun h => False.elim (same h),fun h => False.elim (same2 h)⟩,?_⟩
        simpa only [rank, ac, same, same2, ↓reduceIte] using eq

end Mahjong.WeightedBlocks

#print axioms Mahjong.WeightedBlocks.rank_bound
#print axioms Mahjong.WeightedBlocks.rank_injective
#print axioms Mahjong.WeightedBlocks.rank_surjective
