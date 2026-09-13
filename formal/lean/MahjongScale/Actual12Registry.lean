import MahjongScale.Actual12V2.Root

namespace Mahjong.Actual12Registry

open ResponseTable ResponseCertificate ExternalResponses

/-- Every entry is obtained from the completed kernel-checked table. A JSON
    discovery record supplies neither a P assumption nor a proof. -/
def registry : Registry :=
  fun id => match found : lookup Scale12V2.database id with
    | none => none
    | some row => some ⟨row.state,
        ExternalResponses.checkDatabase_sound Scale12V2.registry Scale12V2.overrides
          Scale12V2.bounds Scale12V2.validBounds Scale12V2.safeBounds
          Scale12V2.database Scale12V2.checked id row found⟩

theorem row756_state : (registry 756).map PFact.state = some Scale12V2.state756 := by rfl

theorem missing_row757 : registry 757 = none := by rfl

theorem root_proved : ProvedP Scale12V2.original := Scale12V2.original_proved

end Mahjong.Actual12Registry

#print axioms Mahjong.Actual12Registry.row756_state
#print axioms Mahjong.Actual12Registry.missing_row757
#print axioms Mahjong.Actual12Registry.root_proved
