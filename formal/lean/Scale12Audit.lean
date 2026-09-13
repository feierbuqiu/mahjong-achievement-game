import MahjongScale.Actual12V2.Root
import Lean

namespace Mahjong.Scale12Audit
def expectedDigits : List Nat :=
  [0,0,0,0,0,0,0,0,2,0,0,0,0,0,1,1,1,1,0,0,0,1,1,1,0,3,0,0,0,0,0,0,0,0]
theorem actual_input : MoveEnumeration.stateEqB Scale12V2.original
    (fun t => expectedDigits[t.val]!) = true := by decide +kernel
theorem actual_tile_count : total Scale12V2.original = 12 := Scale12V2.original_tiles
end Mahjong.Scale12Audit

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
  logInfo m!"AXIOM_AUDIT_PASS theorem_count={count}; only standard three axioms allowed"
  if (env.find? `Mahjong.Scale12.original_second_player_wins).isSome then
    throwError "Unaccepted V1 root imported"
  let some info := env.find? `Mahjong.Scale12V2.original_second_player_wins
    | throwError "Missing exact 12-tile root theorem"
  unless info matches .thmInfo _ do throwError "Root is not a theorem"
  liftTermElabM do
    let expected ← Term.elabType (← `(Mahjong.SafeGame.SecondPlayerWins Mahjong.Step Mahjong.Win Mahjong.Scale12V2.original))
    unless ← Meta.isDefEq info.type expected do throwError "Wrong original-rule root type or remaining premises"
  logInfo "ACTUAL_12_TILE_CLOSED_THEOREM_PRESENT"
  if (env.find? `Mahjong.empty_second_player_wins).isSome then
    throwError "Unexpected empty theorem in a concrete-root audit"
  logInfo "END_TO_END_NOT_VERIFIED: original 12-tile branch certified; empty strategy not closed"
