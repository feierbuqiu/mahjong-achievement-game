import Mahjong.IndexDecoder
import Mahjong.AbsoluteCursor
import Mahjong.PrefixCursor

set_option autoImplicit false

namespace Mahjong.IndexOperations
open GroupCandidates

structure Data where
  groups : GroupInventory.Data
  directory : PrefixDirectory.Data
  key : Nat → Triple

structure Checked (d : Data) : Prop where
  groups : GroupInventory.Checked d.groups
  intervals : PrefixDirectory.check d.directory = true
  row : ∀ b, b < d.directory.blocks →
    (d.key b).1 < d.groups.groups ∧ (d.key b).2.1 < d.groups.groups ∧
    (d.key b).2.2 < d.groups.groups ∧ (d.key b).1 ≤ (d.key b).2.1 ∧
    (d.key b).2.1 ≤ (d.key b).2.2 ∧
    d.directory.size b = WeightedBlocks.size d.groups (d.key b).1 (d.key b).2.1 (d.key b).2.2

abbrev Position := Nat × Triple

def Valid (d : Data) (p : Position) : Prop :=
  p.1 < d.directory.blocks ∧ Coordinates d.groups (d.key p.1).1 (d.key p.1).2.1
    (d.key p.1).2.2 p.2.1 p.2.2.1 p.2.2.2

def within (d : Data) (p : Position) : Nat :=
  WeightedBlocks.rank d.groups (d.key p.1).1 (d.key p.1).2.1 (d.key p.1).2.2 p.2.1 p.2.2.1 p.2.2.2

def rank (d : Data) (p : Position) : Nat := d.directory.offset p.1+within d p

def unrank (seed : Nat → Nat) (d : Data) (r : Nat) : Position :=
  let p := IndexLocate.locate d.directory r
  (p.1,IndexDecoder.decode seed d.groups (d.key p.1).1 (d.key p.1).2.1 (d.key p.1).2.2 p.2)

theorem within_bound (d : Data) (checked : Checked d) (p : Position) (valid : Valid d p) :
    within d p < d.directory.size p.1 := by
  have f := checked.row p.1 valid.1
  rw [f.2.2.2.2.2]
  exact WeightedBlocks.rank_bound _ _ _ _ _ _ _ f.2.2.2.1 f.2.2.2.2.1 valid.2

theorem rank_bound (d : Data) (checked : Checked d) (p : Position) (valid : Valid d p) :
    rank d p < d.directory.total :=
  PrefixDirectory.address_bound _ checked.intervals p.1 (within d p) valid.1 (within_bound d checked p valid)

theorem rank_unrank (seed : Nat → Nat) (d : Data) (checked : Checked d) (r : Nat)
    (inside : r < d.directory.total) :
    Valid d (unrank seed d r) ∧ rank d (unrank seed d r) = r := by
  have p := IndexLocate.address_locate d.directory checked.intervals r inside
  have f := checked.row (IndexLocate.locate d.directory r).1 p.1
  have decoded := IndexDecoder.decode_correct seed d.groups checked.groups _ _ _ _ f.1 f.2.1 f.2.2.1
    f.2.2.2.1 f.2.2.2.2.1 (by rw [← f.2.2.2.2.2]; exact p.2.1)
  refine ⟨⟨p.1,decoded.1⟩,?_⟩
  simp only [rank,within,unrank]
  rw [decoded.2]
  exact p.2.2

theorem rank_injective (d : Data) (checked : Checked d) (p q : Position)
    (vp : Valid d p) (vq : Valid d q) (eq : rank d p = rank d q) : p = q := by
  have rows := PrefixDirectory.address_injective _ checked.intervals p.1 q.1 (within d p) (within d q)
    vp.1 vq.1 (within_bound d checked p vp) (within_bound d checked q vq) eq
  rcases p with ⟨b,x,y,z⟩
  rcases q with ⟨c,u,v,w⟩
  dsimp only at rows vp vq
  have same : b = c := rows.1
  subst c
  have f := checked.row b vp.1
  have coords := WeightedBlocks.rank_injective _ _ _ _ x y z u v w f.2.2.2.1 f.2.2.2.2.1
    vp.2 vq.2 rows.2
  exact Prod.ext rfl (Prod.ext coords.1 (Prod.ext coords.2.1 coords.2.2))

theorem unrank_rank (seed : Nat → Nat) (d : Data) (checked : Checked d)
    (p : Position) (valid : Valid d p) : unrank seed d (rank d p) = p := by
  have q := rank_unrank seed d checked (rank d p) (rank_bound d checked p valid)
  exact rank_injective d checked _ p q.1 valid q.2

def absolute (d : Data) (p : Position) : Triple :=
  AbsoluteCursor.absolute d.groups (d.key p.1).1 (d.key p.1).2.1 (d.key p.1).2.2 p.2

theorem absolute_lookup (d : Data) (checked : Checked d) (p : Position) (valid : Valid d p) :
    let q := absolute d p
    q.1 < d.groups.count ∧ q.2.1 < d.groups.count ∧ q.2.2 < d.groups.count ∧
    (d.groups.group q.1,d.groups.group q.2.1,d.groups.group q.2.2) = d.key p.1 ∧
    (d.groups.member q.1,d.groups.member q.2.1,d.groups.member q.2.2) = p.2 := by
  have f := checked.row p.1 valid.1
  have x := GroupInventory.coordinate_inverse d.groups checked.groups _ _ f.1 valid.2.1
  have y := GroupInventory.coordinate_inverse d.groups checked.groups _ _ f.2.1 valid.2.2.1
  have z := GroupInventory.coordinate_inverse d.groups checked.groups _ _ f.2.2.1 valid.2.2.2.1
  exact ⟨x.1,y.1,z.1,Prod.ext x.2.1 (Prod.ext y.2.1 z.2.1),
    Prod.ext x.2.2 (Prod.ext y.2.2 z.2.2)⟩

end Mahjong.IndexOperations

#print axioms Mahjong.IndexOperations.rank_bound
#print axioms Mahjong.IndexOperations.rank_unrank
#print axioms Mahjong.IndexOperations.rank_injective
#print axioms Mahjong.IndexOperations.unrank_rank
#print axioms Mahjong.IndexOperations.absolute_lookup
