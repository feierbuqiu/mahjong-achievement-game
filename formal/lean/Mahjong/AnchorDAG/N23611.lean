import Mahjong.ExplicitWin
import Mahjong.AnchorDAG.N00000
import Mahjong.AnchorDAG.N19813
import Mahjong.AnchorDAG.N19814
import Mahjong.AnchorDAG.N19816
import Mahjong.AnchorDAG.N19819
import Mahjong.AnchorDAG.N19823
import Mahjong.AnchorDAG.N19828
import Mahjong.AnchorDAG.N19834
import Mahjong.AnchorDAG.N19841
import Mahjong.AnchorDAG.N19850

set_option maxRecDepth 8192
set_option maxHeartbeats 10000000

namespace Mahjong.AnchorDAG.N23611

open ResponseCertificate

def state (t : Tile) : Nat :=
  match t.val with
  | 0 | 3 | 6 | 10 | 12 | 15 | 17 | 19 | 21 | 24 | 25 | 26 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 1 | 2 | 8 | 9 | 11 | 13 | 14 | 16 | 18 | 20 | 22 | 23 | 33 => 1
  | 4 | 5 => 4
  | 7 => 3
  | _ => 0

def reply (t : Tile) : Tile :=
  match t.val with
  | 0 | 1 | 2 => 3
  | 3 | 6 | 8 | 9 | 10 | 11 | 12 | 13 | 14 | 15 | 16 | 18 | 19 | 20 | 21 | 22 | 23 | 24 | 33 => 0
  | 7 => 17
  | 17 | 25 | 26 | 27 | 28 | 29 | 30 | 31 | 32 => 7
  | _ => 0

def winning (t : Tile) : Bool :=
  match t.val with
  | 0 | 1 | 2 | 3 | 6 | 8 | 9 | 10 | 11 | 12 | 13 | 14 | 15 | 16 | 18 | 19 | 20 | 21 | 22 | 23 | 24 | 33 => true
  | 7 | 17 | 25 | 26 | 27 | 28 | 29 | 30 | 31 | 32 => false
  | _ => false

def witness (t : Tile) : ExplicitWin.Witness :=
  match t.val with
  | 0 | 3 => .standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 0 3) 4
  | 1 => .standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 2) 1
  | 2 => .standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 3) 2
  | 6 => .standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 0 4) 4
  | 8 => .standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 8
  | 9 => .standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 9
  | 10 => .standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 1 0) 4
  | 11 => .standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 11
  | 12 => .standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 1 2) 4
  | 13 => .standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 13
  | 14 => .standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 14
  | 15 => .standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 1 4) 4
  | 16 => .standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 16
  | 18 => .standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 18
  | 19 => .standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 2 0) 4
  | 20 => .standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 20
  | 21 => .standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 2 2) 4
  | 22 => .standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 22
  | 23 => .standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 23
  | 24 => .standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 2 4) 4
  | 33 => .standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 33
  | _ => .orphans 0

def continuation (t : Tile) : State :=
  match t.val with
  | 7 | 17 => AnchorDAG.N19850.state
  | 25 => AnchorDAG.N19841.state
  | 26 => AnchorDAG.N19834.state
  | 27 => AnchorDAG.N19828.state
  | 28 => AnchorDAG.N19823.state
  | 29 => AnchorDAG.N19819.state
  | 30 => AnchorDAG.N19816.state
  | 31 => AnchorDAG.N19814.state
  | 32 => AnchorDAG.N19813.state
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
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N19850.proved
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N19850.proved
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N19841.proved
  · exact AnchorDAG.N19834.proved
  · exact AnchorDAG.N19828.proved
  · exact AnchorDAG.N19823.proved
  · exact AnchorDAG.N19819.proved
  · exact AnchorDAG.N19816.proved
  · exact AnchorDAG.N19814.proved
  · exact AnchorDAG.N19813.proved
  · exact AnchorDAG.N00000.proved

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

theorem tiles : total state = 24 := by decide

theorem original_second_player_wins : SafeGame.SecondPlayerWins Step Win state :=
  proved.secondPlayerWins

end Mahjong.AnchorDAG.N23611

#print axioms Mahjong.AnchorDAG.N23611.original_second_player_wins
