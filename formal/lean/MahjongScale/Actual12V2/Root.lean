import MahjongScale.Actual12V2.Group000
import MahjongScale.Actual12V2.Group001
import MahjongScale.Actual12V2.Group002
import MahjongScale.Actual12V2.Group003
import MahjongScale.Actual12V2.Group004
import MahjongScale.Actual12V2.Group005
import MahjongScale.Actual12V2.Group006
import MahjongScale.Actual12V2.Group007
import MahjongScale.Actual12V2.Group008
import MahjongScale.Actual12V2.Group009
import MahjongScale.Actual12V2.Group010
import MahjongScale.Actual12V2.Group011
import MahjongScale.Actual12V2.Group012
import MahjongScale.Actual12V2.Group013
import MahjongScale.Actual12V2.Group014
import MahjongScale.Actual12V2.Group015
import MahjongScale.Actual12V2.Group016
import MahjongScale.Actual12V2.Group017
import MahjongScale.Actual12V2.Group018
import MahjongScale.Actual12V2.Group019
import MahjongScale.Actual12V2.Group020
import MahjongScale.Actual12V2.Group021
import MahjongScale.Actual12V2.Group022
import MahjongScale.Actual12V2.Group023
import MahjongScale.Actual12V2.Group024
import MahjongScale.Actual12V2.Group025
import MahjongScale.Actual12V2.Group026
import MahjongScale.Actual12V2.Group027
import MahjongScale.Actual12V2.Group028
import MahjongScale.Actual12V2.Group029
import MahjongScale.Actual12V2.Group030
import MahjongScale.Actual12V2.Group031
import MahjongScale.Actual12V2.Group032
import MahjongScale.Actual12V2.Group033
import MahjongScale.Actual12V2.Group034
import MahjongScale.Actual12V2.Group035
import MahjongScale.Actual12V2.Group036
import MahjongScale.Actual12V2.Group037
import MahjongScale.Actual12V2.Group038
import MahjongScale.Actual12V2.Group039
import MahjongScale.Actual12V2.Group040
import MahjongScale.Actual12V2.Group041
import MahjongScale.Actual12V2.Group042
import MahjongScale.Actual12V2.Group043
import MahjongScale.Actual12V2.Group044
import MahjongScale.Actual12V2.Group045
import MahjongScale.Actual12V2.Group046
import MahjongScale.Actual12V2.Group047
import MahjongScale.Actual12V2.Group048
import MahjongScale.Actual12V2.Group049
import MahjongScale.Actual12V2.Group050
import MahjongScale.Actual12V2.Group051
import MahjongScale.Actual12V2.Group052
import MahjongScale.Actual12V2.Group053
import MahjongScale.Actual12V2.Group054
import MahjongScale.Actual12V2.Group055
import MahjongScale.Actual12V2.Group056
import MahjongScale.Actual12V2.Group057
import MahjongScale.Actual12V2.Group058
import MahjongScale.Actual12V2.Group059
import MahjongScale.Actual12V2.Group060
import MahjongScale.Actual12V2.Group061
import MahjongScale.Actual12V2.Group062
import MahjongScale.Actual12V2.Group063
import MahjongScale.Actual12V2.Group064
import MahjongScale.Actual12V2.Group065
import MahjongScale.Actual12V2.Group066
import MahjongScale.Actual12V2.Group067
import MahjongScale.Actual12V2.Group068
import MahjongScale.Actual12V2.Group069
import MahjongScale.Actual12V2.Group070
import MahjongScale.Actual12V2.Group071
import MahjongScale.Actual12V2.Group072
import MahjongScale.Actual12V2.Group073
import MahjongScale.Actual12V2.Group074
import MahjongScale.Actual12V2.Group075
import MahjongScale.Actual12V2.Group076
import MahjongScale.Actual12V2.Group077
import MahjongScale.Actual12V2.Group078
import MahjongScale.Actual12V2.Group079
import MahjongScale.Actual12V2.Group080
import MahjongScale.Actual12V2.Group081
import MahjongScale.Actual12V2.Group082
import MahjongScale.Actual12V2.Group083
import MahjongScale.Actual12V2.Group084
import MahjongScale.Actual12V2.Group085
import MahjongScale.Actual12V2.Group086
import MahjongScale.Actual12V2.Group087
import MahjongScale.Actual12V2.Group088
import MahjongScale.Actual12V2.Group089
import MahjongScale.Actual12V2.Group090
import MahjongScale.Actual12V2.Group091
import MahjongScale.Actual12V2.Group092
import MahjongScale.Actual12V2.Group093
import MahjongScale.Actual12V2.Group094

set_option maxRecDepth 32768
set_option maxHeartbeats 100000000

namespace Mahjong.Scale12V2
open ResponseTable ResponseCertificate Generators

theorem first16_checked : ExternalResponses.checkRange registry overrides bounds database 0 16 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 8 8 group0_checked group1_checked

theorem first24_checked : ExternalResponses.checkRange registry overrides bounds database 0 24 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 16 8 first16_checked group2_checked

theorem first32_checked : ExternalResponses.checkRange registry overrides bounds database 0 32 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 24 8 first24_checked group3_checked

theorem first40_checked : ExternalResponses.checkRange registry overrides bounds database 0 40 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 32 8 first32_checked group4_checked

theorem first48_checked : ExternalResponses.checkRange registry overrides bounds database 0 48 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 40 8 first40_checked group5_checked

theorem first56_checked : ExternalResponses.checkRange registry overrides bounds database 0 56 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 48 8 first48_checked group6_checked

theorem first64_checked : ExternalResponses.checkRange registry overrides bounds database 0 64 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 56 8 first56_checked group7_checked

theorem first72_checked : ExternalResponses.checkRange registry overrides bounds database 0 72 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 64 8 first64_checked group8_checked

theorem first80_checked : ExternalResponses.checkRange registry overrides bounds database 0 80 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 72 8 first72_checked group9_checked

theorem first88_checked : ExternalResponses.checkRange registry overrides bounds database 0 88 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 80 8 first80_checked group10_checked

theorem first96_checked : ExternalResponses.checkRange registry overrides bounds database 0 96 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 88 8 first88_checked group11_checked

theorem first104_checked : ExternalResponses.checkRange registry overrides bounds database 0 104 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 96 8 first96_checked group12_checked

theorem first112_checked : ExternalResponses.checkRange registry overrides bounds database 0 112 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 104 8 first104_checked group13_checked

theorem first120_checked : ExternalResponses.checkRange registry overrides bounds database 0 120 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 112 8 first112_checked group14_checked

theorem first128_checked : ExternalResponses.checkRange registry overrides bounds database 0 128 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 120 8 first120_checked group15_checked

theorem first136_checked : ExternalResponses.checkRange registry overrides bounds database 0 136 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 128 8 first128_checked group16_checked

theorem first144_checked : ExternalResponses.checkRange registry overrides bounds database 0 144 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 136 8 first136_checked group17_checked

theorem first152_checked : ExternalResponses.checkRange registry overrides bounds database 0 152 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 144 8 first144_checked group18_checked

theorem first160_checked : ExternalResponses.checkRange registry overrides bounds database 0 160 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 152 8 first152_checked group19_checked

theorem first168_checked : ExternalResponses.checkRange registry overrides bounds database 0 168 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 160 8 first160_checked group20_checked

theorem first176_checked : ExternalResponses.checkRange registry overrides bounds database 0 176 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 168 8 first168_checked group21_checked

theorem first184_checked : ExternalResponses.checkRange registry overrides bounds database 0 184 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 176 8 first176_checked group22_checked

theorem first192_checked : ExternalResponses.checkRange registry overrides bounds database 0 192 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 184 8 first184_checked group23_checked

theorem first200_checked : ExternalResponses.checkRange registry overrides bounds database 0 200 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 192 8 first192_checked group24_checked

theorem first208_checked : ExternalResponses.checkRange registry overrides bounds database 0 208 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 200 8 first200_checked group25_checked

theorem first216_checked : ExternalResponses.checkRange registry overrides bounds database 0 216 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 208 8 first208_checked group26_checked

theorem first224_checked : ExternalResponses.checkRange registry overrides bounds database 0 224 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 216 8 first216_checked group27_checked

theorem first232_checked : ExternalResponses.checkRange registry overrides bounds database 0 232 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 224 8 first224_checked group28_checked

theorem first240_checked : ExternalResponses.checkRange registry overrides bounds database 0 240 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 232 8 first232_checked group29_checked

theorem first248_checked : ExternalResponses.checkRange registry overrides bounds database 0 248 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 240 8 first240_checked group30_checked

theorem first256_checked : ExternalResponses.checkRange registry overrides bounds database 0 256 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 248 8 first248_checked group31_checked

theorem first264_checked : ExternalResponses.checkRange registry overrides bounds database 0 264 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 256 8 first256_checked group32_checked

theorem first272_checked : ExternalResponses.checkRange registry overrides bounds database 0 272 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 264 8 first264_checked group33_checked

theorem first280_checked : ExternalResponses.checkRange registry overrides bounds database 0 280 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 272 8 first272_checked group34_checked

theorem first288_checked : ExternalResponses.checkRange registry overrides bounds database 0 288 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 280 8 first280_checked group35_checked

theorem first296_checked : ExternalResponses.checkRange registry overrides bounds database 0 296 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 288 8 first288_checked group36_checked

theorem first304_checked : ExternalResponses.checkRange registry overrides bounds database 0 304 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 296 8 first296_checked group37_checked

theorem first312_checked : ExternalResponses.checkRange registry overrides bounds database 0 312 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 304 8 first304_checked group38_checked

theorem first320_checked : ExternalResponses.checkRange registry overrides bounds database 0 320 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 312 8 first312_checked group39_checked

theorem first328_checked : ExternalResponses.checkRange registry overrides bounds database 0 328 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 320 8 first320_checked group40_checked

theorem first336_checked : ExternalResponses.checkRange registry overrides bounds database 0 336 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 328 8 first328_checked group41_checked

theorem first344_checked : ExternalResponses.checkRange registry overrides bounds database 0 344 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 336 8 first336_checked group42_checked

theorem first352_checked : ExternalResponses.checkRange registry overrides bounds database 0 352 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 344 8 first344_checked group43_checked

theorem first360_checked : ExternalResponses.checkRange registry overrides bounds database 0 360 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 352 8 first352_checked group44_checked

theorem first368_checked : ExternalResponses.checkRange registry overrides bounds database 0 368 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 360 8 first360_checked group45_checked

theorem first376_checked : ExternalResponses.checkRange registry overrides bounds database 0 376 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 368 8 first368_checked group46_checked

theorem first384_checked : ExternalResponses.checkRange registry overrides bounds database 0 384 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 376 8 first376_checked group47_checked

theorem first392_checked : ExternalResponses.checkRange registry overrides bounds database 0 392 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 384 8 first384_checked group48_checked

theorem first400_checked : ExternalResponses.checkRange registry overrides bounds database 0 400 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 392 8 first392_checked group49_checked

theorem first408_checked : ExternalResponses.checkRange registry overrides bounds database 0 408 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 400 8 first400_checked group50_checked

theorem first416_checked : ExternalResponses.checkRange registry overrides bounds database 0 416 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 408 8 first408_checked group51_checked

theorem first424_checked : ExternalResponses.checkRange registry overrides bounds database 0 424 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 416 8 first416_checked group52_checked

theorem first432_checked : ExternalResponses.checkRange registry overrides bounds database 0 432 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 424 8 first424_checked group53_checked

theorem first440_checked : ExternalResponses.checkRange registry overrides bounds database 0 440 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 432 8 first432_checked group54_checked

theorem first448_checked : ExternalResponses.checkRange registry overrides bounds database 0 448 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 440 8 first440_checked group55_checked

theorem first456_checked : ExternalResponses.checkRange registry overrides bounds database 0 456 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 448 8 first448_checked group56_checked

theorem first464_checked : ExternalResponses.checkRange registry overrides bounds database 0 464 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 456 8 first456_checked group57_checked

theorem first472_checked : ExternalResponses.checkRange registry overrides bounds database 0 472 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 464 8 first464_checked group58_checked

theorem first480_checked : ExternalResponses.checkRange registry overrides bounds database 0 480 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 472 8 first472_checked group59_checked

theorem first488_checked : ExternalResponses.checkRange registry overrides bounds database 0 488 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 480 8 first480_checked group60_checked

theorem first496_checked : ExternalResponses.checkRange registry overrides bounds database 0 496 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 488 8 first488_checked group61_checked

theorem first504_checked : ExternalResponses.checkRange registry overrides bounds database 0 504 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 496 8 first496_checked group62_checked

theorem first512_checked : ExternalResponses.checkRange registry overrides bounds database 0 512 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 504 8 first504_checked group63_checked

theorem first520_checked : ExternalResponses.checkRange registry overrides bounds database 0 520 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 512 8 first512_checked group64_checked

theorem first528_checked : ExternalResponses.checkRange registry overrides bounds database 0 528 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 520 8 first520_checked group65_checked

theorem first536_checked : ExternalResponses.checkRange registry overrides bounds database 0 536 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 528 8 first528_checked group66_checked

theorem first544_checked : ExternalResponses.checkRange registry overrides bounds database 0 544 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 536 8 first536_checked group67_checked

theorem first552_checked : ExternalResponses.checkRange registry overrides bounds database 0 552 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 544 8 first544_checked group68_checked

theorem first560_checked : ExternalResponses.checkRange registry overrides bounds database 0 560 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 552 8 first552_checked group69_checked

theorem first568_checked : ExternalResponses.checkRange registry overrides bounds database 0 568 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 560 8 first560_checked group70_checked

theorem first576_checked : ExternalResponses.checkRange registry overrides bounds database 0 576 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 568 8 first568_checked group71_checked

theorem first584_checked : ExternalResponses.checkRange registry overrides bounds database 0 584 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 576 8 first576_checked group72_checked

theorem first592_checked : ExternalResponses.checkRange registry overrides bounds database 0 592 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 584 8 first584_checked group73_checked

theorem first600_checked : ExternalResponses.checkRange registry overrides bounds database 0 600 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 592 8 first592_checked group74_checked

theorem first608_checked : ExternalResponses.checkRange registry overrides bounds database 0 608 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 600 8 first600_checked group75_checked

theorem first616_checked : ExternalResponses.checkRange registry overrides bounds database 0 616 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 608 8 first608_checked group76_checked

theorem first624_checked : ExternalResponses.checkRange registry overrides bounds database 0 624 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 616 8 first616_checked group77_checked

theorem first632_checked : ExternalResponses.checkRange registry overrides bounds database 0 632 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 624 8 first624_checked group78_checked

theorem first640_checked : ExternalResponses.checkRange registry overrides bounds database 0 640 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 632 8 first632_checked group79_checked

theorem first648_checked : ExternalResponses.checkRange registry overrides bounds database 0 648 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 640 8 first640_checked group80_checked

theorem first656_checked : ExternalResponses.checkRange registry overrides bounds database 0 656 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 648 8 first648_checked group81_checked

theorem first664_checked : ExternalResponses.checkRange registry overrides bounds database 0 664 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 656 8 first656_checked group82_checked

theorem first672_checked : ExternalResponses.checkRange registry overrides bounds database 0 672 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 664 8 first664_checked group83_checked

theorem first680_checked : ExternalResponses.checkRange registry overrides bounds database 0 680 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 672 8 first672_checked group84_checked

theorem first688_checked : ExternalResponses.checkRange registry overrides bounds database 0 688 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 680 8 first680_checked group85_checked

theorem first696_checked : ExternalResponses.checkRange registry overrides bounds database 0 696 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 688 8 first688_checked group86_checked

theorem first704_checked : ExternalResponses.checkRange registry overrides bounds database 0 704 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 696 8 first696_checked group87_checked

theorem first712_checked : ExternalResponses.checkRange registry overrides bounds database 0 712 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 704 8 first704_checked group88_checked

theorem first720_checked : ExternalResponses.checkRange registry overrides bounds database 0 720 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 712 8 first712_checked group89_checked

theorem first728_checked : ExternalResponses.checkRange registry overrides bounds database 0 728 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 720 8 first720_checked group90_checked

theorem first736_checked : ExternalResponses.checkRange registry overrides bounds database 0 736 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 728 8 first728_checked group91_checked

theorem first744_checked : ExternalResponses.checkRange registry overrides bounds database 0 744 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 736 8 first736_checked group92_checked

theorem first752_checked : ExternalResponses.checkRange registry overrides bounds database 0 752 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 744 8 first744_checked group93_checked

theorem first757_checked : ExternalResponses.checkRange registry overrides bounds database 0 757 = true :=
  ExternalResponses.checkRange_append registry overrides bounds database 0 752 5 first752_checked group94_checked

theorem complete_coverage : (ResponseGroups.rows database).length ≤ 757 := by decide +kernel

theorem checked : ExternalResponses.checkDatabase registry overrides bounds database = true :=
  ExternalResponses.checkDatabase_of_full_range registry overrides bounds database 757 complete_coverage first757_checked

theorem root_proved : ProvedP state756 :=
  ExternalResponses.checkDatabase_sound registry overrides bounds validBounds safeBounds database checked 756 row756 (by rfl)

def original (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 9 | 10 | 11 | 12 | 13 | 18 | 19 | 20 | 24 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 0
  | 8 => 2
  | 14 | 15 | 16 | 17 | 21 | 22 | 23 => 1
  | 25 => 3
  | _ => 0

theorem original_checked : Generators.checkReference [] state756 original = true := by decide +kernel
theorem original_proved : ProvedP original :=
  root_proved.ofPath [] (Generators.stateEqB_sound original_checked)
theorem original_tiles : total original = 12 := by decide +kernel
theorem original_second_player_wins : SafeGame.SecondPlayerWins Step Win original := original_proved.secondPlayerWins

end Mahjong.Scale12V2

#print axioms Mahjong.Scale12V2.complete_coverage
#print axioms Mahjong.Scale12V2.checked
#print axioms Mahjong.Scale12V2.root_proved
#print axioms Mahjong.Scale12V2.original_second_player_wins
