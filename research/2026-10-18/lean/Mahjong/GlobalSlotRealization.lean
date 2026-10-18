import Mahjong.IndexedPhysical

set_option autoImplicit false

namespace Mahjong.GlobalSlotRealization
open CanonicalCoverage GroupedCoverage GroupCandidates GlobalOrbitDirectory
open PruningAlgebra GlobalOrbitUniqueness

def ValidAddress (v : Inventories) (u : Nat → HonorDirectory.Data) (a : Nat × Nat × Nat) : Prop :=
  a.1 < (v 3).count ∧ a.2.1 < (u a.1).count ∧ a.2.2 < (u a.1).width a.2.1

theorem realize_coordinates (v : Inventories) (checked : CanonicalCoverage.Checked v)
    (shared : SortedCoverage.SharedMembers v) (d : GroupInventory.Data) (groups : GroupInventory.Checked d)
    (core summary raw : Nat → ByteArray) (link : Link d v raw)
    (coreSizes : Base5Coverage.ProperSizes core) (safeChecked : FullSafeData.Checked (Base5Coverage.tables core summary raw))
    (t : TripleDirectory.Data) (u : Nat → HonorDirectory.Data) (triples : TripleDirectory.Checked d t)
    (h row : Nat) (hh : h < (v 3).count) (hr : row < (u h).count)
    (directory : HonorDirectory.Checked d t (PruningData.rawLabel (raw 3) ((v 3).member h)) (u h))
    (a b c x y z : Nat) (key : t.key ((u h).tid row) = (a,b,c)) (coords : Coordinates d a b c x y z) :
    ∃ e : Entry v d raw t u, address e = (h,row,WeightedBlocks.rank d a b c x y z) := by
  let n := (u h).layer row
  let hl := PruningData.rawLabel (raw 3) ((v 3).member h)
  have present : (a,b,c) ∈ bucket d hl n :=
    (HonorDirectory.actual_iff_bucket d t hl (u h) triples directory a b c n).mp ⟨row,hr,key,rfl⟩
  have f := (mem_bucket d hl n a b c).mp present
  let i := d.first a+x
  let j := d.first b+y
  let k := d.first c+z
  have ci := GroupInventory.coordinate_inverse d groups a x f.1 coords.1
  have cj := GroupInventory.coordinate_inverse d groups b y f.2.1 coords.2.1
  have ck := GroupInventory.coordinate_inverse d groups c z f.2.2.1 coords.2.2.1
  have order := coordinate_order d groups a b c x y z f.1 f.2.1 f.2.2.1 f.2.2.2.1 f.2.2.2.2.1 coords
  let s := IndexedPhysical.state v d i j k h
  have semantic : fullSafe (IndexedPhysical.label v d raw i j k h) :=
    bucket_coordinates_safe d groups hl n a b c x y z present coords
  have safe : IsSafe s := IndexedPhysical.state_safe v checked shared d core summary raw link coreSizes safeChecked
    i j k h ci.1 cj.1 ck.1 hh semantic
  have tiles := IndexedPhysical.state_tiles v checked shared d core summary raw link coreSizes safeChecked
    i j k h ci.1 cj.1 ck.1 hh
  have joined : IndexedPhysical.label v d raw i j k h = join (three d (a,b,c)) hl := by
    unfold IndexedPhysical.label
    rw [GroupInventory.group_label_at_coordinate d groups a x f.1 coords.1,
      GroupInventory.group_label_at_coordinate d groups b y f.2.1 coords.2.1,
      GroupInventory.group_label_at_coordinate d groups c z f.2.2.1 coords.2.2.1]
    rfl
  have ns : n = total s := by rw [joined,f.2.2.2.2.2.2] at tiles; exact tiles
  let block : NumberedBlock d (v 3) (PruningData.rawLabel (raw 3)) s := {
    i:=i,j:=j,k:=k,h:=h,i_bound:=ci.1,j_bound:=cj.1,k_bound:=ck.1,h_bound:=hh,
    ij:=order.1,jk:=order.2,
    i_code:=(IndexedPhysical.state_encoded v checked shared d raw link i j k h ci.1 cj.1 ck.1 hh 0 (by decide)).symm,
    j_code:=(IndexedPhysical.state_encoded v checked shared d raw link i j k h ci.1 cj.1 ck.1 hh 1 (by decide)).symm,
    k_code:=(IndexedPhysical.state_encoded v checked shared d raw link i j k h ci.1 cj.1 ck.1 hh 2 (by decide)).symm,
    h_code:=(IndexedPhysical.state_encoded v checked shared d raw link i j k h ci.1 cj.1 ck.1 hh 3 (by decide)).symm,
    present:=by change (d.group i,d.group j,d.group k) ∈ bucket d hl (total s)
                rw [ci.2.1,cj.2.1,ck.2.1,← ns]; exact present,
    rank_bound:=by
      change WeightedBlocks.rank d (d.group i) (d.group j) (d.group k) (d.member i) (d.member j) (d.member k) <
        WeightedBlocks.size d (d.group i) (d.group j) (d.group k)
      rw [ci.2.1,cj.2.1,ck.2.1,ci.2.2,cj.2.2,ck.2.2]
      exact WeightedBlocks.rank_bound d a b c x y z f.2.2.2.1 f.2.2.2.2.1 coords }
  let entry : Entry v d raw t u := {
    state:=s,valid:=IndexedPhysical.unpack_valid _,safe:=safe,block:=block,row:=row,inside:=hr,
    rowKey:=by change t.key ((u h).tid row) = (d.group i,d.group j,d.group k)
               rw [ci.2.1,cj.2.1,ck.2.1]; exact key,
    layer:=ns }
  refine ⟨entry,?_⟩
  change (h,row,WeightedBlocks.rank d (d.group i) (d.group j) (d.group k) (d.member i) (d.member j) (d.member k)) = _
  rw [ci.2.1,cj.2.1,ck.2.1,ci.2.2,cj.2.2,ck.2.2]

theorem every_valid_address_realized (v : Inventories) (checked : CanonicalCoverage.Checked v)
    (shared : SortedCoverage.SharedMembers v) (d : GroupInventory.Data) (groups : GroupInventory.Checked d)
    (core summary raw : Nat → ByteArray) (link : Link d v raw)
    (coreSizes : Base5Coverage.ProperSizes core) (safeChecked : FullSafeData.Checked (Base5Coverage.tables core summary raw))
    (t : TripleDirectory.Data) (u : Nat → HonorDirectory.Data) (triples : TripleDirectory.Checked d t)
    (directories : ∀ h, h < (v 3).count →
      HonorDirectory.Checked d t (PruningData.rawLabel (raw 3) ((v 3).member h)) (u h))
    (a : Nat × Nat × Nat) (valid : ValidAddress v u a) : ∃ e : Entry v d raw t u, address e = a := by
  have dir := directories a.1 valid.1
  have row := HonorDirectory.row_facts d t _ (u a.1) dir a.2.1 valid.2.1
  have tri := (TripleDirectory.row_facts d t triples _ row.bound).1
  let g := t.key ((u a.1).tid a.2.1)
  let q := IndexDecoder.decode (fun _ => 0) d g.1 g.2.1 g.2.2 a.2.2
  have decoded := IndexDecoder.decode_correct (fun _ => 0) d groups g.1 g.2.1 g.2.2 a.2.2
    tri.1 tri.2.1 tri.2.2.1 tri.2.2.2.1 tri.2.2.2.2.1 (by rw [← row.width]; exact valid.2.2)
  have eta : g = (g.1,g.2.1,g.2.2) := by cases g with |mk x yz => cases yz; rfl
  obtain ⟨e,eq⟩ := realize_coordinates v checked shared d groups core summary raw link coreSizes safeChecked t u triples
    a.1 a.2.1 valid.1 valid.2.1 dir g.1 g.2.1 g.2.2 q.1 q.2.1 q.2.2 eta decoded.1
  refine ⟨e,?_⟩
  rw [decoded.2] at eq
  have ae : (a.1,a.2.1,a.2.2) = a := by cases a with |mk h rw => cases rw; rfl
  exact eq.trans ae

theorem decode_valid_and_safe (seed : Nat → Nat) (v : Inventories) (checked : CanonicalCoverage.Checked v)
    (shared : SortedCoverage.SharedMembers v) (d : GroupInventory.Data) (groups : GroupInventory.Checked d)
    (core summary raw : Nat → ByteArray) (link : Link d v raw)
    (coreSizes : Base5Coverage.ProperSizes core) (safeChecked : FullSafeData.Checked (Base5Coverage.tables core summary raw))
    (t : TripleDirectory.Data) (u : Nat → HonorDirectory.Data) (triples : TripleDirectory.Checked d t)
    (directories : ∀ h, h < (v 3).count →
      HonorDirectory.Checked d t (PruningData.rawLabel (raw 3) ((v 3).member h)) (u h))
    (a : Nat × Nat × Nat) (valid : ValidAddress v u a) :
    Valid (GlobalAddressDecoder.decode seed v d t u a) ∧ IsSafe (GlobalAddressDecoder.decode seed v d t u a) := by
  obtain ⟨e,eq⟩ := every_valid_address_realized v checked shared d groups core summary raw link coreSizes safeChecked
    t u triples directories a valid
  rw [← eq,GlobalAddressDecoder.decode_entry seed v d groups raw t u e]
  exact ⟨e.valid,e.safe⟩

theorem distinct_addresses_have_distinct_orbits (seed : Nat → Nat) (v : Inventories) (checked : CanonicalCoverage.Checked v)
    (sizes : CanonicalCoverage.ProperSizes v) (shared : SortedCoverage.SharedMembers v) (keys : GlobalOrbitKey.SharedKeys v)
    (d : GroupInventory.Data) (groups : GroupInventory.Checked d)
    (core summary raw : Nat → ByteArray) (link : Link d v raw)
    (coreSizes : Base5Coverage.ProperSizes core) (safeChecked : FullSafeData.Checked (Base5Coverage.tables core summary raw))
    (t : TripleDirectory.Data) (u : Nat → HonorDirectory.Data) (triples : TripleDirectory.Checked d t)
    (directories : ∀ h, h < (v 3).count →
      HonorDirectory.Checked d t (PruningData.rawLabel (raw 3) ((v 3).member h)) (u h))
    (a b : Nat × Nat × Nat) (va : ValidAddress v u a) (vb : ValidAddress v u b)
    (same : SameOrbit (GlobalAddressDecoder.decode seed v d t u a) (GlobalAddressDecoder.decode seed v d t u b)) : a = b := by
  obtain ⟨ea,ae⟩ := every_valid_address_realized v checked shared d groups core summary raw link coreSizes safeChecked
    t u triples directories a va
  obtain ⟨eb,be⟩ := every_valid_address_realized v checked shared d groups core summary raw link coreSizes safeChecked
    t u triples directories b vb
  rw [← ae,← be,GlobalAddressDecoder.decode_entry seed v d groups raw t u ea,
    GlobalAddressDecoder.decode_entry seed v d groups raw t u eb] at same
  have result := same_orbit_same_address v checked sizes shared keys d raw link t u triples directories ea eb same
  rwa [ae,be] at result

end Mahjong.GlobalSlotRealization

#print axioms Mahjong.GlobalSlotRealization.realize_coordinates
#print axioms Mahjong.GlobalSlotRealization.every_valid_address_realized
#print axioms Mahjong.GlobalSlotRealization.decode_valid_and_safe
#print axioms Mahjong.GlobalSlotRealization.distinct_addresses_have_distinct_orbits
