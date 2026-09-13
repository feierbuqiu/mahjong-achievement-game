import MahjongScale.Actual12V2.Base

set_option maxRecDepth 32768
set_option maxHeartbeats 100000000

namespace Mahjong.Scale12V2
open ResponseTable ResponseCertificate Generators

def state64 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 19 | 20 | 24 | 27 | 28 => 0
  | 1 | 5 | 6 | 7 | 8 | 10 | 13 | 16 | 18 | 22 | 23 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 17 | 21 => 2
  | 25 => 3
  | _ => 0

def action64 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 0 5) (.sequence 2 3) 17)
  | 1 => .win 1 (FullWinWitness.standard (.triplet 1) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 2 => .win 0 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 0 5) (.sequence 2 3) 17)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 1) (.sequence 0 5) (.sequence 2 3) 17)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 25) (.sequence 0 3) (.sequence 0 6) (.sequence 2 3) 17)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 25) (.sequence 0 6) (.sequence 2 3) 17)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 4) (.sequence 0 6) (.sequence 2 3) 17)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 0 6) (.sequence 2 3) 17)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 9 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 0) (.sequence 2 3) 17)
  | 10 => .win 10 (FullWinWitness.standard (.triplet 10) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 11 => .win 9 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 0) (.sequence 2 3) 17)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 1) (.sequence 2 3) 17)
  | 13 => .win 13 (FullWinWitness.standard (.triplet 13) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 14 => .win 12 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 17)
  | 15 => .win 1 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 1)
  | 16 => .win 16 (FullWinWitness.standard (.triplet 16) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 17 => .win 1 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 1)
  | 18 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 18)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 21 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 21)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 2) (.sequence 2 3) 17)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 24 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 4) 21)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 6) 17)
  | 26 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 26)
  | 27 => .back 28 9 [.swapHonors 0 1]
  | 28 => .back 27 9 []
  | 29 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 29)
  | 30 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 30)
  | 31 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row64 : Row := ⟨64, state64, 64, action64⟩

def state65 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 5 | 6 | 9 | 11 | 12 | 13 | 19 | 20 | 24 | 27 => 0
  | 1 | 7 | 10 | 14 | 15 | 16 | 17 | 18 | 22 | 23 | 26 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 8 | 21 => 2
  | 25 => 3
  | _ => 0

def action65 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 1 => .win 1 (FullWinWitness.standard (.triplet 1) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 8)
  | 2 => .win 0 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 4 => .back 27 9 [.swapSuits 0 1]
  | 5 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 5) (.sequence 2 3) 8)
  | 6 => .win 1 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 1)
  | 7 => .win 7 (FullWinWitness.standard (.triplet 7) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 8)
  | 8 => .win 1 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 1)
  | 9 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 1 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 10 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 10)
  | 11 => .win 9 (FullWinWitness.standard (.triplet 25) (.sequence 1 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 1 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 25) (.sequence 1 3) (.sequence 1 6) (.sequence 2 3) 8)
  | 14 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 6) (.sequence 2 3) 14)
  | 15 => .win 13 (FullWinWitness.standard (.triplet 25) (.sequence 1 4) (.sequence 1 6) (.sequence 2 3) 8)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 1 6) (.sequence 2 3) 8)
  | 17 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 17)
  | 18 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 18)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 0) (.sequence 2 3) 8)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 0) (.sequence 2 3) 8)
  | 21 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 21)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 2) (.sequence 2 3) 8)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 3) (.sequence 2 3) 8)
  | 24 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 4) 21)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 3) (.sequence 2 6) 8)
  | 26 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 26)
  | 27 => .back 4 9 [.swapSuits 0 1]
  | 28 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 28)
  | 29 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 29)
  | 30 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 30)
  | 31 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row65 : Row := ⟨65, state65, 65, action65⟩

def state66 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 19 | 20 | 24 | 27 | 28 => 0
  | 1 | 5 | 6 | 7 | 8 | 10 | 13 | 16 | 18 | 21 | 22 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 17 | 23 => 2
  | 25 => 3
  | _ => 0

def action66 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 0 5) (.sequence 2 3) 17)
  | 1 => .win 1 (FullWinWitness.standard (.triplet 1) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 2 => .win 0 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 0 5) (.sequence 2 3) 17)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 1) (.sequence 0 5) (.sequence 2 3) 17)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 25) (.sequence 0 3) (.sequence 0 6) (.sequence 2 3) 17)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 25) (.sequence 0 6) (.sequence 2 3) 17)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 4) (.sequence 0 6) (.sequence 2 3) 17)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 0 6) (.sequence 2 3) 17)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 9 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 0) (.sequence 2 3) 17)
  | 10 => .win 10 (FullWinWitness.standard (.triplet 10) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 11 => .win 9 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 0) (.sequence 2 3) 17)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 1) (.sequence 2 3) 17)
  | 13 => .win 13 (FullWinWitness.standard (.triplet 13) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 14 => .win 12 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 17)
  | 15 => .win 1 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 1)
  | 16 => .win 16 (FullWinWitness.standard (.triplet 16) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 17 => .win 1 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 1)
  | 18 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 18)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 20 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 2) 23)
  | 21 => .win 22 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 23 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 23)
  | 24 => .win 15 (FullWinWitness.standard (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) (.sequence 2 5) 25)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 5) 17)
  | 26 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 26)
  | 27 => .back 28 10 [.swapHonors 0 1]
  | 28 => .back 27 10 []
  | 29 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 29)
  | 30 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 30)
  | 31 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row66 : Row := ⟨66, state66, 66, action66⟩

def state67 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 18 | 20 | 24 | 27 | 28 => 0
  | 1 | 5 | 6 | 7 | 8 | 10 | 13 | 16 | 19 | 21 | 22 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 17 | 23 => 2
  | 25 => 3
  | _ => 0

def action67 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 0 5) (.sequence 2 3) 17)
  | 1 => .win 1 (FullWinWitness.standard (.triplet 1) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 2 => .win 0 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 0 5) (.sequence 2 3) 17)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 1) (.sequence 0 5) (.sequence 2 3) 17)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 25) (.sequence 0 3) (.sequence 0 6) (.sequence 2 3) 17)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 25) (.sequence 0 6) (.sequence 2 3) 17)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 4) (.sequence 0 6) (.sequence 2 3) 17)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 0 6) (.sequence 2 3) 17)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 9 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 0) (.sequence 2 3) 17)
  | 10 => .win 10 (FullWinWitness.standard (.triplet 10) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 11 => .win 9 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 0) (.sequence 2 3) 17)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 1) (.sequence 2 3) 17)
  | 13 => .win 13 (FullWinWitness.standard (.triplet 13) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 14 => .win 12 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 17)
  | 15 => .win 1 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 1)
  | 16 => .win 16 (FullWinWitness.standard (.triplet 16) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 17 => .win 1 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 1)
  | 18 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 19 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 19)
  | 20 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 1) 23)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 1) (.sequence 2 3) 17)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 23 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 23)
  | 24 => .win 15 (FullWinWitness.standard (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) (.sequence 2 5) 25)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 5) 17)
  | 26 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 26)
  | 27 => .back 28 11 [.swapHonors 0 1]
  | 28 => .back 27 11 []
  | 29 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 29)
  | 30 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 30)
  | 31 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row67 : Row := ⟨67, state67, 67, action67⟩

def state68 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 18 | 20 | 24 | 27 | 28 => 0
  | 1 | 5 | 6 | 7 | 8 | 10 | 13 | 16 | 19 | 21 | 23 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 17 | 22 => 2
  | 25 => 3
  | _ => 0

def action68 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 0 5) (.sequence 2 3) 17)
  | 1 => .win 1 (FullWinWitness.standard (.triplet 1) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 2 => .win 0 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 0 5) (.sequence 2 3) 17)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 1) (.sequence 0 5) (.sequence 2 3) 17)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 25) (.sequence 0 3) (.sequence 0 6) (.sequence 2 3) 17)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 25) (.sequence 0 6) (.sequence 2 3) 17)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 4) (.sequence 0 6) (.sequence 2 3) 17)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 0 6) (.sequence 2 3) 17)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 9 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 0) (.sequence 2 3) 17)
  | 10 => .win 10 (FullWinWitness.standard (.triplet 10) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 11 => .win 9 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 0) (.sequence 2 3) 17)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 1) (.sequence 2 3) 17)
  | 13 => .win 13 (FullWinWitness.standard (.triplet 13) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 14 => .win 12 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 17)
  | 15 => .win 1 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 1)
  | 16 => .win 16 (FullWinWitness.standard (.triplet 16) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 17 => .win 1 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 1)
  | 18 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 19 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 19)
  | 20 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 1) 22)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 1) (.sequence 2 3) 17)
  | 22 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 22)
  | 23 => .win 21 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 24 => .win 15 (FullWinWitness.standard (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) (.sequence 2 6) 25)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 6) 17)
  | 26 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 26)
  | 27 => .back 28 12 [.swapHonors 0 1]
  | 28 => .back 27 12 []
  | 29 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 29)
  | 30 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 30)
  | 31 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row68 : Row := ⟨68, state68, 68, action68⟩

def state69 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 5 | 6 | 9 | 11 | 12 | 13 | 18 | 20 | 24 | 27 => 0
  | 1 | 7 | 10 | 14 | 15 | 16 | 17 | 19 | 21 | 22 | 26 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 8 | 23 => 2
  | 25 => 3
  | _ => 0

def action69 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 1 => .win 1 (FullWinWitness.standard (.triplet 1) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 8)
  | 2 => .win 0 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 4 => .back 27 11 [.swapSuits 0 1]
  | 5 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 5) (.sequence 2 3) 8)
  | 6 => .win 1 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 1)
  | 7 => .win 7 (FullWinWitness.standard (.triplet 7) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 8)
  | 8 => .win 1 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 1)
  | 9 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 1 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 10 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 10)
  | 11 => .win 9 (FullWinWitness.standard (.triplet 25) (.sequence 1 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 1 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 25) (.sequence 1 3) (.sequence 1 6) (.sequence 2 3) 8)
  | 14 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 6) (.sequence 2 3) 14)
  | 15 => .win 13 (FullWinWitness.standard (.triplet 25) (.sequence 1 4) (.sequence 1 6) (.sequence 2 3) 8)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 1 6) (.sequence 2 3) 8)
  | 17 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 17)
  | 18 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 0) (.sequence 2 3) 8)
  | 19 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 19)
  | 20 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 1) 23)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 1) (.sequence 2 3) 8)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 3) (.sequence 2 3) 8)
  | 23 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 23)
  | 24 => .win 6 (FullWinWitness.standard (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) (.sequence 2 5) 25)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 3) (.sequence 2 5) 8)
  | 26 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 26)
  | 27 => .back 4 11 [.swapSuits 0 1]
  | 28 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 28)
  | 29 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 29)
  | 30 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 30)
  | 31 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row69 : Row := ⟨69, state69, 69, action69⟩

def state70 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 6 | 9 | 11 | 12 | 13 | 14 | 16 | 18 | 20 | 21 | 22 => 0
  | 2 | 3 | 4 | 5 | 8 | 10 | 15 | 19 | 23 | 24 | 25 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 7 => 3
  | 17 => 2
  | _ => 0

def action70 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 1 (FullWinWitness.standard (.triplet 7) (.sequence 0 0) (.sequence 0 3) (.sequence 2 5) 17)
  | 1 => .win 0 (FullWinWitness.standard (.triplet 7) (.sequence 0 0) (.sequence 0 3) (.sequence 2 5) 17)
  | 2 => .win 2 (FullWinWitness.standard (.triplet 2) (.triplet 7) (.sequence 0 3) (.sequence 2 5) 17)
  | 3 => .win 1 (FullWinWitness.standard (.triplet 7) (.sequence 0 1) (.sequence 0 3) (.sequence 2 5) 17)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 0 3) (.sequence 2 5) 17)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 2) (.sequence 2 5) 17)
  | 6 => .win 1 (FullWinWitness.standard (.triplet 7) (.sequence 0 1) (.sequence 0 4) (.sequence 2 5) 17)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 0 5) (.sequence 2 5) 17)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 7) (.triplet 8) (.sequence 0 2) (.sequence 2 5) 17)
  | 9 => .win 11 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 0) (.sequence 2 5) 17)
  | 10 => .win 10 (FullWinWitness.standard (.triplet 7) (.triplet 10) (.sequence 0 2) (.sequence 2 5) 17)
  | 11 => .win 9 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 0) (.sequence 2 5) 17)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 1) (.sequence 2 5) 17)
  | 13 => .win 14 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 4) (.sequence 2 5) 17)
  | 14 => .win 13 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 4) (.sequence 2 5) 17)
  | 15 => .win 15 (FullWinWitness.standard (.triplet 7) (.triplet 15) (.sequence 0 2) (.sequence 2 5) 17)
  | 16 => .win 2 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 6) (.sequence 2 5) 2)
  | 17 => .win 2 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 3) (.sequence 2 5) 2)
  | 18 => .win 20 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 2 0) (.sequence 2 5) 17)
  | 19 => .win 16 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 6) (.sequence 2 5) 19)
  | 20 => .win 18 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 2 0) (.sequence 2 5) 17)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 2 1) (.sequence 2 5) 17)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 2 3) (.sequence 2 6) 17)
  | 23 => .win 16 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 6) (.sequence 2 6) 23)
  | 24 => .win 22 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 2 4) (.sequence 2 6) 17)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 2 5) (.sequence 2 6) 17)
  | 26 => .win 16 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 6) (.sequence 2 5) 26)
  | 27 => .win 16 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 6) (.sequence 2 5) 27)
  | 28 => .win 16 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 6) (.sequence 2 5) 28)
  | 29 => .win 16 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 6) (.sequence 2 5) 29)
  | 30 => .win 16 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 6) (.sequence 2 5) 30)
  | 31 => .win 16 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 6) (.sequence 2 5) 31)
  | 32 => .win 16 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 6) (.sequence 2 5) 32)
  | 33 => .win 16 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 6) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row70 : Row := ⟨70, state70, 70, action70⟩

def state71 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 6 | 9 | 11 | 12 | 13 | 18 | 20 | 21 | 23 | 24 | 25 => 0
  | 3 | 5 | 8 | 10 | 14 | 15 | 16 | 17 | 19 | 22 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 4 | 26 => 2
  | 7 => 3
  | _ => 0

def action71 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 25 8 [.swapSuits 0 2, .swapSuits 1 2]
  | 1 => .back 25 12 [.swapSuits 0 2, .swapSuits 1 2]
  | 2 => .win 3 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 0 3) (.sequence 1 5) 26)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 0 3) (.sequence 1 5) 26)
  | 4 => .win 4 (FullWinWitness.standard (.triplet 4) (.triplet 7) (.sequence 0 3) (.sequence 1 5) 26)
  | 5 => .win 3 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 0 3) (.sequence 1 5) 26)
  | 6 => .win 2 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 0 4) (.sequence 1 5) 26)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 0 6) (.sequence 1 5) 26)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 7) (.triplet 8) (.sequence 0 3) (.sequence 1 5) 26)
  | 9 => .win 11 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 0) (.sequence 1 5) 26)
  | 10 => .win 10 (FullWinWitness.standard (.triplet 7) (.triplet 10) (.sequence 0 3) (.sequence 1 5) 26)
  | 11 => .win 9 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 0) (.sequence 1 5) 26)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 1) (.sequence 1 5) 26)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 3) (.sequence 1 6) 26)
  | 14 => .win 14 (FullWinWitness.standard (.triplet 7) (.triplet 14) (.sequence 0 3) (.sequence 1 6) 26)
  | 15 => .win 13 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 4) (.sequence 1 6) 26)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 1 6) 26)
  | 17 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 3) (.sequence 1 5) 26)
  | 18 => .win 20 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 0) 26)
  | 19 => .win 19 (FullWinWitness.standard (.triplet 7) (.triplet 19) (.sequence 0 3) (.sequence 1 5) 26)
  | 20 => .win 18 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 0) 26)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 1) 26)
  | 22 => .win 22 (FullWinWitness.standard (.triplet 7) (.triplet 22) (.sequence 0 3) (.sequence 1 5) 26)
  | 23 => .win 21 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 3) 26)
  | 24 => .win 23 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 4) 26)
  | 25 => .back 0 8 [.swapSuits 0 2, .swapSuits 1 2]
  | 26 => .win 4 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 4)
  | 27 => .win 26 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 27)
  | 28 => .win 26 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 28)
  | 29 => .win 26 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 29)
  | 30 => .win 26 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 30)
  | 31 => .win 26 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 31)
  | 32 => .win 26 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 32)
  | 33 => .win 26 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row71 : Row := ⟨71, state71, 71, action71⟩

def state72 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 6 | 9 | 11 | 12 | 13 | 15 | 16 | 18 | 20 | 21 | 22 => 0
  | 2 | 3 | 4 | 5 | 8 | 10 | 14 | 19 | 23 | 24 | 25 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 7 => 3
  | 17 => 2
  | _ => 0

def action72 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 1 (FullWinWitness.standard (.triplet 7) (.sequence 0 0) (.sequence 0 3) (.sequence 2 5) 17)
  | 1 => .win 0 (FullWinWitness.standard (.triplet 7) (.sequence 0 0) (.sequence 0 3) (.sequence 2 5) 17)
  | 2 => .win 2 (FullWinWitness.standard (.triplet 2) (.triplet 7) (.sequence 0 3) (.sequence 2 5) 17)
  | 3 => .win 1 (FullWinWitness.standard (.triplet 7) (.sequence 0 1) (.sequence 0 3) (.sequence 2 5) 17)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 0 3) (.sequence 2 5) 17)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 2) (.sequence 2 5) 17)
  | 6 => .win 1 (FullWinWitness.standard (.triplet 7) (.sequence 0 1) (.sequence 0 4) (.sequence 2 5) 17)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 0 5) (.sequence 2 5) 17)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 7) (.triplet 8) (.sequence 0 2) (.sequence 2 5) 17)
  | 9 => .win 11 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 0) (.sequence 2 5) 17)
  | 10 => .win 10 (FullWinWitness.standard (.triplet 7) (.triplet 10) (.sequence 0 2) (.sequence 2 5) 17)
  | 11 => .win 9 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 0) (.sequence 2 5) 17)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 1) (.sequence 2 5) 17)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 3) (.sequence 2 5) 17)
  | 14 => .win 14 (FullWinWitness.standard (.triplet 7) (.triplet 14) (.sequence 0 2) (.sequence 2 5) 17)
  | 15 => .win 13 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 4) (.sequence 2 5) 17)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 5) (.sequence 2 5) 17)
  | 17 => .win 2 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 3) (.sequence 2 5) 2)
  | 18 => .win 20 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 2 0) (.sequence 2 5) 17)
  | 19 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 2) (.sequence 2 5) 19)
  | 20 => .win 18 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 2 0) (.sequence 2 5) 17)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 2 1) (.sequence 2 5) 17)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 2 3) (.sequence 2 6) 17)
  | 23 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 2) (.sequence 2 6) 23)
  | 24 => .win 22 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 2 4) (.sequence 2 6) 17)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 2 5) (.sequence 2 6) 17)
  | 26 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 2) (.sequence 2 5) 26)
  | 27 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 2) (.sequence 2 5) 27)
  | 28 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 2) (.sequence 2 5) 28)
  | 29 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 2) (.sequence 2 5) 29)
  | 30 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 2) (.sequence 2 5) 30)
  | 31 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 2) (.sequence 2 5) 31)
  | 32 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 2) (.sequence 2 5) 32)
  | 33 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 2) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row72 : Row := ⟨72, state72, 72, action72⟩

def state73 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 5 | 6 | 9 | 11 | 12 | 13 | 19 | 20 | 24 => 0
  | 1 | 7 | 10 | 14 | 15 | 16 | 17 | 18 | 21 | 22 | 23 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 8 => 2
  | 25 => 3
  | _ => 0

def action73 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 1 => .win 1 (FullWinWitness.standard (.triplet 1) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 8)
  | 2 => .win 0 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 4 => .back 21 9 [.swapSuits 0 1]
  | 5 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 5) (.sequence 2 3) 8)
  | 6 => .win 1 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 1)
  | 7 => .win 7 (FullWinWitness.standard (.triplet 7) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 8)
  | 8 => .win 1 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 1)
  | 9 => .win 0 (FullWinWitness.orphans 8)
  | 10 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 10)
  | 11 => .win 9 (FullWinWitness.standard (.triplet 25) (.sequence 1 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 1 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 25) (.sequence 1 3) (.sequence 1 6) (.sequence 2 3) 8)
  | 14 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 6) (.sequence 2 3) 14)
  | 15 => .win 13 (FullWinWitness.standard (.triplet 25) (.sequence 1 4) (.sequence 1 6) (.sequence 2 3) 8)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 1 6) (.sequence 2 3) 8)
  | 17 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 17)
  | 18 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 18)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 0) (.sequence 2 3) 8)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 0) (.sequence 2 3) 8)
  | 21 => .back 4 9 [.swapSuits 0 1]
  | 22 => .back 4 8 [.swapSuits 0 1]
  | 23 => .back 4 10 [.swapSuits 0 1]
  | 24 => .win 6 (FullWinWitness.standard (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) (.sequence 2 6) 25)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 3) (.sequence 2 6) 8)
  | 26 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 26)
  | 27 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 27)
  | 28 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 28)
  | 29 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 29)
  | 30 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 30)
  | 31 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row73 : Row := ⟨73, state73, 73, action73⟩

def state74 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 5 | 6 | 9 | 11 | 12 | 13 | 18 | 20 | 24 => 0
  | 1 | 7 | 10 | 14 | 15 | 16 | 17 | 19 | 21 | 22 | 23 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 8 => 2
  | 25 => 3
  | _ => 0

def action74 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 1 => .win 1 (FullWinWitness.standard (.triplet 1) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 8)
  | 2 => .win 0 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 4 => .back 22 12 [.swapSuits 0 1]
  | 5 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 5) (.sequence 2 3) 8)
  | 6 => .win 1 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 1)
  | 7 => .win 7 (FullWinWitness.standard (.triplet 7) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 8)
  | 8 => .win 1 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 1)
  | 9 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 1 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 10 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 10)
  | 11 => .win 9 (FullWinWitness.standard (.triplet 25) (.sequence 1 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 1 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 25) (.sequence 1 3) (.sequence 1 6) (.sequence 2 3) 8)
  | 14 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 6) (.sequence 2 3) 14)
  | 15 => .win 13 (FullWinWitness.standard (.triplet 25) (.sequence 1 4) (.sequence 1 6) (.sequence 2 3) 8)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 1 6) (.sequence 2 3) 8)
  | 17 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 17)
  | 18 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 0) (.sequence 2 3) 8)
  | 19 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 19)
  | 20 => .win 18 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 0) (.sequence 2 3) 8)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 1) (.sequence 2 3) 8)
  | 22 => .back 4 12 [.swapSuits 0 1]
  | 23 => .back 4 11 [.swapSuits 0 1]
  | 24 => .win 6 (FullWinWitness.standard (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) (.sequence 2 6) 25)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 3) (.sequence 2 6) 8)
  | 26 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 26)
  | 27 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 27)
  | 28 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 28)
  | 29 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 29)
  | 30 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 30)
  | 31 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row74 : Row := ⟨74, state74, 74, action74⟩

def state75 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 6 | 9 | 11 | 12 | 13 | 14 | 15 | 18 | 20 | 21 | 22 => 0
  | 3 | 17 => 2
  | 4 | 5 | 8 | 10 | 16 | 19 | 23 | 24 | 25 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 7 => 3
  | _ => 0

def action75 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 13 9 [.swapSuits 0 2]
  | 1 => .win 2 (FullWinWitness.standard (.triplet 7) (.sequence 0 1) (.sequence 0 3) (.sequence 2 5) 17)
  | 2 => .win 1 (FullWinWitness.standard (.triplet 7) (.sequence 0 1) (.sequence 0 3) (.sequence 2 5) 17)
  | 3 => .win 3 (FullWinWitness.standard (.triplet 3) (.triplet 7) (.sequence 0 3) (.sequence 2 5) 17)
  | 4 => .win 2 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 0 3) (.sequence 2 5) 17)
  | 5 => .win 4 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 0 3) (.sequence 2 5) 17)
  | 6 => .win 3 (FullWinWitness.standard (.triplet 3) (.triplet 7) (.sequence 0 4) (.sequence 2 5) 17)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 0 6) (.sequence 2 5) 17)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 7) (.triplet 8) (.sequence 0 3) (.sequence 2 5) 17)
  | 9 => .win 11 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 0) (.sequence 2 5) 17)
  | 10 => .win 10 (FullWinWitness.standard (.triplet 7) (.triplet 10) (.sequence 0 3) (.sequence 2 5) 17)
  | 11 => .win 9 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 0) (.sequence 2 5) 17)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 1) (.sequence 2 5) 17)
  | 13 => .back 0 9 [.swapSuits 0 2]
  | 14 => .win 15 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 5) 17)
  | 15 => .win 3 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 6) (.sequence 2 5) 3)
  | 16 => .win 16 (FullWinWitness.standard (.triplet 7) (.triplet 16) (.sequence 0 3) (.sequence 2 5) 17)
  | 17 => .win 3 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 3) (.sequence 2 5) 3)
  | 18 => .win 20 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 2 0) (.sequence 2 5) 17)
  | 19 => .win 15 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 6) (.sequence 2 5) 19)
  | 20 => .win 18 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 2 0) (.sequence 2 5) 17)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 2 1) (.sequence 2 5) 17)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 2 3) (.sequence 2 6) 17)
  | 23 => .win 15 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 6) (.sequence 2 6) 23)
  | 24 => .win 22 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 2 4) (.sequence 2 6) 17)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 2 5) (.sequence 2 6) 17)
  | 26 => .win 15 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 6) (.sequence 2 5) 26)
  | 27 => .win 15 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 6) (.sequence 2 5) 27)
  | 28 => .win 15 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 6) (.sequence 2 5) 28)
  | 29 => .win 15 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 6) (.sequence 2 5) 29)
  | 30 => .win 15 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 6) (.sequence 2 5) 30)
  | 31 => .win 15 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 6) (.sequence 2 5) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 6) (.sequence 2 5) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 6) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row75 : Row := ⟨75, state75, 75, action75⟩

def state76 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 6 | 9 | 11 | 12 | 13 | 14 | 15 | 18 | 20 | 21 | 22 => 0
  | 3 | 4 | 8 | 10 | 16 | 19 | 23 | 24 | 25 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 5 | 17 => 2
  | 7 => 3
  | _ => 0

def action76 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 13 10 [.swapSuits 0 2]
  | 1 => .back 13 11 [.swapSuits 0 2]
  | 2 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 2) (.sequence 2 5) 17)
  | 3 => .win 4 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 0 3) (.sequence 2 5) 17)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 0 3) (.sequence 2 5) 17)
  | 5 => .win 2 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 2) (.sequence 2 5) 17)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 0 4) (.sequence 2 5) 17)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 0 5) (.sequence 2 5) 17)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 7) (.triplet 8) (.sequence 0 3) (.sequence 2 5) 17)
  | 9 => .win 11 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 0) (.sequence 2 5) 17)
  | 10 => .win 10 (FullWinWitness.standard (.triplet 7) (.triplet 10) (.sequence 0 3) (.sequence 2 5) 17)
  | 11 => .win 9 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 0) (.sequence 2 5) 17)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 1) (.sequence 2 5) 17)
  | 13 => .back 0 10 [.swapSuits 0 2]
  | 14 => .win 15 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 5) 17)
  | 15 => .win 2 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 6) (.sequence 2 5) 5)
  | 16 => .win 16 (FullWinWitness.standard (.triplet 7) (.triplet 16) (.sequence 0 3) (.sequence 2 5) 17)
  | 17 => .win 2 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 2) (.sequence 2 5) 5)
  | 18 => .win 20 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 2 0) (.sequence 2 5) 17)
  | 19 => .win 15 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 6) (.sequence 2 5) 19)
  | 20 => .win 18 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 2 0) (.sequence 2 5) 17)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 2 1) (.sequence 2 5) 17)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 2 3) (.sequence 2 6) 17)
  | 23 => .win 15 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 6) (.sequence 2 6) 23)
  | 24 => .win 22 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 2 4) (.sequence 2 6) 17)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 2 5) (.sequence 2 6) 17)
  | 26 => .win 15 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 6) (.sequence 2 5) 26)
  | 27 => .win 15 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 6) (.sequence 2 5) 27)
  | 28 => .win 15 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 6) (.sequence 2 5) 28)
  | 29 => .win 15 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 6) (.sequence 2 5) 29)
  | 30 => .win 15 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 6) (.sequence 2 5) 30)
  | 31 => .win 15 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 6) (.sequence 2 5) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 6) (.sequence 2 5) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 6) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row76 : Row := ⟨76, state76, 76, action76⟩

def state77 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 19 | 20 | 24 | 27 | 28 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 13 | 16 | 18 | 21 | 23 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 17 | 22 => 2
  | 25 => 3
  | _ => 0

def action77 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 1 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 0 5) (.sequence 2 3) 17)
  | 1 => .win 0 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 0 5) (.sequence 2 3) 17)
  | 2 => .win 2 (FullWinWitness.standard (.triplet 2) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 3 => .win 1 (FullWinWitness.standard (.triplet 25) (.sequence 0 1) (.sequence 0 5) (.sequence 2 3) 17)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 25) (.sequence 0 2) (.sequence 0 5) (.sequence 2 3) 17)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 25) (.sequence 0 6) (.sequence 2 3) 17)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 4) (.sequence 0 6) (.sequence 2 3) 17)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 0 6) (.sequence 2 3) 17)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 9 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 0) (.sequence 2 3) 17)
  | 10 => .win 10 (FullWinWitness.standard (.triplet 10) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 11 => .win 9 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 0) (.sequence 2 3) 17)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 1) (.sequence 2 3) 17)
  | 13 => .win 13 (FullWinWitness.standard (.triplet 13) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 14 => .win 12 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 17)
  | 15 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 2)
  | 16 => .win 16 (FullWinWitness.standard (.triplet 16) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 17 => .win 2 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 2)
  | 18 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 18)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 2) (.sequence 2 3) 17)
  | 22 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 22)
  | 23 => .win 21 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 24 => .win 15 (FullWinWitness.standard (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) (.sequence 2 6) 25)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 6) 17)
  | 26 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 26)
  | 27 => .back 28 13 [.swapHonors 0 1]
  | 28 => .back 27 13 []
  | 29 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 29)
  | 30 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 30)
  | 31 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row77 : Row := ⟨77, state77, 77, action77⟩

def state78 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 19 | 20 | 24 | 27 | 28 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 13 | 16 | 18 | 22 | 23 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 17 | 21 => 2
  | 25 => 3
  | _ => 0

def action78 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 1 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 0 5) (.sequence 2 3) 17)
  | 1 => .win 0 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 0 5) (.sequence 2 3) 17)
  | 2 => .win 2 (FullWinWitness.standard (.triplet 2) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 3 => .win 1 (FullWinWitness.standard (.triplet 25) (.sequence 0 1) (.sequence 0 5) (.sequence 2 3) 17)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 25) (.sequence 0 2) (.sequence 0 5) (.sequence 2 3) 17)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 25) (.sequence 0 6) (.sequence 2 3) 17)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 4) (.sequence 0 6) (.sequence 2 3) 17)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 0 6) (.sequence 2 3) 17)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 9 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 0) (.sequence 2 3) 17)
  | 10 => .win 10 (FullWinWitness.standard (.triplet 10) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 11 => .win 9 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 0) (.sequence 2 3) 17)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 1) (.sequence 2 3) 17)
  | 13 => .win 13 (FullWinWitness.standard (.triplet 13) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 14 => .win 12 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 17)
  | 15 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 2)
  | 16 => .win 16 (FullWinWitness.standard (.triplet 16) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 17 => .win 2 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 2)
  | 18 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 18)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 21 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 21)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 2) (.sequence 2 3) 17)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 24 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 4) 21)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 6) 17)
  | 26 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 26)
  | 27 => .back 28 14 [.swapHonors 0 1]
  | 28 => .back 27 14 []
  | 29 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 29)
  | 30 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 30)
  | 31 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row78 : Row := ⟨78, state78, 78, action78⟩

def state79 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 13 | 14 | 15 | 19 | 20 | 24 | 27 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 16 | 18 | 22 | 23 | 26 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 17 | 21 => 2
  | 25 => 3
  | _ => 0

def action79 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 1 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 0 5) (.sequence 2 3) 17)
  | 1 => .win 0 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 0 5) (.sequence 2 3) 17)
  | 2 => .win 2 (FullWinWitness.standard (.triplet 2) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 3 => .win 1 (FullWinWitness.standard (.triplet 25) (.sequence 0 1) (.sequence 0 5) (.sequence 2 3) 17)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 25) (.sequence 0 2) (.sequence 0 5) (.sequence 2 3) 17)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 25) (.sequence 0 6) (.sequence 2 3) 17)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 4) (.sequence 0 6) (.sequence 2 3) 17)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 0 6) (.sequence 2 3) 17)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 9 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 0) (.sequence 2 3) 17)
  | 10 => .win 10 (FullWinWitness.standard (.triplet 10) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 11 => .win 9 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 0) (.sequence 2 3) 17)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 1) (.sequence 2 3) 17)
  | 13 => .back 27 14 []
  | 14 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 5) (.sequence 2 3) 17)
  | 15 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 2)
  | 16 => .win 16 (FullWinWitness.standard (.triplet 16) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 17 => .win 2 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 2)
  | 18 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 18)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 21 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 21)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 2) (.sequence 2 3) 17)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 24 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 4) 21)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 6) 17)
  | 26 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 26)
  | 27 => .back 13 14 []
  | 28 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 28)
  | 29 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 29)
  | 30 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 30)
  | 31 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row79 : Row := ⟨79, state79, 79, action79⟩

def state80 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 19 | 20 | 24 | 27 | 28 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 13 | 16 | 18 | 21 | 22 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 17 | 23 => 2
  | 25 => 3
  | _ => 0

def action80 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 1 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 0 5) (.sequence 2 3) 17)
  | 1 => .win 0 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 0 5) (.sequence 2 3) 17)
  | 2 => .win 2 (FullWinWitness.standard (.triplet 2) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 3 => .win 1 (FullWinWitness.standard (.triplet 25) (.sequence 0 1) (.sequence 0 5) (.sequence 2 3) 17)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 25) (.sequence 0 2) (.sequence 0 5) (.sequence 2 3) 17)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 25) (.sequence 0 6) (.sequence 2 3) 17)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 4) (.sequence 0 6) (.sequence 2 3) 17)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 0 6) (.sequence 2 3) 17)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 9 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 0) (.sequence 2 3) 17)
  | 10 => .win 10 (FullWinWitness.standard (.triplet 10) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 11 => .win 9 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 0) (.sequence 2 3) 17)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 1) (.sequence 2 3) 17)
  | 13 => .win 13 (FullWinWitness.standard (.triplet 13) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 14 => .win 12 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 17)
  | 15 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 2)
  | 16 => .win 16 (FullWinWitness.standard (.triplet 16) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 17 => .win 2 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 2)
  | 18 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 18)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 20 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 2) 23)
  | 21 => .win 22 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 23 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 23)
  | 24 => .win 15 (FullWinWitness.standard (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) (.sequence 2 5) 25)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 5) 17)
  | 26 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 26)
  | 27 => .back 28 15 [.swapHonors 0 1]
  | 28 => .back 27 15 []
  | 29 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 29)
  | 30 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 30)
  | 31 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row80 : Row := ⟨80, state80, 80, action80⟩

def state81 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 18 | 20 | 24 | 27 | 28 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 13 | 16 | 19 | 21 | 22 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 17 | 23 => 2
  | 25 => 3
  | _ => 0

def action81 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 1 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 0 5) (.sequence 2 3) 17)
  | 1 => .win 0 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 0 5) (.sequence 2 3) 17)
  | 2 => .win 2 (FullWinWitness.standard (.triplet 2) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 3 => .win 1 (FullWinWitness.standard (.triplet 25) (.sequence 0 1) (.sequence 0 5) (.sequence 2 3) 17)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 25) (.sequence 0 2) (.sequence 0 5) (.sequence 2 3) 17)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 25) (.sequence 0 6) (.sequence 2 3) 17)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 4) (.sequence 0 6) (.sequence 2 3) 17)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 0 6) (.sequence 2 3) 17)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 9 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 0) (.sequence 2 3) 17)
  | 10 => .win 10 (FullWinWitness.standard (.triplet 10) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 11 => .win 9 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 0) (.sequence 2 3) 17)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 1) (.sequence 2 3) 17)
  | 13 => .win 13 (FullWinWitness.standard (.triplet 13) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 14 => .win 12 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 17)
  | 15 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 2)
  | 16 => .win 16 (FullWinWitness.standard (.triplet 16) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 17 => .win 2 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 2)
  | 18 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 19 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 19)
  | 20 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 1) 23)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 1) (.sequence 2 3) 17)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 23 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 23)
  | 24 => .win 15 (FullWinWitness.standard (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) (.sequence 2 5) 25)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 5) 17)
  | 26 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 26)
  | 27 => .back 28 16 [.swapHonors 0 1]
  | 28 => .back 27 16 []
  | 29 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 29)
  | 30 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 30)
  | 31 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row81 : Row := ⟨81, state81, 81, action81⟩

def state82 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 18 | 20 | 24 | 27 | 28 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 13 | 16 | 19 | 21 | 23 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 17 | 22 => 2
  | 25 => 3
  | _ => 0

def action82 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 1 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 0 5) (.sequence 2 3) 17)
  | 1 => .win 0 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 0 5) (.sequence 2 3) 17)
  | 2 => .win 2 (FullWinWitness.standard (.triplet 2) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 3 => .win 1 (FullWinWitness.standard (.triplet 25) (.sequence 0 1) (.sequence 0 5) (.sequence 2 3) 17)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 25) (.sequence 0 2) (.sequence 0 5) (.sequence 2 3) 17)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 25) (.sequence 0 6) (.sequence 2 3) 17)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 4) (.sequence 0 6) (.sequence 2 3) 17)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 0 6) (.sequence 2 3) 17)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 9 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 0) (.sequence 2 3) 17)
  | 10 => .win 10 (FullWinWitness.standard (.triplet 10) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 11 => .win 9 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 0) (.sequence 2 3) 17)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 1) (.sequence 2 3) 17)
  | 13 => .win 13 (FullWinWitness.standard (.triplet 13) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 14 => .win 12 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 17)
  | 15 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 2)
  | 16 => .win 16 (FullWinWitness.standard (.triplet 16) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 17 => .win 2 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 2)
  | 18 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 19 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 19)
  | 20 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 1) 22)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 1) (.sequence 2 3) 17)
  | 22 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 22)
  | 23 => .win 21 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 24 => .win 15 (FullWinWitness.standard (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) (.sequence 2 6) 25)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 6) 17)
  | 26 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 26)
  | 27 => .back 28 17 [.swapHonors 0 1]
  | 28 => .back 27 17 []
  | 29 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 29)
  | 30 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 30)
  | 31 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row82 : Row := ⟨82, state82, 82, action82⟩

def state83 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 10 | 15 | 18 | 20 | 21 | 22 | 23 | 25 => 0
  | 2 | 5 | 6 | 7 | 8 | 11 | 12 | 13 | 14 | 17 | 19 | 24 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 16 => 3
  | 26 => 2
  | _ => 0

def action83 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 1 (FullWinWitness.standard (.triplet 16) (.sequence 0 0) (.sequence 0 5) (.sequence 1 2) 26)
  | 1 => .win 0 (FullWinWitness.standard (.triplet 16) (.sequence 0 0) (.sequence 0 5) (.sequence 1 2) 26)
  | 2 => .win 2 (FullWinWitness.standard (.triplet 2) (.triplet 16) (.sequence 0 5) (.sequence 1 2) 26)
  | 3 => .win 1 (FullWinWitness.standard (.triplet 16) (.sequence 0 1) (.sequence 0 5) (.sequence 1 2) 26)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 16) (.sequence 0 2) (.sequence 0 5) (.sequence 1 2) 26)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 16) (.sequence 0 6) (.sequence 1 2) 26)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 16) (.sequence 0 4) (.sequence 0 6) (.sequence 1 2) 26)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 0 6) (.sequence 1 2) 26)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 0 5) (.sequence 1 2) 26)
  | 9 => .win 10 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 0) (.sequence 1 3) 26)
  | 10 => .win 9 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 0) (.sequence 1 3) 26)
  | 11 => .win 11 (FullWinWitness.standard (.triplet 11) (.triplet 16) (.sequence 0 5) (.sequence 1 3) 26)
  | 12 => .win 10 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 1) (.sequence 1 3) 26)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 2) (.sequence 1 3) 26)
  | 14 => .win 14 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 5) (.sequence 1 2) 26)
  | 15 => .win 10 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 1) (.sequence 1 4) 26)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 2) (.sequence 1 5) 26)
  | 17 => .win 17 (FullWinWitness.standard (.triplet 16) (.triplet 17) (.sequence 0 5) (.sequence 1 2) 26)
  | 18 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 2) (.sequence 2 0) 26)
  | 19 => .win 19 (FullWinWitness.standard (.triplet 16) (.triplet 19) (.sequence 0 5) (.sequence 1 2) 26)
  | 20 => .win 18 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 2) (.sequence 2 0) 26)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 2) (.sequence 2 1) 26)
  | 22 => .win 23 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 2) (.sequence 2 4) 26)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 2) (.sequence 2 4) 26)
  | 24 => .win 24 (FullWinWitness.standard (.triplet 16) (.triplet 24) (.sequence 0 5) (.sequence 1 2) 26)
  | 25 => .win 2 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 2) (.sequence 2 6) 2)
  | 26 => .win 2 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 5) (.sequence 1 2) 2)
  | 27 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 2) (.sequence 2 6) 27)
  | 28 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 2) (.sequence 2 6) 28)
  | 29 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 2) (.sequence 2 6) 29)
  | 30 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 2) (.sequence 2 6) 30)
  | 31 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 2) (.sequence 2 6) 31)
  | 32 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 2) (.sequence 2 6) 32)
  | 33 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 2) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row83 : Row := ⟨83, state83, 83, action83⟩

def state84 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 6 | 9 | 10 | 12 | 13 | 18 | 20 | 21 | 22 | 23 | 24 => 0
  | 3 | 4 | 8 | 11 | 14 | 15 | 16 | 17 | 19 | 25 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 5 | 26 => 2
  | 7 => 3
  | _ => 0

def action84 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 22 15 [.swapSuits 0 2, .swapSuits 1 2]
  | 1 => .back 22 16 [.swapSuits 0 2, .swapSuits 1 2]
  | 2 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 2) (.sequence 1 5) 26)
  | 3 => .win 4 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 0 3) (.sequence 1 5) 26)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 0 3) (.sequence 1 5) 26)
  | 5 => .win 2 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 2) (.sequence 1 5) 26)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 0 4) (.sequence 1 5) 26)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 0 5) (.sequence 1 5) 26)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 7) (.triplet 8) (.sequence 0 3) (.sequence 1 5) 26)
  | 9 => .win 10 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 0) (.sequence 1 5) 26)
  | 10 => .win 9 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 0) (.sequence 1 5) 26)
  | 11 => .win 11 (FullWinWitness.standard (.triplet 7) (.triplet 11) (.sequence 0 3) (.sequence 1 5) 26)
  | 12 => .win 10 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 1) (.sequence 1 5) 26)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 2) (.sequence 1 5) 26)
  | 14 => .win 14 (FullWinWitness.standard (.triplet 7) (.triplet 14) (.sequence 0 3) (.sequence 1 6) 26)
  | 15 => .win 13 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 4) (.sequence 1 6) 26)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 1 6) 26)
  | 17 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 3) (.sequence 1 5) 26)
  | 18 => .win 20 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 0) 26)
  | 19 => .win 19 (FullWinWitness.standard (.triplet 7) (.triplet 19) (.sequence 0 3) (.sequence 1 5) 26)
  | 20 => .win 18 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 0) 26)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 1) 26)
  | 22 => .back 0 15 [.swapSuits 0 2, .swapSuits 1 2]
  | 23 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 5) 26)
  | 24 => .win 2 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 5) (.sequence 2 6) 5)
  | 25 => .win 25 (FullWinWitness.standard (.triplet 7) (.triplet 25) (.sequence 0 3) (.sequence 1 5) 26)
  | 26 => .win 2 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 2) (.sequence 1 5) 5)
  | 27 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 27)
  | 28 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 28)
  | 29 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 29)
  | 30 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 30)
  | 31 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row84 : Row := ⟨84, state84, 84, action84⟩

def state85 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 10 | 15 | 18 | 20 | 21 | 22 | 24 | 25 => 0
  | 2 | 5 | 6 | 7 | 8 | 11 | 12 | 13 | 14 | 17 | 19 | 23 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 16 => 3
  | 26 => 2
  | _ => 0

def action85 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 1 (FullWinWitness.standard (.triplet 16) (.sequence 0 0) (.sequence 0 5) (.sequence 1 2) 26)
  | 1 => .win 0 (FullWinWitness.standard (.triplet 16) (.sequence 0 0) (.sequence 0 5) (.sequence 1 2) 26)
  | 2 => .win 2 (FullWinWitness.standard (.triplet 2) (.triplet 16) (.sequence 0 5) (.sequence 1 2) 26)
  | 3 => .win 1 (FullWinWitness.standard (.triplet 16) (.sequence 0 1) (.sequence 0 5) (.sequence 1 2) 26)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 16) (.sequence 0 2) (.sequence 0 5) (.sequence 1 2) 26)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 16) (.sequence 0 6) (.sequence 1 2) 26)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 16) (.sequence 0 4) (.sequence 0 6) (.sequence 1 2) 26)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 0 6) (.sequence 1 2) 26)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 0 5) (.sequence 1 2) 26)
  | 9 => .win 10 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 0) (.sequence 1 3) 26)
  | 10 => .win 9 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 0) (.sequence 1 3) 26)
  | 11 => .win 11 (FullWinWitness.standard (.triplet 11) (.triplet 16) (.sequence 0 5) (.sequence 1 3) 26)
  | 12 => .win 10 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 1) (.sequence 1 3) 26)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 2) (.sequence 1 3) 26)
  | 14 => .win 14 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 5) (.sequence 1 2) 26)
  | 15 => .win 10 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 1) (.sequence 1 4) 26)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 2) (.sequence 1 5) 26)
  | 17 => .win 17 (FullWinWitness.standard (.triplet 16) (.triplet 17) (.sequence 0 5) (.sequence 1 2) 26)
  | 18 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 2) (.sequence 2 0) 26)
  | 19 => .win 19 (FullWinWitness.standard (.triplet 16) (.triplet 19) (.sequence 0 5) (.sequence 1 2) 26)
  | 20 => .win 18 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 2) (.sequence 2 0) 26)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 2) (.sequence 2 1) 26)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 2) (.sequence 2 3) 26)
  | 23 => .win 23 (FullWinWitness.standard (.triplet 16) (.triplet 23) (.sequence 0 5) (.sequence 1 2) 26)
  | 24 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 2) (.sequence 2 4) 26)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 2) (.sequence 2 5) 26)
  | 26 => .win 2 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 5) (.sequence 1 2) 2)
  | 27 => .win 26 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 5) (.sequence 1 2) 27)
  | 28 => .win 26 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 5) (.sequence 1 2) 28)
  | 29 => .win 26 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 5) (.sequence 1 2) 29)
  | 30 => .win 26 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 5) (.sequence 1 2) 30)
  | 31 => .win 26 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 5) (.sequence 1 2) 31)
  | 32 => .win 26 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 5) (.sequence 1 2) 32)
  | 33 => .win 26 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 5) (.sequence 1 2) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row85 : Row := ⟨85, state85, 85, action85⟩

def state86 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 13 | 14 | 15 | 18 | 20 | 24 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 16 | 19 | 21 | 22 | 23 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 17 => 2
  | 25 => 3
  | _ => 0

def action86 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 1 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 0 5) (.sequence 2 3) 17)
  | 1 => .win 0 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 0 5) (.sequence 2 3) 17)
  | 2 => .win 2 (FullWinWitness.standard (.triplet 2) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 3 => .win 1 (FullWinWitness.standard (.triplet 25) (.sequence 0 1) (.sequence 0 5) (.sequence 2 3) 17)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 25) (.sequence 0 2) (.sequence 0 5) (.sequence 2 3) 17)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 25) (.sequence 0 6) (.sequence 2 3) 17)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 4) (.sequence 0 6) (.sequence 2 3) 17)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 0 6) (.sequence 2 3) 17)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 9 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 0) (.sequence 2 3) 17)
  | 10 => .win 10 (FullWinWitness.standard (.triplet 10) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 11 => .win 9 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 0) (.sequence 2 3) 17)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 1) (.sequence 2 3) 17)
  | 13 => .back 22 17 []
  | 14 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 5) (.sequence 2 3) 17)
  | 15 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 2)
  | 16 => .win 16 (FullWinWitness.standard (.triplet 16) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 17 => .win 2 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 2)
  | 18 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 19 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 19)
  | 20 => .win 18 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 1) (.sequence 2 3) 17)
  | 22 => .back 13 17 []
  | 23 => .back 13 16 []
  | 24 => .win 15 (FullWinWitness.standard (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) (.sequence 2 6) 25)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 6) 17)
  | 26 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 26)
  | 27 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 27)
  | 28 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 28)
  | 29 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 29)
  | 30 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 30)
  | 31 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row86 : Row := ⟨86, state86, 86, action86⟩

def state87 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 6 | 9 | 10 | 12 | 13 | 18 | 20 | 21 | 23 | 24 | 25 => 0
  | 3 | 5 | 8 | 11 | 14 | 15 | 16 | 17 | 19 | 22 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 4 | 26 => 2
  | 7 => 3
  | _ => 0

def action87 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 25 13 [.swapSuits 0 2, .swapSuits 1 2]
  | 1 => .back 25 17 [.swapSuits 0 2, .swapSuits 1 2]
  | 2 => .win 3 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 0 3) (.sequence 1 5) 26)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 0 3) (.sequence 1 5) 26)
  | 4 => .win 4 (FullWinWitness.standard (.triplet 4) (.triplet 7) (.sequence 0 3) (.sequence 1 5) 26)
  | 5 => .win 3 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 0 3) (.sequence 1 5) 26)
  | 6 => .win 2 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 0 4) (.sequence 1 5) 26)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 0 6) (.sequence 1 5) 26)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 7) (.triplet 8) (.sequence 0 3) (.sequence 1 5) 26)
  | 9 => .win 10 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 0) (.sequence 1 5) 26)
  | 10 => .win 9 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 0) (.sequence 1 5) 26)
  | 11 => .win 11 (FullWinWitness.standard (.triplet 7) (.triplet 11) (.sequence 0 3) (.sequence 1 5) 26)
  | 12 => .win 10 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 1) (.sequence 1 5) 26)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 2) (.sequence 1 5) 26)
  | 14 => .win 14 (FullWinWitness.standard (.triplet 7) (.triplet 14) (.sequence 0 3) (.sequence 1 6) 26)
  | 15 => .win 13 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 4) (.sequence 1 6) 26)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 1 6) 26)
  | 17 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 3) (.sequence 1 5) 26)
  | 18 => .win 20 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 0) 26)
  | 19 => .win 19 (FullWinWitness.standard (.triplet 7) (.triplet 19) (.sequence 0 3) (.sequence 1 5) 26)
  | 20 => .win 18 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 0) 26)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 1) 26)
  | 22 => .win 22 (FullWinWitness.standard (.triplet 7) (.triplet 22) (.sequence 0 3) (.sequence 1 5) 26)
  | 23 => .win 21 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 3) 26)
  | 24 => .win 23 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 4) 26)
  | 25 => .back 0 13 [.swapSuits 0 2, .swapSuits 1 2]
  | 26 => .win 4 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 4)
  | 27 => .win 26 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 27)
  | 28 => .win 26 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 28)
  | 29 => .win 26 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 29)
  | 30 => .win 26 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 30)
  | 31 => .win 26 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 31)
  | 32 => .win 26 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 32)
  | 33 => .win 26 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row87 : Row := ⟨87, state87, 87, action87⟩

def state88 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 13 | 14 | 15 | 19 | 20 | 24 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 16 | 18 | 21 | 22 | 23 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 17 => 2
  | 25 => 3
  | _ => 0

def action88 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 1 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 0 5) (.sequence 2 3) 17)
  | 1 => .win 0 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 0 5) (.sequence 2 3) 17)
  | 2 => .win 2 (FullWinWitness.standard (.triplet 2) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 3 => .win 1 (FullWinWitness.standard (.triplet 25) (.sequence 0 1) (.sequence 0 5) (.sequence 2 3) 17)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 25) (.sequence 0 2) (.sequence 0 5) (.sequence 2 3) 17)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 25) (.sequence 0 6) (.sequence 2 3) 17)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 4) (.sequence 0 6) (.sequence 2 3) 17)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 0 6) (.sequence 2 3) 17)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 9 => .win 0 (FullWinWitness.orphans 17)
  | 10 => .win 10 (FullWinWitness.standard (.triplet 10) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 11 => .win 9 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 0) (.sequence 2 3) 17)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 1) (.sequence 2 3) 17)
  | 13 => .back 22 13 []
  | 14 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 5) (.sequence 2 3) 17)
  | 15 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 2)
  | 16 => .win 16 (FullWinWitness.standard (.triplet 16) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 17 => .win 2 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 2)
  | 18 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 18)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 21 => .back 13 14 []
  | 22 => .back 13 13 []
  | 23 => .back 13 15 []
  | 24 => .win 15 (FullWinWitness.standard (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) (.sequence 2 6) 25)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 6) 17)
  | 26 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 26)
  | 27 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 27)
  | 28 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 28)
  | 29 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 29)
  | 30 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 30)
  | 31 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row88 : Row := ⟨88, state88, 88, action88⟩

def state89 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 6 | 9 | 10 | 12 | 13 | 18 | 20 | 21 | 22 | 23 | 24 => 0
  | 3 | 26 => 2
  | 4 | 5 | 8 | 11 | 14 | 15 | 16 | 17 | 19 | 25 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 7 => 3
  | _ => 0

def action89 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 22 14 [.swapSuits 0 2, .swapSuits 1 2]
  | 1 => .win 2 (FullWinWitness.standard (.triplet 7) (.sequence 0 1) (.sequence 0 3) (.sequence 1 5) 26)
  | 2 => .win 1 (FullWinWitness.standard (.triplet 7) (.sequence 0 1) (.sequence 0 3) (.sequence 1 5) 26)
  | 3 => .win 3 (FullWinWitness.standard (.triplet 3) (.triplet 7) (.sequence 0 3) (.sequence 1 5) 26)
  | 4 => .win 2 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 0 3) (.sequence 1 5) 26)
  | 5 => .win 4 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 0 3) (.sequence 1 5) 26)
  | 6 => .win 3 (FullWinWitness.standard (.triplet 3) (.triplet 7) (.sequence 0 4) (.sequence 1 5) 26)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 0 6) (.sequence 1 5) 26)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 7) (.triplet 8) (.sequence 0 3) (.sequence 1 5) 26)
  | 9 => .win 10 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 0) (.sequence 1 5) 26)
  | 10 => .win 9 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 0) (.sequence 1 5) 26)
  | 11 => .win 11 (FullWinWitness.standard (.triplet 7) (.triplet 11) (.sequence 0 3) (.sequence 1 5) 26)
  | 12 => .win 10 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 1) (.sequence 1 5) 26)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 2) (.sequence 1 5) 26)
  | 14 => .win 14 (FullWinWitness.standard (.triplet 7) (.triplet 14) (.sequence 0 3) (.sequence 1 6) 26)
  | 15 => .win 13 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 4) (.sequence 1 6) 26)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 1 6) 26)
  | 17 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 3) (.sequence 1 5) 26)
  | 18 => .win 20 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 0) 26)
  | 19 => .win 19 (FullWinWitness.standard (.triplet 7) (.triplet 19) (.sequence 0 3) (.sequence 1 5) 26)
  | 20 => .win 18 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 0) 26)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 1) 26)
  | 22 => .back 0 14 [.swapSuits 0 2, .swapSuits 1 2]
  | 23 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 5) 26)
  | 24 => .win 3 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 3)
  | 25 => .win 25 (FullWinWitness.standard (.triplet 7) (.triplet 25) (.sequence 0 3) (.sequence 1 5) 26)
  | 26 => .win 3 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 3)
  | 27 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 27)
  | 28 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 28)
  | 29 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 29)
  | 30 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 30)
  | 31 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row89 : Row := ⟨89, state89, 89, action89⟩

def state90 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 5 | 7 | 10 | 11 | 12 | 13 | 19 | 20 | 24 | 27 => 0
  | 1 | 6 | 9 | 14 | 15 | 16 | 17 | 18 | 22 | 23 | 26 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 8 | 21 => 2
  | 25 => 3
  | _ => 0

def action90 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 1 => .win 1 (FullWinWitness.standard (.triplet 1) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 8)
  | 2 => .win 0 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 4 => .win 5 (FullWinWitness.standard (.triplet 25) (.sequence 0 4) (.sequence 1 5) (.sequence 2 3) 8)
  | 5 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 4) (.sequence 1 5) (.sequence 2 3) 8)
  | 6 => .win 6 (FullWinWitness.standard (.triplet 6) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 8)
  | 7 => .win 1 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 1)
  | 8 => .win 1 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 1)
  | 9 => .win 7 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 9)
  | 10 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 1 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 11 => .win 10 (FullWinWitness.standard (.triplet 25) (.sequence 1 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 12 => .win 13 (FullWinWitness.standard (.triplet 25) (.sequence 1 3) (.sequence 1 6) (.sequence 2 3) 8)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 25) (.sequence 1 3) (.sequence 1 6) (.sequence 2 3) 8)
  | 14 => .win 7 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 6) (.sequence 2 3) 14)
  | 15 => .win 13 (FullWinWitness.standard (.triplet 25) (.sequence 1 4) (.sequence 1 6) (.sequence 2 3) 8)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 1 6) (.sequence 2 3) 8)
  | 17 => .win 7 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 17)
  | 18 => .win 7 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 18)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 0) (.sequence 2 3) 8)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 0) (.sequence 2 3) 8)
  | 21 => .win 7 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 21)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 2) (.sequence 2 3) 8)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 3) (.sequence 2 3) 8)
  | 24 => .win 7 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 4) 21)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 3) (.sequence 2 6) 8)
  | 26 => .win 7 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 26)
  | 27 => .win 0 (FullWinWitness.orphans 8)
  | 28 => .win 7 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 28)
  | 29 => .win 7 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 29)
  | 30 => .win 7 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 30)
  | 31 => .win 7 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 31)
  | 32 => .win 7 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 32)
  | 33 => .win 7 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row90 : Row := ⟨90, state90, 90, action90⟩

def state91 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 6 | 7 | 10 | 11 | 12 | 13 | 19 | 20 | 24 | 27 => 0
  | 1 | 5 | 9 | 14 | 15 | 16 | 17 | 18 | 22 | 23 | 26 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 8 | 21 => 2
  | 25 => 3
  | _ => 0

def action91 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 1 => .win 1 (FullWinWitness.standard (.triplet 1) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 8)
  | 2 => .win 0 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 25) (.sequence 0 3) (.sequence 1 5) (.sequence 2 3) 8)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 8)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 4) (.sequence 1 5) (.sequence 2 3) 8)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 5) (.sequence 2 3) 8)
  | 8 => .win 1 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 1)
  | 9 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 9)
  | 10 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 1 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 11 => .win 10 (FullWinWitness.standard (.triplet 25) (.sequence 1 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 12 => .win 13 (FullWinWitness.standard (.triplet 25) (.sequence 1 3) (.sequence 1 6) (.sequence 2 3) 8)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 25) (.sequence 1 3) (.sequence 1 6) (.sequence 2 3) 8)
  | 14 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 1 6) (.sequence 2 3) 14)
  | 15 => .win 13 (FullWinWitness.standard (.triplet 25) (.sequence 1 4) (.sequence 1 6) (.sequence 2 3) 8)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 1 6) (.sequence 2 3) 8)
  | 17 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 17)
  | 18 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 18)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 0) (.sequence 2 3) 8)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 0) (.sequence 2 3) 8)
  | 21 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 21)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 2) (.sequence 2 3) 8)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 3) (.sequence 2 3) 8)
  | 24 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 1 5) (.sequence 2 4) 21)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 3) (.sequence 2 6) 8)
  | 26 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 26)
  | 27 => .win 0 (FullWinWitness.orphans 8)
  | 28 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 28)
  | 29 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 29)
  | 30 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 30)
  | 31 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 31)
  | 32 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 32)
  | 33 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row91 : Row := ⟨91, state91, 91, action91⟩

def state92 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 16 | 19 | 20 | 24 => 0
  | 5 | 6 | 7 | 8 | 10 | 13 | 18 | 22 | 23 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 17 | 21 => 2
  | 25 => 3
  | _ => 0

def action92 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 9 (FullWinWitness.orphans 17)
  | 1 => .back 16 9 []
  | 2 => .back 16 14 []
  | 3 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 3) (.sequence 0 6) (.sequence 2 3) 17)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 25) (.sequence 0 3) (.sequence 0 6) (.sequence 2 3) 17)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 25) (.sequence 0 6) (.sequence 2 3) 17)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 4) (.sequence 0 6) (.sequence 2 3) 17)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 0 6) (.sequence 2 3) 17)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 9 => .win 0 (FullWinWitness.orphans 17)
  | 10 => .win 10 (FullWinWitness.standard (.triplet 10) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 11 => .win 9 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 0) (.sequence 2 3) 17)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 1) (.sequence 2 3) 17)
  | 13 => .win 13 (FullWinWitness.standard (.triplet 13) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 14 => .win 12 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 17)
  | 15 => .win 14 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 4) (.sequence 2 3) 17)
  | 16 => .back 1 9 []
  | 17 => .win 5 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 6) (.sequence 2 3) 5)
  | 18 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 18)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 21 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 21)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 2) (.sequence 2 3) 17)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 24 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 4) 21)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 6) 17)
  | 26 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 26)
  | 27 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 27)
  | 28 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 28)
  | 29 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 29)
  | 30 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 30)
  | 31 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 31)
  | 32 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 32)
  | 33 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row92 : Row := ⟨92, state92, 92, action92⟩

def state93 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 5 | 6 | 9 | 11 | 15 | 19 | 20 | 21 | 22 | 27 | 28 => 0
  | 1 | 4 | 7 | 10 | 12 | 14 | 17 | 18 | 23 | 24 | 25 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 8 | 13 => 2
  | 16 => 3
  | _ => 0

def action93 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 2 (FullWinWitness.standard (.triplet 16) (.sequence 0 0) (.sequence 1 3) (.sequence 2 5) 8)
  | 1 => .win 1 (FullWinWitness.standard (.triplet 1) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 8)
  | 2 => .win 0 (FullWinWitness.standard (.triplet 16) (.sequence 0 0) (.sequence 1 3) (.sequence 2 5) 8)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 16) (.sequence 0 1) (.sequence 1 3) (.sequence 2 5) 8)
  | 4 => .win 4 (FullWinWitness.standard (.triplet 4) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 8)
  | 5 => .win 3 (FullWinWitness.standard (.triplet 16) (.sequence 0 3) (.sequence 1 3) (.sequence 2 5) 8)
  | 6 => .win 1 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 1)
  | 7 => .win 7 (FullWinWitness.standard (.triplet 7) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 8)
  | 8 => .win 1 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 1)
  | 9 => .win 11 (FullWinWitness.standard (.triplet 16) (.sequence 1 0) (.sequence 1 3) (.sequence 2 5) 8)
  | 10 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 10)
  | 11 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 1) (.sequence 2 5) 13)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 16) (.sequence 1 1) (.sequence 1 3) (.sequence 2 5) 8)
  | 13 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 13)
  | 14 => .win 12 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 1 3) (.sequence 2 5) 8)
  | 15 => .win 6 (FullWinWitness.standard (.sequence 0 6) (.sequence 1 3) (.sequence 1 6) (.sequence 2 5) 16)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 1 6) (.sequence 2 5) 8)
  | 17 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 17)
  | 18 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 18)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 0) (.sequence 2 5) 8)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 0) (.sequence 2 5) 8)
  | 21 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 3) (.sequence 2 6) 8)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 3) (.sequence 2 6) 8)
  | 23 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 6) 23)
  | 24 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 4) (.sequence 2 6) 8)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 5) (.sequence 2 6) 8)
  | 26 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 26)
  | 27 => .back 28 18 [.swapHonors 0 1]
  | 28 => .back 27 18 []
  | 29 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 29)
  | 30 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 30)
  | 31 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row93 : Row := ⟨93, state93, 93, action93⟩

def state94 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 6 | 9 | 11 | 12 | 13 | 14 | 16 | 19 | 20 | 21 | 22 => 0
  | 2 | 3 | 4 | 5 | 8 | 10 | 15 | 18 | 23 | 24 | 25 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 7 => 3
  | 17 => 2
  | _ => 0

def action94 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 1 (FullWinWitness.standard (.triplet 7) (.sequence 0 0) (.sequence 0 3) (.sequence 2 5) 17)
  | 1 => .win 0 (FullWinWitness.standard (.triplet 7) (.sequence 0 0) (.sequence 0 3) (.sequence 2 5) 17)
  | 2 => .win 2 (FullWinWitness.standard (.triplet 2) (.triplet 7) (.sequence 0 3) (.sequence 2 5) 17)
  | 3 => .win 1 (FullWinWitness.standard (.triplet 7) (.sequence 0 1) (.sequence 0 3) (.sequence 2 5) 17)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 0 3) (.sequence 2 5) 17)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 2) (.sequence 2 5) 17)
  | 6 => .win 1 (FullWinWitness.standard (.triplet 7) (.sequence 0 1) (.sequence 0 4) (.sequence 2 5) 17)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 0 5) (.sequence 2 5) 17)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 7) (.triplet 8) (.sequence 0 2) (.sequence 2 5) 17)
  | 9 => .win 0 (FullWinWitness.orphans 17)
  | 10 => .win 10 (FullWinWitness.standard (.triplet 7) (.triplet 10) (.sequence 0 2) (.sequence 2 5) 17)
  | 11 => .win 9 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 0) (.sequence 2 5) 17)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 1) (.sequence 2 5) 17)
  | 13 => .win 14 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 4) (.sequence 2 5) 17)
  | 14 => .win 13 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 4) (.sequence 2 5) 17)
  | 15 => .win 15 (FullWinWitness.standard (.triplet 7) (.triplet 15) (.sequence 0 2) (.sequence 2 5) 17)
  | 16 => .win 2 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 6) (.sequence 2 5) 2)
  | 17 => .win 2 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 3) (.sequence 2 5) 2)
  | 18 => .win 16 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 6) (.sequence 2 5) 18)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 2 0) (.sequence 2 5) 17)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 2 0) (.sequence 2 5) 17)
  | 21 => .win 22 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 2 3) (.sequence 2 6) 17)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 2 3) (.sequence 2 6) 17)
  | 23 => .win 16 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 6) (.sequence 2 6) 23)
  | 24 => .win 22 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 2 4) (.sequence 2 6) 17)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 2 5) (.sequence 2 6) 17)
  | 26 => .win 16 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 6) (.sequence 2 5) 26)
  | 27 => .win 16 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 6) (.sequence 2 5) 27)
  | 28 => .win 16 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 6) (.sequence 2 5) 28)
  | 29 => .win 16 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 6) (.sequence 2 5) 29)
  | 30 => .win 16 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 6) (.sequence 2 5) 30)
  | 31 => .win 16 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 6) (.sequence 2 5) 31)
  | 32 => .win 16 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 6) (.sequence 2 5) 32)
  | 33 => .win 16 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 6) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row94 : Row := ⟨94, state94, 94, action94⟩

def state95 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 6 | 9 | 11 | 12 | 13 | 15 | 16 | 19 | 20 | 21 | 22 => 0
  | 2 | 3 | 4 | 5 | 8 | 10 | 14 | 18 | 23 | 24 | 25 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 7 => 3
  | 17 => 2
  | _ => 0

def action95 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 1 (FullWinWitness.standard (.triplet 7) (.sequence 0 0) (.sequence 0 3) (.sequence 2 5) 17)
  | 1 => .win 0 (FullWinWitness.standard (.triplet 7) (.sequence 0 0) (.sequence 0 3) (.sequence 2 5) 17)
  | 2 => .win 2 (FullWinWitness.standard (.triplet 2) (.triplet 7) (.sequence 0 3) (.sequence 2 5) 17)
  | 3 => .win 1 (FullWinWitness.standard (.triplet 7) (.sequence 0 1) (.sequence 0 3) (.sequence 2 5) 17)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 0 3) (.sequence 2 5) 17)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 2) (.sequence 2 5) 17)
  | 6 => .win 1 (FullWinWitness.standard (.triplet 7) (.sequence 0 1) (.sequence 0 4) (.sequence 2 5) 17)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 0 5) (.sequence 2 5) 17)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 7) (.triplet 8) (.sequence 0 2) (.sequence 2 5) 17)
  | 9 => .win 0 (FullWinWitness.orphans 17)
  | 10 => .win 10 (FullWinWitness.standard (.triplet 7) (.triplet 10) (.sequence 0 2) (.sequence 2 5) 17)
  | 11 => .win 9 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 0) (.sequence 2 5) 17)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 1) (.sequence 2 5) 17)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 3) (.sequence 2 5) 17)
  | 14 => .win 14 (FullWinWitness.standard (.triplet 7) (.triplet 14) (.sequence 0 2) (.sequence 2 5) 17)
  | 15 => .win 13 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 4) (.sequence 2 5) 17)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 5) (.sequence 2 5) 17)
  | 17 => .win 2 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 3) (.sequence 2 5) 2)
  | 18 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 2) (.sequence 2 5) 18)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 2 0) (.sequence 2 5) 17)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 2 0) (.sequence 2 5) 17)
  | 21 => .win 22 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 2 3) (.sequence 2 6) 17)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 2 3) (.sequence 2 6) 17)
  | 23 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 2) (.sequence 2 6) 23)
  | 24 => .win 22 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 2 4) (.sequence 2 6) 17)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 2 5) (.sequence 2 6) 17)
  | 26 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 2) (.sequence 2 5) 26)
  | 27 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 2) (.sequence 2 5) 27)
  | 28 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 2) (.sequence 2 5) 28)
  | 29 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 2) (.sequence 2 5) 29)
  | 30 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 2) (.sequence 2 5) 30)
  | 31 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 2) (.sequence 2 5) 31)
  | 32 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 2) (.sequence 2 5) 32)
  | 33 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 2) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row95 : Row := ⟨95, state95, 95, action95⟩

def state96 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 6 | 7 | 9 | 10 | 15 | 19 | 20 | 21 | 22 => 0
  | 2 | 5 | 11 | 12 | 13 | 14 | 17 | 18 | 23 | 24 | 25 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 8 => 2
  | 16 => 3
  | _ => 0

def action96 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 1 (FullWinWitness.standard (.triplet 16) (.sequence 0 0) (.sequence 1 2) (.sequence 2 5) 8)
  | 1 => .win 0 (FullWinWitness.standard (.triplet 16) (.sequence 0 0) (.sequence 1 2) (.sequence 2 5) 8)
  | 2 => .win 2 (FullWinWitness.standard (.triplet 2) (.triplet 16) (.sequence 1 2) (.sequence 2 5) 8)
  | 3 => .win 1 (FullWinWitness.standard (.triplet 16) (.sequence 0 1) (.sequence 1 2) (.sequence 2 5) 8)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 16) (.sequence 0 2) (.sequence 1 2) (.sequence 2 5) 8)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 16) (.sequence 1 2) (.sequence 2 5) 8)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 16) (.sequence 0 4) (.sequence 1 2) (.sequence 2 5) 8)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 2) (.sequence 2 5) 8)
  | 8 => .win 2 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 2) (.sequence 2 5) 2)
  | 9 => .win 0 (FullWinWitness.orphans 8)
  | 10 => .win 9 (FullWinWitness.standard (.triplet 16) (.sequence 1 0) (.sequence 1 3) (.sequence 2 5) 8)
  | 11 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 11)
  | 12 => .win 10 (FullWinWitness.standard (.triplet 16) (.sequence 1 1) (.sequence 1 3) (.sequence 2 5) 8)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 16) (.sequence 1 2) (.sequence 1 3) (.sequence 2 5) 8)
  | 14 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 2) (.sequence 2 5) 14)
  | 15 => .win 8 (FullWinWitness.standard (.triplet 8) (.sequence 1 2) (.sequence 1 5) (.sequence 2 5) 16)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 16) (.sequence 1 2) (.sequence 1 5) (.sequence 2 5) 8)
  | 17 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 2) (.sequence 2 5) 17)
  | 18 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 2) (.sequence 2 5) 18)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 1 2) (.sequence 2 0) (.sequence 2 5) 8)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 16) (.sequence 1 2) (.sequence 2 0) (.sequence 2 5) 8)
  | 21 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 1 2) (.sequence 2 3) (.sequence 2 6) 8)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 16) (.sequence 1 2) (.sequence 2 3) (.sequence 2 6) 8)
  | 23 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 2) (.sequence 2 6) 23)
  | 24 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 1 2) (.sequence 2 4) (.sequence 2 6) 8)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 1 2) (.sequence 2 5) (.sequence 2 6) 8)
  | 26 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 2) (.sequence 2 5) 26)
  | 27 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 2) (.sequence 2 5) 27)
  | 28 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 2) (.sequence 2 5) 28)
  | 29 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 2) (.sequence 2 5) 29)
  | 30 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 2) (.sequence 2 5) 30)
  | 31 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 2) (.sequence 2 5) 31)
  | 32 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 2) (.sequence 2 5) 32)
  | 33 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 2) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row96 : Row := ⟨96, state96, 96, action96⟩

def state97 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 5 | 7 | 9 | 10 | 15 | 18 | 20 | 21 | 22 => 0
  | 2 | 6 | 11 | 12 | 13 | 14 | 17 | 19 | 23 | 24 | 25 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 8 => 2
  | 16 => 3
  | _ => 0

def action97 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 1 (FullWinWitness.standard (.triplet 16) (.sequence 0 0) (.sequence 1 2) (.sequence 2 5) 8)
  | 1 => .win 0 (FullWinWitness.standard (.triplet 16) (.sequence 0 0) (.sequence 1 2) (.sequence 2 5) 8)
  | 2 => .win 2 (FullWinWitness.standard (.triplet 2) (.triplet 16) (.sequence 1 2) (.sequence 2 5) 8)
  | 3 => .win 1 (FullWinWitness.standard (.triplet 16) (.sequence 0 1) (.sequence 1 2) (.sequence 2 5) 8)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 16) (.sequence 0 2) (.sequence 1 2) (.sequence 2 5) 8)
  | 5 => .win 4 (FullWinWitness.standard (.triplet 16) (.sequence 0 4) (.sequence 1 2) (.sequence 2 5) 8)
  | 6 => .win 6 (FullWinWitness.standard (.triplet 6) (.triplet 16) (.sequence 1 2) (.sequence 2 5) 8)
  | 7 => .win 2 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 2)
  | 8 => .win 2 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 2) (.sequence 2 5) 2)
  | 9 => .win 10 (FullWinWitness.standard (.triplet 16) (.sequence 1 0) (.sequence 1 3) (.sequence 2 5) 8)
  | 10 => .win 9 (FullWinWitness.standard (.triplet 16) (.sequence 1 0) (.sequence 1 3) (.sequence 2 5) 8)
  | 11 => .win 7 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 11)
  | 12 => .win 10 (FullWinWitness.standard (.triplet 16) (.sequence 1 1) (.sequence 1 3) (.sequence 2 5) 8)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 16) (.sequence 1 2) (.sequence 1 3) (.sequence 2 5) 8)
  | 14 => .win 7 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 14)
  | 15 => .win 7 (FullWinWitness.standard (.sequence 0 6) (.sequence 1 2) (.sequence 1 5) (.sequence 2 5) 16)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 16) (.sequence 1 2) (.sequence 1 5) (.sequence 2 5) 8)
  | 17 => .win 7 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 17)
  | 18 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 1 2) (.sequence 2 0) (.sequence 2 5) 8)
  | 19 => .win 7 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 19)
  | 20 => .win 18 (FullWinWitness.standard (.triplet 16) (.sequence 1 2) (.sequence 2 0) (.sequence 2 5) 8)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 1 2) (.sequence 2 1) (.sequence 2 5) 8)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 16) (.sequence 1 2) (.sequence 2 3) (.sequence 2 6) 8)
  | 23 => .win 7 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 6) 23)
  | 24 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 1 2) (.sequence 2 4) (.sequence 2 6) 8)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 1 2) (.sequence 2 5) (.sequence 2 6) 8)
  | 26 => .win 7 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 26)
  | 27 => .win 7 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 27)
  | 28 => .win 7 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 28)
  | 29 => .win 7 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 29)
  | 30 => .win 7 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 30)
  | 31 => .win 7 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 31)
  | 32 => .win 7 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 32)
  | 33 => .win 7 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row97 : Row := ⟨97, state97, 97, action97⟩

def state98 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 5 | 6 | 9 | 10 | 12 | 13 | 18 | 19 | 24 => 0
  | 2 | 7 | 11 | 14 | 15 | 16 | 17 | 20 | 21 | 22 | 23 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 8 => 2
  | 25 => 3
  | _ => 0

def action98 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 1 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 1 5) (.sequence 2 2) 8)
  | 1 => .win 0 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 1 5) (.sequence 2 2) 8)
  | 2 => .win 2 (FullWinWitness.standard (.triplet 2) (.triplet 25) (.sequence 1 5) (.sequence 2 2) 8)
  | 3 => .win 1 (FullWinWitness.standard (.triplet 25) (.sequence 0 1) (.sequence 1 5) (.sequence 2 2) 8)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 25) (.sequence 0 2) (.sequence 1 5) (.sequence 2 2) 8)
  | 5 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 5) (.sequence 2 2) 8)
  | 6 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 2)
  | 7 => .win 7 (FullWinWitness.standard (.triplet 7) (.triplet 25) (.sequence 1 5) (.sequence 2 2) 8)
  | 8 => .win 2 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 1 5) (.sequence 2 2) 2)
  | 9 => .win 10 (FullWinWitness.standard (.triplet 25) (.sequence 1 0) (.sequence 1 5) (.sequence 2 2) 8)
  | 10 => .win 9 (FullWinWitness.standard (.triplet 25) (.sequence 1 0) (.sequence 1 5) (.sequence 2 2) 8)
  | 11 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 11)
  | 12 => .win 10 (FullWinWitness.standard (.triplet 25) (.sequence 1 1) (.sequence 1 5) (.sequence 2 2) 8)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 25) (.sequence 1 2) (.sequence 1 5) (.sequence 2 2) 8)
  | 14 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 6) (.sequence 2 2) 14)
  | 15 => .win 13 (FullWinWitness.standard (.triplet 25) (.sequence 1 4) (.sequence 1 6) (.sequence 2 2) 8)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 1 6) (.sequence 2 2) 8)
  | 17 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 17)
  | 18 => .win 19 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 0) (.sequence 2 3) 8)
  | 19 => .win 18 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 0) (.sequence 2 3) 8)
  | 20 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 20)
  | 21 => .win 19 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 1) (.sequence 2 3) 8)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 2) (.sequence 2 3) 8)
  | 23 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 23)
  | 24 => .win 6 (FullWinWitness.standard (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) (.sequence 2 5) 25)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 2) (.sequence 2 5) 8)
  | 26 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 26)
  | 27 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 27)
  | 28 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 28)
  | 29 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 29)
  | 30 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 30)
  | 31 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row98 : Row := ⟨98, state98, 98, action98⟩

def state99 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 5 | 6 | 9 | 10 | 15 | 19 | 20 | 21 | 22 => 0
  | 2 | 7 | 11 | 12 | 13 | 14 | 17 | 18 | 23 | 24 | 25 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 8 => 2
  | 16 => 3
  | _ => 0

def action99 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 1 (FullWinWitness.standard (.triplet 16) (.sequence 0 0) (.sequence 1 2) (.sequence 2 5) 8)
  | 1 => .win 0 (FullWinWitness.standard (.triplet 16) (.sequence 0 0) (.sequence 1 2) (.sequence 2 5) 8)
  | 2 => .win 2 (FullWinWitness.standard (.triplet 2) (.triplet 16) (.sequence 1 2) (.sequence 2 5) 8)
  | 3 => .win 1 (FullWinWitness.standard (.triplet 16) (.sequence 0 1) (.sequence 1 2) (.sequence 2 5) 8)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 16) (.sequence 0 2) (.sequence 1 2) (.sequence 2 5) 8)
  | 5 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 2) (.sequence 2 5) 8)
  | 6 => .win 2 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 2)
  | 7 => .win 7 (FullWinWitness.standard (.triplet 7) (.triplet 16) (.sequence 1 2) (.sequence 2 5) 8)
  | 8 => .win 2 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 2) (.sequence 2 5) 2)
  | 9 => .win 0 (FullWinWitness.orphans 8)
  | 10 => .win 9 (FullWinWitness.standard (.triplet 16) (.sequence 1 0) (.sequence 1 3) (.sequence 2 5) 8)
  | 11 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 11)
  | 12 => .win 10 (FullWinWitness.standard (.triplet 16) (.sequence 1 1) (.sequence 1 3) (.sequence 2 5) 8)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 16) (.sequence 1 2) (.sequence 1 3) (.sequence 2 5) 8)
  | 14 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 14)
  | 15 => .win 6 (FullWinWitness.standard (.sequence 0 6) (.sequence 1 2) (.sequence 1 5) (.sequence 2 5) 16)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 16) (.sequence 1 2) (.sequence 1 5) (.sequence 2 5) 8)
  | 17 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 17)
  | 18 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 18)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 1 2) (.sequence 2 0) (.sequence 2 5) 8)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 16) (.sequence 1 2) (.sequence 2 0) (.sequence 2 5) 8)
  | 21 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 1 2) (.sequence 2 3) (.sequence 2 6) 8)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 16) (.sequence 1 2) (.sequence 2 3) (.sequence 2 6) 8)
  | 23 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 6) 23)
  | 24 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 1 2) (.sequence 2 4) (.sequence 2 6) 8)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 1 2) (.sequence 2 5) (.sequence 2 6) 8)
  | 26 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 26)
  | 27 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 27)
  | 28 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 28)
  | 29 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 29)
  | 30 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 30)
  | 31 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row99 : Row := ⟨99, state99, 99, action99⟩

def state100 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 5 | 6 | 9 | 10 | 15 | 18 | 20 | 21 | 22 => 0
  | 2 | 7 | 11 | 12 | 13 | 14 | 17 | 19 | 23 | 24 | 25 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 8 => 2
  | 16 => 3
  | _ => 0

def action100 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 1 (FullWinWitness.standard (.triplet 16) (.sequence 0 0) (.sequence 1 2) (.sequence 2 5) 8)
  | 1 => .win 0 (FullWinWitness.standard (.triplet 16) (.sequence 0 0) (.sequence 1 2) (.sequence 2 5) 8)
  | 2 => .win 2 (FullWinWitness.standard (.triplet 2) (.triplet 16) (.sequence 1 2) (.sequence 2 5) 8)
  | 3 => .win 1 (FullWinWitness.standard (.triplet 16) (.sequence 0 1) (.sequence 1 2) (.sequence 2 5) 8)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 16) (.sequence 0 2) (.sequence 1 2) (.sequence 2 5) 8)
  | 5 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 2) (.sequence 2 5) 8)
  | 6 => .win 2 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 2)
  | 7 => .win 7 (FullWinWitness.standard (.triplet 7) (.triplet 16) (.sequence 1 2) (.sequence 2 5) 8)
  | 8 => .win 2 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 2) (.sequence 2 5) 2)
  | 9 => .win 10 (FullWinWitness.standard (.triplet 16) (.sequence 1 0) (.sequence 1 3) (.sequence 2 5) 8)
  | 10 => .win 9 (FullWinWitness.standard (.triplet 16) (.sequence 1 0) (.sequence 1 3) (.sequence 2 5) 8)
  | 11 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 11)
  | 12 => .win 10 (FullWinWitness.standard (.triplet 16) (.sequence 1 1) (.sequence 1 3) (.sequence 2 5) 8)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 16) (.sequence 1 2) (.sequence 1 3) (.sequence 2 5) 8)
  | 14 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 14)
  | 15 => .win 6 (FullWinWitness.standard (.sequence 0 6) (.sequence 1 2) (.sequence 1 5) (.sequence 2 5) 16)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 16) (.sequence 1 2) (.sequence 1 5) (.sequence 2 5) 8)
  | 17 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 17)
  | 18 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 1 2) (.sequence 2 0) (.sequence 2 5) 8)
  | 19 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 19)
  | 20 => .win 18 (FullWinWitness.standard (.triplet 16) (.sequence 1 2) (.sequence 2 0) (.sequence 2 5) 8)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 1 2) (.sequence 2 1) (.sequence 2 5) 8)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 16) (.sequence 1 2) (.sequence 2 3) (.sequence 2 6) 8)
  | 23 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 6) 23)
  | 24 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 1 2) (.sequence 2 4) (.sequence 2 6) 8)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 1 2) (.sequence 2 5) (.sequence 2 6) 8)
  | 26 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 26)
  | 27 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 27)
  | 28 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 28)
  | 29 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 29)
  | 30 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 30)
  | 31 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row100 : Row := ⟨100, state100, 100, action100⟩

def state101 (t : Tile) : Nat :=
  match t.val with
  | 0 | 5 | 6 | 7 | 8 | 9 | 12 | 16 | 18 | 22 | 23 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 1 | 2 | 3 | 4 | 10 | 11 | 13 | 14 | 15 | 19 | 20 | 24 | 27 | 28 => 0
  | 17 | 21 => 2
  | 25 => 3
  | _ => 0

def action101 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 0 (FullWinWitness.standard (.triplet 0) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 1 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 0 5) (.sequence 2 3) 17)
  | 2 => .win 1 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 0 5) (.sequence 2 3) 17)
  | 3 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 3) (.sequence 0 6) (.sequence 2 3) 17)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 25) (.sequence 0 3) (.sequence 0 6) (.sequence 2 3) 17)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 25) (.sequence 0 6) (.sequence 2 3) 17)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 4) (.sequence 0 6) (.sequence 2 3) 17)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 0 6) (.sequence 2 3) 17)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 9 => .win 9 (FullWinWitness.standard (.triplet 9) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 10 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 0) (.sequence 2 3) 17)
  | 11 => .win 10 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 0) (.sequence 2 3) 17)
  | 12 => .win 12 (FullWinWitness.standard (.triplet 12) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 13 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 2) (.sequence 2 3) 17)
  | 14 => .win 13 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 17)
  | 15 => .win 0 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 0)
  | 16 => .win 16 (FullWinWitness.standard (.triplet 16) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 17 => .win 0 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 0)
  | 18 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 18)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 21 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 21)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 2) (.sequence 2 3) 17)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 24 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 4) 21)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 6) 17)
  | 26 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 26)
  | 27 => .win 28 (FullWinWitness.orphans 17)
  | 28 => .win 27 (FullWinWitness.orphans 17)
  | 29 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 29)
  | 30 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 30)
  | 31 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row101 : Row := ⟨101, state101, 101, action101⟩

def state102 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 15 | 16 | 19 | 20 | 22 | 23 | 24 | 27 | 28 => 0
  | 1 | 5 | 6 | 7 | 8 | 12 | 13 | 17 | 18 | 21 | 25 | 29 | 30 | 31 | 32 | 33 => 1
  | 10 => 4
  | 14 | 26 => 2
  | _ => 0

def action102 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 2 (FullWinWitness.standard (.triplet 10) (.sequence 0 0) (.sequence 0 5) (.sequence 1 3) 26)
  | 1 => .win 1 (FullWinWitness.standard (.triplet 1) (.triplet 10) (.sequence 0 5) (.sequence 1 3) 26)
  | 2 => .win 0 (FullWinWitness.standard (.triplet 10) (.sequence 0 0) (.sequence 0 5) (.sequence 1 3) 26)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 10) (.sequence 0 1) (.sequence 0 5) (.sequence 1 3) 26)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 10) (.sequence 0 3) (.sequence 0 6) (.sequence 1 3) 26)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 10) (.sequence 0 6) (.sequence 1 3) 26)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 10) (.sequence 0 4) (.sequence 0 6) (.sequence 1 3) 26)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 0 6) (.sequence 1 3) 26)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 0 5) (.sequence 1 3) 26)
  | 9 => .win 11 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 0) (.sequence 1 3) 26)
  | 11 => .win 9 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 0) (.sequence 1 3) 26)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 1) (.sequence 1 3) 26)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 1 3) 26)
  | 14 => .win 11 (FullWinWitness.standard (.triplet 10) (.triplet 14) (.sequence 0 5) (.sequence 1 1) 26)
  | 15 => .win 11 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 1) (.sequence 1 4) 26)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 1 5) 26)
  | 17 => .win 17 (FullWinWitness.standard (.triplet 10) (.triplet 17) (.sequence 0 5) (.sequence 1 3) 26)
  | 18 => .win 18 (FullWinWitness.standard (.triplet 10) (.triplet 18) (.sequence 0 5) (.sequence 1 3) 26)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 0) 26)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 0) 26)
  | 21 => .win 21 (FullWinWitness.standard (.triplet 10) (.triplet 21) (.sequence 0 5) (.sequence 1 3) 26)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 2) 26)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 26)
  | 24 => .win 1 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 1)
  | 25 => .win 25 (FullWinWitness.standard (.triplet 10) (.triplet 25) (.sequence 0 5) (.sequence 1 3) 26)
  | 26 => .win 1 (FullWinWitness.standard (.triplet 10) (.triplet 26) (.sequence 0 5) (.sequence 1 3) 1)
  | 27 => .back 28 19 [.swapHonors 0 1]
  | 28 => .back 27 19 []
  | 29 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 29)
  | 30 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 30)
  | 31 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row102 : Row := ⟨102, state102, 102, action102⟩

def state103 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 15 | 16 | 19 | 20 | 22 | 23 | 24 | 27 | 28 => 0
  | 2 | 5 | 6 | 7 | 8 | 12 | 13 | 17 | 18 | 21 | 25 | 29 | 30 | 31 | 32 | 33 => 1
  | 10 => 4
  | 14 | 26 => 2
  | _ => 0

def action103 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 1 (FullWinWitness.standard (.triplet 10) (.sequence 0 0) (.sequence 0 5) (.sequence 1 3) 26)
  | 1 => .win 0 (FullWinWitness.standard (.triplet 10) (.sequence 0 0) (.sequence 0 5) (.sequence 1 3) 26)
  | 2 => .win 2 (FullWinWitness.standard (.triplet 2) (.triplet 10) (.sequence 0 5) (.sequence 1 3) 26)
  | 3 => .win 1 (FullWinWitness.standard (.triplet 10) (.sequence 0 1) (.sequence 0 5) (.sequence 1 3) 26)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 10) (.sequence 0 2) (.sequence 0 5) (.sequence 1 3) 26)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 10) (.sequence 0 6) (.sequence 1 3) 26)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 10) (.sequence 0 4) (.sequence 0 6) (.sequence 1 3) 26)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 0 6) (.sequence 1 3) 26)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 0 5) (.sequence 1 3) 26)
  | 9 => .win 11 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 0) (.sequence 1 3) 26)
  | 11 => .win 9 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 0) (.sequence 1 3) 26)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 1) (.sequence 1 3) 26)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 1 3) 26)
  | 14 => .win 11 (FullWinWitness.standard (.triplet 10) (.triplet 14) (.sequence 0 5) (.sequence 1 1) 26)
  | 15 => .win 11 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 1) (.sequence 1 4) 26)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 1 5) 26)
  | 17 => .win 17 (FullWinWitness.standard (.triplet 10) (.triplet 17) (.sequence 0 5) (.sequence 1 3) 26)
  | 18 => .win 18 (FullWinWitness.standard (.triplet 10) (.triplet 18) (.sequence 0 5) (.sequence 1 3) 26)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 0) 26)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 0) 26)
  | 21 => .win 21 (FullWinWitness.standard (.triplet 10) (.triplet 21) (.sequence 0 5) (.sequence 1 3) 26)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 2) 26)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 26)
  | 24 => .win 2 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 2)
  | 25 => .win 25 (FullWinWitness.standard (.triplet 10) (.triplet 25) (.sequence 0 5) (.sequence 1 3) 26)
  | 26 => .win 2 (FullWinWitness.standard (.triplet 10) (.triplet 26) (.sequence 0 5) (.sequence 1 3) 2)
  | 27 => .back 28 20 [.swapHonors 0 1]
  | 28 => .back 27 20 []
  | 29 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 29)
  | 30 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 30)
  | 31 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row103 : Row := ⟨103, state103, 103, action103⟩

def state104 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 4 | 9 | 11 | 15 | 16 | 19 | 20 | 22 | 23 | 24 => 0
  | 5 | 6 | 7 | 8 | 12 | 13 | 17 | 18 | 21 | 25 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 10 => 3
  | 14 | 26 => 2
  | _ => 0

def action104 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 9 (FullWinWitness.orphans 26)
  | 1 => .back 10 19 []
  | 2 => .back 10 20 []
  | 3 => .win 4 (FullWinWitness.standard (.triplet 10) (.sequence 0 3) (.sequence 0 6) (.sequence 1 3) 26)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 10) (.sequence 0 3) (.sequence 0 6) (.sequence 1 3) 26)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 10) (.sequence 0 6) (.sequence 1 3) 26)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 10) (.sequence 0 4) (.sequence 0 6) (.sequence 1 3) 26)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 0 6) (.sequence 1 3) 26)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 0 5) (.sequence 1 3) 26)
  | 9 => .win 0 (FullWinWitness.orphans 26)
  | 10 => .back 2 20 []
  | 11 => .win 14 (FullWinWitness.standard (.triplet 10) (.triplet 14) (.sequence 0 5) (.sequence 1 2) 26)
  | 12 => .win 13 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 1 3) 26)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 1 3) 26)
  | 14 => .win 11 (FullWinWitness.standard (.triplet 10) (.triplet 14) (.sequence 0 5) (.sequence 1 2) 26)
  | 15 => .win 13 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 1 4) 26)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 1 5) 26)
  | 17 => .win 17 (FullWinWitness.standard (.triplet 10) (.triplet 17) (.sequence 0 5) (.sequence 1 3) 26)
  | 18 => .win 18 (FullWinWitness.standard (.triplet 10) (.triplet 18) (.sequence 0 5) (.sequence 1 3) 26)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 0) 26)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 0) 26)
  | 21 => .win 21 (FullWinWitness.standard (.triplet 10) (.triplet 21) (.sequence 0 5) (.sequence 1 3) 26)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 2) 26)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 26)
  | 24 => .win 5 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 6) 5)
  | 25 => .win 25 (FullWinWitness.standard (.triplet 10) (.triplet 25) (.sequence 0 5) (.sequence 1 3) 26)
  | 26 => .win 5 (FullWinWitness.standard (.triplet 10) (.triplet 26) (.sequence 0 6) (.sequence 1 3) 5)
  | 27 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 27)
  | 28 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 28)
  | 29 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 29)
  | 30 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 30)
  | 31 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row104 : Row := ⟨104, state104, 104, action104⟩

def state105 (t : Tile) : Nat :=
  match t.val with
  | 0 | 5 | 6 | 7 | 8 | 9 | 13 | 16 | 18 | 21 | 22 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 1 | 2 | 3 | 4 | 10 | 11 | 12 | 14 | 15 | 19 | 20 | 24 | 27 | 28 => 0
  | 17 | 23 => 2
  | 25 => 3
  | _ => 0

def action105 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 0 (FullWinWitness.standard (.triplet 0) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 1 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 0 5) (.sequence 2 3) 17)
  | 2 => .win 1 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 0 5) (.sequence 2 3) 17)
  | 3 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 3) (.sequence 0 6) (.sequence 2 3) 17)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 25) (.sequence 0 3) (.sequence 0 6) (.sequence 2 3) 17)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 25) (.sequence 0 6) (.sequence 2 3) 17)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 4) (.sequence 0 6) (.sequence 2 3) 17)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 0 6) (.sequence 2 3) 17)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 9 => .win 9 (FullWinWitness.standard (.triplet 9) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 10 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 0) (.sequence 2 3) 17)
  | 11 => .win 10 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 0) (.sequence 2 3) 17)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 2) (.sequence 2 3) 17)
  | 13 => .win 13 (FullWinWitness.standard (.triplet 13) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 14 => .win 12 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 17)
  | 15 => .win 0 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 0)
  | 16 => .win 16 (FullWinWitness.standard (.triplet 16) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 17 => .win 0 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 0)
  | 18 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 18)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 20 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 2) 23)
  | 21 => .win 22 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 23 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 23)
  | 24 => .win 15 (FullWinWitness.standard (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) (.sequence 2 5) 25)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 5) 17)
  | 26 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 26)
  | 27 => .win 28 (FullWinWitness.orphans 17)
  | 28 => .win 27 (FullWinWitness.orphans 17)
  | 29 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 29)
  | 30 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 30)
  | 31 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row105 : Row := ⟨105, state105, 105, action105⟩

def state106 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 5 | 6 | 9 | 10 | 11 | 15 | 19 | 20 | 21 | 22 => 0
  | 4 | 7 | 12 | 13 | 17 | 18 | 23 | 24 | 25 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 8 | 14 => 2
  | 16 => 3
  | _ => 0

def action106 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 9 (FullWinWitness.orphans 8)
  | 1 => .back 10 7 []
  | 2 => .win 3 (FullWinWitness.standard (.triplet 16) (.sequence 0 2) (.sequence 1 3) (.sequence 2 5) 8)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 16) (.sequence 0 2) (.sequence 1 3) (.sequence 2 5) 8)
  | 4 => .win 4 (FullWinWitness.standard (.triplet 4) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 8)
  | 5 => .win 3 (FullWinWitness.standard (.triplet 16) (.sequence 0 3) (.sequence 1 3) (.sequence 2 5) 8)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 4)
  | 7 => .win 7 (FullWinWitness.standard (.triplet 7) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 8)
  | 8 => .win 4 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 4)
  | 9 => .win 0 (FullWinWitness.orphans 8)
  | 10 => .back 1 7 []
  | 11 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 14)
  | 12 => .win 13 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 1 3) (.sequence 2 5) 8)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 1 3) (.sequence 2 5) 8)
  | 14 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 14)
  | 15 => .win 6 (FullWinWitness.standard (.sequence 0 6) (.sequence 1 3) (.sequence 1 5) (.sequence 2 5) 16)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 1 5) (.sequence 2 5) 8)
  | 17 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 17)
  | 18 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 18)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 0) (.sequence 2 5) 8)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 0) (.sequence 2 5) 8)
  | 21 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 3) (.sequence 2 6) 8)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 3) (.sequence 2 6) 8)
  | 23 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 6) 23)
  | 24 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 4) (.sequence 2 6) 8)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 5) (.sequence 2 6) 8)
  | 26 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 26)
  | 27 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 27)
  | 28 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 28)
  | 29 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 29)
  | 30 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 30)
  | 31 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row106 : Row := ⟨106, state106, 106, action106⟩

def state107 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 15 | 19 | 20 | 21 | 23 | 24 | 27 | 28 => 0
  | 1 | 5 | 6 | 7 | 8 | 10 | 12 | 13 | 17 | 18 | 22 | 25 | 29 | 30 | 31 | 32 | 33 => 1
  | 14 | 26 => 2
  | 16 => 3
  | _ => 0

def action107 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 2 (FullWinWitness.standard (.triplet 16) (.sequence 0 0) (.sequence 0 5) (.sequence 1 3) 26)
  | 1 => .win 1 (FullWinWitness.standard (.triplet 1) (.triplet 16) (.sequence 0 5) (.sequence 1 3) 26)
  | 2 => .win 0 (FullWinWitness.standard (.triplet 16) (.sequence 0 0) (.sequence 0 5) (.sequence 1 3) 26)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 16) (.sequence 0 1) (.sequence 0 5) (.sequence 1 3) 26)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 16) (.sequence 0 3) (.sequence 0 6) (.sequence 1 3) 26)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 16) (.sequence 0 6) (.sequence 1 3) 26)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 16) (.sequence 0 4) (.sequence 0 6) (.sequence 1 3) 26)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 0 6) (.sequence 1 3) 26)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 0 5) (.sequence 1 3) 26)
  | 9 => .win 11 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 0) (.sequence 1 3) 26)
  | 10 => .win 10 (FullWinWitness.standard (.triplet 10) (.triplet 16) (.sequence 0 5) (.sequence 1 3) 26)
  | 11 => .win 9 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 0) (.sequence 1 3) 26)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 1) (.sequence 1 3) 26)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 1 3) 26)
  | 14 => .win 11 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 5) (.sequence 1 1) 26)
  | 15 => .win 11 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 1) (.sequence 1 4) 26)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 1 5) 26)
  | 17 => .win 17 (FullWinWitness.standard (.triplet 16) (.triplet 17) (.sequence 0 5) (.sequence 1 3) 26)
  | 18 => .win 18 (FullWinWitness.standard (.triplet 16) (.triplet 18) (.sequence 0 5) (.sequence 1 3) 26)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 0) 26)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 0) 26)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 2) 26)
  | 22 => .win 22 (FullWinWitness.standard (.triplet 16) (.triplet 22) (.sequence 0 5) (.sequence 1 3) 26)
  | 23 => .win 21 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 26)
  | 24 => .win 1 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 1)
  | 25 => .win 25 (FullWinWitness.standard (.triplet 16) (.triplet 25) (.sequence 0 5) (.sequence 1 3) 26)
  | 26 => .win 1 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 5) (.sequence 1 3) 1)
  | 27 => .back 28 21 [.swapHonors 0 1]
  | 28 => .back 27 21 []
  | 29 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 29)
  | 30 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 30)
  | 31 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row107 : Row := ⟨107, state107, 107, action107⟩

def state108 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 15 | 19 | 20 | 21 | 23 | 24 | 27 | 28 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 12 | 13 | 17 | 18 | 22 | 25 | 29 | 30 | 31 | 32 | 33 => 1
  | 14 | 26 => 2
  | 16 => 3
  | _ => 0

def action108 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 1 (FullWinWitness.standard (.triplet 16) (.sequence 0 0) (.sequence 0 5) (.sequence 1 3) 26)
  | 1 => .win 0 (FullWinWitness.standard (.triplet 16) (.sequence 0 0) (.sequence 0 5) (.sequence 1 3) 26)
  | 2 => .win 2 (FullWinWitness.standard (.triplet 2) (.triplet 16) (.sequence 0 5) (.sequence 1 3) 26)
  | 3 => .win 1 (FullWinWitness.standard (.triplet 16) (.sequence 0 1) (.sequence 0 5) (.sequence 1 3) 26)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 16) (.sequence 0 2) (.sequence 0 5) (.sequence 1 3) 26)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 16) (.sequence 0 6) (.sequence 1 3) 26)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 16) (.sequence 0 4) (.sequence 0 6) (.sequence 1 3) 26)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 0 6) (.sequence 1 3) 26)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 0 5) (.sequence 1 3) 26)
  | 9 => .win 11 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 0) (.sequence 1 3) 26)
  | 10 => .win 10 (FullWinWitness.standard (.triplet 10) (.triplet 16) (.sequence 0 5) (.sequence 1 3) 26)
  | 11 => .win 9 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 0) (.sequence 1 3) 26)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 1) (.sequence 1 3) 26)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 1 3) 26)
  | 14 => .win 11 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 5) (.sequence 1 1) 26)
  | 15 => .win 11 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 1) (.sequence 1 4) 26)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 1 5) 26)
  | 17 => .win 17 (FullWinWitness.standard (.triplet 16) (.triplet 17) (.sequence 0 5) (.sequence 1 3) 26)
  | 18 => .win 18 (FullWinWitness.standard (.triplet 16) (.triplet 18) (.sequence 0 5) (.sequence 1 3) 26)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 0) 26)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 0) 26)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 2) 26)
  | 22 => .win 22 (FullWinWitness.standard (.triplet 16) (.triplet 22) (.sequence 0 5) (.sequence 1 3) 26)
  | 23 => .win 21 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 26)
  | 24 => .win 2 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 2)
  | 25 => .win 25 (FullWinWitness.standard (.triplet 16) (.triplet 25) (.sequence 0 5) (.sequence 1 3) 26)
  | 26 => .win 2 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 5) (.sequence 1 3) 2)
  | 27 => .back 28 22 [.swapHonors 0 1]
  | 28 => .back 27 22 []
  | 29 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 29)
  | 30 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 30)
  | 31 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row108 : Row := ⟨108, state108, 108, action108⟩

def state109 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 4 | 9 | 10 | 11 | 15 | 19 | 20 | 21 | 23 | 24 => 0
  | 5 | 6 | 7 | 8 | 12 | 13 | 17 | 18 | 22 | 25 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 14 | 26 => 2
  | 16 => 3
  | _ => 0

def action109 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 9 (FullWinWitness.orphans 26)
  | 1 => .back 10 21 []
  | 2 => .back 10 22 []
  | 3 => .win 4 (FullWinWitness.standard (.triplet 16) (.sequence 0 3) (.sequence 0 6) (.sequence 1 3) 26)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 16) (.sequence 0 3) (.sequence 0 6) (.sequence 1 3) 26)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 16) (.sequence 0 6) (.sequence 1 3) 26)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 16) (.sequence 0 4) (.sequence 0 6) (.sequence 1 3) 26)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 0 6) (.sequence 1 3) 26)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 0 5) (.sequence 1 3) 26)
  | 9 => .win 0 (FullWinWitness.orphans 26)
  | 10 => .back 2 22 []
  | 11 => .win 14 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 5) (.sequence 1 2) 26)
  | 12 => .win 13 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 1 3) 26)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 1 3) 26)
  | 14 => .win 11 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 5) (.sequence 1 2) 26)
  | 15 => .win 13 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 1 4) 26)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 1 5) 26)
  | 17 => .win 17 (FullWinWitness.standard (.triplet 16) (.triplet 17) (.sequence 0 5) (.sequence 1 3) 26)
  | 18 => .win 18 (FullWinWitness.standard (.triplet 16) (.triplet 18) (.sequence 0 5) (.sequence 1 3) 26)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 0) 26)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 0) 26)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 2) 26)
  | 22 => .win 22 (FullWinWitness.standard (.triplet 16) (.triplet 22) (.sequence 0 5) (.sequence 1 3) 26)
  | 23 => .win 21 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 26)
  | 24 => .win 5 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 6) 5)
  | 25 => .win 25 (FullWinWitness.standard (.triplet 16) (.triplet 25) (.sequence 0 5) (.sequence 1 3) 26)
  | 26 => .win 5 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 6) (.sequence 1 3) 5)
  | 27 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 27)
  | 28 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 28)
  | 29 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 29)
  | 30 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 30)
  | 31 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row109 : Row := ⟨109, state109, 109, action109⟩

def state110 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 4 | 9 | 10 | 11 | 12 | 14 | 15 | 19 | 20 | 24 => 0
  | 5 | 6 | 7 | 8 | 13 | 16 | 18 | 21 | 22 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 17 | 23 => 2
  | 25 => 3
  | _ => 0

def action110 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 9 (FullWinWitness.orphans 17)
  | 1 => .back 10 10 []
  | 2 => .back 10 15 []
  | 3 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 3) (.sequence 0 6) (.sequence 2 3) 17)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 25) (.sequence 0 3) (.sequence 0 6) (.sequence 2 3) 17)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 25) (.sequence 0 6) (.sequence 2 3) 17)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 4) (.sequence 0 6) (.sequence 2 3) 17)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 0 6) (.sequence 2 3) 17)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 9 => .win 0 (FullWinWitness.orphans 17)
  | 10 => .back 2 15 []
  | 11 => .win 12 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 2) (.sequence 2 3) 17)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 2) (.sequence 2 3) 17)
  | 13 => .win 13 (FullWinWitness.standard (.triplet 13) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 14 => .win 12 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 17)
  | 15 => .win 5 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 6) (.sequence 2 3) 5)
  | 16 => .win 16 (FullWinWitness.standard (.triplet 16) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 17 => .win 5 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 6) (.sequence 2 3) 5)
  | 18 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 18)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 20 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 2) 23)
  | 21 => .win 22 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 23 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 23)
  | 24 => .win 15 (FullWinWitness.standard (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) (.sequence 2 5) 25)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 5) 17)
  | 26 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 26)
  | 27 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 27)
  | 28 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 28)
  | 29 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 29)
  | 30 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 30)
  | 31 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row110 : Row := ⟨110, state110, 110, action110⟩

def state111 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 15 | 16 | 19 | 20 | 21 | 22 | 24 | 25 => 0
  | 2 | 5 | 6 | 7 | 8 | 11 | 12 | 13 | 14 | 17 | 18 | 23 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 10 => 3
  | 26 => 2
  | _ => 0

def action111 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 1 (FullWinWitness.standard (.triplet 10) (.sequence 0 0) (.sequence 0 5) (.sequence 1 2) 26)
  | 1 => .win 0 (FullWinWitness.standard (.triplet 10) (.sequence 0 0) (.sequence 0 5) (.sequence 1 2) 26)
  | 2 => .win 2 (FullWinWitness.standard (.triplet 2) (.triplet 10) (.sequence 0 5) (.sequence 1 2) 26)
  | 3 => .win 1 (FullWinWitness.standard (.triplet 10) (.sequence 0 1) (.sequence 0 5) (.sequence 1 2) 26)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 10) (.sequence 0 2) (.sequence 0 5) (.sequence 1 2) 26)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 10) (.sequence 0 6) (.sequence 1 2) 26)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 10) (.sequence 0 4) (.sequence 0 6) (.sequence 1 2) 26)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 0 6) (.sequence 1 2) 26)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 0 5) (.sequence 1 2) 26)
  | 9 => .win 0 (FullWinWitness.orphans 26)
  | 10 => .win 9 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 0) (.sequence 1 3) 26)
  | 11 => .win 11 (FullWinWitness.standard (.triplet 10) (.triplet 11) (.sequence 0 5) (.sequence 1 3) 26)
  | 12 => .win 10 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 1) (.sequence 1 3) 26)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 2) (.sequence 1 3) 26)
  | 14 => .win 14 (FullWinWitness.standard (.triplet 10) (.triplet 14) (.sequence 0 5) (.sequence 1 2) 26)
  | 15 => .win 10 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 1) (.sequence 1 4) 26)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 2) (.sequence 1 5) 26)
  | 17 => .win 17 (FullWinWitness.standard (.triplet 10) (.triplet 17) (.sequence 0 5) (.sequence 1 2) 26)
  | 18 => .win 18 (FullWinWitness.standard (.triplet 10) (.triplet 18) (.sequence 0 5) (.sequence 1 2) 26)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 2) (.sequence 2 0) 26)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 2) (.sequence 2 0) 26)
  | 21 => .win 22 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 2) (.sequence 2 3) 26)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 2) (.sequence 2 3) 26)
  | 23 => .win 23 (FullWinWitness.standard (.triplet 10) (.triplet 23) (.sequence 0 5) (.sequence 1 2) 26)
  | 24 => .win 22 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 2) (.sequence 2 4) 26)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 2) (.sequence 2 5) 26)
  | 26 => .win 2 (FullWinWitness.standard (.triplet 10) (.triplet 26) (.sequence 0 5) (.sequence 1 2) 2)
  | 27 => .win 26 (FullWinWitness.standard (.triplet 10) (.triplet 26) (.sequence 0 5) (.sequence 1 2) 27)
  | 28 => .win 26 (FullWinWitness.standard (.triplet 10) (.triplet 26) (.sequence 0 5) (.sequence 1 2) 28)
  | 29 => .win 26 (FullWinWitness.standard (.triplet 10) (.triplet 26) (.sequence 0 5) (.sequence 1 2) 29)
  | 30 => .win 26 (FullWinWitness.standard (.triplet 10) (.triplet 26) (.sequence 0 5) (.sequence 1 2) 30)
  | 31 => .win 26 (FullWinWitness.standard (.triplet 10) (.triplet 26) (.sequence 0 5) (.sequence 1 2) 31)
  | 32 => .win 26 (FullWinWitness.standard (.triplet 10) (.triplet 26) (.sequence 0 5) (.sequence 1 2) 32)
  | 33 => .win 26 (FullWinWitness.standard (.triplet 10) (.triplet 26) (.sequence 0 5) (.sequence 1 2) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row111 : Row := ⟨111, state111, 111, action111⟩

def state112 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 13 | 15 | 16 | 18 | 24 | 25 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 14 | 20 | 21 | 22 | 23 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 17 => 2
  | 19 => 3
  | _ => 0

def action112 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 1 (FullWinWitness.standard (.triplet 19) (.sequence 0 0) (.sequence 0 5) (.sequence 2 2) 17)
  | 1 => .win 0 (FullWinWitness.standard (.triplet 19) (.sequence 0 0) (.sequence 0 5) (.sequence 2 2) 17)
  | 2 => .win 2 (FullWinWitness.standard (.triplet 2) (.triplet 19) (.sequence 0 5) (.sequence 2 2) 17)
  | 3 => .win 1 (FullWinWitness.standard (.triplet 19) (.sequence 0 1) (.sequence 0 5) (.sequence 2 2) 17)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 19) (.sequence 0 2) (.sequence 0 5) (.sequence 2 2) 17)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 19) (.sequence 0 6) (.sequence 2 2) 17)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 19) (.sequence 0 4) (.sequence 0 6) (.sequence 2 2) 17)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 0 6) (.sequence 2 2) 17)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 0 5) (.sequence 2 2) 17)
  | 9 => .win 11 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 0) (.sequence 2 2) 17)
  | 10 => .win 10 (FullWinWitness.standard (.triplet 10) (.triplet 19) (.sequence 0 5) (.sequence 2 2) 17)
  | 11 => .win 9 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 0) (.sequence 2 2) 17)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 1) (.sequence 2 2) 17)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 3) (.sequence 2 2) 17)
  | 14 => .win 14 (FullWinWitness.standard (.triplet 14) (.triplet 19) (.sequence 0 5) (.sequence 2 2) 17)
  | 15 => .win 13 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 4) (.sequence 2 2) 17)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 5) (.sequence 2 2) 17)
  | 17 => .win 2 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 5) (.sequence 2 2) 2)
  | 18 => .win 17 (FullWinWitness.standard (.triplet 17) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 19)
  | 19 => .win 18 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 20 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 20)
  | 21 => .win 17 (FullWinWitness.standard (.triplet 17) (.sequence 0 5) (.sequence 2 1) (.sequence 2 3) 19)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 2) (.sequence 2 3) 17)
  | 23 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 5) (.sequence 2 2) 23)
  | 24 => .win 17 (FullWinWitness.standard (.triplet 17) (.sequence 0 5) (.sequence 2 1) (.sequence 2 4) 19)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 2) (.sequence 2 5) 17)
  | 26 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 5) (.sequence 2 2) 26)
  | 27 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 5) (.sequence 2 2) 27)
  | 28 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 5) (.sequence 2 2) 28)
  | 29 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 5) (.sequence 2 2) 29)
  | 30 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 5) (.sequence 2 2) 30)
  | 31 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 5) (.sequence 2 2) 31)
  | 32 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 5) (.sequence 2 2) 32)
  | 33 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 5) (.sequence 2 2) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row112 : Row := ⟨112, state112, 112, action112⟩

def state113 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 6 | 7 | 9 | 15 | 16 | 19 | 20 | 21 | 22 => 0
  | 2 | 5 | 11 | 12 | 13 | 14 | 17 | 18 | 23 | 24 | 25 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 8 => 2
  | 10 => 3
  | _ => 0

def action113 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 1 (FullWinWitness.standard (.triplet 10) (.sequence 0 0) (.sequence 1 2) (.sequence 2 5) 8)
  | 1 => .win 0 (FullWinWitness.standard (.triplet 10) (.sequence 0 0) (.sequence 1 2) (.sequence 2 5) 8)
  | 2 => .win 2 (FullWinWitness.standard (.triplet 2) (.triplet 10) (.sequence 1 2) (.sequence 2 5) 8)
  | 3 => .win 1 (FullWinWitness.standard (.triplet 10) (.sequence 0 1) (.sequence 1 2) (.sequence 2 5) 8)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 10) (.sequence 0 2) (.sequence 1 2) (.sequence 2 5) 8)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 10) (.sequence 1 2) (.sequence 2 5) 8)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 10) (.sequence 0 4) (.sequence 1 2) (.sequence 2 5) 8)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 2) (.sequence 2 5) 8)
  | 8 => .win 2 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 1 2) (.sequence 2 5) 2)
  | 9 => .win 0 (FullWinWitness.orphans 8)
  | 10 => .win 9 (FullWinWitness.standard (.triplet 10) (.sequence 1 0) (.sequence 1 3) (.sequence 2 5) 8)
  | 11 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 1 3) (.sequence 2 5) 11)
  | 12 => .win 8 (FullWinWitness.standard (.triplet 8) (.sequence 1 1) (.sequence 1 3) (.sequence 2 5) 10)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 10) (.sequence 1 2) (.sequence 1 3) (.sequence 2 5) 8)
  | 14 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 1 2) (.sequence 2 5) 14)
  | 15 => .win 8 (FullWinWitness.standard (.triplet 8) (.sequence 1 1) (.sequence 1 4) (.sequence 2 5) 10)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 10) (.sequence 1 2) (.sequence 1 5) (.sequence 2 5) 8)
  | 17 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 1 2) (.sequence 2 5) 17)
  | 18 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 1 2) (.sequence 2 5) 18)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 10) (.sequence 1 2) (.sequence 2 0) (.sequence 2 5) 8)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 10) (.sequence 1 2) (.sequence 2 0) (.sequence 2 5) 8)
  | 21 => .win 22 (FullWinWitness.standard (.triplet 10) (.sequence 1 2) (.sequence 2 3) (.sequence 2 6) 8)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 10) (.sequence 1 2) (.sequence 2 3) (.sequence 2 6) 8)
  | 23 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 1 2) (.sequence 2 6) 23)
  | 24 => .win 22 (FullWinWitness.standard (.triplet 10) (.sequence 1 2) (.sequence 2 4) (.sequence 2 6) 8)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 1 2) (.sequence 2 5) (.sequence 2 6) 8)
  | 26 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 1 2) (.sequence 2 5) 26)
  | 27 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 1 2) (.sequence 2 5) 27)
  | 28 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 1 2) (.sequence 2 5) 28)
  | 29 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 1 2) (.sequence 2 5) 29)
  | 30 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 1 2) (.sequence 2 5) 30)
  | 31 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 1 2) (.sequence 2 5) 31)
  | 32 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 1 2) (.sequence 2 5) 32)
  | 33 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 1 2) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row113 : Row := ⟨113, state113, 113, action113⟩

def state114 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 6 | 7 | 9 | 11 | 12 | 13 | 18 | 24 | 25 => 0
  | 1 | 5 | 10 | 14 | 15 | 16 | 17 | 20 | 21 | 22 | 23 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 8 => 2
  | 19 => 3
  | _ => 0

def action114 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 2 (FullWinWitness.standard (.triplet 19) (.sequence 0 0) (.sequence 1 5) (.sequence 2 2) 8)
  | 1 => .win 1 (FullWinWitness.standard (.triplet 1) (.triplet 19) (.sequence 1 5) (.sequence 2 2) 8)
  | 2 => .win 0 (FullWinWitness.standard (.triplet 19) (.sequence 0 0) (.sequence 1 5) (.sequence 2 2) 8)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 19) (.sequence 0 1) (.sequence 1 5) (.sequence 2 2) 8)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 19) (.sequence 0 3) (.sequence 1 5) (.sequence 2 2) 8)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 19) (.sequence 1 5) (.sequence 2 2) 8)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 19) (.sequence 0 4) (.sequence 1 5) (.sequence 2 2) 8)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 5) (.sequence 2 2) 8)
  | 8 => .win 1 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 2) 1)
  | 9 => .win 11 (FullWinWitness.standard (.triplet 19) (.sequence 1 0) (.sequence 1 5) (.sequence 2 2) 8)
  | 10 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 2) 10)
  | 11 => .win 9 (FullWinWitness.standard (.triplet 19) (.sequence 1 0) (.sequence 1 5) (.sequence 2 2) 8)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 19) (.sequence 1 1) (.sequence 1 5) (.sequence 2 2) 8)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 19) (.sequence 1 3) (.sequence 1 6) (.sequence 2 2) 8)
  | 14 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 6) (.sequence 2 2) 14)
  | 15 => .win 13 (FullWinWitness.standard (.triplet 19) (.sequence 1 4) (.sequence 1 6) (.sequence 2 2) 8)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 1 6) (.sequence 2 2) 8)
  | 17 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 2) 17)
  | 18 => .win 8 (FullWinWitness.standard (.triplet 8) (.sequence 1 5) (.sequence 2 0) (.sequence 2 3) 19)
  | 19 => .win 18 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 0) (.sequence 2 3) 8)
  | 20 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 3) 20)
  | 21 => .win 8 (FullWinWitness.standard (.triplet 8) (.sequence 1 5) (.sequence 2 1) (.sequence 2 3) 19)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 2) (.sequence 2 3) 8)
  | 23 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 2) 23)
  | 24 => .win 8 (FullWinWitness.standard (.triplet 8) (.sequence 1 5) (.sequence 2 1) (.sequence 2 4) 19)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 2) (.sequence 2 5) 8)
  | 26 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 2) 26)
  | 27 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 2) 27)
  | 28 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 2) 28)
  | 29 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 2) 29)
  | 30 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 2) 30)
  | 31 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 2) 31)
  | 32 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 2) 32)
  | 33 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 2) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row114 : Row := ⟨114, state114, 114, action114⟩

def state115 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 6 | 7 | 9 | 10 | 12 | 13 | 18 | 24 | 25 => 0
  | 2 | 5 | 11 | 14 | 15 | 16 | 17 | 20 | 21 | 22 | 23 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 8 => 2
  | 19 => 3
  | _ => 0

def action115 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 1 (FullWinWitness.standard (.triplet 19) (.sequence 0 0) (.sequence 1 5) (.sequence 2 2) 8)
  | 1 => .win 0 (FullWinWitness.standard (.triplet 19) (.sequence 0 0) (.sequence 1 5) (.sequence 2 2) 8)
  | 2 => .win 2 (FullWinWitness.standard (.triplet 2) (.triplet 19) (.sequence 1 5) (.sequence 2 2) 8)
  | 3 => .win 1 (FullWinWitness.standard (.triplet 19) (.sequence 0 1) (.sequence 1 5) (.sequence 2 2) 8)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 19) (.sequence 0 2) (.sequence 1 5) (.sequence 2 2) 8)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 19) (.sequence 1 5) (.sequence 2 2) 8)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 19) (.sequence 0 4) (.sequence 1 5) (.sequence 2 2) 8)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 5) (.sequence 2 2) 8)
  | 8 => .win 2 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 2) 2)
  | 9 => .win 10 (FullWinWitness.standard (.triplet 19) (.sequence 1 0) (.sequence 1 5) (.sequence 2 2) 8)
  | 10 => .win 9 (FullWinWitness.standard (.triplet 19) (.sequence 1 0) (.sequence 1 5) (.sequence 2 2) 8)
  | 11 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 2) 11)
  | 12 => .win 10 (FullWinWitness.standard (.triplet 19) (.sequence 1 1) (.sequence 1 5) (.sequence 2 2) 8)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 19) (.sequence 1 2) (.sequence 1 5) (.sequence 2 2) 8)
  | 14 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 6) (.sequence 2 2) 14)
  | 15 => .win 13 (FullWinWitness.standard (.triplet 19) (.sequence 1 4) (.sequence 1 6) (.sequence 2 2) 8)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 1 6) (.sequence 2 2) 8)
  | 17 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 2) 17)
  | 18 => .win 8 (FullWinWitness.standard (.triplet 8) (.sequence 1 5) (.sequence 2 0) (.sequence 2 3) 19)
  | 19 => .win 18 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 0) (.sequence 2 3) 8)
  | 20 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 3) 20)
  | 21 => .win 8 (FullWinWitness.standard (.triplet 8) (.sequence 1 5) (.sequence 2 1) (.sequence 2 3) 19)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 2) (.sequence 2 3) 8)
  | 23 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 2) 23)
  | 24 => .win 8 (FullWinWitness.standard (.triplet 8) (.sequence 1 5) (.sequence 2 1) (.sequence 2 4) 19)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 2) (.sequence 2 5) 8)
  | 26 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 2) 26)
  | 27 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 2) 27)
  | 28 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 2) 28)
  | 29 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 2) 29)
  | 30 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 2) 30)
  | 31 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 2) 31)
  | 32 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 2) 32)
  | 33 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 2) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row115 : Row := ⟨115, state115, 115, action115⟩

def state116 (t : Tile) : Nat :=
  match t.val with
  | 0 | 5 | 6 | 7 | 8 | 9 | 13 | 16 | 18 | 22 | 23 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 1 | 2 | 3 | 4 | 10 | 11 | 12 | 14 | 15 | 19 | 20 | 24 | 27 | 28 => 0
  | 17 | 21 => 2
  | 25 => 3
  | _ => 0

def action116 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 0 (FullWinWitness.standard (.triplet 0) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 1 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 0 5) (.sequence 2 3) 17)
  | 2 => .win 1 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 0 5) (.sequence 2 3) 17)
  | 3 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 3) (.sequence 0 6) (.sequence 2 3) 17)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 25) (.sequence 0 3) (.sequence 0 6) (.sequence 2 3) 17)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 25) (.sequence 0 6) (.sequence 2 3) 17)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 4) (.sequence 0 6) (.sequence 2 3) 17)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 0 6) (.sequence 2 3) 17)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 9 => .win 9 (FullWinWitness.standard (.triplet 9) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 10 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 0) (.sequence 2 3) 17)
  | 11 => .win 10 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 0) (.sequence 2 3) 17)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 2) (.sequence 2 3) 17)
  | 13 => .win 13 (FullWinWitness.standard (.triplet 13) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 14 => .win 12 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 17)
  | 15 => .win 0 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 0)
  | 16 => .win 16 (FullWinWitness.standard (.triplet 16) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 17 => .win 0 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 0)
  | 18 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 18)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 21 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 21)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 2) (.sequence 2 3) 17)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 24 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 4) 21)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 6) 17)
  | 26 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 26)
  | 27 => .win 28 (FullWinWitness.orphans 17)
  | 28 => .win 27 (FullWinWitness.orphans 17)
  | 29 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 29)
  | 30 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 30)
  | 31 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row116 : Row := ⟨116, state116, 116, action116⟩

def state117 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 15 | 16 | 19 | 20 | 21 | 23 | 24 | 27 | 28 => 0
  | 1 | 5 | 6 | 7 | 8 | 12 | 13 | 17 | 18 | 22 | 25 | 29 | 30 | 31 | 32 | 33 => 1
  | 10 => 4
  | 14 | 26 => 2
  | _ => 0

def action117 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 2 (FullWinWitness.standard (.triplet 10) (.sequence 0 0) (.sequence 0 5) (.sequence 1 3) 26)
  | 1 => .win 1 (FullWinWitness.standard (.triplet 1) (.triplet 10) (.sequence 0 5) (.sequence 1 3) 26)
  | 2 => .win 0 (FullWinWitness.standard (.triplet 10) (.sequence 0 0) (.sequence 0 5) (.sequence 1 3) 26)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 10) (.sequence 0 1) (.sequence 0 5) (.sequence 1 3) 26)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 10) (.sequence 0 3) (.sequence 0 6) (.sequence 1 3) 26)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 10) (.sequence 0 6) (.sequence 1 3) 26)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 10) (.sequence 0 4) (.sequence 0 6) (.sequence 1 3) 26)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 0 6) (.sequence 1 3) 26)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 0 5) (.sequence 1 3) 26)
  | 9 => .win 11 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 0) (.sequence 1 3) 26)
  | 11 => .win 9 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 0) (.sequence 1 3) 26)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 1) (.sequence 1 3) 26)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 1 3) 26)
  | 14 => .win 11 (FullWinWitness.standard (.triplet 10) (.triplet 14) (.sequence 0 5) (.sequence 1 1) 26)
  | 15 => .win 11 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 1) (.sequence 1 4) 26)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 1 5) 26)
  | 17 => .win 17 (FullWinWitness.standard (.triplet 10) (.triplet 17) (.sequence 0 5) (.sequence 1 3) 26)
  | 18 => .win 18 (FullWinWitness.standard (.triplet 10) (.triplet 18) (.sequence 0 5) (.sequence 1 3) 26)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 0) 26)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 0) 26)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 2) 26)
  | 22 => .win 22 (FullWinWitness.standard (.triplet 10) (.triplet 22) (.sequence 0 5) (.sequence 1 3) 26)
  | 23 => .win 21 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 26)
  | 24 => .win 1 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 1)
  | 25 => .win 25 (FullWinWitness.standard (.triplet 10) (.triplet 25) (.sequence 0 5) (.sequence 1 3) 26)
  | 26 => .win 1 (FullWinWitness.standard (.triplet 10) (.triplet 26) (.sequence 0 5) (.sequence 1 3) 1)
  | 27 => .back 28 23 [.swapHonors 0 1]
  | 28 => .back 27 23 []
  | 29 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 29)
  | 30 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 30)
  | 31 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row117 : Row := ⟨117, state117, 117, action117⟩

def state118 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 15 | 16 | 19 | 20 | 21 | 23 | 24 | 27 | 28 => 0
  | 2 | 5 | 6 | 7 | 8 | 12 | 13 | 17 | 18 | 22 | 25 | 29 | 30 | 31 | 32 | 33 => 1
  | 10 => 4
  | 14 | 26 => 2
  | _ => 0

def action118 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 1 (FullWinWitness.standard (.triplet 10) (.sequence 0 0) (.sequence 0 5) (.sequence 1 3) 26)
  | 1 => .win 0 (FullWinWitness.standard (.triplet 10) (.sequence 0 0) (.sequence 0 5) (.sequence 1 3) 26)
  | 2 => .win 2 (FullWinWitness.standard (.triplet 2) (.triplet 10) (.sequence 0 5) (.sequence 1 3) 26)
  | 3 => .win 1 (FullWinWitness.standard (.triplet 10) (.sequence 0 1) (.sequence 0 5) (.sequence 1 3) 26)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 10) (.sequence 0 2) (.sequence 0 5) (.sequence 1 3) 26)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 10) (.sequence 0 6) (.sequence 1 3) 26)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 10) (.sequence 0 4) (.sequence 0 6) (.sequence 1 3) 26)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 0 6) (.sequence 1 3) 26)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 0 5) (.sequence 1 3) 26)
  | 9 => .win 11 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 0) (.sequence 1 3) 26)
  | 11 => .win 9 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 0) (.sequence 1 3) 26)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 1) (.sequence 1 3) 26)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 1 3) 26)
  | 14 => .win 11 (FullWinWitness.standard (.triplet 10) (.triplet 14) (.sequence 0 5) (.sequence 1 1) 26)
  | 15 => .win 11 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 1) (.sequence 1 4) 26)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 1 5) 26)
  | 17 => .win 17 (FullWinWitness.standard (.triplet 10) (.triplet 17) (.sequence 0 5) (.sequence 1 3) 26)
  | 18 => .win 18 (FullWinWitness.standard (.triplet 10) (.triplet 18) (.sequence 0 5) (.sequence 1 3) 26)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 0) 26)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 0) 26)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 2) 26)
  | 22 => .win 22 (FullWinWitness.standard (.triplet 10) (.triplet 22) (.sequence 0 5) (.sequence 1 3) 26)
  | 23 => .win 21 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 26)
  | 24 => .win 2 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 2)
  | 25 => .win 25 (FullWinWitness.standard (.triplet 10) (.triplet 25) (.sequence 0 5) (.sequence 1 3) 26)
  | 26 => .win 2 (FullWinWitness.standard (.triplet 10) (.triplet 26) (.sequence 0 5) (.sequence 1 3) 2)
  | 27 => .back 28 24 [.swapHonors 0 1]
  | 28 => .back 27 24 []
  | 29 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 29)
  | 30 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 30)
  | 31 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row118 : Row := ⟨118, state118, 118, action118⟩

def state119 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 4 | 9 | 11 | 15 | 16 | 19 | 20 | 21 | 23 | 24 => 0
  | 5 | 6 | 7 | 8 | 12 | 13 | 17 | 18 | 22 | 25 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 10 => 3
  | 14 | 26 => 2
  | _ => 0

def action119 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 9 (FullWinWitness.orphans 26)
  | 1 => .back 10 23 []
  | 2 => .back 10 24 []
  | 3 => .win 4 (FullWinWitness.standard (.triplet 10) (.sequence 0 3) (.sequence 0 6) (.sequence 1 3) 26)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 10) (.sequence 0 3) (.sequence 0 6) (.sequence 1 3) 26)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 10) (.sequence 0 6) (.sequence 1 3) 26)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 10) (.sequence 0 4) (.sequence 0 6) (.sequence 1 3) 26)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 0 6) (.sequence 1 3) 26)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 0 5) (.sequence 1 3) 26)
  | 9 => .win 0 (FullWinWitness.orphans 26)
  | 10 => .back 1 23 []
  | 11 => .win 14 (FullWinWitness.standard (.triplet 10) (.triplet 14) (.sequence 0 5) (.sequence 1 2) 26)
  | 12 => .win 13 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 1 3) 26)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 1 3) 26)
  | 14 => .win 11 (FullWinWitness.standard (.triplet 10) (.triplet 14) (.sequence 0 5) (.sequence 1 2) 26)
  | 15 => .win 13 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 1 4) 26)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 1 5) 26)
  | 17 => .win 17 (FullWinWitness.standard (.triplet 10) (.triplet 17) (.sequence 0 5) (.sequence 1 3) 26)
  | 18 => .win 18 (FullWinWitness.standard (.triplet 10) (.triplet 18) (.sequence 0 5) (.sequence 1 3) 26)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 0) 26)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 0) 26)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 2) 26)
  | 22 => .win 22 (FullWinWitness.standard (.triplet 10) (.triplet 22) (.sequence 0 5) (.sequence 1 3) 26)
  | 23 => .win 21 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 26)
  | 24 => .win 5 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 6) 5)
  | 25 => .win 25 (FullWinWitness.standard (.triplet 10) (.triplet 25) (.sequence 0 5) (.sequence 1 3) 26)
  | 26 => .win 5 (FullWinWitness.standard (.triplet 10) (.triplet 26) (.sequence 0 6) (.sequence 1 3) 5)
  | 27 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 27)
  | 28 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 28)
  | 29 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 29)
  | 30 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 30)
  | 31 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row119 : Row := ⟨119, state119, 119, action119⟩

def state120 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 5 | 6 | 9 | 11 | 15 | 16 | 19 | 20 | 21 | 22 | 27 | 28 => 0
  | 1 | 4 | 7 | 12 | 13 | 17 | 18 | 23 | 24 | 25 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 8 | 14 => 2
  | 10 => 4
  | _ => 0

def action120 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 2 (FullWinWitness.standard (.triplet 10) (.sequence 0 0) (.sequence 1 3) (.sequence 2 5) 8)
  | 1 => .win 1 (FullWinWitness.standard (.triplet 1) (.triplet 10) (.sequence 1 3) (.sequence 2 5) 8)
  | 2 => .win 0 (FullWinWitness.standard (.triplet 10) (.sequence 0 0) (.sequence 1 3) (.sequence 2 5) 8)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 10) (.sequence 0 1) (.sequence 1 3) (.sequence 2 5) 8)
  | 4 => .win 4 (FullWinWitness.standard (.triplet 4) (.triplet 10) (.sequence 1 3) (.sequence 2 5) 8)
  | 5 => .win 3 (FullWinWitness.standard (.triplet 10) (.sequence 0 3) (.sequence 1 3) (.sequence 2 5) 8)
  | 6 => .win 1 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 1)
  | 7 => .win 7 (FullWinWitness.standard (.triplet 7) (.triplet 10) (.sequence 1 3) (.sequence 2 5) 8)
  | 8 => .win 1 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 1 3) (.sequence 2 5) 1)
  | 9 => .win 11 (FullWinWitness.standard (.triplet 10) (.sequence 1 0) (.sequence 1 3) (.sequence 2 5) 8)
  | 11 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 1) (.sequence 2 5) 14)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 10) (.sequence 1 1) (.sequence 1 3) (.sequence 2 5) 8)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 10) (.sequence 1 3) (.sequence 1 3) (.sequence 2 5) 8)
  | 14 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 14)
  | 15 => .win 11 (FullWinWitness.standard (.triplet 10) (.sequence 1 1) (.sequence 1 4) (.sequence 2 5) 8)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 10) (.sequence 1 3) (.sequence 1 5) (.sequence 2 5) 8)
  | 17 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 17)
  | 18 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 18)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 10) (.sequence 1 3) (.sequence 2 0) (.sequence 2 5) 8)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 10) (.sequence 1 3) (.sequence 2 0) (.sequence 2 5) 8)
  | 21 => .win 22 (FullWinWitness.standard (.triplet 10) (.sequence 1 3) (.sequence 2 3) (.sequence 2 6) 8)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 10) (.sequence 1 3) (.sequence 2 3) (.sequence 2 6) 8)
  | 23 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 6) 23)
  | 24 => .win 22 (FullWinWitness.standard (.triplet 10) (.sequence 1 3) (.sequence 2 4) (.sequence 2 6) 8)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 1 3) (.sequence 2 5) (.sequence 2 6) 8)
  | 26 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 26)
  | 27 => .back 28 25 [.swapHonors 0 1]
  | 28 => .back 27 25 []
  | 29 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 29)
  | 30 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 30)
  | 31 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row120 : Row := ⟨120, state120, 120, action120⟩

def state121 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 18 | 20 | 24 | 25 | 27 | 28 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 13 | 16 | 21 | 22 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 17 | 23 => 2
  | 19 => 4
  | _ => 0

def action121 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 1 (FullWinWitness.standard (.triplet 19) (.sequence 0 0) (.sequence 0 5) (.sequence 2 3) 17)
  | 1 => .win 0 (FullWinWitness.standard (.triplet 19) (.sequence 0 0) (.sequence 0 5) (.sequence 2 3) 17)
  | 2 => .win 2 (FullWinWitness.standard (.triplet 2) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 17)
  | 3 => .win 1 (FullWinWitness.standard (.triplet 19) (.sequence 0 1) (.sequence 0 5) (.sequence 2 3) 17)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 19) (.sequence 0 2) (.sequence 0 5) (.sequence 2 3) 17)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 19) (.sequence 0 6) (.sequence 2 3) 17)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 19) (.sequence 0 4) (.sequence 0 6) (.sequence 2 3) 17)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 0 6) (.sequence 2 3) 17)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 17)
  | 9 => .win 11 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 0) (.sequence 2 3) 17)
  | 10 => .win 10 (FullWinWitness.standard (.triplet 10) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 17)
  | 11 => .win 9 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 0) (.sequence 2 3) 17)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 1) (.sequence 2 3) 17)
  | 13 => .win 13 (FullWinWitness.standard (.triplet 13) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 17)
  | 14 => .win 12 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 17)
  | 15 => .win 2 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 2)
  | 16 => .win 16 (FullWinWitness.standard (.triplet 16) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 17)
  | 17 => .win 2 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 2)
  | 18 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 20 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 1) 23)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 1) (.sequence 2 3) 17)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 23 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 23)
  | 24 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 1) (.sequence 2 4) 17)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 3) (.sequence 2 5) 17)
  | 26 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 26)
  | 27 => .back 28 26 [.swapHonors 0 1]
  | 28 => .back 27 26 []
  | 29 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 29)
  | 30 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 30)
  | 31 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row121 : Row := ⟨121, state121, 121, action121⟩

def state122 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 18 | 20 | 24 | 25 | 27 | 28 => 0
  | 1 | 5 | 6 | 7 | 8 | 10 | 13 | 16 | 21 | 22 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 17 | 23 => 2
  | 19 => 4
  | _ => 0

def action122 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 2 (FullWinWitness.standard (.triplet 19) (.sequence 0 0) (.sequence 0 5) (.sequence 2 3) 17)
  | 1 => .win 1 (FullWinWitness.standard (.triplet 1) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 17)
  | 2 => .win 0 (FullWinWitness.standard (.triplet 19) (.sequence 0 0) (.sequence 0 5) (.sequence 2 3) 17)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 19) (.sequence 0 1) (.sequence 0 5) (.sequence 2 3) 17)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 19) (.sequence 0 3) (.sequence 0 6) (.sequence 2 3) 17)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 19) (.sequence 0 6) (.sequence 2 3) 17)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 19) (.sequence 0 4) (.sequence 0 6) (.sequence 2 3) 17)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 0 6) (.sequence 2 3) 17)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 17)
  | 9 => .win 11 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 0) (.sequence 2 3) 17)
  | 10 => .win 10 (FullWinWitness.standard (.triplet 10) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 17)
  | 11 => .win 9 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 0) (.sequence 2 3) 17)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 1) (.sequence 2 3) 17)
  | 13 => .win 13 (FullWinWitness.standard (.triplet 13) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 17)
  | 14 => .win 12 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 17)
  | 15 => .win 1 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 1)
  | 16 => .win 16 (FullWinWitness.standard (.triplet 16) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 17)
  | 17 => .win 1 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 1)
  | 18 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 20 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 1) 23)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 1) (.sequence 2 3) 17)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 23 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 23)
  | 24 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 1) (.sequence 2 4) 17)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 3) (.sequence 2 5) 17)
  | 26 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 26)
  | 27 => .back 28 27 [.swapHonors 0 1]
  | 28 => .back 27 27 []
  | 29 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 29)
  | 30 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 30)
  | 31 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row122 : Row := ⟨122, state122, 122, action122⟩

def state123 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 5 | 6 | 9 | 15 | 16 | 19 | 20 | 21 | 22 => 0
  | 2 | 7 | 11 | 12 | 13 | 14 | 17 | 18 | 23 | 24 | 25 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 8 => 2
  | 10 => 3
  | _ => 0

def action123 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 1 (FullWinWitness.standard (.triplet 10) (.sequence 0 0) (.sequence 1 2) (.sequence 2 5) 8)
  | 1 => .win 0 (FullWinWitness.standard (.triplet 10) (.sequence 0 0) (.sequence 1 2) (.sequence 2 5) 8)
  | 2 => .win 2 (FullWinWitness.standard (.triplet 2) (.triplet 10) (.sequence 1 2) (.sequence 2 5) 8)
  | 3 => .win 1 (FullWinWitness.standard (.triplet 10) (.sequence 0 1) (.sequence 1 2) (.sequence 2 5) 8)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 10) (.sequence 0 2) (.sequence 1 2) (.sequence 2 5) 8)
  | 5 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 2) (.sequence 2 5) 8)
  | 6 => .win 2 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 2)
  | 7 => .win 7 (FullWinWitness.standard (.triplet 7) (.triplet 10) (.sequence 1 2) (.sequence 2 5) 8)
  | 8 => .win 2 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 1 2) (.sequence 2 5) 2)
  | 9 => .win 0 (FullWinWitness.orphans 8)
  | 10 => .win 9 (FullWinWitness.standard (.triplet 10) (.sequence 1 0) (.sequence 1 3) (.sequence 2 5) 8)
  | 11 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 11)
  | 12 => .win 6 (FullWinWitness.standard (.sequence 0 6) (.sequence 1 1) (.sequence 1 3) (.sequence 2 5) 10)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 10) (.sequence 1 2) (.sequence 1 3) (.sequence 2 5) 8)
  | 14 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 14)
  | 15 => .win 6 (FullWinWitness.standard (.sequence 0 6) (.sequence 1 1) (.sequence 1 4) (.sequence 2 5) 10)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 10) (.sequence 1 2) (.sequence 1 5) (.sequence 2 5) 8)
  | 17 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 17)
  | 18 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 18)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 10) (.sequence 1 2) (.sequence 2 0) (.sequence 2 5) 8)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 10) (.sequence 1 2) (.sequence 2 0) (.sequence 2 5) 8)
  | 21 => .win 22 (FullWinWitness.standard (.triplet 10) (.sequence 1 2) (.sequence 2 3) (.sequence 2 6) 8)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 10) (.sequence 1 2) (.sequence 2 3) (.sequence 2 6) 8)
  | 23 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 2) (.sequence 2 6) 23)
  | 24 => .win 22 (FullWinWitness.standard (.triplet 10) (.sequence 1 2) (.sequence 2 4) (.sequence 2 6) 8)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 1 2) (.sequence 2 5) (.sequence 2 6) 8)
  | 26 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 26)
  | 27 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 27)
  | 28 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 28)
  | 29 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 29)
  | 30 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 30)
  | 31 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row123 : Row := ⟨123, state123, 123, action123⟩

def state124 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 5 | 6 | 9 | 11 | 12 | 13 | 18 | 24 | 25 => 0
  | 2 | 7 | 10 | 14 | 15 | 16 | 17 | 20 | 21 | 22 | 23 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 8 => 2
  | 19 => 3
  | _ => 0

def action124 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 1 (FullWinWitness.standard (.triplet 19) (.sequence 0 0) (.sequence 1 5) (.sequence 2 2) 8)
  | 1 => .win 0 (FullWinWitness.standard (.triplet 19) (.sequence 0 0) (.sequence 1 5) (.sequence 2 2) 8)
  | 2 => .win 2 (FullWinWitness.standard (.triplet 2) (.triplet 19) (.sequence 1 5) (.sequence 2 2) 8)
  | 3 => .win 1 (FullWinWitness.standard (.triplet 19) (.sequence 0 1) (.sequence 1 5) (.sequence 2 2) 8)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 19) (.sequence 0 2) (.sequence 1 5) (.sequence 2 2) 8)
  | 5 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 5) (.sequence 2 2) 8)
  | 6 => .win 2 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 2)
  | 7 => .win 7 (FullWinWitness.standard (.triplet 7) (.triplet 19) (.sequence 1 5) (.sequence 2 2) 8)
  | 8 => .win 2 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 2) 2)
  | 9 => .win 11 (FullWinWitness.standard (.triplet 19) (.sequence 1 0) (.sequence 1 5) (.sequence 2 2) 8)
  | 10 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 10)
  | 11 => .win 9 (FullWinWitness.standard (.triplet 19) (.sequence 1 0) (.sequence 1 5) (.sequence 2 2) 8)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 19) (.sequence 1 1) (.sequence 1 5) (.sequence 2 2) 8)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 19) (.sequence 1 3) (.sequence 1 6) (.sequence 2 2) 8)
  | 14 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 6) (.sequence 2 2) 14)
  | 15 => .win 13 (FullWinWitness.standard (.triplet 19) (.sequence 1 4) (.sequence 1 6) (.sequence 2 2) 8)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 1 6) (.sequence 2 2) 8)
  | 17 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 17)
  | 18 => .win 6 (FullWinWitness.standard (.sequence 0 6) (.sequence 1 5) (.sequence 2 0) (.sequence 2 3) 19)
  | 19 => .win 18 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 0) (.sequence 2 3) 8)
  | 20 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 20)
  | 21 => .win 6 (FullWinWitness.standard (.sequence 0 6) (.sequence 1 5) (.sequence 2 1) (.sequence 2 3) 19)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 2) (.sequence 2 3) 8)
  | 23 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 23)
  | 24 => .win 6 (FullWinWitness.standard (.sequence 0 6) (.sequence 1 5) (.sequence 2 1) (.sequence 2 4) 19)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 2) (.sequence 2 5) 8)
  | 26 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 26)
  | 27 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 27)
  | 28 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 28)
  | 29 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 29)
  | 30 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 30)
  | 31 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row124 : Row := ⟨124, state124, 124, action124⟩

def state125 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 5 | 6 | 9 | 10 | 12 | 13 | 18 | 24 | 25 => 0
  | 2 | 7 | 11 | 14 | 15 | 16 | 17 | 20 | 21 | 22 | 23 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 8 => 2
  | 19 => 3
  | _ => 0

def action125 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 1 (FullWinWitness.standard (.triplet 19) (.sequence 0 0) (.sequence 1 5) (.sequence 2 2) 8)
  | 1 => .win 0 (FullWinWitness.standard (.triplet 19) (.sequence 0 0) (.sequence 1 5) (.sequence 2 2) 8)
  | 2 => .win 2 (FullWinWitness.standard (.triplet 2) (.triplet 19) (.sequence 1 5) (.sequence 2 2) 8)
  | 3 => .win 1 (FullWinWitness.standard (.triplet 19) (.sequence 0 1) (.sequence 1 5) (.sequence 2 2) 8)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 19) (.sequence 0 2) (.sequence 1 5) (.sequence 2 2) 8)
  | 5 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 5) (.sequence 2 2) 8)
  | 6 => .win 2 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 2)
  | 7 => .win 7 (FullWinWitness.standard (.triplet 7) (.triplet 19) (.sequence 1 5) (.sequence 2 2) 8)
  | 8 => .win 2 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 2) 2)
  | 9 => .win 10 (FullWinWitness.standard (.triplet 19) (.sequence 1 0) (.sequence 1 5) (.sequence 2 2) 8)
  | 10 => .win 9 (FullWinWitness.standard (.triplet 19) (.sequence 1 0) (.sequence 1 5) (.sequence 2 2) 8)
  | 11 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 11)
  | 12 => .win 10 (FullWinWitness.standard (.triplet 19) (.sequence 1 1) (.sequence 1 5) (.sequence 2 2) 8)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 19) (.sequence 1 2) (.sequence 1 5) (.sequence 2 2) 8)
  | 14 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 6) (.sequence 2 2) 14)
  | 15 => .win 13 (FullWinWitness.standard (.triplet 19) (.sequence 1 4) (.sequence 1 6) (.sequence 2 2) 8)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 1 6) (.sequence 2 2) 8)
  | 17 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 17)
  | 18 => .win 6 (FullWinWitness.standard (.sequence 0 6) (.sequence 1 5) (.sequence 2 0) (.sequence 2 3) 19)
  | 19 => .win 18 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 0) (.sequence 2 3) 8)
  | 20 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 20)
  | 21 => .win 6 (FullWinWitness.standard (.sequence 0 6) (.sequence 1 5) (.sequence 2 1) (.sequence 2 3) 19)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 2) (.sequence 2 3) 8)
  | 23 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 23)
  | 24 => .win 6 (FullWinWitness.standard (.sequence 0 6) (.sequence 1 5) (.sequence 2 1) (.sequence 2 4) 19)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 2) (.sequence 2 5) 8)
  | 26 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 26)
  | 27 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 27)
  | 28 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 28)
  | 29 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 29)
  | 30 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 30)
  | 31 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row125 : Row := ⟨125, state125, 125, action125⟩

def state126 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 5 | 6 | 10 | 11 | 12 | 13 | 19 | 20 | 24 | 27 => 0
  | 2 | 7 | 9 | 14 | 15 | 16 | 17 | 18 | 22 | 23 | 26 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 8 | 21 => 2
  | 25 => 3
  | _ => 0

def action126 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 1 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 1 => .win 0 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 2 => .win 2 (FullWinWitness.standard (.triplet 2) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 8)
  | 3 => .win 1 (FullWinWitness.standard (.triplet 25) (.sequence 0 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 25) (.sequence 0 2) (.sequence 1 5) (.sequence 2 3) 8)
  | 5 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 5) (.sequence 2 3) 8)
  | 6 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 2)
  | 7 => .win 7 (FullWinWitness.standard (.triplet 7) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 8)
  | 8 => .win 2 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 2)
  | 9 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 9)
  | 10 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 1 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 11 => .win 10 (FullWinWitness.standard (.triplet 25) (.sequence 1 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 12 => .win 13 (FullWinWitness.standard (.triplet 25) (.sequence 1 3) (.sequence 1 6) (.sequence 2 3) 8)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 25) (.sequence 1 3) (.sequence 1 6) (.sequence 2 3) 8)
  | 14 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 6) (.sequence 2 3) 14)
  | 15 => .win 13 (FullWinWitness.standard (.triplet 25) (.sequence 1 4) (.sequence 1 6) (.sequence 2 3) 8)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 1 6) (.sequence 2 3) 8)
  | 17 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 17)
  | 18 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 18)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 0) (.sequence 2 3) 8)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 0) (.sequence 2 3) 8)
  | 21 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 21)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 2) (.sequence 2 3) 8)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 3) (.sequence 2 3) 8)
  | 24 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 4) 21)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 3) (.sequence 2 6) 8)
  | 26 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 26)
  | 27 => .win 0 (FullWinWitness.orphans 8)
  | 28 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 28)
  | 29 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 29)
  | 30 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 30)
  | 31 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row126 : Row := ⟨126, state126, 126, action126⟩

def state127 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 5 | 6 | 9 | 11 | 15 | 16 | 19 | 20 | 21 | 22 => 0
  | 4 | 7 | 12 | 13 | 17 | 18 | 23 | 24 | 25 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 8 | 14 => 2
  | 10 => 3
  | _ => 0

def action127 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 9 (FullWinWitness.orphans 8)
  | 1 => .back 10 25 []
  | 2 => .win 3 (FullWinWitness.standard (.triplet 10) (.sequence 0 2) (.sequence 1 3) (.sequence 2 5) 8)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 10) (.sequence 0 2) (.sequence 1 3) (.sequence 2 5) 8)
  | 4 => .win 4 (FullWinWitness.standard (.triplet 4) (.triplet 10) (.sequence 1 3) (.sequence 2 5) 8)
  | 5 => .win 3 (FullWinWitness.standard (.triplet 10) (.sequence 0 3) (.sequence 1 3) (.sequence 2 5) 8)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 4)
  | 7 => .win 7 (FullWinWitness.standard (.triplet 7) (.triplet 10) (.sequence 1 3) (.sequence 2 5) 8)
  | 8 => .win 4 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 1 3) (.sequence 2 5) 4)
  | 9 => .win 0 (FullWinWitness.orphans 8)
  | 10 => .back 1 25 []
  | 11 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 14)
  | 12 => .win 13 (FullWinWitness.standard (.triplet 10) (.sequence 1 3) (.sequence 1 3) (.sequence 2 5) 8)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 10) (.sequence 1 3) (.sequence 1 3) (.sequence 2 5) 8)
  | 14 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 14)
  | 15 => .win 13 (FullWinWitness.standard (.triplet 10) (.sequence 1 3) (.sequence 1 4) (.sequence 2 5) 8)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 10) (.sequence 1 3) (.sequence 1 5) (.sequence 2 5) 8)
  | 17 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 17)
  | 18 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 18)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 10) (.sequence 1 3) (.sequence 2 0) (.sequence 2 5) 8)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 10) (.sequence 1 3) (.sequence 2 0) (.sequence 2 5) 8)
  | 21 => .win 22 (FullWinWitness.standard (.triplet 10) (.sequence 1 3) (.sequence 2 3) (.sequence 2 6) 8)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 10) (.sequence 1 3) (.sequence 2 3) (.sequence 2 6) 8)
  | 23 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 6) 23)
  | 24 => .win 22 (FullWinWitness.standard (.triplet 10) (.sequence 1 3) (.sequence 2 4) (.sequence 2 6) 8)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 1 3) (.sequence 2 5) (.sequence 2 6) 8)
  | 26 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 26)
  | 27 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 27)
  | 28 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 28)
  | 29 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 29)
  | 30 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 30)
  | 31 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row127 : Row := ⟨127, state127, 127, action127⟩

end Mahjong.Scale12V2
