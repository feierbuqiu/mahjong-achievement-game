import Mahjong.FactorizedRules
import Mahjong.FastOrphans

namespace Mahjong.CapacityComplete
open StandardBoundCertificate

theorem capacity_lower (b : Nat) (s : State) :
    searchWith (localMelds b) (FactorizedRules.capacity b s) s = true := by
  unfold FactorizedRules.capacity
  split
  · rfl
  next h1 =>
    split
    · simpa using h1
    next h2 =>
      split
      · simpa using h2
      next h3 =>
        split
        · simpa using h3
        next h4 => simpa using h4

theorem member_block (m : Meld) (u : Tile) (hm : u ∈ m.tiles) :
    u.val / 9 = meldBlock m := by
  cases m with
  | triplet t =>
    simp only [Meld.tiles, List.mem_cons, List.not_mem_nil, or_false, or_self] at hm
    subst u; rfl
  | sequence suit start =>
    simp only [Meld.tiles, List.mem_cons, List.not_mem_nil, or_false] at hm
    rcases hm with rfl | rfl | rfl <;> exact seqTile_same_suit _ _ _

theorem local_count_zero (b : Nat) (ms : List Meld)
    (allowed : ∀ m, m ∈ ms → m ∈ localMelds b) (u : Tile) (other : u.val / 9 ≠ b) :
    countsOf (ms.flatMap Meld.tiles) u = 0 := by
  rw [FastOrphans.countsOf_eq_count]
  apply List.count_eq_zero.mpr
  intro member
  obtain ⟨m, hm, hu⟩ := List.mem_flatMap.mp member
  exact other ((member_block m u hu).trans ((mem_localMelds b m).mp (allowed m hm)))

theorem four_melds_of_sum (s : State) (large : 4 ≤ (FactorizedRules.capacities s).total) :
    ∃ ms : List Meld, ms.length = 4 ∧ Contains (countsOf (ms.flatMap Meld.tiles)) s := by
  obtain ⟨a, ha, aa, ca⟩ := (searchWith_iff _ _ _).mp (capacity_lower 0 s)
  obtain ⟨b, hb, ab, cb⟩ := (searchWith_iff _ _ _).mp (capacity_lower 1 s)
  obtain ⟨c, hc, ac, cc⟩ := (searchWith_iff _ _ _).mp (capacity_lower 2 s)
  obtain ⟨d, hd, ad, cd⟩ := (searchWith_iff _ _ _).mp (capacity_lower 3 s)
  let all := a ++ b ++ c ++ d
  have length : 4 ≤ all.length := by
    simpa [all, FactorizedRules.capacities, Caps.total, ha, hb, hc, hd, Nat.add_assoc] using large
  have contained : Contains (countsOf (all.flatMap Meld.tiles)) s := by
    intro u
    have hu := u.isLt
    have blocks : u.val / 9 = 0 ∨ u.val / 9 = 1 ∨ u.val / 9 = 2 ∨ u.val / 9 = 3 := by omega
    simp only [all, List.flatMap_append, RuleChecker.countsOf_append]
    rcases blocks with h | h | h | h
    · rw [local_count_zero 1 b ab u (by omega), local_count_zero 2 c ac u (by omega),
        local_count_zero 3 d ad u (by omega)]
      simpa using ca u
    · rw [local_count_zero 0 a aa u (by omega), local_count_zero 2 c ac u (by omega),
        local_count_zero 3 d ad u (by omega)]
      simpa using cb u
    · rw [local_count_zero 0 a aa u (by omega), local_count_zero 1 b ab u (by omega),
        local_count_zero 3 d ad u (by omega)]
      simpa using cc u
    · rw [local_count_zero 0 a aa u (by omega), local_count_zero 1 b ab u (by omega),
        local_count_zero 2 c ac u (by omega)]
      simpa using cd u
  exact ⟨all.take 4, List.length_take_of_le length,
    contains_trans (packing_sublist_mono (List.take_sublist _ _)) contained⟩

theorem noWinB_of_no_win (s : State) (valid : Valid s) (no : ¬ Win s) :
    FactorizedRules.noWinB s = true := by
  have falseWin : RuleChecker.winB s = false := (RuleChecker.winB_false_iff s valid).mpr no
  have parts := falseWin
  simp only [RuleChecker.winB, (RuleChecker.validB_iff s).mpr valid, Bool.true_and,
    Bool.or_eq_false_iff] at parts
  simp only [FactorizedRules.noWinB, Bool.and_eq_true, Bool.not_eq_true']
  refine ⟨⟨parts.1.2, parts.2⟩, ?_⟩
  apply List.all_eq_true.mpr
  intro p _
  by_cases available : FastRuleChecker.pairAvailableB s p = true
  · simp only [available, ↓reduceIte, decide_eq_true_eq]
    by_cases small : (FactorizedRules.capacities (FastRuleChecker.removePair s p)).total < 4
    · exact small
    exfalso
    have large : 4 ≤ (FactorizedRules.capacities (FastRuleChecker.removePair s p)).total := by omega
    have packing := four_melds_of_sum _ large
    have standard : RuleChecker.standardB s = true := by
      simp only [RuleChecker.standardB, List.any_eq_true, Bool.and_eq_true]
      refine ⟨p, mem_allTiles p, ?_, ?_⟩
      · simpa only [FastRuleChecker.pairAvailableB_eq] using available
      · apply (RuleChecker.meldSearch_iff _ _).mpr
        simpa only [FastRuleChecker.removePair_eq] using packing
    rw [parts.1.1] at standard
    contradiction
  · simp [available]

theorem noWinB_iff (s : State) (valid : Valid s) :
    FactorizedRules.noWinB s = true ↔ ¬ Win s :=
  ⟨FactorizedRules.noWinB_sound s, noWinB_of_no_win s valid⟩

end Mahjong.CapacityComplete

#print axioms Mahjong.CapacityComplete.noWinB_iff
