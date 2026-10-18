import Mahjong.WordRank
import Mahjong.PrefixData

set_option autoImplicit false

namespace Mahjong.GuardedIndexAccess
open CanonicalInventory GroupCandidates

/-- The actual 32-byte bucket directory: offset, width, three group IDs, tid.
The tid is not used for addressing. Every address interval is checked once. -/
def model (groups : GroupInventory.Data) (bytes : ByteArray) (total : Nat) : IndexOperations.Data where
  groups := groups
  directory := {
    blocks := bytes.size / 32
    total := total
    offset := fun b => PrefixData.read64 bytes (32*b)
    size := fun b => PrefixData.read64 bytes (32*b+8) }
  key := fun b => (read32 bytes (32*b+16),read32 bytes (32*b+20),read32 bytes (32*b+24))

def checkRow (d : IndexOperations.Data) (b : Nat) : Bool :=
  let g := d.key b
  decide (g.1 < d.groups.groups) && decide (g.2.1 < d.groups.groups) &&
  decide (g.2.2 < d.groups.groups) && decide (g.1 ≤ g.2.1) && decide (g.2.1 ≤ g.2.2) &&
  decide (d.directory.size b = WeightedBlocks.size d.groups g.1 g.2.1 g.2.2)

def check (d : IndexOperations.Data) : Bool :=
  PrefixDirectory.check d.directory && checkSpan (checkRow d) 0 d.directory.blocks

theorem checked (d : IndexOperations.Data) (groups : GroupInventory.Checked d.groups)
    (accepted : check d = true) : IndexOperations.Checked d := by
  simp only [check,Bool.and_eq_true] at accepted
  refine ⟨groups,accepted.1,?_⟩
  intro b hb
  have row := checkSpan_each (checkRow d) d.directory.blocks 0 accepted.2 b hb
  simpa only [Nat.zero_add,checkRow,Bool.and_eq_true,decide_eq_true_eq,and_assoc] using row

def coordinates (d : IndexOperations.Data) (b : Nat) (ids : Triple) : IndexOperations.Position :=
  (b,(d.groups.member ids.1,d.groups.member ids.2.1,d.groups.member ids.2.2))

/-- A proposed block is untrusted. Checking its key and the three sorted local
IDs is enough; there is no per-access inverse decoder or physical state. -/
def guard (d : IndexOperations.Data) (b : Nat) (ids : Triple) : Bool :=
  decide (ids.1 < d.groups.count) && decide (ids.2.1 < d.groups.count) &&
  decide (ids.2.2 < d.groups.count) && decide (ids.1 ≤ ids.2.1) && decide (ids.2.1 ≤ ids.2.2) &&
  decide (b < d.directory.blocks) &&
  decide (d.key b = (d.groups.group ids.1,d.groups.group ids.2.1,d.groups.group ids.2.2))

theorem guard_valid (d : IndexOperations.Data) (h : IndexOperations.Checked d)
    (b : Nat) (ids : Triple) (accepted : guard d b ids = true) :
    IndexOperations.Valid d (coordinates d b ids) := by
  simp only [guard,Bool.and_eq_true,decide_eq_true_eq] at accepted
  obtain ⟨⟨⟨⟨⟨⟨a,bb⟩,c⟩,ab⟩,bc⟩,bound⟩,key⟩ := accepted
  refine ⟨bound,?_⟩
  have coords := member_coordinates d.groups h.groups ids.1 ids.2.1 ids.2.2 a bb c ab bc
  simpa only [coordinates,key] using coords

theorem guard_absolute (d : IndexOperations.Data) (h : IndexOperations.Checked d)
    (b : Nat) (ids : Triple) (accepted : guard d b ids = true) :
    IndexOperations.absolute d (coordinates d b ids) = ids := by
  simp only [guard,Bool.and_eq_true,decide_eq_true_eq] at accepted
  obtain ⟨⟨⟨⟨⟨⟨a,bb⟩,c⟩,_⟩,_⟩,_⟩,key⟩ := accepted
  have aa := (GroupInventory.member_facts d.groups h.groups ids.1 a).offset
  have bbb := (GroupInventory.member_facts d.groups h.groups ids.2.1 bb).offset
  have cc := (GroupInventory.member_facts d.groups h.groups ids.2.2 c).offset
  simp only [IndexOperations.absolute,coordinates,AbsoluteCursor.absolute,key]
  exact Prod.ext aa.symm (Prod.ext bbb.symm cc.symm)

def address (d : IndexOperations.Data) (b : Nat) (ids : Triple) : UInt64 :=
  WordRank.rank d (coordinates d b ids)

theorem address_bound (d : IndexOperations.Data) (h : IndexOperations.Checked d)
    (fits : WordLimits.GroupsFit d.groups)
    (limits : WordLimits.bucketFits d.directory.blocks d.directory.total = true)
    (b : Nat) (ids : Triple) (accepted : guard d b ids = true) :
    (address d b ids).toNat < d.directory.total := by
  have valid := guard_valid d h b ids accepted
  rw [address,WordRank.rank_correct d h fits limits _ valid]
  exact IndexOperations.rank_bound d h _ valid

/-- Replaces unrank(rank(ids)) = ids by the small guard. The inverse decoder
appears only in the theorem and is erased from the executable access path. -/
theorem address_inverse (seed : Nat → Nat) (d : IndexOperations.Data) (h : IndexOperations.Checked d)
    (fits : WordLimits.GroupsFit d.groups)
    (limits : WordLimits.bucketFits d.directory.blocks d.directory.total = true)
    (b : Nat) (ids : Triple) (accepted : guard d b ids = true) :
    IndexOperations.absolute d (IndexOperations.unrank seed d (address d b ids).toNat) = ids := by
  have valid := guard_valid d h b ids accepted
  rw [address,WordRank.rank_correct d h fits limits _ valid,
    IndexOperations.unrank_rank seed d h _ valid]
  exact guard_absolute d h b ids accepted

def checkAddress (d : IndexOperations.Data) (b : Nat) (ids : Triple) (r : Nat) : Bool :=
  guard d b ids && decide ((address d b ids).toNat = r)

/-- Even an untrusted producer of source IDs is sufficient: the checked
address ties the visited row to the proved enumeration, without decoding twice. -/
theorem inverse_at (seed : Nat → Nat) (d : IndexOperations.Data) (h : IndexOperations.Checked d)
    (fits : WordLimits.GroupsFit d.groups)
    (limits : WordLimits.bucketFits d.directory.blocks d.directory.total = true)
    (b : Nat) (ids : Triple) (r : Nat) (accepted : checkAddress d b ids r = true) :
    r < d.directory.total ∧
    IndexOperations.absolute d (IndexOperations.unrank seed d r) = ids := by
  simp only [checkAddress,Bool.and_eq_true,decide_eq_true_eq] at accepted
  rw [← accepted.2]
  exact ⟨address_bound d h fits limits b ids accepted.1,
    address_inverse seed d h fits limits b ids accepted.1⟩

end Mahjong.GuardedIndexAccess

#print axioms Mahjong.GuardedIndexAccess.checked
#print axioms Mahjong.GuardedIndexAccess.guard_valid
#print axioms Mahjong.GuardedIndexAccess.guard_absolute
#print axioms Mahjong.GuardedIndexAccess.address_bound
#print axioms Mahjong.GuardedIndexAccess.address_inverse
#print axioms Mahjong.GuardedIndexAccess.inverse_at
