import MahjongNext.Grouped20.Data

set_option maxRecDepth 16384
set_option maxHeartbeats 100000000

namespace Mahjong.ResponseTableGrouped20
open ResponseGroups

theorem group2_checked : checkRange bounds database 16 8 = true := by decide +kernel

end Mahjong.ResponseTableGrouped20

#print axioms Mahjong.ResponseTableGrouped20.group2_checked
