import Mahjong.PilotScanDataV18

set_option autoImplicit false
set_option maxRecDepth 16384
set_option maxHeartbeats 4000000

namespace Mahjong.PilotScanCount1V18
open PilotScanDataV18

theorem checked_0_1 :
    CanonicalInventory.checkSpan checkRow 0 1 = true := by decide +kernel

theorem accepted : checkPrefix 1 = true := by
  unfold checkPrefix
  exact checked_0_1

theorem every_distinct_row (r : Nat) (inside : r < 1) : checkRow r = true := by
  simpa only [Nat.zero_add] using CanonicalInventory.checkSpan_each checkRow 1 0 accepted r inside

end Mahjong.PilotScanCount1V18

#print axioms Mahjong.PilotScanCount1V18.checked_0_1
#print axioms Mahjong.PilotScanCount1V18.accepted
#print axioms Mahjong.PilotScanCount1V18.every_distinct_row
