import Mahjong.CrossLayerAssemblyV17
import Mahjong.EmptyRootV17

set_option autoImplicit false

/-!
This is a proof-producing pure boundary, not an interpretation of a JSON PASS.
The value returned on success carries the original achievement-game strategy.
It uses the exact source table passed to the checker, including its root bytes.

There is no theorem asserting acceptance of the actual whole table here. A
compiled execution of this function is evidence about this verified program;
publishing a closed Lean declaration still requires a checked instantiation of
its finite input and acceptance equation. No external result flag or hash is
accepted as that equation.
-/

namespace Mahjong.RuntimeBindingV17

open SafeGame PackedRules

abbrev Table (c : GlobalEnumeration.Certificate) (data : Nat → SuccessorCache.Data) :=
  CrossLayerAssemblyV17.Candidate c data

def root {c : GlobalEnumeration.Certificate} {data : Nat → SuccessorCache.Data}
    (table : Table c data) : GeneralIndex.Bucket :=
  CrossLayerAssemblyV17.sourceAt table 0 0

/-- The physical empty-root identity follows from finite checks on the actual
root decoder fields. It is not an extra equality supplied by a Python driver. -/
theorem root_binding {c : GlobalEnumeration.Certificate} {data : Nat → SuccessorCache.Data}
    (table : Table c data)
    (accepted : EmptyRootV17.checkP (root table).data (root table).bits = true) :
    CrossLayerAssemblyV17.checkRoot table 0 0 = true := by
  have parts := EmptyRootV17.checkP_parts (root table).data (root table).bits accepted
  have inside := EmptyRootV17.inside (root table).data parts.1
  have physical := EmptyRootV17.decode_empty (root table).data parts.1
  change (decide (0 < CrossLayerAssemblyV17.bucketCount ∧ 0 < (root table).data.size) &&
    Generators.stateEqB (Base5Coverage.unpack (BucketIndex.unrank (root table).data 0)) empty &&
    TerminalBucket.labelP (root table).bits 0) = true
  have same : Generators.stateEqB
      (Base5Coverage.unpack (BucketIndex.unrank (root table).data 0)) empty = true := by
    rw [physical]
    decide
  simpa only [Bool.and_eq_true, decide_eq_true_eq] using
    And.intro (And.intro (And.intro (by decide : 0 < CrossLayerAssemblyV17.bucketCount) inside) same)
      parts.2.2

/-- Full pure acceptance includes the actual P bit and actual empty decoder.
Top-layer buckets are not exempted by old version numbers or seed receipts. -/
def check {c : GlobalEnumeration.Certificate} {data : Nat → SuccessorCache.Data}
    (table : Table c data) : Bool :=
  CrossLayerAssemblyV17.check table && EmptyRootV17.checkP (root table).data (root table).bits

theorem sound (c : GlobalEnumeration.Certificate) (data : Nat → SuccessorCache.Data)
    (cacheChecked : GlobalSuccessorBridge.Checked c data) (table : Table c data)
    (accepted : check table = true) : SecondPlayerWins Step Win empty := by
  have parts : CrossLayerAssemblyV17.check table = true ∧
      EmptyRootV17.checkP (root table).data (root table).bits = true :=
    by simpa only [check, Bool.and_eq_true] using accepted
  exact CrossLayerAssemblyV17.checked_empty_second_player_wins c data cacheChecked table parts.1 0 0
    (root_binding table parts.2)

/-- A successful value contains a proof. Proof erasure does not change which
pure Boolean is computed. An IO wrapper must call this function on its loaded
input, rather than converting an unrelated process report into success. -/
def certify (c : GlobalEnumeration.Certificate) (data : Nat → SuccessorCache.Data)
    (cacheChecked : GlobalSuccessorBridge.Checked c data) (table : Table c data) :
    Option (PLift (SecondPlayerWins Step Win empty)) :=
  if accepted : check table = true then some ⟨sound c data cacheChecked table accepted⟩ else none

/-- Success is exactly the finite predicate in this module. It cannot be
produced by a separate success label or by omitting a failed row. -/
theorem certify_isSome (c : GlobalEnumeration.Certificate) (data : Nat → SuccessorCache.Data)
    (cacheChecked : GlobalSuccessorBridge.Checked c data) (table : Table c data) :
    (certify c data cacheChecked table).isSome = check table := by
  unfold certify
  split
  · next accepted => simp only [Option.isSome_some, accepted]
  · next rejected => simp only [Option.isSome_none]; exact Bool.eq_false_iff.mpr rejected |>.symm

theorem certified_result_sound (c : GlobalEnumeration.Certificate) (data : Nat → SuccessorCache.Data)
    (cacheChecked : GlobalSuccessorBridge.Checked c data) (table : Table c data)
    (result : (certify c data cacheChecked table).isSome = true) :
    SecondPlayerWins Step Win empty := by
  exact sound c data cacheChecked table ((certify_isSome c data cacheChecked table).symm.trans result)

theorem rejection (c : GlobalEnumeration.Certificate) (data : Nat → SuccessorCache.Data)
    (cacheChecked : GlobalSuccessorBridge.Checked c data) (table : Table c data)
    (failed : check table = false) : certify c data cacheChecked table = none := by
  simp only [certify, failed, Bool.false_eq_true, ↓reduceDIte]

end Mahjong.RuntimeBindingV17

#print axioms Mahjong.RuntimeBindingV17.root_binding
#print axioms Mahjong.RuntimeBindingV17.sound
#print axioms Mahjong.RuntimeBindingV17.certify_isSome
#print axioms Mahjong.RuntimeBindingV17.certified_result_sound
#print axioms Mahjong.RuntimeBindingV17.rejection
