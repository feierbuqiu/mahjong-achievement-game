import Mahjong.IndexOperations
import Mahjong.HonorDirectory

set_option autoImplicit false

namespace Mahjong.DirectoryIndex
open GroupCandidates

/-- A bucket is a contiguous slice of the previously checked honor directory. -/
def candidate (d : GroupInventory.Data) (t : TripleDirectory.Data) (u : HonorDirectory.Data)
    (p : PrefixDirectory.Data) (base : Nat) : IndexOperations.Data where
  groups := d
  directory := p
  key := fun b => t.key (u.tid (base+b))

theorem checked_slice (d : GroupInventory.Data) (t : TripleDirectory.Data) (u : HonorDirectory.Data)
    (h : PruningAlgebra.Label) (p : PrefixDirectory.Data) (base : Nat)
    (groups : GroupInventory.Checked d) (triples : TripleDirectory.Checked d t)
    (honors : HonorDirectory.Checked d t h u) (intervals : PrefixDirectory.check p = true)
    (slice : base+p.blocks ≤ u.count) (widths : ∀ b, b < p.blocks → p.size b = u.width (base+b)) :
    IndexOperations.Checked (candidate d t u p base) := by
  refine ⟨groups,intervals,?_⟩
  intro b hb
  change b < p.blocks at hb
  have row := HonorDirectory.row_facts d t h u honors (base+b) (by omega)
  have tri := (TripleDirectory.row_facts d t triples _ row.bound).1
  exact ⟨tri.1,tri.2.1,tri.2.2.1,tri.2.2.2.1,tri.2.2.2.2.1,(widths b hb).trans row.width⟩

theorem slice_keys_injective (d : GroupInventory.Data) (t : TripleDirectory.Data) (u : HonorDirectory.Data)
    (h : PruningAlgebra.Label) (p : PrefixDirectory.Data) (base : Nat)
    (triples : TripleDirectory.Checked d t) (honors : HonorDirectory.Checked d t h u)
    (slice : base+p.blocks ≤ u.count) (a b : Nat) (ha : a < p.blocks) (hb : b < p.blocks)
    (same : (candidate d t u p base).key a = (candidate d t u p base).key b) : a = b := by
  have eq := HonorDirectory.unique_rows d t h u triples honors (base+a) (base+b) (by omega) (by omega) same
  omega

theorem absolute_injective (d : IndexOperations.Data) (checked : IndexOperations.Checked d)
    (unique : ∀ a b, a < d.directory.blocks → b < d.directory.blocks → d.key a = d.key b → a = b)
    (p q : IndexOperations.Position) (vp : IndexOperations.Valid d p) (vq : IndexOperations.Valid d q)
    (same : IndexOperations.absolute d p = IndexOperations.absolute d q) : p = q := by
  have fp := IndexOperations.absolute_lookup d checked p vp
  have fq := IndexOperations.absolute_lookup d checked q vq
  have sameKey : d.key p.1 = d.key q.1 := by
    rw [← fp.2.2.2.1,← fq.2.2.2.1,same]
  have sameMember : p.2 = q.2 := by
    rw [← fp.2.2.2.2,← fq.2.2.2.2,same]
  exact Prod.ext (unique p.1 q.1 vp.1 vq.1 sameKey) sameMember

theorem decoded_ids_injective (seed : Nat → Nat) (d : IndexOperations.Data) (checked : IndexOperations.Checked d)
    (unique : ∀ a b, a < d.directory.blocks → b < d.directory.blocks → d.key a = d.key b → a = b)
    (r s : Nat) (hr : r < d.directory.total) (hs : s < d.directory.total)
    (same : IndexOperations.absolute d (IndexOperations.unrank seed d r) =
      IndexOperations.absolute d (IndexOperations.unrank seed d s)) : r = s := by
  have pr := IndexOperations.rank_unrank seed d checked r hr
  have ps := IndexOperations.rank_unrank seed d checked s hs
  have eq := absolute_injective d checked unique _ _ pr.1 ps.1 same
  rw [← pr.2,← ps.2,eq]

theorem every_valid_appears (seed : Nat → Nat) (d : IndexOperations.Data) (checked : IndexOperations.Checked d)
    (p : IndexOperations.Position) (vp : IndexOperations.Valid d p) :
    ∃ r, r < d.directory.total ∧ IndexOperations.unrank seed d r = p :=
  ⟨IndexOperations.rank d p,IndexOperations.rank_bound d checked p vp,IndexOperations.unrank_rank seed d checked p vp⟩

end Mahjong.DirectoryIndex

#print axioms Mahjong.DirectoryIndex.checked_slice
#print axioms Mahjong.DirectoryIndex.slice_keys_injective
#print axioms Mahjong.DirectoryIndex.absolute_injective
#print axioms Mahjong.DirectoryIndex.decoded_ids_injective
#print axioms Mahjong.DirectoryIndex.every_valid_appears
