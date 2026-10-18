import Mahjong.LocalSuccessorBridge
import Mahjong.GlobalEnumeration

set_option autoImplicit false

namespace Mahjong.GlobalSuccessorBridge
open CanonicalInventory CanonicalCoverage LocalCacheEncoding LocalSymmetryFrame
open GlobalEnumeration GlobalOrbitUniqueness LocalSuccessorBridge Generators

def summaries (c : Certificate) (b : Nat) : LocalSummary.Candidate :=
  SummaryEncoding.candidate b (c.core b) (c.summary b)

def Checked (c : Certificate) (data : Nat → SuccessorCache.Data) : Prop :=
  ∀ b, b < 4 → checkSpan (SuccessorCache.checkRow b (inventoriesOf c b) (summaries c b) (data b))
    0 (inventoriesOf c b).count = true

def Retained (c : Certificate) (s : State) : Prop :=
  ∀ b, b < 4 → ∃ i, i < (inventoriesOf c b).count ∧ (inventoriesOf c b).member i = encodeBlock b s

theorem local_link (c : Certificate) (b : Nat) (hb : b < 4) :
    Linked b (inventoriesOf c b) (summaries c b) := by
  constructor
  · exact (c.coreSizes b hb).trans (c.inventorySizes b hb).symm
  · rfl

theorem summary_checked (c : Certificate) (b : Nat) (hb : b < 4) :
    PruningData.Checked b (summaries c b) := (c.safeChecked b hb).1

/-- One cached local replacement followed by the full SAFE filter. Numeric
suit sorting and optimized rank lookups are separate implementation steps. -/
def Edge (c : Certificate) (data : Nat → SuccessorCache.Data) (s q : State) : Prop :=
  ∃ b i j, b < 4 ∧ i < (inventoriesOf c b).count ∧
    (inventoriesOf c b).member i = encodeBlock b s ∧ j ∈ (data b).next i ∧
    q = replaceBlock b s (decodeBlock b ((inventoriesOf c b).member j)) ∧ IsSafe q

theorem edge_sound (c : Certificate) (data : Nat → SuccessorCache.Data) (checked : Checked c data)
    (s q : State) (valid : Valid s) (edge : Edge c data s q) :
    ∃ r, SafeMove s r ∧ SameOrbit r q ∧ Valid q := by
  obtain ⟨b,i,j,hb,hi,source,member,eq,safe⟩ := edge
  have pass := SuccessorCache.checked_row b (inventoriesOf c b) (summaries c b) (data b) (checked b hb) i hi
  obtain ⟨u,path,_,legal,witness⟩ := cached_edge_realized b (inventoriesOf c b) (summaries c b)
    (c.inventoryChecked b hb) (summary_checked c b hb) (local_link c b hb) (data b) i j pass hi member s valid source
  have result : q = applyPath path (addTile s u) := eq.trans witness
  have rawSafe : IsSafe (addTile s u) := (path_safe_iff path _).mp (by rw [← result]; exact safe)
  refine ⟨addTile s u,⟨⟨u,legal,rfl⟩,rawSafe⟩,⟨path,result⟩,?_⟩
  rw [result]
  exact path_valid path _ (valid_add legal.1 legal.2)

/-- No original SAFE move from a retained source is lost by local filtering,
canonicalization or deduplication of the successor IDs. -/
theorem edge_complete (c : Certificate) (data : Nat → SuccessorCache.Data) (checked : Checked c data)
    (s r : State) (valid : Valid s) (kept : Retained c s) (edge : SafeMove s r) :
    ∃ q, Edge c data s q ∧ SameOrbit r q := by
  obtain ⟨⟨u,legal,rfl⟩,safe⟩ := edge
  let b := u.val/9
  have hb : b < 4 := by have h := u.isLt; dsimp [b]; omega
  obtain ⟨i,hi,source⟩ := kept b hb
  let t := inventoriesOf c b
  let sum := summaries c b
  have av : sum.available (t.member i) u = true := by
    rw [available_eq b t sum (c.inventoryChecked b hb) (summary_checked c b hb)
      (local_link c b hb) i hi s valid source u rfl]
    exact decide_eq_true legal.2
  have raw := raw_addition b t sum (c.inventoryChecked b hb) (summary_checked c b hb)
    (local_link c b hb) i hi s valid source u rfl av
  have cr := CanonicalInventory.checked_row b t (c.inventoryChecked b hb) _ raw.1
  let q := canonBlock (inventoriesOf c) b (addTile s u)
  have va := valid_add legal.1 legal.2
  have vq : Valid q := canonBlock_valid (inventoriesOf c) c.inventoryChecked c.inventorySizes b hb _ va
  have sq : IsSafe q := (canonBlock_safe (inventoriesOf c) c.inventoryChecked c.inventorySizes b hb _ va).mpr safe
  have qcode : encodeBlock b q = t.canonical (sum.next (t.member i) u) := by
    change encodeBlock b (replaceBlock b (addTile s u) (decodeBlock b (t.canonical (encodeBlock b (addTile s u))))) = _
    rw [encode_replace_self,← raw.2.2]
    exact (CanonicalInventory.checked_row b t (c.inventoryChecked b hb) _ cr.range).roundtrip
  have fixed : t.canonical (encodeBlock b q) = encodeBlock b q :=
    canonBlock_fixed (inventoriesOf c) c.inventoryChecked c.inventorySizes b hb _ va
  have passes := safe_raw_partials c.core c.summary c.raw c.coreSizes c.safeChecked q vq sq b hb
  have passes' : PruningAlgebra.passesPartial (t.raw (encodeBlock b q)) := passes
  have insideQ : encodeBlock b q < t.size := by rw [qcode]; exact cr.range
  have qrow := CanonicalInventory.checked_row b t (c.inventoryChecked b hb) _ insideQ
  have retained : t.id (t.canonical (sum.next (t.member i) u)) < t.count := by
    rw [← qcode]
    exact qrow.kept.mpr ⟨fixed,passes'⟩
  let j := t.id (t.canonical (sum.next (t.member i) u))
  have pass := SuccessorCache.checked_row b t sum (data b) (checked b hb) i hi
  have found : j ∈ (data b).next i := retained_addition_cached b t sum (data b) i pass u rfl av retained
  have member : t.member j = t.canonical (sum.next (t.member i) u) :=
    (CanonicalInventory.checked_row b t (c.inventoryChecked b hb) _ cr.range).reverse retained
  have replaced : q = replaceBlock b s (decodeBlock b (t.member j)) := by
    change replaceBlock b (addTile s u) (decodeBlock b (t.canonical (encodeBlock b (addTile s u)))) = _
    rw [replace_after_add b s _ u rfl,member,raw.2.2]
  refine ⟨q,⟨b,i,j,hb,hi,source,found,replaced,sq⟩,?_⟩
  exact ⟨t.witness (encodeBlock b (addTile s u)),
    canonBlock_eq (inventoriesOf c) c.inventoryChecked c.inventorySizes b hb _ va⟩

end Mahjong.GlobalSuccessorBridge

#print axioms Mahjong.GlobalSuccessorBridge.local_link
#print axioms Mahjong.GlobalSuccessorBridge.summary_checked
#print axioms Mahjong.GlobalSuccessorBridge.edge_sound
#print axioms Mahjong.GlobalSuccessorBridge.edge_complete
