import MahjongNext.Grouped20.Group0
import MahjongNext.Grouped20.Group1
import MahjongNext.Grouped20.Group2

set_option maxRecDepth 16384
set_option maxHeartbeats 100000000

namespace Mahjong.ResponseTableGrouped20
open ResponseTable ResponseGroups ResponseCertificate Generators

theorem first16_checked : checkRange bounds database 0 16 = true :=
  checkRange_append bounds database 0 8 8 group0_checked group1_checked

theorem all24_checked : checkRange bounds database 0 24 = true :=
  checkRange_append bounds database 0 16 8 first16_checked group2_checked

theorem complete_coverage : (rows database).length ≤ 24 := by decide +kernel

theorem checked : checkDatabase bounds database = true :=
  checkDatabase_of_full_range bounds database 24 complete_coverage all24_checked

theorem root_proved : ProvedP state23 :=
  checkDatabase_sound bounds validBounds safeBounds database checked 23 row23 (by rfl)

def original (t : Tile) : Nat :=
  match t.val with
  | 0 | 3 | 6 | 10 | 12 | 15 | 16 | 17 | 19 | 21 | 24 | 25 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 0
  | 1 | 2 | 8 | 9 | 11 | 13 | 14 | 18 | 20 | 22 | 23 => 1
  | 4 | 5 | 7 => 3
  | _ => 0

theorem original_checked : Generators.checkReference [.swapSuits 0 2, .swapSuits 1 2, .reverseSuit 1, .reverseSuit 2] state23 original = true := by decide +kernel
theorem original_proved : ProvedP original :=
  root_proved.ofPath [.swapSuits 0 2, .swapSuits 1 2, .reverseSuit 1, .reverseSuit 2] (Generators.stateEqB_sound original_checked)
theorem original_tiles : total original = 20 := by decide +kernel
theorem original_second_player_wins : SafeGame.SecondPlayerWins Step Win original :=
  original_proved.secondPlayerWins

end Mahjong.ResponseTableGrouped20

#print axioms Mahjong.ResponseTableGrouped20.complete_coverage
#print axioms Mahjong.ResponseTableGrouped20.checked
#print axioms Mahjong.ResponseTableGrouped20.root_proved
#print axioms Mahjong.ResponseTableGrouped20.original_proved
#print axioms Mahjong.ResponseTableGrouped20.original_second_player_wins
