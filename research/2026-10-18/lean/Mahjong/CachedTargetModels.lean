import Mahjong.VerifiedSourceTarget

set_option autoImplicit false

namespace Mahjong.CachedTargetModels
open PackedRules GeneralLayer GroupCandidates CachedPackedCheck GlobalEnumeration SafeGame

structure Memo (α : Type) where
  values : Array α
  fallback : Nat → α

@[noinline] def buildMemo {α : Type} (n : Nat) (f : Nat → α) : Memo α :=
  ⟨Array.ofFn (fun i : Fin n => f i.val),f⟩

def readMemo {α : Type} (m : Memo α) (i : Nat) : α :=
  if h : i < m.values.size then m.values[i] else m.fallback i

theorem readMemo_build {α : Type} (n : Nat) (f : Nat → α) : readMemo (buildMemo n f) = f := by
  funext i
  by_cases h : i < n <;> simp [readMemo,buildMemo,h]

/-- Concrete arrays force all byte decoding before getter closures are made. -/
structure Fields where
  code : Memo Nat
  retained : Memo Nat
  group : Memo Nat
  member : Memo Nat
  first : Memo Nat
  groupSize : Memo Nat
  offset : Memo Nat
  width : Memo Nat
  key : Memo Triple

@[noinline] def buildFields (m : IndexOperations.Data) : Fields :=
  ⟨buildMemo m.groups.count m.groups.code,buildMemo m.groups.count m.groups.retained,
   buildMemo m.groups.count m.groups.group,buildMemo m.groups.count m.groups.member,
   buildMemo m.groups.groups m.groups.first,buildMemo m.groups.groups m.groups.size,
   buildMemo m.directory.blocks m.directory.offset,buildMemo m.directory.blocks m.directory.size,
   buildMemo m.directory.blocks m.key⟩

@[noinline] def useFields (m : IndexOperations.Data) (s : Fields) : IndexOperations.Data :=
  { m with
    groups := { m.groups with
      code := readMemo s.code,retained := readMemo s.retained,
      group := readMemo s.group,member := readMemo s.member,
      first := readMemo s.first,size := readMemo s.groupSize }
    directory := { m.directory with offset := readMemo s.offset,size := readMemo s.width }
    key := readMemo s.key }

theorem useFields_build (m : IndexOperations.Data) : useFields m (buildFields m) = m := by
  simp only [useFields,buildFields,readMemo_build]

structure Snapshot where
  models : Array IndexOperations.Data

/-- The caller builds this explicit structure once before entering a scan.
No model or memo-table constructor occurs in the successful lookup branch. -/
@[noinline] def build (bank : GuardedTargetRef.Data) : Snapshot :=
  ⟨Array.ofFn (fun h : Fin 184 =>
    let m := GuardedTargetRef.model bank h.val
    useFields m (buildFields m))⟩

def lookup (bank : GuardedTargetRef.Data) (s : Snapshot) (h : Nat) : IndexOperations.Data :=
  if inside : h < s.models.size then s.models[h] else GuardedTargetRef.model bank h

theorem lookup_build (bank : GuardedTargetRef.Data) :
    lookup bank (build bank) = GuardedTargetRef.model bank := by
  funext h
  by_cases inside : h < 184 <;>
    simp [lookup,build,inside,useFields_build]

def codes (m : IndexOperations.Data) (honorCode : Nat) (ids : Triple) : Packed :=
  ⟨m.groups.retained ids.1,m.groups.retained ids.2.1,m.groups.retained ids.2.2,honorCode⟩

def entry (localData : Local) (bank : GuardedTargetRef.Data) (snapshot : Snapshot)
    (s : Packed) (wantP : Bool) : Bool :=
  let canonical := normalize localData s
  let p := bank.propose canonical
  let bucket := bank.buckets p.1
  let m := lookup bank snapshot p.1
  decide (0 < bucket.data.size) && GuardedIndexAccess.guard m p.2.1 p.2.2 &&
    decide (codes m bucket.data.honorCode p.2.2 = canonical) &&
    let i := (GuardedIndexAccess.address m p.2.1 p.2.2).toNat
    if wantP then TerminalBucket.labelP bucket.bits i else !TerminalBucket.labelP bucket.bits i

theorem entry_build (localData : Local) (bank : GuardedTargetRef.Data) (s : Packed) (wantP : Bool) :
    entry localData bank (build bank) s wantP = GuardedTargetRef.entry localData bank s wantP := by
  simp only [entry,lookup_build]
  rfl

def row (localData : Local) (bank : GuardedTargetRef.Data) (snapshot : Snapshot)
    (s : Packed) (sourceP : Bool) : Bool :=
  initial localData s && if sourceP then
    (raw localData s).all (fun q => !safeB localData q || entry localData bank snapshot q false)
  else
    (raw localData s).any (fun q => safeB localData q && entry localData bank snapshot q true)

theorem row_build (localData : Local) (bank : GuardedTargetRef.Data) (s : Packed) (sourceP : Bool) :
    row localData bank (build bank) s sourceP = GuardedTargetRef.row localData bank s sourceP := by
  simp only [row,GuardedTargetRef.row,entry_build]

def single (localData : Local) (bank : GuardedTargetRef.Data) (snapshot : Snapshot)
    (s : Packed) (b j : Nat) : Bool :=
  initial localData s && decide (b < 4) &&
    decide (j ∈ (localData.edges b).next (sourceId localData s b)) &&
    safeB localData (replace localData s b j) && entry localData bank snapshot (replace localData s b j) true

theorem single_build (localData : Local) (bank : GuardedTargetRef.Data) (s : Packed) (b j : Nat) :
    single localData bank (build bank) s b j = GuardedTargetRef.single localData bank s b j := by
  simp only [single,GuardedTargetRef.single,entry_build]

def sourceRow (source : IndexOperations.Data) (localData : Local) (bank : GuardedTargetRef.Data)
    (snapshot : Snapshot) (honorCode block : Nat) (ids : Triple) (r : Nat) (labelP : Bool) : Bool :=
  GuardedIndexAccess.checkAddress source block ids r &&
    row localData bank snapshot (GuardedCachedRow.codes source honorCode ids) labelP

theorem sourceRow_build (source : IndexOperations.Data) (localData : Local) (bank : GuardedTargetRef.Data)
    (honorCode block : Nat) (ids : Triple) (r : Nat) (labelP : Bool) :
    sourceRow source localData bank (build bank) honorCode block ids r labelP =
      VerifiedSourceTarget.row source localData bank honorCode block ids r labelP := by
  simp only [sourceRow,VerifiedSourceTarget.row,row_build]

def sourceSingle (source : IndexOperations.Data) (localData : Local) (bank : GuardedTargetRef.Data)
    (snapshot : Snapshot) (honorCode block : Nat) (ids : Triple) (r b j : Nat) : Bool :=
  GuardedIndexAccess.checkAddress source block ids r &&
    single localData bank snapshot (GuardedCachedRow.codes source honorCode ids) b j

theorem sourceSingle_build (source : IndexOperations.Data) (localData : Local) (bank : GuardedTargetRef.Data)
    (honorCode block : Nat) (ids : Triple) (r b j : Nat) :
    sourceSingle source localData bank (build bank) honorCode block ids r b j =
      VerifiedSourceTarget.single source localData bank honorCode block ids r b j := by
  simp only [sourceSingle,VerifiedSourceTarget.single,single_build]

theorem sourceRow_original (c : Certificate) (cacheData : Nat → SuccessorCache.Data)
    (cacheChecked : GlobalSuccessorBridge.Checked c cacheData)
    (bank : GuardedTargetRef.Data) (nextChecked : GuardedTargetRef.Checked bank)
    (correct : TargetCorrect (FullSafeData.summaries (ofCertificate c cacheData).rules)
      (GuardedTargetRef.target bank))
    (seed : Nat → Nat) (bytes : ByteArray) (total honorCode block : Nat) (ids : Triple)
    (r : Nat) (labelP : Bool)
    (directoryChecked : GuardedIndexAccess.check (GuardedIndexAccess.model c.groups bytes total) = true)
    (fits : WordLimits.GroupsFit c.groups)
    (limits : WordLimits.bucketFits (bytes.size/32) total = true)
    (accepted : sourceRow (GuardedIndexAccess.model c.groups bytes total) (ofCertificate c cacheData)
      bank (build bank) honorCode block ids r labelP = true) :
    r < total ∧ AchievementStrategy Step Win
      (Base5Coverage.unpack (GuardedCachedRow.decoded c seed
        (GuardedIndexAccess.model c.groups bytes total) honorCode r)) (outcome labelP) := by
  rw [sourceRow_build] at accepted
  exact VerifiedSourceTarget.row_original c cacheData cacheChecked bank nextChecked correct seed bytes
    total honorCode block ids r labelP directoryChecked fits limits accepted

theorem sourceSingle_original (c : Certificate) (cacheData : Nat → SuccessorCache.Data)
    (cacheChecked : GlobalSuccessorBridge.Checked c cacheData)
    (bank : GuardedTargetRef.Data) (nextChecked : GuardedTargetRef.Checked bank)
    (correct : TargetCorrect (FullSafeData.summaries (ofCertificate c cacheData).rules)
      (GuardedTargetRef.target bank))
    (seed : Nat → Nat) (bytes : ByteArray) (total honorCode block : Nat) (ids : Triple)
    (r b j : Nat)
    (directoryChecked : GuardedIndexAccess.check (GuardedIndexAccess.model c.groups bytes total) = true)
    (fits : WordLimits.GroupsFit c.groups)
    (limits : WordLimits.bucketFits (bytes.size/32) total = true)
    (accepted : sourceSingle (GuardedIndexAccess.model c.groups bytes total) (ofCertificate c cacheData)
      bank (build bank) honorCode block ids r b j = true) :
    r < total ∧ AchievementStrategy Step Win
      (Base5Coverage.unpack (GuardedCachedRow.decoded c seed
        (GuardedIndexAccess.model c.groups bytes total) honorCode r)) .N := by
  rw [sourceSingle_build] at accepted
  exact VerifiedSourceTarget.single_original c cacheData cacheChecked bank nextChecked correct seed bytes
    total honorCode block ids r b j directoryChecked fits limits accepted

end Mahjong.CachedTargetModels

#print axioms Mahjong.CachedTargetModels.readMemo_build
#print axioms Mahjong.CachedTargetModels.useFields_build
#print axioms Mahjong.CachedTargetModels.lookup_build
#print axioms Mahjong.CachedTargetModels.entry_build
#print axioms Mahjong.CachedTargetModels.row_build
#print axioms Mahjong.CachedTargetModels.single_build
#print axioms Mahjong.CachedTargetModels.sourceRow_build
#print axioms Mahjong.CachedTargetModels.sourceSingle_build
#print axioms Mahjong.CachedTargetModels.sourceRow_original
#print axioms Mahjong.CachedTargetModels.sourceSingle_original
