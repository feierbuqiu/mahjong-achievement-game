import Mahjong.PairProfile
import Mahjong.LocalCache

namespace Mahjong.LocalSummary
open PairProfile

structure Value where
  meld : Nat
  pair : Nat
  pairs : Nat
  orphanAll : Bool
  orphanPair : Bool
  deriving DecidableEq, Repr

def orphanTiles (b : Nat) : List Tile := orphans.filter (fun u => decide (u.val / 9 = b))

def spec (b : Nat) (s : State) : Value :=
  ⟨cap b s, paired b s,
    ((blockTiles b).filter (fun u => decide (2 ≤ s u))).length,
    (orphanTiles b).all (fun u => decide (1 ≤ s u)),
    (orphanTiles b).any (fun u => decide (2 ≤ s u))⟩

theorem maxMap_congr (xs : List Tile) (f g : Tile → Nat)
    (same : ∀ t, t ∈ xs → f t = g t) : maxMap xs f = maxMap xs g := by
  induction xs with
  | nil => rfl
  | cons t ts ih =>
    change max (f t) (maxMap ts f) = max (g t) (maxMap ts g)
    rw [same t (by simp), ih (fun u hu => same u (List.mem_cons_of_mem t hu))]

theorem all_congr (xs : List Tile) (f g : Tile → Bool)
    (same : ∀ t, t ∈ xs → f t = g t) : xs.all f = xs.all g := by
  induction xs with
  | nil => rfl
  | cons t ts ih =>
    simp only [List.all_cons]
    rw [same t (by simp), ih (fun u hu => same u (List.mem_cons_of_mem t hu))]

theorem any_congr (xs : List Tile) (f g : Tile → Bool)
    (same : ∀ t, t ∈ xs → f t = g t) : xs.any f = xs.any g := by
  induction xs with
  | nil => rfl
  | cons t ts ih =>
    simp only [List.any_cons]
    rw [same t (by simp), ih (fun u hu => same u (List.mem_cons_of_mem t hu))]

theorem cap_same (b : Nat) (s t : State) (same : MaskedLocalBound.SameBlock b s t) :
    cap b s = cap b t := by
  have h (k : Nat) := MaskedLocalBound.search_local_eq b k s t same
  simp only [cap, FactorizedRules.capacity, h]

theorem spec_same (b : Nat) (s t : State) (same : MaskedLocalBound.SameBlock b s t) :
    spec b s = spec b t := by
  have pair : paired b s = paired b t := by
    apply maxMap_congr
    intro p hp
    have equal := same p ((mem_blockTiles b p).mp hp)
    have capeq := cap_same b (FastRuleChecker.removePair s p) (FastRuleChecker.removePair t p)
      (MaskedLocalBound.sameBlock_removePair same p)
    change FactorizedRules.capacity b _ = FactorizedRules.capacity b _ at capeq
    simp only [pairedValue, FastRuleChecker.pairAvailableB, equal, capeq]
    rfl
  have pairs : (blockTiles b).filter (fun u => decide (2 ≤ s u)) =
      (blockTiles b).filter (fun u => decide (2 ≤ t u)) := by
    apply List.filter_congr
    intro u hu
    rw [same u ((mem_blockTiles b u).mp hu)]
  have oh (u : Tile) (hu : u ∈ orphanTiles b) : s u = t u :=
    same u (of_decide_eq_true (List.mem_filter.mp hu).2)
  have present := all_congr (orphanTiles b) (fun u => decide (1 ≤ s u))
    (fun u => decide (1 ≤ t u)) (fun u hu => by rw [oh u hu])
  have duplicate := any_congr (orphanTiles b) (fun u => decide (2 ≤ s u))
    (fun u => decide (2 ≤ t u)) (fun u hu => by rw [oh u hu])
  simp only [spec, cap_same b s t same, pair, pairs, present, duplicate]

def coreCap (core : LocalCache.Candidate) (i : Nat) : Nat :=
  if core.value i 1 == false then 0 else if core.value i 2 == false then 1
  else if core.value i 3 == false then 2 else if core.value i 4 == false then 3 else 4

theorem coreCap_eq (b : Nat) (core : LocalCache.Candidate) (checked : LocalCache.check b core = true)
    (i : Nat) (inside : i < core.size) : coreCap core i = cap b (core.unrank i) := by
  have h (k : Nat) (hk : k ≤ 4) := LocalCache.check_sound b core checked k hk i inside
  simp only [coreCap, cap, FactorizedRules.capacity, h 1 (by decide), h 2 (by decide),
    h 3 (by decide), h 4 (by decide)]

structure Candidate where
  core : LocalCache.Candidate
  value : Nat → Value
  next : Nat → Tile → Nat
  available : Nat → Tile → Bool

def referencePair (table : Candidate) (s : State) (p : Tile) : Nat :=
  if FastRuleChecker.pairAvailableB s p then
    coreCap table.core (table.core.rank (FastRuleChecker.removePair s p)) + 1 else 0

def checkRow (b : Nat) (table : Candidate) (i : Nat) : Bool :=
  let s := table.core.unrank i
  let v := table.value i
  (blockTiles b).all (fun u => decide (s u ≤ 4)) &&
  (blockTiles b).all (fun p => if FastRuleChecker.pairAvailableB s p then
    LocalCache.checkRef b table.core (FastRuleChecker.removePair s p) else true) &&
  decide (v.meld = coreCap table.core i) &&
  decide (v.pair = maxMap (blockTiles b) (referencePair table s)) &&
  decide (v.pairs = ((blockTiles b).filter (fun u => decide (2 ≤ s u))).length) &&
  decide (v.orphanAll = (orphanTiles b).all (fun u => decide (1 ≤ s u))) &&
  decide (v.orphanPair = (orphanTiles b).any (fun u => decide (2 ≤ s u))) &&
  (blockTiles b).all (fun u => decide (table.available i u = decide (s u < 4)) &&
    (if table.available i u then decide (table.next i u < table.core.size) &&
      MaskedLocalBound.sameBlockB b (table.core.unrank (table.next i u)) (addTile s u)
    else true))

def checkSpan (b : Nat) (table : Candidate) (start : Nat) : Nat → Bool
  | 0 => true
  | n + 1 => checkRow b table start && checkSpan b table (start + 1) n

def check (b : Nat) (table : Candidate) : Bool := checkSpan b table 0 table.core.size

theorem checkSpan_add (b : Nat) (table : Candidate) (a c start : Nat) :
    checkSpan b table start (a + c) =
      (checkSpan b table start a && checkSpan b table (start + a) c) := by
  induction a generalizing start with
  | zero => simp [checkSpan]
  | succ a ih =>
    simp only [Nat.succ_add, checkSpan, ih]
    simp [Nat.add_assoc, Nat.add_comm, Nat.add_left_comm, Bool.and_assoc]

theorem row_valid (b : Nat) (table : Candidate) (i : Nat) (row : checkRow b table i = true)
    (u : Tile) (hu : u.val / 9 = b) : table.core.unrank i u ≤ 4 := by
  simp only [checkRow, Bool.and_eq_true, decide_eq_true_eq] at row
  have valid := row.1.1.1.1.1.1.1
  exact of_decide_eq_true (List.all_eq_true.mp valid u ((mem_blockTiles b u).mpr hu))

theorem row_available (b : Nat) (table : Candidate) (i : Nat) (row : checkRow b table i = true)
    (u : Tile) (hu : u.val / 9 = b) :
    table.available i u = decide (table.core.unrank i u < 4) := by
  simp only [checkRow, Bool.and_eq_true, decide_eq_true_eq] at row
  have h := List.all_eq_true.mp row.2 u ((mem_blockTiles b u).mpr hu)
  simp only [Bool.and_eq_true, decide_eq_true_eq] at h
  exact h.1

theorem row_next (b : Nat) (table : Candidate) (i : Nat) (row : checkRow b table i = true)
    (u : Tile) (hu : u.val / 9 = b) (available : table.available i u = true) :
    table.next i u < table.core.size ∧
      MaskedLocalBound.SameBlock b (table.core.unrank (table.next i u)) (addTile (table.core.unrank i) u) := by
  simp only [checkRow, Bool.and_eq_true, decide_eq_true_eq] at row
  have h := List.all_eq_true.mp row.2 u ((mem_blockTiles b u).mpr hu)
  simp only [Bool.and_eq_true, decide_eq_true_eq, available, ↓reduceIte] at h
  exact ⟨h.2.1, MaskedLocalBound.sameBlockB_sound h.2.2⟩

theorem checkSpan_each (b : Nat) (table : Candidate) (count start : Nat)
    (checked : checkSpan b table start count = true) :
    ∀ offset, offset < count → checkRow b table (start + offset) = true := by
  induction count generalizing start with
  | zero => intro offset h; omega
  | succ count ih =>
    have parts : checkRow b table start = true ∧ checkSpan b table (start + 1) count = true := by
      simpa only [checkSpan, Bool.and_eq_true] using checked
    intro offset h
    cases offset with
    | zero => simpa using parts.1
    | succ offset =>
      have x := ih (start + 1) parts.2 offset (by omega)
      simpa [Nat.add_assoc, Nat.add_comm, Nat.add_left_comm] using x

theorem row_spec (b : Nat) (table : Candidate) (coreChecked : LocalCache.check b table.core = true)
    (i : Nat) (inside : i < table.core.size) (row : checkRow b table i = true) :
    table.value i = spec b (table.core.unrank i) := by
  simp only [checkRow, Bool.and_eq_true, decide_eq_true_eq] at row
  obtain ⟨⟨⟨⟨⟨⟨⟨valid, refs⟩, meld⟩, pair⟩, pairs⟩, present⟩, duplicate⟩, next⟩ := row
  have pmap : maxMap (blockTiles b) (referencePair table (table.core.unrank i)) =
      paired b (table.core.unrank i) := by
    apply maxMap_congr
    intro p hp
    by_cases available : FastRuleChecker.pairAvailableB (table.core.unrank i) p = true
    · have ref := List.all_eq_true.mp refs p hp
      simp only [available, ↓reduceIte] at ref
      have parts := LocalCache.checkRef_parts b table.core _ ref
      have ceq := coreCap_eq b table.core coreChecked _ parts.1
      have same := cap_same b _ _ parts.2
      simp only [referencePair, pairedValue, available, ↓reduceIte, ceq]
      exact congrArg (fun n => n + 1) same
    · simp [referencePair, pairedValue, available]
  rw [pmap] at pair
  rw [coreCap_eq b table.core coreChecked i inside] at meld
  cases h : table.value i
  simp only [h] at meld pair pairs present duplicate
  simp only [spec, meld, pair, pairs, present, duplicate]

end Mahjong.LocalSummary

#print axioms Mahjong.LocalSummary.row_spec
