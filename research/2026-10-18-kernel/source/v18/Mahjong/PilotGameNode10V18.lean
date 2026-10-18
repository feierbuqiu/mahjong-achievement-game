import Mahjong.PilotGameCheckBridgeV18

set_option autoImplicit false
set_option maxRecDepth 32768
set_option maxHeartbeats 20000000

namespace Mahjong.PilotGameChecksV18

open PilotGameV18 PilotActualDataV18 PilotGameCheckBridgeV18

theorem node10_source_safe : FactorizedRules.safeB (state node10) = true := by
  decide +kernel

theorem node10_child0_unsafe : FactorizedRules.safeB (addTile (state node10) (0 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node10) (0 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨1, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node10_child1_unsafe : FactorizedRules.safeB (addTile (state node10) (1 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node10) (1 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨2, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (1 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node10_child2_unsafe : FactorizedRules.safeB (addTile (state node10) (2 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node10) (2 : Tile)) (0 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨1, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node10_child3_unsafe : FactorizedRules.safeB (addTile (state node10) (3 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node10) (3 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (3 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node10_child4_unsafe : FactorizedRules.safeB (addTile (state node10) (4 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node10) (4 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (4 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node10_child5_unsafe : FactorizedRules.safeB (addTile (state node10) (5 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node10) (5 : Tile)) (0 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨3, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node10_child6_unsafe : FactorizedRules.safeB (addTile (state node10) (6 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node10) (6 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (6 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node10_child7_unsafe : FactorizedRules.safeB (addTile (state node10) (7 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node10) (7 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (7 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node10_child8_unsafe : FactorizedRules.safeB (addTile (state node10) (8 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node10) (8 : Tile)) (0 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨6, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node10_child9_unsafe : FactorizedRules.safeB (addTile (state node10) (9 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node10) (9 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (9 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node10_child10_unsafe : FactorizedRules.safeB (addTile (state node10) (10 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node10) (10 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (10 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node10_child11_unsafe : FactorizedRules.safeB (addTile (state node10) (11 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node10) (11 : Tile)) (0 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨1, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node10_child12_unsafe : FactorizedRules.safeB (addTile (state node10) (12 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node10) (12 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (12 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node10_child13_unsafe : FactorizedRules.safeB (addTile (state node10) (13 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node10) (13 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (13 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node10_child14_unsafe : FactorizedRules.safeB (addTile (state node10) (14 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node10) (14 : Tile)) (0 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨1, by decide⟩ ⟨3, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node10_child15_unsafe : FactorizedRules.safeB (addTile (state node10) (15 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node10) (15 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (15 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node10_child16_unsafe : FactorizedRules.safeB (addTile (state node10) (16 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node10) (16 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (16 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node10_child17_unsafe : FactorizedRules.safeB (addTile (state node10) (17 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node10) (17 : Tile)) (0 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨1, by decide⟩ ⟨6, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node10_child18_unsafe : FactorizedRules.safeB (addTile (state node10) (18 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node10) (18 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (18 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node10_child19_unsafe : FactorizedRules.safeB (addTile (state node10) (19 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node10) (19 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (19 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node10_child20_unsafe : FactorizedRules.safeB (addTile (state node10) (20 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node10) (20 : Tile)) (0 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨2, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node10_child21_unsafe : FactorizedRules.safeB (addTile (state node10) (21 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node10) (21 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (21 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node10_child22_unsafe : FactorizedRules.safeB (addTile (state node10) (22 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node10) (22 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (22 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node10_child23_unsafe : FactorizedRules.safeB (addTile (state node10) (23 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node10) (23 : Tile)) (0 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨2, by decide⟩ ⟨3, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node10_child24_unsafe : FactorizedRules.safeB (addTile (state node10) (24 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node10) (24 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (24 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node10_child25_unsafe : FactorizedRules.safeB (addTile (state node10) (25 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node10) (25 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (25 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node10_child26_unsafe : FactorizedRules.safeB (addTile (state node10) (26 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node10) (26 : Tile)) (0 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨2, by decide⟩ ⟨6, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node10_kind27_full : ¬ state node10 (27 : Tile) < 4 := by
  decide +kernel

theorem node10_kind28_full : ¬ state node10 (28 : Tile) < 4 := by
  decide +kernel

theorem node10_kind29_full : ¬ state node10 (29 : Tile) < 4 := by
  decide +kernel

theorem node10_child30_unsafe : FactorizedRules.safeB (addTile (state node10) (30 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node10) (30 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (30 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node10_child31_unsafe : FactorizedRules.safeB (addTile (state node10) (31 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node10) (31 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (31 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node10_child32_unsafe : FactorizedRules.safeB (addTile (state node10) (32 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node10) (32 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (32 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node10_child33_unsafe : FactorizedRules.safeB (addTile (state node10) (33 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node10) (33 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (33 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node10_rule_checked : checkRule [] node10 = true := by
  change allTiles.all (fun kind =>
    if state node10 kind < 4 then
      if FactorizedRules.safeB (addTile (state node10) kind) then
        known [] (node10.pRefs.getD kind.val 0) (addTile (state node10) kind) .N
      else true
    else true) = true
  simp only [allTiles, List.all_cons, List.all_nil,
    node10_child0_unsafe,
    node10_child1_unsafe,
    node10_child2_unsafe,
    node10_child3_unsafe,
    node10_child4_unsafe,
    node10_child5_unsafe,
    node10_child6_unsafe,
    node10_child7_unsafe,
    node10_child8_unsafe,
    node10_child9_unsafe,
    node10_child10_unsafe,
    node10_child11_unsafe,
    node10_child12_unsafe,
    node10_child13_unsafe,
    node10_child14_unsafe,
    node10_child15_unsafe,
    node10_child16_unsafe,
    node10_child17_unsafe,
    node10_child18_unsafe,
    node10_child19_unsafe,
    node10_child20_unsafe,
    node10_child21_unsafe,
    node10_child22_unsafe,
    node10_child23_unsafe,
    node10_child24_unsafe,
    node10_child25_unsafe,
    node10_child26_unsafe,
    node10_kind27_full,
    node10_kind28_full,
    node10_kind29_full,
    node10_child30_unsafe,
    node10_child31_unsafe,
    node10_child32_unsafe,
    node10_child33_unsafe,
    Bool.false_eq_true, ↓reduceIte, ite_self, Bool.and_self]

theorem node10_shape :
    decide (node10.counts.size = 34 ∧ node10.pRefs.size = 34) = true := by
  decide +kernel

theorem node10_checked : checkNode [] node10 = true := by
  simp only [checkNode, node10_shape, node10_source_safe,
    node10_rule_checked, Bool.and_self]

end Mahjong.PilotGameChecksV18

#print axioms Mahjong.PilotGameChecksV18.node10_checked
