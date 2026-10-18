import Mahjong.GlobalAddressDecoder

set_option autoImplicit false

namespace Mahjong.IndexedPhysical
open CanonicalCoverage CanonicalInventory GroupedCoverage PackedRules Base5Coverage PruningAlgebra

def codes (v : Inventories) (d : GroupInventory.Data) (i j k h : Nat) : Packed :=
  ⟨d.retained i,d.retained j,d.retained k,(v 3).member h⟩

def state (v : Inventories) (d : GroupInventory.Data) (i j k h : Nat) : State := unpack (codes v d i j k h)

theorem unpack_valid (p : Packed) : Valid (unpack p) := by
  intro u
  exact LocalSymmetryFrame.decode_valid (u.val/9) (p.get (u.val/9)) u

theorem codes_retained (v : Inventories) (shared : SortedCoverage.SharedMembers v)
    (d : GroupInventory.Data) (raw : Nat → ByteArray) (link : Link d v raw)
    (i j k h : Nat) (hi : i < d.count) (hj : j < d.count) (hk : k < d.count) (hh : h < (v 3).count) :
    SortedCoverage.Retained v (codes v d i j k h) := by
  intro b hb
  have options : b = 0 ∨ b = 1 ∨ b = 2 ∨ b = 3 := by omega
  rcases options with rfl | rfl | rfl | rfl
  · exact ⟨i,by rwa [← link.count],by rw [← link.members]; rfl⟩
  · rw [(shared 1 (by decide)).1,(shared 1 (by decide)).2]
    exact ⟨j,by rwa [← link.count],by rw [← link.members]; rfl⟩
  · rw [(shared 2 (by decide)).1,(shared 2 (by decide)).2]
    exact ⟨k,by rwa [← link.count],by rw [← link.members]; rfl⟩
  · exact ⟨h,hh,rfl⟩

theorem state_encoded (v : Inventories) (checked : CanonicalCoverage.Checked v)
    (shared : SortedCoverage.SharedMembers v) (d : GroupInventory.Data) (raw : Nat → ByteArray) (link : Link d v raw)
    (i j k h : Nat) (hi : i < d.count) (hj : j < d.count) (hk : k < d.count) (hh : h < (v 3).count)
    (b : Nat) (hb : b < 4) :
    LocalCacheEncoding.encodeBlock b (state v d i j k h) = (codes v d i j k h).get b := by
  have retained := codes_retained v shared d raw link i j k h hi hj hk hh
  exact SuitSorting.encode_unpacked _ b (v b) (checked b hb)
    (SortedCoverage.retained_inside v checked _ retained b hb)

def label (v : Inventories) (d : GroupInventory.Data) (raw : Nat → ByteArray) (i j k h : Nat) : Label :=
  join (join (join (d.raw (d.retained i)) (d.raw (d.retained j))) (d.raw (d.retained k)))
    (PruningData.rawLabel (raw 3) ((v 3).member h))

theorem raw_label (v : Inventories) (checked : CanonicalCoverage.Checked v)
    (shared : SortedCoverage.SharedMembers v) (d : GroupInventory.Data) (core summary raw : Nat → ByteArray) (link : Link d v raw)
    (i j k h : Nat) (hi : i < d.count) (hj : j < d.count) (hk : k < d.count) (hh : h < (v 3).count) :
    FullSafeData.allRaw (Base5Coverage.tables core summary raw) (pack (state v d i j k h)) = label v d raw i j k h := by
  unfold FullSafeData.allRaw
  rw [CanonicalCoverage.rawAt_pack core summary raw _ 0 (by decide),
    CanonicalCoverage.rawAt_pack core summary raw _ 1 (by decide),
    CanonicalCoverage.rawAt_pack core summary raw _ 2 (by decide),
    CanonicalCoverage.rawAt_pack core summary raw _ 3 (by decide)]
  rw [state_encoded v checked shared d raw link i j k h hi hj hk hh 0 (by decide),
    state_encoded v checked shared d raw link i j k h hi hj hk hh 1 (by decide),
    state_encoded v checked shared d raw link i j k h hi hj hk hh 2 (by decide),
    state_encoded v checked shared d raw link i j k h hi hj hk hh 3 (by decide)]
  rw [← link.raw 0 (by decide),← link.raw 1 (by decide),← link.raw 2 (by decide)]
  rfl

theorem state_safe (v : Inventories) (checked : CanonicalCoverage.Checked v)
    (shared : SortedCoverage.SharedMembers v) (d : GroupInventory.Data) (core summary raw : Nat → ByteArray) (link : Link d v raw)
    (coreSizes : Base5Coverage.ProperSizes core) (safeChecked : FullSafeData.Checked (Base5Coverage.tables core summary raw))
    (i j k h : Nat) (hi : i < d.count) (hj : j < d.count) (hk : k < d.count) (hh : h < (v 3).count)
    (safe : fullSafe (label v d raw i j k h)) : IsSafe (state v d i j k h) := by
  apply (Base5Coverage.checked_filter_on_every_valid_state core summary raw coreSizes safeChecked
    (state v d i j k h) (unpack_valid _)).mp
  rw [raw_label v checked shared d core summary raw link i j k h hi hj hk hh]
  exact safe

theorem state_tiles (v : Inventories) (checked : CanonicalCoverage.Checked v)
    (shared : SortedCoverage.SharedMembers v) (d : GroupInventory.Data) (core summary raw : Nat → ByteArray) (link : Link d v raw)
    (coreSizes : Base5Coverage.ProperSizes core) (safeChecked : FullSafeData.Checked (Base5Coverage.tables core summary raw))
    (i j k h : Nat) (hi : i < d.count) (hj : j < d.count) (hk : k < d.count) (hh : h < (v 3).count) :
    (label v d raw i j k h).tiles = total (state v d i j k h) := by
  have tiles := TileCountBridge.raw_total core summary raw coreSizes safeChecked (state v d i j k h) (unpack_valid _)
  rwa [raw_label v checked shared d core summary raw link i j k h hi hj hk hh] at tiles

end Mahjong.IndexedPhysical

#print axioms Mahjong.IndexedPhysical.unpack_valid
#print axioms Mahjong.IndexedPhysical.codes_retained
#print axioms Mahjong.IndexedPhysical.state_encoded
#print axioms Mahjong.IndexedPhysical.raw_label
#print axioms Mahjong.IndexedPhysical.state_safe
#print axioms Mahjong.IndexedPhysical.state_tiles
