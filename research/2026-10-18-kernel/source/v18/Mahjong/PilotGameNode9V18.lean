import Mahjong.PilotGameCheckBridgeV18

set_option autoImplicit false
set_option maxRecDepth 32768
set_option maxHeartbeats 20000000

namespace Mahjong.PilotGameChecksV18

open PilotGameV18 PilotActualDataV18 PilotGameCheckBridgeV18

theorem node9_source_safe : FactorizedRules.safeB (state node9) = true := by
  decide +kernel

theorem node9_child0_unsafe : FactorizedRules.safeB (addTile (state node9) (0 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node9) (0 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨1, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node9_child1_unsafe : FactorizedRules.safeB (addTile (state node9) (1 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node9) (1 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨2, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (1 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node9_child2_unsafe : FactorizedRules.safeB (addTile (state node9) (2 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node9) (2 : Tile)) (0 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨1, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node9_child3_unsafe : FactorizedRules.safeB (addTile (state node9) (3 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node9) (3 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (3 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node9_child4_unsafe : FactorizedRules.safeB (addTile (state node9) (4 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node9) (4 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (4 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node9_child5_unsafe : FactorizedRules.safeB (addTile (state node9) (5 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node9) (5 : Tile)) (0 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨3, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node9_child6_unsafe : FactorizedRules.safeB (addTile (state node9) (6 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node9) (6 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (6 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node9_child7_unsafe : FactorizedRules.safeB (addTile (state node9) (7 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node9) (7 : Tile)) (0 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨6, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node9_child8_unsafe : FactorizedRules.safeB (addTile (state node9) (8 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node9) (8 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (8 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node9_child9_unsafe : FactorizedRules.safeB (addTile (state node9) (9 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node9) (9 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (9 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node9_child10_unsafe : FactorizedRules.safeB (addTile (state node9) (10 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node9) (10 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (10 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node9_child11_unsafe : FactorizedRules.safeB (addTile (state node9) (11 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node9) (11 : Tile)) (0 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨1, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node9_child12_unsafe : FactorizedRules.safeB (addTile (state node9) (12 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node9) (12 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (12 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node9_child13_unsafe : FactorizedRules.safeB (addTile (state node9) (13 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node9) (13 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (13 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node9_child14_unsafe : FactorizedRules.safeB (addTile (state node9) (14 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node9) (14 : Tile)) (0 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨1, by decide⟩ ⟨3, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node9_child15_unsafe : FactorizedRules.safeB (addTile (state node9) (15 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node9) (15 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (15 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node9_child16_unsafe : FactorizedRules.safeB (addTile (state node9) (16 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node9) (16 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (16 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node9_child17_unsafe : FactorizedRules.safeB (addTile (state node9) (17 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node9) (17 : Tile)) (0 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨1, by decide⟩ ⟨6, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node9_child18_unsafe : FactorizedRules.safeB (addTile (state node9) (18 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node9) (18 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (18 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node9_child19_unsafe : FactorizedRules.safeB (addTile (state node9) (19 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node9) (19 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (19 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node9_child20_unsafe : FactorizedRules.safeB (addTile (state node9) (20 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node9) (20 : Tile)) (0 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨2, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node9_child21_unsafe : FactorizedRules.safeB (addTile (state node9) (21 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node9) (21 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (21 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node9_child22_unsafe : FactorizedRules.safeB (addTile (state node9) (22 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node9) (22 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (22 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node9_child23_unsafe : FactorizedRules.safeB (addTile (state node9) (23 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node9) (23 : Tile)) (0 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨2, by decide⟩ ⟨3, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node9_child24_unsafe : FactorizedRules.safeB (addTile (state node9) (24 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node9) (24 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (24 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node9_child25_unsafe : FactorizedRules.safeB (addTile (state node9) (25 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node9) (25 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (25 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node9_child26_unsafe : FactorizedRules.safeB (addTile (state node9) (26 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node9) (26 : Tile)) (0 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨2, by decide⟩ ⟨6, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node9_kind27_full : ¬ state node9 (27 : Tile) < 4 := by
  decide +kernel

theorem node9_kind28_full : ¬ state node9 (28 : Tile) < 4 := by
  decide +kernel

theorem node9_kind29_full : ¬ state node9 (29 : Tile) < 4 := by
  decide +kernel

theorem node9_child30_unsafe : FactorizedRules.safeB (addTile (state node9) (30 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node9) (30 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (30 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node9_child31_unsafe : FactorizedRules.safeB (addTile (state node9) (31 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node9) (31 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (31 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node9_child32_unsafe : FactorizedRules.safeB (addTile (state node9) (32 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node9) (32 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (32 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node9_child33_unsafe : FactorizedRules.safeB (addTile (state node9) (33 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node9) (33 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (33 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node9_rule_checked : checkRule [node10] node9 = true := by
  change allTiles.all (fun kind =>
    if state node9 kind < 4 then
      if FactorizedRules.safeB (addTile (state node9) kind) then
        known [node10] (node9.pRefs.getD kind.val 1) (addTile (state node9) kind) .N
      else true
    else true) = true
  simp only [allTiles, List.all_cons, List.all_nil,
    node9_child0_unsafe,
    node9_child1_unsafe,
    node9_child2_unsafe,
    node9_child3_unsafe,
    node9_child4_unsafe,
    node9_child5_unsafe,
    node9_child6_unsafe,
    node9_child7_unsafe,
    node9_child8_unsafe,
    node9_child9_unsafe,
    node9_child10_unsafe,
    node9_child11_unsafe,
    node9_child12_unsafe,
    node9_child13_unsafe,
    node9_child14_unsafe,
    node9_child15_unsafe,
    node9_child16_unsafe,
    node9_child17_unsafe,
    node9_child18_unsafe,
    node9_child19_unsafe,
    node9_child20_unsafe,
    node9_child21_unsafe,
    node9_child22_unsafe,
    node9_child23_unsafe,
    node9_child24_unsafe,
    node9_child25_unsafe,
    node9_child26_unsafe,
    node9_kind27_full,
    node9_kind28_full,
    node9_kind29_full,
    node9_child30_unsafe,
    node9_child31_unsafe,
    node9_child32_unsafe,
    node9_child33_unsafe,
    Bool.false_eq_true, ↓reduceIte, ite_self, Bool.and_self]

theorem node9_shape :
    decide (node9.counts.size = 34 ∧ node9.pRefs.size = 34) = true := by
  decide +kernel

theorem node9_checked : checkNode [node10] node9 = true := by
  simp only [checkNode, node9_shape, node9_source_safe,
    node9_rule_checked, Bool.and_self]

end Mahjong.PilotGameChecksV18

#print axioms Mahjong.PilotGameChecksV18.node9_checked
