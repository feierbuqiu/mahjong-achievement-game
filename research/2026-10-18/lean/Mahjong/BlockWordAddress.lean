import Mahjong.GuardedIndexAccess

set_option autoImplicit false

namespace Mahjong.BlockWordAddress
open GroupCandidates

/-- A compact, explicit block snapshot. Its fields are checked once when the
    plan is prepared. No function closures or directory reads occur in rank. -/
structure View where
  a : Nat
  b : Nat
  c : Nat
  firstA : Nat
  firstB : Nat
  firstC : Nat
  sizeA : UInt64
  sizeB : UInt64
  offset : UInt64
  deriving DecidableEq

def ofModel (d : IndexOperations.Data) (block : Nat) : View :=
  let g := d.key block
  { a := g.1, b := g.2.1, c := g.2.2,
    firstA := d.groups.first g.1,
    firstB := d.groups.first g.2.1,
    firstC := d.groups.first g.2.2,
    sizeA := UInt64.ofNat (d.groups.size g.1),
    sizeB := UInt64.ofNat (d.groups.size g.2.1),
    offset := UInt64.ofNat (d.directory.offset block) }

def address (view : View) (ids : Triple) : UInt64 :=
  view.offset + WordRank.within view.a view.b view.c view.sizeA view.sizeB
    (UInt64.ofNat (ids.1-view.firstA))
    (UInt64.ofNat (ids.2.1-view.firstB))
    (UInt64.ofNat (ids.2.2-view.firstC))

abbrev preload := ofModel
abbrev eval := address

/-- Used if the plan record comes from an arbitrary proposal. A native Lean
    preparer can instead construct ofModel directly. Either case has the same
    proved hot expression and no trusted external fields. -/
def check (d : IndexOperations.Data) (block : Nat) (view : View) : Bool :=
  decide (view = ofModel d block)

theorem check_sound (d : IndexOperations.Data) (block : Nat) (view : View)
    (accepted : check d block view = true) : view = ofModel d block := by
  exact of_decide_eq_true accepted

theorem member_sub (d : GroupInventory.Data) (checked : GroupInventory.Checked d)
    (i : Nat) (inside : i < d.count) :
    d.member i = i-d.first (d.group i) := by
  have eq := (GroupInventory.member_facts d checked i inside).offset
  omega

/-- This equality is for the actual executable UInt64 expressions. It does
    not replace a range guard with an unproved assumption about integer wrap. -/
theorem address_eq (d : IndexOperations.Data) (checked : GroupInventory.Checked d.groups)
    (block : Nat) (ids : Triple)
    (guard : GuardedIndexAccess.guard d block ids = true) :
    address (ofModel d block) ids = GuardedIndexAccess.address d block ids := by
  simp only [GuardedIndexAccess.guard, Bool.and_eq_true, decide_eq_true_eq] at guard
  obtain ⟨⟨⟨⟨⟨⟨ha,hb⟩,hc⟩,_⟩,_⟩,_⟩,key⟩ := guard
  simp only [address,ofModel,GuardedIndexAccess.address,GuardedIndexAccess.coordinates,
    WordRank.rank,WordRank.withinAt,key,
    member_sub d.groups checked ids.1 ha,
    member_sub d.groups checked ids.2.1 hb,
    member_sub d.groups checked ids.2.2 hc]

theorem address_bound (d : IndexOperations.Data) (checked : IndexOperations.Checked d)
    (fits : WordLimits.GroupsFit d.groups)
    (limits : WordLimits.bucketFits d.directory.blocks d.directory.total = true)
    (block : Nat) (ids : Triple)
    (guard : GuardedIndexAccess.guard d block ids = true) :
    (address (ofModel d block) ids).toNat < d.directory.total := by
  rw [address_eq d checked.groups block ids guard]
  exact GuardedIndexAccess.address_bound d checked fits limits block ids guard

theorem address_inverse (seed : Nat → Nat) (d : IndexOperations.Data)
    (checked : IndexOperations.Checked d) (fits : WordLimits.GroupsFit d.groups)
    (limits : WordLimits.bucketFits d.directory.blocks d.directory.total = true)
    (block : Nat) (ids : Triple)
    (guard : GuardedIndexAccess.guard d block ids = true) :
    IndexOperations.absolute d
      (IndexOperations.unrank seed d (address (ofModel d block) ids).toNat) = ids := by
  rw [address_eq d checked.groups block ids guard]
  exact GuardedIndexAccess.address_inverse seed d checked fits limits block ids guard

theorem checked_address_eq (d : IndexOperations.Data) (checked : GroupInventory.Checked d.groups)
    (block : Nat) (view : View) (ids : Triple)
    (accepted : check d block view = true)
    (guard : GuardedIndexAccess.guard d block ids = true) :
    address view ids = GuardedIndexAccess.address d block ids := by
  rw [check_sound d block view accepted]
  exact address_eq d checked block ids guard

end Mahjong.BlockWordAddress

#print axioms Mahjong.BlockWordAddress.member_sub
#print axioms Mahjong.BlockWordAddress.check_sound
#print axioms Mahjong.BlockWordAddress.address_eq
#print axioms Mahjong.BlockWordAddress.address_bound
#print axioms Mahjong.BlockWordAddress.address_inverse
#print axioms Mahjong.BlockWordAddress.checked_address_eq
