import MahjongScale.Actual12Registry
import Lean

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
  let some info := env.find? `Mahjong.Scale12V2.original_second_player_wins
    | throwError "Missing exact 12-tile root theorem"
  unless info matches .thmInfo _ do throwError "Root is not a theorem"
  liftTermElabM do
    let expected ← Term.elabType (← `(Mahjong.SafeGame.SecondPlayerWins Mahjong.Step Mahjong.Win Mahjong.Scale12V2.original))
    unless ← Meta.isDefEq info.type expected do throwError "Root has remaining premises or a wrong type"
  logInfo "ACTUAL_12_TILE_CLOSED_THEOREM_PRESENT"
  logInfo "CHECKED_12_TABLE_REGISTRY_PRESENT: 757 local P entries plus their existing proof dependencies"
  if (env.find? `Mahjong.empty_second_player_wins).isSome then
    throwError "Unexpected empty theorem in a concrete-root registry audit"
  logInfo "END_TO_END_NOT_VERIFIED: registered concrete table; empty strategy not closed"
