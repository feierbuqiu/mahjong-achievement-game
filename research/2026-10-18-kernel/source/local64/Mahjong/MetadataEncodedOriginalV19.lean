import Mahjong.MetadataActualEncodedChunk64V19
import Mahjong.MetadataScalarOriginalV19
set_option autoImplicit false
namespace Mahjong.MetadataEncodedOriginalV19

/-- A fresh encoded-recurrence numerical proof, transported to the original
three ByteArray-view obligations. No older accepted64 theorem is used. -/
theorem local_rows_original : Mahjong.CanonicalInventory.checkSpan
    (Mahjong.MetadataLocalOriginalV19.checks Mahjong.MetadataLocalOriginalV19.originalTable) 20000 64 = true := by
  have h := Mahjong.MetadataActualEncodedChunk64V19.local_rows_accepted
  rw [Mahjong.MetadataActualEncodedV19.checkSpan_eq 64 20000 (by decide)] at h
  rw [Mahjong.MetadataActualNextV19.checkSpan_eq 64 20000 (by decide)] at h
  rw [Mahjong.MetadataScalarOriginalV19.row_function_eq] at h
  rw [Mahjong.MetadataLocalOriginalV19.table_eq]
  exact h

end Mahjong.MetadataEncodedOriginalV19
#print axioms Mahjong.MetadataEncodedOriginalV19.local_rows_original
