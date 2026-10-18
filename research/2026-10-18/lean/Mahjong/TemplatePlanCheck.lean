import Mahjong.BlockPlanCheck

set_option autoImplicit false

namespace Mahjong.TemplatePlanCheck
open PackedRules GroupCandidates CanonicalInventory BlockPlanCheck

abbrev Table := Array (Option Edge)

structure Tables where
  get : Nat → Table

@[inline] def key (g : @& GroupInventory.Data) (b j : Nat) : Nat :=
  if b < 3 then g.group j else j

theorem expectedSafe_key (g : GroupInventory.Data) (localData : CachedPackedCheck.Local)
    (ctx : Context) (b j k : Nat) (same : key g b j = key g b k) :
    expectedSafe g localData ctx b j = expectedSafe g localData ctx b k := by
  by_cases numeric : b < 3
  · have eq : g.group j = g.group k := by simpa [key,numeric] using same
    have choices : b = 0 ∨ b = 1 ∨ b = 2 := by omega
    rcases choices with rfl | rfl | rfl <;> simp [expectedSafe,labels,eq]
  · have eq : j = k := by simpa [key,numeric] using same
    rw [eq]

theorem shadowChild_key (g : GroupInventory.Data) (localData : CachedPackedCheck.Local)
    (ctx : Context) (b j k : Nat) (same : key g b j = key g b k) :
    shadowChild g localData ctx b j = shadowChild g localData ctx b k := by
  by_cases numeric : b < 3
  · have eq : g.group j = g.group k := by simpa [key,numeric] using same
    simp [shadowChild,numeric,eq]
  · have eq : j = k := by simpa [key,numeric] using same
    rw [eq]

/-- The actual successor ID is excluded here, and is checked separately. -/
@[inline] def sameTemplate (e t : @& Edge) : Bool :=
  decide (e.safe = t.safe ∧ e.targetHonor = t.targetHonor ∧
    e.targetBlock = t.targetBlock ∧ e.word = t.word)

theorem edge_from_template (localData : CachedPackedCheck.Local) (bank : Bank)
    (ctx : Context) (b : Nat) (e t : Edge)
    (bounded : e.j < if b < 3 then (groupData bank).count else (localData.inventories 3).count)
    (sameKey : key (groupData bank) b e.j = key (groupData bank) b t.j)
    (same : sameTemplate e t = true) (checked : checkEdge localData bank ctx b t = true) :
    checkEdge localData bank ctx b e = true := by
  cases e with | mk ej es eh eb ew =>
    cases t with | mk tj ts th tb tw =>
      have fields := of_decide_eq_true same
      simp only [sameTemplate] at same
      have eq : es = ts ∧ eh = th ∧ eb = tb ∧ ew = tw := fields
      rcases eq with ⟨rfl,rfl,rfl,rfl⟩
      have safeEq := expectedSafe_key (groupData bank) localData ctx b ej tj sameKey
      have shadowEq := shadowChild_key (groupData bank) localData ctx b ej tj sameKey
      simp only [checkEdge,Bool.and_eq_true] at checked ⊢
      refine ⟨⟨by simpa only [decide_eq_true_eq] using bounded,?_⟩,?_⟩
      · simpa only [safeEq] using checked.1.2
      · simpa only [shadowEq] using checked.2

def checkEntry (localData : @& CachedPackedCheck.Local) (bank : @& Bank) (ctx : @& Context)
    (b : Nat) (table : @& Table) (i : Nat) : Bool :=
  if h : i < table.size then
    match table[i] with
    | none => true
    | some e => decide (i = key (groupData bank) b e.j) && checkEdge localData bank ctx b e
  else false

def checkTable (localData : @& CachedPackedCheck.Local) (bank : @& Bank) (ctx : @& Context)
    (b : Nat) (table : @& Table) : Bool :=
  checkSpan (checkEntry localData bank ctx b table) 0 table.size

def checkCachedEdge (g : @& GroupInventory.Data) (localData : @& CachedPackedCheck.Local)
    (b : Nat) (table : @& Table) (e : @& Edge) : Bool :=
  decide (e.j < if b < 3 then g.count else (localData.inventories 3).count) &&
    let i := key g b e.j
    if h : i < table.size then
      match table[i] with
      | none => false
      | some representative => sameTemplate e representative
    else false

theorem cached_edge_sound (localData : CachedPackedCheck.Local) (bank : Bank)
    (ctx : Context) (b : Nat) (table : Table) (e : Edge)
    (templates : checkTable localData bank ctx b table = true)
    (accepted : checkCachedEdge (groupData bank) localData b table e = true) :
    checkEdge localData bank ctx b e = true := by
  let i := key (groupData bank) b e.j
  by_cases bound : i < table.size
  · have parts := accepted
    simp only [checkCachedEdge,show key (groupData bank) b e.j = i from rfl,
      bound,↓reduceDIte,Bool.and_eq_true,decide_eq_true_eq] at parts
    have atEntry := checkSpan_each (checkEntry localData bank ctx b table) table.size 0 templates i bound
    simp only [Nat.zero_add,checkEntry,bound,↓reduceDIte] at atEntry
    cases h : table[i] with
    | none => simp [h] at parts
    | some representative =>
      simp only [h,Bool.and_eq_true,decide_eq_true_eq] at atEntry
      simp only [h] at parts
      exact edge_from_template localData bank ctx b e representative parts.1 atEntry.1 parts.2 atEntry.2
  · simp only [checkCachedEdge,show key (groupData bank) b e.j = i from rfl,
      bound,↓reduceDIte,Bool.and_false] at accepted
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

theorem span_refines (f g : Nat → Bool) (start count : Nat)
    (each : ∀ i, f i = true → g i = true) (accepted : checkSpan f start count = true) :
    checkSpan g start count = true := by
  induction count generalizing start with
  | zero => rfl
  | succ count ih =>
    simp only [checkSpan,Bool.and_eq_true] at accepted ⊢
    exact ⟨each start accepted.1,ih (start+1) accepted.2⟩

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
    exact span_refines _ _ _ _ (fun i ok => row_refines localData bank ctx plan b (tables.get b) i
      (table b (by omega)) ok) rows
  · exact row_refines localData bank ctx plan 3 (tables.get 3) _ (table 3 (by decide)) accepted.2

end Mahjong.TemplatePlanCheck

#print axioms Mahjong.TemplatePlanCheck.expectedSafe_key
#print axioms Mahjong.TemplatePlanCheck.shadowChild_key
#print axioms Mahjong.TemplatePlanCheck.edge_from_template
#print axioms Mahjong.TemplatePlanCheck.cached_edge_sound
#print axioms Mahjong.TemplatePlanCheck.row_refines
#print axioms Mahjong.TemplatePlanCheck.span_refines
#print axioms Mahjong.TemplatePlanCheck.checkPlan_refines
