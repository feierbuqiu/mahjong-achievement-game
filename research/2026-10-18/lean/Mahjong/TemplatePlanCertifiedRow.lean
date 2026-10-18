import Mahjong.TemplatePlanCheck
import Mahjong.HotBlockPlan

set_option autoImplicit false

namespace Mahjong.TemplatePlanCertifiedRow
open PackedRules GeneralLayer GroupCandidates BlockPlanCheck BlockPlanSoundness
open GlobalEnumeration CanonicalInventory SafeGame
open BlockPlanCertifiedRow (sourceModel)

/-- The hot snapshot is constructed once, and its exact executable equality
returns to the original source-row theorem. The next-layer correctness premise
is retained explicitly; historical labels do not become certified here. -/
theorem row_original (c : Certificate) (data : Nat → SuccessorCache.Data)
    (cacheChecked : GlobalSuccessorBridge.Checked c data) (bank : Bank)
    (groupEq : groupData bank = c.groups) (metadata : GuardedTargetRef.Checked (guardedBank bank))
    (correct : TargetCorrect (FullSafeData.summaries (CachedPackedCheck.ofCertificate c data).rules)
      (GuardedTargetRef.target (guardedBank bank)))
    (source : BucketIndex.Data) (sourceGroups : (sourceModel bank source).groups = groupData bank)
    (sourceChecked : IndexOperations.Checked (sourceModel bank source))
    (fits : WordLimits.GroupsFit (sourceModel bank source).groups)
    (limits : WordLimits.bucketFits (sourceModel bank source).directory.blocks source.size = true)
    (view : SourceBlockGuard.View) (ctx : Context) (plan : Plan) (tables : TemplatePlanCheck.Tables)
    (honor : ctx.honorCode = source.honorCode)
    (preparedSource : SourceBlockGuard.check (sourceModel bank source) ctx.sourceBlock view = true)
    (preparedPlan : TemplatePlanCheck.checkPlan (CachedPackedCheck.ofCertificate c data) bank (sourceModel bank source) ctx plan tables = true)
    (ids : Triple) (r : Nat) (sourceP : Bool)
    (accepted : HotBlockPlan.row (HotBlockPlan.build bank ctx plan) view ctx ids r sourceP = true) :
    r < source.size ∧ AchievementStrategy Step Win (Base5Coverage.unpack (BucketIndex.unrank source r)) (outcome sourceP) := by
  have old : BlockPlanFastSource.row bank view ctx plan ids r sourceP = true := by
    rw [← HotBlockPlan.row_build bank view ctx plan ids r sourceP]
    exact accepted
  have checkedPlan := TemplatePlanCheck.checkPlan_refines (CachedPackedCheck.ofCertificate c data) bank
    (sourceModel bank source) ctx plan tables preparedPlan
  exact BlockPlanCertifiedRow.row_original c data cacheChecked bank groupEq metadata correct
    source sourceGroups sourceChecked fits limits view ctx plan honor preparedSource checkedPlan
    ids r sourceP old

theorem single_original (c : Certificate) (data : Nat → SuccessorCache.Data)
    (cacheChecked : GlobalSuccessorBridge.Checked c data) (bank : Bank)
    (groupEq : groupData bank = c.groups) (metadata : GuardedTargetRef.Checked (guardedBank bank))
    (correct : TargetCorrect (FullSafeData.summaries (CachedPackedCheck.ofCertificate c data).rules)
      (GuardedTargetRef.target (guardedBank bank)))
    (source : BucketIndex.Data) (sourceGroups : (sourceModel bank source).groups = groupData bank)
    (sourceChecked : IndexOperations.Checked (sourceModel bank source))
    (fits : WordLimits.GroupsFit (sourceModel bank source).groups)
    (limits : WordLimits.bucketFits (sourceModel bank source).directory.blocks source.size = true)
    (view : SourceBlockGuard.View) (ctx : Context) (plan : Plan) (tables : TemplatePlanCheck.Tables)
    (honor : ctx.honorCode = source.honorCode)
    (preparedSource : SourceBlockGuard.check (sourceModel bank source) ctx.sourceBlock view = true)
    (preparedPlan : TemplatePlanCheck.checkPlan (CachedPackedCheck.ofCertificate c data) bank (sourceModel bank source) ctx plan tables = true)
    (ids : Triple) (r b j : Nat)
    (accepted : HotBlockPlan.single (HotBlockPlan.build bank ctx plan) view ctx ids r b j = true) :
    r < source.size ∧ AchievementStrategy Step Win (Base5Coverage.unpack (BucketIndex.unrank source r)) .N := by
  have old : BlockPlanFastSource.single bank view ctx plan ids r b j = true := by
    rw [← HotBlockPlan.single_build bank view ctx plan ids r b j]
    exact accepted
  have checkedPlan := TemplatePlanCheck.checkPlan_refines (CachedPackedCheck.ofCertificate c data) bank
    (sourceModel bank source) ctx plan tables preparedPlan
  exact BlockPlanCertifiedRow.single_original c data cacheChecked bank groupEq metadata correct
    source sourceGroups sourceChecked fits limits view ctx plan honor preparedSource checkedPlan
    ids r b j old

end Mahjong.TemplatePlanCertifiedRow

#print axioms Mahjong.TemplatePlanCertifiedRow.row_original
#print axioms Mahjong.TemplatePlanCertifiedRow.single_original
