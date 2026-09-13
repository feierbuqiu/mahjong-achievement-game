import Mahjong.StandardBoundCertificate

set_option maxRecDepth 8192
set_option maxHeartbeats 20000000

namespace Mahjong.Scale12LeavesV1.L000068
open StandardBoundCertificate

def state : State := fun t =>
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 12 | 13 | 15 | 16 | 18 | 24 | 25 => 0
  | 17 => 2
  | 19 => 3
  | _ => 1

def caps000 : StandardBoundCert := fun p =>
  match p.val with
  | 17 => ⟨1, 0, 2, 0⟩
  | 19 => ⟨1, 0, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps001 : StandardBoundCert := fun p =>
  match p.val with
  | 2 => ⟨1, 0, 2, 0⟩
  | 17 => ⟨1, 0, 2, 0⟩
  | 19 => ⟨1, 0, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps002 : StandardBoundCert := fun p =>
  match p.val with
  | 5 => ⟨1, 0, 2, 0⟩
  | 17 => ⟨1, 0, 2, 0⟩
  | 19 => ⟨1, 0, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps003 : StandardBoundCert := fun p =>
  match p.val with
  | 6 => ⟨0, 0, 2, 0⟩
  | 17 => ⟨1, 0, 2, 0⟩
  | 19 => ⟨1, 0, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps004 : StandardBoundCert := fun p =>
  match p.val with
  | 7 => ⟨0, 0, 2, 0⟩
  | 17 => ⟨1, 0, 2, 0⟩
  | 19 => ⟨1, 0, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps005 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨1, 0, 2, 0⟩
  | 17 => ⟨1, 0, 2, 0⟩
  | 19 => ⟨1, 0, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps006 : StandardBoundCert := fun p =>
  match p.val with
  | 10 => ⟨1, 0, 2, 0⟩
  | 17 => ⟨1, 0, 2, 0⟩
  | 19 => ⟨1, 0, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps007 : StandardBoundCert := fun p =>
  match p.val with
  | 14 => ⟨1, 0, 2, 0⟩
  | 17 => ⟨1, 0, 2, 0⟩
  | 19 => ⟨1, 0, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps008 : StandardBoundCert := fun p =>
  match p.val with
  | 17 => ⟨1, 0, 2, 0⟩
  | 19 => ⟨1, 1, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps009 : StandardBoundCert := fun p =>
  match p.val with
  | 17 => ⟨1, 0, 2, 0⟩
  | 19 => ⟨1, 0, 2, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps010 : StandardBoundCert := fun p =>
  match p.val with
  | 17 => ⟨1, 0, 2, 0⟩
  | 19 => ⟨1, 0, 1, 0⟩
  | 20 => ⟨1, 0, 2, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps011 : StandardBoundCert := fun p =>
  match p.val with
  | 17 => ⟨1, 0, 2, 0⟩
  | 19 => ⟨1, 0, 2, 0⟩
  | 21 => ⟨1, 0, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps012 : StandardBoundCert := fun p =>
  match p.val with
  | 17 => ⟨1, 0, 2, 0⟩
  | 19 => ⟨1, 0, 1, 0⟩
  | 22 => ⟨1, 0, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps013 : StandardBoundCert := fun p =>
  match p.val with
  | 17 => ⟨1, 0, 2, 0⟩
  | 19 => ⟨1, 0, 1, 0⟩
  | 23 => ⟨1, 0, 2, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps014 : StandardBoundCert := fun p =>
  match p.val with
  | 17 => ⟨1, 0, 2, 0⟩
  | 19 => ⟨1, 0, 1, 0⟩
  | 26 => ⟨1, 0, 2, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps015 : StandardBoundCert := fun p =>
  match p.val with
  | 17 => ⟨1, 0, 2, 0⟩
  | 19 => ⟨1, 0, 1, 0⟩
  | 27 => ⟨1, 0, 2, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps016 : StandardBoundCert := fun p =>
  match p.val with
  | 17 => ⟨1, 0, 2, 0⟩
  | 19 => ⟨1, 0, 1, 0⟩
  | 28 => ⟨1, 0, 2, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps017 : StandardBoundCert := fun p =>
  match p.val with
  | 17 => ⟨1, 0, 2, 0⟩
  | 19 => ⟨1, 0, 1, 0⟩
  | 29 => ⟨1, 0, 2, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps018 : StandardBoundCert := fun p =>
  match p.val with
  | 17 => ⟨1, 0, 2, 0⟩
  | 19 => ⟨1, 0, 1, 0⟩
  | 30 => ⟨1, 0, 2, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps019 : StandardBoundCert := fun p =>
  match p.val with
  | 17 => ⟨1, 0, 2, 0⟩
  | 19 => ⟨1, 0, 1, 0⟩
  | 31 => ⟨1, 0, 2, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps020 : StandardBoundCert := fun p =>
  match p.val with
  | 17 => ⟨1, 0, 2, 0⟩
  | 19 => ⟨1, 0, 1, 0⟩
  | 32 => ⟨1, 0, 2, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps021 : StandardBoundCert := fun p =>
  match p.val with
  | 17 => ⟨1, 0, 2, 0⟩
  | 19 => ⟨1, 0, 1, 0⟩
  | 33 => ⟨1, 0, 2, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def baseCaps : StandardBoundCert := caps000

def childCaps : Tile → StandardBoundCert := fun t =>
  match t.val with
  | 0 => caps000
  | 1 => caps000
  | 2 => caps001
  | 3 => caps000
  | 4 => caps000
  | 5 => caps002
  | 6 => caps003
  | 7 => caps004
  | 8 => caps005
  | 9 => caps000
  | 10 => caps006
  | 11 => caps000
  | 12 => caps000
  | 13 => caps000
  | 14 => caps007
  | 15 => caps000
  | 16 => caps000
  | 17 => caps008
  | 18 => caps009
  | 19 => caps000
  | 20 => caps010
  | 21 => caps011
  | 22 => caps012
  | 23 => caps013
  | 24 => caps009
  | 25 => caps000
  | 26 => caps014
  | 27 => caps015
  | 28 => caps016
  | 29 => caps017
  | 30 => caps018
  | 31 => caps019
  | 32 => caps020
  | 33 => caps021
  | _ => fun _ => ⟨0, 0, 0, 0⟩

end Mahjong.Scale12LeavesV1.L000068
