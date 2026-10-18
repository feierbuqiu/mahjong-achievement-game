import Mahjong.BlockPlanSoundness
import Mahjong.BlockPlanFastSource

set_option autoImplicit false

namespace Mahjong.BlockPlanCertifiedRow
open PackedRules GeneralLayer GroupCandidates BlockPlanCheck BlockPlanSoundness
open GlobalEnumeration CanonicalInventory SafeGame

def sourceModel (bank : Bank) (source : BucketIndex.Data) : IndexOperations.Data :=
  LegacyIndexRefinement.model source bank.shared.raw bank.shared.members

/-- The source packet is tied to the actual legacy source decoder at row r;
    the decoder occurs only in the theorem and is absent from the hot path. -/
theorem decoded_at (bank : Bank) (source : BucketIndex.Data)
    (sourceGroups : (sourceModel bank source).groups = groupData bank)
    (sourceChecked : IndexOperations.Checked (sourceModel bank source))
    (fits : WordLimits.GroupsFit (sourceModel bank source).groups)
    (limits : WordLimits.bucketFits (sourceModel bank source).directory.blocks source.size = true)
    (view : SourceBlockGuard.View) (ctx : Context) (honor : ctx.honorCode = source.honorCode)
    (prepared : SourceBlockGuard.check (sourceModel bank source) ctx.sourceBlock view = true)
    (ids : Triple) (r : Nat) (accepted : SourceBlockGuard.checkAddress view ids r = true) :
    r < source.size ∧ BucketIndex.unrank source r = codes (groupData bank) (packIds ctx ids) := by
  have old := SourceBlockGuard.checkAddress_refines (sourceModel bank source) sourceChecked
    ctx.sourceBlock view ids r prepared accepted
  simp only [GuardedIndexAccess.checkAddress,Bool.and_eq_true,decide_eq_true_eq] at old
  have bound := GuardedIndexAccess.address_bound (sourceModel bank source) sourceChecked fits limits
    ctx.sourceBlock ids old.1
  have inverse := LegacyIndexRefinement.guarded_legacy_inverse source bank.shared.raw bank.shared.members
    sourceChecked fits limits ctx.sourceBlock ids old.1
  change BucketIndex.unrank source (GuardedIndexAccess.address (sourceModel bank source) ctx.sourceBlock ids).toNat = _ at inverse
  rw [old.2] at bound inverse
  refine ⟨bound,?_ ⟩
  change BucketIndex.unrank source r =
    Packed.mk ((groupData bank).retained ids.1) ((groupData bank).retained ids.2.1)
      ((groupData bank).retained ids.2.2) ctx.honorCode
  change BucketIndex.unrank source r =
    Packed.mk ((sourceModel bank source).groups.retained ids.1)
      ((sourceModel bank source).groups.retained ids.2.1)
      ((sourceModel bank source).groups.retained ids.2.2) source.honorCode at inverse
  rwa [sourceGroups,← honor] at inverse

theorem row_original (c : Certificate) (data : Nat → SuccessorCache.Data)
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
    (preparedPlan : checkPlan (CachedPackedCheck.ofCertificate c data) bank (sourceModel bank source) ctx plan = true)
    (ids : Triple) (r : Nat) (sourceP : Bool)
    (accepted : BlockPlanFastSource.row bank view ctx plan ids r sourceP = true) :
    r < source.size ∧ AchievementStrategy Step Win (Base5Coverage.unpack (BucketIndex.unrank source r)) (outcome sourceP) := by
  have old := BlockPlanFastSource.row_refines bank (sourceModel bank source) sourceChecked view ctx plan
    ids r sourceP preparedSource accepted
  have strategy := BlockPlanSoundness.row_original c data cacheChecked bank groupEq metadata correct
    (sourceModel bank source) sourceGroups ctx plan preparedPlan ids r sourceP old
  have guarded : SourceBlockGuard.checkAddress view ids r = true := by
    have parts := accepted
    simp only [BlockPlanFastSource.row,Bool.and_eq_true] at parts
    exact parts.1
  have decoded := decoded_at bank source sourceGroups sourceChecked fits limits view ctx honor preparedSource ids r guarded
  refine ⟨decoded.1,?_ ⟩
  rw [decoded.2,groupEq]
  exact strategy

theorem single_original (c : Certificate) (data : Nat → SuccessorCache.Data)
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
    (preparedPlan : checkPlan (CachedPackedCheck.ofCertificate c data) bank (sourceModel bank source) ctx plan = true)
    (ids : Triple) (r b j : Nat)
    (accepted : BlockPlanFastSource.single bank view ctx plan ids r b j = true) :
    r < source.size ∧ AchievementStrategy Step Win (Base5Coverage.unpack (BucketIndex.unrank source r)) .N := by
  have old := BlockPlanFastSource.single_refines bank (sourceModel bank source) sourceChecked view ctx plan
    ids r b j preparedSource accepted
  have strategy := BlockPlanSoundness.single_original c data cacheChecked bank groupEq metadata correct
    (sourceModel bank source) sourceGroups ctx plan preparedPlan ids r b j old
  have guarded : SourceBlockGuard.checkAddress view ids r = true := by
    have parts := accepted
    simp only [BlockPlanFastSource.single,Bool.and_eq_true] at parts
    exact parts.1.1
  have decoded := decoded_at bank source sourceGroups sourceChecked fits limits view ctx honor preparedSource ids r guarded
  refine ⟨decoded.1,?_ ⟩
  rw [decoded.2,groupEq]
  exact strategy

end Mahjong.BlockPlanCertifiedRow

#print axioms Mahjong.BlockPlanCertifiedRow.decoded_at
#print axioms Mahjong.BlockPlanCertifiedRow.row_original
#print axioms Mahjong.BlockPlanCertifiedRow.single_original
