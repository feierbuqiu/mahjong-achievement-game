import Mahjong.RuleChecker

/-!
Executable equality and complete SAFE move enumeration on the original
34-count table. No canonicalizer or external index is involved.
-/
namespace Mahjong.MoveEnumeration

open RuleChecker

def stateEqB (s t : State) : Bool :=
  allTiles.all (fun kind => decide (s kind = t kind))

theorem stateEqB_iff (s t : State) : stateEqB s t = true ↔ s = t := by
  simp only [stateEqB, List.all_eq_true, decide_eq_true_eq]
  constructor
  · intro he
    funext kind
    exact he kind (mem_allTiles kind)
  · rintro rfl
    intro _ _
    rfl

/-- Computable pointwise equality over all 34 tile kinds. -/
instance instDecidableEqState : DecidableEq State := fun s t =>
  if he : stateEqB s t = true then
    isTrue ((stateEqB_iff s t).1 he)
  else
    isFalse (fun h => he ((stateEqB_iff s t).2 h))

def safeSuccessors (s : State) : List State :=
  if validB s then
    allTiles.filterMap (fun kind =>
      if s kind < 4 then
        let child := addTile s kind
        if safeB child then some child else none
      else none)
  else []

theorem safeSuccessors_invalid {s : State} (hs : ¬ Valid s) :
    safeSuccessors s = [] := by
  have hb : validB s ≠ true := fun h => hs ((validB_iff s).1 h)
  simp [safeSuccessors, hb]

theorem safeSuccessors_iff (s t : State) :
    SafeGame.SafeStep Step Win s t ↔ t ∈ safeSuccessors s := by
  constructor
  · rintro ⟨⟨kind, hlegal, rfl⟩, hsafe⟩
    have hv := (validB_iff s).2 hlegal.1
    have hb := (safeB_iff _ (valid_add hlegal.1 hlegal.2)).2 hsafe
    simp only [safeSuccessors, hv, ↓reduceIte, List.mem_filterMap]
    refine ⟨kind, mem_allTiles kind, ?_⟩
    simp [hlegal.2, hb]
  · intro hm
    by_cases hv : validB s = true
    · have hs := (validB_iff s).1 hv
      simp only [safeSuccessors, hv, ↓reduceIte, List.mem_filterMap] at hm
      obtain ⟨kind, _, hchild⟩ := hm
      by_cases hk : s kind < 4
      · simp only [if_pos hk] at hchild
        by_cases hb : safeB (addTile s kind) = true
        · simp only [hb, ↓reduceIte, Option.some.injEq] at hchild
          subst t
          exact ⟨⟨kind, ⟨hs, hk⟩, rfl⟩, (safeB_iff _ (valid_add hs hk)).1 hb⟩
        · simp [hb] at hchild
      · simp [hk] at hchild
    · simp [safeSuccessors, hv] at hm

theorem safeSuccessors_source_valid {s t : State} (h : t ∈ safeSuccessors s) :
    Valid s := step_source_valid ((safeSuccessors_iff s t).2 h).1

theorem safeSuccessors_target_valid {s t : State} (h : t ∈ safeSuccessors s) :
    Valid t := step_target_valid ((safeSuccessors_iff s t).2 h).1

theorem safeSuccessors_stock_strict {s t : State} (h : t ∈ safeSuccessors s) :
    stock t < stock s := step_stock_strict ((safeSuccessors_iff s t).2 h).1

end Mahjong.MoveEnumeration

#print axioms Mahjong.MoveEnumeration.stateEqB_iff
#print axioms Mahjong.MoveEnumeration.safeSuccessors_iff
#print axioms Mahjong.MoveEnumeration.safeSuccessors_stock_strict
