import Std

set_option maxRecDepth 8192

/-!
Independent mathematical rules for the public cumulative Mahjong game.

Tile indices are 1m..9m,1p..9p,1s..9s,East,South,West,North,White,Green,Red.
Counts use Nat; Valid is the four-copy bound. Contains small large has the
SMALL table first (the reverse of the old SharedMahjong.lean convention).
No C++ profile, SAFE predicate, canonicalizer, index, hash, or P/N bit is used
to define the rules. In particular Win is a 14-tile SUBMULTISET predicate.
-/
namespace Mahjong

abbrev Tile := Fin 34
abbrev Copy := Fin 4
abbrev PhysicalTile := Tile × Copy
abbrev Counts := Tile → Nat
abbrev State := Counts

def allTiles : List Tile :=
  [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16,
   17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33]

def allCopies : List Copy := [0, 1, 2, 3]

def allPhysicalTiles : List PhysicalTile :=
  allTiles.flatMap (fun t => allCopies.map (fun c => (t, c)))

theorem allTiles_length : allTiles.length = 34 := by decide
theorem allTiles_nodup : allTiles.Nodup := by decide
theorem mem_allTiles (t : Tile) : t ∈ allTiles :=
  (by decide : ∀ t : Tile, t ∈ allTiles) t
theorem allPhysicalTiles_length : allPhysicalTiles.length = 136 := by decide
theorem allPhysicalTiles_nodup : allPhysicalTiles.Nodup := by decide
theorem mem_allPhysicalTiles (t : Tile) (c : Copy) : (t, c) ∈ allPhysicalTiles :=
  (by decide : ∀ t : Tile, ∀ c : Copy, (t, c) ∈ allPhysicalTiles) t c

def Valid (s : State) : Prop := ∀ t, s t ≤ 4
def Contains (small large : Counts) : Prop := ∀ t, small t ≤ large t
def empty : State := fun _ => 0
def full : State := fun _ => 4
def unit (t : Tile) : Counts := fun u => if u = t then 1 else 0
def addTile (s : State) (t : Tile) : State := fun u => s u + unit t u
def LegalAdd (s : State) (t : Tile) : Prop := Valid s ∧ s t < 4
def Step (s u : State) : Prop := ∃ t, LegalAdd s t ∧ u = addTile s t

/-- A transparent finite sum; no external finite-set library is required. -/
def sumAlong : List Tile → Counts → Nat
  | [], _ => 0
  | t :: ts, s => s t + sumAlong ts s

def total (s : State) : Nat := sumAlong allTiles s
def stock (s : State) : Nat := 136 - total s

@[simp] theorem unit_self (t : Tile) : unit t t = 1 := by simp [unit]
@[simp] theorem addTile_self (s : State) (t : Tile) : addTile s t t = s t + 1 :=
  by simp [addTile]
theorem addTile_other (s : State) {t u : Tile} (h : u ≠ t) :
    addTile s t u = s u := by simp [addTile, unit, h]

theorem empty_valid : Valid empty := by intro t; simp [empty]
theorem full_valid : Valid full := by intro t; simp [full]
theorem contains_refl (s : Counts) : Contains s s := fun _ => Nat.le_refl _
theorem contains_trans {a b c : Counts} (hab : Contains a b) (hbc : Contains b c) :
    Contains a c := fun t => Nat.le_trans (hab t) (hbc t)
theorem empty_contains (s : Counts) : Contains empty s := fun _ => Nat.zero_le _
theorem addTile_contains (s : State) (t : Tile) : Contains s (addTile s t) := by
  intro u
  exact Nat.le_add_right _ _
theorem contains_valid {small large : Counts} (h : Contains small large)
    (hv : Valid large) : Valid small := fun t => Nat.le_trans (h t) (hv t)

theorem valid_add {s : State} {t : Tile} (hs : Valid s) (ht : s t < 4) :
    Valid (addTile s t) := by
  intro u
  by_cases h : u = t
  · subst u
    simp only [addTile_self]
    omega
  · simpa [addTile, unit, h] using hs u

theorem step_source_valid {s u : State} (h : Step s u) : Valid s := by
  obtain ⟨t, ht, _⟩ := h
  exact ht.1

theorem step_target_valid {s u : State} (h : Step s u) : Valid u := by
  obtain ⟨t, ht, rfl⟩ := h
  exact valid_add ht.1 ht.2

theorem step_contains {s u : State} (h : Step s u) : Contains s u := by
  obtain ⟨t, _, rfl⟩ := h
  exact addTile_contains s t

theorem sumAlong_add (ts : List Tile) (a b : Counts) :
    sumAlong ts (fun t => a t + b t) = sumAlong ts a + sumAlong ts b := by
  induction ts with
  | nil => rfl
  | cons t ts ih =>
    simp [sumAlong, ih, Nat.add_assoc, Nat.add_left_comm]

theorem sumAlong_mono (ts : List Tile) {a b : Counts} (h : Contains a b) :
    sumAlong ts a ≤ sumAlong ts b := by
  induction ts with
  | nil => exact Nat.le_refl 0
  | cons t ts ih => exact Nat.add_le_add (h t) ih

theorem sumAlong_bound (ts : List Tile) {s : State} (hs : Valid s) :
    sumAlong ts s ≤ ts.length * 4 := by
  induction ts with
  | nil => simp [sumAlong]
  | cons t ts ih =>
    simp only [sumAlong, List.length_cons]
    have ht := hs t
    omega

theorem total_mono {a b : Counts} (h : Contains a b) : total a ≤ total b :=
  sumAlong_mono allTiles h

theorem total_le_136 {s : State} (hs : Valid s) : total s ≤ 136 := by
  have h := sumAlong_bound allTiles hs
  simpa [total, allTiles_length] using h

@[simp] theorem total_empty : total empty = 0 := by rfl
@[simp] theorem total_full : total full = 136 := by rfl
@[simp] theorem total_unit (t : Tile) : total (unit t) = 1 :=
  (by decide : ∀ t : Tile, total (unit t) = 1) t

@[simp] theorem total_addTile (s : State) (t : Tile) :
    total (addTile s t) = total s + 1 := by
  change sumAlong allTiles (fun u => s u + unit t u) = total s + 1
  rw [sumAlong_add]
  change total s + total (unit t) = total s + 1
  rw [total_unit]

theorem step_total_succ {s u : State} (h : Step s u) : total u = total s + 1 := by
  obtain ⟨t, _, rfl⟩ := h
  exact total_addTile s t

theorem stock_strict {s : State} {t : Tile} (h : LegalAdd s t) :
    stock (addTile s t) < stock s := by
  have hb := total_le_136 (valid_add h.1 h.2)
  rw [total_addTile] at hb
  simp only [stock, total_addTile]
  omega

theorem step_stock_strict {s u : State} (h : Step s u) : stock u < stock s := by
  obtain ⟨t, ht, rfl⟩ := h
  exact stock_strict ht

theorem legalAdd_iff_remaining {s : State} (hs : Valid s) (t : Tile) :
    LegalAdd s t ↔ 0 < 4 - s t := by
  simp only [LegalAdd]
  constructor
  · intro h; omega
  · intro h; exact ⟨hs, by omega⟩

/-- Canonical realization using distinct physical copies numbered 0..3. -/
def Used (s : State) (e : PhysicalTile) : Prop := e.2.val < s e.1
def nextCopy (s : State) (t : Tile) (h : s t < 4) : PhysicalTile := (t, ⟨s t, h⟩)

theorem nextCopy_not_used (s : State) (t : Tile) (h : s t < 4) :
    ¬ Used s (nextCopy s t h) := by simp [Used, nextCopy]

theorem used_addTile_iff (s : State) (t : Tile) (e : PhysicalTile) :
    Used (addTile s t) e ↔ Used s e ∨ (e.1 = t ∧ e.2.val = s t) := by
  by_cases ht : e.1 = t
  · simp only [Used, addTile, unit, ht, if_true, true_and]
    omega
  · simp [Used, addTile, unit, ht]

theorem nextCopy_used_after_add (s : State) (t : Tile) (h : s t < 4) :
    Used (addTile s t) (nextCopy s t h) := by
  simp [Used, nextCopy, addTile_self]

/-! The three independent 14-tile target constructors. -/

def seqTile (suit : Fin 3) (start : Fin 7) (offset : Fin 3) : Tile :=
  ⟨9 * suit.val + start.val + offset.val, by omega⟩

theorem seqTile_is_numeric (suit : Fin 3) (start : Fin 7) (offset : Fin 3) :
    (seqTile suit start offset).val < 27 := by
  have hs := suit.isLt
  have hr := start.isLt
  have hk := offset.isLt
  dsimp [seqTile]
  omega

theorem seqTile_same_suit (suit : Fin 3) (start : Fin 7) (offset : Fin 3) :
    (seqTile suit start offset).val / 9 = suit.val := by
  have hr := start.isLt
  have hk := offset.isLt
  dsimp [seqTile]
  omega

theorem seqTile_injective (suit : Fin 3) (start : Fin 7) {i j : Fin 3}
    (h : seqTile suit start i = seqTile suit start j) : i = j := by
  apply Fin.ext
  have hv := congrArg Fin.val h
  dsimp [seqTile] at hv
  omega

inductive Meld where
  | triplet (tile : Tile)
  | sequence (suit : Fin 3) (start : Fin 7)
  deriving DecidableEq, Repr

def Meld.tiles : Meld → List Tile
  | .triplet t => [t, t, t]
  | .sequence suit start =>
      [seqTile suit start 0, seqTile suit start 1, seqTile suit start 2]

@[simp] theorem Meld.tiles_length (m : Meld) : m.tiles.length = 3 := by
  cases m <;> rfl

def allMelds : List Meld :=
  allTiles.map Meld.triplet ++
  ([0, 1, 2] : List (Fin 3)).flatMap (fun suit =>
    ([0, 1, 2, 3, 4, 5, 6] : List (Fin 7)).map (Meld.sequence suit))

theorem allMelds_length : allMelds.length = 55 := by decide
theorem mem_allMelds (m : Meld) : m ∈ allMelds := by
  cases m with
  | triplet t => exact (by decide : ∀ t : Tile, Meld.triplet t ∈ allMelds) t
  | sequence suit start =>
    exact (by decide : ∀ s : Fin 3, ∀ r : Fin 7, Meld.sequence s r ∈ allMelds) suit start

def countsOf : List Tile → Counts
  | [] => empty
  | t :: ts => addTile (countsOf ts) t

@[simp] theorem countsOf_total (ts : List Tile) : total (countsOf ts) = ts.length := by
  induction ts with
  | nil => rfl
  | cons t ts ih => simp [countsOf, total_addTile, ih]

def standardTiles (melds : Fin 4 → Meld) (pair : Tile) : List Tile :=
  (melds 0).tiles ++ (melds 1).tiles ++ (melds 2).tiles ++ (melds 3).tiles ++ [pair, pair]

theorem standardTiles_length (melds : Fin 4 → Meld) (pair : Tile) :
    (standardTiles melds pair).length = 14 := by simp [standardTiles]

def Standard (h : Counts) : Prop :=
  ∃ (melds : Fin 4 → Meld) (pair : Tile), h = countsOf (standardTiles melds pair)

def sevenPairsTiles (p : Fin 7 → Tile) : List Tile :=
  [p 0, p 0, p 1, p 1, p 2, p 2, p 3, p 3, p 4, p 4, p 5, p 5, p 6, p 6]

def SevenPairs (h : Counts) : Prop :=
  ∃ p : Fin 7 → Tile, (∀ i j, p i = p j → i = j) ∧ h = countsOf (sevenPairsTiles p)

def orphans : List Tile := [0, 8, 9, 17, 18, 26, 27, 28, 29, 30, 31, 32, 33]
theorem orphans_length : orphans.length = 13 := by decide
theorem orphans_nodup : orphans.Nodup := by decide

def ThirteenOrphans (h : Counts) : Prop :=
  ∃ pair : Tile, pair ∈ orphans ∧ h = countsOf (pair :: orphans)

def WinningHand (h : Counts) : Prop :=
  Valid h ∧ (Standard h ∨ SevenPairs h ∨ ThirteenOrphans h)

def Win (s : State) : Prop := ∃ h, WinningHand h ∧ Contains h s

theorem standard_total {h : Counts} (hh : Standard h) : total h = 14 := by
  obtain ⟨melds, pair, rfl⟩ := hh
  rw [countsOf_total, standardTiles_length]

theorem sevenPairs_total {h : Counts} (hh : SevenPairs h) : total h = 14 := by
  obtain ⟨p, _, rfl⟩ := hh
  rw [countsOf_total]
  rfl

theorem thirteenOrphans_total {h : Counts} (hh : ThirteenOrphans h) : total h = 14 := by
  obtain ⟨pair, _, rfl⟩ := hh
  rw [countsOf_total]
  rfl

theorem winningHand_total {h : Counts} (hh : WinningHand h) : total h = 14 := by
  rcases hh.2 with hs | hp | ho
  · exact standard_total hs
  · exact sevenPairs_total hp
  · exact thirteenOrphans_total ho

theorem winningHand_valid {h : Counts} (hh : WinningHand h) : Valid h := hh.1

theorem win_iff_contains_14 (s : State) :
    Win s ↔ ∃ h, WinningHand h ∧ total h = 14 ∧ Contains h s := by
  constructor
  · rintro ⟨h, hh, hc⟩
    exact ⟨h, hh, winningHand_total hh, hc⟩
  · rintro ⟨h, hh, _, hc⟩
    exact ⟨h, hh, hc⟩

theorem win_mono {s u : State} (h : Contains s u) (hs : Win s) : Win u := by
  obtain ⟨target, ht, hc⟩ := hs
  exact ⟨target, ht, contains_trans hc h⟩

theorem win_after_add {s : State} (hs : Win s) (t : Tile) : Win (addTile s t) :=
  win_mono (addTile_contains s t) hs

theorem win_total_ge_14 {s : State} (hs : Win s) : 14 ≤ total s := by
  obtain ⟨h, hh, hc⟩ := hs
  have hm := total_mono hc
  rw [winningHand_total hh] at hm
  exact hm

theorem not_win_of_total_lt_14 {s : State} (h : total s < 14) : ¬ Win s := by
  intro hw
  have := win_total_ge_14 hw
  omega

theorem empty_not_win : ¬ Win empty := not_win_of_total_lt_14 (by decide)

def fullWitnessMelds (i : Fin 4) : Meld := .triplet ⟨27 + i.val, by omega⟩
def fullWitness : Counts := countsOf (standardTiles fullWitnessMelds 31)

theorem fullWitness_valid : Valid fullWitness := by
  unfold Valid
  decide

theorem full_win : Win full := by
  refine ⟨fullWitness, ?_, ?_⟩
  · exact ⟨fullWitness_valid, Or.inl ⟨fullWitnessMelds, 31, rfl⟩⟩
  · exact fullWitness_valid

/-- There is no exhausted-stock draw in a valid nonwinning position. -/
theorem nonwinning_has_legal_add {s : State} (hs : Valid s) (hn : ¬ Win s) :
    ∃ t, LegalAdd s t := by
  classical
  by_cases hm : ∃ t : Tile, s t < 4
  · obtain ⟨t, ht⟩ := hm
    exact ⟨t, hs, ht⟩
  · have he : s = full := by
      funext t
      have hbound := hs t
      have hnot : ¬ s t < 4 := fun ht => hm ⟨t, ht⟩
      change s t = 4
      omega
    exfalso
    apply hn
    rw [he]
    exact full_win

theorem nonwinning_has_step {s : State} (hs : Valid s) (hn : ¬ Win s) :
    ∃ u, Step s u := by
  obtain ⟨t, ht⟩ := nonwinning_has_legal_add hs hn
  exact ⟨addTile s t, t, ht, rfl⟩

end Mahjong

#print axioms Mahjong.step_stock_strict
#print axioms Mahjong.winningHand_total
#print axioms Mahjong.win_iff_contains_14
#print axioms Mahjong.win_mono
#print axioms Mahjong.nonwinning_has_legal_add
