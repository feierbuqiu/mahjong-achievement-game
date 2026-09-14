import Mahjong.RetrogradeEvaluation

set_option autoImplicit false

namespace Mahjong.LayeredRetrograde
open SafeGame RetrogradeEvaluation
universe u
variable {α : Type u} [DecidableEq α]

abbrev Table (α : Type u) := α → Option Bool
def value (table : Table α) (s : α) : Bool := (table s).getD false
def ready (table : Table α) (xs : List α) : Bool := xs.all (fun s => (table s).isSome)
def store (table : Table α) (s : α) (b : Bool) : Table α := fun t => if t = s then some b else table t

def step (succ : α → List α) (table : Table α) (s : α) : Option (Table α) :=
  if ready table (succ s) then some (store table s (scan (value table) (succ s))) else none

def run (succ : α → List α) : List α → Table α → Option (Table α)
  | [], table => some table
  | s :: rest, table => match step succ table s with
    | none => none
    | some next => run succ rest next

def Truthful (move : α → α → Prop) (table : Table α) : Prop :=
  ∀ s b, table s = some b → NormalStrategy move s (outcome b)

def Covered (table : Table α) (xs : List α) : Prop := ∀ s, s ∈ xs → ∃ b, table s = some b

/-- Prerequisites must appear earlier, so unknown cells cannot count as N. -/
def DependencyOrder (succ : α → List α) : List α → List α → Prop
  | _, [] => True
  | done, s :: rest => (∀ t, t ∈ succ s → t ∈ done) ∧ DependencyOrder succ (s :: done) rest

theorem ready_iff (table : Table α) (xs : List α) : ready table xs = true ↔ Covered table xs := by
  simp only [ready,List.all_eq_true,Covered]
  constructor
  · intro h s hs
    cases eq : table s with
    | none => have bad := h s hs; simp [eq] at bad
    | some b => exact ⟨b,rfl⟩
  · intro h s hs
    obtain ⟨b,eq⟩ := h s hs
    simp [eq]

theorem store_self (table : Table α) (s : α) (b : Bool) : store table s b s = some b := by simp [store]

theorem store_covered (table : Table α) (xs : List α) (covered : Covered table xs) (s : α) (b : Bool) :
    Covered (store table s b) (s :: xs) := by
  intro t ht
  by_cases eq : t = s
  · subst t
    exact ⟨b,store_self table s b⟩
  · have old : t ∈ xs := (List.mem_cons.mp ht).resolve_left eq
    obtain ⟨v,hv⟩ := covered t old
    exact ⟨v,by simp only [store,if_neg eq]; exact hv⟩

theorem step_sound (move : α → α → Prop) (succ : α → List α)
    (exactSucc : ∀ s t, move s t ↔ t ∈ succ s)
    (table next : Table α) (truth : Truthful move table) (s : α)
    (accepted : step succ table s = some next) : Truthful move next := by
  unfold step at accepted
  split at accepted
  next readyNow =>
    have eq : store table s (scan (value table) (succ s)) = next := Option.some.inj accepted
    subst next
    have childProof : ∀ t, t ∈ succ s → NormalStrategy move t (outcome (value table t)) := by
      intro t ht
      obtain ⟨b,hb⟩ := (ready_iff table (succ s)).mp readyNow t ht
      simpa [value,hb] using truth t b hb
    have thisProof := RetrogradeEvaluation.step_sound move s (succ s) (value table) (exactSucc s) childProof
    intro t b hb
    by_cases same : t = s
    · subst t
      have bit : scan (value table) (succ s) = b := Option.some.inj (by simpa [store] using hb)
      rwa [bit] at thisProof
    · exact truth t b (by simpa only [store,if_neg same] using hb)
  next rejected => cases accepted

theorem run_sound (move : α → α → Prop) (succ : α → List α)
    (exactSucc : ∀ s t, move s t ↔ t ∈ succ s) (order : List α) (table result : Table α)
    (truth : Truthful move table) (accepted : run succ order table = some result) : Truthful move result := by
  induction order generalizing table with
  | nil => have eq : table = result := Option.some.inj accepted; rwa [← eq]
  | cons s rest ih =>
    cases hs : step succ table s with
    | none => simp only [run,hs] at accepted; cases accepted
    | some next =>
      apply ih next (step_sound move succ exactSucc table next truth s hs)
      simpa only [run,hs] using accepted

theorem empty_truthful (move : α → α → Prop) : Truthful move (fun _ => none) := by
  intro s b h
  cases h

theorem run_complete (succ : α → List α) (done order : List α) (table : Table α)
    (covered : Covered table done) (deps : DependencyOrder succ done order) :
    ∃ result, run succ order table = some result ∧ Covered result (order ++ done) := by
  induction order generalizing done table with
  | nil => exact ⟨table,rfl,covered⟩
  | cons s rest ih =>
    have children : Covered table (succ s) := fun t ht => covered t (deps.1 t ht)
    let next := store table s (scan (value table) (succ s))
    have nextReady := store_covered table done covered s (scan (value table) (succ s))
    obtain ⟨result,ran,all⟩ := ih (s::done) next nextReady deps.2
    refine ⟨result,?_,?_⟩
    · simp only [run,step,(ready_iff table (succ s)).mpr children,↓reduceIte]
      exact ran
    · intro t ht
      apply all t
      simp only [List.mem_append,List.mem_cons] at ht ⊢
      rcases ht with (head | rest) | old
      · exact Or.inr (Or.inl head)
      · exact Or.inl rest
      · exact Or.inr (Or.inr old)

/-- The numeric rank increases along the processing list. Every edge points
to a strictly smaller rank. Complete enumeration therefore supplies exactly
the dependency order needed by the bottom-up run. -/
theorem order_from_ranks (succ : α → List α) (rank : α → Nat)
    (decreases : ∀ s t, t ∈ succ s → rank t < rank s)
    (done order : List α) (covers : ∀ s, s ∈ done ++ order)
    (sorted : order.Pairwise (fun s t => rank s ≤ rank t)) : DependencyOrder succ done order := by
  induction order generalizing done with
  | nil => trivial
  | cons s rest ih =>
    have pair := List.pairwise_cons.mp sorted
    constructor
    · intro t ht
      have lt := decreases s t ht
      have all := covers t
      simp only [List.mem_append,List.mem_cons] at all
      rcases all with old | same | tail
      · exact old
      · subst t; omega
      · have le := pair.1 t tail; omega
    · apply ih (s::done) ?_ pair.2
      intro t
      have all := covers t
      simp only [List.mem_append,List.mem_cons] at all ⊢
      rcases all with old | head | tail
      · exact Or.inl (Or.inr old)
      · exact Or.inl (Or.inl head)
      · exact Or.inr tail

/-- Existence and correctness of the finite bottom-up computation from an
empty table. No historical output bit or recurrence certificate is assumed. -/
theorem bottom_up_correct (move : α → α → Prop) (succ : α → List α) (rank : α → Nat)
    (exactSucc : ∀ s t, move s t ↔ t ∈ succ s)
    (decreases : ∀ s t, move s t → rank t < rank s)
    (states : List α) (covers : ∀ s, s ∈ states)
    (sorted : states.Pairwise (fun s t => rank s ≤ rank t)) :
    ∃ result, run succ states (fun _ => none) = some result ∧
      ∀ s, ∃ b, result s = some b ∧ NormalStrategy move s (outcome b) := by
  have deps := order_from_ranks succ rank (fun s t ht => decreases s t ((exactSucc s t).mpr ht))
    [] states (by simpa using covers) sorted
  obtain ⟨result,ran,covered⟩ := run_complete succ [] states (fun _ => none) (by intro s hs; cases hs) deps
  have truths := run_sound move succ exactSucc states (fun _ => none) result (empty_truthful move) ran
  refine ⟨result,ran,?_⟩
  intro s
  obtain ⟨b,hb⟩ := covered s (by simpa using covers s)
  exact ⟨b,hb,truths s b hb⟩

end Mahjong.LayeredRetrograde

#print axioms Mahjong.LayeredRetrograde.ready_iff
#print axioms Mahjong.LayeredRetrograde.store_covered
#print axioms Mahjong.LayeredRetrograde.step_sound
#print axioms Mahjong.LayeredRetrograde.run_sound
#print axioms Mahjong.LayeredRetrograde.empty_truthful
#print axioms Mahjong.LayeredRetrograde.run_complete
#print axioms Mahjong.LayeredRetrograde.order_from_ranks
#print axioms Mahjong.LayeredRetrograde.bottom_up_correct
