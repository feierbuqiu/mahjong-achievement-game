import Std

set_option autoImplicit false

namespace Mahjong.RowScheduleV13

private theorem andParts {a b : Bool} (h : (a && b) = true) : a = true ∧ b = true := by
  simpa only [Bool.and_eq_true] using h

structure Chunk where
  first : Nat
  count : Nat
  deriving DecidableEq, Repr

def fallback : Chunk := ⟨0,0⟩
def get (chunks : List Chunk) (k : Nat) : Chunk := chunks.getD k fallback

/-- A checked chain of adjacent half-open intervals. Zero-width chunks are
permitted; no interval can move backwards or overlap a preceding interval. -/
def checkCover : List Chunk → Nat → Nat → Bool
  | [], cursor, stop => decide (cursor = stop)
  | c::cs, cursor, stop => decide (c.first = cursor) && checkCover cs (c.first+c.count) stop

/-- The order here is round-major, so equality with range checks BOTH complete
worker assignment and the absence of duplicated chunk indices. Actual tasks
traverse the same pairs worker-major; the order does not change membership. -/
def assignments (threads rounds : Nat) : List Nat :=
  (List.range rounds).flatMap fun r => (List.range threads).map fun w => w+r*threads

def checkSchedule (chunks : List Chunk) (start count threads rounds : Nat) : Bool :=
  decide (0 < threads ∧ (rounds = 1 ∨ rounds = 4 ∨ rounds = 8) ∧
    chunks.length = threads*rounds ∧ assignments threads rounds = List.range chunks.length) &&
    checkCover chunks start (start+count)

theorem checkCover_covers (chunks : List Chunk) (cursor stop i : Nat)
    (accepted : checkCover chunks cursor stop = true)
    (lower : cursor ≤ i) (upper : i < stop) :
    ∃ k, k < chunks.length ∧ (get chunks k).first ≤ i ∧
      i < (get chunks k).first+(get chunks k).count := by
  induction chunks generalizing cursor with
  | nil =>
    have equal : cursor = stop := of_decide_eq_true accepted
    omega
  | cons c cs ih =>
    have parts := andParts accepted
    have first : c.first = cursor := of_decide_eq_true parts.1
    by_cases inside : i < c.first+c.count
    · refine ⟨0, by simp, ?_, ?_⟩
      · simpa [get,first] using lower
      · simpa [get] using inside
    · have nextLower : c.first+c.count ≤ i := by omega
      obtain ⟨k,hk,lo,hi⟩ := ih (c.first+c.count) parts.2 nextLower
      refine ⟨k+1, by simpa using Nat.succ_lt_succ hk, ?_, ?_⟩
      · simpa [get] using lo
      · simpa [get] using hi

theorem checkCover_total (chunks : List Chunk) (cursor stop : Nat)
    (accepted : checkCover chunks cursor stop = true) :
    stop = cursor+(chunks.map Chunk.count).sum := by
  induction chunks generalizing cursor with
  | nil =>
    have equal : cursor = stop := of_decide_eq_true accepted
    simpa using equal.symm
  | cons c cs ih =>
    have parts := andParts accepted
    have first : c.first = cursor := of_decide_eq_true parts.1
    have rest := ih (c.first+c.count) parts.2
    simp only [List.map_cons,List.sum_cons]
    omega

theorem checked_assignment (chunks : List Chunk) (start count threads rounds k : Nat)
    (accepted : checkSchedule chunks start count threads rounds = true)
    (bound : k < chunks.length) :
    ∃ w, w < threads ∧ ∃ r, r < rounds ∧ w+r*threads = k := by
  have parts := andParts accepted
  have h := of_decide_eq_true parts.1
  have member : k ∈ assignments threads rounds := by
    rw [h.2.2.2]
    exact List.mem_range.mpr bound
  obtain ⟨r,hr,hm⟩ := List.mem_flatMap.mp member
  obtain ⟨w,hw,equal⟩ := List.mem_map.mp hm
  exact ⟨w,List.mem_range.mp hw,r,List.mem_range.mp hr,equal⟩

theorem checked_assignment_unique (chunks : List Chunk) (start count threads rounds : Nat)
    (accepted : checkSchedule chunks start count threads rounds = true) :
    (assignments threads rounds).Nodup := by
  have h := of_decide_eq_true (andParts accepted).1
  rw [h.2.2.2]
  exact List.nodup_range

/-- If every scheduled worker/round checks every row of its chunk, the checked
partition covers every row of the requested source interval. P can stand for
the unchanged actual source-r/P-all/N-member Lean checker. -/
theorem scheduled_all_rows (chunks : List Chunk) (start count threads rounds : Nat)
    (P : Nat → Prop) (accepted : checkSchedule chunks start count threads rounds = true)
    (workers : ∀ w, w < threads → ∀ r, r < rounds →
      ∀ i, (get chunks (w+r*threads)).first ≤ i →
        i < (get chunks (w+r*threads)).first+(get chunks (w+r*threads)).count → P i) :
    ∀ i, start ≤ i → i < start+count → P i := by
  intro i lo hi
  obtain ⟨k,hk,klo,khi⟩ := checkCover_covers chunks start (start+count) i
    (andParts accepted).2 lo hi
  obtain ⟨w,hw,r,hr,equal⟩ := checked_assignment chunks start count threads rounds k accepted hk
  apply workers w hw r hr i
  · simpa [equal] using klo
  · simpa [equal] using khi

theorem checked_total_rows (chunks : List Chunk) (start count threads rounds : Nat)
    (accepted : checkSchedule chunks start count threads rounds = true) :
    (chunks.map Chunk.count).sum = count := by
  have h := checkCover_total chunks start (start+count) (andParts accepted).2
  omega

#print axioms checkCover_covers
#print axioms checkCover_total
#print axioms checked_assignment
#print axioms checked_assignment_unique
#print axioms scheduled_all_rows
#print axioms checked_total_rows

end Mahjong.RowScheduleV13
