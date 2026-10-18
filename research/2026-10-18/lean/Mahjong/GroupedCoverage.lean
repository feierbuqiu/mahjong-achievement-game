import Mahjong.SortedCoverage
import Mahjong.SafeLayerBound
import Mahjong.WeightedBlocks

set_option autoImplicit false

namespace Mahjong.GroupedCoverage
open CanonicalCoverage CanonicalInventory LocalCacheEncoding PruningAlgebra GroupCandidates

structure Link (d : GroupInventory.Data) (t : Inventories) (raw : Nat → ByteArray) : Prop where
  count : d.count = (t 0).count
  members : d.retained = (t 0).member
  raw : ∀ b, b < 3 → d.raw = PruningData.rawLabel (raw b)

theorem candidate_link (numeric groups : ByteArray) (raw ids members : Nat → ByteArray)
    (count : numeric.size / 12 = (members 0).size / 4)
    (same : ∀ b, b < 3 → raw b = raw 0) :
    Link (GroupInventory.candidate numeric groups (raw 0) (members 0)) (inventories raw ids members) raw := by
  refine ⟨count,rfl,?_⟩
  intro b hb
  rw [same b hb]
  rfl

structure NumberedBlock (d : GroupInventory.Data) (hon : CanonicalInventory.Candidate)
    (rawH : Nat → Label) (s : State) where
  i : Nat
  j : Nat
  k : Nat
  h : Nat
  i_bound : i < d.count
  j_bound : j < d.count
  k_bound : k < d.count
  h_bound : h < hon.count
  ij : i ≤ j
  jk : j ≤ k
  i_code : d.retained i = encodeBlock 0 s
  j_code : d.retained j = encodeBlock 1 s
  k_code : d.retained k = encodeBlock 2 s
  h_code : hon.member h = encodeBlock 3 s
  present : (d.group i,d.group j,d.group k) ∈ bucket d (rawH (hon.member h)) (total s)
  rank_bound : WeightedBlocks.rank d (d.group i) (d.group j) (d.group k) (d.member i) (d.member j) (d.member k) <
    WeightedBlocks.size d (d.group i) (d.group j) (d.group k)

theorem inverse_lookup (t : CanonicalInventory.Candidate) (checked : CanonicalInventory.Checked 0 t)
    (code : Nat) (kept : ∃ k, k < t.count ∧ t.member k = code) :
    t.id code < t.count ∧ t.member (t.id code) = code := by
  obtain ⟨k, hk, eq⟩ := kept
  have inv := (checked_member 0 t checked k hk).2
  rw [eq] at inv
  rw [inv]
  exact ⟨hk,eq⟩

theorem sorted_has_numbered_block (core summary raw : Nat → ByteArray)
    (sizes : Base5Coverage.ProperSizes core)
    (checked : FullSafeData.Checked (Base5Coverage.tables core summary raw))
    (t : Inventories) (inventoryChecked : CanonicalCoverage.Checked t) (shared : SortedCoverage.SharedMembers t)
    (d : GroupInventory.Data) (groupChecked : GroupInventory.Checked d) (link : Link d t raw)
    (s : State) (valid : Valid s) (safe : IsSafe s)
    (kept : ∀ b, b < 4 → ∃ k, k < (t b).count ∧ (t b).member k = encodeBlock b s)
    (order : (t 0).id (encodeBlock 0 s) ≤ (t 0).id (encodeBlock 1 s) ∧
      (t 0).id (encodeBlock 1 s) ≤ (t 0).id (encodeBlock 2 s)) :
    Nonempty (NumberedBlock d (t 3) (PruningData.rawLabel (raw 3)) s) := by
  let ids := fun b => (t 0).id (encodeBlock b s)
  have looked (b : Nat) (hb : b < 3) : ids b < d.count ∧ d.retained (ids b) = encodeBlock b s := by
    have stored := kept b (by omega)
    rw [(shared b hb).1,(shared b hb).2] at stored
    have inv := inverse_lookup (t 0) (inventoryChecked 0 (by decide)) _ stored
    rw [link.count,link.members]
    exact inv
  have labels (b : Nat) (hb : b < 3) : d.raw (d.retained (ids b)) = PruningData.rawLabel (raw b) (encodeBlock b s) := by
    rw [(looked b hb).2,link.raw b hb]
  have full := (Base5Coverage.checked_filter_on_every_valid_state core summary raw sizes checked s valid).mpr safe
  have tiles := TileCountBridge.raw_total core summary raw sizes checked s valid
  unfold FullSafeData.allRaw at full tiles
  rw [CanonicalCoverage.rawAt_pack core summary raw s 0 (by decide),
    CanonicalCoverage.rawAt_pack core summary raw s 1 (by decide),
    CanonicalCoverage.rawAt_pack core summary raw s 2 (by decide),
    CanonicalCoverage.rawAt_pack core summary raw s 3 (by decide)] at full tiles
  rw [← labels 0 (by decide),← labels 1 (by decide),← labels 2 (by decide)] at full tiles
  obtain ⟨h, hh, hc⟩ := kept 3 (by decide)
  rw [← hc] at full tiles
  have result := safe_members_in_bucket d groupChecked (PruningData.rawLabel (raw 3) ((t 3).member h))
    (total s) (ids 0) (ids 1) (ids 2) (looked 0 (by decide)).1 (looked 1 (by decide)).1 (looked 2 (by decide)).1
    order.1 order.2 full tiles
  have g01 := GroupInventory.group_monotone d groupChecked (ids 0) (ids 1)
    (looked 0 (by decide)).1 (looked 1 (by decide)).1 order.1
  have g12 := GroupInventory.group_monotone d groupChecked (ids 1) (ids 2)
    (looked 1 (by decide)).1 (looked 2 (by decide)).1 order.2
  exact ⟨⟨ids 0,ids 1,ids 2,h,(looked 0 (by decide)).1,(looked 1 (by decide)).1,(looked 2 (by decide)).1,
    hh,order.1,order.2,(looked 0 (by decide)).2,(looked 1 (by decide)).2,(looked 2 (by decide)).2,hc,result.1,
    WeightedBlocks.rank_bound d _ _ _ _ _ _ g01 g12 result.2⟩⟩

/-- Original-state coverage all the way to an eligible, in-range numbered block
in a layer 0..34 of the group-enumeration specification. Concrete directory
files and the C++ rank/unrank implementation are separate obligations. -/
theorem original_safe_has_numbered_block (core summary raw ids members : Nat → ByteArray)
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
    (s : State) (valid : Valid s) (safe : IsSafe s) :
    ∃ r : State, ∃ path : List Generators.Generator,
      Valid r ∧ IsSafe r ∧ r = Generators.applyPath path s ∧ total r ≤ 34 ∧
      Nonempty (NumberedBlock d (inventories raw ids members 3) (PruningData.rawLabel (raw 3)) r) := by
  obtain ⟨r,path,vr,sr,eq,kept,order⟩ := SortedCoverage.every_safe_sorted_representative
    core summary raw ids members coreSizes safeChecked inventorySizes inventoryChecked shared s valid safe
  have bound := SafeLayerBound.original_safe_bound core summary raw coreSizes safeChecked num hon two three four 34
    localBound c2 c3 c4 last r vr sr
  exact ⟨r,path,vr,sr,eq,bound,sorted_has_numbered_block core summary raw coreSizes safeChecked
    _ inventoryChecked shared d groupChecked link r vr sr kept order⟩

end Mahjong.GroupedCoverage

#print axioms Mahjong.GroupedCoverage.sorted_has_numbered_block
#print axioms Mahjong.GroupedCoverage.candidate_link
#print axioms Mahjong.GroupedCoverage.original_safe_has_numbered_block
