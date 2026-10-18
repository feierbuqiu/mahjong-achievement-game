import Mahjong.GroupedCoverage
import Mahjong.HonorDirectory

set_option autoImplicit false

namespace Mahjong.DirectoryCoverage
open GroupedCoverage CanonicalInventory CanonicalCoverage PruningAlgebra

theorem numbered_block_has_actual_row (d : GroupInventory.Data) (hon : CanonicalInventory.Candidate)
    (rawH : Nat → Label) (s : State) (block : NumberedBlock d hon rawH s)
    (t : TripleDirectory.Data) (u : HonorDirectory.Data)
    (triples : TripleDirectory.Checked d t)
    (directory : HonorDirectory.Checked d t (rawH (hon.member block.h)) u) :
    ∃ row, row < u.count ∧ u.layer row = total s ∧
      t.key (u.tid row) = (d.group block.i,d.group block.j,d.group block.k) ∧
      WeightedBlocks.rank d (d.group block.i) (d.group block.j) (d.group block.k)
        (d.member block.i) (d.member block.j) (d.member block.k) < u.width row := by
  obtain ⟨row,inside,key,layer⟩ := (HonorDirectory.actual_iff_bucket d t (rawH (hon.member block.h)) u
    triples directory _ _ _ _).mpr block.present
  have width := (HonorDirectory.row_facts d t _ u directory row inside).width
  rw [key] at width
  exact ⟨row,inside,layer,key,by rw [width]; exact block.rank_bound⟩

/-- Original SAFE states reach an actual directory entry, using only finite
local and directory checks. This theorem says nothing about old P/N bit values. -/
theorem original_safe_has_actual_entry (core summary raw ids members : Nat → ByteArray)
    (coreSizes : Base5Coverage.ProperSizes core)
    (safeChecked : FullSafeData.Checked (Base5Coverage.tables core summary raw))
    (inventorySizes : CanonicalCoverage.ProperSizes (inventories raw ids members))
    (inventoryChecked : CanonicalCoverage.Checked (inventories raw ids members))
    (shared : SortedCoverage.SharedMembers (inventories raw ids members))
    (d : GroupInventory.Data) (groupChecked : GroupInventory.Checked d) (link : Link d (inventories raw ids members) raw)
    (num hon two three four : SafeLayerBound.Envelope)
    (localBound : SafeLayerBound.RawChecked num hon raw)
    (c2 : SafeLayerBound.checkJoin num num two = true) (c3 : SafeLayerBound.checkJoin two num three = true)
    (c4 : SafeLayerBound.checkJoin three hon four = true) (last : SafeLayerBound.checkFinal four 34 = true)
    (t : TripleDirectory.Data) (u : Nat → HonorDirectory.Data) (triples : TripleDirectory.Checked d t)
    (directories : ∀ h, h < (inventories raw ids members 3).count →
      HonorDirectory.Checked d t (PruningData.rawLabel (raw 3) ((inventories raw ids members 3).member h)) (u h))
    (s : State) (valid : Valid s) (safe : IsSafe s) :
    ∃ r : State, ∃ path : List Generators.Generator, ∃ h row,
      Valid r ∧ IsSafe r ∧ r = Generators.applyPath path s ∧ total r ≤ 34 ∧
      h < (inventories raw ids members 3).count ∧ row < (u h).count ∧ (u h).layer row = total r ∧
      ∃ block : NumberedBlock d (inventories raw ids members 3) (PruningData.rawLabel (raw 3)) r,
        block.h = h ∧ t.key ((u h).tid row) = (d.group block.i,d.group block.j,d.group block.k) ∧
        WeightedBlocks.rank d (d.group block.i) (d.group block.j) (d.group block.k)
          (d.member block.i) (d.member block.j) (d.member block.k) < (u h).width row := by
  obtain ⟨r,path,vr,sr,eq,bound,⟨block⟩⟩ := original_safe_has_numbered_block core summary raw ids members
    coreSizes safeChecked inventorySizes inventoryChecked shared d groupChecked link num hon two three four
    localBound c2 c3 c4 last s valid safe
  obtain ⟨row,inside,layer,key,rank⟩ := numbered_block_has_actual_row d _ _ r block t (u block.h) triples
    (directories block.h block.h_bound)
  exact ⟨r,path,block.h,row,vr,sr,eq,bound,block.h_bound,inside,layer,block,rfl,key,rank⟩

end Mahjong.DirectoryCoverage

#print axioms Mahjong.DirectoryCoverage.numbered_block_has_actual_row
#print axioms Mahjong.DirectoryCoverage.original_safe_has_actual_entry
