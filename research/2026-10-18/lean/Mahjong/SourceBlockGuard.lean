import Mahjong.BlockWordAddress

set_option autoImplicit false

namespace Mahjong.SourceBlockGuard
open GroupCandidates

structure View where
  word : BlockWordAddress.View
  sizes : Triple
  deriving DecidableEq

def ofModel (d : IndexOperations.Data) (block : Nat) : View :=
  let g := d.key block
  ⟨BlockWordAddress.ofModel d block,
    (d.groups.size g.1,d.groups.size g.2.1,d.groups.size g.2.2)⟩

def check (d : IndexOperations.Data) (block : Nat) (view : View) : Bool :=
  decide (block < d.directory.blocks ∧ view = ofModel d block)

/-- Only interval bounds and order are tested for each source proposal. The
    block key, first IDs and sizes are already checked once in the plan. -/
def guard (view : View) (ids : Triple) : Bool :=
  decide ((view.word.firstA ≤ ids.1 ∧ ids.1 < view.word.firstA+view.sizes.1) ∧
    (view.word.firstB ≤ ids.2.1 ∧ ids.2.1 < view.word.firstB+view.sizes.2.1) ∧
    (view.word.firstC ≤ ids.2.2 ∧ ids.2.2 < view.word.firstC+view.sizes.2.2) ∧
    ids.1 ≤ ids.2.1 ∧ ids.2.1 ≤ ids.2.2)

def checkAddress (view : View) (ids : Triple) (r : Nat) : Bool :=
  guard view ids && decide ((BlockWordAddress.address view.word ids).toNat = r)

theorem interval_member (d : GroupInventory.Data) (checked : GroupInventory.Checked d)
    (g i : Nat) (group : g < d.groups)
    (range : d.first g ≤ i ∧ i < d.first g+d.size g) :
    i < d.count ∧ d.group i = g := by
  have inside : i-d.first g < d.size g := by omega
  have translated := GroupInventory.coordinate_inverse d checked g (i-d.first g) group inside
  have same : d.first g+(i-d.first g) = i := by omega
  rw [same] at translated
  exact ⟨translated.1,translated.2.1⟩

theorem guard_refines (d : IndexOperations.Data) (checked : IndexOperations.Checked d)
    (block : Nat) (view : View) (ids : Triple)
    (prepared : check d block view = true) (accepted : guard view ids = true) :
    GuardedIndexAccess.guard d block ids = true := by
  simp only [check,decide_eq_true_eq] at prepared
  rcases prepared with ⟨blockBound,rfl⟩
  have facts := of_decide_eq_true accepted
  dsimp only [ofModel,BlockWordAddress.ofModel] at facts
  have row := checked.row block blockBound
  have a := interval_member d.groups checked.groups (d.key block).1 ids.1 row.1 facts.1
  have b := interval_member d.groups checked.groups (d.key block).2.1 ids.2.1 row.2.1 facts.2.1
  have c := interval_member d.groups checked.groups (d.key block).2.2 ids.2.2 row.2.2.1 facts.2.2.1
  simp only [GuardedIndexAccess.guard,Bool.and_eq_true,decide_eq_true_eq]
  exact ⟨⟨⟨⟨⟨⟨a.1,b.1⟩,c.1⟩,facts.2.2.2.1⟩,facts.2.2.2.2⟩,blockBound⟩,
    by rw [a.2,b.2,c.2]⟩

theorem word_eq (d : IndexOperations.Data) (block : Nat) (view : View)
    (prepared : check d block view = true) : view.word = BlockWordAddress.ofModel d block := by
  have h : block < d.directory.blocks ∧ view = ofModel d block := of_decide_eq_true prepared
  rw [h.2]
  rfl

theorem checkAddress_refines (d : IndexOperations.Data) (checked : IndexOperations.Checked d)
    (block : Nat) (view : View) (ids : Triple) (r : Nat)
    (prepared : check d block view = true) (accepted : checkAddress view ids r = true) :
    GuardedIndexAccess.checkAddress d block ids r = true := by
  simp only [checkAddress,Bool.and_eq_true,decide_eq_true_eq] at accepted
  have guarded := guard_refines d checked block view ids prepared accepted.1
  have address : BlockWordAddress.address view.word ids = GuardedIndexAccess.address d block ids := by
    rw [word_eq d block view prepared]
    exact BlockWordAddress.address_eq d checked.groups block ids guarded
  simp only [GuardedIndexAccess.checkAddress,Bool.and_eq_true,decide_eq_true_eq]
  exact ⟨guarded,by rw [← address]; exact accepted.2⟩

theorem inverse_at (seed : Nat → Nat) (d : IndexOperations.Data)
    (checked : IndexOperations.Checked d) (fits : WordLimits.GroupsFit d.groups)
    (limits : WordLimits.bucketFits d.directory.blocks d.directory.total = true)
    (block : Nat) (view : View) (ids : Triple) (r : Nat)
    (prepared : check d block view = true) (accepted : checkAddress view ids r = true) :
    r < d.directory.total ∧ IndexOperations.absolute d (IndexOperations.unrank seed d r) = ids :=
  GuardedIndexAccess.inverse_at seed d checked fits limits block ids r
    (checkAddress_refines d checked block view ids r prepared accepted)

end Mahjong.SourceBlockGuard

#print axioms Mahjong.SourceBlockGuard.interval_member
#print axioms Mahjong.SourceBlockGuard.guard_refines
#print axioms Mahjong.SourceBlockGuard.word_eq
#print axioms Mahjong.SourceBlockGuard.checkAddress_refines
#print axioms Mahjong.SourceBlockGuard.inverse_at
