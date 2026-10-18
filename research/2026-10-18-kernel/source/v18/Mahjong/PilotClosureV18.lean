import Mahjong.PilotActualGameV18
import Mahjong.PilotScanCount56V18
import Mahjong.PilotScanV18

set_option autoImplicit false

/-! This is a small, saved, closed proof experiment on actual nonempty
positions. The row-acceptance experiment and the original-game certificate
are distinct statements. Neither asserts acceptance of the full V17 input
or a winner from the empty state. -/

namespace Mahjong.PilotClosureV18
open SafeGame PilotGameV18 PilotActualDataV18

theorem actual_game_closed :
    SecondPlayerWins Step Win (state node2) ∧
    SecondPlayerWins Step Win (state node3) ∧
    WinningStrategy Step Win (state node1) :=
  ⟨PilotActualGameV18.actual_p50_second_player_wins,
    PilotActualGameV18.actual_p55_second_player_wins,
    PilotActualGameV18.actual_n35_first_player_wins⟩

theorem original_hot_checker_closed : PilotScanDataV18.checkPrefix 56 = true :=
  PilotScanCount56V18.accepted

theorem actual_scalar_scans_closed :
    GuardedByteScanV16.scan PilotScanV18.p0snapshot PilotScanV18.p0view
      PilotScanV18.p0ctx PilotScanV18.p0sourceBits PilotScanV18.p0compact
      0 1 0 1017 1017 1017 0 = .ok 1 ∧
    GuardedByteScanV16.scan PilotScanV18.n35snapshot PilotScanV18.n35view
      PilotScanV18.n35ctx PilotScanV18.n35sourceBits PilotScanV18.n35compact
      35 1 35 1017 1017 1127 0 = .ok 0 :=
  ⟨PilotScanV18.p0_scan_accepted, PilotScanV18.n35_scan_accepted⟩

end Mahjong.PilotClosureV18

#check Mahjong.PilotClosureV18.actual_game_closed
#check Mahjong.PilotClosureV18.original_hot_checker_closed
#check Mahjong.PilotClosureV18.actual_scalar_scans_closed
#print axioms Mahjong.PilotClosureV18.actual_game_closed
#print axioms Mahjong.PilotClosureV18.original_hot_checker_closed
#print axioms Mahjong.PilotClosureV18.actual_scalar_scans_closed
