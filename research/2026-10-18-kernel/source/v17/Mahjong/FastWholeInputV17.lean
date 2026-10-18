import Mahjong.ScanFinalV17
import Mahjong.FiniteWholeInputV17

set_option autoImplicit false

/-!+# Boolean whole-input boundary for the once-only scans

RawFrame means WITHOUT an assumed successful row scan or range proof. Its
fragments still contain RuntimeScanV17.PreparedPlan values, whose finite
sourceAccepted, planAccepted, and hotBuilt proof fields must be established.
They are not untrusted disk records and cannot be obtained by deserializing a
JSON PASS. The intended construction is buildShared once, then the proved
RuntimeScanV17.prepare for each source block, then Run/Fragment/RawFrame.
prepare performs the actual finite checks and checked-plan construction; a
different constructor would have to supply the same genuine finite proofs.
No PreparedPlan field asserts NormalStrategy, TargetCorrect, or row acceptance.

checkBucket checks exact frame coverage, then calls pureFrameB ONCE for each
visited frame. The proof-producing conversion below never calls a scan in
executable code. It keeps only chunk descriptors; its per-row facts are
erased consequences of those same Boolean scan results.

The final theorem constructs its Trace internally. There is no input
RowChecks, CheckedRange, typed Trace, or semantic strategy hypothesis. This
does not assert acceptance of the actual complete input, supply a production
IO/persistence protocol, or start any scan. Proof erasure and native reports
are still not closed Lean declarations of actual whole-input acceptance.
-/

namespace Mahjong.FastWholeInputV17

open SafeGame CrossLayerAssemblyV17

variable {c : GlobalEnumeration.Certificate} {data : Nat → SuccessorCache.Data}
variable {source : GeneralIndex.Bucket}

structure RawFrame (w : BucketWork c data source) where
  chunk : RowScheduleV13.Chunk
  fragments : List (RuntimeScanV17.Fragment w)

def frameB (w : BucketWork c data source) (frame : RawFrame w) : Bool :=
  RuntimeScanV17.pureFrameB w frame.chunk.first frame.chunk.count frame.fragments

/-- Exact cover is checked before any frame scan. An accepted bucket has no
unscanned tail, hole, or overlap. pureFrameB inspects one computed scan result.
-/
def checkBucket (w : BucketWork c data source) (frames : List (RawFrame w)) : Bool :=
  RowScheduleV13.checkCover (frames.map RawFrame.chunk) 0 source.data.size &&
    frames.all (frameB w)

theorem checkBucket_parts (w : BucketWork c data source) (frames : List (RawFrame w))
    (accepted : checkBucket w frames = true) :
    RowScheduleV13.checkCover (frames.map RawFrame.chunk) 0 source.data.size = true ∧
      frames.all (frameB w) = true := by
  simpa only [checkBucket, Bool.and_eq_true] using accepted

/-- This conversion contains no executable call to pureFrame/pureFrameB.
Only their already supplied accepting equations are used in erased proofs.
The retained list has one small checked chunk per actual frame.
-/
def checkedRanges (w : BucketWork c data source) :
    (frames : List (RawFrame w)) → frames.all (frameB w) = true → List (ScanFinalV17.CheckedRange w)
  | [], _ => []
  | frame :: rest, accepted =>
      let parts : frameB w frame = true ∧ rest.all (frameB w) = true := by
        simpa only [List.all_cons, Bool.and_eq_true] using accepted
      { chunk := frame.chunk
        rows := RuntimeScanV17.pureFrameB_each w frame.chunk.first frame.chunk.count frame.fragments parts.1 } ::
        checkedRanges w rest parts.2

theorem checkedRanges_chunks (w : BucketWork c data source) (frames : List (RawFrame w))
    (accepted : frames.all (frameB w) = true) :
    (checkedRanges w frames accepted).map ScanFinalV17.CheckedRange.chunk = frames.map RawFrame.chunk := by
  induction frames with
  | nil => rfl
  | cons frame rest ih =>
    simp only [checkedRanges, List.map_cons]
    rw [ih]

/-- The exact input chunk cover, not P/N totals or a recomputed scan, supplies
the final trace's coverage check. -/
theorem checkedRanges_cover (w : BucketWork c data source) (frames : List (RawFrame w))
    (accepted : checkBucket w frames = true) :
    ScanFinalV17.checkRanges w
      (checkedRanges w frames (checkBucket_parts w frames accepted).2) = true := by
  change RowScheduleV13.checkCover
    ((checkedRanges w frames (checkBucket_parts w frames accepted).2).map ScanFinalV17.CheckedRange.chunk)
    0 source.data.size = true
  rw [checkedRanges_chunks]
  exact (checkBucket_parts w frames accepted).1

/-- These are prepared frame DATA, not accepted ranges. The only proof
fields they contain are the actual finite plan/source preparation facts
described above. There is no successful scan in this input type. -/
abbrev RawFrames (table : Candidate c data) :=
  ∀ (n : Fin layerCount) (h : Fin bucketCount) (positive : 0 < (table.sources n h).data.size),
    List (RawFrame (table.work n h positive))

def checkWhole (table : Candidate c data) (frames : RawFrames table) : Bool :=
  (List.finRange layerCount).all fun n => (List.finRange bucketCount).all fun h =>
    if positive : 0 < (table.sources n h).data.size then
      checkBucket (table.work n h positive) (frames n h positive)
    else true

theorem checked_cell (table : Candidate c data) (frames : RawFrames table)
    (accepted : checkWhole table frames = true) (n : Fin layerCount) (h : Fin bucketCount)
    (positive : 0 < (table.sources n h).data.size) :
    checkBucket (table.work n h positive) (frames n h positive) = true := by
  have layer := List.all_eq_true.mp accepted n (by simp)
  have cell := List.all_eq_true.mp layer h (by simp)
  simpa only [positive, ↓reduceDIte] using cell

/-- The Trace is constructed after, and solely from, actual successful
Boolean frame scans. No caller supplies the trace's accepted row fields. -/
def buildTrace (table : Candidate c data) (frames : RawFrames table)
    (accepted : checkWhole table frames = true) : ScanFinalV17.Trace table :=
  fun n h positive =>
    checkedRanges (table.work n h positive) (frames n h positive)
      (checkBucket_parts _ _ (checked_cell table frames accepted n h positive)).2

theorem buildTrace_checks (table : Candidate c data) (frames : RawFrames table)
    (accepted : checkWhole table frames = true) :
    ScanFinalV17.traceChecks table (buildTrace table frames accepted) = true := by
  apply List.all_eq_true.mpr
  intro n _
  apply List.all_eq_true.mpr
  intro h _
  by_cases positive : 0 < (table.sources n h).data.size
  · simp only [positive, ↓reduceDIte]
    exact checkedRanges_cover (table.work n h positive) (frames n h positive)
      (checked_cell table frames accepted n h positive)
  · simp only [positive, ↓reduceDIte]

theorem trace_exists (table : Candidate c data) (frames : RawFrames table)
    (accepted : checkWhole table frames = true) :
    ∃ trace : ScanFinalV17.Trace table, ScanFinalV17.traceChecks table trace = true :=
  ⟨buildTrace table frames accepted, buildTrace_checks table frames accepted⟩

theorem finalChecks_of_fast (table : Candidate c data) (frames : RawFrames table)
    (framesChecked : checkWhole table frames = true)
    (targetIdentity : ExecutionAssemblyV17.targetChecks table = true)
    (rootChecked : EmptyRootV17.checkP (RuntimeBindingV17.root table).data
      (RuntimeBindingV17.root table).bits = true) :
    ScanFinalV17.finalChecks table (buildTrace table frames framesChecked) = true := by
  simp only [ScanFinalV17.finalChecks, Bool.and_eq_true]
  exact ⟨⟨targetIdentity, buildTrace_checks table frames framesChecked⟩, rootChecked⟩

/-- Whole raw metadata inputs plus prepared frame data and SIX explicit
Boolean acceptances imply the original empty-game second-player strategy.
There is no assumed Candidate/RowChecks/Trace/TargetCorrect/NormalStrategy
parameter. PreparedPlan contains only finite checks from prepare.
-/
theorem from_finite_input (i : FiniteWholeInputV17.Inputs)
    (baseChecked : FiniteWholeInputV17.baseChecks i = true)
    (successorsChecked : FiniteWholeInputV17.successorChecks i = true)
    (metadataChecked : FiniteWholeInputV17.checkMetadata i = true)
    (frames : RawFrames (FiniteWholeInputV17.buildTable i baseChecked metadataChecked))
    (framesChecked : checkWhole (FiniteWholeInputV17.buildTable i baseChecked metadataChecked) frames = true)
    (targetIdentity : ExecutionAssemblyV17.targetChecks
      (FiniteWholeInputV17.buildTable i baseChecked metadataChecked) = true)
    (rootChecked : EmptyRootV17.checkP
      (RuntimeBindingV17.root (FiniteWholeInputV17.buildTable i baseChecked metadataChecked)).data
      (RuntimeBindingV17.root (FiniteWholeInputV17.buildTable i baseChecked metadataChecked)).bits = true) :
    SecondPlayerWins Step Win empty :=
  ScanFinalV17.from_finite_input i baseChecked successorsChecked metadataChecked
    (buildTrace (FiniteWholeInputV17.buildTable i baseChecked metadataChecked) frames framesChecked)
    (finalChecks_of_fast (FiniteWholeInputV17.buildTable i baseChecked metadataChecked) frames
      framesChecked targetIdentity rootChecked)

end Mahjong.FastWholeInputV17

#print axioms Mahjong.FastWholeInputV17.checkBucket_parts
#print axioms Mahjong.FastWholeInputV17.checkedRanges
#print axioms Mahjong.FastWholeInputV17.checkedRanges_chunks
#print axioms Mahjong.FastWholeInputV17.checkedRanges_cover
#print axioms Mahjong.FastWholeInputV17.buildTrace
#print axioms Mahjong.FastWholeInputV17.buildTrace_checks
#print axioms Mahjong.FastWholeInputV17.trace_exists
#print axioms Mahjong.FastWholeInputV17.finalChecks_of_fast
#print axioms Mahjong.FastWholeInputV17.from_finite_input
