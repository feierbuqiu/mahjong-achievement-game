import Mahjong.SparseTemplatePlanCheck
import Mahjong.CompactHotRow

set_option autoImplicit false

namespace Mahjong.SparseCompactHotRow
open GroupCandidates BlockPlanCheck PackedRules GeneralLayer
open GlobalEnumeration CanonicalInventory SafeGame BlockPlanSoundness
open BlockPlanCertifiedRow (sourceModel)

/-- Sparse preparation changes no compact row semantics. The explicit checked
next-layer premise, actual source row and complete P/actual-member N obligations
are retained in the original game conclusion. -/
theorem original (c : Certificate) (data : Nat → SuccessorCache.Data)
    (cacheChecked : GlobalSuccessorBridge.Checked c data) (bank : Bank)
    (groupEq : groupData bank = c.groups) (metadata : GuardedTargetRef.Checked (guardedBank bank))
    (correct : TargetCorrect (FullSafeData.summaries (CachedPackedCheck.ofCertificate c data).rules)
      (GuardedTargetRef.target (guardedBank bank)))
    (source : BucketIndex.Data) (sourceGroups : (sourceModel bank source).groups = groupData bank)
    (sourceChecked : IndexOperations.Checked (sourceModel bank source))
    (fits : WordLimits.GroupsFit (sourceModel bank source).groups)
    (limits : WordLimits.bucketFits (sourceModel bank source).directory.blocks source.size = true)
    (view : SourceBlockGuard.View) (ctx : Context) (plan : Plan) (tables : SparseTemplatePlanCheck.Tables)
    (honor : ctx.honorCode = source.honorCode)
    (preparedSource : SourceBlockGuard.check (sourceModel bank source) ctx.sourceBlock view = true)
    (preparedPlan : SparseTemplatePlanCheck.checkPlan (CachedPackedCheck.ofCertificate c data) bank
      (sourceModel bank source) ctx plan tables = true)
    (word : UInt64) (r : Nat) (sourceP : Bool)
    (accepted : CompactHotRow.check (HotBlockPlan.build bank ctx plan) view ctx word r sourceP = true) :
    r < source.size ∧ AchievementStrategy Step Win
      (Base5Coverage.unpack (BucketIndex.unrank source r)) (outcome sourceP) := by
  have checkedPlan := SparseTemplatePlanCheck.checkPlan_refines (CachedPackedCheck.ofCertificate c data)
    bank (sourceModel bank source) ctx plan tables preparedPlan
  cases sourceP with
  | false =>
    have hot := CompactHotRow.n_refines _ _ _ _ _ accepted
    have old : BlockPlanFastSource.single bank view ctx plan (CompactHotRow.ids view word) r
        (CompactHotRow.block word) (CompactHotRow.member word) = true := by
      rw [← HotBlockPlan.single_build bank view ctx plan (CompactHotRow.ids view word) r
        (CompactHotRow.block word) (CompactHotRow.member word)]
      exact hot
    exact BlockPlanCertifiedRow.single_original c data cacheChecked bank groupEq metadata correct
      source sourceGroups sourceChecked fits limits view ctx plan honor preparedSource checkedPlan
      (CompactHotRow.ids view word) r (CompactHotRow.block word) (CompactHotRow.member word) old
  | true =>
    have hot := CompactHotRow.p_refines _ _ _ _ _ accepted
    have old : BlockPlanFastSource.row bank view ctx plan (CompactHotRow.ids view word) r true = true := by
      rw [← HotBlockPlan.row_build bank view ctx plan (CompactHotRow.ids view word) r true]
      exact hot
    exact BlockPlanCertifiedRow.row_original c data cacheChecked bank groupEq metadata correct
      source sourceGroups sourceChecked fits limits view ctx plan honor preparedSource checkedPlan
      (CompactHotRow.ids view word) r true old

end Mahjong.SparseCompactHotRow

#print axioms Mahjong.SparseCompactHotRow.original
