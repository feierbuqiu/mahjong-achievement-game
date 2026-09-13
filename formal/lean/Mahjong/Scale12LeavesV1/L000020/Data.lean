import Mahjong.StandardBoundCertificate

set_option maxRecDepth 8192
set_option maxHeartbeats 20000000

namespace Mahjong.Scale12LeavesV1.L000020
open StandardBoundCertificate

def state : State := fun t =>
  match t.val with
  | 0 | 1 | 3 | 4 | 9 | 11 | 15 | 16 | 19 | 20 | 22 | 23 | 24 => 0
  | 10 => 4
  | 14 | 26 => 2
  | _ => 1

def caps000 : StandardBoundCert := fun p =>
  match p.val with
  | 10 => ⟨1, 1, 0, 0⟩
  | 14 => ⟨1, 1, 0, 0⟩
  | 26 => ⟨1, 2, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps001 : StandardBoundCert := fun p =>
  match p.val with
  | 2 => ⟨1, 2, 0, 0⟩
  | 10 => ⟨1, 1, 0, 0⟩
  | 14 => ⟨1, 1, 0, 0⟩
  | 26 => ⟨1, 2, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps002 : StandardBoundCert := fun p =>
  match p.val with
  | 5 => ⟨1, 2, 0, 0⟩
  | 10 => ⟨1, 1, 0, 0⟩
  | 14 => ⟨1, 1, 0, 0⟩
  | 26 => ⟨1, 2, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps003 : StandardBoundCert := fun p =>
  match p.val with
  | 6 => ⟨0, 2, 0, 0⟩
  | 10 => ⟨1, 1, 0, 0⟩
  | 14 => ⟨1, 1, 0, 0⟩
  | 26 => ⟨1, 2, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps004 : StandardBoundCert := fun p =>
  match p.val with
  | 7 => ⟨0, 2, 0, 0⟩
  | 10 => ⟨1, 1, 0, 0⟩
  | 14 => ⟨1, 1, 0, 0⟩
  | 26 => ⟨1, 2, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps005 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨1, 2, 0, 0⟩
  | 10 => ⟨1, 1, 0, 0⟩
  | 14 => ⟨1, 1, 0, 0⟩
  | 26 => ⟨1, 2, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps006 : StandardBoundCert := fun p =>
  match p.val with
  | 10 => ⟨1, 1, 0, 0⟩
  | 14 => ⟨1, 2, 0, 0⟩
  | 26 => ⟨1, 2, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps007 : StandardBoundCert := fun p =>
  match p.val with
  | 10 => ⟨1, 1, 0, 0⟩
  | 12 => ⟨1, 1, 0, 0⟩
  | 14 => ⟨1, 1, 0, 0⟩
  | 26 => ⟨1, 2, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps008 : StandardBoundCert := fun p =>
  match p.val with
  | 10 => ⟨1, 1, 0, 0⟩
  | 13 => ⟨1, 1, 0, 0⟩
  | 14 => ⟨1, 1, 0, 0⟩
  | 26 => ⟨1, 2, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps009 : StandardBoundCert := fun p =>
  match p.val with
  | 10 => ⟨1, 1, 0, 0⟩
  | 14 => ⟨1, 1, 0, 0⟩
  | 17 => ⟨1, 2, 0, 0⟩
  | 26 => ⟨1, 2, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps010 : StandardBoundCert := fun p =>
  match p.val with
  | 10 => ⟨1, 1, 0, 0⟩
  | 14 => ⟨1, 1, 0, 0⟩
  | 18 => ⟨1, 2, 0, 0⟩
  | 26 => ⟨1, 2, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps011 : StandardBoundCert := fun p =>
  match p.val with
  | 10 => ⟨1, 1, 0, 0⟩
  | 14 => ⟨1, 1, 0, 0⟩
  | 21 => ⟨1, 2, 0, 0⟩
  | 26 => ⟨1, 2, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps012 : StandardBoundCert := fun p =>
  match p.val with
  | 10 => ⟨1, 1, 1, 0⟩
  | 14 => ⟨1, 1, 1, 0⟩
  | 26 => ⟨1, 2, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps013 : StandardBoundCert := fun p =>
  match p.val with
  | 10 => ⟨1, 1, 0, 0⟩
  | 14 => ⟨1, 1, 0, 0⟩
  | 25 => ⟨1, 2, 0, 0⟩
  | 26 => ⟨1, 2, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps014 : StandardBoundCert := fun p =>
  match p.val with
  | 10 => ⟨1, 1, 0, 0⟩
  | 14 => ⟨1, 1, 0, 0⟩
  | 26 => ⟨1, 2, 0, 0⟩
  | 27 => ⟨1, 2, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps015 : StandardBoundCert := fun p =>
  match p.val with
  | 10 => ⟨1, 1, 0, 0⟩
  | 14 => ⟨1, 1, 0, 0⟩
  | 26 => ⟨1, 2, 0, 0⟩
  | 28 => ⟨1, 2, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps016 : StandardBoundCert := fun p =>
  match p.val with
  | 10 => ⟨1, 1, 0, 0⟩
  | 14 => ⟨1, 1, 0, 0⟩
  | 26 => ⟨1, 2, 0, 0⟩
  | 29 => ⟨1, 2, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps017 : StandardBoundCert := fun p =>
  match p.val with
  | 10 => ⟨1, 1, 0, 0⟩
  | 14 => ⟨1, 1, 0, 0⟩
  | 26 => ⟨1, 2, 0, 0⟩
  | 30 => ⟨1, 2, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps018 : StandardBoundCert := fun p =>
  match p.val with
  | 10 => ⟨1, 1, 0, 0⟩
  | 14 => ⟨1, 1, 0, 0⟩
  | 26 => ⟨1, 2, 0, 0⟩
  | 31 => ⟨1, 2, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps019 : StandardBoundCert := fun p =>
  match p.val with
  | 10 => ⟨1, 1, 0, 0⟩
  | 14 => ⟨1, 1, 0, 0⟩
  | 26 => ⟨1, 2, 0, 0⟩
  | 32 => ⟨1, 2, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps020 : StandardBoundCert := fun p =>
  match p.val with
  | 10 => ⟨1, 1, 0, 0⟩
  | 14 => ⟨1, 1, 0, 0⟩
  | 26 => ⟨1, 2, 0, 0⟩
  | 33 => ⟨1, 2, 0, 0⟩
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
  | 11 => caps006
  | 12 => caps007
  | 13 => caps008
  | 14 => caps006
  | 15 => caps000
  | 16 => caps000
  | 17 => caps009
  | 18 => caps010
  | 19 => caps000
  | 20 => caps000
  | 21 => caps011
  | 22 => caps000
  | 23 => caps000
  | 24 => caps012
  | 25 => caps013
  | 26 => caps012
  | 27 => caps014
  | 28 => caps015
  | 29 => caps016
  | 30 => caps017
  | 31 => caps018
  | 32 => caps019
  | 33 => caps020
  | _ => fun _ => ⟨0, 0, 0, 0⟩

end Mahjong.Scale12LeavesV1.L000020
