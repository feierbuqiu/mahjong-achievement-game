import Mahjong.FastRuleChecker

set_option maxRecDepth 8192
set_option maxHeartbeats 20000000

namespace Mahjong.ActualCandidateFacts

open FastRuleChecker

/-- Raw candidate data only; the C++ outcome is never a premise. -/
def digits : List Nat :=
  [0,1,1,0,4,4,0,4,1,1,0,1,0,1,1,0,1,1,1,0,1,0,1,1,0,1,1,1,1,1,1,1,1,1]

def candidate : State := fun t =>
  match t.val with
  | 0 | 3 | 6 | 10 | 12 | 15 | 19 | 21 | 24 => 0
  | 4 | 5 | 7 => 4
  | _ => 1

theorem original_digits : candidate = (fun t => digits[t.val]!) := by
  apply (MoveEnumeration.stateEqB_iff _ _).1
  decide +kernel

theorem valid : Valid candidate :=
  (RuleChecker.validB_iff candidate).1 (by decide +kernel)

theorem tiles34 : total candidate = 34 := by decide +kernel

theorem notWin_checked : winB candidate = false := by decide +kernel

theorem notWin : ¬ Win candidate := by
  intro hw
  have hh := (winB_iff candidate valid).2 hw
  rw [notWin_checked] at hh
  contradiction

end Mahjong.ActualCandidateFacts

#print axioms Mahjong.ActualCandidateFacts.notWin
