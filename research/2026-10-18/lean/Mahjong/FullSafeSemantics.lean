import Mahjong.OrphanPruning

set_option autoImplicit false

namespace Mahjong.FullSafeSemantics
open PruningAlgebra PruningSemantics

theorem no_win_of_components (s : State)
    (pairs : (RuleChecker.pairKinds s).length < 7)
    (standard : (current s).pair < 5)
    (orphans : FastOrphans.orphansB s ≠ true) : ¬ Win s := by
  apply FactorizedRules.noWinB_sound s
  rw [← SummaryRules.noWinB_spec]
  simp only [SummaryRules.noWinB, Bool.and_eq_true, Bool.not_eq_true']
  refine ⟨⟨?_, ?_⟩, (current_pair_iff s).mpr standard⟩
  · rw [SummaryRules.sevenPairsB_spec]
    simp only [RuleChecker.sevenPairsB, decide_eq_false_iff_not]
    omega
  · rw [SummaryRules.orphansB_spec]
    exact Bool.eq_false_iff.mpr orphans

theorem pairKinds_after_subset (s : State) (u : Tile) :
    RuleChecker.pairKinds (addTile s u) ⊆ u :: RuleChecker.pairKinds s := by
  intro v hv
  have large := (RuleChecker.mem_pairKinds _ _).mp hv
  by_cases eq : v = u
  · exact List.mem_cons.mpr (Or.inl eq)
  · rw [addTile_other s eq] at large
    exact List.mem_cons.mpr (Or.inr ((RuleChecker.mem_pairKinds _ _).mpr large))

theorem pairs_after_lt (s : State) (u : Tile)
    (small : (RuleChecker.pairKinds s).length < 7)
    (noSix : ¬ ((RuleChecker.pairKinds s).length = 6 ∧ ∃ v, s v = 1)) :
    (RuleChecker.pairKinds (addTile s u)).length < 7 := by
  have nd : (RuleChecker.pairKinds (addTile s u)).Nodup := List.filter_sublist.nodup allTiles_nodup
  by_cases one : s u = 1
  · have bound := nd.length_le_of_subset (pairKinds_after_subset s u)
    change (RuleChecker.pairKinds (addTile s u)).length ≤ (RuleChecker.pairKinds s).length + 1 at bound
    have notSix : (RuleChecker.pairKinds s).length ≠ 6 := fun eq => noSix ⟨eq, u, one⟩
    omega
  · have sub : RuleChecker.pairKinds (addTile s u) ⊆ RuleChecker.pairKinds s := by
      intro v hv
      apply (RuleChecker.mem_pairKinds s v).mpr
      have large := (RuleChecker.mem_pairKinds _ _).mp hv
      by_cases eq : v = u
      · subst v; rw [addTile_self] at large; omega
      · rwa [addTile_other s eq] at large
    have bound := nd.length_le_of_subset sub
    change (RuleChecker.pairKinds (addTile s u)).length ≤ (RuleChecker.pairKinds s).length at bound
    omega

theorem local_contributes_global (s : State) (b : Nat) (hb : b < 4)
    (h : contributes (withLocal b s (addedEnvelope b s)).pair 0) :
    contributes (allLabels s).added.pair 0 := by
  have cases : b = 0 ∨ b = 1 ∨ b = 2 ∨ b = 3 := by omega
  unfold allLabels
  apply (four_added_contributes _ _ _ _).mpr
  rcases cases with rfl | rfl | rfl | rfl
  · exact Or.inl (by simpa [withLocal, labelOf] using h)
  · exact Or.inr (Or.inl (by simpa [withLocal, labelOf] using h))
  · exact Or.inr (Or.inr (Or.inl (by simpa [withLocal, labelOf] using h)))
  · exact Or.inr (Or.inr (Or.inr (by simpa [withLocal, labelOf] using h)))

theorem standard_after_lt (s : State) (u : Tile) (available : s u < 4)
    (small : (allLabels s).added.pair < 5) : (current (addTile s u)).pair < 5 := by
  apply Nat.lt_of_not_ge
  intro large
  let b := u.val / 9
  have hb : b < 4 := by have range := u.isLt; dsimp [b]; omega
  have child : profileOf b (addTile s u) ∈ afterProfiles b s := by
    apply List.mem_map.mpr
    refine ⟨u, List.mem_filter.mpr ⟨?_, by simpa using available⟩, rfl⟩
    exact (PairProfile.mem_blockTiles b u).mpr rfl
  have localContribution : contributes (withLocal b s (addedEnvelope b s)).pair 0 := by
    unfold addedEnvelope
    rw [map_envelope (withLocal b s) (withLocal_unify b s)]
    apply (contributes_envelope _ _ 0).mpr
    apply Or.inr
    refine ⟨withLocal b s (profileOf b (addTile s u)), List.mem_map.mpr ⟨_, child, rfl⟩, ?_⟩
    rw [withLocal_after b s u rfl]
    unfold contributes
    omega
  have globalContribution := local_contributes_global s b hb localContribution
  unfold contributes at globalContribution
  omega

/-- Full semantic filtering is both necessary and sufficient under the original
rules. The theorem has no layer bound or enumeration-completeness premise. -/
theorem full_filter_iff_safe (s : State) (valid : Valid s) :
    fullSafe (allLabels s) ↔ IsSafe s := by
  constructor
  · rintro ⟨pass, orphan⟩
    have safeOrphan : ¬ OrphanPruning.rejected s := fun h =>
      orphan ((OrphanPruning.allLabels_rejected s).mpr h)
    have pairSmall : (RuleChecker.pairKinds s).length < 7 := by
      simpa only [allLabels_pairs] using pass.1
    have noSix : ¬ ((RuleChecker.pairKinds s).length = 6 ∧ ∃ v, s v = 1) := by
      rintro ⟨six, single⟩
      exact pass.2.2.2 ⟨by simpa only [allLabels_pairs] using six, (allLabels_single s).mpr single⟩
    refine ⟨no_win_of_components s pairSmall pass.2.1
      (fun h => safeOrphan (OrphanPruning.rejected_of_current s h)), ?_⟩
    rintro next ⟨u, legal, rfl⟩
    exact no_win_of_components _ (pairs_after_lt s u pairSmall noSix)
      (standard_after_lt s u legal.2 pass.2.2.1)
      (fun h => safeOrphan (OrphanPruning.rejected_of_after s u h))
  · exact OrphanPruning.safe_full_filter s valid

end Mahjong.FullSafeSemantics

#print axioms Mahjong.FullSafeSemantics.pairs_after_lt
#print axioms Mahjong.FullSafeSemantics.standard_after_lt
#print axioms Mahjong.FullSafeSemantics.full_filter_iff_safe
