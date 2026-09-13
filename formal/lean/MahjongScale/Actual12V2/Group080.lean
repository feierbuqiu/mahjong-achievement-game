import MahjongScale.Actual12V2.Data

set_option maxRecDepth 32768
set_option maxHeartbeats 100000000

namespace Mahjong.Scale12V2

theorem group80_fast_checked : Scale.FastExternal.checkRange registry overrides bounds database 640 8 = true := by decide +kernel

theorem group80_checked : ExternalResponses.checkRange registry overrides bounds database 640 8 = true :=
  (Scale.FastExternal.checkRange_eq registry overrides bounds database 640 8).symm.trans group80_fast_checked

end Mahjong.Scale12V2

#print axioms Mahjong.Scale12V2.group80_checked
