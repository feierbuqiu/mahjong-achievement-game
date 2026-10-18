import Mahjong.LegacyIndexRefinement
import Mahjong.CachedPackedFast

set_option autoImplicit false

namespace Mahjong.GuardedTargetRef
open PackedRules GeneralLayer GroupCandidates CachedPackedCheck

structure Data where
  raw : ByteArray
  members : ByteArray
  buckets : Nat → GeneralIndex.Bucket
  propose : Packed → Nat × Nat × Triple

def model (d : Data) (h : Nat) : IndexOperations.Data :=
  LegacyIndexRefinement.model (d.buckets h).data d.raw d.members

/-- These are finite metadata and machine-word bounds for loaded buckets.
There is deliberately no correctness premise for the proposal function. -/
structure Checked (d : Data) : Prop where
  index : ∀ h, 0 < (d.buckets h).data.size → IndexOperations.Checked (model d h)
  fits : ∀ h, 0 < (d.buckets h).data.size → WordLimits.GroupsFit (model d h).groups
  limits : ∀ h, 0 < (d.buckets h).data.size →
    WordLimits.bucketFits (model d h).directory.blocks (d.buckets h).data.size = true

/-- Exactly the legacy target states and labels. The proposed address is
used only after its guard is checked by entry. -/
def target (d : Data) : Target where
  size := fun h => (d.buckets h).data.size
  unrank := fun h i => BucketIndex.unrank (d.buckets h).data i
  labelP := fun h i => TerminalBucket.labelP (d.buckets h).bits i
  locate := fun s =>
    let p := d.propose s
    let i := (GuardedIndexAccess.address (model d p.1) p.2.1 p.2.2).toNat
    ⟨p.1,i,s,[]⟩

/-- Certified word rank replaces the runtime inverse decoder. The guard
rejects bad/missing buckets, block proposals, IDs or canonical codes. -/
def entry (localData : Local) (d : Data) (s : Packed) (wantP : Bool) : Bool :=
  let canonical := normalize localData s
  let p := d.propose canonical
  let bucket := d.buckets p.1
  let m := LegacyIndexRefinement.model bucket.data d.raw d.members
  decide (0 < bucket.data.size) && GuardedIndexAccess.guard m p.2.1 p.2.2 &&
    decide (LegacyIndexRefinement.codes bucket.data d.raw d.members p.2.2 = canonical) &&
    let i := (GuardedIndexAccess.address m p.2.1 p.2.2).toNat
    if wantP then TerminalBucket.labelP bucket.bits i else !TerminalBucket.labelP bucket.bits i

def row (localData : Local) (d : Data) (s : Packed) (sourceP : Bool) : Bool :=
  initial localData s && if sourceP then
    (raw localData s).all (fun q => !safeB localData q || entry localData d q false)
  else
    (raw localData s).any (fun q => safeB localData q && entry localData d q true)

def single (localData : Local) (d : Data) (s : Packed) (b j : Nat) : Bool :=
  initial localData s && decide (b < 4) &&
    decide (j ∈ (localData.edges b).next (sourceId localData s b)) &&
    safeB localData (replace localData s b j) && entry localData d (replace localData s b j) true

theorem entry_refines (localData : Local) (d : Data) (checked : Checked d)
    (s : Packed) (wantP : Bool) (accepted : entry localData d s wantP = true) :
    CachedPackedFast.labelB localData (target d) s wantP = true := by
  let canonical := normalize localData s
  let p := d.propose canonical
  let bucket := d.buckets p.1
  let m := model d p.1
  let i := (GuardedIndexAccess.address m p.2.1 p.2.2).toNat
  simp only [entry,Bool.and_eq_true,decide_eq_true_eq] at accepted
  have positive : 0 < bucket.data.size := accepted.1.1.1
  have guard : GuardedIndexAccess.guard m p.2.1 p.2.2 = true := accepted.1.1.2
  have codes : LegacyIndexRefinement.codes bucket.data d.raw d.members p.2.2 = canonical := accepted.1.2
  have bound : i < bucket.data.size := GuardedIndexAccess.address_bound m
    (checked.index p.1 positive) (checked.fits p.1 positive) (checked.limits p.1 positive) p.2.1 p.2.2 guard
  have inverse : BucketIndex.unrank bucket.data i = canonical :=
    (LegacyIndexRefinement.guarded_legacy_inverse bucket.data d.raw d.members
      (checked.index p.1 positive) (checked.fits p.1 positive) (checked.limits p.1 positive)
      p.2.1 p.2.2 guard).trans codes
  change (decide (i < bucket.data.size) && decide (BucketIndex.unrank bucket.data i = canonical) &&
    (if wantP then TerminalBucket.labelP bucket.bits i else !TerminalBucket.labelP bucket.bits i)) = true
  simp only [Bool.and_eq_true,decide_eq_true_eq]
  exact ⟨⟨bound,inverse⟩,accepted.2⟩

theorem row_refines (localData : Local) (d : Data) (checked : Checked d)
    (s : Packed) (sourceP : Bool) (accepted : row localData d s sourceP = true) :
    CachedPackedFast.row localData (target d) s sourceP = true := by
  simp only [row,Bool.and_eq_true] at accepted
  simp only [CachedPackedFast.row,Bool.and_eq_true]
  refine ⟨accepted.1,?_⟩
  cases sourceP with
  | true =>
    have scan := accepted.2
    change (raw localData s).all _ = true at scan ⊢
    apply List.all_eq_true.mpr
    intro q mem
    have pass := List.all_eq_true.mp scan q mem
    by_cases safe : safeB localData q = true
    · have child : entry localData d q false = true := by
        simpa only [safe,Bool.not_true,Bool.false_or] using pass
      have result := entry_refines localData d checked q false child
      simpa only [safe,Bool.not_true,Bool.false_or] using result
    · have no : safeB localData q = false := by cases h : safeB localData q <;> simp_all
      simp only [no,Bool.not_false,Bool.true_or]
  | false =>
    have scan := accepted.2
    change (raw localData s).any _ = true at scan ⊢
    obtain ⟨q,mem,pass⟩ := List.any_eq_true.mp scan
    simp only [Bool.and_eq_true] at pass
    exact List.any_eq_true.mpr ⟨q,mem,by
      simp only [Bool.and_eq_true]
      exact ⟨pass.1,entry_refines localData d checked q true pass.2⟩⟩

theorem single_refines (localData : Local) (d : Data) (checked : Checked d)
    (s : Packed) (b j : Nat) (accepted : single localData d s b j = true) :
    CachedPackedFast.single localData (target d) s b j = true := by
  simp only [single,Bool.and_eq_true] at accepted
  simp only [CachedPackedFast.single,Bool.and_eq_true]
  exact ⟨accepted.1,entry_refines localData d checked (replace localData s b j) true accepted.2⟩

theorem row_original (c : GlobalEnumeration.Certificate) (cacheData : Nat → SuccessorCache.Data)
    (cacheChecked : GlobalSuccessorBridge.Checked c cacheData) (d : Data) (checked : Checked d)
    (correct : TargetCorrect (FullSafeData.summaries (ofCertificate c cacheData).rules) (target d))
    (s : Packed) (sourceP : Bool) (accepted : row (ofCertificate c cacheData) d s sourceP = true) :
    SafeGame.AchievementStrategy Step Win (Base5Coverage.unpack s) (outcome sourceP) := by
  have result := row_refines (ofCertificate c cacheData) d checked s sourceP accepted
  rw [CachedPackedFast.row_eq] at result
  exact CachedPackedCheck.row_original c cacheData cacheChecked (target d) correct s sourceP result

theorem single_original (c : GlobalEnumeration.Certificate) (cacheData : Nat → SuccessorCache.Data)
    (cacheChecked : GlobalSuccessorBridge.Checked c cacheData) (d : Data) (checked : Checked d)
    (correct : TargetCorrect (FullSafeData.summaries (ofCertificate c cacheData).rules) (target d))
    (s : Packed) (b j : Nat) (accepted : single (ofCertificate c cacheData) d s b j = true) :
    SafeGame.AchievementStrategy Step Win (Base5Coverage.unpack s) .N := by
  have result := single_refines (ofCertificate c cacheData) d checked s b j accepted
  rw [CachedPackedFast.single_eq] at result
  exact CachedPackedCheck.single_original c cacheData cacheChecked (target d) correct s b j result

end Mahjong.GuardedTargetRef

#print axioms Mahjong.GuardedTargetRef.entry_refines
#print axioms Mahjong.GuardedTargetRef.row_refines
#print axioms Mahjong.GuardedTargetRef.single_refines
#print axioms Mahjong.GuardedTargetRef.row_original
#print axioms Mahjong.GuardedTargetRef.single_original
