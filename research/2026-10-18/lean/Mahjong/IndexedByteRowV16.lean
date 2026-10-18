import Mahjong.BorrowedNextGeneratedCompactHotRow

set_option autoImplicit false

namespace Mahjong.IndexedByteRowV16
open GroupCandidates BlockPlanCheck PackedRules GeneralLayer
open GlobalEnumeration CanonicalInventory SafeGame BlockPlanSoundness
open BlockPlanCertifiedRow (sourceModel)

/-- Select an actual successor by list index. The borrowed result is Bool, so
no owned list or target bits escape the executable helper. -/
def singleIndex (hot : @& BorrowedGeneratedHotPlan.Snapshot) (axis : Nat)
    (js : @& List Nat) (a b c index : Nat) : Bool :=
  match js,index with
  | [],_ => false
  | j::_,0 => BorrowedGeneratedHotPlan.pointN hot axis j a b c
  | _::rest,index+1 => singleIndex hot axis rest a b c index

theorem singleIndex_refines (hot : BorrowedGeneratedHotPlan.Snapshot) (axis : Nat)
    (js : List Nat) (a b c index : Nat)
    (accepted : singleIndex hot axis js a b c index = true) :
    ∃ member, BorrowedGeneratedHotPlan.singleNext hot axis js a b c member = true := by
  induction js generalizing index with
  | nil => simp [singleIndex] at accepted
  | cons j rest ih =>
    cases index with
    | zero =>
      refine ⟨j,?_⟩
      simpa only [singleIndex,BorrowedGeneratedHotPlan.singleNext,decide_true,
        Bool.true_and,Bool.or_eq_true] using Or.inl accepted
    | succ index =>
      obtain ⟨member,checked⟩ := ih index accepted
      exact ⟨member,by simp only [BorrowedGeneratedHotPlan.singleNext,checked,Bool.or_true]⟩

@[noinline] def numericIndex (memo : @& BorrowedNextGeneratedHotPlan.MemoNext)
    (hot : @& BorrowedGeneratedHotPlan.Snapshot) (axis i a b c index : Nat) : Bool :=
  if hi : i < memo.values.size then singleIndex hot axis memo.values[i] a b c index
  else singleIndex hot axis (memo.fallback i) a b c index

theorem numericIndex_refines (memo : BorrowedNextGeneratedHotPlan.MemoNext)
    (hot : BorrowedGeneratedHotPlan.Snapshot) (axis i a b c index : Nat)
    (accepted : numericIndex memo hot axis i a b c index = true) :
    ∃ member, BorrowedNextGeneratedHotPlan.numericSingle memo hot axis i a b c member = true := by
  by_cases hi : i < memo.values.size
  · simp only [numericIndex,hi,↓reduceDIte] at accepted
    obtain ⟨member,checked⟩ := singleIndex_refines hot axis memo.values[i] a b c index accepted
    exact ⟨member,by simpa only [BorrowedNextGeneratedHotPlan.numericSingle,hi,↓reduceDIte] using checked⟩
  · simp only [numericIndex,hi,↓reduceDIte] at accepted
    obtain ⟨member,checked⟩ := singleIndex_refines hot axis (memo.fallback i) a b c index accepted
    exact ⟨member,by simpa only [BorrowedNextGeneratedHotPlan.numericSingle,hi,↓reduceDIte] using checked⟩

@[inline] def atIndex (snapshot : @& BorrowedNextGeneratedHotPlan.Snapshot)
    (axis i a b c index : Nat) : Bool :=
  if axis < 3 then
    if ha : axis < snapshot.next.next.size then
      numericIndex snapshot.next.next[axis] snapshot.hot axis i a b c index
    else singleIndex snapshot.hot axis (snapshot.hot.next axis i) a b c index
  else if axis = 3 then singleIndex snapshot.hot axis snapshot.honor a b c index
  else singleIndex snapshot.hot axis (snapshot.hot.next axis i) a b c index

theorem atIndex_refines (snapshot : BorrowedNextGeneratedHotPlan.Snapshot)
    (axis i a b c index : Nat) (accepted : atIndex snapshot axis i a b c index = true) :
    ∃ member, BorrowedNextGeneratedHotPlan.singleAt snapshot axis i a b c member = true := by
  by_cases hn : axis < 3
  · by_cases ha : axis < snapshot.next.next.size
    · simp only [atIndex,hn,ha,↓reduceIte,↓reduceDIte] at accepted
      obtain ⟨member,checked⟩ := numericIndex_refines snapshot.next.next[axis] snapshot.hot axis i a b c index accepted
      exact ⟨member,by simpa only [BorrowedNextGeneratedHotPlan.singleAt,hn,ha,↓reduceIte,↓reduceDIte] using checked⟩
    · simp only [atIndex,hn,ha,↓reduceIte,↓reduceDIte] at accepted
      obtain ⟨member,checked⟩ := singleIndex_refines snapshot.hot axis (snapshot.hot.next axis i) a b c index accepted
      exact ⟨member,by simpa only [BorrowedNextGeneratedHotPlan.singleAt,hn,ha,↓reduceIte,↓reduceDIte] using checked⟩
  · by_cases hh : axis = 3
    · subst axis
      simp [atIndex] at accepted
      obtain ⟨member,checked⟩ := singleIndex_refines snapshot.hot 3 snapshot.honor a b c index accepted
      exact ⟨member,by simpa [BorrowedNextGeneratedHotPlan.singleAt] using checked⟩
    · simp only [atIndex,hn,hh,↓reduceIte] at accepted
      obtain ⟨member,checked⟩ := singleIndex_refines snapshot.hot axis (snapshot.hot.next axis i) a b c index accepted
      exact ⟨member,by simpa only [BorrowedNextGeneratedHotPlan.singleAt,hn,hh,↓reduceIte] using checked⟩

@[inline] def check (snapshot : @& BorrowedNextGeneratedHotPlan.Snapshot)
    (view : @& SourceBlockGuard.View) (ctx : @& Context)
    (ids : @& Triple) (byte : UInt8) (r : Nat) (sourceP : Bool) : Bool :=
  if sourceP then decide (byte.toNat = 128) && BorrowedNextGeneratedHotPlan.row snapshot view ctx ids r true
  else decide (byte.toNat < 128) &&
    BorrowedNextGeneratedHotPlan.sourceAddress view ids.1 ids.2.1 ids.2.2 r &&
    atIndex snapshot (byte.toNat/32)
      (if byte.toNat/32 < 3 then
        if byte.toNat/32 = 0 then ids.1 else if byte.toNat/32 = 1 then ids.2.1 else ids.2.2
       else 0) ids.1 ids.2.1 ids.2.2 (byte.toNat%32)

theorem p_refines (snapshot : BorrowedNextGeneratedHotPlan.Snapshot)
    (view : SourceBlockGuard.View) (ctx : Context) (ids : Triple) (byte : UInt8) (r : Nat)
    (accepted : check snapshot view ctx ids byte r true = true) :
    BorrowedNextGeneratedHotPlan.row snapshot view ctx ids r true = true := by
  simp only [check,↓reduceIte,Bool.and_eq_true] at accepted
  exact accepted.2

theorem n_refines (snapshot : BorrowedNextGeneratedHotPlan.Snapshot)
    (view : SourceBlockGuard.View) (ctx : Context) (ids : Triple) (byte : UInt8) (r : Nat)
    (accepted : check snapshot view ctx ids byte r false = true) :
    ∃ member, BorrowedNextGeneratedHotPlan.single snapshot view ctx ids r (byte.toNat/32) member = true := by
  change (decide (byte.toNat < 128) &&
    BorrowedNextGeneratedHotPlan.sourceAddress view ids.1 ids.2.1 ids.2.2 r &&
    atIndex snapshot (byte.toNat/32)
      (if byte.toNat/32 < 3 then if byte.toNat/32 = 0 then ids.1 else if byte.toNat/32 = 1 then ids.2.1 else ids.2.2 else 0)
      ids.1 ids.2.1 ids.2.2 (byte.toNat%32)) = true at accepted
  simp only [Bool.and_eq_true,decide_eq_true_eq] at accepted
  have axis : byte.toNat/32 < 4 := by omega
  obtain ⟨member,checked⟩ := atIndex_refines snapshot (byte.toNat/32)
    (if byte.toNat/32 < 3 then if byte.toNat/32 = 0 then ids.1 else if byte.toNat/32 = 1 then ids.2.1 else ids.2.2 else 0)
    ids.1 ids.2.1 ids.2.2 (byte.toNat%32) accepted.2
  exact ⟨member,by simp only [BorrowedNextGeneratedHotPlan.single,accepted.1.2,axis,
    decide_true,Bool.true_and]; exact checked⟩

/-- The same original achievement-game conclusion. Source coordinates are
checked for every r; their producer/cursor is not a correctness premise. -/
theorem original (c : Certificate) (data : Nat → SuccessorCache.Data)
    (cacheChecked : GlobalSuccessorBridge.Checked c data) (bank : Bank)
    (groupEq : groupData bank = c.groups) (metadata : GuardedTargetRef.Checked (guardedBank bank))
    (correct : TargetCorrect (FullSafeData.summaries (CachedPackedCheck.ofCertificate c data).rules)
      (GuardedTargetRef.target (guardedBank bank)))
    (source : BucketIndex.Data) (sourceGroups : (sourceModel bank source).groups = groupData bank)
    (sourceChecked : IndexOperations.Checked (sourceModel bank source))
    (fits : WordLimits.GroupsFit (sourceModel bank source).groups)
    (limits : WordLimits.bucketFits (sourceModel bank source).directory.blocks source.size = true)
    (view : SourceBlockGuard.View) (ctx : Context)
    (coverage : GroupNextCoverage.Data) (tables : GeneratedPlanCheck.Tables)
    (honor : ctx.honorCode = source.honorCode)
    (globalChecked : GroupNextCoverage.check (groupData bank)
      (CachedPackedCheck.ofCertificate c data) coverage = true)
    (preparedSource : SourceBlockGuard.check (sourceModel bank source) ctx.sourceBlock view = true)
    (preparedPlan : GeneratedPlanCheck.checkPlan (CachedPackedCheck.ofCertificate c data) bank
      (sourceModel bank source) ctx coverage tables = true)
    (ids : Triple) (byte : UInt8) (r : Nat) (sourceP : Bool)
    (accepted : check (BorrowedNextGeneratedHotPlan.build (CachedPackedCheck.ofCertificate c data) bank ctx tables)
      view ctx ids byte r sourceP = true) :
    r < source.size ∧ AchievementStrategy Step Win
      (Base5Coverage.unpack (BucketIndex.unrank source r)) (outcome sourceP) := by
  let localData := CachedPackedCheck.ofCertificate c data
  have checkedPlan := GeneratedPlanCheck.checkPlan_refines localData bank
    (sourceModel bank source) ctx coverage tables globalChecked preparedPlan
  cases sourceP with
  | false =>
    obtain ⟨member,hot⟩ := n_refines _ _ _ _ _ _ accepted
    have old : BlockPlanFastSource.single bank view ctx (GeneratedPlanCheck.generatedPlan localData bank ctx tables)
        ids r (byte.toNat/32) member = true := by
      rw [← BorrowedNextGeneratedHotPlan.single_build localData bank ctx tables view ids r (byte.toNat/32) member]
      exact hot
    exact BlockPlanCertifiedRow.single_original c data cacheChecked bank groupEq metadata correct
      source sourceGroups sourceChecked fits limits view ctx (GeneratedPlanCheck.generatedPlan localData bank ctx tables)
      honor preparedSource checkedPlan ids r (byte.toNat/32) member old
  | true =>
    have hot := p_refines _ _ _ _ _ _ accepted
    have old : BlockPlanFastSource.row bank view ctx (GeneratedPlanCheck.generatedPlan localData bank ctx tables) ids r true = true := by
      rw [← BorrowedNextGeneratedHotPlan.row_build localData bank ctx tables view ids r true]
      exact hot
    exact BlockPlanCertifiedRow.row_original c data cacheChecked bank groupEq metadata correct
      source sourceGroups sourceChecked fits limits view ctx (GeneratedPlanCheck.generatedPlan localData bank ctx tables)
      honor preparedSource checkedPlan ids r true old

end Mahjong.IndexedByteRowV16

#print axioms Mahjong.IndexedByteRowV16.singleIndex_refines
#print axioms Mahjong.IndexedByteRowV16.numericIndex_refines
#print axioms Mahjong.IndexedByteRowV16.atIndex_refines
#print axioms Mahjong.IndexedByteRowV16.p_refines
#print axioms Mahjong.IndexedByteRowV16.n_refines
#print axioms Mahjong.IndexedByteRowV16.original
