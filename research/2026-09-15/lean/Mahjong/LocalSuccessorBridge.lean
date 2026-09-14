import Mahjong.SuccessorCache

set_option autoImplicit false

namespace Mahjong.LocalSuccessorBridge
open CanonicalInventory LocalCacheEncoding LocalSymmetryFrame MaskedLocalBound Generators

structure Linked (b : Nat) (t : CanonicalInventory.Candidate) (s : LocalSummary.Candidate) : Prop where
  size : s.core.size = t.size
  decode : s.core.unrank = decodeBlock b

theorem add_same (b : Nat) (s t : State) (same : SameBlock b s t) (u : Tile) :
    SameBlock b (addTile s u) (addTile t u) := by
  intro v hv
  simp only [addTile,same v hv]

theorem replace_after_add (b : Nat) (s r : State) (u : Tile) (block : u.val/9 = b) :
    replaceBlock b (addTile s u) r = replaceBlock b s r := by
  funext v
  by_cases inside : v.val/9 = b
  · simp only [replaceBlock,if_pos inside]
  · have different : v ≠ u := by intro eq; apply inside; rw [eq,block]
    simp only [replaceBlock,if_neg inside,addTile_other s different]

theorem source_same (b : Nat) (t : CanonicalInventory.Candidate) (summary : LocalSummary.Candidate)
    (linked : Linked b t summary) (i : Nat) (s : State) (valid : Valid s)
    (source : t.member i = encodeBlock b s) : SameBlock b (summary.core.unrank (t.member i)) s := by
  rw [linked.decode,source]
  exact Base5Coverage.decode_encode_same s valid b

theorem available_eq (b : Nat) (t : CanonicalInventory.Candidate) (summary : LocalSummary.Candidate)
    (inventory : CanonicalInventory.Checked b t) (summaries : PruningData.Checked b summary)
    (linked : Linked b t summary) (i : Nat) (hi : i < t.count) (s : State) (valid : Valid s)
    (source : t.member i = encodeBlock b s) (u : Tile) (block : u.val/9 = b) :
    summary.available (t.member i) u = decide (s u < 4) := by
  have inside := (checked_member b t inventory i hi).1
  have row := PruningData.summary_row b summary summaries (t.member i) (by rw [linked.size]; exact inside)
  rw [LocalSummary.row_available b summary _ row u block,
    source_same b t summary linked i s valid source u block]

theorem raw_addition (b : Nat) (t : CanonicalInventory.Candidate) (summary : LocalSummary.Candidate)
    (inventory : CanonicalInventory.Checked b t) (summaries : PruningData.Checked b summary)
    (linked : Linked b t summary) (i : Nat) (hi : i < t.count) (s : State) (valid : Valid s)
    (source : t.member i = encodeBlock b s) (u : Tile) (block : u.val/9 = b)
    (available : summary.available (t.member i) u = true) :
    summary.next (t.member i) u < t.size ∧
      SameBlock b (decodeBlock b (summary.next (t.member i) u)) (addTile s u) ∧
      summary.next (t.member i) u = encodeBlock b (addTile s u) := by
  have inside := (checked_member b t inventory i hi).1
  have row := PruningData.summary_row b summary summaries (t.member i) (by rw [linked.size]; exact inside)
  have next := LocalSummary.row_next b summary (t.member i) row u block available
  have range : summary.next (t.member i) u < t.size := by rw [← linked.size]; exact next.1
  have same : SameBlock b (decodeBlock b (summary.next (t.member i) u)) (addTile s u) := by
    rw [linked.decode] at next
    exact fun v hv => (next.2 v hv).trans
      (add_same b _ s (by rw [← linked.decode]; exact source_same b t summary linked i s valid source) u v hv)
  have roundtrip := (CanonicalInventory.checked_row b t inventory _ range).roundtrip
  have codes := encode_same b _ _ same
  exact ⟨range,same,roundtrip.symm.trans codes⟩

/-- Every stored local edge can be realized by a real single-tile addition
in any physical context with this retained source block. -/
theorem cached_edge_realized (b : Nat) (t : CanonicalInventory.Candidate) (summary : LocalSummary.Candidate)
    (inventory : CanonicalInventory.Checked b t) (summaries : PruningData.Checked b summary)
    (linked : Linked b t summary) (data : SuccessorCache.Data) (i j : Nat)
    (pass : SuccessorCache.checkRow b t summary data i = true) (hi : i < t.count)
    (edge : j ∈ data.next i) (s : State) (valid : Valid s) (source : t.member i = encodeBlock b s) :
    ∃ u : Tile, ∃ path : List Generator, u.val/9 = b ∧ LegalAdd s u ∧
      replaceBlock b s (decodeBlock b (t.member j)) = applyPath path (addTile s u) := by
  obtain ⟨u,block,av,eq,hj⟩ := (SuccessorCache.row_edge_iff b t summary data i j pass).mp edge
  have legal : s u < 4 := by
    rw [available_eq b t summary inventory summaries linked i hi s valid source u block] at av
    exact of_decide_eq_true av
  have raw := raw_addition b t summary inventory summaries linked i hi s valid source u block av
  have r := CanonicalInventory.checked_row b t inventory _ raw.1
  have cr := CanonicalInventory.checked_row b t inventory _ r.range
  have member : t.member j = t.canonical (summary.next (t.member i) u) := by
    rw [← eq]
    exact cr.reverse (by rw [eq]; exact hj)
  have witness := canonical_context b t inventory _ raw.1 (addTile s u) raw.2.1
  rw [replace_after_add b s _ u block,← member] at witness
  exact ⟨u,t.witness (summary.next (t.member i) u),block,⟨valid,legal⟩,witness⟩

/-- All raw additions whose canonical result is retained occur in the cache. -/
theorem retained_addition_cached (b : Nat) (t : CanonicalInventory.Candidate) (summary : LocalSummary.Candidate)
    (data : SuccessorCache.Data) (i : Nat) (pass : SuccessorCache.checkRow b t summary data i = true)
    (u : Tile) (block : u.val/9 = b) (available : summary.available (t.member i) u = true)
    (retained : t.id (t.canonical (summary.next (t.member i) u)) < t.count) :
    t.id (t.canonical (summary.next (t.member i) u)) ∈ data.next i :=
  (SuccessorCache.row_edge_iff b t summary data i _ pass).mpr ⟨u,block,available,rfl,retained⟩

end Mahjong.LocalSuccessorBridge

#print axioms Mahjong.LocalSuccessorBridge.add_same
#print axioms Mahjong.LocalSuccessorBridge.replace_after_add
#print axioms Mahjong.LocalSuccessorBridge.source_same
#print axioms Mahjong.LocalSuccessorBridge.available_eq
#print axioms Mahjong.LocalSuccessorBridge.raw_addition
#print axioms Mahjong.LocalSuccessorBridge.cached_edge_realized
#print axioms Mahjong.LocalSuccessorBridge.retained_addition_cached
