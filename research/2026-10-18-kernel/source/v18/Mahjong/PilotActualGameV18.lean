import Mahjong.PilotGameChecksV18

set_option autoImplicit false
set_option maxRecDepth 32768
set_option maxHeartbeats 20000000

namespace Mahjong.PilotActualGameV18
open SafeGame PilotGameV18 PilotActualDataV18

/-- The actual finite proposal is checked in the ordinary kernel, including
all physical SAFE successors of P entries and every purported terminal leaf.
There is no external accepted flag or unchecked terminal premise. -/
theorem actual_checked : checkTrace actualTrace = true :=
  PilotGameChecksV18.actual_trace_checked

theorem all_actual_nodes : ∀ node, node ∈ actualTrace →
    Valid (state node) ∧ IsSafe (state node) ∧ NormalStrategy SafeMove (state node) node.label :=
  trace_sound actualTrace actual_checked

theorem actual_p50_second_player_wins : SecondPlayerWins Step Win (state node2) :=
  second_player_wins actualTrace actual_checked node2 (by simp [actualTrace]) rfl

theorem actual_p55_second_player_wins : SecondPlayerWins Step Win (state node3) :=
  second_player_wins actualTrace actual_checked node3 (by simp [actualTrace]) rfl

theorem actual_n35_first_player_wins : WinningStrategy Step Win (state node1) :=
  first_player_wins actualTrace actual_checked node1 (by simp [actualTrace]) rfl

/-- These actual starting positions contain 32 tiles. None is the opening. -/
theorem sampled_positions_have_32_tiles :
    (allTiles.map (state node1)).sum = 32 ∧ (allTiles.map (state node2)).sum = 32 ∧
      (allTiles.map (state node3)).sum = 32 := by decide +kernel

end Mahjong.PilotActualGameV18

#check Mahjong.PilotActualGameV18.actual_p50_second_player_wins
#check Mahjong.PilotActualGameV18.actual_p55_second_player_wins
#check Mahjong.PilotActualGameV18.actual_n35_first_player_wins
#print axioms Mahjong.PilotActualGameV18.actual_checked
#print axioms Mahjong.PilotActualGameV18.all_actual_nodes
#print axioms Mahjong.PilotActualGameV18.actual_p50_second_player_wins
#print axioms Mahjong.PilotActualGameV18.actual_p55_second_player_wins
#print axioms Mahjong.PilotActualGameV18.actual_n35_first_player_wins
#print axioms Mahjong.PilotActualGameV18.sampled_positions_have_32_tiles
