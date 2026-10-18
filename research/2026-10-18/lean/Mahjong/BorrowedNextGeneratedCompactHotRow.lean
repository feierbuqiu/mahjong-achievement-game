import Mahjong.BorrowedNextGeneratedHotPlan
import Mahjong.CompactHotRow

set_option autoImplicit false

namespace Mahjong.BorrowedNextGeneratedCompactHotRow
open GroupCandidates BlockPlanCheck PackedRules GeneralLayer
open GlobalEnumeration CanonicalInventory SafeGame BlockPlanSoundness
open BlockPlanCertifiedRow (sourceModel)

/-- The same untrusted wire format and per-row source guard. Only the internal
representation of the complete actual successor lists is shared. -/
@[inline] def check (snapshot : @& BorrowedNextGeneratedHotPlan.Snapshot)
    (view : @& SourceBlockGuard.View) (ctx : @& Context)
    (word : UInt64) (r : Nat) (sourceP : Bool) : Bool :=
  CompactHotRow.format word sourceP &&
    if sourceP then BorrowedNextGeneratedHotPlan.row snapshot view ctx (CompactHotRow.ids view word) r true
    else BorrowedNextGeneratedHotPlan.single snapshot view ctx (CompactHotRow.ids view word) r
      (CompactHotRow.block word) (CompactHotRow.member word)

theorem p_refines (snapshot : BorrowedNextGeneratedHotPlan.Snapshot) (view : SourceBlockGuard.View)
    (ctx : Context) (word : UInt64) (r : Nat)
    (accepted : check snapshot view ctx word r true = true) :
    BorrowedNextGeneratedHotPlan.row snapshot view ctx (CompactHotRow.ids view word) r true = true := by
  simp only [check,Bool.and_eq_true,↓reduceIte] at accepted
  exact accepted.2

theorem n_refines (snapshot : BorrowedNextGeneratedHotPlan.Snapshot) (view : SourceBlockGuard.View)
    (ctx : Context) (word : UInt64) (r : Nat)
    (accepted : check snapshot view ctx word r false = true) :
    BorrowedNextGeneratedHotPlan.single snapshot view ctx (CompactHotRow.ids view word) r
      (CompactHotRow.block word) (CompactHotRow.member word) = true := by
  simp only [check,Bool.and_eq_true,↓reduceIte] at accepted
  exact accepted.2

/-- Correctness remains conditional on certified next-layer targets. Global
coverage is checked on every actual cached successor once; block templates are
checked individually, and row checks still inspect all P successors or an actual
N successor. No historical label or GPU proposal is promoted to a premise. -/
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
    (word : UInt64) (r : Nat) (sourceP : Bool)
    (accepted : check (BorrowedNextGeneratedHotPlan.build (CachedPackedCheck.ofCertificate c data) bank ctx tables)
      view ctx word r sourceP = true) :
    r < source.size ∧ AchievementStrategy Step Win
      (Base5Coverage.unpack (BucketIndex.unrank source r)) (outcome sourceP) := by
  let localData := CachedPackedCheck.ofCertificate c data
  let plan := GeneratedPlanCheck.generatedPlan localData bank ctx tables
  have checkedPlan := GeneratedPlanCheck.checkPlan_refines localData bank
    (sourceModel bank source) ctx coverage tables globalChecked preparedPlan
  cases sourceP with
  | false =>
    have hot := n_refines _ _ _ _ _ accepted
    have old : BlockPlanFastSource.single bank view ctx plan (CompactHotRow.ids view word) r
        (CompactHotRow.block word) (CompactHotRow.member word) = true := by
      rw [← BorrowedNextGeneratedHotPlan.single_build localData bank ctx tables view (CompactHotRow.ids view word)
        r (CompactHotRow.block word) (CompactHotRow.member word)]
      exact hot
    exact BlockPlanCertifiedRow.single_original c data cacheChecked bank groupEq metadata correct
      source sourceGroups sourceChecked fits limits view ctx plan honor preparedSource checkedPlan
      (CompactHotRow.ids view word) r (CompactHotRow.block word) (CompactHotRow.member word) old
  | true =>
    have hot := p_refines _ _ _ _ _ accepted
    have old : BlockPlanFastSource.row bank view ctx plan (CompactHotRow.ids view word) r true = true := by
      rw [← BorrowedNextGeneratedHotPlan.row_build localData bank ctx tables view (CompactHotRow.ids view word) r true]
      exact hot
    exact BlockPlanCertifiedRow.row_original c data cacheChecked bank groupEq metadata correct
      source sourceGroups sourceChecked fits limits view ctx plan honor preparedSource checkedPlan
      (CompactHotRow.ids view word) r true old

end Mahjong.BorrowedNextGeneratedCompactHotRow

#print axioms Mahjong.BorrowedNextGeneratedCompactHotRow.p_refines
#print axioms Mahjong.BorrowedNextGeneratedCompactHotRow.n_refines
#print axioms Mahjong.BorrowedNextGeneratedCompactHotRow.original
