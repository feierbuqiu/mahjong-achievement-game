import Mahjong.LayeredRetrograde
import Mahjong.MoveNormalization

set_option autoImplicit false

namespace Mahjong.RetrogradeControls

def chain (s : Fin 3) : List (Fin 3) := if s.val = 0 then [1] else if s.val = 1 then [2] else []
def withExtra (s : Fin 3) : List (Fin 3) := if s.val = 0 then [1,2] else chain s
def labels (succ : Fin 3 → List (Fin 3)) (order : List (Fin 3)) : Option (List (Option Bool)) :=
  (LayeredRetrograde.run succ order (fun _ => none)).map fun table => [table 0,table 1,table 2]

theorem valid_order : labels chain [2,1,0] = some [some true,some false,some true] := by decide
theorem reversed_order_rejected : labels chain [0,1,2] = none := by decide
theorem missing_dependency_rejected : labels chain [1,0] = none := by decide
theorem duplicate_finished_node : labels chain [2,2,1,0] = labels chain [2,1,0] := by decide
theorem omitted_edge_changes_result :
    labels withExtra [2,1,0] = some [some false,some false,some true] ∧
    labels chain [2,1,0] = some [some true,some false,some true] := by decide

def falseZero : RetrogradeEvaluation.Bucket Nat := ⟨[1],[1],0⟩
theorem incorrect_summary_detected :
    falseZero.reportedP ≠ RetrogradeEvaluation.countP (fun _ => true) falseZero.rows := by decide
theorem incorrect_summary_can_change_result :
    RetrogradeEvaluation.optimized (fun _ => true) [falseZero] = true ∧
    RetrogradeEvaluation.scan (fun _ : Nat => true) [1] = false := by decide

theorem decreasing_id_needs_extra_sort :
    MoveNormalization.fast ⟨2,4,6,0⟩ 2 1 ≠
      SuitSorting.sort id (MoveNormalization.replace ⟨2,4,6,0⟩ 2 1) := by decide

end Mahjong.RetrogradeControls

#print axioms Mahjong.RetrogradeControls.valid_order
#print axioms Mahjong.RetrogradeControls.reversed_order_rejected
#print axioms Mahjong.RetrogradeControls.missing_dependency_rejected
#print axioms Mahjong.RetrogradeControls.duplicate_finished_node
#print axioms Mahjong.RetrogradeControls.omitted_edge_changes_result
#print axioms Mahjong.RetrogradeControls.incorrect_summary_detected
#print axioms Mahjong.RetrogradeControls.incorrect_summary_can_change_result
#print axioms Mahjong.RetrogradeControls.decreasing_id_needs_extra_sort
