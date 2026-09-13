import MahjongScale.ExternalResponses
import MahjongNext.Actual14.Root

namespace Mahjong.Actual14Registry

open ExternalResponses ResponseTable ResponseCertificate

/-- The JSON registry is discovery metadata only. These facts are obtained
    from the frozen table's actual checked theorem in Lean. -/
def registry : Registry :=
  registryOfCheckedTable Actual14.bounds Actual14.validBounds Actual14.safeBounds
    Actual14.database Actual14.checked

theorem row49_state : (registry 49).map PFact.state = some Actual14.state49 := by rfl

theorem missing_row50 : registry 50 = none := by rfl

/-- This statement has no P premise: the original completed table discharges
    it. It is provided for consumers wanting the registered root directly. -/
theorem root_proved : ProvedP Actual14.original := Actual14.original_proved

end Mahjong.Actual14Registry

#print axioms Mahjong.Actual14Registry.row49_state
#print axioms Mahjong.Actual14Registry.missing_row50
#print axioms Mahjong.Actual14Registry.root_proved
