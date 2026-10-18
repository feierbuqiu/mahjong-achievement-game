import Mahjong.SummaryRules

namespace Mahjong.PackedRules

abbrev Tables := Nat → LocalSummary.Candidate
def Checked (tables : Tables) : Prop := ∀ b, b < 4 →
  LocalCache.check b (tables b).core = true ∧ LocalSummary.check b (tables b) = true

structure Packed where
  a : Nat
  b : Nat
  c : Nat
  h : Nat
  deriving DecidableEq, Repr

def Packed.get (s : Packed) (b : Nat) : Nat :=
  match b with | 0 => s.a | 1 => s.b | 2 => s.c | _ => s.h

def Packed.set (s : Packed) (b v : Nat) : Packed :=
  match b with | 0 => {s with a := v} | 1 => {s with b := v} | 2 => {s with c := v} | _ => {s with h := v}

def state (tables : Tables) (s : Packed) : State :=
  fun u => (tables (u.val / 9)).core.unrank (s.get (u.val / 9)) u

def inside (tables : Tables) (s : Packed) : Bool :=
  [0, 1, 2, 3].all (fun b => decide (s.get b < (tables b).core.size))

theorem inside_part (tables : Tables) (s : Packed) (checked : inside tables s = true)
    (b : Nat) (hb : b < 4) : s.get b < (tables b).core.size := by
  have member : b ∈ [0, 1, 2, 3] := by
    have cases : b = 0 ∨ b = 1 ∨ b = 2 ∨ b = 3 := by omega
    rcases cases with rfl | rfl | rfl | rfl <;> simp
  exact of_decide_eq_true (List.all_eq_true.mp checked b member)

theorem checkedRow (tables : Tables) (checked : Checked tables) (s : Packed)
    (valid : inside tables s = true) (b : Nat) (hb : b < 4) :
    LocalSummary.checkRow b (tables b) (s.get b) = true := by
  have h := LocalSummary.checkSpan_each b (tables b) (tables b).core.size 0 (checked b hb).2
    (s.get b) (inside_part tables s valid b hb)
  simpa using h

theorem state_valid (tables : Tables) (checked : Checked tables) (s : Packed)
    (valid : inside tables s = true) : Valid (state tables s) := by
  intro u
  have hu : u.val / 9 < 4 := by have h := u.isLt; omega
  exact LocalSummary.row_valid (u.val / 9) (tables (u.val / 9)) (s.get (u.val / 9))
    (checkedRow tables checked s valid _ hu) u rfl

def profiles (tables : Tables) (s : Packed) (b : Nat) : LocalSummary.Value := (tables b).value (s.get b)

theorem profiles_spec (tables : Tables) (checked : Checked tables) (s : Packed)
    (valid : inside tables s = true) (b : Nat) (hb : b < 4) :
    profiles tables s b = LocalSummary.spec b (state tables s) := by
  rw [profiles, LocalSummary.row_spec b (tables b) (checked b hb).1 _
    (inside_part tables s valid b hb) (checkedRow tables checked s valid b hb)]
  apply LocalSummary.spec_same
  intro u hu
  simp only [state, hu]

def winB (tables : Tables) (s : Packed) : Bool := !SummaryRules.noWinB (profiles tables s)

theorem winB_eq (tables : Tables) (checked : Checked tables) (s : Packed)
    (valid : inside tables s = true) : winB tables s = FastRuleChecker.winB (state tables s) := by
  have profiles0 := profiles_spec tables checked s valid 0 (by decide)
  have profiles1 := profiles_spec tables checked s valid 1 (by decide)
  have profiles2 := profiles_spec tables checked s valid 2 (by decide)
  have profiles3 := profiles_spec tables checked s valid 3 (by decide)
  have eqn : SummaryRules.noWinB (profiles tables s) = FactorizedRules.noWinB (state tables s) := by
    rw [← SummaryRules.noWinB_spec]
    simp only [SummaryRules.noWinB, SummaryRules.sevenPairsB, SummaryRules.orphansB,
      SummaryRules.noStandardB, List.all_cons, List.all_nil, SummaryRules.others,
      profiles0, profiles1, profiles2, profiles3]
  have hs := state_valid tables checked s valid
  apply Bool.eq_iff_iff.2
  change winB tables s = true ↔ FastRuleChecker.winB (state tables s) = true
  rw [FastRuleChecker.winB_iff _ hs]
  simp only [winB, eqn, Bool.not_eq_true', Bool.eq_false_iff,
    ne_eq, CapacityComplete.noWinB_iff _ hs]
  exact Classical.not_not

def available (tables : Tables) (s : Packed) (u : Tile) : Bool :=
  (tables (u.val / 9)).available (s.get (u.val / 9)) u

def add (tables : Tables) (s : Packed) (u : Tile) : Packed :=
  s.set (u.val / 9) ((tables (u.val / 9)).next (s.get (u.val / 9)) u)

theorem available_eq (tables : Tables) (checked : Checked tables) (s : Packed)
    (valid : inside tables s = true) (u : Tile) :
    available tables s u = decide (state tables s u < 4) := by
  have hu : u.val / 9 < 4 := by have h := u.isLt; omega
  exact LocalSummary.row_available _ _ _ (checkedRow tables checked s valid _ hu) u rfl

theorem get_set (s : Packed) (b d v : Nat) (hb : b < 4) (hd : d < 4) :
    (s.set b v).get d = if b = d then v else s.get d := by
  have bc : b = 0 ∨ b = 1 ∨ b = 2 ∨ b = 3 := by omega
  have dc : d = 0 ∨ d = 1 ∨ d = 2 ∨ d = 3 := by omega
  rcases bc with rfl | rfl | rfl | rfl <;>
    rcases dc with rfl | rfl | rfl | rfl <;> rfl

theorem add_inside (tables : Tables) (checked : Checked tables) (s : Packed)
    (valid : inside tables s = true) (u : Tile) (avail : available tables s u = true) :
    inside tables (add tables s u) = true := by
  have hu : u.val / 9 < 4 := by have h := u.isLt; omega
  have next := (LocalSummary.row_next _ _ _ (checkedRow tables checked s valid _ hu) u rfl avail).1
  unfold inside
  apply List.all_eq_true.mpr
  intro b hb
  have hb' : b < 4 := by
    have cases : b = 0 ∨ b = 1 ∨ b = 2 ∨ b = 3 := by simpa using hb
    omega
  apply decide_eq_true
  simp only [add, get_set s _ b _ hu hb']
  split
  next eq => simpa only [← eq] using next
  next => exact inside_part tables s valid b hb'

theorem add_state (tables : Tables) (checked : Checked tables) (s : Packed)
    (valid : inside tables s = true) (u : Tile) (avail : available tables s u = true) :
    state tables (add tables s u) = addTile (state tables s) u := by
  have hu : u.val / 9 < 4 := by have h := u.isLt; omega
  have next := (LocalSummary.row_next _ _ _ (checkedRow tables checked s valid _ hu) u rfl avail).2
  funext v
  have hv : v.val / 9 < 4 := by have h := v.isLt; omega
  simp only [state, add, get_set s _ _ _ hu hv]
  by_cases same : u.val / 9 = v.val / 9
  · rw [if_pos same]
    have value := next v same.symm
    simp only [addTile, state] at value ⊢
    simpa only [same] using value
  · rw [if_neg same]
    have different : v ≠ u := by intro h; subst v; exact same rfl
    simp only [addTile, state, unit, if_neg different, Nat.add_zero]

def safeB (tables : Tables) (s : Packed) : Bool :=
  inside tables s && !winB tables s && allTiles.all (fun u =>
    if available tables s u then !winB tables (add tables s u) else true)

theorem safeB_eq (tables : Tables) (checked : Checked tables) (s : Packed)
    (valid : inside tables s = true) : safeB tables s = FastRuleChecker.safeB (state tables s) := by
  have hv := (RuleChecker.validB_iff _).mpr (state_valid tables checked s valid)
  simp only [safeB, FastRuleChecker.safeB, valid, hv, Bool.true_and, winB_eq tables checked s valid]
  congr 1
  apply LocalSummary.all_congr
  intro u _
  by_cases av : available tables s u = true
  · have newValid := add_inside tables checked s valid u av
    have same := add_state tables checked s valid u av
    have counts : state tables s u < 4 := of_decide_eq_true ((available_eq tables checked s valid u).symm.trans av)
    simp only [av, ↓reduceIte, winB_eq tables checked _ newValid, same, if_pos counts]
  · have counts : ¬state tables s u < 4 := by
      intro h; apply av; rw [available_eq tables checked s valid u]; exact decide_eq_true h
    simp only [if_neg av, if_neg counts]

end Mahjong.PackedRules

#print axioms Mahjong.PackedRules.winB_eq
#print axioms Mahjong.PackedRules.add_state
#print axioms Mahjong.PackedRules.safeB_eq
