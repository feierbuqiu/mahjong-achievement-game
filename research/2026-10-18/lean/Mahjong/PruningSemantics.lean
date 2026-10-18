import Mahjong.PruningAlgebra
import Mahjong.SummaryRules
import Mahjong.DownwardClosure

set_option autoImplicit false

namespace Mahjong.PruningSemantics
open PruningAlgebra

def profileOf (b : Nat) (s : State) : Profile := ⟨PairProfile.cap b s, PairProfile.paired b s⟩

def current (s : State) : Profile :=
  combine (combine (combine (profileOf 0 s) (profileOf 1 s)) (profileOf 2 s)) (profileOf 3 s)

def withLocal (b : Nat) (s : State) (p : Profile) : Profile :=
  four (if b = 0 then p else profileOf 0 s) (if b = 1 then p else profileOf 1 s)
    (if b = 2 then p else profileOf 2 s) (if b = 3 then p else profileOf 3 s)

theorem withLocal_self (b : Nat) (s : State) : withLocal b s (profileOf b s) = current s := by
  by_cases h0 : b = 0
  · subst b; rfl
  by_cases h1 : b = 1
  · subst b; rfl
  by_cases h2 : b = 2
  · subst b; rfl
  by_cases h3 : b = 3
  · subst b; rfl
  simp only [withLocal, h0, h1, h2, h3, ↓reduceIte, four, current]

theorem withLocal_unify (b : Nat) (s : State) (p q : Profile) :
    withLocal b s (unify p q) = unify (withLocal b s p) (withLocal b s q) := by
  by_cases h0 : b = 0
  · subst b; simp [withLocal, four, combine_unify_left]
  by_cases h1 : b = 1
  · subst b; simp [withLocal, four, combine_unify_right, combine_unify_left]
  by_cases h2 : b = 2
  · subst b; simp [withLocal, four, combine_unify_right, combine_unify_left]
  by_cases h3 : b = 3
  · subst b; simp [withLocal, four, combine_unify_right]
  simp only [withLocal, h0, h1, h2, h3, ↓reduceIte, unify_self]

theorem profileOf_add_other (b : Nat) (s : State) (u : Tile) (other : u.val / 9 ≠ b) :
    profileOf b (addTile s u) = profileOf b s := by
  have same : MaskedLocalBound.SameBlock b (addTile s u) s := by
    intro v hv
    apply addTile_other
    intro eq
    subst v
    exact other hv
  have eq := LocalSummary.spec_same b (addTile s u) s same
  exact congrArg (fun v : LocalSummary.Value => Profile.mk v.meld v.pair) eq

theorem withLocal_after (b : Nat) (s : State) (u : Tile) (hb : u.val / 9 = b) :
    withLocal b s (profileOf b (addTile s u)) = current (addTile s u) := by
  have each (k : Nat) : (if b = k then profileOf b (addTile s u) else profileOf k s) =
      profileOf k (addTile s u) := by
    by_cases eq : b = k
    · simp only [eq, ↓reduceIte]
    · simp only [eq, ↓reduceIte]
      exact (profileOf_add_other k s u (by omega)).symm
  simp only [withLocal, each, four, current]

def afterProfiles (b : Nat) (s : State) : List Profile :=
  ((PairProfile.blockTiles b).filter (fun u => decide (s u < 4))).map
    (fun u => profileOf b (addTile s u))

/-- Including the current profile makes the envelope nonempty. On retained
production local states this extra profile is dominated by the one-add maxima;
that local-data connection must be certified separately. -/
def addedEnvelope (b : Nat) (s : State) : Profile := envelope (profileOf b s) (afterProfiles b s)

def labelOf (b : Nat) (s : State) : Label :=
  ⟨profileOf b s, addedEnvelope b s,
   ((PairProfile.blockTiles b).filter (fun u => decide (2 ≤ s u))).length,
   (PairProfile.blockTiles b).any (fun u => decide (s u = 1)),
   ((LocalSummary.orphanTiles b).filter (fun u => decide (s u = 0))).length,
   (LocalSummary.orphanTiles b).any (fun u => decide (2 ≤ s u)),
   ((PairProfile.blockTiles b).map s).sum⟩

def allLabels (s : State) : Label :=
  join (join (join (labelOf 0 s) (labelOf 1 s)) (labelOf 2 s)) (labelOf 3 s)

theorem allLabels_pairs (s : State) : (allLabels s).pairs = (RuleChecker.pairKinds s).length := by
  simp only [allLabels, join, labelOf]
  rw [RuleChecker.pairKinds, SummaryRules.tiles_partition]
  simp only [List.filter_append, List.length_append]

theorem allLabels_single (s : State) : (allLabels s).single = true ↔ ∃ u, s u = 1 := by
  have partition : allTiles.any (fun u => decide (s u = 1)) = (allLabels s).single := by
    rw [SummaryRules.tiles_partition]
    simp only [List.any_append, allLabels, join, labelOf]
  rw [← partition, List.any_eq_true]
  simp only [mem_allTiles, true_and, decide_eq_true_eq]

/-- This ties the production-style four-profile combination to the previously
proved exact standard-hand summary, for every mathematical state. -/
theorem current_pair_iff (s : State) :
    SummaryRules.noStandardB (fun b => LocalSummary.spec b s) = true ↔ (current s).pair < 5 := by
  have combined := four_current_pair (profileOf 0 s) (profileOf 1 s) (profileOf 2 s) (profileOf 3 s)
  change contributes (current s).pair 0 ↔ _ at combined
  simp only [profileOf, contributes, Nat.add_zero] at combined
  simp only [SummaryRules.noStandardB, List.all_cons, List.all_nil, Bool.and_true,
    Bool.and_eq_true, decide_eq_true_eq, LocalSummary.spec, SummaryRules.others]
  omega

theorem current_pair_lt_of_no_win (s : State) (valid : Valid s) (no : ¬ Win s) :
    (current s).pair < 5 := by
  have summary : SummaryRules.noWinB (fun b => LocalSummary.spec b s) = true := by
    rw [SummaryRules.noWinB_spec]
    exact CapacityComplete.noWinB_of_no_win s valid no
  simp only [SummaryRules.noWinB, Bool.and_eq_true] at summary
  exact (current_pair_iff s).mp summary.2

theorem pairs_lt_of_no_win (s : State) (valid : Valid s) (no : ¬ Win s) :
    (RuleChecker.pairKinds s).length < 7 := by
  have summary : SummaryRules.noWinB (fun b => LocalSummary.spec b s) = true := by
    rw [SummaryRules.noWinB_spec]
    exact CapacityComplete.noWinB_of_no_win s valid no
  simp only [SummaryRules.noWinB, Bool.and_eq_true, Bool.not_eq_true'] at summary
  have pairs := summary.1.1
  rw [SummaryRules.sevenPairsB_spec] at pairs
  simp only [RuleChecker.sevenPairsB, decide_eq_false_iff_not] at pairs
  omega

/-- Different component maxima may use different local moves: distributivity
shows that a standard win still has a single real move (or current win). -/
theorem safe_envelope_pair_lt (b : Nat) (s : State) (valid : Valid s) (safe : IsSafe s) :
    (withLocal b s (addedEnvelope b s)).pair < 5 := by
  apply Nat.lt_of_not_ge
  intro large
  have h : contributes (withLocal b s (addedEnvelope b s)).pair 0 := by
    unfold contributes; omega
  unfold addedEnvelope at h
  rw [map_envelope (withLocal b s) (withLocal_unify b s)] at h
  rcases (contributes_envelope _ _ 0).mp h with now | later
  · rw [withLocal_self] at now
    have no := current_pair_lt_of_no_win s valid safe.1
    unfold contributes at now
    omega
  · obtain ⟨p, mem, win⟩ := later
    obtain ⟨q, hq, eq⟩ := List.mem_map.mp mem
    subst p
    obtain ⟨u, hu, eq⟩ := List.mem_map.mp hq
    subst q
    obtain ⟨hb, available⟩ := List.mem_filter.mp hu
    have block := (PairProfile.mem_blockTiles b u).mp hb
    have av : s u < 4 := of_decide_eq_true available
    rw [withLocal_after b s u block] at win
    have no := current_pair_lt_of_no_win (addTile s u) (valid_add valid av)
      (safe.2 _ ⟨u, ⟨valid, av⟩, rfl⟩)
    unfold contributes at win
    omega

theorem safe_no_six_pairs_single (s : State) (valid : Valid s) (safe : IsSafe s) :
    ¬ ((RuleChecker.pairKinds s).length = 6 ∧ ∃ u, s u = 1) := by
  rintro ⟨six, u, single⟩
  have av : s u < 4 := by omega
  have no := pairs_lt_of_no_win (addTile s u) (valid_add valid av)
    (safe.2 _ ⟨u, ⟨valid, av⟩, rfl⟩)
  have absent : u ∉ RuleChecker.pairKinds s := by
    rw [RuleChecker.mem_pairKinds, single]
    omega
  have nd : (u :: RuleChecker.pairKinds s).Nodup := by
    exact List.nodup_cons.mpr ⟨absent, List.filter_sublist.nodup allTiles_nodup⟩
  have sub : u :: RuleChecker.pairKinds s ⊆ RuleChecker.pairKinds (addTile s u) := by
    intro t ht
    apply (RuleChecker.mem_pairKinds _ _).mpr
    rcases List.mem_cons.mp ht with eq | old
    · subst t; rw [addTile_self, single]; omega
    · have already := (RuleChecker.mem_pairKinds s t).mp old
      have grows := addTile_contains s u t
      omega
  have count := nd.length_le_of_subset sub
  simp only [List.length_cons, six] at count
  omega

/-- The partial filter is now connected to original-rule SAFE for semantic
labels, including current standard wins, one-add standard threats, seven
pairs, and the six-pairs-plus-singleton shortcut. -/
theorem safe_passes_partial (s : State) (valid : Valid s) (safe : IsSafe s) :
    passesPartial (allLabels s) := by
  have added : (allLabels s).added.pair < 5 := by
    apply Nat.lt_of_not_ge
    intro large
    have contribution : contributes (allLabels s).added.pair 0 := by unfold contributes; omega
    unfold allLabels at contribution
    rw [four_added_contributes] at contribution
    have h0 := safe_envelope_pair_lt 0 s valid safe
    have h1 := safe_envelope_pair_lt 1 s valid safe
    have h2 := safe_envelope_pair_lt 2 s valid safe
    have h3 := safe_envelope_pair_lt 3 s valid safe
    simp [withLocal] at h0 h1 h2 h3
    simp only [labelOf, contributes, Nat.add_zero] at contribution
    omega
  refine ⟨?_, current_pair_lt_of_no_win s valid safe.1, added, ?_⟩
  · rw [allLabels_pairs]
    exact pairs_lt_of_no_win s valid safe.1
  · rintro ⟨six, single⟩
    apply safe_no_six_pairs_single s valid safe
    exact ⟨by simpa only [allLabels_pairs] using six, (allLabels_single s).mp single⟩

/-- All actual early pruning sites survive for every original SAFE position,
provided their local labels have the semantic interpretation defined here. -/
theorem safe_all_early_filters (s : State) (valid : Valid s) (safe : IsSafe s) :
    passesPartial (labelOf 0 s) ∧ passesPartial (labelOf 1 s) ∧
    passesPartial (labelOf 2 s) ∧ passesPartial (labelOf 3 s) ∧
    passesPartial (join (labelOf 0 s) (labelOf 1 s)) ∧
    passesPartial (join (join (labelOf 0 s) (labelOf 1 s)) (labelOf 2 s)) := by
  have all := safe_passes_partial s valid safe
  have abc := partial_left _ _ all
  have ab := partial_left _ _ abc
  exact ⟨partial_left _ _ ab, partial_right _ _ ab,
    partial_right _ _ abc, partial_right _ _ all, ab, abc⟩

/-- A deliberately one-sided data obligation suffices for no false rejection.
It does not establish that every accepted label is actually SAFE. -/
theorem bounded_data_no_false_pruning (s : State) (valid : Valid s) (safe : IsSafe s)
    (a b c h : Label)
    (ha : PruningBelow a (labelOf 0 s)) (hb : PruningBelow b (labelOf 1 s))
    (hc : PruningBelow c (labelOf 2 s)) (hh : PruningBelow h (labelOf 3 s)) :
    passesPartial a ∧ passesPartial b ∧ passesPartial c ∧ passesPartial h ∧
    passesPartial (join a b) ∧ passesPartial (join (join a b) c) := by
  have all := safe_all_early_filters s valid safe
  exact ⟨partial_of_below _ _ ha all.1, partial_of_below _ _ hb all.2.1,
    partial_of_below _ _ hc all.2.2.1, partial_of_below _ _ hh all.2.2.2.1,
    partial_of_below _ _ (join_mono _ _ _ _ ha hb) all.2.2.2.2.1,
    partial_of_below _ _ (join_mono _ _ _ _ (join_mono _ _ _ _ ha hb) hc) all.2.2.2.2.2⟩

def restrict (keep : Nat → Bool) (s : State) : State :=
  fun u => if keep (u.val / 9) then s u else 0

theorem restrict_contains (keep : Nat → Bool) (s : State) : Contains (restrict keep s) s := by
  intro u
  unfold restrict
  split <;> omega

theorem safe_restrict (keep : Nat → Bool) (s : State) (valid : Valid s) (safe : IsSafe s) :
    IsSafe (restrict keep s) := safe_of_contains (restrict_contains keep s) valid safe

/-- Original-rule SAFE states cannot be rejected for existing standard hands
or seven pairs in any retained subset of blocks. No directory assumptions. -/
theorem safe_restricted_current (keep : Nat → Bool) (s : State) (valid : Valid s) (safe : IsSafe s) :
    (current (restrict keep s)).pair < 5 ∧ (RuleChecker.pairKinds (restrict keep s)).length < 7 := by
  have v := contains_valid (restrict_contains keep s) valid
  have h := safe_restrict keep s valid safe
  exact ⟨current_pair_lt_of_no_win _ v h.1, pairs_lt_of_no_win _ v h.1⟩

/-- The same guarantee holds after every legal one-tile addition to the
restricted state. This does not yet equate the C++ compressed `add` field. -/
theorem safe_restricted_after (keep : Nat → Bool) (s : State) (valid : Valid s) (safe : IsSafe s)
    (u : Tile) (available : restrict keep s u < 4) :
    (current (addTile (restrict keep s) u)).pair < 5 ∧
    (RuleChecker.pairKinds (addTile (restrict keep s) u)).length < 7 := by
  have v := contains_valid (restrict_contains keep s) valid
  have h := safe_restrict keep s valid safe
  have nextValid := valid_add v available
  have no : ¬ Win (addTile (restrict keep s) u) :=
    h.2 _ ⟨u, ⟨v, available⟩, rfl⟩
  exact ⟨current_pair_lt_of_no_win _ nextValid no, pairs_lt_of_no_win _ nextValid no⟩

end Mahjong.PruningSemantics

#print axioms Mahjong.PruningSemantics.current_pair_iff
#print axioms Mahjong.PruningSemantics.safe_envelope_pair_lt
#print axioms Mahjong.PruningSemantics.safe_no_six_pairs_single
#print axioms Mahjong.PruningSemantics.safe_passes_partial
#print axioms Mahjong.PruningSemantics.safe_all_early_filters
#print axioms Mahjong.PruningSemantics.bounded_data_no_false_pruning
#print axioms Mahjong.PruningSemantics.safe_restricted_current
#print axioms Mahjong.PruningSemantics.safe_restricted_after
