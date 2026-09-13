import MahjongNext.Grouped20.Root
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
  let some info := env.find? `Mahjong.ResponseTableGrouped20.original_second_player_wins
    | throwError "Missing grouped 20-tile theorem"
  unless info matches .thmInfo _ do throwError "Root is not a theorem"
  liftTermElabM do
    let expected ← Term.elabType (← `(Mahjong.SafeGame.SecondPlayerWins Mahjong.Step Mahjong.Win Mahjong.ResponseTableGrouped20.original))
    unless ← Meta.isDefEq info.type expected do throwError "Wrong root type or remaining premises"
  logInfo "GROUPED_20_TILE_CLOSED_THEOREM_PRESENT"
  logInfo "END_TO_END_NOT_VERIFIED: concrete 20-tile proof only"
