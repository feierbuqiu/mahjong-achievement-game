import Mahjong.PilotScanDataV18

set_option autoImplicit false
set_option maxRecDepth 16384
set_option maxHeartbeats 4000000

namespace Mahjong.PilotScanCount56V18
open PilotScanDataV18

theorem checked_0_8 :
    CanonicalInventory.checkSpan checkRow 0 8 = true := by decide +kernel

theorem checked_8_8 :
    CanonicalInventory.checkSpan checkRow 8 8 = true := by decide +kernel

theorem checked_16_8 :
    CanonicalInventory.checkSpan checkRow 16 8 = true := by decide +kernel

theorem checked_24_8 :
    CanonicalInventory.checkSpan checkRow 24 8 = true := by decide +kernel

theorem checked_32_8 :
    CanonicalInventory.checkSpan checkRow 32 8 = true := by decide +kernel

theorem checked_40_8 :
    CanonicalInventory.checkSpan checkRow 40 8 = true := by decide +kernel

theorem checked_48_8 :
    CanonicalInventory.checkSpan checkRow 48 8 = true := by decide +kernel

theorem accepted : checkPrefix 56 = true := by
  unfold checkPrefix
  rw [CanonicalInventory.checkSpan_add checkRow 8 48 0,
    checked_0_8, Bool.true_and]
  rw [CanonicalInventory.checkSpan_add checkRow 8 40 8,
    checked_8_8, Bool.true_and]
  rw [CanonicalInventory.checkSpan_add checkRow 8 32 16,
    checked_16_8, Bool.true_and]
  rw [CanonicalInventory.checkSpan_add checkRow 8 24 24,
    checked_24_8, Bool.true_and]
  rw [CanonicalInventory.checkSpan_add checkRow 8 16 32,
    checked_32_8, Bool.true_and]
  rw [CanonicalInventory.checkSpan_add checkRow 8 8 40,
    checked_40_8, Bool.true_and]
  exact checked_48_8

theorem every_distinct_row (r : Nat) (inside : r < 56) : checkRow r = true := by
  simpa only [Nat.zero_add] using CanonicalInventory.checkSpan_each checkRow 56 0 accepted r inside

end Mahjong.PilotScanCount56V18

#print axioms Mahjong.PilotScanCount56V18.checked_0_8
#print axioms Mahjong.PilotScanCount56V18.checked_8_8
#print axioms Mahjong.PilotScanCount56V18.checked_16_8
#print axioms Mahjong.PilotScanCount56V18.checked_24_8
#print axioms Mahjong.PilotScanCount56V18.checked_32_8
#print axioms Mahjong.PilotScanCount56V18.checked_40_8
#print axioms Mahjong.PilotScanCount56V18.checked_48_8
#print axioms Mahjong.PilotScanCount56V18.accepted
#print axioms Mahjong.PilotScanCount56V18.every_distinct_row
