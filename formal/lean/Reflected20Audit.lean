import MahjongNext.ResponseTableFull20
import Lean

namespace Mahjong.Reflected20Audit
def expectedDigits : List Nat :=
  [0,1,1,0,3,3,0,3,1,1,0,1,0,1,1,0,0,0,1,0,1,0,1,1,0,0,0,0,0,0,0,0,0,0]
theorem root_digits_checked : MoveEnumeration.stateEqB ResponseTableFull20.original
    (fun t => expectedDigits[t.val]!) = true := by decide +kernel
end Mahjong.Reflected20Audit

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
  for old in [`Mahjong.AnchorDAG.N24086.original_second_player_wins,
              `Mahjong.Greedy20V1.original_second_player_wins] do
    if (env.find? old).isSome then throwError "Old per-row root imported: {old}"
  logInfo "NO_PREVIOUS_20_TILE_ROOT_IMPORTED"
  let some info := env.find? `Mahjong.ResponseTableFull20.original_second_player_wins
    | throwError "Missing reflected root theorem"
  unless info matches .thmInfo _ do throwError "Root is not a theorem"
  liftTermElabM do
    let expected ← Term.elabType (← `(Mahjong.SafeGame.SecondPlayerWins Mahjong.Step Mahjong.Win Mahjong.ResponseTableFull20.original))
    unless ← Meta.isDefEq info.type expected do throwError "Wrong root type or remaining premises"
  logInfo "REFLECTED_20_TILE_CLOSED_THEOREM_PRESENT"
  if (env.find? `Mahjong.empty_second_player_wins).isSome then
    throwError "Unexpected empty-position theorem in this test"
  logInfo "END_TO_END_NOT_VERIFIED: reflected certificate is for the concrete 20-tile game"
