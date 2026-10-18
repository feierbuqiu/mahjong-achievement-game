import Mahjong.GeneratedHotPlan

set_option autoImplicit false

namespace Mahjong.BorrowedGeneratedHotPlan
open PackedRules GroupCandidates BlockPlanCheck

abbrev Table := GeneratedHotPlan.Table
abbrev Shared := GeneratedHotPlan.Shared
abbrev buildShared := GeneratedHotPlan.buildShared

/-- The key memo is a data field, so valid keys require no owned closure call.
All out-of-range cases retain the original total-function fallback. -/
structure Snapshot where
  tables : Array Table
  fallbackTable : Nat → Table
  fallback : HotBlockPlan.HotEdge
  groups : CachedPackedSnapshot.Memo Nat
  next : Nat → Nat → List Nat

@[noinline] def buildWithShared (localData : CachedPackedCheck.Local) (bank : Bank)
    (ctx : Context) (tables : GeneratedPlanCheck.Tables) (shared : Shared) : Snapshot :=
  let f := GeneratedHotPlan.hotTable bank tables
  let honorNext := (localData.edges 3).next (GeneratedPlanCheck.sourceKey localData ctx 3)
  ⟨Array.ofFn (fun b : Fin 4 => f b.val),f,
    HotBlockPlan.ofEdge bank GeneratedPlanCheck.fallback,shared.groups,
    fun b i => if b < 3 then (localData.edges b).next i else
      if b = 3 then honorNext else (localData.edges b).next (GeneratedPlanCheck.sourceKey localData ctx b)⟩

def build (localData : CachedPackedCheck.Local) (bank : Bank)
    (ctx : Context) (tables : GeneratedPlanCheck.Tables) : Snapshot :=
  buildWithShared localData bank ctx tables (buildShared (groupData bank))

theorem buildWithShared_buildShared (localData : CachedPackedCheck.Local) (bank : Bank)
    (ctx : Context) (tables : GeneratedPlanCheck.Tables) :
    buildWithShared localData bank ctx tables (buildShared (groupData bank)) =
      build localData bank ctx tables := rfl

@[inline] def readGroup (memo : @& CachedPackedSnapshot.Memo Nat) (j : Nat) : Nat :=
  if h : j < memo.values.size then memo.values[j] else memo.fallback j

theorem readGroup_eq (memo : CachedPackedSnapshot.Memo Nat) (j : Nat) :
    readGroup memo j = CachedPackedSnapshot.readMemo memo j := rfl

@[inline] def key (snapshot : @& Snapshot) (axis j : Nat) : Nat :=
  if axis < 3 then readGroup snapshot.groups j else j

/-- Specification bridge only. Executable point functions never construct this
owned snapshot or a function capturing it. -/
def toV10 (snapshot : Snapshot) : GeneratedHotPlan.Snapshot :=
  ⟨snapshot.tables,snapshot.fallbackTable,snapshot.fallback,key snapshot,snapshot.next⟩

theorem toV10_buildWithShared (localData : CachedPackedCheck.Local) (bank : Bank)
    (ctx : Context) (tables : GeneratedPlanCheck.Tables) (shared : Shared) :
    toV10 (buildWithShared localData bank ctx tables shared) =
      GeneratedHotPlan.buildWithShared localData bank ctx tables shared := rfl

theorem toV10_build (localData : CachedPackedCheck.Local) (bank : Bank)
    (ctx : Context) (tables : GeneratedPlanCheck.Tables) :
    toV10 (build localData bank ctx tables) = GeneratedHotPlan.build localData bank ctx tables := rfl

/-- Keep a Bool-returning borrowed call boundary: no owned edge, word or bits
has to escape before the result is computed. Inspect generated C before claiming
that a particular compiler actually eliminates the reference-count operations. -/
@[noinline] def entryP (entry : @& HotBlockPlan.HotEdge) (a b c axis j : Nat) : Bool :=
  !entry.safe || !FastBitRead.labelP64 entry.bits (HotWord.childAddress entry.word a b c axis j)

@[noinline] def entryN (entry : @& HotBlockPlan.HotEdge) (a b c axis j : Nat) : Bool :=
  entry.safe && FastBitRead.labelP64 entry.bits (HotWord.childAddress entry.word a b c axis j)

@[noinline] def tableP (table : @& Table) (fallback : @& HotBlockPlan.HotEdge)
    (k a b c axis j : Nat) : Bool :=
  if hk : k < table.slots.size then
    let slot := table.slots[k]
    if he : slot < table.entries.size then entryP table.entries[slot] a b c axis j
    else entryP fallback a b c axis j
  else entryP fallback a b c axis j

@[noinline] def tableN (table : @& Table) (fallback : @& HotBlockPlan.HotEdge)
    (k a b c axis j : Nat) : Bool :=
  if hk : k < table.slots.size then
    let slot := table.slots[k]
    if he : slot < table.entries.size then entryN table.entries[slot] a b c axis j
    else entryN fallback a b c axis j
  else entryN fallback a b c axis j

@[inline] def pointP (snapshot : @& Snapshot) (axis j a b c : Nat) : Bool :=
  let k := key snapshot axis j
  if ha : axis < snapshot.tables.size then
    tableP snapshot.tables[axis] snapshot.fallback k a b c axis j
  else tableP (snapshot.fallbackTable axis) snapshot.fallback k a b c axis j

@[inline] def pointN (snapshot : @& Snapshot) (axis j a b c : Nat) : Bool :=
  let k := key snapshot axis j
  if ha : axis < snapshot.tables.size then
    tableN snapshot.tables[axis] snapshot.fallback k a b c axis j
  else tableN (snapshot.fallbackTable axis) snapshot.fallback k a b c axis j

theorem tableP_eq (table : Table) (fallback : HotBlockPlan.HotEdge)
    (k a b c axis j : Nat) :
    tableP table fallback k a b c axis j =
      let entry := table.entries.getD (table.slots.getD k table.entries.size) fallback
      !entry.safe || !GeneratedHotPlan.label entry a b c axis j := by
  by_cases hk : k < table.slots.size
  · by_cases he : table.slots[k] < table.entries.size
    · simp [tableP,Array.getD,hk,he,entryP,GeneratedHotPlan.label]
    · simp [tableP,Array.getD,hk,he,entryP,GeneratedHotPlan.label]
  · simp [tableP,Array.getD,hk,entryP,GeneratedHotPlan.label]

theorem tableN_eq (table : Table) (fallback : HotBlockPlan.HotEdge)
    (k a b c axis j : Nat) :
    tableN table fallback k a b c axis j =
      let entry := table.entries.getD (table.slots.getD k table.entries.size) fallback
      entry.safe && GeneratedHotPlan.label entry a b c axis j := by
  by_cases hk : k < table.slots.size
  · by_cases he : table.slots[k] < table.entries.size
    · simp [tableN,Array.getD,hk,he,entryN,GeneratedHotPlan.label]
    · simp [tableN,Array.getD,hk,he,entryN,GeneratedHotPlan.label]
  · simp [tableN,Array.getD,hk,entryN,GeneratedHotPlan.label]

theorem pointP_eq (snapshot : Snapshot) (axis j a b c : Nat) :
    pointP snapshot axis j a b c =
      let entry := GeneratedHotPlan.template (toV10 snapshot) axis j
      !entry.safe || !GeneratedHotPlan.label entry a b c axis j := by
  by_cases ha : axis < snapshot.tables.size
  · simp only [pointP,ha,↓reduceDIte,tableP_eq,GeneratedHotPlan.template,
      GeneratedHotPlan.getTable,toV10]
  · simp only [pointP,ha,↓reduceDIte,tableP_eq,GeneratedHotPlan.template,
      GeneratedHotPlan.getTable,toV10]

theorem pointN_eq (snapshot : Snapshot) (axis j a b c : Nat) :
    pointN snapshot axis j a b c =
      let entry := GeneratedHotPlan.template (toV10 snapshot) axis j
      entry.safe && GeneratedHotPlan.label entry a b c axis j := by
  by_cases ha : axis < snapshot.tables.size
  · simp only [pointN,ha,↓reduceDIte,tableN_eq,GeneratedHotPlan.template,
      GeneratedHotPlan.getTable,toV10]
  · simp only [pointN,ha,↓reduceDIte,tableN_eq,GeneratedHotPlan.template,
      GeneratedHotPlan.getTable,toV10]

def allNext (snapshot : @& Snapshot) (axis : Nat) (js : @& List Nat)
    (a b c : Nat) : Bool :=
  match js with
  | [] => true
  | j::rest => pointP snapshot axis j a b c && allNext snapshot axis rest a b c

def anyNext (snapshot : @& Snapshot) (axis : Nat) (js : @& List Nat)
    (a b c : Nat) : Bool :=
  match js with
  | [] => false
  | j::rest => pointN snapshot axis j a b c || anyNext snapshot axis rest a b c

def singleNext (snapshot : @& Snapshot) (axis : Nat) (js : @& List Nat)
    (a b c member : Nat) : Bool :=
  match js with
  | [] => false
  | j::rest => (decide (j = member) && pointN snapshot axis j a b c) ||
      singleNext snapshot axis rest a b c member

theorem allNext_eq (snapshot : Snapshot) (axis : Nat) (js : List Nat) (a b c : Nat) :
    allNext snapshot axis js a b c = GeneratedHotPlan.allNext (toV10 snapshot) axis js a b c := by
  induction js with
  | nil => rfl
  | cons j js ih => simp only [allNext,GeneratedHotPlan.allNext,pointP_eq,ih]

theorem anyNext_eq (snapshot : Snapshot) (axis : Nat) (js : List Nat) (a b c : Nat) :
    anyNext snapshot axis js a b c = GeneratedHotPlan.anyNext (toV10 snapshot) axis js a b c := by
  induction js with
  | nil => rfl
  | cons j js ih => simp only [anyNext,GeneratedHotPlan.anyNext,pointN_eq,ih]

theorem singleNext_eq (snapshot : Snapshot) (axis : Nat) (js : List Nat) (a b c member : Nat) :
    singleNext snapshot axis js a b c member =
      GeneratedHotPlan.singleNext (toV10 snapshot) axis js a b c member := by
  induction js with
  | nil => rfl
  | cons j js ih => simp only [singleNext,GeneratedHotPlan.singleNext,pointN_eq,ih]

def row (snapshot : @& Snapshot) (view : @& SourceBlockGuard.View)
    (_ctx : @& Context) (ids : @& Triple) (r : Nat) (sourceP : Bool) : Bool :=
  SourceBlockGuard.checkAddress view ids r &&
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

def single (snapshot : @& Snapshot) (view : @& SourceBlockGuard.View)
    (_ctx : @& Context) (ids : @& Triple) (r axis member : Nat) : Bool :=
  SourceBlockGuard.checkAddress view ids r && decide (axis < 4) &&
    singleNext snapshot axis (snapshot.next axis (if axis < 3 then
      if axis = 0 then ids.1 else if axis = 1 then ids.2.1 else ids.2.2 else 0))
      ids.1 ids.2.1 ids.2.2 member

theorem row_eq (snapshot : Snapshot) (view : SourceBlockGuard.View) (ctx : Context)
    (ids : Triple) (r : Nat) (sourceP : Bool) :
    row snapshot view ctx ids r sourceP = GeneratedHotPlan.row (toV10 snapshot) view ctx ids r sourceP := by
  simp only [row,GeneratedHotPlan.row,allNext_eq,anyNext_eq,toV10]

theorem single_eq (snapshot : Snapshot) (view : SourceBlockGuard.View) (ctx : Context)
    (ids : Triple) (r axis member : Nat) :
    single snapshot view ctx ids r axis member =
      GeneratedHotPlan.single (toV10 snapshot) view ctx ids r axis member := by
  simp only [single,GeneratedHotPlan.single,singleNext_eq,toV10]

theorem row_build (localData : CachedPackedCheck.Local) (bank : Bank)
    (ctx : Context) (tables : GeneratedPlanCheck.Tables) (view : SourceBlockGuard.View)
    (ids : Triple) (r : Nat) (sourceP : Bool) :
    row (build localData bank ctx tables) view ctx ids r sourceP =
      BlockPlanFastSource.row bank view ctx
        (GeneratedPlanCheck.generatedPlan localData bank ctx tables) ids r sourceP := by
  rw [row_eq,toV10_build]
  exact GeneratedHotPlan.row_build localData bank ctx tables view ids r sourceP

theorem single_build (localData : CachedPackedCheck.Local) (bank : Bank)
    (ctx : Context) (tables : GeneratedPlanCheck.Tables) (view : SourceBlockGuard.View)
    (ids : Triple) (r axis member : Nat) :
    single (build localData bank ctx tables) view ctx ids r axis member =
      BlockPlanFastSource.single bank view ctx
        (GeneratedPlanCheck.generatedPlan localData bank ctx tables) ids r axis member := by
  rw [single_eq,toV10_build]
  exact GeneratedHotPlan.single_build localData bank ctx tables view ids r axis member

end Mahjong.BorrowedGeneratedHotPlan

#print axioms Mahjong.BorrowedGeneratedHotPlan.readGroup_eq
#print axioms Mahjong.BorrowedGeneratedHotPlan.toV10_build
#print axioms Mahjong.BorrowedGeneratedHotPlan.pointP_eq
#print axioms Mahjong.BorrowedGeneratedHotPlan.pointN_eq
#print axioms Mahjong.BorrowedGeneratedHotPlan.allNext_eq
#print axioms Mahjong.BorrowedGeneratedHotPlan.anyNext_eq
#print axioms Mahjong.BorrowedGeneratedHotPlan.singleNext_eq
#print axioms Mahjong.BorrowedGeneratedHotPlan.row_eq
#print axioms Mahjong.BorrowedGeneratedHotPlan.single_eq
#print axioms Mahjong.BorrowedGeneratedHotPlan.row_build
#print axioms Mahjong.BorrowedGeneratedHotPlan.single_build
