import Mahjong.PruningData
import Mahjong.PackedRules

set_option autoImplicit false

namespace Mahjong.PruningPackedBridge
open PruningAlgebra PruningSemantics

theorem profile_same (b : Nat) (s t : State) (same : MaskedLocalBound.SameBlock b s t) :
    profileOf b s = profileOf b t :=
  congrArg (fun v : LocalSummary.Value => Profile.mk v.meld v.pair) (LocalSummary.spec_same b s t same)

theorem afterProfiles_same (b : Nat) (s t : State) (same : MaskedLocalBound.SameBlock b s t) :
    afterProfiles b s = afterProfiles b t := by
  have filters : (PairProfile.blockTiles b).filter (fun u => decide (s u < 4)) =
      (PairProfile.blockTiles b).filter (fun u => decide (t u < 4)) := by
    apply List.filter_congr
    intro u hu
    rw [same u ((PairProfile.mem_blockTiles b u).mp hu)]
  unfold afterProfiles
  rw [filters]
  apply List.map_congr_left
  intro u _
  apply profile_same
  intro v hv
  simp only [addTile, same v hv]

theorem label_same_below (b : Nat) (s t : State) (same : MaskedLocalBound.SameBlock b s t) :
    PruningBelow (labelOf b s) (labelOf b t) := by
  have pr := profile_same b s t same
  have ad : addedEnvelope b s = addedEnvelope b t := by
    simp only [addedEnvelope, pr, afterProfiles_same b s t same]
  have q := congrArg LocalSummary.Value.pairs (LocalSummary.spec_same b s t same)
  have single := LocalSummary.any_congr (PairProfile.blockTiles b)
    (fun u => decide (s u = 1)) (fun u => decide (t u = 1))
    (fun u hu => by rw [same u ((PairProfile.mem_blockTiles b u).mp hu)])
  change ProfileBelow (profileOf b s) (profileOf b t) ∧
    ProfileBelow (addedEnvelope b s) (addedEnvelope b t) ∧ _ ∧ _
  rw [pr, ad]
  refine ⟨⟨Nat.le_refl _, Nat.le_refl _⟩, ⟨Nat.le_refl _, Nat.le_refl _⟩, ?_, ?_⟩
  · exact Nat.le_of_eq q
  · intro h
    change (PairProfile.blockTiles b).any (fun u => decide (t u = 1)) = true
    change (PairProfile.blockTiles b).any (fun u => decide (s u = 1)) = true at h
    rw [← single]
    exact h

theorem below_trans (a b c : Label) (ab : PruningBelow a b) (bc : PruningBelow b c) :
    PruningBelow a c :=
  ⟨⟨Nat.le_trans ab.1.1 bc.1.1, Nat.le_trans ab.1.2 bc.1.2⟩,
   ⟨Nat.le_trans ab.2.1.1 bc.2.1.1, Nat.le_trans ab.2.1.2 bc.2.1.2⟩,
   Nat.le_trans ab.2.2.1 bc.2.2.1, fun h => bc.2.2.2 (ab.2.2.2 h)⟩

abbrev Tables := Nat → PruningData.Candidate

def summaries (tables : Tables) : PackedRules.Tables := fun b => (tables b).summary

def rawAt (tables : Tables) (s : PackedRules.Packed) (b : Nat) : Label := (tables b).raw (s.get b)

def Checked (tables : Tables) : Prop := ∀ b, b < 4 →
  PruningData.Checked b (tables b).summary ∧
    PruningData.checkSpan b (tables b) 0 (tables b).summary.core.size = true

/-- After the finite local checks, the early-filter guarantee applies to
every decoded packed SAFE state, not just the tested local rows. Encoding
coverage, canonicalization and the final orphan filter remain separate. -/
theorem checked_original_safe_survives (tables : Tables) (checked : Checked tables)
    (s : PackedRules.Packed) (inside : PackedRules.inside (summaries tables) s = true)
    (safe : IsSafe (PackedRules.state (summaries tables) s)) :
    passesPartial (rawAt tables s 0) ∧ passesPartial (rawAt tables s 1) ∧
    passesPartial (rawAt tables s 2) ∧ passesPartial (rawAt tables s 3) ∧
    passesPartial (join (rawAt tables s 0) (rawAt tables s 1)) ∧
    passesPartial (join (join (rawAt tables s 0) (rawAt tables s 1)) (rawAt tables s 2)) := by
  have cache : PackedRules.Checked (summaries tables) := fun b hb => (checked b hb).1
  have valid := PackedRules.state_valid (summaries tables) cache s inside
  have each (b : Nat) (hb : b < 4) :
      PruningBelow (rawAt tables s b) (labelOf b (PackedRules.state (summaries tables) s)) := by
    have index := PackedRules.inside_part (summaries tables) s inside b hb
    have row := PruningData.checkSpan_each b (tables b) (tables b).summary.core.size 0
      (checked b hb).2 (s.get b) index
    have rowBelow := PruningData.checkRow_sound b (tables b) (checked b hb).1 (s.get b) index (by simpa using row)
    apply below_trans _ _ _ rowBelow
    apply label_same_below
    intro u hu
    simp only [PackedRules.state, summaries, hu]
  exact bounded_data_no_false_pruning _ valid safe _ _ _ _
    (each 0 (by decide)) (each 1 (by decide)) (each 2 (by decide)) (each 3 (by decide))

end Mahjong.PruningPackedBridge

#print axioms Mahjong.PruningPackedBridge.checked_original_safe_survives
