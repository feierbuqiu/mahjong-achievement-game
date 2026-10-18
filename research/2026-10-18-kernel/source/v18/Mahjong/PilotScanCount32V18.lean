import Mahjong.PilotScanDataV18

set_option autoImplicit false
set_option maxRecDepth 16384
set_option maxHeartbeats 4000000

namespace Mahjong.PilotScanCount32V18
open PilotScanDataV18

theorem checked_0_8 :
    CanonicalInventory.checkSpan checkRow 0 8 = true := by decide +kernel

theorem checked_8_8 :
    CanonicalInventory.checkSpan checkRow 8 8 = true := by decide +kernel

theorem checked_16_8 :
    CanonicalInventory.checkSpan checkRow 16 8 = true := by decide +kernel

theorem checked_24_8 :
    CanonicalInventory.checkSpan checkRow 24 8 = true := by decide +kernel

theorem accepted : checkPrefix 32 = true := by
  unfold checkPrefix
  rw [CanonicalInventory.checkSpan_add checkRow 8 24 0,
    checked_0_8, Bool.true_and]
  rw [CanonicalInventory.checkSpan_add checkRow 8 16 8,
    checked_8_8, Bool.true_and]
  rw [CanonicalInventory.checkSpan_add checkRow 8 8 16,
    checked_16_8, Bool.true_and]
  exact checked_24_8

theorem every_distinct_row (r : Nat) (inside : r < 32) : checkRow r = true := by
  simpa only [Nat.zero_add] using CanonicalInventory.checkSpan_each checkRow 32 0 accepted r inside

end Mahjong.PilotScanCount32V18

#print axioms Mahjong.PilotScanCount32V18.checked_0_8
#print axioms Mahjong.PilotScanCount32V18.checked_8_8
#print axioms Mahjong.PilotScanCount32V18.checked_16_8
#print axioms Mahjong.PilotScanCount32V18.checked_24_8
#print axioms Mahjong.PilotScanCount32V18.accepted
#print axioms Mahjong.PilotScanCount32V18.every_distinct_row
