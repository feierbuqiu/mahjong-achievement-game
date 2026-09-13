import MahjongNext.Actual14.Group0
import MahjongNext.Actual14.Group1
import MahjongNext.Actual14.Group2
import MahjongNext.Actual14.Group3
import MahjongNext.Actual14.Group4
import MahjongNext.Actual14.Group5
import MahjongNext.Actual14.Group6

set_option maxRecDepth 16384
set_option maxHeartbeats 100000000

namespace Mahjong.Actual14
open ResponseTable ResponseGroups ResponseCertificate Generators

theorem first16_checked : checkRange bounds database 0 16 = true :=
  checkRange_append bounds database 0 8 8 group0_checked group1_checked

theorem first24_checked : checkRange bounds database 0 24 = true :=
  checkRange_append bounds database 0 16 8 first16_checked group2_checked

theorem first32_checked : checkRange bounds database 0 32 = true :=
  checkRange_append bounds database 0 24 8 first24_checked group3_checked

theorem first40_checked : checkRange bounds database 0 40 = true :=
  checkRange_append bounds database 0 32 8 first32_checked group4_checked

theorem first48_checked : checkRange bounds database 0 48 = true :=
  checkRange_append bounds database 0 40 8 first40_checked group5_checked

theorem first50_checked : checkRange bounds database 0 50 = true :=
  checkRange_append bounds database 0 48 2 first48_checked group6_checked

theorem complete_coverage : (rows database).length ≤ 50 := by decide +kernel

theorem checked : checkDatabase bounds database = true :=
  checkDatabase_of_full_range bounds database 50 complete_coverage first50_checked

theorem root_proved : ProvedP state49 :=
  checkDatabase_sound bounds validBounds safeBounds database checked 49 row49 (by rfl)

def original (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 4 | 9 | 10 | 11 | 13 | 14 | 15 | 16 | 18 | 19 | 20 | 24 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 0
  | 5 | 6 | 7 | 8 | 12 | 21 | 22 => 1
  | 17 | 23 => 2
  | 25 => 3
  | _ => 0

theorem original_checked : Generators.checkReference [] state49 original = true := by decide +kernel
theorem original_proved : ProvedP original :=
  root_proved.ofPath [] (Generators.stateEqB_sound original_checked)
theorem original_tiles : total original = 14 := by decide +kernel
theorem original_second_player_wins : SafeGame.SecondPlayerWins Step Win original :=
  original_proved.secondPlayerWins

end Mahjong.Actual14

#print axioms Mahjong.Actual14.complete_coverage
#print axioms Mahjong.Actual14.checked
#print axioms Mahjong.Actual14.root_proved
#print axioms Mahjong.Actual14.original_proved
#print axioms Mahjong.Actual14.original_second_player_wins
