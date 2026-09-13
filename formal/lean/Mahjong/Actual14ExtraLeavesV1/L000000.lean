import Mahjong.Actual14ExtraLeavesV1.L000000.Data
import Mahjong.Bridge

set_option maxRecDepth 8192
set_option maxHeartbeats 20000000

namespace Mahjong.Actual14ExtraLeavesV1.L000000
open StandardBoundCertificate

theorem checkSafe_true : checkSafe state baseCaps childCaps = true := by
  decide +kernel

theorem valid : Valid state :=
  (checkSafe_sound state baseCaps childCaps checkSafe_true).1

theorem safe : IsSafe state :=
  (checkSafe_sound state baseCaps childCaps checkSafe_true).2

end Mahjong.Actual14ExtraLeavesV1.L000000
#print axioms Mahjong.Actual14ExtraLeavesV1.L000000.checkSafe_true
#print axioms Mahjong.Actual14ExtraLeavesV1.L000000.valid
#print axioms Mahjong.Actual14ExtraLeavesV1.L000000.safe
