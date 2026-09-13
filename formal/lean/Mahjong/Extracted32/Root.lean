import Mahjong.Extracted32.P000000

namespace Mahjong.Extracted32
def original (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 4 | 5 | 7 | 8 | 17 | 18 | 20 | 22 | 23 | 25 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 1 | 3 | 6 | 9 | 10 | 11 | 12 | 15 | 19 | 21 | 24 => 0
  | 13 | 14 | 16 => 4
  | _ => 0

theorem original_checked : Generators.checkReference [.swapSuits 0 1] Extracted32.P000000.state original = true := by decide +kernel
theorem original_proved : ResponseCertificate.ProvedP original :=
  (Extracted32.P000000.proved).ofPath [.swapSuits 0 1] (Generators.stateEqB_sound original_checked)
theorem original_second_player_wins : SafeGame.SecondPlayerWins Step Win original := original_proved.secondPlayerWins
end Mahjong.Extracted32

#print axioms Mahjong.Extracted32.original_second_player_wins
