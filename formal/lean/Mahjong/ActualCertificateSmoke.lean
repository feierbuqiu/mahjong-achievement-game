import Mahjong.ActualCandidateSafe
import Mahjong.ActualTerminalReplies
import Mahjong.Certificate

/-!
A complete kernel-checked certificate for ONE concrete 34-tile Mahjong table.
This module does not claim a proof for the empty initial position.
All negative and positive rule checks are independently proved in imports.
-/
namespace Mahjong.ActualCertificateSmoke

open SafeGame Certificate MoveEnumeration

abbrev candidate : State := ActualCandidateFacts.candidate

theorem candidate_valid : Valid candidate := ActualCandidateFacts.valid
theorem candidate_total : total candidate = 34 := ActualCandidateFacts.tiles34
theorem candidate_safe : Safe Step Win candidate := ActualCandidateSafe.safe

theorem candidate_terminal_checked : safeSuccessors candidate = [] := by
  cases he : safeSuccessors candidate with
  | nil => rfl
  | cons child rest =>
    have hm : child ∈ safeSuccessors candidate := by rw [he]; simp
    exact False.elim (ActualTerminalReplies.no_safe_step child
      ((safeSuccessors_iff candidate child).2 hm))

def trace : List (Claim State) := [⟨candidate, .P⟩]

theorem trace_checked : checkTrace safeSuccessors trace = true := by
  simp [trace, checkTrace, checkClaim, candidate_terminal_checked]

theorem candidate_P : NormalStrategy (SafeStep Step Win) candidate .P := by
  exact checkTrace_sound safeSuccessors (SafeStep Step Win) safeSuccessors_iff
    trace trace_checked ⟨candidate, .P⟩ (by simp [trace])

theorem candidate_original_second_player_wins : SecondPlayerWins Step Win candidate :=
  safe_p_second_player_wins (move := Step) (win := Win) (domain := Valid)
    (fun _ edge => step_target_valid edge)
    (fun _ valid live => nonwinning_has_step valid live)
    candidate_valid candidate_safe candidate_P

end Mahjong.ActualCertificateSmoke

#print axioms Mahjong.ActualCertificateSmoke.candidate_safe
#print axioms Mahjong.ActualCertificateSmoke.trace_checked
#print axioms Mahjong.ActualCertificateSmoke.candidate_P
#print axioms Mahjong.ActualCertificateSmoke.candidate_original_second_player_wins
