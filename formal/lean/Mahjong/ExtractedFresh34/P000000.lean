import Mahjong.FullWinWitness
import Mahjong.ResponseCertificate
import Mahjong.GeneratedLeaf.Fresh34V1

set_option maxRecDepth 8192
set_option maxHeartbeats 10000000
namespace Mahjong.ExtractedFresh34.P000000
open ResponseCertificate
def state (t : Tile) : Nat :=
  match t.val with
  | 0 | 3 | 6 | 10 | 12 | 15 | 19 | 21 | 24 => 0
  | 1 | 2 | 4 | 5 | 7 | 8 | 9 | 11 | 13 | 14 | 16 | 17 | 18 | 20 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 22 | 23 | 25 => 4
  | _ => 0

def reply (t : Tile) : Tile :=
  match t.val with
  | 0 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 | 13 | 14 | 15 | 16 | 17 | 18 | 19 | 20 | 21 | 24 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 0
  | 1 | 2 => 3
  | _ => 0

def witness (t : Tile) : FullWinWitness.Witness :=
  match t.val with
  | 0 => FullWinWitness.orphans 0
  | 1 => FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 1
  | 2 => FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 3) 2
  | 3 => FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 0) (.sequence 0 3) 22
  | 4 => FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 0) 4
  | 5 => FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 0) 5
  | 6 => FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 0) (.sequence 0 4) 22
  | 7 => FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 0) 7
  | 8 => FullWinWitness.orphans 8
  | 9 => FullWinWitness.orphans 9
  | 10 => FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 0) (.sequence 1 0) 22
  | 11 => FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 0) 11
  | 12 => FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 0) (.sequence 1 2) 22
  | 13 => FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 0) 13
  | 14 => FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 0) 14
  | 15 => FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 0) (.sequence 1 4) 22
  | 16 => FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 0) 16
  | 17 => FullWinWitness.orphans 17
  | 18 => FullWinWitness.orphans 18
  | 19 => FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 0) (.sequence 2 0) 22
  | 20 => FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 0) 20
  | 21 => FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 0) (.sequence 2 2) 22
  | 24 => FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 0) (.sequence 2 4) 22
  | 26 => FullWinWitness.orphans 26
  | 27 => FullWinWitness.orphans 27
  | 28 => FullWinWitness.orphans 28
  | 29 => FullWinWitness.orphans 29
  | 30 => FullWinWitness.orphans 30
  | 31 => FullWinWitness.orphans 31
  | 32 => FullWinWitness.orphans 32
  | 33 => FullWinWitness.orphans 33
  | _ => FullWinWitness.orphans 0

theorem actual_state : state = Mahjong.GeneratedLeaf.Fresh34V1.state :=
  (MoveEnumeration.stateEqB_iff _ _).1 (by decide +kernel)
theorem valid : Valid state := by rw [actual_state]; exact Mahjong.GeneratedLeaf.Fresh34V1.valid
theorem safe : IsSafe state := by rw [actual_state]; exact Mahjong.GeneratedLeaf.Fresh34V1.safe
def afterReply (t : Tile) : State := addTile (addTile state t) (reply t)
theorem reply_bound : ∀ t : Tile, state t < 4 → (addTile state t) (reply t) < 4 := by decide +kernel
theorem win_checked : ∀ t : Tile, state t < 4 → FullWinWitness.check (afterReply t) (witness t) = true := by decide +kernel
theorem responses : Responses state := by
  intro t hl
  have legal : LegalAdd (addTile state t) (reply t) := ⟨valid_add hl.1 hl.2, reply_bound t hl.2⟩
  exact Reply.win (reply t) legal (FullWinWitness.sound _ _ (valid_add legal.1 legal.2) (win_checked t hl.2))
theorem proved : ProvedP state := node valid safe responses
end Mahjong.ExtractedFresh34.P000000

#print axioms Mahjong.ExtractedFresh34.P000000.proved
