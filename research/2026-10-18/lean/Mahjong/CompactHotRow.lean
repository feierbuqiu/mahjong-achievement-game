import Mahjong.TemplatePlanCertifiedRow
set_option autoImplicit false

namespace Mahjong.CompactHotRow
open GroupCandidates BlockPlanCheck
open PackedRules GeneralLayer
open GlobalEnumeration CanonicalInventory SafeGame BlockPlanSoundness
open BlockPlanCertifiedRow (sourceModel)

@[inline] def ids (view : @& SourceBlockGuard.View) (word : UInt64) : Triple :=
  (view.word.firstA+(word &&& 4095).toNat,
   view.word.firstB+((word >>> 12) &&& 4095).toNat,
   view.word.firstC+((word >>> 24) &&& 4095).toNat)

@[inline] def block (word : UInt64) : Nat := ((word >>> 36) &&& 3).toNat
@[inline] def member (word : UInt64) : Nat := ((word >>> 38) &&& 262143).toNat

@[inline] def format (word : UInt64) (sourceP : Bool) : Bool :=
  decide (word >>> 57 = 0) &&
  decide (((word >>> 56) &&& 1) = if sourceP then 1 else 0) &&
  (if sourceP then decide (block word = 0 ∧ member word = 0) else true)

/-- Decoded words remain arbitrary proposals. The original source-r guard and
    complete P / actual-member N checks are evaluated on every accepted row. -/
@[inline] def check (snapshot : @& HotBlockPlan.Snapshot)
    (view : @& SourceBlockGuard.View) (ctx : @& Context)
    (word : UInt64) (r : Nat) (sourceP : Bool) : Bool :=
  format word sourceP &&
    if sourceP then HotBlockPlan.row snapshot view ctx (ids view word) r true
    else HotBlockPlan.single snapshot view ctx (ids view word) r (block word) (member word)

theorem p_refines (snapshot : HotBlockPlan.Snapshot) (view : SourceBlockGuard.View)
    (ctx : Context) (word : UInt64) (r : Nat)
    (accepted : check snapshot view ctx word r true = true) :
    HotBlockPlan.row snapshot view ctx (ids view word) r true = true := by
  simp only [check,Bool.and_eq_true,↓reduceIte] at accepted
  exact accepted.2

theorem n_refines (snapshot : HotBlockPlan.Snapshot) (view : SourceBlockGuard.View)
    (ctx : Context) (word : UInt64) (r : Nat)
    (accepted : check snapshot view ctx word r false = true) :
    HotBlockPlan.single snapshot view ctx (ids view word) r (block word) (member word) = true := by
  simp only [check,Bool.and_eq_true,↓reduceIte] at accepted
  exact accepted.2

/-- The wire decoder adds no premise: the accepted untrusted IDs and N member
    are quantified proposals in the existing actual-source-row soundness theorem. -/
theorem original (c : Certificate) (data : Nat → SuccessorCache.Data)
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
    (preparedPlan : TemplatePlanCheck.checkPlan (CachedPackedCheck.ofCertificate c data) bank
      (sourceModel bank source) ctx plan tables = true)
    (word : UInt64) (r : Nat) (sourceP : Bool)
    (accepted : check (HotBlockPlan.build bank ctx plan) view ctx word r sourceP = true) :
    r < source.size ∧ AchievementStrategy Step Win
      (Base5Coverage.unpack (BucketIndex.unrank source r)) (outcome sourceP) := by
  cases sourceP with
  | false =>
    exact TemplatePlanCertifiedRow.single_original c data cacheChecked bank groupEq metadata correct
      source sourceGroups sourceChecked fits limits view ctx plan tables honor preparedSource
      preparedPlan (ids view word) r (block word) (member word) (n_refines _ _ _ _ _ accepted)
  | true =>
    exact TemplatePlanCertifiedRow.row_original c data cacheChecked bank groupEq metadata correct
      source sourceGroups sourceChecked fits limits view ctx plan tables honor preparedSource
      preparedPlan (ids view word) r true (p_refines _ _ _ _ _ accepted)

end Mahjong.CompactHotRow

#print axioms Mahjong.CompactHotRow.p_refines
#print axioms Mahjong.CompactHotRow.n_refines
#print axioms Mahjong.CompactHotRow.original
