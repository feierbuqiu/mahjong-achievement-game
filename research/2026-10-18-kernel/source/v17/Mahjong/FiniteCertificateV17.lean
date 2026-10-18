import Mahjong.GlobalEnumeration
import Mahjong.WordLimits

set_option autoImplicit false

/-! A certificate constructor from raw finite data and executable checks.

Inputs contain no semantic propositions or preconstructed Certificate. Numeric
files are shared by definition for the three suits. Every other certificate
premise is obtained from an explicitly bounded Boolean check. This module does
not assert that the checks have been executed on any historical input files.
-/

namespace Mahjong.FiniteCertificateV17

open GlobalOrbitUniqueness

structure LocalFiles where
  core : ByteArray
  summary : ByteArray
  raw : ByteArray
  ids : ByteArray
  members : ByteArray

structure BoundFiles where
  entries : ByteArray
  index : ByteArray

structure HonorFiles where
  rows : Array HonorDirectory.Entry
  lookup : Array Nat

structure Inputs where
  numeric : LocalFiles
  honor : LocalFiles
  numericRecords : ByteArray
  groupRecords : ByteArray
  numericBound : BoundFiles
  honorBound : BoundFiles
  twoBound : BoundFiles
  threeBound : BoundFiles
  fourBound : BoundFiles
  tripleKeys : ByteArray
  tripleLabels : ByteArray
  honorDirectories : Array HonorFiles

def select (numeric honor : ByteArray) (b : Nat) : ByteArray :=
  if b = 3 then honor else numeric

def core (i : Inputs) : Nat → ByteArray := select i.numeric.core i.honor.core
def summary (i : Inputs) : Nat → ByteArray := select i.numeric.summary i.honor.summary
def raw (i : Inputs) : Nat → ByteArray := select i.numeric.raw i.honor.raw
def ids (i : Inputs) : Nat → ByteArray := select i.numeric.ids i.honor.ids
def members (i : Inputs) : Nat → ByteArray := select i.numeric.members i.honor.members

def tables (i : Inputs) : FullSafeData.Tables := Base5Coverage.tables (core i) (summary i) (raw i)
def inventories (i : Inputs) : CanonicalCoverage.Inventories :=
  CanonicalCoverage.inventories (raw i) (ids i) (members i)
def groups (i : Inputs) : GroupInventory.Data :=
  GroupInventory.candidate i.numericRecords i.groupRecords (raw i 0) (members i 0)
def envelope (b : BoundFiles) : SafeLayerBound.Envelope := SafeLayerBound.candidate b.entries b.index
def triples (i : Inputs) : TripleDirectory.Data := TripleDirectory.candidate i.tripleKeys i.tripleLabels
def honors (i : Inputs) (h : Nat) : HonorDirectory.Data :=
  let files := i.honorDirectories.getD h ⟨#[],#[]⟩
  HonorDirectory.candidate files.rows files.lookup

def localChecks (i : Inputs) (b : Nat) : Bool :=
  decide ((core i b).size = Base5Coverage.size b) &&
  (LocalCache.check b (tables i b).summary.core && LocalSummary.check b (tables i b).summary) &&
  FullSafeData.checkSpan b (tables i b) 0 (tables i b).summary.core.size &&
  decide ((inventories i b).size = Base5Coverage.size b) &&
  (CanonicalInventory.checkSpan (CanonicalInventory.checkRow b (inventories i b)) 0 (inventories i b).size &&
    CanonicalInventory.checkSpan (CanonicalInventory.checkMember (inventories i b)) 0 (inventories i b).count) &&
  CanonicalInventory.checkSpan
    (SafeLayerBound.checkRaw (if b = 3 then envelope i.honorBound else envelope i.numericBound) (raw i b))
    0 (Base5Coverage.size b)

def allLocalChecks (i : Inputs) : Bool := (List.range 4).all (localChecks i)

def groupChecks (i : Inputs) : Bool :=
  decide ((groups i).count = (inventories i 0).count) &&
  CanonicalInventory.checkSpan (GroupInventory.checkMember (groups i)) 0 (groups i).count &&
  CanonicalInventory.checkSpan (GroupInventory.checkGroup (groups i)) 0 (groups i).groups

def boundChecks (i : Inputs) : Bool :=
  SafeLayerBound.checkJoin (envelope i.numericBound) (envelope i.numericBound) (envelope i.twoBound) &&
  SafeLayerBound.checkJoin (envelope i.twoBound) (envelope i.numericBound) (envelope i.threeBound) &&
  SafeLayerBound.checkJoin (envelope i.threeBound) (envelope i.honorBound) (envelope i.fourBound) &&
  SafeLayerBound.checkFinal (envelope i.fourBound) 34

def tripleChecks (i : Inputs) : Bool :=
  CanonicalInventory.checkSpan (TripleDirectory.checkRow (groups i) (triples i)) 0 (triples i).count &&
  CanonicalInventory.checkSpan (TripleDirectory.checkA (groups i) (triples i)) 0 (groups i).groups

def honorChecks (i : Inputs) (h : Nat) : Bool :=
  let label := PruningData.rawLabel (raw i 3) ((inventories i 3).member h)
  CanonicalInventory.checkSpan (HonorDirectory.checkRow (groups i) (triples i) label (honors i h))
    0 (honors i h).count &&
  CanonicalInventory.checkSpan (HonorDirectory.checkCandidate (triples i) label (honors i h)) 0 (triples i).count

def directoryChecks (i : Inputs) : Bool :=
  decide (i.honorDirectories.size = (inventories i 3).count) &&
  (List.range (inventories i 3).count).all (honorChecks i)

/-- Physical record sizes are checked as well as the semantic row predicates.
No trailing partial record or missing per-honor lookup vector is accepted. -/
def layoutChecks (i : Inputs) : Bool :=
  (List.range 4).all (fun b =>
    decide ((summary i b).size = 4 * (core i b).size) &&
    decide ((raw i b).size = 12 * Base5Coverage.size b) &&
    decide ((ids i b).size = 4 * Base5Coverage.size b) &&
    decide ((members i b).size % 4 = 0)) &&
  decide (i.numericRecords.size % 12 = 0) && decide (i.groupRecords.size % 8 = 0) &&
  decide (i.tripleKeys.size % 12 = 0) && decide (i.tripleLabels.size = 12 * (triples i).count) &&
  (List.range i.honorDirectories.size).all (fun h =>
    decide ((i.honorDirectories.getD h ⟨#[],#[]⟩).lookup.size = (triples i).count)) &&
  [i.numericBound,i.honorBound,i.twoBound,i.threeBound,i.fourBound].all (fun b =>
    decide (b.entries.size % 8 = 0) && decide (b.index.size % 4 = 0))

/-- The same finite group word bounds used by the existing guarded native row.
Per-bucket prefix/index/UInt64 bounds are separate source/target obligations. -/
def wordChecks (i : Inputs) : Bool :=
  decide (i.groupRecords.size / 8 = 1104) && decide (i.numericRecords.size / 12 = 131676) &&
  CanonicalInventory.checkSpan (IndexHelperCheck.groupRow i.groupRecords) 0 1104

def checks (i : Inputs) : Bool :=
  allLocalChecks i && groupChecks i && boundChecks i && tripleChecks i &&
  directoryChecks i && layoutChecks i && wordChecks i

private theorem checks_parts (i : Inputs) (checked : checks i = true) :
    allLocalChecks i = true ∧ groupChecks i = true ∧ boundChecks i = true ∧
    tripleChecks i = true ∧ directoryChecks i = true ∧ layoutChecks i = true ∧ wordChecks i = true := by
  simpa only [checks,Bool.and_eq_true,and_assoc] using checked

private theorem local_facts (i : Inputs) (b : Nat) (checked : localChecks i b = true) :
    (core i b).size = Base5Coverage.size b ∧
    PruningData.Checked b (tables i b).summary ∧
    FullSafeData.checkSpan b (tables i b) 0 (tables i b).summary.core.size = true ∧
    (inventories i b).size = Base5Coverage.size b ∧
    CanonicalInventory.Checked b (inventories i b) ∧
    CanonicalInventory.checkSpan
      (SafeLayerBound.checkRaw (if b = 3 then envelope i.honorBound else envelope i.numericBound) (raw i b))
      0 (Base5Coverage.size b) = true := by
  simpa only [localChecks,PruningData.Checked,CanonicalInventory.Checked,
    Bool.and_eq_true,decide_eq_true_eq,and_assoc] using checked

private theorem each_local (i : Inputs) (checked : allLocalChecks i = true) (b : Nat) (hb : b < 4) :
    localChecks i b = true :=
  List.all_eq_true.mp checked b (List.mem_range.mpr hb)

private theorem group_facts (i : Inputs) (checked : groupChecks i = true) :
    (groups i).count = (inventories i 0).count ∧ GroupInventory.Checked (groups i) := by
  simpa only [groupChecks,GroupInventory.Checked,Bool.and_eq_true,decide_eq_true_eq,and_assoc] using checked

private theorem bound_facts (i : Inputs) (checked : boundChecks i = true) :
    SafeLayerBound.checkJoin (envelope i.numericBound) (envelope i.numericBound) (envelope i.twoBound) = true ∧
    SafeLayerBound.checkJoin (envelope i.twoBound) (envelope i.numericBound) (envelope i.threeBound) = true ∧
    SafeLayerBound.checkJoin (envelope i.threeBound) (envelope i.honorBound) (envelope i.fourBound) = true ∧
    SafeLayerBound.checkFinal (envelope i.fourBound) 34 = true := by
  simpa only [boundChecks,Bool.and_eq_true,and_assoc] using checked

private theorem raw_shared (i : Inputs) (b : Nat) (hb : b < 3) : raw i b = raw i 0 := by
  have ne : b ≠ 3 := by omega
  simp [raw,select,ne]

private theorem ids_shared (i : Inputs) (b : Nat) (hb : b < 3) : ids i b = ids i 0 := by
  have ne : b ≠ 3 := by omega
  simp [ids,select,ne]

private theorem members_shared (i : Inputs) (b : Nat) (hb : b < 3) : members i b = members i 0 := by
  have ne : b ≠ 3 := by omega
  simp [members,select,ne]

/-- Construct every original Certificate field from the finite Boolean checks.
There is no supplied Checked, Link, shared-function equality, or semantic
correctness proposition in Inputs. -/
def build (i : Inputs) (checked : checks i = true) : GlobalEnumeration.Certificate := by
  have parts := checks_parts i checked
  have gf := group_facts i parts.2.1
  have bf := bound_facts i parts.2.2.1
  have tf : TripleDirectory.Checked (groups i) (triples i) := by
    simpa only [tripleChecks,TripleDirectory.Checked,Bool.and_eq_true] using parts.2.2.2.1
  have df : i.honorDirectories.size = (inventories i 3).count ∧
      (List.range (inventories i 3).count).all (honorChecks i) = true := by
    simpa only [directoryChecks,Bool.and_eq_true,decide_eq_true_eq] using parts.2.2.2.2.1
  exact {
    core := core i
    summary := summary i
    raw := raw i
    ids := ids i
    members := members i
    coreSizes := by
      intro b hb
      exact (local_facts i b (each_local i parts.1 b hb)).1
    safeChecked := by
      intro b hb
      have facts := local_facts i b (each_local i parts.1 b hb)
      exact ⟨facts.2.1,facts.2.2.1⟩
    inventorySizes := by
      intro b hb
      exact (local_facts i b (each_local i parts.1 b hb)).2.2.2.1
    inventoryChecked := by
      intro b hb
      exact (local_facts i b (each_local i parts.1 b hb)).2.2.2.2.1
    sharedMembers := SortedCoverage.shared_of_same_files (raw i) (ids i) (members i) (members_shared i)
    sharedKeys := GlobalOrbitKey.shared_of_same_files (raw i) (ids i) (members i) (raw_shared i) (ids_shared i)
    groups := groups i
    groupChecked := gf.2
    link := by
      refine ⟨gf.1,rfl,?_⟩
      intro b hb
      change PruningData.rawLabel (raw i 0) = PruningData.rawLabel (raw i b)
      rw [raw_shared i b hb]
    numericBound := envelope i.numericBound
    honorBound := envelope i.honorBound
    twoBound := envelope i.twoBound
    threeBound := envelope i.threeBound
    fourBound := envelope i.fourBound
    localBound := by
      intro b hb
      exact (local_facts i b (each_local i parts.1 b hb)).2.2.2.2.2
    twoChecked := bf.1
    threeChecked := bf.2.1
    fourChecked := bf.2.2.1
    finalChecked := bf.2.2.2
    triples := triples i
    honors := honors i
    tripleChecked := tf
    directoryChecked := by
      intro h hh
      have row := List.all_eq_true.mp df.2 h (List.mem_range.mpr hh)
      simpa only [honorChecks,HonorDirectory.Checked,Bool.and_eq_true,inventories] using row
  }

/-- Explicit data identity, including entire functions rather than only values
inside a finite tested interval. The functions all come from the input bytes. -/
structure DataBinding (i : Inputs) (c : GlobalEnumeration.Certificate) : Prop where
  core : c.core = core i
  summary : c.summary = summary i
  raw : c.raw = raw i
  ids : c.ids = ids i
  members : c.members = members i
  groups : c.groups = groups i
  numericBound : c.numericBound = envelope i.numericBound
  honorBound : c.honorBound = envelope i.honorBound
  twoBound : c.twoBound = envelope i.twoBound
  threeBound : c.threeBound = envelope i.threeBound
  fourBound : c.fourBound = envelope i.fourBound
  triples : c.triples = triples i
  honors : c.honors = honors i

theorem build_binding (i : Inputs) (checked : checks i = true) : DataBinding i (build i checked) := by
  exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩

theorem sound (i : Inputs) (checked : checks i = true) :
    ∃ c : GlobalEnumeration.Certificate, DataBinding i c :=
  ⟨build i checked,build_binding i checked⟩

theorem groups_fit (i : Inputs) (checked : checks i = true) : WordLimits.GroupsFit (build i checked).groups := by
  have word := (checks_parts i checked).2.2.2.2.2.2
  have facts : i.groupRecords.size / 8 = 1104 ∧ i.numericRecords.size / 12 = 131676 ∧
      CanonicalInventory.checkSpan (IndexHelperCheck.groupRow i.groupRecords) 0 1104 = true := by
    simpa only [wordChecks,Bool.and_eq_true,decide_eq_true_eq,and_assoc] using word
  exact WordLimits.groups_from_checks i.numericRecords i.groupRecords (raw i 0) (members i 0)
    facts.1 facts.2.1 facts.2.2

/-- Existing complete-enumeration semantics can now be invoked from finite
checks on raw Inputs, not from an assumed semantic Certificate value. -/
theorem enumeration_correct (i : Inputs) (checked : checks i = true) (seed : Nat → Nat) :
    (∀ a, GlobalEnumeration.ValidSlot (build i checked) a →
      Valid (GlobalEnumeration.decode seed (build i checked) a) ∧
      IsSafe (GlobalEnumeration.decode seed (build i checked) a)) ∧
    (∀ s, Valid s → IsSafe s → ∃ a, GlobalEnumeration.ValidSlot (build i checked) a ∧
      SameOrbit s (GlobalEnumeration.decode seed (build i checked) a)) ∧
    (∀ a b, GlobalEnumeration.ValidSlot (build i checked) a →
      GlobalEnumeration.ValidSlot (build i checked) b →
      (SameOrbit (GlobalEnumeration.decode seed (build i checked) a)
        (GlobalEnumeration.decode seed (build i checked) b) ↔ a = b)) :=
  GlobalEnumeration.enumeration_correct seed (build i checked)

end Mahjong.FiniteCertificateV17

#print axioms Mahjong.FiniteCertificateV17.build_binding
#print axioms Mahjong.FiniteCertificateV17.sound
#print axioms Mahjong.FiniteCertificateV17.groups_fit
#print axioms Mahjong.FiniteCertificateV17.enumeration_correct
