import Std
import Mahjong.SafeGame

/-!
# Executable P/N certificates

The input is ordinary Lean data.  Acceptance is a proposition about a pure Bool
checker, and the soundness proofs below are checked by the Lean kernel.  No file
hash, native process exit status, or external table is assumed to be true.

`checkAll` checks a total labelling of an explicitly covered finite game.
`checkTrace` checks an acyclic, possibly sparse list of justified claims.  Every
P claim checks every successor; an N claim only needs one P successor already
justified in the tail.  Repeated entries are harmless for soundness.

The `exactSucc` premise is essential: an external enumerator is not a proof that
all moves of the mathematical game were enumerated.
-/

namespace Mahjong.Certificate

open Mahjong.SafeGame

universe u

variable {α : Type u}

/-- A requested P/N fact, not an assumption or a proof of that fact. -/
structure Claim (α : Type u) where
  state : α
  outcome : Outcome
  deriving DecidableEq, Repr

/-- Check the local P/N recurrence using a complete successor enumeration. -/
def checkLabel (succ : α → List α) (label : α → Outcome) (s : α) : Bool :=
  match label s with
  | .P => (succ s).all (fun t => decide (label t = .N))
  | .N => (succ s).any (fun t => decide (label t = .P))

/-- Check each state listed in `states`; completeness is a separate premise. -/
def checkAll (states : List α) (succ : α → List α)
    (label : α → Outcome) : Bool :=
  states.all (checkLabel succ label)

theorem checkLabel_sound (succ : α → List α) (label : α → Outcome) (s : α)
    (checked : checkLabel succ label s = true) :
    (label s = .P → ∀ t, t ∈ succ s → label t = .N) ∧
    (label s = .N → ∃ t, t ∈ succ s ∧ label t = .P) := by
  constructor
  · intro hp
    simpa [checkLabel, hp] using checked
  · intro hn
    simpa [checkLabel, hn] using checked

/-- A checked, complete table gives the local certificate used by SafeGame. -/
theorem checkAll_certificate
    (states : List α) (succ : α → List α) (label : α → Outcome)
    (move : α → α → Prop) (rank : α → Nat)
    (covers : ∀ s, s ∈ states)
    (exactSucc : ∀ s t, move s t ↔ t ∈ succ s)
    (decreases : ∀ {s t}, move s t → rank t < rank s)
    (checked : checkAll states succ label = true) :
    PNCertificate move rank label := by
  have each : ∀ s, s ∈ states → checkLabel succ label s = true := by
    simpa [checkAll] using checked
  refine { decreases := decreases, p_label := ?_, n_label := ?_ }
  · intro s hp t hm
    exact (checkLabel_sound succ label s (each s (covers s))).1 hp t
      ((exactSucc s t).mp hm)
  · intro s hn
    obtain ⟨t, ht, hp⟩ :=
      (checkLabel_sound succ label s (each s (covers s))).2 hn
    exact ⟨t, (exactSucc s t).mpr ht, hp⟩

/-- Complete finite checking plus a decreasing rank proves every table label. -/
theorem checkAll_sound
    (states : List α) (succ : α → List α) (label : α → Outcome)
    (move : α → α → Prop) (rank : α → Nat)
    (covers : ∀ s, s ∈ states)
    (exactSucc : ∀ s t, move s t ↔ t ∈ succ s)
    (decreases : ∀ {s t}, move s t → rank t < rank s)
    (checked : checkAll states succ label = true) (s : α) :
    NormalStrategy move s (label s) :=
  (checkAll_certificate states succ label move rank covers exactSucc decreases
    checked).sound s

section Trace

variable [DecidableEq α]

/-- Search already justified claims.  This simple implementation is linear. -/
def known (facts : List (Claim α)) (s : α) (outcome : Outcome) : Bool :=
  facts.any (fun c => decide (c.state = s ∧ c.outcome = outcome))

/-- Check one claim against facts that must already have been justified. -/
def checkClaim (succ : α → List α) (facts : List (Claim α))
    (c : Claim α) : Bool :=
  match c.outcome with
  | .P => (succ c.state).all (fun t => known facts t .N)
  | .N => (succ c.state).any (fun t => known facts t .P)

/--
The tail contains earlier claims.  This order prevents cyclic self-support,
including a purported terminal N claim and a self-justifying P/N cycle.
-/
def checkTrace (succ : α → List α) : List (Claim α) → Bool
  | [] => true
  | c :: cs => checkTrace succ cs && checkClaim succ cs c

theorem known_sound (move : α → α → Prop) (facts : List (Claim α))
    (truths : ∀ c, c ∈ facts → NormalStrategy move c.state c.outcome)
    (s : α) (outcome : Outcome) (checked : known facts s outcome = true) :
    NormalStrategy move s outcome := by
  have found : ∃ c, c ∈ facts ∧ c.state = s ∧ c.outcome = outcome := by
    simpa [known] using checked
  obtain ⟨c, hc, hs, ho⟩ := found
  simpa [hs, ho] using truths c hc

theorem checkClaim_sound (succ : α → List α) (move : α → α → Prop)
    (exactSucc : ∀ s t, move s t ↔ t ∈ succ s)
    (facts : List (Claim α))
    (truths : ∀ c, c ∈ facts → NormalStrategy move c.state c.outcome)
    (c : Claim α) (checked : checkClaim succ facts c = true) :
    NormalStrategy move c.state c.outcome := by
  cases ho : c.outcome with
  | P =>
      have allKnown : ∀ t, t ∈ succ c.state → known facts t .N = true := by
        simpa [checkClaim, ho] using checked
      apply NormalStrategy.p
      intro t hm
      exact known_sound move facts truths t .N
        (allKnown t ((exactSucc c.state t).mp hm))
  | N =>
      have someKnown : ∃ t, t ∈ succ c.state ∧ known facts t .P = true := by
        simpa [checkClaim, ho] using checked
      obtain ⟨t, ht, hp⟩ := someKnown
      exact NormalStrategy.n ((exactSucc c.state t).mpr ht)
        (known_sound move facts truths t .P hp)

/--
A successful acyclic trace proves every contained claim for the exact game.
No global domain coverage or full table is required for this theorem.
-/
theorem checkTrace_sound (succ : α → List α) (move : α → α → Prop)
    (exactSucc : ∀ s t, move s t ↔ t ∈ succ s)
    (trace : List (Claim α)) :
    checkTrace succ trace = true →
    ∀ c, c ∈ trace → NormalStrategy move c.state c.outcome := by
  induction trace with
  | nil =>
      intro _ c hc
      cases hc
  | cons c cs ih =>
      intro checked
      have parts : checkTrace succ cs = true ∧ checkClaim succ cs c = true := by
        simpa [checkTrace] using checked
      have tail := ih parts.1
      intro d hd
      rcases List.mem_cons.mp hd with heq | ht
      · subst d
        exact checkClaim_sound succ move exactSucc cs tail c parts.2
      · exact tail d ht

end Trace

end Mahjong.Certificate
