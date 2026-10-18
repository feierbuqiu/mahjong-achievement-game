import Mahjong.CachedPackedCheck
import Mahjong.GuardedIndexAccess

set_option autoImplicit false

namespace Mahjong.GuardedCachedRow
open PackedRules GeneralLayer GlobalEnumeration GroupCandidates CanonicalInventory SafeGame

/-- The executable source uses the same retained-code array as the checked
group inventory. Source IDs and directory block may be untrusted proposals. -/
def codes (d : IndexOperations.Data) (honorCode : Nat) (ids : Triple) : Packed :=
  ⟨d.groups.retained ids.1,d.groups.retained ids.2.1,d.groups.retained ids.2.2,honorCode⟩

def row (d : IndexOperations.Data) (localData : CachedPackedCheck.Local) (target : Target)
    (honorCode block : Nat) (ids : Triple) (r : Nat) (labelP : Bool) : Bool :=
  GuardedIndexAccess.checkAddress d block ids r &&
    CachedPackedCheck.row localData target (codes d honorCode ids) labelP

def single (d : IndexOperations.Data) (localData : CachedPackedCheck.Local) (target : Target)
    (honorCode block : Nat) (ids : Triple) (r b j : Nat) : Bool :=
  GuardedIndexAccess.checkAddress d block ids r &&
    CachedPackedCheck.single localData target (codes d honorCode ids) b j

/-- Specification of the proved index decoder using the canonical inventory.
The decoder never runs in the guarded source-access path. -/
def decoded (c : Certificate) (seed : Nat → Nat) (d : IndexOperations.Data)
    (honorCode r : Nat) : Packed :=
  let ids := IndexOperations.absolute d (IndexOperations.unrank seed d r)
  ⟨(inventoriesOf c 0).member ids.1,(inventoriesOf c 0).member ids.2.1,
    (inventoriesOf c 0).member ids.2.2,honorCode⟩

/-- Byte-level directory inputs and group-inventory data are the same values
used by the certificate; no assumed decoder or rank implementation is needed. -/
theorem codes_eq_decoded (c : Certificate) (seed : Nat → Nat) (bytes : ByteArray)
    (total honorCode block : Nat) (ids : Triple) (r : Nat)
    (directoryChecked : GuardedIndexAccess.check (GuardedIndexAccess.model c.groups bytes total) = true)
    (fits : WordLimits.GroupsFit c.groups)
    (limits : WordLimits.bucketFits (bytes.size/32) total = true)
    (accepted : GuardedIndexAccess.checkAddress (GuardedIndexAccess.model c.groups bytes total) block ids r = true) :
    r < total ∧ codes (GuardedIndexAccess.model c.groups bytes total) honorCode ids =
      decoded c seed (GuardedIndexAccess.model c.groups bytes total) honorCode r := by
  let d := GuardedIndexAccess.model c.groups bytes total
  have checked : IndexOperations.Checked d := GuardedIndexAccess.checked d c.groupChecked directoryChecked
  have inverse := GuardedIndexAccess.inverse_at seed d checked fits limits block ids r accepted
  refine ⟨inverse.1,?_⟩
  unfold decoded
  rw [inverse.2]
  simp only [codes,GuardedIndexAccess.model,c.link.members]
  rfl

theorem row_original (c : Certificate) (data : Nat → SuccessorCache.Data)
    (cacheChecked : GlobalSuccessorBridge.Checked c data) (target : Target)
    (correct : TargetCorrect (FullSafeData.summaries (CachedPackedCheck.ofCertificate c data).rules) target)
    (seed : Nat → Nat) (bytes : ByteArray) (total honorCode block : Nat) (ids : Triple)
    (r : Nat) (labelP : Bool)
    (directoryChecked : GuardedIndexAccess.check (GuardedIndexAccess.model c.groups bytes total) = true)
    (fits : WordLimits.GroupsFit c.groups)
    (limits : WordLimits.bucketFits (bytes.size/32) total = true)
    (accepted : row (GuardedIndexAccess.model c.groups bytes total)
      (CachedPackedCheck.ofCertificate c data) target honorCode block ids r labelP = true) :
    r < total ∧ AchievementStrategy Step Win
      (Base5Coverage.unpack (decoded c seed (GuardedIndexAccess.model c.groups bytes total) honorCode r))
      (outcome labelP) := by
  simp only [row,Bool.and_eq_true] at accepted
  have source := codes_eq_decoded c seed bytes total honorCode block ids r directoryChecked fits limits accepted.1
  have result := CachedPackedCheck.row_original c data cacheChecked target correct _ labelP accepted.2
  exact ⟨source.1,by rwa [source.2] at result⟩

theorem single_original (c : Certificate) (data : Nat → SuccessorCache.Data)
    (cacheChecked : GlobalSuccessorBridge.Checked c data) (target : Target)
    (correct : TargetCorrect (FullSafeData.summaries (CachedPackedCheck.ofCertificate c data).rules) target)
    (seed : Nat → Nat) (bytes : ByteArray) (total honorCode block : Nat) (ids : Triple)
    (r b j : Nat)
    (directoryChecked : GuardedIndexAccess.check (GuardedIndexAccess.model c.groups bytes total) = true)
    (fits : WordLimits.GroupsFit c.groups)
    (limits : WordLimits.bucketFits (bytes.size/32) total = true)
    (accepted : single (GuardedIndexAccess.model c.groups bytes total)
      (CachedPackedCheck.ofCertificate c data) target honorCode block ids r b j = true) :
    r < total ∧ AchievementStrategy Step Win
      (Base5Coverage.unpack (decoded c seed (GuardedIndexAccess.model c.groups bytes total) honorCode r)) .N := by
  simp only [single,Bool.and_eq_true] at accepted
  have source := codes_eq_decoded c seed bytes total honorCode block ids r directoryChecked fits limits accepted.1
  have result := CachedPackedCheck.single_original c data cacheChecked target correct _ b j accepted.2
  exact ⟨source.1,by rwa [source.2] at result⟩

def span (d : IndexOperations.Data) (localData : CachedPackedCheck.Local) (target : Target)
    (honorCode : Nat) (propose : Nat → Nat × Triple) (labelP : Nat → Bool) (start count : Nat) : Bool :=
  checkSpan (fun r => row d localData target honorCode (propose r).1 (propose r).2 r (labelP r)) start count

theorem span_each (d : IndexOperations.Data) (localData : CachedPackedCheck.Local) (target : Target)
    (honorCode : Nat) (propose : Nat → Nat × Triple) (labelP : Nat → Bool) (start count : Nat)
    (accepted : span d localData target honorCode propose labelP start count = true)
    (offset : Nat) (inside : offset < count) :
    row d localData target honorCode (propose (start+offset)).1 (propose (start+offset)).2
      (start+offset) (labelP (start+offset)) = true :=
  checkSpan_each _ count start accepted offset inside

theorem span_original (c : Certificate) (data : Nat → SuccessorCache.Data)
    (cacheChecked : GlobalSuccessorBridge.Checked c data) (target : Target)
    (correct : TargetCorrect (FullSafeData.summaries (CachedPackedCheck.ofCertificate c data).rules) target)
    (seed : Nat → Nat) (bytes : ByteArray) (total honorCode : Nat)
    (propose : Nat → Nat × Triple) (labelP : Nat → Bool) (start count : Nat)
    (directoryChecked : GuardedIndexAccess.check (GuardedIndexAccess.model c.groups bytes total) = true)
    (fits : WordLimits.GroupsFit c.groups)
    (limits : WordLimits.bucketFits (bytes.size/32) total = true)
    (accepted : span (GuardedIndexAccess.model c.groups bytes total)
      (CachedPackedCheck.ofCertificate c data) target honorCode propose labelP start count = true) :
    ∀ offset, offset < count → start+offset < total ∧ AchievementStrategy Step Win
      (Base5Coverage.unpack (decoded c seed (GuardedIndexAccess.model c.groups bytes total) honorCode (start+offset)))
      (outcome (labelP (start+offset))) := by
  intro offset inside
  exact row_original c data cacheChecked target correct seed bytes total honorCode _ _ _ _
    directoryChecked fits limits (span_each _ _ target honorCode propose labelP start count accepted offset inside)

end Mahjong.GuardedCachedRow

#print axioms Mahjong.GuardedCachedRow.codes_eq_decoded
#print axioms Mahjong.GuardedCachedRow.row_original
#print axioms Mahjong.GuardedCachedRow.single_original
#print axioms Mahjong.GuardedCachedRow.span_each
#print axioms Mahjong.GuardedCachedRow.span_original
