import Mahjong.MetadataActualEncodedV19
set_option autoImplicit false
set_option maxRecDepth 32768
set_option maxHeartbeats 0
namespace Mahjong.MetadataEncodedSummary8V19
theorem rows_accepted : Mahjong.CanonicalInventory.checkSpan
    (ScalarSummaryNextV19.row 0 Mahjong.MetadataActualScalarV19.table.summary) 20000 8 = true := by
  decide +kernel
#print axioms rows_accepted
end Mahjong.MetadataEncodedSummary8V19
