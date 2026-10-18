import Mahjong.GeneratedPlanCheck

set_option autoImplicit false

namespace Mahjong.CheckedPlanConstructor
open PackedRules BlockPlanCheck

/-!
This is a new candidate. The original checker and its proofs are unchanged.

The proposal supplies only an honor bucket and a directory block. SAFE, the
canonical child, and the word-address view are computed by this pure Lean
constructor. An accepted result carries an erased proof of the original
checkEdge condition, so the native caller must not run checkEdge a second time.
Every reachable key and the original shared slot map are still checked.
-/

abbrev Proposal := Packed → Nat × Nat

def zeroWord : BlockWordAddress.View := ⟨0,0,0,0,0,0,0,0,0⟩

abbrev CheckedEdge (localData : CachedPackedCheck.Local) (bank : Bank)
    (ctx : Context) (b : Nat) :=
  { e : Edge // checkEdge localData bank ctx b e = true }

/-- The original per-template target gate without the redundant comparison
of a view with a second reconstruction of the same view. -/
def targetGate (bank : @& Bank) (g : @& GroupInventory.Data)
    (q : @& Packed) (m : @& IndexOperations.Data) (h block : Nat) : Bool :=
  decide (0 < (bank.buckets h).size) &&
    decide ((bank.buckets h).honorCode = q.h) &&
    decide (block < m.directory.blocks) &&
    decide (m.key block = groupKey g q)

/-- The proposition in CheckedEdge is erased, not evaluated. This body
computes each SAFE/shadow/model/view once and retains every original gate. -/
def prepareEdgeUsing (localData : @& CachedPackedCheck.Local) (bank : @& Bank)
    (g : @& GroupInventory.Data) (gCorrect : g = groupData bank)
    (ctx : @& Context) (propose : @& Proposal) (b j : Nat) :
    Option (CheckedEdge localData bank ctx b) :=
  if bounded : j < (if b < 3 then g.count else (localData.inventories 3).count) then
    if safe : expectedSafe g localData ctx b j = true then
      let q := SuitSorting.sort id (shadowChild g localData ctx b j)
      let p := propose q
      let m := model bank p.1
      if target : targetGate bank g q m p.1 p.2 = true then
        some ⟨⟨j,true,p.1,p.2,BlockWordAddress.ofModel m p.2⟩,by
          dsimp only [q,m] at target ⊢
          rw [gCorrect] at bounded safe target
          simpa [checkEdge,targetGate,BlockWordAddress.check,bounded,safe] using target⟩
      else none
    else
      some ⟨⟨j,false,0,0,zeroWord⟩,by
        have notSafe : expectedSafe g localData ctx b j = false := by
          cases eq : expectedSafe g localData ctx b j <;> simp_all
        rw [gCorrect] at bounded notSafe
        simp [checkEdge,bounded,notSafe]⟩
  else none

def prepareEdge (localData : @& CachedPackedCheck.Local) (bank : @& Bank)
    (ctx : @& Context) (propose : @& Proposal) (b j : Nat) :
    Option (CheckedEdge localData bank ctx b) :=
  prepareEdgeUsing localData bank (groupData bank) rfl ctx propose b j

theorem prepareEdge_sound (localData : CachedPackedCheck.Local) (bank : Bank)
    (ctx : Context) (propose : Proposal) (b j : Nat)
    (e : CheckedEdge localData bank ctx b)
    (_returned : prepareEdge localData bank ctx propose b j = some e) :
    checkEdge localData bank ctx b e.val = true := e.property

abbrev CheckedEntries (localData : CachedPackedCheck.Local) (bank : Bank)
    (ctx : Context) (b : Nat) :=
  { es : Array Edge // es.all (checkEdge localData bank ctx b) = true }

def emptyEntries (localData : CachedPackedCheck.Local) (bank : Bank)
    (ctx : Context) (b : Nat) : CheckedEntries localData bank ctx b :=
  ⟨#[],by simp⟩

def pushEntry (localData : CachedPackedCheck.Local) (bank : Bank)
    (ctx : Context) (b : Nat) (es : CheckedEntries localData bank ctx b)
    (e : CheckedEdge localData bank ctx b) : CheckedEntries localData bank ctx b :=
  ⟨es.val.push e.val,by simp only [Array.all_push,es.property,e.property,Bool.and_self]⟩

/-- Tail-recursive unique-array producer. Actual successor lists are not
expanded here; keys are the already covered reachable-key list. -/
def prepareEntries (localData : @& CachedPackedCheck.Local) (bank : @& Bank)
    (g : @& GroupInventory.Data) (gCorrect : g = groupData bank)
    (ctx : @& Context) (propose : @& Proposal) (b : Nat) :
    List Nat → CheckedEntries localData bank ctx b →
      Option (CheckedEntries localData bank ctx b)
  | [],es => some es
  | k :: ks,es =>
    let j := if b < 3 then g.first k else k
    match prepareEdgeUsing localData bank g gCorrect ctx propose b j with
    | none => none
    | some e => prepareEntries localData bank g gCorrect ctx propose b ks
        (pushEntry localData bank ctx b es e)

/-- Cheap slot/key validation, retaining both bounds and the original key
equality. This deliberately performs no SAFE or target-model reconstruction. -/
def layoutKey (g : @& GroupInventory.Data) (table : @& SparseTemplatePlanCheck.Table)
    (b k : Nat) : Bool :=
  let slot := table.slots.getD k table.entries.size
  let e := table.entries.getD slot GeneratedPlanCheck.fallback
  decide (k < table.slots.size ∧ slot < table.entries.size) &&
    decide (k = TemplatePlanCheck.key g b e.j)

theorem layoutKey_sound (localData : CachedPackedCheck.Local) (bank : Bank)
    (ctx : Context) (b k : Nat) (table : SparseTemplatePlanCheck.Table)
    (entries : table.entries.all (checkEdge localData bank ctx b) = true)
    (accepted : layoutKey (groupData bank) table b k = true) :
    GeneratedPlanCheck.checkKey localData bank ctx ⟨fun _ => table⟩ b k = true := by
  have parts := accepted
  simp only [layoutKey,Bool.and_eq_true,decide_eq_true_eq] at parts
  have each := Array.all_eq_true.mp entries _ parts.1.2
  rw [Array.getElem_eq_getD GeneratedPlanCheck.fallback] at each
  simp only [GeneratedPlanCheck.checkKey,GeneratedPlanCheck.representative,Bool.and_eq_true]
  exact ⟨⟨decide_eq_true parts.1,decide_eq_true parts.2⟩,each⟩

abbrev CheckedTable (localData : CachedPackedCheck.Local) (bank : Bank)
    (ctx : Context) (b : Nat) (keys : List Nat) :=
  { table : SparseTemplatePlanCheck.Table //
    keys.all (GeneratedPlanCheck.checkKey localData bank ctx ⟨fun _ => table⟩ b) = true }

def prepareTable (localData : @& CachedPackedCheck.Local) (bank : @& Bank)
    (ctx : @& Context) (propose : @& Proposal) (b : Nat)
    (keys : List Nat) (slots : Array Nat) :
    Option (CheckedTable localData bank ctx b keys) :=
  let g := groupData bank
  match prepareEntries localData bank g rfl ctx propose b keys (emptyEntries localData bank ctx b) with
  | none => none
  | some entries =>
    let table : SparseTemplatePlanCheck.Table := ⟨slots,entries.val⟩
    if accepted : keys.all (layoutKey g table b) = true then
      some ⟨table,by
        apply List.all_eq_true.mpr
        intro k member
        exact layoutKey_sound localData bank ctx b k table entries.property
          (List.all_eq_true.mp accepted k member)⟩
    else none

abbrev CheckedAxis (localData : CachedPackedCheck.Local) (bank : Bank)
    (ctx : Context) (coverage : GroupNextCoverage.Data) (b : Nat) :=
  { table : SparseTemplatePlanCheck.Table //
    GeneratedPlanCheck.checkAxis localData bank ctx coverage ⟨fun _ => table⟩ b = true }

def prepareAxis (localData : @& CachedPackedCheck.Local) (bank : @& Bank)
    (ctx : @& Context) (coverage : @& GroupNextCoverage.Data)
    (propose : @& Proposal) (slots : Nat → Nat → Array Nat) (b : Nat) :
    Option (CheckedAxis localData bank ctx coverage b) :=
  let k := GeneratedPlanCheck.sourceKey localData ctx b
  if bounded : k < GroupNextCoverage.domainCount (groupData bank) localData b then
    match prepareTable localData bank ctx propose b (coverage.keys b k) (slots b k) with
    | none => none
    | some table => some ⟨table.val,by
      simp only [GeneratedPlanCheck.checkAxis,Bool.and_eq_true]
      exact ⟨decide_eq_true bounded,table.property⟩⟩
  else none

def install (a b c h : SparseTemplatePlanCheck.Table) : GeneratedPlanCheck.Tables :=
  ⟨fun i => if i = 0 then a else if i = 1 then b else if i = 2 then c else h⟩

abbrev CheckedPlan (localData : CachedPackedCheck.Local) (bank : Bank)
    (source : IndexOperations.Data) (ctx : Context) (coverage : GroupNextCoverage.Data) :=
  { tables : GeneratedPlanCheck.Tables //
    GeneratedPlanCheck.checkPlan localData bank source ctx coverage tables = true }

/-- A checked constructor of the same tables consumed by the unchanged hot
snapshot/row code. All four actual reachable-key sets are consumed. -/
def preparePlan (localData : @& CachedPackedCheck.Local) (bank : @& Bank)
    (source : @& IndexOperations.Data) (ctx : @& Context)
    (coverage : @& GroupNextCoverage.Data) (propose : @& Proposal)
    (slots : Nat → Nat → Array Nat) :
    Option (CheckedPlan localData bank source ctx coverage) :=
  if context : checkContext localData bank source ctx = true then
    match prepareAxis localData bank ctx coverage propose slots 0,
        prepareAxis localData bank ctx coverage propose slots 1,
        prepareAxis localData bank ctx coverage propose slots 2,
        prepareAxis localData bank ctx coverage propose slots 3 with
    | some a,some b,some c,some h =>
      some ⟨install a.val b.val c.val h.val,by
        simp only [GeneratedPlanCheck.checkPlan,context,Bool.true_and]
        apply List.all_eq_true.mpr
        intro i member
        have bound := List.mem_range.mp member
        have cases : i = 0 ∨ i = 1 ∨ i = 2 ∨ i = 3 := by omega
        rcases cases with rfl | rfl | rfl | rfl
        · simpa [GeneratedPlanCheck.checkAxis,GeneratedPlanCheck.checkKey,
            GeneratedPlanCheck.representative,install] using a.property
        · simpa [GeneratedPlanCheck.checkAxis,GeneratedPlanCheck.checkKey,
            GeneratedPlanCheck.representative,install] using b.property
        · simpa [GeneratedPlanCheck.checkAxis,GeneratedPlanCheck.checkKey,
            GeneratedPlanCheck.representative,install] using c.property
        · simpa [GeneratedPlanCheck.checkAxis,GeneratedPlanCheck.checkKey,
            GeneratedPlanCheck.representative,install] using h.property⟩
    | _,_,_,_ => none
  else none

theorem preparePlan_sound (localData : CachedPackedCheck.Local) (bank : Bank)
    (source : IndexOperations.Data) (ctx : Context) (coverage : GroupNextCoverage.Data)
    (propose : Proposal) (slots : Nat → Nat → Array Nat)
    (p : CheckedPlan localData bank source ctx coverage)
    (_returned : preparePlan localData bank source ctx coverage propose slots = some p) :
    GeneratedPlanCheck.checkPlan localData bank source ctx coverage p.val = true := p.property

theorem preparePlan_refines (localData : CachedPackedCheck.Local) (bank : Bank)
    (source : IndexOperations.Data) (ctx : Context) (coverage : GroupNextCoverage.Data)
    (p : CheckedPlan localData bank source ctx coverage)
    (globalChecked : GroupNextCoverage.check (groupData bank) localData coverage = true) :
    BlockPlanCheck.checkPlan localData bank source ctx
      (GeneratedPlanCheck.generatedPlan localData bank ctx p.val) = true := by
  exact GeneratedPlanCheck.checkPlan_refines localData bank source ctx coverage p.val
    globalChecked p.property

end Mahjong.CheckedPlanConstructor

#print axioms Mahjong.CheckedPlanConstructor.prepareEdge_sound
#print axioms Mahjong.CheckedPlanConstructor.layoutKey_sound
#print axioms Mahjong.CheckedPlanConstructor.preparePlan_sound
#print axioms Mahjong.CheckedPlanConstructor.preparePlan_refines
