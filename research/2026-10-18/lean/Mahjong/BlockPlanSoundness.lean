import Mahjong.BlockPlanCheck

set_option autoImplicit false

namespace Mahjong.BlockPlanSoundness
open PackedRules GeneralLayer GroupCandidates CanonicalInventory GlobalEnumeration
open CachedPackedCheck BlockPlanCheck SafeGame Generators CanonicalCoverage GlobalOrbitUniqueness

def codes (g : GroupInventory.Data) (p : Packed) : Packed := MovePlanRefinement.mapNumeric g.retained p

def Inside (g : GroupInventory.Data) (p : Packed) : Prop := MovePlanRefinement.Inside g p

def AtContext (g : GroupInventory.Data) (ctx : Context) (p : Packed) : Prop :=
  g.group p.a = ctx.key.1 ∧ g.group p.b = ctx.key.2.1 ∧ g.group p.c = ctx.key.2.2 ∧ p.h = ctx.honorCode

theorem model_groups (bank : Bank) (h : Nat) : (model bank h).groups = groupData bank := rfl

theorem numeric_member (c : Certificate) (b : Nat) (hb : b < 3) :
    (inventoriesOf c b).count = c.groups.count ∧ (inventoriesOf c b).member = c.groups.retained := by
  have shared := c.sharedMembers b hb
  exact ⟨shared.2.trans c.link.count.symm,shared.1.trans c.link.members.symm⟩

theorem id_of_member (c : Certificate) (b : Nat) (hb : b < 3) (i : Nat) (hi : i < c.groups.count) :
    (inventoriesOf c b).id (c.groups.retained i) = i := by
  have facts := numeric_member c b hb
  rw [← facts.2]
  exact (CanonicalInventory.checked_member b _ (c.inventoryChecked b (by omega)) i
    (by change i < (inventoriesOf c b).count; rwa [facts.1])).2

theorem codes_retained (c : Certificate) (p : Packed) (ip : Inside c.groups p)
    (honor : ∃ h, h < (inventoriesOf c 3).count ∧ (inventoriesOf c 3).member h = p.h) :
    SortedCoverage.Retained (inventoriesOf c) (codes c.groups p) := by
  obtain ⟨h,hh,heq⟩ := honor
  have result := IndexedPhysical.codes_retained (inventoriesOf c) c.sharedMembers c.groups c.raw c.link
    p.a p.b p.c h ip.1 ip.2.1 ip.2.2 hh
  simpa only [codes,MovePlanRefinement.mapNumeric,IndexedPhysical.codes,heq] using result

theorem codes_inside (c : Certificate) (data : Nat → SuccessorCache.Data) (p : Packed)
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

theorem codes_retainedB (c : Certificate) (data : Nat → SuccessorCache.Data) (p : Packed)
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

theorem raw_of_ids (c : Certificate) (data : Nat → SuccessorCache.Data) (p : Packed) (ip : Inside c.groups p) :
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

theorem safe_of_ids (c : Certificate) (data : Nat → SuccessorCache.Data) (ctx : Context) (p : Packed)
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

structure ContextFacts (localData : Local) (bank : Bank) (source : IndexOperations.Data) (ctx : Context) : Prop where
  groups : ctx.key.1 < (groupData bank).groups ∧ ctx.key.2.1 < (groupData bank).groups ∧
    ctx.key.2.2 < (groupData bank).groups ∧ ctx.key.1 ≤ ctx.key.2.1 ∧ ctx.key.2.1 ≤ ctx.key.2.2
  source : ctx.sourceBlock < source.directory.blocks ∧ source.key ctx.sourceBlock = ctx.key
  honorBucket : ctx.honorCode = (bank.buckets ctx.sourceHonor).honorCode
  honorRange : ctx.honorCode < (localData.rules 3).summary.core.size
  honorRetained : (localData.inventories 3).id ctx.honorCode < (localData.inventories 3).count ∧
    (localData.inventories 3).member ((localData.inventories 3).id ctx.honorCode) = ctx.honorCode
  safe : expectedSafe (groupData bank) localData ctx 4 0 = true

theorem context_facts (localData : Local) (bank : Bank) (source : IndexOperations.Data) (ctx : Context)
    (accepted : checkContext localData bank source ctx = true) : ContextFacts localData bank source ctx := by
  simp only [checkContext,Bool.and_eq_true,decide_eq_true_eq] at accepted
  exact ⟨accepted.1.1.1.1.1,accepted.1.1.1.1.2,accepted.1.1.1.2,accepted.1.1.2,accepted.1.2,accepted.2⟩

theorem source_facts (localData : Local) (bank : Bank) (source : IndexOperations.Data) (ctx : Context)
    (sourceGroups : source.groups = groupData bank)
    (context : ContextFacts localData bank source ctx) (ids : Triple)
    (accepted : GuardedIndexAccess.guard source ctx.sourceBlock ids = true) :
    Inside (groupData bank) (packIds ctx ids) ∧ AtContext (groupData bank) ctx (packIds ctx ids) ∧
      ids.1 ≤ ids.2.1 ∧ ids.2.1 ≤ ids.2.2 := by
  simp only [GuardedIndexAccess.guard,Bool.and_eq_true,decide_eq_true_eq] at accepted
  obtain ⟨⟨⟨⟨⟨⟨a,b⟩,cc⟩,ab⟩,bc⟩,_⟩,key⟩ := accepted
  rw [sourceGroups] at a b cc key
  have eq : ((groupData bank).group ids.1,(groupData bank).group ids.2.1,(groupData bank).group ids.2.2) = ctx.key :=
    key.symm.trans context.source.2
  have aa := congrArg Prod.fst eq
  have bb := congrArg (fun t : Triple => t.2.1) eq
  have ccc := congrArg (fun t : Triple => t.2.2) eq
  exact ⟨⟨a,b,cc⟩,⟨aa,bb,ccc,rfl⟩,ab,bc⟩

theorem codes_sourceId (c : Certificate) (data : Nat → SuccessorCache.Data) (ctx : Context) (p : Packed)
    (ip : Inside c.groups p) (ctxAt : AtContext c.groups ctx p) (b : Nat) (hb : b < 4) :
    CachedPackedCheck.sourceId (ofCertificate c data) (codes c.groups p) b =
      BlockPlanCheck.sourceId (ofCertificate c data) ctx p b := by
  have cases : b = 0 ∨ b = 1 ∨ b = 2 ∨ b = 3 := by omega
  rcases cases with rfl | rfl | rfl | rfl
  · exact id_of_member c 0 (by decide) p.a ip.1
  · exact id_of_member c 1 (by decide) p.b ip.2.1
  · exact id_of_member c 2 (by decide) p.c ip.2.2
  · change (inventoriesOf c 3).id p.h = (inventoriesOf c 3).id ctx.honorCode
    rw [ctxAt.2.2.2]

theorem group_get (g : GroupInventory.Data) (ctx : Context) (p : Packed) (ctxAt : AtContext g ctx p)
    (b : Nat) (hb : b < 3) : g.group (p.get b) = keyGet ctx.key b := by
  have choices : b = 0 ∨ b = 1 ∨ b = 2 := by omega
  rcases choices with rfl | rfl | rfl
  · exact ctxAt.1
  · exact ctxAt.2.1
  · exact ctxAt.2.2.1

theorem plan_row_facts (localData : Local) (bank : Bank) (source : IndexOperations.Data)
    (ctx : Context) (plan : Plan) (groupsChecked : GroupInventory.Checked (groupData bank))
    (accepted : checkPlan localData bank source ctx plan = true) (p : Packed)
    (ip : Inside (groupData bank) p) (ctxAt : AtContext (groupData bank) ctx p)
    (b : Nat) (hb : b < 4) :
    ((plan.rows b (planIndex p b)).map Edge.j = (localData.edges b).next (BlockPlanCheck.sourceId localData ctx p b)) ∧
      (plan.rows b (planIndex p b)).all (checkEdge localData bank ctx b) = true := by
  simp only [checkPlan,Bool.and_eq_true] at accepted
  by_cases numeric : b < 3
  · have ib : p.get b < (groupData bank).count := by
      have choices : b = 0 ∨ b = 1 ∨ b = 2 := by omega
      rcases choices with rfl | rfl | rfl
      · exact ip.1
      · exact ip.2.1
      · exact ip.2.2
    have facts := GroupInventory.member_facts (groupData bank) groupsChecked (p.get b) ib
    have keyEq := group_get _ ctx p ctxAt b numeric
    have position := facts.offset
    have width := facts.member
    rw [keyEq] at position width
    have scan := List.all_eq_true.mp accepted.1.2 b (List.mem_range.mpr numeric)
    have offset : p.get b-(groupData bank).first (keyGet ctx.key b) < (groupData bank).size (keyGet ctx.key b) := by
      omega
    have atRow := checkSpan_each _ ((groupData bank).size (keyGet ctx.key b))
      ((groupData bank).first (keyGet ctx.key b)) scan _ offset
    have indexEq : (groupData bank).first (keyGet ctx.key b) +
      (p.get b-(groupData bank).first (keyGet ctx.key b)) = p.get b := by omega
    rw [indexEq] at atRow
    simpa only [BlockPlanCheck.checkRow,planIndex,BlockPlanCheck.sourceId,if_pos numeric,Bool.and_eq_true,decide_eq_true_eq] using atRow
  · have eq : b = 3 := by omega
    subst b
    simpa only [BlockPlanCheck.checkRow,planIndex,BlockPlanCheck.sourceId,show ¬ 3 < 3 by omega,if_false,
      Bool.and_eq_true,decide_eq_true_eq] using accepted.2

theorem rawChild_codes_of_members (g : GroupInventory.Data) (localData : Local)
    (members : ∀ b, b < 3 → (localData.inventories b).member = g.retained) (p : Packed)
    (b j : Nat) (hb : b < 4) :
    CachedPackedCheck.replace localData (codes g p) b j = codes g (rawChild localData p b j) := by
  have choices : b = 0 ∨ b = 1 ∨ b = 2 ∨ b = 3 := by omega
  rcases choices with rfl | rfl | rfl | rfl
  · change Packed.mk ((localData.inventories 0).member j) _ _ _ = _
    rw [members 0 (by decide)]
    rfl
  · change Packed.mk _ ((localData.inventories 1).member j) _ _ = _
    rw [members 1 (by decide)]
    rfl
  · change Packed.mk _ _ ((localData.inventories 2).member j) _ = _
    rw [members 2 (by decide)]
    rfl
  · rfl

theorem rawChild_codes (c : Certificate) (data : Nat → SuccessorCache.Data) (p : Packed)
    (b j : Nat) (hb : b < 4) :
    CachedPackedCheck.replace (ofCertificate c data) (codes c.groups p) b j =
      codes c.groups (rawChild (ofCertificate c data) p b j) :=
  rawChild_codes_of_members c.groups (ofCertificate c data) (fun b hb => (numeric_member c b hb).2) p b j hb

theorem mapped_compare_path (f : Nat → Nat) (p : Packed) (a b : Fin 3) :
    ∃ path, Base5Coverage.unpack (MovePlanRefinement.mapNumeric f (SuitSorting.compareSwap id a b p)) =
      applyPath path (Base5Coverage.unpack (MovePlanRefinement.mapNumeric f p)) := by
  unfold SuitSorting.compareSwap
  split
  · exact ⟨[.swapSuits a b],by rw [MovePlanRefinement.map_swap]; exact SuitSorting.swapped_state a b _⟩
  · exact ⟨[],rfl⟩

theorem mapped_sort_path (f : Nat → Nat) (p : Packed) :
    ∃ path, Base5Coverage.unpack (MovePlanRefinement.mapNumeric f (SuitSorting.sort id p)) =
      applyPath path (Base5Coverage.unpack (MovePlanRefinement.mapNumeric f p)) := by
  obtain ⟨a,ha⟩ := mapped_compare_path f p 0 1
  obtain ⟨b,hb⟩ := mapped_compare_path f (SuitSorting.compareSwap id 0 1 p) 1 2
  obtain ⟨cc,hc⟩ := mapped_compare_path f (SuitSorting.compareSwap id 1 2 (SuitSorting.compareSwap id 0 1 p)) 0 1
  refine ⟨a++b++cc,?_⟩
  rw [CanonicalCoverage.path_append,CanonicalCoverage.path_append,← ha,← hb]
  exact hc

theorem shadow_is_shadow (g : GroupInventory.Data) (ctx : Context) (p : Packed) (ctxAt : AtContext g ctx p) :
    MovePlanRefinement.shadow g p = BlockPlanCheck.shadow g ctx := by
  simp only [MovePlanRefinement.shadow,MovePlanRefinement.mapNumeric,BlockPlanCheck.shadow,
    ctxAt.1,ctxAt.2.1,ctxAt.2.2.1,ctxAt.2.2.2]

theorem shadow_child_groups (g : GroupInventory.Data) (checked : GroupInventory.Checked g)
    (localData : Local) (ctx : Context) (p : Packed) (ip : Inside g p) (ctxAt : AtContext g ctx p)
    (b j : Nat) (hb : b < 4) (hj : j < if b < 3 then g.count else (localData.inventories 3).count) :
    Inside g (shadowChild g localData ctx b j) ∧
      groupKey g (SuitSorting.sort id (rawChild localData p b j)) =
        groupKey g (SuitSorting.sort id (shadowChild g localData ctx b j)) := by
  have sh := MovePlanRefinement.shadow_inside_and_groups g checked p ip
  rw [shadow_is_shadow g ctx p ctxAt] at sh
  by_cases numeric : b < 3
  · have jbound : j < g.count := by simpa only [if_pos numeric] using hj
    have ft := MovePlanRefinement.first_of_group g checked j jbound
    have iq := rawChild_inside g localData p ip b j hb hj
    have is := rawChild_inside g localData (BlockPlanCheck.shadow g ctx) sh.1 b
      (g.first (g.group j)) hb (by simpa only [if_pos numeric] using ft.1)
    have is' : Inside g (shadowChild g localData ctx b j) := by simpa only [shadowChild,if_pos numeric] using is
    refine ⟨is',?_⟩
    have equality : MovePlanRefinement.mapNumeric g.group (rawChild localData p b j) =
      MovePlanRefinement.mapNumeric g.group (shadowChild g localData ctx b j) := by
      have choices : b = 0 ∨ b = 1 ∨ b = 2 := by omega
      have base := sh.2
      have sa := congrArg Packed.a base
      have sb := congrArg Packed.b base
      have sc := congrArg Packed.c base
      change g.group (BlockPlanCheck.shadow g ctx).a = g.group p.a at sa
      change g.group (BlockPlanCheck.shadow g ctx).b = g.group p.b at sb
      change g.group (BlockPlanCheck.shadow g ctx).c = g.group p.c at sc
      have hsame : (BlockPlanCheck.shadow g ctx).h = ctx.honorCode := rfl
      rcases choices with rfl | rfl | rfl <;>
        simp only [rawChild,shadowChild,MovePlanRefinement.mapNumeric,Packed.set,show 0 < 3 by omega,
          show 1 < 3 by omega,show 2 < 3 by omega,if_true,ft.2,sa,sb,sc,ctxAt.2.2.2,hsame]
    have sorted := MovePlanRefinement.same_sorted_groups g checked _ _ iq is' (congrArg GlobalOrbitKey.signature equality)
    exact congrArg (fun q : Packed => (q.a,q.b,q.c)) sorted
  · have eq : b = 3 := by omega
    subst b
    have is := rawChild_inside g localData (BlockPlanCheck.shadow g ctx) sh.1 3 j (by omega) hj
    change Inside g (shadowChild g localData ctx 3 j) at is
    refine ⟨is,?_⟩
    have iq := rawChild_inside g localData p ip 3 j (by omega) hj
    have equality : MovePlanRefinement.mapNumeric g.group (rawChild localData p 3 j) =
      MovePlanRefinement.mapNumeric g.group (shadowChild g localData ctx 3 j) := by
      have base := sh.2
      have sa := congrArg Packed.a base
      have sb := congrArg Packed.b base
      have sc := congrArg Packed.c base
      change g.group (BlockPlanCheck.shadow g ctx).a = g.group p.a at sa
      change g.group (BlockPlanCheck.shadow g ctx).b = g.group p.b at sb
      change g.group (BlockPlanCheck.shadow g ctx).c = g.group p.c at sc
      simp only [rawChild,shadowChild,MovePlanRefinement.mapNumeric,show ¬3 < 3 by omega,
        if_false,sa,sb,sc]
    have sorted := MovePlanRefinement.same_sorted_groups g checked _ _ iq is (congrArg GlobalOrbitKey.signature equality)
    exact congrArg (fun q : Packed => (q.a,q.b,q.c)) sorted

theorem childNumeric_eq (localData : Local) (p : Packed) (b j : Nat) :
    childNumeric p b j =
      let q := SuitSorting.sort id (rawChild localData p b j)
      (q.a,q.b,q.c) := by
  by_cases numeric : b < 3
  · simp only [childNumeric,rawChild,if_pos numeric]
  · simp only [childNumeric,rawChild,if_neg numeric]
    simp only [SuitSorting.sort,SuitSorting.compare01,SuitSorting.compare12,id_eq]
    repeat' first | rfl | split

theorem shadow_child_honor (g : GroupInventory.Data) (localData : Local) (ctx : Context)
    (p : Packed) (ctxAt : AtContext g ctx p) (b j : Nat) (hb : b < 4) :
    (SuitSorting.sort id (shadowChild g localData ctx b j)).h =
      (SuitSorting.sort id (rawChild localData p b j)).h := by
  rw [SuitSorting.sort_honor,SuitSorting.sort_honor]
  by_cases numeric : b < 3
  · have choices : b = 0 ∨ b = 1 ∨ b = 2 := by omega
    rcases choices with rfl | rfl | rfl <;> exact ctxAt.2.2.2.symm
  · simp only [shadowChild,rawChild,if_neg numeric]

theorem edge_j (localData : Local) (bank : Bank) (ctx : Context) (b : Nat) (e : Edge)
    (accepted : checkEdge localData bank ctx b e = true) :
    e.j < (if b < 3 then (groupData bank).count else (localData.inventories 3).count) ∧
      e.safe = expectedSafe (groupData bank) localData ctx b e.j := by
  simp only [checkEdge,Bool.and_eq_true,decide_eq_true_eq] at accepted
  exact accepted.1

structure EdgeFacts (localData : Local) (bank : Bank) (ctx : Context) (b : Nat) (e : Edge) : Prop where
  bound : e.j < if b < 3 then (groupData bank).count else (localData.inventories 3).count
  safeEq : e.safe = expectedSafe (groupData bank) localData ctx b e.j
  positive : 0 < (bank.buckets e.targetHonor).size
  honor : (bank.buckets e.targetHonor).honorCode =
    (SuitSorting.sort id (shadowChild (groupData bank) localData ctx b e.j)).h
  block : e.targetBlock < (model bank e.targetHonor).directory.blocks
  key : (model bank e.targetHonor).key e.targetBlock =
    groupKey (groupData bank) (SuitSorting.sort id (shadowChild (groupData bank) localData ctx b e.j))
  word : BlockWordAddress.check (model bank e.targetHonor) e.targetBlock e.word = true

theorem edge_facts (localData : Local) (bank : Bank) (ctx : Context) (b : Nat) (e : Edge)
    (accepted : checkEdge localData bank ctx b e = true) (safe : e.safe = true) :
    EdgeFacts localData bank ctx b e := by
  have pre := edge_j localData bank ctx b e accepted
  simp only [checkEdge,Bool.and_eq_true,decide_eq_true_eq,safe,if_true] at accepted
  exact ⟨pre.1,pre.2,accepted.2.1.1.1.1,accepted.2.1.1.1.2,
    accepted.2.1.1.2,accepted.2.1.2,accepted.2.2⟩

theorem target_guard (localData : Local) (bank : Bank) (ctx : Context)
    (groupChecked : GroupInventory.Checked (groupData bank)) (p : Packed)
    (ip : Inside (groupData bank) p) (ctxAt : AtContext (groupData bank) ctx p)
    (b : Nat) (hb : b < 4) (e : Edge) (facts : EdgeFacts localData bank ctx b e) :
    GuardedIndexAccess.guard (model bank e.targetHonor) e.targetBlock (childNumeric p b e.j) = true := by
  have iq := rawChild_inside (groupData bank) localData p ip b e.j hb facts.bound
  have sq := MovePlanRefinement.sort_inside (groupData bank) (rawChild localData p b e.j) iq
  have order := SuitSorting.sorted_order id (rawChild localData p b e.j)
  have keys := (shadow_child_groups (groupData bank) groupChecked localData ctx p ip ctxAt b e.j hb facts.bound).2
  have key := facts.key.trans keys.symm
  rw [childNumeric_eq localData p b e.j]
  simp only [GuardedIndexAccess.guard,Bool.and_eq_true,decide_eq_true_eq]
  exact ⟨⟨⟨⟨⟨⟨sq.1,sq.2.1⟩,sq.2.2⟩,order.1⟩,order.2⟩,facts.block⟩,key⟩

theorem label_strategy (c : Certificate) (data : Nat → SuccessorCache.Data)
    (bank : Bank) (groupEq : groupData bank = c.groups)
    (metadata : GuardedTargetRef.Checked (guardedBank bank))
    (correct : TargetCorrect (FullSafeData.summaries (ofCertificate c data).rules)
      (GuardedTargetRef.target (guardedBank bank)))
    (ctx : Context) (p : Packed) (ip : Inside c.groups p) (ctxAt : AtContext c.groups ctx p)
    (b : Nat) (hb : b < 4) (e : Edge)
    (accepted : checkEdge (ofCertificate c data) bank ctx b e = true) (safe : e.safe = true) :
    NormalStrategy SafeMove (Base5Coverage.unpack (codes c.groups (rawChild (ofCertificate c data) p b e.j)))
      (outcome (label bank p b e)) := by
  let localData := ofCertificate c data
  let q := SuitSorting.sort id (rawChild localData p b e.j)
  let ids := childNumeric p b e.j
  let m := model bank e.targetHonor
  have groupsChecked : GroupInventory.Checked (groupData bank) := by rw [groupEq]; exact c.groupChecked
  have ip' : Inside (groupData bank) p := by rwa [groupEq]
  have ctxAt' : AtContext (groupData bank) ctx p := by rwa [groupEq]
  have facts := edge_facts localData bank ctx b e accepted safe
  have guard := target_guard localData bank ctx groupsChecked p ip' ctxAt' b hb e facts
  have indexChecked := metadata.index e.targetHonor facts.positive
  have fits := metadata.fits e.targetHonor facts.positive
  have limits := metadata.limits e.targetHonor facts.positive
  have word := BlockWordAddress.checked_address_eq m indexChecked.groups e.targetBlock e.word ids facts.word guard
  have bound : (BlockWordAddress.address e.word ids).toNat < (bank.buckets e.targetHonor).size := by
    rw [word]
    exact GuardedIndexAccess.address_bound m indexChecked fits limits _ _ guard
  have inverse := LegacyIndexRefinement.guarded_legacy_inverse (legacyBucket bank e.targetHonor).data
    bank.shared.raw bank.shared.members indexChecked fits limits e.targetBlock ids guard
  change BucketIndex.unrank (legacyBucket bank e.targetHonor).data
    (GuardedIndexAccess.address m e.targetBlock ids).toNat = _ at inverse
  have honorEq : (bank.buckets e.targetHonor).honorCode = q.h :=
    facts.honor.trans (shadow_child_honor (groupData bank) localData ctx p ctxAt' b e.j hb)
  have stateEq : BucketIndex.unrank (legacyBucket bank e.targetHonor).data
      (BlockWordAddress.address e.word ids).toNat = codes c.groups q := by
    rw [word,inverse]
    change Packed.mk ((groupData bank).retained ids.1) ((groupData bank).retained ids.2.1)
      ((groupData bank).retained ids.2.2) (bank.buckets e.targetHonor).honorCode = _
    have idEq : ids = (q.a,q.b,q.c) := childNumeric_eq localData p b e.j
    rw [idEq,groupEq,honorEq]
    rfl
  have result := correct e.targetHonor (BlockWordAddress.address e.word ids).toNat bound
  change NormalStrategy SafeMove (PackedRules.state (FullSafeData.summaries localData.rules)
    (BucketIndex.unrank (legacyBucket bank e.targetHonor).data (BlockWordAddress.address e.word ids).toNat))
    (outcome (label bank p b e)) at result
  rw [stateEq,CachedPackedCheck.state_eq] at result
  obtain ⟨path,pathEq⟩ := mapped_sort_path c.groups.retained (rawChild localData p b e.j)
  change Base5Coverage.unpack (codes c.groups q) = _ at pathEq
  rw [pathEq] at result
  exact (path_preserves_outcome path _ _).mpr result

theorem source_initial (c : Certificate) (data : Nat → SuccessorCache.Data) (bank : Bank)
    (groupEq : groupData bank = c.groups) (source : IndexOperations.Data) (ctx : Context)
    (context : ContextFacts (ofCertificate c data) bank source ctx)
    (p : Packed) (ip : Inside c.groups p) (ctxAt : AtContext c.groups ctx p) :
    initial (ofCertificate c data) (codes c.groups p) = true := by
  have honor : ∃ h, h < (inventoriesOf c 3).count ∧ (inventoriesOf c 3).member h = p.h :=
    ⟨(inventoriesOf c 3).id ctx.honorCode,context.honorRetained.1,
      context.honorRetained.2.trans ctxAt.2.2.2.symm⟩
  have range := codes_inside c data p ip honor
  have retained := codes_retainedB c data p ip honor
  have safe : CachedPackedCheck.safeB (ofCertificate c data) (codes c.groups p) = true := by
    change (inside _ _ && decide (PruningAlgebra.fullSafe (FullSafeData.allRaw _ _))) = true
    rw [range,Bool.true_and,raw_of_ids c data p ip]
    have yes := context.safe
    rw [groupEq] at yes
    simpa only [expectedSafe,labels,show ¬4=0 by omega,show ¬4=1 by omega,show ¬4=2 by omega,
      show ¬4=3 by omega,if_false,ctxAt.1,ctxAt.2.1,ctxAt.2.2.1,ctxAt.2.2.2] using yes
  simp only [initial,Bool.and_eq_true]
  exact ⟨⟨range,retained⟩,safe⟩

theorem row_inventory (c : Certificate) (data : Nat → SuccessorCache.Data) (bank : Bank)
    (groupEq : groupData bank = c.groups) (source : IndexOperations.Data) (ctx : Context) (plan : Plan)
    (prepared : checkPlan (ofCertificate c data) bank source ctx plan = true)
    (p : Packed) (ip : Inside c.groups p) (ctxAt : AtContext c.groups ctx p) (b : Nat) (hb : b < 4) :
    ((plan.rows b (planIndex p b)).map Edge.j = (data b).next
      (CachedPackedCheck.sourceId (ofCertificate c data) (codes c.groups p) b)) ∧
      (plan.rows b (planIndex p b)).all (checkEdge (ofCertificate c data) bank ctx b) = true := by
  have groupsChecked : GroupInventory.Checked (groupData bank) := by rw [groupEq]; exact c.groupChecked
  have ip' : Inside (groupData bank) p := by rwa [groupEq]
  have ctxAt' : AtContext (groupData bank) ctx p := by rwa [groupEq]
  have result := plan_row_facts (ofCertificate c data) bank source ctx plan groupsChecked prepared p ip' ctxAt' b hb
  rw [← codes_sourceId c data ctx p ip ctxAt b hb] at result
  exact result

theorem plan_entry (c : Certificate) (data : Nat → SuccessorCache.Data) (bank : Bank)
    (groupEq : groupData bank = c.groups) (source : IndexOperations.Data) (ctx : Context) (plan : Plan)
    (prepared : checkPlan (ofCertificate c data) bank source ctx plan = true)
    (context : ContextFacts (ofCertificate c data) bank source ctx)
    (p : Packed) (ip : Inside c.groups p) (ctxAt : AtContext c.groups ctx p)
    (b : Nat) (hb : b < 4) (e : Edge) (member : e ∈ plan.rows b (planIndex p b)) :
    checkEdge (ofCertificate c data) bank ctx b e = true ∧
      codes c.groups (rawChild (ofCertificate c data) p b e.j) ∈
        CachedPackedCheck.raw (ofCertificate c data) (codes c.groups p) ∧
      CachedPackedCheck.safeB (ofCertificate c data) (codes c.groups (rawChild (ofCertificate c data) p b e.j)) = e.safe := by
  have inventory := row_inventory c data bank groupEq source ctx plan prepared p ip ctxAt b hb
  have entryCheck := List.all_eq_true.mp inventory.2 e member
  have cacheMem : e.j ∈ (data b).next (CachedPackedCheck.sourceId (ofCertificate c data) (codes c.groups p) b) := by
    rw [← inventory.1]
    exact List.mem_map.mpr ⟨e,member,rfl⟩
  have mem := (CachedPackedCheck.raw_mem (ofCertificate c data) (codes c.groups p) _).mpr
    ⟨b,e.j,hb,cacheMem,(rawChild_codes c data p b e.j hb).symm⟩
  have facts := edge_j (ofCertificate c data) bank ctx b e entryCheck
  have bound : e.j < if b < 3 then c.groups.count else (inventoriesOf c 3).count := by
    have h := facts.1
    change e.j < (if b < 3 then (groupData bank).count else (inventoriesOf c 3).count) at h
    rwa [groupEq] at h
  have honor : ∃ h, h < (inventoriesOf c 3).count ∧ (inventoriesOf c 3).member h = p.h :=
    ⟨(inventoriesOf c 3).id ctx.honorCode,context.honorRetained.1,
      context.honorRetained.2.trans ctxAt.2.2.2.symm⟩
  have safeEq := safe_of_ids c data ctx p ip ctxAt honor b e.j hb bound
  have planned := facts.2
  rw [groupEq] at planned
  exact ⟨entryCheck,mem,safeEq.trans planned.symm⟩

theorem row_sound (c : Certificate) (data : Nat → SuccessorCache.Data)
    (cacheChecked : GlobalSuccessorBridge.Checked c data) (bank : Bank)
    (groupEq : groupData bank = c.groups) (metadata : GuardedTargetRef.Checked (guardedBank bank))
    (correct : TargetCorrect (FullSafeData.summaries (ofCertificate c data).rules)
      (GuardedTargetRef.target (guardedBank bank)))
    (source : IndexOperations.Data) (sourceGroups : source.groups = groupData bank)
    (ctx : Context) (plan : Plan) (prepared : checkPlan (ofCertificate c data) bank source ctx plan = true)
    (ids : Triple) (r : Nat) (sourceP : Bool)
    (accepted : BlockPlanCheck.row bank source ctx plan ids r sourceP = true) :
    IsSafe (Base5Coverage.unpack (codes c.groups (packIds ctx ids))) ∧
      NormalStrategy SafeMove (Base5Coverage.unpack (codes c.groups (packIds ctx ids))) (outcome sourceP) := by
  have ctxReady : checkContext (ofCertificate c data) bank source ctx = true := by
    have parts := prepared
    simp only [checkPlan,Bool.and_eq_true] at parts
    exact parts.1.1
  have context := context_facts (ofCertificate c data) bank source ctx ctxReady
  simp only [BlockPlanCheck.row,Bool.and_eq_true] at accepted
  have guard : GuardedIndexAccess.guard source ctx.sourceBlock ids = true := by
    have h := accepted.1
    simp only [GuardedIndexAccess.checkAddress,Bool.and_eq_true] at h
    exact h.1
  have sf := source_facts (ofCertificate c data) bank source ctx sourceGroups context ids guard
  have ip : Inside c.groups (packIds ctx ids) := by simpa only [groupEq] using sf.1
  have ctxAt : AtContext c.groups ctx (packIds ctx ids) := by simpa only [groupEq] using sf.2.1
  let p := packIds ctx ids
  have ready := source_initial c data bank groupEq source ctx context p ip ctxAt
  have facts := CachedPackedCheck.initial_facts c data (codes c.groups p) ready
  refine ⟨facts.2.2,?_⟩
  cases sourceP with
  | true =>
    have scan := accepted.2
    simp only [↓reduceIte] at scan
    change ((List.range 4).all _) = true at scan
    apply NormalStrategy.p
    intro t physical
    obtain ⟨q,qMem,orbit⟩ := CachedPackedCheck.children_complete c data cacheChecked
      (codes c.groups p) facts.1 facts.2.1 t physical
    obtain ⟨qRaw,qSafe⟩ := List.mem_filter.mp qMem
    obtain ⟨b,j,hb,jMem,qEq⟩ := (CachedPackedCheck.raw_mem _ _ q).mp qRaw
    have inventory := row_inventory c data bank groupEq source ctx plan prepared p ip ctxAt b hb
    have inMap : j ∈ (plan.rows b (planIndex p b)).map Edge.j := by rw [inventory.1]; exact jMem
    obtain ⟨e,eMem,ej⟩ := List.mem_map.mp inMap
    have entry := plan_entry c data bank groupEq source ctx plan prepared context p ip ctxAt b hb e eMem
    have qCodes : q = codes c.groups (rawChild (ofCertificate c data) p b e.j) := by
      rw [qEq,rawChild_codes c data p b j hb,ej]
    have safe : e.safe = true := by rw [← entry.2.2,← qCodes]; exact qSafe
    have labels := List.all_eq_true.mp scan b (List.mem_range.mpr hb)
    have noP := List.all_eq_true.mp labels e eMem
    simp only [safe,Bool.not_true,Bool.false_or,Bool.not_eq_true'] at noP
    change label bank p b e = false at noP
    have strategy := label_strategy c data bank groupEq metadata correct ctx p ip ctxAt b hb e entry.1 safe
    simp only [noP,outcome,Bool.false_eq_true,↓reduceIte] at strategy
    rw [← qCodes] at strategy
    obtain ⟨path,pathEq⟩ := orbit
    rw [pathEq] at strategy
    exact (path_preserves_outcome path t .N).mpr strategy
  | false =>
    have scan := accepted.2
    simp only [Bool.false_eq_true,↓reduceIte] at scan
    change ((List.range 4).any _) = true at scan
    obtain ⟨b,bMem,hit⟩ := List.any_eq_true.mp scan
    have hb : b < 4 := List.mem_range.mp bMem
    obtain ⟨e,eMem,pass⟩ := List.any_eq_true.mp hit
    simp only [Bool.and_eq_true] at pass
    have entry := plan_entry c data bank groupEq source ctx plan prepared context p ip ctxAt b hb e eMem
    have safe : CachedPackedCheck.safeB (ofCertificate c data)
      (codes c.groups (rawChild (ofCertificate c data) p b e.j)) = true := entry.2.2.trans pass.1
    have childMem : codes c.groups (rawChild (ofCertificate c data) p b e.j) ∈
      CachedPackedCheck.children (ofCertificate c data) (codes c.groups p) := List.mem_filter.mpr ⟨entry.2.1,safe⟩
    have edge := CachedPackedCheck.child_edge c data cacheChecked _ _ facts.1 facts.2.1 childMem
    obtain ⟨t,move,orbit,_⟩ := GlobalSuccessorBridge.edge_sound c data cacheChecked _ _
      (CachedPackedCheck.packed_valid c data _ facts.1) edge
    have strategy := label_strategy c data bank groupEq metadata correct ctx p ip ctxAt b hb e entry.1 pass.1
    have yes : label bank p b e = true := pass.2
    simp only [yes,outcome,↓reduceIte] at strategy
    apply NormalStrategy.n move
    obtain ⟨path,pathEq⟩ := orbit
    rw [pathEq] at strategy
    exact (path_preserves_outcome path t .P).mpr strategy

theorem row_original (c : Certificate) (data : Nat → SuccessorCache.Data)
    (cacheChecked : GlobalSuccessorBridge.Checked c data) (bank : Bank)
    (groupEq : groupData bank = c.groups) (metadata : GuardedTargetRef.Checked (guardedBank bank))
    (correct : TargetCorrect (FullSafeData.summaries (ofCertificate c data).rules)
      (GuardedTargetRef.target (guardedBank bank)))
    (source : IndexOperations.Data) (sourceGroups : source.groups = groupData bank)
    (ctx : Context) (plan : Plan) (prepared : checkPlan (ofCertificate c data) bank source ctx plan = true)
    (ids : Triple) (r : Nat) (sourceP : Bool)
    (accepted : BlockPlanCheck.row bank source ctx plan ids r sourceP = true) :
    AchievementStrategy Step Win (Base5Coverage.unpack (codes c.groups (packIds ctx ids))) (outcome sourceP) := by
  have result := row_sound c data cacheChecked bank groupEq metadata correct source sourceGroups ctx plan prepared ids r sourceP accepted
  exact (original_safe_reduction result.1).mp result.2

theorem single_implies_row (bank : Bank) (source : IndexOperations.Data) (ctx : Context) (plan : Plan)
    (ids : Triple) (r b j : Nat) (accepted : BlockPlanCheck.single bank source ctx plan ids r b j = true) :
    BlockPlanCheck.row bank source ctx plan ids r false = true := by
  simp only [BlockPlanCheck.single,Bool.and_eq_true,decide_eq_true_eq] at accepted
  obtain ⟨⟨sourceGuard,hb⟩,hit⟩ := accepted
  obtain ⟨e,eMem,pass⟩ := List.any_eq_true.mp hit
  simp only [Bool.and_eq_true] at pass
  simp only [BlockPlanCheck.row,Bool.false_eq_true,↓reduceIte,Bool.and_eq_true]
  exact ⟨sourceGuard,List.any_eq_true.mpr ⟨b,List.mem_range.mpr hb,
    List.any_eq_true.mpr ⟨e,eMem,by simp only [Bool.and_eq_true]; exact ⟨pass.1.2,pass.2⟩⟩⟩⟩

theorem single_original (c : Certificate) (data : Nat → SuccessorCache.Data)
    (cacheChecked : GlobalSuccessorBridge.Checked c data) (bank : Bank)
    (groupEq : groupData bank = c.groups) (metadata : GuardedTargetRef.Checked (guardedBank bank))
    (correct : TargetCorrect (FullSafeData.summaries (ofCertificate c data).rules)
      (GuardedTargetRef.target (guardedBank bank)))
    (source : IndexOperations.Data) (sourceGroups : source.groups = groupData bank)
    (ctx : Context) (plan : Plan) (prepared : checkPlan (ofCertificate c data) bank source ctx plan = true)
    (ids : Triple) (r b j : Nat) (accepted : BlockPlanCheck.single bank source ctx plan ids r b j = true) :
    AchievementStrategy Step Win (Base5Coverage.unpack (codes c.groups (packIds ctx ids))) .N :=
  row_original c data cacheChecked bank groupEq metadata correct source sourceGroups ctx plan prepared ids r false
    (single_implies_row bank source ctx plan ids r b j accepted)

end Mahjong.BlockPlanSoundness

#print axioms Mahjong.BlockPlanSoundness.numeric_member
#print axioms Mahjong.BlockPlanSoundness.codes_inside
#print axioms Mahjong.BlockPlanSoundness.raw_of_ids
#print axioms Mahjong.BlockPlanSoundness.safe_of_ids
#print axioms Mahjong.BlockPlanSoundness.plan_row_facts
#print axioms Mahjong.BlockPlanSoundness.shadow_child_groups
#print axioms Mahjong.BlockPlanSoundness.target_guard
#print axioms Mahjong.BlockPlanSoundness.label_strategy
#print axioms Mahjong.BlockPlanSoundness.source_initial
#print axioms Mahjong.BlockPlanSoundness.row_inventory
#print axioms Mahjong.BlockPlanSoundness.plan_entry
#print axioms Mahjong.BlockPlanSoundness.row_sound
#print axioms Mahjong.BlockPlanSoundness.row_original
#print axioms Mahjong.BlockPlanSoundness.single_implies_row
#print axioms Mahjong.BlockPlanSoundness.single_original
