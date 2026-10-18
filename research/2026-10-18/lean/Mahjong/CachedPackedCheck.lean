import Mahjong.GlobalSuccessorBridge
import Mahjong.GeneralLayer
import Mahjong.FastSingleWitness
import Mahjong.SuitSorting

set_option autoImplicit false

namespace Mahjong.CachedPackedCheck
open PackedRules GeneralLayer GlobalEnumeration GlobalSuccessorBridge
open CanonicalInventory LocalCacheEncoding LocalSymmetryFrame Generators SafeGame
open CanonicalCoverage GlobalOrbitUniqueness

/-- Executable data only. Its finite checks are inherited from the existing
global-enumeration certificate and checked successor caches below. -/
structure Local where
  rules : FullSafeData.Tables
  inventories : Nat → CanonicalInventory.Candidate
  edges : Nat → SuccessorCache.Data

def ofCertificate (c : Certificate) (data : Nat → SuccessorCache.Data) : Local :=
  ⟨Base5Coverage.tables c.core c.summary c.raw, inventoriesOf c, data⟩

def retainedB (d : Local) (s : Packed) : Bool :=
  [0,1,2,3].all fun b =>
    let t := d.inventories b
    let i := t.id (s.get b)
    decide (i < t.count ∧ t.member i = s.get b)

def sourceId (d : Local) (s : Packed) (b : Nat) : Nat :=
  (d.inventories b).id (s.get b)

def replace (d : Local) (s : Packed) (b j : Nat) : Packed :=
  s.set b ((d.inventories b).member j)

def raw (d : Local) (s : Packed) : List Packed :=
  (List.range 4).flatMap fun b =>
    ((d.edges b).next (sourceId d s b)).map (replace d s b)

def safeB (d : Local) (s : Packed) : Bool := FastSingleWitness.safeB d.rules s

def children (d : Local) (s : Packed) : List Packed := (raw d s).filter (safeB d)

/-- All d codes are already canonical. Suit sorting therefore needs no
reflection, honor permutation or physical-state restoration. -/
def normalize (d : Local) (s : Packed) : Packed :=
  SuitSorting.sort ((d.inventories 0).id) s

def reference (d : Local) (target : Target) (s : Packed) : Reference :=
  target.locate (normalize d s)

def refB (d : Local) (target : Target) (s : Packed) : Bool :=
  let r := reference d target s
  decide (r.index < target.size r.bucket) &&
    decide (target.unrank r.bucket r.index = normalize d s)

def isP (d : Local) (target : Target) (s : Packed) : Bool :=
  let r := reference d target s
  target.labelP r.bucket r.index

def initial (d : Local) (s : Packed) : Bool :=
  inside (FullSafeData.summaries d.rules) s && retainedB d s && safeB d s

def row (d : Local) (target : Target) (s : Packed) (labelP : Bool) : Bool :=
  initial d s && if labelP then
    (raw d s).all (fun q => !safeB d q || (refB d target q && !isP d target q))
  else
    (raw d s).any (fun q => safeB d q && refB d target q && isP d target q)

/-- A GPU may propose b,j. Membership, SAFE, indexing and the P child label
are all rechecked in compiled Lean, without trusting CUDA. -/
def single (d : Local) (target : Target) (s : Packed) (b j : Nat) : Bool :=
  initial d s && decide (b < 4) &&
    decide (j ∈ (d.edges b).next (sourceId d s b)) &&
    safeB d (replace d s b j) &&
    refB d target (replace d s b j) && isP d target (replace d s b j)

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
  · simp only [eq, if_true, replaceBlock, ↓reduceIte]
  · have ne : u.val/9 ≠ b := Ne.symm eq
    simp only [if_neg eq, replaceBlock, if_neg ne]

theorem raw_inside (c : Certificate) (data : Nat → SuccessorCache.Data)
    (checked : GlobalSuccessorBridge.Checked c data) (s q : Packed)
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
  simp only [safeB,FastSingleWitness.safeB,valid,Bool.true_and,decide_eq_true_eq]
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
    (checked : GlobalSuccessorBridge.Checked c data) (s q : Packed)
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
    (checked : GlobalSuccessorBridge.Checked c data) (s : Packed)
    (valid : inside (FullSafeData.summaries (ofCertificate c data).rules) s = true)
    (retained : retainedB (ofCertificate c data) s = true) (t : State)
    (edge : SafeMove (Base5Coverage.unpack s) t) :
    ∃ q, q ∈ children (ofCertificate c data) s ∧
      SameOrbit t (Base5Coverage.unpack q) := by
  obtain ⟨physical,cached,orbit⟩ := GlobalSuccessorBridge.edge_complete c data checked
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
    (checked : GlobalSuccessorBridge.Checked c data) (target : Target)
    (correct : TargetCorrect (FullSafeData.summaries (ofCertificate c data).rules) target)
    (s : Packed) (labelP : Bool)
    (accepted : row (ofCertificate c data) target s labelP = true) :
    IsSafe (Base5Coverage.unpack s) ∧ NormalStrategy SafeMove (Base5Coverage.unpack s)
      (outcome labelP) := by
  simp only [row,Bool.and_eq_true] at accepted
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
    obtain ⟨t,edge,orbit,_⟩ := GlobalSuccessorBridge.edge_sound c data checked
      (Base5Coverage.unpack s) (Base5Coverage.unpack q) (packed_valid c data s facts.1) cached
    have strategy := ref_sound c data target correct q pass.1.2
    simp only [pass.2,outcome,↓reduceIte] at strategy
    apply NormalStrategy.n edge
    obtain ⟨path,eq⟩ := orbit
    rw [eq] at strategy
    exact (path_preserves_outcome path t .P).mpr strategy

theorem row_original (c : Certificate) (data : Nat → SuccessorCache.Data)
    (checked : GlobalSuccessorBridge.Checked c data) (target : Target)
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
  simp only [row,Bool.false_eq_true,↓reduceIte,Bool.and_eq_true]
  refine ⟨initial,List.any_eq_true.mpr ⟨replace d s b j,?_,?_⟩⟩
  · exact (raw_mem d s _).mpr ⟨b,j,hb,member,rfl⟩
  · simp only [safe,ref,label,Bool.and_self]

theorem single_original (c : Certificate) (data : Nat → SuccessorCache.Data)
    (checked : GlobalSuccessorBridge.Checked c data) (target : Target)
    (correct : TargetCorrect (FullSafeData.summaries (ofCertificate c data).rules) target)
    (s : Packed) (b j : Nat)
    (accepted : single (ofCertificate c data) target s b j = true) :
    AchievementStrategy Step Win (Base5Coverage.unpack s) .N :=
  row_original c data checked target correct s false (single_implies_row _ target s b j accepted)

end Mahjong.CachedPackedCheck

#print axioms Mahjong.CachedPackedCheck.ref_sound
#print axioms Mahjong.CachedPackedCheck.child_edge
#print axioms Mahjong.CachedPackedCheck.children_complete
#print axioms Mahjong.CachedPackedCheck.row_sound
#print axioms Mahjong.CachedPackedCheck.row_original
#print axioms Mahjong.CachedPackedCheck.single_implies_row
#print axioms Mahjong.CachedPackedCheck.single_original
