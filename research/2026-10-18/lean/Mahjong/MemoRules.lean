import Mahjong.LocalCache
import Mahjong.FactorizedRules

namespace Mahjong.MemoRules

abbrev Tables := Nat → LocalCache.Candidate
def Checked (tables : Tables) : Prop := ∀ b, b < 4 → LocalCache.check b (tables b) = true

def capacity (tables : Tables) (b : Nat) (s : State) : Nat :=
  let table := tables b
  if LocalCache.checkRef b table s then
    let i := table.rank s
    if table.value i 1 == false then 0
    else if table.value i 2 == false then 1
    else if table.value i 3 == false then 2
    else if table.value i 4 == false then 3
    else 4
  else FactorizedRules.capacity b s

theorem capacity_eq (tables : Tables) (checked : Checked tables) (b : Nat) (hb : b < 4)
    (s : State) : capacity tables b s = FactorizedRules.capacity b s := by
  unfold capacity
  dsimp only
  split
  next h =>
    have parts := LocalCache.checkRef_parts b (tables b) s h
    have bit (k : Nat) (small : k ≤ 4) :
        (tables b).value ((tables b).rank s) k =
          StandardBoundCertificate.searchWith (StandardBoundCertificate.localMelds b) k s := by
      rw [LocalCache.check_sound b (tables b) (checked b hb) k small _ parts.1]
      exact MaskedLocalBound.search_local_eq b k _ _ parts.2
    simp only [bit 1 (by decide), bit 2 (by decide), bit 3 (by decide), bit 4 (by decide),
      FactorizedRules.capacity]
  next => rfl

def capacities (tables : Tables) (s : State) : StandardBoundCertificate.Caps :=
  ⟨capacity tables 0 s, capacity tables 1 s, capacity tables 2 s, capacity tables 3 s⟩

theorem capacities_eq (tables : Tables) (checked : Checked tables) (s : State) :
    capacities tables s = FactorizedRules.capacities s := by
  simp only [capacities, FactorizedRules.capacities, capacity_eq tables checked 0 (by decide),
    capacity_eq tables checked 1 (by decide), capacity_eq tables checked 2 (by decide),
    capacity_eq tables checked 3 (by decide)]

theorem capacity_removePair_other (tables : Tables) (checked : Checked tables)
    (s : State) (p : Tile) (b : Nat) (hb : b < 4) (other : p.val / 9 ≠ b) :
    capacity tables b (FastRuleChecker.removePair s p) = capacity tables b s := by
  rw [capacity_eq tables checked b hb, capacity_eq tables checked b hb]
  have same : MaskedLocalBound.SameBlock b (FastRuleChecker.removePair s p) s := by
    intro u hu
    have different : u ≠ p := by
      intro h; subst u; exact other hu
    simp only [FastRuleChecker.removePair, if_neg different]
  have eqn (k : Nat) := MaskedLocalBound.search_local_eq b k _ _ same
  simp only [FactorizedRules.capacity, eqn]

def afterPairTotal (tables : Tables) (s : State) (base : StandardBoundCertificate.Caps)
    (p : Tile) : Nat :=
  let r := FastRuleChecker.removePair s p
  match p.val / 9 with
  | 0 => capacity tables 0 r + base.suit1 + base.suit2 + base.honors
  | 1 => base.suit0 + capacity tables 1 r + base.suit2 + base.honors
  | 2 => base.suit0 + base.suit1 + capacity tables 2 r + base.honors
  | _ => base.suit0 + base.suit1 + base.suit2 + capacity tables 3 r

theorem afterPairTotal_eq (tables : Tables) (checked : Checked tables) (s : State) (p : Tile) :
    afterPairTotal tables s (capacities tables s) p =
      (capacities tables (FastRuleChecker.removePair s p)).total := by
  have ht := p.isLt
  have cases : p.val / 9 = 0 ∨ p.val / 9 = 1 ∨ p.val / 9 = 2 ∨ p.val / 9 = 3 := by omega
  have move := capacity_removePair_other tables checked s p
  rcases cases with h | h | h | h
  all_goals simp [afterPairTotal, capacities, StandardBoundCertificate.Caps.total,
    move 0 (by decide), move 1 (by decide), move 2 (by decide), move 3 (by decide), h]

def noWinB (tables : Tables) (s : State) : Bool :=
  let base := capacities tables s
  !RuleChecker.sevenPairsB s && !RuleChecker.orphansB s &&
    allTiles.all (fun p => if FastRuleChecker.pairAvailableB s p then
      decide (afterPairTotal tables s base p < 4) else true)

def winB (tables : Tables) (s : State) : Bool :=
  if noWinB tables s then false else FastRuleChecker.winB s

theorem winB_eq (tables : Tables) (checked : Checked tables) (s : State) :
    winB tables s = FactorizedRules.winB s := by
  simp only [winB, noWinB, FactorizedRules.winB, FactorizedRules.noWinB]
  simp only [afterPairTotal_eq tables checked]
  simp only [capacities_eq tables checked]
  rfl

def safeB (tables : Tables) (s : State) : Bool :=
  RuleChecker.validB s && !winB tables s && allTiles.all (fun t =>
    if s t < 4 then !winB tables (addTile s t) else true)

theorem safeB_eq (tables : Tables) (checked : Checked tables) (s : State) :
    safeB tables s = FactorizedRules.safeB s := by
  simp only [safeB, FactorizedRules.safeB, winB_eq tables checked]

def safeSuccessors (tables : Tables) (s : State) : List State :=
  if RuleChecker.validB s then
    allTiles.filterMap (fun kind =>
      if s kind < 4 then
        let child := addTile s kind
        if safeB tables child then some child else none
      else none)
  else []

theorem safeSuccessors_eq (tables : Tables) (checked : Checked tables) (s : State) :
    safeSuccessors tables s = FactorizedRules.safeSuccessors s := by
  simp only [safeSuccessors, FactorizedRules.safeSuccessors, safeB_eq tables checked]

end Mahjong.MemoRules

#print axioms Mahjong.MemoRules.capacity_eq
#print axioms Mahjong.MemoRules.safeSuccessors_eq
