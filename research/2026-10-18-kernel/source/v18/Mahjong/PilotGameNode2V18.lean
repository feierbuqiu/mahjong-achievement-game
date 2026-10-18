import Mahjong.PilotGameCheckBridgeV18
import Mahjong.PilotGameNode9V18

set_option autoImplicit false
set_option maxRecDepth 32768
set_option maxHeartbeats 20000000

namespace Mahjong.PilotGameChecksV18

open PilotGameV18 PilotActualDataV18 PilotGameCheckBridgeV18

theorem node2_source_safe : FactorizedRules.safeB (state node2) = true := by
  exact safeB_of_contained _ _ (by decide +kernel) node9_source_safe

theorem node2_child0_unsafe : FactorizedRules.safeB (addTile (state node2) (0 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node2) (0 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨1, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node2_child1_unsafe : FactorizedRules.safeB (addTile (state node2) (1 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node2) (1 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨2, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (1 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node2_child2_unsafe : FactorizedRules.safeB (addTile (state node2) (2 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node2) (2 : Tile)) (0 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨1, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node2_child3_unsafe : FactorizedRules.safeB (addTile (state node2) (3 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node2) (3 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (3 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node2_child4_unsafe : FactorizedRules.safeB (addTile (state node2) (4 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node2) (4 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (4 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node2_child5_unsafe : FactorizedRules.safeB (addTile (state node2) (5 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node2) (5 : Tile)) (0 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨3, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node2_child6_unsafe : FactorizedRules.safeB (addTile (state node2) (6 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node2) (6 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (6 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node2_child7_unsafe : FactorizedRules.safeB (addTile (state node2) (7 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node2) (7 : Tile)) (0 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨6, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node2_child8_unsafe : FactorizedRules.safeB (addTile (state node2) (8 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node2) (8 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (8 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node2_child9_unsafe : FactorizedRules.safeB (addTile (state node2) (9 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node2) (9 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (9 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node2_child10_unsafe : FactorizedRules.safeB (addTile (state node2) (10 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node2) (10 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (10 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node2_child11_unsafe : FactorizedRules.safeB (addTile (state node2) (11 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node2) (11 : Tile)) (0 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨1, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node2_child12_unsafe : FactorizedRules.safeB (addTile (state node2) (12 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node2) (12 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (12 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node2_child13_unsafe : FactorizedRules.safeB (addTile (state node2) (13 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node2) (13 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (13 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node2_child14_unsafe : FactorizedRules.safeB (addTile (state node2) (14 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node2) (14 : Tile)) (0 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨1, by decide⟩ ⟨3, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node2_child15_unsafe : FactorizedRules.safeB (addTile (state node2) (15 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node2) (15 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (15 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node2_child16_unsafe : FactorizedRules.safeB (addTile (state node2) (16 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node2) (16 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (16 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node2_child17_unsafe : FactorizedRules.safeB (addTile (state node2) (17 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node2) (17 : Tile)) (0 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨1, by decide⟩ ⟨6, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node2_child18_unsafe : FactorizedRules.safeB (addTile (state node2) (18 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node2) (18 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (18 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node2_child19_unsafe : FactorizedRules.safeB (addTile (state node2) (19 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node2) (19 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (19 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node2_child20_unsafe : FactorizedRules.safeB (addTile (state node2) (20 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node2) (20 : Tile)) (0 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨2, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node2_child21_unsafe : FactorizedRules.safeB (addTile (state node2) (21 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node2) (21 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (21 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node2_child22_unsafe : FactorizedRules.safeB (addTile (state node2) (22 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node2) (22 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (22 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node2_child23_unsafe : FactorizedRules.safeB (addTile (state node2) (23 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node2) (23 : Tile)) (0 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨2, by decide⟩ ⟨3, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node2_child24_unsafe : FactorizedRules.safeB (addTile (state node2) (24 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node2) (24 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (24 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node2_child25_unsafe : FactorizedRules.safeB (addTile (state node2) (25 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node2) (25 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (25 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node2_child26_unsafe : FactorizedRules.safeB (addTile (state node2) (26 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node2) (26 : Tile)) (0 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨2, by decide⟩ ⟨6, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node2_kind27_full : ¬ state node2 (27 : Tile) < 4 := by
  decide +kernel

theorem node2_kind28_full : ¬ state node2 (28 : Tile) < 4 := by
  decide +kernel

theorem node2_kind29_full : ¬ state node2 (29 : Tile) < 4 := by
  decide +kernel

theorem node2_child30_unsafe : FactorizedRules.safeB (addTile (state node2) (30 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node2) (30 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (30 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node2_child31_unsafe : FactorizedRules.safeB (addTile (state node2) (31 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node2) (31 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (31 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node2_child32_known :
    known [node3,node4,node5,node6,node7,node8,node9,node10] (node2.pRefs.getD (32 : Tile).val 8) (addTile (state node2) (32 : Tile)) .N = true := by
  decide +kernel

theorem node2_child33_known :
    known [node3,node4,node5,node6,node7,node8,node9,node10] (node2.pRefs.getD (33 : Tile).val 8) (addTile (state node2) (33 : Tile)) .N = true := by
  decide +kernel

theorem node2_rule_checked : checkRule [node3,node4,node5,node6,node7,node8,node9,node10] node2 = true := by
  change allTiles.all (fun kind =>
    if state node2 kind < 4 then
      if FactorizedRules.safeB (addTile (state node2) kind) then
        known [node3,node4,node5,node6,node7,node8,node9,node10] (node2.pRefs.getD kind.val 8) (addTile (state node2) kind) .N
      else true
    else true) = true
  simp only [allTiles, List.all_cons, List.all_nil,
    node2_child0_unsafe,
    node2_child1_unsafe,
    node2_child2_unsafe,
    node2_child3_unsafe,
    node2_child4_unsafe,
    node2_child5_unsafe,
    node2_child6_unsafe,
    node2_child7_unsafe,
    node2_child8_unsafe,
    node2_child9_unsafe,
    node2_child10_unsafe,
    node2_child11_unsafe,
    node2_child12_unsafe,
    node2_child13_unsafe,
    node2_child14_unsafe,
    node2_child15_unsafe,
    node2_child16_unsafe,
    node2_child17_unsafe,
    node2_child18_unsafe,
    node2_child19_unsafe,
    node2_child20_unsafe,
    node2_child21_unsafe,
    node2_child22_unsafe,
    node2_child23_unsafe,
    node2_child24_unsafe,
    node2_child25_unsafe,
    node2_child26_unsafe,
    node2_kind27_full,
    node2_kind28_full,
    node2_kind29_full,
    node2_child30_unsafe,
    node2_child31_unsafe,
    node2_child32_known,
    node2_child33_known,
    Bool.false_eq_true, ↓reduceIte, ite_self, Bool.and_self]

theorem node2_shape :
    decide (node2.counts.size = 34 ∧ node2.pRefs.size = 34) = true := by
  decide +kernel

theorem node2_checked : checkNode [node3,node4,node5,node6,node7,node8,node9,node10] node2 = true := by
  simp only [checkNode, node2_shape, node2_source_safe,
    node2_rule_checked, Bool.and_self]

end Mahjong.PilotGameChecksV18

#print axioms Mahjong.PilotGameChecksV18.node2_checked
