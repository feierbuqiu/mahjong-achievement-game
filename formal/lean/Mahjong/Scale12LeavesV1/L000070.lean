import Mahjong.Scale12LeavesV1.L000070.Data
import Mahjong.Bridge

set_option maxRecDepth 8192
set_option maxHeartbeats 20000000

namespace Mahjong.Scale12LeavesV1.L000070
open StandardBoundCertificate

theorem checkSafe_true : checkSafe state baseCaps childCaps = true := by
  decide +kernel

theorem valid : Valid state :=
  (checkSafe_sound state baseCaps childCaps checkSafe_true).1

theorem safe : IsSafe state :=
  (checkSafe_sound state baseCaps childCaps checkSafe_true).2

end Mahjong.Scale12LeavesV1.L000070
#print axioms Mahjong.Scale12LeavesV1.L000070.checkSafe_true
#print axioms Mahjong.Scale12LeavesV1.L000070.valid
#print axioms Mahjong.Scale12LeavesV1.L000070.safe
