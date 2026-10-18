import Mahjong.MetadataActualNextV19
import Mahjong.EncodedMeldRecurrenceV19
set_option autoImplicit false
noncomputable section
namespace Mahjong.MetadataActualEncodedV19

def row (i : Nat) : Bool :=
  Mahjong.EncodedMeldRecurrenceV19.coreRow 0
    Mahjong.MetadataActualScalarV19.table.summary.core.value i &&
  ScalarSummaryNextV19.row 0 Mahjong.MetadataActualScalarV19.table.summary i &&
  Mahjong.FullSafeData.checkRow 0 Mahjong.MetadataActualScalarV19.table i

theorem row_eq (i : Nat) (inside : i < 1953125) :
    row i = Mahjong.MetadataActualNextV19.row i := by
  unfold row Mahjong.MetadataActualNextV19.row
  rw [← Mahjong.EncodedMeldRecurrenceV19.coreRow_eq 0 (by decide) _
        Mahjong.MetadataActualNextV19.shape i inside,
      GenericLocalRefV19.coreRow_eq 0 (by decide) _ Mahjong.MetadataActualNextV19.shape i]

theorem checkSpan_eq (count start : Nat) (range : start+count ≤ 1953125) :
    Mahjong.CanonicalInventory.checkSpan row start count =
      Mahjong.CanonicalInventory.checkSpan Mahjong.MetadataActualNextV19.row start count := by
  apply ScalarSummaryNextV19.checkSpan_congr
  intro offset inside
  exact row_eq (start+offset) (by omega)

end Mahjong.MetadataActualEncodedV19
#print axioms Mahjong.MetadataActualEncodedV19.row_eq
#print axioms Mahjong.MetadataActualEncodedV19.checkSpan_eq
