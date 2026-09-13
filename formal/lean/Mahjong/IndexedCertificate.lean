import Std
import Mahjong.SafeGame

/-!
# Certificates with explicit references and tree lookup

The tree is ordinary inductive Lean data.  External producers may balance it;
soundness does not assume its ordering, balance, index uniqueness, or provenance.
Every stored node is checked.  A lookup succeeds only at its exact requested ID.
Every reference must have a strictly smaller ID than the node being checked.

P nodes pair references with the complete successor list, including its length.
N nodes carry exactly one reference to a legal P successor.  A balanced input
tree needs logarithmic lookup depth instead of searching all previous claims.
-/

namespace Mahjong.IndexedCertificate

open Mahjong.SafeGame

universe u

variable {α : Type u}

structure Node (α : Type u) where
  id : Nat
  state : α
  outcome : Outcome
  refs : List Nat
  deriving DecidableEq, Repr

inductive Tree (α : Type u) where
  | empty
  | branch (left : Tree α) (node : Node α) (right : Tree α)
  deriving Repr

/-- Exact-ID search. A badly ordered tree may fail to find an existing node. -/
def lookup : Tree α → Nat → Option (Node α)
  | .empty, _ => none
  | .branch left node right, id =>
      if id = node.id then some node
      else if id < node.id then lookup left id else lookup right id

def AllNodes (property : Node α → Prop) : Tree α → Prop
  | .empty => True
  | .branch left node right =>
      AllNodes property left ∧ property node ∧ AllNodes property right

theorem lookup_property (property : Node α → Prop) (tree : Tree α)
    (all : AllNodes property tree) (id : Nat) (node : Node α)
    (found : lookup tree id = some node) : property node ∧ node.id = id := by
  induction tree with
  | empty => simp [lookup] at found
  | branch left current right ihl ihr =>
      obtain ⟨hl, hc, hr⟩ := all
      by_cases same : id = current.id
      · have hn : current = node := by simpa [lookup, same] using found
        subst node
        exact ⟨hc, same.symm⟩
      · by_cases less : id < current.id
        · exact ihl hl (by simpa [lookup, same, less] using found)
        · exact ihr hr (by simpa [lookup, same, less] using found)

def allCheck (test : Node α → Bool) : Tree α → Bool
  | .empty => true
  | .branch left node right => allCheck test left && test node && allCheck test right

theorem allCheck_sound (test : Node α → Bool) (tree : Tree α)
    (checked : allCheck test tree = true) : AllNodes (fun node => test node = true) tree := by
  induction tree with
  | empty => trivial
  | branch left node right ihl ihr =>
      have parts : (allCheck test left = true ∧ test node = true) ∧
          allCheck test right = true := by
        simpa [allCheck] using checked
      exact ⟨ihl parts.1.1, parts.1.2, ihr parts.2⟩

section Check

variable [DecidableEq α]

def checkRef (tree : Tree α) (limit ref : Nat) (state : α) (outcome : Outcome) : Bool :=
  decide (ref < limit) &&
    match lookup tree ref with
    | none => false
    | some node => decide (node.state = state ∧ node.outcome = outcome)

def checkP (tree : Tree α) (limit : Nat) : List α → List Nat → Bool
  | [], [] => true
  | state :: states, ref :: refs =>
      checkRef tree limit ref state .N && checkP tree limit states refs
  | _, _ => false

def checkNode (succ : α → List α) (tree : Tree α) (node : Node α) : Bool :=
  match node.outcome with
  | .P => checkP tree node.id (succ node.state) node.refs
  | .N =>
      match node.refs with
      | [ref] => decide (ref < node.id) &&
          match lookup tree ref with
          | none => false
          | some child => decide (child.outcome = .P ∧ child.state ∈ succ node.state)
      | _ => false

def checkDatabase (succ : α → List α) (tree : Tree α) : Bool :=
  allCheck (checkNode succ tree) tree

theorem checkRef_sound (tree : Tree α) (move : α → α → Prop) (limit : Nat)
    (previous : ∀ ref, ref < limit → ∀ child, lookup tree ref = some child →
      NormalStrategy move child.state child.outcome)
    (ref : Nat) (state : α) (outcome : Outcome)
    (checked : checkRef tree limit ref state outcome = true) :
    NormalStrategy move state outcome := by
  have parts : ref < limit ∧
      (match lookup tree ref with
       | none => false
       | some node => decide (node.state = state ∧ node.outcome = outcome)) = true := by
    simpa [checkRef] using checked
  cases found : lookup tree ref with
  | none => simp [found] at parts
  | some child =>
      have same : child.state = state ∧ child.outcome = outcome := by
        simpa [found] using parts.2
      simpa [same.1, same.2] using previous ref parts.1 child found

theorem checkP_sound (tree : Tree α) (move : α → α → Prop) (limit : Nat)
    (previous : ∀ ref, ref < limit → ∀ child, lookup tree ref = some child →
      NormalStrategy move child.state child.outcome)
    (states : List α) (refs : List Nat)
    (checked : checkP tree limit states refs = true) :
    ∀ state, state ∈ states → NormalStrategy move state .N := by
  induction states generalizing refs with
  | nil =>
      intro state member
      cases member
  | cons state states ih =>
      cases refs with
      | nil => simp [checkP] at checked
      | cons ref refs =>
          have parts : checkRef tree limit ref state .N = true ∧
              checkP tree limit states refs = true := by
            simpa [checkP] using checked
          intro target member
          rcases List.mem_cons.mp member with same | tail
          · subst target
            exact checkRef_sound tree move limit previous ref state .N parts.1
          · exact ih refs parts.2 target tail

theorem checkNode_sound (succ : α → List α) (move : α → α → Prop)
    (exactSucc : ∀ s t, move s t ↔ t ∈ succ s)
    (tree : Tree α) (node : Node α)
    (previous : ∀ ref, ref < node.id → ∀ child, lookup tree ref = some child →
      NormalStrategy move child.state child.outcome)
    (checked : checkNode succ tree node = true) :
    NormalStrategy move node.state node.outcome := by
  cases outcome : node.outcome with
  | P =>
      have hp : checkP tree node.id (succ node.state) node.refs = true := by
        simpa [checkNode, outcome] using checked
      apply NormalStrategy.p
      intro target edge
      exact checkP_sound tree move node.id previous (succ node.state) node.refs hp
        target ((exactSucc node.state target).mp edge)
  | N =>
      cases refs : node.refs with
      | nil => simp [checkNode, outcome, refs] at checked
      | cons ref rest =>
          cases rest with
          | cons another rest => simp [checkNode, outcome, refs] at checked
          | nil =>
              have parts : ref < node.id ∧
                  (match lookup tree ref with
                   | none => false
                   | some child => decide (child.outcome = .P ∧
                       child.state ∈ succ node.state)) = true := by
                simpa [checkNode, outcome, refs] using checked
              cases found : lookup tree ref with
              | none => simp [found] at parts
              | some child =>
                  have childFacts : child.outcome = .P ∧ child.state ∈ succ node.state := by
                    simpa [found] using parts.2
                  have strategy := previous ref parts.1 child found
                  exact NormalStrategy.n ((exactSucc node.state child.state).mpr childFacts.2)
                    (by simpa [childFacts.1] using strategy)

/--
Every successful lookup in a checked tree gives a strategy for the exact game.
Only the reference IDs impose the proof order; tree shape imposes none.
-/
theorem checkDatabase_sound (succ : α → List α) (move : α → α → Prop)
    (exactSucc : ∀ s t, move s t ↔ t ∈ succ s)
    (tree : Tree α) (checked : checkDatabase succ tree = true)
    (id : Nat) (node : Node α) (found : lookup tree id = some node) :
    NormalStrategy move node.state node.outcome := by
  have all : AllNodes (fun n => checkNode succ tree n = true) tree :=
    allCheck_sound (checkNode succ tree) tree checked
  have byId : ∀ id : Nat, ∀ node, lookup tree id = some node →
      NormalStrategy move node.state node.outcome := by
    intro id
    induction id using Nat.strongRecOn with
    | ind id ih =>
        intro current lookupCurrent
        have currentFacts := lookup_property (fun n => checkNode succ tree n = true)
          tree all id current lookupCurrent
        apply checkNode_sound succ move exactSucc tree current
        · intro ref less child lookupChild
          exact ih ref (by simpa [currentFacts.2] using less) child lookupChild
        · exact currentFacts.1
  exact byId id node found

end Check

end Mahjong.IndexedCertificate
