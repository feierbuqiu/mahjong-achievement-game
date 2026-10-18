import Mahjong.MaskedLocalBound

/- The cache and both index functions are untrusted. Every available meld
reference is checked, even when an earlier meld already supplies a true bit.
Induction is on the requested meld count, not on an assumed index ordering. -/
namespace Mahjong.LocalCache
open StandardBoundCertificate MaskedLocalBound

structure Candidate where
  size : Nat
  unrank : Nat → State
  rank : State → Nat
  value : Nat → Nat → Bool

def checkRef (b : Nat) (table : Candidate) (s : State) : Bool :=
  decide (table.rank s < table.size) &&
    sameBlockB b (table.unrank (table.rank s)) s

def expected (b : Nat) (table : Candidate) (s : State) (k : Nat) : Bool :=
  (localMelds b).any (fun m => FastRuleChecker.meldAvailableB s m &&
    table.value (table.rank (FastRuleChecker.removeMeld s m)) k)

def checkRow (b : Nat) (table : Candidate) (i : Nat) : Bool :=
  let s := table.unrank i
  (localMelds b).all (fun m => if FastRuleChecker.meldAvailableB s m then
    checkRef b table (FastRuleChecker.removeMeld s m) else true) &&
  table.value i 0 && [0, 1, 2, 3].all (fun k =>
    decide (table.value i (k + 1) = expected b table s k))

def checkSpan (b : Nat) (table : Candidate) (start : Nat) : Nat → Bool
  | 0 => true
  | n + 1 => checkRow b table start && checkSpan b table (start + 1) n

def check (b : Nat) (table : Candidate) : Bool := checkSpan b table 0 table.size

theorem checkSpan_add (b : Nat) (table : Candidate) (a c start : Nat) :
    checkSpan b table start (a + c) =
      (checkSpan b table start a && checkSpan b table (start + a) c) := by
  induction a generalizing start with
  | zero => simp [checkSpan]
  | succ a ih =>
    simp only [Nat.succ_add, checkSpan, ih]
    simp [Nat.add_assoc, Nat.add_comm, Nat.add_left_comm, Bool.and_assoc]

theorem checkSpan_each (b : Nat) (table : Candidate) (count start : Nat)
    (checked : checkSpan b table start count = true) :
    ∀ offset, offset < count → checkRow b table (start + offset) = true := by
  induction count generalizing start with
  | zero => intro offset h; omega
  | succ count ih =>
    have parts : checkRow b table start = true ∧
        checkSpan b table (start + 1) count = true := by
      simpa only [checkSpan, Bool.and_eq_true] using checked
    intro offset h
    cases offset with
    | zero => simpa using parts.1
    | succ offset =>
      have x := ih (start + 1) parts.2 offset (by omega)
      simpa [Nat.add_assoc, Nat.add_comm, Nat.add_left_comm] using x

theorem checkRef_parts (b : Nat) (table : Candidate) (s : State)
    (checked : checkRef b table s = true) :
    table.rank s < table.size ∧ SameBlock b (table.unrank (table.rank s)) s := by
  simp only [checkRef, Bool.and_eq_true, decide_eq_true_eq] at checked
  exact ⟨checked.1, sameBlockB_sound checked.2⟩

private theorem any_eq_of_on_list (ms : List Meld) (p q : Meld → Bool)
    (same : ∀ m, m ∈ ms → p m = q m) : ms.any p = ms.any q := by
  induction ms with
  | nil => rfl
  | cons m ms ih =>
    simp only [List.any_cons]
    rw [same m (by simp), ih (fun n hn => same n (List.mem_cons_of_mem _ hn))]

theorem check_sound (b : Nat) (table : Candidate) (checked : check b table = true)
    (k : Nat) (small : k ≤ 4) (i : Nat) (inside : i < table.size) :
    table.value i k = searchWith (localMelds b) k (table.unrank i) := by
  have each : ∀ j, j < table.size → checkRow b table j = true := by
    intro j hj
    simpa using checkSpan_each b table table.size 0 checked j hj
  induction k generalizing i with
  | zero =>
    have row := each i inside
    simp only [checkRow, Bool.and_eq_true] at row
    exact row.1.2
  | succ k ih =>
    have row := each i inside
    simp only [checkRow, Bool.and_eq_true] at row
    have member : k ∈ [0, 1, 2, 3] := by
      have cases : k = 0 ∨ k = 1 ∨ k = 2 ∨ k = 3 := by omega
      rcases cases with rfl | rfl | rfl | rfl <;> simp
    have eqn := of_decide_eq_true (List.all_eq_true.mp row.2 k member)
    rw [eqn]
    unfold expected searchWith
    apply any_eq_of_on_list
    intro m hm
    by_cases available : FastRuleChecker.meldAvailableB (table.unrank i) m = true
    · simp only [available, Bool.true_and]
      have ref := List.all_eq_true.mp row.1.1 m hm
      simp only [available, ↓reduceIte] at ref
      have parts := checkRef_parts b table _ ref
      rw [ih (by omega) _ parts.1]
      exact search_local_eq b k _ _ parts.2
    · have no : FastRuleChecker.meldAvailableB (table.unrank i) m = false :=
        Bool.eq_false_iff.2 available
      simp only [no, Bool.false_and]

/-- Exact local counts are checked before a lookup is allowed to affect rules.
    A miss evaluates the original search; it cannot hide a legal move. -/
def lookup (b : Nat) (table : Candidate) (s : State) (k : Nat) : Bool :=
  if k ≤ 4 && checkRef b table s then table.value (table.rank s) k
  else searchWith (localMelds b) k s

theorem lookup_eq (b : Nat) (table : Candidate) (checked : check b table = true)
    (s : State) (k : Nat) : lookup b table s k = searchWith (localMelds b) k s := by
  unfold lookup
  split
  next h =>
    simp only [Bool.and_eq_true, decide_eq_true_eq] at h
    have parts := checkRef_parts b table s h.2
    rw [check_sound b table checked k h.1 _ parts.1]
    exact search_local_eq b k _ _ parts.2
  next => rfl

end Mahjong.LocalCache

#print axioms Mahjong.LocalCache.checkSpan_add
#print axioms Mahjong.LocalCache.check_sound
#print axioms Mahjong.LocalCache.lookup_eq
