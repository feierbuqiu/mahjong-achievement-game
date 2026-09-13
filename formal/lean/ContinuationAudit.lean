import Mahjong
import Mahjong.AnchorDAG.N24086
import Mahjong.Extracted32.Root
import Mahjong.BoundBenchSafeCertV1
import Mahjong.BoundCacheSafeV1
import Mahjong.ResponseCertificateTest
import Lean

namespace Mahjong.ContinuationAudit

def twentyDigits : List Nat :=
  [0,1,1,0,3,3,0,3,1,1,0,1,0,1,1,0,0,0,1,0,1,0,1,1,0,0,0,0,0,0,0,0,0,0]
def thirtyTwoDigits : List Nat :=
  [1,0,1,0,1,1,0,1,1,0,0,0,0,4,4,0,4,1,1,0,1,0,1,1,0,1,1,1,1,1,1,1,1,1]

theorem twenty_digits_checked : MoveEnumeration.stateEqB AnchorDAG.N24086.state
    (fun t => twentyDigits[t.val]!) = true := by decide +kernel
theorem thirty_two_digits_checked : MoveEnumeration.stateEqB Extracted32.original
    (fun t => thirtyTwoDigits[t.val]!) = true := by decide +kernel

end Mahjong.ContinuationAudit

open Lean Elab Command

run_cmd do
  let env ← getEnv
  let allowed : List Name := [`propext, `Classical.choice, `Quot.sound]
  let mut count := 0
  for (name, info) in env.constants.toList do
    if name.toString.startsWith "Mahjong." then
      if info matches .thmInfo _ then
        count := count + 1
        let axs ← collectAxioms name
        for ax in axs do
          unless ax ∈ allowed do throwError "Unapproved axiom in {name}: {ax}"
  unless count > 6000 do throwError "Generated proof DAG was not loaded: {count}"
  logInfo m!"AXIOM_AUDIT_PASS theorem_count={count}; only propext, Classical.choice, Quot.sound allowed"
  let some twenty := env.find? `Mahjong.AnchorDAG.N24086.original_second_player_wins
    | throwError "Missing actual 20-tile root theorem"
  liftTermElabM do
    let expected ← Term.elabType (← `(Mahjong.SafeGame.SecondPlayerWins Mahjong.Step Mahjong.Win Mahjong.AnchorDAG.N24086.state))
    unless ← Meta.isDefEq twenty.type expected do throwError "20-tile theorem still has premises or wrong type"
  logInfo "ACTUAL_20_TILE_CLOSED_THEOREM_PRESENT"
  let some thirtyTwo := env.find? `Mahjong.Extracted32.original_second_player_wins
    | throwError "Missing original-coordinate 32-tile root theorem"
  liftTermElabM do
    let expected ← Term.elabType (← `(Mahjong.SafeGame.SecondPlayerWins Mahjong.Step Mahjong.Win Mahjong.Extracted32.original))
    unless ← Meta.isDefEq thirtyTwo.type expected do throwError "32-tile theorem still has premises or wrong type"
  logInfo "EXTRACTED_32_TILE_CLOSED_THEOREM_PRESENT"
  match env.find? `Mahjong.empty_second_player_wins with
  | none => logInfo "END_TO_END_NOT_VERIFIED: no closed empty-position theorem exists"
  | some info =>
      unless info matches .thmInfo _ do throwError "Final declaration is not a theorem"
      liftTermElabM do
        let expected ← Term.elabType (← `(Mahjong.SafeGame.SecondPlayerWins Mahjong.Step Mahjong.Win Mahjong.empty))
        unless ← Meta.isDefEq info.type expected do throwError "Empty-position theorem has wrong type or premises"
      logInfo "END_TO_END_CLOSED_THEOREM_PRESENT"
