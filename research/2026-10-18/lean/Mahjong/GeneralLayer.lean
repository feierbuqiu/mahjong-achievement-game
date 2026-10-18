import Mahjong.PreloadedRules
import Mahjong.Generators
import Mahjong.Bridge
import Mahjong.PackedInterpretation

set_option autoImplicit false

namespace Mahjong.GeneralLayer
open PackedRules SafeGame Generators

def childB (tables : Tables) (s : Packed) (u : Tile) : Bool :=
  available tables s u && PreloadedRules.safeB tables (add tables s u)

theorem childB_sound (tables : Tables) (cache : Checked tables) (s : Packed)
    (valid : inside tables s = true) (u : Tile) (h : childB tables s u = true) :
    SafeMove (state tables s) (state tables (add tables s u)) := by
  simp only [childB, Bool.and_eq_true] at h
  have nv := add_inside tables cache s valid u h.1
  have same := add_state tables cache s valid u h.1
  refine ⟨⟨u, ⟨state_valid tables cache s valid, ?_⟩, same⟩, ?_⟩
  · exact of_decide_eq_true ((available_eq tables cache s valid u).symm.trans h.1)
  · apply (FastRuleChecker.safeB_iff _ (state_valid tables cache _ nv)).mp
    rw [← PackedRules.safeB_eq tables cache _ nv, ← PreloadedRules.safeB_eq]
    exact h.2

def children (tables : Tables) (s : Packed) : List Packed :=
  (allTiles.filter (childB tables s)).map (add tables s)

theorem children_sound (tables : Tables) (cache : Checked tables) (s : Packed)
    (valid : inside tables s = true) (q : Packed) (h : q ∈ children tables s) :
    SafeMove (state tables s) (state tables q) := by
  simp only [children, List.mem_map, List.mem_filter] at h
  obtain ⟨u, ⟨_, good⟩, rfl⟩ := h
  exact childB_sound tables cache s valid u good

theorem children_complete (tables : Tables) (cache : Checked tables) (s : Packed)
    (valid : inside tables s = true) (t : State) (edge : SafeMove (state tables s) t) :
    ∃ q, q ∈ children tables s ∧ state tables q = t := by
  obtain ⟨⟨u, legal, rfl⟩, safe⟩ := edge
  have av : available tables s u = true := by
    rw [available_eq tables cache s valid u]
    exact decide_eq_true legal.2
  have nv := add_inside tables cache s valid u av
  have same := add_state tables cache s valid u av
  refine ⟨add tables s u, ?_, same⟩
  simp only [children, List.mem_map, List.mem_filter]
  refine ⟨u, ⟨mem_allTiles u, ?_⟩, rfl⟩
  simp only [childB, av, Bool.true_and, PreloadedRules.safeB_eq,
    PackedRules.safeB_eq tables cache _ nv, same]
  exact (FastRuleChecker.safeB_iff _ (valid_add legal.1 legal.2)).mpr safe

structure Reference where
  bucket : Nat
  index : Nat
  canonical : Packed
  restore : List Generator

structure Target where
  size : Nat → Nat
  unrank : Nat → Nat → Packed
  labelP : Nat → Nat → Bool
  locate : Packed → Reference

def outcome (isP : Bool) : Outcome := if isP then .P else .N

def checkRef (tables : Tables) (target : Target) (e : Packed × Reference) : Bool :=
  let r := e.2
  decide (r.index < target.size r.bucket) &&
    decide (target.unrank r.bucket r.index = r.canonical) &&
    checkReference r.restore (PackedInterpretation.cachedState tables r.canonical)
      (PackedInterpretation.cachedState tables e.1)

def entryP (target : Target) (e : Packed × Reference) : Bool := target.labelP e.2.bucket e.2.index

def entries (tables : Tables) (target : Target) (s : Packed) : List (Packed × Reference) :=
  (children tables s).map (fun q => (q, target.locate q))

def row (tables : Tables) (target : Target) (s : Packed) (isP : Bool) : Bool :=
  let es := entries tables target s
  inside tables s && PreloadedRules.safeB tables s && es.all (checkRef tables target) &&
    if isP then es.all (fun e => !entryP target e) else es.any (entryP target)

/-- This premise is supplied by already checked higher layers, never by C++ labels alone. -/
def TargetCorrect (tables : Tables) (target : Target) : Prop :=
  ∀ b i, i < target.size b → NormalStrategy SafeMove (state tables (target.unrank b i))
    (outcome (target.labelP b i))

theorem ref_sound (tables : Tables) (target : Target) (correct : TargetCorrect tables target)
    (e : Packed × Reference) (accepted : checkRef tables target e = true) :
    NormalStrategy SafeMove (state tables e.1) (outcome (entryP target e)) := by
  simp only [checkRef, Bool.and_eq_true, decide_eq_true_eq] at accepted
  simp only [PackedInterpretation.cachedState_eq] at accepted
  have h := correct e.2.bucket e.2.index accepted.1.1
  rw [accepted.1.2] at h
  exact checked_reference_sound e.2.restore accepted.2 h

theorem row_sound (tables : Tables) (cache : Checked tables) (target : Target)
    (correct : TargetCorrect tables target) (s : Packed) (isP : Bool)
    (accepted : row tables target s isP = true) :
    IsSafe (state tables s) ∧ NormalStrategy SafeMove (state tables s) (outcome isP) := by
  simp only [row, Bool.and_eq_true] at accepted
  have valid := accepted.1.1.1
  have safe : IsSafe (state tables s) := by
    apply (FastRuleChecker.safeB_iff _ (state_valid tables cache s valid)).mp
    rw [← PackedRules.safeB_eq tables cache s valid, ← PreloadedRules.safeB_eq]
    exact accepted.1.1.2
  have next (q : Packed) (mem : q ∈ children tables s) :
      NormalStrategy SafeMove (state tables q)
        (outcome (target.labelP (target.locate q).bucket (target.locate q).index)) := by
    apply ref_sound tables target correct (q, target.locate q)
    exact List.all_eq_true.mp accepted.1.2 _ (List.mem_map.mpr ⟨q, mem, rfl⟩)
  refine ⟨safe, ?_⟩
  cases isP with
  | true =>
    apply NormalStrategy.p
    intro t edge
    obtain ⟨q, mem, rfl⟩ := children_complete tables cache s valid t edge
    have entryMem : (q, target.locate q) ∈ entries tables target s := List.mem_map.mpr ⟨q, mem, rfl⟩
    have label := List.all_eq_true.mp accepted.2 _ entryMem
    simp only [Bool.not_eq_true', entryP] at label
    simpa only [outcome, label, Bool.false_eq_true, ↓reduceIte] using next q mem
  | false =>
    obtain ⟨e, mem, label⟩ := List.any_eq_true.mp accepted.2
    unfold entries at mem
    obtain ⟨q, hq, rfl⟩ := List.mem_map.mp mem
    apply NormalStrategy.n (children_sound tables cache s valid q hq)
    change target.labelP (target.locate q).bucket (target.locate q).index = true at label
    simpa only [outcome, label, ↓reduceIte] using next q hq

end Mahjong.GeneralLayer

#print axioms Mahjong.GeneralLayer.children_complete
#print axioms Mahjong.GeneralLayer.row_sound
