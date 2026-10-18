import Mahjong.Ranking

/-!
Universal block arithmetic, independent of any Mahjong table size. These
theorems certify the four coordinate layouts, not the C++ program or the
membership/SAFE correctness of the actual bucket directory.
-/
set_option autoImplicit false

namespace Mahjong.EnumerationBlocks
open Ranking

theorem rank2_surjective (n r : Nat) (hr : r < c2 n) :
    ∃ x y, x ≤ y ∧ y < n ∧ rank2 x y = r := by
  induction n with
  | zero => simp [c2] at hr
  | succ n ih =>
    by_cases old : r < c2 n
    · obtain ⟨x, y, hxy, hyn, eq⟩ := ih old
      exact ⟨x, y, hxy, by omega, eq⟩
    · have step := c2_succ n
      refine ⟨r - c2 n, n, ?_, by omega, ?_⟩
      · omega
      · unfold rank2; omega

theorem rank3_surjective (n r : Nat) (hr : r < c3 n) :
    ∃ x y z, x ≤ y ∧ y ≤ z ∧ z < n ∧ rank3 x y z = r := by
  induction n with
  | zero => simp [c3] at hr
  | succ n ih =>
    by_cases old : r < c3 n
    · obtain ⟨x, y, z, hxy, hyz, hzn, eq⟩ := ih old
      exact ⟨x, y, z, hxy, hyz, by omega, eq⟩
    · have step := c3_succ n
      have residual : r - c3 n < c2 (n + 1) := by omega
      obtain ⟨x, y, hxy, hyn, eq⟩ := rank2_surjective (n + 1) (r - c3 n) residual
      refine ⟨x, y, n, hxy, by omega, by omega, ?_⟩
      unfold rank2 at eq
      unfold rank3
      omega

def radix (a x y : Nat) : Nat := x + a * y

theorem radix_surjective (a b r : Nat) (ha : 0 < a) (hr : r < a * b) :
    ∃ x y, x < a ∧ y < b ∧ radix a x y = r := by
  refine ⟨r % a, r / a, Nat.mod_lt _ ha, ?_, Nat.mod_add_div _ _⟩
  apply (Nat.div_lt_iff_lt_mul ha).2
  simpa [Nat.mul_comm] using hr

theorem radix_injective {a x y x' y' : Nat} (hx : x < a) (hx' : x' < a)
    (eq : radix a x y = radix a x' y') : x = x' ∧ y = y' := by
  have ha : 0 < a := by omega
  have rem := congrArg (fun n => n % a) eq
  have quo := congrArg (fun n => n / a) eq
  simp only [radix, Nat.add_mul_mod_self_left, Nat.mod_eq_of_lt hx,
    Nat.mod_eq_of_lt hx'] at rem
  simp only [radix, Nat.add_mul_div_left _ _ ha, Nat.div_eq_of_lt hx,
    Nat.div_eq_of_lt hx', Nat.zero_add] at quo
  exact ⟨rem, quo⟩

theorem radix_bound {a b x y : Nat} (hx : x < a) (hy : y < b) :
    radix a x y < a * b := by
  have step : a * (y + 1) ≤ a * b := Nat.mul_le_mul_left a (by omega)
  simp only [Nat.mul_add, Nat.mul_one] at step
  unfold radix
  omega

/-- Three different groups: x + a * (y + b * z). -/
theorem distinct_groups_surjective (a b c r : Nat)
    (ha : 0 < a) (hb : 0 < b) (hr : r < a * (b * c)) :
    ∃ x y z, x < a ∧ y < b ∧ z < c ∧ radix a x (radix b y z) = r := by
  obtain ⟨x, q, hx, hq, eq⟩ := radix_surjective a (b * c) r ha hr
  obtain ⟨y, z, hy, hz, eq'⟩ := radix_surjective b c q hb hq
  exact ⟨x, y, z, hx, hy, hz, by rw [eq', eq]⟩

theorem distinct_groups_injective {a b x y z x' y' z' : Nat}
    (hx : x < a) (hx' : x' < a) (hy : y < b) (hy' : y' < b)
    (eq : radix a x (radix b y z) = radix a x' (radix b y' z')) :
    x = x' ∧ y = y' ∧ z = z' := by
  obtain ⟨ex, eq'⟩ := radix_injective hx hx' eq
  obtain ⟨ey, ez⟩ := radix_injective hy hy' eq'
  exact ⟨ex, ey, ez⟩

/-- The first two groups coincide: rank2 x y + c2(a) * z. -/
theorem first_two_surjective (a c r : Nat) (ha : 0 < c2 a) (hr : r < c2 a * c) :
    ∃ x y z, x ≤ y ∧ y < a ∧ z < c ∧ radix (c2 a) (rank2 x y) z = r := by
  obtain ⟨q, z, hq, hz, eq⟩ := radix_surjective (c2 a) c r ha hr
  obtain ⟨x, y, hxy, hy, eq'⟩ := rank2_surjective a q hq
  exact ⟨x, y, z, hxy, hy, hz, by rw [eq', eq]⟩

theorem first_two_injective {a x y z x' y' z' : Nat}
    (hxy : x ≤ y) (hy : y < a) (hxy' : x' ≤ y') (hy' : y' < a)
    (eq : radix (c2 a) (rank2 x y) z = radix (c2 a) (rank2 x' y') z') :
    x = x' ∧ y = y' ∧ z = z' := by
  obtain ⟨eq', ez⟩ := radix_injective (rank2_lt_group_size hxy hy)
    (rank2_lt_group_size hxy' hy') eq
  obtain ⟨ex, ey⟩ := rank2_injective hxy hxy' eq'
  exact ⟨ex, ey, ez⟩

/-- The last two groups coincide: x + a * rank2 y z. -/
theorem last_two_surjective (a b r : Nat) (ha : 0 < a) (hr : r < a * c2 b) :
    ∃ x y z, x < a ∧ y ≤ z ∧ z < b ∧ radix a x (rank2 y z) = r := by
  obtain ⟨x, q, hx, hq, eq⟩ := radix_surjective a (c2 b) r ha hr
  obtain ⟨y, z, hyz, hz, eq'⟩ := rank2_surjective b q hq
  exact ⟨x, y, z, hx, hyz, hz, by rw [eq', eq]⟩

theorem last_two_injective {a x y z x' y' z' : Nat}
    (hx : x < a) (hx' : x' < a) (hyz : y ≤ z) (hyz' : y' ≤ z')
    (eq : radix a x (rank2 y z) = radix a x' (rank2 y' z')) :
    x = x' ∧ y = y' ∧ z = z' := by
  obtain ⟨ex, eq'⟩ := radix_injective hx hx' eq
  obtain ⟨ey, ez⟩ := rank2_injective hyz hyz' eq'
  exact ⟨ex, ey, ez⟩

theorem first_two_bound {a c x y z : Nat} (hxy : x ≤ y) (hy : y < a) (hz : z < c) :
    radix (c2 a) (rank2 x y) z < c2 a * c :=
  radix_bound (rank2_lt_group_size hxy hy) hz

theorem last_two_bound {a b x y z : Nat} (hx : x < a) (hyz : y ≤ z) (hz : z < b) :
    radix a x (rank2 y z) < a * c2 b :=
  radix_bound hx (rank2_lt_group_size hyz hz)

theorem distinct_groups_bound {a b c x y z : Nat} (hx : x < a) (hy : y < b) (hz : z < c) :
    radix a x (radix b y z) < a * (b * c) := radix_bound hx (radix_bound hy hz)

end Mahjong.EnumerationBlocks

#print axioms Mahjong.EnumerationBlocks.rank2_surjective
#print axioms Mahjong.EnumerationBlocks.rank3_surjective
#print axioms Mahjong.Ranking.rank3_injective
#print axioms Mahjong.Ranking.rank3_lt_group_size
#print axioms Mahjong.EnumerationBlocks.distinct_groups_surjective
#print axioms Mahjong.EnumerationBlocks.distinct_groups_injective
#print axioms Mahjong.EnumerationBlocks.first_two_surjective
#print axioms Mahjong.EnumerationBlocks.first_two_injective
#print axioms Mahjong.EnumerationBlocks.last_two_surjective
#print axioms Mahjong.EnumerationBlocks.last_two_injective
#print axioms Mahjong.EnumerationBlocks.first_two_bound
#print axioms Mahjong.EnumerationBlocks.last_two_bound
#print axioms Mahjong.EnumerationBlocks.distinct_groups_bound
