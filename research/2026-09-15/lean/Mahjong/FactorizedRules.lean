import Mahjong.CachedStandardBounds

/- A proved negative fast path. A failure to establish a bound falls back to
the complete reference predicate, so an incomplete bound can never hide a move.
The next optimization can replace repeated capacities by a checked local cache. -/
namespace Mahjong.FactorizedRules
open StandardBoundCertificate CachedStandardBounds

def capacity (b : Nat) (s : State) : Nat :=
  if searchWith (localMelds b) 1 s == false then 0
  else if searchWith (localMelds b) 2 s == false then 1
  else if searchWith (localMelds b) 3 s == false then 2
  else if searchWith (localMelds b) 4 s == false then 3
  else 4

theorem capacity_upper (b : Nat) (s : State) (small : capacity b s < 4) :
    searchWith (localMelds b) (capacity b s + 1) s = false := by
  unfold capacity at *
  split at small <;> simp_all
  split at small <;> simp_all
  split at small <;> simp_all
  split at small <;> simp_all

def capacities (s : State) : Caps :=
  ⟨capacity 0 s, capacity 1 s, capacity 2 s, capacity 3 s⟩

def noWinB (s : State) : Bool :=
  !RuleChecker.sevenPairsB s && !RuleChecker.orphansB s &&
    allTiles.all (fun p => if FastRuleChecker.pairAvailableB s p then
      decide ((capacities (FastRuleChecker.removePair s p)).total < 4) else true)

theorem noWinB_sound (s : State) (checked : noWinB s = true) : ¬ Win s := by
  simp only [noWinB, Bool.and_eq_true, Bool.not_eq_true'] at checked
  apply no_win_of_bounds (cert := fun p => capacities (FastRuleChecker.removePair s p))
  · constructor
    intro p available
    have summed := List.all_eq_true.mp checked.2 p (mem_allTiles p)
    simp only [available, ↓reduceIte, decide_eq_true_eq] at summed
    refine ⟨summed, ?_, ?_, ?_, ?_⟩
    all_goals apply capacity_upper
    all_goals dsimp [capacities, Caps.total] at summed ⊢
    all_goals omega
  · exact checked.1.1
  · exact checked.1.2

def winB (s : State) : Bool :=
  if noWinB s then false else FastRuleChecker.winB s

theorem winB_eq (s : State) : winB s = FastRuleChecker.winB s := by
  unfold winB
  split
  next bound =>
    symm
    apply Bool.eq_false_iff.2
    intro won
    have hv : Valid s := by
      have h := won
      rw [FastRuleChecker.winB_eq] at h
      exact ((RuleChecker.winB_iff_valid_and_win s).1 h).1
    exact noWinB_sound s bound ((FastRuleChecker.winB_iff s hv).1 won)
  next => rfl

def safeB (s : State) : Bool :=
  RuleChecker.validB s && !winB s && allTiles.all (fun t =>
    if s t < 4 then !winB (addTile s t) else true)

theorem safeB_eq (s : State) : safeB s = FastRuleChecker.safeB s := by
  simp only [safeB, FastRuleChecker.safeB, winB_eq]

def safeSuccessors (s : State) : List State :=
  if RuleChecker.validB s then
    allTiles.filterMap (fun kind =>
      if s kind < 4 then
        let child := addTile s kind
        if safeB child then some child else none
      else none)
  else []

theorem safeSuccessors_eq (s : State) :
    safeSuccessors s = FastRuleChecker.safeSuccessors s := by
  simp only [safeSuccessors, FastRuleChecker.safeSuccessors, safeB_eq]

theorem safeSuccessors_iff (s t : State) :
    SafeGame.SafeStep Step Win s t ↔ t ∈ safeSuccessors s := by
  rw [safeSuccessors_eq]
  exact FastRuleChecker.safeSuccessors_iff s t

end Mahjong.FactorizedRules

#print axioms Mahjong.FactorizedRules.capacity_upper
#print axioms Mahjong.FactorizedRules.noWinB_sound
#print axioms Mahjong.FactorizedRules.winB_eq
#print axioms Mahjong.FactorizedRules.safeSuccessors_iff
