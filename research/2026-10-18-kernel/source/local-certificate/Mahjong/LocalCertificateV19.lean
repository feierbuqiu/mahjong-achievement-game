import Mahjong.CachedPackedCheck

set_option autoImplicit false

/-! Local original-game certificates. No global directory, orbit uniqueness,
maximum-SAFE-layer envelope, or GlobalEnumeration.Certificate construction.
All original SAFE successor obligations remain exact and finite. -/

namespace Mahjong.LocalCertificateV19

open CanonicalCoverage GroupedCoverage CanonicalInventory

structure Certificate where
  core : Nat → ByteArray
  summary : Nat → ByteArray
  raw : Nat → ByteArray
  ids : Nat → ByteArray
  members : Nat → ByteArray
  coreSizes : Base5Coverage.ProperSizes core
  safeChecked : FullSafeData.Checked (Base5Coverage.tables core summary raw)
  inventorySizes : CanonicalCoverage.ProperSizes (inventories raw ids members)
  inventoryChecked : CanonicalCoverage.Checked (inventories raw ids members)

def inventoriesOf (c : Certificate) : Inventories := inventories c.raw c.ids c.members

/-- Optional extra local group metadata for Cartesian/tensor methods.
Still no triples, honor directories, global uniqueness or SAFE layer bound. -/
structure GroupedCertificate extends Certificate where
  sharedMembers : SortedCoverage.SharedMembers (inventories raw ids members)
  groups : GroupInventory.Data
  groupChecked : GroupInventory.Checked groups
  link : Link groups (inventories raw ids members) raw

namespace Successors
open CanonicalInventory CanonicalCoverage LocalCacheEncoding LocalSymmetryFrame
open GlobalOrbitUniqueness LocalSuccessorBridge Generators

def summaries (c : Certificate) (b : Nat) : LocalSummary.Candidate :=
  SummaryEncoding.candidate b (c.core b) (c.summary b)

def Checked (c : Certificate) (data : Nat → SuccessorCache.Data) : Prop :=
  ∀ b, b < 4 → checkSpan (SuccessorCache.checkRow b (inventoriesOf c b) (summaries c b) (data b))
    0 (inventoriesOf c b).count = true

def Retained (c : Certificate) (s : State) : Prop :=
  ∀ b, b < 4 → ∃ i, i < (inventoriesOf c b).count ∧ (inventoriesOf c b).member i = encodeBlock b s

theorem local_link (c : Certificate) (b : Nat) (hb : b < 4) :
    Linked b (inventoriesOf c b) (summaries c b) := by
  constructor
  · exact (c.coreSizes b hb).trans (c.inventorySizes b hb).symm
  · rfl

theorem summary_checked (c : Certificate) (b : Nat) (hb : b < 4) :
    PruningData.Checked b (summaries c b) := (c.safeChecked b hb).1

/-- One cached local replacement followed by the full SAFE filter. Numeric
suit sorting and optimized rank lookups are separate implementation steps. -/
def Edge (c : Certificate) (data : Nat → SuccessorCache.Data) (s q : State) : Prop :=
  ∃ b i j, b < 4 ∧ i < (inventoriesOf c b).count ∧
    (inventoriesOf c b).member i = encodeBlock b s ∧ j ∈ (data b).next i ∧
    q = replaceBlock b s (decodeBlock b ((inventoriesOf c b).member j)) ∧ IsSafe q

theorem edge_sound (c : Certificate) (data : Nat → SuccessorCache.Data) (checked : Checked c data)
    (s q : State) (valid : Valid s) (edge : Edge c data s q) :
    ∃ r, SafeMove s r ∧ SameOrbit r q ∧ Valid q := by
  obtain ⟨b,i,j,hb,hi,source,member,eq,safe⟩ := edge
  have pass := SuccessorCache.checked_row b (inventoriesOf c b) (summaries c b) (data b) (checked b hb) i hi
  obtain ⟨u,path,_,legal,witness⟩ := cached_edge_realized b (inventoriesOf c b) (summaries c b)
    (c.inventoryChecked b hb) (summary_checked c b hb) (local_link c b hb) (data b) i j pass hi member s valid source
  have result : q = applyPath path (addTile s u) := eq.trans witness
  have rawSafe : IsSafe (addTile s u) := (path_safe_iff path _).mp (by rw [← result]; exact safe)
  refine ⟨addTile s u,⟨⟨u,legal,rfl⟩,rawSafe⟩,⟨path,result⟩,?_⟩
  rw [result]
  exact path_valid path _ (valid_add legal.1 legal.2)

/-- No original SAFE move from a retained source is lost by local filtering,
canonicalization or deduplication of the successor IDs. -/
theorem edge_complete (c : Certificate) (data : Nat → SuccessorCache.Data) (checked : Checked c data)
    (s r : State) (valid : Valid s) (kept : Retained c s) (edge : SafeMove s r) :
    ∃ q, Edge c data s q ∧ SameOrbit r q := by
  obtain ⟨⟨u,legal,rfl⟩,safe⟩ := edge
  let b := u.val/9
  have hb : b < 4 := by have h := u.isLt; dsimp [b]; omega
  obtain ⟨i,hi,source⟩ := kept b hb
  let t := inventoriesOf c b
  let sum := summaries c b
  have av : sum.available (t.member i) u = true := by
    rw [available_eq b t sum (c.inventoryChecked b hb) (summary_checked c b hb)
      (local_link c b hb) i hi s valid source u rfl]
    exact decide_eq_true legal.2
  have raw := raw_addition b t sum (c.inventoryChecked b hb) (summary_checked c b hb)
    (local_link c b hb) i hi s valid source u rfl av
  have cr := CanonicalInventory.checked_row b t (c.inventoryChecked b hb) _ raw.1
  let q := canonBlock (inventoriesOf c) b (addTile s u)
  have va := valid_add legal.1 legal.2
  have vq : Valid q := canonBlock_valid (inventoriesOf c) c.inventoryChecked c.inventorySizes b hb _ va
  have sq : IsSafe q := (canonBlock_safe (inventoriesOf c) c.inventoryChecked c.inventorySizes b hb _ va).mpr safe
  have qcode : encodeBlock b q = t.canonical (sum.next (t.member i) u) := by
    change encodeBlock b (replaceBlock b (addTile s u) (decodeBlock b (t.canonical (encodeBlock b (addTile s u))))) = _
    rw [encode_replace_self,← raw.2.2]
    exact (CanonicalInventory.checked_row b t (c.inventoryChecked b hb) _ cr.range).roundtrip
  have fixed : t.canonical (encodeBlock b q) = encodeBlock b q :=
    canonBlock_fixed (inventoriesOf c) c.inventoryChecked c.inventorySizes b hb _ va
  have passes := safe_raw_partials c.core c.summary c.raw c.coreSizes c.safeChecked q vq sq b hb
  have passes' : PruningAlgebra.passesPartial (t.raw (encodeBlock b q)) := passes
  have insideQ : encodeBlock b q < t.size := by rw [qcode]; exact cr.range
  have qrow := CanonicalInventory.checked_row b t (c.inventoryChecked b hb) _ insideQ
  have retained : t.id (t.canonical (sum.next (t.member i) u)) < t.count := by
    rw [← qcode]
    exact qrow.kept.mpr ⟨fixed,passes'⟩
  let j := t.id (t.canonical (sum.next (t.member i) u))
  have pass := SuccessorCache.checked_row b t sum (data b) (checked b hb) i hi
  have found : j ∈ (data b).next i := retained_addition_cached b t sum (data b) i pass u rfl av retained
  have member : t.member j = t.canonical (sum.next (t.member i) u) :=
    (CanonicalInventory.checked_row b t (c.inventoryChecked b hb) _ cr.range).reverse retained
  have replaced : q = replaceBlock b s (decodeBlock b (t.member j)) := by
    change replaceBlock b (addTile s u) (decodeBlock b (t.canonical (encodeBlock b (addTile s u)))) = _
    rw [replace_after_add b s _ u rfl,member,raw.2.2]
  refine ⟨q,⟨b,i,j,hb,hi,source,found,replaced,sq⟩,?_⟩
  exact ⟨t.witness (encodeBlock b (addTile s u)),
    canonBlock_eq (inventoriesOf c) c.inventoryChecked c.inventorySizes b hb _ va⟩


end Successors

namespace Cached
open PackedRules GeneralLayer CachedPackedCheck Successors
open CanonicalInventory LocalCacheEncoding LocalSymmetryFrame Generators SafeGame
open CanonicalCoverage GlobalOrbitUniqueness

/-- Exactly the old executable Local record, built from a genuinely smaller
certificate. No conversion to the old global certificate exists here. -/
def ofCertificate (c : Certificate) (data : Nat → SuccessorCache.Data) : CachedPackedCheck.Local :=
  ⟨Base5Coverage.tables c.core c.summary c.raw,inventoriesOf c,data⟩

theorem state_eq (c : Certificate) (data : Nat → SuccessorCache.Data) (s : Packed) :
    state (FullSafeData.summaries (ofCertificate c data).rules) s = Base5Coverage.unpack s := rfl

theorem packed_encode (c : Certificate) (data : Nat → SuccessorCache.Data) (s : Packed)
    (valid : inside (FullSafeData.summaries (ofCertificate c data).rules) s = true)
    (b : Nat) (hb : b < 4) :
    encodeBlock b (Base5Coverage.unpack s) = s.get b := by
  apply SuitSorting.encode_unpacked s b (inventoriesOf c b) (c.inventoryChecked b hb)
  have h := inside_part _ s valid b hb
  change s.get b < (c.core b).size at h
  change s.get b < (inventoriesOf c b).size
  exact Nat.lt_of_lt_of_eq h ((c.coreSizes b hb).trans (c.inventorySizes b hb).symm)

theorem packed_valid (c : Certificate) (data : Nat → SuccessorCache.Data) (s : Packed)
    (valid : inside (FullSafeData.summaries (ofCertificate c data).rules) s = true) :
    Valid (Base5Coverage.unpack s) :=
  PackedRules.state_valid _ (fun b hb => (c.safeChecked b hb).1) s valid

theorem retainedB_facts (d : Local) (s : Packed) (accepted : retainedB d s = true)
    (b : Nat) (hb : b < 4) : sourceId d s b < (d.inventories b).count ∧
      (d.inventories b).member (sourceId d s b) = s.get b := by
  have mem : b ∈ [0,1,2,3] := by
    have choices : b = 0 ∨ b = 1 ∨ b = 2 ∨ b = 3 := by omega
    rcases choices with rfl | rfl | rfl | rfl <;> simp
  exact of_decide_eq_true (List.all_eq_true.mp accepted b mem)

theorem retainedB_sound (c : Certificate) (data : Nat → SuccessorCache.Data) (s : Packed)
    (valid : inside (FullSafeData.summaries (ofCertificate c data).rules) s = true)
    (accepted : retainedB (ofCertificate c data) s = true) :
    Retained c (Base5Coverage.unpack s) := by
  intro b hb
  have facts := retainedB_facts (ofCertificate c data) s accepted b hb
  exact ⟨sourceId (ofCertificate c data) s b,facts.1,
    facts.2.trans (packed_encode c data s valid b hb).symm⟩

theorem raw_mem (d : Local) (s q : Packed) :
    q ∈ raw d s ↔ ∃ b j, b < 4 ∧
      j ∈ (d.edges b).next (sourceId d s b) ∧ q = replace d s b j := by
  simp only [raw,List.mem_flatMap,List.mem_range,List.mem_map]
  constructor
  · rintro ⟨b,hb,j,hj,eq⟩
    exact ⟨b,j,hb,hj,eq.symm⟩
  · rintro ⟨b,j,hb,hj,eq⟩
    exact ⟨b,hb,j,hj,eq.symm⟩

theorem unpack_replace (d : Local) (s : Packed) (b j : Nat) (hb : b < 4) :
    Base5Coverage.unpack (replace d s b j) =
      replaceBlock b (Base5Coverage.unpack s)
        (decodeBlock b ((d.inventories b).member j)) := by
  funext u
  have hu : u.val/9 < 4 := by have h := u.isLt; omega
  unfold Base5Coverage.unpack replace
  rw [PackedRules.get_set s b _ _ hb hu]
  by_cases eq : b = u.val/9
  · simp only [eq, replaceBlock, ↓reduceIte]
  · have ne : u.val/9 ≠ b := Ne.symm eq
    simp only [if_neg eq, replaceBlock, if_neg ne]

theorem raw_inside (c : Certificate) (data : Nat → SuccessorCache.Data)
    (checked : Successors.Checked c data) (s q : Packed)
    (valid : inside (FullSafeData.summaries (ofCertificate c data).rules) s = true)
    (retained : retainedB (ofCertificate c data) s = true)
    (member : q ∈ raw (ofCertificate c data) s) :
    inside (FullSafeData.summaries (ofCertificate c data).rules) q = true := by
  obtain ⟨b,j,hb,hj,rfl⟩ := (raw_mem _ s q).mp member
  have ids := retainedB_facts (ofCertificate c data) s retained b hb
  have row := SuccessorCache.checked_row b _ _ (data b) (checked b hb) _ ids.1
  have bound := (SuccessorCache.row_facts b _ _ (data b) _ row).bounds j hj
  have code := (CanonicalInventory.checked_member b _ (c.inventoryChecked b hb) j bound.1).1
  change (inventoriesOf c b).member j < (inventoriesOf c b).size at code
  have sizeEq : (inventoriesOf c b).size = (c.core b).size :=
    (c.inventorySizes b hb).trans (c.coreSizes b hb).symm
  rw [sizeEq] at code
  unfold inside
  apply List.all_eq_true.mpr
  intro d hd
  have choices : d = 0 ∨ d = 1 ∨ d = 2 ∨ d = 3 := by simpa using hd
  have dh : d < 4 := by omega
  apply decide_eq_true
  change ((replace (ofCertificate c data) s b j).get d) < (c.core d).size
  rw [replace,PackedRules.get_set s b d _ hb dh]
  split
  · next eq => subst d; exact code
  · exact inside_part _ s valid d dh

theorem safe_iff (c : Certificate) (data : Nat → SuccessorCache.Data) (s : Packed)
    (valid : inside (FullSafeData.summaries (ofCertificate c data).rules) s = true) :
    safeB (ofCertificate c data) s = true ↔ IsSafe (Base5Coverage.unpack s) := by
  simp only [CachedPackedCheck.safeB,FastSingleWitness.safeB,valid,Bool.true_and,decide_eq_true_eq]
  exact FullSafeData.checked_full_filter_iff_safe _ c.safeChecked s valid

theorem initial_facts (c : Certificate) (data : Nat → SuccessorCache.Data) (s : Packed)
    (accepted : initial (ofCertificate c data) s = true) :
    inside (FullSafeData.summaries (ofCertificate c data).rules) s = true ∧
    retainedB (ofCertificate c data) s = true ∧ IsSafe (Base5Coverage.unpack s) := by
  simp only [initial,Bool.and_eq_true] at accepted
  exact ⟨accepted.1.1,accepted.1.2,(safe_iff c data s accepted.1.1).mp accepted.2⟩

theorem ref_sound (c : Certificate) (data : Nat → SuccessorCache.Data) (target : Target)
    (correct : TargetCorrect (FullSafeData.summaries (ofCertificate c data).rules) target)
    (s : Packed) (accepted : refB (ofCertificate c data) target s = true) :
    NormalStrategy SafeMove (Base5Coverage.unpack s)
      (outcome (isP (ofCertificate c data) target s)) := by
  simp only [refB,Bool.and_eq_true,decide_eq_true_eq] at accepted
  have result := correct (reference (ofCertificate c data) target s).bucket
    (reference (ofCertificate c data) target s).index accepted.1
  rw [accepted.2,state_eq] at result
  obtain ⟨path,eq⟩ := SuitSorting.sort_path ((inventoriesOf c 0).id) s
  change NormalStrategy SafeMove (Base5Coverage.unpack (normalize (ofCertificate c data) s))
    (outcome (isP (ofCertificate c data) target s)) at result
  change Base5Coverage.unpack (normalize (ofCertificate c data) s) = _ at eq
  rw [eq] at result
  exact (path_preserves_outcome path (Base5Coverage.unpack s) _).mpr result

theorem child_edge (c : Certificate) (data : Nat → SuccessorCache.Data)
    (checked : Successors.Checked c data) (s q : Packed)
    (valid : inside (FullSafeData.summaries (ofCertificate c data).rules) s = true)
    (retained : retainedB (ofCertificate c data) s = true)
    (member : q ∈ children (ofCertificate c data) s) :
    Edge c data (Base5Coverage.unpack s) (Base5Coverage.unpack q) := by
  obtain ⟨mem,pass⟩ := List.mem_filter.mp member
  have vq := raw_inside c data checked s q valid retained mem
  have sq := (safe_iff c data q vq).mp pass
  obtain ⟨b,j,hb,hj,rfl⟩ := (raw_mem _ s q).mp mem
  have ids := retainedB_facts (ofCertificate c data) s retained b hb
  exact ⟨b,sourceId (ofCertificate c data) s b,j,hb,ids.1,
    ids.2.trans (packed_encode c data s valid b hb).symm,hj,
    unpack_replace _ s b j hb,sq⟩

theorem children_complete (c : Certificate) (data : Nat → SuccessorCache.Data)
    (checked : Successors.Checked c data) (s : Packed)
    (valid : inside (FullSafeData.summaries (ofCertificate c data).rules) s = true)
    (retained : retainedB (ofCertificate c data) s = true) (t : State)
    (edge : SafeMove (Base5Coverage.unpack s) t) :
    ∃ q, q ∈ children (ofCertificate c data) s ∧
      SameOrbit t (Base5Coverage.unpack q) := by
  obtain ⟨physical,cached,orbit⟩ := Successors.edge_complete c data checked
    (Base5Coverage.unpack s) t (packed_valid c data s valid)
    (retainedB_sound c data s valid retained) edge
  obtain ⟨b,i,j,hb,hi,source,hj,eq,safe⟩ := cached
  have sourceCode : (inventoriesOf c b).member i = s.get b :=
    source.trans (packed_encode c data s valid b hb)
  have idEq : sourceId (ofCertificate c data) s b = i := by
    unfold sourceId
    change (inventoriesOf c b).id (s.get b) = i
    rw [← sourceCode]
    exact (CanonicalInventory.checked_member b _ (c.inventoryChecked b hb) i hi).2
  let q := replace (ofCertificate c data) s b j
  have rawMem : q ∈ raw (ofCertificate c data) s :=
    (raw_mem _ s q).mpr ⟨b,j,hb,by change j ∈ (data b).next _; rwa [idEq],rfl⟩
  have unpackEq : Base5Coverage.unpack q = physical :=
    (unpack_replace (ofCertificate c data) s b j hb).trans eq.symm
  have vq := raw_inside c data checked s q valid retained rawMem
  refine ⟨q,List.mem_filter.mpr ⟨rawMem,?_⟩,?_⟩
  · apply (safe_iff c data q vq).mpr
    rwa [unpackEq]
  · rwa [unpackEq]

/-- Both P and N rows are connected to the original SAFE game. Higher-layer
labels must already be proved; arbitrary GPU/rank proposals are guarded by
an exact target-unrank equality in refB. -/
theorem row_sound (c : Certificate) (data : Nat → SuccessorCache.Data)
    (checked : Successors.Checked c data) (target : Target)
    (correct : TargetCorrect (FullSafeData.summaries (ofCertificate c data).rules) target)
    (s : Packed) (labelP : Bool)
    (accepted : row (ofCertificate c data) target s labelP = true) :
    IsSafe (Base5Coverage.unpack s) ∧ NormalStrategy SafeMove (Base5Coverage.unpack s)
      (outcome labelP) := by
  simp only [CachedPackedCheck.row,Bool.and_eq_true] at accepted
  have facts := initial_facts c data s accepted.1
  refine ⟨facts.2.2,?_⟩
  cases labelP with
  | true =>
    have scan := accepted.2
    change (raw (ofCertificate c data) s).all _ = true at scan
    apply NormalStrategy.p
    intro t edge
    obtain ⟨q,member,orbit⟩ := children_complete c data checked s facts.1 facts.2.1 t edge
    obtain ⟨rawMem,safe⟩ := List.mem_filter.mp member
    have pass := List.all_eq_true.mp scan q rawMem
    simp only [safe,Bool.not_true,Bool.false_or,Bool.and_eq_true,Bool.not_eq_true'] at pass
    have strategy := ref_sound c data target correct q pass.1
    simp only [pass.2,outcome,Bool.false_eq_true,↓reduceIte] at strategy
    obtain ⟨path,eq⟩ := orbit
    rw [eq] at strategy
    exact (path_preserves_outcome path t .N).mpr strategy
  | false =>
    have scan := accepted.2
    change (raw (ofCertificate c data) s).any _ = true at scan
    obtain ⟨q,rawMem,pass⟩ := List.any_eq_true.mp scan
    simp only [Bool.and_eq_true] at pass
    have member : q ∈ children (ofCertificate c data) s := List.mem_filter.mpr ⟨rawMem,pass.1.1⟩
    have cached := child_edge c data checked s q facts.1 facts.2.1 member
    obtain ⟨t,edge,orbit,_⟩ := Successors.edge_sound c data checked
      (Base5Coverage.unpack s) (Base5Coverage.unpack q) (packed_valid c data s facts.1) cached
    have strategy := ref_sound c data target correct q pass.1.2
    simp only [pass.2,outcome,↓reduceIte] at strategy
    apply NormalStrategy.n edge
    obtain ⟨path,eq⟩ := orbit
    rw [eq] at strategy
    exact (path_preserves_outcome path t .P).mpr strategy

theorem row_original (c : Certificate) (data : Nat → SuccessorCache.Data)
    (checked : Successors.Checked c data) (target : Target)
    (correct : TargetCorrect (FullSafeData.summaries (ofCertificate c data).rules) target)
    (s : Packed) (labelP : Bool)
    (accepted : row (ofCertificate c data) target s labelP = true) :
    AchievementStrategy Step Win (Base5Coverage.unpack s) (outcome labelP) := by
  have result := row_sound c data checked target correct s labelP accepted
  exact (original_safe_reduction result.1).mp result.2

theorem single_implies_row (d : Local) (target : Target) (s : Packed) (b j : Nat)
    (accepted : single d target s b j = true) : row d target s false = true := by
  simp only [single,Bool.and_eq_true,decide_eq_true_eq] at accepted
  obtain ⟨⟨⟨⟨⟨initial,hb⟩,member⟩,safe⟩,ref⟩,label⟩ := accepted
  simp only [CachedPackedCheck.row,Bool.false_eq_true,↓reduceIte,Bool.and_eq_true]
  refine ⟨initial,List.any_eq_true.mpr ⟨replace d s b j,?_,?_⟩⟩
  · exact (raw_mem d s _).mpr ⟨b,j,hb,member,rfl⟩
  · simp only [safe,ref,label,Bool.and_self]

theorem single_original (c : Certificate) (data : Nat → SuccessorCache.Data)
    (checked : Successors.Checked c data) (target : Target)
    (correct : TargetCorrect (FullSafeData.summaries (ofCertificate c data).rules) target)
    (s : Packed) (b j : Nat)
    (accepted : single (ofCertificate c data) target s b j = true) :
    AchievementStrategy Step Win (Base5Coverage.unpack s) .N :=
  row_original c data checked target correct s false (single_implies_row _ target s b j accepted)


end Cached
end Mahjong.LocalCertificateV19

#print axioms Mahjong.LocalCertificateV19.Successors.local_link
#print axioms Mahjong.LocalCertificateV19.Successors.summary_checked
#print axioms Mahjong.LocalCertificateV19.Successors.edge_sound
#print axioms Mahjong.LocalCertificateV19.Successors.edge_complete
#print axioms Mahjong.LocalCertificateV19.Cached.state_eq
#print axioms Mahjong.LocalCertificateV19.Cached.packed_encode
#print axioms Mahjong.LocalCertificateV19.Cached.packed_valid
#print axioms Mahjong.LocalCertificateV19.Cached.retainedB_sound
#print axioms Mahjong.LocalCertificateV19.Cached.raw_inside
#print axioms Mahjong.LocalCertificateV19.Cached.safe_iff
#print axioms Mahjong.LocalCertificateV19.Cached.initial_facts
#print axioms Mahjong.LocalCertificateV19.Cached.ref_sound
#print axioms Mahjong.LocalCertificateV19.Cached.child_edge
#print axioms Mahjong.LocalCertificateV19.Cached.children_complete
#print axioms Mahjong.LocalCertificateV19.Cached.row_sound
#print axioms Mahjong.LocalCertificateV19.Cached.row_original
#print axioms Mahjong.LocalCertificateV19.Cached.single_original
