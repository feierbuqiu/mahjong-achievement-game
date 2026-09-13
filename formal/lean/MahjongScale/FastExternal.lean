import MahjongScale.ExternalResponses
import MahjongScale.FastPositive

namespace Mahjong.Scale.FastExternal

open ResponseTable ResponseCertificate ExternalResponses

/-- Optional certified external references keep precisely the original check.
    Only the ordinary action fallback uses the equivalent positive checker. -/
def checkResponse (registry : Registry) (tree : Tree) (limit : Nat)
    (s : State) (first : Tile) (ordinary : Action) : Option Ref → Bool
  | none => FastPositive.checkAction tree limit s first ordinary
  | some ref => ExternalResponses.checkExternal registry s first ref

theorem external_unchanged (registry : Registry) (tree : Tree) (limit : Nat)
    (s : State) (first : Tile) (ordinary : Action) (ref : Ref) :
    checkResponse registry tree limit s first ordinary (some ref) =
      ExternalResponses.checkExternal registry s first ref := rfl

theorem checkResponse_eq (registry : Registry) (tree : Tree) (limit : Nat)
    (s : State) (first : Tile) (ordinary : Action) (externalRef : Option Ref) :
    checkResponse registry tree limit s first ordinary externalRef =
      ExternalResponses.checkResponse registry tree limit s first ordinary externalRef := by
  cases externalRef with
  | none => exact FastPositive.checkAction_eq tree limit s first ordinary
  | some ref => rfl

def checkRow (registry : Registry) (overrides : Overrides)
    (bounds : Nat → State) (tree : Tree) (row : Row) : Bool :=
  RuleChecker.containsB row.state (bounds row.safeBound) &&
    allTiles.all (fun first => if row.state first < 4 then
      checkResponse registry tree row.id row.state first (row.action first)
        (overrides row.id first) else true)

theorem checkRow_eq (registry : Registry) (overrides : Overrides)
    (bounds : Nat → State) (tree : Tree) (row : Row) :
    checkRow registry overrides bounds tree row =
      ExternalResponses.checkRow registry overrides bounds tree row := by
  simp only [checkRow, ExternalResponses.checkRow, checkResponse_eq]

def checkDatabase (registry : Registry) (overrides : Overrides)
    (bounds : Nat → State) (tree : Tree) : Bool :=
  allCheck (checkRow registry overrides bounds tree) tree

theorem checkDatabase_eq (registry : Registry) (overrides : Overrides)
    (bounds : Nat → State) (tree : Tree) :
    checkDatabase registry overrides bounds tree =
      ExternalResponses.checkDatabase registry overrides bounds tree := by
  have same := funext (checkRow_eq registry overrides bounds tree)
  simp only [checkDatabase, ExternalResponses.checkDatabase, same]

def checkRange (registry : Registry) (overrides : Overrides) (bounds : Nat → State)
    (tree : Tree) (start count : Nat) : Bool :=
  (((ResponseGroups.rows tree).drop start).take count).all
    (checkRow registry overrides bounds tree)

theorem checkRange_eq (registry : Registry) (overrides : Overrides) (bounds : Nat → State)
    (tree : Tree) (start count : Nat) :
    checkRange registry overrides bounds tree start count =
      ExternalResponses.checkRange registry overrides bounds tree start count := by
  have same := funext (checkRow_eq registry overrides bounds tree)
  simp only [checkRange, ExternalResponses.checkRange, same]

theorem checkDatabase_sound (registry : Registry) (overrides : Overrides)
    (bounds : Nat → State) (validBounds : ∀ i, Valid (bounds i))
    (safeBounds : ∀ i, IsSafe (bounds i)) (tree : Tree)
    (checked : checkDatabase registry overrides bounds tree = true)
    (id : Nat) (row : Row) (found : lookup tree id = some row) : ProvedP row.state :=
  ExternalResponses.checkDatabase_sound registry overrides bounds validBounds safeBounds
    tree (by simpa only [checkDatabase_eq] using checked) id row found

end Mahjong.Scale.FastExternal

#print axioms Mahjong.Scale.FastExternal.external_unchanged
#print axioms Mahjong.Scale.FastExternal.checkResponse_eq
#print axioms Mahjong.Scale.FastExternal.checkRow_eq
#print axioms Mahjong.Scale.FastExternal.checkDatabase_eq
#print axioms Mahjong.Scale.FastExternal.checkRange_eq
#print axioms Mahjong.Scale.FastExternal.checkDatabase_sound
