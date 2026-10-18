import Mahjong.PilotGameCheckBridgeV18

set_option autoImplicit false
set_option maxRecDepth 32768
set_option maxHeartbeats 20000000

namespace Mahjong.PilotGameChecksV18

open PilotGameV18 PilotActualDataV18 PilotGameCheckBridgeV18

theorem node4_source_safe : FactorizedRules.safeB (state node4) = true := by
  decide +kernel

theorem node4_child0_unsafe : FactorizedRules.safeB (addTile (state node4) (0 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node4) (0 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨1, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node4_child1_unsafe : FactorizedRules.safeB (addTile (state node4) (1 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node4) (1 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨2, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (1 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node4_child2_unsafe : FactorizedRules.safeB (addTile (state node4) (2 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node4) (2 : Tile)) (0 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨1, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node4_child3_unsafe : FactorizedRules.safeB (addTile (state node4) (3 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node4) (3 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (3 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node4_child4_unsafe : FactorizedRules.safeB (addTile (state node4) (4 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node4) (4 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (4 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node4_child5_unsafe : FactorizedRules.safeB (addTile (state node4) (5 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node4) (5 : Tile)) (0 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨3, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node4_child6_unsafe : FactorizedRules.safeB (addTile (state node4) (6 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node4) (6 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (6 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node4_child7_unsafe : FactorizedRules.safeB (addTile (state node4) (7 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node4) (7 : Tile)) (0 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨6, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node4_child8_unsafe : FactorizedRules.safeB (addTile (state node4) (8 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node4) (8 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (8 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node4_child9_unsafe : FactorizedRules.safeB (addTile (state node4) (9 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node4) (9 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (9 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node4_child10_unsafe : FactorizedRules.safeB (addTile (state node4) (10 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node4) (10 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (10 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node4_child11_unsafe : FactorizedRules.safeB (addTile (state node4) (11 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node4) (11 : Tile)) (0 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨1, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node4_child12_unsafe : FactorizedRules.safeB (addTile (state node4) (12 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node4) (12 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (12 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node4_child13_unsafe : FactorizedRules.safeB (addTile (state node4) (13 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node4) (13 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (13 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node4_child14_unsafe : FactorizedRules.safeB (addTile (state node4) (14 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node4) (14 : Tile)) (0 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨1, by decide⟩ ⟨3, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node4_child15_unsafe : FactorizedRules.safeB (addTile (state node4) (15 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node4) (15 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (15 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node4_child16_unsafe : FactorizedRules.safeB (addTile (state node4) (16 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node4) (16 : Tile)) (0 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨1, by decide⟩ ⟨6, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node4_child17_unsafe : FactorizedRules.safeB (addTile (state node4) (17 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node4) (17 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (17 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node4_child18_unsafe : FactorizedRules.safeB (addTile (state node4) (18 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node4) (18 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (18 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node4_child19_unsafe : FactorizedRules.safeB (addTile (state node4) (19 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node4) (19 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (19 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node4_child20_unsafe : FactorizedRules.safeB (addTile (state node4) (20 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node4) (20 : Tile)) (0 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨2, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node4_child21_unsafe : FactorizedRules.safeB (addTile (state node4) (21 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node4) (21 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (21 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node4_child22_unsafe : FactorizedRules.safeB (addTile (state node4) (22 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node4) (22 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (22 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node4_child23_unsafe : FactorizedRules.safeB (addTile (state node4) (23 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node4) (23 : Tile)) (0 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨2, by decide⟩ ⟨3, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node4_child24_unsafe : FactorizedRules.safeB (addTile (state node4) (24 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node4) (24 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (24 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node4_child25_unsafe : FactorizedRules.safeB (addTile (state node4) (25 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node4) (25 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (25 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node4_child26_unsafe : FactorizedRules.safeB (addTile (state node4) (26 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node4) (26 : Tile)) (0 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨2, by decide⟩ ⟨6, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (0 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node4_kind27_full : ¬ state node4 (27 : Tile) < 4 := by
  decide +kernel

theorem node4_kind28_full : ¬ state node4 (28 : Tile) < 4 := by
  decide +kernel

theorem node4_kind29_full : ¬ state node4 (29 : Tile) < 4 := by
  decide +kernel

theorem node4_child30_unsafe : FactorizedRules.safeB (addTile (state node4) (30 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node4) (30 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (30 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node4_child31_unsafe : FactorizedRules.safeB (addTile (state node4) (31 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node4) (31 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (31 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node4_child32_unsafe : FactorizedRules.safeB (addTile (state node4) (32 : Tile)) = false := by
  exact unsafe_after_standard_next (addTile (state node4) (32 : Tile)) (2 : Tile)
    (fun j : Fin 4 => if j.val = 0 then Meld.sequence ⟨0, by decide⟩ ⟨0, by decide⟩ else if j.val = 1 then Meld.triplet (27 : Tile) else if j.val = 2 then Meld.triplet (28 : Tile) else Meld.triplet (29 : Tile)) (32 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node4_child33_unsafe : FactorizedRules.safeB (addTile (state node4) (33 : Tile)) = false := by
  exact unsafe_after_orphans_next (addTile (state node4) (33 : Tile)) (26 : Tile) (27 : Tile)
    (by decide +kernel) (by decide +kernel) (by decide +kernel) (by decide +kernel)

theorem node4_rule_checked : checkRule [node5,node6,node7,node8,node9,node10] node4 = true := by
  change allTiles.all (fun kind =>
    if state node4 kind < 4 then
      if FactorizedRules.safeB (addTile (state node4) kind) then
        known [node5,node6,node7,node8,node9,node10] (node4.pRefs.getD kind.val 6) (addTile (state node4) kind) .N
      else true
    else true) = true
  simp only [allTiles, List.all_cons, List.all_nil,
    node4_child0_unsafe,
    node4_child1_unsafe,
    node4_child2_unsafe,
    node4_child3_unsafe,
    node4_child4_unsafe,
    node4_child5_unsafe,
    node4_child6_unsafe,
    node4_child7_unsafe,
    node4_child8_unsafe,
    node4_child9_unsafe,
    node4_child10_unsafe,
    node4_child11_unsafe,
    node4_child12_unsafe,
    node4_child13_unsafe,
    node4_child14_unsafe,
    node4_child15_unsafe,
    node4_child16_unsafe,
    node4_child17_unsafe,
    node4_child18_unsafe,
    node4_child19_unsafe,
    node4_child20_unsafe,
    node4_child21_unsafe,
    node4_child22_unsafe,
    node4_child23_unsafe,
    node4_child24_unsafe,
    node4_child25_unsafe,
    node4_child26_unsafe,
    node4_kind27_full,
    node4_kind28_full,
    node4_kind29_full,
    node4_child30_unsafe,
    node4_child31_unsafe,
    node4_child32_unsafe,
    node4_child33_unsafe,
    Bool.false_eq_true, ↓reduceIte, ite_self, Bool.and_self]

theorem node4_shape :
    decide (node4.counts.size = 34 ∧ node4.pRefs.size = 34) = true := by
  decide +kernel

theorem node4_checked : checkNode [node5,node6,node7,node8,node9,node10] node4 = true := by
  simp only [checkNode, node4_shape, node4_source_safe,
    node4_rule_checked, Bool.and_self]

end Mahjong.PilotGameChecksV18

#print axioms Mahjong.PilotGameChecksV18.node4_checked
