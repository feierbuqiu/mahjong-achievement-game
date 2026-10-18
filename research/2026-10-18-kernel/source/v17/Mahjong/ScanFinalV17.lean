import Mahjong.RuntimeScanV17
import Mahjong.ExecutionAssemblyV17
import Mahjong.FiniteWholeInputV17

set_option autoImplicit false

/-!
Connect the actual once-only scalar scans to the original game's conclusion.
Completed frames can discard their proposal buffers: a CheckedRange keeps
only its extent at runtime. Its acceptance proof is an erased Lean field.

These are typed in-process results, not checkpoint files. A JSON or hash
cannot be deserialized into a CheckedRange proof. A closed persistent theorem
for the actual input still needs a genuine proof artifact, not proof erasure.
No production IO driver, all-table execution, memory benchmark or actual
whole-input acceptance is claimed by this module.
-/

namespace Mahjong.ScanFinalV17

open SafeGame CrossLayerAssemblyV17

variable {c : GlobalEnumeration.Certificate} {data : Nat → SuccessorCache.Data}
variable {source : GeneralIndex.Bucket}

/-- Native storage is only two natural numbers. Acceptance is established by
the verified scalar scan, not reconstructed from an untrusted success flag. -/
structure CheckedRange (w : BucketWork c data source) where
  chunk : RowScheduleV13.Chunk
  rows : ∀ r, chunk.first ≤ r → r < chunk.first + chunk.count → RuntimeScanV17.RowAccepted w r

def forgetFrame (w : BucketWork c data source) (start count : Nat)
    (fragments : List (RuntimeScanV17.Fragment w))
    (checked : RuntimeScanV17.CheckedFrame w start count fragments) : CheckedRange w :=
  ⟨⟨start,count⟩, RuntimeScanV17.CheckedFrame.each w start count fragments checked⟩

def checkRanges (w : BucketWork c data source) (ranges : List (CheckedRange w)) : Bool :=
  RowScheduleV13.checkCover (ranges.map CheckedRange.chunk) 0 source.data.size

theorem ranges_each (w : BucketWork c data source) (ranges : List (CheckedRange w))
    (accepted : checkRanges w ranges = true) (r : Nat) (inside : r < source.data.size) :
    RuntimeScanV17.RowAccepted w r := by
  obtain ⟨range, member, lower, upper⟩ := RuntimeScanV17.cover_member CheckedRange.chunk ranges
    0 source.data.size r accepted (Nat.zero_le r) inside
  exact range.rows r lower upper

/-- This collection may be built from typed scan returns. The source bucket,
next bank and common certificate are parameters of every returned value, so
a proof for different bytes or a different source cannot be substituted. -/
abbrev Trace (table : Candidate c data) :=
  ∀ (n : Fin layerCount) (h : Fin bucketCount) (positive : 0 < (table.sources n h).data.size),
    List (CheckedRange (table.work n h positive))

def traceChecks (table : Candidate c data) (trace : Trace table) : Bool :=
  (List.finRange layerCount).all fun n => (List.finRange bucketCount).all fun h =>
    if positive : 0 < (table.sources n h).data.size then
      checkRanges (table.work n h positive) (trace n h positive)
    else true

theorem trace_cell (table : Candidate c data) (trace : Trace table)
    (accepted : traceChecks table trace = true) (n : Fin layerCount) (h : Fin bucketCount)
    (positive : 0 < (table.sources n h).data.size) :
    checkRanges (table.work n h positive) (trace n h positive) = true := by
  have layer := List.all_eq_true.mp accepted n (by simp)
  have cell := List.all_eq_true.mp layer h (by simp)
  simpa only [positive, ↓reduceDIte] using cell

theorem checked_rows (table : Candidate c data) (trace : Trace table)
    (accepted : traceChecks table trace = true) : ExecutionAssemblyV17.RowChecks table := by
  intro n h positive r inside
  exact ranges_each (table.work n h positive) (trace n h positive)
    (trace_cell table trace accepted n h positive) r inside

/-- This final check is lightweight: compare exact source/target bytes,
check exact completed-frame coverage, and check the actual empty-root fields
and P bit. It never calls a scalar scan or checks a block plan again. -/
def finalChecks (table : Candidate c data) (trace : Trace table) : Bool :=
  ExecutionAssemblyV17.targetChecks table && traceChecks table trace &&
    EmptyRootV17.checkP (RuntimeBindingV17.root table).data (RuntimeBindingV17.root table).bits

theorem sound (cacheChecked : GlobalSuccessorBridge.Checked c data)
    (table : Candidate c data) (trace : Trace table)
    (accepted : finalChecks table trace = true) : SecondPlayerWins Step Win empty := by
  have parts : (ExecutionAssemblyV17.targetChecks table = true ∧ traceChecks table trace = true) ∧
      EmptyRootV17.checkP (RuntimeBindingV17.root table).data (RuntimeBindingV17.root table).bits = true := by
    simpa only [finalChecks, Bool.and_eq_true] using accepted
  exact ExecutionAssemblyV17.empty_second_player_wins c data cacheChecked table parts.1.1
    (checked_rows table trace parts.1.2) parts.2

/-- All non-Boolean metadata premises are now supplied by constructors over
raw finite inputs. No assumed TargetCorrect or assumed game strategy remains.
The typed trace must come from actual Lean scans; it is not an external log. -/
theorem from_finite_input (i : FiniteWholeInputV17.Inputs)
    (baseChecked : FiniteWholeInputV17.baseChecks i = true)
    (successorsChecked : FiniteWholeInputV17.successorChecks i = true)
    (metadataChecked : FiniteWholeInputV17.checkMetadata i = true)
    (trace : Trace (FiniteWholeInputV17.buildTable i baseChecked metadataChecked))
    (accepted : finalChecks (FiniteWholeInputV17.buildTable i baseChecked metadataChecked) trace = true) :
    SecondPlayerWins Step Win empty :=
  sound (FiniteMetadataV17.successorsChecked i.base baseChecked i.numericEdges i.honorEdges successorsChecked)
    (FiniteWholeInputV17.buildTable i baseChecked metadataChecked) trace accepted

def finish (cacheChecked : GlobalSuccessorBridge.Checked c data)
    (table : Candidate c data) (trace : Trace table) : Option (PLift (SecondPlayerWins Step Win empty)) :=
  if accepted : finalChecks table trace = true then some ⟨sound cacheChecked table trace accepted⟩ else none

theorem finish_isSome (cacheChecked : GlobalSuccessorBridge.Checked c data)
    (table : Candidate c data) (trace : Trace table) :
    (finish cacheChecked table trace).isSome = finalChecks table trace := by
  unfold finish
  split
  · next accepted => simp only [Option.isSome_some, accepted]
  · next rejected => simp only [Option.isSome_none]; exact Bool.eq_false_iff.mpr rejected |>.symm

end Mahjong.ScanFinalV17

#print axioms Mahjong.ScanFinalV17.ranges_each
#print axioms Mahjong.ScanFinalV17.checked_rows
#print axioms Mahjong.ScanFinalV17.sound
#print axioms Mahjong.ScanFinalV17.from_finite_input
#print axioms Mahjong.ScanFinalV17.finish_isSome
