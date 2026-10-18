import Mahjong.GlobalOrbitDirectory
import Mahjong.IndexDecoder

set_option autoImplicit false

namespace Mahjong.GlobalAddressDecoder
open CanonicalCoverage GroupCandidates GroupedCoverage PackedRules Base5Coverage GlobalOrbitDirectory

def decode (seed : Nat → Nat) (v : Inventories) (d : GroupInventory.Data)
    (t : TripleDirectory.Data) (u : Nat → HonorDirectory.Data) (a : Nat × Nat × Nat) : State :=
  let g := t.key ((u a.1).tid a.2.1)
  let q := IndexDecoder.decode seed d g.1 g.2.1 g.2.2 a.2.2
  unpack ⟨d.retained (d.first g.1+q.1),d.retained (d.first g.2.1+q.2.1),
    d.retained (d.first g.2.2+q.2.2),(v 3).member a.1⟩

theorem decode_entry (seed : Nat → Nat) (v : Inventories) (d : GroupInventory.Data)
    (groups : GroupInventory.Checked d) (raw : Nat → ByteArray)
    (t : TripleDirectory.Data) (u : Nat → HonorDirectory.Data) (e : Entry v d raw t u) :
    decode seed v d t u (address e) = e.state := by
  have a := GroupInventory.member_facts d groups e.block.i e.block.i_bound
  have b := GroupInventory.member_facts d groups e.block.j e.block.j_bound
  have c := GroupInventory.member_facts d groups e.block.k e.block.k_bound
  have ab := GroupInventory.group_monotone d groups e.block.i e.block.j e.block.i_bound e.block.j_bound e.block.ij
  have bc := GroupInventory.group_monotone d groups e.block.j e.block.k e.block.j_bound e.block.k_bound e.block.jk
  have coords := member_coordinates d groups e.block.i e.block.j e.block.k e.block.i_bound e.block.j_bound e.block.k_bound e.block.ij e.block.jk
  have inverse := IndexDecoder.decode_rank seed d groups _ _ _ _ _ _ a.group b.group c.group ab bc coords
  simp only [decode,address,e.rowKey,inverse]
  rw [← a.offset,← b.offset,← c.offset,e.block.i_code,e.block.j_code,e.block.k_code,e.block.h_code]
  exact unpack_pack e.state e.valid

theorem same_address_same_state (v : Inventories) (d : GroupInventory.Data)
    (groups : GroupInventory.Checked d) (raw : Nat → ByteArray)
    (t : TripleDirectory.Data) (u : Nat → HonorDirectory.Data) (a b : Entry v d raw t u)
    (same : address a = address b) : a.state = b.state := by
  rw [← decode_entry (fun _ => 0) v d groups raw t u a,← decode_entry (fun _ => 0) v d groups raw t u b,same]

theorem same_address_iff_same_orbit (v : Inventories) (checked : CanonicalCoverage.Checked v)
    (sizes : CanonicalCoverage.ProperSizes v) (members : SortedCoverage.SharedMembers v) (keys : GlobalOrbitKey.SharedKeys v)
    (d : GroupInventory.Data) (groups : GroupInventory.Checked d) (raw : Nat → ByteArray) (link : Link d v raw)
    (t : TripleDirectory.Data) (u : Nat → HonorDirectory.Data) (triples : TripleDirectory.Checked d t)
    (directories : ∀ h, h < (v 3).count →
      HonorDirectory.Checked d t (PruningData.rawLabel (raw 3) ((v 3).member h)) (u h))
    (a b : Entry v d raw t u) :
    address a = address b ↔ GlobalOrbitUniqueness.SameOrbit a.state b.state := by
  constructor
  · intro same
    have states := same_address_same_state v d groups raw t u a b same
    rw [states]
    exact GlobalOrbitUniqueness.sameOrbit_refl b.state
  · exact same_orbit_same_address v checked sizes members keys d raw link t u triples directories a b

end Mahjong.GlobalAddressDecoder

#print axioms Mahjong.GlobalAddressDecoder.decode_entry
#print axioms Mahjong.GlobalAddressDecoder.same_address_same_state
#print axioms Mahjong.GlobalAddressDecoder.same_address_iff_same_orbit
