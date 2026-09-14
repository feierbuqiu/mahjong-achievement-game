import Mahjong.CanonicalCoverage

set_option autoImplicit false

namespace Mahjong.SuccessorCache
open CanonicalInventory PairProfile

structure Data where
  source : Nat → Nat
  arity : Nat → Nat
  next : Nat → List Nat

def capacity (b : Nat) : Nat := if b = 3 then 4 else 9

/-- Expected retained successors, obtained from the already certified raw
addition table and canonical inventory. Duplicates here are intentional. -/
def expected (b : Nat) (t : CanonicalInventory.Candidate) (s : LocalSummary.Candidate) (i : Nat) : List Nat :=
  ((blockTiles b).map (fun u => if s.available (t.member i) u then
    t.id (t.canonical (s.next (t.member i) u)) else t.count)).filter (fun j => decide (j < t.count))

theorem expected_mem (b : Nat) (t : CanonicalInventory.Candidate) (s : LocalSummary.Candidate) (i j : Nat) :
    j ∈ expected b t s i ↔ ∃ u : Tile, u.val/9 = b ∧ s.available (t.member i) u = true ∧
      t.id (t.canonical (s.next (t.member i) u)) = j ∧ j < t.count := by
  simp only [expected,List.mem_filter,List.mem_map,decide_eq_true_eq]
  constructor
  · rintro ⟨⟨u,block,eq⟩,bound⟩
    by_cases avail : s.available (t.member i) u = true
    · rw [if_pos avail] at eq
      exact ⟨u,(mem_blockTiles b u).mp block,avail,eq,bound⟩
    · rw [if_neg avail] at eq
      omega
  · rintro ⟨u,block,avail,eq,bound⟩
    exact ⟨⟨u,(mem_blockTiles b u).mpr block,by rw [if_pos avail]; exact eq⟩,bound⟩

def checkRow (b : Nat) (t : CanonicalInventory.Candidate) (s : LocalSummary.Candidate) (d : Data) (i : Nat) : Bool :=
  decide (d.source i = t.member i) && decide (d.arity i ≤ capacity b) &&
  decide ((d.next i).length = d.arity i) &&
  (d.next i).all (fun j => decide (j < t.count ∧ i < j)) &&
  decide ((d.next i).Pairwise (fun j k => j < k)) &&
  (d.next i).all (fun j => decide (j ∈ expected b t s i)) &&
  (expected b t s i).all (fun j => decide (j ∈ d.next i))

structure RowFacts (b : Nat) (t : CanonicalInventory.Candidate) (s : LocalSummary.Candidate) (d : Data) (i : Nat) : Prop where
  source : d.source i = t.member i
  capacity : d.arity i ≤ SuccessorCache.capacity b
  length : (d.next i).length = d.arity i
  bounds : ∀ j, j ∈ d.next i → j < t.count ∧ i < j
  order : (d.next i).Pairwise (fun j k => j < k)
  sound : ∀ j, j ∈ d.next i → j ∈ expected b t s i
  complete : ∀ j, j ∈ expected b t s i → j ∈ d.next i

theorem row_facts (b : Nat) (t : CanonicalInventory.Candidate) (s : LocalSummary.Candidate) (d : Data) (i : Nat)
    (pass : checkRow b t s d i = true) : RowFacts b t s d i := by
  simp only [checkRow,Bool.and_eq_true,decide_eq_true_eq] at pass
  obtain ⟨⟨⟨⟨⟨⟨source,cap⟩,len⟩,bounds⟩,order⟩,sound⟩,complete⟩ := pass
  refine ⟨source,cap,len,?_,order,?_,?_⟩
  · intro j hj
    exact of_decide_eq_true (List.all_eq_true.mp bounds j hj)
  · intro j hj
    exact of_decide_eq_true (List.all_eq_true.mp sound j hj)
  · intro j hj
    exact of_decide_eq_true (List.all_eq_true.mp complete j hj)

theorem row_edge_iff (b : Nat) (t : CanonicalInventory.Candidate) (s : LocalSummary.Candidate) (d : Data) (i j : Nat)
    (pass : checkRow b t s d i = true) :
    j ∈ d.next i ↔ ∃ u : Tile, u.val/9 = b ∧ s.available (t.member i) u = true ∧
      t.id (t.canonical (s.next (t.member i) u)) = j ∧ j < t.count := by
  have f := row_facts b t s d i pass
  exact (show j ∈ d.next i ↔ j ∈ expected b t s i from ⟨f.sound j,f.complete j⟩).trans (expected_mem b t s i j)

theorem checked_row (b : Nat) (t : CanonicalInventory.Candidate) (s : LocalSummary.Candidate) (d : Data)
    (pass : checkSpan (checkRow b t s d) 0 t.count = true) (i : Nat) (inside : i < t.count) :
    checkRow b t s d i = true := by
  simpa only [Nat.zero_add] using checkSpan_each _ t.count 0 pass i inside

def rowBytes (b : Nat) : Nat := 8+4*capacity b

/-- Fixed-size row: source code, raw arity, then capacity many uint32 IDs.
The min limits allocations even on corrupt arity bytes; checkRow rejects it. -/
def candidate (b : Nat) (bytes : ByteArray) : Data where
  source := fun i => read32 bytes (rowBytes b*i)
  arity := fun i => read32 bytes (rowBytes b*i+4)
  next := fun i => (List.range (min (read32 bytes (rowBytes b*i+4)) (capacity b))).map
    (fun k => read32 bytes (rowBytes b*i+8+4*k))

theorem candidate_allocation_bound (b : Nat) (bytes : ByteArray) (i : Nat) :
    ((candidate b bytes).next i).length ≤ capacity b := by
  simp only [candidate,List.length_map,List.length_range]
  exact Nat.min_le_right _ _

/-- Numeric checks are identical in all three suits for shared input files.
This transports an actual full numeric check, not a sampled comparison. -/
theorem numeric_row_shared (b : Nat) (hb : b < 3) (core summary raw ids members edges : ByteArray) (i : Nat) :
    checkRow b (CanonicalInventory.candidate b raw ids members) (SummaryEncoding.candidate b core summary)
      (candidate b edges) i =
    checkRow 0 (CanonicalInventory.candidate 0 raw ids members) (SummaryEncoding.candidate 0 core summary)
      (candidate 0 edges) i := by
  have options : b = 0 ∨ b = 1 ∨ b = 2 := by omega
  rcases options with rfl | rfl | rfl <;> rfl

theorem numeric_span_shared (b : Nat) (hb : b < 3) (core summary raw ids members edges : ByteArray) (start count : Nat) :
    checkSpan (checkRow b (CanonicalInventory.candidate b raw ids members) (SummaryEncoding.candidate b core summary)
      (candidate b edges)) start count =
    checkSpan (checkRow 0 (CanonicalInventory.candidate 0 raw ids members) (SummaryEncoding.candidate 0 core summary)
      (candidate 0 edges)) start count := by
  have equal : checkRow b (CanonicalInventory.candidate b raw ids members) (SummaryEncoding.candidate b core summary)
      (candidate b edges) =
    checkRow 0 (CanonicalInventory.candidate 0 raw ids members) (SummaryEncoding.candidate 0 core summary)
      (candidate 0 edges) := funext (numeric_row_shared b hb core summary raw ids members edges)
  rw [equal]

end Mahjong.SuccessorCache

#print axioms Mahjong.SuccessorCache.expected_mem
#print axioms Mahjong.SuccessorCache.row_facts
#print axioms Mahjong.SuccessorCache.row_edge_iff
#print axioms Mahjong.SuccessorCache.checked_row
#print axioms Mahjong.SuccessorCache.candidate_allocation_bound
#print axioms Mahjong.SuccessorCache.numeric_row_shared
#print axioms Mahjong.SuccessorCache.numeric_span_shared
