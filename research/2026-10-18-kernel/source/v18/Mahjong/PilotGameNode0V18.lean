import Mahjong.PilotGameCheckBridgeV18

set_option autoImplicit false
set_option maxRecDepth 32768
set_option maxHeartbeats 20000000

namespace Mahjong.PilotGameChecksV18

open PilotGameV18 PilotActualDataV18 PilotGameCheckBridgeV18

theorem node0_source_safe : FactorizedRules.safeB (state node0) = true := by
  decide +kernel

theorem node0_child0_unsafe : FactorizedRules.safeB (addTile (state node0) (0 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node0) (0 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨1, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node0_child1_unsafe : FactorizedRules.safeB (addTile (state node0) (1 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node0) (1 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨2, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (1 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node0_child2_unsafe : FactorizedRules.safeB (addTile (state node0) (2 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node0) (2 : Tile)) (0 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨1, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node0_child3_unsafe : FactorizedRules.safeB (addTile (state node0) (3 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node0) (3 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (3 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node0_child4_unsafe : FactorizedRules.safeB (addTile (state node0) (4 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node0) (4 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (4 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node0_child5_unsafe : FactorizedRules.safeB (addTile (state node0) (5 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node0) (5 : Tile)) (0 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨3, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node0_child6_unsafe : FactorizedRules.safeB (addTile (state node0) (6 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node0) (6 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (6 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node0_child7_unsafe : FactorizedRules.safeB (addTile (state node0) (7 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node0) (7 : Tile)) (0 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨6, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node0_child8_unsafe : FactorizedRules.safeB (addTile (state node0) (8 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node0) (8 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (8 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node0_child9_unsafe : FactorizedRules.safeB (addTile (state node0) (9 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node0) (9 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (9 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node0_child10_unsafe : FactorizedRules.safeB (addTile (state node0) (10 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node0) (10 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (10 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node0_child11_unsafe : FactorizedRules.safeB (addTile (state node0) (11 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node0) (11 : Tile)) (0 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨1, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node0_child12_unsafe : FactorizedRules.safeB (addTile (state node0) (12 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node0) (12 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (12 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node0_child13_unsafe : FactorizedRules.safeB (addTile (state node0) (13 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node0) (13 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (13 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node0_child14_unsafe : FactorizedRules.safeB (addTile (state node0) (14 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node0) (14 : Tile)) (0 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨1, by decide⟩ ⟨3, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node0_child15_unsafe : FactorizedRules.safeB (addTile (state node0) (15 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node0) (15 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (15 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node0_child16_unsafe : FactorizedRules.safeB (addTile (state node0) (16 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node0) (16 : Tile)) (0 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨1, by decide⟩ ⟨6, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node0_child17_unsafe : FactorizedRules.safeB (addTile (state node0) (17 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node0) (17 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (17 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node0_child18_unsafe : FactorizedRules.safeB (addTile (state node0) (18 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node0) (18 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (18 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node0_child19_unsafe : FactorizedRules.safeB (addTile (state node0) (19 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node0) (19 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (19 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node0_child20_unsafe : FactorizedRules.safeB (addTile (state node0) (20 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node0) (20 : Tile)) (0 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨2, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node0_child21_unsafe : FactorizedRules.safeB (addTile (state node0) (21 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node0) (21 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (21 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node0_child22_unsafe : FactorizedRules.safeB (addTile (state node0) (22 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node0) (22 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (22 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node0_child23_unsafe : FactorizedRules.safeB (addTile (state node0) (23 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node0) (23 : Tile)) (0 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨2, by decide⟩ ⟨3, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node0_child24_unsafe : FactorizedRules.safeB (addTile (state node0) (24 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node0) (24 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (24 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node0_child25_unsafe : FactorizedRules.safeB (addTile (state node0) (25 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node0) (25 : Tile)) (0 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨2, by decide⟩ ⟨6, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node0_child26_unsafe : FactorizedRules.safeB (addTile (state node0) (26 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node0) (26 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (26 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node0_kind27_full : ¬ state node0 (27 : Tile) < 4 := by
  decide +kernel

theorem node0_kind28_full : ¬ state node0 (28 : Tile) < 4 := by
  decide +kernel

theorem node0_kind29_full : ¬ state node0 (29 : Tile) < 4 := by
  decide +kernel

theorem node0_child30_unsafe : FactorizedRules.safeB (addTile (state node0) (30 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node0) (30 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (30 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node0_child31_unsafe : FactorizedRules.safeB (addTile (state node0) (31 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node0) (31 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (31 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node0_child32_unsafe : FactorizedRules.safeB (addTile (state node0) (32 : Tile)) = false := by
  exact unsafe_after_orphans_next (addTile (state node0) (32 : Tile)) (33 : Tile) (27 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node0_child33_unsafe : FactorizedRules.safeB (addTile (state node0) (33 : Tile)) = false := by
  exact unsafe_after_orphans_next (addTile (state node0) (33 : Tile)) (32 : Tile) (27 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node0_rule_checked : checkRule [node1,node2,node3,node4,node5,node6,node7,node8,node9,node10] node0 = true := by
  change allTiles.all (fun kind =>
    if state node0 kind < 4 then
      if FactorizedRules.safeB (addTile (state node0) kind) then
        known [node1,node2,node3,node4,node5,node6,node7,node8,node9,node10] (node0.pRefs.getD kind.val 10) (addTile (state node0) kind) .N
      else true
    else true) = true
  simp only [allTiles, List.all_cons, List.all_nil,
    node0_child0_unsafe,
    node0_child1_unsafe,
    node0_child2_unsafe,
    node0_child3_unsafe,
    node0_child4_unsafe,
    node0_child5_unsafe,
    node0_child6_unsafe,
    node0_child7_unsafe,
    node0_child8_unsafe,
    node0_child9_unsafe,
    node0_child10_unsafe,
    node0_child11_unsafe,
    node0_child12_unsafe,
    node0_child13_unsafe,
    node0_child14_unsafe,
    node0_child15_unsafe,
    node0_child16_unsafe,
    node0_child17_unsafe,
    node0_child18_unsafe,
    node0_child19_unsafe,
    node0_child20_unsafe,
    node0_child21_unsafe,
    node0_child22_unsafe,
    node0_child23_unsafe,
    node0_child24_unsafe,
    node0_child25_unsafe,
    node0_child26_unsafe,
    node0_kind27_full,
    node0_kind28_full,
    node0_kind29_full,
    node0_child30_unsafe,
    node0_child31_unsafe,
    node0_child32_unsafe,
    node0_child33_unsafe,
    Bool.false_eq_true, ↓reduceIte, ite_self, Bool.and_self]

theorem node0_shape :
    decide (node0.counts.size = 34 ∧ node0.pRefs.size = 34) = true := by
  decide +kernel

theorem node0_checked : checkNode [node1,node2,node3,node4,node5,node6,node7,node8,node9,node10] node0 = true := by
  simp only [checkNode, node0_shape, node0_source_safe,
    node0_rule_checked, Bool.and_self]

end Mahjong.PilotGameChecksV18

#print axioms Mahjong.PilotGameChecksV18.node0_checked
