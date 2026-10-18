import Mahjong.MetadataActualEncodedV19
set_option autoImplicit false
set_option maxRecDepth 32768
set_option maxHeartbeats 0
namespace Mahjong.MetadataEncodedCore8V19
theorem rows_accepted : Mahjong.CanonicalInventory.checkSpan
    (Mahjong.EncodedMeldRecurrenceV19.coreRow 0 Mahjong.MetadataActualScalarV19.table.summary.core.value) 20000 8 = true := by
  decide +kernel
#print axioms rows_accepted
end Mahjong.MetadataEncodedCore8V19
