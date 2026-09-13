import MahjongScale.Actual12V2.Base

set_option maxRecDepth 32768
set_option maxHeartbeats 100000000

namespace Mahjong.Scale12V2
open ResponseTable ResponseCertificate Generators

def state320 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 15 | 16 | 19 | 20 | 22 | 23 | 25 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 2 | 5 | 6 | 7 | 8 | 12 | 14 | 17 | 18 | 21 | 24 | 33 => 1
  | 10 => 4
  | 13 | 26 => 2
  | _ => 0

def action320 (t : Tile) : Action :=
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
  | 24 => .win 24 (FullWinWitness.standard (.triplet 10) (.triplet 24) (.sequence 0 5) (.sequence 1 3) 26)
  | 25 => .win 2 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 2)
  | 26 => .win 2 (FullWinWitness.standard (.triplet 10) (.triplet 26) (.sequence 0 5) (.sequence 1 3) 2)
  | 27 => .back 28 178 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 178 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 178 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 178 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 178 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 178 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 25 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row320 : Row := ⟨320, state320, 320, action320⟩

def state321 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 15 | 17 | 19 | 20 | 22 | 23 | 25 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 12 | 14 | 18 | 21 | 24 | 33 => 1
  | 13 | 26 => 2
  | 16 => 4
  | _ => 0

def action321 (t : Tile) : Action :=
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
  | 24 => .win 24 (FullWinWitness.standard (.triplet 16) (.triplet 24) (.sequence 0 5) (.sequence 1 3) 26)
  | 25 => .win 2 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 2)
  | 26 => .win 2 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 5) (.sequence 1 3) 2)
  | 27 => .back 28 179 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 179 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 179 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 179 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 179 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 179 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row321 : Row := ⟨321, state321, 321, action321⟩

def state322 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 15 | 19 | 20 | 22 | 23 | 25 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 12 | 14 | 17 | 18 | 21 | 24 | 33 => 1
  | 13 | 26 => 2
  | 16 => 3
  | _ => 0

def action322 (t : Tile) : Action :=
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
  | 24 => .win 24 (FullWinWitness.standard (.triplet 16) (.triplet 24) (.sequence 0 5) (.sequence 1 3) 26)
  | 25 => .win 2 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 2)
  | 26 => .win 2 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 5) (.sequence 1 3) 2)
  | 27 => .back 28 180 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 180 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 180 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 180 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 180 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 180 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row322 : Row := ⟨322, state322, 322, action322⟩

def state323 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 6 | 8 | 9 | 10 | 12 | 13 | 19 | 20 | 22 | 23 | 25 | 27 | 28 | 29 | 30 | 31 => 0
  | 3 | 5 | 11 | 14 | 15 | 16 | 17 | 18 | 21 | 24 | 32 | 33 => 1
  | 4 | 26 => 2
  | 7 => 4
  | _ => 0

def action323 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 27 178 [.swapSuits 0 1, .reverseSuit 0, .swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 1 => .back 27 179 [.swapSuits 0 1, .swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
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
  | 24 => .win 24 (FullWinWitness.standard (.triplet 7) (.triplet 24) (.sequence 0 3) (.sequence 1 5) 26)
  | 25 => .win 4 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 4)
  | 26 => .win 4 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 4)
  | 27 => .back 1 179 [.swapSuits 0 1, .swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 28 => .back 1 179 [.swapSuits 0 1, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 29 => .back 1 179 [.swapSuits 0 1, .swapHonors 2 4, .swapHonors 3 4]
  | 30 => .back 1 179 [.swapSuits 0 1, .swapHonors 3 4]
  | 31 => .back 1 179 [.swapSuits 0 1]
  | 32 => .win 25 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 32)
  | 33 => .win 25 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row323 : Row := ⟨323, state323, 323, action323⟩

def state324 (t : Tile) : Nat :=
  match t.val with
  | 0 | 5 | 6 | 7 | 8 | 9 | 12 | 15 | 18 | 22 | 23 | 26 | 33 => 1
  | 1 | 2 | 3 | 4 | 10 | 11 | 13 | 14 | 16 | 19 | 20 | 24 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 17 | 21 => 2
  | 25 => 3
  | _ => 0

def action324 (t : Tile) : Action :=
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
  | 15 => .win 15 (FullWinWitness.standard (.triplet 15) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 16 => .win 0 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 0)
  | 17 => .win 0 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 0)
  | 18 => .win 16 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 18)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 21 => .win 16 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 21)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 2) (.sequence 2 3) 17)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 24 => .win 16 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 4) 21)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 6) 17)
  | 26 => .win 16 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 26)
  | 27 => .back 28 181 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 181 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 181 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 181 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 181 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 181 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 16 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row324 : Row := ⟨324, state324, 324, action324⟩

def state325 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 15 | 16 | 19 | 20 | 22 | 23 | 25 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 2 | 5 | 6 | 7 | 8 | 12 | 13 | 17 | 18 | 21 | 24 | 33 => 1
  | 10 => 4
  | 14 | 26 => 2
  | _ => 0

def action325 (t : Tile) : Action :=
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
  | 24 => .win 24 (FullWinWitness.standard (.triplet 10) (.triplet 24) (.sequence 0 5) (.sequence 1 3) 26)
  | 25 => .win 2 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 2)
  | 26 => .win 2 (FullWinWitness.standard (.triplet 10) (.triplet 26) (.sequence 0 5) (.sequence 1 3) 2)
  | 27 => .back 28 182 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 182 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 182 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 182 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 182 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 182 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 25 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row325 : Row := ⟨325, state325, 325, action325⟩

def state326 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 4 | 9 | 11 | 15 | 16 | 19 | 20 | 22 | 23 | 25 | 27 | 28 | 29 | 30 => 0
  | 5 | 6 | 7 | 8 | 12 | 13 | 17 | 18 | 21 | 24 | 31 | 32 | 33 => 1
  | 10 => 3
  | 14 | 26 => 2
  | _ => 0

def action326 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 9 181 [.swapSuits 1 2, .reverseSuit 1]
  | 1 => .back 10 176 []
  | 2 => .back 10 182 []
  | 3 => .win 4 (FullWinWitness.standard (.triplet 10) (.sequence 0 3) (.sequence 0 6) (.sequence 1 3) 26)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 10) (.sequence 0 3) (.sequence 0 6) (.sequence 1 3) 26)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 10) (.sequence 0 6) (.sequence 1 3) 26)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 10) (.sequence 0 4) (.sequence 0 6) (.sequence 1 3) 26)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 0 6) (.sequence 1 3) 26)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 0 5) (.sequence 1 3) 26)
  | 9 => .back 0 181 [.swapSuits 1 2, .reverseSuit 1]
  | 10 => .back 2 182 []
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
  | 24 => .win 24 (FullWinWitness.standard (.triplet 10) (.triplet 24) (.sequence 0 5) (.sequence 1 3) 26)
  | 25 => .win 5 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 6) 5)
  | 26 => .win 5 (FullWinWitness.standard (.triplet 10) (.triplet 26) (.sequence 0 6) (.sequence 1 3) 5)
  | 27 => .back 28 183 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 183 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 183 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 183 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 25 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 25 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 25 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row326 : Row := ⟨326, state326, 326, action326⟩

def state327 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 6 | 8 | 10 | 11 | 12 | 13 | 19 | 20 | 22 | 23 | 25 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 1 | 3 | 5 | 9 | 14 | 15 | 16 | 17 | 18 | 21 | 24 | 33 => 1
  | 4 | 26 => 2
  | 7 => 4
  | _ => 0

def action327 (t : Tile) : Action :=
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
  | 24 => .win 24 (FullWinWitness.standard (.triplet 7) (.triplet 24) (.sequence 0 3) (.sequence 1 5) 26)
  | 25 => .win 1 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 1)
  | 26 => .win 1 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 1)
  | 27 => .back 28 184 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 184 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 184 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 184 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 184 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 184 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 25 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row327 : Row := ⟨327, state327, 327, action327⟩

def state328 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 6 | 8 | 10 | 11 | 12 | 13 | 19 | 20 | 22 | 23 | 25 | 27 | 28 | 29 | 30 | 31 => 0
  | 1 | 3 | 4 | 5 | 9 | 14 | 15 | 16 | 17 | 18 | 21 | 24 | 32 | 33 => 1
  | 7 => 4
  | 26 => 2
  | _ => 0

def action328 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 2 (FullWinWitness.standard (.triplet 7) (.sequence 0 0) (.sequence 0 3) (.sequence 1 5) 26)
  | 1 => .win 1 (FullWinWitness.standard (.triplet 1) (.triplet 7) (.sequence 0 3) (.sequence 1 5) 26)
  | 2 => .win 0 (FullWinWitness.standard (.triplet 7) (.sequence 0 0) (.sequence 0 3) (.sequence 1 5) 26)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 7) (.sequence 0 1) (.sequence 0 3) (.sequence 1 5) 26)
  | 4 => .back 27 184 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 5 => .win 6 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 0 5) (.sequence 1 5) 26)
  | 6 => .win 2 (FullWinWitness.standard (.triplet 7) (.sequence 0 1) (.sequence 0 4) (.sequence 1 5) 26)
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
  | 24 => .win 24 (FullWinWitness.standard (.triplet 7) (.triplet 24) (.sequence 0 3) (.sequence 1 5) 26)
  | 25 => .win 1 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 1)
  | 26 => .win 1 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 1)
  | 27 => .back 4 184 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 28 => .back 4 184 [.swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 29 => .back 4 184 [.swapHonors 2 4, .swapHonors 3 4]
  | 30 => .back 4 184 [.swapHonors 3 4]
  | 31 => .back 4 184 []
  | 32 => .win 25 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 32)
  | 33 => .win 25 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row328 : Row := ⟨328, state328, 328, action328⟩

def state329 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 6 | 10 | 11 | 12 | 13 | 19 | 20 | 22 | 23 | 25 | 27 | 28 | 29 | 30 | 31 => 0
  | 2 | 3 | 4 | 5 | 8 | 9 | 14 | 15 | 16 | 17 | 18 | 21 | 24 | 32 | 33 => 1
  | 7 => 3
  | 26 => 2
  | _ => 0

def action329 (t : Tile) : Action :=
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
  | 24 => .win 24 (FullWinWitness.standard (.triplet 7) (.triplet 24) (.sequence 0 2) (.sequence 1 5) 26)
  | 25 => .win 2 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 2)
  | 26 => .win 2 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 2)
  | 27 => .back 28 185 [.swapHonors 0 4, .swapHonors 1 3, .swapHonors 2 4]
  | 28 => .back 27 185 [.swapHonors 0 3, .swapHonors 1 4, .swapHonors 2 3, .swapHonors 3 4]
  | 29 => .back 27 185 [.swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 4]
  | 30 => .back 27 185 [.swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 3, .swapHonors 3 4]
  | 31 => .back 27 185 [.swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 3]
  | 32 => .win 25 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 5) (.sequence 2 6) 32)
  | 33 => .win 25 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 5) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row329 : Row := ⟨329, state329, 329, action329⟩

def state330 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 6 | 8 | 9 | 10 | 12 | 13 | 19 | 20 | 22 | 23 | 25 | 27 | 28 | 29 | 30 | 31 => 0
  | 3 | 26 => 2
  | 4 | 5 | 11 | 14 | 15 | 16 | 17 | 18 | 21 | 24 | 32 | 33 => 1
  | 7 => 4
  | _ => 0

def action330 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 27 182 [.swapSuits 0 1, .reverseSuit 0, .swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
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
  | 18 => .win 18 (FullWinWitness.standard (.triplet 7) (.triplet 18) (.sequence 0 3) (.sequence 1 5) 26)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 0) 26)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 0) 26)
  | 21 => .win 21 (FullWinWitness.standard (.triplet 7) (.triplet 21) (.sequence 0 3) (.sequence 1 5) 26)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 2) 26)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 3) 26)
  | 24 => .win 24 (FullWinWitness.standard (.triplet 7) (.triplet 24) (.sequence 0 3) (.sequence 1 5) 26)
  | 25 => .win 3 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 3)
  | 26 => .win 3 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 3)
  | 27 => .back 0 182 [.swapSuits 0 1, .reverseSuit 0, .swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 28 => .back 0 182 [.swapSuits 0 1, .reverseSuit 0, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 29 => .back 0 182 [.swapSuits 0 1, .reverseSuit 0, .swapHonors 2 4, .swapHonors 3 4]
  | 30 => .back 0 182 [.swapSuits 0 1, .reverseSuit 0, .swapHonors 3 4]
  | 31 => .back 0 182 [.swapSuits 0 1, .reverseSuit 0]
  | 32 => .win 25 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 32)
  | 33 => .win 25 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row330 : Row := ⟨330, state330, 330, action330⟩

def state331 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 6 | 10 | 11 | 12 | 13 | 19 | 20 | 22 | 23 | 25 | 27 | 28 | 29 | 30 | 31 => 0
  | 3 | 26 => 2
  | 4 | 5 | 8 | 9 | 14 | 15 | 16 | 17 | 18 | 21 | 24 | 32 | 33 => 1
  | 7 => 3
  | _ => 0

def action331 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 27 181 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 1 => .win 2 (FullWinWitness.standard (.triplet 7) (.sequence 0 1) (.sequence 0 3) (.sequence 1 5) 26)
  | 2 => .win 1 (FullWinWitness.standard (.triplet 7) (.sequence 0 1) (.sequence 0 3) (.sequence 1 5) 26)
  | 3 => .win 3 (FullWinWitness.standard (.triplet 3) (.triplet 7) (.sequence 0 3) (.sequence 1 5) 26)
  | 4 => .win 2 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 0 3) (.sequence 1 5) 26)
  | 5 => .win 4 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 0 3) (.sequence 1 5) 26)
  | 6 => .win 3 (FullWinWitness.standard (.triplet 3) (.triplet 7) (.sequence 0 4) (.sequence 1 5) 26)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 0 6) (.sequence 1 5) 26)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 7) (.triplet 8) (.sequence 0 3) (.sequence 1 5) 26)
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
  | 24 => .win 24 (FullWinWitness.standard (.triplet 7) (.triplet 24) (.sequence 0 3) (.sequence 1 5) 26)
  | 25 => .win 3 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 3)
  | 26 => .win 3 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 3)
  | 27 => .back 0 181 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 28 => .back 0 181 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 29 => .back 0 181 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 2 4, .swapHonors 3 4]
  | 30 => .back 0 181 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 3 4]
  | 31 => .back 0 181 [.swapSuits 0 2, .swapSuits 1 2]
  | 32 => .win 25 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 32)
  | 33 => .win 25 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row331 : Row := ⟨331, state331, 331, action331⟩

def state332 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 5 | 7 | 10 | 11 | 12 | 13 | 19 | 20 | 24 | 27 | 28 | 29 | 30 | 31 => 0
  | 1 | 6 | 9 | 14 | 15 | 16 | 17 | 18 | 21 | 22 | 26 | 32 | 33 => 1
  | 8 | 23 => 2
  | 25 => 3
  | _ => 0

def action332 (t : Tile) : Action :=
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
  | 20 => .win 7 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 23)
  | 21 => .win 22 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 3) (.sequence 2 3) 8)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 3) (.sequence 2 3) 8)
  | 23 => .win 7 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 23)
  | 24 => .win 7 (FullWinWitness.standard (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) (.sequence 2 5) 25)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 3) (.sequence 2 5) 8)
  | 26 => .win 7 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 26)
  | 27 => .back 28 186 [.swapHonors 0 4, .swapHonors 1 3, .swapHonors 2 4]
  | 28 => .back 27 186 [.swapHonors 0 3, .swapHonors 1 4, .swapHonors 2 3, .swapHonors 3 4]
  | 29 => .back 27 186 [.swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 4]
  | 30 => .back 27 186 [.swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 3, .swapHonors 3 4]
  | 31 => .back 27 186 [.swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 3]
  | 32 => .win 7 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 32)
  | 33 => .win 7 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row332 : Row := ⟨332, state332, 332, action332⟩

def state333 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 5 | 6 | 9 | 11 | 15 | 19 | 20 | 21 | 22 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 1 | 4 | 7 | 10 | 12 | 13 | 17 | 18 | 23 | 24 | 25 | 26 | 33 => 1
  | 8 | 14 => 2
  | 16 => 3
  | _ => 0

def action333 (t : Tile) : Action :=
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
  | 27 => .back 28 187 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 187 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 187 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 187 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 187 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 187 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row333 : Row := ⟨333, state333, 333, action333⟩

def state334 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 6 | 7 | 10 | 11 | 12 | 13 | 19 | 20 | 24 | 27 | 28 | 29 | 30 | 31 => 0
  | 1 | 5 | 9 | 14 | 15 | 16 | 17 | 18 | 21 | 22 | 26 | 32 | 33 => 1
  | 8 | 23 => 2
  | 25 => 3
  | _ => 0

def action334 (t : Tile) : Action :=
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
  | 20 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 1 5) (.sequence 2 2) 23)
  | 21 => .win 22 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 3) (.sequence 2 3) 8)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 3) (.sequence 2 3) 8)
  | 23 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 23)
  | 24 => .win 8 (FullWinWitness.standard (.triplet 8) (.sequence 1 5) (.sequence 2 3) (.sequence 2 5) 25)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 3) (.sequence 2 5) 8)
  | 26 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 26)
  | 27 => .back 28 188 [.swapHonors 0 4, .swapHonors 1 3, .swapHonors 2 4]
  | 28 => .back 27 188 [.swapHonors 0 3, .swapHonors 1 4, .swapHonors 2 3, .swapHonors 3 4]
  | 29 => .back 27 188 [.swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 4]
  | 30 => .back 27 188 [.swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 3, .swapHonors 3 4]
  | 31 => .back 27 188 [.swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 3]
  | 32 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 32)
  | 33 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row334 : Row := ⟨334, state334, 334, action334⟩

def state335 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 5 | 6 | 7 | 9 | 11 | 15 | 19 | 20 | 21 | 22 | 27 | 28 | 29 | 30 | 31 => 0
  | 1 | 4 | 10 | 12 | 13 | 17 | 18 | 23 | 24 | 25 | 26 | 32 | 33 => 1
  | 8 | 14 => 2
  | 16 => 3
  | _ => 0

def action335 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 2 (FullWinWitness.standard (.triplet 16) (.sequence 0 0) (.sequence 1 3) (.sequence 2 5) 8)
  | 1 => .win 1 (FullWinWitness.standard (.triplet 1) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 8)
  | 2 => .win 0 (FullWinWitness.standard (.triplet 16) (.sequence 0 0) (.sequence 1 3) (.sequence 2 5) 8)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 16) (.sequence 0 1) (.sequence 1 3) (.sequence 2 5) 8)
  | 4 => .win 4 (FullWinWitness.standard (.triplet 4) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 8)
  | 5 => .win 3 (FullWinWitness.standard (.triplet 16) (.sequence 0 3) (.sequence 1 3) (.sequence 2 5) 8)
  | 6 => .win 5 (FullWinWitness.standard (.triplet 16) (.sequence 0 4) (.sequence 1 3) (.sequence 2 5) 8)
  | 7 => .back 27 187 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 8 => .win 1 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 1)
  | 9 => .win 11 (FullWinWitness.standard (.triplet 16) (.sequence 1 0) (.sequence 1 3) (.sequence 2 5) 8)
  | 10 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 10)
  | 11 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 1) (.sequence 2 5) 14)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 16) (.sequence 1 1) (.sequence 1 3) (.sequence 2 5) 8)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 1 3) (.sequence 2 5) 8)
  | 14 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 14)
  | 15 => .win 8 (FullWinWitness.standard (.triplet 8) (.sequence 1 3) (.sequence 1 5) (.sequence 2 5) 16)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 1 5) (.sequence 2 5) 8)
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
  | 27 => .back 7 187 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 28 => .back 7 187 [.swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 29 => .back 7 187 [.swapHonors 2 4, .swapHonors 3 4]
  | 30 => .back 7 187 [.swapHonors 3 4]
  | 31 => .back 7 187 []
  | 32 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 32)
  | 33 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row335 : Row := ⟨335, state335, 335, action335⟩

def state336 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 5 | 6 | 9 | 11 | 15 | 19 | 20 | 21 | 22 | 27 | 28 | 29 | 30 | 31 => 0
  | 1 | 7 | 10 | 12 | 13 | 17 | 18 | 23 | 24 | 25 | 26 | 32 | 33 => 1
  | 8 | 14 => 2
  | 16 => 3
  | _ => 0

def action336 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 2 (FullWinWitness.standard (.triplet 16) (.sequence 0 0) (.sequence 1 3) (.sequence 2 5) 8)
  | 1 => .win 1 (FullWinWitness.standard (.triplet 1) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 8)
  | 2 => .win 0 (FullWinWitness.standard (.triplet 16) (.sequence 0 0) (.sequence 1 3) (.sequence 2 5) 8)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 16) (.sequence 0 1) (.sequence 1 3) (.sequence 2 5) 8)
  | 4 => .back 27 187 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 5 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 5) 8)
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
  | 27 => .back 4 187 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 28 => .back 4 187 [.swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 29 => .back 4 187 [.swapHonors 2 4, .swapHonors 3 4]
  | 30 => .back 4 187 [.swapHonors 3 4]
  | 31 => .back 4 187 []
  | 32 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row336 : Row := ⟨336, state336, 336, action336⟩

def state337 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 6 | 9 | 11 | 12 | 13 | 14 | 15 | 16 | 19 | 20 | 21 | 22 | 27 | 28 | 29 => 0
  | 3 | 4 | 8 | 10 | 18 | 23 | 24 | 25 | 26 | 30 | 31 | 32 | 33 => 1
  | 5 | 17 => 2
  | 7 => 3
  | _ => 0

def action337 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 15 186 [.swapSuits 0 2, .swapSuits 1 2]
  | 1 => .back 16 189 [.swapSuits 0 1]
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
  | 13 => .back 1 190 [.swapSuits 0 1]
  | 14 => .back 0 188 [.swapSuits 0 2, .swapSuits 1 2]
  | 15 => .back 0 186 [.swapSuits 0 2, .swapSuits 1 2]
  | 16 => .back 1 189 [.swapSuits 0 1]
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
  | 27 => .back 28 191 [.swapHonors 0 2]
  | 28 => .back 27 191 [.swapHonors 0 1, .swapHonors 1 2]
  | 29 => .back 27 191 [.swapHonors 0 1]
  | 30 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 3) (.sequence 2 5) 30)
  | 31 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 3) (.sequence 2 5) 31)
  | 32 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 3) (.sequence 2 5) 32)
  | 33 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 3) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row337 : Row := ⟨337, state337, 337, action337⟩

def state338 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 19 | 20 | 24 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 1 | 5 | 6 | 7 | 8 | 10 | 13 | 16 | 18 | 21 | 23 | 26 | 33 => 1
  | 17 | 22 => 2
  | 25 => 3
  | _ => 0

def action338 (t : Tile) : Action :=
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
  | 27 => .back 28 192 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 192 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 192 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 192 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 192 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 192 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row338 : Row := ⟨338, state338, 338, action338⟩

def state339 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 5 | 6 | 9 | 11 | 12 | 13 | 19 | 20 | 24 | 27 | 28 | 29 | 30 | 31 => 0
  | 1 | 7 | 10 | 14 | 15 | 16 | 17 | 18 | 22 | 23 | 26 | 32 | 33 => 1
  | 8 | 21 => 2
  | 25 => 3
  | _ => 0

def action339 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 1 => .win 1 (FullWinWitness.standard (.triplet 1) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 8)
  | 2 => .win 0 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 4 => .back 27 193 [.swapSuits 0 1, .swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
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
  | 27 => .back 28 194 [.swapHonors 0 4, .swapHonors 1 3, .swapHonors 2 4]
  | 28 => .back 27 194 [.swapHonors 0 3, .swapHonors 1 4, .swapHonors 2 3, .swapHonors 3 4]
  | 29 => .back 27 194 [.swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 4]
  | 30 => .back 27 194 [.swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 3, .swapHonors 3 4]
  | 31 => .back 27 194 [.swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 3]
  | 32 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row339 : Row := ⟨339, state339, 339, action339⟩

def state340 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 19 | 20 | 24 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 1 | 5 | 6 | 7 | 8 | 10 | 13 | 16 | 18 | 21 | 22 | 26 | 33 => 1
  | 17 | 23 => 2
  | 25 => 3
  | _ => 0

def action340 (t : Tile) : Action :=
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
  | 27 => .back 28 195 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 195 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 195 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 195 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 195 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 195 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row340 : Row := ⟨340, state340, 340, action340⟩

def state341 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 18 | 20 | 24 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 1 | 5 | 6 | 7 | 8 | 10 | 13 | 16 | 19 | 21 | 22 | 26 | 33 => 1
  | 17 | 23 => 2
  | 25 => 3
  | _ => 0

def action341 (t : Tile) : Action :=
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
  | 27 => .back 28 196 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 196 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 196 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 196 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 196 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 196 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row341 : Row := ⟨341, state341, 341, action341⟩

def state342 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 18 | 20 | 24 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 1 | 5 | 6 | 7 | 8 | 10 | 13 | 16 | 19 | 21 | 23 | 26 | 33 => 1
  | 17 | 22 => 2
  | 25 => 3
  | _ => 0

def action342 (t : Tile) : Action :=
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
  | 27 => .back 28 197 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 197 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 197 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 197 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 197 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 197 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row342 : Row := ⟨342, state342, 342, action342⟩

def state343 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 5 | 6 | 9 | 11 | 12 | 13 | 18 | 20 | 24 | 27 | 28 | 29 | 30 => 0
  | 1 | 7 | 10 | 14 | 15 | 16 | 17 | 19 | 21 | 22 | 23 | 26 | 31 | 32 | 33 => 1
  | 8 => 2
  | 25 => 3
  | _ => 0

def action343 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 1 => .win 1 (FullWinWitness.standard (.triplet 1) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 8)
  | 2 => .win 0 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 4 => .back 22 197 [.swapSuits 0 1]
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
  | 22 => .back 4 197 [.swapSuits 0 1]
  | 23 => .back 4 196 [.swapSuits 0 1]
  | 24 => .win 6 (FullWinWitness.standard (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) (.sequence 2 6) 25)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 3) (.sequence 2 6) 8)
  | 26 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 26)
  | 27 => .back 28 198 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 198 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 198 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 198 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row343 : Row := ⟨343, state343, 343, action343⟩

def state344 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 6 | 9 | 11 | 12 | 13 | 14 | 16 | 18 | 20 | 21 | 22 | 27 | 28 | 29 | 30 => 0
  | 2 | 3 | 4 | 5 | 8 | 10 | 15 | 19 | 23 | 24 | 25 | 26 | 31 | 32 | 33 => 1
  | 7 => 3
  | 17 => 2
  | _ => 0

def action344 (t : Tile) : Action :=
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
  | 27 => .back 28 199 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 199 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 199 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 199 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 16 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 6) (.sequence 2 5) 31)
  | 32 => .win 16 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 6) (.sequence 2 5) 32)
  | 33 => .win 16 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 6) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row344 : Row := ⟨344, state344, 344, action344⟩

def state345 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 19 | 20 | 24 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 1 | 5 | 6 | 7 | 8 | 10 | 13 | 16 | 18 | 22 | 23 | 26 | 33 => 1
  | 17 | 21 => 2
  | 25 => 3
  | _ => 0

def action345 (t : Tile) : Action :=
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
  | 27 => .back 28 193 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 193 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 193 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 193 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 193 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 193 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row345 : Row := ⟨345, state345, 345, action345⟩

def state346 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 6 | 9 | 11 | 12 | 13 | 18 | 20 | 21 | 23 | 24 | 25 | 27 | 28 | 29 | 30 => 0
  | 3 | 5 | 8 | 10 | 14 | 15 | 16 | 17 | 19 | 22 | 31 | 32 | 33 => 1
  | 4 | 26 => 2
  | 7 => 3
  | _ => 0

def action346 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 25 192 [.swapSuits 0 2, .swapSuits 1 2]
  | 1 => .back 25 197 [.swapSuits 0 2, .swapSuits 1 2]
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
  | 25 => .back 1 197 [.swapSuits 0 2, .swapSuits 1 2]
  | 26 => .win 4 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 4)
  | 27 => .back 28 200 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 200 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 200 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 200 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 26 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 31)
  | 32 => .win 26 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 32)
  | 33 => .win 26 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row346 : Row := ⟨346, state346, 346, action346⟩

def state347 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 6 | 9 | 11 | 12 | 13 | 14 | 15 | 18 | 20 | 21 | 22 | 27 | 28 | 29 | 30 => 0
  | 3 | 4 | 8 | 10 | 16 | 19 | 23 | 24 | 25 | 26 | 31 | 32 | 33 => 1
  | 5 | 17 => 2
  | 7 => 3
  | _ => 0

def action347 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 13 195 [.swapSuits 0 2]
  | 1 => .back 13 196 [.swapSuits 0 2]
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
  | 13 => .back 0 195 [.swapSuits 0 2]
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
  | 27 => .back 28 201 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 201 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 201 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 201 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 15 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 6) (.sequence 2 5) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 6) (.sequence 2 5) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 6) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row347 : Row := ⟨347, state347, 347, action347⟩

def state348 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 6 | 9 | 11 | 12 | 13 | 15 | 16 | 18 | 20 | 21 | 22 | 27 | 28 | 29 | 30 => 0
  | 2 | 3 | 4 | 5 | 8 | 10 | 14 | 19 | 23 | 24 | 25 | 26 | 31 | 32 | 33 => 1
  | 7 => 3
  | 17 => 2
  | _ => 0

def action348 (t : Tile) : Action :=
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
  | 27 => .back 28 202 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 202 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 202 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 202 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 2) (.sequence 2 5) 31)
  | 32 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 2) (.sequence 2 5) 32)
  | 33 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 2) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row348 : Row := ⟨348, state348, 348, action348⟩

def state349 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 5 | 6 | 9 | 11 | 12 | 13 | 19 | 20 | 24 | 27 | 28 | 29 | 30 => 0
  | 1 | 7 | 10 | 14 | 15 | 16 | 17 | 18 | 21 | 22 | 23 | 26 | 31 | 32 | 33 => 1
  | 8 => 2
  | 25 => 3
  | _ => 0

def action349 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 1 => .win 1 (FullWinWitness.standard (.triplet 1) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 8)
  | 2 => .win 0 (FullWinWitness.standard (.triplet 25) (.sequence 0 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 3 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 4 => .back 23 195 [.swapSuits 0 1]
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
  | 21 => .back 27 194 [.swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 3]
  | 22 => .back 4 192 [.swapSuits 0 1]
  | 23 => .back 4 195 [.swapSuits 0 1]
  | 24 => .win 6 (FullWinWitness.standard (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) (.sequence 2 6) 25)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 3) (.sequence 2 6) 8)
  | 26 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 26)
  | 27 => .back 21 194 [.swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 3]
  | 28 => .back 21 194 [.swapHonors 1 3, .swapHonors 2 3]
  | 29 => .back 21 194 [.swapHonors 2 3]
  | 30 => .back 21 194 []
  | 31 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row349 : Row := ⟨349, state349, 349, action349⟩

def state350 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 6 | 9 | 11 | 12 | 13 | 14 | 15 | 18 | 20 | 21 | 22 | 27 | 28 | 29 | 30 => 0
  | 3 | 17 => 2
  | 4 | 5 | 8 | 10 | 16 | 19 | 23 | 24 | 25 | 26 | 31 | 32 | 33 => 1
  | 7 => 3
  | _ => 0

def action350 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 27 194 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 3]
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
  | 13 => .back 0 193 [.swapSuits 0 2]
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
  | 27 => .back 0 194 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 3]
  | 28 => .back 0 194 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 1 3, .swapHonors 2 3]
  | 29 => .back 0 194 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 2 3]
  | 30 => .back 0 194 [.swapSuits 0 2, .swapSuits 1 2]
  | 31 => .win 15 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 6) (.sequence 2 5) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 6) (.sequence 2 5) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 6) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row350 : Row := ⟨350, state350, 350, action350⟩

def state351 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 6 | 9 | 11 | 12 | 13 | 14 | 15 | 16 | 18 | 20 | 21 | 22 | 27 | 28 => 0
  | 3 | 4 | 5 | 8 | 10 | 19 | 23 | 24 | 25 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 7 => 3
  | 17 => 2
  | _ => 0

def action351 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 16 203 [.swapSuits 0 2, .swapSuits 1 2]
  | 1 => .back 16 198 [.swapSuits 0 2, .swapSuits 1 2]
  | 2 => .back 15 199 []
  | 3 => .back 16 204 []
  | 4 => .back 13 200 [.swapSuits 1 2]
  | 5 => .back 16 201 []
  | 6 => .win 7 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 0 6) (.sequence 2 5) 17)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 0 6) (.sequence 2 5) 17)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 7) (.triplet 8) (.sequence 0 3) (.sequence 2 5) 17)
  | 9 => .win 11 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 0) (.sequence 2 5) 17)
  | 10 => .win 10 (FullWinWitness.standard (.triplet 7) (.triplet 10) (.sequence 0 3) (.sequence 2 5) 17)
  | 11 => .win 9 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 0) (.sequence 2 5) 17)
  | 12 => .win 11 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 1) (.sequence 2 5) 17)
  | 13 => .back 4 200 [.swapSuits 1 2]
  | 14 => .back 2 202 []
  | 15 => .back 2 199 []
  | 16 => .back 5 201 []
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
  | 27 => .back 28 205 [.swapHonors 0 1]
  | 28 => .back 27 205 []
  | 29 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 3) (.sequence 2 5) 29)
  | 30 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 3) (.sequence 2 5) 30)
  | 31 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 3) (.sequence 2 5) 31)
  | 32 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 3) (.sequence 2 5) 32)
  | 33 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 3) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row351 : Row := ⟨351, state351, 351, action351⟩

def state352 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 19 | 20 | 24 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 13 | 16 | 18 | 21 | 23 | 26 | 33 => 1
  | 17 | 22 => 2
  | 25 => 3
  | _ => 0

def action352 (t : Tile) : Action :=
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
  | 27 => .back 28 206 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 206 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 206 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 206 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 206 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 206 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row352 : Row := ⟨352, state352, 352, action352⟩

def state353 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 13 | 14 | 15 | 19 | 20 | 24 | 27 | 28 | 29 | 30 | 31 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 16 | 18 | 22 | 23 | 26 | 32 | 33 => 1
  | 17 | 21 => 2
  | 25 => 3
  | _ => 0

def action353 (t : Tile) : Action :=
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
  | 13 => .back 27 207 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
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
  | 27 => .back 28 208 [.swapHonors 0 4, .swapHonors 1 3, .swapHonors 2 4]
  | 28 => .back 27 208 [.swapHonors 0 3, .swapHonors 1 4, .swapHonors 2 3, .swapHonors 3 4]
  | 29 => .back 27 208 [.swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 4]
  | 30 => .back 27 208 [.swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 3, .swapHonors 3 4]
  | 31 => .back 27 208 [.swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 3]
  | 32 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row353 : Row := ⟨353, state353, 353, action353⟩

def state354 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 19 | 20 | 24 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 13 | 16 | 18 | 21 | 22 | 26 | 33 => 1
  | 17 | 23 => 2
  | 25 => 3
  | _ => 0

def action354 (t : Tile) : Action :=
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
  | 27 => .back 28 209 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 209 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 209 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 209 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 209 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 209 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row354 : Row := ⟨354, state354, 354, action354⟩

def state355 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 18 | 20 | 24 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 13 | 16 | 19 | 21 | 22 | 26 | 33 => 1
  | 17 | 23 => 2
  | 25 => 3
  | _ => 0

def action355 (t : Tile) : Action :=
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
  | 27 => .back 28 210 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 210 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 210 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 210 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 210 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 210 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row355 : Row := ⟨355, state355, 355, action355⟩

def state356 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 16 | 18 | 20 | 24 | 27 | 28 | 29 | 30 | 31 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 13 | 19 | 21 | 23 | 26 | 32 | 33 => 1
  | 17 | 22 => 2
  | 25 => 3
  | _ => 0

def action356 (t : Tile) : Action :=
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
  | 16 => .back 27 211 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 17 => .win 2 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 2)
  | 18 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 19 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 19)
  | 20 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 1) 22)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 1) (.sequence 2 3) 17)
  | 22 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 22)
  | 23 => .win 21 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 24 => .win 17 (FullWinWitness.standard (.triplet 17) (.sequence 0 5) (.sequence 2 3) (.sequence 2 6) 25)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 6) 17)
  | 26 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 26)
  | 27 => .back 16 211 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 28 => .back 16 211 [.swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 29 => .back 16 211 [.swapHonors 2 4, .swapHonors 3 4]
  | 30 => .back 16 211 [.swapHonors 3 4]
  | 31 => .back 16 211 []
  | 32 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 32)
  | 33 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row356 : Row := ⟨356, state356, 356, action356⟩

def state357 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 10 | 15 | 18 | 20 | 21 | 22 | 23 | 25 | 27 | 28 | 29 | 30 => 0
  | 2 | 5 | 6 | 7 | 8 | 11 | 12 | 13 | 14 | 17 | 19 | 24 | 31 | 32 | 33 => 1
  | 16 => 3
  | 26 => 2
  | _ => 0

def action357 (t : Tile) : Action :=
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
  | 27 => .back 28 212 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 212 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 212 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 212 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 2) (.sequence 2 6) 31)
  | 32 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 2) (.sequence 2 6) 32)
  | 33 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 2) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row357 : Row := ⟨357, state357, 357, action357⟩

def state358 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 19 | 20 | 24 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 13 | 16 | 18 | 22 | 23 | 26 | 33 => 1
  | 17 | 21 => 2
  | 25 => 3
  | _ => 0

def action358 (t : Tile) : Action :=
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
  | 27 => .back 28 207 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 207 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 207 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 207 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 207 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 207 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row358 : Row := ⟨358, state358, 358, action358⟩

def state359 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 6 | 9 | 10 | 12 | 13 | 18 | 20 | 21 | 22 | 23 | 24 | 27 | 28 | 29 | 30 => 0
  | 3 | 4 | 8 | 11 | 14 | 15 | 16 | 17 | 19 | 25 | 31 | 32 | 33 => 1
  | 5 | 26 => 2
  | 7 => 3
  | _ => 0

def action359 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 22 209 [.swapSuits 0 2, .swapSuits 1 2]
  | 1 => .back 22 210 [.swapSuits 0 2, .swapSuits 1 2]
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
  | 22 => .back 1 210 [.swapSuits 0 2, .swapSuits 1 2]
  | 23 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 5) 26)
  | 24 => .win 2 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 5) (.sequence 2 6) 5)
  | 25 => .win 25 (FullWinWitness.standard (.triplet 7) (.triplet 25) (.sequence 0 3) (.sequence 1 5) 26)
  | 26 => .win 2 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 2) (.sequence 1 5) 5)
  | 27 => .back 28 213 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 213 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 213 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 213 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row359 : Row := ⟨359, state359, 359, action359⟩

def state360 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 10 | 15 | 18 | 20 | 21 | 22 | 24 | 25 | 27 | 28 | 29 | 30 => 0
  | 2 | 5 | 6 | 7 | 8 | 11 | 12 | 13 | 14 | 17 | 19 | 23 | 31 | 32 | 33 => 1
  | 16 => 3
  | 26 => 2
  | _ => 0

def action360 (t : Tile) : Action :=
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
  | 27 => .back 28 214 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 214 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 214 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 214 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 26 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 5) (.sequence 1 2) 31)
  | 32 => .win 26 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 5) (.sequence 1 2) 32)
  | 33 => .win 26 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 5) (.sequence 1 2) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row360 : Row := ⟨360, state360, 360, action360⟩

def state361 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 13 | 14 | 15 | 19 | 20 | 24 | 27 | 28 | 29 | 30 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 16 | 18 | 21 | 22 | 23 | 26 | 31 | 32 | 33 => 1
  | 17 => 2
  | 25 => 3
  | _ => 0

def action361 (t : Tile) : Action :=
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
  | 13 => .back 22 206 []
  | 14 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 5) (.sequence 2 3) 17)
  | 15 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 2)
  | 16 => .win 16 (FullWinWitness.standard (.triplet 16) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 17 => .win 2 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 2)
  | 18 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 18)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 21 => .back 27 208 [.swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 3]
  | 22 => .back 13 206 []
  | 23 => .back 13 209 []
  | 24 => .win 15 (FullWinWitness.standard (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) (.sequence 2 6) 25)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 6) 17)
  | 26 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 26)
  | 27 => .back 21 208 [.swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 3]
  | 28 => .back 21 208 [.swapHonors 1 3, .swapHonors 2 3]
  | 29 => .back 21 208 [.swapHonors 2 3]
  | 30 => .back 21 208 []
  | 31 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row361 : Row := ⟨361, state361, 361, action361⟩

def state362 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 13 | 14 | 15 | 18 | 20 | 24 | 27 | 28 | 29 | 30 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 16 | 19 | 21 | 22 | 23 | 26 | 31 | 32 | 33 => 1
  | 17 => 2
  | 25 => 3
  | _ => 0

def action362 (t : Tile) : Action :=
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
  | 13 => .back 23 210 []
  | 14 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 5) (.sequence 2 3) 17)
  | 15 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 2)
  | 16 => .win 16 (FullWinWitness.standard (.triplet 16) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 17 => .win 2 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 2)
  | 18 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 19 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 19)
  | 20 => .win 18 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 0) (.sequence 2 3) 17)
  | 21 => .win 20 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 1) (.sequence 2 3) 17)
  | 22 => .back 13 211 []
  | 23 => .back 13 210 []
  | 24 => .win 15 (FullWinWitness.standard (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) (.sequence 2 6) 25)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 6) 17)
  | 26 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 26)
  | 27 => .back 28 215 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 215 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 215 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 215 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row362 : Row := ⟨362, state362, 362, action362⟩

def state363 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 6 | 9 | 10 | 12 | 13 | 18 | 20 | 21 | 22 | 23 | 24 | 27 | 28 | 29 | 30 => 0
  | 3 | 26 => 2
  | 4 | 5 | 8 | 11 | 14 | 15 | 16 | 17 | 19 | 25 | 31 | 32 | 33 => 1
  | 7 => 3
  | _ => 0

def action363 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 27 208 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 3]
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
  | 22 => .back 0 207 [.swapSuits 0 2, .swapSuits 1 2]
  | 23 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 5) 26)
  | 24 => .win 3 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 3)
  | 25 => .win 25 (FullWinWitness.standard (.triplet 7) (.triplet 25) (.sequence 0 3) (.sequence 1 5) 26)
  | 26 => .win 3 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 3)
  | 27 => .back 0 208 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 3]
  | 28 => .back 0 208 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 1 3, .swapHonors 2 3]
  | 29 => .back 0 208 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 2 3]
  | 30 => .back 0 208 [.swapSuits 0 2, .swapSuits 1 2]
  | 31 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 7) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row363 : Row := ⟨363, state363, 363, action363⟩

def state364 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 6 | 9 | 10 | 12 | 13 | 18 | 20 | 21 | 23 | 24 | 25 | 27 | 28 | 29 | 30 => 0
  | 3 | 5 | 8 | 11 | 14 | 15 | 16 | 17 | 19 | 22 | 31 | 32 | 33 => 1
  | 4 | 26 => 2
  | 7 => 3
  | _ => 0

def action364 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 25 206 [.swapSuits 0 2, .swapSuits 1 2]
  | 1 => .back 25 211 [.swapSuits 0 2, .swapSuits 1 2]
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
  | 25 => .back 0 206 [.swapSuits 0 2, .swapSuits 1 2]
  | 26 => .win 4 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 4)
  | 27 => .back 28 216 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 216 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 216 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 216 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 26 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 31)
  | 32 => .win 26 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 32)
  | 33 => .win 26 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row364 : Row := ⟨364, state364, 364, action364⟩

def state365 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 6 | 9 | 10 | 12 | 13 | 18 | 20 | 21 | 22 | 23 | 24 | 25 | 27 | 28 => 0
  | 3 | 4 | 5 | 8 | 11 | 14 | 15 | 16 | 17 | 19 | 29 | 30 | 31 | 32 | 33 => 1
  | 7 => 3
  | 26 => 2
  | _ => 0

def action365 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 25 217 [.swapSuits 0 2, .swapSuits 1 2]
  | 1 => .back 25 215 [.swapSuits 0 2, .swapSuits 1 2]
  | 2 => .back 24 212 [.swapSuits 0 1]
  | 3 => .back 25 218 []
  | 4 => .back 22 216 []
  | 5 => .back 25 213 []
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
  | 22 => .back 4 216 []
  | 23 => .back 2 214 [.swapSuits 0 1]
  | 24 => .back 2 212 [.swapSuits 0 1]
  | 25 => .back 5 213 []
  | 26 => .win 6 (FullWinWitness.standard (.triplet 26) (.sequence 0 3) (.sequence 0 6) (.sequence 1 5) 7)
  | 27 => .back 28 219 [.swapHonors 0 1]
  | 28 => .back 27 219 []
  | 29 => .win 26 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 29)
  | 30 => .win 26 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 30)
  | 31 => .win 26 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 31)
  | 32 => .win 26 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 32)
  | 33 => .win 26 (FullWinWitness.standard (.triplet 7) (.triplet 26) (.sequence 0 3) (.sequence 1 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row365 : Row := ⟨365, state365, 365, action365⟩

def state366 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 5 | 7 | 10 | 11 | 12 | 13 | 19 | 20 | 24 | 27 | 28 | 29 | 30 | 31 => 0
  | 1 | 6 | 9 | 14 | 15 | 16 | 17 | 18 | 22 | 23 | 26 | 32 | 33 => 1
  | 8 | 21 => 2
  | 25 => 3
  | _ => 0

def action366 (t : Tile) : Action :=
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
  | 27 => .back 28 220 [.swapHonors 0 4, .swapHonors 1 3, .swapHonors 2 4]
  | 28 => .back 27 220 [.swapHonors 0 3, .swapHonors 1 4, .swapHonors 2 3, .swapHonors 3 4]
  | 29 => .back 27 220 [.swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 4]
  | 30 => .back 27 220 [.swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 3, .swapHonors 3 4]
  | 31 => .back 27 220 [.swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 3]
  | 32 => .win 7 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 32)
  | 33 => .win 7 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row366 : Row := ⟨366, state366, 366, action366⟩

def state367 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 6 | 7 | 10 | 11 | 12 | 13 | 19 | 20 | 24 | 27 | 28 | 29 | 30 | 31 => 0
  | 1 | 5 | 9 | 14 | 15 | 16 | 17 | 18 | 22 | 23 | 26 | 32 | 33 => 1
  | 8 | 21 => 2
  | 25 => 3
  | _ => 0

def action367 (t : Tile) : Action :=
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
  | 27 => .back 28 221 [.swapHonors 0 4, .swapHonors 1 3, .swapHonors 2 4]
  | 28 => .back 27 221 [.swapHonors 0 3, .swapHonors 1 4, .swapHonors 2 3, .swapHonors 3 4]
  | 29 => .back 27 221 [.swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 4]
  | 30 => .back 27 221 [.swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 3, .swapHonors 3 4]
  | 31 => .back 27 221 [.swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 3]
  | 32 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 32)
  | 33 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row367 : Row := ⟨367, state367, 367, action367⟩

def state368 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 16 | 19 | 20 | 24 | 27 | 28 | 29 | 30 | 31 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 13 | 18 | 22 | 23 | 26 | 32 | 33 => 1
  | 17 | 21 => 2
  | 25 => 3
  | _ => 0

def action368 (t : Tile) : Action :=
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
  | 16 => .back 27 207 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
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
  | 27 => .back 16 207 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 28 => .back 16 207 [.swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 29 => .back 16 207 [.swapHonors 2 4, .swapHonors 3 4]
  | 30 => .back 16 207 [.swapHonors 3 4]
  | 31 => .back 16 207 []
  | 32 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 32)
  | 33 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row368 : Row := ⟨368, state368, 368, action368⟩

def state369 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 4 | 9 | 11 | 12 | 13 | 14 | 15 | 16 | 19 | 20 | 24 | 27 | 28 | 29 => 0
  | 5 | 6 | 7 | 8 | 10 | 18 | 22 | 23 | 26 | 30 | 31 | 32 | 33 => 1
  | 17 | 21 => 2
  | 25 => 3
  | _ => 0

def action369 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 15 220 [.swapSuits 0 1]
  | 1 => .back 16 194 [.swapSuits 0 1]
  | 2 => .back 16 208 []
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
  | 13 => .back 2 222 []
  | 14 => .back 0 221 [.swapSuits 0 1]
  | 15 => .back 0 220 [.swapSuits 0 1]
  | 16 => .back 2 208 []
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
  | 27 => .back 28 223 [.swapHonors 0 2]
  | 28 => .back 27 223 [.swapHonors 0 1, .swapHonors 1 2]
  | 29 => .back 27 223 [.swapHonors 0 1]
  | 30 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 30)
  | 31 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 31)
  | 32 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 32)
  | 33 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row369 : Row := ⟨369, state369, 369, action369⟩

def state370 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 5 | 6 | 9 | 11 | 15 | 19 | 20 | 21 | 22 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 1 | 4 | 7 | 10 | 12 | 14 | 17 | 18 | 23 | 24 | 25 | 26 | 33 => 1
  | 8 | 13 => 2
  | 16 => 3
  | _ => 0

def action370 (t : Tile) : Action :=
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
  | 27 => .back 28 224 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 224 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 224 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 224 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 224 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 224 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row370 : Row := ⟨370, state370, 370, action370⟩

def state371 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 6 | 9 | 11 | 12 | 13 | 14 | 16 | 19 | 20 | 21 | 22 | 27 | 28 | 29 | 30 => 0
  | 2 | 3 | 4 | 5 | 8 | 10 | 15 | 18 | 23 | 24 | 25 | 26 | 31 | 32 | 33 => 1
  | 7 => 3
  | 17 => 2
  | _ => 0

def action371 (t : Tile) : Action :=
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
  | 27 => .back 28 225 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 225 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 225 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 225 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 16 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 6) (.sequence 2 5) 31)
  | 32 => .win 16 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 6) (.sequence 2 5) 32)
  | 33 => .win 16 (FullWinWitness.standard (.triplet 7) (.sequence 0 2) (.sequence 1 6) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row371 : Row := ⟨371, state371, 371, action371⟩

def state372 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 18 | 20 | 24 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 13 | 16 | 19 | 21 | 23 | 26 | 33 => 1
  | 17 | 22 => 2
  | 25 => 3
  | _ => 0

def action372 (t : Tile) : Action :=
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
  | 27 => .back 28 211 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 211 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 211 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 211 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 211 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 211 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row372 : Row := ⟨372, state372, 372, action372⟩

def state373 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 6 | 9 | 11 | 12 | 13 | 15 | 16 | 19 | 20 | 21 | 22 | 27 | 28 | 29 | 30 => 0
  | 2 | 3 | 4 | 5 | 8 | 10 | 14 | 18 | 23 | 24 | 25 | 26 | 31 | 32 | 33 => 1
  | 7 => 3
  | 17 => 2
  | _ => 0

def action373 (t : Tile) : Action :=
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
  | 27 => .back 28 226 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 226 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 226 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 226 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 2) (.sequence 2 5) 31)
  | 32 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 2) (.sequence 2 5) 32)
  | 33 => .win 17 (FullWinWitness.standard (.triplet 7) (.triplet 17) (.sequence 0 2) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row373 : Row := ⟨373, state373, 373, action373⟩

def state374 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 6 | 7 | 9 | 10 | 15 | 19 | 20 | 21 | 22 | 27 | 28 | 29 | 30 => 0
  | 2 | 5 | 11 | 12 | 13 | 14 | 17 | 18 | 23 | 24 | 25 | 26 | 31 | 32 | 33 => 1
  | 8 => 2
  | 16 => 3
  | _ => 0

def action374 (t : Tile) : Action :=
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
  | 27 => .back 28 227 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 227 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 227 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 227 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 2) (.sequence 2 5) 31)
  | 32 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 2) (.sequence 2 5) 32)
  | 33 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 2) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row374 : Row := ⟨374, state374, 374, action374⟩

def state375 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 5 | 7 | 9 | 10 | 15 | 18 | 20 | 21 | 22 | 27 | 28 | 29 | 30 => 0
  | 2 | 6 | 11 | 12 | 13 | 14 | 17 | 19 | 23 | 24 | 25 | 26 | 31 | 32 | 33 => 1
  | 8 => 2
  | 16 => 3
  | _ => 0

def action375 (t : Tile) : Action :=
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
  | 27 => .back 28 228 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 228 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 228 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 228 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 7 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 31)
  | 32 => .win 7 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 32)
  | 33 => .win 7 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row375 : Row := ⟨375, state375, 375, action375⟩

def state376 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 5 | 6 | 9 | 10 | 12 | 13 | 18 | 19 | 24 | 27 | 28 | 29 | 30 => 0
  | 2 | 7 | 11 | 14 | 15 | 16 | 17 | 20 | 21 | 22 | 23 | 26 | 31 | 32 | 33 => 1
  | 8 => 2
  | 25 => 3
  | _ => 0

def action376 (t : Tile) : Action :=
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
  | 27 => .back 28 229 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 229 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 229 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 229 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row376 : Row := ⟨376, state376, 376, action376⟩

def state377 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 5 | 6 | 9 | 10 | 15 | 19 | 20 | 21 | 22 | 27 | 28 | 29 | 30 => 0
  | 2 | 7 | 11 | 12 | 13 | 14 | 17 | 18 | 23 | 24 | 25 | 26 | 31 | 32 | 33 => 1
  | 8 => 2
  | 16 => 3
  | _ => 0

def action377 (t : Tile) : Action :=
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
  | 27 => .back 28 230 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 230 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 230 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 230 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row377 : Row := ⟨377, state377, 377, action377⟩

def state378 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 5 | 6 | 9 | 10 | 15 | 18 | 20 | 21 | 22 | 27 | 28 | 29 | 30 => 0
  | 2 | 7 | 11 | 12 | 13 | 14 | 17 | 19 | 23 | 24 | 25 | 26 | 31 | 32 | 33 => 1
  | 8 => 2
  | 16 => 3
  | _ => 0

def action378 (t : Tile) : Action :=
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
  | 27 => .back 28 231 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 231 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 231 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 231 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 2) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row378 : Row := ⟨378, state378, 378, action378⟩

def state379 (t : Tile) : Nat :=
  match t.val with
  | 0 | 5 | 6 | 7 | 8 | 9 | 12 | 16 | 18 | 22 | 23 | 26 | 33 => 1
  | 1 | 2 | 3 | 4 | 10 | 11 | 13 | 14 | 15 | 19 | 20 | 24 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 17 | 21 => 2
  | 25 => 3
  | _ => 0

def action379 (t : Tile) : Action :=
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
  | 27 => .back 28 232 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 232 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 232 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 232 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 232 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 232 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row379 : Row := ⟨379, state379, 379, action379⟩

def state380 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 4 | 5 | 6 | 10 | 11 | 12 | 13 | 19 | 20 | 24 | 27 | 28 | 29 | 30 | 31 => 0
  | 3 | 7 | 9 | 14 | 15 | 16 | 17 | 18 | 22 | 23 | 26 | 32 | 33 => 1
  | 8 | 21 => 2
  | 25 => 3
  | _ => 0

def action380 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 27 232 [.swapSuits 0 1, .swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
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
  | 27 => .back 0 232 [.swapSuits 0 1, .swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 28 => .back 0 232 [.swapSuits 0 1, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 29 => .back 0 232 [.swapSuits 0 1, .swapHonors 2 4, .swapHonors 3 4]
  | 30 => .back 0 232 [.swapSuits 0 1, .swapHonors 3 4]
  | 31 => .back 0 232 [.swapSuits 0 1]
  | 32 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row380 : Row := ⟨380, state380, 380, action380⟩

def state381 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 4 | 5 | 6 | 9 | 10 | 11 | 15 | 19 | 20 | 21 | 22 | 27 | 28 | 29 | 30 => 0
  | 3 | 7 | 13 | 14 | 17 | 18 | 23 | 24 | 25 | 26 | 31 | 32 | 33 => 1
  | 8 | 12 => 2
  | 16 => 3
  | _ => 0

def action381 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 9 232 [.swapSuits 0 1, .swapSuits 1 2]
  | 1 => .win 2 (FullWinWitness.standard (.triplet 16) (.sequence 0 1) (.sequence 1 3) (.sequence 2 5) 8)
  | 2 => .win 1 (FullWinWitness.standard (.triplet 16) (.sequence 0 1) (.sequence 1 3) (.sequence 2 5) 8)
  | 3 => .win 3 (FullWinWitness.standard (.triplet 3) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 8)
  | 4 => .win 2 (FullWinWitness.standard (.triplet 16) (.sequence 0 2) (.sequence 1 3) (.sequence 2 5) 8)
  | 5 => .win 4 (FullWinWitness.standard (.triplet 16) (.sequence 0 3) (.sequence 1 3) (.sequence 2 5) 8)
  | 6 => .win 3 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 3)
  | 7 => .win 7 (FullWinWitness.standard (.triplet 7) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 8)
  | 8 => .win 3 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 1 3) (.sequence 2 5) 3)
  | 9 => .back 0 232 [.swapSuits 0 1, .swapSuits 1 2]
  | 10 => .win 11 (FullWinWitness.standard (.triplet 16) (.sequence 1 1) (.sequence 1 3) (.sequence 2 5) 8)
  | 11 => .win 10 (FullWinWitness.standard (.triplet 16) (.sequence 1 1) (.sequence 1 3) (.sequence 2 5) 8)
  | 12 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 12)
  | 13 => .win 11 (FullWinWitness.standard (.triplet 16) (.sequence 1 2) (.sequence 1 3) (.sequence 2 5) 8)
  | 14 => .win 13 (FullWinWitness.standard (.triplet 16) (.sequence 1 3) (.sequence 1 3) (.sequence 2 5) 8)
  | 15 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 4) (.sequence 2 5) 12)
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
  | 27 => .back 9 233 [.swapSuits 1 2, .swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 3]
  | 28 => .back 9 233 [.swapSuits 1 2, .swapHonors 1 3, .swapHonors 2 3]
  | 29 => .back 9 233 [.swapSuits 1 2, .swapHonors 2 3]
  | 30 => .back 9 233 [.swapSuits 1 2]
  | 31 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 31)
  | 32 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row381 : Row := ⟨381, state381, 381, action381⟩

def state382 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 15 | 16 | 19 | 20 | 22 | 23 | 24 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 1 | 5 | 6 | 7 | 8 | 12 | 13 | 17 | 18 | 21 | 25 | 33 => 1
  | 10 => 4
  | 14 | 26 => 2
  | _ => 0

def action382 (t : Tile) : Action :=
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
  | 27 => .back 28 234 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 234 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 234 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 234 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 234 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 234 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row382 : Row := ⟨382, state382, 382, action382⟩

def state383 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 4 | 5 | 6 | 9 | 11 | 12 | 13 | 18 | 20 | 24 | 25 | 27 | 28 | 29 | 30 | 31 => 0
  | 3 | 7 | 10 | 14 | 15 | 16 | 17 | 21 | 22 | 26 | 32 | 33 => 1
  | 8 | 23 => 2
  | 19 => 4
  | _ => 0

def action383 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 27 234 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
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
  | 27 => .back 28 235 [.swapHonors 0 4, .swapHonors 1 3, .swapHonors 2 4]
  | 28 => .back 27 235 [.swapHonors 0 3, .swapHonors 1 4, .swapHonors 2 3, .swapHonors 3 4]
  | 29 => .back 27 235 [.swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 4]
  | 30 => .back 27 235 [.swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 3, .swapHonors 3 4]
  | 31 => .back 27 235 [.swapHonors 0 3, .swapHonors 1 3, .swapHonors 2 3]
  | 32 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 19) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row383 : Row := ⟨383, state383, 383, action383⟩

end Mahjong.Scale12V2
