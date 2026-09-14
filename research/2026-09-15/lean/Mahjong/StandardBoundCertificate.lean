import Mahjong.FastRuleChecker

/-!
Small, independently checked negative certificates for ordinary Mahjong hands.
For each possible pair, four claimed bounds concern the number of melds in
each numeric suit and honors. Each bound is checked by a local search only.
The soundness proof partitions an arbitrary four-meld witness; it does not
assume C++ profiles, a state quotient, or any external table is correct.
-/
namespace Mahjong.StandardBoundCertificate

open RuleChecker

def meldBlock : Meld → Nat
  | .triplet t => t.val / 9
  | .sequence suit _ => suit.val

theorem meldBlock_lt_four (m : Meld) : meldBlock m < 4 := by
  cases m with
  | triplet t => have ht := t.isLt; dsimp [meldBlock]; omega
  | sequence suit start => have hs := suit.isLt; dsimp [meldBlock]; omega

def localMelds (b : Nat) : List Meld :=
  allMelds.filter (fun m => decide (meldBlock m = b))

theorem mem_localMelds (b : Nat) (m : Meld) : m ∈ localMelds b ↔ meldBlock m = b := by
  simp [localMelds, mem_allMelds m]

def searchWith (allowed : List Meld) : Nat → State → Bool
  | 0, _ => true
  | k + 1, s => allowed.any (fun m =>
      FastRuleChecker.meldAvailableB s m && searchWith allowed k (FastRuleChecker.removeMeld s m))

theorem searchWith_iff (allowed : List Meld) (k : Nat) (s : State) :
    searchWith allowed k s = true ↔
      ∃ ms : List Meld, ms.length = k ∧ (∀ m, m ∈ ms → m ∈ allowed) ∧
        Contains (countsOf (ms.flatMap Meld.tiles)) s := by
  induction k generalizing s with
  | zero =>
    constructor
    · intro _; exact ⟨[], rfl, by simp, empty_contains s⟩
    · intro _; rfl
  | succ k ih =>
    simp only [searchWith, List.any_eq_true, Bool.and_eq_true,
      FastRuleChecker.meldAvailableB_eq, containsB_iff, FastRuleChecker.removeMeld_eq, ih]
    constructor
    · rintro ⟨m, hm, ha, ms, hl, hallowed, hc⟩
      refine ⟨m :: ms, by simp [hl], ?_, ?_⟩
      · intro n hn
        rcases List.mem_cons.1 hn with rfl | hn
        · exact hm
        · exact hallowed n hn
      · exact (contains_append_iff m.tiles (ms.flatMap Meld.tiles) s).2 ⟨ha, hc⟩
    · rintro ⟨ms, hl, hallowed, hc⟩
      cases ms with
      | nil => simp at hl
      | cons m ms =>
        have hh := (contains_append_iff m.tiles (ms.flatMap Meld.tiles) s).1 hc
        refine ⟨m, hallowed m (by simp), hh.1, ms, by simpa using hl, ?_, hh.2⟩
        intro n hn
        exact hallowed n (List.mem_cons_of_mem _ hn)

theorem packing_sublist_mono {ms ns : List Meld} (h : ms.Sublist ns) :
    Contains (countsOf (ms.flatMap Meld.tiles)) (countsOf (ns.flatMap Meld.tiles)) := by
  induction h with
  | slnil => exact contains_refl _
  | cons m h ih =>
    intro t
    have ht := ih t
    simp only [List.flatMap_cons, countsOf_append]
    omega
  | cons_cons m h ih =>
    intro t
    simp only [List.flatMap_cons, countsOf_append]
    exact Nat.add_le_add_left (ih t) _

def blockMelds (ms : List Meld) (b : Nat) : List Meld :=
  ms.filter (fun m => decide (meldBlock m = b))

theorem partition_length (ms : List Meld) :
    (blockMelds ms 0).length + (blockMelds ms 1).length +
      (blockMelds ms 2).length + (blockMelds ms 3).length = ms.length := by
  induction ms with
  | nil => rfl
  | cons m ms ih =>
    have hm := meldBlock_lt_four m
    have hc : meldBlock m = 0 ∨ meldBlock m = 1 ∨ meldBlock m = 2 ∨ meldBlock m = 3 := by
      omega
    simp only [blockMelds] at ih ⊢
    rcases hc with hc | hc | hc | hc <;>
      simp [hc] <;> omega

theorem local_negative_bound (b cap : Nat) (s : State)
    (checked : searchWith (localMelds b) (cap + 1) s = false)
    (ms : List Meld) (contained : Contains (countsOf (ms.flatMap Meld.tiles)) s) :
    (blockMelds ms b).length ≤ cap := by
  by_cases hn : (blockMelds ms b).length ≤ cap
  · exact hn
  exfalso
  have hlen : cap + 1 ≤ (blockMelds ms b).length := by omega
  have hsub : (blockMelds ms b).Sublist ms := List.filter_sublist
  have hcontained := contains_trans (packing_sublist_mono hsub) contained
  have hall : ∀ m, m ∈ blockMelds ms b → m ∈ localMelds b := by
    intro m hm
    apply (mem_localMelds b m).2
    exact of_decide_eq_true (List.mem_filter.1 hm).2
  have hpref : searchWith (localMelds b) (cap + 1) s = true := by
    apply (searchWith_iff _ _ _).2
    refine ⟨(blockMelds ms b).take (cap + 1), List.length_take_of_le hlen, ?_, ?_⟩
    · intro m hm
      exact hall m (List.mem_of_mem_take hm)
    · exact contains_trans (packing_sublist_mono (List.take_sublist _ _)) hcontained
  rw [checked] at hpref
  contradiction

structure Caps where
  suit0 : Nat
  suit1 : Nat
  suit2 : Nat
  honors : Nat
  deriving DecidableEq, Repr

def Caps.total (c : Caps) : Nat := c.suit0 + c.suit1 + c.suit2 + c.honors

def checkAfterPair (s : State) (c : Caps) : Bool :=
  decide (c.total < 4) &&
    (!searchWith (localMelds 0) (c.suit0 + 1) s &&
      (!searchWith (localMelds 1) (c.suit1 + 1) s &&
        (!searchWith (localMelds 2) (c.suit2 + 1) s &&
          !searchWith (localMelds 3) (c.honors + 1) s)))

theorem checkAfterPair_sound (s : State) (c : Caps) (checked : checkAfterPair s c = true) :
    ¬ ∃ ms : List Meld, ms.length = 4 ∧ Contains (countsOf (ms.flatMap Meld.tiles)) s := by
  simp only [checkAfterPair, Bool.and_eq_true, Bool.not_eq_true', decide_eq_true_eq] at checked
  obtain ⟨hsum, h0, h1, h2, h3⟩ := checked
  rintro ⟨ms, hlen, hc⟩
  have hb0 := local_negative_bound 0 c.suit0 s h0 ms hc
  have hb1 := local_negative_bound 1 c.suit1 s h1 ms hc
  have hb2 := local_negative_bound 2 c.suit2 s h2 ms hc
  have hb3 := local_negative_bound 3 c.honors s h3 ms hc
  have hp := partition_length ms
  dsimp [Caps.total] at hsum
  omega

abbrev StandardBoundCert := Tile → Caps

def checkStandardBound (s : State) (cert : StandardBoundCert) : Bool :=
  allTiles.all (fun pair =>
    if FastRuleChecker.pairAvailableB s pair then
      checkAfterPair (FastRuleChecker.removePair s pair) (cert pair)
    else true)

theorem checkStandardBound_sound (s : State) (cert : StandardBoundCert)
    (checked : checkStandardBound s cert = true) :
    ¬ ∃ h, Standard h ∧ Contains h s := by
  simp only [checkStandardBound, List.all_eq_true] at checked
  intro hw
  have hb := (standardB_iff s).2 hw
  simp only [RuleChecker.standardB, List.any_eq_true, Bool.and_eq_true,
    containsB_iff, RuleChecker.meldSearch_iff] at hb
  obtain ⟨pair, _, hp, ms, hl, hc⟩ := hb
  have hpB : FastRuleChecker.pairAvailableB s pair = true := by
    rw [FastRuleChecker.pairAvailableB_eq, containsB_iff]
    exact hp
  have hh := checked pair (mem_allTiles pair)
  simp only [hpB, ↓reduceIte, FastRuleChecker.removePair_eq] at hh
  exact checkAfterPair_sound _ _ hh ⟨ms, hl, hc⟩

/-- A failed or unhelpful certificate falls back to the exact proved checker. -/
def certifiedStandardB (s : State) (cert : StandardBoundCert) : Bool :=
  if checkStandardBound s cert then false else FastRuleChecker.standardB s

theorem certifiedStandardB_eq (s : State) (cert : StandardBoundCert) :
    certifiedStandardB s cert = FastRuleChecker.standardB s := by
  by_cases hc : checkStandardBound s cert = true
  · have hn : FastRuleChecker.standardB s = false := by
      apply Bool.eq_false_iff.2
      intro hp
      rw [FastRuleChecker.standardB_eq] at hp
      exact checkStandardBound_sound s cert hc ((standardB_iff s).1 hp)
    simp only [certifiedStandardB, hc, ↓reduceIte, hn]
  · simp [certifiedStandardB, hc]

def certifiedWinB (s : State) (cert : StandardBoundCert) : Bool :=
  validB s && (certifiedStandardB s cert || sevenPairsB s || orphansB s)

theorem certifiedWinB_eq (s : State) (cert : StandardBoundCert) :
    certifiedWinB s cert = FastRuleChecker.winB s := by
  simp only [certifiedWinB, FastRuleChecker.winB, certifiedStandardB_eq]

theorem certifiedWinB_iff (s : State) (cert : StandardBoundCert) (hs : Valid s) :
    certifiedWinB s cert = true ↔ Win s := by
  rw [certifiedWinB_eq, FastRuleChecker.winB_iff s hs]

def certifiedSafeB (s : State) (base : StandardBoundCert)
    (children : Tile → StandardBoundCert) : Bool :=
  validB s && !certifiedWinB s base && allTiles.all (fun t =>
    if s t < 4 then !certifiedWinB (addTile s t) (children t) else true)

theorem certifiedSafeB_eq (s : State) (base : StandardBoundCert)
    (children : Tile → StandardBoundCert) :
    certifiedSafeB s base children = FastRuleChecker.safeB s := by
  simp only [certifiedSafeB, FastRuleChecker.safeB, certifiedWinB_eq]

theorem certifiedSafeB_iff (s : State) (base : StandardBoundCert)
    (children : Tile → StandardBoundCert) (hs : Valid s) :
    certifiedSafeB s base children = true ↔ SafeGame.Safe Step Win s := by
  rw [certifiedSafeB_eq, FastRuleChecker.safeB_iff s hs]

/-- Certificate-only entry point: no silent expensive fallback during checking. -/
def checkNoWin (s : State) (cert : StandardBoundCert) : Bool :=
  validB s && (checkStandardBound s cert && (!sevenPairsB s && !orphansB s))

theorem checkNoWin_sound (s : State) (cert : StandardBoundCert)
    (checked : checkNoWin s cert = true) : Valid s ∧ ¬ Win s := by
  simp only [checkNoWin, Bool.and_eq_true, Bool.not_eq_true', validB_iff] at checked
  obtain ⟨hv, hstd, hpairs, horphans⟩ := checked
  refine ⟨hv, ?_⟩
  rintro ⟨h, hh, hc⟩
  rcases hh.2 with hstdShape | hpairsShape | horphansShape
  · exact checkStandardBound_sound s cert hstd ⟨h, hstdShape, hc⟩
  · have hp := (sevenPairsB_iff s).2 ⟨h, hpairsShape, hc⟩
    rw [hpairs] at hp
    contradiction
  · have hp := (orphansB_iff s).2 ⟨h, horphansShape, hc⟩
    rw [horphans] at hp
    contradiction

def checkSafe (s : State) (base : StandardBoundCert)
    (children : Tile → StandardBoundCert) : Bool :=
  checkNoWin s base && allTiles.all (fun t =>
    if s t < 4 then checkNoWin (addTile s t) (children t) else true)

theorem checkSafe_sound (s : State) (base : StandardBoundCert)
    (children : Tile → StandardBoundCert)
    (checked : checkSafe s base children = true) : Valid s ∧ SafeGame.Safe Step Win s := by
  simp only [checkSafe, Bool.and_eq_true, List.all_eq_true] at checked
  have hs := checkNoWin_sound s base checked.1
  refine ⟨hs.1, hs.2, ?_⟩
  rintro _ ⟨t, ht, rfl⟩
  have hc := checked.2 t (mem_allTiles t)
  simp only [if_pos ht.2] at hc
  exact (checkNoWin_sound _ (children t) hc).2

end Mahjong.StandardBoundCertificate

#print axioms Mahjong.StandardBoundCertificate.checkStandardBound_sound
#print axioms Mahjong.StandardBoundCertificate.certifiedWinB_eq
#print axioms Mahjong.StandardBoundCertificate.checkSafe_sound
