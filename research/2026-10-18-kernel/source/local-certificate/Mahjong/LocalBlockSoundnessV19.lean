import Mahjong.LocalCertificateV19
import Mahjong.BlockPlanSoundness

set_option autoImplicit false

namespace Mahjong.LocalBlockSoundnessV19
open PackedRules GeneralLayer GroupCandidates CanonicalInventory
open CachedPackedCheck BlockPlanCheck SafeGame Generators CanonicalCoverage GlobalOrbitUniqueness
open BlockPlanSoundness

def inventoriesOf (c : LocalCertificateV19.GroupedCertificate) : Inventories :=
  LocalCertificateV19.inventoriesOf c.toCertificate

def ofCertificate (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) : Local :=
  LocalCertificateV19.Cached.ofCertificate c.toCertificate data

theorem numeric_member (c : LocalCertificateV19.GroupedCertificate) (b : Nat) (hb : b < 3) :
    (inventoriesOf c b).count = c.groups.count ∧ (inventoriesOf c b).member = c.groups.retained := by
  have shared := c.sharedMembers b hb
  exact ⟨shared.2.trans c.link.count.symm,shared.1.trans c.link.members.symm⟩

theorem id_of_member (c : LocalCertificateV19.GroupedCertificate) (b : Nat) (hb : b < 3) (i : Nat) (hi : i < c.groups.count) :
    (inventoriesOf c b).id (c.groups.retained i) = i := by
  have facts := numeric_member c b hb
  rw [← facts.2]
  exact (CanonicalInventory.checked_member b _ (c.inventoryChecked b (by omega)) i
    (by change i < (inventoriesOf c b).count; rwa [facts.1])).2

theorem codes_retained (c : LocalCertificateV19.GroupedCertificate) (p : Packed) (ip : Inside c.groups p)
    (honor : ∃ h, h < (inventoriesOf c 3).count ∧ (inventoriesOf c 3).member h = p.h) :
    SortedCoverage.Retained (inventoriesOf c) (codes c.groups p) := by
  obtain ⟨h,hh,heq⟩ := honor
  have result := IndexedPhysical.codes_retained (inventoriesOf c) c.sharedMembers c.groups c.raw c.link
    p.a p.b p.c h ip.1 ip.2.1 ip.2.2 hh
  simpa only [codes,MovePlanRefinement.mapNumeric,IndexedPhysical.codes,heq] using result

theorem codes_inside (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (p : Packed)
    (ip : Inside c.groups p)
    (honor : ∃ h, h < (inventoriesOf c 3).count ∧ (inventoriesOf c 3).member h = p.h) :
    inside (FullSafeData.summaries (ofCertificate c data).rules) (codes c.groups p) = true := by
  have kept := codes_retained c p ip honor
  apply List.all_eq_true.mpr
  intro b hb
  have choices : b = 0 ∨ b = 1 ∨ b = 2 ∨ b = 3 := by simpa using hb
  have bound : b < 4 := by omega
  apply decide_eq_true
  have range := SortedCoverage.retained_inside (inventoriesOf c) c.inventoryChecked _ kept b bound
  have sizeEq : (inventoriesOf c b).size = (c.core b).size :=
    (c.inventorySizes b bound).trans (c.coreSizes b bound).symm
  change (codes c.groups p).get b < (c.core b).size
  rwa [sizeEq] at range

theorem codes_retainedB (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (p : Packed)
    (ip : Inside c.groups p)
    (honor : ∃ h, h < (inventoriesOf c 3).count ∧ (inventoriesOf c 3).member h = p.h) :
    retainedB (ofCertificate c data) (codes c.groups p) = true := by
  have kept := codes_retained c p ip honor
  apply List.all_eq_true.mpr
  intro b hb
  have choices : b = 0 ∨ b = 1 ∨ b = 2 ∨ b = 3 := by simpa using hb
  have bound : b < 4 := by omega
  obtain ⟨i,hi,heq⟩ := kept b bound
  have inv := (CanonicalInventory.checked_member b _ (c.inventoryChecked b bound) i hi).2
  change (inventoriesOf c b).id ((inventoriesOf c b).member i) = i at inv
  apply decide_eq_true
  change (inventoriesOf c b).id ((codes c.groups p).get b) < (inventoriesOf c b).count ∧
    (inventoriesOf c b).member ((inventoriesOf c b).id ((codes c.groups p).get b)) = _
  rw [← heq,inv]
  exact ⟨hi,rfl⟩

theorem group_label (g : GroupInventory.Data) (checked : GroupInventory.Checked g) (i : Nat) (hi : i < g.count) :
    g.raw (g.retained i) = g.label (g.group i) := by
  have f := GroupInventory.member_facts g checked i hi
  have result := f.label
  rwa [f.code] at result

theorem raw_of_ids (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (p : Packed) (ip : Inside c.groups p) :
    FullSafeData.allRaw (ofCertificate c data).rules (codes c.groups p) =
      PruningAlgebra.join (PruningAlgebra.join (PruningAlgebra.join
        (c.groups.label (c.groups.group p.a)) (c.groups.label (c.groups.group p.b)))
        (c.groups.label (c.groups.group p.c))) (((ofCertificate c data).rules 3).raw p.h) := by
  have a := group_label c.groups c.groupChecked p.a ip.1
  have b := group_label c.groups c.groupChecked p.b ip.2.1
  have cc := group_label c.groups c.groupChecked p.c ip.2.2
  have raw0 : ((ofCertificate c data).rules 0).raw = c.groups.raw := (c.link.raw 0 (by decide)).symm
  have raw1 : ((ofCertificate c data).rules 1).raw = c.groups.raw := (c.link.raw 1 (by decide)).symm
  have raw2 : ((ofCertificate c data).rules 2).raw = c.groups.raw := (c.link.raw 2 (by decide)).symm
  change PruningAlgebra.join (PruningAlgebra.join (PruningAlgebra.join
    (((ofCertificate c data).rules 0).raw (c.groups.retained p.a))
    (((ofCertificate c data).rules 1).raw (c.groups.retained p.b)))
    (((ofCertificate c data).rules 2).raw (c.groups.retained p.c))) _ = _
  rw [raw0,raw1,raw2,a,b,cc]
  rfl

theorem rawChild_inside (g : GroupInventory.Data) (localData : Local) (p : Packed)
    (ip : Inside g p) (b j : Nat) (hb : b < 4)
    (hj : j < if b < 3 then g.count else (localData.inventories 3).count) :
    Inside g (rawChild localData p b j) := by
  have choices : b = 0 ∨ b = 1 ∨ b = 2 ∨ b = 3 := by omega
  rcases choices with rfl | rfl | rfl | rfl
  · exact ⟨hj,ip.2.1,ip.2.2⟩
  · exact ⟨ip.1,hj,ip.2.2⟩
  · exact ⟨ip.1,ip.2.1,hj⟩
  · exact ip

theorem rawChild_honor (g : GroupInventory.Data) (localData : Local) (p : Packed)
    (honor : ∃ h, h < (localData.inventories 3).count ∧ (localData.inventories 3).member h = p.h)
    (b j : Nat) (hb : b < 4)
    (hj : j < if b < 3 then g.count else (localData.inventories 3).count) :
    ∃ h, h < (localData.inventories 3).count ∧
      (localData.inventories 3).member h = (rawChild localData p b j).h := by
  by_cases numeric : b < 3
  · obtain ⟨h,hh,heq⟩ := honor
    refine ⟨h,hh,?_⟩
    have choices : b = 0 ∨ b = 1 ∨ b = 2 := by omega
    rcases choices with rfl | rfl | rfl <;> exact heq
  · exact ⟨j,by simpa only [if_neg numeric] using hj,by simp only [rawChild,if_neg numeric]⟩

theorem safe_of_ids (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (ctx : Context) (p : Packed)
    (ip : Inside c.groups p) (ctxAt : AtContext c.groups ctx p)
    (honor : ∃ h, h < (inventoriesOf c 3).count ∧ (inventoriesOf c 3).member h = p.h)
    (b j : Nat) (hb : b < 4)
    (hj : j < if b < 3 then c.groups.count else (inventoriesOf c 3).count) :
    CachedPackedCheck.safeB (ofCertificate c data) (codes c.groups (rawChild (ofCertificate c data) p b j)) =
      expectedSafe c.groups (ofCertificate c data) ctx b j := by
  have iq := rawChild_inside c.groups (ofCertificate c data) p ip b j hb hj
  have hq := rawChild_honor c.groups (ofCertificate c data) p honor b j hb hj
  have range := codes_inside c data _ iq hq
  change (inside _ _ && decide (PruningAlgebra.fullSafe (FullSafeData.allRaw _ _))) = _
  rw [range,Bool.true_and,raw_of_ids c data _ iq]
  have choices : b = 0 ∨ b = 1 ∨ b = 2 ∨ b = 3 := by omega
  rcases choices with rfl | rfl | rfl | rfl <;>
    simp [expectedSafe,labels,rawChild,Packed.set,ctxAt.1,ctxAt.2.1,ctxAt.2.2.1,ctxAt.2.2.2]

theorem rawChild_codes (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (p : Packed)
    (b j : Nat) (hb : b < 4) :
    CachedPackedCheck.replace (ofCertificate c data) (codes c.groups p) b j =
      codes c.groups (rawChild (ofCertificate c data) p b j) :=
  rawChild_codes_of_members c.groups (ofCertificate c data) (fun b hb => (numeric_member c b hb).2) p b j hb

end Mahjong.LocalBlockSoundnessV19
#print axioms Mahjong.LocalBlockSoundnessV19.numeric_member
#print axioms Mahjong.LocalBlockSoundnessV19.id_of_member
#print axioms Mahjong.LocalBlockSoundnessV19.codes_retained
#print axioms Mahjong.LocalBlockSoundnessV19.codes_inside
#print axioms Mahjong.LocalBlockSoundnessV19.codes_retainedB
#print axioms Mahjong.LocalBlockSoundnessV19.raw_of_ids
#print axioms Mahjong.LocalBlockSoundnessV19.safe_of_ids
#print axioms Mahjong.LocalBlockSoundnessV19.rawChild_codes
