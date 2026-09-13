import MahjongNext.Actual14.Data

set_option maxRecDepth 16384
set_option maxHeartbeats 100000000

namespace Mahjong.Actual14
open ResponseGroups

theorem group6_checked : checkRange bounds database 48 2 = true := by decide +kernel

end Mahjong.Actual14

#print axioms Mahjong.Actual14.group6_checked
