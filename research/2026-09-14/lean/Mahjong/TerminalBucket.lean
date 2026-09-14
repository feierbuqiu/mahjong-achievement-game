import Mahjong.BucketIndex
import Mahjong.Bridge

set_option autoImplicit false

namespace Mahjong.TerminalBucket
open PackedRules SafeGame

def noChildren (tables : Tables) (s : Packed) : Bool := allTiles.all (fun u =>
  if available tables s u then !safeB tables (add tables s u) else true)

theorem terminal_sound (tables : Tables) (checked : Checked tables) (s : Packed)
    (valid : inside tables s = true) (terminal : noChildren tables s = true) :
    NormalStrategy SafeMove (state tables s) .P := by
  apply NormalStrategy.p
  intro t edge
  obtain ⟨⟨u, legal, same⟩, targetSafe⟩ := edge
  subst t
  have av : available tables s u = true := by
    rw [available_eq tables checked s valid u]
    exact decide_eq_true legal.2
  have nv := add_inside tables checked s valid u av
  have equal := add_state tables checked s valid u av
  have absent := List.all_eq_true.mp terminal u (mem_allTiles u)
  simp only [av, ↓reduceIte, Bool.not_eq_true', safeB_eq tables checked _ nv, equal] at absent
  have present := (FastRuleChecker.safeB_iff _ (valid_add legal.1 legal.2)).mpr targetSafe
  rw [absent] at present
  contradiction

def labelP (bits : ByteArray) (i : Nat) : Bool := decide (((bits[i/8]!).toNat / 2^(i%8)) % 2 = 1)

def row (tables : Tables) (d : BucketIndex.Data) (bits : ByteArray) (i : Nat) : Bool :=
  let s := BucketIndex.unrank d i
  labelP bits i && BucketIndex.roundtrip d i && inside tables s &&
    safeB tables s && noChildren tables s

theorem row_sound (tables : Tables) (checked : Checked tables) (d : BucketIndex.Data)
    (bits : ByteArray) (i : Nat) (accepted : row tables d bits i = true) :
    labelP bits i = true ∧
    Safe Step Win (state tables (BucketIndex.unrank d i)) ∧
    NormalStrategy SafeMove (state tables (BucketIndex.unrank d i)) .P := by
  simp only [row, Bool.and_eq_true] at accepted
  have valid := accepted.1.1.2
  refine ⟨accepted.1.1.1.1, ?_, terminal_sound tables checked _ valid accepted.2⟩
  apply (FastRuleChecker.safeB_iff _ (state_valid tables checked _ valid)).mp
  rw [← safeB_eq tables checked _ valid]
  exact accepted.1.2

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

end Mahjong.TerminalBucket

#print axioms Mahjong.TerminalBucket.row_sound
#print axioms Mahjong.TerminalBucket.span_each
#print axioms Mahjong.TerminalBucket.span_add
