import Mahjong.StandardBoundCertificate

set_option maxRecDepth 8192
set_option maxHeartbeats 20000000

namespace Mahjong.Scale12LeavesV1.L000057
open StandardBoundCertificate

def state : State := fun t =>
  match t.val with
  | 0 | 2 | 3 | 4 | 6 | 7 | 10 | 11 | 12 | 13 | 19 | 20 | 24 | 27 => 0
  | 8 | 21 => 2
  | 25 => 3
  | _ => 1

def caps000 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 1, 2, 0⟩
  | 21 => ⟨0, 1, 1, 0⟩
  | 25 => ⟨0, 1, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps001 : StandardBoundCert := fun p =>
  match p.val with
  | 1 => ⟨0, 1, 2, 0⟩
  | 8 => ⟨0, 1, 2, 0⟩
  | 21 => ⟨0, 1, 1, 0⟩
  | 25 => ⟨0, 1, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps002 : StandardBoundCert := fun p =>
  match p.val with
  | 5 => ⟨0, 1, 2, 0⟩
  | 8 => ⟨0, 1, 2, 0⟩
  | 21 => ⟨0, 1, 1, 0⟩
  | 25 => ⟨0, 1, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps003 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 1, 2, 0⟩
  | 21 => ⟨1, 1, 1, 0⟩
  | 25 => ⟨1, 1, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps004 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 1, 2, 0⟩
  | 9 => ⟨0, 1, 2, 0⟩
  | 21 => ⟨0, 1, 1, 0⟩
  | 25 => ⟨0, 1, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps005 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 1, 2, 0⟩
  | 14 => ⟨0, 1, 2, 0⟩
  | 21 => ⟨0, 1, 1, 0⟩
  | 25 => ⟨0, 1, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps006 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 1, 2, 0⟩
  | 15 => ⟨0, 0, 2, 0⟩
  | 21 => ⟨0, 1, 1, 0⟩
  | 25 => ⟨0, 1, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps007 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 1, 2, 0⟩
  | 16 => ⟨0, 0, 2, 0⟩
  | 21 => ⟨0, 1, 1, 0⟩
  | 25 => ⟨0, 1, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps008 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 1, 2, 0⟩
  | 17 => ⟨0, 1, 2, 0⟩
  | 21 => ⟨0, 1, 1, 0⟩
  | 25 => ⟨0, 1, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps009 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 1, 2, 0⟩
  | 18 => ⟨0, 1, 2, 0⟩
  | 21 => ⟨0, 1, 1, 0⟩
  | 25 => ⟨0, 1, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps010 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 1, 2, 0⟩
  | 21 => ⟨0, 1, 2, 0⟩
  | 25 => ⟨0, 1, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps011 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 1, 2, 0⟩
  | 21 => ⟨0, 1, 1, 0⟩
  | 22 => ⟨0, 1, 1, 0⟩
  | 25 => ⟨0, 1, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps012 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 1, 2, 0⟩
  | 21 => ⟨0, 1, 1, 0⟩
  | 23 => ⟨0, 1, 1, 0⟩
  | 25 => ⟨0, 1, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps013 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 1, 2, 0⟩
  | 21 => ⟨0, 1, 2, 0⟩
  | 25 => ⟨0, 1, 2, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps014 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 1, 2, 0⟩
  | 21 => ⟨0, 1, 1, 0⟩
  | 25 => ⟨0, 1, 1, 0⟩
  | 26 => ⟨0, 1, 2, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps015 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 1, 2, 0⟩
  | 21 => ⟨0, 1, 1, 0⟩
  | 25 => ⟨0, 1, 1, 0⟩
  | 28 => ⟨0, 1, 2, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps016 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 1, 2, 0⟩
  | 21 => ⟨0, 1, 1, 0⟩
  | 25 => ⟨0, 1, 1, 0⟩
  | 29 => ⟨0, 1, 2, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps017 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 1, 2, 0⟩
  | 21 => ⟨0, 1, 1, 0⟩
  | 25 => ⟨0, 1, 1, 0⟩
  | 30 => ⟨0, 1, 2, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps018 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 1, 2, 0⟩
  | 21 => ⟨0, 1, 1, 0⟩
  | 25 => ⟨0, 1, 1, 0⟩
  | 31 => ⟨0, 1, 2, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps019 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 1, 2, 0⟩
  | 21 => ⟨0, 1, 1, 0⟩
  | 25 => ⟨0, 1, 1, 0⟩
  | 32 => ⟨0, 1, 2, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps020 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 1, 2, 0⟩
  | 21 => ⟨0, 1, 1, 0⟩
  | 25 => ⟨0, 1, 1, 0⟩
  | 33 => ⟨0, 1, 2, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def baseCaps : StandardBoundCert := caps000

def childCaps : Tile → StandardBoundCert := fun t =>
  match t.val with
  | 0 => caps000
  | 1 => caps001
  | 2 => caps000
  | 3 => caps000
  | 4 => caps000
  | 5 => caps002
  | 6 => caps000
  | 7 => caps000
  | 8 => caps003
  | 9 => caps004
  | 10 => caps000
  | 11 => caps000
  | 12 => caps000
  | 13 => caps000
  | 14 => caps005
  | 15 => caps006
  | 16 => caps007
  | 17 => caps008
  | 18 => caps009
  | 19 => caps000
  | 20 => caps000
  | 21 => caps010
  | 22 => caps011
  | 23 => caps012
  | 24 => caps013
  | 25 => caps000
  | 26 => caps014
  | 27 => caps000
  | 28 => caps015
  | 29 => caps016
  | 30 => caps017
  | 31 => caps018
  | 32 => caps019
  | 33 => caps020
  | _ => fun _ => ⟨0, 0, 0, 0⟩

end Mahjong.Scale12LeavesV1.L000057
