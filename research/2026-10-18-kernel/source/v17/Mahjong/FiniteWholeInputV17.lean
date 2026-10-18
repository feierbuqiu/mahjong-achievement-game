import Mahjong.FiniteMetadataV17
import Mahjong.RuntimeBindingV17

set_option autoImplicit false

/-!+# A pure, proof-producing entry point with only raw finite inputs

Inputs contain no Candidate, Certificate, Checked proof, row soundness
function, NormalStrategy, or TargetCorrect. The only theorem premises below
are accepting equations for four explicitly named pure Boolean checks on
those inputs. All non-Boolean metadata obligations are constructed internally.

The per-row Array is a FINITE REFERENCE MODEL. It does not prescribe a
production allocation of one plan/proposal record for every game row. In
particular, checkActualRow also repeats preparation checks in this reference
model; an optimized RuntimeScan needs a separate refinement proof. This module
does not run either model, start a scan, or assert any actual table acceptance.

An Option proof returned by certify is mathematical proof-producing code.
Proof erasure in a native executable is not a way to import a process report
or Python PASS as a closed Lean proof of acceptance for the actual input.
-/

namespace Mahjong.FiniteWholeInputV17

open SafeGame CrossLayerAssemblyV17

/-- All cell fields are raw finite data. Coverage outside the supplied arrays
defaults to the empty key list and is still subject to the full coverage
checker. The row fallback likewise acquires no correctness by being present.
-/
structure RawCell where
  targets : Fin bucketCount → BlockPlanCheck.Bucket
  coverage : Array (Array (List Nat))
  rows : Array RowProposal
  fallback : RowProposal
  spans : List RowScheduleV13.Chunk

structure Inputs where
  base : FiniteCertificateV17.Inputs
  indexIds : ByteArray
  numericEdges : ByteArray
  honorEdges : ByteArray
  sources : Fin layerCount → Fin bucketCount → GeneralIndex.Bucket
  cells : Fin layerCount → Fin bucketCount → RawCell

def coverageData (cell : RawCell) : GroupNextCoverage.Data :=
  ⟨fun axis key => (cell.coverage.getD axis #[]).getD key []⟩

def data (i : Inputs) : Nat → SuccessorCache.Data :=
  FiniteMetadataV17.successorData i.numericEdges i.honorEdges

/-- The raw, proof-free local data used by metadata checks. Its equality to
the data in the constructed common certificate is definitional, not a new
caller-supplied equality or semantic assumption. -/
def localData (i : Inputs) : CachedPackedCheck.Local :=
  ⟨FiniteCertificateV17.tables i.base, FiniteCertificateV17.inventories i.base, data i⟩

abbrev baseChecks (i : Inputs) : Bool := FiniteCertificateV17.checks i.base

abbrev successorChecks (i : Inputs) : Bool :=
  FiniteMetadataV17.checkSuccessors i.base i.numericEdges i.honorEdges

theorem localData_binding (i : Inputs) (baseChecked : baseChecks i = true) :
    localData i = CachedPackedCheck.ofCertificate (FiniteCertificateV17.build i.base baseChecked) (data i) := rfl

/-- Empty source cells do not need any work object. Every nonempty cell must
check its own exact source bytes, every loaded target's metadata, and the
complete reachable-key coverage, including SAFE-false keys. -/
def checkCellMetadata (i : Inputs) (n : Fin layerCount) (h : Fin bucketCount) : Bool :=
  let source := i.sources n h
  let cell := i.cells n h
  if 0 < source.data.size then
    FiniteMetadataV17.checkSource i.base i.indexIds source &&
      FiniteMetadataV17.checkBank i.base i.indexIds cell.targets &&
      GroupNextCoverage.check
        (BlockPlanCheck.groupData (FiniteMetadataV17.bank i.base i.indexIds cell.targets).bank)
        (localData i) (coverageData cell)
  else true

def checkMetadata (i : Inputs) : Bool :=
  (List.finRange layerCount).all fun n =>
    (List.finRange bucketCount).all (checkCellMetadata i n)

theorem checked_metadata_cell (i : Inputs) (metadataChecked : checkMetadata i = true)
    (n : Fin layerCount) (h : Fin bucketCount) (positive : 0 < (i.sources n h).data.size) :
    FiniteMetadataV17.checkSource i.base i.indexIds (i.sources n h) = true ∧
      FiniteMetadataV17.checkBank i.base i.indexIds (i.cells n h).targets = true ∧
      GroupNextCoverage.check
        (BlockPlanCheck.groupData (FiniteMetadataV17.bank i.base i.indexIds (i.cells n h).targets).bank)
        (localData i) (coverageData (i.cells n h)) = true := by
  have layer := List.all_eq_true.mp metadataChecked n (by simp)
  have cell := List.all_eq_true.mp layer h (by simp)
  simpa only [checkCellMetadata, positive, ↓reduceIte, Bool.and_eq_true, and_assoc] using cell

/-- All typed index, source/target, word-bound, shared-data and coverage
premises in BucketWork are constructed from the explicit raw-input checks.
TargetCorrect is not a field, parameter, or construction assumption.
-/
def buildTable (i : Inputs) (baseChecked : baseChecks i = true)
    (metadataChecked : checkMetadata i = true) :
    Candidate (FiniteCertificateV17.build i.base baseChecked) (data i) where
  sources := i.sources
  work := fun n h positive =>
    let cell := i.cells n h
    let checked := checked_metadata_cell i metadataChecked n h positive
    FiniteMetadataV17.buildBucketWork i.base baseChecked i.indexIds i.numericEdges i.honorEdges
      cell.targets (i.sources n h) checked.1 checked.2.1 (coverageData cell)
      checked.2.2 cell.rows cell.fallback cell.spans

/-- The complete theorem has exactly four finite Boolean acceptance inputs.
The final goal is the original shared-table achievement game and its actual
empty state, rather than an abstract graph or a weakened P/N statement.
-/
theorem sound (i : Inputs)
    (baseChecked : baseChecks i = true)
    (successorsChecked : successorChecks i = true)
    (metadataChecked : checkMetadata i = true)
    (rowsAndRootChecked : RuntimeBindingV17.check (buildTable i baseChecked metadataChecked) = true) :
    SecondPlayerWins Step Win empty := by
  exact RuntimeBindingV17.sound (FiniteCertificateV17.build i.base baseChecked) (data i)
    (FiniteMetadataV17.successorsChecked i.base baseChecked i.numericEdges i.honorEdges successorsChecked)
    (buildTable i baseChecked metadataChecked) rowsAndRootChecked

/-- The ordered decision procedure. A failed or unknown predecessor cannot
be bypassed by supplying a Candidate or an externally supplied success flag.
-/
def accepted (i : Inputs) : Bool :=
  if baseChecked : baseChecks i = true then
    if successorChecks i = true then
      if metadataChecked : checkMetadata i = true then
        RuntimeBindingV17.check (buildTable i baseChecked metadataChecked)
      else false
    else false
  else false

theorem accepted_parts (i : Inputs) (result : accepted i = true) :
    ∃ (baseChecked : baseChecks i = true)
      (_successorsChecked : successorChecks i = true)
      (metadataChecked : checkMetadata i = true),
      RuntimeBindingV17.check (buildTable i baseChecked metadataChecked) = true := by
  unfold accepted at result
  split at result
  next baseChecked =>
    split at result
    next successorsChecked =>
      split at result
      next metadataChecked => exact ⟨baseChecked, successorsChecked, metadataChecked, result⟩
      next rejected => cases result
    next rejected => cases result
  next rejected => cases result

theorem accepted_sound (i : Inputs) (result : accepted i = true) :
    SecondPlayerWins Step Win empty := by
  obtain ⟨baseChecked, successorsChecked, metadataChecked, rowsAndRootChecked⟩ := accepted_parts i result
  exact sound i baseChecked successorsChecked metadataChecked rowsAndRootChecked

/-- A successful return contains the original-game proof. Every preceding
test is evaluated in order before the complete row/root test is eligible.
No untrusted producer is used as a source of proof objects.
-/
def certify (i : Inputs) : Option (PLift (SecondPlayerWins Step Win empty)) :=
  if baseChecked : baseChecks i = true then
    if successorsChecked : successorChecks i = true then
      if metadataChecked : checkMetadata i = true then
        if rowsAndRootChecked : RuntimeBindingV17.check (buildTable i baseChecked metadataChecked) = true then
          some ⟨sound i baseChecked successorsChecked metadataChecked rowsAndRootChecked⟩
        else none
      else none
    else none
  else none

theorem certify_isSome (i : Inputs) : (certify i).isSome = accepted i := by
  by_cases baseChecked : baseChecks i = true
  · by_cases successorsChecked : successorChecks i = true
    · by_cases metadataChecked : checkMetadata i = true
      · by_cases rowsAndRootChecked : RuntimeBindingV17.check (buildTable i baseChecked metadataChecked) = true
        · simp [certify, accepted, baseChecked, successorsChecked, metadataChecked, rowsAndRootChecked]
        · have failed := Bool.eq_false_iff.mpr rowsAndRootChecked
          simp [certify, accepted, baseChecked, successorsChecked, metadataChecked, failed]
      · simp [certify, accepted, baseChecked, successorsChecked, metadataChecked]
    · simp [certify, accepted, baseChecked, successorsChecked]
  · simp [certify, accepted, baseChecked]

theorem certified_result_sound (i : Inputs) (result : (certify i).isSome = true) :
    SecondPlayerWins Step Win empty :=
  accepted_sound i ((certify_isSome i).symm.trans result)

theorem rejection (i : Inputs) (failed : accepted i = false) : certify i = none := by
  cases output : certify i with
  | none => rfl
  | some proof =>
    have impossible := certify_isSome i
    simp only [output, Option.isSome_some, failed] at impossible
    cases impossible

end Mahjong.FiniteWholeInputV17

#print axioms Mahjong.FiniteWholeInputV17.localData_binding
#print axioms Mahjong.FiniteWholeInputV17.checked_metadata_cell
#print axioms Mahjong.FiniteWholeInputV17.buildTable
#print axioms Mahjong.FiniteWholeInputV17.sound
#print axioms Mahjong.FiniteWholeInputV17.accepted_parts
#print axioms Mahjong.FiniteWholeInputV17.accepted_sound
#print axioms Mahjong.FiniteWholeInputV17.certify_isSome
#print axioms Mahjong.FiniteWholeInputV17.certified_result_sound
#print axioms Mahjong.FiniteWholeInputV17.rejection
