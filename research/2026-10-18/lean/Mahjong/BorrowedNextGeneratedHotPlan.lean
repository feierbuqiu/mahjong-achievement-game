import Mahjong.BorrowedGeneratedHotPlan
import Mahjong.GeneratedLocalCache

set_option autoImplicit false

namespace Mahjong.BorrowedNextGeneratedHotPlan
open PackedRules GroupCandidates BlockPlanCheck

abbrev Table := BorrowedGeneratedHotPlan.Table
abbrev MemoNext := CachedPackedSnapshot.Memo (List Nat)

/-- These two finite caches are built once and shared by source blocks. -/
structure Shared where
  groups : CachedPackedSnapshot.Memo Nat
  next : GeneratedLocalCache.Snapshot

@[noinline] def buildShared (g : GroupInventory.Data) (localData : CachedPackedCheck.Local) : Shared :=
  ⟨(BorrowedGeneratedHotPlan.buildShared g).groups,GeneratedLocalCache.build localData⟩

structure Snapshot where
  hot : BorrowedGeneratedHotPlan.Snapshot
  next : GeneratedLocalCache.Snapshot
  honor : List Nat

@[noinline] def buildWithShared (localData : CachedPackedCheck.Local) (bank : Bank)
    (ctx : Context) (tables : GeneratedPlanCheck.Tables) (shared : Shared) : Snapshot :=
  ⟨BorrowedGeneratedHotPlan.buildWithShared localData bank ctx tables ⟨shared.groups⟩,
    shared.next,(localData.edges 3).next (GeneratedPlanCheck.sourceKey localData ctx 3)⟩

def build (localData : CachedPackedCheck.Local) (bank : Bank)
    (ctx : Context) (tables : GeneratedPlanCheck.Tables) : Snapshot :=
  buildWithShared localData bank ctx tables (buildShared (groupData bank) localData)

theorem buildWithShared_buildShared (localData : CachedPackedCheck.Local) (bank : Bank)
    (ctx : Context) (tables : GeneratedPlanCheck.Tables) :
    buildWithShared localData bank ctx tables (buildShared (groupData bank) localData) =
      build localData bank ctx tables := rfl

/-- Specification only. Runtime row helpers compute Bool directly from borrowed
cache entries, without returning an owned List or invoking this reader. -/
def next (snapshot : Snapshot) (axis i : Nat) : List Nat :=
  if axis < 3 then
    if ha : axis < snapshot.next.next.size then
      CachedPackedSnapshot.readMemo snapshot.next.next[axis] i
    else snapshot.hot.next axis i
  else if axis = 3 then snapshot.honor else snapshot.hot.next axis i

def toV11 (snapshot : Snapshot) : BorrowedGeneratedHotPlan.Snapshot :=
  { snapshot.hot with next := next snapshot }

@[noinline] def numericAll (memo : @& MemoNext) (hot : @& BorrowedGeneratedHotPlan.Snapshot)
    (axis i a b c : Nat) : Bool :=
  if hi : i < memo.values.size then BorrowedGeneratedHotPlan.allNext hot axis memo.values[i] a b c
  else BorrowedGeneratedHotPlan.allNext hot axis (memo.fallback i) a b c

@[noinline] def numericAny (memo : @& MemoNext) (hot : @& BorrowedGeneratedHotPlan.Snapshot)
    (axis i a b c : Nat) : Bool :=
  if hi : i < memo.values.size then BorrowedGeneratedHotPlan.anyNext hot axis memo.values[i] a b c
  else BorrowedGeneratedHotPlan.anyNext hot axis (memo.fallback i) a b c

@[noinline] def numericSingle (memo : @& MemoNext) (hot : @& BorrowedGeneratedHotPlan.Snapshot)
    (axis i a b c member : Nat) : Bool :=
  if hi : i < memo.values.size then BorrowedGeneratedHotPlan.singleNext hot axis memo.values[i] a b c member
  else BorrowedGeneratedHotPlan.singleNext hot axis (memo.fallback i) a b c member

@[inline] def allAt (snapshot : @& Snapshot) (axis i a b c : Nat) : Bool :=
  if axis < 3 then
    if ha : axis < snapshot.next.next.size then
      numericAll snapshot.next.next[axis] snapshot.hot axis i a b c
    else BorrowedGeneratedHotPlan.allNext snapshot.hot axis (snapshot.hot.next axis i) a b c
  else if axis = 3 then BorrowedGeneratedHotPlan.allNext snapshot.hot axis snapshot.honor a b c
  else BorrowedGeneratedHotPlan.allNext snapshot.hot axis (snapshot.hot.next axis i) a b c

@[inline] def anyAt (snapshot : @& Snapshot) (axis i a b c : Nat) : Bool :=
  if axis < 3 then
    if ha : axis < snapshot.next.next.size then
      numericAny snapshot.next.next[axis] snapshot.hot axis i a b c
    else BorrowedGeneratedHotPlan.anyNext snapshot.hot axis (snapshot.hot.next axis i) a b c
  else if axis = 3 then BorrowedGeneratedHotPlan.anyNext snapshot.hot axis snapshot.honor a b c
  else BorrowedGeneratedHotPlan.anyNext snapshot.hot axis (snapshot.hot.next axis i) a b c

@[inline] def singleAt (snapshot : @& Snapshot) (axis i a b c member : Nat) : Bool :=
  if axis < 3 then
    if ha : axis < snapshot.next.next.size then
      numericSingle snapshot.next.next[axis] snapshot.hot axis i a b c member
    else BorrowedGeneratedHotPlan.singleNext snapshot.hot axis (snapshot.hot.next axis i) a b c member
  else if axis = 3 then BorrowedGeneratedHotPlan.singleNext snapshot.hot axis snapshot.honor a b c member
  else BorrowedGeneratedHotPlan.singleNext snapshot.hot axis (snapshot.hot.next axis i) a b c member

theorem numericAll_eq (memo : MemoNext) (hot : BorrowedGeneratedHotPlan.Snapshot)
    (axis i a b c : Nat) :
    numericAll memo hot axis i a b c =
      BorrowedGeneratedHotPlan.allNext hot axis (CachedPackedSnapshot.readMemo memo i) a b c := by
  by_cases hi : i < memo.values.size <;> simp only [numericAll,CachedPackedSnapshot.readMemo,hi,↓reduceDIte]

theorem numericAny_eq (memo : MemoNext) (hot : BorrowedGeneratedHotPlan.Snapshot)
    (axis i a b c : Nat) :
    numericAny memo hot axis i a b c =
      BorrowedGeneratedHotPlan.anyNext hot axis (CachedPackedSnapshot.readMemo memo i) a b c := by
  by_cases hi : i < memo.values.size <;> simp only [numericAny,CachedPackedSnapshot.readMemo,hi,↓reduceDIte]

theorem numericSingle_eq (memo : MemoNext) (hot : BorrowedGeneratedHotPlan.Snapshot)
    (axis i a b c member : Nat) :
    numericSingle memo hot axis i a b c member =
      BorrowedGeneratedHotPlan.singleNext hot axis (CachedPackedSnapshot.readMemo memo i) a b c member := by
  by_cases hi : i < memo.values.size <;> simp only [numericSingle,CachedPackedSnapshot.readMemo,hi,↓reduceDIte]

theorem allAt_eq (snapshot : Snapshot) (axis i a b c : Nat) :
    allAt snapshot axis i a b c =
      BorrowedGeneratedHotPlan.allNext snapshot.hot axis (next snapshot axis i) a b c := by
  by_cases hn : axis < 3
  · by_cases ha : axis < snapshot.next.next.size <;>
      simp only [allAt,next,hn,ha,↓reduceIte,↓reduceDIte,numericAll_eq]
  · by_cases hh : axis = 3 <;>
      simp [allAt,next,hn,hh]

theorem anyAt_eq (snapshot : Snapshot) (axis i a b c : Nat) :
    anyAt snapshot axis i a b c =
      BorrowedGeneratedHotPlan.anyNext snapshot.hot axis (next snapshot axis i) a b c := by
  by_cases hn : axis < 3
  · by_cases ha : axis < snapshot.next.next.size <;>
      simp only [anyAt,next,hn,ha,↓reduceIte,↓reduceDIte,numericAny_eq]
  · by_cases hh : axis = 3 <;>
      simp [anyAt,next,hn,hh]

theorem singleAt_eq (snapshot : Snapshot) (axis i a b c member : Nat) :
    singleAt snapshot axis i a b c member =
      BorrowedGeneratedHotPlan.singleNext snapshot.hot axis (next snapshot axis i) a b c member := by
  by_cases hn : axis < 3
  · by_cases ha : axis < snapshot.next.next.size <;>
      simp only [singleAt,next,hn,ha,↓reduceIte,↓reduceDIte,numericSingle_eq]
  · by_cases hh : axis = 3 <;>
      simp [singleAt,next,hn,hh]

theorem pointP_toV11 (snapshot : Snapshot) (axis j a b c : Nat) :
    BorrowedGeneratedHotPlan.pointP (toV11 snapshot) axis j a b c =
      BorrowedGeneratedHotPlan.pointP snapshot.hot axis j a b c := rfl

theorem pointN_toV11 (snapshot : Snapshot) (axis j a b c : Nat) :
    BorrowedGeneratedHotPlan.pointN (toV11 snapshot) axis j a b c =
      BorrowedGeneratedHotPlan.pointN snapshot.hot axis j a b c := rfl

theorem allNext_toV11 (snapshot : Snapshot) (axis : Nat) (js : List Nat) (a b c : Nat) :
    BorrowedGeneratedHotPlan.allNext (toV11 snapshot) axis js a b c =
      BorrowedGeneratedHotPlan.allNext snapshot.hot axis js a b c := by
  induction js with
  | nil => rfl
  | cons j js ih => simp only [BorrowedGeneratedHotPlan.allNext,pointP_toV11,ih]

theorem anyNext_toV11 (snapshot : Snapshot) (axis : Nat) (js : List Nat) (a b c : Nat) :
    BorrowedGeneratedHotPlan.anyNext (toV11 snapshot) axis js a b c =
      BorrowedGeneratedHotPlan.anyNext snapshot.hot axis js a b c := by
  induction js with
  | nil => rfl
  | cons j js ih => simp only [BorrowedGeneratedHotPlan.anyNext,pointN_toV11,ih]

theorem singleNext_toV11 (snapshot : Snapshot) (axis : Nat) (js : List Nat) (a b c member : Nat) :
    BorrowedGeneratedHotPlan.singleNext (toV11 snapshot) axis js a b c member =
      BorrowedGeneratedHotPlan.singleNext snapshot.hot axis js a b c member := by
  induction js with
  | nil => rfl
  | cons j js ih => simp only [BorrowedGeneratedHotPlan.singleNext,pointN_toV11,ih]

/-- Literal scalar expansion of the original source guard and address formula.
No range, order, arithmetic, or out-of-domain behavior is removed. -/
@[inline] def sourceAddress (view : @& SourceBlockGuard.View) (a b c r : Nat) : Bool :=
  decide ((view.word.firstA ≤ a ∧ a < view.word.firstA+view.sizes.1) ∧
    (view.word.firstB ≤ b ∧ b < view.word.firstB+view.sizes.2.1) ∧
    (view.word.firstC ≤ c ∧ c < view.word.firstC+view.sizes.2.2) ∧
    a ≤ b ∧ b ≤ c) &&
    decide ((view.word.offset + WordRank.within view.word.a view.word.b view.word.c
      view.word.sizeA view.word.sizeB (UInt64.ofNat (a-view.word.firstA))
      (UInt64.ofNat (b-view.word.firstB)) (UInt64.ofNat (c-view.word.firstC))).toNat = r)

theorem sourceAddress_eq (view : SourceBlockGuard.View) (ids : Triple) (r : Nat) :
    sourceAddress view ids.1 ids.2.1 ids.2.2 r = SourceBlockGuard.checkAddress view ids r := rfl

@[inline] def row (snapshot : @& Snapshot) (view : @& SourceBlockGuard.View)
    (_ctx : @& Context) (ids : @& Triple) (r : Nat) (sourceP : Bool) : Bool :=
  sourceAddress view ids.1 ids.2.1 ids.2.2 r &&
    if sourceP then
      allAt snapshot 0 ids.1 ids.1 ids.2.1 ids.2.2 &&
      allAt snapshot 1 ids.2.1 ids.1 ids.2.1 ids.2.2 &&
      allAt snapshot 2 ids.2.2 ids.1 ids.2.1 ids.2.2 &&
      allAt snapshot 3 0 ids.1 ids.2.1 ids.2.2
    else
      anyAt snapshot 0 ids.1 ids.1 ids.2.1 ids.2.2 ||
      anyAt snapshot 1 ids.2.1 ids.1 ids.2.1 ids.2.2 ||
      anyAt snapshot 2 ids.2.2 ids.1 ids.2.1 ids.2.2 ||
      anyAt snapshot 3 0 ids.1 ids.2.1 ids.2.2

@[inline] def single (snapshot : @& Snapshot) (view : @& SourceBlockGuard.View)
    (_ctx : @& Context) (ids : @& Triple) (r axis member : Nat) : Bool :=
  sourceAddress view ids.1 ids.2.1 ids.2.2 r && decide (axis < 4) &&
    singleAt snapshot axis (if axis < 3 then
      if axis = 0 then ids.1 else if axis = 1 then ids.2.1 else ids.2.2 else 0)
      ids.1 ids.2.1 ids.2.2 member

theorem row_eq (snapshot : Snapshot) (view : SourceBlockGuard.View) (ctx : Context)
    (ids : Triple) (r : Nat) (sourceP : Bool) :
    row snapshot view ctx ids r sourceP =
      BorrowedGeneratedHotPlan.row (toV11 snapshot) view ctx ids r sourceP := by
  simp only [row,sourceAddress_eq,BorrowedGeneratedHotPlan.row,allAt_eq,anyAt_eq,allNext_toV11,anyNext_toV11]
  rfl

theorem single_eq (snapshot : Snapshot) (view : SourceBlockGuard.View) (ctx : Context)
    (ids : Triple) (r axis member : Nat) :
    single snapshot view ctx ids r axis member =
      BorrowedGeneratedHotPlan.single (toV11 snapshot) view ctx ids r axis member := by
  simp only [single,sourceAddress_eq,BorrowedGeneratedHotPlan.single,singleAt_eq,singleNext_toV11]
  rfl

theorem hot_build (localData : CachedPackedCheck.Local) (bank : Bank)
    (ctx : Context) (tables : GeneratedPlanCheck.Tables) :
    (build localData bank ctx tables).hot = BorrowedGeneratedHotPlan.build localData bank ctx tables := rfl

theorem next_build (localData : CachedPackedCheck.Local) (bank : Bank)
    (ctx : Context) (tables : GeneratedPlanCheck.Tables) (axis i : Nat) :
    next (build localData bank ctx tables) axis i =
      (BorrowedGeneratedHotPlan.build localData bank ctx tables).next axis i := by
  by_cases hn : axis < 3
  · have ha : axis < 4 := by omega
    simp [next,build,buildWithShared,buildShared,GeneratedLocalCache.build,hn,ha,
      CachedPackedSnapshot.readMemo_build,BorrowedGeneratedHotPlan.build,
      BorrowedGeneratedHotPlan.buildWithShared]
  · by_cases hh : axis = 3
    · subst axis
      simp [next,build,buildWithShared,BorrowedGeneratedHotPlan.build,
        BorrowedGeneratedHotPlan.buildWithShared]
    · simp only [next,hn,hh,↓reduceIte]
      rw [hot_build]

theorem toV11_build (localData : CachedPackedCheck.Local) (bank : Bank)
    (ctx : Context) (tables : GeneratedPlanCheck.Tables) :
    toV11 (build localData bank ctx tables) = BorrowedGeneratedHotPlan.build localData bank ctx tables := by
  have sameNext : next (build localData bank ctx tables) =
      (BorrowedGeneratedHotPlan.build localData bank ctx tables).next := by
    funext axis i
    exact next_build localData bank ctx tables axis i
  simp only [toV11,hot_build,sameNext]

theorem row_build (localData : CachedPackedCheck.Local) (bank : Bank)
    (ctx : Context) (tables : GeneratedPlanCheck.Tables) (view : SourceBlockGuard.View)
    (ids : Triple) (r : Nat) (sourceP : Bool) :
    row (build localData bank ctx tables) view ctx ids r sourceP =
      BlockPlanFastSource.row bank view ctx
        (GeneratedPlanCheck.generatedPlan localData bank ctx tables) ids r sourceP := by
  rw [row_eq,toV11_build]
  exact BorrowedGeneratedHotPlan.row_build localData bank ctx tables view ids r sourceP

theorem single_build (localData : CachedPackedCheck.Local) (bank : Bank)
    (ctx : Context) (tables : GeneratedPlanCheck.Tables) (view : SourceBlockGuard.View)
    (ids : Triple) (r axis member : Nat) :
    single (build localData bank ctx tables) view ctx ids r axis member =
      BlockPlanFastSource.single bank view ctx
        (GeneratedPlanCheck.generatedPlan localData bank ctx tables) ids r axis member := by
  rw [single_eq,toV11_build]
  exact BorrowedGeneratedHotPlan.single_build localData bank ctx tables view ids r axis member

/-- Used only for the worker's already-rejecting out-of-range default. -/
def empty : Snapshot :=
  let word : BlockWordAddress.View := ⟨0,0,0,0,0,0,0,0,0⟩
  let table : Table := ⟨#[],#[]⟩
  ⟨⟨#[],fun _ => table,⟨0,false,ByteArray.empty,HotWord.ofView word⟩,
      ⟨#[],fun _ => 0⟩,fun _ _ => []⟩,⟨#[]⟩,[]⟩

end Mahjong.BorrowedNextGeneratedHotPlan

#print axioms Mahjong.BorrowedNextGeneratedHotPlan.numericAll_eq
#print axioms Mahjong.BorrowedNextGeneratedHotPlan.numericAny_eq
#print axioms Mahjong.BorrowedNextGeneratedHotPlan.numericSingle_eq
#print axioms Mahjong.BorrowedNextGeneratedHotPlan.allAt_eq
#print axioms Mahjong.BorrowedNextGeneratedHotPlan.anyAt_eq
#print axioms Mahjong.BorrowedNextGeneratedHotPlan.singleAt_eq
#print axioms Mahjong.BorrowedNextGeneratedHotPlan.sourceAddress_eq
#print axioms Mahjong.BorrowedNextGeneratedHotPlan.row_eq
#print axioms Mahjong.BorrowedNextGeneratedHotPlan.single_eq
#print axioms Mahjong.BorrowedNextGeneratedHotPlan.next_build
#print axioms Mahjong.BorrowedNextGeneratedHotPlan.toV11_build
#print axioms Mahjong.BorrowedNextGeneratedHotPlan.row_build
#print axioms Mahjong.BorrowedNextGeneratedHotPlan.single_build
