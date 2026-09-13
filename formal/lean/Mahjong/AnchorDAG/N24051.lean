import Mahjong.ExplicitWin
import Mahjong.AnchorDAG.N00000
import Mahjong.AnchorDAG.N23574
import Mahjong.AnchorDAG.N23575
import Mahjong.AnchorDAG.N23576
import Mahjong.AnchorDAG.N23577
import Mahjong.AnchorDAG.N23578
import Mahjong.AnchorDAG.N23584
import Mahjong.AnchorDAG.N23590
import Mahjong.AnchorDAG.N23597
import Mahjong.AnchorDAG.N23606
import Mahjong.AnchorDAG.N23616
import Mahjong.AnchorDAG.N23702

set_option maxRecDepth 8192
set_option maxHeartbeats 10000000

namespace Mahjong.AnchorDAG.N24051

open ResponseCertificate

def state (t : Tile) : Nat :=
  match t.val with
  | 0 | 3 | 6 | 10 | 12 | 15 | 16 | 17 | 19 | 21 | 24 | 25 | 26 | 27 | 29 | 30 | 31 | 32 | 33 => 0
  | 1 | 2 | 8 | 9 | 11 | 13 | 14 | 18 | 20 | 22 | 23 | 28 => 1
  | 4 => 4
  | 5 | 7 => 3
  | _ => 0

def reply (t : Tile) : Tile :=
  match t.val with
  | 0 | 1 => 3
  | 2 => 10
  | 3 | 6 | 8 | 9 | 10 | 11 | 12 | 13 | 14 | 15 | 18 | 19 | 20 | 21 | 22 | 23 | 24 | 28 => 0
  | 5 => 7
  | 7 | 16 | 17 | 25 | 26 | 27 | 29 | 30 | 31 | 32 | 33 => 5
  | _ => 0

def winning (t : Tile) : Bool :=
  match t.val with
  | 0 | 1 | 2 | 3 | 6 | 8 | 9 | 10 | 11 | 12 | 13 | 14 | 15 | 18 | 19 | 20 | 21 | 22 | 23 | 24 | 28 => true
  | 5 | 7 | 16 | 17 | 25 | 26 | 27 | 29 | 30 | 31 | 32 | 33 => false
  | _ => false

def witness (t : Tile) : ExplicitWin.Witness :=
  match t.val with
  | 0 | 3 => .standard (.triplet 4) (.triplet 7) (.sequence 0 0) (.sequence 0 3) 5
  | 1 => .standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 2) 1
  | 2 => .standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 1 0) 2
  | 6 => .standard (.triplet 4) (.triplet 7) (.sequence 0 0) (.sequence 0 4) 5
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
  | 28 => .standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 28
  | _ => .orphans 0

def continuation (t : Tile) : State :=
  match t.val with
  | 5 | 7 => AnchorDAG.N23702.state
  | 16 => AnchorDAG.N23616.state
  | 17 => AnchorDAG.N23606.state
  | 25 => AnchorDAG.N23597.state
  | 26 => AnchorDAG.N23590.state
  | 27 => AnchorDAG.N23584.state
  | 29 => AnchorDAG.N23578.state
  | 30 => AnchorDAG.N23577.state
  | 31 => AnchorDAG.N23576.state
  | 32 => AnchorDAG.N23575.state
  | 33 => AnchorDAG.N23574.state
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
  · exact AnchorDAG.N23702.proved
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N23702.proved
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N23616.proved
  · exact AnchorDAG.N23606.proved
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N23597.proved
  · exact AnchorDAG.N23590.proved
  · exact AnchorDAG.N23584.proved
  · exact AnchorDAG.N00000.proved
  · exact AnchorDAG.N23578.proved
  · exact AnchorDAG.N23577.proved
  · exact AnchorDAG.N23576.proved
  · exact AnchorDAG.N23575.proved
  · exact AnchorDAG.N23574.proved

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

theorem tiles : total state = 22 := by decide

theorem original_second_player_wins : SafeGame.SecondPlayerWins Step Win state :=
  proved.secondPlayerWins

end Mahjong.AnchorDAG.N24051

#print axioms Mahjong.AnchorDAG.N24051.original_second_player_wins
