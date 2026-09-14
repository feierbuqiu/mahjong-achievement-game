import Mahjong.FastMemoRules
import Mahjong.CapacityComplete

namespace Mahjong.ExactMemoRules

theorem noWinB_eq (tables : MemoRules.Tables) (checked : MemoRules.Checked tables) (s : State) :
    FastMemoRules.noWinB tables s = FactorizedRules.noWinB s := by
  rw [FastMemoRules.noWinB_eq]
  simp only [MemoRules.noWinB, FactorizedRules.noWinB]
  simp only [MemoRules.afterPairTotal_eq tables checked]
  simp only [MemoRules.capacities_eq tables checked]

/-- The capacity test is now proved complete. No recursive global meld-search
    fallback is required, including when a child actually contains a win. -/
def winB (tables : MemoRules.Tables) (s : State) : Bool :=
  RuleChecker.validB s && !FastMemoRules.noWinB tables s

theorem winB_eq (tables : MemoRules.Tables) (checked : MemoRules.Checked tables) (s : State) :
    winB tables s = FastRuleChecker.winB s := by
  apply Bool.eq_iff_iff.2
  change winB tables s = true ↔ FastRuleChecker.winB s = true
  rw [FastRuleChecker.winB_eq, RuleChecker.winB_iff_valid_and_win]
  simp only [winB, Bool.and_eq_true, Bool.not_eq_true', RuleChecker.validB_iff,
    noWinB_eq tables checked]
  constructor
  · rintro ⟨valid, no⟩
    refine ⟨valid, Classical.not_not.mp ?_⟩
    intro absent
    have yes := CapacityComplete.noWinB_of_no_win s valid absent
    rw [no] at yes
    contradiction
  · rintro ⟨valid, win⟩
    refine ⟨valid, Bool.eq_false_iff.mpr ?_⟩
    intro falseCert
    exact FactorizedRules.noWinB_sound s falseCert win

def safeB (tables : MemoRules.Tables) (s : State) : Bool :=
  RuleChecker.validB s && !winB tables s && allTiles.all (fun t =>
    if s t < 4 then !winB tables (addTile s t) else true)

theorem safeB_eq (tables : MemoRules.Tables) (checked : MemoRules.Checked tables) (s : State) :
    safeB tables s = FastRuleChecker.safeB s := by
  simp only [safeB, FastRuleChecker.safeB, winB_eq tables checked]

def safeSuccessors (tables : MemoRules.Tables) (s : State) : List State :=
  if RuleChecker.validB s then
    allTiles.filterMap (fun kind =>
      if s kind < 4 then
        let child := addTile s kind
        if safeB tables child then some child else none
      else none)
  else []

theorem safeSuccessors_eq (tables : MemoRules.Tables) (checked : MemoRules.Checked tables) (s : State) :
    safeSuccessors tables s = FastRuleChecker.safeSuccessors s := by
  simp only [safeSuccessors, FastRuleChecker.safeSuccessors, safeB_eq tables checked]

end Mahjong.ExactMemoRules

#print axioms Mahjong.ExactMemoRules.winB_eq
#print axioms Mahjong.ExactMemoRules.safeSuccessors_eq
