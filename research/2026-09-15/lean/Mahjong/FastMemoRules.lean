import Mahjong.MemoRules
import Mahjong.FastOrphans

namespace Mahjong.FastMemoRules

def noWinB (tables : MemoRules.Tables) (s : State) : Bool :=
  let base := MemoRules.capacities tables s
  !RuleChecker.sevenPairsB s && !FastOrphans.orphansB s &&
    allTiles.all (fun p => if FastRuleChecker.pairAvailableB s p then
      decide (MemoRules.afterPairTotal tables s base p < 4) else true)

theorem noWinB_eq (tables : MemoRules.Tables) (s : State) :
    noWinB tables s = MemoRules.noWinB tables s := by
  simp only [noWinB, MemoRules.noWinB, FastOrphans.orphansB_eq]

def winB (tables : MemoRules.Tables) (s : State) : Bool :=
  if noWinB tables s then false else FastRuleChecker.winB s

theorem winB_eq (tables : MemoRules.Tables) (s : State) : winB tables s = MemoRules.winB tables s := by
  simp only [winB, MemoRules.winB, noWinB_eq]

def safeB (tables : MemoRules.Tables) (s : State) : Bool :=
  RuleChecker.validB s && !winB tables s && allTiles.all (fun t =>
    if s t < 4 then !winB tables (addTile s t) else true)

theorem safeB_eq (tables : MemoRules.Tables) (s : State) : safeB tables s = MemoRules.safeB tables s := by
  simp only [safeB, MemoRules.safeB, winB_eq]

def safeSuccessors (tables : MemoRules.Tables) (s : State) : List State :=
  if RuleChecker.validB s then
    allTiles.filterMap (fun kind =>
      if s kind < 4 then
        let child := addTile s kind
        if safeB tables child then some child else none
      else none)
  else []

theorem safeSuccessors_eq (tables : MemoRules.Tables) (s : State) :
    safeSuccessors tables s = MemoRules.safeSuccessors tables s := by
  simp only [safeSuccessors, MemoRules.safeSuccessors, safeB_eq]

end Mahjong.FastMemoRules

#print axioms Mahjong.FastMemoRules.safeSuccessors_eq
