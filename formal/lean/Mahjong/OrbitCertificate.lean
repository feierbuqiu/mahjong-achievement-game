import Std
import Mahjong.SafeGame

/-!
# Strategy sharing with checked symmetry witnesses

A reference names an earlier proved state and a finite transformation witness.
The transformed state must equal the actual physical successor being checked.
No canonicalizer, orbit classifier, index, or representative choice is trusted.
-/

namespace Mahjong.OrbitCertificate

open Mahjong.SafeGame

universe u v

variable {α : Type u} {G : Type v}

/-- Apply the head generator first, then the remainder of the list. -/
def applyWord (action : G → α → α) : List G → α → α
  | [], s => s
  | g :: gs, s => applyWord action gs (action g s)

theorem applyWord_sound (action : G → α → α) (move : α → α → Prop)
    (action_sound : ∀ g s o,
      NormalStrategy move (action g s) o ↔ NormalStrategy move s o)
    (word : List G) (s : α) (o : Outcome) :
    NormalStrategy move (applyWord action word s) o ↔ NormalStrategy move s o := by
  induction word generalizing s with
  | nil => rfl
  | cons g gs ih =>
      exact (ih (action g s)).trans (action_sound g s o)

structure Ref (G : Type v) where
  id : Nat
  witness : List G
  deriving Repr

structure Node (α : Type u) (G : Type v) where
  id : Nat
  state : α
  outcome : Outcome
  refs : List (Ref G)
  deriving Repr

inductive Tree (α : Type u) (G : Type v) where
  | empty
  | branch (left : Tree α G) (node : Node α G) (right : Tree α G)
  deriving Repr

def lookup : Tree α G → Nat → Option (Node α G)
  | .empty, _ => none
  | .branch left node right, id =>
      if id = node.id then some node
      else if id < node.id then lookup left id else lookup right id

def AllNodes (property : Node α G → Prop) : Tree α G → Prop
  | .empty => True
  | .branch left node right =>
      AllNodes property left ∧ property node ∧ AllNodes property right

theorem lookup_property (property : Node α G → Prop) (tree : Tree α G)
    (all : AllNodes property tree) (id : Nat) (node : Node α G)
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

def allCheck (test : Node α G → Bool) : Tree α G → Bool
  | .empty => true
  | .branch left node right => allCheck test left && test node && allCheck test right

theorem allCheck_sound (test : Node α G → Bool) (tree : Tree α G)
    (checked : allCheck test tree = true) : AllNodes (fun node => test node = true) tree := by
  induction tree with
  | empty => trivial
  | branch left node right ihl ihr =>
      have parts : (allCheck test left = true ∧ test node = true) ∧
          allCheck test right = true := by simpa [allCheck] using checked
      exact ⟨ihl parts.1.1, parts.1.2, ihr parts.2⟩

section Check

variable [DecidableEq α]

/-- `transform witness proved` must be the real target, not merely share a hash. -/
def checkRef (transform : List G → α → α) (tree : Tree α G)
    (limit : Nat) (ref : Ref G) (state : α) (outcome : Outcome) : Bool :=
  decide (ref.id < limit) &&
    match lookup tree ref.id with
    | none => false
    | some node => decide (transform ref.witness node.state = state ∧ node.outcome = outcome)

def checkP (transform : List G → α → α) (tree : Tree α G)
    (limit : Nat) : List α → List (Ref G) → Bool
  | [], [] => true
  | state :: states, ref :: refs =>
      checkRef transform tree limit ref state .N && checkP transform tree limit states refs
  | _, _ => false

def checkNode (succ : α → List α) (transform : List G → α → α)
    (tree : Tree α G) (node : Node α G) : Bool :=
  match node.outcome with
  | .P => checkP transform tree node.id (succ node.state) node.refs
  | .N =>
      match node.refs with
      | [ref] => decide (ref.id < node.id) &&
          match lookup tree ref.id with
          | none => false
          | some child => decide (child.outcome = .P ∧
              transform ref.witness child.state ∈ succ node.state)
      | _ => false

def checkDatabase (succ : α → List α) (transform : List G → α → α)
    (tree : Tree α G) : Bool :=
  allCheck (checkNode succ transform tree) tree

theorem checkRef_sound (transform : List G → α → α) (move : α → α → Prop)
    (transform_sound : ∀ word s o,
      NormalStrategy move (transform word s) o ↔ NormalStrategy move s o)
    (tree : Tree α G) (limit : Nat)
    (previous : ∀ id, id < limit → ∀ child, lookup tree id = some child →
      NormalStrategy move child.state child.outcome)
    (ref : Ref G) (state : α) (outcome : Outcome)
    (checked : checkRef transform tree limit ref state outcome = true) :
    NormalStrategy move state outcome := by
  have parts : ref.id < limit ∧
      (match lookup tree ref.id with
       | none => false
       | some node => decide (transform ref.witness node.state = state ∧
           node.outcome = outcome)) = true := by
    simpa [checkRef] using checked
  cases found : lookup tree ref.id with
  | none => simp [found] at parts
  | some child =>
      have same : transform ref.witness child.state = state ∧ child.outcome = outcome := by
        simpa [found] using parts.2
      have h := (transform_sound ref.witness child.state child.outcome).mpr
        (previous ref.id parts.1 child found)
      simpa [same.1, same.2] using h

theorem checkP_sound (transform : List G → α → α) (move : α → α → Prop)
    (transform_sound : ∀ word s o,
      NormalStrategy move (transform word s) o ↔ NormalStrategy move s o)
    (tree : Tree α G) (limit : Nat)
    (previous : ∀ id, id < limit → ∀ child, lookup tree id = some child →
      NormalStrategy move child.state child.outcome)
    (states : List α) (refs : List (Ref G))
    (checked : checkP transform tree limit states refs = true) :
    ∀ state, state ∈ states → NormalStrategy move state .N := by
  induction states generalizing refs with
  | nil =>
      intro state member
      cases member
  | cons state states ih =>
      cases refs with
      | nil => simp [checkP] at checked
      | cons ref refs =>
          have parts : checkRef transform tree limit ref state .N = true ∧
              checkP transform tree limit states refs = true := by
            simpa [checkP] using checked
          intro target member
          rcases List.mem_cons.mp member with same | tail
          · subst target
            exact checkRef_sound transform move transform_sound tree limit previous
              ref state .N parts.1
          · exact ih refs parts.2 target tail

theorem checkNode_sound (succ : α → List α) (move : α → α → Prop)
    (exactSucc : ∀ s t, move s t ↔ t ∈ succ s)
    (transform : List G → α → α)
    (transform_sound : ∀ word s o,
      NormalStrategy move (transform word s) o ↔ NormalStrategy move s o)
    (tree : Tree α G) (node : Node α G)
    (previous : ∀ id, id < node.id → ∀ child, lookup tree id = some child →
      NormalStrategy move child.state child.outcome)
    (checked : checkNode succ transform tree node = true) :
    NormalStrategy move node.state node.outcome := by
  cases outcome : node.outcome with
  | P =>
      have hp : checkP transform tree node.id (succ node.state) node.refs = true := by
        simpa [checkNode, outcome] using checked
      apply NormalStrategy.p
      intro target edge
      exact checkP_sound transform move transform_sound tree node.id previous
        (succ node.state) node.refs hp target ((exactSucc node.state target).mp edge)
  | N =>
      cases refs : node.refs with
      | nil => simp [checkNode, outcome, refs] at checked
      | cons ref rest =>
          cases rest with
          | cons another rest => simp [checkNode, outcome, refs] at checked
          | nil =>
              have parts : ref.id < node.id ∧
                  (match lookup tree ref.id with
                   | none => false
                   | some child => decide (child.outcome = .P ∧
                       transform ref.witness child.state ∈ succ node.state)) = true := by
                simpa [checkNode, outcome, refs] using checked
              cases found : lookup tree ref.id with
              | none => simp [found] at parts
              | some child =>
                  have facts : child.outcome = .P ∧
                      transform ref.witness child.state ∈ succ node.state := by
                    simpa [found] using parts.2
                  have h := (transform_sound ref.witness child.state child.outcome).mpr
                    (previous ref.id parts.1 child found)
                  exact NormalStrategy.n
                    ((exactSucc node.state (transform ref.witness child.state)).mpr facts.2)
                    (by simpa [facts.1] using h)

/-- A successful physical-move check with proved transformations yields the root strategy. -/
theorem checkDatabase_sound (succ : α → List α) (move : α → α → Prop)
    (exactSucc : ∀ s t, move s t ↔ t ∈ succ s)
    (transform : List G → α → α)
    (transform_sound : ∀ word s o,
      NormalStrategy move (transform word s) o ↔ NormalStrategy move s o)
    (tree : Tree α G) (checked : checkDatabase succ transform tree = true)
    (id : Nat) (node : Node α G) (found : lookup tree id = some node) :
    NormalStrategy move node.state node.outcome := by
  have all : AllNodes (fun n => checkNode succ transform tree n = true) tree :=
    allCheck_sound (checkNode succ transform tree) tree checked
  have byId : ∀ id : Nat, ∀ node, lookup tree id = some node →
      NormalStrategy move node.state node.outcome := by
    intro id
    induction id using Nat.strongRecOn with
    | ind id ih =>
        intro current lookupCurrent
        have facts := lookup_property (fun n => checkNode succ transform tree n = true)
          tree all id current lookupCurrent
        apply checkNode_sound succ move exactSucc transform transform_sound tree current
        · intro ref less child lookupChild
          exact ih ref (by simpa [facts.2] using less) child lookupChild
        · exact facts.1
  exact byId id node found

end Check

end Mahjong.OrbitCertificate
