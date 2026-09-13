import MahjongNext.ResponseGroups
import MahjongNext.SafeBounds
import Mahjong.Actual14LeavesV1.L000003
import Mahjong.Actual14LeavesV1.L000002
import Mahjong.Actual14LeavesV1.L000001
import Mahjong.Actual14LeavesV1.L000000
import Mahjong.Actual14ExtraLeavesV1.L000001
import Mahjong.Actual14ExtraLeavesV1.L000000

set_option maxRecDepth 16384
set_option maxHeartbeats 100000000

namespace Mahjong.Actual14
open ResponseTable ResponseCertificate Generators

def leafFact (i : Nat) : SafeBounds.Fact :=
  match i with
  | 0 => ⟨Mahjong.Actual14LeavesV1.L000003.state, Mahjong.Actual14LeavesV1.L000003.valid, Mahjong.Actual14LeavesV1.L000003.safe⟩
  | 1 => ⟨Mahjong.Actual14LeavesV1.L000002.state, Mahjong.Actual14LeavesV1.L000002.valid, Mahjong.Actual14LeavesV1.L000002.safe⟩
  | 2 => ⟨Mahjong.Actual14LeavesV1.L000001.state, Mahjong.Actual14LeavesV1.L000001.valid, Mahjong.Actual14LeavesV1.L000001.safe⟩
  | 3 => ⟨Mahjong.Actual14LeavesV1.L000000.state, Mahjong.Actual14LeavesV1.L000000.valid, Mahjong.Actual14LeavesV1.L000000.safe⟩
  | 4 => ⟨Mahjong.Actual14ExtraLeavesV1.L000001.state, Mahjong.Actual14ExtraLeavesV1.L000001.valid, Mahjong.Actual14ExtraLeavesV1.L000001.safe⟩
  | 5 => ⟨Mahjong.Actual14ExtraLeavesV1.L000000.state, Mahjong.Actual14ExtraLeavesV1.L000000.valid, Mahjong.Actual14ExtraLeavesV1.L000000.safe⟩
  | _ => ⟨Mahjong.Actual14LeavesV1.L000003.state, Mahjong.Actual14LeavesV1.L000003.valid, Mahjong.Actual14LeavesV1.L000003.safe⟩

def boundSpec (i : Nat) : Nat × List Generator :=
  match i with
  | 0 => (3, [])
  | 1 => (2, [])
  | 2 => (1, [])
  | 3 => (0, [])
  | 4 => (5, [])
  | 5 => (4, [])
  | 6 => (3, [])
  | 7 => (2, [])
  | 8 => (1, [])
  | 9 => (0, [])
  | 10 => (3, [])
  | 11 => (2, [])
  | 12 => (5, [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3])
  | 13 => (4, [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3])
  | 14 => (3, [])
  | 15 => (2, [])
  | 16 => (1, [])
  | 17 => (0, [])
  | 18 => (5, [.swapSuits 1 2])
  | 19 => (4, [.swapSuits 1 2])
  | 20 => (5, [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 3, .swapHonors 4 5])
  | 21 => (4, [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 3, .swapHonors 4 5])
  | 22 => (4, [.swapSuits 0 1, .swapHonors 0 4, .swapHonors 1 3, .swapHonors 3 4])
  | 23 => (3, [])
  | 24 => (2, [])
  | 25 => (2, [.swapSuits 0 2, .swapSuits 1 2])
  | 26 => (1, [])
  | 27 => (0, [])
  | 28 => (0, [.swapSuits 0 2, .swapSuits 1 2])
  | 29 => (5, [.swapSuits 1 2, .swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3])
  | 30 => (4, [.swapSuits 1 2, .swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3])
  | 31 => (5, [.swapSuits 0 2, .swapSuits 1 2, .reverseSuit 0, .swapHonors 0 6, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 5 6])
  | 32 => (4, [.swapSuits 0 1, .swapHonors 0 6, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 5 6])
  | 33 => (4, [.swapSuits 0 1, .swapSuits 1 2, .reverseSuit 1, .swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 3, .swapHonors 4 5])
  | 34 => (3, [])
  | 35 => (2, [.swapSuits 0 2, .swapSuits 1 2])
  | 36 => (2, [.swapSuits 0 2, .swapSuits 1 2])
  | 37 => (1, [])
  | 38 => (0, [.swapSuits 0 2, .swapSuits 1 2])
  | 39 => (0, [.swapSuits 0 2, .swapSuits 1 2])
  | 40 => (5, [.swapSuits 1 2, .swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 3, .swapHonors 4 5])
  | 41 => (4, [.swapSuits 1 2, .swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 3, .swapHonors 4 5])
  | 42 => (4, [.swapHonors 0 4, .swapHonors 1 3, .swapHonors 3 4])
  | 43 => (5, [.swapSuits 0 1, .swapSuits 1 2, .reverseSuit 1, .swapHonors 0 6, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 5 6])
  | 44 => (3, [.swapSuits 0 2, .swapSuits 1 2])
  | 45 => (1, [.swapSuits 0 2, .swapSuits 1 2])
  | 46 => (5, [.swapSuits 1 2, .swapHonors 0 6, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 5 6])
  | 47 => (4, [.swapHonors 0 6, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 5 6])
  | 48 => (4, [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 3, .swapHonors 4 5])
  | 49 => (5, [.swapHonors 0 6, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 5 6])
  | _ => (0, [])

def boundFact (i : Nat) : SafeBounds.Fact :=
  (leafFact (boundSpec i).1).alongPath (boundSpec i).2
def bounds (i : Nat) : State := (boundFact i).state

theorem validBounds (i : Nat) : Valid (bounds i) := (boundFact i).valid
theorem safeBounds (i : Nat) : IsSafe (bounds i) := (boundFact i).safe

def state0 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 15 | 19 | 20 | 22 | 23 | 25 => 0
  | 1 | 5 | 6 | 7 | 8 | 10 | 12 | 13 | 17 | 18 | 21 | 24 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 14 | 26 => 2
  | 16 => 3
  | _ => 0

def action0 (t : Tile) : Action :=
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
  | 9 => .win 0 (FullWinWitness.orphans 26)
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
  | 21 => .win 21 (FullWinWitness.standard (.triplet 16) (.triplet 21) (.sequence 0 5) (.sequence 1 3) 26)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 2) 26)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 26)
  | 24 => .win 24 (FullWinWitness.standard (.triplet 16) (.triplet 24) (.sequence 0 5) (.sequence 1 3) 26)
  | 25 => .win 1 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 1)
  | 26 => .win 1 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 5) (.sequence 1 3) 1)
  | 27 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 27)
  | 28 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 28)
  | 29 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 29)
  | 30 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 30)
  | 31 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row0 : Row := ⟨0, state0, 0, action0⟩

def state1 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 15 | 19 | 20 | 22 | 23 | 24 => 0
  | 1 | 5 | 6 | 7 | 8 | 10 | 12 | 13 | 17 | 18 | 21 | 25 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 14 | 26 => 2
  | 16 => 3
  | _ => 0

def action1 (t : Tile) : Action :=
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
  | 9 => .win 0 (FullWinWitness.orphans 26)
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
  | 21 => .win 21 (FullWinWitness.standard (.triplet 16) (.triplet 21) (.sequence 0 5) (.sequence 1 3) 26)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 2) 26)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 26)
  | 24 => .win 1 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 1)
  | 25 => .win 25 (FullWinWitness.standard (.triplet 16) (.triplet 25) (.sequence 0 5) (.sequence 1 3) 26)
  | 26 => .win 1 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 5) (.sequence 1 3) 1)
  | 27 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 27)
  | 28 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 28)
  | 29 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 29)
  | 30 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 30)
  | 31 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row1 : Row := ⟨1, state1, 1, action1⟩

def state2 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 15 | 19 | 20 | 22 | 23 | 25 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 12 | 13 | 17 | 18 | 21 | 24 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 14 | 26 => 2
  | 16 => 3
  | _ => 0

def action2 (t : Tile) : Action :=
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
  | 9 => .win 0 (FullWinWitness.orphans 26)
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
  | 21 => .win 21 (FullWinWitness.standard (.triplet 16) (.triplet 21) (.sequence 0 5) (.sequence 1 3) 26)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 2) 26)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 26)
  | 24 => .win 24 (FullWinWitness.standard (.triplet 16) (.triplet 24) (.sequence 0 5) (.sequence 1 3) 26)
  | 25 => .win 2 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 2)
  | 26 => .win 2 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 5) (.sequence 1 3) 2)
  | 27 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 27)
  | 28 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 28)
  | 29 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 29)
  | 30 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 30)
  | 31 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row2 : Row := ⟨2, state2, 2, action2⟩

def state3 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 15 | 19 | 20 | 22 | 23 | 24 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 12 | 13 | 17 | 18 | 21 | 25 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 14 | 26 => 2
  | 16 => 3
  | _ => 0

def action3 (t : Tile) : Action :=
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
  | 9 => .win 0 (FullWinWitness.orphans 26)
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
  | 21 => .win 21 (FullWinWitness.standard (.triplet 16) (.triplet 21) (.sequence 0 5) (.sequence 1 3) 26)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 2) 26)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 26)
  | 24 => .win 2 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 2)
  | 25 => .win 25 (FullWinWitness.standard (.triplet 16) (.triplet 25) (.sequence 0 5) (.sequence 1 3) 26)
  | 26 => .win 2 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 5) (.sequence 1 3) 2)
  | 27 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 27)
  | 28 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 28)
  | 29 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 29)
  | 30 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 30)
  | 31 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row3 : Row := ⟨3, state3, 3, action3⟩

def state4 (t : Tile) : Nat :=
  match t.val with
  | 0 | 5 | 6 | 7 | 8 | 9 | 12 | 15 | 18 | 21 | 22 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 1 | 2 | 3 | 4 | 10 | 11 | 13 | 14 | 16 | 19 | 20 | 24 | 27 | 28 => 0
  | 17 | 23 => 2
  | 25 => 3
  | _ => 0

def action4 (t : Tile) : Action :=
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
  | 20 => .win 16 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 2) 23)
  | 21 => .win 22 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 23 => .win 16 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 23)
  | 24 => .win 16 (FullWinWitness.standard (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) (.sequence 2 5) 25)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 5) 17)
  | 26 => .win 16 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 26)
  | 27 => .win 28 (FullWinWitness.orphans 17)
  | 28 => .win 27 (FullWinWitness.orphans 17)
  | 29 => .win 16 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 29)
  | 30 => .win 16 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 30)
  | 31 => .win 16 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 16 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 16 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row4 : Row := ⟨4, state4, 4, action4⟩

def state5 (t : Tile) : Nat :=
  match t.val with
  | 0 | 5 | 6 | 7 | 8 | 9 | 12 | 16 | 18 | 21 | 22 | 26 | 29 | 30 | 31 | 32 | 33 => 1
  | 1 | 2 | 3 | 4 | 10 | 11 | 13 | 14 | 15 | 19 | 20 | 24 | 27 | 28 => 0
  | 17 | 23 => 2
  | 25 => 3
  | _ => 0

def action5 (t : Tile) : Action :=
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

def row5 : Row := ⟨5, state5, 5, action5⟩

def state6 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 15 | 19 | 20 | 22 | 23 | 25 | 27 | 28 => 0
  | 1 | 5 | 6 | 7 | 8 | 10 | 12 | 13 | 17 | 18 | 21 | 24 | 29 | 30 | 31 | 32 | 33 => 1
  | 14 | 26 => 2
  | 16 => 3
  | _ => 0

def action6 (t : Tile) : Action :=
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
  | 21 => .win 21 (FullWinWitness.standard (.triplet 16) (.triplet 21) (.sequence 0 5) (.sequence 1 3) 26)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 2) 26)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 26)
  | 24 => .win 24 (FullWinWitness.standard (.triplet 16) (.triplet 24) (.sequence 0 5) (.sequence 1 3) 26)
  | 25 => .win 1 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 1)
  | 26 => .win 1 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 5) (.sequence 1 3) 1)
  | 27 => .back 28 0 [.swapHonors 0 1]
  | 28 => .back 27 0 []
  | 29 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 29)
  | 30 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 30)
  | 31 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row6 : Row := ⟨6, state6, 6, action6⟩

def state7 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 15 | 19 | 20 | 22 | 23 | 24 | 27 | 28 => 0
  | 1 | 5 | 6 | 7 | 8 | 10 | 12 | 13 | 17 | 18 | 21 | 25 | 29 | 30 | 31 | 32 | 33 => 1
  | 14 | 26 => 2
  | 16 => 3
  | _ => 0

def action7 (t : Tile) : Action :=
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
  | 21 => .win 21 (FullWinWitness.standard (.triplet 16) (.triplet 21) (.sequence 0 5) (.sequence 1 3) 26)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 2) 26)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 26)
  | 24 => .win 1 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 1)
  | 25 => .win 25 (FullWinWitness.standard (.triplet 16) (.triplet 25) (.sequence 0 5) (.sequence 1 3) 26)
  | 26 => .win 1 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 5) (.sequence 1 3) 1)
  | 27 => .back 28 1 [.swapHonors 0 1]
  | 28 => .back 27 1 []
  | 29 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 29)
  | 30 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 30)
  | 31 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row7 : Row := ⟨7, state7, 7, action7⟩

def state8 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 15 | 19 | 20 | 22 | 23 | 25 | 27 | 28 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 12 | 13 | 17 | 18 | 21 | 24 | 29 | 30 | 31 | 32 | 33 => 1
  | 14 | 26 => 2
  | 16 => 3
  | _ => 0

def action8 (t : Tile) : Action :=
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
  | 21 => .win 21 (FullWinWitness.standard (.triplet 16) (.triplet 21) (.sequence 0 5) (.sequence 1 3) 26)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 2) 26)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 26)
  | 24 => .win 24 (FullWinWitness.standard (.triplet 16) (.triplet 24) (.sequence 0 5) (.sequence 1 3) 26)
  | 25 => .win 2 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 2)
  | 26 => .win 2 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 5) (.sequence 1 3) 2)
  | 27 => .back 28 2 [.swapHonors 0 1]
  | 28 => .back 27 2 []
  | 29 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 29)
  | 30 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 30)
  | 31 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row8 : Row := ⟨8, state8, 8, action8⟩

def state9 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 15 | 19 | 20 | 22 | 23 | 24 | 27 | 28 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 12 | 13 | 17 | 18 | 21 | 25 | 29 | 30 | 31 | 32 | 33 => 1
  | 14 | 26 => 2
  | 16 => 3
  | _ => 0

def action9 (t : Tile) : Action :=
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
  | 21 => .win 21 (FullWinWitness.standard (.triplet 16) (.triplet 21) (.sequence 0 5) (.sequence 1 3) 26)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 2) 26)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 26)
  | 24 => .win 2 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 2)
  | 25 => .win 25 (FullWinWitness.standard (.triplet 16) (.triplet 25) (.sequence 0 5) (.sequence 1 3) 26)
  | 26 => .win 2 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 5) (.sequence 1 3) 2)
  | 27 => .back 28 3 [.swapHonors 0 1]
  | 28 => .back 27 3 []
  | 29 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 29)
  | 30 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 30)
  | 31 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row9 : Row := ⟨9, state9, 9, action9⟩

def state10 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 4 | 9 | 10 | 11 | 15 | 19 | 20 | 22 | 23 | 25 => 0
  | 5 | 6 | 7 | 8 | 12 | 13 | 17 | 18 | 21 | 24 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 14 | 26 => 2
  | 16 => 3
  | _ => 0

def action10 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 9 (FullWinWitness.orphans 26)
  | 1 => .back 10 0 []
  | 2 => .back 10 2 []
  | 3 => .win 4 (FullWinWitness.standard (.triplet 16) (.sequence 0 3) (.sequence 0 6) (.sequence 1 3) 26)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 16) (.sequence 0 3) (.sequence 0 6) (.sequence 1 3) 26)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 16) (.sequence 0 6) (.sequence 1 3) 26)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 16) (.sequence 0 4) (.sequence 0 6) (.sequence 1 3) 26)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 0 6) (.sequence 1 3) 26)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 0 5) (.sequence 1 3) 26)
  | 9 => .win 0 (FullWinWitness.orphans 26)
  | 10 => .back 2 2 []
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
  | 21 => .win 21 (FullWinWitness.standard (.triplet 16) (.triplet 21) (.sequence 0 5) (.sequence 1 3) 26)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 2) 26)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 26)
  | 24 => .win 24 (FullWinWitness.standard (.triplet 16) (.triplet 24) (.sequence 0 5) (.sequence 1 3) 26)
  | 25 => .win 5 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 6) 5)
  | 26 => .win 5 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 6) (.sequence 1 3) 5)
  | 27 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 27)
  | 28 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 28)
  | 29 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 29)
  | 30 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 30)
  | 31 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row10 : Row := ⟨10, state10, 10, action10⟩

def state11 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 4 | 9 | 10 | 11 | 15 | 19 | 20 | 22 | 23 | 24 => 0
  | 5 | 6 | 7 | 8 | 12 | 13 | 17 | 18 | 21 | 25 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 1
  | 14 | 26 => 2
  | 16 => 3
  | _ => 0

def action11 (t : Tile) : Action :=
  match t.val with
  | 0 => .win 9 (FullWinWitness.orphans 26)
  | 1 => .back 10 1 []
  | 2 => .back 10 3 []
  | 3 => .win 4 (FullWinWitness.standard (.triplet 16) (.sequence 0 3) (.sequence 0 6) (.sequence 1 3) 26)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 16) (.sequence 0 3) (.sequence 0 6) (.sequence 1 3) 26)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 16) (.sequence 0 6) (.sequence 1 3) 26)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 16) (.sequence 0 4) (.sequence 0 6) (.sequence 1 3) 26)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 0 6) (.sequence 1 3) 26)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 0 5) (.sequence 1 3) 26)
  | 9 => .win 0 (FullWinWitness.orphans 26)
  | 10 => .back 2 3 []
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
  | 21 => .win 21 (FullWinWitness.standard (.triplet 16) (.triplet 21) (.sequence 0 5) (.sequence 1 3) 26)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 2) 26)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 26)
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

def row11 : Row := ⟨11, state11, 11, action11⟩

def state12 (t : Tile) : Nat :=
  match t.val with
  | 0 | 5 | 6 | 7 | 8 | 9 | 12 | 15 | 18 | 21 | 22 | 26 | 31 | 32 | 33 => 1
  | 1 | 2 | 3 | 4 | 10 | 11 | 13 | 14 | 16 | 19 | 20 | 24 | 27 | 28 | 29 | 30 => 0
  | 17 | 23 => 2
  | 25 => 3
  | _ => 0

def action12 (t : Tile) : Action :=
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
  | 20 => .win 16 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 2) 23)
  | 21 => .win 22 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 23 => .win 16 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 23)
  | 24 => .win 16 (FullWinWitness.standard (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) (.sequence 2 5) 25)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 5) 17)
  | 26 => .win 16 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 26)
  | 27 => .back 28 4 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 4 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 4 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 4 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 16 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 16 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 16 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row12 : Row := ⟨12, state12, 12, action12⟩

def state13 (t : Tile) : Nat :=
  match t.val with
  | 0 | 5 | 6 | 7 | 8 | 9 | 12 | 16 | 18 | 21 | 22 | 26 | 31 | 32 | 33 => 1
  | 1 | 2 | 3 | 4 | 10 | 11 | 13 | 14 | 15 | 19 | 20 | 24 | 27 | 28 | 29 | 30 => 0
  | 17 | 23 => 2
  | 25 => 3
  | _ => 0

def action13 (t : Tile) : Action :=
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
  | 20 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 2) 23)
  | 21 => .win 22 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 23 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 23)
  | 24 => .win 15 (FullWinWitness.standard (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) (.sequence 2 5) 25)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 5) 17)
  | 26 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 26)
  | 27 => .back 28 5 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 5 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 5 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 5 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 31)
  | 32 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row13 : Row := ⟨13, state13, 13, action13⟩

def state14 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 15 | 19 | 20 | 22 | 23 | 25 | 27 | 28 | 29 | 30 => 0
  | 1 | 5 | 6 | 7 | 8 | 10 | 12 | 13 | 17 | 18 | 21 | 24 | 31 | 32 | 33 => 1
  | 14 | 26 => 2
  | 16 => 3
  | _ => 0

def action14 (t : Tile) : Action :=
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
  | 21 => .win 21 (FullWinWitness.standard (.triplet 16) (.triplet 21) (.sequence 0 5) (.sequence 1 3) 26)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 2) 26)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 26)
  | 24 => .win 24 (FullWinWitness.standard (.triplet 16) (.triplet 24) (.sequence 0 5) (.sequence 1 3) 26)
  | 25 => .win 1 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 1)
  | 26 => .win 1 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 5) (.sequence 1 3) 1)
  | 27 => .back 28 6 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 6 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 6 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 6 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row14 : Row := ⟨14, state14, 14, action14⟩

def state15 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 15 | 19 | 20 | 22 | 23 | 24 | 27 | 28 | 29 | 30 => 0
  | 1 | 5 | 6 | 7 | 8 | 10 | 12 | 13 | 17 | 18 | 21 | 25 | 31 | 32 | 33 => 1
  | 14 | 26 => 2
  | 16 => 3
  | _ => 0

def action15 (t : Tile) : Action :=
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
  | 21 => .win 21 (FullWinWitness.standard (.triplet 16) (.triplet 21) (.sequence 0 5) (.sequence 1 3) 26)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 2) 26)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 26)
  | 24 => .win 1 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 1)
  | 25 => .win 25 (FullWinWitness.standard (.triplet 16) (.triplet 25) (.sequence 0 5) (.sequence 1 3) 26)
  | 26 => .win 1 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 5) (.sequence 1 3) 1)
  | 27 => .back 28 7 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 7 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 7 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 7 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row15 : Row := ⟨15, state15, 15, action15⟩

def state16 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 15 | 19 | 20 | 22 | 23 | 25 | 27 | 28 | 29 | 30 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 12 | 13 | 17 | 18 | 21 | 24 | 31 | 32 | 33 => 1
  | 14 | 26 => 2
  | 16 => 3
  | _ => 0

def action16 (t : Tile) : Action :=
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
  | 21 => .win 21 (FullWinWitness.standard (.triplet 16) (.triplet 21) (.sequence 0 5) (.sequence 1 3) 26)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 2) 26)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 26)
  | 24 => .win 24 (FullWinWitness.standard (.triplet 16) (.triplet 24) (.sequence 0 5) (.sequence 1 3) 26)
  | 25 => .win 2 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 2)
  | 26 => .win 2 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 5) (.sequence 1 3) 2)
  | 27 => .back 28 8 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 8 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 8 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 8 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row16 : Row := ⟨16, state16, 16, action16⟩

def state17 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 15 | 19 | 20 | 22 | 23 | 24 | 27 | 28 | 29 | 30 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 12 | 13 | 17 | 18 | 21 | 25 | 31 | 32 | 33 => 1
  | 14 | 26 => 2
  | 16 => 3
  | _ => 0

def action17 (t : Tile) : Action :=
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
  | 21 => .win 21 (FullWinWitness.standard (.triplet 16) (.triplet 21) (.sequence 0 5) (.sequence 1 3) 26)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 2) 26)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 26)
  | 24 => .win 2 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 2)
  | 25 => .win 25 (FullWinWitness.standard (.triplet 16) (.triplet 25) (.sequence 0 5) (.sequence 1 3) 26)
  | 26 => .win 2 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 5) (.sequence 1 3) 2)
  | 27 => .back 28 9 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 9 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 9 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 9 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row17 : Row := ⟨17, state17, 17, action17⟩

def state18 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 4 | 9 | 10 | 11 | 15 | 19 | 20 | 22 | 23 | 25 | 27 | 28 => 0
  | 5 | 6 | 7 | 8 | 12 | 13 | 17 | 18 | 21 | 24 | 29 | 30 | 31 | 32 | 33 => 1
  | 14 | 26 => 2
  | 16 => 3
  | _ => 0

def action18 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 9 4 [.swapSuits 1 2]
  | 1 => .back 10 6 []
  | 2 => .back 10 8 []
  | 3 => .win 4 (FullWinWitness.standard (.triplet 16) (.sequence 0 3) (.sequence 0 6) (.sequence 1 3) 26)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 16) (.sequence 0 3) (.sequence 0 6) (.sequence 1 3) 26)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 16) (.sequence 0 6) (.sequence 1 3) 26)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 16) (.sequence 0 4) (.sequence 0 6) (.sequence 1 3) 26)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 0 6) (.sequence 1 3) 26)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 0 5) (.sequence 1 3) 26)
  | 9 => .back 0 4 [.swapSuits 1 2]
  | 10 => .back 2 8 []
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
  | 21 => .win 21 (FullWinWitness.standard (.triplet 16) (.triplet 21) (.sequence 0 5) (.sequence 1 3) 26)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 2) 26)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 26)
  | 24 => .win 24 (FullWinWitness.standard (.triplet 16) (.triplet 24) (.sequence 0 5) (.sequence 1 3) 26)
  | 25 => .win 5 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 6) 5)
  | 26 => .win 5 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 6) (.sequence 1 3) 5)
  | 27 => .back 28 10 [.swapHonors 0 1]
  | 28 => .back 27 10 []
  | 29 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 29)
  | 30 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 30)
  | 31 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row18 : Row := ⟨18, state18, 18, action18⟩

def state19 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 4 | 9 | 10 | 11 | 15 | 19 | 20 | 22 | 23 | 24 | 27 | 28 => 0
  | 5 | 6 | 7 | 8 | 12 | 13 | 17 | 18 | 21 | 25 | 29 | 30 | 31 | 32 | 33 => 1
  | 14 | 26 => 2
  | 16 => 3
  | _ => 0

def action19 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 9 5 [.swapSuits 1 2]
  | 1 => .back 10 7 []
  | 2 => .back 10 9 []
  | 3 => .win 4 (FullWinWitness.standard (.triplet 16) (.sequence 0 3) (.sequence 0 6) (.sequence 1 3) 26)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 16) (.sequence 0 3) (.sequence 0 6) (.sequence 1 3) 26)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 16) (.sequence 0 6) (.sequence 1 3) 26)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 16) (.sequence 0 4) (.sequence 0 6) (.sequence 1 3) 26)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 0 6) (.sequence 1 3) 26)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 0 5) (.sequence 1 3) 26)
  | 9 => .back 0 5 [.swapSuits 1 2]
  | 10 => .back 2 9 []
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
  | 21 => .win 21 (FullWinWitness.standard (.triplet 16) (.triplet 21) (.sequence 0 5) (.sequence 1 3) 26)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 2) 26)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 26)
  | 24 => .win 5 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 6) 5)
  | 25 => .win 25 (FullWinWitness.standard (.triplet 16) (.triplet 25) (.sequence 0 5) (.sequence 1 3) 26)
  | 26 => .win 5 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 6) (.sequence 1 3) 5)
  | 27 => .back 28 11 [.swapHonors 0 1]
  | 28 => .back 27 11 []
  | 29 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 29)
  | 30 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 30)
  | 31 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row19 : Row := ⟨19, state19, 19, action19⟩

def state20 (t : Tile) : Nat :=
  match t.val with
  | 0 | 5 | 6 | 7 | 8 | 9 | 12 | 15 | 18 | 21 | 22 | 26 | 33 => 1
  | 1 | 2 | 3 | 4 | 10 | 11 | 13 | 14 | 16 | 19 | 20 | 24 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 17 | 23 => 2
  | 25 => 3
  | _ => 0

def action20 (t : Tile) : Action :=
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
  | 20 => .win 16 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 2) 23)
  | 21 => .win 22 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 23 => .win 16 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 23)
  | 24 => .win 16 (FullWinWitness.standard (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) (.sequence 2 5) 25)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 5) 17)
  | 26 => .win 16 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 26)
  | 27 => .back 28 12 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 12 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 12 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 12 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 12 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 12 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 16 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row20 : Row := ⟨20, state20, 20, action20⟩

def state21 (t : Tile) : Nat :=
  match t.val with
  | 0 | 5 | 6 | 7 | 8 | 9 | 12 | 16 | 18 | 21 | 22 | 26 | 33 => 1
  | 1 | 2 | 3 | 4 | 10 | 11 | 13 | 14 | 15 | 19 | 20 | 24 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 17 | 23 => 2
  | 25 => 3
  | _ => 0

def action21 (t : Tile) : Action :=
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
  | 20 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 2) 23)
  | 21 => .win 22 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 23 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 23)
  | 24 => .win 15 (FullWinWitness.standard (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) (.sequence 2 5) 25)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 5) 17)
  | 26 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 26)
  | 27 => .back 28 13 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 13 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 13 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 13 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 13 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 13 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row21 : Row := ⟨21, state21, 21, action21⟩

def state22 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 4 | 5 | 6 | 10 | 11 | 12 | 13 | 19 | 20 | 24 | 27 | 28 | 29 | 30 | 31 => 0
  | 3 | 7 | 9 | 14 | 15 | 16 | 17 | 18 | 21 | 22 | 26 | 32 | 33 => 1
  | 8 | 23 => 2
  | 25 => 3
  | _ => 0

def action22 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 27 13 [.swapSuits 0 1, .swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
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
  | 20 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 23)
  | 21 => .win 22 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 3) (.sequence 2 3) 8)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 3) (.sequence 2 3) 8)
  | 23 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 23)
  | 24 => .win 6 (FullWinWitness.standard (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) (.sequence 2 5) 25)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 3) (.sequence 2 5) 8)
  | 26 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 26)
  | 27 => .back 0 13 [.swapSuits 0 1, .swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 28 => .back 0 13 [.swapSuits 0 1, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 29 => .back 0 13 [.swapSuits 0 1, .swapHonors 2 4, .swapHonors 3 4]
  | 30 => .back 0 13 [.swapSuits 0 1, .swapHonors 3 4]
  | 31 => .back 0 13 [.swapSuits 0 1]
  | 32 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row22 : Row := ⟨22, state22, 22, action22⟩

def state23 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 15 | 19 | 20 | 22 | 23 | 25 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 1 | 5 | 6 | 7 | 8 | 10 | 12 | 13 | 17 | 18 | 21 | 24 | 33 => 1
  | 14 | 26 => 2
  | 16 => 3
  | _ => 0

def action23 (t : Tile) : Action :=
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
  | 21 => .win 21 (FullWinWitness.standard (.triplet 16) (.triplet 21) (.sequence 0 5) (.sequence 1 3) 26)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 2) 26)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 26)
  | 24 => .win 24 (FullWinWitness.standard (.triplet 16) (.triplet 24) (.sequence 0 5) (.sequence 1 3) 26)
  | 25 => .win 1 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 1)
  | 26 => .win 1 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 5) (.sequence 1 3) 1)
  | 27 => .back 28 14 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 14 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 14 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 14 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 14 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 14 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row23 : Row := ⟨23, state23, 23, action23⟩

def state24 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 15 | 19 | 20 | 22 | 23 | 24 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 1 | 5 | 6 | 7 | 8 | 10 | 12 | 13 | 17 | 18 | 21 | 25 | 33 => 1
  | 14 | 26 => 2
  | 16 => 3
  | _ => 0

def action24 (t : Tile) : Action :=
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
  | 21 => .win 21 (FullWinWitness.standard (.triplet 16) (.triplet 21) (.sequence 0 5) (.sequence 1 3) 26)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 2) 26)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 26)
  | 24 => .win 1 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 1)
  | 25 => .win 25 (FullWinWitness.standard (.triplet 16) (.triplet 25) (.sequence 0 5) (.sequence 1 3) 26)
  | 26 => .win 1 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 5) (.sequence 1 3) 1)
  | 27 => .back 28 15 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 15 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 15 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 15 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 15 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 15 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row24 : Row := ⟨24, state24, 24, action24⟩

def state25 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 4 | 5 | 6 | 9 | 11 | 12 | 13 | 18 | 20 | 24 | 27 | 28 | 29 | 30 | 31 => 0
  | 3 | 7 | 10 | 14 | 15 | 16 | 17 | 19 | 21 | 22 | 26 | 32 | 33 => 1
  | 8 | 23 => 2
  | 25 => 3
  | _ => 0

def action25 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 27 15 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 1 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 2 => .win 1 (FullWinWitness.standard (.triplet 25) (.sequence 0 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 3 => .win 3 (FullWinWitness.standard (.triplet 3) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 8)
  | 4 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 2) (.sequence 1 5) (.sequence 2 3) 8)
  | 5 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 3) (.sequence 1 5) (.sequence 2 3) 8)
  | 6 => .win 3 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 3)
  | 7 => .win 7 (FullWinWitness.standard (.triplet 7) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 8)
  | 8 => .win 3 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 3)
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
  | 27 => .back 0 15 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 28 => .back 0 15 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 29 => .back 0 15 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 2 4, .swapHonors 3 4]
  | 30 => .back 0 15 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 3 4]
  | 31 => .back 0 15 [.swapSuits 0 2, .swapSuits 1 2]
  | 32 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row25 : Row := ⟨25, state25, 25, action25⟩

def state26 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 15 | 19 | 20 | 22 | 23 | 25 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 12 | 13 | 17 | 18 | 21 | 24 | 33 => 1
  | 14 | 26 => 2
  | 16 => 3
  | _ => 0

def action26 (t : Tile) : Action :=
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
  | 21 => .win 21 (FullWinWitness.standard (.triplet 16) (.triplet 21) (.sequence 0 5) (.sequence 1 3) 26)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 2) 26)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 26)
  | 24 => .win 24 (FullWinWitness.standard (.triplet 16) (.triplet 24) (.sequence 0 5) (.sequence 1 3) 26)
  | 25 => .win 2 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 2)
  | 26 => .win 2 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 5) (.sequence 1 3) 2)
  | 27 => .back 28 16 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 16 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 16 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 16 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 16 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 16 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row26 : Row := ⟨26, state26, 26, action26⟩

def state27 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 15 | 19 | 20 | 22 | 23 | 24 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 12 | 13 | 17 | 18 | 21 | 25 | 33 => 1
  | 14 | 26 => 2
  | 16 => 3
  | _ => 0

def action27 (t : Tile) : Action :=
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
  | 21 => .win 21 (FullWinWitness.standard (.triplet 16) (.triplet 21) (.sequence 0 5) (.sequence 1 3) 26)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 2) 26)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 26)
  | 24 => .win 2 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 2)
  | 25 => .win 25 (FullWinWitness.standard (.triplet 16) (.triplet 25) (.sequence 0 5) (.sequence 1 3) 26)
  | 26 => .win 2 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 5) (.sequence 1 3) 2)
  | 27 => .back 28 17 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 17 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 17 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 17 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 17 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 17 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row27 : Row := ⟨27, state27, 27, action27⟩

def state28 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 4 | 5 | 6 | 9 | 10 | 12 | 13 | 18 | 20 | 24 | 27 | 28 | 29 | 30 | 31 => 0
  | 3 | 7 | 11 | 14 | 15 | 16 | 17 | 19 | 21 | 22 | 26 | 32 | 33 => 1
  | 8 | 23 => 2
  | 25 => 3
  | _ => 0

def action28 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 27 17 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 1 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 2 => .win 1 (FullWinWitness.standard (.triplet 25) (.sequence 0 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 3 => .win 3 (FullWinWitness.standard (.triplet 3) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 8)
  | 4 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 2) (.sequence 1 5) (.sequence 2 3) 8)
  | 5 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 3) (.sequence 1 5) (.sequence 2 3) 8)
  | 6 => .win 3 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 3)
  | 7 => .win 7 (FullWinWitness.standard (.triplet 7) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 8)
  | 8 => .win 3 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 3)
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
  | 26 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 26)
  | 27 => .back 0 17 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 28 => .back 0 17 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 29 => .back 0 17 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 2 4, .swapHonors 3 4]
  | 30 => .back 0 17 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 3 4]
  | 31 => .back 0 17 [.swapSuits 0 2, .swapSuits 1 2]
  | 32 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 32)
  | 33 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row28 : Row := ⟨28, state28, 28, action28⟩

def state29 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 4 | 9 | 10 | 11 | 15 | 19 | 20 | 22 | 23 | 25 | 27 | 28 | 29 | 30 => 0
  | 5 | 6 | 7 | 8 | 12 | 13 | 17 | 18 | 21 | 24 | 31 | 32 | 33 => 1
  | 14 | 26 => 2
  | 16 => 3
  | _ => 0

def action29 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 9 12 [.swapSuits 1 2]
  | 1 => .back 10 14 []
  | 2 => .back 10 16 []
  | 3 => .win 4 (FullWinWitness.standard (.triplet 16) (.sequence 0 3) (.sequence 0 6) (.sequence 1 3) 26)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 16) (.sequence 0 3) (.sequence 0 6) (.sequence 1 3) 26)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 16) (.sequence 0 6) (.sequence 1 3) 26)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 16) (.sequence 0 4) (.sequence 0 6) (.sequence 1 3) 26)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 0 6) (.sequence 1 3) 26)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 0 5) (.sequence 1 3) 26)
  | 9 => .back 0 12 [.swapSuits 1 2]
  | 10 => .back 2 16 []
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
  | 21 => .win 21 (FullWinWitness.standard (.triplet 16) (.triplet 21) (.sequence 0 5) (.sequence 1 3) 26)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 2) 26)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 26)
  | 24 => .win 24 (FullWinWitness.standard (.triplet 16) (.triplet 24) (.sequence 0 5) (.sequence 1 3) 26)
  | 25 => .win 5 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 6) 5)
  | 26 => .win 5 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 6) (.sequence 1 3) 5)
  | 27 => .back 28 18 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 18 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 18 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 18 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row29 : Row := ⟨29, state29, 29, action29⟩

def state30 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 4 | 9 | 10 | 11 | 15 | 19 | 20 | 22 | 23 | 24 | 27 | 28 | 29 | 30 => 0
  | 5 | 6 | 7 | 8 | 12 | 13 | 17 | 18 | 21 | 25 | 31 | 32 | 33 => 1
  | 14 | 26 => 2
  | 16 => 3
  | _ => 0

def action30 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 9 13 [.swapSuits 1 2]
  | 1 => .back 10 15 []
  | 2 => .back 10 17 []
  | 3 => .win 4 (FullWinWitness.standard (.triplet 16) (.sequence 0 3) (.sequence 0 6) (.sequence 1 3) 26)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 16) (.sequence 0 3) (.sequence 0 6) (.sequence 1 3) 26)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 16) (.sequence 0 6) (.sequence 1 3) 26)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 16) (.sequence 0 4) (.sequence 0 6) (.sequence 1 3) 26)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 0 6) (.sequence 1 3) 26)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 0 5) (.sequence 1 3) 26)
  | 9 => .back 0 13 [.swapSuits 1 2]
  | 10 => .back 2 17 []
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
  | 21 => .win 21 (FullWinWitness.standard (.triplet 16) (.triplet 21) (.sequence 0 5) (.sequence 1 3) 26)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 2) 26)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 26)
  | 24 => .win 5 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 6) 5)
  | 25 => .win 25 (FullWinWitness.standard (.triplet 16) (.triplet 25) (.sequence 0 5) (.sequence 1 3) 26)
  | 26 => .win 5 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 6) (.sequence 1 3) 5)
  | 27 => .back 28 19 [.swapHonors 0 3, .swapHonors 1 2, .swapHonors 2 3]
  | 28 => .back 27 19 [.swapHonors 0 2, .swapHonors 1 3]
  | 29 => .back 27 19 [.swapHonors 0 2, .swapHonors 1 2, .swapHonors 2 3]
  | 30 => .back 27 19 [.swapHonors 0 2, .swapHonors 1 2]
  | 31 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 31)
  | 32 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 32)
  | 33 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row30 : Row := ⟨30, state30, 30, action30⟩

def state31 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 6 | 7 | 10 | 11 | 12 | 13 | 19 | 20 | 22 | 23 | 25 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 0
  | 1 => 3
  | 3 | 26 => 2
  | 4 | 5 | 8 | 9 | 14 | 15 | 16 | 17 | 18 | 21 | 24 => 1
  | _ => 0

def action31 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 27 20 [.swapSuits 0 2, .swapSuits 1 2, .reverseSuit 0, .swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
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
  | 21 => .win 21 (FullWinWitness.standard (.triplet 1) (.triplet 21) (.sequence 0 3) (.sequence 1 5) 26)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 1) (.sequence 0 3) (.sequence 1 5) (.sequence 2 2) 26)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 1) (.sequence 0 3) (.sequence 1 5) (.sequence 2 3) 26)
  | 24 => .win 24 (FullWinWitness.standard (.triplet 1) (.triplet 24) (.sequence 0 3) (.sequence 1 5) 26)
  | 25 => .win 2 (FullWinWitness.standard (.sequence 0 1) (.sequence 0 3) (.sequence 1 5) (.sequence 2 6) 1)
  | 26 => .win 2 (FullWinWitness.standard (.triplet 26) (.sequence 0 1) (.sequence 0 3) (.sequence 1 5) 1)
  | 27 => .back 0 20 [.swapSuits 0 2, .swapSuits 1 2, .reverseSuit 0, .swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 28 => .back 0 20 [.swapSuits 0 2, .swapSuits 1 2, .reverseSuit 0, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 29 => .back 0 20 [.swapSuits 0 2, .swapSuits 1 2, .reverseSuit 0, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 30 => .back 0 20 [.swapSuits 0 2, .swapSuits 1 2, .reverseSuit 0, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 31 => .back 0 20 [.swapSuits 0 2, .swapSuits 1 2, .reverseSuit 0, .swapHonors 4 6, .swapHonors 5 6]
  | 32 => .back 0 20 [.swapSuits 0 2, .swapSuits 1 2, .reverseSuit 0, .swapHonors 5 6]
  | 33 => .back 0 20 [.swapSuits 0 2, .swapSuits 1 2, .reverseSuit 0]
  | _ => .win 0 (FullWinWitness.orphans 0)

def row31 : Row := ⟨31, state31, 31, action31⟩

def state32 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 4 | 5 | 6 | 10 | 11 | 12 | 13 | 19 | 20 | 24 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 0
  | 3 | 7 | 9 | 14 | 15 | 16 | 17 | 18 | 21 | 22 | 26 => 1
  | 8 | 23 => 2
  | 25 => 3
  | _ => 0

def action32 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 27 21 [.swapSuits 0 1, .swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
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
  | 20 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 2) 23)
  | 21 => .win 22 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 3) (.sequence 2 3) 8)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 3) (.sequence 2 3) 8)
  | 23 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 23)
  | 24 => .win 6 (FullWinWitness.standard (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) (.sequence 2 5) 25)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 1 5) (.sequence 2 3) (.sequence 2 5) 8)
  | 26 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 26)
  | 27 => .back 0 21 [.swapSuits 0 1, .swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 28 => .back 0 21 [.swapSuits 0 1, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 29 => .back 0 21 [.swapSuits 0 1, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 30 => .back 0 21 [.swapSuits 0 1, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 31 => .back 0 21 [.swapSuits 0 1, .swapHonors 4 6, .swapHonors 5 6]
  | 32 => .back 0 21 [.swapSuits 0 1, .swapHonors 5 6]
  | 33 => .back 0 21 [.swapSuits 0 1]
  | _ => .win 0 (FullWinWitness.orphans 0)

def row32 : Row := ⟨32, state32, 32, action32⟩

def state33 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 4 | 5 | 6 | 9 | 11 | 15 | 16 | 19 | 20 | 21 | 22 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 3 | 7 | 13 | 14 | 17 | 18 | 23 | 24 | 25 | 26 | 33 => 1
  | 8 | 12 => 2
  | 10 => 3
  | _ => 0

def action33 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 9 21 [.swapSuits 0 1, .swapSuits 1 2, .reverseSuit 1]
  | 1 => .win 2 (FullWinWitness.standard (.triplet 10) (.sequence 0 1) (.sequence 1 3) (.sequence 2 5) 8)
  | 2 => .win 1 (FullWinWitness.standard (.triplet 10) (.sequence 0 1) (.sequence 1 3) (.sequence 2 5) 8)
  | 3 => .win 3 (FullWinWitness.standard (.triplet 3) (.triplet 10) (.sequence 1 3) (.sequence 2 5) 8)
  | 4 => .win 2 (FullWinWitness.standard (.triplet 10) (.sequence 0 2) (.sequence 1 3) (.sequence 2 5) 8)
  | 5 => .win 4 (FullWinWitness.standard (.triplet 10) (.sequence 0 3) (.sequence 1 3) (.sequence 2 5) 8)
  | 6 => .win 3 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 3)
  | 7 => .win 7 (FullWinWitness.standard (.triplet 7) (.triplet 10) (.sequence 1 3) (.sequence 2 5) 8)
  | 8 => .win 3 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 1 3) (.sequence 2 5) 3)
  | 9 => .back 0 21 [.swapSuits 0 1, .swapSuits 1 2, .reverseSuit 1]
  | 10 => .win 11 (FullWinWitness.standard (.triplet 10) (.sequence 1 1) (.sequence 1 3) (.sequence 2 5) 8)
  | 11 => .win 6 (FullWinWitness.standard (.sequence 0 6) (.sequence 1 1) (.sequence 1 3) (.sequence 2 5) 10)
  | 12 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 12)
  | 13 => .win 11 (FullWinWitness.standard (.triplet 10) (.sequence 1 2) (.sequence 1 3) (.sequence 2 5) 8)
  | 14 => .win 13 (FullWinWitness.standard (.triplet 10) (.sequence 1 3) (.sequence 1 3) (.sequence 2 5) 8)
  | 15 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 4) (.sequence 2 5) 12)
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
  | 27 => .back 9 22 [.swapSuits 1 2, .reverseSuit 1, .swapHonors 0 5, .swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | 28 => .back 9 22 [.swapSuits 1 2, .reverseSuit 1, .swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | 29 => .back 9 22 [.swapSuits 1 2, .reverseSuit 1, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | 30 => .back 9 22 [.swapSuits 1 2, .reverseSuit 1, .swapHonors 3 5, .swapHonors 4 5]
  | 31 => .back 9 22 [.swapSuits 1 2, .reverseSuit 1, .swapHonors 4 5]
  | 32 => .back 9 22 [.swapSuits 1 2, .reverseSuit 1]
  | 33 => .win 6 (FullWinWitness.standard (.triplet 10) (.sequence 0 6) (.sequence 1 3) (.sequence 2 5) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row33 : Row := ⟨33, state33, 33, action33⟩

def state34 (t : Tile) : Nat :=
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 15 | 17 | 19 | 20 | 22 | 23 | 25 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 0
  | 1 | 5 | 6 | 7 | 8 | 10 | 12 | 13 | 18 | 21 | 24 => 1
  | 14 | 26 => 2
  | 16 => 3
  | _ => 0

def action34 (t : Tile) : Action :=
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
  | 17 => .back 27 23 [.swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 18 => .win 18 (FullWinWitness.standard (.triplet 16) (.triplet 18) (.sequence 0 5) (.sequence 1 3) 26)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 0) 26)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 0) 26)
  | 21 => .win 21 (FullWinWitness.standard (.triplet 16) (.triplet 21) (.sequence 0 5) (.sequence 1 3) 26)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 2) 26)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 26)
  | 24 => .win 24 (FullWinWitness.standard (.triplet 16) (.triplet 24) (.sequence 0 5) (.sequence 1 3) 26)
  | 25 => .win 1 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 1)
  | 26 => .win 1 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 5) (.sequence 1 3) 1)
  | 27 => .back 17 23 [.swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 28 => .back 17 23 [.swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 29 => .back 17 23 [.swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 30 => .back 17 23 [.swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 31 => .back 17 23 [.swapHonors 4 6, .swapHonors 5 6]
  | 32 => .back 17 23 [.swapHonors 5 6]
  | 33 => .back 17 23 []
  | _ => .win 0 (FullWinWitness.orphans 0)

def row34 : Row := ⟨34, state34, 34, action34⟩

def state35 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 4 | 5 | 6 | 9 | 11 | 12 | 13 | 18 | 20 | 24 | 26 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 3 | 7 | 10 | 14 | 15 | 16 | 17 | 19 | 21 | 22 | 33 => 1
  | 8 | 23 => 2
  | 25 => 3
  | _ => 0

def action35 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 26 24 [.swapSuits 0 2, .swapSuits 1 2]
  | 1 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 2 => .win 1 (FullWinWitness.standard (.triplet 25) (.sequence 0 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 3 => .win 3 (FullWinWitness.standard (.triplet 3) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 8)
  | 4 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 2) (.sequence 1 5) (.sequence 2 3) 8)
  | 5 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 3) (.sequence 1 5) (.sequence 2 3) 8)
  | 6 => .win 3 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 3)
  | 7 => .win 7 (FullWinWitness.standard (.triplet 7) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 8)
  | 8 => .win 3 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 3)
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
  | 26 => .back 0 24 [.swapSuits 0 2, .swapSuits 1 2]
  | 27 => .back 26 25 [.swapHonors 0 5, .swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | 28 => .back 26 25 [.swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | 29 => .back 26 25 [.swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | 30 => .back 26 25 [.swapHonors 3 5, .swapHonors 4 5]
  | 31 => .back 26 25 [.swapHonors 4 5]
  | 32 => .back 26 25 []
  | 33 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row35 : Row := ⟨35, state35, 35, action35⟩

def state36 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 4 | 5 | 6 | 9 | 11 | 12 | 13 | 18 | 20 | 24 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 0
  | 3 | 7 | 10 | 14 | 15 | 16 | 17 | 19 | 21 | 22 | 26 => 1
  | 8 | 23 => 2
  | 25 => 3
  | _ => 0

def action36 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 27 24 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 1 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 2 => .win 1 (FullWinWitness.standard (.triplet 25) (.sequence 0 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 3 => .win 3 (FullWinWitness.standard (.triplet 3) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 8)
  | 4 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 2) (.sequence 1 5) (.sequence 2 3) 8)
  | 5 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 3) (.sequence 1 5) (.sequence 2 3) 8)
  | 6 => .win 3 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 3)
  | 7 => .win 7 (FullWinWitness.standard (.triplet 7) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 8)
  | 8 => .win 3 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 3)
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
  | 27 => .back 0 24 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 28 => .back 0 24 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 29 => .back 0 24 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 30 => .back 0 24 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 31 => .back 0 24 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 4 6, .swapHonors 5 6]
  | 32 => .back 0 24 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 5 6]
  | 33 => .back 0 24 [.swapSuits 0 2, .swapSuits 1 2]
  | _ => .win 0 (FullWinWitness.orphans 0)

def row36 : Row := ⟨36, state36, 36, action36⟩

def state37 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 15 | 17 | 19 | 20 | 22 | 23 | 25 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 0
  | 2 | 5 | 6 | 7 | 8 | 10 | 12 | 13 | 18 | 21 | 24 => 1
  | 14 | 26 => 2
  | 16 => 3
  | _ => 0

def action37 (t : Tile) : Action :=
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
  | 17 => .back 27 26 [.swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 18 => .win 18 (FullWinWitness.standard (.triplet 16) (.triplet 18) (.sequence 0 5) (.sequence 1 3) 26)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 0) 26)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 0) 26)
  | 21 => .win 21 (FullWinWitness.standard (.triplet 16) (.triplet 21) (.sequence 0 5) (.sequence 1 3) 26)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 2) 26)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 26)
  | 24 => .win 24 (FullWinWitness.standard (.triplet 16) (.triplet 24) (.sequence 0 5) (.sequence 1 3) 26)
  | 25 => .win 2 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 2)
  | 26 => .win 2 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 5) (.sequence 1 3) 2)
  | 27 => .back 17 26 [.swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 28 => .back 17 26 [.swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 29 => .back 17 26 [.swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 30 => .back 17 26 [.swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 31 => .back 17 26 [.swapHonors 4 6, .swapHonors 5 6]
  | 32 => .back 17 26 [.swapHonors 5 6]
  | 33 => .back 17 26 []
  | _ => .win 0 (FullWinWitness.orphans 0)

def row37 : Row := ⟨37, state37, 37, action37⟩

def state38 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 4 | 5 | 6 | 9 | 10 | 12 | 13 | 18 | 20 | 24 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 0
  | 3 | 7 | 11 | 14 | 15 | 16 | 17 | 19 | 21 | 22 | 26 => 1
  | 8 | 23 => 2
  | 25 => 3
  | _ => 0

def action38 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 27 27 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 1 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 2 => .win 1 (FullWinWitness.standard (.triplet 25) (.sequence 0 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 3 => .win 3 (FullWinWitness.standard (.triplet 3) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 8)
  | 4 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 2) (.sequence 1 5) (.sequence 2 3) 8)
  | 5 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 3) (.sequence 1 5) (.sequence 2 3) 8)
  | 6 => .win 3 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 3)
  | 7 => .win 7 (FullWinWitness.standard (.triplet 7) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 8)
  | 8 => .win 3 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 3)
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
  | 26 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 26)
  | 27 => .back 0 27 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 28 => .back 0 27 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 29 => .back 0 27 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 30 => .back 0 27 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 31 => .back 0 27 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 4 6, .swapHonors 5 6]
  | 32 => .back 0 27 [.swapSuits 0 2, .swapSuits 1 2, .swapHonors 5 6]
  | 33 => .back 0 27 [.swapSuits 0 2, .swapSuits 1 2]
  | _ => .win 0 (FullWinWitness.orphans 0)

def row38 : Row := ⟨38, state38, 38, action38⟩

def state39 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 4 | 5 | 6 | 9 | 10 | 12 | 13 | 18 | 20 | 24 | 26 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 3 | 7 | 11 | 14 | 15 | 16 | 17 | 19 | 21 | 22 | 33 => 1
  | 8 | 23 => 2
  | 25 => 3
  | _ => 0

def action39 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 26 27 [.swapSuits 0 2, .swapSuits 1 2]
  | 1 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 2 => .win 1 (FullWinWitness.standard (.triplet 25) (.sequence 0 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 3 => .win 3 (FullWinWitness.standard (.triplet 3) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 8)
  | 4 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 2) (.sequence 1 5) (.sequence 2 3) 8)
  | 5 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 3) (.sequence 1 5) (.sequence 2 3) 8)
  | 6 => .win 3 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 3)
  | 7 => .win 7 (FullWinWitness.standard (.triplet 7) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 8)
  | 8 => .win 3 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 3)
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
  | 26 => .back 0 27 [.swapSuits 0 2, .swapSuits 1 2]
  | 27 => .back 26 28 [.swapHonors 0 5, .swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | 28 => .back 26 28 [.swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | 29 => .back 26 28 [.swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | 30 => .back 26 28 [.swapHonors 3 5, .swapHonors 4 5]
  | 31 => .back 26 28 [.swapHonors 4 5]
  | 32 => .back 26 28 []
  | 33 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 5) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row39 : Row := ⟨39, state39, 39, action39⟩

def state40 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 4 | 9 | 10 | 11 | 15 | 19 | 20 | 22 | 23 | 25 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 5 | 6 | 7 | 8 | 12 | 13 | 17 | 18 | 21 | 24 | 33 => 1
  | 14 | 26 => 2
  | 16 => 3
  | _ => 0

def action40 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 9 20 [.swapSuits 1 2]
  | 1 => .back 10 23 []
  | 2 => .back 10 26 []
  | 3 => .win 4 (FullWinWitness.standard (.triplet 16) (.sequence 0 3) (.sequence 0 6) (.sequence 1 3) 26)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 16) (.sequence 0 3) (.sequence 0 6) (.sequence 1 3) 26)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 16) (.sequence 0 6) (.sequence 1 3) 26)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 16) (.sequence 0 4) (.sequence 0 6) (.sequence 1 3) 26)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 0 6) (.sequence 1 3) 26)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 0 5) (.sequence 1 3) 26)
  | 9 => .back 0 20 [.swapSuits 1 2]
  | 10 => .back 2 26 []
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
  | 21 => .win 21 (FullWinWitness.standard (.triplet 16) (.triplet 21) (.sequence 0 5) (.sequence 1 3) 26)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 2) 26)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 26)
  | 24 => .win 24 (FullWinWitness.standard (.triplet 16) (.triplet 24) (.sequence 0 5) (.sequence 1 3) 26)
  | 25 => .win 5 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 6) 5)
  | 26 => .win 5 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 6) (.sequence 1 3) 5)
  | 27 => .back 28 29 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 29 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 29 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 29 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 29 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 29 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 25 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row40 : Row := ⟨40, state40, 40, action40⟩

def state41 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 4 | 9 | 10 | 11 | 15 | 19 | 20 | 22 | 23 | 24 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 5 | 6 | 7 | 8 | 12 | 13 | 17 | 18 | 21 | 25 | 33 => 1
  | 14 | 26 => 2
  | 16 => 3
  | _ => 0

def action41 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 9 21 [.swapSuits 1 2]
  | 1 => .back 10 24 []
  | 2 => .back 10 27 []
  | 3 => .win 4 (FullWinWitness.standard (.triplet 16) (.sequence 0 3) (.sequence 0 6) (.sequence 1 3) 26)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 16) (.sequence 0 3) (.sequence 0 6) (.sequence 1 3) 26)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 16) (.sequence 0 6) (.sequence 1 3) 26)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 16) (.sequence 0 4) (.sequence 0 6) (.sequence 1 3) 26)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 0 6) (.sequence 1 3) 26)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 0 5) (.sequence 1 3) 26)
  | 9 => .back 0 21 [.swapSuits 1 2]
  | 10 => .back 2 27 []
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
  | 21 => .win 21 (FullWinWitness.standard (.triplet 16) (.triplet 21) (.sequence 0 5) (.sequence 1 3) 26)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 2) 26)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 26)
  | 24 => .win 5 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 6) 5)
  | 25 => .win 25 (FullWinWitness.standard (.triplet 16) (.triplet 25) (.sequence 0 5) (.sequence 1 3) 26)
  | 26 => .win 5 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 6) (.sequence 1 3) 5)
  | 27 => .back 28 30 [.swapHonors 0 5, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 28 => .back 27 30 [.swapHonors 0 4, .swapHonors 1 5, .swapHonors 2 4, .swapHonors 3 5]
  | 29 => .back 27 30 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 5, .swapHonors 3 4, .swapHonors 4 5]
  | 30 => .back 27 30 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 5]
  | 31 => .back 27 30 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4, .swapHonors 4 5]
  | 32 => .back 27 30 [.swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 33 => .win 24 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 6) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row41 : Row := ⟨41, state41, 41, action41⟩

def state42 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 4 | 9 | 10 | 11 | 13 | 14 | 15 | 18 | 19 | 20 | 24 | 27 | 28 | 29 | 30 | 31 => 0
  | 5 | 6 | 7 | 8 | 12 | 16 | 21 | 22 | 26 | 32 | 33 => 1
  | 17 | 23 => 2
  | 25 => 3
  | _ => 0

def action42 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 18 22 [.swapSuits 0 1]
  | 1 => .back 19 25 [.swapSuits 0 1]
  | 2 => .back 19 28 [.swapSuits 0 1]
  | 3 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 3) (.sequence 0 6) (.sequence 2 3) 17)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 25) (.sequence 0 3) (.sequence 0 6) (.sequence 2 3) 17)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 25) (.sequence 0 6) (.sequence 2 3) 17)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 4) (.sequence 0 6) (.sequence 2 3) 17)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 0 6) (.sequence 2 3) 17)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 9 => .back 27 30 [.swapSuits 1 2, .swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 10 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 1) (.sequence 2 3) 17)
  | 11 => .win 10 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 1) (.sequence 2 3) 17)
  | 12 => .win 12 (FullWinWitness.standard (.triplet 12) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 13 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 2) (.sequence 2 3) 17)
  | 14 => .win 13 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 17)
  | 15 => .win 5 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 6) (.sequence 2 3) 5)
  | 16 => .win 16 (FullWinWitness.standard (.triplet 16) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 17 => .win 5 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 6) (.sequence 2 3) 5)
  | 18 => .back 0 22 [.swapSuits 0 1]
  | 19 => .back 2 28 [.swapSuits 0 1]
  | 20 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 2) 23)
  | 21 => .win 22 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 23 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 23)
  | 24 => .win 15 (FullWinWitness.standard (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) (.sequence 2 5) 25)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 5) 17)
  | 26 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 26)
  | 27 => .back 9 30 [.swapSuits 1 2, .swapHonors 0 4, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 28 => .back 9 30 [.swapSuits 1 2, .swapHonors 1 4, .swapHonors 2 4, .swapHonors 3 4]
  | 29 => .back 9 30 [.swapSuits 1 2, .swapHonors 2 4, .swapHonors 3 4]
  | 30 => .back 9 30 [.swapSuits 1 2, .swapHonors 3 4]
  | 31 => .back 9 30 [.swapSuits 1 2]
  | 32 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 32)
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row42 : Row := ⟨42, state42, 42, action42⟩

def state43 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 4 | 5 | 6 | 7 | 9 | 11 | 15 | 16 | 19 | 20 | 21 | 22 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 0
  | 3 | 13 | 14 | 17 | 18 | 23 | 24 | 25 | 26 => 1
  | 8 | 12 => 2
  | 10 => 3
  | _ => 0

def action43 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 6 31 [.swapSuits 0 2, .swapSuits 1 2]
  | 1 => .win 2 (FullWinWitness.standard (.triplet 10) (.sequence 0 1) (.sequence 1 3) (.sequence 2 5) 8)
  | 2 => .win 1 (FullWinWitness.standard (.triplet 10) (.sequence 0 1) (.sequence 1 3) (.sequence 2 5) 8)
  | 3 => .win 3 (FullWinWitness.standard (.triplet 3) (.triplet 10) (.sequence 1 3) (.sequence 2 5) 8)
  | 4 => .win 2 (FullWinWitness.standard (.triplet 10) (.sequence 0 2) (.sequence 1 3) (.sequence 2 5) 8)
  | 5 => .win 4 (FullWinWitness.standard (.triplet 10) (.sequence 0 3) (.sequence 1 3) (.sequence 2 5) 8)
  | 6 => .back 0 31 [.swapSuits 0 2, .swapSuits 1 2]
  | 7 => .back 9 32 [.swapSuits 1 2, .reverseSuit 1]
  | 8 => .win 3 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 1 3) (.sequence 2 5) 3)
  | 9 => .back 7 32 [.swapSuits 1 2, .reverseSuit 1]
  | 10 => .win 11 (FullWinWitness.standard (.triplet 10) (.sequence 1 1) (.sequence 1 3) (.sequence 2 5) 8)
  | 11 => .win 8 (FullWinWitness.standard (.triplet 8) (.sequence 1 1) (.sequence 1 3) (.sequence 2 5) 10)
  | 12 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 1 3) (.sequence 2 5) 12)
  | 13 => .win 11 (FullWinWitness.standard (.triplet 10) (.sequence 1 2) (.sequence 1 3) (.sequence 2 5) 8)
  | 14 => .win 13 (FullWinWitness.standard (.triplet 10) (.sequence 1 3) (.sequence 1 3) (.sequence 2 5) 8)
  | 15 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 1 4) (.sequence 2 5) 12)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 10) (.sequence 1 3) (.sequence 1 6) (.sequence 2 5) 8)
  | 17 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 1 3) (.sequence 2 5) 17)
  | 18 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 1 3) (.sequence 2 5) 18)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 10) (.sequence 1 3) (.sequence 2 0) (.sequence 2 5) 8)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 10) (.sequence 1 3) (.sequence 2 0) (.sequence 2 5) 8)
  | 21 => .win 22 (FullWinWitness.standard (.triplet 10) (.sequence 1 3) (.sequence 2 3) (.sequence 2 6) 8)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 10) (.sequence 1 3) (.sequence 2 3) (.sequence 2 6) 8)
  | 23 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 1 3) (.sequence 2 6) 23)
  | 24 => .win 22 (FullWinWitness.standard (.triplet 10) (.sequence 1 3) (.sequence 2 4) (.sequence 2 6) 8)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 10) (.sequence 1 3) (.sequence 2 5) (.sequence 2 6) 8)
  | 26 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 10) (.sequence 1 3) (.sequence 2 5) 26)
  | 27 => .back 7 33 [.swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 28 => .back 7 33 [.swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 29 => .back 7 33 [.swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 30 => .back 7 33 [.swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 31 => .back 7 33 [.swapHonors 4 6, .swapHonors 5 6]
  | 32 => .back 7 33 [.swapHonors 5 6]
  | 33 => .back 7 33 []
  | _ => .win 0 (FullWinWitness.orphans 0)

def row43 : Row := ⟨43, state43, 43, action43⟩

def state44 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 4 | 5 | 6 | 7 | 9 | 11 | 12 | 13 | 18 | 20 | 24 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 0
  | 3 | 10 | 14 | 15 | 16 | 17 | 19 | 21 | 22 => 1
  | 8 | 23 => 2
  | 25 => 3
  | _ => 0

def action44 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 6 34 [.swapSuits 0 2, .swapSuits 1 2]
  | 1 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 2 => .win 1 (FullWinWitness.standard (.triplet 25) (.sequence 0 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 3 => .win 3 (FullWinWitness.standard (.triplet 3) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 8)
  | 4 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 2) (.sequence 1 5) (.sequence 2 3) 8)
  | 5 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 3) (.sequence 1 5) (.sequence 2 3) 8)
  | 6 => .back 0 34 [.swapSuits 0 2, .swapSuits 1 2]
  | 7 => .back 27 35 [.swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 8 => .win 3 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 3)
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
  | 26 => .back 7 36 []
  | 27 => .back 7 35 [.swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 28 => .back 7 35 [.swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 29 => .back 7 35 [.swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 30 => .back 7 35 [.swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 31 => .back 7 35 [.swapHonors 4 6, .swapHonors 5 6]
  | 32 => .back 7 35 [.swapHonors 5 6]
  | 33 => .back 7 35 []
  | _ => .win 0 (FullWinWitness.orphans 0)

def row44 : Row := ⟨44, state44, 44, action44⟩

def state45 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 4 | 5 | 6 | 7 | 9 | 10 | 12 | 13 | 18 | 20 | 24 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 0
  | 3 | 11 | 14 | 15 | 16 | 17 | 19 | 21 | 22 => 1
  | 8 | 23 => 2
  | 25 => 3
  | _ => 0

def action45 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 6 37 [.swapSuits 0 2, .swapSuits 1 2]
  | 1 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 2 => .win 1 (FullWinWitness.standard (.triplet 25) (.sequence 0 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 3 => .win 3 (FullWinWitness.standard (.triplet 3) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 8)
  | 4 => .win 2 (FullWinWitness.standard (.triplet 25) (.sequence 0 2) (.sequence 1 5) (.sequence 2 3) 8)
  | 5 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 3) (.sequence 1 5) (.sequence 2 3) 8)
  | 6 => .back 0 37 [.swapSuits 0 2, .swapSuits 1 2]
  | 7 => .back 26 38 []
  | 8 => .win 3 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 3)
  | 9 => .win 10 (FullWinWitness.standard (.triplet 25) (.sequence 1 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 10 => .win 9 (FullWinWitness.standard (.triplet 25) (.sequence 1 0) (.sequence 1 5) (.sequence 2 3) 8)
  | 11 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 1 5) (.sequence 2 3) 11)
  | 12 => .win 10 (FullWinWitness.standard (.triplet 25) (.sequence 1 1) (.sequence 1 5) (.sequence 2 3) 8)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 25) (.sequence 1 2) (.sequence 1 5) (.sequence 2 3) 8)
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
  | 26 => .back 7 38 []
  | 27 => .back 7 39 [.swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 28 => .back 7 39 [.swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 29 => .back 7 39 [.swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 30 => .back 7 39 [.swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 31 => .back 7 39 [.swapHonors 4 6, .swapHonors 5 6]
  | 32 => .back 7 39 [.swapHonors 5 6]
  | 33 => .back 7 39 []
  | _ => .win 0 (FullWinWitness.orphans 0)

def row45 : Row := ⟨45, state45, 45, action45⟩

def state46 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 4 | 9 | 10 | 11 | 15 | 17 | 19 | 20 | 22 | 23 | 25 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 0
  | 5 | 6 | 7 | 8 | 12 | 13 | 18 | 21 | 24 => 1
  | 14 | 26 => 2
  | 16 => 3
  | _ => 0

def action46 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 9 31 [.swapSuits 0 1, .reverseSuit 1]
  | 1 => .back 10 34 []
  | 2 => .back 10 37 []
  | 3 => .win 4 (FullWinWitness.standard (.triplet 16) (.sequence 0 3) (.sequence 0 6) (.sequence 1 3) 26)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 16) (.sequence 0 3) (.sequence 0 6) (.sequence 1 3) 26)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 16) (.sequence 0 6) (.sequence 1 3) 26)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 16) (.sequence 0 4) (.sequence 0 6) (.sequence 1 3) 26)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 0 6) (.sequence 1 3) 26)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 16) (.sequence 0 5) (.sequence 1 3) 26)
  | 9 => .back 0 31 [.swapSuits 0 1, .reverseSuit 1]
  | 10 => .back 2 37 []
  | 11 => .win 14 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 5) (.sequence 1 2) 26)
  | 12 => .win 13 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 1 3) 26)
  | 13 => .win 12 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 1 3) 26)
  | 14 => .win 11 (FullWinWitness.standard (.triplet 14) (.triplet 16) (.sequence 0 5) (.sequence 1 2) 26)
  | 15 => .win 13 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 1 4) 26)
  | 16 => .win 15 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 1 5) 26)
  | 17 => .back 27 40 [.swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 18 => .win 18 (FullWinWitness.standard (.triplet 16) (.triplet 18) (.sequence 0 5) (.sequence 1 3) 26)
  | 19 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 0) 26)
  | 20 => .win 19 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 0) 26)
  | 21 => .win 21 (FullWinWitness.standard (.triplet 16) (.triplet 21) (.sequence 0 5) (.sequence 1 3) 26)
  | 22 => .win 20 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 2) 26)
  | 23 => .win 22 (FullWinWitness.standard (.triplet 16) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 26)
  | 24 => .win 24 (FullWinWitness.standard (.triplet 16) (.triplet 24) (.sequence 0 5) (.sequence 1 3) 26)
  | 25 => .win 5 (FullWinWitness.standard (.triplet 16) (.sequence 0 6) (.sequence 1 3) (.sequence 2 6) 5)
  | 26 => .win 5 (FullWinWitness.standard (.triplet 16) (.triplet 26) (.sequence 0 6) (.sequence 1 3) 5)
  | 27 => .back 17 40 [.swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 28 => .back 17 40 [.swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 29 => .back 17 40 [.swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 30 => .back 17 40 [.swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 31 => .back 17 40 [.swapHonors 4 6, .swapHonors 5 6]
  | 32 => .back 17 40 [.swapHonors 5 6]
  | 33 => .back 17 40 []
  | _ => .win 0 (FullWinWitness.orphans 0)

def row46 : Row := ⟨46, state46, 46, action46⟩

def state47 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 4 | 9 | 10 | 11 | 13 | 14 | 15 | 18 | 19 | 20 | 24 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 0
  | 5 | 6 | 7 | 8 | 12 | 16 | 21 | 22 | 26 => 1
  | 17 | 23 => 2
  | 25 => 3
  | _ => 0

def action47 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 18 32 [.swapSuits 0 1]
  | 1 => .back 19 36 [.swapSuits 0 1]
  | 2 => .back 19 38 [.swapSuits 0 1]
  | 3 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 3) (.sequence 0 6) (.sequence 2 3) 17)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 25) (.sequence 0 3) (.sequence 0 6) (.sequence 2 3) 17)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 25) (.sequence 0 6) (.sequence 2 3) 17)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 4) (.sequence 0 6) (.sequence 2 3) 17)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 0 6) (.sequence 2 3) 17)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 9 => .back 27 41 [.swapSuits 1 2, .swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 10 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 1) (.sequence 2 3) 17)
  | 11 => .win 10 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 1) (.sequence 2 3) 17)
  | 12 => .win 12 (FullWinWitness.standard (.triplet 12) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 13 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 2) (.sequence 2 3) 17)
  | 14 => .win 13 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 17)
  | 15 => .win 5 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 6) (.sequence 2 3) 5)
  | 16 => .win 16 (FullWinWitness.standard (.triplet 16) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 17 => .win 5 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 6) (.sequence 2 3) 5)
  | 18 => .back 0 32 [.swapSuits 0 1]
  | 19 => .back 2 38 [.swapSuits 0 1]
  | 20 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 2) 23)
  | 21 => .win 22 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 23 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 23)
  | 24 => .win 15 (FullWinWitness.standard (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) (.sequence 2 5) 25)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 5) 17)
  | 26 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 26)
  | 27 => .back 9 41 [.swapSuits 1 2, .swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 28 => .back 9 41 [.swapSuits 1 2, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 29 => .back 9 41 [.swapSuits 1 2, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 30 => .back 9 41 [.swapSuits 1 2, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 31 => .back 9 41 [.swapSuits 1 2, .swapHonors 4 6, .swapHonors 5 6]
  | 32 => .back 9 41 [.swapSuits 1 2, .swapHonors 5 6]
  | 33 => .back 9 41 [.swapSuits 1 2]
  | _ => .win 0 (FullWinWitness.orphans 0)

def row47 : Row := ⟨47, state47, 47, action47⟩

def state48 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 4 | 9 | 10 | 11 | 13 | 14 | 15 | 18 | 19 | 20 | 24 | 26 | 27 | 28 | 29 | 30 | 31 | 32 => 0
  | 5 | 6 | 7 | 8 | 12 | 16 | 21 | 22 | 33 => 1
  | 17 | 23 => 2
  | 25 => 3
  | _ => 0

def action48 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 18 33 [.swapSuits 0 2, .swapSuits 1 2, .reverseSuit 2]
  | 1 => .back 19 35 [.swapSuits 0 1]
  | 2 => .back 19 39 [.swapSuits 0 1]
  | 3 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 3) (.sequence 0 6) (.sequence 2 3) 17)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 25) (.sequence 0 3) (.sequence 0 6) (.sequence 2 3) 17)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 25) (.sequence 0 6) (.sequence 2 3) 17)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 4) (.sequence 0 6) (.sequence 2 3) 17)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 0 6) (.sequence 2 3) 17)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 9 => .back 26 41 [.swapSuits 1 2]
  | 10 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 1) (.sequence 2 3) 17)
  | 11 => .win 10 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 1) (.sequence 2 3) 17)
  | 12 => .win 12 (FullWinWitness.standard (.triplet 12) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 13 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 2) (.sequence 2 3) 17)
  | 14 => .win 13 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 17)
  | 15 => .win 5 (FullWinWitness.standard (.triplet 25) (.sequence 0 6) (.sequence 1 6) (.sequence 2 3) 5)
  | 16 => .win 16 (FullWinWitness.standard (.triplet 16) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 17 => .win 5 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 6) (.sequence 2 3) 5)
  | 18 => .back 0 33 [.swapSuits 0 2, .swapSuits 1 2, .reverseSuit 2]
  | 19 => .back 1 35 [.swapSuits 0 1]
  | 20 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 2) 23)
  | 21 => .win 22 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 23 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 23)
  | 24 => .win 15 (FullWinWitness.standard (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) (.sequence 2 5) 25)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 5) 17)
  | 26 => .back 9 41 [.swapSuits 1 2]
  | 27 => .back 26 42 [.swapHonors 0 5, .swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | 28 => .back 26 42 [.swapHonors 1 5, .swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | 29 => .back 26 42 [.swapHonors 2 5, .swapHonors 3 5, .swapHonors 4 5]
  | 30 => .back 26 42 [.swapHonors 3 5, .swapHonors 4 5]
  | 31 => .back 26 42 [.swapHonors 4 5]
  | 32 => .back 26 42 []
  | 33 => .win 15 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 6) (.sequence 2 3) 33)
  | _ => .win 0 (FullWinWitness.orphans 0)

def row48 : Row := ⟨48, state48, 48, action48⟩

def state49 (t : Tile) : Nat :=
  match t.val with
  | 0 | 1 | 2 | 3 | 4 | 9 | 10 | 11 | 13 | 14 | 15 | 16 | 18 | 19 | 20 | 24 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 0
  | 5 | 6 | 7 | 8 | 12 | 21 | 22 => 1
  | 17 | 23 => 2
  | 25 => 3
  | _ => 0

def action49 (t : Tile) : Action :=
  match t.val with
  | 0 => .back 18 43 [.swapSuits 0 2, .swapSuits 1 2, .reverseSuit 2]
  | 1 => .back 19 44 [.swapSuits 0 1]
  | 2 => .back 19 45 [.swapSuits 0 1]
  | 3 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 3) (.sequence 0 6) (.sequence 2 3) 17)
  | 4 => .win 3 (FullWinWitness.standard (.triplet 25) (.sequence 0 3) (.sequence 0 6) (.sequence 2 3) 17)
  | 5 => .win 5 (FullWinWitness.standard (.triplet 5) (.triplet 25) (.sequence 0 6) (.sequence 2 3) 17)
  | 6 => .win 4 (FullWinWitness.standard (.triplet 25) (.sequence 0 4) (.sequence 0 6) (.sequence 2 3) 17)
  | 7 => .win 6 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 0 6) (.sequence 2 3) 17)
  | 8 => .win 8 (FullWinWitness.standard (.triplet 8) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 9 => .back 15 46 [.swapSuits 1 2]
  | 10 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 1) (.sequence 2 3) 17)
  | 11 => .win 10 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 1) (.sequence 2 3) 17)
  | 12 => .win 12 (FullWinWitness.standard (.triplet 12) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 17)
  | 13 => .win 11 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 2) (.sequence 2 3) 17)
  | 14 => .win 13 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 1 3) (.sequence 2 3) 17)
  | 15 => .back 9 46 [.swapSuits 1 2]
  | 16 => .back 26 47 []
  | 17 => .win 5 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 6) (.sequence 2 3) 5)
  | 18 => .back 0 43 [.swapSuits 0 2, .swapSuits 1 2, .reverseSuit 2]
  | 19 => .back 2 45 [.swapSuits 0 1]
  | 20 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 2) 23)
  | 21 => .win 22 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 22 => .win 21 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 3) 17)
  | 23 => .win 17 (FullWinWitness.standard (.triplet 17) (.triplet 25) (.sequence 0 5) (.sequence 2 3) 23)
  | 24 => .win 17 (FullWinWitness.standard (.triplet 17) (.sequence 0 5) (.sequence 2 3) (.sequence 2 5) 25)
  | 25 => .win 24 (FullWinWitness.standard (.triplet 25) (.sequence 0 5) (.sequence 2 3) (.sequence 2 5) 17)
  | 26 => .back 16 47 []
  | 27 => .back 16 48 [.swapHonors 0 6, .swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 28 => .back 16 48 [.swapHonors 1 6, .swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 29 => .back 16 48 [.swapHonors 2 6, .swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 30 => .back 16 48 [.swapHonors 3 6, .swapHonors 4 6, .swapHonors 5 6]
  | 31 => .back 16 48 [.swapHonors 4 6, .swapHonors 5 6]
  | 32 => .back 16 48 [.swapHonors 5 6]
  | 33 => .back 16 48 []
  | _ => .win 0 (FullWinWitness.orphans 0)

def row49 : Row := ⟨49, state49, 49, action49⟩

def database : Tree := (.branch (.branch (.branch (.branch (.branch (.branch .empty row0 .empty) row1 (.branch .empty row2 .empty)) row3 (.branch (.branch .empty row4 .empty) row5 .empty)) row6 (.branch (.branch (.branch .empty row7 .empty) row8 .empty) row9 (.branch (.branch .empty row10 .empty) row11 .empty))) row12 (.branch (.branch (.branch (.branch .empty row13 .empty) row14 (.branch .empty row15 .empty)) row16 (.branch (.branch .empty row17 .empty) row18 .empty)) row19 (.branch (.branch (.branch .empty row20 .empty) row21 .empty) row22 (.branch (.branch .empty row23 .empty) row24 .empty)))) row25 (.branch (.branch (.branch (.branch (.branch .empty row26 .empty) row27 (.branch .empty row28 .empty)) row29 (.branch (.branch .empty row30 .empty) row31 .empty)) row32 (.branch (.branch (.branch .empty row33 .empty) row34 .empty) row35 (.branch (.branch .empty row36 .empty) row37 .empty))) row38 (.branch (.branch (.branch (.branch .empty row39 .empty) row40 .empty) row41 (.branch (.branch .empty row42 .empty) row43 .empty)) row44 (.branch (.branch (.branch .empty row45 .empty) row46 .empty) row47 (.branch (.branch .empty row48 .empty) row49 .empty)))))

end Mahjong.Actual14
