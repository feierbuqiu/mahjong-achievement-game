import Mahjong.GeneratedPlanCheck
import Mahjong.HotBlockPlan
import Mahjong.CachedPackedSnapshot

set_option autoImplicit false

namespace Mahjong.GeneratedHotPlan
open PackedRules GroupCandidates BlockPlanCheck

/-- Only one hot entry per shared template. Actual successor IDs remain in the
checked local successor cache, rather than being copied into every source block. -/
structure Table where
  slots : Array Nat
  entries : Array HotBlockPlan.HotEdge

structure Snapshot where
  tables : Array Table
  fallbackTable : Nat → Table
  fallback : HotBlockPlan.HotEdge
  key : Nat → Nat → Nat
  next : Nat → Nat → List Nat

/-- Shared by all source blocks in one native epoch. The original total group
reader is preserved outside the finite materialized range as well. -/
structure Shared where
  groups : CachedPackedSnapshot.Memo Nat

@[noinline] def buildShared (g : GroupInventory.Data) : Shared :=
  ⟨CachedPackedSnapshot.buildMemo g.count g.group⟩

def hotTable (bank : Bank) (tables : GeneratedPlanCheck.Tables) (b : Nat) : Table :=
  let table := tables.get b
  ⟨table.slots,table.entries.map (HotBlockPlan.ofEdge bank)⟩

@[noinline] def buildWithShared (localData : CachedPackedCheck.Local) (bank : Bank)
    (ctx : Context) (tables : GeneratedPlanCheck.Tables) (shared : Shared) : Snapshot :=
  let f := hotTable bank tables
  let honorNext := (localData.edges 3).next (GeneratedPlanCheck.sourceKey localData ctx 3)
  ⟨Array.ofFn (fun b : Fin 4 => f b.val),f,
    HotBlockPlan.ofEdge bank GeneratedPlanCheck.fallback,
    (fun b j => if b < 3 then CachedPackedSnapshot.readMemo shared.groups j else j),
    fun b i => if b < 3 then (localData.edges b).next i else
      if b = 3 then honorNext else (localData.edges b).next (GeneratedPlanCheck.sourceKey localData ctx b)⟩

/-- Specification used in the soundness theorem. The executable constructs the
same shared value once and passes it to buildWithShared for each source block. -/
def build (localData : CachedPackedCheck.Local) (bank : Bank)
    (ctx : Context) (tables : GeneratedPlanCheck.Tables) : Snapshot :=
  buildWithShared localData bank ctx tables (buildShared (groupData bank))

theorem buildWithShared_buildShared (localData : CachedPackedCheck.Local) (bank : Bank)
    (ctx : Context) (tables : GeneratedPlanCheck.Tables) :
    buildWithShared localData bank ctx tables (buildShared (groupData bank)) =
      build localData bank ctx tables := rfl

@[inline] def getTable (snapshot : @& Snapshot) (b : Nat) : Table :=
  if h : b < snapshot.tables.size then snapshot.tables[b] else snapshot.fallbackTable b

@[inline] def template (snapshot : @& Snapshot) (b j : Nat) : HotBlockPlan.HotEdge :=
  let table := getTable snapshot b
  table.entries.getD (table.slots.getD (snapshot.key b j) table.entries.size) snapshot.fallback

@[inline] def label (entry : @& HotBlockPlan.HotEdge)
    (a b c axis j : Nat) : Bool :=
  FastBitRead.labelP64 entry.bits (HotWord.childAddress entry.word a b c axis j)

def allNext (snapshot : @& Snapshot) (axis : Nat) (js : @& List Nat)
    (a b c : Nat) : Bool :=
  match js with
  | [] => true
  | j::rest =>
    let entry := template snapshot axis j
    (!entry.safe || !label entry a b c axis j) && allNext snapshot axis rest a b c

def anyNext (snapshot : @& Snapshot) (axis : Nat) (js : @& List Nat)
    (a b c : Nat) : Bool :=
  match js with
  | [] => false
  | j::rest =>
    let entry := template snapshot axis j
    (entry.safe && label entry a b c axis j) || anyNext snapshot axis rest a b c

def singleNext (snapshot : @& Snapshot) (axis : Nat) (js : @& List Nat)
    (a b c member : Nat) : Bool :=
  match js with
  | [] => false
  | j::rest =>
    (decide (j = member) &&
      let entry := template snapshot axis j
      entry.safe && label entry a b c axis j) ||
        singleNext snapshot axis rest a b c member

theorem getTable_build (localData : CachedPackedCheck.Local) (bank : Bank)
    (ctx : Context) (tables : GeneratedPlanCheck.Tables) (b : Nat) :
    getTable (build localData bank ctx tables) b = hotTable bank tables b := by
  by_cases hb : b < 4
  · simp [getTable,build,buildWithShared,hb]
  · simp [getTable,build,buildWithShared,hb]

theorem getD_map (entries : Array Edge) (bank : Bank) (i : Nat) (fallback : Edge) :
    (entries.map (HotBlockPlan.ofEdge bank)).getD i (HotBlockPlan.ofEdge bank fallback) =
      HotBlockPlan.ofEdge bank (entries.getD i fallback) := by
  simp only [Array.getD_eq_getD_getElem?,Array.getElem?_map]
  cases entries[i]? <;> rfl

theorem template_build (localData : CachedPackedCheck.Local) (bank : Bank)
    (ctx : Context) (tables : GeneratedPlanCheck.Tables) (b j : Nat) :
    template (build localData bank ctx tables) b j =
      HotBlockPlan.ofEdge bank
        (GeneratedPlanCheck.representative tables b (TemplatePlanCheck.key (groupData bank) b j)) := by
  unfold template
  rw [getTable_build]
  have keyEq : (build localData bank ctx tables).key b j =
      TemplatePlanCheck.key (groupData bank) b j := by
    simp [build,buildWithShared,buildShared,CachedPackedSnapshot.readMemo_build,TemplatePlanCheck.key]
  rw [keyEq]
  simp only [hotTable,Array.size_map]
  exact getD_map _ _ _ _

theorem label_ofEdge (bank : Bank) (p : Packed) (axis j : Nat) (e : Edge) :
    label (HotBlockPlan.ofEdge bank e) p.a p.b p.c axis j =
      BlockPlanCheck.label bank p axis {e with j := j} := by
  simp only [label,HotBlockPlan.ofEdge,FastBitRead.labelP64_eq,
    HotWord.childAddress_eq,BlockPlanCheck.label]

theorem allNext_build (localData : CachedPackedCheck.Local) (bank : Bank)
    (ctx : Context) (tables : GeneratedPlanCheck.Tables) (axis : Nat) (js : List Nat) (p : Packed) :
    allNext (build localData bank ctx tables) axis js p.a p.b p.c =
      (js.map (GeneratedPlanCheck.edge (groupData bank) tables axis)).all
        (fun e => !e.safe || !BlockPlanCheck.label bank p axis e) := by
  induction js with
  | nil => rfl
  | cons j js ih =>
    simp only [allNext,List.map_cons,List.all_cons,template_build,label_ofEdge,ih]
    rfl

theorem anyNext_build (localData : CachedPackedCheck.Local) (bank : Bank)
    (ctx : Context) (tables : GeneratedPlanCheck.Tables) (axis : Nat) (js : List Nat) (p : Packed) :
    anyNext (build localData bank ctx tables) axis js p.a p.b p.c =
      (js.map (GeneratedPlanCheck.edge (groupData bank) tables axis)).any
        (fun e => e.safe && BlockPlanCheck.label bank p axis e) := by
  induction js with
  | nil => rfl
  | cons j js ih =>
    simp only [anyNext,List.map_cons,List.any_cons,template_build,label_ofEdge,ih]
    rfl

theorem singleNext_build (localData : CachedPackedCheck.Local) (bank : Bank)
    (ctx : Context) (tables : GeneratedPlanCheck.Tables) (axis : Nat) (js : List Nat)
    (p : Packed) (member : Nat) :
    singleNext (build localData bank ctx tables) axis js p.a p.b p.c member =
      (js.map (GeneratedPlanCheck.edge (groupData bank) tables axis)).any
        (fun e => decide (e.j = member) && e.safe && BlockPlanCheck.label bank p axis e) := by
  induction js with
  | nil => rfl
  | cons j js ih =>
    simp only [singleNext,List.map_cons,List.any_cons,template_build,ih]
    rw [label_ofEdge]
    simp only [GeneratedPlanCheck.edge,HotBlockPlan.ofEdge,Bool.and_assoc]
    rfl

def row (snapshot : @& Snapshot) (sourceView : @& SourceBlockGuard.View)
    (_ctx : @& Context) (ids : @& Triple) (r : Nat) (sourceP : Bool) : Bool :=
  SourceBlockGuard.checkAddress sourceView ids r &&
    if sourceP then
      allNext snapshot 0 (snapshot.next 0 ids.1) ids.1 ids.2.1 ids.2.2 &&
      allNext snapshot 1 (snapshot.next 1 ids.2.1) ids.1 ids.2.1 ids.2.2 &&
      allNext snapshot 2 (snapshot.next 2 ids.2.2) ids.1 ids.2.1 ids.2.2 &&
      allNext snapshot 3 (snapshot.next 3 0) ids.1 ids.2.1 ids.2.2
    else
      anyNext snapshot 0 (snapshot.next 0 ids.1) ids.1 ids.2.1 ids.2.2 ||
      anyNext snapshot 1 (snapshot.next 1 ids.2.1) ids.1 ids.2.1 ids.2.2 ||
      anyNext snapshot 2 (snapshot.next 2 ids.2.2) ids.1 ids.2.1 ids.2.2 ||
      anyNext snapshot 3 (snapshot.next 3 0) ids.1 ids.2.1 ids.2.2

def single (snapshot : @& Snapshot) (sourceView : @& SourceBlockGuard.View)
    (_ctx : @& Context) (ids : @& Triple) (r axis member : Nat) : Bool :=
  SourceBlockGuard.checkAddress sourceView ids r && decide (axis < 4) &&
    singleNext snapshot axis (snapshot.next axis (if axis < 3 then
      if axis = 0 then ids.1 else if axis = 1 then ids.2.1 else ids.2.2 else 0))
      ids.1 ids.2.1 ids.2.2 member

theorem next_build (localData : CachedPackedCheck.Local) (bank : Bank)
    (ctx : Context) (tables : GeneratedPlanCheck.Tables) (b i : Nat) :
    (build localData bank ctx tables).next b i =
      (localData.edges b).next (if b < 3 then i else GeneratedPlanCheck.sourceKey localData ctx b) := by
  by_cases hb : b < 3
  · simp [build,buildWithShared,hb]
  · by_cases h3 : b = 3
    · subst b
      simp [build,buildWithShared,GeneratedPlanCheck.sourceKey]
    · simp [build,buildWithShared,hb,h3]

theorem row_build (localData : CachedPackedCheck.Local) (bank : Bank)
    (ctx : Context) (tables : GeneratedPlanCheck.Tables) (sourceView : SourceBlockGuard.View)
    (ids : Triple) (r : Nat) (sourceP : Bool) :
    row (build localData bank ctx tables) sourceView ctx ids r sourceP =
      BlockPlanFastSource.row bank sourceView ctx
        (GeneratedPlanCheck.generatedPlan localData bank ctx tables) ids r sourceP := by
  have ap (b : Nat) (js : List Nat) := allNext_build localData bank ctx tables b js (packIds ctx ids)
  have an (b : Nat) (js : List Nat) := anyNext_build localData bank ctx tables b js (packIds ctx ids)
  simp only [packIds] at ap an
  simp only [row,ap,an,next_build]
  simp [BlockPlanFastSource.row,GeneratedPlanCheck.generatedPlan,packIds,planIndex,Packed.get,
    List.range_succ,Bool.and_assoc,Bool.or_assoc]

theorem single_build (localData : CachedPackedCheck.Local) (bank : Bank)
    (ctx : Context) (tables : GeneratedPlanCheck.Tables) (sourceView : SourceBlockGuard.View)
    (ids : Triple) (r axis member : Nat) :
    single (build localData bank ctx tables) sourceView ctx ids r axis member =
      BlockPlanFastSource.single bank sourceView ctx
        (GeneratedPlanCheck.generatedPlan localData bank ctx tables) ids r axis member := by
  have eq (js : List Nat) := singleNext_build localData bank ctx tables axis js (packIds ctx ids) member
  simp only [packIds] at eq
  simp only [single,eq,next_build,BlockPlanFastSource.single,GeneratedPlanCheck.generatedPlan]
  by_cases h0 : axis = 0
  · subst axis
    rfl
  · by_cases h1 : axis = 1
    · subst axis
      rfl
    · by_cases h2 : axis = 2
      · subst axis
        rfl
      · have hb : ¬ axis < 3 := by omega
        simp [planIndex,hb,packIds]

end Mahjong.GeneratedHotPlan

#print axioms Mahjong.GeneratedHotPlan.template_build
#print axioms Mahjong.GeneratedHotPlan.allNext_build
#print axioms Mahjong.GeneratedHotPlan.anyNext_build
#print axioms Mahjong.GeneratedHotPlan.singleNext_build
#print axioms Mahjong.GeneratedHotPlan.row_build
#print axioms Mahjong.GeneratedHotPlan.single_build
