import Mahjong.MetadataActualEncodedV19
set_option autoImplicit false
set_option maxRecDepth 32768
set_option maxHeartbeats 0
namespace Mahjong.MetadataEncodedRaw8V19
theorem rows_accepted : Mahjong.CanonicalInventory.checkSpan
    (Mahjong.FullSafeData.checkRow 0 Mahjong.MetadataActualScalarV19.table) 20000 8 = true := by
  decide +kernel
#print axioms rows_accepted
end Mahjong.MetadataEncodedRaw8V19
