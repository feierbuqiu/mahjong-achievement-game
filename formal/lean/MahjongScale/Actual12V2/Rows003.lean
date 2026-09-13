import MahjongScale.Actual12V2.Base

set_option maxRecDepth 32768
set_option maxHeartbeats 100000000

namespace Mahjong.Scale12V2
open ResponseTable ResponseCertificate Generators

def state192 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 19 | 20 | 24 | 27 | 28 | 29 | 30 => 0
  | 1 | 5 | 6 | 7 | 8 | 10 | 13 | 16 | 18 | 21 | 23 | 26 | 31 | 32 | 33 => 1
  | 17 | 22 => 2
  | 25 => 3
  | _ => 0

def action192 (t : Tile) : Action :=
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
  | 21 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 2) (.sequence 2 3) 17)
  | 22 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 22)
  | 23 => .win 21 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 24 => .win 15 (FullWinWitness.standard (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) (.sequence 2 6) 25)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 6) 17)
  | 26 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 26)
  | 27 => .back 28 63 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 63 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 63 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 63 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row192 : Row := ⟨192, state192, 192, action192⟩

def state193 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 19 | 20 | 24 | 27 | 28 | 29 | 30 => 0
  | 1 | 5 | 6 | 7 | 8 | 10 | 13 | 16 | 18 | 22 | 23 | 26 | 31 | 32 | 33 => 1
  | 17 | 21 => 2
  | 25 => 3
  | _ => 0

def action193 (t : Tile) : Action :=
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
  | 27 => .back 28 64 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 64 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 64 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 64 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row193 : Row := ⟨193, state193, 193, action193⟩

def state194 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 5 | 6 | 9 | 11 | 12 | 13 | 19 | 20 | 24 | 27 | 28 | 29 => 0
  | 1 | 7 | 10 | 14 | 15 | 16 | 17 | 18 | 22 | 23 | 26 | 30 | 31 | 32 | 33 => 1
  | 8 | 21 => 2
  | 25 => 3
  | _ => 0

def action194 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 1 => .win 1 (FullWinWitness.standard (.triplet 1) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 8)
  | 2 => .win 0 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 4 => .back 27 64 [.swapSuits 0 1, .swapHonors 0 2, .swapHonors 1 2]
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
  | 27 => .back 28 65 [.swapHonors 0 2]
  | 28 => .back 27 65 [.swapHonors 0 1, .swapHonors 1 2]
  | 29 => .back 27 65 [.swapHonors 0 1]
  | 30 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 30)
  | 31 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row194 : Row := ⟨194, state194, 194, action194⟩

def state195 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 19 | 20 | 24 | 27 | 28 | 29 | 30 => 0
  | 1 | 5 | 6 | 7 | 8 | 10 | 13 | 16 | 18 | 21 | 22 | 26 | 31 | 32 | 33 => 1
  | 17 | 23 => 2
  | 25 => 3
  | _ => 0

def action195 (t : Tile) : Action :=
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
  | 27 => .back 28 66 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 66 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 66 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 66 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row195 : Row := ⟨195, state195, 195, action195⟩

def state196 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 18 | 20 | 24 | 27 | 28 | 29 | 30 => 0
  | 1 | 5 | 6 | 7 | 8 | 10 | 13 | 16 | 19 | 21 | 22 | 26 | 31 | 32 | 33 => 1
  | 17 | 23 => 2
  | 25 => 3
  | _ => 0

def action196 (t : Tile) : Action :=
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
  | 27 => .back 28 67 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 67 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 67 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 67 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row196 : Row := ⟨196, state196, 196, action196⟩

def state197 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 18 | 20 | 24 | 27 | 28 | 29 | 30 => 0
  | 1 | 5 | 6 | 7 | 8 | 10 | 13 | 16 | 19 | 21 | 23 | 26 | 31 | 32 | 33 => 1
  | 17 | 22 => 2
  | 25 => 3
  | _ => 0

def action197 (t : Tile) : Action :=
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
  | 27 => .back 28 68 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 68 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 68 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 68 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row197 : Row := ⟨197, state197, 197, action197⟩

def state198 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 5 | 6 | 9 | 11 | 12 | 13 | 18 | 20 | 24 | 27 | 28 => 0
  | 1 | 7 | 10 | 14 | 15 | 16 | 17 | 19 | 21 | 22 | 23 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 8 => 2
  | 25 => 3
  | _ => 0

def action198 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 1 => .win 1 (FullWinWitness.standard (.triplet 1) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 8)
  | 2 => .win 0 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 4 => .back 22 68 [.swapSuits 0 1]
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
  | 22 => .back 4 68 [.swapSuits 0 1]
  | 23 => .back 27 69 [.swapHonors 0 1]
  | 24 => .win 6 (FullWinWitness.standard (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) (.sequence 2 6) 25)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 3) (.sequence 2 6) 8)
  | 26 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 26)
  | 27 => .back 23 69 [.swapHonors 0 1]
  | 28 => .back 23 69 []
  | 29 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 29)
  | 30 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 30)
  | 31 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row198 : Row := ⟨198, state198, 198, action198⟩

def state199 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 6 | 9 | 11 | 12 | 13 | 14 | 16 | 18 | 20 | 21 | 22 | 27 | 28 => 0
  | 2 | 3 | 4 | 5 | 8 | 10 | 15 | 19 | 23 | 24 | 25 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 7 => 3
  | 17 => 2
  | _ => 0

def action199 (t : Tile) : Action :=
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
  | 27 => .back 28 70 [.swapHonors 0 1]
  | 28 => .back 27 70 []
  | 29 => .win 16 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 6) (.sequence 2 5) 29)
  | 30 => .win 16 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 6) (.sequence 2 5) 30)
  | 31 => .win 16 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 6) (.sequence 2 5) 31)
  | 32 => .win 16 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 6) (.sequence 2 5) 32)
  | 33 => .win 16 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 6) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row199 : Row := ⟨199, state199, 199, action199⟩

def state200 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 6 | 9 | 11 | 12 | 13 | 18 | 20 | 21 | 23 | 24 | 25 | 27 | 28 => 0
  | 3 | 5 | 8 | 10 | 14 | 15 | 16 | 17 | 19 | 22 | 29 | 30 | 31 | 32 | 33 => 1
  | 4 | 26 => 2
  | 7 => 3
  | _ => 0

def action200 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 25 63 [.swapSuits 0 2, .swapSuits 1 2]
  | 1 => .back 25 68 [.swapSuits 0 2, .swapSuits 1 2]
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
  | 25 => .back 0 63 [.swapSuits 0 2, .swapSuits 1 2]
  | 26 => .win 4 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 4)
  | 27 => .back 28 71 [.swapHonors 0 1]
  | 28 => .back 27 71 []
  | 29 => .win 26 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 29)
  | 30 => .win 26 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 30)
  | 31 => .win 26 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 31)
  | 32 => .win 26 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 32)
  | 33 => .win 26 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row200 : Row := ⟨200, state200, 200, action200⟩

def state201 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 6 | 9 | 11 | 12 | 13 | 14 | 15 | 18 | 20 | 21 | 22 | 27 | 28 => 0
  | 3 | 4 | 8 | 10 | 16 | 19 | 23 | 24 | 25 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 5 | 17 => 2
  | 7 => 3
  | _ => 0

def action201 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 13 66 [.swapSuits 0 2]
  | 1 => .back 27 69 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 0 1]
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
  | 13 => .back 0 66 [.swapSuits 0 2]
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
  | 27 => .back 1 69 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 0 1]
  | 28 => .back 1 69 [.swapSuits 0 2, .swapSuits 1 2]
  | 29 => .win 15 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 6) (.sequence 2 5) 29)
  | 30 => .win 15 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 6) (.sequence 2 5) 30)
  | 31 => .win 15 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 6) (.sequence 2 5) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 6) (.sequence 2 5) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 6) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row201 : Row := ⟨201, state201, 201, action201⟩

def state202 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 6 | 9 | 11 | 12 | 13 | 15 | 16 | 18 | 20 | 21 | 22 | 27 | 28 => 0
  | 2 | 3 | 4 | 5 | 8 | 10 | 14 | 19 | 23 | 24 | 25 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 7 => 3
  | 17 => 2
  | _ => 0

def action202 (t : Tile) : Action :=
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
  | 27 => .back 28 72 [.swapHonors 0 1]
  | 28 => .back 27 72 []
  | 29 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 2) (.sequence 2 5) 29)
  | 30 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 2) (.sequence 2 5) 30)
  | 31 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 2) (.sequence 2 5) 31)
  | 32 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 2) (.sequence 2 5) 32)
  | 33 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 2) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row202 : Row := ⟨202, state202, 202, action202⟩

def state203 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 5 | 6 | 9 | 11 | 12 | 13 | 19 | 20 | 24 | 27 | 28 => 0
  | 1 | 7 | 10 | 14 | 15 | 16 | 17 | 18 | 21 | 22 | 23 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 8 => 2
  | 25 => 3
  | _ => 0

def action203 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 1 => .win 1 (FullWinWitness.standard (.triplet 1) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 8)
  | 2 => .win 0 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 4 => .back 23 66 [.swapSuits 0 1]
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
  | 21 => .back 27 65 [.swapHonors 0 1]
  | 22 => .back 4 63 [.swapSuits 0 1]
  | 23 => .back 4 66 [.swapSuits 0 1]
  | 24 => .win 6 (FullWinWitness.standard (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) (.sequence 2 6) 25)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 3) (.sequence 2 6) 8)
  | 26 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 26)
  | 27 => .back 21 65 [.swapHonors 0 1]
  | 28 => .back 21 65 []
  | 29 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 29)
  | 30 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 30)
  | 31 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row203 : Row := ⟨203, state203, 203, action203⟩

def state204 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 6 | 9 | 11 | 12 | 13 | 14 | 15 | 18 | 20 | 21 | 22 | 27 | 28 => 0
  | 3 | 17 => 2
  | 4 | 5 | 8 | 10 | 16 | 19 | 23 | 24 | 25 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 7 => 3
  | _ => 0

def action204 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 27 65 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 0 1]
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
  | 13 => .back 0 64 [.swapSuits 0 2]
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
  | 27 => .back 0 65 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 0 1]
  | 28 => .back 0 65 [.swapSuits 0 2, .swapSuits 1 2]
  | 29 => .win 15 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 6) (.sequence 2 5) 29)
  | 30 => .win 15 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 6) (.sequence 2 5) 30)
  | 31 => .win 15 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 6) (.sequence 2 5) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 6) (.sequence 2 5) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 6) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row204 : Row := ⟨204, state204, 204, action204⟩

def state205 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 6 | 9 | 11 | 12 | 13 | 14 | 15 | 16 | 18 | 20 | 21 | 22 => 0
  | 3 | 4 | 5 | 8 | 10 | 19 | 23 | 24 | 25 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 7 => 3
  | 17 => 2
  | _ => 0

def action205 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 16 73 [.swapSuits 0 2, .swapSuits 1 2]
  | 1 => .back 16 74 [.swapSuits 0 2, .swapSuits 1 2]
  | 2 => .back 15 70 []
  | 3 => .back 16 75 []
  | 4 => .back 13 71 [.swapSuits 1 2]
  | 5 => .back 16 76 []
  | 6 => .win 7 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 0 6) (.sequence 2 5) 17)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 0 6) (.sequence 2 5) 17)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 7) (.triplet 8) (.sequence 0 3) (.sequence 2 5) 17)
  | 9 => .win 11 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 0) (.sequence 2 5) 17)
  | 10 => .win 10 (FullWinWitness.standard (.triplet 7) (.triplet 10) (.sequence 0 3) (.sequence 2 5) 17)
  | 11 => .win 9 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 0) (.sequence 2 5) 17)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 1) (.sequence 2 5) 17)
  | 13 => .back 4 71 [.swapSuits 1 2]
  | 14 => .back 2 72 []
  | 15 => .back 2 70 []
  | 16 => .back 0 73 [.swapSuits 0 2, .swapSuits 1 2]
  | 17 => .win 6 (FullWinWitness.standard (.triplet 17) (.sequence 0 3) (.sequence 0 6) (.sequence 2 5) 7)
  | 18 => .win 20 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 2 0) (.sequence 2 5) 17)
  | 19 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 3) (.sequence 2 5) 19)
  | 20 => .win 18 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 2 0) (.sequence 2 5) 17)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 2 1) (.sequence 2 5) 17)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 2 3) (.sequence 2 6) 17)
  | 23 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 3) (.sequence 2 6) 23)
  | 24 => .win 22 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 2 4) (.sequence 2 6) 17)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 2 5) (.sequence 2 6) 17)
  | 26 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 3) (.sequence 2 5) 26)
  | 27 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 3) (.sequence 2 5) 27)
  | 28 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 3) (.sequence 2 5) 28)
  | 29 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 3) (.sequence 2 5) 29)
  | 30 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 3) (.sequence 2 5) 30)
  | 31 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 3) (.sequence 2 5) 31)
  | 32 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 3) (.sequence 2 5) 32)
  | 33 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 3) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row205 : Row := ⟨205, state205, 205, action205⟩

def state206 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 19 | 20 | 24 | 27 | 28 | 29 | 30 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 13 | 16 | 18 | 21 | 23 | 26 | 31 | 32 | 33 => 1
  | 17 | 22 => 2
  | 25 => 3
  | _ => 0

def action206 (t : Tile) : Action :=
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
  | 27 => .back 28 77 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 77 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 77 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 77 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row206 : Row := ⟨206, state206, 206, action206⟩

def state207 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 19 | 20 | 24 | 27 | 28 | 29 | 30 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 13 | 16 | 18 | 22 | 23 | 26 | 31 | 32 | 33 => 1
  | 17 | 21 => 2
  | 25 => 3
  | _ => 0

def action207 (t : Tile) : Action :=
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
  | 27 => .back 28 78 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 78 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 78 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 78 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row207 : Row := ⟨207, state207, 207, action207⟩

def state208 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 13 | 14 | 15 | 19 | 20 | 24 | 27 | 28 | 29 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 16 | 18 | 22 | 23 | 26 | 30 | 31 | 32 | 33 => 1
  | 17 | 21 => 2
  | 25 => 3
  | _ => 0

def action208 (t : Tile) : Action :=
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
  | 13 => .back 27 78 [.swapHonors 0 2, .swapHonors 1 2]
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
  | 27 => .back 28 79 [.swapHonors 0 2]
  | 28 => .back 27 79 [.swapHonors 0 1, .swapHonors 1 2]
  | 29 => .back 27 79 [.swapHonors 0 1]
  | 30 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 30)
  | 31 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row208 : Row := ⟨208, state208, 208, action208⟩

def state209 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 19 | 20 | 24 | 27 | 28 | 29 | 30 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 13 | 16 | 18 | 21 | 22 | 26 | 31 | 32 | 33 => 1
  | 17 | 23 => 2
  | 25 => 3
  | _ => 0

def action209 (t : Tile) : Action :=
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
  | 27 => .back 28 80 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 80 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 80 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 80 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row209 : Row := ⟨209, state209, 209, action209⟩

def state210 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 18 | 20 | 24 | 27 | 28 | 29 | 30 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 13 | 16 | 19 | 21 | 22 | 26 | 31 | 32 | 33 => 1
  | 17 | 23 => 2
  | 25 => 3
  | _ => 0

def action210 (t : Tile) : Action :=
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
  | 27 => .back 28 81 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 81 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 81 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 81 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row210 : Row := ⟨210, state210, 210, action210⟩

def state211 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 18 | 20 | 24 | 27 | 28 | 29 | 30 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 13 | 16 | 19 | 21 | 23 | 26 | 31 | 32 | 33 => 1
  | 17 | 22 => 2
  | 25 => 3
  | _ => 0

def action211 (t : Tile) : Action :=
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
  | 27 => .back 28 82 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 82 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 82 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 82 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row211 : Row := ⟨211, state211, 211, action211⟩

def state212 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 10 | 15 | 18 | 20 | 21 | 22 | 23 | 25 | 27 | 28 => 0
  | 2 | 5 | 6 | 7 | 8 | 11 | 12 | 13 | 14 | 17 | 19 | 24 | 29 | 30 | 31 | 32 | 33 => 1
  | 16 => 3
  | 26 => 2
  | _ => 0

def action212 (t : Tile) : Action :=
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
  | 27 => .back 28 83 [.swapHonors 0 1]
  | 28 => .back 27 83 []
  | 29 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 2) (.sequence 2 6) 29)
  | 30 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 2) (.sequence 2 6) 30)
  | 31 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 2) (.sequence 2 6) 31)
  | 32 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 2) (.sequence 2 6) 32)
  | 33 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 2) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row212 : Row := ⟨212, state212, 212, action212⟩

def state213 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 6 | 9 | 10 | 12 | 13 | 18 | 20 | 21 | 22 | 23 | 24 | 27 | 28 => 0
  | 3 | 4 | 8 | 11 | 14 | 15 | 16 | 17 | 19 | 25 | 29 | 30 | 31 | 32 | 33 => 1
  | 5 | 26 => 2
  | 7 => 3
  | _ => 0

def action213 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 22 80 [.swapSuits 0 2, .swapSuits 1 2]
  | 1 => .back 22 81 [.swapSuits 0 2, .swapSuits 1 2]
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
  | 22 => .back 1 81 [.swapSuits 0 2, .swapSuits 1 2]
  | 23 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 5) 26)
  | 24 => .win 2 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 5) (.sequence 2 6) 5)
  | 25 => .win 25 (FullWinWitness.standard (.triplet 7) (.triplet 25) (.sequence 0 3) (.sequence 1 5) 26)
  | 26 => .win 2 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 2) (.sequence 1 5) 5)
  | 27 => .back 28 84 [.swapHonors 0 1]
  | 28 => .back 27 84 []
  | 29 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 29)
  | 30 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 30)
  | 31 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row213 : Row := ⟨213, state213, 213, action213⟩

def state214 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 10 | 15 | 18 | 20 | 21 | 22 | 24 | 25 | 27 | 28 => 0
  | 2 | 5 | 6 | 7 | 8 | 11 | 12 | 13 | 14 | 17 | 19 | 23 | 29 | 30 | 31 | 32 | 33 => 1
  | 16 => 3
  | 26 => 2
  | _ => 0

def action214 (t : Tile) : Action :=
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
  | 27 => .back 28 85 [.swapHonors 0 1]
  | 28 => .back 27 85 []
  | 29 => .win 26 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 5) (.sequence 1 2) 29)
  | 30 => .win 26 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 5) (.sequence 1 2) 30)
  | 31 => .win 26 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 5) (.sequence 1 2) 31)
  | 32 => .win 26 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 5) (.sequence 1 2) 32)
  | 33 => .win 26 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 5) (.sequence 1 2) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row214 : Row := ⟨214, state214, 214, action214⟩

def state215 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 13 | 14 | 15 | 18 | 20 | 24 | 27 | 28 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 16 | 19 | 21 | 22 | 23 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 17 => 2
  | 25 => 3
  | _ => 0

def action215 (t : Tile) : Action :=
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
  | 13 => .back 23 81 []
  | 14 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 5) (.sequence 2 3) 17)
  | 15 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 2)
  | 16 => .win 16 (FullWinWitness.standard (.triplet 16) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 17 => .win 2 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 2)
  | 18 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 19 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 19)
  | 20 => .win 18 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 1) (.sequence 2 3) 17)
  | 22 => .back 13 82 []
  | 23 => .back 13 81 []
  | 24 => .win 15 (FullWinWitness.standard (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) (.sequence 2 6) 25)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 6) 17)
  | 26 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 26)
  | 27 => .back 28 86 [.swapHonors 0 1]
  | 28 => .back 27 86 []
  | 29 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 29)
  | 30 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 30)
  | 31 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row215 : Row := ⟨215, state215, 215, action215⟩

def state216 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 6 | 9 | 10 | 12 | 13 | 18 | 20 | 21 | 23 | 24 | 25 | 27 | 28 => 0
  | 3 | 5 | 8 | 11 | 14 | 15 | 16 | 17 | 19 | 22 | 29 | 30 | 31 | 32 | 33 => 1
  | 4 | 26 => 2
  | 7 => 3
  | _ => 0

def action216 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 25 77 [.swapSuits 0 2, .swapSuits 1 2]
  | 1 => .back 25 82 [.swapSuits 0 2, .swapSuits 1 2]
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
  | 25 => .back 0 77 [.swapSuits 0 2, .swapSuits 1 2]
  | 26 => .win 4 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 4)
  | 27 => .back 28 87 [.swapHonors 0 1]
  | 28 => .back 27 87 []
  | 29 => .win 26 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 29)
  | 30 => .win 26 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 30)
  | 31 => .win 26 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 31)
  | 32 => .win 26 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 32)
  | 33 => .win 26 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row216 : Row := ⟨216, state216, 216, action216⟩

def state217 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 13 | 14 | 15 | 19 | 20 | 24 | 27 | 28 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 16 | 18 | 21 | 22 | 23 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 17 => 2
  | 25 => 3
  | _ => 0

def action217 (t : Tile) : Action :=
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
  | 13 => .back 22 77 []
  | 14 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 5) (.sequence 2 3) 17)
  | 15 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 2)
  | 16 => .win 16 (FullWinWitness.standard (.triplet 16) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 17 => .win 2 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 2)
  | 18 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 18)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 21 => .back 27 79 [.swapHonors 0 1]
  | 22 => .back 13 77 []
  | 23 => .back 13 80 []
  | 24 => .win 15 (FullWinWitness.standard (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) (.sequence 2 6) 25)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 6) 17)
  | 26 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 26)
  | 27 => .back 21 79 [.swapHonors 0 1]
  | 28 => .back 21 79 []
  | 29 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 29)
  | 30 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 30)
  | 31 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row217 : Row := ⟨217, state217, 217, action217⟩

def state218 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 6 | 9 | 10 | 12 | 13 | 18 | 20 | 21 | 22 | 23 | 24 | 27 | 28 => 0
  | 3 | 26 => 2
  | 4 | 5 | 8 | 11 | 14 | 15 | 16 | 17 | 19 | 25 | 29 | 30 | 31 | 32 | 33 => 1
  | 7 => 3
  | _ => 0

def action218 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 27 79 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 0 1]
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
  | 22 => .back 0 78 [.swapSuits 0 2, .swapSuits 1 2]
  | 23 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 5) 26)
  | 24 => .win 3 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 3)
  | 25 => .win 25 (FullWinWitness.standard (.triplet 7) (.triplet 25) (.sequence 0 3) (.sequence 1 5) 26)
  | 26 => .win 3 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 3)
  | 27 => .back 0 79 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 0 1]
  | 28 => .back 0 79 [.swapSuits 0 2, .swapSuits 1 2]
  | 29 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 29)
  | 30 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 30)
  | 31 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row218 : Row := ⟨218, state218, 218, action218⟩

def state219 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 6 | 9 | 10 | 12 | 13 | 18 | 20 | 21 | 22 | 23 | 24 | 25 => 0
  | 3 | 4 | 5 | 8 | 11 | 14 | 15 | 16 | 17 | 19 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 7 => 3
  | 26 => 2
  | _ => 0

def action219 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 25 88 [.swapSuits 0 2, .swapSuits 1 2]
  | 1 => .back 25 86 [.swapSuits 0 2, .swapSuits 1 2]
  | 2 => .back 24 83 [.swapSuits 0 1]
  | 3 => .back 25 89 []
  | 4 => .back 22 87 []
  | 5 => .back 25 84 []
  | 6 => .win 7 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 0 6) (.sequence 1 5) 26)
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
  | 22 => .back 4 87 []
  | 23 => .back 2 85 [.swapSuits 0 1]
  | 24 => .back 2 83 [.swapSuits 0 1]
  | 25 => .back 5 84 []
  | 26 => .win 6 (FullWinWitness.standard (.triplet 26) (.sequence 0 3) (.sequence 0 6) (.sequence 1 5) 7)
  | 27 => .win 26 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 27)
  | 28 => .win 26 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 28)
  | 29 => .win 26 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 29)
  | 30 => .win 26 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 30)
  | 31 => .win 26 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 31)
  | 32 => .win 26 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 32)
  | 33 => .win 26 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row219 : Row := ⟨219, state219, 219, action219⟩

def state220 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 5 | 7 | 10 | 11 | 12 | 13 | 19 | 20 | 24 | 27 | 28 | 29 => 0
  | 1 | 6 | 9 | 14 | 15 | 16 | 17 | 18 | 22 | 23 | 26 | 30 | 31 | 32 | 33 => 1
  | 8 | 21 => 2
  | 25 => 3
  | _ => 0

def action220 (t : Tile) : Action :=
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
  | 27 => .back 28 90 [.swapHonors 0 2]
  | 28 => .back 27 90 [.swapHonors 0 1, .swapHonors 1 2]
  | 29 => .back 27 90 [.swapHonors 0 1]
  | 30 => .win 7 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 30)
  | 31 => .win 7 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 31)
  | 32 => .win 7 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 32)
  | 33 => .win 7 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row220 : Row := ⟨220, state220, 220, action220⟩

def state221 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 6 | 7 | 10 | 11 | 12 | 13 | 19 | 20 | 24 | 27 | 28 | 29 => 0
  | 1 | 5 | 9 | 14 | 15 | 16 | 17 | 18 | 22 | 23 | 26 | 30 | 31 | 32 | 33 => 1
  | 8 | 21 => 2
  | 25 => 3
  | _ => 0

def action221 (t : Tile) : Action :=
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
  | 27 => .back 28 91 [.swapHonors 0 2]
  | 28 => .back 27 91 [.swapHonors 0 1, .swapHonors 1 2]
  | 29 => .back 27 91 [.swapHonors 0 1]
  | 30 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 30)
  | 31 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 31)
  | 32 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 32)
  | 33 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row221 : Row := ⟨221, state221, 221, action221⟩

def state222 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 16 | 19 | 20 | 24 | 27 | 28 | 29 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 13 | 18 | 22 | 23 | 26 | 30 | 31 | 32 | 33 => 1
  | 17 | 21 => 2
  | 25 => 3
  | _ => 0

def action222 (t : Tile) : Action :=
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
  | 15 => .win 14 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 4) (.sequence 2 3) 17)
  | 16 => .back 27 78 [.swapHonors 0 2, .swapHonors 1 2]
  | 17 => .win 2 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 2)
  | 18 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 18)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 21 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 21)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 2) (.sequence 2 3) 17)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 24 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 4) 21)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 6) 17)
  | 26 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 26)
  | 27 => .back 16 78 [.swapHonors 0 2, .swapHonors 1 2]
  | 28 => .back 16 78 [.swapHonors 1 2]
  | 29 => .back 16 78 []
  | 30 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 30)
  | 31 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 31)
  | 32 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 32)
  | 33 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row222 : Row := ⟨222, state222, 222, action222⟩

def state223 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 4 | 9 | 11 | 12 | 13 | 14 | 15 | 16 | 19 | 20 | 24 | 27 => 0
  | 5 | 6 | 7 | 8 | 10 | 18 | 22 | 23 | 26 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 17 | 21 => 2
  | 25 => 3
  | _ => 0

def action223 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 15 90 [.swapSuits 0 1]
  | 1 => .back 16 65 [.swapSuits 0 1]
  | 2 => .back 16 79 []
  | 3 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 3) (.sequence 0 6) (.sequence 2 3) 17)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 25) (.sequence 0 3) (.sequence 0 6) (.sequence 2 3) 17)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 25) (.sequence 0 6) (.sequence 2 3) 17)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 4) (.sequence 0 6) (.sequence 2 3) 17)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 0 6) (.sequence 2 3) 17)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 9 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 0) (.sequence 2 3) 17)
  | 10 => .win 10 (FullWinWitness.standard (.triplet 10) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 11 => .win 9 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 0) (.sequence 2 3) 17)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 1) (.sequence 2 3) 17)
  | 13 => .back 27 92 []
  | 14 => .back 0 91 [.swapSuits 0 1]
  | 15 => .back 0 90 [.swapSuits 0 1]
  | 16 => .back 2 79 []
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
  | 27 => .back 13 92 []
  | 28 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 28)
  | 29 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 29)
  | 30 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 30)
  | 31 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 31)
  | 32 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 32)
  | 33 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row223 : Row := ⟨223, state223, 223, action223⟩

def state224 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 5 | 6 | 9 | 11 | 15 | 19 | 20 | 21 | 22 | 27 | 28 | 29 | 30 => 0
  | 1 | 4 | 7 | 10 | 12 | 14 | 17 | 18 | 23 | 24 | 25 | 26 | 31 | 32 | 33 => 1
  | 8 | 13 => 2
  | 16 => 3
  | _ => 0

def action224 (t : Tile) : Action :=
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
  | 27 => .back 28 93 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 93 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 93 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 93 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row224 : Row := ⟨224, state224, 224, action224⟩

def state225 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 6 | 9 | 11 | 12 | 13 | 14 | 16 | 19 | 20 | 21 | 22 | 27 | 28 => 0
  | 2 | 3 | 4 | 5 | 8 | 10 | 15 | 18 | 23 | 24 | 25 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 7 => 3
  | 17 => 2
  | _ => 0

def action225 (t : Tile) : Action :=
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
  | 18 => .win 16 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 6) (.sequence 2 5) 18)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 2 0) (.sequence 2 5) 17)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 2 0) (.sequence 2 5) 17)
  | 21 => .win 22 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 2 3) (.sequence 2 6) 17)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 2 3) (.sequence 2 6) 17)
  | 23 => .win 16 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 6) (.sequence 2 6) 23)
  | 24 => .win 22 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 2 4) (.sequence 2 6) 17)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 2 5) (.sequence 2 6) 17)
  | 26 => .win 16 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 6) (.sequence 2 5) 26)
  | 27 => .back 28 94 [.swapHonors 0 1]
  | 28 => .back 27 94 []
  | 29 => .win 16 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 6) (.sequence 2 5) 29)
  | 30 => .win 16 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 6) (.sequence 2 5) 30)
  | 31 => .win 16 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 6) (.sequence 2 5) 31)
  | 32 => .win 16 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 6) (.sequence 2 5) 32)
  | 33 => .win 16 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 6) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row225 : Row := ⟨225, state225, 225, action225⟩

def state226 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 6 | 9 | 11 | 12 | 13 | 15 | 16 | 19 | 20 | 21 | 22 | 27 | 28 => 0
  | 2 | 3 | 4 | 5 | 8 | 10 | 14 | 18 | 23 | 24 | 25 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 7 => 3
  | 17 => 2
  | _ => 0

def action226 (t : Tile) : Action :=
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
  | 18 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 2) (.sequence 2 5) 18)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 2 0) (.sequence 2 5) 17)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 2 0) (.sequence 2 5) 17)
  | 21 => .win 22 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 2 3) (.sequence 2 6) 17)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 2 3) (.sequence 2 6) 17)
  | 23 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 2) (.sequence 2 6) 23)
  | 24 => .win 22 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 2 4) (.sequence 2 6) 17)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 2 5) (.sequence 2 6) 17)
  | 26 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 2) (.sequence 2 5) 26)
  | 27 => .back 28 95 [.swapHonors 0 1]
  | 28 => .back 27 95 []
  | 29 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 2) (.sequence 2 5) 29)
  | 30 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 2) (.sequence 2 5) 30)
  | 31 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 2) (.sequence 2 5) 31)
  | 32 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 2) (.sequence 2 5) 32)
  | 33 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 2) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row226 : Row := ⟨226, state226, 226, action226⟩

def state227 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 6 | 7 | 9 | 10 | 15 | 19 | 20 | 21 | 22 | 27 | 28 => 0
  | 2 | 5 | 11 | 12 | 13 | 14 | 17 | 18 | 23 | 24 | 25 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 8 => 2
  | 16 => 3
  | _ => 0

def action227 (t : Tile) : Action :=
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
  | 9 => .win 10 (FullWinWitness.standard (.triplet 16) (.sequence 1 0) (.sequence 1 3) (.sequence 2 5) 8)
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
  | 27 => .back 28 96 [.swapHonors 0 1]
  | 28 => .back 27 96 []
  | 29 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 2) (.sequence 2 5) 29)
  | 30 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 2) (.sequence 2 5) 30)
  | 31 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 2) (.sequence 2 5) 31)
  | 32 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 2) (.sequence 2 5) 32)
  | 33 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 2) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row227 : Row := ⟨227, state227, 227, action227⟩

def state228 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 5 | 7 | 9 | 10 | 15 | 18 | 20 | 21 | 22 | 27 | 28 => 0
  | 2 | 6 | 11 | 12 | 13 | 14 | 17 | 19 | 23 | 24 | 25 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 8 => 2
  | 16 => 3
  | _ => 0

def action228 (t : Tile) : Action :=
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
  | 27 => .back 28 97 [.swapHonors 0 1]
  | 28 => .back 27 97 []
  | 29 => .win 7 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 29)
  | 30 => .win 7 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 30)
  | 31 => .win 7 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 31)
  | 32 => .win 7 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 32)
  | 33 => .win 7 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row228 : Row := ⟨228, state228, 228, action228⟩

def state229 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 5 | 6 | 9 | 10 | 12 | 13 | 18 | 19 | 24 | 27 | 28 => 0
  | 2 | 7 | 11 | 14 | 15 | 16 | 17 | 20 | 21 | 22 | 23 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 8 => 2
  | 25 => 3
  | _ => 0

def action229 (t : Tile) : Action :=
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
  | 27 => .back 28 98 [.swapHonors 0 1]
  | 28 => .back 27 98 []
  | 29 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 29)
  | 30 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 30)
  | 31 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row229 : Row := ⟨229, state229, 229, action229⟩

def state230 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 5 | 6 | 9 | 10 | 15 | 19 | 20 | 21 | 22 | 27 | 28 => 0
  | 2 | 7 | 11 | 12 | 13 | 14 | 17 | 18 | 23 | 24 | 25 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 8 => 2
  | 16 => 3
  | _ => 0

def action230 (t : Tile) : Action :=
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
  | 18 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 18)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 1 2) (.sequence 2 0) (.sequence 2 5) 8)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 16) (.sequence 1 2) (.sequence 2 0) (.sequence 2 5) 8)
  | 21 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 1 2) (.sequence 2 3) (.sequence 2 6) 8)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 16) (.sequence 1 2) (.sequence 2 3) (.sequence 2 6) 8)
  | 23 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 6) 23)
  | 24 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 1 2) (.sequence 2 4) (.sequence 2 6) 8)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 1 2) (.sequence 2 5) (.sequence 2 6) 8)
  | 26 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 26)
  | 27 => .back 28 99 [.swapHonors 0 1]
  | 28 => .back 27 99 []
  | 29 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 29)
  | 30 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 30)
  | 31 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row230 : Row := ⟨230, state230, 230, action230⟩

def state231 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 5 | 6 | 9 | 10 | 15 | 18 | 20 | 21 | 22 | 27 | 28 => 0
  | 2 | 7 | 11 | 12 | 13 | 14 | 17 | 19 | 23 | 24 | 25 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 8 => 2
  | 16 => 3
  | _ => 0

def action231 (t : Tile) : Action :=
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
  | 27 => .back 28 100 [.swapHonors 0 1]
  | 28 => .back 27 100 []
  | 29 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 29)
  | 30 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 30)
  | 31 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row231 : Row := ⟨231, state231, 231, action231⟩

def state232 (t : Tile) : Nat :=
  match t.val with
  | 0 | 5 | 6 | 7 | 8 | 9 | 12 | 16 | 18 | 22 | 23 | 26 | 31 | 32 | 33 => 1
  | 1 | 2 | 3 | 4 | 10 | 11 | 13 | 14 | 15 | 19 | 20 | 24 | 27 | 28 | 29 | 30 => 0
  | 17 | 21 => 2
  | 25 => 3
  | _ => 0

def action232 (t : Tile) : Action :=
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
  | 27 => .back 28 101 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 101 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 101 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 101 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row232 : Row := ⟨232, state232, 232, action232⟩

def state233 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 4 | 5 | 6 | 10 | 11 | 12 | 13 | 19 | 20 | 24 | 27 | 28 | 29 => 0
  | 3 | 7 | 9 | 14 | 15 | 16 | 17 | 18 | 22 | 23 | 26 | 30 | 31 | 32 | 33 => 1
  | 8 | 21 => 2
  | 25 => 3
  | _ => 0

def action233 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 27 101 [.swapSuits 0 1, .swapHonors 0 2, .swapHonors 1 2]
  | 1 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 2 => .win 1 (FullWinWitness.standard (.triplet 25) (.sequence 0 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 3 => .win 3 (FullWinWitness.standard (.triplet 3) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 8)
  | 4 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 2) (.sequence 1 5) (.sequence 2 3) 8)
  | 5 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 3) (.sequence 1 5) (.sequence 2 3) 8)
  | 6 => .win 3 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 3)
  | 7 => .win 7 (FullWinWitness.standard (.triplet 7) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 8)
  | 8 => .win 3 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 3)
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
  | 27 => .back 0 101 [.swapSuits 0 1, .swapHonors 0 2, .swapHonors 1 2]
  | 28 => .back 0 101 [.swapSuits 0 1, .swapHonors 1 2]
  | 29 => .back 0 101 [.swapSuits 0 1]
  | 30 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 30)
  | 31 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row233 : Row := ⟨233, state233, 233, action233⟩

def state234 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 15 | 16 | 19 | 20 | 22 | 23 | 24 | 27 | 28 | 29 | 30 => 0
  | 1 | 5 | 6 | 7 | 8 | 12 | 13 | 17 | 18 | 21 | 25 | 31 | 32 | 33 => 1
  | 10 => 4
  | 14 | 26 => 2
  | _ => 0

def action234 (t : Tile) : Action :=
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
  | 27 => .back 28 102 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 102 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 102 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 102 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row234 : Row := ⟨234, state234, 234, action234⟩

def state235 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 4 | 5 | 6 | 9 | 11 | 12 | 13 | 18 | 20 | 24 | 25 | 27 | 28 | 29 => 0
  | 3 | 7 | 10 | 14 | 15 | 16 | 17 | 21 | 22 | 26 | 30 | 31 | 32 | 33 => 1
  | 8 | 23 => 2
  | 19 => 4
  | _ => 0

def action235 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 27 102 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 0 2, .swapHonors 1 2]
  | 1 => .win 2 (FullWinWitness.standard (.triplet 19) (.sequence 0 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 2 => .win 1 (FullWinWitness.standard (.triplet 19) (.sequence 0 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 3 => .win 3 (FullWinWitness.standard (.triplet 3) (.triplet 19) (.sequence 1 5) (.sequence 2 3) 8)
  | 4 => .win 2 (FullWinWitness.standard (.triplet 19) (.sequence 0 2) (.sequence 1 5) (.sequence 2 3) 8)
  | 5 => .win 4 (FullWinWitness.standard (.triplet 19) (.sequence 0 3) (.sequence 1 5) (.sequence 2 3) 8)
  | 6 => .win 3 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 3)
  | 7 => .win 7 (FullWinWitness.standard (.triplet 7) (.triplet 19) (.sequence 1 5) (.sequence 2 3) 8)
  | 8 => .win 3 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 3) 3)
  | 9 => .win 11 (FullWinWitness.standard (.triplet 19) (.sequence 1 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 10 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 10)
  | 11 => .win 9 (FullWinWitness.standard (.triplet 19) (.sequence 1 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 19) (.sequence 1 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 19) (.sequence 1 3) (.sequence 1 6) (.sequence 2 3) 8)
  | 14 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 6) (.sequence 2 3) 14)
  | 15 => .win 13 (FullWinWitness.standard (.triplet 19) (.sequence 1 4) (.sequence 1 6) (.sequence 2 3) 8)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 1 6) (.sequence 2 3) 8)
  | 17 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 17)
  | 18 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 0) (.sequence 2 3) 8)
  | 20 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 1) 23)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 1) (.sequence 2 3) 8)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 3) (.sequence 2 3) 8)
  | 23 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 23)
  | 24 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 1) (.sequence 2 4) 8)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 3) (.sequence 2 5) 8)
  | 26 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 26)
  | 27 => .back 0 102 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 0 2, .swapHonors 1 2]
  | 28 => .back 0 102 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 1 2]
  | 29 => .back 0 102 [.swapSuits 0 2, .swapSuits 1 2]
  | 30 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 30)
  | 31 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row235 : Row := ⟨235, state235, 235, action235⟩

def state236 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 15 | 16 | 19 | 20 | 22 | 23 | 24 | 27 | 28 | 29 | 30 => 0
  | 2 | 5 | 6 | 7 | 8 | 12 | 13 | 17 | 18 | 21 | 25 | 31 | 32 | 33 => 1
  | 10 => 4
  | 14 | 26 => 2
  | _ => 0

def action236 (t : Tile) : Action :=
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
  | 27 => .back 28 103 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 103 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 103 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 103 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row236 : Row := ⟨236, state236, 236, action236⟩

def state237 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 4 | 5 | 6 | 9 | 10 | 12 | 13 | 18 | 20 | 24 | 25 | 27 | 28 | 29 => 0
  | 3 | 7 | 11 | 14 | 15 | 16 | 17 | 21 | 22 | 26 | 30 | 31 | 32 | 33 => 1
  | 8 | 23 => 2
  | 19 => 4
  | _ => 0

def action237 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 27 103 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 0 2, .swapHonors 1 2]
  | 1 => .win 2 (FullWinWitness.standard (.triplet 19) (.sequence 0 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 2 => .win 1 (FullWinWitness.standard (.triplet 19) (.sequence 0 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 3 => .win 3 (FullWinWitness.standard (.triplet 3) (.triplet 19) (.sequence 1 5) (.sequence 2 3) 8)
  | 4 => .win 2 (FullWinWitness.standard (.triplet 19) (.sequence 0 2) (.sequence 1 5) (.sequence 2 3) 8)
  | 5 => .win 4 (FullWinWitness.standard (.triplet 19) (.sequence 0 3) (.sequence 1 5) (.sequence 2 3) 8)
  | 6 => .win 3 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 3)
  | 7 => .win 7 (FullWinWitness.standard (.triplet 7) (.triplet 19) (.sequence 1 5) (.sequence 2 3) 8)
  | 8 => .win 3 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 3) 3)
  | 9 => .win 10 (FullWinWitness.standard (.triplet 19) (.sequence 1 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 10 => .win 9 (FullWinWitness.standard (.triplet 19) (.sequence 1 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 11 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 11)
  | 12 => .win 10 (FullWinWitness.standard (.triplet 19) (.sequence 1 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 19) (.sequence 1 2) (.sequence 1 5) (.sequence 2 3) 8)
  | 14 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 6) (.sequence 2 3) 14)
  | 15 => .win 13 (FullWinWitness.standard (.triplet 19) (.sequence 1 4) (.sequence 1 6) (.sequence 2 3) 8)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 1 6) (.sequence 2 3) 8)
  | 17 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 17)
  | 18 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 0) (.sequence 2 3) 8)
  | 20 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 1) 23)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 1) (.sequence 2 3) 8)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 3) (.sequence 2 3) 8)
  | 23 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 23)
  | 24 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 1) (.sequence 2 4) 8)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 3) (.sequence 2 5) 8)
  | 26 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 26)
  | 27 => .back 0 103 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 0 2, .swapHonors 1 2]
  | 28 => .back 0 103 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 1 2]
  | 29 => .back 0 103 [.swapSuits 0 2, .swapSuits 1 2]
  | 30 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 30)
  | 31 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row237 : Row := ⟨237, state237, 237, action237⟩

def state238 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 4 | 9 | 11 | 15 | 16 | 19 | 20 | 22 | 23 | 24 | 27 | 28 => 0
  | 5 | 6 | 7 | 8 | 12 | 13 | 17 | 18 | 21 | 25 | 29 | 30 | 31 | 32 | 33 => 1
  | 10 => 3
  | 14 | 26 => 2
  | _ => 0

def action238 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 9 101 [.swapSuits 1 2, .reverseSuit 1]
  | 1 => .back 10 102 []
  | 2 => .back 10 103 []
  | 3 => .win 4 (FullWinWitness.standard (.triplet 10) (.sequence 0 3) (.sequence 0 6) (.sequence 1 3) 26)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 10) (.sequence 0 3) (.sequence 0 6) (.sequence 1 3) 26)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 10) (.sequence 0 6) (.sequence 1 3) 26)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 10) (.sequence 0 4) (.sequence 0 6) (.sequence 1 3) 26)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 0 6) (.sequence 1 3) 26)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 0 5) (.sequence 1 3) 26)
  | 9 => .back 0 101 [.swapSuits 1 2, .reverseSuit 1]
  | 10 => .back 1 102 []
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
  | 27 => .back 28 104 [.swapHonors 0 1]
  | 28 => .back 27 104 []
  | 29 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 29)
  | 30 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 30)
  | 31 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row238 : Row := ⟨238, state238, 238, action238⟩

def state239 (t : Tile) : Nat :=
  match t.val with
  | 0 | 5 | 6 | 7 | 8 | 9 | 13 | 16 | 18 | 21 | 22 | 26 | 31 | 32 | 33 => 1
  | 1 | 2 | 3 | 4 | 10 | 11 | 12 | 14 | 15 | 19 | 20 | 24 | 27 | 28 | 29 | 30 => 0
  | 17 | 23 => 2
  | 25 => 3
  | _ => 0

def action239 (t : Tile) : Action :=
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
  | 27 => .back 28 105 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 105 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 105 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 105 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row239 : Row := ⟨239, state239, 239, action239⟩

def state240 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 5 | 6 | 9 | 10 | 11 | 15 | 19 | 20 | 21 | 22 | 27 | 28 => 0
  | 4 | 7 | 12 | 13 | 17 | 18 | 23 | 24 | 25 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 8 | 14 => 2
  | 16 => 3
  | _ => 0

def action240 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 9 105 [.swapSuits 0 1, .swapSuits 1 2]
  | 1 => .back 10 59 []
  | 2 => .win 3 (FullWinWitness.standard (.triplet 16) (.sequence 0 2) (.sequence 1 3) (.sequence 2 5) 8)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 16) (.sequence 0 2) (.sequence 1 3) (.sequence 2 5) 8)
  | 4 => .win 4 (FullWinWitness.standard (.triplet 4) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 8)
  | 5 => .win 3 (FullWinWitness.standard (.triplet 16) (.sequence 0 3) (.sequence 1 3) (.sequence 2 5) 8)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 4)
  | 7 => .win 7 (FullWinWitness.standard (.triplet 7) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 8)
  | 8 => .win 4 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 4)
  | 9 => .back 0 105 [.swapSuits 0 1, .swapSuits 1 2]
  | 10 => .back 1 59 []
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
  | 27 => .back 28 106 [.swapHonors 0 1]
  | 28 => .back 27 106 []
  | 29 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 29)
  | 30 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 30)
  | 31 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row240 : Row := ⟨240, state240, 240, action240⟩

def state241 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 15 | 19 | 20 | 21 | 23 | 24 | 27 | 28 | 29 | 30 => 0
  | 1 | 5 | 6 | 7 | 8 | 10 | 12 | 13 | 17 | 18 | 22 | 25 | 31 | 32 | 33 => 1
  | 14 | 26 => 2
  | 16 => 3
  | _ => 0

def action241 (t : Tile) : Action :=
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
  | 27 => .back 28 107 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 107 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 107 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 107 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row241 : Row := ⟨241, state241, 241, action241⟩

def state242 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 15 | 19 | 20 | 21 | 23 | 24 | 27 | 28 | 29 | 30 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 12 | 13 | 17 | 18 | 22 | 25 | 31 | 32 | 33 => 1
  | 14 | 26 => 2
  | 16 => 3
  | _ => 0

def action242 (t : Tile) : Action :=
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
  | 27 => .back 28 108 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 108 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 108 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 108 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row242 : Row := ⟨242, state242, 242, action242⟩

def state243 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 4 | 9 | 10 | 11 | 15 | 19 | 20 | 21 | 23 | 24 | 27 | 28 => 0
  | 5 | 6 | 7 | 8 | 12 | 13 | 17 | 18 | 22 | 25 | 29 | 30 | 31 | 32 | 33 => 1
  | 14 | 26 => 2
  | 16 => 3
  | _ => 0

def action243 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 9 105 [.swapSuits 1 2]
  | 1 => .back 10 107 []
  | 2 => .back 10 108 []
  | 3 => .win 4 (FullWinWitness.standard (.triplet 16) (.sequence 0 3) (.sequence 0 6) (.sequence 1 3) 26)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 16) (.sequence 0 3) (.sequence 0 6) (.sequence 1 3) 26)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 16) (.sequence 0 6) (.sequence 1 3) 26)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 16) (.sequence 0 4) (.sequence 0 6) (.sequence 1 3) 26)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 0 6) (.sequence 1 3) 26)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 0 5) (.sequence 1 3) 26)
  | 9 => .back 0 105 [.swapSuits 1 2]
  | 10 => .back 2 108 []
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
  | 27 => .back 28 109 [.swapHonors 0 1]
  | 28 => .back 27 109 []
  | 29 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 29)
  | 30 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 30)
  | 31 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row243 : Row := ⟨243, state243, 243, action243⟩

def state244 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 4 | 9 | 10 | 11 | 12 | 14 | 15 | 19 | 20 | 24 | 27 | 28 => 0
  | 5 | 6 | 7 | 8 | 13 | 16 | 18 | 21 | 22 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 17 | 23 => 2
  | 25 => 3
  | _ => 0

def action244 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 9 105 []
  | 1 => .back 10 66 []
  | 2 => .back 10 80 []
  | 3 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 3) (.sequence 0 6) (.sequence 2 3) 17)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 25) (.sequence 0 3) (.sequence 0 6) (.sequence 2 3) 17)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 25) (.sequence 0 6) (.sequence 2 3) 17)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 4) (.sequence 0 6) (.sequence 2 3) 17)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 0 6) (.sequence 2 3) 17)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 9 => .back 0 105 []
  | 10 => .back 1 66 []
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
  | 27 => .back 28 110 [.swapHonors 0 1]
  | 28 => .back 27 110 []
  | 29 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 29)
  | 30 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 30)
  | 31 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row244 : Row := ⟨244, state244, 244, action244⟩

def state245 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 18 | 20 | 24 | 26 | 27 | 28 | 29 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 13 | 16 | 19 | 21 | 22 | 30 | 31 | 32 | 33 => 1
  | 17 | 23 => 2
  | 25 => 3
  | _ => 0

def action245 (t : Tile) : Action :=
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
  | 26 => .back 27 81 [.swapHonors 0 2, .swapHonors 1 2]
  | 27 => .back 26 81 [.swapHonors 0 2, .swapHonors 1 2]
  | 28 => .back 26 81 [.swapHonors 1 2]
  | 29 => .back 26 81 []
  | 30 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 30)
  | 31 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row245 : Row := ⟨245, state245, 245, action245⟩

def state246 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 15 | 16 | 19 | 20 | 21 | 22 | 24 | 25 | 27 | 28 => 0
  | 2 | 5 | 6 | 7 | 8 | 11 | 12 | 13 | 14 | 17 | 18 | 23 | 29 | 30 | 31 | 32 | 33 => 1
  | 10 => 3
  | 26 => 2
  | _ => 0

def action246 (t : Tile) : Action :=
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
  | 9 => .win 10 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 0) (.sequence 1 3) 26)
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
  | 27 => .back 28 111 [.swapHonors 0 1]
  | 28 => .back 27 111 []
  | 29 => .win 26 (FullWinWitness.standard (.triplet 10) (.triplet 26) (.sequence 0 5) (.sequence 1 2) 29)
  | 30 => .win 26 (FullWinWitness.standard (.triplet 10) (.triplet 26) (.sequence 0 5) (.sequence 1 2) 30)
  | 31 => .win 26 (FullWinWitness.standard (.triplet 10) (.triplet 26) (.sequence 0 5) (.sequence 1 2) 31)
  | 32 => .win 26 (FullWinWitness.standard (.triplet 10) (.triplet 26) (.sequence 0 5) (.sequence 1 2) 32)
  | 33 => .win 26 (FullWinWitness.standard (.triplet 10) (.triplet 26) (.sequence 0 5) (.sequence 1 2) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row246 : Row := ⟨246, state246, 246, action246⟩

def state247 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 13 | 15 | 16 | 18 | 24 | 25 | 27 | 28 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 14 | 20 | 21 | 22 | 23 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 17 => 2
  | 19 => 3
  | _ => 0

def action247 (t : Tile) : Action :=
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
  | 27 => .back 28 112 [.swapHonors 0 1]
  | 28 => .back 27 112 []
  | 29 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 5) (.sequence 2 2) 29)
  | 30 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 5) (.sequence 2 2) 30)
  | 31 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 5) (.sequence 2 2) 31)
  | 32 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 5) (.sequence 2 2) 32)
  | 33 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 5) (.sequence 2 2) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row247 : Row := ⟨247, state247, 247, action247⟩

def state248 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 6 | 7 | 9 | 15 | 16 | 19 | 20 | 21 | 22 | 27 | 28 => 0
  | 2 | 5 | 11 | 12 | 13 | 14 | 17 | 18 | 23 | 24 | 25 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 8 => 2
  | 10 => 3
  | _ => 0

def action248 (t : Tile) : Action :=
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
  | 9 => .win 8 (FullWinWitness.standard (.triplet 8) (.sequence 1 0) (.sequence 1 3) (.sequence 2 5) 10)
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
  | 27 => .back 28 113 [.swapHonors 0 1]
  | 28 => .back 27 113 []
  | 29 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 1 2) (.sequence 2 5) 29)
  | 30 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 1 2) (.sequence 2 5) 30)
  | 31 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 1 2) (.sequence 2 5) 31)
  | 32 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 1 2) (.sequence 2 5) 32)
  | 33 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 1 2) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row248 : Row := ⟨248, state248, 248, action248⟩

def state249 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 6 | 7 | 9 | 11 | 12 | 13 | 18 | 24 | 25 | 27 | 28 => 0
  | 1 | 5 | 10 | 14 | 15 | 16 | 17 | 20 | 21 | 22 | 23 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 8 => 2
  | 19 => 3
  | _ => 0

def action249 (t : Tile) : Action :=
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
  | 27 => .back 28 114 [.swapHonors 0 1]
  | 28 => .back 27 114 []
  | 29 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 2) 29)
  | 30 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 2) 30)
  | 31 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 2) 31)
  | 32 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 2) 32)
  | 33 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 2) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row249 : Row := ⟨249, state249, 249, action249⟩

def state250 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 6 | 7 | 9 | 10 | 12 | 13 | 18 | 24 | 25 | 27 | 28 => 0
  | 2 | 5 | 11 | 14 | 15 | 16 | 17 | 20 | 21 | 22 | 23 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 8 => 2
  | 19 => 3
  | _ => 0

def action250 (t : Tile) : Action :=
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
  | 27 => .back 28 115 [.swapHonors 0 1]
  | 28 => .back 27 115 []
  | 29 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 2) 29)
  | 30 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 2) 30)
  | 31 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 2) 31)
  | 32 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 2) 32)
  | 33 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 2) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row250 : Row := ⟨250, state250, 250, action250⟩

def state251 (t : Tile) : Nat :=
  match t.val with
  | 0 | 5 | 6 | 7 | 8 | 9 | 13 | 16 | 18 | 22 | 23 | 26 | 31 | 32 | 33 => 1
  | 1 | 2 | 3 | 4 | 10 | 11 | 12 | 14 | 15 | 19 | 20 | 24 | 27 | 28 | 29 | 30 => 0
  | 17 | 21 => 2
  | 25 => 3
  | _ => 0

def action251 (t : Tile) : Action :=
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
  | 27 => .back 28 116 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 116 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 116 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 116 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row251 : Row := ⟨251, state251, 251, action251⟩

def state252 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 15 | 16 | 19 | 20 | 21 | 23 | 24 | 27 | 28 | 29 | 30 => 0
  | 1 | 5 | 6 | 7 | 8 | 12 | 13 | 17 | 18 | 22 | 25 | 31 | 32 | 33 => 1
  | 10 => 4
  | 14 | 26 => 2
  | _ => 0

def action252 (t : Tile) : Action :=
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
  | 27 => .back 28 117 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 117 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 117 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 117 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row252 : Row := ⟨252, state252, 252, action252⟩

def state253 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 15 | 16 | 19 | 20 | 21 | 23 | 24 | 27 | 28 | 29 | 30 => 0
  | 2 | 5 | 6 | 7 | 8 | 12 | 13 | 17 | 18 | 22 | 25 | 31 | 32 | 33 => 1
  | 10 => 4
  | 14 | 26 => 2
  | _ => 0

def action253 (t : Tile) : Action :=
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
  | 27 => .back 28 118 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 118 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 118 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 118 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row253 : Row := ⟨253, state253, 253, action253⟩

def state254 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 4 | 9 | 11 | 15 | 16 | 19 | 20 | 21 | 23 | 24 | 27 | 28 => 0
  | 5 | 6 | 7 | 8 | 12 | 13 | 17 | 18 | 22 | 25 | 29 | 30 | 31 | 32 | 33 => 1
  | 10 => 3
  | 14 | 26 => 2
  | _ => 0

def action254 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 9 116 [.swapSuits 1 2, .reverseSuit 1]
  | 1 => .back 10 117 []
  | 2 => .back 10 118 []
  | 3 => .win 4 (FullWinWitness.standard (.triplet 10) (.sequence 0 3) (.sequence 0 6) (.sequence 1 3) 26)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 10) (.sequence 0 3) (.sequence 0 6) (.sequence 1 3) 26)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 10) (.sequence 0 6) (.sequence 1 3) 26)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 10) (.sequence 0 4) (.sequence 0 6) (.sequence 1 3) 26)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 0 6) (.sequence 1 3) 26)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 0 5) (.sequence 1 3) 26)
  | 9 => .back 0 116 [.swapSuits 1 2, .reverseSuit 1]
  | 10 => .back 2 118 []
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
  | 27 => .back 28 119 [.swapHonors 0 1]
  | 28 => .back 27 119 []
  | 29 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 29)
  | 30 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 30)
  | 31 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row254 : Row := ⟨254, state254, 254, action254⟩

def state255 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 5 | 6 | 9 | 11 | 15 | 16 | 19 | 20 | 21 | 22 | 27 | 28 | 29 | 30 => 0
  | 1 | 4 | 7 | 12 | 13 | 17 | 18 | 23 | 24 | 25 | 26 | 31 | 32 | 33 => 1
  | 8 | 14 => 2
  | 10 => 4
  | _ => 0

def action255 (t : Tile) : Action :=
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
  | 27 => .back 28 120 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 120 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 120 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 120 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row255 : Row := ⟨255, state255, 255, action255⟩

end Mahjong.Scale12V2
