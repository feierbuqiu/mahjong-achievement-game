import Mahjong.IndexedByteRowV16

set_option autoImplicit false

namespace Mahjong.IndexedByteRowSafeV17

open PackedRules GeneralLayer GroupCandidates BlockPlanCheck BlockPlanSoundness
open GlobalEnumeration CanonicalInventory SafeGame
open BlockPlanCertifiedRow (sourceModel)

/-- Keep the stronger SAFE normal-play result before applying the original
achievement-game reduction. The source guard ties this result to the actual
legacy decoder at the absolute row r. -/
private theorem checked_row_sound_at (c : Certificate) (data : Nat → SuccessorCache.Data)
    (cacheChecked : GlobalSuccessorBridge.Checked c data) (bank : Bank)
    (groupEq : groupData bank = c.groups) (metadata : GuardedTargetRef.Checked (guardedBank bank))
    (correct : TargetCorrect (FullSafeData.summaries (CachedPackedCheck.ofCertificate c data).rules)
      (GuardedTargetRef.target (guardedBank bank)))
    (source : BucketIndex.Data) (sourceGroups : (sourceModel bank source).groups = groupData bank)
    (sourceChecked : IndexOperations.Checked (sourceModel bank source))
    (fits : WordLimits.GroupsFit (sourceModel bank source).groups)
    (limits : WordLimits.bucketFits (sourceModel bank source).directory.blocks source.size = true)
    (view : SourceBlockGuard.View) (ctx : Context) (plan : Plan)
    (honor : ctx.honorCode = source.honorCode)
    (preparedSource : SourceBlockGuard.check (sourceModel bank source) ctx.sourceBlock view = true)
    (preparedPlan : BlockPlanCheck.checkPlan (CachedPackedCheck.ofCertificate c data) bank
      (sourceModel bank source) ctx plan = true)
    (ids : Triple) (r : Nat) (sourceP : Bool)
    (guarded : SourceBlockGuard.checkAddress view ids r = true)
    (accepted : BlockPlanCheck.row bank (sourceModel bank source) ctx plan ids r sourceP = true) :
    r < source.size ∧
      IsSafe (Base5Coverage.unpack (BucketIndex.unrank source r)) ∧
      NormalStrategy SafeMove (Base5Coverage.unpack (BucketIndex.unrank source r)) (outcome sourceP) := by
  have strategy := BlockPlanSoundness.row_sound c data cacheChecked bank groupEq metadata correct
    (sourceModel bank source) sourceGroups ctx plan preparedPlan ids r sourceP accepted
  have decoded := BlockPlanCertifiedRow.decoded_at bank source sourceGroups sourceChecked fits limits
    view ctx honor preparedSource ids r guarded
  refine ⟨decoded.1,?_⟩
  rw [decoded.2,groupEq]
  exact strategy

/-- Strong soundness for the unchanged V16 byte checker. All parameters,
including the next-layer TargetCorrect premise, have the same meaning and
order as IndexedByteRowV16.original. P still uses every actual SAFE successor;
N still supplies a member of the actual successor list. No correctness of the
GPU byte, coordinate cursor, or supplied source label is assumed here. A caller
binding this theorem to a stored label must additionally identify sourceP with
that actual stored label. -/
theorem sound (c : Certificate) (data : Nat → SuccessorCache.Data)
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
    (accepted : IndexedByteRowV16.check
      (BorrowedNextGeneratedHotPlan.build (CachedPackedCheck.ofCertificate c data) bank ctx tables)
      view ctx ids byte r sourceP = true) :
    r < source.size ∧
      IsSafe (Base5Coverage.unpack (BucketIndex.unrank source r)) ∧
      NormalStrategy SafeMove (Base5Coverage.unpack (BucketIndex.unrank source r)) (outcome sourceP) := by
  let localData := CachedPackedCheck.ofCertificate c data
  have checkedPlan := GeneratedPlanCheck.checkPlan_refines localData bank
    (sourceModel bank source) ctx coverage tables globalChecked preparedPlan
  cases sourceP with
  | false =>
    obtain ⟨member,hot⟩ := IndexedByteRowV16.n_refines _ _ _ _ _ _ accepted
    have fast : BlockPlanFastSource.single bank view ctx
        (GeneratedPlanCheck.generatedPlan localData bank ctx tables)
        ids r (byte.toNat/32) member = true := by
      rw [← BorrowedNextGeneratedHotPlan.single_build localData bank ctx tables view ids r
        (byte.toNat/32) member]
      exact hot
    have oldSingle := BlockPlanFastSource.single_refines bank (sourceModel bank source) sourceChecked
      view ctx (GeneratedPlanCheck.generatedPlan localData bank ctx tables) ids r
      (byte.toNat/32) member preparedSource fast
    have oldRow := BlockPlanSoundness.single_implies_row bank (sourceModel bank source) ctx
      (GeneratedPlanCheck.generatedPlan localData bank ctx tables) ids r (byte.toNat/32) member oldSingle
    have guarded : SourceBlockGuard.checkAddress view ids r = true := by
      have parts := fast
      simp only [BlockPlanFastSource.single,Bool.and_eq_true] at parts
      exact parts.1.1
    exact checked_row_sound_at c data cacheChecked bank groupEq metadata correct source sourceGroups
      sourceChecked fits limits view ctx (GeneratedPlanCheck.generatedPlan localData bank ctx tables)
      honor preparedSource checkedPlan ids r false guarded oldRow
  | true =>
    have hot := IndexedByteRowV16.p_refines _ _ _ _ _ _ accepted
    have fast : BlockPlanFastSource.row bank view ctx
        (GeneratedPlanCheck.generatedPlan localData bank ctx tables) ids r true = true := by
      rw [← BorrowedNextGeneratedHotPlan.row_build localData bank ctx tables view ids r true]
      exact hot
    have oldRow := BlockPlanFastSource.row_refines bank (sourceModel bank source) sourceChecked
      view ctx (GeneratedPlanCheck.generatedPlan localData bank ctx tables) ids r true preparedSource fast
    have guarded : SourceBlockGuard.checkAddress view ids r = true := by
      have parts := fast
      simp only [BlockPlanFastSource.row,Bool.and_eq_true] at parts
      exact parts.1
    exact checked_row_sound_at c data cacheChecked bank groupEq metadata correct source sourceGroups
      sourceChecked fits limits view ctx (GeneratedPlanCheck.generatedPlan localData bank ctx tables)
      honor preparedSource checkedPlan ids r true guarded oldRow

end Mahjong.IndexedByteRowSafeV17

#print axioms Mahjong.IndexedByteRowSafeV17.sound
