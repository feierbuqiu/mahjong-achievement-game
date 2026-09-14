import Mahjong.PruningSemantics

set_option autoImplicit false

namespace Mahjong.OrphanPruning
open PruningAlgebra PruningSemantics

def missingTiles (s : State) : List Tile := orphans.filter (fun u => decide (s u = 0))

def hasPair (s : State) : Prop := ∃ u, u ∈ orphans ∧ 2 ≤ s u

def rejected (s : State) : Prop :=
  (missingTiles s).length = 0 ∨ ((missingTiles s).length = 1 ∧ hasPair s)

theorem mem_missing (s : State) (u : Tile) :
    u ∈ missingTiles s ↔ u ∈ orphans ∧ s u = 0 := by
  simp [missingTiles]

theorem missing_zero (s : State) :
    (missingTiles s).length = 0 ↔ ∀ u, u ∈ orphans → 1 ≤ s u := by
  simp only [missingTiles, List.length_eq_zero_iff, List.filter_eq_nil_iff, decide_eq_true_eq]
  constructor
  · intro h u hu; have n := h u hu; omega
  · intro h u hu; have n := h u hu; omega

theorem orphan_win_iff (s : State) :
    FastOrphans.orphansB s = true ↔ (missingTiles s).length = 0 ∧ hasPair s := by
  simp only [FastOrphans.orphansB, Bool.and_eq_true, List.all_eq_true,
    List.any_eq_true, decide_eq_true_eq, hasPair, missing_zero]

theorem orphan_win (s : State) (valid : Valid s) (h : FastOrphans.orphansB s = true) : Win s := by
  obtain ⟨target, hand, contained⟩ := (RuleChecker.orphansB_iff s).mp ((FastOrphans.orphansB_eq s) ▸ h)
  exact ⟨target, ⟨contains_valid contained valid, Or.inr (Or.inr hand)⟩, contained⟩

theorem rejected_of_current (s : State) (h : FastOrphans.orphansB s = true) : rejected s :=
  Or.inl ((orphan_win_iff s).mp h).1

theorem rejected_of_after (s : State) (u : Tile)
    (h : FastOrphans.orphansB (addTile s u) = true) : rejected s := by
  obtain ⟨allZero, pair⟩ := (orphan_win_iff _).mp h
  have all := (missing_zero _).mp allZero
  by_cases zero : (missingTiles s).length = 0
  · exact Or.inl zero
  have subset : missingTiles s ⊆ [u] := by
    intro v hv
    obtain ⟨ho, absent⟩ := (mem_missing s v).mp hv
    have positive := all v ho
    by_cases eq : v = u
    · simp [eq]
    · rw [addTile_other s eq] at positive
      omega
  have length := (List.filter_sublist.nodup orphans_nodup : (missingTiles s).Nodup).length_le_of_subset subset
  change (missingTiles s).length ≤ 1 at length
  have one : (missingTiles s).length = 1 := by omega
  obtain ⟨v, only⟩ := List.length_eq_one_iff.mp one
  have vm : v ∈ missingTiles s := by rw [only]; simp
  have vu : v = u := by simpa using subset vm
  have absent : s u = 0 := by simpa [vu] using ((mem_missing s v).mp vm).2
  obtain ⟨p, hp, large⟩ := pair
  have other : p ≠ u := by intro eq; subst p; rw [addTile_self, absent] at large; omega
  rw [addTile_other s other] at large
  exact Or.inr ⟨one, p, hp, large⟩

theorem current_or_after_of_rejected (s : State) (h : rejected s) :
    FastOrphans.orphansB s = true ∨
      ∃ u, s u < 4 ∧ FastOrphans.orphansB (addTile s u) = true := by
  rcases h with zero | ⟨one, pair⟩
  · by_cases pair : hasPair s
    · exact Or.inl ((orphan_win_iff s).mpr ⟨zero, pair⟩)
    have all := (missing_zero s).mp zero
    have member : (0 : Tile) ∈ orphans := by decide
    have atLeast := all 0 member
    have small : s 0 < 2 := by
      apply Nat.lt_of_not_ge
      intro large
      exact pair ⟨0, member, large⟩
    have single : s 0 = 1 := by omega
    apply Or.inr
    refine ⟨0, by omega, (orphan_win_iff _).mpr ⟨?_, ?_⟩⟩
    · apply (missing_zero _).mpr
      intro v hv
      exact Nat.le_trans (all v hv) (addTile_contains s 0 v)
    · exact ⟨0, member, by rw [addTile_self, single]; decide⟩
  · obtain ⟨u, only⟩ := List.length_eq_one_iff.mp one
    have member : u ∈ missingTiles s := by rw [only]; simp
    have absent := ((mem_missing s u).mp member).2
    apply Or.inr
    refine ⟨u, by omega, (orphan_win_iff _).mpr ⟨?_, ?_⟩⟩
    · apply (missing_zero _).mpr
      intro v hv
      by_cases eq : v = u
      · subst v; rw [addTile_self]; omega
      · have positive : 1 ≤ s v := by
          apply Nat.le_of_not_lt
          intro no
          have inMissing : v ∈ missingTiles s := (mem_missing s v).mpr ⟨hv, by omega⟩
          rw [only] at inMissing
          exact eq (by simpa using inMissing)
        exact Nat.le_trans positive (addTile_contains s u v)
    · obtain ⟨p, hp, large⟩ := pair
      exact ⟨p, hp, Nat.le_trans large (addTile_contains s u p)⟩

theorem rejected_iff_current_or_after (s : State) :
    rejected s ↔ FastOrphans.orphansB s = true ∨
      ∃ u, s u < 4 ∧ FastOrphans.orphansB (addTile s u) = true := by
  constructor
  · exact current_or_after_of_rejected s
  · rintro (now | ⟨u, _, later⟩)
    · exact rejected_of_current s now
    · exact rejected_of_after s u later

theorem safe_not_rejected (s : State) (valid : Valid s) (safe : IsSafe s) : ¬ rejected s := by
  intro h
  rcases current_or_after_of_rejected s h with now | ⟨u, available, later⟩
  · exact safe.1 (orphan_win s valid now)
  · exact safe.2 _ ⟨u, ⟨valid, available⟩, rfl⟩
      (orphan_win _ (valid_add valid available) later)

theorem allLabels_missing (s : State) : (allLabels s).missing = (missingTiles s).length := by
  simp only [allLabels, join, labelOf, missingTiles]
  rw [SummaryRules.orphans_partition]
  simp only [List.filter_append, List.length_append]

theorem allLabels_orphanPair (s : State) : (allLabels s).orphanPair = true ↔ hasPair s := by
  have partition : orphans.any (fun u => decide (2 ≤ s u)) = (allLabels s).orphanPair := by
    rw [SummaryRules.orphans_partition]
    simp only [List.any_append, allLabels, join, labelOf]
  rw [← partition]
  simp only [List.any_eq_true, decide_eq_true_eq, hasPair]

theorem allLabels_rejected (s : State) :
    ((allLabels s).missing = 0 ∨ ((allLabels s).missing = 1 ∧ (allLabels s).orphanPair = true)) ↔
      rejected s := by
  rw [allLabels_missing, allLabels_orphanPair]
  rfl

theorem safe_full_filter (s : State) (valid : Valid s) (safe : IsSafe s) : fullSafe (allLabels s) :=
  ⟨safe_passes_partial s valid safe,
    fun h => safe_not_rejected s valid safe ((allLabels_rejected s).mp h)⟩

end Mahjong.OrphanPruning

#print axioms Mahjong.OrphanPruning.rejected_iff_current_or_after
#print axioms Mahjong.OrphanPruning.safe_full_filter
