import Mahjong.TemplatePlanCheck

set_option autoImplicit false

namespace Mahjong.SparseTemplatePlanCheck
open PackedRules GroupCandidates CanonicalInventory BlockPlanCheck

/-- Untrusted key-to-entry proposals. Every use checks both bounds and the key. -/
structure Table where
  slots : Array Nat
  entries : Array Edge

structure Tables where
  get : Nat → Table

abbrev key := TemplatePlanCheck.key
abbrev sameTemplate := TemplatePlanCheck.sameTemplate

def checkEntry (localData : @& CachedPackedCheck.Local) (bank : @& Bank) (ctx : @& Context)
    (b : Nat) (table : @& Table) (i : Nat) : Bool :=
  if h : i < table.entries.size then checkEdge localData bank ctx b table.entries[i]
  else false

/-- Only populated representatives are checked; unused slots carry no premise. -/
def checkTable (localData : @& CachedPackedCheck.Local) (bank : @& Bank) (ctx : @& Context)
    (b : Nat) (table : @& Table) : Bool :=
  checkSpan (checkEntry localData bank ctx b table) 0 table.entries.size

theorem checked_entry (localData : CachedPackedCheck.Local) (bank : Bank) (ctx : Context)
    (b : Nat) (table : Table) (i : Nat)
    (templates : checkTable localData bank ctx b table = true) (bound : i < table.entries.size) :
    checkEdge localData bank ctx b table.entries[i] = true := by
  have accepted := checkSpan_each (checkEntry localData bank ctx b table) table.entries.size 0 templates i bound
  simpa only [Nat.zero_add,checkEntry,bound,↓reduceDIte] using accepted

def checkCachedEdge (g : @& GroupInventory.Data) (localData : @& CachedPackedCheck.Local)
    (b : Nat) (table : @& Table) (e : @& Edge) : Bool :=
  decide (e.j < if b < 3 then g.count else (localData.inventories 3).count) &&
    let i := key g b e.j
    if h : i < table.slots.size then
      let slot := table.slots[i]
      if h' : slot < table.entries.size then
        let representative := table.entries[slot]
        decide (key g b e.j = key g b representative.j) && sameTemplate e representative
      else false
    else false

theorem cached_edge_sound (localData : CachedPackedCheck.Local) (bank : Bank)
    (ctx : Context) (b : Nat) (table : Table) (e : Edge)
    (templates : checkTable localData bank ctx b table = true)
    (accepted : checkCachedEdge (groupData bank) localData b table e = true) :
    checkEdge localData bank ctx b e = true := by
  let i := key (groupData bank) b e.j
  by_cases keyBound : i < table.slots.size
  · let slot := table.slots[i]
    by_cases entryBound : slot < table.entries.size
    · have parts := accepted
      simp only [checkCachedEdge,show key (groupData bank) b e.j = i from rfl,
        keyBound,↓reduceDIte,show table.slots[i] = slot from rfl,
        entryBound,Bool.and_eq_true,decide_eq_true_eq] at parts
      exact TemplatePlanCheck.edge_from_template localData bank ctx b e table.entries[slot]
        parts.1 parts.2.1 parts.2.2 (checked_entry localData bank ctx b table slot templates entryBound)
    · simp only [checkCachedEdge,show key (groupData bank) b e.j = i from rfl,
        keyBound,↓reduceDIte,show table.slots[i] = slot from rfl,
        entryBound,Bool.and_false] at accepted
      simp at accepted
  · simp only [checkCachedEdge,show key (groupData bank) b e.j = i from rfl,
      keyBound,↓reduceDIte,Bool.and_false] at accepted
    simp at accepted

def checkRow (g : @& GroupInventory.Data) (localData : @& CachedPackedCheck.Local)
    (plan : @& Plan) (b : Nat) (table : @& Table) (i : Nat) : Bool :=
  let es := plan.rows b (if b < 3 then i else 0)
  decide (es.map Edge.j = (localData.edges b).next i) &&
    es.all (checkCachedEdge g localData b table)

theorem row_refines (localData : CachedPackedCheck.Local) (bank : Bank) (ctx : Context)
    (plan : Plan) (b : Nat) (table : Table) (i : Nat)
    (templates : checkTable localData bank ctx b table = true)
    (accepted : checkRow (groupData bank) localData plan b table i = true) :
    BlockPlanCheck.checkRow localData bank ctx plan b i = true := by
  simp only [checkRow,BlockPlanCheck.checkRow,Bool.and_eq_true] at accepted ⊢
  refine ⟨accepted.1,List.all_eq_true.mpr ?_⟩
  intro e member
  exact cached_edge_sound localData bank ctx b table e templates (List.all_eq_true.mp accepted.2 e member)

def checkPlan (localData : @& CachedPackedCheck.Local) (bank : @& Bank) (source : @& IndexOperations.Data)
    (ctx : @& Context) (plan : @& Plan) (tables : @& Tables) : Bool :=
  let g := groupData bank
  BlockPlanCheck.checkContext localData bank source ctx &&
    (List.range 4).all (fun b => checkTable localData bank ctx b (tables.get b)) &&
    (List.range 3).all (fun b => checkSpan (checkRow g localData plan b (tables.get b))
      (g.first (keyGet ctx.key b)) (g.size (keyGet ctx.key b))) &&
    checkRow g localData plan 3 (tables.get 3) ((localData.inventories 3).id ctx.honorCode)

theorem checkPlan_refines (localData : CachedPackedCheck.Local) (bank : Bank) (source : IndexOperations.Data)
    (ctx : Context) (plan : Plan) (tables : Tables)
    (accepted : checkPlan localData bank source ctx plan tables = true) :
    BlockPlanCheck.checkPlan localData bank source ctx plan = true := by
  simp only [checkPlan,BlockPlanCheck.checkPlan,Bool.and_eq_true] at accepted ⊢
  have table (b : Nat) (bound : b < 4) : checkTable localData bank ctx b (tables.get b) = true :=
    List.all_eq_true.mp accepted.1.1.2 b (List.mem_range.mpr bound)
  refine ⟨⟨accepted.1.1.1,List.all_eq_true.mpr ?_⟩,?_⟩
  · intro b member
    have hb : b < 3 := List.mem_range.mp member
    have rows := List.all_eq_true.mp accepted.1.2 b member
    exact TemplatePlanCheck.span_refines _ _ _ _ (fun i ok => row_refines localData bank ctx plan b (tables.get b) i
      (table b (by omega)) ok) rows
  · exact row_refines localData bank ctx plan 3 (tables.get 3) _ (table 3 (by decide)) accepted.2

end Mahjong.SparseTemplatePlanCheck

#print axioms Mahjong.SparseTemplatePlanCheck.checked_entry
#print axioms Mahjong.SparseTemplatePlanCheck.cached_edge_sound
#print axioms Mahjong.SparseTemplatePlanCheck.row_refines
#print axioms Mahjong.SparseTemplatePlanCheck.checkPlan_refines
