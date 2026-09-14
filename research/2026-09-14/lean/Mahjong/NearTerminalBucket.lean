import Mahjong.TerminalBucket
import Mahjong.PreloadedRules

set_option autoImplicit false

namespace Mahjong.NearTerminalBucket
open PackedRules SafeGame

def noChildren (tables : Tables) (s : Packed) : Bool := allTiles.all (fun u =>
  if available tables s u then !PreloadedRules.safeB tables (add tables s u) else true)

theorem noChildren_eq (tables : Tables) (s : Packed) : noChildren tables s = TerminalBucket.noChildren tables s := by
  simp only [noChildren, TerminalBucket.noChildren, PreloadedRules.safeB_eq]

def witnessB (tables : Tables) (s : Packed) (u : Tile) : Bool :=
  available tables s u && PreloadedRules.safeB tables (add tables s u) && noChildren tables (add tables s u)

def row (tables : Tables) (d : BucketIndex.Data) (bits : ByteArray) (i : Nat) : Bool :=
  let s := BucketIndex.unrank d i
  BucketIndex.roundtrip d i && inside tables s && PreloadedRules.safeB tables s &&
    if TerminalBucket.labelP bits i then noChildren tables s else allTiles.any (witnessB tables s)

theorem row_sound (tables : Tables) (checked : Checked tables) (d : BucketIndex.Data)
    (bits : ByteArray) (i : Nat) (accepted : row tables d bits i = true) :
    Safe Step Win (state tables (BucketIndex.unrank d i)) ∧
    NormalStrategy SafeMove (state tables (BucketIndex.unrank d i))
      (if TerminalBucket.labelP bits i then .P else .N) := by
  simp only [row, Bool.and_eq_true] at accepted
  let s := BucketIndex.unrank d i
  have valid : inside tables s = true := accepted.1.1.2
  have sourceSafe : Safe Step Win (state tables s) := by
    apply (FastRuleChecker.safeB_iff _ (state_valid tables checked _ valid)).mp
    rw [← PackedRules.safeB_eq tables checked _ valid, ← PreloadedRules.safeB_eq]
    exact accepted.1.2
  refine ⟨sourceSafe, ?_⟩
  by_cases hp : TerminalBucket.labelP bits i = true
  · simp only [hp, ↓reduceIte] at accepted ⊢
    exact TerminalBucket.terminal_sound tables checked s valid ((noChildren_eq tables s) ▸ accepted.2)
  · simp only [if_neg hp] at accepted ⊢
    obtain ⟨u, _, wit⟩ := List.any_eq_true.mp accepted.2
    simp only [witnessB, Bool.and_eq_true] at wit
    have nv := add_inside tables checked s valid u wit.1.1
    have equal := add_state tables checked s valid u wit.1.1
    have childSafe : Safe Step Win (state tables (add tables s u)) := by
      apply (FastRuleChecker.safeB_iff _ (state_valid tables checked _ nv)).mp
      rw [← PackedRules.safeB_eq tables checked _ nv, ← PreloadedRules.safeB_eq]
      exact wit.1.2
    have edge : SafeMove (state tables s) (state tables (add tables s u)) := by
      refine ⟨⟨u, ⟨state_valid tables checked _ valid, ?_⟩, equal⟩, childSafe⟩
      exact of_decide_eq_true ((available_eq tables checked s valid u).symm.trans wit.1.1)
    exact NormalStrategy.n edge (TerminalBucket.terminal_sound tables checked _ nv
      ((noChildren_eq tables _) ▸ wit.2))

def span (tables : Tables) (d : BucketIndex.Data) (bits : ByteArray) (start : Nat) : Nat → Bool
  | 0 => true
  | count+1 => row tables d bits start && span tables d bits (start+1) count

theorem span_each (tables : Tables) (d : BucketIndex.Data) (bits : ByteArray)
    (count start : Nat) (h : span tables d bits start count = true) :
    ∀ offset, offset < count → row tables d bits (start+offset) = true := by
  induction count generalizing start with
  | zero => intro offset h; omega
  | succ count ih =>
    simp only [span, Bool.and_eq_true] at h
    intro offset less
    cases offset with
    | zero => simpa using h.1
    | succ offset =>
      have x := ih (start+1) h.2 offset (by omega)
      simpa [Nat.add_assoc, Nat.add_comm, Nat.add_left_comm] using x

theorem span_add (tables : Tables) (d : BucketIndex.Data) (bits : ByteArray) (a b start : Nat) :
    span tables d bits start (a+b) = (span tables d bits start a && span tables d bits (start+a) b) := by
  induction a generalizing start with
  | zero => simp [span]
  | succ a ih =>
    simp only [Nat.succ_add, span, ih]
    simp [Nat.add_assoc, Nat.add_comm, Nat.add_left_comm, Bool.and_assoc]

end Mahjong.NearTerminalBucket

#print axioms Mahjong.NearTerminalBucket.row_sound
#print axioms Mahjong.NearTerminalBucket.span_each
#print axioms Mahjong.NearTerminalBucket.span_add
