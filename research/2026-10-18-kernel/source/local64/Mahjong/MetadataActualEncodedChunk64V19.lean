import Mahjong.MetadataActualEncoded8V19
set_option autoImplicit false
set_option maxRecDepth 32768
set_option maxHeartbeats 0
namespace Mahjong.MetadataActualEncodedChunk64V19
theorem append (s a b : Nat)
    (ha : Mahjong.CanonicalInventory.checkSpan Mahjong.MetadataActualEncodedV19.row s a = true)
    (hb : Mahjong.CanonicalInventory.checkSpan Mahjong.MetadataActualEncodedV19.row (s+a) b = true) :
    Mahjong.CanonicalInventory.checkSpan Mahjong.MetadataActualEncodedV19.row s (a+b) = true := by
  rw [Mahjong.CanonicalInventory.checkSpan_add,ha,hb]
  rfl
theorem chunk_0 : Mahjong.CanonicalInventory.checkSpan Mahjong.MetadataActualEncodedV19.row 20000 8 = true :=
  Mahjong.MetadataActualEncoded8V19.local_rows_accepted
theorem chunk_8 : Mahjong.CanonicalInventory.checkSpan Mahjong.MetadataActualEncodedV19.row 20008 8 = true := by
  decide +kernel
theorem chunk_16 : Mahjong.CanonicalInventory.checkSpan Mahjong.MetadataActualEncodedV19.row 20016 8 = true := by
  decide +kernel
theorem chunk_24 : Mahjong.CanonicalInventory.checkSpan Mahjong.MetadataActualEncodedV19.row 20024 8 = true := by
  decide +kernel
theorem chunk_32 : Mahjong.CanonicalInventory.checkSpan Mahjong.MetadataActualEncodedV19.row 20032 8 = true := by
  decide +kernel
theorem chunk_40 : Mahjong.CanonicalInventory.checkSpan Mahjong.MetadataActualEncodedV19.row 20040 8 = true := by
  decide +kernel
theorem chunk_48 : Mahjong.CanonicalInventory.checkSpan Mahjong.MetadataActualEncodedV19.row 20048 8 = true := by
  decide +kernel
theorem chunk_56 : Mahjong.CanonicalInventory.checkSpan Mahjong.MetadataActualEncodedV19.row 20056 8 = true := by
  decide +kernel
theorem local_rows_accepted : Mahjong.CanonicalInventory.checkSpan Mahjong.MetadataActualEncodedV19.row 20000 64 = true :=
  append 20000 8 56 chunk_0 (append 20008 8 48 chunk_8 (append 20016 8 40 chunk_16 (append 20024 8 32 chunk_24 (append 20032 8 24 chunk_32 (append 20040 8 16 chunk_40 (append 20048 8 8 chunk_48 (chunk_56)))))))
#print axioms local_rows_accepted
end Mahjong.MetadataActualEncodedChunk64V19
