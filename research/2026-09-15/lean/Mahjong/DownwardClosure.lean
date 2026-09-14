import Mahjong.Bridge

/- Safety is hereditary under deleting tiles from valid shared tables.
   This justifies monotone pruning once the local unsafe predicate is exact;
   it does not assert that an external profile implementation is exact. -/
namespace Mahjong

theorem addTile_mono {s t : State} (h : Contains s t) (kind : Tile) :
    Contains (addTile s kind) (addTile t kind) := by
  intro u
  exact Nat.add_le_add_right (h u) (unit kind u)

theorem safe_of_contains {s t : State} (contained : Contains s t)
    (valid : Valid t) (safe : IsSafe t) : IsSafe s := by
  refine ⟨fun won => safe.1 (win_mono contained won), ?_⟩
  rintro _ ⟨kind, legal, rfl⟩ won
  by_cases extra : s kind < t kind
  · have supplied : Contains (addTile s kind) t := by
      intro u
      by_cases same : u = kind
      · subst u
        simp only [addTile_self]
        omega
      · simpa only [addTile_other s same] using contained u
    exact safe.1 (win_mono supplied won)
  · have countsEqual : s kind = t kind := by
      have h := contained kind
      omega
    have available : t kind < 4 := by rw [← countsEqual]; exact legal.2
    exact safe.2 (addTile t kind) ⟨kind, ⟨valid, available⟩, rfl⟩
      (win_mono (addTile_mono contained kind) won)

theorem unsafe_superset {s t : State} (contained : Contains s t)
    (valid : Valid t) (notSafe : ¬ IsSafe s) : ¬ IsSafe t :=
  fun safe => notSafe (safe_of_contains contained valid safe)

end Mahjong

#print axioms Mahjong.safe_of_contains
#print axioms Mahjong.unsafe_superset
