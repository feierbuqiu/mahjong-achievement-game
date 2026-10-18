import Mahjong.MetadataActualEncodedV19
set_option autoImplicit false
set_option maxRecDepth 32768
set_option maxHeartbeats 0
namespace Mahjong.MetadataActualEncoded8V19
theorem local_rows_accepted : Mahjong.CanonicalInventory.checkSpan
    Mahjong.MetadataActualEncodedV19.row 20000 8 = true := by
  decide +kernel
#print axioms local_rows_accepted
end Mahjong.MetadataActualEncoded8V19
