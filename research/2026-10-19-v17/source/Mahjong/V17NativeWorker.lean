import Mahjong.FastWholeInputV17

set_option autoImplicit false

/-!
Typed native adapter for the frozen V17 checks. No result string, checksum,
checkpoint, historical seed, or externally supplied Boolean is a constructor
argument for an accepting proof. Each accepting equation below comes from
the branch of the check actually executed on the stored raw input.

Keep one Session alive for the entire invocation. Open one nonempty bucket,
prepare its blocks with its one actual shared memo, scan independently owned
fragments, and join the returned typed values. CompletedRange has no proposal
buffer as a runtime field. Its work parameter and acceptance proofs are erased.

The IO loader must bind the same raw bytes and source/target family throughout.
This adapter does not turn an IO log into a closed Lean theorem for that family.
The final typed route is finishWhole, which invokes the frozen ScanFinal check.
-/

namespace Mahjong.V17NativeWorker

open CrossLayerAssemblyV17

structure Failure where
  tag : String
  first : Option Nat := none
  count : Option Nat := none
  block : Option Nat := none
  deriving Repr

private def fail (tag : String) : Failure := { tag := tag }

/-- Construct only through checkBase in the native IO entry. Inputs have no
Checked, Certificate, row-correctness, or strategy fields. -/
structure BaseSession where
  inputs : FiniteCertificateV17.Inputs
  accepted : FiniteCertificateV17.checks inputs = true

def BaseSession.certificate (base : BaseSession) : GlobalEnumeration.Certificate :=
  FiniteCertificateV17.build base.inputs base.accepted

/-- Every expensive family is executed once on success. The order starts with
physical extents, so malformed raw files fail before their full semantic scan.
No diagnostic retry is performed in the successful branch. -/
def checkBase (i : FiniteCertificateV17.Inputs) : Except Failure BaseSession :=
  if layout : FiniteCertificateV17.layoutChecks i = true then
    if word : FiniteCertificateV17.wordChecks i = true then
      if localAccepted : FiniteCertificateV17.allLocalChecks i = true then
        if groups : FiniteCertificateV17.groupChecks i = true then
          if bounds : FiniteCertificateV17.boundChecks i = true then
            if triples : FiniteCertificateV17.tripleChecks i = true then
              if directories : FiniteCertificateV17.directoryChecks i = true then
                .ok ⟨i, by
                  simp only [FiniteCertificateV17.checks, localAccepted, groups, bounds,
                    triples, directories, layout, word, Bool.true_and]⟩
              else .error (fail "base_honor_directories_rejected")
            else .error (fail "base_triple_directory_rejected")
          else .error (fail "base_layer_bounds_rejected")
        else .error (fail "base_group_inventory_rejected")
      else .error (fail "base_local_cache_inventory_or_raw_rejected")
    else .error (fail "base_word_limits_rejected")
  else .error (fail "base_physical_layout_rejected")

structure Session where
  base : BaseSession
  numericEdges : ByteArray
  honorEdges : ByteArray
  edgesAccepted : FiniteMetadataV17.checkSuccessors base.inputs numericEdges honorEdges = true

def Session.certificate (session : Session) : GlobalEnumeration.Certificate :=
  session.base.certificate

def Session.data (session : Session) : Nat → SuccessorCache.Data :=
  FiniteMetadataV17.successorData session.numericEdges session.honorEdges

def Session.localData (session : Session) : CachedPackedCheck.Local :=
  CachedPackedCheck.ofCertificate session.certificate session.data

theorem Session.successors (session : Session) :
    GlobalSuccessorBridge.Checked session.certificate session.data :=
  FiniteMetadataV17.successorsChecked session.base.inputs session.base.accepted
    session.numericEdges session.honorEdges session.edgesAccepted

/-- Numeric suits are shared only through the frozen numeric_span_shared
theorem inside checkSuccessors/successorsChecked; honors are separately run. -/
def checkEdges (base : BaseSession) (numeric honor : ByteArray) : Except Failure Session :=
  if accepted : FiniteMetadataV17.checkSuccessors base.inputs numeric honor = true then
    .ok ⟨base, numeric, honor, accepted⟩
  else .error (fail "successor_complete_lists_rejected")

/-- Raw data for one bucket. Targets are the complete finite 184-slot bank.
Zero-sized slots remain subject to the original empty-target convention.
Coverage includes all actual next keys, including SAFE-false keys. -/
structure BucketInput where
  indexIds : ByteArray
  targets : Fin bucketCount → BlockPlanCheck.Bucket
  source : GeneralIndex.Bucket
  coverage : GroupNextCoverage.Data

def BucketInput.bank (session : Session) (input : BucketInput) : FiniteBank :=
  FiniteMetadataV17.bank session.base.inputs input.indexIds input.targets

/-- This unused raw fallback is required by the frozen BucketWork reference
interface. The fast scan builds its own existential proposal in Prop from
each actual PreparedPlan; the fallback supplies no accepted row. -/
def rawFallback : RowProposal :=
  { view := ⟨⟨0,0,0,0,0,0,0,0,0⟩, (0,0,0)⟩
    context := ⟨0,0,(0,0,0),0⟩
    tables := ⟨fun _ => ⟨#[],#[]⟩⟩
    ids := (0,0,0)
    byte := 255 }

structure BucketSession (session : Session) where
  input : BucketInput
  sourceAccepted : FiniteMetadataV17.checkSource session.base.inputs input.indexIds input.source = true
  targetsAccepted : FiniteMetadataV17.checkBank session.base.inputs input.indexIds input.targets = true
  coverageAccepted : GroupNextCoverage.check
    (BlockPlanCheck.groupData (input.bank session).bank) session.localData input.coverage = true

def BucketSession.work {session : Session} (bucket : BucketSession session) :
    BucketWork session.certificate session.data bucket.input.source :=
  FiniteMetadataV17.buildBucketWork session.base.inputs session.base.accepted
    bucket.input.indexIds session.numericEdges session.honorEdges bucket.input.targets bucket.input.source
    bucket.sourceAccepted bucket.targetsAccepted bucket.input.coverage bucket.coverageAccepted
    #[] rawFallback []

/-- Timed by the IO wrapper once per bucket. Building the shared memo is a
separate explicit operation below and must not be repeated for every frame. -/
def openBucket (session : Session) (input : BucketInput) : Except Failure (BucketSession session) :=
  if _positive : 0 < input.source.data.size then
    if sourceAccepted : FiniteMetadataV17.checkSource session.base.inputs input.indexIds input.source = true then
      if targetsAccepted : FiniteMetadataV17.checkBank session.base.inputs input.indexIds input.targets = true then
        if coverageAccepted : GroupNextCoverage.check
            (BlockPlanCheck.groupData (input.bank session).bank) session.localData input.coverage = true then
          .ok ⟨input, sourceAccepted, targetsAccepted, coverageAccepted⟩
        else .error (fail "bucket_complete_next_key_coverage_rejected")
      else .error (fail "bucket_target_metadata_rejected")
    else .error (fail "bucket_source_metadata_rejected")
  else .error (fail "empty_bucket_requires_no_work")

abbrev Shared {session : Session} (bucket : BucketSession session) :=
  RuntimeScanV17.CertifiedShared bucket.work

/-- Actual buildShared, once per immutable bucket/common-local-data identity. -/
def buildShared {session : Session} (bucket : BucketSession session) : Shared bucket :=
  RuntimeScanV17.buildShared bucket.work

abbrev Plan {session : Session} (bucket : BucketSession session) :=
  RuntimeScanV17.PreparedPlan bucket.work

/-- Every source block gets the frozen actual prepare call. No supplied
PreparedPlan, accepted plan flag, or historical native result is consumed. -/
def prepareBlock {session : Session} (bucket : BucketSession session) (shared : Shared bucket)
    (context : BlockPlanCheck.Context) (view : SourceBlockGuard.View)
    (proposal : CheckedPlanConstructor.Proposal) (slots : Nat → Nat → Array Nat) :
    Except Failure (Plan bucket) :=
  match RuntimeScanV17.prepare bucket.work shared context view proposal slots with
  | some plan => .ok plan
  | none => .error { tag := "block_honor_source_view_or_checked_plan_rejected"
                     block := some context.sourceBlock }

abbrev Run {session : Session} (bucket : BucketSession session) := RuntimeScanV17.Run bucket.work
abbrev Fragment {session : Session} (bucket : BucketSession session) := RuntimeScanV17.Fragment bucket.work
abbrev Scanned {session : Session} (bucket : BucketSession session) := RuntimeScanV17.ScannedFragment bucket.work
abbrev CompletedRange {session : Session} (bucket : BucketSession session) := ScanFinalV17.CheckedRange bucket.work

/-- Invoke in one task per independently allocated fragment. The scan itself
is the frozen one-call scanFragment. A rejected Option does not identify the
exact bad row; first/count below identify its fragment without rescanning it. -/
def scanOwnedFragment {session : Session} (bucket : BucketSession session) (fragment : Fragment bucket) :
    Except Failure (Scanned bucket) :=
  if fragment.compact.size = fragment.chunk.count ∧ fragment.chunk.count ≤ 5592406 then
    match RuntimeScanV17.scanFragment bucket.work fragment with
    | some scanned => .ok scanned
    | none => .error { tag := "fragment_cover_source_address_or_indexed_row_rejected"
                       first := some fragment.chunk.first
                       count := some fragment.chunk.count }
  else .error { tag := "fragment_owned_byte_extent_rejected"
                first := some fragment.chunk.first
                count := some fragment.chunk.count }

structure FrameResult {session : Session} (bucket : BucketSession session) where
  p : Nat
  range : CompletedRange bucket

/-- Main-thread join: exactly one assembleScanned and one forgetFrame. It
checks 12-fragment scheduling, exact full payload sizes and source bounds,
then erases the scan proofs while retaining the two-Nat completed extent.
Do not retain scanned/fragments after this call if their bytes may be freed. -/
def finishFrame {session : Session} (bucket : BucketSession session) (start count : Nat)
    (scanned : List (Scanned bucket)) : Except Failure (FrameResult bucket) :=
  match RuntimeScanV17.assembleScanned bucket.work start count scanned with
  | none => .error { tag := "frame_schedule_payload_source_bounds_or_join_rejected"
                     first := some start, count := some count }
  | some checked => .ok ⟨checked.p,
      ScanFinalV17.forgetFrame bucket.work start count
        (scanned.map RuntimeScanV17.ScannedFragment.fragment) checked⟩

structure BucketResult {session : Session} (bucket : BucketSession session) where
  ranges : List (CompletedRange bucket)
  accepted : ScanFinalV17.checkRanges bucket.work ranges = true

/-- Exact whole-bucket cover, including its tail. Receipts cannot restore
the typed range proofs after process restart; affected scans must be rerun. -/
def finishBucket {session : Session} (bucket : BucketSession session)
    (ranges : List (CompletedRange bucket)) : Except Failure (BucketResult bucket) :=
  if accepted : ScanFinalV17.checkRanges bucket.work ranges = true then .ok ⟨ranges, accepted⟩
  else .error { tag := "bucket_incomplete_or_noncontiguous_frame_cover"
                first := some 0, count := some bucket.input.source.data.size }

theorem BucketResult.each {session : Session} (bucket : BucketSession session)
    (result : BucketResult bucket) (r : Nat) (inside : r < bucket.input.source.data.size) :
    RuntimeScanV17.RowAccepted bucket.work r :=
  ScanFinalV17.ranges_each bucket.work result.ranges result.accepted r inside

/-- The exact frozen target comparison, projected onto one adjacent layer.
The loader can share actual loaded ByteArrays; no whole Candidate is needed
for this executable projection. Every nonempty target compares all seven
original fields, including the entire bits ByteArray, with its next source.
The association to one global input family remains the IO binding obligation.
-/
def checkTargetSources (bank : FiniteBank) (next : Nat → GeneralIndex.Bucket) : Bool :=
  (List.range bucketCount).all fun h =>
    if 0 < (BlockPlanCheck.legacyBucket bank.bank h).data.size then
      sameBucket (BlockPlanCheck.legacyBucket bank.bank h) (next h)
    else true

theorem checkTargetSources_eq {c : GlobalEnumeration.Certificate}
    {data : Nat → SuccessorCache.Data} (table : Candidate c data) (n : Nat) (bank : FiniteBank) :
    checkTargetSources bank (sourceAt table (n + 1)) = checkTargets table n bank := rfl

def checkRoot (source : GeneralIndex.Bucket) : Bool :=
  EmptyRootV17.checkP source.data source.bits

/-- This is the original final typed route. It actually checks exact next
layer identities, all 35 x 184 nonempty-bucket range covers, and root data/P.
The IO loader must supply one Candidate/Trace over the same Session, not
independent reports. Keeping only report strings cannot call this function. -/
def finishWhole (session : Session) (table : Candidate session.certificate session.data)
    (trace : ScanFinalV17.Trace table) : Except Failure (PLift (SafeGame.SecondPlayerWins
      Step Win empty)) :=
  match ScanFinalV17.finish session.successors table trace with
  | some result => .ok result
  | none => .error (fail "whole_target_identity_trace_cover_or_empty_root_rejected")

end Mahjong.V17NativeWorker

#print axioms Mahjong.V17NativeWorker.Session.successors
#print axioms Mahjong.V17NativeWorker.BucketResult.each
#print axioms Mahjong.V17NativeWorker.checkTargetSources_eq
#print axioms Mahjong.V17NativeWorker.finishWhole
