import Mahjong.ExplicitWin
import Mahjong.AnchorDAG.N00000
import Mahjong.AnchorDAG.N24046
import Mahjong.AnchorDAG.N24047
import Mahjong.AnchorDAG.N24048
import Mahjong.AnchorDAG.N24049
import Mahjong.AnchorDAG.N24050
import Mahjong.AnchorDAG.N24051
import Mahjong.AnchorDAG.N24052
import Mahjong.AnchorDAG.N24053
import Mahjong.AnchorDAG.N24054
import Mahjong.AnchorDAG.N24055
import Mahjong.AnchorDAG.N24056
import Mahjong.AnchorDAG.N24070
import Mahjong.AnchorDAG.N24084

set_option maxRecDepth 8192
set_option maxHeartbeats 10000000

namespace Mahjong.AnchorDAG.N24086

open ResponseCertificate

def state (t : Tile) : Nat :=
  match t.val with
  | 0 | 3 | 6 | 10 | 12 | 15 | 16 | 17 | 19 | 21 | 24 | 25 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 0
  | 1 | 2 | 8 | 9 | 11 | 13 | 14 | 18 | 20 | 22 | 23 => 1
  | 4 | 5 | 7 => 3
  | _ => 0

def reply (t : Tile) : Tile :=
  match t.val with
  | 0 | 3 => 6
  | 1 | 2 => 10
  | 4 => 5
  | 5 | 7 | 16 | 17 | 25 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 4
  | 6 | 8 | 9 | 10 | 11 | 12 | 13 | 14 | 15 | 18 | 19 | 20 | 21 | 22 | 23 | 24 => 0
  | _ => 0

def winning (t : Tile) : Bool :=
  match t.val with
  | 0 | 1 | 2 | 3 | 6 | 8 | 9 | 10 | 11 | 12 | 13 | 14 | 15 | 18 | 19 | 20 | 21 | 22 | 23 | 24 => true
  | 4 | 5 | 7 | 16 | 17 | 25 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => false
  | _ => false

def witness (t : Tile) : ExplicitWin.Witness :=
  match t.val with
  | 0 | 6 => .standard (.triplet 4) (.triplet 5) (.sequence 0 0) (.sequence 0 6) 7
  | 1 => .standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 1 0) 1
  | 2 => .standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 1 0) 2
  | 3 => .standard (.triplet 4) (.triplet 5) (.sequence 0 1) (.sequence 0 6) 7
  | 8 => .standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 8
  | 9 => .standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 9
  | 10 => .standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 1 0) 4
  | 11 => .standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 11
  | 12 => .standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 1 2) 4
  | 13 => .standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 13
  | 14 => .standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 14
  | 15 => .standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 1 4) 4
  | 18 => .standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 18
  | 19 => .standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 2 0) 4
  | 20 => .standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 20
  | 21 => .standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 2 2) 4
  | 22 => .standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 22
  | 23 => .standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 23
  | 24 => .standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 2 4) 4
  | _ => .orphans 0

def continuation (t : Tile) : State :=
  match t.val with
  | 4 | 5 => AnchorDAG.N24084.state
  | 7 => AnchorDAG.N24070.state
  | 16 => AnchorDAG.N24056.state
  | 17 => AnchorDAG.N24055.state
  | 25 => AnchorDAG.N24054.state
  | 26 => AnchorDAG.N24053.state
  | 27 => AnchorDAG.N24052.state
  | 28 => AnchorDAG.N24051.state
  | 29 => AnchorDAG.N24050.state
  | 30 => AnchorDAG.N24049.state
  | 31 => AnchorDAG.N24048.state
  | 32 => AnchorDAG.N24047.state
  | 33 => AnchorDAG.N24046.state
  | _ => AnchorDAG.N00000.state

def afterReply (t : Tile) : State := addTile (addTile state t) (reply t)

theorem contained : Contains state ActualCandidateFacts.candidate :=
  (RuleChecker.containsB_iff _ _).1 (by decide +kernel)

theorem valid : Valid state := contains_valid contained ActualCandidateFacts.valid

theorem reply_bound : ∀ t : Tile, state t < 4 → (addTile state t) (reply t) < 4 := by
  decide +kernel

theorem win_checked : ∀ t : Tile, state t < 4 → winning t = true →
    ExplicitWin.check (afterReply t) (witness t) = true := by decide +kernel

theorem back_checked : ∀ t : Tile, state t < 4 → winning t = false →
    MoveEnumeration.stateEqB (afterReply t) (continuation t) = true := by decide +kernel

theorem continuation_proved (t : Tile) : ProvedP (continuation t) := by
  have ht := mem_allTiles t
  simp only [allTiles, List.mem_cons, List.not_mem_nil, or_false] at ht
  rcases ht with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N24084.proved
  · exact AnchorDAG.N24084.proved
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N24070.proved
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N24056.proved
  · exact AnchorDAG.N24055.proved
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N24054.proved
  · exact AnchorDAG.N24053.proved
  · exact AnchorDAG.N24052.proved
  · exact AnchorDAG.N24051.proved
  · exact AnchorDAG.N24050.proved
  · exact AnchorDAG.N24049.proved
  · exact AnchorDAG.N24048.proved
  · exact AnchorDAG.N24047.proved
  · exact AnchorDAG.N24046.proved

theorem responses : Responses state := by
  intro t firstLegal
  have legal : LegalAdd (addTile state t) (reply t) :=
    ⟨valid_add firstLegal.1 firstLegal.2, reply_bound t firstLegal.2⟩
  cases h : winning t with
  | false =>
      apply Reply.back (reply t) legal
      have same := (MoveEnumeration.stateEqB_iff _ _).1 (back_checked t firstLegal.2 h)
      change ProvedP (afterReply t)
      rw [same]
      exact continuation_proved t
  | true =>
      exact Reply.win (reply t) legal
        (ExplicitWin.sound _ _ (valid_add legal.1 legal.2) (win_checked t firstLegal.2 h))

theorem proved : ProvedP state :=
  node_of_safe_extension contained ActualCandidateFacts.valid ActualCandidateSafe.safe responses

theorem tiles : total state = 20 := by decide

theorem original_second_player_wins : SafeGame.SecondPlayerWins Step Win state :=
  proved.secondPlayerWins

end Mahjong.AnchorDAG.N24086

#print axioms Mahjong.AnchorDAG.N24086.original_second_player_wins
