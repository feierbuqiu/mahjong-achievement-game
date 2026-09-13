import MahjongNext.Actual14.Root
import Lean

namespace Mahjong.Actual14Audit
def expectedDigits : List Nat :=
  [0,0,0,0,0,1,1,1,1,0,0,0,1,0,0,0,0,2,0,0,0,1,1,2,0,3,0,0,0,0,0,0,0,0]
theorem root_digits_checked : MoveEnumeration.stateEqB Actual14.original
    (fun t => expectedDigits[t.val]!) = true := by decide +kernel
theorem exactly_fourteen : total Actual14.original = 14 := Actual14.original_tiles
end Mahjong.Actual14Audit

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
    for bannedPrefix in ["Mahjong.AnchorDAG.", "Mahjong.Greedy20V1.",
                   "Mahjong.ResponseTableFull20.", "Mahjong.ResponseTableGrouped20.",
                   "Mahjong.Actual14ResponsesV1.", "Mahjong.Actual14ResponsesV2."] do
      if name.toString.startsWith bannedPrefix then throwError "Previous P proof imported: {name}"
  logInfo m!"AXIOM_AUDIT_PASS theorem_count={count}; only propext, Classical.choice, Quot.sound allowed"
  logInfo "NO_PREVIOUS_P_CERTIFICATE_IMPORTED"
  let some info := env.find? `Mahjong.Actual14.original_second_player_wins
    | throwError "Missing concrete 14-tile theorem"
  unless info matches .thmInfo _ do throwError "Root is not a theorem"
  liftTermElabM do
    let expected ← Term.elabType (← `(Mahjong.SafeGame.SecondPlayerWins Mahjong.Step Mahjong.Win Mahjong.Actual14.original))
    unless ← Meta.isDefEq info.type expected do throwError "Wrong root type or remaining premises"
  logInfo "ACTUAL_14_TILE_CLOSED_THEOREM_PRESENT"
  if (env.find? `Mahjong.empty_second_player_wins).isSome then
    throwError "Unexpected empty-position theorem in this test"
  logInfo "END_TO_END_NOT_VERIFIED: concrete 14-tile branch does not close the empty-position strategy"
