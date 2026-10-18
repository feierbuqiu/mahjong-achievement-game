import Mahjong.FullSafeSemantics
import Mahjong.PruningPackedBridge

set_option autoImplicit false

namespace Mahjong.FullSafeData
open PruningAlgebra PruningSemantics

def checkRow (b : Nat) (t : PruningData.Candidate) (i : Nat) : Bool :=
  let a := t.raw i
  let s := t.summary.core.unrank i
  PruningData.checkRow b t i &&
    (if a.current.pair < 5 then decide (a.added = PruningData.expectedAdded b t.summary i) else true) &&
    decide (a.missing = ((LocalSummary.orphanTiles b).filter (fun u => decide (s u = 0))).length) &&
    decide (a.orphanPair = (LocalSummary.orphanTiles b).any (fun u => decide (2 ≤ s u))) &&
    decide (a.tiles = ((PairProfile.blockTiles b).map s).sum)

def checkSpan (b : Nat) (t : PruningData.Candidate) (start : Nat) : Nat → Bool
  | 0 => true
  | n + 1 => checkRow b t start && checkSpan b t (start + 1) n

theorem checkSpan_add (b : Nat) (t : PruningData.Candidate) (a c start : Nat) :
    checkSpan b t start (a + c) = (checkSpan b t start a && checkSpan b t (start + a) c) := by
  induction a generalizing start with
  | zero => simp [checkSpan]
  | succ a ih =>
    simp only [Nat.succ_add, checkSpan, ih]
    simp [Nat.add_assoc, Nat.add_comm, Nat.add_left_comm, Bool.and_assoc]

theorem checkSpan_each (b : Nat) (t : PruningData.Candidate) (count start : Nat)
    (checked : checkSpan b t start count = true) :
    ∀ offset, offset < count → checkRow b t (start + offset) = true := by
  induction count generalizing start with
  | zero => intro offset h; omega
  | succ count ih =>
    have parts : checkRow b t start = true ∧ checkSpan b t (start + 1) count = true := by
      simpa only [checkSpan, Bool.and_eq_true] using checked
    intro offset h
    cases offset with
    | zero => simpa using parts.1
    | succ offset =>
      have x := ih (start + 1) parts.2 offset (by omega)
      simpa [Nat.add_assoc, Nat.add_comm, Nat.add_left_comm] using x

def Facts (a e : Label) : Prop :=
  PruningBelow a e ∧ a.missing = e.missing ∧ a.orphanPair = e.orphanPair ∧
    a.tiles = e.tiles ∧ (a.current.pair < 5 → a = e)

/-- Exact added-envelope equality is only needed below the immediate standard-win
cutoff. Above that cutoff the local label is already rejected. -/
theorem checkRow_sound (b : Nat) (t : PruningData.Candidate)
    (checked : PruningData.Checked b t.summary) (i : Nat) (inside : i < t.summary.core.size)
    (row : checkRow b t i = true) : Facts (t.raw i) (labelOf b (t.summary.core.unrank i)) := by
  simp only [checkRow, Bool.and_eq_true, decide_eq_true_eq] at row
  obtain ⟨⟨⟨⟨basic, added⟩, missing⟩, orphan⟩, tiles⟩ := row
  have below := PruningData.checkRow_sound b t checked i inside basic
  refine ⟨below, missing, orphan, tiles, ?_⟩
  intro small
  simp only [small, ↓reduceIte, decide_eq_true_eq] at added
  have cur := PruningData.view_spec b t.summary checked i inside
  have future := PruningData.expectedAdded_spec b t.summary checked i inside
  have summary := LocalSummary.row_spec b t.summary checked.1 i inside
    (PruningData.summary_row b t.summary checked i inside)
  have qeq := congrArg LocalSummary.Value.pairs summary
  simp only [LocalSummary.spec] at qeq
  simp only [PruningData.checkRow, Bool.and_eq_true, decide_eq_true_eq] at basic
  obtain ⟨⟨⟨pr, _⟩, pairs⟩, single⟩ := basic
  have prEq : (t.raw i).current = profileOf b (t.summary.core.unrank i) := pr.trans cur
  have adEq : (t.raw i).added = addedEnvelope b (t.summary.core.unrank i) := added.trans future
  have pairEq := pairs.trans qeq
  cases value : t.raw i
  simp only [value] at prEq adEq pairEq single missing orphan tiles
  simp only [labelOf, prEq, adEq, pairEq, single, missing, orphan, tiles]

theorem label_same (b : Nat) (s t : State) (same : MaskedLocalBound.SameBlock b s t) :
    labelOf b s = labelOf b t := by
  have fields := LocalSummary.spec_same b s t same
  have currentEq := PruningPackedBridge.profile_same b s t same
  have addedEq : addedEnvelope b s = addedEnvelope b t := by
    simp only [addedEnvelope, currentEq, PruningPackedBridge.afterProfiles_same b s t same]
  have q := congrArg LocalSummary.Value.pairs fields
  have pair := congrArg LocalSummary.Value.orphanPair fields
  simp only [LocalSummary.spec] at q pair
  have single := LocalSummary.any_congr (PairProfile.blockTiles b)
    (fun u => decide (s u = 1)) (fun u => decide (t u = 1))
    (fun u hu => by rw [same u ((PairProfile.mem_blockTiles b u).mp hu)])
  have missing : (LocalSummary.orphanTiles b).filter (fun u => decide (s u = 0)) =
      (LocalSummary.orphanTiles b).filter (fun u => decide (t u = 0)) := by
    apply List.filter_congr
    intro u hu
    rw [same u (of_decide_eq_true (List.mem_filter.mp hu).2)]
  have tileMap : (PairProfile.blockTiles b).map s = (PairProfile.blockTiles b).map t := by
    apply List.map_congr_left
    intro u hu
    exact same u ((PairProfile.mem_blockTiles b u).mp hu)
  simp only [labelOf, currentEq, addedEq, q, pair, single, missing, tileMap]

abbrev Tables := PruningPackedBridge.Tables
abbrev rawAt := PruningPackedBridge.rawAt
abbrev summaries := PruningPackedBridge.summaries

def Checked (tables : Tables) : Prop := ∀ b, b < 4 →
  PruningData.Checked b (tables b).summary ∧ checkSpan b (tables b) 0 (tables b).summary.core.size = true

def allRaw (tables : Tables) (s : PackedRules.Packed) : Label :=
  join (join (join (rawAt tables s 0) (rawAt tables s 1)) (rawAt tables s 2)) (rawAt tables s 3)

theorem checked_facts (tables : Tables) (checked : Checked tables)
    (s : PackedRules.Packed) (inside : PackedRules.inside (summaries tables) s = true)
    (b : Nat) (hb : b < 4) : Facts (rawAt tables s b) (labelOf b (PackedRules.state (summaries tables) s)) := by
  have index := PackedRules.inside_part (summaries tables) s inside b hb
  have row := checkSpan_each b (tables b) (tables b).summary.core.size 0
    (checked b hb).2 (s.get b) index
  have result := checkRow_sound b (tables b) (checked b hb).1 (s.get b) index (by simpa using row)
  have same : labelOf b ((tables b).summary.core.unrank (s.get b)) =
      labelOf b (PackedRules.state (summaries tables) s) := by
    apply label_same
    intro u hu
    simp only [PackedRules.state, summaries, PruningPackedBridge.summaries, hu]
  rw [same] at result
  exact result

/-- A kernel theorem connecting finite local checks to full SAFE filtering for
every in-range packed state; global encoding and orbit coverage are separate. -/
theorem checked_full_filter_iff_safe (tables : Tables) (checked : Checked tables)
    (s : PackedRules.Packed) (inside : PackedRules.inside (summaries tables) s = true) :
    fullSafe (allRaw tables s) ↔ IsSafe (PackedRules.state (summaries tables) s) := by
  have cache : PackedRules.Checked (summaries tables) := fun b hb => (checked b hb).1
  have valid := PackedRules.state_valid (summaries tables) cache s inside
  have f0 := checked_facts tables checked s inside 0 (by decide)
  have f1 := checked_facts tables checked s inside 1 (by decide)
  have f2 := checked_facts tables checked s inside 2 (by decide)
  have f3 := checked_facts tables checked s inside 3 (by decide)
  constructor
  · intro pass
    have early := four_block_pruning_complete _ _ _ _ pass
    have eq0 := f0.2.2.2.2 early.1.2.1
    have eq1 := f1.2.2.2.2 early.2.1.2.1
    have eq2 := f2.2.2.2.2 early.2.2.1.2.1
    have eq3 := f3.2.2.2.2 early.2.2.2.1.2.1
    unfold allRaw at pass
    rw [eq0, eq1, eq2, eq3] at pass
    exact (FullSafeSemantics.full_filter_iff_safe _ valid).mp pass
  · intro safe
    have semantic := (FullSafeSemantics.full_filter_iff_safe _ valid).mpr safe
    have below := join_mono _ _ _ _ (join_mono _ _ _ _ (join_mono _ _ _ _ f0.1 f1.1) f2.1) f3.1
    have miss : (allRaw tables s).missing = (allLabels (PackedRules.state (summaries tables) s)).missing := by
      simp only [allRaw, allLabels, join, f0.2.1, f1.2.1, f2.2.1, f3.2.1]
    have pair : (allRaw tables s).orphanPair = (allLabels (PackedRules.state (summaries tables) s)).orphanPair := by
      simp only [allRaw, allLabels, join, f0.2.2.1, f1.2.2.1, f2.2.2.1, f3.2.2.1]
    refine ⟨partial_of_below _ _ below semantic.1, ?_⟩
    rw [miss, pair]
    exact semantic.2

end Mahjong.FullSafeData

#print axioms Mahjong.FullSafeData.checkRow_sound
#print axioms Mahjong.FullSafeData.checkSpan_add
#print axioms Mahjong.FullSafeData.checkSpan_each
#print axioms Mahjong.FullSafeData.checked_full_filter_iff_safe
