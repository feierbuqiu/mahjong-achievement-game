import Mahjong.SuccessorCertification

set_option autoImplicit false

namespace Mahjong.CachedSuccessorList
open GlobalEnumeration GlobalSuccessorBridge CanonicalInventory CanonicalCoverage
open GlobalOrbitKey GlobalOrbitUniqueness LocalCacheEncoding LocalSymmetryFrame

def sourceId (c : Certificate) (s : State) (b : Nat) : Nat :=
  (inventoriesOf c b).id (encodeBlock b s)

def replacement (c : Certificate) (s : State) (b j : Nat) : State :=
  replaceBlock b s (decodeBlock b ((inventoriesOf c b).member j))

def raw (c : Certificate) (data : Nat → SuccessorCache.Data) (s : State) : List State :=
  (List.range 4).flatMap fun b => ((data b).next (sourceId c s b)).map (replacement c s b)

def safeTest (c : Certificate) (s : State) : Bool :=
  decide (PruningAlgebra.fullSafe (FullSafeData.allRaw
    (Base5Coverage.tables c.core c.summary c.raw) (Base5Coverage.pack s)))

def successors (c : Certificate) (data : Nat → SuccessorCache.Data) (s : State) : List PackedRules.Packed :=
  ((raw c data s).filter (safeTest c)).map (key (inventoriesOf c))

theorem source_id (c : Certificate) (s : State) (kept : Retained c s) (b : Nat) (hb : b < 4) :
    sourceId c s b < (inventoriesOf c b).count ∧
      (inventoriesOf c b).member (sourceId c s b) = encodeBlock b s := by
  obtain ⟨i,hi,eq⟩ := kept b hb
  have inverse := (CanonicalInventory.checked_member b _ (c.inventoryChecked b hb) i hi).2
  have id : sourceId c s b = i := by unfold sourceId; rw [← eq]; exact inverse
  rw [id]
  exact ⟨hi,eq⟩

theorem raw_mem (c : Certificate) (data : Nat → SuccessorCache.Data) (s q : State) :
    q ∈ raw c data s ↔ ∃ b j, b < 4 ∧ j ∈ (data b).next (sourceId c s b) ∧
      q = replacement c s b j := by
  simp only [raw,List.mem_flatMap,List.mem_range,List.mem_map]
  constructor
  · rintro ⟨b,hb,j,hj,eq⟩
    exact ⟨b,j,hb,hj,eq.symm⟩
  · rintro ⟨b,j,hb,hj,eq⟩
    exact ⟨b,hb,j,hj,eq.symm⟩

theorem raw_valid (c : Certificate) (data : Nat → SuccessorCache.Data)
    (checked : GlobalSuccessorBridge.Checked c data) (s q : State) (valid : Valid s)
    (kept : Retained c s) (mem : q ∈ raw c data s) : Valid q := by
  obtain ⟨b,j,hb,hj,eq⟩ := (raw_mem c data s q).mp mem
  have ids := source_id c s kept b hb
  have row := SuccessorCache.checked_row b _ _ (data b) (checked b hb) _ ids.1
  obtain ⟨u,path,_,legal,result⟩ := LocalSuccessorBridge.cached_edge_realized b _ _
    (c.inventoryChecked b hb) (summary_checked c b hb) (local_link c b hb) (data b)
    (sourceId c s b) j row ids.1 hj s valid ids.2
  rw [eq]
  change Valid (replaceBlock b s (decodeBlock b ((inventoriesOf c b).member j)))
  change replaceBlock b s (decodeBlock b ((inventoriesOf c b).member j)) =
    Generators.applyPath path (addTile s u) at result
  rw [result]
  exact LocalSymmetryFrame.path_valid path _ (valid_add legal.1 legal.2)

theorem filtered_iff_edge (c : Certificate) (data : Nat → SuccessorCache.Data)
    (checked : GlobalSuccessorBridge.Checked c data) (s q : State) (valid : Valid s)
    (kept : Retained c s) :
    q ∈ (raw c data s).filter (safeTest c) ↔ Edge c data s q := by
  constructor
  · intro mem
    obtain ⟨rawMem,safe⟩ := List.mem_filter.mp mem
    have vq := raw_valid c data checked s q valid kept rawMem
    have sq : IsSafe q := (Base5Coverage.checked_filter_on_every_valid_state
      c.core c.summary c.raw c.coreSizes c.safeChecked q vq).mp (of_decide_eq_true safe)
    obtain ⟨b,j,hb,hj,eq⟩ := (raw_mem c data s q).mp rawMem
    have ids := source_id c s kept b hb
    exact ⟨b,sourceId c s b,j,hb,ids.1,ids.2,hj,eq,sq⟩
  · rintro ⟨b,i,j,hb,hi,source,member,eq,safe⟩
    have inverse := (CanonicalInventory.checked_member b _ (c.inventoryChecked b hb) i hi).2
    have id : sourceId c s b = i := by unfold sourceId; rw [← source]; exact inverse
    have rawMem : q ∈ raw c data s := (raw_mem c data s q).mpr ⟨b,j,hb,by rwa [id],eq⟩
    have vq := raw_valid c data checked s q valid kept rawMem
    exact List.mem_filter.mpr ⟨rawMem,decide_eq_true ((Base5Coverage.checked_filter_on_every_valid_state
      c.core c.summary c.raw c.coreSizes c.safeChecked q vq).mpr safe)⟩

/-- A concrete finite successor list for the already proved original-game
quotient, from any retained SAFE representative. No P/N labels occur. -/
theorem exact_moves (c : Certificate) (data : Nat → SuccessorCache.Data)
    (checked : GlobalSuccessorBridge.Checked c data) (s : SafePosition) (kept : Retained c s.val)
    (k : PackedRules.Packed) :
    k ∈ successors c data s.val ↔
      CachedTransitionQuotient.Move c data (CachedTransitionQuotient.encode c s) k := by
  constructor
  · intro mem
    obtain ⟨q,hq,eq⟩ := List.mem_map.mp mem
    exact ⟨s.val,q,s.property.1,s.property.2,kept,rfl,
      (filtered_iff_edge c data checked s.val q s.property.1 kept).mp hq,eq⟩
  · intro edge
    obtain ⟨t,physical,target⟩ := CachedTransitionQuotient.backward c data checked edge
    obtain ⟨q,cached,orbit⟩ := edge_complete c data checked s.val t.val s.property.1 kept physical
    have eq := key_sameOrbit (inventoriesOf c) c.inventoryChecked c.inventorySizes c.sharedKeys
      t.val q t.property.1 orbit
    exact List.mem_map.mpr ⟨q,(filtered_iff_edge c data checked s.val q s.property.1 kept).mpr cached,
      eq.trans target⟩

end Mahjong.CachedSuccessorList

#print axioms Mahjong.CachedSuccessorList.source_id
#print axioms Mahjong.CachedSuccessorList.raw_mem
#print axioms Mahjong.CachedSuccessorList.raw_valid
#print axioms Mahjong.CachedSuccessorList.filtered_iff_edge
#print axioms Mahjong.CachedSuccessorList.exact_moves
