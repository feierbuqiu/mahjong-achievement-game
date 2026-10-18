import Mahjong.IndexWordArithmetic
import Mahjong.IndexHelperCheck
import Mahjong.DirectorySliceBinding

set_option autoImplicit false

namespace Mahjong.WordLimits
open CanonicalInventory

/-- Bounds already checked on the concrete numeric group records. -/
def GroupsFit (d : GroupInventory.Data) : Prop :=
  d.groups = 1104 ∧ d.count = 131676 ∧
    ∀ g, g < d.groups → 0 < d.size g ∧ d.size g ≤ 3403 ∧ d.first g+d.size g ≤ 131676

theorem groups_from_checks (numeric groups raw members : ByteArray)
    (ng : groups.size/8 = 1104) (nc : numeric.size/12 = 131676)
    (checked : checkSpan (IndexHelperCheck.groupRow groups) 0 1104 = true) :
    GroupsFit (GroupInventory.candidate numeric groups raw members) := by
  refine ⟨ng,nc,?_⟩
  intro g hg
  have hg' : g < 1104 := by change g < groups.size/8 at hg; omega
  have f := IndexHelperCheck.groupRow_bounds groups g (by
    simpa only [Nat.zero_add] using checkSpan_each _ 1104 0 checked g hg')
  exact f

theorem member_storage (d : GroupInventory.Data) (checked : GroupInventory.Checked d)
    (fits : GroupsFit d) (i : Nat) (hi : i < d.count) :
    i < 2^32 ∧ d.group i < 2^16 ∧ d.member i < 2^16 ∧ d.member i ≤ 3403 := by
  have f := GroupInventory.member_facts d checked i hi
  have g := fits.2.2 _ f.group
  have fg := f.group
  have fm := f.member
  have ng := fits.1
  have nc := fits.2.1
  refine ⟨by omega,by omega,by omega,by omega⟩

theorem coordinate_storage (d : GroupInventory.Data) (fits : GroupsFit d) (g x : Nat)
    (hg : g < d.groups) (hx : x < d.size g) :
    d.first g < 2^32 ∧ d.first g+d.size g < 2^32 ∧ d.first g+x+1 < 2^32 ∧ x ≤ 3403 := by
  have f := fits.2.2 g hg
  exact ⟨by omega,by omega,by omega,by omega⟩

def bucketFits (count total : Nat) : Bool := decide (count < 2^32) && decide (total < 2^64)

theorem bucket_facts (count total : Nat) (checked : bucketFits count total = true) :
    count < 2^32 ∧ total < 2^64 := by
  simpa only [bucketFits,Bool.and_eq_true,decide_eq_true_eq] using checked

theorem group_casts (d : GroupInventory.Data) (checked : GroupInventory.Checked d)
    (fits : GroupsFit d) (i : Nat) (hi : i < d.count) :
    (UInt32.ofNat i).toNat = i ∧ (UInt16.ofNat (d.group i)).toNat = d.group i ∧
      (UInt16.ofNat (d.member i)).toNat = d.member i := by
  have f := member_storage d checked fits i hi
  exact ⟨UInt32.toNat_ofNat_of_lt' f.1,UInt16.toNat_ofNat_of_lt' f.2.1,
    UInt16.toNat_ofNat_of_lt' f.2.2.1⟩

theorem widening_preserves (member : UInt16) (size : UInt32) :
    member.toUInt64.toNat = member.toNat ∧ size.toUInt64.toNat = size.toNat := ⟨rfl,rfl⟩

theorem decoder_coordinate_cast (d : GroupInventory.Data) (fits : GroupsFit d) (g x : Nat)
    (hg : g < d.groups) (hx : x < d.size g) :
    ((UInt32.ofNat (d.first g))+(UInt64.ofNat x).toUInt32).toNat = d.first g+x := by
  have bounds := coordinate_storage d fits g x hg hx
  have castX : (UInt64.ofNat x).toNat = x := UInt64.toNat_ofNat_of_lt' (by change x < 2^64; omega)
  have narrow : (UInt64.ofNat x).toUInt32.toNat = x := by
    rw [UInt64.toNat_toUInt32,castX,Nat.mod_eq_of_lt (by omega)]
  rw [UInt32.toNat_add,UInt32.toNat_ofNat_of_lt' bounds.1,narrow,Nat.mod_eq_of_lt (by omega)]

theorem prefix_arithmetic_bounds (d : PrefixDirectory.Data) (checked : PrefixDirectory.check d = true)
    (fits : bucketFits d.blocks d.total = true) (b r : Nat) (hb : b < d.blocks) (hr : r < d.size b) :
    d.offset b+r < 2^64 ∧ r+1 < 2^64 ∧ d.offset b+d.size b < 2^64 ∧ b+1 < 2^32 := by
  have f := PrefixDirectory.row_facts d checked b hb
  have fb := f.bound
  have bounds := bucket_facts d.blocks d.total fits
  exact ⟨by omega,by omega,by omega,by omega⟩

end Mahjong.WordLimits

#print axioms Mahjong.WordLimits.groups_from_checks
#print axioms Mahjong.WordLimits.member_storage
#print axioms Mahjong.WordLimits.coordinate_storage
#print axioms Mahjong.WordLimits.bucket_facts
#print axioms Mahjong.WordLimits.group_casts
#print axioms Mahjong.WordLimits.widening_preserves
#print axioms Mahjong.WordLimits.decoder_coordinate_cast
#print axioms Mahjong.WordLimits.prefix_arithmetic_bounds
