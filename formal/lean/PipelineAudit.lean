import Mahjong.ExtractedFresh34.Root
import Lean

namespace Mahjong.PipelineAudit
def originalDigits : List Nat :=
  [1,0,1,0,4,4,0,4,1,0,1,1,0,1,1,0,1,1,1,0,1,0,1,1,0,1,1,1,1,1,1,1,1,1]
theorem original_checked : MoveEnumeration.stateEqB ExtractedFresh34.original
    (fun t => originalDigits[t.val]!) = true := by decide +kernel
end Mahjong.PipelineAudit

open Lean Elab Command
run_cmd do
  let env ← getEnv
  let allowed : List Name := [`propext, `Classical.choice, `Quot.sound]
  let mut count := 0
  for (name, info) in env.constants.toList do
    if name.toString.startsWith "Mahjong." then
      if info matches .thmInfo _ then
        count := count + 1
        for ax in (← collectAxioms name) do
          unless ax ∈ allowed do throwError "Unapproved axiom in {name}: {ax}"
  logInfo m!"AXIOM_AUDIT_PASS theorem_count={count}; only propext, Classical.choice, Quot.sound allowed"
  if (env.find? `Mahjong.ActualCandidateFacts.candidate).isSome then
    throwError "The independently generated leaf unexpectedly imports the previous anchor"
  logInfo "NO_PREVIOUS_ANCHOR_IMPORTED"
  let some info := env.find? `Mahjong.ExtractedFresh34.original_second_player_wins
    | throwError "Missing original-game theorem"
  liftTermElabM do
    let expected ← Term.elabType (← `(Mahjong.SafeGame.SecondPlayerWins Mahjong.Step Mahjong.Win Mahjong.ExtractedFresh34.original))
    unless ← Meta.isDefEq info.type expected do throwError "Unexpected theorem type or remaining premises"
  logInfo "FRESH_34_TILE_CLOSED_THEOREM_PRESENT"
  if (env.find? `Mahjong.empty_second_player_wins).isSome then
    throwError "Unexpected empty-position declaration in the endgame-only pipeline test"
  logInfo "END_TO_END_NOT_VERIFIED: this certificate is a 34-tile endgame, not the empty state"
