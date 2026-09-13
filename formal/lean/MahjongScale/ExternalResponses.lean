import MahjongNext.ResponseGroups

/-!
Response tables may reuse independent, already proved physical P facts.
The old tree and row representation is unchanged. An optional external action
replaces one ordinary action; a missing external fact is rejected, not retried
as the ordinary action. Internal references retain the original strict rank.
-/

namespace Mahjong.ExternalResponses

open ResponseTable ResponseCertificate Generators

structure PFact where
  state : State
  proved : ProvedP state

abbrev Registry := Nat → Option PFact

/-- A previously checked ordinary table already proves every successful
    lookup. Reuse its completed theorem; do not recheck or copy its subgraph. -/
def registryOfCheckedTable (bounds : Nat → State)
    (validBounds : ∀ i, Valid (bounds i)) (safeBounds : ∀ i, IsSafe (bounds i))
    (tree : Tree) (checked : ResponseTable.checkDatabase bounds tree = true) : Registry :=
  fun id => match found : lookup tree id with
    | none => none
    | some row => some ⟨row.state,
        ResponseTable.checkDatabase_sound bounds validBounds safeBounds tree checked id row found⟩

structure Ref where
  second : Tile
  id : Nat
  path : List Generator

abbrev Overrides := Nat → Tile → Option Ref

def checkExternal (registry : Registry) (s : State) (first : Tile) (ref : Ref) : Bool :=
  decide ((addTile s first) ref.second < 4) &&
    match registry ref.id with
    | none => false
    | some fact => checkReference ref.path fact.state (afterReply s first ref.second)

theorem checkExternal_sound (registry : Registry) (s : State) (first : Tile)
    (legalFirst : LegalAdd s first) (ref : Ref)
    (checked : checkExternal registry s first ref = true) : Reply s first := by
  have parts : (addTile s first) ref.second < 4 ∧
      (match registry ref.id with
       | none => false
       | some fact => checkReference ref.path fact.state (afterReply s first ref.second)) = true := by
    simpa only [checkExternal, Bool.and_eq_true, decide_eq_true_eq] using checked
  have legal : LegalAdd (addTile s first) ref.second :=
    ⟨valid_add legalFirst.1 legalFirst.2, parts.1⟩
  cases entry : registry ref.id with
  | none =>
      simp only [entry, Bool.false_eq_true] at parts
      exact False.elim parts.2
  | some fact =>
      have same : checkReference ref.path fact.state (afterReply s first ref.second) = true := by
        simpa only [entry] using parts.2
      exact Reply.backAlongCheckedPath first ref.second legal fact.proved ref.path same

def checkResponse (registry : Registry) (tree : Tree) (limit : Nat)
    (s : State) (first : Tile) (ordinary : Action) : Option Ref → Bool
  | none => ResponseTable.checkAction tree limit s first ordinary
  | some ref => checkExternal registry s first ref

theorem checkResponse_sound (registry : Registry) (tree : Tree) (limit : Nat)
    (previous : ∀ id, id < limit → ∀ child, lookup tree id = some child → ProvedP child.state)
    (s : State) (first : Tile) (legalFirst : LegalAdd s first)
    (ordinary : Action) (externalRef : Option Ref)
    (checked : checkResponse registry tree limit s first ordinary externalRef = true) :
    Reply s first := by
  cases externalRef with
  | none => exact ResponseTable.checkAction_sound tree limit previous s first legalFirst ordinary checked
  | some ref => exact checkExternal_sound registry s first legalFirst ref checked

def checkRow (registry : Registry) (overrides : Overrides)
    (bounds : Nat → State) (tree : Tree) (row : Row) : Bool :=
  RuleChecker.containsB row.state (bounds row.safeBound) &&
    allTiles.all (fun first => if row.state first < 4 then
      checkResponse registry tree row.id row.state first (row.action first)
        (overrides row.id first) else true)

theorem checkRow_sound (registry : Registry) (overrides : Overrides)
    (bounds : Nat → State) (validBounds : ∀ i, Valid (bounds i))
    (safeBounds : ∀ i, IsSafe (bounds i)) (tree : Tree) (row : Row)
    (previous : ∀ id, id < row.id → ∀ child, lookup tree id = some child → ProvedP child.state)
    (checked : checkRow registry overrides bounds tree row = true) : ProvedP row.state := by
  have parts : RuleChecker.containsB row.state (bounds row.safeBound) = true ∧
      allTiles.all (fun first => if row.state first < 4 then
        checkResponse registry tree row.id row.state first (row.action first)
          (overrides row.id first) else true) = true := by
    simpa only [checkRow, Bool.and_eq_true] using checked
  apply node_of_safe_extension ((RuleChecker.containsB_iff _ _).1 parts.1)
    (validBounds row.safeBound) (safeBounds row.safeBound)
  intro first legalFirst
  have checkedAction := List.all_eq_true.mp parts.2 first (mem_allTiles first)
  simp only [if_pos legalFirst.2] at checkedAction
  exact checkResponse_sound registry tree row.id previous row.state first legalFirst
    (row.action first) (overrides row.id first) checkedAction

def checkDatabase (registry : Registry) (overrides : Overrides)
    (bounds : Nat → State) (tree : Tree) : Bool :=
  allCheck (checkRow registry overrides bounds tree) tree

theorem checkDatabase_sound (registry : Registry) (overrides : Overrides)
    (bounds : Nat → State) (validBounds : ∀ i, Valid (bounds i))
    (safeBounds : ∀ i, IsSafe (bounds i)) (tree : Tree)
    (checked : checkDatabase registry overrides bounds tree = true)
    (id : Nat) (row : Row) (found : lookup tree id = some row) : ProvedP row.state := by
  have all : AllRows (fun r => checkRow registry overrides bounds tree r = true) tree :=
    allCheck_sound (checkRow registry overrides bounds tree) tree checked
  have byId : ∀ id : Nat, ∀ row, lookup tree id = some row → ProvedP row.state := by
    intro id
    induction id using Nat.strongRecOn with
    | ind id ih =>
      intro current lookupCurrent
      have facts := lookup_property (fun r => checkRow registry overrides bounds tree r = true)
        tree all id current lookupCurrent
      apply checkRow_sound registry overrides bounds validBounds safeBounds tree current
      · intro ref less child lookupChild
        exact ih ref (by simpa only [facts.2] using less) child lookupChild
      · exact facts.1
  exact byId id row found

theorem original_second_player_wins (registry : Registry) (overrides : Overrides)
    (bounds : Nat → State) (validBounds : ∀ i, Valid (bounds i))
    (safeBounds : ∀ i, IsSafe (bounds i)) (tree : Tree)
    (checked : checkDatabase registry overrides bounds tree = true)
    (id : Nat) (row : Row) (found : lookup tree id = some row) :
    SafeGame.SecondPlayerWins Step Win row.state :=
  (checkDatabase_sound registry overrides bounds validBounds safeBounds tree checked id row found).secondPlayerWins

def checkRange (registry : Registry) (overrides : Overrides) (bounds : Nat → State)
    (tree : Tree) (start count : Nat) : Bool :=
  (((ResponseGroups.rows tree).drop start).take count).all
    (checkRow registry overrides bounds tree)

theorem checkRange_append (registry : Registry) (overrides : Overrides)
    (bounds : Nat → State) (tree : Tree) (start firstCount secondCount : Nat)
    (first : checkRange registry overrides bounds tree start firstCount = true)
    (second : checkRange registry overrides bounds tree (start + firstCount) secondCount = true) :
    checkRange registry overrides bounds tree start (firstCount + secondCount) = true := by
  unfold checkRange at *
  rw [List.take_add, List.all_append, List.drop_drop]
  rw [first, second]
  rfl

theorem checkDatabase_of_full_range (registry : Registry) (overrides : Overrides)
    (bounds : Nat → State) (tree : Tree) (count : Nat)
    (covers : (ResponseGroups.rows tree).length ≤ count)
    (checked : checkRange registry overrides bounds tree 0 count = true) :
    checkDatabase registry overrides bounds tree = true := by
  unfold checkRange at checked
  simp only [List.drop_zero] at checked
  rw [List.take_of_length_le covers] at checked
  simpa only [checkDatabase, ResponseGroups.allCheck_eq_rows] using checked

end Mahjong.ExternalResponses

#print axioms Mahjong.ExternalResponses.checkExternal_sound
#print axioms Mahjong.ExternalResponses.checkResponse_sound
#print axioms Mahjong.ExternalResponses.checkRow_sound
#print axioms Mahjong.ExternalResponses.checkDatabase_sound
#print axioms Mahjong.ExternalResponses.original_second_player_wins
#print axioms Mahjong.ExternalResponses.checkRange_append
#print axioms Mahjong.ExternalResponses.checkDatabase_of_full_range
