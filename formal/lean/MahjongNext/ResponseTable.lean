import Mahjong.FullWinWitness
import Mahjong.ResponseCertificate

/-!
A reflected table of two-step responses. The table contains data, not strategy
proofs. A successful Boolean check plus shared proved SAFE bounds yields the
original-game meaning for every successful lookup.

P rows inspect all 34 legal first kinds. N rows and their SAFE searches are not
stored. References use exact physical equality after a proved symmetry path
and strictly smaller IDs, so cycles and unknown references cannot certify P.
-/

namespace Mahjong.ResponseTable

open ResponseCertificate Generators

inductive Action where
  | win (second : Tile) (witness : FullWinWitness.Witness)
  | back (second : Tile) (ref : Nat) (path : List Generator)

structure Row where
  id : Nat
  state : State
  safeBound : Nat
  action : Tile → Action

inductive Tree where
  | empty
  | branch (left : Tree) (row : Row) (right : Tree)

/-- A producer may balance the tree; no ordering or uniqueness assumption is
    needed for soundness. A lookup always checks an exact row ID. -/
def lookup : Tree → Nat → Option Row
  | .empty, _ => none
  | .branch left row right, id =>
      if id = row.id then some row
      else if id < row.id then lookup left id else lookup right id

def AllRows (property : Row → Prop) : Tree → Prop
  | .empty => True
  | .branch left row right => AllRows property left ∧ property row ∧ AllRows property right

theorem lookup_property (property : Row → Prop) (tree : Tree)
    (all : AllRows property tree) (id : Nat) (row : Row)
    (found : lookup tree id = some row) : property row ∧ row.id = id := by
  induction tree with
  | empty => simp [lookup] at found
  | branch left current right ihl ihr =>
    obtain ⟨hl, hc, hr⟩ := all
    by_cases same : id = current.id
    · have equal : current = row := by simpa [lookup, same] using found
      subst row
      exact ⟨hc, same.symm⟩
    · by_cases less : id < current.id
      · exact ihl hl (by simpa [lookup, same, less] using found)
      · exact ihr hr (by simpa [lookup, same, less] using found)

def allCheck (test : Row → Bool) : Tree → Bool
  | .empty => true
  | .branch left row right => allCheck test left && (test row && allCheck test right)

theorem allCheck_sound (test : Row → Bool) (tree : Tree)
    (checked : allCheck test tree = true) : AllRows (fun row => test row = true) tree := by
  induction tree with
  | empty => trivial
  | branch left row right ihl ihr =>
    have parts : allCheck test left = true ∧ test row = true ∧ allCheck test right = true := by
      simpa only [allCheck, Bool.and_eq_true] using checked
    exact ⟨ihl parts.1, parts.2.1, ihr parts.2.2⟩

def afterReply (s : State) (first second : Tile) : State :=
  addTile (addTile s first) second

def checkAction (tree : Tree) (limit : Nat) (s : State) (first : Tile) : Action → Bool
  | .win second witness =>
      decide ((addTile s first) second < 4) && FullWinWitness.check (afterReply s first second) witness
  | .back second ref path =>
      decide ((addTile s first) second < 4) && (decide (ref < limit) &&
        match lookup tree ref with
        | none => false
        | some child => Generators.checkReference path child.state (afterReply s first second))

/-- This is the missing bridge from a cheap reflected action to an actual
    two-step Reply. No SAFE predicate is evaluated by checkAction. -/
theorem checkAction_sound (tree : Tree) (limit : Nat)
    (previous : ∀ id, id < limit → ∀ child, lookup tree id = some child → ProvedP child.state)
    (s : State) (first : Tile) (legalFirst : LegalAdd s first) (action : Action)
    (checked : checkAction tree limit s first action = true) : Reply s first := by
  cases action with
  | win second witness =>
    have parts : (addTile s first) second < 4 ∧
        FullWinWitness.check (afterReply s first second) witness = true := by
      simpa only [checkAction, Bool.and_eq_true, decide_eq_true_eq] using checked
    have legal : LegalAdd (addTile s first) second :=
      ⟨valid_add legalFirst.1 legalFirst.2, parts.1⟩
    exact Reply.win second legal
      (FullWinWitness.sound _ witness (valid_add legal.1 legal.2) parts.2)
  | back second ref path =>
    have parts : (addTile s first) second < 4 ∧ ref < limit ∧
        (match lookup tree ref with
         | none => false
         | some child => Generators.checkReference path child.state (afterReply s first second)) = true := by
      simpa only [checkAction, Bool.and_eq_true, decide_eq_true_eq] using checked
    have legal : LegalAdd (addTile s first) second :=
      ⟨valid_add legalFirst.1 legalFirst.2, parts.1⟩
    cases found : lookup tree ref with
    | none =>
      simp only [found, Bool.false_eq_true] at parts
      exact False.elim parts.2.2
    | some child =>
      have checkedRef : Generators.checkReference path child.state (afterReply s first second) = true := by
        simpa only [found] using parts.2.2
      exact Reply.backAlongCheckedPath first second legal
        (previous ref parts.2.1 child found) path checkedRef

/-- The selector is ordinary data. Every selected SAFE bound must have a
    separate mathematical proof supplied to soundness, potentially shared
    by arbitrarily many rows. A one-region certificate uses a constant bound. -/
def checkRow (bounds : Nat → State) (tree : Tree) (row : Row) : Bool :=
  RuleChecker.containsB row.state (bounds row.safeBound) &&
    allTiles.all (fun first => if row.state first < 4 then
      checkAction tree row.id row.state first (row.action first) else true)

theorem checkRow_sound (bounds : Nat → State)
    (validBounds : ∀ i, Valid (bounds i)) (safeBounds : ∀ i, IsSafe (bounds i))
    (tree : Tree) (row : Row)
    (previous : ∀ id, id < row.id → ∀ child, lookup tree id = some child → ProvedP child.state)
    (checked : checkRow bounds tree row = true) : ProvedP row.state := by
  have parts : RuleChecker.containsB row.state (bounds row.safeBound) = true ∧
      allTiles.all (fun first => if row.state first < 4 then
        checkAction tree row.id row.state first (row.action first) else true) = true := by
    simpa only [checkRow, Bool.and_eq_true] using checked
  apply node_of_safe_extension ((RuleChecker.containsB_iff _ _).1 parts.1)
    (validBounds row.safeBound) (safeBounds row.safeBound)
  intro first legalFirst
  have checkedAction := List.all_eq_true.mp parts.2 first (mem_allTiles first)
  simp only [if_pos legalFirst.2] at checkedAction
  exact checkAction_sound tree row.id previous row.state first legalFirst
    (row.action first) checkedAction

def checkDatabase (bounds : Nat → State) (tree : Tree) : Bool :=
  allCheck (checkRow bounds tree) tree

/-- One checked table proves every retrieved physical P state. All row IDs
    strictly decrease through references; tree balance affects speed only. -/
theorem checkDatabase_sound (bounds : Nat → State)
    (validBounds : ∀ i, Valid (bounds i)) (safeBounds : ∀ i, IsSafe (bounds i))
    (tree : Tree) (checked : checkDatabase bounds tree = true)
    (id : Nat) (row : Row) (found : lookup tree id = some row) : ProvedP row.state := by
  have all : AllRows (fun r => checkRow bounds tree r = true) tree :=
    allCheck_sound (checkRow bounds tree) tree checked
  have byId : ∀ id : Nat, ∀ row, lookup tree id = some row → ProvedP row.state := by
    intro id
    induction id using Nat.strongRecOn with
    | ind id ih =>
      intro current lookupCurrent
      have facts := lookup_property (fun r => checkRow bounds tree r = true)
        tree all id current lookupCurrent
      apply checkRow_sound bounds validBounds safeBounds tree current
      · intro ref less child lookupChild
        exact ih ref (by simpa only [facts.2] using less) child lookupChild
      · exact facts.1
  exact byId id row found

theorem original_second_player_wins (bounds : Nat → State)
    (validBounds : ∀ i, Valid (bounds i)) (safeBounds : ∀ i, IsSafe (bounds i))
    (tree : Tree) (checked : checkDatabase bounds tree = true)
    (id : Nat) (row : Row) (found : lookup tree id = some row) :
    SafeGame.SecondPlayerWins Step Win row.state :=
  (checkDatabase_sound bounds validBounds safeBounds tree checked id row found).secondPlayerWins

end Mahjong.ResponseTable

#print axioms Mahjong.ResponseTable.checkAction_sound
#print axioms Mahjong.ResponseTable.checkRow_sound
#print axioms Mahjong.ResponseTable.checkDatabase_sound
#print axioms Mahjong.ResponseTable.original_second_player_wins
