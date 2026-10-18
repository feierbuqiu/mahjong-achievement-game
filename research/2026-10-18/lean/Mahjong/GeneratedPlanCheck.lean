import Mahjong.GroupNextCoverage

set_option autoImplicit false

namespace Mahjong.GeneratedPlanCheck
open PackedRules GroupCandidates CanonicalInventory BlockPlanCheck

abbrev Tables := SparseTemplatePlanCheck.Tables

def fallback : Edge := ⟨0,false,0,0,⟨0,0,0,0,0,0,0,0,0⟩⟩

def representative (tables : @& Tables) (b k : Nat) : Edge :=
  let table := tables.get b
  table.entries.getD (table.slots.getD k table.entries.size) fallback

def edge (g : @& GroupInventory.Data) (tables : @& Tables) (b j : Nat) : Edge :=
  { representative tables b (TemplatePlanCheck.key g b j) with j := j }

def sourceKey (localData : @& CachedPackedCheck.Local) (ctx : @& Context) (b : Nat) : Nat :=
  if b < 3 then keyGet ctx.key b else (localData.inventories 3).id ctx.honorCode

/-- Specification only: the hot implementation must not materialize this map.
The complete actual next list is preserved by construction, even for unsafe edges. -/
def generatedPlan (localData : @& CachedPackedCheck.Local) (bank : @& Bank)
    (ctx : @& Context) (tables : @& Tables) : Plan :=
  ⟨fun b i => ((localData.edges b).next (if b < 3 then i else sourceKey localData ctx b)).map
    (edge (groupData bank) tables b)⟩

def checkKey (localData : @& CachedPackedCheck.Local) (bank : @& Bank)
    (ctx : @& Context) (tables : @& Tables) (b k : Nat) : Bool :=
  let table := tables.get b
  let slot := table.slots.getD k table.entries.size
  let template := representative tables b k
  decide (k < table.slots.size ∧ slot < table.entries.size) &&
    decide (k = TemplatePlanCheck.key (groupData bank) b template.j) &&
    BlockPlanCheck.checkEdge localData bank ctx b template

def checkAxis (localData : @& CachedPackedCheck.Local) (bank : @& Bank)
    (ctx : @& Context) (coverage : @& GroupNextCoverage.Data)
    (tables : @& Tables) (b : Nat) : Bool :=
  let k := sourceKey localData ctx b
  decide (k < GroupNextCoverage.domainCount (groupData bank) localData b) &&
    (coverage.keys b k).all (checkKey localData bank ctx tables b)

/-- Only context and the reachable shared keys are checked for each block.
GroupNextCoverage.check is a separate once-per-local-cache precondition. -/
def checkPlan (localData : @& CachedPackedCheck.Local) (bank : @& Bank)
    (source : @& IndexOperations.Data) (ctx : @& Context)
    (coverage : @& GroupNextCoverage.Data) (tables : @& Tables) : Bool :=
  BlockPlanCheck.checkContext localData bank source ctx &&
    (List.range 4).all (checkAxis localData bank ctx coverage tables)

theorem edge_template (g : GroupInventory.Data) (tables : Tables) (b j : Nat) :
    TemplatePlanCheck.sameTemplate (edge g tables b j)
      (representative tables b (TemplatePlanCheck.key g b j)) = true := by
  simp only [edge,TemplatePlanCheck.sameTemplate]
  simp

theorem key_sound (localData : CachedPackedCheck.Local) (bank : Bank)
    (ctx : Context) (tables : Tables) (b k : Nat)
    (accepted : checkKey localData bank ctx tables b k = true) :
    k = TemplatePlanCheck.key (groupData bank) b (representative tables b k).j ∧
      BlockPlanCheck.checkEdge localData bank ctx b (representative tables b k) = true := by
  simp only [checkKey,Bool.and_eq_true,decide_eq_true_eq] at accepted
  exact ⟨accepted.1.2,accepted.2⟩

theorem edge_sound (localData : CachedPackedCheck.Local) (bank : Bank)
    (ctx : Context) (tables : Tables) (b j : Nat)
    (bounded : j < if b < 3 then (groupData bank).count else (localData.inventories 3).count)
    (accepted : checkKey localData bank ctx tables b (TemplatePlanCheck.key (groupData bank) b j) = true) :
    BlockPlanCheck.checkEdge localData bank ctx b (edge (groupData bank) tables b j) = true := by
  have fields := key_sound localData bank ctx tables b _ accepted
  apply TemplatePlanCheck.edge_from_template localData bank ctx b
    (edge (groupData bank) tables b j)
    (representative tables b (TemplatePlanCheck.key (groupData bank) b j))
  · exact bounded
  · exact fields.1
  · exact edge_template (groupData bank) tables b j
  · exact fields.2

theorem row_refines (localData : CachedPackedCheck.Local) (bank : Bank)
    (ctx : Context) (coverage : GroupNextCoverage.Data) (tables : Tables) (b i : Nat)
    (globalChecked : GroupNextCoverage.check (groupData bank) localData coverage = true)
    (blockBound : b < 4) (accepted : checkAxis localData bank ctx coverage tables b = true)
    (lower : GroupNextCoverage.rowFirst (groupData bank) b (sourceKey localData ctx b) ≤ i)
    (upper : i-GroupNextCoverage.rowFirst (groupData bank) b (sourceKey localData ctx b) <
      GroupNextCoverage.rowCount (groupData bank) b (sourceKey localData ctx b)) :
    BlockPlanCheck.checkRow localData bank ctx (generatedPlan localData bank ctx tables) b i = true := by
  have parts := accepted
  simp only [checkAxis,Bool.and_eq_true,decide_eq_true_eq] at parts
  have nextIndex : (if b < 3 then (if b < 3 then i else 0) else sourceKey localData ctx b) = i := by
    by_cases numeric : b < 3
    · simp [numeric]
    · simp only [GroupNextCoverage.rowFirst,GroupNextCoverage.rowCount,numeric,↓reduceIte] at lower upper
      simp only [numeric,↓reduceIte]
      omega
  have rows : (generatedPlan localData bank ctx tables).rows b (if b < 3 then i else 0) =
      ((localData.edges b).next i).map (edge (groupData bank) tables b) := by
    simp only [generatedPlan,nextIndex]
  simp only [BlockPlanCheck.checkRow,rows,Bool.and_eq_true]
  constructor
  · simp [List.map_map,Function.comp_def,edge]
  · apply List.all_eq_true.mpr
    intro e inMap
    rcases List.mem_map.mp inMap with ⟨j,inNext,rfl⟩
    have covered := GroupNextCoverage.covered (groupData bank) localData coverage b
      (sourceKey localData ctx b) i j globalChecked blockBound parts.1 lower upper inNext
    exact edge_sound localData bank ctx tables b j covered.1
      (List.all_eq_true.mp parts.2 _ covered.2)

theorem span_of_each (f : Nat → Bool) (start count : Nat)
    (each : ∀ offset, offset < count → f (start+offset) = true) :
    checkSpan f start count = true := by
  induction count generalizing start with
  | zero => rfl
  | succ count ih =>
    simp only [checkSpan,Bool.and_eq_true]
    constructor
    · simpa only [Nat.add_zero] using each 0 (by omega)
    · apply ih
      intro offset bound
      have next := each (offset+1) (by omega)
      simpa only [Nat.add_assoc,Nat.add_left_comm,Nat.add_comm] using next

theorem checkPlan_refines (localData : CachedPackedCheck.Local) (bank : Bank)
    (source : IndexOperations.Data) (ctx : Context)
    (coverage : GroupNextCoverage.Data) (tables : Tables)
    (globalChecked : GroupNextCoverage.check (groupData bank) localData coverage = true)
    (accepted : checkPlan localData bank source ctx coverage tables = true) :
    BlockPlanCheck.checkPlan localData bank source ctx (generatedPlan localData bank ctx tables) = true := by
  have parts := accepted
  simp only [checkPlan,Bool.and_eq_true] at parts
  have axis (b : Nat) (bound : b < 4) : checkAxis localData bank ctx coverage tables b = true :=
    List.all_eq_true.mp parts.2 b (List.mem_range.mpr bound)
  simp only [BlockPlanCheck.checkPlan,Bool.and_eq_true]
  refine ⟨⟨parts.1,List.all_eq_true.mpr ?_⟩,?_⟩
  · intro b member
    have numeric : b < 3 := List.mem_range.mp member
    apply span_of_each
    intro offset bound
    apply row_refines localData bank ctx coverage tables b _ globalChecked (by omega) (axis b (by omega))
    · simp only [GroupNextCoverage.rowFirst,sourceKey,numeric,↓reduceIte]
      omega
    · simp only [GroupNextCoverage.rowFirst,GroupNextCoverage.rowCount,sourceKey,numeric,↓reduceIte]
      omega
  · apply row_refines localData bank ctx coverage tables 3 _ globalChecked (by decide) (axis 3 (by decide))
    · simp [GroupNextCoverage.rowFirst,sourceKey]
    · simp [GroupNextCoverage.rowFirst,GroupNextCoverage.rowCount,sourceKey]

end Mahjong.GeneratedPlanCheck

#print axioms Mahjong.GeneratedPlanCheck.edge_template
#print axioms Mahjong.GeneratedPlanCheck.key_sound
#print axioms Mahjong.GeneratedPlanCheck.edge_sound
#print axioms Mahjong.GeneratedPlanCheck.row_refines
#print axioms Mahjong.GeneratedPlanCheck.span_of_each
#print axioms Mahjong.GeneratedPlanCheck.checkPlan_refines
