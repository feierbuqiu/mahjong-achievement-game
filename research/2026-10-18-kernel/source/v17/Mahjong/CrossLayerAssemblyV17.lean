import Mahjong.IndexedByteRowSafeV17
import Mahjong.RowScheduleV13

set_option autoImplicit false

/-!+# Finite assembly of the actual indexed-byte row checks

This module proves an implication from actual pure-checker acceptance. It does
not manufacture the acceptance proof from a process exit, JSON receipt, hash,
or Python registry. In particular, none of the final theorems assumes
`TargetCorrect`, `NormalStrategy`, or a semantic soundness proposition for the
untrusted row producer.

The source matrix has exactly 35 layers and 184 buckets per layer. A target
bank has exactly 184 possible slots, with size zero outside them. Every loaded
nonempty target slot is compared, field by field INCLUDING its actual bits,
with the source bucket in the next layer. Missing target slots are harmless
only when the unchanged row checker accepts: a P row still checks ALL actual
SAFE successors, and an N row still checks an actual successor-list member.

The finite local/enumeration and source/target metadata premises are exposed
as typed certificate fields. They still have to be constructed for the actual
input bytes. Acceptance of every row of every nonempty bucket, including the
historically imported top layers, also remains to be instantiated. This file
alone is therefore not an unconditional empty-position result.
-/

namespace Mahjong.CrossLayerAssemblyV17

open SafeGame GeneralLayer Generators PackedRules GroupCandidates
open BlockPlanCheck GlobalEnumeration CanonicalInventory
open BlockPlanCertifiedRow (sourceModel)

abbrev layerCount : Nat := 35
abbrev bucketCount : Nat := 184

/-! ## Exact adjacent span composition -/

/-- A pure checked chain starts at `cursor`, ends at `stop`, and checks every
row in each half-open chunk. Zero-width chunks cannot create progress. The
last equality prevents a missing tail from being accepted. -/
def checkSpans (row : Nat → Bool) (stop : Nat) : Nat → List RowScheduleV13.Chunk → Bool
  | cursor, [] => decide (cursor = stop)
  | cursor, part :: rest =>
      decide (part.first = cursor) && checkSpan row part.first part.count &&
        checkSpans row stop (part.first + part.count) rest

theorem checkSpans_total (row : Nat → Bool) (parts : List RowScheduleV13.Chunk)
    (cursor stop : Nat) (accepted : checkSpans row stop cursor parts = true) :
    stop = cursor + (parts.map RowScheduleV13.Chunk.count).sum := by
  induction parts generalizing cursor with
  | nil =>
    have same : cursor = stop := of_decide_eq_true accepted
    simpa using same.symm
  | cons part rest ih =>
    have h : (part.first = cursor ∧ checkSpan row part.first part.count = true) ∧
        checkSpans row stop (part.first + part.count) rest = true := by
      simpa only [checkSpans, Bool.and_eq_true, decide_eq_true_eq] using accepted
    have tail := ih (part.first + part.count) h.2
    simp only [List.map_cons, List.sum_cons]
    omega

/-- Every requested absolute row is checked; no prefix-only acceptance can
supply this statement when `stop` is the actual bucket size. -/
theorem checkSpans_each (row : Nat → Bool) (parts : List RowScheduleV13.Chunk)
    (cursor stop : Nat) (accepted : checkSpans row stop cursor parts = true)
    (r : Nat) (lower : cursor ≤ r) (upper : r < stop) : row r = true := by
  induction parts generalizing cursor with
  | nil =>
    have same : cursor = stop := of_decide_eq_true accepted
    omega
  | cons part rest ih =>
    have h : (part.first = cursor ∧ checkSpan row part.first part.count = true) ∧
        checkSpans row stop (part.first + part.count) rest = true := by
      simpa only [checkSpans, Bool.and_eq_true, decide_eq_true_eq] using accepted
    by_cases here : r < part.first + part.count
    · have offset : r - part.first < part.count := by omega
      have checked := checkSpan_each row part.count part.first h.1.2 (r - part.first) offset
      have same : part.first + (r - part.first) = r := by omega
      simpa only [same] using checked
    · exact ih (part.first + part.count) h.2 (by omega)

theorem checkSpans_bounds (row : Nat → Bool) (parts : List RowScheduleV13.Chunk)
    (cursor stop : Nat) (accepted : checkSpans row stop cursor parts = true) :
    ∀ part, part ∈ parts → cursor ≤ part.first ∧ part.first + part.count ≤ stop := by
  induction parts generalizing cursor with
  | nil => intro part absent; cases absent
  | cons part rest ih =>
    have h : (part.first = cursor ∧ checkSpan row part.first part.count = true) ∧
        checkSpans row stop (part.first + part.count) rest = true := by
      simpa only [checkSpans, Bool.and_eq_true, decide_eq_true_eq] using accepted
    have tailTotal := checkSpans_total row rest (part.first + part.count) stop h.2
    intro q member
    rcases List.mem_cons.mp member with same | tail
    · subst q
      constructor <;> omega
    · have bounds := ih (part.first + part.count) h.2 q tail
      constructor <;> omega

/-- In the listed order, any later chunk starts after the entire preceding
chunk. Together with `checkSpans_each` and `checkSpans_total`, this is an exact
coverage result, rather than a sum-of-counts heuristic. -/
theorem checkSpans_disjoint (row : Nat → Bool) (parts : List RowScheduleV13.Chunk)
    (cursor stop : Nat) (accepted : checkSpans row stop cursor parts = true) :
    parts.Pairwise (fun a b => a.first + a.count ≤ b.first) := by
  induction parts generalizing cursor with
  | nil => exact List.Pairwise.nil
  | cons part rest ih =>
    have h : (part.first = cursor ∧ checkSpan row part.first part.count = true) ∧
        checkSpans row stop (part.first + part.count) rest = true := by
      simpa only [checkSpans, Bool.and_eq_true, decide_eq_true_eq] using accepted
    apply List.pairwise_cons.mpr
    constructor
    · intro q member
      exact (checkSpans_bounds row rest (part.first + part.count) stop h.2 q member).1
    · exact ih (part.first + part.count) h.2

/-! ## Byte-exact source and target identity -/

/-- Compare all fields used by the actual legacy decoder and bit lookup.
Neither a matching file name nor equality of P/N counts is sufficient. -/
def sameBucket (a b : GeneralIndex.Bucket) : Bool :=
  decide (a.data.numeric = b.data.numeric ∧ a.data.ids = b.data.ids ∧
    a.data.groups = b.data.groups ∧ a.data.directory = b.data.directory ∧
    a.data.honorCode = b.data.honorCode ∧ a.data.size = b.data.size ∧ a.bits = b.bits)

theorem sameBucket_sound (a b : GeneralIndex.Bucket)
    (accepted : sameBucket a b = true) : a = b := by
  rcases a with ⟨⟨an, ai, ag, ad, ah, az⟩, ab⟩
  rcases b with ⟨⟨bn, bi, bg, bd, bh, bz⟩, bb⟩
  have h : an = bn ∧ ai = bi ∧ ag = bg ∧ ad = bd ∧ ah = bh ∧ az = bz ∧ ab = bb :=
    of_decide_eq_true accepted
  rcases h with ⟨rfl, rfl, rfl, rfl, rfl, rfl, rfl⟩
  rfl

def emptyTargetBucket : BlockPlanCheck.Bucket := ⟨ByteArray.empty, 0, 0, ByteArray.empty⟩

/-- Intrinsically finite target slots: outside bucket 0..183 there is no row
whose correctness could accidentally be supplied by a default label. -/
structure FiniteBank where
  shared : BlockPlanCheck.Shared
  slots : Fin bucketCount → BlockPlanCheck.Bucket

def FiniteBank.bank (d : FiniteBank) : BlockPlanCheck.Bank where
  shared := d.shared
  buckets := fun h => if inside : h < bucketCount then d.slots ⟨h, inside⟩ else emptyTargetBucket

theorem FiniteBank.outside_size (d : FiniteBank) (h : Nat) (outside : ¬ h < bucketCount) :
    (legacyBucket d.bank h).data.size = 0 := by
  simp only [legacyBucket, FiniteBank.bank, outside, ↓reduceDIte, emptyTargetBucket]

/-- Finite metadata required by the unchanged row theorem. The fields here
are index/cache/bounds checks and representation equalities, not P/N facts.
The producer's coordinates and byte remain completely untrusted. -/
structure RowProposal where
  view : SourceBlockGuard.View
  context : BlockPlanCheck.Context
  tables : GeneratedPlanCheck.Tables
  ids : Triple
  byte : UInt8

structure BucketWork (c : GlobalEnumeration.Certificate) (data : Nat → SuccessorCache.Data)
    (source : GeneralIndex.Bucket) where
  next : FiniteBank
  groupEq : groupData next.bank = c.groups
  targetMetadata : GuardedTargetRef.Checked (guardedBank next.bank)
  sourceGroups : (sourceModel next.bank source.data).groups = groupData next.bank
  sourceChecked : IndexOperations.Checked (sourceModel next.bank source.data)
  fits : WordLimits.GroupsFit (sourceModel next.bank source.data).groups
  limits : WordLimits.bucketFits (sourceModel next.bank source.data).directory.blocks source.data.size = true
  coverage : GroupNextCoverage.Data
  coverageChecked : GroupNextCoverage.check (groupData next.bank)
    (CachedPackedCheck.ofCertificate c data) coverage = true
  propose : Nat → RowProposal
  spans : List RowScheduleV13.Chunk

/-- Empty buckets need no row witnesses. Every nonempty source bucket does,
including top-layer seeds or buckets historically imported by Python. -/
structure Candidate (c : GlobalEnumeration.Certificate) (data : Nat → SuccessorCache.Data) where
  sources : Fin layerCount → Fin bucketCount → GeneralIndex.Bucket
  work : ∀ n h, 0 < (sources n h).data.size → BucketWork c data (sources n h)

def sourceAt {c : GlobalEnumeration.Certificate} {data : Nat → SuccessorCache.Data}
    (table : Candidate c data) (n h : Nat) : GeneralIndex.Bucket :=
  if nl : n < layerCount then
    if hb : h < bucketCount then table.sources ⟨n, nl⟩ ⟨h, hb⟩ else GeneralIndex.emptyBucket
  else GeneralIndex.emptyBucket

theorem sourceAt_outside_layer {c : GlobalEnumeration.Certificate} {data : Nat → SuccessorCache.Data}
    (table : Candidate c data) (n h : Nat) (outside : ¬ n < layerCount) :
    (sourceAt table n h).data.size = 0 := by
  simp only [sourceAt, outside, ↓reduceDIte, GeneralIndex.emptyBucket]

theorem sourceAt_outside_bucket {c : GlobalEnumeration.Certificate} {data : Nat → SuccessorCache.Data}
    (table : Candidate c data) (n h : Nat) (outside : ¬ h < bucketCount) :
    (sourceAt table n h).data.size = 0 := by
  by_cases nl : n < layerCount <;>
    simp only [sourceAt, nl, outside, ↓reduceDIte, GeneralIndex.emptyBucket]

def checkTargets {c : GlobalEnumeration.Certificate} {data : Nat → SuccessorCache.Data}
    (table : Candidate c data) (n : Nat) (bank : FiniteBank) : Bool :=
  (List.range bucketCount).all fun h =>
    if 0 < (legacyBucket bank.bank h).data.size then
      sameBucket (legacyBucket bank.bank h) (sourceAt table (n + 1) h)
    else true

theorem checkTargets_identity {c : GlobalEnumeration.Certificate} {data : Nat → SuccessorCache.Data}
    (table : Candidate c data) (n : Nat) (bank : FiniteBank)
    (accepted : checkTargets table n bank = true) (h : Nat) (inside : h < bucketCount)
    (nonempty : 0 < (legacyBucket bank.bank h).data.size) :
    legacyBucket bank.bank h = sourceAt table (n + 1) h := by
  have entry := List.all_eq_true.mp accepted h (List.mem_range.mpr inside)
  apply sameBucket_sound
  simpa only [nonempty, ↓reduceIte] using entry

/-! ## The actual row checker and finite full-table acceptance -/

/-- The last conjunct is exactly the unchanged indexed byte checker. Its
source flag is read from the actual source bits at this absolute row r.
Source/plan preparation is also checked; neither is a semantic hypothesis. -/
def checkActualRow (c : GlobalEnumeration.Certificate) (data : Nat → SuccessorCache.Data)
    (source : GeneralIndex.Bucket) (w : BucketWork c data source) (r : Nat) : Bool :=
  let p := w.propose r
  let localData := CachedPackedCheck.ofCertificate c data
  decide (p.context.honorCode = source.data.honorCode) &&
    SourceBlockGuard.check (sourceModel w.next.bank source.data) p.context.sourceBlock p.view &&
    GeneratedPlanCheck.checkPlan localData w.next.bank (sourceModel w.next.bank source.data)
      p.context w.coverage p.tables &&
    IndexedByteRowV16.check (BorrowedNextGeneratedHotPlan.build localData w.next.bank p.context p.tables)
      p.view p.context p.ids p.byte r (TerminalBucket.labelP source.bits r)

def checkBucket {c : GlobalEnumeration.Certificate} {data : Nat → SuccessorCache.Data}
    (table : Candidate c data) (n : Nat) (source : GeneralIndex.Bucket)
    (w : BucketWork c data source) : Bool :=
  checkTargets table n w.next && checkSpans (checkActualRow c data source w) source.data.size 0 w.spans

def checkCell {c : GlobalEnumeration.Certificate} {data : Nat → SuccessorCache.Data}
    (table : Candidate c data) (n h : Nat) : Bool :=
  if nl : n < layerCount then
    if hb : h < bucketCount then
      let source := table.sources ⟨n, nl⟩ ⟨h, hb⟩
      if positive : 0 < source.data.size then
        checkBucket table n source (table.work ⟨n, nl⟩ ⟨h, hb⟩ positive)
      else true
    else false
  else false

def check {c : GlobalEnumeration.Certificate} {data : Nat → SuccessorCache.Data}
    (table : Candidate c data) : Bool :=
  (List.range layerCount).all fun n => (List.range bucketCount).all (checkCell table n)

theorem checked_cell {c : GlobalEnumeration.Certificate} {data : Nat → SuccessorCache.Data}
    (table : Candidate c data) (accepted : check table = true)
    (n h : Nat) (nl : n < layerCount) (hb : h < bucketCount) : checkCell table n h = true := by
  have layer := List.all_eq_true.mp accepted n (List.mem_range.mpr nl)
  exact List.all_eq_true.mp layer h (List.mem_range.mpr hb)

def LayerSound {c : GlobalEnumeration.Certificate} {data : Nat → SuccessorCache.Data}
    (table : Candidate c data) (n : Nat) : Prop :=
  ∀ h r, r < (sourceAt table n h).data.size →
    IsSafe (Base5Coverage.unpack (BucketIndex.unrank (sourceAt table n h).data r)) ∧
    NormalStrategy SafeMove (Base5Coverage.unpack (BucketIndex.unrank (sourceAt table n h).data r))
      (outcome (TerminalBucket.labelP (sourceAt table n h).bits r))

/-- This is where target correctness is PRODUCED from the next checked layer
and actual byte identity. It is never an assumed field in Candidate. -/
theorem targets_of_next_layer {c : GlobalEnumeration.Certificate} {data : Nat → SuccessorCache.Data}
    (table : Candidate c data) (n : Nat) (bank : FiniteBank)
    (accepted : checkTargets table n bank = true) (next : LayerSound table (n + 1)) :
    TargetCorrect (FullSafeData.summaries (CachedPackedCheck.ofCertificate c data).rules)
      (GuardedTargetRef.target (guardedBank bank.bank)) := by
  intro h r bound
  change r < (legacyBucket bank.bank h).data.size at bound
  have nonempty : 0 < (legacyBucket bank.bank h).data.size := by omega
  have inside : h < bucketCount := by
    by_cases inside : h < bucketCount
    · exact inside
    · have zero := bank.outside_size h inside
      omega
  have same := checkTargets_identity table n bank accepted h inside nonempty
  change NormalStrategy SafeMove
    (Base5Coverage.unpack (BucketIndex.unrank (legacyBucket bank.bank h).data r))
    (outcome (TerminalBucket.labelP (legacyBucket bank.bank h).bits r))
  rw [same] at bound ⊢
  exact (next h r bound).2

theorem checked_actual_row_sound (c : GlobalEnumeration.Certificate) (data : Nat → SuccessorCache.Data)
    (cacheChecked : GlobalSuccessorBridge.Checked c data) (source : GeneralIndex.Bucket)
    (w : BucketWork c data source)
    (correct : TargetCorrect (FullSafeData.summaries (CachedPackedCheck.ofCertificate c data).rules)
      (GuardedTargetRef.target (guardedBank w.next.bank)))
    (r : Nat) (accepted : checkActualRow c data source w r = true) :
    r < source.data.size ∧
      IsSafe (Base5Coverage.unpack (BucketIndex.unrank source.data r)) ∧
      NormalStrategy SafeMove (Base5Coverage.unpack (BucketIndex.unrank source.data r))
        (outcome (TerminalBucket.labelP source.bits r)) := by
  have h : ((w.propose r).context.honorCode = source.data.honorCode ∧
      SourceBlockGuard.check (sourceModel w.next.bank source.data)
        (w.propose r).context.sourceBlock (w.propose r).view = true) ∧
      GeneratedPlanCheck.checkPlan (CachedPackedCheck.ofCertificate c data) w.next.bank
        (sourceModel w.next.bank source.data) (w.propose r).context w.coverage (w.propose r).tables = true := by
    have all := accepted
    simp only [checkActualRow, Bool.and_eq_true, decide_eq_true_eq] at all
    exact all.1
  have row : IndexedByteRowV16.check
      (BorrowedNextGeneratedHotPlan.build (CachedPackedCheck.ofCertificate c data) w.next.bank
        (w.propose r).context (w.propose r).tables)
      (w.propose r).view (w.propose r).context (w.propose r).ids (w.propose r).byte r
      (TerminalBucket.labelP source.bits r) = true := by
    have all := accepted
    simp only [checkActualRow, Bool.and_eq_true, decide_eq_true_eq] at all
    exact all.2
  exact IndexedByteRowSafeV17.sound c data cacheChecked w.next.bank w.groupEq w.targetMetadata correct
    source.data w.sourceGroups w.sourceChecked w.fits w.limits
    (w.propose r).view (w.propose r).context w.coverage (w.propose r).tables
    h.1.1 w.coverageChecked h.1.2 h.2 (w.propose r).ids (w.propose r).byte r
    (TerminalBucket.labelP source.bits r) row

theorem checked_layer_step (c : GlobalEnumeration.Certificate) (data : Nat → SuccessorCache.Data)
    (cacheChecked : GlobalSuccessorBridge.Checked c data) (table : Candidate c data)
    (accepted : check table = true) (n : Nat) (nl : n < layerCount)
    (next : LayerSound table (n + 1)) : LayerSound table n := by
  intro h r bound
  by_cases hb : h < bucketCount
  · let source := table.sources ⟨n, nl⟩ ⟨h, hb⟩
    have sourceEq : sourceAt table n h = source := by simp only [sourceAt, nl, hb, ↓reduceDIte, source]
    rw [sourceEq] at bound ⊢
    have positive : 0 < source.data.size := by omega
    let w := table.work ⟨n, nl⟩ ⟨h, hb⟩ positive
    have cell := checked_cell table accepted n h nl hb
    have whole : checkBucket table n source w = true := by
      simpa only [checkCell, nl, hb, positive, ↓reduceDIte, source, w] using cell
    have parts : checkTargets table n w.next = true ∧
        checkSpans (checkActualRow c data source w) source.data.size 0 w.spans = true := by
      simpa only [checkBucket, Bool.and_eq_true] using whole
    have correct := targets_of_next_layer table n w.next parts.1 next
    have row := checkSpans_each (checkActualRow c data source w) w.spans 0 source.data.size
      parts.2 r (Nat.zero_le r) bound
    exact (checked_actual_row_sound c data cacheChecked source w correct r row).2
  · have zero := sourceAt_outside_bucket table n h hb
    omega

/-- A finite descending dependency theorem. It does not presume that a
candidate label is correct; the supplied step must establish it from the
strictly next layer. This middle lemma has no game-specific assumptions. -/
theorem descending_layers (top : Nat) (P : Nat → Prop)
    (outside : ∀ n, top ≤ n → P n)
    (step : ∀ n, n < top → P (n + 1) → P n) : ∀ n, P n := by
  have bounded : ∀ k n, top ≤ n + k → P n := by
    intro k
    induction k with
    | zero => intro n hn; exact outside n (by omega)
    | succ k ih =>
      intro n hn
      by_cases below : n < top
      · exact step n below (ih (n + 1) (by omega))
      · exact outside n (by omega)
  intro n
  exact bounded top n (by omega)

/-- Every source row in all 35 x 184 buckets receives its actual stored
label's SAFE normal strategy. No assumed TargetCorrect or row-soundness
function occurs in this theorem's arguments. -/
theorem checked_all_layers_sound (c : GlobalEnumeration.Certificate) (data : Nat → SuccessorCache.Data)
    (cacheChecked : GlobalSuccessorBridge.Checked c data) (table : Candidate c data)
    (accepted : check table = true) : ∀ n, LayerSound table n := by
  apply descending_layers layerCount (LayerSound table)
  · intro n outside h r bound
    have zero := sourceAt_outside_layer table n h (by omega)
    omega
  · exact checked_layer_step c data cacheChecked table accepted

/-- After assembly, any actual accepted source bank is a proved target bank
for a preceding layer. This corollary exports the existing interface. -/
theorem checked_target_correct (c : GlobalEnumeration.Certificate) (data : Nat → SuccessorCache.Data)
    (cacheChecked : GlobalSuccessorBridge.Checked c data) (table : Candidate c data)
    (accepted : check table = true) (n : Nat) (bank : FiniteBank)
    (identity : checkTargets table n bank = true) :
    TargetCorrect (FullSafeData.summaries (CachedPackedCheck.ofCertificate c data).rules)
      (GuardedTargetRef.target (guardedBank bank.bank)) :=
  targets_of_next_layer table n bank identity (checked_all_layers_sound c data cacheChecked table accepted (n + 1))

/-! ## Root identity and the original game's winning strategy -/

def checkRoot {c : GlobalEnumeration.Certificate} {data : Nat → SuccessorCache.Data}
    (table : Candidate c data) (h r : Nat) : Bool :=
  decide (h < bucketCount ∧ r < (sourceAt table 0 h).data.size) &&
    stateEqB (Base5Coverage.unpack (BucketIndex.unrank (sourceAt table 0 h).data r)) empty &&
    TerminalBucket.labelP (sourceAt table 0 h).bits r

theorem checked_empty_normal (c : GlobalEnumeration.Certificate) (data : Nat → SuccessorCache.Data)
    (cacheChecked : GlobalSuccessorBridge.Checked c data) (table : Candidate c data)
    (accepted : check table = true) (h r : Nat) (root : checkRoot table h r = true) :
    NormalStrategy SafeMove empty .P := by
  have parts : ((h < bucketCount ∧ r < (sourceAt table 0 h).data.size) ∧
      stateEqB (Base5Coverage.unpack (BucketIndex.unrank (sourceAt table 0 h).data r)) empty = true) ∧
      TerminalBucket.labelP (sourceAt table 0 h).bits r = true := by
    simpa only [checkRoot, Bool.and_eq_true, decide_eq_true_eq] using root
  have normal := (checked_all_layers_sound c data cacheChecked table accepted 0 h r parts.1.1.2).2
  have physical := stateEqB_sound parts.1.2
  simpa only [physical, parts.2, outcome, ↓reduceIte] using normal

/-- Genuine second-player achievement winning strategy against EVERY legal
first move, with an actual legal 14-tile win at strategy leaves. Supplying the
actual complete-check and actual empty/P bit proofs is still required. -/
theorem checked_empty_second_player_wins (c : GlobalEnumeration.Certificate) (data : Nat → SuccessorCache.Data)
    (cacheChecked : GlobalSuccessorBridge.Checked c data) (table : Candidate c data)
    (accepted : check table = true) (h r : Nat) (root : checkRoot table h r = true) :
    SecondPlayerWins Step Win empty :=
  original_second_player_wins_of_safe_P (checked_empty_normal c data cacheChecked table accepted h r root)

end Mahjong.CrossLayerAssemblyV17

#print axioms Mahjong.CrossLayerAssemblyV17.checkSpans_each
#print axioms Mahjong.CrossLayerAssemblyV17.checkSpans_disjoint
#print axioms Mahjong.CrossLayerAssemblyV17.sameBucket_sound
#print axioms Mahjong.CrossLayerAssemblyV17.targets_of_next_layer
#print axioms Mahjong.CrossLayerAssemblyV17.checked_all_layers_sound
#print axioms Mahjong.CrossLayerAssemblyV17.checked_target_correct
#print axioms Mahjong.CrossLayerAssemblyV17.checked_empty_normal
#print axioms Mahjong.CrossLayerAssemblyV17.checked_empty_second_player_wins
