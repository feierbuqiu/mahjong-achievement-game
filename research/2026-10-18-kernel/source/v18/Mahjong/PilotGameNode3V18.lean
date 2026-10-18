import Mahjong.PilotGameCheckBridgeV18
import Mahjong.PilotGameNode10V18

set_option autoImplicit false
set_option maxRecDepth 32768
set_option maxHeartbeats 20000000

namespace Mahjong.PilotGameChecksV18

open PilotGameV18 PilotActualDataV18 PilotGameCheckBridgeV18

theorem node3_source_safe : FactorizedRules.safeB (state node3) = true := by
  exact safeB_of_contained _ _ (by decide +kernel) node10_source_safe

theorem node3_child0_unsafe : FactorizedRules.safeB (addTile (state node3) (0 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node3) (0 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨1, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node3_child1_unsafe : FactorizedRules.safeB (addTile (state node3) (1 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node3) (1 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨2, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (1 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node3_child2_unsafe : FactorizedRules.safeB (addTile (state node3) (2 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node3) (2 : Tile)) (0 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨1, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node3_child3_unsafe : FactorizedRules.safeB (addTile (state node3) (3 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node3) (3 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (3 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node3_child4_unsafe : FactorizedRules.safeB (addTile (state node3) (4 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node3) (4 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (4 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node3_child5_unsafe : FactorizedRules.safeB (addTile (state node3) (5 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node3) (5 : Tile)) (0 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨3, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node3_child6_unsafe : FactorizedRules.safeB (addTile (state node3) (6 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node3) (6 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (6 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node3_child7_unsafe : FactorizedRules.safeB (addTile (state node3) (7 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node3) (7 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (7 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node3_child8_unsafe : FactorizedRules.safeB (addTile (state node3) (8 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node3) (8 : Tile)) (0 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨6, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node3_child9_unsafe : FactorizedRules.safeB (addTile (state node3) (9 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node3) (9 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (9 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node3_child10_unsafe : FactorizedRules.safeB (addTile (state node3) (10 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node3) (10 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (10 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node3_child11_unsafe : FactorizedRules.safeB (addTile (state node3) (11 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node3) (11 : Tile)) (0 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨1, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node3_child12_unsafe : FactorizedRules.safeB (addTile (state node3) (12 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node3) (12 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (12 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node3_child13_unsafe : FactorizedRules.safeB (addTile (state node3) (13 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node3) (13 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (13 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node3_child14_unsafe : FactorizedRules.safeB (addTile (state node3) (14 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node3) (14 : Tile)) (0 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨1, by decide⟩ ⟨3, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node3_child15_unsafe : FactorizedRules.safeB (addTile (state node3) (15 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node3) (15 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (15 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node3_child16_unsafe : FactorizedRules.safeB (addTile (state node3) (16 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node3) (16 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (16 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node3_child17_unsafe : FactorizedRules.safeB (addTile (state node3) (17 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node3) (17 : Tile)) (0 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨1, by decide⟩ ⟨6, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node3_child18_unsafe : FactorizedRules.safeB (addTile (state node3) (18 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node3) (18 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (18 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node3_child19_unsafe : FactorizedRules.safeB (addTile (state node3) (19 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node3) (19 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (19 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node3_child20_unsafe : FactorizedRules.safeB (addTile (state node3) (20 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node3) (20 : Tile)) (0 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨2, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node3_child21_unsafe : FactorizedRules.safeB (addTile (state node3) (21 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node3) (21 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (21 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node3_child22_unsafe : FactorizedRules.safeB (addTile (state node3) (22 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node3) (22 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (22 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node3_child23_unsafe : FactorizedRules.safeB (addTile (state node3) (23 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node3) (23 : Tile)) (0 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨2, by decide⟩ ⟨3, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node3_child24_unsafe : FactorizedRules.safeB (addTile (state node3) (24 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node3) (24 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (24 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node3_child25_unsafe : FactorizedRules.safeB (addTile (state node3) (25 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node3) (25 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (25 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node3_child26_unsafe : FactorizedRules.safeB (addTile (state node3) (26 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node3) (26 : Tile)) (0 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨2, by decide⟩ ⟨6, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node3_kind27_full : ¬ state node3 (27 : Tile) < 4 := by
  decide +kernel

theorem node3_kind28_full : ¬ state node3 (28 : Tile) < 4 := by
  decide +kernel

theorem node3_kind29_full : ¬ state node3 (29 : Tile) < 4 := by
  decide +kernel

theorem node3_child30_unsafe : FactorizedRules.safeB (addTile (state node3) (30 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node3) (30 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (30 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node3_child31_unsafe : FactorizedRules.safeB (addTile (state node3) (31 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node3) (31 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (31 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node3_child32_known :
    known [node4,node5,node6,node7,node8,node9,node10] (node3.pRefs.getD (32 : Tile).val 7) (addTile (state node3) (32 : Tile)) .N = true := by
  decide +kernel

theorem node3_child33_known :
    known [node4,node5,node6,node7,node8,node9,node10] (node3.pRefs.getD (33 : Tile).val 7) (addTile (state node3) (33 : Tile)) .N = true := by
  decide +kernel

theorem node3_rule_checked : checkRule [node4,node5,node6,node7,node8,node9,node10] node3 = true := by
  change allTiles.all (fun kind =>
    if state node3 kind < 4 then
      if FactorizedRules.safeB (addTile (state node3) kind) then
        known [node4,node5,node6,node7,node8,node9,node10] (node3.pRefs.getD kind.val 7) (addTile (state node3) kind) .N
      else true
    else true) = true
  simp only [allTiles, List.all_cons, List.all_nil,
    node3_child0_unsafe,
    node3_child1_unsafe,
    node3_child2_unsafe,
    node3_child3_unsafe,
    node3_child4_unsafe,
    node3_child5_unsafe,
    node3_child6_unsafe,
    node3_child7_unsafe,
    node3_child8_unsafe,
    node3_child9_unsafe,
    node3_child10_unsafe,
    node3_child11_unsafe,
    node3_child12_unsafe,
    node3_child13_unsafe,
    node3_child14_unsafe,
    node3_child15_unsafe,
    node3_child16_unsafe,
    node3_child17_unsafe,
    node3_child18_unsafe,
    node3_child19_unsafe,
    node3_child20_unsafe,
    node3_child21_unsafe,
    node3_child22_unsafe,
    node3_child23_unsafe,
    node3_child24_unsafe,
    node3_child25_unsafe,
    node3_child26_unsafe,
    node3_kind27_full,
    node3_kind28_full,
    node3_kind29_full,
    node3_child30_unsafe,
    node3_child31_unsafe,
    node3_child32_known,
    node3_child33_known,
    Bool.false_eq_true, ↓reduceIte, ite_self, Bool.and_self]

theorem node3_shape :
    decide (node3.counts.size = 34 ∧ node3.pRefs.size = 34) = true := by
  decide +kernel

theorem node3_checked : checkNode [node4,node5,node6,node7,node8,node9,node10] node3 = true := by
  simp only [checkNode, node3_shape, node3_source_safe,
    node3_rule_checked, Bool.and_self]

end Mahjong.PilotGameChecksV18

#print axioms Mahjong.PilotGameChecksV18.node3_checked
