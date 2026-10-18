import Mahjong.PilotScanDataV18

set_option autoImplicit false
set_option maxRecDepth 16384
set_option maxHeartbeats 4000000

namespace Mahjong.PilotScanCount8V18
open PilotScanDataV18

theorem checked_0_8 :
    CanonicalInventory.checkSpan checkRow 0 8 = true := by decide +kernel

theorem accepted : checkPrefix 8 = true := by
  unfold checkPrefix
  exact checked_0_8

theorem every_distinct_row (r : Nat) (inside : r < 8) : checkRow r = true := by
  simpa only [Nat.zero_add] using CanonicalInventory.checkSpan_each checkRow 8 0 accepted r inside

end Mahjong.PilotScanCount8V18

#print axioms Mahjong.PilotScanCount8V18.checked_0_8
#print axioms Mahjong.PilotScanCount8V18.accepted
#print axioms Mahjong.PilotScanCount8V18.every_distinct_row
