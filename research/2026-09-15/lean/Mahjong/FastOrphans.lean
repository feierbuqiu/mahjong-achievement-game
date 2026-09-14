import Mahjong.RuleChecker

namespace Mahjong.FastOrphans

theorem countsOf_eq_count (xs : List Tile) (u : Tile) : countsOf xs u = xs.count u := by
  induction xs with
  | nil => rfl
  | cons t ts ih =>
    by_cases h : u = t
    · subst u; simp [countsOf, addTile, unit, ih, Nat.add_comm]
    · simp [countsOf, addTile, unit, ih, h, Ne.symm h]

theorem contains_pair (s : State) (p : Tile) (hp : p ∈ orphans) :
    Contains (countsOf (p :: orphans)) s ↔
      (∀ u, u ∈ orphans → 1 ≤ s u) ∧ 2 ≤ s p := by
  constructor
  · intro contained
    have pair := contained p
    simp [countsOf_eq_count, orphans_nodup.count, hp] at pair
    refine ⟨?_, pair⟩
    intro u hu
    have h := contained u
    by_cases eq : u = p
    · subst u; omega
    · simpa [countsOf_eq_count, orphans_nodup.count, hu, eq, Ne.symm eq] using h
  · rintro ⟨all, pair⟩ u
    by_cases eq : u = p
    · subst u
      simpa [countsOf_eq_count, orphans_nodup.count, hp] using pair
    · by_cases hu : u ∈ orphans
      · simpa [countsOf_eq_count, orphans_nodup.count, hu, eq, Ne.symm eq] using all u hu
      · simp [countsOf_eq_count, orphans_nodup.count, hu, eq, Ne.symm eq]

def orphansB (s : State) : Bool :=
  orphans.all (fun u => decide (1 ≤ s u)) && orphans.any (fun u => decide (2 ≤ s u))

theorem orphansB_eq (s : State) : orphansB s = RuleChecker.orphansB s := by
  apply Bool.eq_iff_iff.2
  change orphansB s = true ↔ RuleChecker.orphansB s = true
  simp only [orphansB, RuleChecker.orphansB, Bool.and_eq_true, List.all_eq_true,
    List.any_eq_true, decide_eq_true_eq, RuleChecker.containsB_iff]
  constructor
  · rintro ⟨all, p, hp, pair⟩
    exact ⟨p, hp, (contains_pair s p hp).2 ⟨all, pair⟩⟩
  · rintro ⟨p, hp, contains⟩
    have parts := (contains_pair s p hp).1 contains
    exact ⟨parts.1, p, hp, parts.2⟩

end Mahjong.FastOrphans

#print axioms Mahjong.FastOrphans.orphansB_eq
