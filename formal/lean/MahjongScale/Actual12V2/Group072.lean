import MahjongScale.Actual12V2.Data

set_option maxRecDepth 32768
set_option maxHeartbeats 100000000

namespace Mahjong.Scale12V2

theorem group72_fast_checked : Scale.FastExternal.checkRange registry overrides bounds database 576 8 = true := by decide +kernel

theorem group72_checked : ExternalResponses.checkRange registry overrides bounds database 576 8 = true :=
  (Scale.FastExternal.checkRange_eq registry overrides bounds database 576 8).symm.trans group72_fast_checked

end Mahjong.Scale12V2

#print axioms Mahjong.Scale12V2.group72_checked
