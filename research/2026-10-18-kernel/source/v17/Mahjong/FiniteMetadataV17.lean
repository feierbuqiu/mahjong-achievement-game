import Mahjong.CrossLayerAssemblyV17
import Mahjong.FiniteCertificateV17
import Mahjong.CheckedPlanConstructor

set_option autoImplicit false

/-!+# Finite metadata from raw inputs and actual Boolean checks

The input to these constructors is bytes, finite arrays/records, and equality
proofs saying that the stated pure Boolean checks accept those actual inputs.
There is no input NormalStrategy, TargetCorrect, arbitrary Checked proposition,
or semantic row theorem. The common GlobalEnumeration.Certificate is produced
by FiniteCertificateV17.build from its raw Inputs and complete finite checks.

Nothing here proves that a historical file hash, native PASS receipt, or Python
registry entails an accepting Lean Boolean equality. Actual instances of the
finite checks, the row/span checks, and the root/P-bit check remain necessary.
-/

namespace Mahjong.FiniteMetadataV17

open CanonicalInventory CrossLayerAssemblyV17
open BlockPlanCheck BlockPlanCertifiedRow

/-- Actual numeric index IDs are a separate input from canonical inventory
IDs. No equality between the two formats is assumed. -/
def shared (i : FiniteCertificateV17.Inputs) (indexIds : ByteArray) : BlockPlanCheck.Shared :=
  ⟨i.numericRecords, indexIds, i.groupRecords,
    FiniteCertificateV17.raw i 0, FiniteCertificateV17.members i 0⟩

def bank (i : FiniteCertificateV17.Inputs) (indexIds : ByteArray)
    (slots : Fin bucketCount → BlockPlanCheck.Bucket) : FiniteBank :=
  ⟨shared i indexIds, slots⟩

/-- Entire data structures, not a sampled equality of group labels. The
common certificate and every source/target model use the same raw candidate.
-/
theorem groupEq (i : FiniteCertificateV17.Inputs)
    (baseChecked : FiniteCertificateV17.checks i = true) (indexIds : ByteArray)
    (slots : Fin bucketCount → BlockPlanCheck.Bucket) :
    groupData (bank i indexIds slots).bank = (FiniteCertificateV17.build i baseChecked).groups := rfl

def sourceIndex (i : FiniteCertificateV17.Inputs) (source : GeneralIndex.Bucket) : IndexOperations.Data :=
  LegacyIndexRefinement.model source.data
    (FiniteCertificateV17.raw i 0) (FiniteCertificateV17.members i 0)

/-- Bind all shared source decoder bytes, then check whole-record extents,
the complete finite prefix/key directory, and the actual machine-word limits.
The physical bit-table storage is padded to UInt64 words, as in the loader.
-/
def checkSource (i : FiniteCertificateV17.Inputs) (indexIds : ByteArray)
    (source : GeneralIndex.Bucket) : Bool :=
  decide (source.data.numeric = i.numericRecords ∧ source.data.ids = indexIds ∧
    source.data.groups = i.groupRecords ∧ indexIds.size = 1953125 * 4 ∧
    source.data.directory.size % 32 = 0 ∧
    source.bits.size = (source.data.size + 63) / 64 * 8) &&
    GuardedIndexAccess.check (sourceIndex i source) &&
    WordLimits.bucketFits (sourceIndex i source).directory.blocks source.data.size

structure SourceFacts (i : FiniteCertificateV17.Inputs) (source : GeneralIndex.Bucket) : Prop where
  groups : (sourceIndex i source).groups = FiniteCertificateV17.groups i
  checked : IndexOperations.Checked (sourceIndex i source)
  fits : WordLimits.GroupsFit (sourceIndex i source).groups
  limits : WordLimits.bucketFits (sourceIndex i source).directory.blocks source.data.size = true
  whole_records : source.data.directory.size % 32 = 0
  bit_storage : source.bits.size = (source.data.size + 63) / 64 * 8

theorem source_facts (i : FiniteCertificateV17.Inputs)
    (baseChecked : FiniteCertificateV17.checks i = true) (indexIds : ByteArray)
    (source : GeneralIndex.Bucket) (accepted : checkSource i indexIds source = true) :
    SourceFacts i source := by
  have h : ((source.data.numeric = i.numericRecords ∧ source.data.ids = indexIds ∧
      source.data.groups = i.groupRecords ∧ indexIds.size = 1953125 * 4 ∧
      source.data.directory.size % 32 = 0 ∧
      source.bits.size = (source.data.size + 63) / 64 * 8) ∧
      GuardedIndexAccess.check (sourceIndex i source) = true) ∧
      WordLimits.bucketFits (sourceIndex i source).directory.blocks source.data.size = true := by
    simpa only [checkSource, Bool.and_eq_true, decide_eq_true_eq] using accepted
  have groups : (sourceIndex i source).groups = FiniteCertificateV17.groups i := by
    change GroupInventory.candidate source.data.numeric source.data.groups
      (FiniteCertificateV17.raw i 0) (FiniteCertificateV17.members i 0) = _
    rw [h.1.1.1, h.1.1.2.2.1]
    rfl
  have checkedGroups : GroupInventory.Checked (sourceIndex i source).groups := by
    rw [groups]
    exact (FiniteCertificateV17.build i baseChecked).groupChecked
  have fits : WordLimits.GroupsFit (sourceIndex i source).groups := by
    rw [groups]
    exact FiniteCertificateV17.groups_fit i baseChecked
  exact ⟨groups, GuardedIndexAccess.checked (sourceIndex i source) checkedGroups h.1.2,
    fits, h.2, h.1.1.2.2.2.2.1, h.1.1.2.2.2.2.2⟩

theorem sourceGroups (i : FiniteCertificateV17.Inputs) (indexIds : ByteArray)
    (slots : Fin bucketCount → BlockPlanCheck.Bucket) (source : GeneralIndex.Bucket)
    (accepted : checkSource i indexIds source = true) :
    (sourceModel (bank i indexIds slots).bank source.data).groups =
      groupData (bank i indexIds slots).bank := by
  have h := accepted
  simp only [checkSource, Bool.and_eq_true, decide_eq_true_eq] at h
  change GroupInventory.candidate source.data.numeric source.data.groups
    (FiniteCertificateV17.raw i 0) (FiniteCertificateV17.members i 0) = _
  rw [h.1.1.1, h.1.1.2.2.1]
  rfl

/-- Every nonempty loaded target is checked. Outside the finite slots its
size is zero by construction, rather than by a quantified unchecked premise.
-/
def checkBank (i : FiniteCertificateV17.Inputs) (indexIds : ByteArray)
    (slots : Fin bucketCount → BlockPlanCheck.Bucket) : Bool :=
  (List.range bucketCount).all fun h =>
    if 0 < (legacyBucket (bank i indexIds slots).bank h).data.size then
      checkSource i indexIds (legacyBucket (bank i indexIds slots).bank h)
    else true

theorem bank_slot_facts (i : FiniteCertificateV17.Inputs)
    (baseChecked : FiniteCertificateV17.checks i = true) (indexIds : ByteArray)
    (slots : Fin bucketCount → BlockPlanCheck.Bucket)
    (accepted : checkBank i indexIds slots = true) (h : Nat)
    (positive : 0 < (legacyBucket (bank i indexIds slots).bank h).data.size) :
    SourceFacts i (legacyBucket (bank i indexIds slots).bank h) := by
  have inside : h < bucketCount := by
    by_cases inside : h < bucketCount
    · exact inside
    · have zero := (bank i indexIds slots).outside_size h inside
      omega
  have slot := List.all_eq_true.mp accepted h (List.mem_range.mpr inside)
  apply source_facts i baseChecked indexIds
  simpa only [positive, ↓reduceIte] using slot

theorem targetMetadata (i : FiniteCertificateV17.Inputs)
    (baseChecked : FiniteCertificateV17.checks i = true) (indexIds : ByteArray)
    (slots : Fin bucketCount → BlockPlanCheck.Bucket)
    (accepted : checkBank i indexIds slots = true) :
    GuardedTargetRef.Checked (guardedBank (bank i indexIds slots).bank) := by
  constructor
  · intro h positive
    exact (bank_slot_facts i baseChecked indexIds slots accepted h positive).checked
  · intro h positive
    exact (bank_slot_facts i baseChecked indexIds slots accepted h positive).fits
  · intro h positive
    exact (bank_slot_facts i baseChecked indexIds slots accepted h positive).limits

/-! ## Raw successor bytes to all four checked local domains -/

def successorData (numeric honor : ByteArray) (b : Nat) : SuccessorCache.Data :=
  SuccessorCache.candidate b (FiniteCertificateV17.select numeric honor b)

def numericSuccessors (i : FiniteCertificateV17.Inputs) (bytes : ByteArray) : Bool :=
  checkSpan (SuccessorCache.checkRow 0
    (CanonicalInventory.candidate 0 i.numeric.raw i.numeric.ids i.numeric.members)
    (SummaryEncoding.candidate 0 i.numeric.core i.numeric.summary)
    (SuccessorCache.candidate 0 bytes)) 0 (i.numeric.members.size / 4)

def honorSuccessors (i : FiniteCertificateV17.Inputs) (bytes : ByteArray) : Bool :=
  checkSpan (SuccessorCache.checkRow 3
    (CanonicalInventory.candidate 3 i.honor.raw i.honor.ids i.honor.members)
    (SummaryEncoding.candidate 3 i.honor.core i.honor.summary)
    (SuccessorCache.candidate 3 bytes)) 0 (i.honor.members.size / 4)

/-- A full numeric span and full honor span, with exact fixed-row byte
extents. The three numeric domains are shared by the proved existing theorem,
not by sampling a few rows in the other suits. -/
def checkSuccessors (i : FiniteCertificateV17.Inputs) (numeric honor : ByteArray) : Bool :=
  decide (numeric.size = (i.numeric.members.size / 4) * SuccessorCache.rowBytes 0 ∧
    honor.size = (i.honor.members.size / 4) * SuccessorCache.rowBytes 3) &&
    numericSuccessors i numeric && honorSuccessors i honor

theorem successorsChecked (i : FiniteCertificateV17.Inputs)
    (baseChecked : FiniteCertificateV17.checks i = true) (numeric honor : ByteArray)
    (accepted : checkSuccessors i numeric honor = true) :
    GlobalSuccessorBridge.Checked (FiniteCertificateV17.build i baseChecked)
      (successorData numeric honor) := by
  have h : ((numeric.size = (i.numeric.members.size / 4) * SuccessorCache.rowBytes 0 ∧
      honor.size = (i.honor.members.size / 4) * SuccessorCache.rowBytes 3) ∧
      numericSuccessors i numeric = true) ∧ honorSuccessors i honor = true := by
    simpa only [checkSuccessors, Bool.and_eq_true, decide_eq_true_eq] using accepted
  intro b hb
  change checkSpan (SuccessorCache.checkRow b
    (CanonicalInventory.candidate b (FiniteCertificateV17.raw i b)
      (FiniteCertificateV17.ids i b) (FiniteCertificateV17.members i b))
    (SummaryEncoding.candidate b (FiniteCertificateV17.core i b) (FiniteCertificateV17.summary i b))
    (successorData numeric honor b)) 0 ((FiniteCertificateV17.members i b).size / 4) = true
  by_cases isHonor : b = 3
  · subst b
    exact h.2
  · have numericDomain : b < 3 := by omega
    simp only [FiniteCertificateV17.raw, FiniteCertificateV17.ids, FiniteCertificateV17.members,
      FiniteCertificateV17.core, FiniteCertificateV17.summary, successorData,
      FiniteCertificateV17.select, isHonor, ↓reduceIte]
    have same := SuccessorCache.numeric_span_shared b numericDomain
      i.numeric.core i.numeric.summary i.numeric.raw i.numeric.ids i.numeric.members numeric
      0 (i.numeric.members.size / 4)
    exact same.trans h.1.2

/-! ## Checked-plan constructor without an arbitrary CheckedPlan input -/

/-- Expose only the raw tables returned by the actual pure checked
constructor. The caller cannot supply a fabricated subtype property. -/
def constructedTables (localData : CachedPackedCheck.Local) (next : BlockPlanCheck.Bank)
    (source : IndexOperations.Data) (ctx : BlockPlanCheck.Context) (coverage : GroupNextCoverage.Data)
    (propose : CheckedPlanConstructor.Proposal) (slots : Nat → Nat → Array Nat) :
    Option GeneratedPlanCheck.Tables :=
  (CheckedPlanConstructor.preparePlan localData next source ctx coverage propose slots).map Subtype.val

theorem constructedTables_checked (localData : CachedPackedCheck.Local) (next : BlockPlanCheck.Bank)
    (source : IndexOperations.Data) (ctx : BlockPlanCheck.Context) (coverage : GroupNextCoverage.Data)
    (propose : CheckedPlanConstructor.Proposal) (slots : Nat → Nat → Array Nat)
    (tables : GeneratedPlanCheck.Tables)
    (returned : constructedTables localData next source ctx coverage propose slots = some tables) :
    GeneratedPlanCheck.checkPlan localData next source ctx coverage tables = true := by
  unfold constructedTables at returned
  cases made : CheckedPlanConstructor.preparePlan localData next source ctx coverage propose slots with
  | none => simp only [made, Option.map_none] at returned; cases returned
  | some checked =>
    have same : checked.val = tables := Option.some.inj (by
      simpa only [made, Option.map_some] using returned)
    rw [← same]
    exact checked.property

/-! ## A complete BucketWork constructor with no semantic premise -/

/-- The row proposal input is a finite array and a raw fallback value, not
an assumed theorem or an assumed row checker. All its actual rows will still
have to pass CrossLayerAssemblyV17.checkActualRow/checkSpans.
-/
def buildBucketWork (i : FiniteCertificateV17.Inputs)
    (baseChecked : FiniteCertificateV17.checks i = true) (indexIds numericEdges honorEdges : ByteArray)
    (slots : Fin bucketCount → BlockPlanCheck.Bucket) (source : GeneralIndex.Bucket)
    (sourceAccepted : checkSource i indexIds source = true)
    (targetAccepted : checkBank i indexIds slots = true)
    (coverage : GroupNextCoverage.Data)
    (coverageAccepted : GroupNextCoverage.check (groupData (bank i indexIds slots).bank)
      (CachedPackedCheck.ofCertificate (FiniteCertificateV17.build i baseChecked)
        (successorData numericEdges honorEdges)) coverage = true)
    (rows : Array RowProposal) (fallback : RowProposal) (spans : List RowScheduleV13.Chunk) :
    BucketWork (FiniteCertificateV17.build i baseChecked) (successorData numericEdges honorEdges) source :=
  let sourceFacts := source_facts i baseChecked indexIds source sourceAccepted
  { next := bank i indexIds slots
    groupEq := groupEq i baseChecked indexIds slots
    targetMetadata := targetMetadata i baseChecked indexIds slots targetAccepted
    sourceGroups := sourceGroups i indexIds slots source sourceAccepted
    sourceChecked := sourceFacts.checked
    fits := sourceFacts.fits
    limits := sourceFacts.limits
    coverage := coverage
    coverageChecked := coverageAccepted
    propose := fun r => rows.getD r fallback
    spans := spans }

end Mahjong.FiniteMetadataV17

#print axioms Mahjong.FiniteMetadataV17.groupEq
#print axioms Mahjong.FiniteMetadataV17.source_facts
#print axioms Mahjong.FiniteMetadataV17.sourceGroups
#print axioms Mahjong.FiniteMetadataV17.targetMetadata
#print axioms Mahjong.FiniteMetadataV17.successorsChecked
#print axioms Mahjong.FiniteMetadataV17.constructedTables_checked
#print axioms Mahjong.FiniteMetadataV17.buildBucketWork
