import Mahjong.CrossLayerAssemblyV17
import Mahjong.CheckedPlanConstructor
import Mahjong.GuardedByteScanV16

set_option autoImplicit false

/-!
The proof-producing boundary for the existing once-prepare/once-scan loop.

An accepted process report is not an input to any theorem in this module.
Prepared plans carry only proofs of executable finite checks and of the hot
representation that was actually built. In particular they contain no game
strategy or TargetCorrect premise. A successful scan calls the frozen scalar
scan once per run. Its erased proof supplies every row's checker equality.

The existential row proposals in the last theorems live only in Prop. They
do not allocate a proposal for every row or repeat checkPlan during a scan.
-/

namespace Mahjong.RuntimeScanV17

open GroupCandidates BlockPlanCheck CrossLayerAssemblyV17
open BlockPlanCertifiedRow (sourceModel)

variable {c : GlobalEnumeration.Certificate} {data : Nat → SuccessorCache.Data}
variable {source : GeneralIndex.Bucket}

/-- A globally built shared memo. The representation equality is erased;
the expensive shared cache is not reconstructed for each source block. -/
abbrev CertifiedShared (w : BucketWork c data source) :=
  { shared : BorrowedNextGeneratedHotPlan.Shared //
    shared = BorrowedNextGeneratedHotPlan.buildShared (groupData w.next.bank)
      (CachedPackedCheck.ofCertificate c data) }

def buildShared (w : BucketWork c data source) : CertifiedShared w :=
  ⟨BorrowedNextGeneratedHotPlan.buildShared (groupData w.next.bank)
    (CachedPackedCheck.ofCertificate c data), rfl⟩

/-- Exactly the finite preparation facts used by checkActualRow. The tables
are the raw checked-constructor result, not a per-row expanded edge plan. -/
structure PreparedPlan (w : BucketWork c data source) where
  context : Context
  view : SourceBlockGuard.View
  tables : GeneratedPlanCheck.Tables
  hot : BorrowedNextGeneratedHotPlan.Snapshot
  honor : context.honorCode = source.data.honorCode
  sourceAccepted : SourceBlockGuard.check (sourceModel w.next.bank source.data)
    context.sourceBlock view = true
  planAccepted : GeneratedPlanCheck.checkPlan (CachedPackedCheck.ofCertificate c data)
    w.next.bank (sourceModel w.next.bank source.data) context w.coverage tables = true
  hotBuilt : hot = BorrowedNextGeneratedHotPlan.build
    (CachedPackedCheck.ofCertificate c data) w.next.bank context tables

/-- Compute each actual constructor once. The successful constructor's
property is reused as an erased proof; checkPlan is NOT executed a second
time. Source-view and honor checks are still actual executable checks. -/
def prepare (w : BucketWork c data source) (shared : CertifiedShared w)
    (ctx : Context) (view : SourceBlockGuard.View)
    (proposal : CheckedPlanConstructor.Proposal) (slots : Nat → Nat → Array Nat) :
    Option (PreparedPlan w) :=
  if honor : ctx.honorCode = source.data.honorCode then
    if sourceAccepted : SourceBlockGuard.check (sourceModel w.next.bank source.data)
        ctx.sourceBlock view = true then
      match CheckedPlanConstructor.preparePlan (CachedPackedCheck.ofCertificate c data)
          w.next.bank (sourceModel w.next.bank source.data) ctx w.coverage proposal slots with
      | none => none
      | some checked =>
        some ⟨ctx, view, checked.val,
          BorrowedNextGeneratedHotPlan.buildWithShared (CachedPackedCheck.ofCertificate c data)
            w.next.bank ctx checked.val shared.val,
          honor, sourceAccepted, checked.property, by
            rw [shared.property]
            rfl⟩
    else none
  else none

/-- No correctness of initial IDs or of nextIds is assumed. The frozen scan
checks the absolute source address of every row, including the first. -/
structure Run (w : BucketWork c data source) where
  chunk : RowScheduleV13.Chunk
  prepared : PreparedPlan w
  initial : Triple

def scanRuns (w : BucketWork c data source) (compact : ByteArray) (base : Nat) :
    List (Run w) → Nat → Except Nat Nat
  | [], p => .ok p
  | run :: rest, p =>
    match GuardedByteScanV16.scan run.prepared.hot run.prepared.view run.prepared.context
        source.bits compact base run.chunk.count run.chunk.first
        run.initial.1 run.initial.2.1 run.initial.2.2 p with
    | .error row => .error row
    | .ok nextP => scanRuns w compact base rest nextP

/-- The block sub-runs must cover the whole scheduled fragment, including
the final tail. This check is outside the scalar per-row loop. -/
def checkRuns (w : BucketWork c data source) (compact : ByteArray)
    (base first count : Nat) (runs : List (Run w)) : Except Nat Nat :=
  if RowScheduleV13.checkCover (runs.map Run.chunk) first (first + count) then
    scanRuns w compact base runs 0
  else .error first

/-- A local finite-check witness, with the actual source bit at r. It has no
semantic game premise. The constant proposal is only a convenient way to
express the existing checkActualRow function at this single row. -/
def RowAccepted (w : BucketWork c data source) (r : Nat) : Prop :=
  ∃ proposal : RowProposal,
    checkActualRow c data source { w with propose := fun _ => proposal } r = true

theorem prepared_row (w : BucketWork c data source) (plan : PreparedPlan w)
    (ids : Triple) (byte : UInt8) (r : Nat)
    (accepted : IndexedByteRowV16.check plan.hot plan.view plan.context ids byte r
      (FastBitRead.labelPNat source.bits r) = true) :
    RowAccepted w r := by
  have checked := accepted
  rw [plan.hotBuilt, FastBitRead.labelPNat_eq] at checked
  refine ⟨⟨plan.view, plan.context, plan.tables, ids, byte⟩, ?_⟩
  simpa only [checkActualRow, plan.honor, decide_true, plan.sourceAccepted,
    plan.planAccepted, Bool.true_and] using checked

/-- Generic exact-cover membership, used both for block runs and for the
twelve independently owned input fragments. It does not infer coverage from
P/N counts or from a sum of row counts. -/
theorem cover_member {α : Type} (range : α → RowScheduleV13.Chunk)
    (items : List α) (cursor stop r : Nat)
    (accepted : RowScheduleV13.checkCover (items.map range) cursor stop = true)
    (lower : cursor ≤ r) (upper : r < stop) :
    ∃ item, item ∈ items ∧ (range item).first ≤ r ∧
      r < (range item).first + (range item).count := by
  induction items generalizing cursor with
  | nil =>
    have same : cursor = stop := of_decide_eq_true accepted
    omega
  | cons item rest ih =>
    have parts : (range item).first = cursor ∧
        RowScheduleV13.checkCover (rest.map range)
          ((range item).first + (range item).count) stop = true := by
      simpa only [List.map_cons, RowScheduleV13.checkCover,
        Bool.and_eq_true, decide_eq_true_eq] using accepted
    by_cases here : r < (range item).first + (range item).count
    · exact ⟨item, List.mem_cons_self, by omega, here⟩
    · obtain ⟨other, member, lo, hi⟩ := ih
        ((range item).first + (range item).count) parts.2 (by omega)
      exact ⟨other, List.mem_cons_of_mem item member, lo, hi⟩

theorem scanRuns_each (w : BucketWork c data source) (compact : ByteArray) (base : Nat)
    (runs : List (Run w)) (p result : Nat)
    (accepted : scanRuns w compact base runs p = .ok result) :
    ∀ run, run ∈ runs → ∀ r, run.chunk.first ≤ r →
      r < run.chunk.first + run.chunk.count → RowAccepted w r := by
  induction runs generalizing p with
  | nil => intro run absent; cases absent
  | cons run rest ih =>
    cases current : GuardedByteScanV16.scan run.prepared.hot run.prepared.view
        run.prepared.context source.bits compact base run.chunk.count run.chunk.first
        run.initial.1 run.initial.2.1 run.initial.2.2 p with
    | error row => simp only [scanRuns, current] at accepted; cases accepted
    | ok nextP =>
      have tail : scanRuns w compact base rest nextP = .ok result := by
        simpa only [scanRuns, current] using accepted
      intro selected member r lower upper
      rcases List.mem_cons.mp member with same | inRest
      · subst selected
        obtain ⟨ids, checked⟩ := GuardedByteScanV16.accepted_checks_every_row
          run.prepared.hot run.prepared.view run.prepared.context source.bits compact base
          run.chunk.count run.chunk.first run.initial.1 run.initial.2.1 run.initial.2.2
          p nextP current r lower upper
        exact prepared_row w run.prepared ids (compact[r-base]!) r checked
      · exact ih nextP tail selected inRest r lower upper

theorem checkRuns_each (w : BucketWork c data source) (compact : ByteArray)
    (base first count : Nat) (runs : List (Run w)) (result : Nat)
    (accepted : checkRuns w compact base first count runs = .ok result) :
    ∀ r, first ≤ r → r < first + count → RowAccepted w r := by
  unfold checkRuns at accepted
  split at accepted
  next cover =>
    intro r lower upper
    obtain ⟨run, member, lo, hi⟩ := cover_member Run.chunk runs first (first + count) r
      cover lower upper
    exact scanRuns_each w compact base runs 0 result accepted run member r lo hi
  next rejected => cases accepted

/-- The actual round1 payload has twelve separately allocated one-byte
arrays. The byte base is this fragment's absolute first row, not frame start. -/
structure Fragment (w : BucketWork c data source) where
  chunk : RowScheduleV13.Chunk
  compact : ByteArray
  runs : List (Run w)

def checkPayload (w : BucketWork c data source) (start count : Nat)
    (fragments : List (Fragment w)) : Bool :=
  RowScheduleV13.checkSchedule (fragments.map Fragment.chunk) start count 12 1 &&
    decide (0 < count ∧ count ≤ 67108864 ∧ start + count ≤ source.data.size ∧
      fragments.length = 12) &&
    fragments.all (fun fragment =>
      decide (fragment.compact.size = fragment.chunk.count ∧ fragment.chunk.count ≤ 5592406))

theorem payload_cover (w : BucketWork c data source) (start count : Nat)
    (fragments : List (Fragment w))
    (accepted : checkPayload w start count fragments = true) :
    RowScheduleV13.checkCover (fragments.map Fragment.chunk) start (start + count) = true := by
  have parts := accepted
  simp only [checkPayload, Bool.and_eq_true] at parts
  have scheduleParts := parts.1.1
  simp only [RowScheduleV13.checkSchedule, Bool.and_eq_true] at scheduleParts
  exact scheduleParts.2

/-- Scan each input fragment once. Each worker's counter starts at zero;
only the twelve completed counters are added outside the row loop. -/
def scanFrame (w : BucketWork c data source) : List (Fragment w) → Nat → Except Nat Nat
  | [], total => .ok total
  | fragment :: rest, total =>
    match checkRuns w fragment.compact fragment.chunk.first fragment.chunk.first
        fragment.chunk.count fragment.runs with
    | .error row => .error row
    | .ok p => scanFrame w rest (total + p)

def pureFrame (w : BucketWork c data source) (start count : Nat)
    (fragments : List (Fragment w)) : Except Nat Nat :=
  if checkPayload w start count fragments then scanFrame w fragments 0 else .error start

/-- A Boolean boundary when the caller needs a Bool. The result of the ONE
pureFrame evaluation is inspected; the scan is not recomputed in a branch. -/
def pureFrameB (w : BucketWork c data source) (start count : Nat)
    (fragments : List (Fragment w)) : Bool :=
  match pureFrame w start count fragments with
  | .ok _ => true
  | .error _ => false

theorem scanFrame_each (w : BucketWork c data source) (fragments : List (Fragment w))
    (total result : Nat) (accepted : scanFrame w fragments total = .ok result) :
    ∀ fragment, fragment ∈ fragments → ∀ r, fragment.chunk.first ≤ r →
      r < fragment.chunk.first + fragment.chunk.count → RowAccepted w r := by
  induction fragments generalizing total with
  | nil => intro fragment absent; cases absent
  | cons fragment rest ih =>
    cases current : checkRuns w fragment.compact fragment.chunk.first fragment.chunk.first
        fragment.chunk.count fragment.runs with
    | error row => simp only [scanFrame, current] at accepted; cases accepted
    | ok p =>
      have tail : scanFrame w rest (total + p) = .ok result := by
        simpa only [scanFrame, current] using accepted
      intro selected member r lower upper
      rcases List.mem_cons.mp member with same | inRest
      · subst selected
        exact checkRuns_each w fragment.compact fragment.chunk.first fragment.chunk.first
          fragment.chunk.count fragment.runs p current r lower upper
      · exact ih (total + p) tail selected inRest r lower upper

theorem pureFrame_each (w : BucketWork c data source) (start count : Nat)
    (fragments : List (Fragment w)) (result : Nat)
    (accepted : pureFrame w start count fragments = .ok result) :
    ∀ r, start ≤ r → r < start + count → RowAccepted w r := by
  unfold pureFrame at accepted
  split at accepted
  next payload =>
    intro r lower upper
    obtain ⟨fragment, member, lo, hi⟩ := cover_member Fragment.chunk fragments start
      (start + count) r (payload_cover w start count fragments payload) lower upper
    exact scanFrame_each w fragments 0 result accepted fragment member r lo hi
  next rejected => cases accepted

theorem pureFrameB_each (w : BucketWork c data source) (start count : Nat)
    (fragments : List (Fragment w))
    (accepted : pureFrameB w start count fragments = true) :
    ∀ r, start ≤ r → r < start + count → RowAccepted w r := by
  cases result : pureFrame w start count fragments with
  | error row => simp only [pureFrameB, result] at accepted; cases accepted
  | ok p => exact pureFrame_each w start count fragments p result

/-! ## Typed composition of the actual parallel scans

Each task may call scanFragment once and retain the returned erased equality.
The main thread only validates the lightweight payload/coverage descriptor
and sums completed counters. assembleScanned does NOT call scanFrame or
pureFrame in executable code. Their appearances in its proof are erased.
Nothing here identifies an IO result string with an equality in Lean.
-/

structure ScannedFragment (w : BucketWork c data source) where
  fragment : Fragment w
  p : Nat
  accepted : checkRuns w fragment.compact fragment.chunk.first fragment.chunk.first
    fragment.chunk.count fragment.runs = .ok p

def scanFragment (w : BucketWork c data source) (fragment : Fragment w) :
    Option (ScannedFragment w) :=
  match returned : checkRuns w fragment.compact fragment.chunk.first fragment.chunk.first
      fragment.chunk.count fragment.runs with
  | .error _ => none
  | .ok p => some ⟨fragment, p, returned⟩

structure CheckedFrame (w : BucketWork c data source) (start count : Nat)
    (fragments : List (Fragment w)) where
  p : Nat
  accepted : pureFrame w start count fragments = .ok p

def sumP (w : BucketWork c data source) (scanned : List (ScannedFragment w)) : Nat :=
  (scanned.map ScannedFragment.p).sum

theorem scanFrame_scanned (w : BucketWork c data source)
    (scanned : List (ScannedFragment w)) (total : Nat) :
    scanFrame w (scanned.map ScannedFragment.fragment) total = .ok (total + sumP w scanned) := by
  induction scanned generalizing total with
  | nil => simp only [List.map_nil, scanFrame, sumP, List.sum_nil, Nat.add_zero]
  | cons head rest ih =>
    simp only [List.map_cons, scanFrame, head.accepted]
    rw [ih]
    simp only [sumP, List.map_cons, List.sum_cons, Nat.add_assoc]

/-- Join-side certification. The scans supplying ScannedFragment values
have already run. In particular this function neither reruns a scalar scan
nor executes checkPlan for each row. -/
def assembleScanned (w : BucketWork c data source) (start count : Nat)
    (scanned : List (ScannedFragment w)) :
    Option (CheckedFrame w start count (scanned.map ScannedFragment.fragment)) :=
  if accepted : checkPayload w start count (scanned.map ScannedFragment.fragment) = true then
    some ⟨sumP w scanned, by
      simpa only [pureFrame, accepted, ↓reduceIte, Nat.zero_add] using
        scanFrame_scanned w scanned 0⟩
  else none

/-- The sequential interface also exposes its one computed result through
a dependent match. This is an alternative to the parallel typed join. -/
def executeFrame (w : BucketWork c data source) (start count : Nat)
    (fragments : List (Fragment w)) : Option (CheckedFrame w start count fragments) :=
  match returned : pureFrame w start count fragments with
  | .error _ => none
  | .ok p => some ⟨p, returned⟩

theorem CheckedFrame.each (w : BucketWork c data source) (start count : Nat)
    (fragments : List (Fragment w)) (checked : CheckedFrame w start count fragments) :
    ∀ r, start ≤ r → r < start + count → RowAccepted w r :=
  pureFrame_each w start count fragments checked.p checked.accepted

theorem assembleScanned_each (w : BucketWork c data source) (start count : Nat)
    (scanned : List (ScannedFragment w))
    (checked : CheckedFrame w start count (scanned.map ScannedFragment.fragment))
    (_returned : assembleScanned w start count scanned = some checked) :
    ∀ r, start ≤ r → r < start + count → RowAccepted w r :=
  CheckedFrame.each w start count (scanned.map ScannedFragment.fragment) checked

theorem checkActualRow_congr (w : BucketWork c data source)
    (a b : Nat → RowProposal) (r : Nat) (same : a r = b r) :
    checkActualRow c data source { w with propose := a } r =
      checkActualRow c data source { w with propose := b } r := by
  simp only [checkActualRow, same]

/-- Choice is used only in this proposition-level bridge. It chooses a
single proposal function for the interval from actual successful row checks;
it is not an executable row-proposal array or a second checking pass. -/
theorem pureFrame_proposals (w : BucketWork c data source) (start count : Nat)
    (fragments : List (Fragment w)) (result : Nat)
    (accepted : pureFrame w start count fragments = .ok result) :
    ∃ proposals : Nat → RowProposal,
      ∀ r, start ≤ r → r < start + count →
        checkActualRow c data source { w with propose := proposals } r = true := by
  classical
  have each := pureFrame_each w start count fragments result accepted
  let proposals : Nat → RowProposal := fun r =>
    if inside : start ≤ r ∧ r < start + count then
      Classical.choose (each r inside.1 inside.2)
    else w.propose r
  refine ⟨proposals, ?_⟩
  intro r lower upper
  have here : start ≤ r ∧ r < start + count := ⟨lower, upper⟩
  have selected : proposals r = Classical.choose (each r lower upper) := by
    dsimp only [proposals]
    rw [dif_pos here]
  have result := Classical.choose_spec (each r lower upper)
  rw [checkActualRow_congr w proposals
    (fun _ => Classical.choose (each r lower upper)) r selected]
  exact result

end Mahjong.RuntimeScanV17

#print axioms Mahjong.RuntimeScanV17.prepared_row
#print axioms Mahjong.RuntimeScanV17.cover_member
#print axioms Mahjong.RuntimeScanV17.scanRuns_each
#print axioms Mahjong.RuntimeScanV17.checkRuns_each
#print axioms Mahjong.RuntimeScanV17.payload_cover
#print axioms Mahjong.RuntimeScanV17.scanFrame_each
#print axioms Mahjong.RuntimeScanV17.pureFrame_each
#print axioms Mahjong.RuntimeScanV17.pureFrameB_each
#print axioms Mahjong.RuntimeScanV17.scanFrame_scanned
#print axioms Mahjong.RuntimeScanV17.CheckedFrame.each
#print axioms Mahjong.RuntimeScanV17.assembleScanned_each
#print axioms Mahjong.RuntimeScanV17.checkActualRow_congr
#print axioms Mahjong.RuntimeScanV17.pureFrame_proposals
