import Mahjong.PilotGameNode0V18
import Mahjong.PilotGameNode4V18
import Mahjong.PilotGameNode9V18
import Mahjong.PilotGameNode10V18
import Mahjong.PilotGameNode2V18
import Mahjong.PilotGameNode3V18

set_option autoImplicit false
set_option maxRecDepth 32768
set_option maxHeartbeats 20000000

namespace Mahjong.PilotGameChecksV18

open PilotGameV18 PilotActualDataV18 PilotGameCheckBridgeV18

theorem node1_source_safe : FactorizedRules.safeB (state node1) = true := by
  exact safeB_of_contained _ _ (by decide +kernel) node4_source_safe

theorem node1_rule_checked : checkRule [node2,node3,node4,node5,node6,node7,node8,node9,node10] node1 = true := by
  decide +kernel

theorem node1_shape :
    decide (node1.counts.size = 34 ∧ node1.pRefs.size = 34) = true := by
  decide +kernel

theorem node1_checked : checkNode [node2,node3,node4,node5,node6,node7,node8,node9,node10] node1 = true := by
  simp only [checkNode, node1_shape, node1_source_safe,
    node1_rule_checked, Bool.and_self]

theorem node5_source_safe : FactorizedRules.safeB (state node5) = true := by
  exact safeB_of_contained _ _ (by decide +kernel) node9_source_safe

theorem node5_rule_checked : checkRule [node6,node7,node8,node9,node10] node5 = true := by
  decide +kernel

theorem node5_shape :
    decide (node5.counts.size = 34 ∧ node5.pRefs.size = 34) = true := by
  decide +kernel

theorem node5_checked : checkNode [node6,node7,node8,node9,node10] node5 = true := by
  simp only [checkNode, node5_shape, node5_source_safe,
    node5_rule_checked, Bool.and_self]

theorem node6_source_safe : FactorizedRules.safeB (state node6) = true := by
  exact safeB_of_contained _ _ (by decide +kernel) node9_source_safe

theorem node6_rule_checked : checkRule [node7,node8,node9,node10] node6 = true := by
  decide +kernel

theorem node6_shape :
    decide (node6.counts.size = 34 ∧ node6.pRefs.size = 34) = true := by
  decide +kernel

theorem node6_checked : checkNode [node7,node8,node9,node10] node6 = true := by
  simp only [checkNode, node6_shape, node6_source_safe,
    node6_rule_checked, Bool.and_self]

theorem node7_source_safe : FactorizedRules.safeB (state node7) = true := by
  exact safeB_of_contained _ _ (by decide +kernel) node10_source_safe

theorem node7_rule_checked : checkRule [node8,node9,node10] node7 = true := by
  decide +kernel

theorem node7_shape :
    decide (node7.counts.size = 34 ∧ node7.pRefs.size = 34) = true := by
  decide +kernel

theorem node7_checked : checkNode [node8,node9,node10] node7 = true := by
  simp only [checkNode, node7_shape, node7_source_safe,
    node7_rule_checked, Bool.and_self]

theorem node8_source_safe : FactorizedRules.safeB (state node8) = true := by
  exact safeB_of_contained _ _ (by decide +kernel) node10_source_safe

theorem node8_rule_checked : checkRule [node9,node10] node8 = true := by
  decide +kernel

theorem node8_shape :
    decide (node8.counts.size = 34 ∧ node8.pRefs.size = 34) = true := by
  decide +kernel

theorem node8_checked : checkNode [node9,node10] node8 = true := by
  simp only [checkNode, node8_shape, node8_source_safe,
    node8_rule_checked, Bool.and_self]

theorem actual_trace_checked :
    PilotGameV18.checkTrace PilotActualDataV18.actualTrace = true := by
  simp only [PilotActualDataV18.actualTrace, PilotGameV18.checkTrace,
    node0_checked,
    node1_checked,
    node2_checked,
    node3_checked,
    node4_checked,
    node5_checked,
    node6_checked,
    node7_checked,
    node8_checked,
    node9_checked,
    node10_checked, Bool.and_self]

end Mahjong.PilotGameChecksV18

#print axioms Mahjong.PilotGameChecksV18.actual_trace_checked
