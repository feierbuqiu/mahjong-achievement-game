import MahjongScale.Actual12V2.Base

set_option maxRecDepth 32768
set_option maxHeartbeats 100000000

namespace Mahjong.Scale12V2
open ResponseTable ResponseCertificate Generators

def state256 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 18 | 20 | 24 | 25 | 27 | 28 | 29 | 30 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 13 | 16 | 21 | 22 | 26 | 31 | 32 | 33 => 1
  | 17 | 23 => 2
  | 19 => 4
  | _ => 0

def action256 (t : Tile) : Action :=
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
  | 27 => .back 28 121 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 121 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 121 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 121 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row256 : Row := ⟨256, state256, 256, action256⟩

def state257 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 18 | 20 | 24 | 25 | 27 | 28 | 29 | 30 => 0
  | 1 | 5 | 6 | 7 | 8 | 10 | 13 | 16 | 21 | 22 | 26 | 31 | 32 | 33 => 1
  | 17 | 23 => 2
  | 19 => 4
  | _ => 0

def action257 (t : Tile) : Action :=
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
  | 27 => .back 28 122 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 122 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 122 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 122 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row257 : Row := ⟨257, state257, 257, action257⟩

def state258 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 5 | 6 | 9 | 15 | 16 | 19 | 20 | 21 | 22 | 27 | 28 => 0
  | 2 | 7 | 11 | 12 | 13 | 14 | 17 | 18 | 23 | 24 | 25 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 8 => 2
  | 10 => 3
  | _ => 0

def action258 (t : Tile) : Action :=
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
  | 9 => .win 6 (FullWinWitness.standard (.sequence 0 6) (.sequence 1 0) (.sequence 1 3) (.sequence 2 5) 10)
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
  | 27 => .back 28 123 [.swapHonors 0 1]
  | 28 => .back 27 123 []
  | 29 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 29)
  | 30 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 30)
  | 31 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row258 : Row := ⟨258, state258, 258, action258⟩

def state259 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 5 | 6 | 9 | 11 | 12 | 13 | 18 | 24 | 25 | 27 | 28 => 0
  | 2 | 7 | 10 | 14 | 15 | 16 | 17 | 20 | 21 | 22 | 23 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 8 => 2
  | 19 => 3
  | _ => 0

def action259 (t : Tile) : Action :=
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
  | 27 => .back 28 124 [.swapHonors 0 1]
  | 28 => .back 27 124 []
  | 29 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 29)
  | 30 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 30)
  | 31 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row259 : Row := ⟨259, state259, 259, action259⟩

def state260 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 5 | 6 | 9 | 10 | 12 | 13 | 18 | 24 | 25 | 27 | 28 => 0
  | 2 | 7 | 11 | 14 | 15 | 16 | 17 | 20 | 21 | 22 | 23 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 8 => 2
  | 19 => 3
  | _ => 0

def action260 (t : Tile) : Action :=
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
  | 27 => .back 28 125 [.swapHonors 0 1]
  | 28 => .back 27 125 []
  | 29 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 29)
  | 30 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 30)
  | 31 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row260 : Row := ⟨260, state260, 260, action260⟩

def state261 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 5 | 6 | 10 | 11 | 12 | 13 | 19 | 20 | 24 | 27 | 28 | 29 => 0
  | 2 | 7 | 9 | 14 | 15 | 16 | 17 | 18 | 22 | 23 | 26 | 30 | 31 | 32 | 33 => 1
  | 8 | 21 => 2
  | 25 => 3
  | _ => 0

def action261 (t : Tile) : Action :=
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
  | 27 => .back 28 126 [.swapHonors 0 2]
  | 28 => .back 27 126 [.swapHonors 0 1, .swapHonors 1 2]
  | 29 => .back 27 126 [.swapHonors 0 1]
  | 30 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 30)
  | 31 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row261 : Row := ⟨261, state261, 261, action261⟩

def state262 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 5 | 6 | 9 | 11 | 15 | 16 | 19 | 20 | 21 | 22 | 27 | 28 => 0
  | 4 | 7 | 12 | 13 | 17 | 18 | 23 | 24 | 25 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 8 | 14 => 2
  | 10 => 3
  | _ => 0

def action262 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 9 116 [.swapSuits 0 1, .swapSuits 1 2, .reverseSuit 1]
  | 1 => .back 10 120 []
  | 2 => .win 3 (FullWinWitness.standard (.triplet 10) (.sequence 0 2) (.sequence 1 3) (.sequence 2 5) 8)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 10) (.sequence 0 2) (.sequence 1 3) (.sequence 2 5) 8)
  | 4 => .win 4 (FullWinWitness.standard (.triplet 4) (.triplet 10) (.sequence 1 3) (.sequence 2 5) 8)
  | 5 => .win 3 (FullWinWitness.standard (.triplet 10) (.sequence 0 3) (.sequence 1 3) (.sequence 2 5) 8)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 4)
  | 7 => .win 7 (FullWinWitness.standard (.triplet 7) (.triplet 10) (.sequence 1 3) (.sequence 2 5) 8)
  | 8 => .win 4 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 1 3) (.sequence 2 5) 4)
  | 9 => .back 0 116 [.swapSuits 0 1, .swapSuits 1 2, .reverseSuit 1]
  | 10 => .back 1 120 []
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
  | 27 => .back 28 127 [.swapHonors 0 1]
  | 28 => .back 27 127 []
  | 29 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 29)
  | 30 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 30)
  | 31 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row262 : Row := ⟨262, state262, 262, action262⟩

def state263 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 15 | 16 | 19 | 20 | 22 | 23 | 24 | 27 | 28 | 29 | 30 => 0
  | 1 | 5 | 6 | 7 | 8 | 12 | 14 | 17 | 18 | 21 | 25 | 31 | 32 | 33 => 1
  | 10 => 4
  | 13 | 26 => 2
  | _ => 0

def action263 (t : Tile) : Action :=
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
  | 13 => .win 11 (FullWinWitness.standard (.triplet 10) (.triplet 13) (.sequence 0 5) (.sequence 1 1) 26)
  | 14 => .win 12 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 1 3) 26)
  | 15 => .win 11 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 1) (.sequence 1 4) 26)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 1 6) 26)
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
  | 27 => .back 28 128 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 128 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 128 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 128 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row263 : Row := ⟨263, state263, 263, action263⟩

def state264 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 15 | 16 | 19 | 20 | 21 | 22 | 23 | 24 | 27 | 28 => 0
  | 1 | 5 | 6 | 7 | 8 | 12 | 13 | 14 | 17 | 18 | 25 | 29 | 30 | 31 | 32 | 33 => 1
  | 10 => 4
  | 26 => 2
  | _ => 0

def action264 (t : Tile) : Action :=
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
  | 13 => .back 22 129 []
  | 14 => .back 21 102 []
  | 15 => .win 11 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 1) (.sequence 1 4) 26)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 1 6) 26)
  | 17 => .win 17 (FullWinWitness.standard (.triplet 10) (.triplet 17) (.sequence 0 5) (.sequence 1 3) 26)
  | 18 => .win 18 (FullWinWitness.standard (.triplet 10) (.triplet 18) (.sequence 0 5) (.sequence 1 3) 26)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 0) 26)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 0) 26)
  | 21 => .back 14 102 []
  | 22 => .back 13 129 []
  | 23 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 5) 26)
  | 24 => .win 1 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 1)
  | 25 => .win 25 (FullWinWitness.standard (.triplet 10) (.triplet 25) (.sequence 0 5) (.sequence 1 3) 26)
  | 26 => .win 1 (FullWinWitness.standard (.triplet 10) (.triplet 26) (.sequence 0 5) (.sequence 1 3) 1)
  | 27 => .back 22 130 [.swapHonors 0 1]
  | 28 => .back 22 130 []
  | 29 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 29)
  | 30 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 30)
  | 31 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row264 : Row := ⟨264, state264, 264, action264⟩

def state265 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 5 | 6 | 9 | 11 | 12 | 13 | 18 | 20 | 24 | 25 | 27 | 28 => 0
  | 1 | 7 | 10 | 14 | 15 | 16 | 17 | 22 | 23 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 8 | 21 => 2
  | 19 => 3
  | _ => 0

def action265 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 2 (FullWinWitness.standard (.triplet 19) (.sequence 0 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 1 => .win 1 (FullWinWitness.standard (.triplet 1) (.triplet 19) (.sequence 1 5) (.sequence 2 3) 8)
  | 2 => .win 0 (FullWinWitness.standard (.triplet 19) (.sequence 0 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 19) (.sequence 0 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 4 => .back 18 66 [.swapSuits 0 1, .reverseSuit 2]
  | 5 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 5) (.sequence 2 3) 8)
  | 6 => .win 1 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 1)
  | 7 => .win 7 (FullWinWitness.standard (.triplet 7) (.triplet 19) (.sequence 1 5) (.sequence 2 3) 8)
  | 8 => .win 1 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 3) 1)
  | 9 => .win 11 (FullWinWitness.standard (.triplet 19) (.sequence 1 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 10 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 10)
  | 11 => .win 9 (FullWinWitness.standard (.triplet 19) (.sequence 1 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 19) (.sequence 1 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 19) (.sequence 1 3) (.sequence 1 6) (.sequence 2 3) 8)
  | 14 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 6) (.sequence 2 3) 14)
  | 15 => .win 13 (FullWinWitness.standard (.triplet 19) (.sequence 1 4) (.sequence 1 6) (.sequence 2 3) 8)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 1 6) (.sequence 2 3) 8)
  | 17 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 17)
  | 18 => .back 4 66 [.swapSuits 0 1, .reverseSuit 2]
  | 19 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 1) (.sequence 2 3) 8)
  | 20 => .win 6 (FullWinWitness.standard (.sequence 0 6) (.sequence 1 5) (.sequence 2 1) (.sequence 2 3) 19)
  | 21 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 21)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 2) (.sequence 2 3) 8)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 3) (.sequence 2 3) 8)
  | 24 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 4) 21)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 3) (.sequence 2 6) 8)
  | 26 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 26)
  | 27 => .back 28 131 [.swapHonors 0 1]
  | 28 => .back 27 131 []
  | 29 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 29)
  | 30 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 30)
  | 31 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row265 : Row := ⟨265, state265, 265, action265⟩

def state266 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 18 | 20 | 24 | 25 | 27 | 28 | 29 | 30 => 0
  | 1 | 5 | 6 | 7 | 8 | 10 | 13 | 16 | 21 | 23 | 26 | 31 | 32 | 33 => 1
  | 17 | 22 => 2
  | 19 => 4
  | _ => 0

def action266 (t : Tile) : Action :=
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
  | 20 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 1) 22)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 1) (.sequence 2 3) 17)
  | 22 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 22)
  | 23 => .win 21 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 24 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 1) (.sequence 2 4) 17)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 3) (.sequence 2 6) 17)
  | 26 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 26)
  | 27 => .back 28 132 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 132 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 132 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 132 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row266 : Row := ⟨266, state266, 266, action266⟩

def state267 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 5 | 6 | 9 | 11 | 12 | 13 | 18 | 20 | 24 | 25 | 27 | 28 => 0
  | 4 | 7 | 10 | 14 | 15 | 16 | 17 | 21 | 22 | 23 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 8 => 2
  | 19 => 4
  | _ => 0

def action267 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 22 129 [.swapSuits 0 2, .swapSuits 1 2]
  | 1 => .back 23 122 [.swapSuits 0 1]
  | 2 => .win 3 (FullWinWitness.standard (.triplet 19) (.sequence 0 2) (.sequence 1 5) (.sequence 2 3) 8)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 19) (.sequence 0 2) (.sequence 1 5) (.sequence 2 3) 8)
  | 4 => .win 4 (FullWinWitness.standard (.triplet 4) (.triplet 19) (.sequence 1 5) (.sequence 2 3) 8)
  | 5 => .win 3 (FullWinWitness.standard (.triplet 19) (.sequence 0 3) (.sequence 1 5) (.sequence 2 3) 8)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 4)
  | 7 => .win 7 (FullWinWitness.standard (.triplet 7) (.triplet 19) (.sequence 1 5) (.sequence 2 3) 8)
  | 8 => .win 4 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 3) 4)
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
  | 20 => .win 18 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 0) (.sequence 2 3) 8)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 1) (.sequence 2 3) 8)
  | 22 => .back 0 129 [.swapSuits 0 2, .swapSuits 1 2]
  | 23 => .back 1 122 [.swapSuits 0 1]
  | 24 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 1) (.sequence 2 4) 8)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 3) (.sequence 2 6) 8)
  | 26 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 26)
  | 27 => .back 0 130 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 0 1]
  | 28 => .back 0 130 [.swapSuits 0 2, .swapSuits 1 2]
  | 29 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 29)
  | 30 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 30)
  | 31 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row267 : Row := ⟨267, state267, 267, action267⟩

def state268 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 5 | 6 | 9 | 11 | 12 | 13 | 18 | 20 | 24 | 25 | 27 | 28 => 0
  | 1 | 7 | 10 | 14 | 15 | 16 | 17 | 21 | 23 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 8 | 22 => 2
  | 19 => 3
  | _ => 0

def action268 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 2 (FullWinWitness.standard (.triplet 19) (.sequence 0 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 1 => .win 1 (FullWinWitness.standard (.triplet 1) (.triplet 19) (.sequence 1 5) (.sequence 2 3) 8)
  | 2 => .win 0 (FullWinWitness.standard (.triplet 19) (.sequence 0 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 19) (.sequence 0 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 4 => .back 18 63 [.swapSuits 0 1, .reverseSuit 2]
  | 5 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 5) (.sequence 2 3) 8)
  | 6 => .win 1 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 1)
  | 7 => .win 7 (FullWinWitness.standard (.triplet 7) (.triplet 19) (.sequence 1 5) (.sequence 2 3) 8)
  | 8 => .win 1 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 3) 1)
  | 9 => .win 11 (FullWinWitness.standard (.triplet 19) (.sequence 1 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 10 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 10)
  | 11 => .win 9 (FullWinWitness.standard (.triplet 19) (.sequence 1 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 19) (.sequence 1 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 19) (.sequence 1 3) (.sequence 1 6) (.sequence 2 3) 8)
  | 14 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 6) (.sequence 2 3) 14)
  | 15 => .win 13 (FullWinWitness.standard (.triplet 19) (.sequence 1 4) (.sequence 1 6) (.sequence 2 3) 8)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 1 6) (.sequence 2 3) 8)
  | 17 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 17)
  | 18 => .back 4 63 [.swapSuits 0 1, .reverseSuit 2]
  | 19 => .back 4 132 [.swapSuits 0 1]
  | 20 => .win 21 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 2) (.sequence 2 3) 8)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 2) (.sequence 2 3) 8)
  | 22 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 22)
  | 23 => .win 21 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 3) (.sequence 2 3) 8)
  | 24 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 2) (.sequence 2 4) 8)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 3) (.sequence 2 6) 8)
  | 26 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 26)
  | 27 => .back 28 133 [.swapHonors 0 1]
  | 28 => .back 27 133 []
  | 29 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 29)
  | 30 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 30)
  | 31 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row268 : Row := ⟨268, state268, 268, action268⟩

def state269 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 4 | 5 | 6 | 9 | 11 | 12 | 13 | 18 | 20 | 24 | 25 | 27 | 28 => 0
  | 3 | 7 | 10 | 14 | 15 | 16 | 17 | 21 | 22 | 23 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 8 => 2
  | 19 => 4
  | _ => 0

def action269 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 23 102 [.swapSuits 0 2, .swapSuits 1 2]
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
  | 20 => .win 18 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 0) (.sequence 2 3) 8)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 1) (.sequence 2 3) 8)
  | 22 => .back 0 128 [.swapSuits 0 2, .swapSuits 1 2]
  | 23 => .back 0 102 [.swapSuits 0 2, .swapSuits 1 2]
  | 24 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 1) (.sequence 2 4) 8)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 3) (.sequence 2 6) 8)
  | 26 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 26)
  | 27 => .back 28 134 [.swapHonors 0 1]
  | 28 => .back 27 134 []
  | 29 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 29)
  | 30 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 30)
  | 31 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row269 : Row := ⟨269, state269, 269, action269⟩

def state270 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 5 | 6 | 9 | 11 | 12 | 13 | 18 | 20 | 24 | 25 | 27 | 28 => 0
  | 1 | 7 | 10 | 14 | 15 | 16 | 17 | 21 | 22 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 8 | 23 => 2
  | 19 => 3
  | _ => 0

def action270 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 2 (FullWinWitness.standard (.triplet 19) (.sequence 0 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 1 => .win 1 (FullWinWitness.standard (.triplet 1) (.triplet 19) (.sequence 1 5) (.sequence 2 3) 8)
  | 2 => .win 0 (FullWinWitness.standard (.triplet 19) (.sequence 0 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 19) (.sequence 0 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 4 => .back 19 122 [.swapSuits 0 1]
  | 5 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 5) (.sequence 2 3) 8)
  | 6 => .win 1 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 1)
  | 7 => .win 7 (FullWinWitness.standard (.triplet 7) (.triplet 19) (.sequence 1 5) (.sequence 2 3) 8)
  | 8 => .win 1 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 3) 1)
  | 9 => .win 11 (FullWinWitness.standard (.triplet 19) (.sequence 1 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 10 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 10)
  | 11 => .win 9 (FullWinWitness.standard (.triplet 19) (.sequence 1 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 19) (.sequence 1 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 19) (.sequence 1 3) (.sequence 1 6) (.sequence 2 3) 8)
  | 14 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 6) (.sequence 2 3) 14)
  | 15 => .win 13 (FullWinWitness.standard (.triplet 19) (.sequence 1 4) (.sequence 1 6) (.sequence 2 3) 8)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 1 6) (.sequence 2 3) 8)
  | 17 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 17)
  | 18 => .back 27 65 [.reverseSuit 2, .swapHonors 0 1]
  | 19 => .back 4 122 [.swapSuits 0 1]
  | 20 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 23)
  | 21 => .win 22 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 3) (.sequence 2 3) 8)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 3) (.sequence 2 3) 8)
  | 23 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 23)
  | 24 => .win 22 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 3) (.sequence 2 4) 8)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 3) (.sequence 2 5) 8)
  | 26 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 26)
  | 27 => .back 18 65 [.reverseSuit 2, .swapHonors 0 1]
  | 28 => .back 18 65 [.reverseSuit 2]
  | 29 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 29)
  | 30 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 30)
  | 31 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row270 : Row := ⟨270, state270, 270, action270⟩

def state271 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 9 | 11 | 12 | 13 | 18 | 20 | 24 | 25 => 0
  | 7 | 10 | 14 | 15 | 16 | 17 | 21 | 22 | 23 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 8 => 2
  | 19 => 3
  | _ => 0

def action271 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 23 135 [.swapSuits 0 2, .swapSuits 1 2]
  | 1 => .back 21 131 []
  | 2 => .back 20 124 []
  | 3 => .back 19 134 []
  | 4 => .back 23 136 []
  | 5 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 5) (.sequence 2 3) 8)
  | 6 => .win 5 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 5) (.sequence 2 3) 8)
  | 7 => .win 7 (FullWinWitness.standard (.triplet 7) (.triplet 19) (.sequence 1 5) (.sequence 2 3) 8)
  | 8 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 8)
  | 9 => .win 11 (FullWinWitness.standard (.triplet 19) (.sequence 1 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 10 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 10)
  | 11 => .win 9 (FullWinWitness.standard (.triplet 19) (.sequence 1 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 19) (.sequence 1 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 19) (.sequence 1 3) (.sequence 1 6) (.sequence 2 3) 8)
  | 14 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 6) (.sequence 2 3) 14)
  | 15 => .win 13 (FullWinWitness.standard (.triplet 19) (.sequence 1 4) (.sequence 1 6) (.sequence 2 3) 8)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 1 6) (.sequence 2 3) 8)
  | 17 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 17)
  | 18 => .back 1 73 [.reverseSuit 2]
  | 19 => .back 3 134 []
  | 20 => .back 2 124 []
  | 21 => .back 1 131 []
  | 22 => .back 1 133 []
  | 23 => .back 1 137 []
  | 24 => .win 25 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 3) (.sequence 2 6) 8)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 3) (.sequence 2 6) 8)
  | 26 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 26)
  | 27 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 27)
  | 28 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 28)
  | 29 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 29)
  | 30 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 30)
  | 31 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row271 : Row := ⟨271, state271, 271, action271⟩

def state272 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 15 | 16 | 19 | 20 | 21 | 23 | 24 | 27 | 28 | 29 | 30 => 0
  | 2 | 5 | 6 | 7 | 8 | 12 | 14 | 17 | 18 | 22 | 25 | 31 | 32 | 33 => 1
  | 10 => 4
  | 13 | 26 => 2
  | _ => 0

def action272 (t : Tile) : Action :=
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
  | 13 => .win 11 (FullWinWitness.standard (.triplet 10) (.triplet 13) (.sequence 0 5) (.sequence 1 1) 26)
  | 14 => .win 12 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 1 3) 26)
  | 15 => .win 11 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 1) (.sequence 1 4) 26)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 1 6) 26)
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
  | 27 => .back 28 138 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 138 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 138 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 138 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row272 : Row := ⟨272, state272, 272, action272⟩

def state273 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 15 | 16 | 19 | 20 | 21 | 22 | 23 | 24 | 27 | 28 => 0
  | 2 | 5 | 6 | 7 | 8 | 12 | 13 | 14 | 17 | 18 | 25 | 29 | 30 | 31 | 32 | 33 => 1
  | 10 => 4
  | 26 => 2
  | _ => 0

def action273 (t : Tile) : Action :=
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
  | 13 => .back 21 139 []
  | 14 => .back 22 118 []
  | 15 => .win 11 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 1) (.sequence 1 4) 26)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 1 6) 26)
  | 17 => .win 17 (FullWinWitness.standard (.triplet 10) (.triplet 17) (.sequence 0 5) (.sequence 1 3) 26)
  | 18 => .win 18 (FullWinWitness.standard (.triplet 10) (.triplet 18) (.sequence 0 5) (.sequence 1 3) 26)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 0) 26)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 0) 26)
  | 21 => .back 13 139 []
  | 22 => .back 14 118 []
  | 23 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 5) 26)
  | 24 => .win 2 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 2)
  | 25 => .win 25 (FullWinWitness.standard (.triplet 10) (.triplet 25) (.sequence 0 5) (.sequence 1 3) 26)
  | 26 => .win 2 (FullWinWitness.standard (.triplet 10) (.triplet 26) (.sequence 0 5) (.sequence 1 3) 2)
  | 27 => .back 28 140 [.swapHonors 0 1]
  | 28 => .back 27 140 []
  | 29 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 29)
  | 30 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 30)
  | 31 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row273 : Row := ⟨273, state273, 273, action273⟩

def state274 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 15 | 16 | 19 | 20 | 22 | 23 | 24 | 27 | 28 | 29 | 30 => 0
  | 2 | 5 | 6 | 7 | 8 | 12 | 14 | 17 | 18 | 21 | 25 | 31 | 32 | 33 => 1
  | 10 => 4
  | 13 | 26 => 2
  | _ => 0

def action274 (t : Tile) : Action :=
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
  | 13 => .win 11 (FullWinWitness.standard (.triplet 10) (.triplet 13) (.sequence 0 5) (.sequence 1 1) 26)
  | 14 => .win 12 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 1 3) 26)
  | 15 => .win 11 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 1) (.sequence 1 4) 26)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 1 6) 26)
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
  | 27 => .back 28 139 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 139 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 139 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 139 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row274 : Row := ⟨274, state274, 274, action274⟩

def state275 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 5 | 6 | 9 | 10 | 12 | 13 | 18 | 20 | 24 | 25 | 27 | 28 => 0
  | 4 | 7 | 11 | 14 | 15 | 16 | 17 | 21 | 23 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 8 | 22 => 2
  | 19 => 3
  | _ => 0

def action275 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 19 138 [.swapSuits 0 2, .swapSuits 1 2]
  | 1 => .back 18 77 [.swapSuits 0 1, .reverseSuit 2]
  | 2 => .win 3 (FullWinWitness.standard (.triplet 19) (.sequence 0 2) (.sequence 1 5) (.sequence 2 3) 8)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 19) (.sequence 0 2) (.sequence 1 5) (.sequence 2 3) 8)
  | 4 => .win 4 (FullWinWitness.standard (.triplet 4) (.triplet 19) (.sequence 1 5) (.sequence 2 3) 8)
  | 5 => .win 3 (FullWinWitness.standard (.triplet 19) (.sequence 0 3) (.sequence 1 5) (.sequence 2 3) 8)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 4)
  | 7 => .win 7 (FullWinWitness.standard (.triplet 7) (.triplet 19) (.sequence 1 5) (.sequence 2 3) 8)
  | 8 => .win 4 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 3) 4)
  | 9 => .win 10 (FullWinWitness.standard (.triplet 19) (.sequence 1 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 10 => .win 9 (FullWinWitness.standard (.triplet 19) (.sequence 1 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 11 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 11)
  | 12 => .win 10 (FullWinWitness.standard (.triplet 19) (.sequence 1 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 19) (.sequence 1 2) (.sequence 1 5) (.sequence 2 3) 8)
  | 14 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 6) (.sequence 2 3) 14)
  | 15 => .win 13 (FullWinWitness.standard (.triplet 19) (.sequence 1 4) (.sequence 1 6) (.sequence 2 3) 8)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 1 6) (.sequence 2 3) 8)
  | 17 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 17)
  | 18 => .back 1 77 [.swapSuits 0 1, .reverseSuit 2]
  | 19 => .back 1 141 [.swapSuits 0 1]
  | 20 => .win 21 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 2) (.sequence 2 3) 8)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 2) (.sequence 2 3) 8)
  | 22 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 22)
  | 23 => .win 21 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 3) (.sequence 2 3) 8)
  | 24 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 2) (.sequence 2 4) 8)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 3) (.sequence 2 6) 8)
  | 26 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 26)
  | 27 => .back 28 142 [.swapHonors 0 1]
  | 28 => .back 27 142 []
  | 29 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 29)
  | 30 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 30)
  | 31 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row275 : Row := ⟨275, state275, 275, action275⟩

def state276 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 18 | 20 | 24 | 25 | 27 | 28 | 29 | 30 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 13 | 16 | 21 | 23 | 26 | 31 | 32 | 33 => 1
  | 17 | 22 => 2
  | 19 => 4
  | _ => 0

def action276 (t : Tile) : Action :=
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
  | 20 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 1) 22)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 1) (.sequence 2 3) 17)
  | 22 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 22)
  | 23 => .win 21 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 24 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 1) (.sequence 2 4) 17)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 3) (.sequence 2 6) 17)
  | 26 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 26)
  | 27 => .back 28 141 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 141 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 141 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 141 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row276 : Row := ⟨276, state276, 276, action276⟩

def state277 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 13 | 14 | 15 | 18 | 20 | 24 | 25 | 27 | 28 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 16 | 21 | 22 | 23 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 17 => 2
  | 19 => 4
  | _ => 0

def action277 (t : Tile) : Action :=
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
  | 13 => .back 23 121 []
  | 14 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 5) (.sequence 2 3) 17)
  | 15 => .win 2 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 2)
  | 16 => .win 16 (FullWinWitness.standard (.triplet 16) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 17)
  | 17 => .win 2 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 2)
  | 18 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 20 => .win 18 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 1) (.sequence 2 3) 17)
  | 22 => .back 13 141 []
  | 23 => .back 13 121 []
  | 24 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 1) (.sequence 2 4) 17)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 3) (.sequence 2 6) 17)
  | 26 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 26)
  | 27 => .back 28 143 [.swapHonors 0 1]
  | 28 => .back 27 143 []
  | 29 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 29)
  | 30 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 30)
  | 31 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row277 : Row := ⟨277, state277, 277, action277⟩

def state278 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 13 | 14 | 15 | 18 | 20 | 24 | 25 | 27 | 28 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 16 | 22 | 23 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 17 | 21 => 2
  | 19 => 3
  | _ => 0

def action278 (t : Tile) : Action :=
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
  | 13 => .back 18 80 [.reverseSuit 2]
  | 14 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 5) (.sequence 2 3) 17)
  | 15 => .win 2 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 2)
  | 16 => .win 16 (FullWinWitness.standard (.triplet 16) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 17)
  | 17 => .win 2 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 2)
  | 18 => .back 13 80 [.reverseSuit 2]
  | 19 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 1) (.sequence 2 3) 17)
  | 20 => .win 15 (FullWinWitness.standard (.sequence 0 5) (.sequence 1 6) (.sequence 2 1) (.sequence 2 3) 19)
  | 21 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 21)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 2) (.sequence 2 3) 17)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 24 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 4) 21)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 3) (.sequence 2 6) 17)
  | 26 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 26)
  | 27 => .back 28 144 [.swapHonors 0 1]
  | 28 => .back 27 144 []
  | 29 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 29)
  | 30 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 30)
  | 31 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row278 : Row := ⟨278, state278, 278, action278⟩

def state279 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 4 | 5 | 6 | 9 | 10 | 12 | 13 | 18 | 20 | 24 | 25 | 27 | 28 => 0
  | 3 | 7 | 11 | 14 | 15 | 16 | 17 | 21 | 22 | 23 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 8 => 2
  | 19 => 4
  | _ => 0

def action279 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 22 139 [.swapSuits 0 2, .swapSuits 1 2]
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
  | 20 => .win 18 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 0) (.sequence 2 3) 8)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 1) (.sequence 2 3) 8)
  | 22 => .back 0 139 [.swapSuits 0 2, .swapSuits 1 2]
  | 23 => .back 0 103 [.swapSuits 0 2, .swapSuits 1 2]
  | 24 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 1) (.sequence 2 4) 8)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 3) (.sequence 2 6) 8)
  | 26 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 26)
  | 27 => .back 28 145 [.swapHonors 0 1]
  | 28 => .back 27 145 []
  | 29 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 29)
  | 30 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 30)
  | 31 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row279 : Row := ⟨279, state279, 279, action279⟩

def state280 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 13 | 14 | 15 | 18 | 20 | 24 | 25 | 27 | 28 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 16 | 21 | 22 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 17 | 23 => 2
  | 19 => 3
  | _ => 0

def action280 (t : Tile) : Action :=
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
  | 13 => .back 19 121 []
  | 14 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 5) (.sequence 2 3) 17)
  | 15 => .win 2 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 2)
  | 16 => .win 16 (FullWinWitness.standard (.triplet 16) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 17)
  | 17 => .win 2 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 2)
  | 18 => .back 27 79 [.reverseSuit 2, .swapHonors 0 1]
  | 19 => .back 13 121 []
  | 20 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 2) 23)
  | 21 => .win 22 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 23 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 23)
  | 24 => .win 22 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 3) (.sequence 2 4) 17)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 3) (.sequence 2 5) 17)
  | 26 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 26)
  | 27 => .back 18 79 [.reverseSuit 2, .swapHonors 0 1]
  | 28 => .back 18 79 [.reverseSuit 2]
  | 29 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 29)
  | 30 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 30)
  | 31 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row280 : Row := ⟨280, state280, 280, action280⟩

def state281 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 9 | 10 | 12 | 13 | 18 | 20 | 24 | 25 => 0
  | 7 | 11 | 14 | 15 | 16 | 17 | 21 | 22 | 23 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 8 => 2
  | 19 => 3
  | _ => 0

def action281 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 19 140 [.swapSuits 0 2, .swapSuits 1 2]
  | 1 => .back 21 144 [.swapSuits 0 1]
  | 2 => .back 20 125 []
  | 3 => .back 19 145 []
  | 4 => .back 22 142 []
  | 5 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 5) (.sequence 2 3) 8)
  | 6 => .win 5 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 5) (.sequence 2 3) 8)
  | 7 => .win 7 (FullWinWitness.standard (.triplet 7) (.triplet 19) (.sequence 1 5) (.sequence 2 3) 8)
  | 8 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 8)
  | 9 => .win 10 (FullWinWitness.standard (.triplet 19) (.sequence 1 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 10 => .win 9 (FullWinWitness.standard (.triplet 19) (.sequence 1 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 11 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 11)
  | 12 => .win 10 (FullWinWitness.standard (.triplet 19) (.sequence 1 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 19) (.sequence 1 2) (.sequence 1 5) (.sequence 2 3) 8)
  | 14 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 6) (.sequence 2 3) 14)
  | 15 => .win 13 (FullWinWitness.standard (.triplet 19) (.sequence 1 4) (.sequence 1 6) (.sequence 2 3) 8)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 1 6) (.sequence 2 3) 8)
  | 17 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 17)
  | 18 => .back 1 88 [.swapSuits 0 1, .reverseSuit 2]
  | 19 => .back 3 145 []
  | 20 => .back 2 125 []
  | 21 => .back 1 144 [.swapSuits 0 1]
  | 22 => .back 4 142 []
  | 23 => .back 1 146 [.swapSuits 0 1]
  | 24 => .win 25 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 3) (.sequence 2 6) 8)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 3) (.sequence 2 6) 8)
  | 26 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 26)
  | 27 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 27)
  | 28 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 28)
  | 29 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 29)
  | 30 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 30)
  | 31 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row281 : Row := ⟨281, state281, 281, action281⟩

def state282 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 5 | 6 | 10 | 11 | 12 | 13 | 19 | 20 | 24 | 27 | 28 | 29 => 0
  | 2 | 7 | 9 | 14 | 15 | 16 | 17 | 18 | 21 | 22 | 26 | 30 | 31 | 32 | 33 => 1
  | 8 | 23 => 2
  | 25 => 3
  | _ => 0

def action282 (t : Tile) : Action :=
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
  | 20 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 23)
  | 21 => .win 22 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 3) (.sequence 2 3) 8)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 3) (.sequence 2 3) 8)
  | 23 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 23)
  | 24 => .win 6 (FullWinWitness.standard (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) (.sequence 2 5) 25)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 3) (.sequence 2 5) 8)
  | 26 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 26)
  | 27 => .back 28 147 [.swapHonors 0 2]
  | 28 => .back 27 147 [.swapHonors 0 1, .swapHonors 1 2]
  | 29 => .back 27 147 [.swapHonors 0 1]
  | 30 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 30)
  | 31 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row282 : Row := ⟨282, state282, 282, action282⟩

def state283 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 5 | 6 | 9 | 11 | 15 | 16 | 19 | 20 | 21 | 22 | 27 | 28 | 29 | 30 => 0
  | 1 | 4 | 7 | 12 | 14 | 17 | 18 | 23 | 24 | 25 | 26 | 31 | 32 | 33 => 1
  | 8 | 13 => 2
  | 10 => 4
  | _ => 0

def action283 (t : Tile) : Action :=
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
  | 11 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 1) (.sequence 2 5) 13)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 10) (.sequence 1 1) (.sequence 1 3) (.sequence 2 5) 8)
  | 13 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 13)
  | 14 => .win 12 (FullWinWitness.standard (.triplet 10) (.sequence 1 3) (.sequence 1 3) (.sequence 2 5) 8)
  | 15 => .win 11 (FullWinWitness.standard (.triplet 10) (.sequence 1 1) (.sequence 1 4) (.sequence 2 5) 8)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 10) (.sequence 1 3) (.sequence 1 6) (.sequence 2 5) 8)
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
  | 27 => .back 28 148 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 148 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 148 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 148 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row283 : Row := ⟨283, state283, 283, action283⟩

def state284 (t : Tile) : Nat :=
  match t.val with
  | 0 | 5 | 6 | 7 | 8 | 9 | 13 | 16 | 18 | 21 | 23 | 26 | 31 | 32 | 33 => 1
  | 1 | 2 | 3 | 4 | 10 | 11 | 12 | 14 | 15 | 19 | 20 | 24 | 27 | 28 | 29 | 30 => 0
  | 17 | 22 => 2
  | 25 => 3
  | _ => 0

def action284 (t : Tile) : Action :=
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
  | 21 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 2) (.sequence 2 3) 17)
  | 22 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 22)
  | 23 => .win 21 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 24 => .win 15 (FullWinWitness.standard (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) (.sequence 2 6) 25)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 6) 17)
  | 26 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 26)
  | 27 => .back 28 149 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 149 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 149 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 149 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row284 : Row := ⟨284, state284, 284, action284⟩

def state285 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 5 | 6 | 9 | 11 | 15 | 16 | 19 | 20 | 21 | 22 | 27 | 28 => 0
  | 4 | 7 | 12 | 14 | 17 | 18 | 23 | 24 | 25 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 8 | 13 => 2
  | 10 => 3
  | _ => 0

def action285 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 9 149 [.swapSuits 0 1, .swapSuits 1 2, .reverseSuit 1]
  | 1 => .back 10 148 []
  | 2 => .win 3 (FullWinWitness.standard (.triplet 10) (.sequence 0 2) (.sequence 1 3) (.sequence 2 5) 8)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 10) (.sequence 0 2) (.sequence 1 3) (.sequence 2 5) 8)
  | 4 => .win 4 (FullWinWitness.standard (.triplet 4) (.triplet 10) (.sequence 1 3) (.sequence 2 5) 8)
  | 5 => .win 3 (FullWinWitness.standard (.triplet 10) (.sequence 0 3) (.sequence 1 3) (.sequence 2 5) 8)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 4)
  | 7 => .win 7 (FullWinWitness.standard (.triplet 7) (.triplet 10) (.sequence 1 3) (.sequence 2 5) 8)
  | 8 => .win 4 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 1 3) (.sequence 2 5) 4)
  | 9 => .back 0 149 [.swapSuits 0 1, .swapSuits 1 2, .reverseSuit 1]
  | 10 => .back 1 148 []
  | 11 => .win 12 (FullWinWitness.standard (.triplet 10) (.sequence 1 2) (.sequence 1 3) (.sequence 2 5) 8)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 10) (.sequence 1 2) (.sequence 1 3) (.sequence 2 5) 8)
  | 13 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 13)
  | 14 => .win 12 (FullWinWitness.standard (.triplet 10) (.sequence 1 3) (.sequence 1 3) (.sequence 2 5) 8)
  | 15 => .win 11 (FullWinWitness.standard (.triplet 10) (.sequence 1 2) (.sequence 1 4) (.sequence 2 5) 8)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 10) (.sequence 1 3) (.sequence 1 6) (.sequence 2 5) 8)
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
  | 27 => .back 28 150 [.swapHonors 0 1]
  | 28 => .back 27 150 []
  | 29 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 29)
  | 30 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 30)
  | 31 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row285 : Row := ⟨285, state285, 285, action285⟩

def state286 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 15 | 16 | 19 | 20 | 21 | 23 | 24 | 27 | 28 | 29 | 30 => 0
  | 1 | 5 | 6 | 7 | 8 | 12 | 14 | 17 | 18 | 22 | 25 | 31 | 32 | 33 => 1
  | 10 => 4
  | 13 | 26 => 2
  | _ => 0

def action286 (t : Tile) : Action :=
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
  | 13 => .win 11 (FullWinWitness.standard (.triplet 10) (.triplet 13) (.sequence 0 5) (.sequence 1 1) 26)
  | 14 => .win 12 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 1 3) 26)
  | 15 => .win 11 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 1) (.sequence 1 4) 26)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 1 6) 26)
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
  | 27 => .back 28 129 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 129 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 129 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 129 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row286 : Row := ⟨286, state286, 286, action286⟩

def state287 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 4 | 9 | 11 | 15 | 16 | 19 | 20 | 21 | 23 | 24 | 27 | 28 => 0
  | 5 | 6 | 7 | 8 | 12 | 14 | 17 | 18 | 22 | 25 | 29 | 30 | 31 | 32 | 33 => 1
  | 10 => 3
  | 13 | 26 => 2
  | _ => 0

def action287 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 9 149 [.swapSuits 1 2, .reverseSuit 1]
  | 1 => .back 10 129 []
  | 2 => .back 10 138 []
  | 3 => .win 4 (FullWinWitness.standard (.triplet 10) (.sequence 0 3) (.sequence 0 6) (.sequence 1 3) 26)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 10) (.sequence 0 3) (.sequence 0 6) (.sequence 1 3) 26)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 10) (.sequence 0 6) (.sequence 1 3) 26)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 10) (.sequence 0 4) (.sequence 0 6) (.sequence 1 3) 26)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 0 6) (.sequence 1 3) 26)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 0 5) (.sequence 1 3) 26)
  | 9 => .back 0 149 [.swapSuits 1 2, .reverseSuit 1]
  | 10 => .back 1 129 []
  | 11 => .win 12 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 2) (.sequence 1 3) 26)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 2) (.sequence 1 3) 26)
  | 13 => .win 13 (FullWinWitness.standard (.triplet 10) (.triplet 13) (.sequence 0 5) (.sequence 1 3) 26)
  | 14 => .win 12 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 1 3) 26)
  | 15 => .win 11 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 2) (.sequence 1 4) 26)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 1 6) 26)
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
  | 27 => .back 28 151 [.swapHonors 0 1]
  | 28 => .back 27 151 []
  | 29 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 29)
  | 30 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 30)
  | 31 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row287 : Row := ⟨287, state287, 287, action287⟩

def state288 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 4 | 9 | 10 | 11 | 12 | 14 | 15 | 19 | 20 | 24 | 27 | 28 => 0
  | 5 | 6 | 7 | 8 | 13 | 16 | 18 | 21 | 23 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 17 | 22 => 2
  | 25 => 3
  | _ => 0

def action288 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 9 149 []
  | 1 => .back 10 63 []
  | 2 => .back 10 77 []
  | 3 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 3) (.sequence 0 6) (.sequence 2 3) 17)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 25) (.sequence 0 3) (.sequence 0 6) (.sequence 2 3) 17)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 25) (.sequence 0 6) (.sequence 2 3) 17)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 4) (.sequence 0 6) (.sequence 2 3) 17)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 0 6) (.sequence 2 3) 17)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 9 => .back 0 149 []
  | 10 => .back 2 77 []
  | 11 => .win 12 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 2) (.sequence 2 3) 17)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 2) (.sequence 2 3) 17)
  | 13 => .win 13 (FullWinWitness.standard (.triplet 13) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 14 => .win 12 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 17)
  | 15 => .win 5 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 6) (.sequence 2 3) 5)
  | 16 => .win 16 (FullWinWitness.standard (.triplet 16) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 17 => .win 5 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 6) (.sequence 2 3) 5)
  | 18 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 18)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 2) (.sequence 2 3) 17)
  | 22 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 22)
  | 23 => .win 21 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 24 => .win 15 (FullWinWitness.standard (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) (.sequence 2 6) 25)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 6) 17)
  | 26 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 26)
  | 27 => .back 28 152 [.swapHonors 0 1]
  | 28 => .back 27 152 []
  | 29 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 29)
  | 30 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 30)
  | 31 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row288 : Row := ⟨288, state288, 288, action288⟩

def state289 (t : Tile) : Nat :=
  match t.val with
  | 0 | 6 | 7 | 10 | 11 | 12 | 13 | 19 | 20 | 22 | 23 | 24 | 27 | 28 | 29 => 0
  | 1 => 3
  | 2 | 3 | 4 | 5 | 8 | 9 | 14 | 15 | 16 | 17 | 18 | 21 | 25 | 30 | 31 | 32 | 33 => 1
  | 26 => 2
  | _ => 0

def action289 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 1 (FullWinWitness.standard (.triplet 1) (.sequence 0 0) (.sequence 0 3) (.sequence 1 5) 26)
  | 1 => .win 0 (FullWinWitness.standard (.triplet 1) (.sequence 0 0) (.sequence 0 3) (.sequence 1 5) 26)
  | 2 => .win 2 (FullWinWitness.standard (.triplet 1) (.triplet 2) (.sequence 0 3) (.sequence 1 5) 26)
  | 3 => .win 1 (FullWinWitness.standard (.triplet 1) (.sequence 0 1) (.sequence 0 3) (.sequence 1 5) 26)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 1) (.sequence 0 2) (.sequence 0 3) (.sequence 1 5) 26)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 1) (.triplet 5) (.sequence 0 2) (.sequence 1 5) 26)
  | 6 => .win 1 (FullWinWitness.standard (.triplet 1) (.sequence 0 1) (.sequence 0 4) (.sequence 1 5) 26)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 1) (.sequence 0 2) (.sequence 0 5) (.sequence 1 5) 26)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 1) (.triplet 8) (.sequence 0 2) (.sequence 1 5) 26)
  | 9 => .win 9 (FullWinWitness.standard (.triplet 1) (.triplet 9) (.sequence 0 2) (.sequence 1 5) 26)
  | 10 => .win 11 (FullWinWitness.standard (.triplet 1) (.sequence 0 2) (.sequence 1 0) (.sequence 1 5) 26)
  | 11 => .win 10 (FullWinWitness.standard (.triplet 1) (.sequence 0 2) (.sequence 1 0) (.sequence 1 5) 26)
  | 12 => .win 13 (FullWinWitness.standard (.triplet 1) (.sequence 0 2) (.sequence 1 3) (.sequence 1 6) 26)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 1) (.sequence 0 2) (.sequence 1 3) (.sequence 1 6) 26)
  | 14 => .win 14 (FullWinWitness.standard (.triplet 1) (.triplet 14) (.sequence 0 2) (.sequence 1 6) 26)
  | 15 => .win 13 (FullWinWitness.standard (.triplet 1) (.sequence 0 2) (.sequence 1 4) (.sequence 1 6) 26)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 1) (.sequence 0 2) (.sequence 1 5) (.sequence 1 6) 26)
  | 17 => .win 17 (FullWinWitness.standard (.triplet 1) (.triplet 17) (.sequence 0 2) (.sequence 1 5) 26)
  | 18 => .win 18 (FullWinWitness.standard (.triplet 1) (.triplet 18) (.sequence 0 2) (.sequence 1 5) 26)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 1) (.sequence 0 2) (.sequence 1 5) (.sequence 2 0) 26)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 1) (.sequence 0 2) (.sequence 1 5) (.sequence 2 0) 26)
  | 21 => .win 21 (FullWinWitness.standard (.triplet 1) (.triplet 21) (.sequence 0 2) (.sequence 1 5) 26)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 1) (.sequence 0 2) (.sequence 1 5) (.sequence 2 2) 26)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 1) (.sequence 0 2) (.sequence 1 5) (.sequence 2 3) 26)
  | 24 => .win 0 (FullWinWitness.standard (.sequence 0 0) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 1)
  | 25 => .win 25 (FullWinWitness.standard (.triplet 1) (.triplet 25) (.sequence 0 2) (.sequence 1 5) 26)
  | 26 => .win 0 (FullWinWitness.standard (.triplet 26) (.sequence 0 0) (.sequence 0 3) (.sequence 1 5) 1)
  | 27 => .back 28 153 [.swapHonors 0 2]
  | 28 => .back 27 153 [.swapHonors 0 1, .swapHonors 1 2]
  | 29 => .back 27 153 [.swapHonors 0 1]
  | 30 => .win 24 (FullWinWitness.standard (.triplet 1) (.sequence 0 2) (.sequence 1 5) (.sequence 2 6) 30)
  | 31 => .win 24 (FullWinWitness.standard (.triplet 1) (.sequence 0 2) (.sequence 1 5) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 1) (.sequence 0 2) (.sequence 1 5) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 1) (.sequence 0 2) (.sequence 1 5) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row289 : Row := ⟨289, state289, 289, action289⟩

def state290 (t : Tile) : Nat :=
  match t.val with
  | 0 | 5 | 6 | 7 | 8 | 9 | 12 | 16 | 18 | 21 | 23 | 26 | 31 | 32 | 33 => 1
  | 1 | 2 | 3 | 4 | 10 | 11 | 13 | 14 | 15 | 19 | 20 | 24 | 27 | 28 | 29 | 30 => 0
  | 17 | 22 => 2
  | 25 => 3
  | _ => 0

def action290 (t : Tile) : Action :=
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
  | 21 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 2) (.sequence 2 3) 17)
  | 22 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 22)
  | 23 => .win 21 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 24 => .win 15 (FullWinWitness.standard (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) (.sequence 2 6) 25)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 6) 17)
  | 26 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 26)
  | 27 => .back 28 154 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 154 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 154 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 154 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row290 : Row := ⟨290, state290, 290, action290⟩

def state291 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 4 | 9 | 11 | 15 | 16 | 19 | 20 | 22 | 23 | 24 | 27 | 28 => 0
  | 5 | 6 | 7 | 8 | 12 | 14 | 17 | 18 | 21 | 25 | 29 | 30 | 31 | 32 | 33 => 1
  | 10 => 3
  | 13 | 26 => 2
  | _ => 0

def action291 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 9 154 [.swapSuits 1 2, .reverseSuit 1]
  | 1 => .back 10 128 []
  | 2 => .back 10 139 []
  | 3 => .win 4 (FullWinWitness.standard (.triplet 10) (.sequence 0 3) (.sequence 0 6) (.sequence 1 3) 26)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 10) (.sequence 0 3) (.sequence 0 6) (.sequence 1 3) 26)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 10) (.sequence 0 6) (.sequence 1 3) 26)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 10) (.sequence 0 4) (.sequence 0 6) (.sequence 1 3) 26)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 0 6) (.sequence 1 3) 26)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 0 5) (.sequence 1 3) 26)
  | 9 => .back 0 154 [.swapSuits 1 2, .reverseSuit 1]
  | 10 => .back 2 139 []
  | 11 => .win 12 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 2) (.sequence 1 3) 26)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 2) (.sequence 1 3) 26)
  | 13 => .win 13 (FullWinWitness.standard (.triplet 10) (.triplet 13) (.sequence 0 5) (.sequence 1 3) 26)
  | 14 => .win 12 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 1 3) 26)
  | 15 => .win 11 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 2) (.sequence 1 4) 26)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 1 6) 26)
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
  | 27 => .back 28 155 [.swapHonors 0 1]
  | 28 => .back 27 155 []
  | 29 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 29)
  | 30 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 30)
  | 31 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row291 : Row := ⟨291, state291, 291, action291⟩

def state292 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 5 | 7 | 9 | 15 | 16 | 19 | 20 | 21 | 22 | 27 | 28 => 0
  | 1 | 6 | 11 | 12 | 13 | 14 | 17 | 18 | 23 | 24 | 25 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 8 => 2
  | 10 => 3
  | _ => 0

def action292 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 2 (FullWinWitness.standard (.triplet 10) (.sequence 0 0) (.sequence 1 2) (.sequence 2 5) 8)
  | 1 => .win 1 (FullWinWitness.standard (.triplet 1) (.triplet 10) (.sequence 1 2) (.sequence 2 5) 8)
  | 2 => .win 0 (FullWinWitness.standard (.triplet 10) (.sequence 0 0) (.sequence 1 2) (.sequence 2 5) 8)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 10) (.sequence 0 1) (.sequence 1 2) (.sequence 2 5) 8)
  | 4 => .win 5 (FullWinWitness.standard (.triplet 10) (.sequence 0 4) (.sequence 1 2) (.sequence 2 5) 8)
  | 5 => .win 4 (FullWinWitness.standard (.triplet 10) (.sequence 0 4) (.sequence 1 2) (.sequence 2 5) 8)
  | 6 => .win 6 (FullWinWitness.standard (.triplet 6) (.triplet 10) (.sequence 1 2) (.sequence 2 5) 8)
  | 7 => .win 1 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 1)
  | 8 => .win 1 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 1 2) (.sequence 2 5) 1)
  | 9 => .win 7 (FullWinWitness.standard (.sequence 0 6) (.sequence 1 0) (.sequence 1 3) (.sequence 2 5) 10)
  | 10 => .win 9 (FullWinWitness.standard (.triplet 10) (.sequence 1 0) (.sequence 1 3) (.sequence 2 5) 8)
  | 11 => .win 7 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 11)
  | 12 => .win 7 (FullWinWitness.standard (.sequence 0 6) (.sequence 1 1) (.sequence 1 3) (.sequence 2 5) 10)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 10) (.sequence 1 2) (.sequence 1 3) (.sequence 2 5) 8)
  | 14 => .win 7 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 14)
  | 15 => .win 7 (FullWinWitness.standard (.sequence 0 6) (.sequence 1 1) (.sequence 1 4) (.sequence 2 5) 10)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 10) (.sequence 1 2) (.sequence 1 5) (.sequence 2 5) 8)
  | 17 => .win 7 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 17)
  | 18 => .win 7 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 18)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 10) (.sequence 1 2) (.sequence 2 0) (.sequence 2 5) 8)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 10) (.sequence 1 2) (.sequence 2 0) (.sequence 2 5) 8)
  | 21 => .win 22 (FullWinWitness.standard (.triplet 10) (.sequence 1 2) (.sequence 2 3) (.sequence 2 6) 8)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 10) (.sequence 1 2) (.sequence 2 3) (.sequence 2 6) 8)
  | 23 => .win 7 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 2) (.sequence 2 6) 23)
  | 24 => .win 22 (FullWinWitness.standard (.triplet 10) (.sequence 1 2) (.sequence 2 4) (.sequence 2 6) 8)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 1 2) (.sequence 2 5) (.sequence 2 6) 8)
  | 26 => .win 7 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 26)
  | 27 => .back 28 156 [.swapHonors 0 1]
  | 28 => .back 27 156 []
  | 29 => .win 7 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 29)
  | 30 => .win 7 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 30)
  | 31 => .win 7 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 31)
  | 32 => .win 7 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 32)
  | 33 => .win 7 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row292 : Row := ⟨292, state292, 292, action292⟩

def state293 (t : Tile) : Nat :=
  match t.val with
  | 0 | 6 | 7 | 10 | 11 | 12 | 13 | 19 | 20 | 21 | 23 | 24 | 27 | 28 | 29 => 0
  | 1 => 3
  | 2 | 3 | 4 | 5 | 8 | 9 | 14 | 15 | 16 | 17 | 18 | 22 | 25 | 30 | 31 | 32 | 33 => 1
  | 26 => 2
  | _ => 0

def action293 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 1 (FullWinWitness.standard (.triplet 1) (.sequence 0 0) (.sequence 0 3) (.sequence 1 5) 26)
  | 1 => .win 0 (FullWinWitness.standard (.triplet 1) (.sequence 0 0) (.sequence 0 3) (.sequence 1 5) 26)
  | 2 => .win 2 (FullWinWitness.standard (.triplet 1) (.triplet 2) (.sequence 0 3) (.sequence 1 5) 26)
  | 3 => .win 1 (FullWinWitness.standard (.triplet 1) (.sequence 0 1) (.sequence 0 3) (.sequence 1 5) 26)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 1) (.sequence 0 2) (.sequence 0 3) (.sequence 1 5) 26)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 1) (.triplet 5) (.sequence 0 2) (.sequence 1 5) 26)
  | 6 => .win 1 (FullWinWitness.standard (.triplet 1) (.sequence 0 1) (.sequence 0 4) (.sequence 1 5) 26)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 1) (.sequence 0 2) (.sequence 0 5) (.sequence 1 5) 26)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 1) (.triplet 8) (.sequence 0 2) (.sequence 1 5) 26)
  | 9 => .win 9 (FullWinWitness.standard (.triplet 1) (.triplet 9) (.sequence 0 2) (.sequence 1 5) 26)
  | 10 => .win 11 (FullWinWitness.standard (.triplet 1) (.sequence 0 2) (.sequence 1 0) (.sequence 1 5) 26)
  | 11 => .win 10 (FullWinWitness.standard (.triplet 1) (.sequence 0 2) (.sequence 1 0) (.sequence 1 5) 26)
  | 12 => .win 13 (FullWinWitness.standard (.triplet 1) (.sequence 0 2) (.sequence 1 3) (.sequence 1 6) 26)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 1) (.sequence 0 2) (.sequence 1 3) (.sequence 1 6) 26)
  | 14 => .win 14 (FullWinWitness.standard (.triplet 1) (.triplet 14) (.sequence 0 2) (.sequence 1 6) 26)
  | 15 => .win 13 (FullWinWitness.standard (.triplet 1) (.sequence 0 2) (.sequence 1 4) (.sequence 1 6) 26)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 1) (.sequence 0 2) (.sequence 1 5) (.sequence 1 6) 26)
  | 17 => .win 17 (FullWinWitness.standard (.triplet 1) (.triplet 17) (.sequence 0 2) (.sequence 1 5) 26)
  | 18 => .win 18 (FullWinWitness.standard (.triplet 1) (.triplet 18) (.sequence 0 2) (.sequence 1 5) 26)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 1) (.sequence 0 2) (.sequence 1 5) (.sequence 2 0) 26)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 1) (.sequence 0 2) (.sequence 1 5) (.sequence 2 0) 26)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 1) (.sequence 0 2) (.sequence 1 5) (.sequence 2 2) 26)
  | 22 => .win 22 (FullWinWitness.standard (.triplet 1) (.triplet 22) (.sequence 0 2) (.sequence 1 5) 26)
  | 23 => .win 21 (FullWinWitness.standard (.triplet 1) (.sequence 0 2) (.sequence 1 5) (.sequence 2 3) 26)
  | 24 => .win 0 (FullWinWitness.standard (.sequence 0 0) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 1)
  | 25 => .win 25 (FullWinWitness.standard (.triplet 1) (.triplet 25) (.sequence 0 2) (.sequence 1 5) 26)
  | 26 => .win 0 (FullWinWitness.standard (.triplet 26) (.sequence 0 0) (.sequence 0 3) (.sequence 1 5) 1)
  | 27 => .back 28 157 [.swapHonors 0 2]
  | 28 => .back 27 157 [.swapHonors 0 1, .swapHonors 1 2]
  | 29 => .back 27 157 [.swapHonors 0 1]
  | 30 => .win 24 (FullWinWitness.standard (.triplet 1) (.sequence 0 2) (.sequence 1 5) (.sequence 2 6) 30)
  | 31 => .win 24 (FullWinWitness.standard (.triplet 1) (.sequence 0 2) (.sequence 1 5) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 1) (.sequence 0 2) (.sequence 1 5) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 1) (.sequence 0 2) (.sequence 1 5) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row293 : Row := ⟨293, state293, 293, action293⟩

def state294 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 16 | 18 | 20 | 24 | 25 | 27 | 28 => 0
  | 1 | 5 | 6 | 7 | 8 | 10 | 13 | 21 | 22 | 23 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 17 => 2
  | 19 => 4
  | _ => 0

def action294 (t : Tile) : Action :=
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
  | 15 => .win 14 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 4) (.sequence 2 3) 17)
  | 16 => .back 23 122 []
  | 17 => .win 1 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 1)
  | 18 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 20 => .win 18 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 1) (.sequence 2 3) 17)
  | 22 => .back 16 132 []
  | 23 => .back 16 122 []
  | 24 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 1) (.sequence 2 4) 17)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 3) (.sequence 2 6) 17)
  | 26 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 26)
  | 27 => .back 28 158 [.swapHonors 0 1]
  | 28 => .back 27 158 []
  | 29 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 29)
  | 30 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 30)
  | 31 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 31)
  | 32 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 32)
  | 33 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row294 : Row := ⟨294, state294, 294, action294⟩

def state295 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 5 | 7 | 9 | 11 | 12 | 13 | 18 | 24 | 25 | 27 | 28 => 0
  | 1 | 6 | 10 | 14 | 15 | 16 | 17 | 20 | 21 | 22 | 23 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 8 => 2
  | 19 => 3
  | _ => 0

def action295 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 2 (FullWinWitness.standard (.triplet 19) (.sequence 0 0) (.sequence 1 5) (.sequence 2 2) 8)
  | 1 => .win 1 (FullWinWitness.standard (.triplet 1) (.triplet 19) (.sequence 1 5) (.sequence 2 2) 8)
  | 2 => .win 0 (FullWinWitness.standard (.triplet 19) (.sequence 0 0) (.sequence 1 5) (.sequence 2 2) 8)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 19) (.sequence 0 1) (.sequence 1 5) (.sequence 2 2) 8)
  | 4 => .win 5 (FullWinWitness.standard (.triplet 19) (.sequence 0 4) (.sequence 1 5) (.sequence 2 2) 8)
  | 5 => .win 4 (FullWinWitness.standard (.triplet 19) (.sequence 0 4) (.sequence 1 5) (.sequence 2 2) 8)
  | 6 => .win 6 (FullWinWitness.standard (.triplet 6) (.triplet 19) (.sequence 1 5) (.sequence 2 2) 8)
  | 7 => .win 1 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 1)
  | 8 => .win 1 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 2) 1)
  | 9 => .win 11 (FullWinWitness.standard (.triplet 19) (.sequence 1 0) (.sequence 1 5) (.sequence 2 2) 8)
  | 10 => .win 7 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 10)
  | 11 => .win 9 (FullWinWitness.standard (.triplet 19) (.sequence 1 0) (.sequence 1 5) (.sequence 2 2) 8)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 19) (.sequence 1 1) (.sequence 1 5) (.sequence 2 2) 8)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 19) (.sequence 1 3) (.sequence 1 6) (.sequence 2 2) 8)
  | 14 => .win 7 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 6) (.sequence 2 2) 14)
  | 15 => .win 13 (FullWinWitness.standard (.triplet 19) (.sequence 1 4) (.sequence 1 6) (.sequence 2 2) 8)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 1 6) (.sequence 2 2) 8)
  | 17 => .win 7 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 17)
  | 18 => .win 7 (FullWinWitness.standard (.sequence 0 6) (.sequence 1 5) (.sequence 2 0) (.sequence 2 3) 19)
  | 19 => .win 18 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 0) (.sequence 2 3) 8)
  | 20 => .win 7 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 20)
  | 21 => .win 7 (FullWinWitness.standard (.sequence 0 6) (.sequence 1 5) (.sequence 2 1) (.sequence 2 3) 19)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 2) (.sequence 2 3) 8)
  | 23 => .win 7 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 23)
  | 24 => .win 7 (FullWinWitness.standard (.sequence 0 6) (.sequence 1 5) (.sequence 2 1) (.sequence 2 4) 19)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 2) (.sequence 2 5) 8)
  | 26 => .win 7 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 26)
  | 27 => .back 28 159 [.swapHonors 0 1]
  | 28 => .back 27 159 []
  | 29 => .win 7 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 29)
  | 30 => .win 7 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 30)
  | 31 => .win 7 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 31)
  | 32 => .win 7 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 32)
  | 33 => .win 7 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row295 : Row := ⟨295, state295, 295, action295⟩

def state296 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 5 | 6 | 7 | 9 | 11 | 12 | 13 | 18 | 20 | 24 | 25 => 0
  | 1 | 10 | 14 | 15 | 16 | 17 | 21 | 22 | 23 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 8 => 2
  | 19 => 3
  | _ => 0

def action296 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 2 (FullWinWitness.standard (.triplet 19) (.sequence 0 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 1 => .win 1 (FullWinWitness.standard (.triplet 1) (.triplet 19) (.sequence 1 5) (.sequence 2 3) 8)
  | 2 => .win 0 (FullWinWitness.standard (.triplet 19) (.sequence 0 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 19) (.sequence 0 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 4 => .back 19 158 [.swapSuits 0 1]
  | 5 => .back 20 114 []
  | 6 => .back 20 159 []
  | 7 => .back 21 131 []
  | 8 => .win 1 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 3) 1)
  | 9 => .win 11 (FullWinWitness.standard (.triplet 19) (.sequence 1 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 10 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 3) 10)
  | 11 => .win 9 (FullWinWitness.standard (.triplet 19) (.sequence 1 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 19) (.sequence 1 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 19) (.sequence 1 3) (.sequence 1 6) (.sequence 2 3) 8)
  | 14 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 6) (.sequence 2 3) 14)
  | 15 => .win 13 (FullWinWitness.standard (.triplet 19) (.sequence 1 4) (.sequence 1 6) (.sequence 2 3) 8)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 1 6) (.sequence 2 3) 8)
  | 17 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 3) 17)
  | 18 => .back 7 73 [.reverseSuit 2]
  | 19 => .back 4 158 [.swapSuits 0 1]
  | 20 => .back 6 159 []
  | 21 => .back 7 131 []
  | 22 => .back 7 133 []
  | 23 => .back 7 137 []
  | 24 => .win 25 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 3) (.sequence 2 6) 8)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 3) (.sequence 2 6) 8)
  | 26 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 3) 26)
  | 27 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 3) 27)
  | 28 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 3) 28)
  | 29 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 3) 29)
  | 30 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 3) 30)
  | 31 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 3) 31)
  | 32 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 3) 32)
  | 33 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row296 : Row := ⟨296, state296, 296, action296⟩

def state297 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 18 | 20 | 24 | 26 | 27 | 28 | 29 | 30 => 0
  | 1 | 5 | 6 | 7 | 8 | 10 | 13 | 16 | 19 | 21 | 23 | 31 | 32 | 33 => 1
  | 17 | 22 => 2
  | 25 => 4
  | _ => 0

def action297 (t : Tile) : Action :=
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
  | 24 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 5) 22)
  | 26 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 6) 17)
  | 27 => .back 28 160 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 160 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 160 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 160 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row297 : Row := ⟨297, state297, 297, action297⟩

def state298 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 16 | 18 | 20 | 24 | 25 | 27 | 28 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 13 | 21 | 23 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 17 | 22 => 2
  | 19 => 3
  | _ => 0

def action298 (t : Tile) : Action :=
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
  | 15 => .win 14 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 4) (.sequence 2 3) 17)
  | 16 => .back 18 77 [.reverseSuit 2]
  | 17 => .win 2 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 2)
  | 18 => .back 16 77 [.reverseSuit 2]
  | 19 => .back 16 141 []
  | 20 => .win 21 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 2) (.sequence 2 3) 17)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 2) (.sequence 2 3) 17)
  | 22 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 22)
  | 23 => .win 21 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 24 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 2) (.sequence 2 4) 17)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 3) (.sequence 2 6) 17)
  | 26 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 26)
  | 27 => .back 28 161 [.swapHonors 0 1]
  | 28 => .back 27 161 []
  | 29 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 29)
  | 30 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 30)
  | 31 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 31)
  | 32 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 32)
  | 33 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row298 : Row := ⟨298, state298, 298, action298⟩

def state299 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 13 | 14 | 16 | 18 | 24 | 25 | 27 | 28 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 15 | 20 | 21 | 22 | 23 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 17 => 2
  | 19 => 3
  | _ => 0

def action299 (t : Tile) : Action :=
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
  | 13 => .win 14 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 4) (.sequence 2 2) 17)
  | 14 => .win 13 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 4) (.sequence 2 2) 17)
  | 15 => .win 15 (FullWinWitness.standard (.triplet 15) (.triplet 19) (.sequence 0 5) (.sequence 2 2) 17)
  | 16 => .win 2 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 2) 2)
  | 17 => .win 2 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 5) (.sequence 2 2) 2)
  | 18 => .win 16 (FullWinWitness.standard (.sequence 0 5) (.sequence 1 6) (.sequence 2 0) (.sequence 2 3) 19)
  | 19 => .win 18 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 20 => .win 16 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 20)
  | 21 => .win 16 (FullWinWitness.standard (.sequence 0 5) (.sequence 1 6) (.sequence 2 1) (.sequence 2 3) 19)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 2) (.sequence 2 3) 17)
  | 23 => .win 16 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 2) 23)
  | 24 => .win 16 (FullWinWitness.standard (.sequence 0 5) (.sequence 1 6) (.sequence 2 1) (.sequence 2 4) 19)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 2) (.sequence 2 5) 17)
  | 26 => .win 16 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 2) 26)
  | 27 => .back 28 162 [.swapHonors 0 1]
  | 28 => .back 27 162 []
  | 29 => .win 16 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 2) 29)
  | 30 => .win 16 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 2) 30)
  | 31 => .win 16 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 2) 31)
  | 32 => .win 16 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 2) 32)
  | 33 => .win 16 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 2) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row299 : Row := ⟨299, state299, 299, action299⟩

def state300 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 13 | 14 | 15 | 16 | 18 | 20 | 24 | 25 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 21 | 22 | 23 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 17 => 2
  | 19 => 3
  | _ => 0

def action300 (t : Tile) : Action :=
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
  | 13 => .back 22 161 []
  | 14 => .back 20 112 []
  | 15 => .back 20 162 []
  | 16 => .back 21 144 []
  | 17 => .win 2 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 2)
  | 18 => .back 16 88 [.reverseSuit 2]
  | 19 => .back 16 143 []
  | 20 => .back 15 162 []
  | 21 => .back 16 144 []
  | 22 => .back 13 161 []
  | 23 => .back 16 146 []
  | 24 => .win 25 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 3) (.sequence 2 6) 17)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 3) (.sequence 2 6) 17)
  | 26 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 26)
  | 27 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 27)
  | 28 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 28)
  | 29 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 29)
  | 30 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 30)
  | 31 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 31)
  | 32 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 32)
  | 33 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row300 : Row := ⟨300, state300, 300, action300⟩

def state301 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 18 | 20 | 24 | 26 | 27 | 28 | 29 | 30 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 13 | 16 | 19 | 21 | 23 | 31 | 32 | 33 => 1
  | 17 | 22 => 2
  | 25 => 4
  | _ => 0

def action301 (t : Tile) : Action :=
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
  | 24 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 5) 22)
  | 26 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 6) 17)
  | 27 => .back 28 163 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 163 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 163 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 163 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row301 : Row := ⟨301, state301, 301, action301⟩

def state302 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 6 | 8 | 10 | 11 | 12 | 13 | 19 | 20 | 21 | 23 | 24 | 27 | 28 | 29 | 30 => 0
  | 1 | 3 | 5 | 9 | 14 | 15 | 16 | 17 | 18 | 22 | 25 | 31 | 32 | 33 => 1
  | 4 | 26 => 2
  | 7 => 4
  | _ => 0

def action302 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 2 (FullWinWitness.standard (.triplet 7) (.sequence 0 0) (.sequence 0 3) (.sequence 1 5) 26)
  | 1 => .win 1 (FullWinWitness.standard (.triplet 1) (.triplet 7) (.sequence 0 3) (.sequence 1 5) 26)
  | 2 => .win 0 (FullWinWitness.standard (.triplet 7) (.sequence 0 0) (.sequence 0 3) (.sequence 1 5) 26)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 7) (.sequence 0 1) (.sequence 0 3) (.sequence 1 5) 26)
  | 4 => .win 2 (FullWinWitness.standard (.triplet 4) (.triplet 7) (.sequence 0 1) (.sequence 1 5) 26)
  | 5 => .win 3 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 0 3) (.sequence 1 5) 26)
  | 6 => .win 2 (FullWinWitness.standard (.triplet 7) (.sequence 0 1) (.sequence 0 5) (.sequence 1 5) 4)
  | 8 => .win 6 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 0 6) (.sequence 1 5) 26)
  | 9 => .win 9 (FullWinWitness.standard (.triplet 7) (.triplet 9) (.sequence 0 3) (.sequence 1 5) 26)
  | 10 => .win 11 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 0) (.sequence 1 5) 26)
  | 11 => .win 10 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 0) (.sequence 1 5) 26)
  | 12 => .win 13 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 3) (.sequence 1 6) 26)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 3) (.sequence 1 6) 26)
  | 14 => .win 14 (FullWinWitness.standard (.triplet 7) (.triplet 14) (.sequence 0 3) (.sequence 1 6) 26)
  | 15 => .win 13 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 4) (.sequence 1 6) 26)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 1 6) 26)
  | 17 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 3) (.sequence 1 5) 26)
  | 18 => .win 18 (FullWinWitness.standard (.triplet 7) (.triplet 18) (.sequence 0 3) (.sequence 1 5) 26)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 0) 26)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 0) 26)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 2) 26)
  | 22 => .win 22 (FullWinWitness.standard (.triplet 7) (.triplet 22) (.sequence 0 3) (.sequence 1 5) 26)
  | 23 => .win 21 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 3) 26)
  | 24 => .win 1 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 1)
  | 25 => .win 25 (FullWinWitness.standard (.triplet 7) (.triplet 25) (.sequence 0 3) (.sequence 1 5) 26)
  | 26 => .win 1 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 1)
  | 27 => .back 28 164 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 164 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 164 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 164 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row302 : Row := ⟨302, state302, 302, action302⟩

def state303 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 5 | 6 | 9 | 11 | 15 | 17 | 19 | 20 | 21 | 22 | 27 | 28 | 29 | 30 => 0
  | 1 | 4 | 7 | 10 | 12 | 14 | 18 | 23 | 24 | 25 | 26 | 31 | 32 | 33 => 1
  | 8 | 13 => 2
  | 16 => 4
  | _ => 0

def action303 (t : Tile) : Action :=
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
  | 15 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 5) (.sequence 2 5) 13)
  | 17 => .win 15 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 1 6) (.sequence 2 5) 8)
  | 18 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 18)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 0) (.sequence 2 5) 8)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 0) (.sequence 2 5) 8)
  | 21 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 3) (.sequence 2 6) 8)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 3) (.sequence 2 6) 8)
  | 23 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 6) 23)
  | 24 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 4) (.sequence 2 6) 8)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 5) (.sequence 2 6) 8)
  | 26 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 26)
  | 27 => .back 28 165 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 165 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 165 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 165 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row303 : Row := ⟨303, state303, 303, action303⟩

def state304 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 15 | 17 | 19 | 20 | 21 | 23 | 24 | 27 | 28 | 29 | 30 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 12 | 14 | 18 | 22 | 25 | 31 | 32 | 33 => 1
  | 13 | 26 => 2
  | 16 => 4
  | _ => 0

def action304 (t : Tile) : Action :=
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
  | 13 => .win 11 (FullWinWitness.standard (.triplet 13) (.triplet 16) (.sequence 0 5) (.sequence 1 1) 26)
  | 14 => .win 12 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 1 3) 26)
  | 15 => .win 11 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 1) (.sequence 1 5) 13)
  | 17 => .win 15 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 1 6) 26)
  | 18 => .win 18 (FullWinWitness.standard (.triplet 16) (.triplet 18) (.sequence 0 5) (.sequence 1 3) 26)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 0) 26)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 0) 26)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 2) 26)
  | 22 => .win 22 (FullWinWitness.standard (.triplet 16) (.triplet 22) (.sequence 0 5) (.sequence 1 3) 26)
  | 23 => .win 21 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 26)
  | 24 => .win 2 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 2)
  | 25 => .win 25 (FullWinWitness.standard (.triplet 16) (.triplet 25) (.sequence 0 5) (.sequence 1 3) 26)
  | 26 => .win 2 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 5) (.sequence 1 3) 2)
  | 27 => .back 28 166 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 166 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 166 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 166 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row304 : Row := ⟨304, state304, 304, action304⟩

def state305 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 15 | 19 | 20 | 21 | 23 | 24 | 27 | 28 | 29 | 30 => 0
  | 1 | 5 | 6 | 7 | 8 | 10 | 12 | 14 | 17 | 18 | 22 | 25 | 31 | 32 | 33 => 1
  | 13 | 26 => 2
  | 16 => 3
  | _ => 0

def action305 (t : Tile) : Action :=
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
  | 13 => .win 11 (FullWinWitness.standard (.triplet 13) (.triplet 16) (.sequence 0 5) (.sequence 1 1) 26)
  | 14 => .win 12 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 1 3) 26)
  | 15 => .win 11 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 1) (.sequence 1 4) 26)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 1 6) 26)
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
  | 27 => .back 28 167 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 167 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 167 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 167 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row305 : Row := ⟨305, state305, 305, action305⟩

def state306 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 15 | 19 | 20 | 21 | 23 | 24 | 27 | 28 | 29 | 30 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 12 | 14 | 17 | 18 | 22 | 25 | 31 | 32 | 33 => 1
  | 13 | 26 => 2
  | 16 => 3
  | _ => 0

def action306 (t : Tile) : Action :=
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
  | 13 => .win 11 (FullWinWitness.standard (.triplet 13) (.triplet 16) (.sequence 0 5) (.sequence 1 1) 26)
  | 14 => .win 12 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 1 3) 26)
  | 15 => .win 11 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 1) (.sequence 1 4) 26)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 1 6) 26)
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
  | 27 => .back 28 168 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 168 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 168 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 168 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row306 : Row := ⟨306, state306, 306, action306⟩

def state307 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 15 | 17 | 19 | 20 | 21 | 23 | 24 | 27 | 28 | 29 | 30 => 0
  | 1 | 5 | 6 | 7 | 8 | 10 | 12 | 14 | 18 | 22 | 25 | 31 | 32 | 33 => 1
  | 13 | 26 => 2
  | 16 => 4
  | _ => 0

def action307 (t : Tile) : Action :=
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
  | 13 => .win 11 (FullWinWitness.standard (.triplet 13) (.triplet 16) (.sequence 0 5) (.sequence 1 1) 26)
  | 14 => .win 12 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 1 3) 26)
  | 15 => .win 11 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 1) (.sequence 1 5) 13)
  | 17 => .win 15 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 1 6) 26)
  | 18 => .win 18 (FullWinWitness.standard (.triplet 16) (.triplet 18) (.sequence 0 5) (.sequence 1 3) 26)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 0) 26)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 0) 26)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 2) 26)
  | 22 => .win 22 (FullWinWitness.standard (.triplet 16) (.triplet 22) (.sequence 0 5) (.sequence 1 3) 26)
  | 23 => .win 21 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 26)
  | 24 => .win 1 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 1)
  | 25 => .win 25 (FullWinWitness.standard (.triplet 16) (.triplet 25) (.sequence 0 5) (.sequence 1 3) 26)
  | 26 => .win 1 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 5) (.sequence 1 3) 1)
  | 27 => .back 28 169 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 169 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 169 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 169 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row307 : Row := ⟨307, state307, 307, action307⟩

def state308 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 6 | 8 | 9 | 10 | 12 | 13 | 18 | 20 | 21 | 23 | 24 | 27 | 28 | 29 => 0
  | 3 | 26 => 2
  | 4 | 5 | 11 | 14 | 15 | 16 | 17 | 19 | 22 | 25 | 30 | 31 | 32 | 33 => 1
  | 7 => 4
  | _ => 0

def action308 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 27 121 [.swapSuits 0 2, .swapSuits 1 2, .reverseSuit 0, .swapHonors 0 2, .swapHonors 1 2]
  | 1 => .win 2 (FullWinWitness.standard (.triplet 7) (.sequence 0 1) (.sequence 0 3) (.sequence 1 5) 26)
  | 2 => .win 1 (FullWinWitness.standard (.triplet 7) (.sequence 0 1) (.sequence 0 3) (.sequence 1 5) 26)
  | 3 => .win 3 (FullWinWitness.standard (.triplet 3) (.triplet 7) (.sequence 0 3) (.sequence 1 5) 26)
  | 4 => .win 2 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 0 3) (.sequence 1 5) 26)
  | 5 => .win 4 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 0 3) (.sequence 1 5) 26)
  | 6 => .win 2 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 0 5) (.sequence 1 5) 26)
  | 8 => .win 6 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 0 6) (.sequence 1 5) 26)
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
  | 24 => .win 3 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 3)
  | 25 => .win 25 (FullWinWitness.standard (.triplet 7) (.triplet 25) (.sequence 0 3) (.sequence 1 5) 26)
  | 26 => .win 3 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 3)
  | 27 => .back 0 121 [.swapSuits 0 2, .swapSuits 1 2, .reverseSuit 0, .swapHonors 0 2, .swapHonors 1 2]
  | 28 => .back 0 121 [.swapSuits 0 2, .swapSuits 1 2, .reverseSuit 0, .swapHonors 1 2]
  | 29 => .back 0 121 [.swapSuits 0 2, .swapSuits 1 2, .reverseSuit 0]
  | 30 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 30)
  | 31 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row308 : Row := ⟨308, state308, 308, action308⟩

def state309 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 15 | 17 | 19 | 20 | 22 | 23 | 24 | 27 | 28 | 29 | 30 => 0
  | 1 | 5 | 6 | 7 | 8 | 10 | 12 | 14 | 18 | 21 | 25 | 31 | 32 | 33 => 1
  | 13 | 26 => 2
  | 16 => 4
  | _ => 0

def action309 (t : Tile) : Action :=
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
  | 13 => .win 11 (FullWinWitness.standard (.triplet 13) (.triplet 16) (.sequence 0 5) (.sequence 1 1) 26)
  | 14 => .win 12 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 1 3) 26)
  | 15 => .win 11 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 1) (.sequence 1 5) 13)
  | 17 => .win 15 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 1 6) 26)
  | 18 => .win 18 (FullWinWitness.standard (.triplet 16) (.triplet 18) (.sequence 0 5) (.sequence 1 3) 26)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 0) 26)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 0) 26)
  | 21 => .win 21 (FullWinWitness.standard (.triplet 16) (.triplet 21) (.sequence 0 5) (.sequence 1 3) 26)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 2) 26)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 26)
  | 24 => .win 1 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 1)
  | 25 => .win 25 (FullWinWitness.standard (.triplet 16) (.triplet 25) (.sequence 0 5) (.sequence 1 3) 26)
  | 26 => .win 1 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 5) (.sequence 1 3) 1)
  | 27 => .back 28 170 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 170 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 170 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 170 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row309 : Row := ⟨309, state309, 309, action309⟩

def state310 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 15 | 19 | 20 | 22 | 23 | 24 | 27 | 28 | 29 | 30 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 12 | 14 | 17 | 18 | 21 | 25 | 31 | 32 | 33 => 1
  | 13 | 26 => 2
  | 16 => 3
  | _ => 0

def action310 (t : Tile) : Action :=
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
  | 13 => .win 11 (FullWinWitness.standard (.triplet 13) (.triplet 16) (.sequence 0 5) (.sequence 1 1) 26)
  | 14 => .win 12 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 1 3) 26)
  | 15 => .win 11 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 1) (.sequence 1 4) 26)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 1 6) 26)
  | 17 => .win 17 (FullWinWitness.standard (.triplet 16) (.triplet 17) (.sequence 0 5) (.sequence 1 3) 26)
  | 18 => .win 18 (FullWinWitness.standard (.triplet 16) (.triplet 18) (.sequence 0 5) (.sequence 1 3) 26)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 0) 26)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 0) 26)
  | 21 => .win 21 (FullWinWitness.standard (.triplet 16) (.triplet 21) (.sequence 0 5) (.sequence 1 3) 26)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 2) 26)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 26)
  | 24 => .win 2 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 2)
  | 25 => .win 25 (FullWinWitness.standard (.triplet 16) (.triplet 25) (.sequence 0 5) (.sequence 1 3) 26)
  | 26 => .win 2 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 5) (.sequence 1 3) 2)
  | 27 => .back 28 171 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 171 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 171 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 171 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row310 : Row := ⟨310, state310, 310, action310⟩

def state311 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 6 | 8 | 9 | 10 | 12 | 13 | 19 | 20 | 22 | 23 | 24 | 27 | 28 | 29 => 0
  | 3 | 5 | 11 | 14 | 15 | 16 | 17 | 18 | 21 | 25 | 30 | 31 | 32 | 33 => 1
  | 4 | 26 => 2
  | 7 => 4
  | _ => 0

def action311 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 27 139 [.swapSuits 0 1, .reverseSuit 0, .swapHonors 0 2, .swapHonors 1 2]
  | 1 => .back 27 172 [.swapSuits 0 1, .swapHonors 0 2, .swapHonors 1 2]
  | 2 => .win 3 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 0 3) (.sequence 1 5) 26)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 0 3) (.sequence 1 5) 26)
  | 4 => .win 4 (FullWinWitness.standard (.triplet 4) (.triplet 7) (.sequence 0 3) (.sequence 1 5) 26)
  | 5 => .win 3 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 0 3) (.sequence 1 5) 26)
  | 6 => .win 2 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 0 4) (.sequence 1 5) 26)
  | 8 => .win 6 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 0 6) (.sequence 1 5) 26)
  | 9 => .win 10 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 0) (.sequence 1 5) 26)
  | 10 => .win 9 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 0) (.sequence 1 5) 26)
  | 11 => .win 11 (FullWinWitness.standard (.triplet 7) (.triplet 11) (.sequence 0 3) (.sequence 1 5) 26)
  | 12 => .win 10 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 1) (.sequence 1 5) 26)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 2) (.sequence 1 5) 26)
  | 14 => .win 14 (FullWinWitness.standard (.triplet 7) (.triplet 14) (.sequence 0 3) (.sequence 1 6) 26)
  | 15 => .win 13 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 4) (.sequence 1 6) 26)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 1 6) 26)
  | 17 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 3) (.sequence 1 5) 26)
  | 18 => .win 18 (FullWinWitness.standard (.triplet 7) (.triplet 18) (.sequence 0 3) (.sequence 1 5) 26)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 0) 26)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 0) 26)
  | 21 => .win 21 (FullWinWitness.standard (.triplet 7) (.triplet 21) (.sequence 0 3) (.sequence 1 5) 26)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 2) 26)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 3) 26)
  | 24 => .win 4 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 4)
  | 25 => .win 25 (FullWinWitness.standard (.triplet 7) (.triplet 25) (.sequence 0 3) (.sequence 1 5) 26)
  | 26 => .win 4 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 4)
  | 27 => .back 0 139 [.swapSuits 0 1, .reverseSuit 0, .swapHonors 0 2, .swapHonors 1 2]
  | 28 => .back 0 139 [.swapSuits 0 1, .reverseSuit 0, .swapHonors 1 2]
  | 29 => .back 0 139 [.swapSuits 0 1, .reverseSuit 0]
  | 30 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 30)
  | 31 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row311 : Row := ⟨311, state311, 311, action311⟩

def state312 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 15 | 17 | 19 | 20 | 22 | 23 | 24 | 27 | 28 | 29 | 30 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 12 | 14 | 18 | 21 | 25 | 31 | 32 | 33 => 1
  | 13 | 26 => 2
  | 16 => 4
  | _ => 0

def action312 (t : Tile) : Action :=
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
  | 13 => .win 11 (FullWinWitness.standard (.triplet 13) (.triplet 16) (.sequence 0 5) (.sequence 1 1) 26)
  | 14 => .win 12 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 1 3) 26)
  | 15 => .win 11 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 1) (.sequence 1 5) 13)
  | 17 => .win 15 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 1 6) 26)
  | 18 => .win 18 (FullWinWitness.standard (.triplet 16) (.triplet 18) (.sequence 0 5) (.sequence 1 3) 26)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 0) 26)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 0) 26)
  | 21 => .win 21 (FullWinWitness.standard (.triplet 16) (.triplet 21) (.sequence 0 5) (.sequence 1 3) 26)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 2) 26)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 26)
  | 24 => .win 2 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 2)
  | 25 => .win 25 (FullWinWitness.standard (.triplet 16) (.triplet 25) (.sequence 0 5) (.sequence 1 3) 26)
  | 26 => .win 2 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 5) (.sequence 1 3) 2)
  | 27 => .back 28 172 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 172 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 172 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 172 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row312 : Row := ⟨312, state312, 312, action312⟩

def state313 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 6 | 8 | 10 | 11 | 12 | 13 | 19 | 20 | 22 | 23 | 24 | 27 | 28 | 29 | 30 => 0
  | 1 | 3 | 5 | 9 | 14 | 15 | 16 | 17 | 18 | 21 | 25 | 31 | 32 | 33 => 1
  | 4 | 26 => 2
  | 7 => 4
  | _ => 0

def action313 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 2 (FullWinWitness.standard (.triplet 7) (.sequence 0 0) (.sequence 0 3) (.sequence 1 5) 26)
  | 1 => .win 1 (FullWinWitness.standard (.triplet 1) (.triplet 7) (.sequence 0 3) (.sequence 1 5) 26)
  | 2 => .win 0 (FullWinWitness.standard (.triplet 7) (.sequence 0 0) (.sequence 0 3) (.sequence 1 5) 26)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 7) (.sequence 0 1) (.sequence 0 3) (.sequence 1 5) 26)
  | 4 => .win 2 (FullWinWitness.standard (.triplet 4) (.triplet 7) (.sequence 0 1) (.sequence 1 5) 26)
  | 5 => .win 3 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 0 3) (.sequence 1 5) 26)
  | 6 => .win 2 (FullWinWitness.standard (.triplet 7) (.sequence 0 1) (.sequence 0 5) (.sequence 1 5) 4)
  | 8 => .win 6 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 0 6) (.sequence 1 5) 26)
  | 9 => .win 9 (FullWinWitness.standard (.triplet 7) (.triplet 9) (.sequence 0 3) (.sequence 1 5) 26)
  | 10 => .win 11 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 0) (.sequence 1 5) 26)
  | 11 => .win 10 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 0) (.sequence 1 5) 26)
  | 12 => .win 13 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 3) (.sequence 1 6) 26)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 3) (.sequence 1 6) 26)
  | 14 => .win 14 (FullWinWitness.standard (.triplet 7) (.triplet 14) (.sequence 0 3) (.sequence 1 6) 26)
  | 15 => .win 13 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 4) (.sequence 1 6) 26)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 1 6) 26)
  | 17 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 3) (.sequence 1 5) 26)
  | 18 => .win 18 (FullWinWitness.standard (.triplet 7) (.triplet 18) (.sequence 0 3) (.sequence 1 5) 26)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 0) 26)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 0) 26)
  | 21 => .win 21 (FullWinWitness.standard (.triplet 7) (.triplet 21) (.sequence 0 3) (.sequence 1 5) 26)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 2) 26)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 3) 26)
  | 24 => .win 1 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 1)
  | 25 => .win 25 (FullWinWitness.standard (.triplet 7) (.triplet 25) (.sequence 0 3) (.sequence 1 5) 26)
  | 26 => .win 1 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 1)
  | 27 => .back 28 173 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 173 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 173 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 173 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row313 : Row := ⟨313, state313, 313, action313⟩

def state314 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 4 | 5 | 6 | 9 | 11 | 15 | 17 | 19 | 20 | 21 | 22 | 27 | 28 | 29 => 0
  | 3 | 7 | 10 | 12 | 14 | 18 | 23 | 24 | 25 | 26 | 30 | 31 | 32 | 33 => 1
  | 8 | 13 => 2
  | 16 => 4
  | _ => 0

def action314 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 27 173 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 0 2, .swapHonors 1 2]
  | 1 => .win 2 (FullWinWitness.standard (.triplet 16) (.sequence 0 1) (.sequence 1 3) (.sequence 2 5) 8)
  | 2 => .win 1 (FullWinWitness.standard (.triplet 16) (.sequence 0 1) (.sequence 1 3) (.sequence 2 5) 8)
  | 3 => .win 3 (FullWinWitness.standard (.triplet 3) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 8)
  | 4 => .win 2 (FullWinWitness.standard (.triplet 16) (.sequence 0 2) (.sequence 1 3) (.sequence 2 5) 8)
  | 5 => .win 4 (FullWinWitness.standard (.triplet 16) (.sequence 0 3) (.sequence 1 3) (.sequence 2 5) 8)
  | 6 => .win 3 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 3)
  | 7 => .win 7 (FullWinWitness.standard (.triplet 7) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 8)
  | 8 => .win 3 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 3)
  | 9 => .win 11 (FullWinWitness.standard (.triplet 16) (.sequence 1 0) (.sequence 1 3) (.sequence 2 5) 8)
  | 10 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 10)
  | 11 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 1) (.sequence 2 5) 13)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 16) (.sequence 1 1) (.sequence 1 3) (.sequence 2 5) 8)
  | 13 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 13)
  | 14 => .win 12 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 1 3) (.sequence 2 5) 8)
  | 15 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 5) (.sequence 2 5) 13)
  | 17 => .win 15 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 1 6) (.sequence 2 5) 8)
  | 18 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 18)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 0) (.sequence 2 5) 8)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 0) (.sequence 2 5) 8)
  | 21 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 3) (.sequence 2 6) 8)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 3) (.sequence 2 6) 8)
  | 23 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 6) 23)
  | 24 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 4) (.sequence 2 6) 8)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 5) (.sequence 2 6) 8)
  | 26 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 26)
  | 27 => .back 0 173 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 0 2, .swapHonors 1 2]
  | 28 => .back 0 173 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 1 2]
  | 29 => .back 0 173 [.swapSuits 0 2, .swapSuits 1 2]
  | 30 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 30)
  | 31 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row314 : Row := ⟨314, state314, 314, action314⟩

def state315 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 6 | 10 | 11 | 12 | 13 | 19 | 20 | 22 | 23 | 24 | 27 | 28 | 29 => 0
  | 2 | 3 | 4 | 5 | 8 | 9 | 14 | 15 | 16 | 17 | 18 | 21 | 25 | 30 | 31 | 32 | 33 => 1
  | 7 => 3
  | 26 => 2
  | _ => 0

def action315 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 1 (FullWinWitness.standard (.triplet 7) (.sequence 0 0) (.sequence 0 3) (.sequence 1 5) 26)
  | 1 => .win 0 (FullWinWitness.standard (.triplet 7) (.sequence 0 0) (.sequence 0 3) (.sequence 1 5) 26)
  | 2 => .win 2 (FullWinWitness.standard (.triplet 2) (.triplet 7) (.sequence 0 3) (.sequence 1 5) 26)
  | 3 => .win 1 (FullWinWitness.standard (.triplet 7) (.sequence 0 1) (.sequence 0 3) (.sequence 1 5) 26)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 0 3) (.sequence 1 5) 26)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 7) (.sequence 0 2) (.sequence 1 5) 26)
  | 6 => .win 1 (FullWinWitness.standard (.triplet 7) (.sequence 0 1) (.sequence 0 4) (.sequence 1 5) 26)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 0 5) (.sequence 1 5) 26)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 7) (.triplet 8) (.sequence 0 2) (.sequence 1 5) 26)
  | 9 => .win 9 (FullWinWitness.standard (.triplet 7) (.triplet 9) (.sequence 0 2) (.sequence 1 5) 26)
  | 10 => .win 11 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 0) (.sequence 1 5) 26)
  | 11 => .win 10 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 0) (.sequence 1 5) 26)
  | 12 => .win 13 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 3) (.sequence 1 6) 26)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 3) (.sequence 1 6) 26)
  | 14 => .win 14 (FullWinWitness.standard (.triplet 7) (.triplet 14) (.sequence 0 2) (.sequence 1 6) 26)
  | 15 => .win 13 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 4) (.sequence 1 6) 26)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 5) (.sequence 1 6) 26)
  | 17 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 2) (.sequence 1 5) 26)
  | 18 => .win 18 (FullWinWitness.standard (.triplet 7) (.triplet 18) (.sequence 0 2) (.sequence 1 5) 26)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 5) (.sequence 2 0) 26)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 5) (.sequence 2 0) 26)
  | 21 => .win 21 (FullWinWitness.standard (.triplet 7) (.triplet 21) (.sequence 0 2) (.sequence 1 5) 26)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 5) (.sequence 2 2) 26)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 5) (.sequence 2 3) 26)
  | 24 => .win 2 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 2)
  | 25 => .win 25 (FullWinWitness.standard (.triplet 7) (.triplet 25) (.sequence 0 2) (.sequence 1 5) 26)
  | 26 => .win 2 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 2)
  | 27 => .back 28 174 [.swapHonors 0 2]
  | 28 => .back 27 174 [.swapHonors 0 1, .swapHonors 1 2]
  | 29 => .back 27 174 [.swapHonors 0 1]
  | 30 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 5) (.sequence 2 6) 30)
  | 31 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 5) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 5) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 5) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row315 : Row := ⟨315, state315, 315, action315⟩

def state316 (t : Tile) : Nat :=
  match t.val with
  | 0 | 6 | 7 | 10 | 11 | 12 | 13 | 19 | 20 | 22 | 23 | 25 | 27 | 28 | 29 | 30 | 31 => 0
  | 1 => 3
  | 2 | 3 | 4 | 5 | 8 | 9 | 14 | 15 | 16 | 17 | 18 | 21 | 24 | 32 | 33 => 1
  | 26 => 2
  | _ => 0

def action316 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 1 (FullWinWitness.standard (.triplet 1) (.sequence 0 0) (.sequence 0 3) (.sequence 1 5) 26)
  | 1 => .win 0 (FullWinWitness.standard (.triplet 1) (.sequence 0 0) (.sequence 0 3) (.sequence 1 5) 26)
  | 2 => .win 2 (FullWinWitness.standard (.triplet 1) (.triplet 2) (.sequence 0 3) (.sequence 1 5) 26)
  | 3 => .win 1 (FullWinWitness.standard (.triplet 1) (.sequence 0 1) (.sequence 0 3) (.sequence 1 5) 26)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 1) (.sequence 0 2) (.sequence 0 3) (.sequence 1 5) 26)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 1) (.triplet 5) (.sequence 0 2) (.sequence 1 5) 26)
  | 6 => .win 1 (FullWinWitness.standard (.triplet 1) (.sequence 0 1) (.sequence 0 4) (.sequence 1 5) 26)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 1) (.sequence 0 2) (.sequence 0 5) (.sequence 1 5) 26)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 1) (.triplet 8) (.sequence 0 2) (.sequence 1 5) 26)
  | 9 => .win 9 (FullWinWitness.standard (.triplet 1) (.triplet 9) (.sequence 0 2) (.sequence 1 5) 26)
  | 10 => .win 11 (FullWinWitness.standard (.triplet 1) (.sequence 0 2) (.sequence 1 0) (.sequence 1 5) 26)
  | 11 => .win 10 (FullWinWitness.standard (.triplet 1) (.sequence 0 2) (.sequence 1 0) (.sequence 1 5) 26)
  | 12 => .win 13 (FullWinWitness.standard (.triplet 1) (.sequence 0 2) (.sequence 1 3) (.sequence 1 6) 26)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 1) (.sequence 0 2) (.sequence 1 3) (.sequence 1 6) 26)
  | 14 => .win 14 (FullWinWitness.standard (.triplet 1) (.triplet 14) (.sequence 0 2) (.sequence 1 6) 26)
  | 15 => .win 13 (FullWinWitness.standard (.triplet 1) (.sequence 0 2) (.sequence 1 4) (.sequence 1 6) 26)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 1) (.sequence 0 2) (.sequence 1 5) (.sequence 1 6) 26)
  | 17 => .win 17 (FullWinWitness.standard (.triplet 1) (.triplet 17) (.sequence 0 2) (.sequence 1 5) 26)
  | 18 => .win 18 (FullWinWitness.standard (.triplet 1) (.triplet 18) (.sequence 0 2) (.sequence 1 5) 26)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 1) (.sequence 0 2) (.sequence 1 5) (.sequence 2 0) 26)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 1) (.sequence 0 2) (.sequence 1 5) (.sequence 2 0) 26)
  | 21 => .win 21 (FullWinWitness.standard (.triplet 1) (.triplet 21) (.sequence 0 2) (.sequence 1 5) 26)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 1) (.sequence 0 2) (.sequence 1 5) (.sequence 2 2) 26)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 1) (.sequence 0 2) (.sequence 1 5) (.sequence 2 3) 26)
  | 24 => .win 24 (FullWinWitness.standard (.triplet 1) (.triplet 24) (.sequence 0 2) (.sequence 1 5) 26)
  | 25 => .win 0 (FullWinWitness.standard (.sequence 0 0) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 1)
  | 26 => .win 0 (FullWinWitness.standard (.triplet 26) (.sequence 0 0) (.sequence 0 3) (.sequence 1 5) 1)
  | 27 => .back 28 175 [.swapHonors 0 4, .swapHonors 1 3, .swapHonors 2 4]
  | 28 => .back 27 175 [.swapHonors 0 3, .swapHonors 1 4, .swapHonors 2 3, .swapHonors 3 4]
  | 29 => .back 27 175 [.swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 4]
  | 30 => .back 27 175 [.swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 3, .swapHonors 3 4]
  | 31 => .back 27 175 [.swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 3]
  | 32 => .win 25 (FullWinWitness.standard (.triplet 1) (.sequence 0 2) (.sequence 1 5) (.sequence 2 6) 32)
  | 33 => .win 25 (FullWinWitness.standard (.triplet 1) (.sequence 0 2) (.sequence 1 5) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row316 : Row := ⟨316, state316, 316, action316⟩

def state317 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 15 | 16 | 19 | 20 | 22 | 23 | 25 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 1 | 5 | 6 | 7 | 8 | 12 | 13 | 17 | 18 | 21 | 24 | 33 => 1
  | 10 => 4
  | 14 | 26 => 2
  | _ => 0

def action317 (t : Tile) : Action :=
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
  | 24 => .win 24 (FullWinWitness.standard (.triplet 10) (.triplet 24) (.sequence 0 5) (.sequence 1 3) 26)
  | 25 => .win 1 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 1)
  | 26 => .win 1 (FullWinWitness.standard (.triplet 10) (.triplet 26) (.sequence 0 5) (.sequence 1 3) 1)
  | 27 => .back 28 176 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 176 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 176 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 176 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 176 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 176 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 25 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row317 : Row := ⟨317, state317, 317, action317⟩

def state318 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 15 | 17 | 19 | 20 | 22 | 23 | 25 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 1 | 5 | 6 | 7 | 8 | 10 | 12 | 14 | 18 | 21 | 24 | 33 => 1
  | 13 | 26 => 2
  | 16 => 4
  | _ => 0

def action318 (t : Tile) : Action :=
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
  | 13 => .win 11 (FullWinWitness.standard (.triplet 13) (.triplet 16) (.sequence 0 5) (.sequence 1 1) 26)
  | 14 => .win 12 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 1 3) 26)
  | 15 => .win 11 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 1) (.sequence 1 5) 13)
  | 17 => .win 15 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 1 6) 26)
  | 18 => .win 18 (FullWinWitness.standard (.triplet 16) (.triplet 18) (.sequence 0 5) (.sequence 1 3) 26)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 0) 26)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 0) 26)
  | 21 => .win 21 (FullWinWitness.standard (.triplet 16) (.triplet 21) (.sequence 0 5) (.sequence 1 3) 26)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 2) 26)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 26)
  | 24 => .win 24 (FullWinWitness.standard (.triplet 16) (.triplet 24) (.sequence 0 5) (.sequence 1 3) 26)
  | 25 => .win 1 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 1)
  | 26 => .win 1 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 5) (.sequence 1 3) 1)
  | 27 => .back 28 177 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 177 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 177 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 177 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 177 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 177 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row318 : Row := ⟨318, state318, 318, action318⟩

def state319 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 6 | 8 | 9 | 11 | 12 | 13 | 19 | 20 | 22 | 23 | 25 | 27 | 28 | 29 | 30 | 31 => 0
  | 3 | 26 => 2
  | 4 | 5 | 10 | 14 | 15 | 16 | 17 | 18 | 21 | 24 | 32 | 33 => 1
  | 7 => 4
  | _ => 0

def action319 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 27 176 [.swapSuits 0 1, .reverseSuit 0, .swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 1 => .win 2 (FullWinWitness.standard (.triplet 7) (.sequence 0 1) (.sequence 0 3) (.sequence 1 5) 26)
  | 2 => .win 1 (FullWinWitness.standard (.triplet 7) (.sequence 0 1) (.sequence 0 3) (.sequence 1 5) 26)
  | 3 => .win 3 (FullWinWitness.standard (.triplet 3) (.triplet 7) (.sequence 0 3) (.sequence 1 5) 26)
  | 4 => .win 2 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 0 3) (.sequence 1 5) 26)
  | 5 => .win 4 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 0 3) (.sequence 1 5) 26)
  | 6 => .win 2 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 0 5) (.sequence 1 5) 26)
  | 8 => .win 6 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 0 6) (.sequence 1 5) 26)
  | 9 => .win 11 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 0) (.sequence 1 5) 26)
  | 10 => .win 10 (FullWinWitness.standard (.triplet 7) (.triplet 10) (.sequence 0 3) (.sequence 1 5) 26)
  | 11 => .win 9 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 0) (.sequence 1 5) 26)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 1) (.sequence 1 5) 26)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 3) (.sequence 1 6) 26)
  | 14 => .win 14 (FullWinWitness.standard (.triplet 7) (.triplet 14) (.sequence 0 3) (.sequence 1 6) 26)
  | 15 => .win 13 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 4) (.sequence 1 6) 26)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 1 6) 26)
  | 17 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 3) (.sequence 1 5) 26)
  | 18 => .win 18 (FullWinWitness.standard (.triplet 7) (.triplet 18) (.sequence 0 3) (.sequence 1 5) 26)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 0) 26)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 0) 26)
  | 21 => .win 21 (FullWinWitness.standard (.triplet 7) (.triplet 21) (.sequence 0 3) (.sequence 1 5) 26)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 2) 26)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 3) 26)
  | 24 => .win 24 (FullWinWitness.standard (.triplet 7) (.triplet 24) (.sequence 0 3) (.sequence 1 5) 26)
  | 25 => .win 3 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 3)
  | 26 => .win 3 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 3)
  | 27 => .back 0 176 [.swapSuits 0 1, .reverseSuit 0, .swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 28 => .back 0 176 [.swapSuits 0 1, .reverseSuit 0, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 29 => .back 0 176 [.swapSuits 0 1, .reverseSuit 0, .swapHonors 2 4, .swapHonors 3 4]
  | 30 => .back 0 176 [.swapSuits 0 1, .reverseSuit 0, .swapHonors 3 4]
  | 31 => .back 0 176 [.swapSuits 0 1, .reverseSuit 0]
  | 32 => .win 25 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 32)
  | 33 => .win 25 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row319 : Row := ⟨319, state319, 319, action319⟩

end Mahjong.Scale12V2
