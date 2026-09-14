import Mahjong.RetrogradeEvaluation
import Mahjong.MoveNormalization

set_option autoImplicit false

namespace Mahjong.OptimizedRowBridge
open PackedRules CachedSuccessorList GlobalEnumeration GlobalOrbitKey RetrogradeEvaluation

def contribution (c : Certificate) (data : Nat → SuccessorCache.Data) (s : State) (b : Nat) : List Packed :=
  ((((data b).next (sourceId c s b)).map (replacement c s b)).filter (safeTest c)).map (key (inventoriesOf c))

def numericPiece (c : Certificate) (data : Nat → SuccessorCache.Data) (s : State) : List Packed :=
  (contribution c data s 0 ++ contribution c data s 1) ++ contribution c data s 2

def honorPieces (c : Certificate) (data : Nat → SuccessorCache.Data) (s : State) : List (List Packed) :=
  ((data 3).next (sourceId c s 3)).map fun j =>
    let q := replacement c s 3 j
    if safeTest c q then [key (inventoriesOf c) q] else []

/-- Each honor target contributes at most one candidate; numeric targets share
the unchanged honor bucket. The production order tests honors first. -/
def pieces (c : Certificate) (data : Nat → SuccessorCache.Data) (s : State) : List (List Packed) :=
  honorPieces c data s ++ [numericPiece c data s]

theorem singleton_filter_flatten {α β : Type} (xs : List α) (p : α → Bool) (f : α → β) :
    (xs.map (fun x => if p x then [f x] else [])).flatten = (xs.filter p).map f := by
  induction xs with
  | nil => rfl
  | cons x xs ih => cases h : p x <;> simp [h,ih]

theorem honor_flatten (c : Certificate) (data : Nat → SuccessorCache.Data) (s : State) :
    (honorPieces c data s).flatten = contribution c data s 3 := by
  rw [honorPieces,singleton_filter_flatten]
  simp only [contribution,List.filter_map,List.map_map,Function.comp_def]

theorem split_successors (c : Certificate) (data : Nat → SuccessorCache.Data) (s : State) :
    successors c data s = numericPiece c data s ++ (honorPieces c data s).flatten := by
  rw [honor_flatten]
  have four : List.range 4 = [0,1,2,3] := by decide
  rw [successors,raw,four]
  simp only [List.flatMap_cons,List.flatMap_nil,List.append_nil,List.filter_append,
    List.map_append,numericPiece,contribution,List.append_assoc]

theorem pieces_cover (c : Certificate) (data : Nat → SuccessorCache.Data) (s : State) (q : Packed) :
    q ∈ (pieces c data s).flatten ↔ q ∈ successors c data s := by
  rw [split_successors]
  simp only [pieces,List.flatten_append,List.flatten_cons,List.flatten_nil,List.append_nil,List.mem_append]
  exact or_comm

theorem flatMap_eq_flatten {α β : Type} (xs : List α) (f : α → List β) :
    xs.flatMap f = (xs.map f).flatten := by
  induction xs with
  | nil => rfl
  | cons x xs ih => simp [ih]

/-- This connects the optimized bucket scan to the original game. The explicit
layout premise describes the candidate pieces, rather than postulating that
the final external table satisfies all game equations. -/
theorem optimized_cached_step (c : Certificate) (data : Nat → SuccessorCache.Data)
    (checked : GlobalSuccessorBridge.Checked c data) (s : SafePosition)
    (kept : GlobalSuccessorBridge.Retained c s.val) (isP : Packed → Bool)
    (bs : List (RetrogradeEvaluation.Bucket Packed))
    (valid : ∀ b, b ∈ bs → ValidBucket isP b)
    (layout : bs.map RetrogradeEvaluation.Bucket.candidates = pieces c data s.val)
    (children : ∀ q, q ∈ successors c data s.val →
      SafeGame.NormalStrategy (CachedTransitionQuotient.Move c data) q (outcome (isP q))) :
    SafeGame.NormalStrategy RestrictedSafeMove s (outcome (RetrogradeEvaluation.optimized isP bs)) := by
  have sets : ∀ q, q ∈ bs.flatMap RetrogradeEvaluation.Bucket.candidates ↔ q ∈ successors c data s.val := by
    intro q
    rw [flatMap_eq_flatten,layout]
    exact pieces_cover c data s.val q
  rw [RetrogradeEvaluation.optimized_correct isP bs valid,scan_same_members isP _ _ sets]
  exact cached_step_sound c data checked s kept isP children

/-- Any orbit-dependent SAFE/lookup predicate and any child labels can be
applied after the duplicate-suit reduction without changing the parent bit. -/
theorem duplicate_sort_scan (next : Nat → List Nat) (p : Packed)
    (accept isP : Packed → Bool) :
    scan isP ((MoveNormalization.optimized next p).filter accept) =
      scan isP ((MoveNormalization.full next p).filter accept) := by
  apply scan_same_members
  intro q
  simp only [List.mem_filter,MoveNormalization.optimized_mem_iff]

end Mahjong.OptimizedRowBridge

#print axioms Mahjong.OptimizedRowBridge.singleton_filter_flatten
#print axioms Mahjong.OptimizedRowBridge.honor_flatten
#print axioms Mahjong.OptimizedRowBridge.split_successors
#print axioms Mahjong.OptimizedRowBridge.pieces_cover
#print axioms Mahjong.OptimizedRowBridge.optimized_cached_step
#print axioms Mahjong.OptimizedRowBridge.duplicate_sort_scan
