import Mahjong.Rules
import Mahjong.SafeGame

set_option maxRecDepth 8192

/-!
Executable reference checker for the independent original rules.

The standard-hand search deducts one chosen pair and four legal melds. It is
intentionally independent of the C++ profile tables and canonical index.
Contains has the SMALL table first throughout this module.
-/
namespace Mahjong.RuleChecker

def containsB (small large : Counts) : Bool :=
  allTiles.all (fun t => decide (small t ≤ large t))

theorem containsB_iff (small large : Counts) :
    containsB small large = true ↔ Contains small large := by
  simp only [containsB, List.all_eq_true, decide_eq_true_eq]
  exact ⟨fun h t => h t (mem_allTiles t), fun h t _ => h t⟩

def validB (s : State) : Bool := containsB s full

theorem validB_iff (s : State) : validB s = true ↔ Valid s := by
  exact containsB_iff s full

def subtract (large small : Counts) : Counts := fun t => large t - small t

theorem countsOf_append (xs ys : List Tile) (t : Tile) :
    countsOf (xs ++ ys) t = countsOf xs t + countsOf ys t := by
  induction xs with
  | nil => simp [countsOf, empty]
  | cons x xs ih =>
    simp [countsOf, addTile, ih, Nat.add_assoc, Nat.add_comm]

theorem countsOf_append_comm (xs ys : List Tile) :
    countsOf (xs ++ ys) = countsOf (ys ++ xs) := by
  funext t
  simp only [countsOf_append, Nat.add_comm]

theorem contains_add_iff (a b s : Counts) :
    Contains (fun t => a t + b t) s ↔
      Contains a s ∧ Contains b (subtract s a) := by
  constructor
  · intro h
    constructor
    · intro t; have ht := h t; dsimp at ht; omega
    · intro t; have ht := h t; dsimp at ht; dsimp [subtract]; omega
  · rintro ⟨ha, hb⟩ t
    have hat := ha t
    have hbt := hb t
    dsimp [subtract] at hbt
    dsimp
    omega

theorem contains_append_iff (xs ys : List Tile) (s : Counts) :
    Contains (countsOf (xs ++ ys)) s ↔
      Contains (countsOf xs) s ∧ Contains (countsOf ys) (subtract s (countsOf xs)) := by
  have he : countsOf (xs ++ ys) = (fun t => countsOf xs t + countsOf ys t) :=
    funext (countsOf_append xs ys)
  rw [he, contains_add_iff]

def meldSearch : Nat → State → Bool
  | 0, _ => true
  | k + 1, s => allMelds.any (fun m =>
      containsB (countsOf m.tiles) s &&
        meldSearch k (subtract s (countsOf m.tiles)))

theorem meldSearch_iff (k : Nat) (s : State) :
    meldSearch k s = true ↔
      ∃ ms : List Meld, ms.length = k ∧ Contains (countsOf (ms.flatMap Meld.tiles)) s := by
  induction k generalizing s with
  | zero =>
    constructor
    · intro _; exact ⟨[], rfl, empty_contains s⟩
    · intro _; rfl
  | succ k ih =>
    simp only [meldSearch, List.any_eq_true, Bool.and_eq_true, containsB_iff, ih]
    constructor
    · rintro ⟨m, _, hm, ms, hlen, hms⟩
      refine ⟨m :: ms, by simp [hlen], ?_⟩
      exact (contains_append_iff m.tiles (ms.flatMap Meld.tiles) s).2 ⟨hm, hms⟩
    · rintro ⟨ms, hlen, hms⟩
      cases ms with
      | nil => simp at hlen
      | cons m ms =>
        have hh := (contains_append_iff m.tiles (ms.flatMap Meld.tiles) s).1 hms
        exact ⟨m, mem_allMelds m, hh.1, ms, by simpa using hlen, hh.2⟩

def standardB (s : State) : Bool :=
  allTiles.any (fun pair =>
    containsB (countsOf [pair, pair]) s &&
      meldSearch 4 (subtract s (countsOf [pair, pair])))

private def fourMelds (a b c d : Meld) (i : Fin 4) : Meld :=
  match i.val with
  | 0 => a
  | 1 => b
  | 2 => c
  | _ => d

theorem standardB_iff (s : State) :
    standardB s = true ↔ ∃ h, Standard h ∧ Contains h s := by
  simp only [standardB, List.any_eq_true, Bool.and_eq_true, containsB_iff, meldSearch_iff]
  constructor
  · rintro ⟨pair, _, hp, ms, hlen, hms⟩
    cases ms with
    | nil => simp at hlen
    | cons a ms =>
      cases ms with
      | nil => simp at hlen
      | cons b ms =>
        cases ms with
        | nil => simp at hlen
        | cons c ms =>
          cases ms with
          | nil => simp at hlen
          | cons d ms =>
            have hn : ms = [] := by simpa using hlen
            subst ms
            let f := fourMelds a b c d
            refine ⟨countsOf (standardTiles f pair), ⟨f, pair, rfl⟩, ?_⟩
            have hc := (contains_append_iff [pair, pair]
              ([a, b, c, d].flatMap Meld.tiles) s).2 ⟨hp, hms⟩
            rw [countsOf_append_comm] at hc
            simpa [standardTiles, f, fourMelds, List.append_assoc] using hc
  · rintro ⟨_, ⟨f, pair, rfl⟩, hc⟩
    refine ⟨pair, mem_allTiles pair, ?_⟩
    have he : standardTiles f pair =
        ([f 0, f 1, f 2, f 3].flatMap Meld.tiles) ++ [pair, pair] := by
      simp [standardTiles, List.append_assoc]
    rw [he, countsOf_append_comm] at hc
    have hh := (contains_append_iff [pair, pair]
      ([f 0, f 1, f 2, f 3].flatMap Meld.tiles) s).1 hc
    exact ⟨hh.1, [f 0, f 1, f 2, f 3], rfl, hh.2⟩

def orphansB (s : State) : Bool :=
  orphans.any (fun pair => containsB (countsOf (pair :: orphans)) s)

theorem orphansB_iff (s : State) :
    orphansB s = true ↔ ∃ h, ThirteenOrphans h ∧ Contains h s := by
  simp only [orphansB, List.any_eq_true, containsB_iff]
  constructor
  · rintro ⟨pair, hp, hc⟩
    exact ⟨countsOf (pair :: orphans), ⟨pair, hp, rfl⟩, hc⟩
  · rintro ⟨_, ⟨pair, hp, rfl⟩, hc⟩
    exact ⟨pair, hp, hc⟩

theorem nodup_ofFn_of_injective {n : Nat} {α : Type} (f : Fin n → α)
    (hf : ∀ i j, f i = f j → i = j) : (List.ofFn f).Nodup := by
  rw [List.nodup_iff_pairwise_ne, List.pairwise_iff_getElem]
  intro i j hi hj hij he
  simp only [List.getElem_ofFn] at he
  have hv := congrArg Fin.val (hf _ _ he)
  dsimp at hv
  omega

theorem sevenPairsTiles_eq (p : Fin 7 → Tile) :
    sevenPairsTiles p = (List.ofFn p).flatMap (fun t => [t, t]) := by
  rfl

theorem countsOf_doubles (xs : List Tile) (t : Tile) :
    countsOf (xs.flatMap (fun x => [x, x])) t = 2 * xs.count t := by
  induction xs with
  | nil => simp [countsOf, empty]
  | cons x xs ih =>
    by_cases ht : t = x
    · subst t
      simp [countsOf, addTile, unit, ih, Nat.mul_add, Nat.add_assoc]
    · simp [countsOf, addTile, unit, ih, ht, Ne.symm ht]

theorem sevenPairsAsList_iff (s : State) :
    (∃ h, SevenPairs h ∧ Contains h s) ↔
    ∃ xs : List Tile, xs.length = 7 ∧ xs.Nodup ∧
      Contains (countsOf (xs.flatMap (fun t => [t, t]))) s := by
  constructor
  · rintro ⟨_, ⟨p, hp, rfl⟩, hc⟩
    exact ⟨List.ofFn p, List.length_ofFn, nodup_ofFn_of_injective p hp,
      (sevenPairsTiles_eq p) ▸ hc⟩
  · rintro ⟨xs, hlen, hn, hc⟩
    let p : Fin 7 → Tile := fun i => xs[i.val]'(by rw [hlen]; exact i.isLt)
    have hp : ∀ i j, p i = p j → i = j := by
      intro i j he
      apply Fin.ext
      exact (List.getElem_inj hn).1 he
    have hxs : List.ofFn p = xs := by
      apply List.ext_getElem
      · simp [hlen]
      · intro i hi hj
        simp only [List.getElem_ofFn]
        rfl
    refine ⟨countsOf (sevenPairsTiles p), ⟨p, hp, rfl⟩, ?_⟩
    rw [sevenPairsTiles_eq, hxs]
    exact hc

/-- Seven DISTINCT kinds with at least two copies; four copies still count once. -/
def pairKinds (s : State) : List Tile := allTiles.filter (fun t => decide (2 ≤ s t))

theorem mem_pairKinds (s : State) (t : Tile) : t ∈ pairKinds s ↔ 2 ≤ s t := by
  simp [pairKinds, mem_allTiles t]

def sevenPairsB (s : State) : Bool := decide (7 ≤ (pairKinds s).length)

theorem sevenPairsB_iff (s : State) :
    sevenPairsB s = true ↔ ∃ h, SevenPairs h ∧ Contains h s := by
  rw [sevenPairsAsList_iff]
  simp only [sevenPairsB, decide_eq_true_eq]
  constructor
  · intro hlen
    let xs := (pairKinds s).take 7
    have hxlen : xs.length = 7 := List.length_take_of_le hlen
    have hnd : (pairKinds s).Nodup := List.filter_sublist.nodup allTiles_nodup
    have hxn : xs.Nodup := (List.take_sublist 7 (pairKinds s)).nodup hnd
    refine ⟨xs, hxlen, hxn, ?_⟩
    intro t
    rw [countsOf_doubles, hxn.count]
    by_cases ht : t ∈ xs
    · rw [if_pos ht]
      exact (mem_pairKinds s t).1 (List.mem_of_mem_take ht)
    · simp [ht]
  · rintro ⟨xs, hxlen, hxn, hc⟩
    have hsub : xs ⊆ pairKinds s := by
      intro t ht
      apply (mem_pairKinds s t).2
      have hh := hc t
      rw [countsOf_doubles, hxn.count, if_pos ht] at hh
      exact hh
    have hl := hxn.length_le_of_subset hsub
    rw [hxlen] at hl
    exact hl

/-- The Valid guard makes behavior on malformed tables explicit. -/
def winB (s : State) : Bool :=
  validB s && (standardB s || sevenPairsB s || orphansB s)

theorem winB_iff_valid_and_win (s : State) :
    winB s = true ↔ Valid s ∧ Win s := by
  simp only [winB, Bool.and_eq_true, Bool.or_eq_true, validB_iff,
    standardB_iff, sevenPairsB_iff, orphansB_iff]
  constructor
  · rintro ⟨hv, hw⟩
    refine ⟨hv, ?_⟩
    rcases hw with (⟨h, hh, hc⟩ | ⟨h, hh, hc⟩) | ⟨h, hh, hc⟩
    · exact ⟨h, ⟨contains_valid hc hv, Or.inl hh⟩, hc⟩
    · exact ⟨h, ⟨contains_valid hc hv, Or.inr (Or.inl hh)⟩, hc⟩
    · exact ⟨h, ⟨contains_valid hc hv, Or.inr (Or.inr hh)⟩, hc⟩
  · rintro ⟨hv, h, hh, hc⟩
    refine ⟨hv, ?_⟩
    rcases hh.2 with hs | hp | ho
    · exact Or.inl (Or.inl ⟨h, hs, hc⟩)
    · exact Or.inl (Or.inr ⟨h, hp, hc⟩)
    · exact Or.inr ⟨h, ho, hc⟩

theorem winB_iff (s : State) (hs : Valid s) : winB s = true ↔ Win s := by
  rw [winB_iff_valid_and_win]
  exact and_iff_right hs

theorem winB_false_iff (s : State) (hs : Valid s) : winB s = false ↔ ¬ Win s := by
  rw [Bool.eq_false_iff]
  exact not_congr (winB_iff s hs)

/-- Test the current table and all 34 available physical tile-kind additions. -/
def safeB (s : State) : Bool :=
  validB s && !winB s && allTiles.all (fun t =>
    if s t < 4 then !winB (addTile s t) else true)

theorem safeB_iff (s : State) (hs : Valid s) :
    safeB s = true ↔ SafeGame.Safe Step Win s := by
  simp only [safeB, Bool.and_eq_true, Bool.not_eq_true', validB_iff,
    winB_false_iff s hs, List.all_eq_true]
  constructor
  · rintro ⟨⟨_, hn⟩, hc⟩
    refine ⟨hn, ?_⟩
    rintro u ⟨t, ht, rfl⟩
    have hh := hc t (mem_allTiles t)
    simp only [if_pos ht.2, Bool.not_eq_true'] at hh
    exact (winB_false_iff _ (valid_add hs ht.2)).1 hh
  · rintro ⟨hn, hc⟩
    refine ⟨⟨hs, hn⟩, ?_⟩
    intro t _
    by_cases ht : s t < 4
    · simp only [if_pos ht, Bool.not_eq_true']
      apply (winB_false_iff _ (valid_add hs ht)).2
      exact hc _ ⟨t, ⟨hs, ht⟩, rfl⟩
    · simp [ht]

theorem safeB_iff_valid_and_safe (s : State) :
    safeB s = true ↔ Valid s ∧ SafeGame.Safe Step Win s := by
  constructor
  · intro hb
    have hs : Valid s := by
      have hh := hb
      simp only [safeB, Bool.and_eq_true, validB_iff] at hh
      exact hh.1.1
    exact ⟨hs, (safeB_iff s hs).1 hb⟩
  · rintro ⟨hs, hsafe⟩
    exact (safeB_iff s hs).2 hsafe

end Mahjong.RuleChecker

#print axioms Mahjong.RuleChecker.standardB_iff
#print axioms Mahjong.RuleChecker.orphansB_iff
#print axioms Mahjong.RuleChecker.sevenPairsB_iff
#print axioms Mahjong.RuleChecker.winB_iff
#print axioms Mahjong.RuleChecker.safeB_iff
