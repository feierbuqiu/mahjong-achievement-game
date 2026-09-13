import MahjongScale.Actual12V2.Base

set_option maxRecDepth 32768
set_option maxHeartbeats 100000000

namespace Mahjong.Scale12V2
open ResponseTable ResponseCertificate Generators

def state512 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 6 | 9 | 11 | 12 | 13 | 14 | 15 | 16 | 19 | 20 | 21 | 22 | 27 | 28 | 29 | 30 | 31 => 0
  | 3 | 4 | 8 | 10 | 18 | 23 | 24 | 25 | 26 | 32 | 33 => 1
  | 5 | 17 => 2
  | 7 => 3
  | _ => 0

def action512 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 15 332 [.swapSuits 0 2, .swapSuits 1 2]
  | 1 => .back 13 335 [.swapSuits 0 1]
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
  | 13 => .back 1 335 [.swapSuits 0 1]
  | 14 => .back 0 334 [.swapSuits 0 2, .swapSuits 1 2]
  | 15 => .back 0 332 [.swapSuits 0 2, .swapSuits 1 2]
  | 16 => .back 1 336 [.swapSuits 0 1]
  | 17 => .win 2 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 2) (.sequence 2 5) 5)
  | 18 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 3) (.sequence 2 5) 18)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 2 0) (.sequence 2 5) 17)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 2 0) (.sequence 2 5) 17)
  | 21 => .win 22 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 2 3) (.sequence 2 6) 17)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 2 3) (.sequence 2 6) 17)
  | 23 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 3) (.sequence 2 6) 23)
  | 24 => .win 22 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 2 4) (.sequence 2 6) 17)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 2 5) (.sequence 2 6) 17)
  | 26 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 3) (.sequence 2 5) 26)
  | 27 => .back 28 337 [.swapHonors 0 4, .swapHonors 1 3, .swapHonors 2 4]
  | 28 => .back 27 337 [.swapHonors 0 3, .swapHonors 1 4, .swapHonors 2 3, .swapHonors 3 4]
  | 29 => .back 27 337 [.swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 4]
  | 30 => .back 27 337 [.swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 3, .swapHonors 3 4]
  | 31 => .back 27 337 [.swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 3]
  | 32 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 3) (.sequence 2 5) 32)
  | 33 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 3) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row512 : Row := ⟨512, state512, 512, action512⟩

def state513 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 5 | 6 | 9 | 11 | 12 | 13 | 19 | 20 | 24 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 1 | 7 | 10 | 14 | 15 | 16 | 17 | 18 | 21 | 22 | 23 | 26 | 33 => 1
  | 8 => 2
  | 25 => 3
  | _ => 0

def action513 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 1 => .win 1 (FullWinWitness.standard (.triplet 1) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 8)
  | 2 => .win 0 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 4 => .back 22 338 [.swapSuits 0 1]
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
  | 21 => .back 27 339 [.swapHonors 0 5, .swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | 22 => .back 4 338 [.swapSuits 0 1]
  | 23 => .back 4 340 [.swapSuits 0 1]
  | 24 => .win 6 (FullWinWitness.standard (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) (.sequence 2 6) 25)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 3) (.sequence 2 6) 8)
  | 26 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 26)
  | 27 => .back 21 339 [.swapHonors 0 5, .swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | 28 => .back 21 339 [.swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | 29 => .back 21 339 [.swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | 30 => .back 21 339 [.swapHonors 3 5, .swapHonors 4 5]
  | 31 => .back 21 339 [.swapHonors 4 5]
  | 32 => .back 21 339 []
  | 33 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row513 : Row := ⟨513, state513, 513, action513⟩

def state514 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 5 | 6 | 9 | 11 | 12 | 13 | 18 | 20 | 24 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 1 | 7 | 10 | 14 | 15 | 16 | 17 | 19 | 21 | 22 | 23 | 26 | 33 => 1
  | 8 => 2
  | 25 => 3
  | _ => 0

def action514 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 1 => .win 1 (FullWinWitness.standard (.triplet 1) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 8)
  | 2 => .win 0 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 4 => .back 23 341 [.swapSuits 0 1]
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
  | 22 => .back 4 342 [.swapSuits 0 1]
  | 23 => .back 4 341 [.swapSuits 0 1]
  | 24 => .win 6 (FullWinWitness.standard (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) (.sequence 2 6) 25)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 3) (.sequence 2 6) 8)
  | 26 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 26)
  | 27 => .back 28 343 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 343 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 343 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 343 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 343 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 343 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row514 : Row := ⟨514, state514, 514, action514⟩

def state515 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 6 | 9 | 11 | 12 | 13 | 14 | 16 | 18 | 20 | 21 | 22 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 2 | 3 | 4 | 5 | 8 | 10 | 15 | 19 | 23 | 24 | 25 | 26 | 33 => 1
  | 7 => 3
  | 17 => 2
  | _ => 0

def action515 (t : Tile) : Action :=
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
  | 27 => .back 28 344 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 344 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 344 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 344 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 344 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 344 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 16 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 6) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row515 : Row := ⟨515, state515, 515, action515⟩

def state516 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 6 | 9 | 11 | 12 | 13 | 14 | 15 | 18 | 20 | 21 | 22 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 3 | 17 => 2
  | 4 | 5 | 8 | 10 | 16 | 19 | 23 | 24 | 25 | 26 | 33 => 1
  | 7 => 3
  | _ => 0

def action516 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 27 339 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 0 5, .swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
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
  | 13 => .back 0 345 [.swapSuits 0 2]
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
  | 27 => .back 0 339 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 0 5, .swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | 28 => .back 0 339 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | 29 => .back 0 339 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | 30 => .back 0 339 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 3 5, .swapHonors 4 5]
  | 31 => .back 0 339 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 4 5]
  | 32 => .back 0 339 [.swapSuits 0 2, .swapSuits 1 2]
  | 33 => .win 15 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 6) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row516 : Row := ⟨516, state516, 516, action516⟩

def state517 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 6 | 9 | 11 | 12 | 13 | 18 | 20 | 21 | 23 | 24 | 25 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 3 | 5 | 8 | 10 | 14 | 15 | 16 | 17 | 19 | 22 | 33 => 1
  | 4 | 26 => 2
  | 7 => 3
  | _ => 0

def action517 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 25 338 [.swapSuits 0 2, .swapSuits 1 2]
  | 1 => .back 25 342 [.swapSuits 0 2, .swapSuits 1 2]
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
  | 25 => .back 0 338 [.swapSuits 0 2, .swapSuits 1 2]
  | 26 => .win 4 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 4)
  | 27 => .back 28 346 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 346 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 346 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 346 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 346 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 346 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 26 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row517 : Row := ⟨517, state517, 517, action517⟩

def state518 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 6 | 9 | 11 | 12 | 13 | 14 | 15 | 18 | 20 | 21 | 22 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 3 | 4 | 8 | 10 | 16 | 19 | 23 | 24 | 25 | 26 | 33 => 1
  | 5 | 17 => 2
  | 7 => 3
  | _ => 0

def action518 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 13 340 [.swapSuits 0 2]
  | 1 => .back 13 341 [.swapSuits 0 2]
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
  | 13 => .back 1 341 [.swapSuits 0 2]
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
  | 27 => .back 28 347 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 347 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 347 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 347 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 347 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 347 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 15 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 6) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row518 : Row := ⟨518, state518, 518, action518⟩

def state519 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 6 | 9 | 11 | 12 | 13 | 15 | 16 | 18 | 20 | 21 | 22 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 2 | 3 | 4 | 5 | 8 | 10 | 14 | 19 | 23 | 24 | 25 | 26 | 33 => 1
  | 7 => 3
  | 17 => 2
  | _ => 0

def action519 (t : Tile) : Action :=
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
  | 27 => .back 28 348 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 348 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 348 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 348 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 348 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 348 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 2) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row519 : Row := ⟨519, state519, 519, action519⟩

def state520 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 6 | 9 | 11 | 12 | 13 | 14 | 15 | 16 | 18 | 20 | 21 | 22 | 27 | 28 | 29 | 30 => 0
  | 3 | 4 | 5 | 8 | 10 | 19 | 23 | 24 | 25 | 26 | 31 | 32 | 33 => 1
  | 7 => 3
  | 17 => 2
  | _ => 0

def action520 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 16 349 [.swapSuits 0 2, .swapSuits 1 2]
  | 1 => .back 16 343 [.swapSuits 0 2, .swapSuits 1 2]
  | 2 => .back 15 344 []
  | 3 => .back 16 350 []
  | 4 => .back 13 346 [.swapSuits 1 2]
  | 5 => .back 16 347 []
  | 6 => .win 7 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 0 6) (.sequence 2 5) 17)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 0 6) (.sequence 2 5) 17)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 7) (.triplet 8) (.sequence 0 3) (.sequence 2 5) 17)
  | 9 => .win 11 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 0) (.sequence 2 5) 17)
  | 10 => .win 10 (FullWinWitness.standard (.triplet 7) (.triplet 10) (.sequence 0 3) (.sequence 2 5) 17)
  | 11 => .win 9 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 0) (.sequence 2 5) 17)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 1) (.sequence 2 5) 17)
  | 13 => .back 4 346 [.swapSuits 1 2]
  | 14 => .back 2 348 []
  | 15 => .back 2 344 []
  | 16 => .back 5 347 []
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
  | 27 => .back 28 351 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 351 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 351 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 351 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 3) (.sequence 2 5) 31)
  | 32 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 3) (.sequence 2 5) 32)
  | 33 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 3) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row520 : Row := ⟨520, state520, 520, action520⟩

def state521 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 13 | 14 | 15 | 19 | 20 | 24 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 16 | 18 | 21 | 22 | 23 | 26 | 33 => 1
  | 17 => 2
  | 25 => 3
  | _ => 0

def action521 (t : Tile) : Action :=
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
  | 13 => .back 22 352 []
  | 14 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 5) (.sequence 2 3) 17)
  | 15 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 2)
  | 16 => .win 16 (FullWinWitness.standard (.triplet 16) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 17 => .win 2 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 2)
  | 18 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 18)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 21 => .back 27 353 [.swapHonors 0 5, .swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | 22 => .back 13 352 []
  | 23 => .back 13 354 []
  | 24 => .win 15 (FullWinWitness.standard (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) (.sequence 2 6) 25)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 6) 17)
  | 26 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 26)
  | 27 => .back 21 353 [.swapHonors 0 5, .swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | 28 => .back 21 353 [.swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | 29 => .back 21 353 [.swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | 30 => .back 21 353 [.swapHonors 3 5, .swapHonors 4 5]
  | 31 => .back 21 353 [.swapHonors 4 5]
  | 32 => .back 21 353 []
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row521 : Row := ⟨521, state521, 521, action521⟩

def state522 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 16 | 18 | 20 | 24 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 13 | 19 | 21 | 22 | 23 | 26 | 33 => 1
  | 17 => 2
  | 25 => 3
  | _ => 0

def action522 (t : Tile) : Action :=
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
  | 16 => .back 23 355 []
  | 17 => .win 2 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 2)
  | 18 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 19 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 19)
  | 20 => .win 18 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 1) (.sequence 2 3) 17)
  | 22 => .back 27 356 [.swapHonors 0 5, .swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | 23 => .back 16 355 []
  | 24 => .win 17 (FullWinWitness.standard (.triplet 17) (.sequence 0 5) (.sequence 2 3) (.sequence 2 6) 25)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 6) 17)
  | 26 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 26)
  | 27 => .back 22 356 [.swapHonors 0 5, .swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | 28 => .back 22 356 [.swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | 29 => .back 22 356 [.swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | 30 => .back 22 356 [.swapHonors 3 5, .swapHonors 4 5]
  | 31 => .back 22 356 [.swapHonors 4 5]
  | 32 => .back 22 356 []
  | 33 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row522 : Row := ⟨522, state522, 522, action522⟩

def state523 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 10 | 15 | 18 | 20 | 21 | 22 | 23 | 25 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 2 | 5 | 6 | 7 | 8 | 11 | 12 | 13 | 14 | 17 | 19 | 24 | 33 => 1
  | 16 => 3
  | 26 => 2
  | _ => 0

def action523 (t : Tile) : Action :=
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
  | 27 => .back 28 357 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 357 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 357 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 357 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 357 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 357 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 2) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row523 : Row := ⟨523, state523, 523, action523⟩

def state524 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 6 | 9 | 10 | 12 | 13 | 18 | 20 | 21 | 22 | 23 | 24 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 3 | 26 => 2
  | 4 | 5 | 8 | 11 | 14 | 15 | 16 | 17 | 19 | 25 | 33 => 1
  | 7 => 3
  | _ => 0

def action524 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 27 353 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 0 5, .swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
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
  | 22 => .back 0 358 [.swapSuits 0 2, .swapSuits 1 2]
  | 23 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 5) 26)
  | 24 => .win 3 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 3)
  | 25 => .win 25 (FullWinWitness.standard (.triplet 7) (.triplet 25) (.sequence 0 3) (.sequence 1 5) 26)
  | 26 => .win 3 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 3)
  | 27 => .back 0 353 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 0 5, .swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | 28 => .back 0 353 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | 29 => .back 0 353 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | 30 => .back 0 353 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 3 5, .swapHonors 4 5]
  | 31 => .back 0 353 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 4 5]
  | 32 => .back 0 353 [.swapSuits 0 2, .swapSuits 1 2]
  | 33 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row524 : Row := ⟨524, state524, 524, action524⟩

def state525 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 6 | 9 | 10 | 12 | 13 | 18 | 20 | 21 | 23 | 24 | 25 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 3 | 5 | 8 | 11 | 14 | 15 | 16 | 17 | 19 | 22 | 33 => 1
  | 4 | 26 => 2
  | 7 => 3
  | _ => 0

def action525 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 25 352 [.swapSuits 0 2, .swapSuits 1 2]
  | 1 => .back 27 356 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 0 5, .swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
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
  | 25 => .back 0 352 [.swapSuits 0 2, .swapSuits 1 2]
  | 26 => .win 4 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 4)
  | 27 => .back 1 356 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 0 5, .swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | 28 => .back 1 356 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | 29 => .back 1 356 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | 30 => .back 1 356 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 3 5, .swapHonors 4 5]
  | 31 => .back 1 356 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 4 5]
  | 32 => .back 1 356 [.swapSuits 0 2, .swapSuits 1 2]
  | 33 => .win 26 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row525 : Row := ⟨525, state525, 525, action525⟩

def state526 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 6 | 9 | 10 | 12 | 13 | 18 | 20 | 21 | 22 | 23 | 24 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 3 | 4 | 8 | 11 | 14 | 15 | 16 | 17 | 19 | 25 | 33 => 1
  | 5 | 26 => 2
  | 7 => 3
  | _ => 0

def action526 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 22 354 [.swapSuits 0 2, .swapSuits 1 2]
  | 1 => .back 22 355 [.swapSuits 0 2, .swapSuits 1 2]
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
  | 22 => .back 1 355 [.swapSuits 0 2, .swapSuits 1 2]
  | 23 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 5) 26)
  | 24 => .win 2 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 5) (.sequence 2 6) 5)
  | 25 => .win 25 (FullWinWitness.standard (.triplet 7) (.triplet 25) (.sequence 0 3) (.sequence 1 5) 26)
  | 26 => .win 2 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 2) (.sequence 1 5) 5)
  | 27 => .back 28 359 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 359 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 359 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 359 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 359 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 359 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row526 : Row := ⟨526, state526, 526, action526⟩

def state527 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 10 | 15 | 18 | 20 | 21 | 22 | 24 | 25 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 2 | 5 | 6 | 7 | 8 | 11 | 12 | 13 | 14 | 17 | 19 | 23 | 33 => 1
  | 16 => 3
  | 26 => 2
  | _ => 0

def action527 (t : Tile) : Action :=
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
  | 27 => .back 28 360 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 360 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 360 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 360 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 360 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 360 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 26 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 5) (.sequence 1 2) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row527 : Row := ⟨527, state527, 527, action527⟩

def state528 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 6 | 9 | 10 | 12 | 13 | 18 | 20 | 21 | 22 | 23 | 24 | 25 | 27 | 28 | 29 | 30 => 0
  | 3 | 4 | 5 | 8 | 11 | 14 | 15 | 16 | 17 | 19 | 31 | 32 | 33 => 1
  | 7 => 3
  | 26 => 2
  | _ => 0

def action528 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 25 361 [.swapSuits 0 2, .swapSuits 1 2]
  | 1 => .back 25 362 [.swapSuits 0 2, .swapSuits 1 2]
  | 2 => .back 24 357 [.swapSuits 0 1]
  | 3 => .back 25 363 []
  | 4 => .back 22 364 []
  | 5 => .back 25 359 []
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
  | 22 => .back 4 364 []
  | 23 => .back 2 360 [.swapSuits 0 1]
  | 24 => .back 2 357 [.swapSuits 0 1]
  | 25 => .back 5 359 []
  | 26 => .win 6 (FullWinWitness.standard (.triplet 26) (.sequence 0 3) (.sequence 0 6) (.sequence 1 5) 7)
  | 27 => .back 28 365 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 365 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 365 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 365 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 26 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 31)
  | 32 => .win 26 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 32)
  | 33 => .win 26 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row528 : Row := ⟨528, state528, 528, action528⟩

def state529 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 5 | 7 | 10 | 11 | 12 | 13 | 19 | 20 | 24 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 0
  | 1 | 6 | 9 | 14 | 15 | 16 | 17 | 18 | 22 | 23 | 26 => 1
  | 8 | 21 => 2
  | 25 => 3
  | _ => 0

def action529 (t : Tile) : Action :=
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
  | 27 => .back 28 366 [.swapHonors 0 6, .swapHonors 1 5, .swapHonors 2 6, .swapHonors 3 5, .swapHonors 4 6]
  | 28 => .back 27 366 [.swapHonors 0 5, .swapHonors 1 6, .swapHonors 2 5, .swapHonors 3 6, .swapHonors 4 5, .swapHonors 5 6]
  | 29 => .back 27 366 [.swapHonors 0 5, .swapHonors 1 5, .swapHonors 2 6, .swapHonors 3 5, .swapHonors 4 6]
  | 30 => .back 27 366 [.swapHonors 0 5, .swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 6, .swapHonors 4 5, .swapHonors 5 6]
  | 31 => .back 27 366 [.swapHonors 0 5, .swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 6]
  | 32 => .back 27 366 [.swapHonors 0 5, .swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5, .swapHonors 5 6]
  | 33 => .back 27 366 [.swapHonors 0 5, .swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | _ => .win 0 (FullWinWitness.orphans 0)

def row529 : Row := ⟨529, state529, 529, action529⟩

def state530 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 5 | 6 | 9 | 11 | 12 | 13 | 19 | 20 | 24 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 0
  | 1 | 7 | 10 | 14 | 15 | 16 | 17 | 18 | 22 | 23 | 26 => 1
  | 8 | 21 => 2
  | 25 => 3
  | _ => 0

def action530 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 1 => .win 1 (FullWinWitness.standard (.triplet 1) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 8)
  | 2 => .win 0 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 4 => .back 27 345 [.swapSuits 0 1, .swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
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
  | 27 => .back 28 339 [.swapHonors 0 6, .swapHonors 1 5, .swapHonors 2 6, .swapHonors 3 5, .swapHonors 4 6]
  | 28 => .back 27 339 [.swapHonors 0 5, .swapHonors 1 6, .swapHonors 2 5, .swapHonors 3 6, .swapHonors 4 5, .swapHonors 5 6]
  | 29 => .back 27 339 [.swapHonors 0 5, .swapHonors 1 5, .swapHonors 2 6, .swapHonors 3 5, .swapHonors 4 6]
  | 30 => .back 27 339 [.swapHonors 0 5, .swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 6, .swapHonors 4 5, .swapHonors 5 6]
  | 31 => .back 27 339 [.swapHonors 0 5, .swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 6]
  | 32 => .back 27 339 [.swapHonors 0 5, .swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5, .swapHonors 5 6]
  | 33 => .back 27 339 [.swapHonors 0 5, .swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | _ => .win 0 (FullWinWitness.orphans 0)

def row530 : Row := ⟨530, state530, 530, action530⟩

def state531 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 16 | 19 | 20 | 24 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 13 | 18 | 22 | 23 | 26 => 1
  | 17 | 21 => 2
  | 25 => 3
  | _ => 0

def action531 (t : Tile) : Action :=
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
  | 16 => .back 27 358 [.swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
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
  | 27 => .back 16 358 [.swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 28 => .back 16 358 [.swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 29 => .back 16 358 [.swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 30 => .back 16 358 [.swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 31 => .back 16 358 [.swapHonors 4 6, .swapHonors 5 6]
  | 32 => .back 16 358 [.swapHonors 5 6]
  | 33 => .back 16 358 []
  | _ => .win 0 (FullWinWitness.orphans 0)

def row531 : Row := ⟨531, state531, 531, action531⟩

def state532 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 6 | 7 | 10 | 11 | 12 | 13 | 19 | 20 | 24 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 0
  | 1 | 5 | 9 | 14 | 15 | 16 | 17 | 18 | 22 | 23 | 26 => 1
  | 8 | 21 => 2
  | 25 => 3
  | _ => 0

def action532 (t : Tile) : Action :=
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
  | 27 => .back 28 367 [.swapHonors 0 6, .swapHonors 1 5, .swapHonors 2 6, .swapHonors 3 5, .swapHonors 4 6]
  | 28 => .back 27 367 [.swapHonors 0 5, .swapHonors 1 6, .swapHonors 2 5, .swapHonors 3 6, .swapHonors 4 5, .swapHonors 5 6]
  | 29 => .back 27 367 [.swapHonors 0 5, .swapHonors 1 5, .swapHonors 2 6, .swapHonors 3 5, .swapHonors 4 6]
  | 30 => .back 27 367 [.swapHonors 0 5, .swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 6, .swapHonors 4 5, .swapHonors 5 6]
  | 31 => .back 27 367 [.swapHonors 0 5, .swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 6]
  | 32 => .back 27 367 [.swapHonors 0 5, .swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5, .swapHonors 5 6]
  | 33 => .back 27 367 [.swapHonors 0 5, .swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | _ => .win 0 (FullWinWitness.orphans 0)

def row532 : Row := ⟨532, state532, 532, action532⟩

def state533 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 4 | 9 | 11 | 12 | 13 | 14 | 15 | 16 | 19 | 20 | 24 | 27 | 28 | 29 | 30 | 31 => 0
  | 5 | 6 | 7 | 8 | 10 | 18 | 22 | 23 | 26 | 32 | 33 => 1
  | 17 | 21 => 2
  | 25 => 3
  | _ => 0

def action533 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 15 366 [.swapSuits 0 1]
  | 1 => .back 16 339 [.swapSuits 0 1]
  | 2 => .back 16 353 []
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
  | 13 => .back 2 368 []
  | 14 => .back 0 367 [.swapSuits 0 1]
  | 15 => .back 0 366 [.swapSuits 0 1]
  | 16 => .back 2 353 []
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
  | 27 => .back 28 369 [.swapHonors 0 4, .swapHonors 1 3, .swapHonors 2 4]
  | 28 => .back 27 369 [.swapHonors 0 3, .swapHonors 1 4, .swapHonors 2 3, .swapHonors 3 4]
  | 29 => .back 27 369 [.swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 4]
  | 30 => .back 27 369 [.swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 3, .swapHonors 3 4]
  | 31 => .back 27 369 [.swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 3]
  | 32 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 32)
  | 33 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row533 : Row := ⟨533, state533, 533, action533⟩

def state534 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 16 | 18 | 20 | 24 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 0
  | 1 | 5 | 6 | 7 | 8 | 10 | 13 | 19 | 21 | 23 | 26 => 1
  | 17 | 22 => 2
  | 25 => 3
  | _ => 0

def action534 (t : Tile) : Action :=
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
  | 15 => .win 14 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 4) (.sequence 2 3) 17)
  | 16 => .back 27 342 [.swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 17 => .win 1 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 1)
  | 18 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 19 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 19)
  | 20 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 1) 22)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 1) (.sequence 2 3) 17)
  | 22 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 22)
  | 23 => .win 21 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 24 => .win 17 (FullWinWitness.standard (.triplet 17) (.sequence 0 5) (.sequence 2 3) (.sequence 2 6) 25)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 6) 17)
  | 26 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 26)
  | 27 => .back 16 342 [.swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 28 => .back 16 342 [.swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 29 => .back 16 342 [.swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 30 => .back 16 342 [.swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 31 => .back 16 342 [.swapHonors 4 6, .swapHonors 5 6]
  | 32 => .back 16 342 [.swapHonors 5 6]
  | 33 => .back 16 342 []
  | _ => .win 0 (FullWinWitness.orphans 0)

def row534 : Row := ⟨534, state534, 534, action534⟩

def state535 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 5 | 6 | 9 | 11 | 15 | 19 | 20 | 21 | 22 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 0
  | 1 | 4 | 7 | 10 | 12 | 13 | 14 | 17 | 18 | 23 | 24 | 25 | 26 => 1
  | 8 => 2
  | 16 => 3
  | _ => 0

def action535 (t : Tile) : Action :=
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
  | 11 => .win 9 (FullWinWitness.standard (.triplet 16) (.sequence 1 0) (.sequence 1 3) (.sequence 2 5) 8)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 16) (.sequence 1 1) (.sequence 1 3) (.sequence 2 5) 8)
  | 13 => .back 27 370 [.swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 14 => .back 27 333 [.swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
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
  | 27 => .back 14 333 [.swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 28 => .back 14 333 [.swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 29 => .back 14 333 [.swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 30 => .back 14 333 [.swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 31 => .back 14 333 [.swapHonors 4 6, .swapHonors 5 6]
  | 32 => .back 14 333 [.swapHonors 5 6]
  | 33 => .back 14 333 []
  | _ => .win 0 (FullWinWitness.orphans 0)

def row535 : Row := ⟨535, state535, 535, action535⟩

def state536 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 6 | 9 | 11 | 12 | 13 | 14 | 16 | 19 | 20 | 21 | 22 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 2 | 3 | 4 | 5 | 8 | 10 | 15 | 18 | 23 | 24 | 25 | 26 | 33 => 1
  | 7 => 3
  | 17 => 2
  | _ => 0

def action536 (t : Tile) : Action :=
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
  | 27 => .back 28 371 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 371 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 371 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 371 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 371 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 371 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 16 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 6) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row536 : Row := ⟨536, state536, 536, action536⟩

def state537 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 5 | 6 | 7 | 9 | 11 | 15 | 19 | 20 | 21 | 22 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 0
  | 1 | 4 | 10 | 12 | 14 | 17 | 18 | 23 | 24 | 25 | 26 => 1
  | 8 | 13 => 2
  | 16 => 3
  | _ => 0

def action537 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 2 (FullWinWitness.standard (.triplet 16) (.sequence 0 0) (.sequence 1 3) (.sequence 2 5) 8)
  | 1 => .win 1 (FullWinWitness.standard (.triplet 1) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 8)
  | 2 => .win 0 (FullWinWitness.standard (.triplet 16) (.sequence 0 0) (.sequence 1 3) (.sequence 2 5) 8)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 16) (.sequence 0 1) (.sequence 1 3) (.sequence 2 5) 8)
  | 4 => .win 4 (FullWinWitness.standard (.triplet 4) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 8)
  | 5 => .win 3 (FullWinWitness.standard (.triplet 16) (.sequence 0 3) (.sequence 1 3) (.sequence 2 5) 8)
  | 6 => .win 5 (FullWinWitness.standard (.triplet 16) (.sequence 0 4) (.sequence 1 3) (.sequence 2 5) 8)
  | 7 => .back 27 370 [.swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 8 => .win 1 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 1)
  | 9 => .win 11 (FullWinWitness.standard (.triplet 16) (.sequence 1 0) (.sequence 1 3) (.sequence 2 5) 8)
  | 10 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 10)
  | 11 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 1) (.sequence 2 5) 13)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 16) (.sequence 1 1) (.sequence 1 3) (.sequence 2 5) 8)
  | 13 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 13)
  | 14 => .win 12 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 1 3) (.sequence 2 5) 8)
  | 15 => .win 8 (FullWinWitness.standard (.triplet 8) (.sequence 1 3) (.sequence 1 6) (.sequence 2 5) 16)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 1 6) (.sequence 2 5) 8)
  | 17 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 17)
  | 18 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 18)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 0) (.sequence 2 5) 8)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 0) (.sequence 2 5) 8)
  | 21 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 3) (.sequence 2 6) 8)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 3) (.sequence 2 6) 8)
  | 23 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 3) (.sequence 2 6) 23)
  | 24 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 4) (.sequence 2 6) 8)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 5) (.sequence 2 6) 8)
  | 26 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 26)
  | 27 => .back 7 370 [.swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 28 => .back 7 370 [.swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 29 => .back 7 370 [.swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 30 => .back 7 370 [.swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 31 => .back 7 370 [.swapHonors 4 6, .swapHonors 5 6]
  | 32 => .back 7 370 [.swapHonors 5 6]
  | 33 => .back 7 370 []
  | _ => .win 0 (FullWinWitness.orphans 0)

def row537 : Row := ⟨537, state537, 537, action537⟩

def state538 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 16 | 19 | 20 | 24 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 13 | 18 | 21 | 23 | 26 => 1
  | 17 | 22 => 2
  | 25 => 3
  | _ => 0

def action538 (t : Tile) : Action :=
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
  | 16 => .back 27 352 [.swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 17 => .win 2 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 2)
  | 18 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 18)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 2) (.sequence 2 3) 17)
  | 22 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 22)
  | 23 => .win 21 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 24 => .win 17 (FullWinWitness.standard (.triplet 17) (.sequence 0 5) (.sequence 2 3) (.sequence 2 6) 25)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 6) 17)
  | 26 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 26)
  | 27 => .back 16 352 [.swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 28 => .back 16 352 [.swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 29 => .back 16 352 [.swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 30 => .back 16 352 [.swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 31 => .back 16 352 [.swapHonors 4 6, .swapHonors 5 6]
  | 32 => .back 16 352 [.swapHonors 5 6]
  | 33 => .back 16 352 []
  | _ => .win 0 (FullWinWitness.orphans 0)

def row538 : Row := ⟨538, state538, 538, action538⟩

def state539 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 6 | 9 | 10 | 12 | 13 | 18 | 20 | 21 | 23 | 24 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 0
  | 3 | 5 | 8 | 11 | 14 | 15 | 16 | 17 | 19 | 22 | 25 => 1
  | 4 | 26 => 2
  | 7 => 3
  | _ => 0

def action539 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 27 352 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 1 => .back 27 372 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
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
  | 24 => .win 4 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 4)
  | 25 => .win 25 (FullWinWitness.standard (.triplet 7) (.triplet 25) (.sequence 0 3) (.sequence 1 5) 26)
  | 26 => .win 4 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 4)
  | 27 => .back 0 352 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 28 => .back 0 352 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 29 => .back 0 352 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 30 => .back 0 352 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 31 => .back 0 352 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 4 6, .swapHonors 5 6]
  | 32 => .back 0 352 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 5 6]
  | 33 => .back 0 352 [.swapSuits 0 2, .swapSuits 1 2]
  | _ => .win 0 (FullWinWitness.orphans 0)

def row539 : Row := ⟨539, state539, 539, action539⟩

def state540 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 13 | 14 | 15 | 18 | 20 | 24 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 16 | 19 | 21 | 22 | 26 => 1
  | 17 | 23 => 2
  | 25 => 3
  | _ => 0

def action540 (t : Tile) : Action :=
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
  | 13 => .back 27 355 [.swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 14 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 5) (.sequence 2 3) 17)
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
  | 27 => .back 13 355 [.swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 28 => .back 13 355 [.swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 29 => .back 13 355 [.swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 30 => .back 13 355 [.swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 31 => .back 13 355 [.swapHonors 4 6, .swapHonors 5 6]
  | 32 => .back 13 355 [.swapHonors 5 6]
  | 33 => .back 13 355 []
  | _ => .win 0 (FullWinWitness.orphans 0)

def row540 : Row := ⟨540, state540, 540, action540⟩

def state541 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 13 | 14 | 15 | 19 | 20 | 24 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 16 | 18 | 21 | 22 | 26 => 1
  | 17 | 23 => 2
  | 25 => 3
  | _ => 0

def action541 (t : Tile) : Action :=
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
  | 13 => .back 27 354 [.swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 14 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 5) (.sequence 2 3) 17)
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
  | 27 => .back 13 354 [.swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 28 => .back 13 354 [.swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 29 => .back 13 354 [.swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 30 => .back 13 354 [.swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 31 => .back 13 354 [.swapHonors 4 6, .swapHonors 5 6]
  | 32 => .back 13 354 [.swapHonors 5 6]
  | 33 => .back 13 354 []
  | _ => .win 0 (FullWinWitness.orphans 0)

def row541 : Row := ⟨541, state541, 541, action541⟩

def state542 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 6 | 9 | 10 | 12 | 13 | 18 | 20 | 21 | 23 | 24 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 0
  | 3 | 4 | 8 | 11 | 14 | 15 | 16 | 17 | 19 | 22 | 25 => 1
  | 5 | 26 => 2
  | 7 => 3
  | _ => 0

def action542 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 27 354 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 1 => .back 27 355 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
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
  | 22 => .win 22 (FullWinWitness.standard (.triplet 7) (.triplet 22) (.sequence 0 3) (.sequence 1 5) 26)
  | 23 => .win 21 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 3) 26)
  | 24 => .win 2 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 5) (.sequence 2 6) 5)
  | 25 => .win 25 (FullWinWitness.standard (.triplet 7) (.triplet 25) (.sequence 0 3) (.sequence 1 5) 26)
  | 26 => .win 2 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 2) (.sequence 1 5) 5)
  | 27 => .back 1 355 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 28 => .back 1 355 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 29 => .back 1 355 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 30 => .back 1 355 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 31 => .back 1 355 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 4 6, .swapHonors 5 6]
  | 32 => .back 1 355 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 5 6]
  | 33 => .back 1 355 [.swapSuits 0 2, .swapSuits 1 2]
  | _ => .win 0 (FullWinWitness.orphans 0)

def row542 : Row := ⟨542, state542, 542, action542⟩

def state543 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 6 | 9 | 11 | 12 | 13 | 15 | 16 | 19 | 20 | 21 | 22 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 2 | 3 | 4 | 5 | 8 | 10 | 14 | 18 | 23 | 24 | 25 | 26 | 33 => 1
  | 7 => 3
  | 17 => 2
  | _ => 0

def action543 (t : Tile) : Action :=
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
  | 27 => .back 28 373 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 373 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 373 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 373 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 373 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 373 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 2) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row543 : Row := ⟨543, state543, 543, action543⟩

def state544 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 6 | 7 | 9 | 10 | 15 | 19 | 20 | 21 | 22 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 2 | 5 | 11 | 12 | 13 | 14 | 17 | 18 | 23 | 24 | 25 | 26 | 33 => 1
  | 8 => 2
  | 16 => 3
  | _ => 0

def action544 (t : Tile) : Action :=
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
  | 27 => .back 28 374 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 374 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 374 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 374 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 374 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 374 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 2) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row544 : Row := ⟨544, state544, 544, action544⟩

def state545 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 5 | 7 | 9 | 10 | 15 | 18 | 20 | 21 | 22 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 2 | 6 | 11 | 12 | 13 | 14 | 17 | 19 | 23 | 24 | 25 | 26 | 33 => 1
  | 8 => 2
  | 16 => 3
  | _ => 0

def action545 (t : Tile) : Action :=
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
  | 27 => .back 28 375 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 375 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 375 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 375 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 375 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 375 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 7 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row545 : Row := ⟨545, state545, 545, action545⟩

def state546 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 5 | 6 | 9 | 10 | 12 | 13 | 18 | 19 | 24 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 2 | 7 | 11 | 14 | 15 | 16 | 17 | 20 | 21 | 22 | 23 | 26 | 33 => 1
  | 8 => 2
  | 25 => 3
  | _ => 0

def action546 (t : Tile) : Action :=
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
  | 27 => .back 28 376 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 376 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 376 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 376 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 376 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 376 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row546 : Row := ⟨546, state546, 546, action546⟩

def state547 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 4 | 9 | 10 | 12 | 13 | 14 | 15 | 18 | 19 | 24 | 27 | 28 | 29 | 30 | 31 => 0
  | 5 | 6 | 7 | 8 | 11 | 16 | 20 | 21 | 22 | 23 | 26 | 32 | 33 => 1
  | 17 => 2
  | 25 => 3
  | _ => 0

def action547 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 27 377 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 1 => .back 27 378 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 2 => .back 27 376 [.swapSuits 0 1, .swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 3 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 3) (.sequence 0 6) (.sequence 2 2) 17)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 25) (.sequence 0 3) (.sequence 0 6) (.sequence 2 2) 17)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 25) (.sequence 0 6) (.sequence 2 2) 17)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 4) (.sequence 0 6) (.sequence 2 2) 17)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 0 6) (.sequence 2 2) 17)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 0 5) (.sequence 2 2) 17)
  | 9 => .win 10 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 0) (.sequence 2 2) 17)
  | 10 => .win 9 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 0) (.sequence 2 2) 17)
  | 11 => .win 11 (FullWinWitness.standard (.triplet 11) (.triplet 25) (.sequence 0 5) (.sequence 2 2) 17)
  | 12 => .win 10 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 1) (.sequence 2 2) 17)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 2) (.sequence 2 2) 17)
  | 14 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 5) (.sequence 2 2) 17)
  | 15 => .win 5 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 6) (.sequence 2 2) 5)
  | 16 => .win 16 (FullWinWitness.standard (.triplet 16) (.triplet 25) (.sequence 0 5) (.sequence 2 2) 17)
  | 17 => .win 5 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 6) (.sequence 2 2) 5)
  | 18 => .win 19 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 19 => .win 18 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 20 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 20)
  | 21 => .win 19 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 1) (.sequence 2 3) 17)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 2) (.sequence 2 3) 17)
  | 23 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 2) 23)
  | 24 => .win 15 (FullWinWitness.standard (.sequence 0 5) (.sequence 1 6) (.sequence 2 2) (.sequence 2 5) 25)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 2) (.sequence 2 5) 17)
  | 26 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 2) 26)
  | 27 => .back 2 376 [.swapSuits 0 1, .swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 28 => .back 2 376 [.swapSuits 0 1, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 29 => .back 2 376 [.swapSuits 0 1, .swapHonors 2 4, .swapHonors 3 4]
  | 30 => .back 2 376 [.swapSuits 0 1, .swapHonors 3 4]
  | 31 => .back 2 376 [.swapSuits 0 1]
  | 32 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 2) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 2) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row547 : Row := ⟨547, state547, 547, action547⟩

def state548 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 4 | 5 | 6 | 10 | 11 | 12 | 13 | 19 | 20 | 24 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 0
  | 3 | 7 | 9 | 14 | 15 | 16 | 17 | 18 | 22 | 23 | 26 => 1
  | 8 | 21 => 2
  | 25 => 3
  | _ => 0

def action548 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 27 379 [.swapSuits 0 1, .swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
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
  | 27 => .back 0 379 [.swapSuits 0 1, .swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 28 => .back 0 379 [.swapSuits 0 1, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 29 => .back 0 379 [.swapSuits 0 1, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 30 => .back 0 379 [.swapSuits 0 1, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 31 => .back 0 379 [.swapSuits 0 1, .swapHonors 4 6, .swapHonors 5 6]
  | 32 => .back 0 379 [.swapSuits 0 1, .swapHonors 5 6]
  | 33 => .back 0 379 [.swapSuits 0 1]
  | _ => .win 0 (FullWinWitness.orphans 0)

def row548 : Row := ⟨548, state548, 548, action548⟩

def state549 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 4 | 5 | 6 | 7 | 9 | 10 | 11 | 15 | 19 | 20 | 21 | 22 | 27 | 28 | 29 | 30 | 31 => 0
  | 3 | 13 | 14 | 17 | 18 | 23 | 24 | 25 | 26 | 32 | 33 => 1
  | 8 | 12 => 2
  | 16 => 3
  | _ => 0

def action549 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 6 331 [.swapSuits 0 2, .swapSuits 1 2]
  | 1 => .win 2 (FullWinWitness.standard (.triplet 16) (.sequence 0 1) (.sequence 1 3) (.sequence 2 5) 8)
  | 2 => .win 1 (FullWinWitness.standard (.triplet 16) (.sequence 0 1) (.sequence 1 3) (.sequence 2 5) 8)
  | 3 => .win 3 (FullWinWitness.standard (.triplet 3) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 8)
  | 4 => .win 2 (FullWinWitness.standard (.triplet 16) (.sequence 0 2) (.sequence 1 3) (.sequence 2 5) 8)
  | 5 => .win 4 (FullWinWitness.standard (.triplet 16) (.sequence 0 3) (.sequence 1 3) (.sequence 2 5) 8)
  | 6 => .back 0 331 [.swapSuits 0 2, .swapSuits 1 2]
  | 7 => .back 9 380 [.swapSuits 1 2]
  | 8 => .win 3 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 3)
  | 9 => .back 7 380 [.swapSuits 1 2]
  | 10 => .win 11 (FullWinWitness.standard (.triplet 16) (.sequence 1 1) (.sequence 1 3) (.sequence 2 5) 8)
  | 11 => .win 10 (FullWinWitness.standard (.triplet 16) (.sequence 1 1) (.sequence 1 3) (.sequence 2 5) 8)
  | 12 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 12)
  | 13 => .win 11 (FullWinWitness.standard (.triplet 16) (.sequence 1 2) (.sequence 1 3) (.sequence 2 5) 8)
  | 14 => .win 13 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 1 3) (.sequence 2 5) 8)
  | 15 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 4) (.sequence 2 5) 12)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 1 6) (.sequence 2 5) 8)
  | 17 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 17)
  | 18 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 18)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 0) (.sequence 2 5) 8)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 0) (.sequence 2 5) 8)
  | 21 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 3) (.sequence 2 6) 8)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 3) (.sequence 2 6) 8)
  | 23 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 3) (.sequence 2 6) 23)
  | 24 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 4) (.sequence 2 6) 8)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 5) (.sequence 2 6) 8)
  | 26 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 26)
  | 27 => .back 7 381 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 28 => .back 7 381 [.swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 29 => .back 7 381 [.swapHonors 2 4, .swapHonors 3 4]
  | 30 => .back 7 381 [.swapHonors 3 4]
  | 31 => .back 7 381 []
  | 32 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 32)
  | 33 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row549 : Row := ⟨549, state549, 549, action549⟩

def state550 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 4 | 5 | 6 | 9 | 11 | 12 | 13 | 18 | 20 | 24 | 25 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 0
  | 3 | 7 | 10 | 14 | 15 | 16 | 17 | 21 | 22 | 26 => 1
  | 8 | 23 => 2
  | 19 => 4
  | _ => 0

def action550 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 27 382 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
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
  | 27 => .back 28 383 [.swapHonors 0 6, .swapHonors 1 5, .swapHonors 2 6, .swapHonors 3 5, .swapHonors 4 6]
  | 28 => .back 27 383 [.swapHonors 0 5, .swapHonors 1 6, .swapHonors 2 5, .swapHonors 3 6, .swapHonors 4 5, .swapHonors 5 6]
  | 29 => .back 27 383 [.swapHonors 0 5, .swapHonors 1 5, .swapHonors 2 6, .swapHonors 3 5, .swapHonors 4 6]
  | 30 => .back 27 383 [.swapHonors 0 5, .swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 6, .swapHonors 4 5, .swapHonors 5 6]
  | 31 => .back 27 383 [.swapHonors 0 5, .swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 6]
  | 32 => .back 27 383 [.swapHonors 0 5, .swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5, .swapHonors 5 6]
  | 33 => .back 27 383 [.swapHonors 0 5, .swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | _ => .win 0 (FullWinWitness.orphans 0)

def row550 : Row := ⟨550, state550, 550, action550⟩

def state551 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 4 | 5 | 6 | 7 | 9 | 10 | 11 | 15 | 17 | 18 | 20 | 21 | 22 | 27 | 28 | 29 | 30 | 31 => 0
  | 3 | 13 | 14 | 19 | 23 | 24 | 25 | 26 | 32 | 33 => 1
  | 8 | 12 => 2
  | 16 => 4
  | _ => 0

def action551 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 6 319 [.swapSuits 0 2, .swapSuits 1 2]
  | 1 => .win 2 (FullWinWitness.standard (.triplet 16) (.sequence 0 1) (.sequence 1 3) (.sequence 2 5) 8)
  | 2 => .win 1 (FullWinWitness.standard (.triplet 16) (.sequence 0 1) (.sequence 1 3) (.sequence 2 5) 8)
  | 3 => .win 3 (FullWinWitness.standard (.triplet 3) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 8)
  | 4 => .win 2 (FullWinWitness.standard (.triplet 16) (.sequence 0 2) (.sequence 1 3) (.sequence 2 5) 8)
  | 5 => .win 4 (FullWinWitness.standard (.triplet 16) (.sequence 0 3) (.sequence 1 3) (.sequence 2 5) 8)
  | 6 => .back 0 319 [.swapSuits 0 2, .swapSuits 1 2]
  | 7 => .back 9 383 [.swapSuits 1 2, .reverseSuit 1]
  | 8 => .win 3 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 3)
  | 9 => .back 7 383 [.swapSuits 1 2, .reverseSuit 1]
  | 10 => .win 11 (FullWinWitness.standard (.triplet 16) (.sequence 1 1) (.sequence 1 3) (.sequence 2 5) 8)
  | 11 => .win 10 (FullWinWitness.standard (.triplet 16) (.sequence 1 1) (.sequence 1 3) (.sequence 2 5) 8)
  | 12 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 12)
  | 13 => .win 11 (FullWinWitness.standard (.triplet 16) (.sequence 1 2) (.sequence 1 3) (.sequence 2 5) 8)
  | 14 => .win 13 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 1 3) (.sequence 2 5) 8)
  | 15 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 4) (.sequence 2 5) 12)
  | 17 => .win 15 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 1 6) (.sequence 2 5) 8)
  | 18 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 0) (.sequence 2 5) 8)
  | 19 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 19)
  | 20 => .win 18 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 0) (.sequence 2 5) 8)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 1) (.sequence 2 5) 8)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 3) (.sequence 2 6) 8)
  | 23 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 3) (.sequence 2 6) 23)
  | 24 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 4) (.sequence 2 6) 8)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 5) (.sequence 2 6) 8)
  | 26 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 26)
  | 27 => .back 7 384 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 28 => .back 7 384 [.swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 29 => .back 7 384 [.swapHonors 2 4, .swapHonors 3 4]
  | 30 => .back 7 384 [.swapHonors 3 4]
  | 31 => .back 7 384 []
  | 32 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 32)
  | 33 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row551 : Row := ⟨551, state551, 551, action551⟩

def state552 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 4 | 5 | 6 | 9 | 10 | 12 | 13 | 18 | 20 | 24 | 25 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 0
  | 3 | 7 | 11 | 14 | 15 | 16 | 17 | 21 | 22 | 26 => 1
  | 8 | 23 => 2
  | 19 => 4
  | _ => 0

def action552 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 27 385 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
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
  | 27 => .back 0 385 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 28 => .back 0 385 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 29 => .back 0 385 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 30 => .back 0 385 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 31 => .back 0 385 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 4 6, .swapHonors 5 6]
  | 32 => .back 0 385 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 5 6]
  | 33 => .back 0 385 [.swapSuits 0 2, .swapSuits 1 2]
  | _ => .win 0 (FullWinWitness.orphans 0)

def row552 : Row := ⟨552, state552, 552, action552⟩

def state553 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 4 | 5 | 6 | 7 | 9 | 10 | 11 | 15 | 17 | 18 | 19 | 21 | 22 | 27 | 28 | 29 | 30 | 31 => 0
  | 3 | 13 | 14 | 20 | 23 | 24 | 25 | 26 | 32 | 33 => 1
  | 8 | 12 => 2
  | 16 => 4
  | _ => 0

def action553 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 6 330 [.swapSuits 0 2, .swapSuits 1 2]
  | 1 => .win 2 (FullWinWitness.standard (.triplet 16) (.sequence 0 1) (.sequence 1 3) (.sequence 2 5) 8)
  | 2 => .win 1 (FullWinWitness.standard (.triplet 16) (.sequence 0 1) (.sequence 1 3) (.sequence 2 5) 8)
  | 3 => .win 3 (FullWinWitness.standard (.triplet 3) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 8)
  | 4 => .win 2 (FullWinWitness.standard (.triplet 16) (.sequence 0 2) (.sequence 1 3) (.sequence 2 5) 8)
  | 5 => .win 4 (FullWinWitness.standard (.triplet 16) (.sequence 0 3) (.sequence 1 3) (.sequence 2 5) 8)
  | 6 => .back 0 330 [.swapSuits 0 2, .swapSuits 1 2]
  | 7 => .back 27 386 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 8 => .win 3 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 3)
  | 9 => .back 7 387 [.swapSuits 1 2, .reverseSuit 1]
  | 10 => .win 11 (FullWinWitness.standard (.triplet 16) (.sequence 1 1) (.sequence 1 3) (.sequence 2 5) 8)
  | 11 => .win 10 (FullWinWitness.standard (.triplet 16) (.sequence 1 1) (.sequence 1 3) (.sequence 2 5) 8)
  | 12 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 12)
  | 13 => .win 11 (FullWinWitness.standard (.triplet 16) (.sequence 1 2) (.sequence 1 3) (.sequence 2 5) 8)
  | 14 => .win 13 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 1 3) (.sequence 2 5) 8)
  | 15 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 4) (.sequence 2 5) 12)
  | 17 => .win 15 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 1 6) (.sequence 2 5) 8)
  | 18 => .win 19 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 0) (.sequence 2 5) 8)
  | 19 => .win 18 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 0) (.sequence 2 5) 8)
  | 20 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 20)
  | 21 => .win 19 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 1) (.sequence 2 5) 8)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 2) (.sequence 2 5) 8)
  | 23 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 3) (.sequence 2 6) 23)
  | 24 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 4) (.sequence 2 6) 8)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 5) (.sequence 2 6) 8)
  | 26 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 26)
  | 27 => .back 7 386 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 28 => .back 7 386 [.swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 29 => .back 7 386 [.swapHonors 2 4, .swapHonors 3 4]
  | 30 => .back 7 386 [.swapHonors 3 4]
  | 31 => .back 7 386 []
  | 32 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 32)
  | 33 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row553 : Row := ⟨553, state553, 553, action553⟩

def state554 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 4 | 9 | 11 | 15 | 16 | 19 | 20 | 22 | 23 | 24 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 5 | 6 | 7 | 8 | 12 | 13 | 17 | 18 | 21 | 25 | 33 => 1
  | 10 => 3
  | 14 | 26 => 2
  | _ => 0

def action554 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 9 379 [.swapSuits 1 2, .reverseSuit 1]
  | 1 => .back 10 382 []
  | 2 => .back 10 385 []
  | 3 => .win 4 (FullWinWitness.standard (.triplet 10) (.sequence 0 3) (.sequence 0 6) (.sequence 1 3) 26)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 10) (.sequence 0 3) (.sequence 0 6) (.sequence 1 3) 26)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 10) (.sequence 0 6) (.sequence 1 3) 26)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 10) (.sequence 0 4) (.sequence 0 6) (.sequence 1 3) 26)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 0 6) (.sequence 1 3) 26)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 0 5) (.sequence 1 3) 26)
  | 9 => .back 0 379 [.swapSuits 1 2, .reverseSuit 1]
  | 10 => .back 2 385 []
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
  | 27 => .back 28 388 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 388 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 388 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 388 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 388 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 388 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row554 : Row := ⟨554, state554, 554, action554⟩

def state555 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 4 | 9 | 10 | 11 | 13 | 14 | 15 | 18 | 20 | 24 | 25 | 27 | 28 | 29 | 30 | 31 => 0
  | 5 | 6 | 7 | 8 | 12 | 16 | 21 | 22 | 26 | 32 | 33 => 1
  | 17 | 23 => 2
  | 19 => 3
  | _ => 0

def action555 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 18 380 [.swapSuits 0 1, .reverseSuit 2]
  | 1 => .back 19 383 [.swapSuits 0 1]
  | 2 => .back 19 387 [.swapSuits 0 1]
  | 3 => .win 4 (FullWinWitness.standard (.triplet 19) (.sequence 0 3) (.sequence 0 6) (.sequence 2 3) 17)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 19) (.sequence 0 3) (.sequence 0 6) (.sequence 2 3) 17)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 19) (.sequence 0 6) (.sequence 2 3) 17)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 19) (.sequence 0 4) (.sequence 0 6) (.sequence 2 3) 17)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 0 6) (.sequence 2 3) 17)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 17)
  | 9 => .back 27 388 [.swapSuits 1 2, .swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 10 => .win 11 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 1) (.sequence 2 3) 17)
  | 11 => .win 10 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 1) (.sequence 2 3) 17)
  | 12 => .win 12 (FullWinWitness.standard (.triplet 12) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 17)
  | 13 => .win 11 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 2) (.sequence 2 3) 17)
  | 14 => .win 13 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 17)
  | 15 => .win 5 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 6) (.sequence 2 3) 5)
  | 16 => .win 16 (FullWinWitness.standard (.triplet 16) (.triplet 19) (.sequence 0 5) (.sequence 2 3) 17)
  | 17 => .win 5 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 6) (.sequence 2 3) 5)
  | 18 => .back 0 380 [.swapSuits 0 1, .reverseSuit 2]
  | 19 => .back 1 383 [.swapSuits 0 1]
  | 20 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 2) 23)
  | 21 => .win 22 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 23 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 23)
  | 24 => .win 22 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 3) (.sequence 2 4) 17)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 3) (.sequence 2 5) 17)
  | 26 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 26)
  | 27 => .back 9 388 [.swapSuits 1 2, .swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 28 => .back 9 388 [.swapSuits 1 2, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 29 => .back 9 388 [.swapSuits 1 2, .swapHonors 2 4, .swapHonors 3 4]
  | 30 => .back 9 388 [.swapSuits 1 2, .swapHonors 3 4]
  | 31 => .back 9 388 [.swapSuits 1 2]
  | 32 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row555 : Row := ⟨555, state555, 555, action555⟩

def state556 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 4 | 9 | 10 | 11 | 13 | 14 | 15 | 18 | 19 | 20 | 24 | 26 | 27 | 28 | 29 | 30 => 0
  | 5 | 6 | 7 | 8 | 12 | 16 | 22 | 23 | 31 | 32 | 33 => 1
  | 17 | 21 => 2
  | 25 => 3
  | _ => 0

def action556 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 26 381 [.swapSuits 0 2, .swapSuits 1 2]
  | 1 => .back 25 384 [.swapSuits 0 2, .swapSuits 1 2]
  | 2 => .back 25 386 [.swapSuits 0 2, .swapSuits 1 2]
  | 3 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 3) (.sequence 0 6) (.sequence 2 3) 17)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 25) (.sequence 0 3) (.sequence 0 6) (.sequence 2 3) 17)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 25) (.sequence 0 6) (.sequence 2 3) 17)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 4) (.sequence 0 6) (.sequence 2 3) 17)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 0 6) (.sequence 2 3) 17)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 9 => .back 18 388 [.swapSuits 1 2, .reverseSuit 2]
  | 10 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 1) (.sequence 2 3) 17)
  | 11 => .win 10 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 1) (.sequence 2 3) 17)
  | 12 => .win 12 (FullWinWitness.standard (.triplet 12) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 13 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 2) (.sequence 2 3) 17)
  | 14 => .win 13 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 17)
  | 15 => .win 5 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 6) (.sequence 2 3) 5)
  | 16 => .win 16 (FullWinWitness.standard (.triplet 16) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 17 => .win 5 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 6) (.sequence 2 3) 5)
  | 18 => .back 9 388 [.swapSuits 1 2, .reverseSuit 2]
  | 19 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 1) (.sequence 2 3) 17)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 1) (.sequence 2 3) 17)
  | 21 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 21)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 2) (.sequence 2 3) 17)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 24 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 4) 21)
  | 25 => .back 2 386 [.swapSuits 0 2, .swapSuits 1 2]
  | 26 => .back 0 381 [.swapSuits 0 2, .swapSuits 1 2]
  | 27 => .back 18 389 [.reverseSuit 2, .swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 3]
  | 28 => .back 18 389 [.reverseSuit 2, .swapHonors 1 3, .swapHonors 2 3]
  | 29 => .back 18 389 [.reverseSuit 2, .swapHonors 2 3]
  | 30 => .back 18 389 [.reverseSuit 2]
  | 31 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row556 : Row := ⟨556, state556, 556, action556⟩

def state557 (t : Tile) : Nat :=
  match t.val with
  | 0 | 5 | 6 | 7 | 8 | 9 | 13 | 18 | 21 | 22 | 26 => 1
  | 1 | 2 | 3 | 4 | 10 | 11 | 12 | 14 | 15 | 16 | 19 | 20 | 24 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 0
  | 17 | 23 => 2
  | 25 => 3
  | _ => 0

def action557 (t : Tile) : Action :=
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
  | 15 => .win 14 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 4) (.sequence 2 3) 17)
  | 16 => .back 27 390 [.swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 17 => .win 0 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 0)
  | 18 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 18)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 20 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 2) 23)
  | 21 => .win 22 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 23 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 23)
  | 24 => .win 17 (FullWinWitness.standard (.triplet 17) (.sequence 0 5) (.sequence 2 3) (.sequence 2 5) 25)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 5) 17)
  | 26 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 26)
  | 27 => .back 16 390 [.swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 28 => .back 16 390 [.swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 29 => .back 16 390 [.swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 30 => .back 16 390 [.swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 31 => .back 16 390 [.swapHonors 4 6, .swapHonors 5 6]
  | 32 => .back 16 390 [.swapHonors 5 6]
  | 33 => .back 16 390 []
  | _ => .win 0 (FullWinWitness.orphans 0)

def row557 : Row := ⟨557, state557, 557, action557⟩

def state558 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 5 | 6 | 9 | 10 | 11 | 15 | 19 | 20 | 21 | 22 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 4 | 7 | 12 | 13 | 17 | 18 | 23 | 24 | 25 | 26 | 33 => 1
  | 8 | 14 => 2
  | 16 => 3
  | _ => 0

def action558 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 9 390 [.swapSuits 0 1, .swapSuits 1 2]
  | 1 => .back 10 333 []
  | 2 => .win 3 (FullWinWitness.standard (.triplet 16) (.sequence 0 2) (.sequence 1 3) (.sequence 2 5) 8)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 16) (.sequence 0 2) (.sequence 1 3) (.sequence 2 5) 8)
  | 4 => .win 4 (FullWinWitness.standard (.triplet 4) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 8)
  | 5 => .win 3 (FullWinWitness.standard (.triplet 16) (.sequence 0 3) (.sequence 1 3) (.sequence 2 5) 8)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 4)
  | 7 => .win 7 (FullWinWitness.standard (.triplet 7) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 8)
  | 8 => .win 4 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 4)
  | 9 => .back 0 390 [.swapSuits 0 1, .swapSuits 1 2]
  | 10 => .back 1 333 []
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
  | 27 => .back 28 391 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 391 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 391 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 391 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 391 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 391 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row558 : Row := ⟨558, state558, 558, action558⟩

def state559 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 15 | 17 | 19 | 20 | 21 | 23 | 24 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 0
  | 1 | 5 | 6 | 7 | 8 | 10 | 12 | 13 | 18 | 22 | 25 => 1
  | 14 | 26 => 2
  | 16 => 3
  | _ => 0

def action559 (t : Tile) : Action :=
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
  | 17 => .back 27 392 [.swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 18 => .win 18 (FullWinWitness.standard (.triplet 16) (.triplet 18) (.sequence 0 5) (.sequence 1 3) 26)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 0) 26)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 0) 26)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 2) 26)
  | 22 => .win 22 (FullWinWitness.standard (.triplet 16) (.triplet 22) (.sequence 0 5) (.sequence 1 3) 26)
  | 23 => .win 21 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 26)
  | 24 => .win 1 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 1)
  | 25 => .win 25 (FullWinWitness.standard (.triplet 16) (.triplet 25) (.sequence 0 5) (.sequence 1 3) 26)
  | 26 => .win 1 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 5) (.sequence 1 3) 1)
  | 27 => .back 17 392 [.swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 28 => .back 17 392 [.swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 29 => .back 17 392 [.swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 30 => .back 17 392 [.swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 31 => .back 17 392 [.swapHonors 4 6, .swapHonors 5 6]
  | 32 => .back 17 392 [.swapHonors 5 6]
  | 33 => .back 17 392 []
  | _ => .win 0 (FullWinWitness.orphans 0)

def row559 : Row := ⟨559, state559, 559, action559⟩

def state560 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 18 | 20 | 24 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 0
  | 1 | 5 | 6 | 7 | 8 | 10 | 13 | 16 | 19 | 21 | 22 => 1
  | 17 | 23 => 2
  | 25 => 3
  | _ => 0

def action560 (t : Tile) : Action :=
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
  | 26 => .back 27 341 [.swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 27 => .back 26 341 [.swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 28 => .back 26 341 [.swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 29 => .back 26 341 [.swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 30 => .back 26 341 [.swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 31 => .back 26 341 [.swapHonors 4 6, .swapHonors 5 6]
  | 32 => .back 26 341 [.swapHonors 5 6]
  | 33 => .back 26 341 []
  | _ => .win 0 (FullWinWitness.orphans 0)

def row560 : Row := ⟨560, state560, 560, action560⟩

def state561 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 5 | 6 | 7 | 9 | 11 | 12 | 13 | 18 | 20 | 24 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 4 | 10 | 14 | 15 | 16 | 17 | 19 | 21 | 22 | 26 | 33 => 1
  | 8 | 23 => 2
  | 25 => 3
  | _ => 0

def action561 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 7 392 [.swapSuits 0 2, .swapSuits 1 2]
  | 1 => .back 7 341 [.swapSuits 0 1]
  | 2 => .win 3 (FullWinWitness.standard (.triplet 25) (.sequence 0 2) (.sequence 1 5) (.sequence 2 3) 8)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 2) (.sequence 1 5) (.sequence 2 3) 8)
  | 4 => .win 4 (FullWinWitness.standard (.triplet 4) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 8)
  | 5 => .win 3 (FullWinWitness.standard (.triplet 25) (.sequence 0 3) (.sequence 1 5) (.sequence 2 3) 8)
  | 6 => .win 5 (FullWinWitness.standard (.triplet 25) (.sequence 0 4) (.sequence 1 5) (.sequence 2 3) 8)
  | 7 => .back 1 341 [.swapSuits 0 1]
  | 8 => .win 4 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 4)
  | 9 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 1 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 10 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 10)
  | 11 => .win 9 (FullWinWitness.standard (.triplet 25) (.sequence 1 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 1 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 25) (.sequence 1 3) (.sequence 1 6) (.sequence 2 3) 8)
  | 14 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 1 6) (.sequence 2 3) 14)
  | 15 => .win 13 (FullWinWitness.standard (.triplet 25) (.sequence 1 4) (.sequence 1 6) (.sequence 2 3) 8)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 1 6) (.sequence 2 3) 8)
  | 17 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 17)
  | 18 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 0) (.sequence 2 3) 8)
  | 19 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 19)
  | 20 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 1 5) (.sequence 2 1) 23)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 1) (.sequence 2 3) 8)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 3) (.sequence 2 3) 8)
  | 23 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 23)
  | 24 => .win 8 (FullWinWitness.standard (.triplet 8) (.sequence 1 5) (.sequence 2 3) (.sequence 2 5) 25)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 3) (.sequence 2 5) 8)
  | 26 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 26)
  | 27 => .back 7 393 [.swapHonors 0 5, .swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | 28 => .back 7 393 [.swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | 29 => .back 7 393 [.swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | 30 => .back 7 393 [.swapHonors 3 5, .swapHonors 4 5]
  | 31 => .back 7 393 [.swapHonors 4 5]
  | 32 => .back 7 393 []
  | 33 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row561 : Row := ⟨561, state561, 561, action561⟩

def state562 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 18 | 20 | 24 | 25 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 13 | 16 | 22 | 23 | 26 => 1
  | 17 | 21 => 2
  | 19 => 3
  | _ => 0

def action562 (t : Tile) : Action :=
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
  | 18 => .back 27 354 [.reverseSuit 2, .swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 19 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 1) (.sequence 2 3) 17)
  | 20 => .win 15 (FullWinWitness.standard (.sequence 0 5) (.sequence 1 6) (.sequence 2 1) (.sequence 2 3) 19)
  | 21 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 21)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 2) (.sequence 2 3) 17)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 24 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 4) 21)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 3) (.sequence 2 6) 17)
  | 26 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 26)
  | 27 => .back 18 354 [.reverseSuit 2, .swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 28 => .back 18 354 [.reverseSuit 2, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 29 => .back 18 354 [.reverseSuit 2, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 30 => .back 18 354 [.reverseSuit 2, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 31 => .back 18 354 [.reverseSuit 2, .swapHonors 4 6, .swapHonors 5 6]
  | 32 => .back 18 354 [.reverseSuit 2, .swapHonors 5 6]
  | 33 => .back 18 354 [.reverseSuit 2]
  | _ => .win 0 (FullWinWitness.orphans 0)

def row562 : Row := ⟨562, state562, 562, action562⟩

def state563 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 16 | 18 | 20 | 24 | 26 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 13 | 19 | 21 | 22 | 33 => 1
  | 17 | 23 => 2
  | 25 => 3
  | _ => 0

def action563 (t : Tile) : Action :=
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
  | 16 => .back 26 355 []
  | 17 => .win 2 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 2)
  | 18 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 19 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 19)
  | 20 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 1) 23)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 1) (.sequence 2 3) 17)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 23 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 23)
  | 24 => .win 17 (FullWinWitness.standard (.triplet 17) (.sequence 0 5) (.sequence 2 3) (.sequence 2 5) 25)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 5) 17)
  | 26 => .back 16 355 []
  | 27 => .back 16 394 [.swapHonors 0 5, .swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | 28 => .back 16 394 [.swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | 29 => .back 16 394 [.swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | 30 => .back 16 394 [.swapHonors 3 5, .swapHonors 4 5]
  | 31 => .back 16 394 [.swapHonors 4 5]
  | 32 => .back 16 394 []
  | 33 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row563 : Row := ⟨563, state563, 563, action563⟩

def state564 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 6 | 7 | 10 | 11 | 12 | 13 | 19 | 20 | 21 | 23 | 24 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 0
  | 1 => 3
  | 3 | 26 => 2
  | 4 | 5 | 8 | 9 | 14 | 15 | 16 | 17 | 18 | 22 | 25 => 1
  | _ => 0

def action564 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 27 390 [.swapSuits 0 2, .swapSuits 1 2, .reverseSuit 0, .swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 1 => .win 2 (FullWinWitness.standard (.triplet 1) (.sequence 0 1) (.sequence 0 3) (.sequence 1 5) 26)
  | 2 => .win 1 (FullWinWitness.standard (.triplet 1) (.sequence 0 1) (.sequence 0 3) (.sequence 1 5) 26)
  | 3 => .win 3 (FullWinWitness.standard (.triplet 1) (.triplet 3) (.sequence 0 3) (.sequence 1 5) 26)
  | 4 => .win 2 (FullWinWitness.standard (.triplet 1) (.sequence 0 2) (.sequence 0 3) (.sequence 1 5) 26)
  | 5 => .win 4 (FullWinWitness.standard (.triplet 1) (.sequence 0 3) (.sequence 0 3) (.sequence 1 5) 26)
  | 6 => .win 3 (FullWinWitness.standard (.triplet 1) (.triplet 3) (.sequence 0 4) (.sequence 1 5) 26)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 1) (.sequence 0 3) (.sequence 0 6) (.sequence 1 5) 26)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 1) (.triplet 8) (.sequence 0 3) (.sequence 1 5) 26)
  | 9 => .win 9 (FullWinWitness.standard (.triplet 1) (.triplet 9) (.sequence 0 3) (.sequence 1 5) 26)
  | 10 => .win 11 (FullWinWitness.standard (.triplet 1) (.sequence 0 3) (.sequence 1 0) (.sequence 1 5) 26)
  | 11 => .win 10 (FullWinWitness.standard (.triplet 1) (.sequence 0 3) (.sequence 1 0) (.sequence 1 5) 26)
  | 12 => .win 13 (FullWinWitness.standard (.triplet 1) (.sequence 0 3) (.sequence 1 3) (.sequence 1 6) 26)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 1) (.sequence 0 3) (.sequence 1 3) (.sequence 1 6) 26)
  | 14 => .win 14 (FullWinWitness.standard (.triplet 1) (.triplet 14) (.sequence 0 3) (.sequence 1 6) 26)
  | 15 => .win 13 (FullWinWitness.standard (.triplet 1) (.sequence 0 3) (.sequence 1 4) (.sequence 1 6) 26)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 1) (.sequence 0 3) (.sequence 1 5) (.sequence 1 6) 26)
  | 17 => .win 17 (FullWinWitness.standard (.triplet 1) (.triplet 17) (.sequence 0 3) (.sequence 1 5) 26)
  | 18 => .win 18 (FullWinWitness.standard (.triplet 1) (.triplet 18) (.sequence 0 3) (.sequence 1 5) 26)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 1) (.sequence 0 3) (.sequence 1 5) (.sequence 2 0) 26)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 1) (.sequence 0 3) (.sequence 1 5) (.sequence 2 0) 26)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 1) (.sequence 0 3) (.sequence 1 5) (.sequence 2 2) 26)
  | 22 => .win 22 (FullWinWitness.standard (.triplet 1) (.triplet 22) (.sequence 0 3) (.sequence 1 5) 26)
  | 23 => .win 21 (FullWinWitness.standard (.triplet 1) (.sequence 0 3) (.sequence 1 5) (.sequence 2 3) 26)
  | 24 => .win 2 (FullWinWitness.standard (.sequence 0 1) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 1)
  | 25 => .win 25 (FullWinWitness.standard (.triplet 1) (.triplet 25) (.sequence 0 3) (.sequence 1 5) 26)
  | 26 => .win 2 (FullWinWitness.standard (.triplet 26) (.sequence 0 1) (.sequence 0 3) (.sequence 1 5) 1)
  | 27 => .back 0 390 [.swapSuits 0 2, .swapSuits 1 2, .reverseSuit 0, .swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 28 => .back 0 390 [.swapSuits 0 2, .swapSuits 1 2, .reverseSuit 0, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 29 => .back 0 390 [.swapSuits 0 2, .swapSuits 1 2, .reverseSuit 0, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 30 => .back 0 390 [.swapSuits 0 2, .swapSuits 1 2, .reverseSuit 0, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 31 => .back 0 390 [.swapSuits 0 2, .swapSuits 1 2, .reverseSuit 0, .swapHonors 4 6, .swapHonors 5 6]
  | 32 => .back 0 390 [.swapSuits 0 2, .swapSuits 1 2, .reverseSuit 0, .swapHonors 5 6]
  | 33 => .back 0 390 [.swapSuits 0 2, .swapSuits 1 2, .reverseSuit 0]
  | _ => .win 0 (FullWinWitness.orphans 0)

def row564 : Row := ⟨564, state564, 564, action564⟩

def state565 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 15 | 17 | 19 | 20 | 21 | 23 | 24 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 12 | 13 | 18 | 22 | 25 => 1
  | 14 | 26 => 2
  | 16 => 3
  | _ => 0

def action565 (t : Tile) : Action :=
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
  | 17 => .back 27 395 [.swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 18 => .win 18 (FullWinWitness.standard (.triplet 16) (.triplet 18) (.sequence 0 5) (.sequence 1 3) 26)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 0) 26)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 0) 26)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 2) 26)
  | 22 => .win 22 (FullWinWitness.standard (.triplet 16) (.triplet 22) (.sequence 0 5) (.sequence 1 3) 26)
  | 23 => .win 21 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 26)
  | 24 => .win 2 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 2)
  | 25 => .win 25 (FullWinWitness.standard (.triplet 16) (.triplet 25) (.sequence 0 5) (.sequence 1 3) 26)
  | 26 => .win 2 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 5) (.sequence 1 3) 2)
  | 27 => .back 17 395 [.swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 28 => .back 17 395 [.swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 29 => .back 17 395 [.swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 30 => .back 17 395 [.swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 31 => .back 17 395 [.swapHonors 4 6, .swapHonors 5 6]
  | 32 => .back 17 395 [.swapHonors 5 6]
  | 33 => .back 17 395 []
  | _ => .win 0 (FullWinWitness.orphans 0)

def row565 : Row := ⟨565, state565, 565, action565⟩

def state566 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 4 | 9 | 10 | 11 | 15 | 19 | 20 | 21 | 23 | 24 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 5 | 6 | 7 | 8 | 12 | 13 | 17 | 18 | 22 | 25 | 33 => 1
  | 14 | 26 => 2
  | 16 => 3
  | _ => 0

def action566 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 9 390 [.swapSuits 1 2]
  | 1 => .back 10 392 []
  | 2 => .back 10 395 []
  | 3 => .win 4 (FullWinWitness.standard (.triplet 16) (.sequence 0 3) (.sequence 0 6) (.sequence 1 3) 26)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 16) (.sequence 0 3) (.sequence 0 6) (.sequence 1 3) 26)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 16) (.sequence 0 6) (.sequence 1 3) 26)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 16) (.sequence 0 4) (.sequence 0 6) (.sequence 1 3) 26)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 0 6) (.sequence 1 3) 26)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 0 5) (.sequence 1 3) 26)
  | 9 => .back 0 390 [.swapSuits 1 2]
  | 10 => .back 2 395 []
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
  | 27 => .back 28 396 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 396 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 396 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 396 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 396 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 396 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row566 : Row := ⟨566, state566, 566, action566⟩

def state567 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 18 | 20 | 24 | 25 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 0
  | 1 | 5 | 6 | 7 | 8 | 10 | 13 | 16 | 22 | 23 | 26 => 1
  | 17 | 21 => 2
  | 19 => 3
  | _ => 0

def action567 (t : Tile) : Action :=
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
  | 18 => .back 27 340 [.reverseSuit 2, .swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 19 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 1) (.sequence 2 3) 17)
  | 20 => .win 15 (FullWinWitness.standard (.sequence 0 5) (.sequence 1 6) (.sequence 2 1) (.sequence 2 3) 19)
  | 21 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 21)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 2) (.sequence 2 3) 17)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 24 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 4) 21)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 2 3) (.sequence 2 6) 17)
  | 26 => .win 15 (FullWinWitness.standard (.triplet 19) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 26)
  | 27 => .back 18 340 [.reverseSuit 2, .swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 28 => .back 18 340 [.reverseSuit 2, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 29 => .back 18 340 [.reverseSuit 2, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 30 => .back 18 340 [.reverseSuit 2, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 31 => .back 18 340 [.reverseSuit 2, .swapHonors 4 6, .swapHonors 5 6]
  | 32 => .back 18 340 [.reverseSuit 2, .swapHonors 5 6]
  | 33 => .back 18 340 [.reverseSuit 2]
  | _ => .win 0 (FullWinWitness.orphans 0)

def row567 : Row := ⟨567, state567, 567, action567⟩

def state568 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 4 | 9 | 10 | 11 | 12 | 14 | 15 | 19 | 20 | 24 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 5 | 6 | 7 | 8 | 13 | 16 | 18 | 21 | 22 | 26 | 33 => 1
  | 17 | 23 => 2
  | 25 => 3
  | _ => 0

def action568 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 9 390 []
  | 1 => .back 10 340 []
  | 2 => .back 10 354 []
  | 3 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 3) (.sequence 0 6) (.sequence 2 3) 17)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 25) (.sequence 0 3) (.sequence 0 6) (.sequence 2 3) 17)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 25) (.sequence 0 6) (.sequence 2 3) 17)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 4) (.sequence 0 6) (.sequence 2 3) 17)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 0 6) (.sequence 2 3) 17)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 9 => .back 0 390 []
  | 10 => .back 2 354 []
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
  | 27 => .back 28 397 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 397 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 397 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 397 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 397 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 397 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row568 : Row := ⟨568, state568, 568, action568⟩

def state569 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 5 | 6 | 7 | 9 | 11 | 15 | 17 | 19 | 20 | 21 | 22 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 1 | 4 | 10 | 12 | 13 | 18 | 23 | 24 | 25 | 26 | 33 => 1
  | 8 | 14 => 2
  | 16 => 3
  | _ => 0

def action569 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 2 (FullWinWitness.standard (.triplet 16) (.sequence 0 0) (.sequence 1 3) (.sequence 2 5) 8)
  | 1 => .win 1 (FullWinWitness.standard (.triplet 1) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 8)
  | 2 => .win 0 (FullWinWitness.standard (.triplet 16) (.sequence 0 0) (.sequence 1 3) (.sequence 2 5) 8)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 16) (.sequence 0 1) (.sequence 1 3) (.sequence 2 5) 8)
  | 4 => .win 4 (FullWinWitness.standard (.triplet 4) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 8)
  | 5 => .win 3 (FullWinWitness.standard (.triplet 16) (.sequence 0 3) (.sequence 1 3) (.sequence 2 5) 8)
  | 6 => .win 5 (FullWinWitness.standard (.triplet 16) (.sequence 0 4) (.sequence 1 3) (.sequence 2 5) 8)
  | 7 => .back 17 333 []
  | 8 => .win 1 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 1)
  | 9 => .win 11 (FullWinWitness.standard (.triplet 16) (.sequence 1 0) (.sequence 1 3) (.sequence 2 5) 8)
  | 10 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 10)
  | 11 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 1) (.sequence 2 5) 14)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 16) (.sequence 1 1) (.sequence 1 3) (.sequence 2 5) 8)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 1 3) (.sequence 2 5) 8)
  | 14 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 14)
  | 15 => .win 8 (FullWinWitness.standard (.triplet 8) (.sequence 1 3) (.sequence 1 5) (.sequence 2 5) 16)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 1 5) (.sequence 2 5) 8)
  | 17 => .back 7 333 []
  | 18 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 18)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 0) (.sequence 2 5) 8)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 0) (.sequence 2 5) 8)
  | 21 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 3) (.sequence 2 6) 8)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 3) (.sequence 2 6) 8)
  | 23 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 3) (.sequence 2 6) 23)
  | 24 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 4) (.sequence 2 6) 8)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 2 5) (.sequence 2 6) 8)
  | 26 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 26)
  | 27 => .back 17 335 [.swapHonors 0 5, .swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | 28 => .back 17 335 [.swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | 29 => .back 17 335 [.swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | 30 => .back 17 335 [.swapHonors 3 5, .swapHonors 4 5]
  | 31 => .back 17 335 [.swapHonors 4 5]
  | 32 => .back 17 335 []
  | 33 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row569 : Row := ⟨569, state569, 569, action569⟩

def state570 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 15 | 17 | 19 | 20 | 21 | 23 | 24 | 25 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 12 | 13 | 18 | 22 | 33 => 1
  | 14 | 26 => 2
  | 16 => 3
  | _ => 0

def action570 (t : Tile) : Action :=
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
  | 17 => .back 25 395 []
  | 18 => .win 18 (FullWinWitness.standard (.triplet 16) (.triplet 18) (.sequence 0 5) (.sequence 1 3) 26)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 0) 26)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 0) 26)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 2) 26)
  | 22 => .win 22 (FullWinWitness.standard (.triplet 16) (.triplet 22) (.sequence 0 5) (.sequence 1 3) 26)
  | 23 => .win 21 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 26)
  | 24 => .win 23 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 4) 26)
  | 25 => .back 17 395 []
  | 26 => .win 2 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 5) (.sequence 1 3) 2)
  | 27 => .back 25 398 [.swapHonors 0 5, .swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | 28 => .back 25 398 [.swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | 29 => .back 25 398 [.swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | 30 => .back 25 398 [.swapHonors 3 5, .swapHonors 4 5]
  | 31 => .back 25 398 [.swapHonors 4 5]
  | 32 => .back 25 398 []
  | 33 => .win 26 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 5) (.sequence 1 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row570 : Row := ⟨570, state570, 570, action570⟩

def state571 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 4 | 9 | 10 | 11 | 12 | 14 | 15 | 18 | 20 | 24 | 26 | 27 | 28 | 29 | 30 | 31 => 0
  | 5 | 6 | 7 | 8 | 13 | 16 | 19 | 21 | 22 | 32 | 33 => 1
  | 17 | 23 => 2
  | 25 => 3
  | _ => 0

def action571 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 10 399 [.swapSuits 0 2, .swapSuits 1 2]
  | 1 => .back 26 393 [.swapSuits 0 1]
  | 2 => .back 10 394 []
  | 3 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 3) (.sequence 0 6) (.sequence 2 3) 17)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 25) (.sequence 0 3) (.sequence 0 6) (.sequence 2 3) 17)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 25) (.sequence 0 6) (.sequence 2 3) 17)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 4) (.sequence 0 6) (.sequence 2 3) 17)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 0 6) (.sequence 2 3) 17)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 9 => .back 2 398 [.swapSuits 1 2]
  | 10 => .back 2 394 []
  | 11 => .win 12 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 2) (.sequence 2 3) 17)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 2) (.sequence 2 3) 17)
  | 13 => .win 13 (FullWinWitness.standard (.triplet 13) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 14 => .win 12 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 17)
  | 15 => .win 5 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 6) (.sequence 2 3) 5)
  | 16 => .win 16 (FullWinWitness.standard (.triplet 16) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 17 => .win 5 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 6) (.sequence 2 3) 5)
  | 18 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 19 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 19)
  | 20 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 1) 23)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 1) (.sequence 2 3) 17)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 23 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 23)
  | 24 => .win 15 (FullWinWitness.standard (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) (.sequence 2 5) 25)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 5) 17)
  | 26 => .back 1 393 [.swapSuits 0 1]
  | 27 => .back 2 400 [.swapSuits 0 1, .swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 28 => .back 2 400 [.swapSuits 0 1, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 29 => .back 2 400 [.swapSuits 0 1, .swapHonors 2 4, .swapHonors 3 4]
  | 30 => .back 2 400 [.swapSuits 0 1, .swapHonors 3 4]
  | 31 => .back 2 400 [.swapSuits 0 1]
  | 32 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row571 : Row := ⟨571, state571, 571, action571⟩

def state572 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 15 | 16 | 19 | 20 | 21 | 22 | 24 | 25 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 2 | 5 | 6 | 7 | 8 | 11 | 12 | 13 | 14 | 17 | 18 | 23 | 33 => 1
  | 10 => 3
  | 26 => 2
  | _ => 0

def action572 (t : Tile) : Action :=
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
  | 27 => .back 28 401 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 401 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 401 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 401 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 401 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 401 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 26 (FullWinWitness.standard (.triplet 10) (.triplet 26) (.sequence 0 5) (.sequence 1 2) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row572 : Row := ⟨572, state572, 572, action572⟩

def state573 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 13 | 15 | 16 | 18 | 24 | 25 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 14 | 20 | 21 | 22 | 23 | 26 | 33 => 1
  | 17 => 2
  | 19 => 3
  | _ => 0

def action573 (t : Tile) : Action :=
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
  | 27 => .back 28 402 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 402 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 402 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 402 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 402 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 402 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 19) (.sequence 0 5) (.sequence 2 2) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row573 : Row := ⟨573, state573, 573, action573⟩

def state574 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 6 | 7 | 9 | 15 | 16 | 19 | 20 | 21 | 22 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 2 | 5 | 11 | 12 | 13 | 14 | 17 | 18 | 23 | 24 | 25 | 26 | 33 => 1
  | 8 => 2
  | 10 => 3
  | _ => 0

def action574 (t : Tile) : Action :=
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
  | 27 => .back 28 403 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 403 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 403 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 403 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 403 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 403 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 1 2) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row574 : Row := ⟨574, state574, 574, action574⟩

def state575 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 6 | 7 | 9 | 11 | 12 | 13 | 18 | 24 | 25 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 1 | 5 | 10 | 14 | 15 | 16 | 17 | 20 | 21 | 22 | 23 | 26 | 33 => 1
  | 8 => 2
  | 19 => 3
  | _ => 0

def action575 (t : Tile) : Action :=
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
  | 27 => .back 28 404 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 404 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 404 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 404 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 404 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 404 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 19) (.sequence 1 5) (.sequence 2 2) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row575 : Row := ⟨575, state575, 575, action575⟩

end Mahjong.Scale12V2
