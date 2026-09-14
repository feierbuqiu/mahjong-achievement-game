import Mahjong.GlobalOrbitUniqueness
import Mahjong.DirectoryCoverage

set_option autoImplicit false

namespace Mahjong.GlobalOrbitDirectory
open CanonicalCoverage CanonicalInventory LocalCacheEncoding Base5Coverage PackedRules
open GlobalOrbitKey GlobalOrbitUniqueness GroupedCoverage GroupCandidates

theorem numbered_representative (t : Inventories) (checked : CanonicalCoverage.Checked t)
    (shared : SortedCoverage.SharedMembers t) (d : GroupInventory.Data) (raw : Nat → ByteArray)
    (link : Link d t raw) (s : State) (valid : Valid s)
    (block : NumberedBlock d (t 3) (PruningData.rawLabel (raw 3)) s) : Representative t s := by
  have num (i : Nat) (hi : i < d.count) : (t 0).id (d.retained i) = i := by
    rw [link.members]
    exact (checked_member 0 (t 0) (checked 0 (by decide)) i (by rwa [← link.count])).2
  have i := num block.i block.i_bound
  have j := num block.j block.j_bound
  have k := num block.k block.k_bound
  refine ⟨valid,?_,?_,?_⟩
  · intro b hb
    have options : b = 0 ∨ b = 1 ∨ b = 2 ∨ b = 3 := by omega
    rcases options with rfl | rfl | rfl | rfl
    · exact ⟨block.i,by rw [← link.count]; exact block.i_bound,by rw [← link.members]; exact block.i_code⟩
    · rw [(shared 1 (by decide)).1,(shared 1 (by decide)).2]
      exact ⟨block.j,by rw [← link.count]; exact block.j_bound,by rw [← link.members]; exact block.j_code⟩
    · rw [(shared 2 (by decide)).1,(shared 2 (by decide)).2]
      exact ⟨block.k,by rw [← link.count]; exact block.k_bound,by rw [← link.members]; exact block.k_code⟩
    · exact ⟨block.h,block.h_bound,block.h_code⟩
  · rw [← block.i_code,← block.j_code,i,j]
    exact block.ij
  · rw [← block.j_code,← block.k_code,j,k]
    exact block.jk

def stateIds (t : Inventories) (s : State) : Packed :=
  ⟨(t 0).id (encodeBlock 0 s),(t 0).id (encodeBlock 1 s),
    (t 0).id (encodeBlock 2 s),(t 3).id (encodeBlock 3 s)⟩

theorem numbered_ids (t : Inventories) (checked : CanonicalCoverage.Checked t)
    (d : GroupInventory.Data) (raw : Nat → ByteArray) (link : Link d t raw)
    (s : State) (block : NumberedBlock d (t 3) (PruningData.rawLabel (raw 3)) s) :
    stateIds t s = ⟨block.i,block.j,block.k,block.h⟩ := by
  have num (i : Nat) (hi : i < d.count) : (t 0).id (d.retained i) = i := by
    rw [link.members]
    exact (checked_member 0 (t 0) (checked 0 (by decide)) i (by rwa [← link.count])).2
  have hon := (checked_member 3 (t 3) (checked 3 (by decide)) block.h block.h_bound).2
  simp only [stateIds,← block.i_code,← block.j_code,← block.k_code,← block.h_code,
    num block.i block.i_bound,num block.j block.j_bound,num block.k block.k_bound,hon]

theorem numbered_same_orbit_ids (t : Inventories) (checked : CanonicalCoverage.Checked t)
    (sizes : CanonicalCoverage.ProperSizes t) (members : SortedCoverage.SharedMembers t) (keys : SharedKeys t)
    (d : GroupInventory.Data) (raw : Nat → ByteArray) (link : Link d t raw)
    (s r : State) (vs : Valid s) (vr : Valid r)
    (a : NumberedBlock d (t 3) (PruningData.rawLabel (raw 3)) s)
    (b : NumberedBlock d (t 3) (PruningData.rawLabel (raw 3)) r) (orbit : SameOrbit s r) :
    (Packed.mk a.i a.j a.k a.h) = ⟨b.i,b.j,b.k,b.h⟩ := by
  have eq := representatives_in_same_orbit_equal t checked sizes keys s r
    (numbered_representative t checked members d raw link s vs a)
    (numbered_representative t checked members d raw link r vr b) orbit
  rw [← numbered_ids t checked d raw link s a,← numbered_ids t checked d raw link r b,eq]

structure Entry (v : Inventories) (d : GroupInventory.Data) (raw : Nat → ByteArray)
    (t : TripleDirectory.Data) (u : Nat → HonorDirectory.Data) where
  state : State
  valid : Valid state
  safe : IsSafe state
  block : NumberedBlock d (v 3) (PruningData.rawLabel (raw 3)) state
  row : Nat
  inside : row < (u block.h).count
  rowKey : t.key ((u block.h).tid row) = (d.group block.i,d.group block.j,d.group block.k)
  layer : (u block.h).layer row = total state

def address {v : Inventories} {d : GroupInventory.Data} {raw : Nat → ByteArray}
    {t : TripleDirectory.Data} {u : Nat → HonorDirectory.Data} (e : Entry v d raw t u) : Nat × Nat × Nat :=
  (e.block.h,e.row,WeightedBlocks.rank d (d.group e.block.i) (d.group e.block.j) (d.group e.block.k)
    (d.member e.block.i) (d.member e.block.j) (d.member e.block.k))

theorem entry_address_bound {v : Inventories} {d : GroupInventory.Data} {raw : Nat → ByteArray}
    {t : TripleDirectory.Data} {u : Nat → HonorDirectory.Data} (e : Entry v d raw t u)
    (directories : ∀ h, h < (v 3).count →
      HonorDirectory.Checked d t (PruningData.rawLabel (raw 3) ((v 3).member h)) (u h)) :
    (address e).1 < (v 3).count ∧ (address e).2.1 < (u (address e).1).count ∧
      (address e).2.2 < (u (address e).1).width (address e).2.1 := by
  have f := HonorDirectory.row_facts d t _ (u e.block.h) (directories e.block.h e.block.h_bound) e.row e.inside
  have width := f.width
  rw [e.rowKey] at width
  exact ⟨e.block.h_bound,e.inside,by dsimp only [address]; rw [width]; exact e.block.rank_bound⟩

theorem same_orbit_same_address (v : Inventories) (checked : CanonicalCoverage.Checked v)
    (sizes : CanonicalCoverage.ProperSizes v) (members : SortedCoverage.SharedMembers v) (keys : SharedKeys v)
    (d : GroupInventory.Data) (raw : Nat → ByteArray) (link : Link d v raw)
    (t : TripleDirectory.Data) (u : Nat → HonorDirectory.Data) (triples : TripleDirectory.Checked d t)
    (directories : ∀ h, h < (v 3).count →
      HonorDirectory.Checked d t (PruningData.rawLabel (raw 3) ((v 3).member h)) (u h))
    (a b : Entry v d raw t u) (orbit : SameOrbit a.state b.state) : address a = address b := by
  have ids := numbered_same_orbit_ids v checked sizes members keys d raw link a.state b.state a.valid b.valid a.block b.block orbit
  have ei := congrArg Packed.a ids
  have ej := congrArg Packed.b ids
  have ek := congrArg Packed.c ids
  have eh := congrArg Packed.h ids
  dsimp only at ei ej ek eh
  have bInside : b.row < (u a.block.h).count := by rw [eh]; exact b.inside
  have bKey : t.key ((u a.block.h).tid b.row) = (d.group b.block.i,d.group b.block.j,d.group b.block.k) := by
    rw [eh]; exact b.rowKey
  have rowEq := HonorDirectory.unique_rows d t _ (u a.block.h) triples (directories a.block.h a.block.h_bound)
    a.row b.row a.inside bInside (by rw [a.rowKey,bKey,ei,ej,ek])
  simp only [address,ei,ej,ek,eh,rowEq]

theorem every_safe_has_entry (core summary raw ids members : Nat → ByteArray)
    (coreSizes : Base5Coverage.ProperSizes core)
    (safeChecked : FullSafeData.Checked (Base5Coverage.tables core summary raw))
    (inventorySizes : CanonicalCoverage.ProperSizes (inventories raw ids members))
    (inventoryChecked : CanonicalCoverage.Checked (inventories raw ids members))
    (shared : SortedCoverage.SharedMembers (inventories raw ids members))
    (d : GroupInventory.Data) (groupChecked : GroupInventory.Checked d) (link : Link d (inventories raw ids members) raw)
    (num hon two three four : SafeLayerBound.Envelope) (localBound : SafeLayerBound.RawChecked num hon raw)
    (c2 : SafeLayerBound.checkJoin num num two = true) (c3 : SafeLayerBound.checkJoin two num three = true)
    (c4 : SafeLayerBound.checkJoin three hon four = true) (last : SafeLayerBound.checkFinal four 34 = true)
    (t : TripleDirectory.Data) (u : Nat → HonorDirectory.Data) (triples : TripleDirectory.Checked d t)
    (directories : ∀ h, h < (inventories raw ids members 3).count →
      HonorDirectory.Checked d t (PruningData.rawLabel (raw 3) ((inventories raw ids members 3).member h)) (u h))
    (s : State) (valid : Valid s) (safe : IsSafe s) :
    ∃ e : Entry (inventories raw ids members) d raw t u, SameOrbit s e.state := by
  obtain ⟨r,path,h,row,vr,sr,eq,_,_,inside,layer,block,bh,rowKey,_⟩ :=
    DirectoryCoverage.original_safe_has_actual_entry core summary raw ids members coreSizes safeChecked
      inventorySizes inventoryChecked shared d groupChecked link num hon two three four localBound c2 c3 c4 last
      t u triples directories s valid safe
  let e : Entry (inventories raw ids members) d raw t u :=
    ⟨r,vr,sr,block,row,by rw [bh]; exact inside,by rw [bh]; exact rowKey,by rw [bh]; exact layer⟩
  exact ⟨e,path,eq⟩

theorem every_safe_has_unique_directory_address (core summary raw ids members : Nat → ByteArray)
    (coreSizes : Base5Coverage.ProperSizes core)
    (safeChecked : FullSafeData.Checked (Base5Coverage.tables core summary raw))
    (inventorySizes : CanonicalCoverage.ProperSizes (inventories raw ids members))
    (inventoryChecked : CanonicalCoverage.Checked (inventories raw ids members))
    (shared : SortedCoverage.SharedMembers (inventories raw ids members))
    (keys : SharedKeys (inventories raw ids members))
    (d : GroupInventory.Data) (groupChecked : GroupInventory.Checked d) (link : Link d (inventories raw ids members) raw)
    (num hon two three four : SafeLayerBound.Envelope) (localBound : SafeLayerBound.RawChecked num hon raw)
    (c2 : SafeLayerBound.checkJoin num num two = true) (c3 : SafeLayerBound.checkJoin two num three = true)
    (c4 : SafeLayerBound.checkJoin three hon four = true) (last : SafeLayerBound.checkFinal four 34 = true)
    (t : TripleDirectory.Data) (u : Nat → HonorDirectory.Data) (triples : TripleDirectory.Checked d t)
    (directories : ∀ h, h < (inventories raw ids members 3).count →
      HonorDirectory.Checked d t (PruningData.rawLabel (raw 3) ((inventories raw ids members 3).member h)) (u h))
    (s : State) (valid : Valid s) (safe : IsSafe s) :
    ∃ e : Entry (inventories raw ids members) d raw t u, SameOrbit s e.state ∧
      ∀ f : Entry (inventories raw ids members) d raw t u, SameOrbit s f.state → address f = address e := by
  obtain ⟨e,orbit⟩ := every_safe_has_entry core summary raw ids members coreSizes safeChecked inventorySizes
    inventoryChecked shared d groupChecked link num hon two three four localBound c2 c3 c4 last t u triples directories s valid safe
  refine ⟨e,orbit,?_⟩
  intro f same
  exact same_orbit_same_address _ inventoryChecked inventorySizes shared keys d raw link t u triples directories f e
    (sameOrbit_trans f.state s e.state (sameOrbit_symm s f.state same) orbit)

end Mahjong.GlobalOrbitDirectory

#print axioms Mahjong.GlobalOrbitDirectory.numbered_representative
#print axioms Mahjong.GlobalOrbitDirectory.numbered_ids
#print axioms Mahjong.GlobalOrbitDirectory.numbered_same_orbit_ids
#print axioms Mahjong.GlobalOrbitDirectory.entry_address_bound
#print axioms Mahjong.GlobalOrbitDirectory.same_orbit_same_address
#print axioms Mahjong.GlobalOrbitDirectory.every_safe_has_entry
#print axioms Mahjong.GlobalOrbitDirectory.every_safe_has_unique_directory_address
