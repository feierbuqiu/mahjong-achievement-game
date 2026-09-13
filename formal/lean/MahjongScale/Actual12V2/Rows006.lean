import MahjongScale.Actual12V2.Base

set_option maxRecDepth 32768
set_option maxHeartbeats 100000000

namespace Mahjong.Scale12V2
open ResponseTable ResponseCertificate Generators

def state384 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 4 | 5 | 6 | 9 | 10 | 11 | 15 | 17 | 18 | 20 | 21 | 22 | 27 | 28 | 29 | 30 => 0
  | 3 | 7 | 13 | 14 | 19 | 23 | 24 | 25 | 26 | 31 | 32 | 33 => 1
  | 8 | 12 => 2
  | 16 => 4
  | _ => 0

def action384 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 9 234 [.swapSuits 0 2, .reverseSuit 1]
  | 1 => .win 2 (FullWinWitness.standard (.triplet 16) (.sequence 0 1) (.sequence 1 3) (.sequence 2 5) 8)
  | 2 => .win 1 (FullWinWitness.standard (.triplet 16) (.sequence 0 1) (.sequence 1 3) (.sequence 2 5) 8)
  | 3 => .win 3 (FullWinWitness.standard (.triplet 3) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 8)
  | 4 => .win 2 (FullWinWitness.standard (.triplet 16) (.sequence 0 2) (.sequence 1 3) (.sequence 2 5) 8)
  | 5 => .win 4 (FullWinWitness.standard (.triplet 16) (.sequence 0 3) (.sequence 1 3) (.sequence 2 5) 8)
  | 6 => .win 3 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 3)
  | 7 => .win 7 (FullWinWitness.standard (.triplet 7) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 8)
  | 8 => .win 3 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 3)
  | 9 => .back 27 235 [.swapSuits 1 2, .reverseSuit 1, .swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 3]
  | 10 => .win 11 (FullWinWitness.standard (.triplet 16) (.sequence 1 1) (.sequence 1 3) (.sequence 2 5) 8)
  | 11 => .win 10 (FullWinWitness.standard (.triplet 16) (.sequence 1 1) (.sequence 1 3) (.sequence 2 5) 8)
  | 12 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 12)
  | 13 => .win 11 (FullWinWitness.standard (.triplet 16) (.sequence 1 2) (.sequence 1 3) (.sequence 2 5) 8)
  | 14 => .win 13 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 1 3) (.sequence 2 5) 8)
  | 15 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 4) (.sequence 2 5) 12)
  | 17 => .win 15 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 1 6) (.sequence 2 5) 8)
  | 18 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 0) (.sequence 2 5) 8)
  | 19 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 19)
  | 20 => .win 18 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 0) (.sequence 2 5) 8)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 1) (.sequence 2 5) 8)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 3) (.sequence 2 6) 8)
  | 23 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 6) 23)
  | 24 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 4) (.sequence 2 6) 8)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 5) (.sequence 2 6) 8)
  | 26 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 26)
  | 27 => .back 9 235 [.swapSuits 1 2, .reverseSuit 1, .swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 3]
  | 28 => .back 9 235 [.swapSuits 1 2, .reverseSuit 1, .swapHonors 1 3, .swapHonors 2 3]
  | 29 => .back 9 235 [.swapSuits 1 2, .reverseSuit 1, .swapHonors 2 3]
  | 30 => .back 9 235 [.swapSuits 1 2, .reverseSuit 1]
  | 31 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row384 : Row := ⟨384, state384, 384, action384⟩

def state385 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 15 | 16 | 19 | 20 | 22 | 23 | 24 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 2 | 5 | 6 | 7 | 8 | 12 | 13 | 17 | 18 | 21 | 25 | 33 => 1
  | 10 => 4
  | 14 | 26 => 2
  | _ => 0

def action385 (t : Tile) : Action :=
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
  | 27 => .back 28 236 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 236 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 236 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 236 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 236 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 236 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row385 : Row := ⟨385, state385, 385, action385⟩

def state386 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 4 | 5 | 6 | 9 | 10 | 11 | 15 | 17 | 18 | 19 | 21 | 22 | 27 | 28 | 29 | 30 => 0
  | 3 | 7 | 13 | 14 | 20 | 23 | 24 | 25 | 26 | 31 | 32 | 33 => 1
  | 8 | 12 => 2
  | 16 => 4
  | _ => 0

def action386 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 9 236 [.swapSuits 0 2, .reverseSuit 1]
  | 1 => .win 2 (FullWinWitness.standard (.triplet 16) (.sequence 0 1) (.sequence 1 3) (.sequence 2 5) 8)
  | 2 => .win 1 (FullWinWitness.standard (.triplet 16) (.sequence 0 1) (.sequence 1 3) (.sequence 2 5) 8)
  | 3 => .win 3 (FullWinWitness.standard (.triplet 3) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 8)
  | 4 => .win 2 (FullWinWitness.standard (.triplet 16) (.sequence 0 2) (.sequence 1 3) (.sequence 2 5) 8)
  | 5 => .win 4 (FullWinWitness.standard (.triplet 16) (.sequence 0 3) (.sequence 1 3) (.sequence 2 5) 8)
  | 6 => .win 3 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 3)
  | 7 => .win 7 (FullWinWitness.standard (.triplet 7) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 8)
  | 8 => .win 3 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 3)
  | 9 => .back 0 236 [.swapSuits 0 2, .reverseSuit 1]
  | 10 => .win 11 (FullWinWitness.standard (.triplet 16) (.sequence 1 1) (.sequence 1 3) (.sequence 2 5) 8)
  | 11 => .win 10 (FullWinWitness.standard (.triplet 16) (.sequence 1 1) (.sequence 1 3) (.sequence 2 5) 8)
  | 12 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 12)
  | 13 => .win 11 (FullWinWitness.standard (.triplet 16) (.sequence 1 2) (.sequence 1 3) (.sequence 2 5) 8)
  | 14 => .win 13 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 1 3) (.sequence 2 5) 8)
  | 15 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 4) (.sequence 2 5) 12)
  | 17 => .win 15 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 1 6) (.sequence 2 5) 8)
  | 18 => .win 19 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 0) (.sequence 2 5) 8)
  | 19 => .win 18 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 0) (.sequence 2 5) 8)
  | 20 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 20)
  | 21 => .win 19 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 1) (.sequence 2 5) 8)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 2) (.sequence 2 5) 8)
  | 23 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 6) 23)
  | 24 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 4) (.sequence 2 6) 8)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 5) (.sequence 2 6) 8)
  | 26 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 26)
  | 27 => .back 9 237 [.swapSuits 1 2, .reverseSuit 1, .swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 3]
  | 28 => .back 9 237 [.swapSuits 1 2, .reverseSuit 1, .swapHonors 1 3, .swapHonors 2 3]
  | 29 => .back 9 237 [.swapSuits 1 2, .reverseSuit 1, .swapHonors 2 3]
  | 30 => .back 9 237 [.swapSuits 1 2, .reverseSuit 1]
  | 31 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row386 : Row := ⟨386, state386, 386, action386⟩

def state387 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 4 | 5 | 6 | 9 | 10 | 12 | 13 | 18 | 20 | 24 | 25 | 27 | 28 | 29 | 30 | 31 => 0
  | 3 | 7 | 11 | 14 | 15 | 16 | 17 | 21 | 22 | 26 | 32 | 33 => 1
  | 8 | 23 => 2
  | 19 => 4
  | _ => 0

def action387 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 27 236 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
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
  | 27 => .back 0 236 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 28 => .back 0 236 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 29 => .back 0 236 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 2 4, .swapHonors 3 4]
  | 30 => .back 0 236 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 3 4]
  | 31 => .back 0 236 [.swapSuits 0 2, .swapSuits 1 2]
  | 32 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row387 : Row := ⟨387, state387, 387, action387⟩

def state388 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 4 | 9 | 11 | 15 | 16 | 19 | 20 | 22 | 23 | 24 | 27 | 28 | 29 | 30 => 0
  | 5 | 6 | 7 | 8 | 12 | 13 | 17 | 18 | 21 | 25 | 31 | 32 | 33 => 1
  | 10 => 3
  | 14 | 26 => 2
  | _ => 0

def action388 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 9 232 [.swapSuits 1 2, .reverseSuit 1]
  | 1 => .back 10 234 []
  | 2 => .back 10 236 []
  | 3 => .win 4 (FullWinWitness.standard (.triplet 10) (.sequence 0 3) (.sequence 0 6) (.sequence 1 3) 26)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 10) (.sequence 0 3) (.sequence 0 6) (.sequence 1 3) 26)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 10) (.sequence 0 6) (.sequence 1 3) 26)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 10) (.sequence 0 4) (.sequence 0 6) (.sequence 1 3) 26)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 0 6) (.sequence 1 3) 26)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 0 5) (.sequence 1 3) 26)
  | 9 => .back 0 232 [.swapSuits 1 2, .reverseSuit 1]
  | 10 => .back 2 236 []
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
  | 27 => .back 28 238 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 238 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 238 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 238 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row388 : Row := ⟨388, state388, 388, action388⟩

def state389 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 4 | 9 | 10 | 11 | 13 | 14 | 15 | 18 | 20 | 24 | 25 | 27 | 28 | 29 => 0
  | 5 | 6 | 7 | 8 | 12 | 16 | 21 | 22 | 26 | 30 | 31 | 32 | 33 => 1
  | 17 | 23 => 2
  | 19 => 3
  | _ => 0

def action389 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 18 233 [.swapSuits 0 1, .reverseSuit 2]
  | 1 => .back 19 235 [.swapSuits 0 1]
  | 2 => .back 19 237 [.swapSuits 0 1]
  | 3 => .win 4 (FullWinWitness.standard (.triplet 19) (.sequence 0 3) (.sequence 0 6) (.sequence 2 3) 17)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 19) (.sequence 0 3) (.sequence 0 6) (.sequence 2 3) 17)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 19) (.sequence 0 6) (.sequence 2 3) 17)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 19) (.sequence 0 4) (.sequence 0 6) (.sequence 2 3) 17)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 0 6) (.sequence 2 3) 17)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 17)
  | 9 => .back 27 238 [.swapSuits 1 2, .swapHonors 0 2, .swapHonors 1 2]
  | 10 => .win 11 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 1) (.sequence 2 3) 17)
  | 11 => .win 10 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 1) (.sequence 2 3) 17)
  | 12 => .win 12 (FullWinWitness.standard (.triplet 12) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 17)
  | 13 => .win 11 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 2) (.sequence 2 3) 17)
  | 14 => .win 13 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 17)
  | 15 => .win 5 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 6) (.sequence 2 3) 5)
  | 16 => .win 16 (FullWinWitness.standard (.triplet 16) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 17)
  | 17 => .win 5 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 6) (.sequence 2 3) 5)
  | 18 => .back 0 233 [.swapSuits 0 1, .reverseSuit 2]
  | 19 => .back 1 235 [.swapSuits 0 1]
  | 20 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 2) 23)
  | 21 => .win 22 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 23 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 23)
  | 24 => .win 22 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 3) (.sequence 2 4) 17)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 3) (.sequence 2 5) 17)
  | 26 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 26)
  | 27 => .back 9 238 [.swapSuits 1 2, .swapHonors 0 2, .swapHonors 1 2]
  | 28 => .back 9 238 [.swapSuits 1 2, .swapHonors 1 2]
  | 29 => .back 9 238 [.swapSuits 1 2]
  | 30 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 30)
  | 31 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row389 : Row := ⟨389, state389, 389, action389⟩

def state390 (t : Tile) : Nat :=
  match t.val with
  | 0 | 5 | 6 | 7 | 8 | 9 | 13 | 16 | 18 | 21 | 22 | 26 | 33 => 1
  | 1 | 2 | 3 | 4 | 10 | 11 | 12 | 14 | 15 | 19 | 20 | 24 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 17 | 23 => 2
  | 25 => 3
  | _ => 0

def action390 (t : Tile) : Action :=
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
  | 27 => .back 28 239 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 239 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 239 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 239 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 239 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 239 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row390 : Row := ⟨390, state390, 390, action390⟩

def state391 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 5 | 6 | 9 | 10 | 11 | 15 | 19 | 20 | 21 | 22 | 27 | 28 | 29 | 30 => 0
  | 4 | 7 | 12 | 13 | 17 | 18 | 23 | 24 | 25 | 26 | 31 | 32 | 33 => 1
  | 8 | 14 => 2
  | 16 => 3
  | _ => 0

def action391 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 9 239 [.swapSuits 0 1, .swapSuits 1 2]
  | 1 => .back 10 187 []
  | 2 => .win 3 (FullWinWitness.standard (.triplet 16) (.sequence 0 2) (.sequence 1 3) (.sequence 2 5) 8)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 16) (.sequence 0 2) (.sequence 1 3) (.sequence 2 5) 8)
  | 4 => .win 4 (FullWinWitness.standard (.triplet 4) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 8)
  | 5 => .win 3 (FullWinWitness.standard (.triplet 16) (.sequence 0 3) (.sequence 1 3) (.sequence 2 5) 8)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 4)
  | 7 => .win 7 (FullWinWitness.standard (.triplet 7) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 8)
  | 8 => .win 4 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 4)
  | 9 => .back 0 239 [.swapSuits 0 1, .swapSuits 1 2]
  | 10 => .back 1 187 []
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
  | 27 => .back 28 240 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 240 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 240 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 240 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row391 : Row := ⟨391, state391, 391, action391⟩

def state392 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 15 | 19 | 20 | 21 | 23 | 24 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 1 | 5 | 6 | 7 | 8 | 10 | 12 | 13 | 17 | 18 | 22 | 25 | 33 => 1
  | 14 | 26 => 2
  | 16 => 3
  | _ => 0

def action392 (t : Tile) : Action :=
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
  | 27 => .back 28 241 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 241 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 241 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 241 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 241 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 241 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row392 : Row := ⟨392, state392, 392, action392⟩

def state393 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 5 | 6 | 9 | 11 | 12 | 13 | 18 | 20 | 24 | 27 | 28 | 29 | 30 | 31 => 0
  | 4 | 7 | 10 | 14 | 15 | 16 | 17 | 19 | 21 | 22 | 26 | 32 | 33 => 1
  | 8 | 23 => 2
  | 25 => 3
  | _ => 0

def action393 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 27 241 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 1 => .back 27 196 [.swapSuits 0 1, .swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 2 => .win 3 (FullWinWitness.standard (.triplet 25) (.sequence 0 2) (.sequence 1 5) (.sequence 2 3) 8)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 2) (.sequence 1 5) (.sequence 2 3) 8)
  | 4 => .win 4 (FullWinWitness.standard (.triplet 4) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 8)
  | 5 => .win 3 (FullWinWitness.standard (.triplet 25) (.sequence 0 3) (.sequence 1 5) (.sequence 2 3) 8)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 4)
  | 7 => .win 7 (FullWinWitness.standard (.triplet 7) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 8)
  | 8 => .win 4 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 4)
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
  | 27 => .back 1 196 [.swapSuits 0 1, .swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 28 => .back 1 196 [.swapSuits 0 1, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 29 => .back 1 196 [.swapSuits 0 1, .swapHonors 2 4, .swapHonors 3 4]
  | 30 => .back 1 196 [.swapSuits 0 1, .swapHonors 3 4]
  | 31 => .back 1 196 [.swapSuits 0 1]
  | 32 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row393 : Row := ⟨393, state393, 393, action393⟩

def state394 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 18 | 20 | 24 | 26 | 27 | 28 | 29 | 30 | 31 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 13 | 16 | 19 | 21 | 22 | 32 | 33 => 1
  | 17 | 23 => 2
  | 25 => 3
  | _ => 0

def action394 (t : Tile) : Action :=
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
  | 26 => .back 27 210 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 27 => .back 26 210 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 28 => .back 26 210 [.swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 29 => .back 26 210 [.swapHonors 2 4, .swapHonors 3 4]
  | 30 => .back 26 210 [.swapHonors 3 4]
  | 31 => .back 26 210 []
  | 32 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row394 : Row := ⟨394, state394, 394, action394⟩

def state395 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 15 | 19 | 20 | 21 | 23 | 24 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 12 | 13 | 17 | 18 | 22 | 25 | 33 => 1
  | 14 | 26 => 2
  | 16 => 3
  | _ => 0

def action395 (t : Tile) : Action :=
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
  | 27 => .back 28 242 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 242 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 242 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 242 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 242 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 242 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row395 : Row := ⟨395, state395, 395, action395⟩

def state396 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 4 | 9 | 10 | 11 | 15 | 19 | 20 | 21 | 23 | 24 | 27 | 28 | 29 | 30 => 0
  | 5 | 6 | 7 | 8 | 12 | 13 | 17 | 18 | 22 | 25 | 31 | 32 | 33 => 1
  | 14 | 26 => 2
  | 16 => 3
  | _ => 0

def action396 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 9 239 [.swapSuits 1 2]
  | 1 => .back 10 241 []
  | 2 => .back 10 242 []
  | 3 => .win 4 (FullWinWitness.standard (.triplet 16) (.sequence 0 3) (.sequence 0 6) (.sequence 1 3) 26)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 16) (.sequence 0 3) (.sequence 0 6) (.sequence 1 3) 26)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 16) (.sequence 0 6) (.sequence 1 3) 26)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 16) (.sequence 0 4) (.sequence 0 6) (.sequence 1 3) 26)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 0 6) (.sequence 1 3) 26)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 0 5) (.sequence 1 3) 26)
  | 9 => .back 0 239 [.swapSuits 1 2]
  | 10 => .back 2 242 []
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
  | 27 => .back 28 243 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 243 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 243 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 243 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row396 : Row := ⟨396, state396, 396, action396⟩

def state397 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 4 | 9 | 10 | 11 | 12 | 14 | 15 | 19 | 20 | 24 | 27 | 28 | 29 | 30 => 0
  | 5 | 6 | 7 | 8 | 13 | 16 | 18 | 21 | 22 | 26 | 31 | 32 | 33 => 1
  | 17 | 23 => 2
  | 25 => 3
  | _ => 0

def action397 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 9 239 []
  | 1 => .back 10 195 []
  | 2 => .back 10 209 []
  | 3 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 3) (.sequence 0 6) (.sequence 2 3) 17)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 25) (.sequence 0 3) (.sequence 0 6) (.sequence 2 3) 17)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 25) (.sequence 0 6) (.sequence 2 3) 17)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 4) (.sequence 0 6) (.sequence 2 3) 17)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 0 6) (.sequence 2 3) 17)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 9 => .back 0 239 []
  | 10 => .back 1 195 []
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
  | 27 => .back 28 244 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 244 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 244 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 244 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row397 : Row := ⟨397, state397, 397, action397⟩

def state398 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 15 | 17 | 19 | 20 | 21 | 23 | 24 | 27 | 28 | 29 | 30 | 31 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 12 | 13 | 18 | 22 | 25 | 32 | 33 => 1
  | 14 | 26 => 2
  | 16 => 3
  | _ => 0

def action398 (t : Tile) : Action :=
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
  | 17 => .back 27 242 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 18 => .win 18 (FullWinWitness.standard (.triplet 16) (.triplet 18) (.sequence 0 5) (.sequence 1 3) 26)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 0) 26)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 0) 26)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 2) 26)
  | 22 => .win 22 (FullWinWitness.standard (.triplet 16) (.triplet 22) (.sequence 0 5) (.sequence 1 3) 26)
  | 23 => .win 21 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 26)
  | 24 => .win 2 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 2)
  | 25 => .win 25 (FullWinWitness.standard (.triplet 16) (.triplet 25) (.sequence 0 5) (.sequence 1 3) 26)
  | 26 => .win 2 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 5) (.sequence 1 3) 2)
  | 27 => .back 17 242 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 28 => .back 17 242 [.swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 29 => .back 17 242 [.swapHonors 2 4, .swapHonors 3 4]
  | 30 => .back 17 242 [.swapHonors 3 4]
  | 31 => .back 17 242 []
  | 32 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row398 : Row := ⟨398, state398, 398, action398⟩

def state399 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 5 | 6 | 9 | 11 | 15 | 17 | 19 | 20 | 21 | 22 | 27 | 28 | 29 | 30 | 31 => 0
  | 1 | 4 | 7 | 10 | 12 | 13 | 18 | 23 | 24 | 25 | 26 | 32 | 33 => 1
  | 8 | 14 => 2
  | 16 => 3
  | _ => 0

def action399 (t : Tile) : Action :=
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
  | 11 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 1) (.sequence 2 5) 14)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 16) (.sequence 1 1) (.sequence 1 3) (.sequence 2 5) 8)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 1 3) (.sequence 2 5) 8)
  | 14 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 14)
  | 15 => .win 6 (FullWinWitness.standard (.sequence 0 6) (.sequence 1 3) (.sequence 1 5) (.sequence 2 5) 16)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 1 5) (.sequence 2 5) 8)
  | 17 => .back 27 187 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 18 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 18)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 0) (.sequence 2 5) 8)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 0) (.sequence 2 5) 8)
  | 21 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 3) (.sequence 2 6) 8)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 3) (.sequence 2 6) 8)
  | 23 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 6) 23)
  | 24 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 4) (.sequence 2 6) 8)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 5) (.sequence 2 6) 8)
  | 26 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 26)
  | 27 => .back 17 187 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 28 => .back 17 187 [.swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 29 => .back 17 187 [.swapHonors 2 4, .swapHonors 3 4]
  | 30 => .back 17 187 [.swapHonors 3 4]
  | 31 => .back 17 187 []
  | 32 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row399 : Row := ⟨399, state399, 399, action399⟩

def state400 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 5 | 6 | 9 | 10 | 12 | 13 | 18 | 20 | 24 | 26 | 27 | 28 | 29 | 30 => 0
  | 4 | 7 | 11 | 14 | 15 | 16 | 17 | 19 | 21 | 22 | 31 | 32 | 33 => 1
  | 8 | 23 => 2
  | 25 => 3
  | _ => 0

def action400 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 26 242 [.swapSuits 0 2, .swapSuits 1 2]
  | 1 => .back 26 210 [.swapSuits 0 1]
  | 2 => .win 3 (FullWinWitness.standard (.triplet 25) (.sequence 0 2) (.sequence 1 5) (.sequence 2 3) 8)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 2) (.sequence 1 5) (.sequence 2 3) 8)
  | 4 => .win 4 (FullWinWitness.standard (.triplet 4) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 8)
  | 5 => .win 3 (FullWinWitness.standard (.triplet 25) (.sequence 0 3) (.sequence 1 5) (.sequence 2 3) 8)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 4)
  | 7 => .win 7 (FullWinWitness.standard (.triplet 7) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 8)
  | 8 => .win 4 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 4)
  | 9 => .win 10 (FullWinWitness.standard (.triplet 25) (.sequence 1 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 10 => .win 9 (FullWinWitness.standard (.triplet 25) (.sequence 1 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 11 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 11)
  | 12 => .win 10 (FullWinWitness.standard (.triplet 25) (.sequence 1 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 25) (.sequence 1 2) (.sequence 1 5) (.sequence 2 3) 8)
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
  | 26 => .back 1 210 [.swapSuits 0 1]
  | 27 => .back 1 245 [.swapSuits 0 1, .swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 3]
  | 28 => .back 1 245 [.swapSuits 0 1, .swapHonors 1 3, .swapHonors 2 3]
  | 29 => .back 1 245 [.swapSuits 0 1, .swapHonors 2 3]
  | 30 => .back 1 245 [.swapSuits 0 1]
  | 31 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row400 : Row := ⟨400, state400, 400, action400⟩

def state401 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 15 | 16 | 19 | 20 | 21 | 22 | 24 | 25 | 27 | 28 | 29 | 30 => 0
  | 2 | 5 | 6 | 7 | 8 | 11 | 12 | 13 | 14 | 17 | 18 | 23 | 31 | 32 | 33 => 1
  | 10 => 3
  | 26 => 2
  | _ => 0

def action401 (t : Tile) : Action :=
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
  | 27 => .back 28 246 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 246 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 246 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 246 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 26 (FullWinWitness.standard (.triplet 10) (.triplet 26) (.sequence 0 5) (.sequence 1 2) 31)
  | 32 => .win 26 (FullWinWitness.standard (.triplet 10) (.triplet 26) (.sequence 0 5) (.sequence 1 2) 32)
  | 33 => .win 26 (FullWinWitness.standard (.triplet 10) (.triplet 26) (.sequence 0 5) (.sequence 1 2) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row401 : Row := ⟨401, state401, 401, action401⟩

def state402 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 13 | 15 | 16 | 18 | 24 | 25 | 27 | 28 | 29 | 30 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 14 | 20 | 21 | 22 | 23 | 26 | 31 | 32 | 33 => 1
  | 17 => 2
  | 19 => 3
  | _ => 0

def action402 (t : Tile) : Action :=
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
  | 27 => .back 28 247 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 247 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 247 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 247 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 5) (.sequence 2 2) 31)
  | 32 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 5) (.sequence 2 2) 32)
  | 33 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 5) (.sequence 2 2) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row402 : Row := ⟨402, state402, 402, action402⟩

def state403 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 6 | 7 | 9 | 15 | 16 | 19 | 20 | 21 | 22 | 27 | 28 | 29 | 30 => 0
  | 2 | 5 | 11 | 12 | 13 | 14 | 17 | 18 | 23 | 24 | 25 | 26 | 31 | 32 | 33 => 1
  | 8 => 2
  | 10 => 3
  | _ => 0

def action403 (t : Tile) : Action :=
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
  | 27 => .back 28 248 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 248 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 248 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 248 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 1 2) (.sequence 2 5) 31)
  | 32 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 1 2) (.sequence 2 5) 32)
  | 33 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 1 2) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row403 : Row := ⟨403, state403, 403, action403⟩

def state404 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 6 | 7 | 9 | 11 | 12 | 13 | 18 | 24 | 25 | 27 | 28 | 29 | 30 => 0
  | 1 | 5 | 10 | 14 | 15 | 16 | 17 | 20 | 21 | 22 | 23 | 26 | 31 | 32 | 33 => 1
  | 8 => 2
  | 19 => 3
  | _ => 0

def action404 (t : Tile) : Action :=
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
  | 27 => .back 28 249 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 249 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 249 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 249 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 2) 31)
  | 32 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 2) 32)
  | 33 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 2) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row404 : Row := ⟨404, state404, 404, action404⟩

def state405 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 6 | 7 | 9 | 10 | 12 | 13 | 18 | 24 | 25 | 27 | 28 | 29 | 30 => 0
  | 2 | 5 | 11 | 14 | 15 | 16 | 17 | 20 | 21 | 22 | 23 | 26 | 31 | 32 | 33 => 1
  | 8 => 2
  | 19 => 3
  | _ => 0

def action405 (t : Tile) : Action :=
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
  | 27 => .back 28 250 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 250 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 250 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 250 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 2) 31)
  | 32 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 2) 32)
  | 33 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 2) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row405 : Row := ⟨405, state405, 405, action405⟩

def state406 (t : Tile) : Nat :=
  match t.val with
  | 0 | 5 | 6 | 7 | 8 | 9 | 13 | 16 | 18 | 22 | 23 | 26 | 33 => 1
  | 1 | 2 | 3 | 4 | 10 | 11 | 12 | 14 | 15 | 19 | 20 | 24 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 17 | 21 => 2
  | 25 => 3
  | _ => 0

def action406 (t : Tile) : Action :=
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
  | 27 => .back 28 251 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 251 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 251 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 251 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 251 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 251 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row406 : Row := ⟨406, state406, 406, action406⟩

def state407 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 15 | 16 | 19 | 20 | 21 | 23 | 24 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 1 | 5 | 6 | 7 | 8 | 12 | 13 | 17 | 18 | 22 | 25 | 33 => 1
  | 10 => 4
  | 14 | 26 => 2
  | _ => 0

def action407 (t : Tile) : Action :=
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
  | 27 => .back 28 252 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 252 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 252 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 252 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 252 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 252 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row407 : Row := ⟨407, state407, 407, action407⟩

def state408 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 15 | 16 | 19 | 20 | 21 | 23 | 24 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 2 | 5 | 6 | 7 | 8 | 12 | 13 | 17 | 18 | 22 | 25 | 33 => 1
  | 10 => 4
  | 14 | 26 => 2
  | _ => 0

def action408 (t : Tile) : Action :=
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
  | 27 => .back 28 253 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 253 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 253 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 253 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 253 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 253 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row408 : Row := ⟨408, state408, 408, action408⟩

def state409 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 4 | 9 | 11 | 15 | 16 | 19 | 20 | 21 | 23 | 24 | 27 | 28 | 29 | 30 => 0
  | 5 | 6 | 7 | 8 | 12 | 13 | 17 | 18 | 22 | 25 | 31 | 32 | 33 => 1
  | 10 => 3
  | 14 | 26 => 2
  | _ => 0

def action409 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 9 251 [.swapSuits 1 2, .reverseSuit 1]
  | 1 => .back 10 252 []
  | 2 => .back 10 253 []
  | 3 => .win 4 (FullWinWitness.standard (.triplet 10) (.sequence 0 3) (.sequence 0 6) (.sequence 1 3) 26)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 10) (.sequence 0 3) (.sequence 0 6) (.sequence 1 3) 26)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 10) (.sequence 0 6) (.sequence 1 3) 26)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 10) (.sequence 0 4) (.sequence 0 6) (.sequence 1 3) 26)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 0 6) (.sequence 1 3) 26)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 0 5) (.sequence 1 3) 26)
  | 9 => .back 0 251 [.swapSuits 1 2, .reverseSuit 1]
  | 10 => .back 1 252 []
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
  | 27 => .back 28 254 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 254 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 254 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 254 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row409 : Row := ⟨409, state409, 409, action409⟩

def state410 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 5 | 6 | 9 | 11 | 15 | 16 | 19 | 20 | 21 | 22 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 1 | 4 | 7 | 12 | 13 | 17 | 18 | 23 | 24 | 25 | 26 | 33 => 1
  | 8 | 14 => 2
  | 10 => 4
  | _ => 0

def action410 (t : Tile) : Action :=
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
  | 27 => .back 28 255 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 255 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 255 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 255 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 255 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 255 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row410 : Row := ⟨410, state410, 410, action410⟩

def state411 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 18 | 20 | 24 | 25 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 13 | 16 | 21 | 22 | 26 | 33 => 1
  | 17 | 23 => 2
  | 19 => 4
  | _ => 0

def action411 (t : Tile) : Action :=
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
  | 27 => .back 28 256 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 256 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 256 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 256 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 256 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 256 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row411 : Row := ⟨411, state411, 411, action411⟩

def state412 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 18 | 20 | 24 | 25 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 1 | 5 | 6 | 7 | 8 | 10 | 13 | 16 | 21 | 22 | 26 | 33 => 1
  | 17 | 23 => 2
  | 19 => 4
  | _ => 0

def action412 (t : Tile) : Action :=
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
  | 27 => .back 28 257 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 257 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 257 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 257 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 257 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 257 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row412 : Row := ⟨412, state412, 412, action412⟩

def state413 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 5 | 6 | 9 | 15 | 16 | 19 | 20 | 21 | 22 | 27 | 28 | 29 | 30 => 0
  | 2 | 7 | 11 | 12 | 13 | 14 | 17 | 18 | 23 | 24 | 25 | 26 | 31 | 32 | 33 => 1
  | 8 => 2
  | 10 => 3
  | _ => 0

def action413 (t : Tile) : Action :=
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
  | 27 => .back 28 258 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 258 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 258 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 258 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row413 : Row := ⟨413, state413, 413, action413⟩

def state414 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 5 | 6 | 9 | 11 | 12 | 13 | 18 | 24 | 25 | 27 | 28 | 29 | 30 => 0
  | 2 | 7 | 10 | 14 | 15 | 16 | 17 | 20 | 21 | 22 | 23 | 26 | 31 | 32 | 33 => 1
  | 8 => 2
  | 19 => 3
  | _ => 0

def action414 (t : Tile) : Action :=
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
  | 27 => .back 28 259 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 259 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 259 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 259 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row414 : Row := ⟨414, state414, 414, action414⟩

def state415 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 5 | 6 | 9 | 10 | 12 | 13 | 18 | 24 | 25 | 27 | 28 | 29 | 30 => 0
  | 2 | 7 | 11 | 14 | 15 | 16 | 17 | 20 | 21 | 22 | 23 | 26 | 31 | 32 | 33 => 1
  | 8 => 2
  | 19 => 3
  | _ => 0

def action415 (t : Tile) : Action :=
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
  | 27 => .back 28 260 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 260 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 260 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 260 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row415 : Row := ⟨415, state415, 415, action415⟩

def state416 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 5 | 6 | 10 | 11 | 12 | 13 | 19 | 20 | 24 | 27 | 28 | 29 | 30 | 31 => 0
  | 2 | 7 | 9 | 14 | 15 | 16 | 17 | 18 | 22 | 23 | 26 | 32 | 33 => 1
  | 8 | 21 => 2
  | 25 => 3
  | _ => 0

def action416 (t : Tile) : Action :=
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
  | 27 => .back 28 261 [.swapHonors 0 4, .swapHonors 1 3, .swapHonors 2 4]
  | 28 => .back 27 261 [.swapHonors 0 3, .swapHonors 1 4, .swapHonors 2 3, .swapHonors 3 4]
  | 29 => .back 27 261 [.swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 4]
  | 30 => .back 27 261 [.swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 3, .swapHonors 3 4]
  | 31 => .back 27 261 [.swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 3]
  | 32 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row416 : Row := ⟨416, state416, 416, action416⟩

def state417 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 5 | 6 | 9 | 11 | 15 | 16 | 19 | 20 | 21 | 22 | 27 | 28 | 29 | 30 => 0
  | 4 | 7 | 12 | 13 | 17 | 18 | 23 | 24 | 25 | 26 | 31 | 32 | 33 => 1
  | 8 | 14 => 2
  | 10 => 3
  | _ => 0

def action417 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 9 251 [.swapSuits 0 1, .swapSuits 1 2, .reverseSuit 1]
  | 1 => .back 10 255 []
  | 2 => .win 3 (FullWinWitness.standard (.triplet 10) (.sequence 0 2) (.sequence 1 3) (.sequence 2 5) 8)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 10) (.sequence 0 2) (.sequence 1 3) (.sequence 2 5) 8)
  | 4 => .win 4 (FullWinWitness.standard (.triplet 4) (.triplet 10) (.sequence 1 3) (.sequence 2 5) 8)
  | 5 => .win 3 (FullWinWitness.standard (.triplet 10) (.sequence 0 3) (.sequence 1 3) (.sequence 2 5) 8)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 4)
  | 7 => .win 7 (FullWinWitness.standard (.triplet 7) (.triplet 10) (.sequence 1 3) (.sequence 2 5) 8)
  | 8 => .win 4 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 1 3) (.sequence 2 5) 4)
  | 9 => .back 0 251 [.swapSuits 0 1, .swapSuits 1 2, .reverseSuit 1]
  | 10 => .back 1 255 []
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
  | 27 => .back 28 262 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 262 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 262 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 262 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row417 : Row := ⟨417, state417, 417, action417⟩

def state418 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 15 | 16 | 19 | 20 | 22 | 23 | 24 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 1 | 5 | 6 | 7 | 8 | 12 | 14 | 17 | 18 | 21 | 25 | 33 => 1
  | 10 => 4
  | 13 | 26 => 2
  | _ => 0

def action418 (t : Tile) : Action :=
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
  | 27 => .back 28 263 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 263 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 263 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 263 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 263 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 263 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row418 : Row := ⟨418, state418, 418, action418⟩

def state419 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 15 | 16 | 19 | 20 | 21 | 22 | 23 | 24 | 27 | 28 | 29 | 30 => 0
  | 1 | 5 | 6 | 7 | 8 | 12 | 13 | 14 | 17 | 18 | 25 | 31 | 32 | 33 => 1
  | 10 => 4
  | 26 => 2
  | _ => 0

def action419 (t : Tile) : Action :=
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
  | 13 => .back 21 263 []
  | 14 => .back 22 252 []
  | 15 => .win 11 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 1) (.sequence 1 4) 26)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 1 6) 26)
  | 17 => .win 17 (FullWinWitness.standard (.triplet 10) (.triplet 17) (.sequence 0 5) (.sequence 1 3) 26)
  | 18 => .win 18 (FullWinWitness.standard (.triplet 10) (.triplet 18) (.sequence 0 5) (.sequence 1 3) 26)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 0) 26)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 0) 26)
  | 21 => .back 13 263 []
  | 22 => .back 14 252 []
  | 23 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 5) 26)
  | 24 => .win 1 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 1)
  | 25 => .win 25 (FullWinWitness.standard (.triplet 10) (.triplet 25) (.sequence 0 5) (.sequence 1 3) 26)
  | 26 => .win 1 (FullWinWitness.standard (.triplet 10) (.triplet 26) (.sequence 0 5) (.sequence 1 3) 1)
  | 27 => .back 28 264 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 264 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 264 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 264 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row419 : Row := ⟨419, state419, 419, action419⟩

def state420 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 5 | 6 | 9 | 11 | 12 | 13 | 18 | 20 | 24 | 25 | 27 | 28 | 29 | 30 => 0
  | 1 | 7 | 10 | 14 | 15 | 16 | 17 | 22 | 23 | 26 | 31 | 32 | 33 => 1
  | 8 | 21 => 2
  | 19 => 3
  | _ => 0

def action420 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 2 (FullWinWitness.standard (.triplet 19) (.sequence 0 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 1 => .win 1 (FullWinWitness.standard (.triplet 1) (.triplet 19) (.sequence 1 5) (.sequence 2 3) 8)
  | 2 => .win 0 (FullWinWitness.standard (.triplet 19) (.sequence 0 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 19) (.sequence 0 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 4 => .back 18 195 [.swapSuits 0 1, .reverseSuit 2]
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
  | 18 => .back 4 195 [.swapSuits 0 1, .reverseSuit 2]
  | 19 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 1) (.sequence 2 3) 8)
  | 20 => .win 6 (FullWinWitness.standard (.sequence 0 6) (.sequence 1 5) (.sequence 2 1) (.sequence 2 3) 19)
  | 21 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 21)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 2) (.sequence 2 3) 8)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 3) (.sequence 2 3) 8)
  | 24 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 4) 21)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 3) (.sequence 2 6) 8)
  | 26 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 26)
  | 27 => .back 28 265 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 265 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 265 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 265 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row420 : Row := ⟨420, state420, 420, action420⟩

def state421 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 18 | 20 | 24 | 25 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 1 | 5 | 6 | 7 | 8 | 10 | 13 | 16 | 21 | 23 | 26 | 33 => 1
  | 17 | 22 => 2
  | 19 => 4
  | _ => 0

def action421 (t : Tile) : Action :=
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
  | 27 => .back 28 266 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 266 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 266 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 266 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 266 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 266 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row421 : Row := ⟨421, state421, 421, action421⟩

def state422 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 5 | 6 | 9 | 11 | 12 | 13 | 18 | 20 | 24 | 25 | 27 | 28 | 29 | 30 => 0
  | 4 | 7 | 10 | 14 | 15 | 16 | 17 | 21 | 22 | 23 | 26 | 31 | 32 | 33 => 1
  | 8 => 2
  | 19 => 4
  | _ => 0

def action422 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 23 252 [.swapSuits 0 2, .swapSuits 1 2]
  | 1 => .back 22 266 [.swapSuits 0 1]
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
  | 22 => .back 1 266 [.swapSuits 0 1]
  | 23 => .back 0 252 [.swapSuits 0 2, .swapSuits 1 2]
  | 24 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 1) (.sequence 2 4) 8)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 3) (.sequence 2 6) 8)
  | 26 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 26)
  | 27 => .back 28 267 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 267 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 267 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 267 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row422 : Row := ⟨422, state422, 422, action422⟩

def state423 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 5 | 6 | 9 | 11 | 12 | 13 | 18 | 20 | 24 | 25 | 27 | 28 | 29 | 30 => 0
  | 1 | 7 | 10 | 14 | 15 | 16 | 17 | 21 | 23 | 26 | 31 | 32 | 33 => 1
  | 8 | 22 => 2
  | 19 => 3
  | _ => 0

def action423 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 2 (FullWinWitness.standard (.triplet 19) (.sequence 0 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 1 => .win 1 (FullWinWitness.standard (.triplet 1) (.triplet 19) (.sequence 1 5) (.sequence 2 3) 8)
  | 2 => .win 0 (FullWinWitness.standard (.triplet 19) (.sequence 0 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 19) (.sequence 0 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 4 => .back 19 266 [.swapSuits 0 1]
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
  | 18 => .back 4 192 [.swapSuits 0 1, .reverseSuit 2]
  | 19 => .back 4 266 [.swapSuits 0 1]
  | 20 => .win 21 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 2) (.sequence 2 3) 8)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 2) (.sequence 2 3) 8)
  | 22 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 22)
  | 23 => .win 21 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 3) (.sequence 2 3) 8)
  | 24 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 2) (.sequence 2 4) 8)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 3) (.sequence 2 6) 8)
  | 26 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 26)
  | 27 => .back 28 268 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 268 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 268 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 268 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row423 : Row := ⟨423, state423, 423, action423⟩

def state424 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 4 | 5 | 6 | 9 | 11 | 12 | 13 | 18 | 20 | 24 | 25 | 27 | 28 | 29 | 30 => 0
  | 3 | 7 | 10 | 14 | 15 | 16 | 17 | 21 | 22 | 23 | 26 | 31 | 32 | 33 => 1
  | 8 => 2
  | 19 => 4
  | _ => 0

def action424 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 22 263 [.swapSuits 0 2, .swapSuits 1 2]
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
  | 22 => .back 0 263 [.swapSuits 0 2, .swapSuits 1 2]
  | 23 => .back 27 235 [.swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 3]
  | 24 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 1) (.sequence 2 4) 8)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 3) (.sequence 2 6) 8)
  | 26 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 26)
  | 27 => .back 23 235 [.swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 3]
  | 28 => .back 23 235 [.swapHonors 1 3, .swapHonors 2 3]
  | 29 => .back 23 235 [.swapHonors 2 3]
  | 30 => .back 23 235 []
  | 31 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row424 : Row := ⟨424, state424, 424, action424⟩

def state425 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 5 | 6 | 9 | 11 | 12 | 13 | 18 | 20 | 24 | 25 | 27 | 28 | 29 | 30 => 0
  | 1 | 7 | 10 | 14 | 15 | 16 | 17 | 21 | 22 | 26 | 31 | 32 | 33 => 1
  | 8 | 23 => 2
  | 19 => 3
  | _ => 0

def action425 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 2 (FullWinWitness.standard (.triplet 19) (.sequence 0 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 1 => .win 1 (FullWinWitness.standard (.triplet 1) (.triplet 19) (.sequence 1 5) (.sequence 2 3) 8)
  | 2 => .win 0 (FullWinWitness.standard (.triplet 19) (.sequence 0 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 19) (.sequence 0 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 4 => .back 19 257 [.swapSuits 0 1]
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
  | 18 => .back 27 194 [.reverseSuit 2, .swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 3]
  | 19 => .back 4 257 [.swapSuits 0 1]
  | 20 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 23)
  | 21 => .win 22 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 3) (.sequence 2 3) 8)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 3) (.sequence 2 3) 8)
  | 23 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 23)
  | 24 => .win 22 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 3) (.sequence 2 4) 8)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 3) (.sequence 2 5) 8)
  | 26 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 26)
  | 27 => .back 18 194 [.reverseSuit 2, .swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 3]
  | 28 => .back 18 194 [.reverseSuit 2, .swapHonors 1 3, .swapHonors 2 3]
  | 29 => .back 18 194 [.reverseSuit 2, .swapHonors 2 3]
  | 30 => .back 18 194 [.reverseSuit 2]
  | 31 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row425 : Row := ⟨425, state425, 425, action425⟩

def state426 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 9 | 11 | 12 | 13 | 18 | 20 | 24 | 25 | 27 | 28 => 0
  | 7 | 10 | 14 | 15 | 16 | 17 | 21 | 22 | 23 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 8 => 2
  | 19 => 3
  | _ => 0

def action426 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 19 264 [.swapSuits 0 2, .swapSuits 1 2]
  | 1 => .back 21 265 []
  | 2 => .back 20 259 []
  | 3 => .back 19 269 []
  | 4 => .back 19 267 []
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
  | 18 => .back 1 203 [.reverseSuit 2]
  | 19 => .back 4 267 []
  | 20 => .back 2 259 []
  | 21 => .back 1 265 []
  | 22 => .back 1 268 []
  | 23 => .back 1 270 []
  | 24 => .win 25 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 3) (.sequence 2 6) 8)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 3) (.sequence 2 6) 8)
  | 26 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 26)
  | 27 => .back 28 271 [.swapHonors 0 1]
  | 28 => .back 27 271 []
  | 29 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 29)
  | 30 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 30)
  | 31 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row426 : Row := ⟨426, state426, 426, action426⟩

def state427 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 15 | 16 | 19 | 20 | 21 | 23 | 24 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 2 | 5 | 6 | 7 | 8 | 12 | 14 | 17 | 18 | 22 | 25 | 33 => 1
  | 10 => 4
  | 13 | 26 => 2
  | _ => 0

def action427 (t : Tile) : Action :=
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
  | 27 => .back 28 272 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 272 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 272 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 272 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 272 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 272 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row427 : Row := ⟨427, state427, 427, action427⟩

def state428 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 15 | 16 | 19 | 20 | 21 | 22 | 23 | 24 | 27 | 28 | 29 | 30 => 0
  | 2 | 5 | 6 | 7 | 8 | 12 | 13 | 14 | 17 | 18 | 25 | 31 | 32 | 33 => 1
  | 10 => 4
  | 26 => 2
  | _ => 0

def action428 (t : Tile) : Action :=
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
  | 13 => .back 22 272 []
  | 14 => .back 21 236 []
  | 15 => .win 11 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 1) (.sequence 1 4) 26)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 1 6) 26)
  | 17 => .win 17 (FullWinWitness.standard (.triplet 10) (.triplet 17) (.sequence 0 5) (.sequence 1 3) 26)
  | 18 => .win 18 (FullWinWitness.standard (.triplet 10) (.triplet 18) (.sequence 0 5) (.sequence 1 3) 26)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 0) 26)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 0) 26)
  | 21 => .back 14 236 []
  | 22 => .back 13 272 []
  | 23 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 5) 26)
  | 24 => .win 2 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 2)
  | 25 => .win 25 (FullWinWitness.standard (.triplet 10) (.triplet 25) (.sequence 0 5) (.sequence 1 3) 26)
  | 26 => .win 2 (FullWinWitness.standard (.triplet 10) (.triplet 26) (.sequence 0 5) (.sequence 1 3) 2)
  | 27 => .back 28 273 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 273 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 273 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 273 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row428 : Row := ⟨428, state428, 428, action428⟩

def state429 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 4 | 5 | 6 | 9 | 10 | 12 | 13 | 18 | 20 | 24 | 25 | 27 | 28 | 29 | 30 | 31 => 0
  | 3 | 7 | 11 | 14 | 15 | 16 | 17 | 21 | 23 | 26 | 32 | 33 => 1
  | 8 | 22 => 2
  | 19 => 4
  | _ => 0

def action429 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 27 274 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
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
  | 20 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 1) 22)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 1) (.sequence 2 3) 8)
  | 22 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 22)
  | 23 => .win 21 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 3) (.sequence 2 3) 8)
  | 24 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 1) (.sequence 2 4) 8)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 3) (.sequence 2 6) 8)
  | 26 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 26)
  | 27 => .back 0 274 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 28 => .back 0 274 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 29 => .back 0 274 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 2 4, .swapHonors 3 4]
  | 30 => .back 0 274 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 3 4]
  | 31 => .back 0 274 [.swapSuits 0 2, .swapSuits 1 2]
  | 32 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row429 : Row := ⟨429, state429, 429, action429⟩

def state430 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 5 | 6 | 9 | 10 | 12 | 13 | 18 | 20 | 24 | 25 | 27 | 28 | 29 | 30 => 0
  | 4 | 7 | 11 | 14 | 15 | 16 | 17 | 21 | 23 | 26 | 31 | 32 | 33 => 1
  | 8 | 22 => 2
  | 19 => 3
  | _ => 0

def action430 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 19 272 [.swapSuits 0 2, .swapSuits 1 2]
  | 1 => .back 18 206 [.swapSuits 0 1, .reverseSuit 2]
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
  | 18 => .back 1 206 [.swapSuits 0 1, .reverseSuit 2]
  | 19 => .back 0 272 [.swapSuits 0 2, .swapSuits 1 2]
  | 20 => .win 21 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 2) (.sequence 2 3) 8)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 2) (.sequence 2 3) 8)
  | 22 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 22)
  | 23 => .win 21 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 3) (.sequence 2 3) 8)
  | 24 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 2) (.sequence 2 4) 8)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 3) (.sequence 2 6) 8)
  | 26 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 26)
  | 27 => .back 28 275 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 275 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 275 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 275 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row430 : Row := ⟨430, state430, 430, action430⟩

def state431 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 18 | 20 | 24 | 25 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 13 | 16 | 21 | 23 | 26 | 33 => 1
  | 17 | 22 => 2
  | 19 => 4
  | _ => 0

def action431 (t : Tile) : Action :=
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
  | 27 => .back 28 276 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 276 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 276 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 276 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 276 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 276 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row431 : Row := ⟨431, state431, 431, action431⟩

def state432 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 13 | 14 | 15 | 18 | 20 | 24 | 25 | 27 | 28 | 29 | 30 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 16 | 21 | 22 | 23 | 26 | 31 | 32 | 33 => 1
  | 17 => 2
  | 19 => 4
  | _ => 0

def action432 (t : Tile) : Action :=
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
  | 13 => .back 23 256 []
  | 14 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 5) (.sequence 2 3) 17)
  | 15 => .win 2 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 2)
  | 16 => .win 16 (FullWinWitness.standard (.triplet 16) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 17)
  | 17 => .win 2 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 2)
  | 18 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 20 => .win 18 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 1) (.sequence 2 3) 17)
  | 22 => .back 13 276 []
  | 23 => .back 13 256 []
  | 24 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 1) (.sequence 2 4) 17)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 3) (.sequence 2 6) 17)
  | 26 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 26)
  | 27 => .back 28 277 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 277 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 277 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 277 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row432 : Row := ⟨432, state432, 432, action432⟩

def state433 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 13 | 14 | 15 | 18 | 20 | 24 | 25 | 27 | 28 | 29 | 30 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 16 | 22 | 23 | 26 | 31 | 32 | 33 => 1
  | 17 | 21 => 2
  | 19 => 3
  | _ => 0

def action433 (t : Tile) : Action :=
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
  | 13 => .back 18 209 [.reverseSuit 2]
  | 14 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 5) (.sequence 2 3) 17)
  | 15 => .win 2 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 2)
  | 16 => .win 16 (FullWinWitness.standard (.triplet 16) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 17)
  | 17 => .win 2 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 2)
  | 18 => .back 13 209 [.reverseSuit 2]
  | 19 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 1) (.sequence 2 3) 17)
  | 20 => .win 15 (FullWinWitness.standard (.sequence 0 5) (.sequence 1 6) (.sequence 2 1) (.sequence 2 3) 19)
  | 21 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 21)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 2) (.sequence 2 3) 17)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 24 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 4) 21)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 3) (.sequence 2 6) 17)
  | 26 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 26)
  | 27 => .back 28 278 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 278 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 278 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 278 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row433 : Row := ⟨433, state433, 433, action433⟩

def state434 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 4 | 5 | 6 | 9 | 10 | 12 | 13 | 18 | 20 | 24 | 25 | 27 | 28 | 29 | 30 => 0
  | 3 | 7 | 11 | 14 | 15 | 16 | 17 | 21 | 22 | 23 | 26 | 31 | 32 | 33 => 1
  | 8 => 2
  | 19 => 4
  | _ => 0

def action434 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 23 236 [.swapSuits 0 2, .swapSuits 1 2]
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
  | 22 => .back 0 274 [.swapSuits 0 2, .swapSuits 1 2]
  | 23 => .back 0 236 [.swapSuits 0 2, .swapSuits 1 2]
  | 24 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 1) (.sequence 2 4) 8)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 3) (.sequence 2 6) 8)
  | 26 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 26)
  | 27 => .back 23 237 [.swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 3]
  | 28 => .back 23 237 [.swapHonors 1 3, .swapHonors 2 3]
  | 29 => .back 23 237 [.swapHonors 2 3]
  | 30 => .back 23 237 []
  | 31 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row434 : Row := ⟨434, state434, 434, action434⟩

def state435 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 13 | 14 | 15 | 18 | 20 | 24 | 25 | 27 | 28 | 29 | 30 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 16 | 21 | 22 | 26 | 31 | 32 | 33 => 1
  | 17 | 23 => 2
  | 19 => 3
  | _ => 0

def action435 (t : Tile) : Action :=
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
  | 13 => .back 19 256 []
  | 14 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 5) (.sequence 2 3) 17)
  | 15 => .win 2 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 2)
  | 16 => .win 16 (FullWinWitness.standard (.triplet 16) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 17)
  | 17 => .win 2 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 2)
  | 18 => .back 27 208 [.reverseSuit 2, .swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 3]
  | 19 => .back 13 256 []
  | 20 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 2) 23)
  | 21 => .win 22 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 23 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 23)
  | 24 => .win 22 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 3) (.sequence 2 4) 17)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 3) (.sequence 2 5) 17)
  | 26 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 26)
  | 27 => .back 18 208 [.reverseSuit 2, .swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 3]
  | 28 => .back 18 208 [.reverseSuit 2, .swapHonors 1 3, .swapHonors 2 3]
  | 29 => .back 18 208 [.reverseSuit 2, .swapHonors 2 3]
  | 30 => .back 18 208 [.reverseSuit 2]
  | 31 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row435 : Row := ⟨435, state435, 435, action435⟩

def state436 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 9 | 10 | 12 | 13 | 18 | 20 | 24 | 25 | 27 | 28 => 0
  | 7 | 11 | 14 | 15 | 16 | 17 | 21 | 22 | 23 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 8 => 2
  | 19 => 3
  | _ => 0

def action436 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 19 273 [.swapSuits 0 2, .swapSuits 1 2]
  | 1 => .back 21 278 [.swapSuits 0 1]
  | 2 => .back 20 260 []
  | 3 => .back 19 279 []
  | 4 => .back 22 275 []
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
  | 18 => .back 1 217 [.swapSuits 0 1, .reverseSuit 2]
  | 19 => .back 1 277 [.swapSuits 0 1]
  | 20 => .back 2 260 []
  | 21 => .back 1 278 [.swapSuits 0 1]
  | 22 => .back 4 275 []
  | 23 => .back 1 280 [.swapSuits 0 1]
  | 24 => .win 25 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 3) (.sequence 2 6) 8)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 19) (.sequence 1 5) (.sequence 2 3) (.sequence 2 6) 8)
  | 26 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 26)
  | 27 => .back 28 281 [.swapHonors 0 1]
  | 28 => .back 27 281 []
  | 29 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 29)
  | 30 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 30)
  | 31 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row436 : Row := ⟨436, state436, 436, action436⟩

def state437 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 5 | 6 | 10 | 11 | 12 | 13 | 19 | 20 | 24 | 27 | 28 | 29 | 30 | 31 => 0
  | 2 | 7 | 9 | 14 | 15 | 16 | 17 | 18 | 21 | 22 | 26 | 32 | 33 => 1
  | 8 | 23 => 2
  | 25 => 3
  | _ => 0

def action437 (t : Tile) : Action :=
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
  | 27 => .back 28 282 [.swapHonors 0 4, .swapHonors 1 3, .swapHonors 2 4]
  | 28 => .back 27 282 [.swapHonors 0 3, .swapHonors 1 4, .swapHonors 2 3, .swapHonors 3 4]
  | 29 => .back 27 282 [.swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 4]
  | 30 => .back 27 282 [.swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 3, .swapHonors 3 4]
  | 31 => .back 27 282 [.swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 3]
  | 32 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row437 : Row := ⟨437, state437, 437, action437⟩

def state438 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 5 | 6 | 9 | 11 | 15 | 16 | 19 | 20 | 21 | 22 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 1 | 4 | 7 | 12 | 14 | 17 | 18 | 23 | 24 | 25 | 26 | 33 => 1
  | 8 | 13 => 2
  | 10 => 4
  | _ => 0

def action438 (t : Tile) : Action :=
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
  | 27 => .back 28 283 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 283 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 283 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 283 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 283 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 283 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row438 : Row := ⟨438, state438, 438, action438⟩

def state439 (t : Tile) : Nat :=
  match t.val with
  | 0 | 5 | 6 | 7 | 8 | 9 | 13 | 16 | 18 | 21 | 23 | 26 | 33 => 1
  | 1 | 2 | 3 | 4 | 10 | 11 | 12 | 14 | 15 | 19 | 20 | 24 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 17 | 22 => 2
  | 25 => 3
  | _ => 0

def action439 (t : Tile) : Action :=
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
  | 27 => .back 28 284 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 284 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 284 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 284 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 284 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 284 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row439 : Row := ⟨439, state439, 439, action439⟩

def state440 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 5 | 6 | 9 | 11 | 15 | 16 | 19 | 20 | 21 | 22 | 27 | 28 | 29 | 30 => 0
  | 4 | 7 | 12 | 14 | 17 | 18 | 23 | 24 | 25 | 26 | 31 | 32 | 33 => 1
  | 8 | 13 => 2
  | 10 => 3
  | _ => 0

def action440 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 9 284 [.swapSuits 0 1, .swapSuits 1 2, .reverseSuit 1]
  | 1 => .back 10 283 []
  | 2 => .win 3 (FullWinWitness.standard (.triplet 10) (.sequence 0 2) (.sequence 1 3) (.sequence 2 5) 8)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 10) (.sequence 0 2) (.sequence 1 3) (.sequence 2 5) 8)
  | 4 => .win 4 (FullWinWitness.standard (.triplet 4) (.triplet 10) (.sequence 1 3) (.sequence 2 5) 8)
  | 5 => .win 3 (FullWinWitness.standard (.triplet 10) (.sequence 0 3) (.sequence 1 3) (.sequence 2 5) 8)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 4)
  | 7 => .win 7 (FullWinWitness.standard (.triplet 7) (.triplet 10) (.sequence 1 3) (.sequence 2 5) 8)
  | 8 => .win 4 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 1 3) (.sequence 2 5) 4)
  | 9 => .back 0 284 [.swapSuits 0 1, .swapSuits 1 2, .reverseSuit 1]
  | 10 => .back 1 283 []
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
  | 27 => .back 28 285 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 285 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 285 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 285 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row440 : Row := ⟨440, state440, 440, action440⟩

def state441 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 15 | 16 | 19 | 20 | 21 | 23 | 24 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 1 | 5 | 6 | 7 | 8 | 12 | 14 | 17 | 18 | 22 | 25 | 33 => 1
  | 10 => 4
  | 13 | 26 => 2
  | _ => 0

def action441 (t : Tile) : Action :=
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
  | 27 => .back 28 286 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 286 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 286 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 286 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 286 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 286 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row441 : Row := ⟨441, state441, 441, action441⟩

def state442 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 4 | 9 | 11 | 15 | 16 | 19 | 20 | 21 | 23 | 24 | 27 | 28 | 29 | 30 => 0
  | 5 | 6 | 7 | 8 | 12 | 14 | 17 | 18 | 22 | 25 | 31 | 32 | 33 => 1
  | 10 => 3
  | 13 | 26 => 2
  | _ => 0

def action442 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 9 284 [.swapSuits 1 2, .reverseSuit 1]
  | 1 => .back 10 286 []
  | 2 => .back 10 272 []
  | 3 => .win 4 (FullWinWitness.standard (.triplet 10) (.sequence 0 3) (.sequence 0 6) (.sequence 1 3) 26)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 10) (.sequence 0 3) (.sequence 0 6) (.sequence 1 3) 26)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 10) (.sequence 0 6) (.sequence 1 3) 26)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 10) (.sequence 0 4) (.sequence 0 6) (.sequence 1 3) 26)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 0 6) (.sequence 1 3) 26)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 0 5) (.sequence 1 3) 26)
  | 9 => .back 0 284 [.swapSuits 1 2, .reverseSuit 1]
  | 10 => .back 2 272 []
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
  | 27 => .back 28 287 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 287 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 287 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 287 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row442 : Row := ⟨442, state442, 442, action442⟩

def state443 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 4 | 9 | 10 | 11 | 12 | 14 | 15 | 19 | 20 | 24 | 27 | 28 | 29 | 30 => 0
  | 5 | 6 | 7 | 8 | 13 | 16 | 18 | 21 | 23 | 26 | 31 | 32 | 33 => 1
  | 17 | 22 => 2
  | 25 => 3
  | _ => 0

def action443 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 9 284 []
  | 1 => .back 10 192 []
  | 2 => .back 10 206 []
  | 3 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 3) (.sequence 0 6) (.sequence 2 3) 17)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 25) (.sequence 0 3) (.sequence 0 6) (.sequence 2 3) 17)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 25) (.sequence 0 6) (.sequence 2 3) 17)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 4) (.sequence 0 6) (.sequence 2 3) 17)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 0 6) (.sequence 2 3) 17)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 9 => .back 0 284 []
  | 10 => .back 2 206 []
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
  | 27 => .back 28 288 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 288 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 288 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 288 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row443 : Row := ⟨443, state443, 443, action443⟩

def state444 (t : Tile) : Nat :=
  match t.val with
  | 0 | 6 | 7 | 10 | 11 | 12 | 13 | 19 | 20 | 22 | 23 | 24 | 27 | 28 | 29 | 30 | 31 => 0
  | 1 => 3
  | 2 | 3 | 4 | 5 | 8 | 9 | 14 | 15 | 16 | 17 | 18 | 21 | 25 | 32 | 33 => 1
  | 26 => 2
  | _ => 0

def action444 (t : Tile) : Action :=
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
  | 27 => .back 28 289 [.swapHonors 0 4, .swapHonors 1 3, .swapHonors 2 4]
  | 28 => .back 27 289 [.swapHonors 0 3, .swapHonors 1 4, .swapHonors 2 3, .swapHonors 3 4]
  | 29 => .back 27 289 [.swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 4]
  | 30 => .back 27 289 [.swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 3, .swapHonors 3 4]
  | 31 => .back 27 289 [.swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 3]
  | 32 => .win 24 (FullWinWitness.standard (.triplet 1) (.sequence 0 2) (.sequence 1 5) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 1) (.sequence 0 2) (.sequence 1 5) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row444 : Row := ⟨444, state444, 444, action444⟩

def state445 (t : Tile) : Nat :=
  match t.val with
  | 0 | 5 | 6 | 7 | 8 | 9 | 12 | 16 | 18 | 21 | 23 | 26 | 33 => 1
  | 1 | 2 | 3 | 4 | 10 | 11 | 13 | 14 | 15 | 19 | 20 | 24 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 17 | 22 => 2
  | 25 => 3
  | _ => 0

def action445 (t : Tile) : Action :=
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
  | 27 => .back 28 290 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 290 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 290 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 290 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 290 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 290 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row445 : Row := ⟨445, state445, 445, action445⟩

def state446 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 15 | 16 | 19 | 20 | 22 | 23 | 24 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 2 | 5 | 6 | 7 | 8 | 12 | 14 | 17 | 18 | 21 | 25 | 33 => 1
  | 10 => 4
  | 13 | 26 => 2
  | _ => 0

def action446 (t : Tile) : Action :=
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
  | 27 => .back 28 274 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 274 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 274 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 274 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 274 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 274 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row446 : Row := ⟨446, state446, 446, action446⟩

def state447 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 4 | 9 | 11 | 15 | 16 | 19 | 20 | 22 | 23 | 24 | 27 | 28 | 29 | 30 => 0
  | 5 | 6 | 7 | 8 | 12 | 14 | 17 | 18 | 21 | 25 | 31 | 32 | 33 => 1
  | 10 => 3
  | 13 | 26 => 2
  | _ => 0

def action447 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 9 290 [.swapSuits 1 2, .reverseSuit 1]
  | 1 => .back 10 263 []
  | 2 => .back 10 274 []
  | 3 => .win 4 (FullWinWitness.standard (.triplet 10) (.sequence 0 3) (.sequence 0 6) (.sequence 1 3) 26)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 10) (.sequence 0 3) (.sequence 0 6) (.sequence 1 3) 26)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 10) (.sequence 0 6) (.sequence 1 3) 26)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 10) (.sequence 0 4) (.sequence 0 6) (.sequence 1 3) 26)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 0 6) (.sequence 1 3) 26)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 0 5) (.sequence 1 3) 26)
  | 9 => .back 0 290 [.swapSuits 1 2, .reverseSuit 1]
  | 10 => .back 1 263 []
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
  | 27 => .back 28 291 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 291 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 291 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 291 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row447 : Row := ⟨447, state447, 447, action447⟩

end Mahjong.Scale12V2
