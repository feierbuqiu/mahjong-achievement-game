prelude
import MetadataEncodedSliceDataV19

set_option autoImplicit false

/-- The unchanged original three-check finite statement over the captured
partial ByteArray views, using exactly the new saved encoded proof. -/
theorem Mahjong.MetadataEncodedVerifyV19.original_finite_statement :
    Mahjong.CanonicalInventory.checkSpan
      (Mahjong.MetadataLocalOriginalV19.checks
        Mahjong.MetadataLocalOriginalV19.originalTable) 20000 64 = true :=
  Mahjong.MetadataEncodedOriginalV19.local_rows_original

#print axioms Mahjong.MetadataEncodedOriginalV19.local_rows_original
#print axioms Mahjong.MetadataEncodedVerifyV19.original_finite_statement
