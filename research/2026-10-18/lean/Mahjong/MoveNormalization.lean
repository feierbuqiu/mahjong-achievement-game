import Mahjong.GlobalOrbitKey
import Mahjong.SuccessorCache

set_option autoImplicit false

namespace Mahjong.MoveNormalization
open PackedRules SuitSorting GlobalOrbitKey

def replace (p : Packed) (b : Fin 3) (target : Nat) : Packed :=
  ⟨if b.val = 0 then target else p.a,if b.val = 1 then target else p.b,
   if b.val = 2 then target else p.c,p.h⟩

/-- The actual conditional 01 then 12 comparisons after increasing one ID. -/
def fast (p : Packed) (b : Fin 3) (target : Nat) : Packed :=
  let q := replace p b target
  let q := if b.val = 0 then compareSwap id 0 1 q else q
  if b.val < 2 then compareSwap id 1 2 q else q

theorem compare_signature (key : Nat → Nat) (a b : Fin 3) (p : Packed) :
    signature (compareSwap key a b p) = signature p := by
  unfold compareSwap
  split
  · exact signature_swap p a b
  · rfl

theorem sort_signature (p : Packed) : signature (sort id p) = signature p := by
  simp only [sort,compare_signature]

theorem fast_signature (p : Packed) (b : Fin 3) (target : Nat) :
    signature (fast p b target) = signature (replace p b target) := by
  unfold fast
  split <;> simp only [compare_signature]
  all_goals split <;> simp only [compare_signature]

theorem fast_zero (p : Packed) (target : Nat) :
    fast p 0 target = compareSwap id 1 2 (compareSwap id 0 1 ⟨target,p.b,p.c,p.h⟩) := rfl

theorem fast_one (p : Packed) (target : Nat) :
    fast p 1 target = compareSwap id 1 2 ⟨p.a,target,p.c,p.h⟩ := rfl

theorem fast_sorted (p : Packed) (b : Fin 3) (target : Nat)
    (ab : p.a ≤ p.b) (bc : p.b ≤ p.c) (increases : p.get b.val ≤ target) :
    (fast p b target).a ≤ (fast p b target).b ∧ (fast p b target).b ≤ (fast p b target).c := by
  rcases fin_three b with rfl | rfl | rfl
  · change p.a ≤ target at increases
    rw [fast_zero]
    simp only [compare01,compare12,id_eq]
    split <;> dsimp only at *
    all_goals split <;> dsimp only at * <;> omega
  · change p.b ≤ target at increases
    rw [fast_one]
    simp only [compare12,id_eq]
    split <;> dsimp only at * <;> omega
  · change p.c ≤ target at increases
    exact ⟨ab,Nat.le_trans bc increases⟩

theorem fast_eq_sort (p : Packed) (b : Fin 3) (target : Nat)
    (ab : p.a ≤ p.b) (bc : p.b ≤ p.c) (increases : p.get b.val ≤ target) :
    fast p b target = sort id (replace p b target) := by
  have f := fast_sorted p b target ab bc increases
  have s := sorted_order id (replace p b target)
  exact signature_sorted_injective _ _ f.1 f.2 s.1 s.2
    ((fast_signature p b target).trans (sort_signature _).symm)

theorem cached_fast_eq_sort (b : Fin 3) (t : CanonicalInventory.Candidate)
    (s : LocalSummary.Candidate) (d : SuccessorCache.Data) (p : Packed) (target : Nat)
    (row : SuccessorCache.checkRow b.val t s d (p.get b.val) = true)
    (member : target ∈ d.next (p.get b.val)) (ab : p.a ≤ p.b) (bc : p.b ≤ p.c) :
    fast p b target = sort id (replace p b target) :=
  fast_eq_sort p b target ab bc (Nat.le_of_lt ((SuccessorCache.row_facts _ _ _ _ _ row).bounds target member).2)

theorem replace_swap (p : Packed) (a b : Fin 3) (target : Nat)
    (same : p.get a.val = p.get b.val) : swapped a b (replace p a target) = replace p b target := by
  rcases fin_three a with rfl | rfl | rfl <;> rcases fin_three b with rfl | rfl | rfl <;>
    simp_all [replace,swapped,transposeBlock,Packed.get]

theorem equal_source_signature (p : Packed) (a b : Fin 3) (target : Nat)
    (same : p.get a.val = p.get b.val) :
    signature (replace p a target) = signature (replace p b target) := by
  rw [← replace_swap p a b target same,signature_swap]

def keep (p : Packed) (b : Fin 3) : Prop := b.val = 0 ∨ p.get b.val ≠ p.get (b.val-1)
instance (p : Packed) (b : Fin 3) : Decidable (keep p b) := inferInstanceAs (Decidable (_ ∨ _))

def representative (p : Packed) (b : Fin 3) : Fin 3 :=
  if b.val = 0 then 0 else if b.val = 1 then (if p.a = p.b then 0 else 1)
  else if p.b = p.c then (if p.a = p.b then 0 else 1) else 2

theorem representative_kept (p : Packed) (b : Fin 3) : keep p (representative p b) := by
  rcases fin_three b with rfl | rfl | rfl <;>
    by_cases ab : p.a = p.b <;> by_cases bc : p.b = p.c <;>
    simp_all [representative,keep,Packed.get] <;> omega

theorem representative_same (p : Packed) (b : Fin 3) :
    p.get (representative p b).val = p.get b.val := by
  rcases fin_three b with rfl | rfl | rfl <;>
    by_cases ab : p.a = p.b <;> by_cases bc : p.b = p.c <;>
    simp_all [representative,Packed.get]

def suits : List (Fin 3) := [0,1,2]

theorem mem_suits (b : Fin 3) : b ∈ suits := by
  simpa [suits] using fin_three b

def full (next : Nat → List Nat) (p : Packed) : List Packed :=
  suits.flatMap fun b => (next (p.get b.val)).map fun j => signature (replace p b j)

def optimized (next : Nat → List Nat) (p : Packed) : List Packed :=
  (suits.filter (fun b => decide (keep p b))).flatMap fun b =>
    (next (p.get b.val)).map fun j => signature (fast p b j)

/-- Skipping each repeated adjacent source suit and using two comparisons
preserves every successor orbit, independently of future P/N labels. -/
theorem optimized_mem_iff (next : Nat → List Nat) (p q : Packed) :
    q ∈ optimized next p ↔ q ∈ full next p := by
  simp only [optimized,full,List.mem_flatMap,List.mem_filter,List.mem_map,decide_eq_true_eq]
  constructor
  · rintro ⟨b,⟨hb,_⟩,j,hj,eq⟩
    exact ⟨b,hb,j,hj,(fast_signature p b j).symm.trans eq⟩
  · rintro ⟨b,_,j,hj,eq⟩
    let a := representative p b
    have same := representative_same p b
    refine ⟨a,⟨mem_suits a,representative_kept p b⟩,j,?_,?_⟩
    · change j ∈ next (p.get (representative p b).val)
      rwa [same]
    · exact (fast_signature p a j).trans ((equal_source_signature p a b j same).trans eq)

end Mahjong.MoveNormalization

#print axioms Mahjong.MoveNormalization.compare_signature
#print axioms Mahjong.MoveNormalization.sort_signature
#print axioms Mahjong.MoveNormalization.fast_signature
#print axioms Mahjong.MoveNormalization.fast_sorted
#print axioms Mahjong.MoveNormalization.fast_eq_sort
#print axioms Mahjong.MoveNormalization.cached_fast_eq_sort
#print axioms Mahjong.MoveNormalization.replace_swap
#print axioms Mahjong.MoveNormalization.equal_source_signature
#print axioms Mahjong.MoveNormalization.representative_kept
#print axioms Mahjong.MoveNormalization.representative_same
#print axioms Mahjong.MoveNormalization.optimized_mem_iff
