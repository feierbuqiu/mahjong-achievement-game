import Std

/-!
The arithmetic core of repeated-group colex ranking, over unbounded naturals.
This module does not certify C++ integer overflow bounds, local group lists,
SAFE filtering, block offsets, rank/unrank code, or the entire global index.
-/

namespace Mahjong.Ranking

/-- Number of pairs `x ≤ y < n`. -/
def tri : Nat → Nat
  | 0 => 0
  | n + 1 => tri n + (n + 1)

/-- Number of triples `x ≤ y ≤ z < n`. -/
def tet : Nat → Nat
  | 0 => 0
  | n + 1 => tet n + tri (n + 1)

theorem twice_tri (n : Nat) : 2 * tri n = n * (n + 1) := by
  induction n with
  | zero => rfl
  | succ n ih =>
      simp only [tri, Nat.mul_add, Nat.add_mul,
        Nat.mul_one, Nat.one_mul] at *
      omega

theorem six_times_tet (n : Nat) : 6 * tet n = n * (n + 1) * (n + 2) := by
  induction n with
  | zero => rfl
  | succ n ih =>
      have ht := twice_tri (n + 1)
      simp only [tet, Nat.mul_add, Nat.add_mul,
        Nat.mul_one, Nat.one_mul, Nat.mul_assoc] at *
      omega

/-- Matches `Index::c2_start` as natural-number arithmetic. -/
def c2 (n : Nat) : Nat := n * (n + 1) / 2

/-- Matches `Index::c3_start` as natural-number arithmetic. -/
def c3 (n : Nat) : Nat := n * (n + 1) * (n + 2) / 6

theorem c2_eq_tri (n : Nat) : c2 n = tri n :=
  Nat.div_eq_of_eq_mul_right (by decide) (twice_tri n).symm

theorem c3_eq_tet (n : Nat) : c3 n = tet n :=
  Nat.div_eq_of_eq_mul_right (by decide) (six_times_tet n).symm

theorem tri_mono {a b : Nat} (h : a ≤ b) : tri a ≤ tri b := by
  induction h with
  | refl => exact Nat.le_refl _
  | @step b hab ih =>
      simp only [tri]
      omega

theorem tet_mono {a b : Nat} (h : a ≤ b) : tet a ≤ tet b := by
  induction h with
  | refl => exact Nat.le_refl _
  | @step b hab ih =>
      simp only [tet]
      omega

theorem c2_mono {a b : Nat} (h : a ≤ b) : c2 a ≤ c2 b := by
  simpa only [c2_eq_tri] using tri_mono h

theorem c3_mono {a b : Nat} (h : a ≤ b) : c3 a ≤ c3 b := by
  simpa only [c3_eq_tet] using tet_mono h

theorem c2_succ (n : Nat) : c2 (n + 1) = c2 n + (n + 1) := by
  simp only [c2_eq_tri, tri]

theorem c3_succ (n : Nat) : c3 (n + 1) = c3 n + c2 (n + 1) := by
  simp only [c3_eq_tet, c2_eq_tri, tet]

def rank2 (x y : Nat) : Nat := x + c2 y

def rank3 (x y z : Nat) : Nat := x + c2 y + c3 z

/-- For a fixed largest pair member, the rank lies in precisely that block. -/
theorem rank2_bounds {x y : Nat} (hxy : x ≤ y) :
    c2 y ≤ rank2 x y ∧ rank2 x y < c2 (y + 1) := by
  have h := c2_succ y
  unfold rank2
  omega

/-- For a fixed largest triple member, the rank lies in precisely that block. -/
theorem rank3_bounds {x y z : Nat} (hxy : x ≤ y) (hyz : y ≤ z) :
    c3 z ≤ rank3 x y z ∧ rank3 x y z < c3 (z + 1) := by
  have pairBounds := rank2_bounds hxy
  have upper := c2_mono (a := y + 1) (b := z + 1) (by omega)
  have next := c3_succ z
  unfold rank2 at pairBounds
  unfold rank3
  omega

theorem rank2_injective {x y x' y' : Nat}
    (hxy : x ≤ y) (hxy' : x' ≤ y')
    (same : rank2 x y = rank2 x' y') : x = x' ∧ y = y' := by
  have b := rank2_bounds hxy
  have b' := rank2_bounds hxy'
  have yy : y = y' := by
    by_cases lt : y < y'
    · have sep := c2_mono (a := y + 1) (b := y') (by omega)
      omega
    · by_cases gt : y' < y
      · have sep := c2_mono (a := y' + 1) (b := y) (by omega)
        omega
      · omega
  subst y'
  unfold rank2 at same
  exact ⟨by omega, rfl⟩

theorem rank3_injective {x y z x' y' z' : Nat}
    (hxy : x ≤ y) (hyz : y ≤ z) (hxy' : x' ≤ y') (hyz' : y' ≤ z')
    (same : rank3 x y z = rank3 x' y' z') :
    x = x' ∧ y = y' ∧ z = z' := by
  have b := rank3_bounds hxy hyz
  have b' := rank3_bounds hxy' hyz'
  have zz : z = z' := by
    by_cases lt : z < z'
    · have sep := c3_mono (a := z + 1) (b := z') (by omega)
      omega
    · by_cases gt : z' < z
      · have sep := c3_mono (a := z' + 1) (b := z) (by omega)
        omega
      · omega
  subst z'
  have pairSame : rank2 x y = rank2 x' y' := by
    unfold rank2
    unfold rank3 at same
    omega
  obtain ⟨xx, yy⟩ := rank2_injective hxy hxy' pairSame
  exact ⟨xx, yy, rfl⟩

/-- A pair of members from a group of size n fits in its c2(n)-entry block. -/
theorem rank2_lt_group_size {x y n : Nat} (hxy : x ≤ y) (hyn : y < n) :
    rank2 x y < c2 n := by
  have b := rank2_bounds hxy
  have upper := c2_mono (a := y + 1) (b := n) (by omega)
  omega

/-- A sorted triple from one group of size n fits in its c3(n)-entry block. -/
theorem rank3_lt_group_size {x y z n : Nat}
    (hxy : x ≤ y) (hyz : y ≤ z) (hzn : z < n) :
    rank3 x y z < c3 n := by
  have b := rank3_bounds hxy hyz
  have upper := c3_mono (a := z + 1) (b := n) (by omega)
  omega

end Mahjong.Ranking

#print axioms Mahjong.Ranking.twice_tri
#print axioms Mahjong.Ranking.six_times_tet
#print axioms Mahjong.Ranking.c2_eq_tri
#print axioms Mahjong.Ranking.c3_eq_tet
#print axioms Mahjong.Ranking.rank2_bounds
#print axioms Mahjong.Ranking.rank3_bounds
#print axioms Mahjong.Ranking.rank2_injective
#print axioms Mahjong.Ranking.rank3_injective
#print axioms Mahjong.Ranking.rank2_lt_group_size
#print axioms Mahjong.Ranking.rank3_lt_group_size
