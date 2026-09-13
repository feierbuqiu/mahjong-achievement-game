import MahjongNext.Actual14.Data

set_option maxRecDepth 16384
set_option maxHeartbeats 100000000

namespace Mahjong.Actual14
open ResponseGroups

theorem group4_checked : checkRange bounds database 32 8 = true := by decide +kernel

end Mahjong.Actual14

#print axioms Mahjong.Actual14.group4_checked
