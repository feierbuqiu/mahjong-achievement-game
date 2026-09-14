import Mahjong.CachedSuccessorList

set_option autoImplicit false

namespace Mahjong.RetrogradeEvaluation
open SafeGame
universe u
variable {α : Type u}

def outcome (isP : Bool) : Outcome := if isP then .P else .N

/-- True means the parent is P. Finding one P child stops immediately. -/
def scan (isP : α → Bool) : List α → Bool
  | [] => true
  | t :: rest => if isP t then false else scan isP rest

theorem scan_true_iff (isP : α → Bool) (xs : List α) :
    scan isP xs = true ↔ ∀ t, t ∈ xs → isP t = false := by
  induction xs with
  | nil => simp [scan]
  | cons t xs ih => cases h : isP t <;> simp_all [scan]

theorem scan_false_iff (isP : α → Bool) (xs : List α) :
    scan isP xs = false ↔ ∃ t, t ∈ xs ∧ isP t = true := by
  induction xs with
  | nil => simp [scan]
  | cons t xs ih => cases h : isP t <;> simp_all [scan]

theorem scan_append (isP : α → Bool) (xs ys : List α) :
    scan isP (xs++ys) = if scan isP xs then scan isP ys else false := by
  induction xs with
  | nil => rfl
  | cons t xs ih => cases h : isP t <;> simp [scan,h,ih]

def countP (isP : α → Bool) : List α → Nat
  | [] => 0
  | t :: rest => (if isP t then 1 else 0)+countP isP rest

theorem countP_zero_iff (isP : α → Bool) (xs : List α) :
    countP isP xs = 0 ↔ ∀ t, t ∈ xs → isP t = false := by
  induction xs with
  | nil => simp [countP]
  | cons t xs ih => cases h : isP t <;> simp_all [countP]

theorem countP_bound (isP : α → Bool) (xs : List α) : countP isP xs ≤ xs.length := by
  induction xs with
  | nil => simp [countP]
  | cons t xs ih => cases h : isP t <;> simp [countP,h] <;> omega

theorem countP_full_iff (isP : α → Bool) (xs : List α) :
    countP isP xs = xs.length ↔ ∀ t, t ∈ xs → isP t = true := by
  induction xs with
  | nil => simp [countP]
  | cons t xs ih =>
    have bound := countP_bound isP xs
    cases h : isP t
    · simp [countP,h]
      omega
    · simp [countP,h]
      rw [← ih]
      omega

structure Bucket (α : Type u) where
  rows : List α
  candidates : List α
  reportedP : Nat

def ValidBucket (isP : α → Bool) (b : Bucket α) : Prop :=
  b.reportedP = countP isP b.rows ∧ ∀ t, t ∈ b.candidates → t ∈ b.rows

theorem zero_bucket (isP : α → Bool) (b : Bucket α) (valid : ValidBucket isP b)
    (zero : b.reportedP = 0) : scan isP b.candidates = true := by
  apply (scan_true_iff isP b.candidates).mpr
  intro t ht
  exact (countP_zero_iff isP b.rows).mp (valid.1.symm.trans zero) t (valid.2 t ht)

theorem all_p_bucket (isP : α → Bool) (b : Bucket α) (valid : ValidBucket isP b)
    (full : b.reportedP = b.rows.length) (t : α) (ht : t ∈ b.rows) : isP t = true :=
  (countP_full_iff isP b.rows).mp (valid.1.symm.trans full) t ht

def scanBuckets (isP : α → Bool) : List (Bucket α) → Bool
  | [] => true
  | b :: rest => if b.reportedP = 0 then scanBuckets isP rest
    else if scan isP b.candidates then scanBuckets isP rest else false

def optimized (isP : α → Bool) (bs : List (Bucket α)) : Bool :=
  if bs.all (fun b => decide (b.reportedP = 0)) then true else scanBuckets isP bs

theorem scan_buckets_correct (isP : α → Bool) (bs : List (Bucket α))
    (valid : ∀ b, b ∈ bs → ValidBucket isP b) :
    scanBuckets isP bs = scan isP (bs.flatMap Bucket.candidates) := by
  induction bs with
  | nil => rfl
  | cons b bs ih =>
    have vb := valid b (by simp)
    have rest := ih (fun t ht => valid t (by simp [ht]))
    simp only [scanBuckets,List.flatMap_cons,scan_append]
    by_cases hz : b.reportedP = 0
    · rw [if_pos hz,zero_bucket isP b vb hz]
      exact rest
    · rw [if_neg hz,rest]

theorem whole_bucket_p (isP : α → Bool) (bs : List (Bucket α))
    (valid : ∀ b, b ∈ bs → ValidBucket isP b)
    (zero : bs.all (fun b => decide (b.reportedP = 0)) = true) :
    scan isP (bs.flatMap Bucket.candidates) = true := by
  apply (scan_true_iff isP _).mpr
  intro t ht
  obtain ⟨b,hb,hm⟩ := List.mem_flatMap.mp ht
  have z : b.reportedP = 0 := of_decide_eq_true (List.all_eq_true.mp zero b hb)
  exact (scan_true_iff isP _).mp (zero_bucket isP b (valid b hb) z) t hm

theorem optimized_correct (isP : α → Bool) (bs : List (Bucket α))
    (valid : ∀ b, b ∈ bs → ValidBucket isP b) :
    optimized isP bs = scan isP (bs.flatMap Bucket.candidates) := by
  unfold optimized
  split
  · exact (whole_bucket_p isP bs valid ‹_›).symm
  · exact scan_buckets_correct isP bs valid

theorem scan_same_members (isP : α → Bool) (xs ys : List α)
    (same : ∀ t, t ∈ xs ↔ t ∈ ys) : scan isP xs = scan isP ys := by
  cases hx : scan isP xs <;> cases hy : scan isP ys <;> try rfl
  · obtain ⟨t,ht,hp⟩ := (scan_false_iff isP xs).mp hx
    have no := (scan_true_iff isP ys).mp hy t ((same t).mp ht)
    simp [hp] at no
  · obtain ⟨t,ht,hp⟩ := (scan_false_iff isP ys).mp hy
    have no := (scan_true_iff isP xs).mp hx t ((same t).mpr ht)
    simp [hp] at no

theorem step_sound (move : α → α → Prop) (s : α) (succ : List α) (isP : α → Bool)
    (exactSucc : ∀ t, move s t ↔ t ∈ succ)
    (children : ∀ t, t ∈ succ → NormalStrategy move t (outcome (isP t))) :
    NormalStrategy move s (outcome (scan isP succ)) := by
  cases result : scan isP succ with
  | true =>
    apply NormalStrategy.p
    intro t edge
    have mem := (exactSucc t).mp edge
    have no := (scan_true_iff isP succ).mp result t mem
    simpa [outcome,no] using children t mem
  | false =>
    obtain ⟨t,mem,yes⟩ := (scan_false_iff isP succ).mp result
    apply NormalStrategy.n ((exactSucc t).mpr mem)
    simpa [outcome,yes] using children t mem

def evaluate (succ : α → List α) : Nat → α → Bool
  | 0, _ => false
  | fuel+1, s => scan (evaluate succ fuel) (succ s)

/-- Correctness of the computation itself by decreasing rank, with no
assumption that an external table already satisfies the recurrence. -/
theorem evaluate_sound (move : α → α → Prop) (succ : α → List α) (rank : α → Nat)
    (exactSucc : ∀ s t, move s t ↔ t ∈ succ s)
    (decreases : ∀ s t, move s t → rank t < rank s) (fuel : Nat) (s : α) (enough : rank s < fuel) :
    NormalStrategy move s (outcome (evaluate succ fuel s)) := by
  induction fuel generalizing s with
  | zero => omega
  | succ fuel ih =>
    apply step_sound move s (succ s) (evaluate succ fuel) (exactSucc s)
    intro t ht
    exact ih t (by have lt := decreases s t ((exactSucc s t).mpr ht); omega)

/-- The row computation is attached to the concrete, complete cached graph.
Child strategy proofs are supplied by the preceding layer in an induction. -/
theorem cached_step_sound (c : GlobalEnumeration.Certificate) (data : Nat → SuccessorCache.Data)
    (checked : GlobalSuccessorBridge.Checked c data) (s : SafePosition)
    (kept : GlobalSuccessorBridge.Retained c s.val) (isP : PackedRules.Packed → Bool)
    (children : ∀ q, q ∈ CachedSuccessorList.successors c data s.val →
      NormalStrategy (CachedTransitionQuotient.Move c data) q (outcome (isP q))) :
    NormalStrategy RestrictedSafeMove s (outcome (scan isP (CachedSuccessorList.successors c data s.val))) := by
  apply (CachedTransitionQuotient.strategy_iff c data checked s _).mpr
  exact step_sound _ _ _ isP (fun q => (CachedSuccessorList.exact_moves c data checked s kept q).symm) children

end Mahjong.RetrogradeEvaluation

#print axioms Mahjong.RetrogradeEvaluation.scan_true_iff
#print axioms Mahjong.RetrogradeEvaluation.scan_false_iff
#print axioms Mahjong.RetrogradeEvaluation.scan_append
#print axioms Mahjong.RetrogradeEvaluation.countP_zero_iff
#print axioms Mahjong.RetrogradeEvaluation.countP_full_iff
#print axioms Mahjong.RetrogradeEvaluation.zero_bucket
#print axioms Mahjong.RetrogradeEvaluation.all_p_bucket
#print axioms Mahjong.RetrogradeEvaluation.scan_buckets_correct
#print axioms Mahjong.RetrogradeEvaluation.whole_bucket_p
#print axioms Mahjong.RetrogradeEvaluation.optimized_correct
#print axioms Mahjong.RetrogradeEvaluation.scan_same_members
#print axioms Mahjong.RetrogradeEvaluation.step_sound
#print axioms Mahjong.RetrogradeEvaluation.evaluate_sound
#print axioms Mahjong.RetrogradeEvaluation.cached_step_sound
