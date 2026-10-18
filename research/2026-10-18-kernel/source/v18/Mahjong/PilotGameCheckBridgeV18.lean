import Mahjong.PilotActualDataV18
import Mahjong.DownwardClosure

set_option autoImplicit false
set_option maxRecDepth 32768
set_option maxHeartbeats 20000000

/- Separately opaque equations for actual physical-game proposals.
Source safety is checked or inherited from an actually checked larger state.
Excluded children have a concrete legal reply and a contained winning hand.
Historical labels and the external hint generator are not proof premises.
This small fragment is not an empty-position or whole-table result. -/

namespace Mahjong.PilotGameCheckBridgeV18

open PilotGameV18 PilotActualDataV18

theorem unsafe_of_step_win {s t : State} (edge : Step s t) (won : Win t) :
    FactorizedRules.safeB s = false := by
  apply Bool.eq_false_iff.mpr
  intro accepted
  exact (safe_facts s accepted).2.2 t edge won

theorem unsafe_after_standard_next (s : State) (kind : Tile)
    (melds : Fin 4 → Meld) (pair : Tile)
    (valid : RuleChecker.validB s = true) (legal : s kind < 4)
    (covered : RuleChecker.containsB (countsOf (standardTiles melds pair))
      (addTile s kind) = true) : FactorizedRules.safeB s = false := by
  have sourceValid := (RuleChecker.validB_iff s).mp valid
  have contained := (RuleChecker.containsB_iff _ _).mp covered
  apply unsafe_of_step_win ⟨kind, ⟨sourceValid, legal⟩, rfl⟩
  exact ⟨countsOf (standardTiles melds pair),
    ⟨contains_valid contained (valid_add sourceValid legal), Or.inl ⟨melds, pair, rfl⟩⟩,
    contained⟩

theorem unsafe_after_orphans_next (s : State) (kind pair : Tile)
    (valid : RuleChecker.validB s = true) (legal : s kind < 4)
    (orphanPair : pair ∈ orphans)
    (covered : RuleChecker.containsB (countsOf (pair :: orphans))
      (addTile s kind) = true) : FactorizedRules.safeB s = false := by
  have sourceValid := (RuleChecker.validB_iff s).mp valid
  have contained := (RuleChecker.containsB_iff _ _).mp covered
  apply unsafe_of_step_win ⟨kind, ⟨sourceValid, legal⟩, rfl⟩
  exact ⟨countsOf (pair :: orphans),
    ⟨contains_valid contained (valid_add sourceValid legal),
      Or.inr (Or.inr ⟨pair, orphanPair, rfl⟩)⟩, contained⟩

theorem safeB_of_contained (s t : State)
    (covered : RuleChecker.containsB s t = true)
    (safe : FactorizedRules.safeB t = true) : FactorizedRules.safeB s = true := by
  have larger := safe_facts t safe
  have contained := (RuleChecker.containsB_iff s t).mp covered
  rw [FactorizedRules.safeB_eq]
  exact (FastRuleChecker.safeB_iff s (contains_valid contained larger.1)).mpr
    (safe_of_contains contained larger.1 larger.2)

end Mahjong.PilotGameCheckBridgeV18

#print axioms Mahjong.PilotGameCheckBridgeV18.unsafe_of_step_win
#print axioms Mahjong.PilotGameCheckBridgeV18.unsafe_after_standard_next
#print axioms Mahjong.PilotGameCheckBridgeV18.unsafe_after_orphans_next
#print axioms Mahjong.PilotGameCheckBridgeV18.safeB_of_contained
