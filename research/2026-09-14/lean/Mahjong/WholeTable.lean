import Mahjong.FactorizedRules
import Mahjong.Generators
import Mahjong.DownwardClosure

/- A finite candidate table is untrusted data. No theorem about its rank,
unrank, canonicalizer, SAFE filtering, size, or P/N bits is a premise.
All references, including those out of N rows, are checked before reuse.
The scanner is constant-stack and does not allocate a list of all indices. -/
namespace Mahjong.WholeTable
open SafeGame Generators

structure Candidate where
  size : Nat
  unrank : Nat → State
  rank : State → Nat
  canonical : State → State
  restore : State → List Generator
  label : Nat → Outcome

def childIndex (table : Candidate) (s : State) : Nat := table.rank (table.canonical s)

def checkRef (table : Candidate) (parentStock : Nat) (s : State) : Bool :=
  let i := childIndex table s
  decide (i < table.size) &&
    stateEqB (table.unrank i) (table.canonical s) &&
    checkReference (table.restore s) (table.unrank i) s &&
    decide (stock (table.unrank i) < parentStock)

def checkPN (table : Candidate) (next : List State) (label : Outcome) : Bool :=
  match label with
  | .P => next.all (fun s => decide (table.label (childIndex table s) = .N))
  | .N => next.any (fun s => decide (table.label (childIndex table s) = .P))

def checkRow (table : Candidate) (i : Nat) : Bool :=
  let s := table.unrank i
  let next := FactorizedRules.safeSuccessors s
  RuleChecker.validB s && FactorizedRules.safeB s &&
    next.all (checkRef table (stock s)) && checkPN table next (table.label i)

def checkSpan (table : Candidate) (start : Nat) : Nat → Bool
  | 0 => true
  | count + 1 => checkRow table start && checkSpan table (start + 1) count

def check (table : Candidate) : Bool := checkSpan table 0 table.size

/-- Adjacent completed spans compose without rerunning their interior rows. -/
theorem checkSpan_add (table : Candidate) (a b start : Nat) :
    checkSpan table start (a + b) =
      (checkSpan table start a && checkSpan table (start + a) b) := by
  induction a generalizing start with
  | zero => simp [checkSpan]
  | succ a ih =>
    simp only [Nat.succ_add, checkSpan, ih]
    simp [Nat.add_assoc, Nat.add_comm, Nat.add_left_comm, Bool.and_assoc]

theorem roundtrip_injective {α β : Type} (rank : α → β) (unrank : β → α)
    {s t : α} (hs : unrank (rank s) = s) (ht : unrank (rank t) = t)
    (same : rank s = rank t) : s = t := by
  rw [← hs, ← ht, same]

theorem checkSpan_each (table : Candidate) (count start : Nat)
    (checked : checkSpan table start count = true) :
    ∀ offset, offset < count → checkRow table (start + offset) = true := by
  induction count generalizing start with
  | zero => intro offset h; omega
  | succ count ih =>
    have parts : checkRow table start = true ∧ checkSpan table (start + 1) count = true := by
      simpa only [checkSpan, Bool.and_eq_true] using checked
    intro offset h
    cases offset with
    | zero => simpa using parts.1
    | succ offset =>
      have x := ih (start + 1) parts.2 offset (by omega)
      simpa [Nat.add_assoc, Nat.add_comm, Nat.add_left_comm] using x

theorem checkRef_parts (table : Candidate) (parentStock : Nat) (s : State)
    (checked : checkRef table parentStock s = true) :
    childIndex table s < table.size ∧
    table.unrank (childIndex table s) = table.canonical s ∧
    checkReference (table.restore s) (table.unrank (childIndex table s)) s = true ∧
    stock (table.unrank (childIndex table s)) < parentStock := by
  simp only [checkRef, Bool.and_eq_true, decide_eq_true_eq] at checked
  exact ⟨checked.1.1.1, stateEqB_sound checked.1.1.2, checked.1.2, checked.2⟩

theorem check_sound (table : Candidate) (checked : check table = true)
    (i : Nat) (inside : i < table.size) :
    NormalStrategy SafeMove (table.unrank i) (table.label i) := by
  have each : ∀ j, j < table.size → checkRow table j = true := by
    intro j hj
    simpa using checkSpan_each table table.size 0 checked j hj
  have bounded : ∀ n, ∀ j, j < table.size → stock (table.unrank j) ≤ n →
      NormalStrategy SafeMove (table.unrank j) (table.label j) := by
    intro n
    induction n using Nat.strongRecOn with
    | ind n ih =>
      intro j hj bound
      have row := each j hj
      simp only [checkRow, Bool.and_eq_true] at row
      have refs := List.all_eq_true.mp row.1.2
      have child (t : State) (edge : SafeMove (table.unrank j) t) :
          NormalStrategy SafeMove t (table.label (childIndex table t)) := by
        have mem := (FactorizedRules.safeSuccessors_iff _ _).mp edge
        have parts := checkRef_parts table _ t (refs t mem)
        have smaller := Nat.lt_of_lt_of_le parts.2.2.2 bound
        have proved := ih (stock (table.unrank (childIndex table t))) smaller
          (childIndex table t) parts.1 (Nat.le_refl _)
        exact checked_reference_sound (table.restore t) parts.2.2.1 proved
      cases label : table.label j with
      | P =>
        apply NormalStrategy.p
        intro t edge
        have labels : (FactorizedRules.safeSuccessors (table.unrank j)).all
            (fun s => decide (table.label (childIndex table s) = .N)) = true := by
          simpa [checkPN, label] using row.2
        have ht := of_decide_eq_true (List.all_eq_true.mp labels t
          ((FactorizedRules.safeSuccessors_iff _ _).mp edge))
        simpa only [ht] using child t edge
      | N =>
        have labels : (FactorizedRules.safeSuccessors (table.unrank j)).any
            (fun s => decide (table.label (childIndex table s) = .P)) = true := by
          simpa [checkPN, label] using row.2
        obtain ⟨t, mem, ht⟩ := List.any_eq_true.mp labels
        have edge := (FactorizedRules.safeSuccessors_iff _ _).mpr mem
        apply NormalStrategy.n (move := SafeMove) edge
        have hp := of_decide_eq_true ht
        simpa only [hp] using child t edge
  exact bounded (stock (table.unrank i)) i inside (Nat.le_refl _)

def checkRoot (table : Candidate) (i : Nat) : Bool :=
  decide (i < table.size) && stateEqB (table.unrank i) empty && decide (table.label i = .P)

/-- The only computation premise is acceptance of this actual candidate table.
There is no rank/unrank bijection, SAFE <= 34, or C++-profile premise. -/
theorem checked_empty_wins (table : Candidate) (i : Nat)
    (checked : check table = true) (root : checkRoot table i = true) :
    SecondPlayerWins Step Win empty := by
  simp only [checkRoot, Bool.and_eq_true, decide_eq_true_eq] at root
  have equal := stateEqB_sound root.1.2
  apply original_second_player_wins_of_safe_P
  simpa only [equal, root.2] using check_sound table checked i root.1.1

end Mahjong.WholeTable

#print axioms Mahjong.WholeTable.roundtrip_injective
#print axioms Mahjong.WholeTable.checkSpan_add
#print axioms Mahjong.WholeTable.checkSpan_each
#print axioms Mahjong.WholeTable.check_sound
#print axioms Mahjong.WholeTable.checked_empty_wins
