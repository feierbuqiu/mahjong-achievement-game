import MahjongNext.ResponseTable
import Mahjong.ActualCandidateSafe
import Mahjong.ActualTerminalReplies

set_option maxRecDepth 16384
set_option maxHeartbeats 100000000

namespace Mahjong.ResponseTableFull20
open ResponseTable ResponseCertificate Generators

def boundsPath (i : Nat) : List Generator :=
  match i with
  | 0 => []
  | 1 => []
  | 2 => [.swapSuits 0 1, .reverseSuit 0]
  | 3 => []
  | 4 => [.swapSuits 0 1, .reverseSuit 0]
  | 5 => [.swapSuits 0 2, .reverseSuit 0, .reverseSuit 1]
  | 6 => []
  | 7 => []
  | 8 => [.swapSuits 0 1, .reverseSuit 0]
  | 9 => [.swapSuits 0 2, .reverseSuit 0, .reverseSuit 1]
  | 10 => []
  | 11 => []
  | 12 => [.swapSuits 0 1, .reverseSuit 0]
  | 13 => [.swapSuits 0 1, .reverseSuit 0]
  | 14 => [.swapSuits 0 2, .reverseSuit 0, .reverseSuit 1]
  | 15 => []
  | 16 => [.swapSuits 0 1, .reverseSuit 0]
  | 17 => [.swapSuits 0 1, .reverseSuit 0]
  | 18 => [.swapSuits 0 2, .reverseSuit 0, .reverseSuit 1]
  | 19 => [.swapSuits 0 2, .reverseSuit 0, .reverseSuit 1]
  | 20 => [.swapSuits 0 1, .reverseSuit 0]
  | 21 => [.swapSuits 0 2, .reverseSuit 0, .reverseSuit 1]
  | 22 => [.swapSuits 0 2, .reverseSuit 0, .reverseSuit 1]
  | 23 => [.swapSuits 0 2, .reverseSuit 0, .reverseSuit 1]
  | _ => []

def bounds (i : Nat) : State :=
  applyPath (boundsPath i) ActualCandidateFacts.candidate

theorem anchorFact : ProvedP ActualCandidateFacts.candidate :=
  ⟨ActualCandidateFacts.valid, ActualCandidateSafe.safe, ActualTerminalReplies.candidate_normalP⟩
theorem validBounds (i : Nat) : Valid (bounds i) := (anchorFact.alongPath (boundsPath i)).valid
theorem safeBounds (i : Nat) : IsSafe (bounds i) := (anchorFact.alongPath (boundsPath i)).safe

def anchorWitness (t : Tile) : FullWinWitness.Witness :=
  if ActualTerminalReplies.isOrphan t then FullWinWitness.orphans (ActualTerminalReplies.pair t)
  else FullWinWitness.standard (ActualTerminalReplies.melds t 0) (ActualTerminalReplies.melds t 1)
    (ActualTerminalReplies.melds t 2) (ActualTerminalReplies.melds t 3) (ActualTerminalReplies.pair t)
def row0 : Row := ⟨0, ActualCandidateFacts.candidate, 0,
  fun t => .win (ActualTerminalReplies.reply t) (anchorWitness t)⟩

def state1 (t : Tile) : Nat :=
  match t.val with
  | 0 | 3 | 6 | 10 | 12 | 15 | 19 | 21 | 24 | 27 | 28 => 0
  | 1 | 2 | 8 | 9 | 11 | 13 | 14 | 16 | 17 | 18 | 20 | 22 | 23 | 25 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 4 | 5 | 7 => 4
  | _ => 0

def action1 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 3 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 0 3) 4)
  | 1 => .win 3 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 2) 1)
  | 2 => .win 3 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 3) 2)
  | 3 => .win 0 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 0 3) 4)
  | 6 => .win 0 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 0 4) 4)
  | 8 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 8)
  | 9 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 9)
  | 10 => .win 0 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 1 0) 4)
  | 11 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 11)
  | 12 => .win 0 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 1 2) 4)
  | 13 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 13)
  | 14 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 14)
  | 15 => .win 0 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 1 4) 4)
  | 16 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 16)
  | 17 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 17)
  | 18 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 18)
  | 19 => .win 0 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 2 0) 4)
  | 20 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 20)
  | 21 => .win 0 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 2 2) 4)
  | 22 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 22)
  | 23 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 23)
  | 24 => .win 0 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 2 4) 4)
  | 25 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 25)
  | 26 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 26)
  | 27 => .back 28 0 [.swapHonors 0 1]
  | 28 => .back 27 0 []
  | 29 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 29)
  | 30 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 30)
  | 31 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 31)
  | 32 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 32)
  | 33 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row1 : Row := ⟨1, state1, 1, action1⟩

def state2 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 5 | 7 | 9 | 12 | 15 | 19 | 21 | 24 => 0
  | 3 | 4 | 6 | 8 | 10 | 11 | 17 | 18 | 20 | 22 | 23 | 25 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 13 | 14 | 16 => 4
  | _ => 0

def action2 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 1 0 [.swapSuits 0 1, .reverseSuit 0]
  | 1 => .back 0 0 [.swapSuits 0 1, .reverseSuit 0]
  | 2 => .win 6 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 6)
  | 3 => .win 5 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 4) 3)
  | 4 => .win 7 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 6) 4)
  | 5 => .win 3 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 4) 3)
  | 6 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 6)
  | 7 => .win 2 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 2) (.sequence 0 6) 13)
  | 8 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 8)
  | 9 => .win 2 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 2) (.sequence 1 0) 13)
  | 10 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 10)
  | 11 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 11)
  | 12 => .win 2 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 2) (.sequence 1 1) 13)
  | 15 => .win 2 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 2) (.sequence 1 4) 13)
  | 17 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 17)
  | 18 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 18)
  | 19 => .win 2 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 2) (.sequence 2 0) 13)
  | 20 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 20)
  | 21 => .win 2 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 2) (.sequence 2 2) 13)
  | 22 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 22)
  | 23 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 23)
  | 24 => .win 2 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 2) (.sequence 2 4) 13)
  | 25 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 25)
  | 26 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 26)
  | 27 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 27)
  | 28 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 28)
  | 29 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 29)
  | 30 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 30)
  | 31 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 31)
  | 32 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 32)
  | 33 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row2 : Row := ⟨2, state2, 2, action2⟩

def state3 (t : Tile) : Nat :=
  match t.val with
  | 0 | 3 | 6 | 10 | 12 | 15 | 19 | 21 | 24 | 27 | 28 | 29 | 30 => 0
  | 1 | 2 | 8 | 9 | 11 | 13 | 14 | 16 | 17 | 18 | 20 | 22 | 23 | 25 | 26 | 31 | 32 | 33 => 1
  | 4 | 5 | 7 => 4
  | _ => 0

def action3 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 3 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 0 3) 4)
  | 1 => .win 3 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 2) 1)
  | 2 => .win 3 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 3) 2)
  | 3 => .win 0 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 0 3) 4)
  | 6 => .win 0 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 0 4) 4)
  | 8 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 8)
  | 9 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 9)
  | 10 => .win 0 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 1 0) 4)
  | 11 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 11)
  | 12 => .win 0 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 1 2) 4)
  | 13 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 13)
  | 14 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 14)
  | 15 => .win 0 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 1 4) 4)
  | 16 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 16)
  | 17 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 17)
  | 18 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 18)
  | 19 => .win 0 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 2 0) 4)
  | 20 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 20)
  | 21 => .win 0 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 2 2) 4)
  | 22 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 22)
  | 23 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 23)
  | 24 => .win 0 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 2 4) 4)
  | 25 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 25)
  | 26 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 26)
  | 27 => .back 28 1 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 1 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 1 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 1 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 31)
  | 32 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 32)
  | 33 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row3 : Row := ⟨3, state3, 3, action3⟩

def state4 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 5 | 7 | 9 | 12 | 15 | 19 | 21 | 24 | 27 | 28 => 0
  | 3 | 4 | 6 | 8 | 10 | 11 | 17 | 18 | 20 | 22 | 23 | 25 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 13 | 14 | 16 => 4
  | _ => 0

def action4 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 1 1 [.swapSuits 0 1, .reverseSuit 0]
  | 1 => .back 0 1 [.swapSuits 0 1, .reverseSuit 0]
  | 2 => .win 6 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 6)
  | 3 => .win 5 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 4) 3)
  | 4 => .win 7 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 6) 4)
  | 5 => .win 3 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 4) 3)
  | 6 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 6)
  | 7 => .win 2 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 2) (.sequence 0 6) 13)
  | 8 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 8)
  | 9 => .win 2 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 2) (.sequence 1 0) 13)
  | 10 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 10)
  | 11 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 11)
  | 12 => .win 2 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 2) (.sequence 1 1) 13)
  | 15 => .win 2 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 2) (.sequence 1 4) 13)
  | 17 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 17)
  | 18 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 18)
  | 19 => .win 2 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 2) (.sequence 2 0) 13)
  | 20 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 20)
  | 21 => .win 2 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 2) (.sequence 2 2) 13)
  | 22 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 22)
  | 23 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 23)
  | 24 => .win 2 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 2) (.sequence 2 4) 13)
  | 25 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 25)
  | 26 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 26)
  | 27 => .back 28 2 [.swapHonors 0 1]
  | 28 => .back 27 2 []
  | 29 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 29)
  | 30 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 30)
  | 31 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 31)
  | 32 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 32)
  | 33 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row4 : Row := ⟨4, state4, 4, action4⟩

def state5 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 5 | 7 | 9 | 10 | 11 | 14 | 16 | 18 | 21 | 24 => 0
  | 3 | 4 | 6 | 8 | 12 | 13 | 15 | 17 | 19 | 20 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 22 | 23 | 25 => 4
  | _ => 0

def action5 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 1 2 [.swapSuits 0 2, .swapSuits 1 2, .reverseSuit 0]
  | 1 => .back 0 2 [.swapSuits 0 2, .swapSuits 1 2, .reverseSuit 0]
  | 2 => .win 6 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 6)
  | 3 => .win 5 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 4) 3)
  | 4 => .win 7 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 6) 4)
  | 5 => .win 3 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 4) 3)
  | 6 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 6)
  | 7 => .win 2 (FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 2) (.sequence 0 6) 22)
  | 8 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 8)
  | 9 => .back 10 2 [.swapSuits 1 2, .reverseSuit 1]
  | 10 => .back 9 2 [.swapSuits 1 2, .reverseSuit 1]
  | 11 => .win 2 (FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 2) (.sequence 1 2) 22)
  | 12 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 12)
  | 13 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 13)
  | 14 => .win 2 (FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 2) (.sequence 1 3) 22)
  | 15 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 15)
  | 16 => .win 2 (FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 2) (.sequence 1 6) 22)
  | 17 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 17)
  | 18 => .win 2 (FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 2) (.sequence 2 0) 22)
  | 19 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 19)
  | 20 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 20)
  | 21 => .win 2 (FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 2) (.sequence 2 1) 22)
  | 24 => .win 2 (FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 2) (.sequence 2 4) 22)
  | 26 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 26)
  | 27 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 27)
  | 28 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 28)
  | 29 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 29)
  | 30 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 30)
  | 31 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 31)
  | 32 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 32)
  | 33 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row5 : Row := ⟨5, state5, 5, action5⟩

def state6 (t : Tile) : Nat :=
  match t.val with
  | 0 | 3 | 6 | 10 | 12 | 15 | 19 | 21 | 24 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 1 | 2 | 8 | 9 | 11 | 13 | 14 | 16 | 17 | 18 | 20 | 22 | 23 | 25 | 26 | 33 => 1
  | 4 | 5 | 7 => 4
  | _ => 0

def action6 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 3 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 0 3) 4)
  | 1 => .win 3 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 2) 1)
  | 2 => .win 3 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 3) 2)
  | 3 => .win 0 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 0 3) 4)
  | 6 => .win 0 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 0 4) 4)
  | 8 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 8)
  | 9 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 9)
  | 10 => .win 0 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 1 0) 4)
  | 11 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 11)
  | 12 => .win 0 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 1 2) 4)
  | 13 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 13)
  | 14 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 14)
  | 15 => .win 0 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 1 4) 4)
  | 16 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 16)
  | 17 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 17)
  | 18 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 18)
  | 19 => .win 0 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 2 0) 4)
  | 20 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 20)
  | 21 => .win 0 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 2 2) 4)
  | 22 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 22)
  | 23 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 23)
  | 24 => .win 0 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 2 4) 4)
  | 25 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 25)
  | 26 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 26)
  | 27 => .back 28 3 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 3 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 3 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 3 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 3 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 3 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row6 : Row := ⟨6, state6, 6, action6⟩

def state7 (t : Tile) : Nat :=
  match t.val with
  | 0 | 3 | 6 | 10 | 12 | 15 | 19 | 21 | 24 | 27 | 28 | 29 | 30 | 31 => 0
  | 1 | 2 | 8 | 9 | 11 | 13 | 14 | 16 | 17 | 18 | 20 | 22 | 23 | 25 | 26 | 32 | 33 => 1
  | 4 | 7 => 4
  | 5 => 3
  | _ => 0

def action7 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 3 (FullWinWitness.standard (.triplet 4) (.triplet 7) (.sequence 0 0) (.sequence 0 3) 5)
  | 1 => .win 3 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 2) 1)
  | 2 => .win 6 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 6) 2)
  | 3 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 7) (.sequence 0 0) (.sequence 0 3) 5)
  | 5 => .back 27 3 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 6 => .win 0 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 0 6) 4)
  | 8 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 8)
  | 9 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 9)
  | 10 => .win 0 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 1 0) 4)
  | 11 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 11)
  | 12 => .win 0 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 1 2) 4)
  | 13 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 13)
  | 14 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 14)
  | 15 => .win 0 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 1 4) 4)
  | 16 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 16)
  | 17 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 17)
  | 18 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 18)
  | 19 => .win 0 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 2 0) 4)
  | 20 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 20)
  | 21 => .win 0 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 2 2) 4)
  | 22 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 22)
  | 23 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 23)
  | 24 => .win 0 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 2 4) 4)
  | 25 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 25)
  | 26 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 26)
  | 27 => .back 5 3 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 28 => .back 5 3 [.swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 29 => .back 5 3 [.swapHonors 2 4, .swapHonors 3 4]
  | 30 => .back 5 3 [.swapHonors 3 4]
  | 31 => .back 5 3 []
  | 32 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 32)
  | 33 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row7 : Row := ⟨7, state7, 7, action7⟩

def state8 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 5 | 7 | 9 | 12 | 15 | 19 | 21 | 24 | 27 | 28 | 29 | 30 => 0
  | 3 | 4 | 6 | 8 | 10 | 11 | 17 | 18 | 20 | 22 | 23 | 25 | 26 | 31 | 32 | 33 => 1
  | 13 | 14 | 16 => 4
  | _ => 0

def action8 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 1 3 [.swapSuits 0 1, .reverseSuit 0]
  | 1 => .back 0 3 [.swapSuits 0 1, .reverseSuit 0]
  | 2 => .win 6 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 6)
  | 3 => .win 5 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 4) 3)
  | 4 => .win 7 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 6) 4)
  | 5 => .win 3 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 4) 3)
  | 6 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 6)
  | 7 => .win 2 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 2) (.sequence 0 6) 13)
  | 8 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 8)
  | 9 => .win 2 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 2) (.sequence 1 0) 13)
  | 10 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 10)
  | 11 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 11)
  | 12 => .win 2 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 2) (.sequence 1 1) 13)
  | 15 => .win 2 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 2) (.sequence 1 4) 13)
  | 17 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 17)
  | 18 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 18)
  | 19 => .win 2 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 2) (.sequence 2 0) 13)
  | 20 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 20)
  | 21 => .win 2 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 2) (.sequence 2 2) 13)
  | 22 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 22)
  | 23 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 23)
  | 24 => .win 2 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 2) (.sequence 2 4) 13)
  | 25 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 25)
  | 26 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 26)
  | 27 => .back 28 4 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 4 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 4 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 4 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 31)
  | 32 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 32)
  | 33 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row8 : Row := ⟨8, state8, 8, action8⟩

def state9 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 5 | 7 | 9 | 10 | 11 | 14 | 16 | 18 | 21 | 24 | 27 | 28 => 0
  | 3 | 4 | 6 | 8 | 12 | 13 | 15 | 17 | 19 | 20 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 22 | 23 | 25 => 4
  | _ => 0

def action9 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 1 4 [.swapSuits 0 2, .swapSuits 1 2, .reverseSuit 0]
  | 1 => .back 0 4 [.swapSuits 0 2, .swapSuits 1 2, .reverseSuit 0]
  | 2 => .win 6 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 6)
  | 3 => .win 5 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 4) 3)
  | 4 => .win 7 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 6) 4)
  | 5 => .win 3 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 4) 3)
  | 6 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 6)
  | 7 => .win 2 (FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 2) (.sequence 0 6) 22)
  | 8 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 8)
  | 9 => .back 10 4 [.swapSuits 1 2, .reverseSuit 1]
  | 10 => .back 9 4 [.swapSuits 1 2, .reverseSuit 1]
  | 11 => .win 2 (FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 2) (.sequence 1 2) 22)
  | 12 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 12)
  | 13 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 13)
  | 14 => .win 2 (FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 2) (.sequence 1 3) 22)
  | 15 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 15)
  | 16 => .win 2 (FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 2) (.sequence 1 6) 22)
  | 17 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 17)
  | 18 => .win 2 (FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 2) (.sequence 2 0) 22)
  | 19 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 19)
  | 20 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 20)
  | 21 => .win 2 (FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 2) (.sequence 2 1) 22)
  | 24 => .win 2 (FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 2) (.sequence 2 4) 22)
  | 26 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 26)
  | 27 => .back 28 5 [.swapHonors 0 1]
  | 28 => .back 27 5 []
  | 29 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 29)
  | 30 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 30)
  | 31 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 31)
  | 32 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 32)
  | 33 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row9 : Row := ⟨9, state9, 9, action9⟩

def state10 (t : Tile) : Nat :=
  match t.val with
  | 0 | 3 | 6 | 10 | 12 | 15 | 19 | 21 | 24 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 1 | 2 | 8 | 9 | 11 | 13 | 14 | 16 | 17 | 18 | 20 | 22 | 23 | 25 | 26 | 33 => 1
  | 4 => 4
  | 5 | 7 => 3
  | _ => 0

def action10 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 3 (FullWinWitness.standard (.triplet 4) (.triplet 7) (.sequence 0 0) (.sequence 0 3) 5)
  | 1 => .win 3 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 2) 1)
  | 2 => .win 10 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 1 0) 2)
  | 3 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 7) (.sequence 0 0) (.sequence 0 3) 5)
  | 5 => .back 7 6 []
  | 6 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 7) (.sequence 0 0) (.sequence 0 4) 5)
  | 7 => .back 5 6 []
  | 8 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 8)
  | 9 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 9)
  | 10 => .win 0 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 1 0) 4)
  | 11 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 11)
  | 12 => .win 0 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 1 2) 4)
  | 13 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 13)
  | 14 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 14)
  | 15 => .win 0 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 1 4) 4)
  | 16 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 16)
  | 17 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 17)
  | 18 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 18)
  | 19 => .win 0 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 2 0) 4)
  | 20 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 20)
  | 21 => .win 0 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 2 2) 4)
  | 22 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 22)
  | 23 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 23)
  | 24 => .win 0 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 2 4) 4)
  | 25 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 25)
  | 26 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 26)
  | 27 => .back 7 7 [.swapHonors 0 5, .swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | 28 => .back 7 7 [.swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | 29 => .back 7 7 [.swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | 30 => .back 7 7 [.swapHonors 3 5, .swapHonors 4 5]
  | 31 => .back 7 7 [.swapHonors 4 5]
  | 32 => .back 7 7 []
  | 33 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row10 : Row := ⟨10, state10, 10, action10⟩

def state11 (t : Tile) : Nat :=
  match t.val with
  | 0 | 3 | 6 | 10 | 12 | 15 | 19 | 21 | 24 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 0
  | 1 | 2 | 8 | 9 | 11 | 13 | 14 | 16 | 17 | 18 | 20 | 22 | 23 | 25 | 26 => 1
  | 4 => 3
  | 5 | 7 => 4
  | _ => 0

def action11 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 3 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 0 3) 4)
  | 1 => .win 6 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 5) 1)
  | 2 => .win 6 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 5) 2)
  | 3 => .win 0 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 0 3) 4)
  | 4 => .back 27 6 [.swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 6 => .win 0 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 0 4) 4)
  | 8 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 8)
  | 9 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 9)
  | 10 => .win 0 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 1 0) 4)
  | 11 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 11)
  | 12 => .win 0 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 1 2) 4)
  | 13 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 13)
  | 14 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 14)
  | 15 => .win 0 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 1 4) 4)
  | 16 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 16)
  | 17 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 17)
  | 18 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 18)
  | 19 => .win 0 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 2 0) 4)
  | 20 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 20)
  | 21 => .win 0 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 2 2) 4)
  | 22 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 22)
  | 23 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 23)
  | 24 => .win 0 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 2 4) 4)
  | 25 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 25)
  | 26 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 26)
  | 27 => .back 4 6 [.swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 28 => .back 4 6 [.swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 29 => .back 4 6 [.swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 30 => .back 4 6 [.swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 31 => .back 4 6 [.swapHonors 4 6, .swapHonors 5 6]
  | 32 => .back 4 6 [.swapHonors 5 6]
  | 33 => .back 4 6 []
  | _ => .win 0 (FullWinWitness.orphans 0)

def row11 : Row := ⟨11, state11, 11, action11⟩

def state12 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 5 | 7 | 9 | 12 | 15 | 19 | 21 | 24 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 3 | 4 | 6 | 8 | 10 | 11 | 17 | 18 | 20 | 22 | 23 | 25 | 26 | 33 => 1
  | 13 | 14 | 16 => 4
  | _ => 0

def action12 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 1 6 [.swapSuits 0 1, .reverseSuit 0]
  | 1 => .back 0 6 [.swapSuits 0 1, .reverseSuit 0]
  | 2 => .win 6 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 6)
  | 3 => .win 5 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 4) 3)
  | 4 => .win 7 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 6) 4)
  | 5 => .win 3 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 4) 3)
  | 6 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 6)
  | 7 => .win 2 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 2) (.sequence 0 6) 13)
  | 8 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 8)
  | 9 => .win 2 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 2) (.sequence 1 0) 13)
  | 10 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 10)
  | 11 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 11)
  | 12 => .win 2 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 2) (.sequence 1 1) 13)
  | 15 => .win 2 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 2) (.sequence 1 4) 13)
  | 17 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 17)
  | 18 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 18)
  | 19 => .win 2 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 2) (.sequence 2 0) 13)
  | 20 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 20)
  | 21 => .win 2 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 2) (.sequence 2 2) 13)
  | 22 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 22)
  | 23 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 23)
  | 24 => .win 2 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 2) (.sequence 2 4) 13)
  | 25 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 25)
  | 26 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 26)
  | 27 => .back 28 8 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 8 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 8 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 8 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 8 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 8 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row12 : Row := ⟨12, state12, 12, action12⟩

def state13 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 5 | 7 | 9 | 12 | 15 | 19 | 21 | 24 | 27 | 28 | 29 | 30 | 31 => 0
  | 3 | 4 | 6 | 8 | 10 | 11 | 17 | 18 | 20 | 22 | 23 | 25 | 26 | 32 | 33 => 1
  | 13 | 16 => 4
  | 14 => 3
  | _ => 0

def action13 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 1 7 [.swapSuits 0 1, .reverseSuit 0]
  | 1 => .back 0 7 [.swapSuits 0 1, .reverseSuit 0]
  | 2 => .win 6 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 6)
  | 3 => .win 5 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 4) 3)
  | 4 => .win 7 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 6) 4)
  | 5 => .win 3 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 4) 3)
  | 6 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 6)
  | 7 => .win 2 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 2) (.sequence 0 6) 13)
  | 8 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 8)
  | 9 => .win 2 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 2) (.sequence 1 0) 13)
  | 10 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 10)
  | 11 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 11)
  | 12 => .win 2 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 2) (.sequence 1 1) 13)
  | 14 => .back 27 8 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 15 => .win 2 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 2) (.sequence 1 6) 13)
  | 17 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 17)
  | 18 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 18)
  | 19 => .win 2 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 2) (.sequence 2 0) 13)
  | 20 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 20)
  | 21 => .win 2 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 2) (.sequence 2 2) 13)
  | 22 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 22)
  | 23 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 23)
  | 24 => .win 2 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 2) (.sequence 2 4) 13)
  | 25 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 25)
  | 26 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 26)
  | 27 => .back 14 8 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 28 => .back 14 8 [.swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 29 => .back 14 8 [.swapHonors 2 4, .swapHonors 3 4]
  | 30 => .back 14 8 [.swapHonors 3 4]
  | 31 => .back 14 8 []
  | 32 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 32)
  | 33 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row13 : Row := ⟨13, state13, 13, action13⟩

def state14 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 5 | 7 | 9 | 10 | 11 | 14 | 16 | 18 | 21 | 24 | 27 | 28 | 29 | 30 => 0
  | 3 | 4 | 6 | 8 | 12 | 13 | 15 | 17 | 19 | 20 | 26 | 31 | 32 | 33 => 1
  | 22 | 23 | 25 => 4
  | _ => 0

def action14 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 1 8 [.swapSuits 0 2, .swapSuits 1 2, .reverseSuit 0]
  | 1 => .back 0 8 [.swapSuits 0 2, .swapSuits 1 2, .reverseSuit 0]
  | 2 => .win 6 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 6)
  | 3 => .win 5 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 4) 3)
  | 4 => .win 7 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 6) 4)
  | 5 => .win 3 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 4) 3)
  | 6 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 6)
  | 7 => .win 2 (FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 2) (.sequence 0 6) 22)
  | 8 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 8)
  | 9 => .back 10 8 [.swapSuits 1 2, .reverseSuit 1]
  | 10 => .back 9 8 [.swapSuits 1 2, .reverseSuit 1]
  | 11 => .win 2 (FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 2) (.sequence 1 2) 22)
  | 12 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 12)
  | 13 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 13)
  | 14 => .win 2 (FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 2) (.sequence 1 3) 22)
  | 15 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 15)
  | 16 => .win 2 (FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 2) (.sequence 1 6) 22)
  | 17 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 17)
  | 18 => .win 2 (FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 2) (.sequence 2 0) 22)
  | 19 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 19)
  | 20 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 20)
  | 21 => .win 2 (FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 2) (.sequence 2 1) 22)
  | 24 => .win 2 (FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 2) (.sequence 2 4) 22)
  | 26 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 26)
  | 27 => .back 28 9 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 9 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 9 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 9 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 31)
  | 32 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 32)
  | 33 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row14 : Row := ⟨14, state14, 14, action14⟩

def state15 (t : Tile) : Nat :=
  match t.val with
  | 0 | 3 | 6 | 10 | 12 | 15 | 19 | 21 | 24 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 0
  | 1 | 2 | 8 | 9 | 11 | 13 | 14 | 16 | 17 | 18 | 20 | 22 | 23 | 25 | 26 => 1
  | 4 | 5 | 7 => 3
  | _ => 0

def action15 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 6 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.sequence 0 0) (.sequence 0 6) 7)
  | 1 => .win 10 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 1 0) 1)
  | 2 => .win 10 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 1 0) 2)
  | 3 => .win 6 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.sequence 0 1) (.sequence 0 6) 7)
  | 4 => .back 27 10 [.swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 5 => .back 7 11 []
  | 6 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.sequence 0 0) (.sequence 0 6) 7)
  | 7 => .back 5 11 []
  | 8 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 8)
  | 9 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 9)
  | 10 => .win 0 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 1 0) 4)
  | 11 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 11)
  | 12 => .win 0 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 1 2) 4)
  | 13 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 13)
  | 14 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 14)
  | 15 => .win 0 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 1 4) 4)
  | 16 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 16)
  | 17 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 17)
  | 18 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 18)
  | 19 => .win 0 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 2 0) 4)
  | 20 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 20)
  | 21 => .win 0 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 2 2) 4)
  | 22 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 22)
  | 23 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 23)
  | 24 => .win 0 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 0) (.sequence 2 4) 4)
  | 25 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 25)
  | 26 => .win 0 (FullWinWitness.standard (.triplet 4) (.triplet 5) (.triplet 7) (.sequence 0 0) 26)
  | 27 => .back 4 10 [.swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 28 => .back 4 10 [.swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 29 => .back 4 10 [.swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 30 => .back 4 10 [.swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 31 => .back 4 10 [.swapHonors 4 6, .swapHonors 5 6]
  | 32 => .back 4 10 [.swapHonors 5 6]
  | 33 => .back 4 10 []
  | _ => .win 0 (FullWinWitness.orphans 0)

def row15 : Row := ⟨15, state15, 15, action15⟩

def state16 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 5 | 7 | 9 | 12 | 15 | 19 | 21 | 24 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 3 | 4 | 6 | 8 | 10 | 11 | 17 | 18 | 20 | 22 | 23 | 25 | 26 | 33 => 1
  | 13 => 4
  | 14 | 16 => 3
  | _ => 0

def action16 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 1 10 [.swapSuits 0 1, .reverseSuit 0]
  | 1 => .back 0 10 [.swapSuits 0 1, .reverseSuit 0]
  | 2 => .win 6 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 6)
  | 3 => .win 5 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 4) 3)
  | 4 => .win 7 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 6) 4)
  | 5 => .win 3 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 4) 3)
  | 6 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 6)
  | 7 => .win 2 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 2) (.sequence 0 6) 13)
  | 8 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 8)
  | 9 => .win 2 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 2) (.sequence 1 0) 13)
  | 10 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 10)
  | 11 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 11)
  | 12 => .win 2 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 2) (.sequence 1 1) 13)
  | 14 => .back 16 12 []
  | 15 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 16) (.sequence 0 2) (.sequence 1 4) 14)
  | 16 => .back 14 12 []
  | 17 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 17)
  | 18 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 18)
  | 19 => .win 2 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 2) (.sequence 2 0) 13)
  | 20 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 20)
  | 21 => .win 2 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 2) (.sequence 2 2) 13)
  | 22 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 22)
  | 23 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 23)
  | 24 => .win 2 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 2) (.sequence 2 4) 13)
  | 25 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 25)
  | 26 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 26)
  | 27 => .back 16 13 [.swapHonors 0 5, .swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | 28 => .back 16 13 [.swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | 29 => .back 16 13 [.swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | 30 => .back 16 13 [.swapHonors 3 5, .swapHonors 4 5]
  | 31 => .back 16 13 [.swapHonors 4 5]
  | 32 => .back 16 13 []
  | 33 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row16 : Row := ⟨16, state16, 16, action16⟩

def state17 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 5 | 7 | 9 | 12 | 15 | 19 | 21 | 24 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 0
  | 3 | 4 | 6 | 8 | 10 | 11 | 17 | 18 | 20 | 22 | 23 | 25 | 26 => 1
  | 13 => 3
  | 14 | 16 => 4
  | _ => 0

def action17 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 1 11 [.swapSuits 0 1, .reverseSuit 0]
  | 1 => .back 0 11 [.swapSuits 0 1, .reverseSuit 0]
  | 2 => .win 6 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 6)
  | 3 => .win 5 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 4) 3)
  | 4 => .win 7 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 6) 4)
  | 5 => .win 3 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 4) 3)
  | 6 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 6)
  | 7 => .win 2 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 2) (.sequence 0 6) 13)
  | 8 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 8)
  | 9 => .win 2 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 2) (.sequence 1 0) 13)
  | 10 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 10)
  | 11 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 11)
  | 12 => .win 2 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 2) (.sequence 1 1) 13)
  | 13 => .back 27 12 [.swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 15 => .win 2 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 2) (.sequence 1 4) 13)
  | 17 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 17)
  | 18 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 18)
  | 19 => .win 2 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 2) (.sequence 2 0) 13)
  | 20 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 20)
  | 21 => .win 2 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 2) (.sequence 2 2) 13)
  | 22 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 22)
  | 23 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 23)
  | 24 => .win 2 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 2) (.sequence 2 4) 13)
  | 25 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 25)
  | 26 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 26)
  | 27 => .back 13 12 [.swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 28 => .back 13 12 [.swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 29 => .back 13 12 [.swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 30 => .back 13 12 [.swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 31 => .back 13 12 [.swapHonors 4 6, .swapHonors 5 6]
  | 32 => .back 13 12 [.swapHonors 5 6]
  | 33 => .back 13 12 []
  | _ => .win 0 (FullWinWitness.orphans 0)

def row17 : Row := ⟨17, state17, 17, action17⟩

def state18 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 5 | 7 | 9 | 10 | 11 | 14 | 16 | 18 | 21 | 24 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 3 | 4 | 6 | 8 | 12 | 13 | 15 | 17 | 19 | 20 | 26 | 33 => 1
  | 22 | 23 | 25 => 4
  | _ => 0

def action18 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 1 12 [.swapSuits 0 2, .swapSuits 1 2, .reverseSuit 0]
  | 1 => .back 0 12 [.swapSuits 0 2, .swapSuits 1 2, .reverseSuit 0]
  | 2 => .win 6 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 6)
  | 3 => .win 5 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 4) 3)
  | 4 => .win 7 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 6) 4)
  | 5 => .win 3 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 4) 3)
  | 6 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 6)
  | 7 => .win 2 (FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 2) (.sequence 0 6) 22)
  | 8 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 8)
  | 9 => .back 10 12 [.swapSuits 1 2, .reverseSuit 1]
  | 10 => .back 9 12 [.swapSuits 1 2, .reverseSuit 1]
  | 11 => .win 2 (FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 2) (.sequence 1 2) 22)
  | 12 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 12)
  | 13 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 13)
  | 14 => .win 2 (FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 2) (.sequence 1 3) 22)
  | 15 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 15)
  | 16 => .win 2 (FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 2) (.sequence 1 6) 22)
  | 17 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 17)
  | 18 => .win 2 (FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 2) (.sequence 2 0) 22)
  | 19 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 19)
  | 20 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 20)
  | 21 => .win 2 (FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 2) (.sequence 2 1) 22)
  | 24 => .win 2 (FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 2) (.sequence 2 4) 22)
  | 26 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 26)
  | 27 => .back 28 14 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 14 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 14 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 14 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 14 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 14 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row18 : Row := ⟨18, state18, 18, action18⟩

def state19 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 5 | 7 | 9 | 10 | 11 | 14 | 16 | 18 | 21 | 24 | 27 | 28 | 29 | 30 | 31 => 0
  | 3 | 4 | 6 | 8 | 12 | 13 | 15 | 17 | 19 | 20 | 26 | 32 | 33 => 1
  | 22 | 25 => 4
  | 23 => 3
  | _ => 0

def action19 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 1 13 [.swapSuits 0 2, .swapSuits 1 2, .reverseSuit 0]
  | 1 => .back 0 13 [.swapSuits 0 2, .swapSuits 1 2, .reverseSuit 0]
  | 2 => .win 6 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 6)
  | 3 => .win 5 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 4) 3)
  | 4 => .win 7 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 6) 4)
  | 5 => .win 3 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 4) 3)
  | 6 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 6)
  | 7 => .win 2 (FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 2) (.sequence 0 6) 22)
  | 8 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 8)
  | 9 => .back 10 13 [.swapSuits 1 2, .reverseSuit 1]
  | 10 => .back 9 13 [.swapSuits 1 2, .reverseSuit 1]
  | 11 => .win 2 (FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 2) (.sequence 1 2) 22)
  | 12 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 12)
  | 13 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 13)
  | 14 => .win 2 (FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 2) (.sequence 1 3) 22)
  | 15 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 15)
  | 16 => .win 2 (FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 2) (.sequence 1 6) 22)
  | 17 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 17)
  | 18 => .win 2 (FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 2) (.sequence 2 0) 22)
  | 19 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 19)
  | 20 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 20)
  | 21 => .win 2 (FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 2) (.sequence 2 1) 22)
  | 23 => .back 27 14 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 24 => .win 2 (FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 2) (.sequence 2 6) 22)
  | 26 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 26)
  | 27 => .back 23 14 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 28 => .back 23 14 [.swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 29 => .back 23 14 [.swapHonors 2 4, .swapHonors 3 4]
  | 30 => .back 23 14 [.swapHonors 3 4]
  | 31 => .back 23 14 []
  | 32 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 32)
  | 33 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row19 : Row := ⟨19, state19, 19, action19⟩

def state20 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 5 | 7 | 9 | 12 | 15 | 19 | 21 | 24 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 0
  | 3 | 4 | 6 | 8 | 10 | 11 | 17 | 18 | 20 | 22 | 23 | 25 | 26 => 1
  | 13 | 14 | 16 => 3
  | _ => 0

def action20 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 1 15 [.swapSuits 0 1, .reverseSuit 0]
  | 1 => .back 0 15 [.swapSuits 0 1, .reverseSuit 0]
  | 2 => .win 6 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 6)
  | 3 => .win 5 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 4) 3)
  | 4 => .win 7 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 6) 4)
  | 5 => .win 3 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 4) 3)
  | 6 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 6)
  | 7 => .win 2 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 2) (.sequence 0 6) 13)
  | 8 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 8)
  | 9 => .win 2 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 2) (.sequence 1 0) 13)
  | 10 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 10)
  | 11 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 11)
  | 12 => .win 2 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 2) (.sequence 1 1) 13)
  | 13 => .back 27 16 [.swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 14 => .back 16 17 []
  | 15 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.sequence 0 2) (.sequence 1 6) 16)
  | 16 => .back 14 17 []
  | 17 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 17)
  | 18 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 18)
  | 19 => .win 2 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 2) (.sequence 2 0) 13)
  | 20 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 20)
  | 21 => .win 2 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 2) (.sequence 2 2) 13)
  | 22 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 22)
  | 23 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 23)
  | 24 => .win 2 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 2) (.sequence 2 4) 13)
  | 25 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 25)
  | 26 => .win 2 (FullWinWitness.standard (.triplet 13) (.triplet 14) (.triplet 16) (.sequence 0 2) 26)
  | 27 => .back 13 16 [.swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 28 => .back 13 16 [.swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 29 => .back 13 16 [.swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 30 => .back 13 16 [.swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 31 => .back 13 16 [.swapHonors 4 6, .swapHonors 5 6]
  | 32 => .back 13 16 [.swapHonors 5 6]
  | 33 => .back 13 16 []
  | _ => .win 0 (FullWinWitness.orphans 0)

def row20 : Row := ⟨20, state20, 20, action20⟩

def state21 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 5 | 7 | 9 | 10 | 11 | 14 | 16 | 18 | 21 | 24 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 3 | 4 | 6 | 8 | 12 | 13 | 15 | 17 | 19 | 20 | 26 | 33 => 1
  | 22 => 4
  | 23 | 25 => 3
  | _ => 0

def action21 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 1 16 [.swapSuits 0 2, .swapSuits 1 2, .reverseSuit 0]
  | 1 => .back 0 16 [.swapSuits 0 2, .swapSuits 1 2, .reverseSuit 0]
  | 2 => .win 6 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 6)
  | 3 => .win 5 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 4) 3)
  | 4 => .win 7 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 6) 4)
  | 5 => .win 3 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 4) 3)
  | 6 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 6)
  | 7 => .win 2 (FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 2) (.sequence 0 6) 22)
  | 8 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 8)
  | 9 => .back 10 16 [.swapSuits 1 2, .reverseSuit 1]
  | 10 => .back 9 16 [.swapSuits 1 2, .reverseSuit 1]
  | 11 => .win 2 (FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 2) (.sequence 1 2) 22)
  | 12 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 12)
  | 13 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 13)
  | 14 => .win 2 (FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 2) (.sequence 1 3) 22)
  | 15 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 15)
  | 16 => .win 2 (FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 2) (.sequence 1 6) 22)
  | 17 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 17)
  | 18 => .win 2 (FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 2) (.sequence 2 0) 22)
  | 19 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 19)
  | 20 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 20)
  | 21 => .win 2 (FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 2) (.sequence 2 1) 22)
  | 23 => .back 25 18 []
  | 24 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 25) (.sequence 0 2) (.sequence 2 4) 23)
  | 25 => .back 23 18 []
  | 26 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 26)
  | 27 => .back 25 19 [.swapHonors 0 5, .swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | 28 => .back 25 19 [.swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | 29 => .back 25 19 [.swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | 30 => .back 25 19 [.swapHonors 3 5, .swapHonors 4 5]
  | 31 => .back 25 19 [.swapHonors 4 5]
  | 32 => .back 25 19 []
  | 33 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row21 : Row := ⟨21, state21, 21, action21⟩

def state22 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 5 | 7 | 9 | 10 | 11 | 14 | 16 | 18 | 21 | 24 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 0
  | 3 | 4 | 6 | 8 | 12 | 13 | 15 | 17 | 19 | 20 | 26 => 1
  | 22 => 3
  | 23 | 25 => 4
  | _ => 0

def action22 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 1 17 [.swapSuits 0 2, .swapSuits 1 2, .reverseSuit 0]
  | 1 => .back 0 17 [.swapSuits 0 2, .swapSuits 1 2, .reverseSuit 0]
  | 2 => .win 6 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 6)
  | 3 => .win 5 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 4) 3)
  | 4 => .win 7 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 6) 4)
  | 5 => .win 3 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 4) 3)
  | 6 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 6)
  | 7 => .win 2 (FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 2) (.sequence 0 6) 22)
  | 8 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 8)
  | 9 => .back 10 17 [.swapSuits 1 2, .reverseSuit 1]
  | 10 => .back 9 17 [.swapSuits 1 2, .reverseSuit 1]
  | 11 => .win 2 (FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 2) (.sequence 1 2) 22)
  | 12 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 12)
  | 13 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 13)
  | 14 => .win 2 (FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 2) (.sequence 1 3) 22)
  | 15 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 15)
  | 16 => .win 2 (FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 2) (.sequence 1 6) 22)
  | 17 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 17)
  | 18 => .win 2 (FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 2) (.sequence 2 0) 22)
  | 19 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 19)
  | 20 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 20)
  | 21 => .win 2 (FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 2) (.sequence 2 1) 22)
  | 22 => .back 27 18 [.swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 24 => .win 2 (FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 2) (.sequence 2 4) 22)
  | 26 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 26)
  | 27 => .back 22 18 [.swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 28 => .back 22 18 [.swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 29 => .back 22 18 [.swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 30 => .back 22 18 [.swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 31 => .back 22 18 [.swapHonors 4 6, .swapHonors 5 6]
  | 32 => .back 22 18 [.swapHonors 5 6]
  | 33 => .back 22 18 []
  | _ => .win 0 (FullWinWitness.orphans 0)

def row22 : Row := ⟨22, state22, 22, action22⟩

def state23 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 5 | 7 | 9 | 10 | 11 | 14 | 16 | 18 | 21 | 24 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 0
  | 3 | 4 | 6 | 8 | 12 | 13 | 15 | 17 | 19 | 20 | 26 => 1
  | 22 | 23 | 25 => 3
  | _ => 0

def action23 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 1 20 [.swapSuits 0 2, .swapSuits 1 2, .reverseSuit 0]
  | 1 => .back 0 20 [.swapSuits 0 2, .swapSuits 1 2, .reverseSuit 0]
  | 2 => .win 6 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 6)
  | 3 => .win 5 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 4) 3)
  | 4 => .win 7 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 6) 4)
  | 5 => .win 3 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 4) 3)
  | 6 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 6)
  | 7 => .win 2 (FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 2) (.sequence 0 6) 22)
  | 8 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 8)
  | 9 => .back 10 20 [.swapSuits 1 2, .reverseSuit 1]
  | 10 => .back 9 20 [.swapSuits 1 2, .reverseSuit 1]
  | 11 => .win 2 (FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 2) (.sequence 1 2) 22)
  | 12 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 12)
  | 13 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 13)
  | 14 => .win 2 (FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 2) (.sequence 1 3) 22)
  | 15 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 15)
  | 16 => .win 2 (FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 2) (.sequence 1 6) 22)
  | 17 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 17)
  | 18 => .win 2 (FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 2) (.sequence 2 0) 22)
  | 19 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 19)
  | 20 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 20)
  | 21 => .win 2 (FullWinWitness.standard (.triplet 23) (.triplet 25) (.sequence 0 2) (.sequence 2 1) 22)
  | 22 => .back 27 21 [.swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 23 => .back 25 22 []
  | 24 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.sequence 0 2) (.sequence 2 6) 25)
  | 25 => .back 23 22 []
  | 26 => .win 2 (FullWinWitness.standard (.triplet 22) (.triplet 23) (.triplet 25) (.sequence 0 2) 26)
  | 27 => .back 22 21 [.swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 28 => .back 22 21 [.swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 29 => .back 22 21 [.swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 30 => .back 22 21 [.swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 31 => .back 22 21 [.swapHonors 4 6, .swapHonors 5 6]
  | 32 => .back 22 21 [.swapHonors 5 6]
  | 33 => .back 22 21 []
  | _ => .win 0 (FullWinWitness.orphans 0)

def row23 : Row := ⟨23, state23, 23, action23⟩

def database : Tree := (.branch (.branch (.branch (.branch (.branch .empty row0 .empty) row1 (.branch .empty row2 .empty)) row3 (.branch (.branch .empty row4 .empty) row5 .empty)) row6 (.branch (.branch (.branch .empty row7 .empty) row8 .empty) row9 (.branch (.branch .empty row10 .empty) row11 .empty))) row12 (.branch (.branch (.branch (.branch .empty row13 .empty) row14 .empty) row15 (.branch (.branch .empty row16 .empty) row17 .empty)) row18 (.branch (.branch (.branch .empty row19 .empty) row20 .empty) row21 (.branch (.branch .empty row22 .empty) row23 .empty))))

theorem checked : checkDatabase bounds database = true := by decide +kernel

theorem root_proved : ProvedP state23 :=
  checkDatabase_sound bounds validBounds safeBounds database checked 23 row23 (by rfl)
def original (t : Tile) : Nat :=
  match t.val with
  | 0 | 3 | 6 | 10 | 12 | 15 | 16 | 17 | 19 | 21 | 24 | 25 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 0
  | 1 | 2 | 8 | 9 | 11 | 13 | 14 | 18 | 20 | 22 | 23 => 1
  | 4 | 5 | 7 => 3
  | _ => 0

theorem original_checked : Generators.checkReference [.swapSuits 0 2, .swapSuits 1 2, .reverseSuit 1, .reverseSuit 2] state23 original = true := by decide +kernel
theorem original_proved : ProvedP original :=
  root_proved.ofPath [.swapSuits 0 2, .swapSuits 1 2, .reverseSuit 1, .reverseSuit 2] (Generators.stateEqB_sound original_checked)
theorem original_tiles : total original = 20 := by decide +kernel
theorem original_second_player_wins : SafeGame.SecondPlayerWins Step Win original :=
  original_proved.secondPlayerWins

end Mahjong.ResponseTableFull20

#print axioms Mahjong.ResponseTableFull20.checked
#print axioms Mahjong.ResponseTableFull20.root_proved
#print axioms Mahjong.ResponseTableFull20.original_proved
#print axioms Mahjong.ResponseTableFull20.original_second_player_wins
