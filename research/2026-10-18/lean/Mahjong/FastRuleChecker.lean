import Mahjong.MoveEnumeration

/-!
A proved optimization of RuleChecker. Meld/pair availability inspects only
the one or three involved tile kinds, rather than scanning all 34 kinds.
The mathematical Win and original move relation remain unchanged.
-/
namespace Mahjong.FastRuleChecker

open RuleChecker

theorem contains_pair_iff (s : State) (t : Tile) :
    Contains (countsOf [t, t]) s ↔ 2 ≤ s t := by
  constructor
  · intro h
    simpa [countsOf, addTile, unit, empty] using h t
  · intro h u
    by_cases hu : u = t
    · subst u; simpa [countsOf, addTile, unit, empty] using h
    · simp [countsOf, addTile, unit, empty, hu]

theorem contains_triplet_iff (s : State) (t : Tile) :
    Contains (countsOf [t, t, t]) s ↔ 3 ≤ s t := by
  constructor
  · intro h
    simpa [countsOf, addTile, unit, empty] using h t
  · intro h u
    by_cases hu : u = t
    · subst u; simpa [countsOf, addTile, unit, empty] using h
    · simp [countsOf, addTile, unit, empty, hu]

theorem contains_three_distinct_iff (s : State) (a b c : Tile)
    (hab : a ≠ b) (hac : a ≠ c) (hbc : b ≠ c) :
    Contains (countsOf [a, b, c]) s ↔ 1 ≤ s a ∧ 1 ≤ s b ∧ 1 ≤ s c := by
  constructor
  · intro h
    constructor
    · simpa [countsOf, addTile, unit, empty, hab, hac] using h a
    constructor
    · simpa [countsOf, addTile, unit, empty, Ne.symm hab, hbc] using h b
    · simpa [countsOf, addTile, unit, empty, Ne.symm hac, Ne.symm hbc] using h c
  · rintro ⟨ha, hb, hc⟩ u
    by_cases hua : u = a
    · subst u; simpa [countsOf, addTile, unit, empty, hab, hac] using ha
    by_cases hub : u = b
    · subst u; simpa [countsOf, addTile, unit, empty, Ne.symm hab, hbc] using hb
    by_cases huc : u = c
    · subst u; simpa [countsOf, addTile, unit, empty, Ne.symm hac, Ne.symm hbc] using hc
    · simp [countsOf, addTile, unit, empty, hua, hub, huc]

private theorem seq01 (suit : Fin 3) (start : Fin 7) :
    seqTile suit start 0 ≠ seqTile suit start 1 := by
  intro he
  have hi := seqTile_injective suit start he
  exact (by decide : (0 : Fin 3) ≠ 1) hi

private theorem seq02 (suit : Fin 3) (start : Fin 7) :
    seqTile suit start 0 ≠ seqTile suit start 2 := by
  intro he
  have hi := seqTile_injective suit start he
  exact (by decide : (0 : Fin 3) ≠ 2) hi

private theorem seq12 (suit : Fin 3) (start : Fin 7) :
    seqTile suit start 1 ≠ seqTile suit start 2 := by
  intro he
  have hi := seqTile_injective suit start he
  exact (by decide : (1 : Fin 3) ≠ 2) hi

def pairAvailableB (s : State) (t : Tile) : Bool := decide (2 ≤ s t)

def meldAvailableB (s : State) : Meld → Bool
  | .triplet t => decide (3 ≤ s t)
  | .sequence suit start => decide
      (1 ≤ s (seqTile suit start 0) ∧
       1 ≤ s (seqTile suit start 1) ∧
       1 ≤ s (seqTile suit start 2))

theorem pairAvailableB_eq (s : State) (t : Tile) :
    pairAvailableB s t = containsB (countsOf [t, t]) s := by
  apply Bool.eq_iff_iff.2
  change pairAvailableB s t = true ↔ containsB (countsOf [t, t]) s = true
  rw [containsB_iff, contains_pair_iff]
  simp only [pairAvailableB, decide_eq_true_eq]

theorem meldAvailableB_eq (s : State) (m : Meld) :
    meldAvailableB s m = containsB (countsOf m.tiles) s := by
  apply Bool.eq_iff_iff.2
  change meldAvailableB s m = true ↔ containsB (countsOf m.tiles) s = true
  rw [containsB_iff]
  cases m with
  | triplet t =>
    change decide (3 ≤ s t) = true ↔ Contains (countsOf [t, t, t]) s
    rw [contains_triplet_iff]
    simp only [decide_eq_true_eq]
  | sequence suit start =>
    change decide (1 ≤ s (seqTile suit start 0) ∧ 1 ≤ s (seqTile suit start 1) ∧
      1 ≤ s (seqTile suit start 2)) = true ↔ Contains
      (countsOf [seqTile suit start 0, seqTile suit start 1, seqTile suit start 2]) s
    rw [contains_three_distinct_iff s _ _ _ (seq01 suit start) (seq02 suit start)
      (seq12 suit start)]
    simp only [decide_eq_true_eq]

def removePair (s : State) (t : Tile) : State :=
  fun u => if u = t then s u - 2 else s u

def removeMeld (s : State) : Meld → State
  | .triplet t => fun u => if u = t then s u - 3 else s u
  | .sequence suit start => fun u =>
      if u = seqTile suit start 0 ∨ u = seqTile suit start 1 ∨
          u = seqTile suit start 2 then s u - 1 else s u

theorem removePair_eq (s : State) (t : Tile) :
    removePair s t = subtract s (countsOf [t, t]) := by
  funext u
  by_cases hu : u = t <;> simp [removePair, subtract, countsOf, addTile, unit, empty, hu]

theorem removeMeld_eq (s : State) (m : Meld) :
    removeMeld s m = subtract s (countsOf m.tiles) := by
  cases m with
  | triplet t =>
    funext u
    by_cases hu : u = t <;>
      simp [removeMeld, subtract, Meld.tiles, countsOf, addTile, unit, empty, hu]
  | sequence suit start =>
    funext u
    have hab := seq01 suit start
    have hac := seq02 suit start
    have hbc := seq12 suit start
    by_cases ha : u = seqTile suit start 0
    · subst u
      simp [removeMeld, subtract, Meld.tiles, countsOf, addTile, unit, empty, hab, hac]
    by_cases hb : u = seqTile suit start 1
    · subst u
      simp [removeMeld, subtract, Meld.tiles, countsOf, addTile, unit, empty, Ne.symm hab, hbc]
    by_cases hc : u = seqTile suit start 2
    · subst u
      simp [removeMeld, subtract, Meld.tiles, countsOf, addTile, unit, empty, Ne.symm hac,
        Ne.symm hbc]
    · simp [removeMeld, subtract, Meld.tiles, countsOf, addTile, unit, empty, ha, hb, hc]

def meldSearch : Nat → State → Bool
  | 0, _ => true
  | k + 1, s => allMelds.any (fun m =>
      meldAvailableB s m && meldSearch k (removeMeld s m))

theorem meldSearch_eq (k : Nat) (s : State) :
    meldSearch k s = RuleChecker.meldSearch k s := by
  induction k generalizing s with
  | zero => rfl
  | succ k ih =>
    simp only [meldSearch, RuleChecker.meldSearch, meldAvailableB_eq, removeMeld_eq, ih]

def standardB (s : State) : Bool :=
  allTiles.any (fun pair => pairAvailableB s pair && meldSearch 4 (removePair s pair))

theorem standardB_eq (s : State) : standardB s = RuleChecker.standardB s := by
  simp only [standardB, RuleChecker.standardB, pairAvailableB_eq, removePair_eq, meldSearch_eq]

def winB (s : State) : Bool :=
  validB s && (standardB s || sevenPairsB s || orphansB s)

theorem winB_eq (s : State) : winB s = RuleChecker.winB s := by
  simp only [winB, RuleChecker.winB, standardB_eq]

theorem winB_iff (s : State) (hs : Valid s) : winB s = true ↔ Win s := by
  rw [winB_eq, RuleChecker.winB_iff s hs]

def safeB (s : State) : Bool :=
  validB s && !winB s && allTiles.all (fun t =>
    if s t < 4 then !winB (addTile s t) else true)

theorem safeB_eq (s : State) : safeB s = RuleChecker.safeB s := by
  simp only [safeB, RuleChecker.safeB, winB_eq]

theorem safeB_iff (s : State) (hs : Valid s) :
    safeB s = true ↔ SafeGame.Safe Step Win s := by
  rw [safeB_eq, RuleChecker.safeB_iff s hs]

def safeSuccessors (s : State) : List State :=
  if validB s then
    allTiles.filterMap (fun kind =>
      if s kind < 4 then
        let child := addTile s kind
        if safeB child then some child else none
      else none)
  else []

theorem safeSuccessors_eq (s : State) :
    safeSuccessors s = MoveEnumeration.safeSuccessors s := by
  simp only [safeSuccessors, MoveEnumeration.safeSuccessors, safeB_eq]

theorem safeSuccessors_iff (s t : State) :
    SafeGame.SafeStep Step Win s t ↔ t ∈ safeSuccessors s := by
  rw [safeSuccessors_eq]
  exact MoveEnumeration.safeSuccessors_iff s t

end Mahjong.FastRuleChecker

#print axioms Mahjong.FastRuleChecker.winB_iff
#print axioms Mahjong.FastRuleChecker.safeB_iff
#print axioms Mahjong.FastRuleChecker.safeSuccessors_iff
