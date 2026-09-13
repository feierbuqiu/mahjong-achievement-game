import Mahjong.ActualCandidateFacts

set_option maxRecDepth 8192
set_option maxHeartbeats 20000000

namespace Mahjong.ActualCandidateChildren
open ActualCandidateFacts FastRuleChecker

theorem child20_checked : winB (addTile candidate 20) = false := by decide +kernel

end Mahjong.ActualCandidateChildren
#print axioms Mahjong.ActualCandidateChildren.child20_checked

