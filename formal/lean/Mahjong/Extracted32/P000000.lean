import Mahjong.ExplicitWin
import Mahjong.AnchorDAG.N00000

set_option maxRecDepth 8192
set_option maxHeartbeats 10000000

namespace Mahjong.Extracted32.P000000
open ResponseCertificate

def state (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 6 | 10 | 12 | 15 | 19 | 21 | 24 => 0
  | 4 | 5 | 7 => 4
  | 8 | 9 | 11 | 13 | 14 | 16 | 17 | 18 | 20 | 22 | 23 | 25 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | _ => 0

def reply (t : Tile) : Tile :=
  match t.val with
  | 0 | 8 | 9 | 17 | 18 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 0
  | 1 => 2
  | 2 => 1
  | 3 => 6
  | 6 | 10 | 11 | 12 | 13 | 14 | 15 | 16 | 19 | 20 | 21 | 22 | 23 | 24 | 25 => 3
  | _ => 0

def winning (t : Tile) : Bool :=
  match t.val with
  | 0 | 3 | 6 | 8 | 9 | 10 | 11 | 12 | 13 | 14 | 15 | 16 | 17 | 18 | 19 | 20 | 21 | 22 | 23 | 24 | 25 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => true
  | _ => false

def witness (t : Tile) : ExplicitWin.Witness :=
  match t.val with
  | 0 => .orphans 0
  | 3 | 6 => .standard (.triplet 5) (.triplet 7) (.sequence 0 3) (.sequence 0 6) 4
  | 8 => .orphans 8
  | 9 => .orphans 9
  | 10 => .standard (.triplet 5) (.triplet 7) (.sequence 0 3) (.sequence 1 0) 4
  | 11 => .standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 3) 11
  | 12 => .standard (.triplet 5) (.triplet 7) (.sequence 0 3) (.sequence 1 2) 4
  | 13 => .standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 3) 13
  | 14 => .standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 3) 14
  | 15 => .standard (.triplet 5) (.triplet 7) (.sequence 0 3) (.sequence 1 4) 4
  | 16 => .standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 3) 16
  | 17 => .orphans 17
  | 18 => .orphans 18
  | 19 => .standard (.triplet 5) (.triplet 7) (.sequence 0 3) (.sequence 2 0) 4
  | 20 => .standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 3) 20
  | 21 => .standard (.triplet 5) (.triplet 7) (.sequence 0 3) (.sequence 2 2) 4
  | 22 => .standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 3) 22
  | 23 => .standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 3) 23
  | 24 => .standard (.triplet 5) (.triplet 7) (.sequence 0 3) (.sequence 2 4) 4
  | 25 => .standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 3) 25
  | 26 => .orphans 26
  | 27 => .orphans 27
  | 28 => .orphans 28
  | 29 => .orphans 29
  | 30 => .orphans 30
  | 31 => .orphans 31
  | 32 => .orphans 32
  | 33 => .orphans 33
  | _ => .orphans 0

def continuation (t : Tile) : State :=
  match t.val with
  | 1 | 2 => Generators.applyPath [] AnchorDAG.N00000.state
  | _ => (Generators.applyPath [] AnchorDAG.N00000.state)

def afterReply (t : Tile) : State := addTile (addTile state t) (reply t)
theorem anchor_proved : ProvedP (Generators.applyPath [] AnchorDAG.N00000.state) := (AnchorDAG.N00000.proved).alongPath []
theorem contained : Contains state (Generators.applyPath [] AnchorDAG.N00000.state) :=
  (RuleChecker.containsB_iff _ _).1 (by decide +kernel)
theorem valid : Valid state := contains_valid contained anchor_proved.valid
theorem reply_bound : ∀ t : Tile, state t < 4 → (addTile state t) (reply t) < 4 := by decide +kernel
theorem win_checked : ∀ t : Tile, state t < 4 → winning t = true →
    ExplicitWin.check (afterReply t) (witness t) = true := by decide +kernel
theorem back_checked : ∀ t : Tile, state t < 4 → winning t = false →
    MoveEnumeration.stateEqB (afterReply t) (continuation t) = true := by decide +kernel
theorem continuation_proved (t : Tile) : ProvedP (continuation t) := by
  have ht := mem_allTiles t
  simp only [allTiles, List.mem_cons, List.not_mem_nil, or_false] at ht
  rcases ht with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
  · exact (AnchorDAG.N00000.proved).alongPath []
  · exact (AnchorDAG.N00000.proved).alongPath []
  · exact (AnchorDAG.N00000.proved).alongPath []
  · exact (AnchorDAG.N00000.proved).alongPath []
  · exact (AnchorDAG.N00000.proved).alongPath []
  · exact (AnchorDAG.N00000.proved).alongPath []
  · exact (AnchorDAG.N00000.proved).alongPath []
  · exact (AnchorDAG.N00000.proved).alongPath []
  · exact (AnchorDAG.N00000.proved).alongPath []
  · exact (AnchorDAG.N00000.proved).alongPath []
  · exact (AnchorDAG.N00000.proved).alongPath []
  · exact (AnchorDAG.N00000.proved).alongPath []
  · exact (AnchorDAG.N00000.proved).alongPath []
  · exact (AnchorDAG.N00000.proved).alongPath []
  · exact (AnchorDAG.N00000.proved).alongPath []
  · exact (AnchorDAG.N00000.proved).alongPath []
  · exact (AnchorDAG.N00000.proved).alongPath []
  · exact (AnchorDAG.N00000.proved).alongPath []
  · exact (AnchorDAG.N00000.proved).alongPath []
  · exact (AnchorDAG.N00000.proved).alongPath []
  · exact (AnchorDAG.N00000.proved).alongPath []
  · exact (AnchorDAG.N00000.proved).alongPath []
  · exact (AnchorDAG.N00000.proved).alongPath []
  · exact (AnchorDAG.N00000.proved).alongPath []
  · exact (AnchorDAG.N00000.proved).alongPath []
  · exact (AnchorDAG.N00000.proved).alongPath []
  · exact (AnchorDAG.N00000.proved).alongPath []
  · exact (AnchorDAG.N00000.proved).alongPath []
  · exact (AnchorDAG.N00000.proved).alongPath []
  · exact (AnchorDAG.N00000.proved).alongPath []
  · exact (AnchorDAG.N00000.proved).alongPath []
  · exact (AnchorDAG.N00000.proved).alongPath []
  · exact (AnchorDAG.N00000.proved).alongPath []
  · exact (AnchorDAG.N00000.proved).alongPath []
theorem responses : Responses state := by
  intro t hl
  have legal : LegalAdd (addTile state t) (reply t) := ⟨valid_add hl.1 hl.2, reply_bound t hl.2⟩
  cases h : winning t with
  | false =>
      apply Reply.back (reply t) legal
      have same := (MoveEnumeration.stateEqB_iff _ _).1 (back_checked t hl.2 h)
      change ProvedP (afterReply t)
      rw [same]
      exact continuation_proved t
  | true =>
      exact Reply.win (reply t) legal
        (ExplicitWin.sound _ _ (valid_add legal.1 legal.2) (win_checked t hl.2 h))
theorem proved : ProvedP state := node_of_proved_extension contained anchor_proved responses
end Mahjong.Extracted32.P000000

#print axioms Mahjong.Extracted32.P000000.proved
