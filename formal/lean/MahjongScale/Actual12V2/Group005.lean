import MahjongScale.Actual12V2.Data

set_option maxRecDepth 32768
set_option maxHeartbeats 100000000

namespace Mahjong.Scale12V2

theorem group5_fast_checked : Scale.FastExternal.checkRange registry overrides bounds database 40 8 = true := by decide +kernel

theorem group5_checked : ExternalResponses.checkRange registry overrides bounds database 40 8 = true :=
  (Scale.FastExternal.checkRange_eq registry overrides bounds database 40 8).symm.trans group5_fast_checked

end Mahjong.Scale12V2

#print axioms Mahjong.Scale12V2.group5_checked
