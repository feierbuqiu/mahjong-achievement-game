import Mahjong.GuardedTargetRef
import Mahjong.GuardedCachedRow

set_option autoImplicit false

namespace Mahjong.VerifiedSourceTarget
open PackedRules GeneralLayer GroupCandidates GlobalEnumeration CanonicalInventory SafeGame

def row (source : IndexOperations.Data) (localData : CachedPackedCheck.Local)
    (next : GuardedTargetRef.Data) (honorCode block : Nat) (ids : Triple)
    (r : Nat) (labelP : Bool) : Bool :=
  GuardedIndexAccess.checkAddress source block ids r &&
    GuardedTargetRef.row localData next (GuardedCachedRow.codes source honorCode ids) labelP

def single (source : IndexOperations.Data) (localData : CachedPackedCheck.Local)
    (next : GuardedTargetRef.Data) (honorCode block : Nat) (ids : Triple)
    (r b j : Nat) : Bool :=
  GuardedIndexAccess.checkAddress source block ids r &&
    GuardedTargetRef.single localData next (GuardedCachedRow.codes source honorCode ids) b j

theorem row_refines (source : IndexOperations.Data) (localData : CachedPackedCheck.Local)
    (next : GuardedTargetRef.Data) (checked : GuardedTargetRef.Checked next)
    (honorCode block : Nat) (ids : Triple) (r : Nat) (labelP : Bool)
    (accepted : row source localData next honorCode block ids r labelP = true) :
    GuardedCachedRow.row source localData (GuardedTargetRef.target next) honorCode block ids r labelP = true := by
  simp only [row,Bool.and_eq_true] at accepted
  simp only [GuardedCachedRow.row,Bool.and_eq_true]
  have child := GuardedTargetRef.row_refines localData next checked _ labelP accepted.2
  rw [CachedPackedFast.row_eq] at child
  exact ⟨accepted.1,child⟩

theorem single_refines (source : IndexOperations.Data) (localData : CachedPackedCheck.Local)
    (next : GuardedTargetRef.Data) (checked : GuardedTargetRef.Checked next)
    (honorCode block : Nat) (ids : Triple) (r b j : Nat)
    (accepted : single source localData next honorCode block ids r b j = true) :
    GuardedCachedRow.single source localData (GuardedTargetRef.target next) honorCode block ids r b j = true := by
  simp only [single,Bool.and_eq_true] at accepted
  simp only [GuardedCachedRow.single,Bool.and_eq_true]
  have child := GuardedTargetRef.single_refines localData next checked _ b j accepted.2
  rw [CachedPackedFast.single_eq] at child
  exact ⟨accepted.1,child⟩

theorem row_original (c : Certificate) (cacheData : Nat → SuccessorCache.Data)
    (cacheChecked : GlobalSuccessorBridge.Checked c cacheData)
    (next : GuardedTargetRef.Data) (nextChecked : GuardedTargetRef.Checked next)
    (correct : TargetCorrect (FullSafeData.summaries (CachedPackedCheck.ofCertificate c cacheData).rules)
      (GuardedTargetRef.target next))
    (seed : Nat → Nat) (bytes : ByteArray) (total honorCode block : Nat) (ids : Triple)
    (r : Nat) (labelP : Bool)
    (directoryChecked : GuardedIndexAccess.check (GuardedIndexAccess.model c.groups bytes total) = true)
    (fits : WordLimits.GroupsFit c.groups)
    (limits : WordLimits.bucketFits (bytes.size/32) total = true)
    (accepted : row (GuardedIndexAccess.model c.groups bytes total)
      (CachedPackedCheck.ofCertificate c cacheData) next honorCode block ids r labelP = true) :
    r < total ∧ AchievementStrategy Step Win
      (Base5Coverage.unpack (GuardedCachedRow.decoded c seed
        (GuardedIndexAccess.model c.groups bytes total) honorCode r)) (outcome labelP) :=
  GuardedCachedRow.row_original c cacheData cacheChecked (GuardedTargetRef.target next) correct
    seed bytes total honorCode block ids r labelP directoryChecked fits limits
    (row_refines _ _ next nextChecked honorCode block ids r labelP accepted)

theorem single_original (c : Certificate) (cacheData : Nat → SuccessorCache.Data)
    (cacheChecked : GlobalSuccessorBridge.Checked c cacheData)
    (next : GuardedTargetRef.Data) (nextChecked : GuardedTargetRef.Checked next)
    (correct : TargetCorrect (FullSafeData.summaries (CachedPackedCheck.ofCertificate c cacheData).rules)
      (GuardedTargetRef.target next))
    (seed : Nat → Nat) (bytes : ByteArray) (total honorCode block : Nat) (ids : Triple)
    (r b j : Nat)
    (directoryChecked : GuardedIndexAccess.check (GuardedIndexAccess.model c.groups bytes total) = true)
    (fits : WordLimits.GroupsFit c.groups)
    (limits : WordLimits.bucketFits (bytes.size/32) total = true)
    (accepted : single (GuardedIndexAccess.model c.groups bytes total)
      (CachedPackedCheck.ofCertificate c cacheData) next honorCode block ids r b j = true) :
    r < total ∧ AchievementStrategy Step Win
      (Base5Coverage.unpack (GuardedCachedRow.decoded c seed
        (GuardedIndexAccess.model c.groups bytes total) honorCode r)) .N :=
  GuardedCachedRow.single_original c cacheData cacheChecked (GuardedTargetRef.target next) correct
    seed bytes total honorCode block ids r b j directoryChecked fits limits
    (single_refines _ _ next nextChecked honorCode block ids r b j accepted)

def span (source : IndexOperations.Data) (localData : CachedPackedCheck.Local)
    (next : GuardedTargetRef.Data) (honorCode : Nat) (propose : Nat → Nat × Triple)
    (labelP : Nat → Bool) (start count : Nat) : Bool :=
  checkSpan (fun r => row source localData next honorCode (propose r).1 (propose r).2 r (labelP r)) start count

theorem span_each (source : IndexOperations.Data) (localData : CachedPackedCheck.Local)
    (next : GuardedTargetRef.Data) (honorCode : Nat) (propose : Nat → Nat × Triple)
    (labelP : Nat → Bool) (start count : Nat)
    (accepted : span source localData next honorCode propose labelP start count = true)
    (offset : Nat) (inside : offset < count) :
    row source localData next honorCode (propose (start+offset)).1 (propose (start+offset)).2
      (start+offset) (labelP (start+offset)) = true :=
  checkSpan_each _ count start accepted offset inside

theorem span_refines (source : IndexOperations.Data) (localData : CachedPackedCheck.Local)
    (next : GuardedTargetRef.Data) (checked : GuardedTargetRef.Checked next)
    (honorCode : Nat) (propose : Nat → Nat × Triple) (labelP : Nat → Bool)
    (start count : Nat) (accepted : span source localData next honorCode propose labelP start count = true) :
    GuardedCachedRow.span source localData (GuardedTargetRef.target next) honorCode propose labelP start count = true := by
  induction count generalizing start with
  | zero => rfl
  | succ count ih =>
    have parts : row source localData next honorCode (propose start).1 (propose start).2 start (labelP start) = true ∧
      span source localData next honorCode propose labelP (start+1) count = true := by
      simpa only [span,checkSpan,Bool.and_eq_true] using accepted
    change (GuardedCachedRow.row source localData (GuardedTargetRef.target next) honorCode
      (propose start).1 (propose start).2 start (labelP start) &&
      GuardedCachedRow.span source localData (GuardedTargetRef.target next) honorCode propose labelP (start+1) count) = true
    simp only [Bool.and_eq_true]
    exact ⟨row_refines source localData next checked honorCode _ _ _ _ parts.1,ih (start+1) parts.2⟩

end Mahjong.VerifiedSourceTarget

#print axioms Mahjong.VerifiedSourceTarget.row_refines
#print axioms Mahjong.VerifiedSourceTarget.single_refines
#print axioms Mahjong.VerifiedSourceTarget.row_original
#print axioms Mahjong.VerifiedSourceTarget.single_original
#print axioms Mahjong.VerifiedSourceTarget.span_each
#print axioms Mahjong.VerifiedSourceTarget.span_refines
