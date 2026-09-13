import Mahjong.StandardBoundCertificate

set_option maxRecDepth 8192
set_option maxHeartbeats 20000000

namespace Mahjong.Scale12LeavesV1.L000025
open StandardBoundCertificate

def state : State := fun t =>
  match t.val with
  | 0 | 2 | 3 | 5 | 6 | 9 | 11 | 15 | 16 | 19 | 20 | 21 | 22 => 0
  | 8 | 14 => 2
  | 10 => 4
  | _ => 1

def caps000 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 2, 1, 0⟩
  | 10 => ⟨0, 1, 1, 0⟩
  | 14 => ⟨0, 1, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps001 : StandardBoundCert := fun p =>
  match p.val with
  | 1 => ⟨0, 2, 1, 0⟩
  | 8 => ⟨0, 2, 1, 0⟩
  | 10 => ⟨0, 1, 1, 0⟩
  | 14 => ⟨0, 1, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps002 : StandardBoundCert := fun p =>
  match p.val with
  | 4 => ⟨0, 2, 1, 0⟩
  | 8 => ⟨0, 2, 1, 0⟩
  | 10 => ⟨0, 1, 1, 0⟩
  | 14 => ⟨0, 1, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps003 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 2, 1, 0⟩
  | 10 => ⟨1, 1, 1, 0⟩
  | 14 => ⟨1, 1, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps004 : StandardBoundCert := fun p =>
  match p.val with
  | 7 => ⟨0, 2, 1, 0⟩
  | 8 => ⟨0, 2, 1, 0⟩
  | 10 => ⟨0, 1, 1, 0⟩
  | 14 => ⟨0, 1, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps005 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 2, 1, 0⟩
  | 10 => ⟨0, 1, 1, 0⟩
  | 14 => ⟨0, 2, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps006 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 2, 1, 0⟩
  | 10 => ⟨0, 1, 1, 0⟩
  | 12 => ⟨0, 1, 1, 0⟩
  | 14 => ⟨0, 1, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps007 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 2, 1, 0⟩
  | 10 => ⟨0, 1, 1, 0⟩
  | 13 => ⟨0, 1, 1, 0⟩
  | 14 => ⟨0, 1, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps008 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 2, 1, 0⟩
  | 10 => ⟨0, 1, 1, 0⟩
  | 14 => ⟨0, 1, 1, 0⟩
  | 17 => ⟨0, 2, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps009 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 2, 1, 0⟩
  | 10 => ⟨0, 1, 1, 0⟩
  | 14 => ⟨0, 1, 1, 0⟩
  | 18 => ⟨0, 2, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps010 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 2, 1, 0⟩
  | 10 => ⟨0, 1, 1, 0⟩
  | 14 => ⟨0, 1, 1, 0⟩
  | 23 => ⟨0, 2, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps011 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 2, 1, 0⟩
  | 10 => ⟨0, 1, 1, 0⟩
  | 14 => ⟨0, 1, 1, 0⟩
  | 24 => ⟨0, 2, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps012 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 2, 1, 0⟩
  | 10 => ⟨0, 1, 1, 0⟩
  | 14 => ⟨0, 1, 1, 0⟩
  | 25 => ⟨0, 2, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps013 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 2, 1, 0⟩
  | 10 => ⟨0, 1, 1, 0⟩
  | 14 => ⟨0, 1, 1, 0⟩
  | 26 => ⟨0, 2, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps014 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 2, 1, 0⟩
  | 10 => ⟨0, 1, 1, 0⟩
  | 14 => ⟨0, 1, 1, 0⟩
  | 27 => ⟨0, 2, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps015 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 2, 1, 0⟩
  | 10 => ⟨0, 1, 1, 0⟩
  | 14 => ⟨0, 1, 1, 0⟩
  | 28 => ⟨0, 2, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps016 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 2, 1, 0⟩
  | 10 => ⟨0, 1, 1, 0⟩
  | 14 => ⟨0, 1, 1, 0⟩
  | 29 => ⟨0, 2, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps017 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 2, 1, 0⟩
  | 10 => ⟨0, 1, 1, 0⟩
  | 14 => ⟨0, 1, 1, 0⟩
  | 30 => ⟨0, 2, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps018 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 2, 1, 0⟩
  | 10 => ⟨0, 1, 1, 0⟩
  | 14 => ⟨0, 1, 1, 0⟩
  | 31 => ⟨0, 2, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps019 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 2, 1, 0⟩
  | 10 => ⟨0, 1, 1, 0⟩
  | 14 => ⟨0, 1, 1, 0⟩
  | 32 => ⟨0, 2, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps020 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 2, 1, 0⟩
  | 10 => ⟨0, 1, 1, 0⟩
  | 14 => ⟨0, 1, 1, 0⟩
  | 33 => ⟨0, 2, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def baseCaps : StandardBoundCert := caps000

def childCaps : Tile → StandardBoundCert := fun t =>
  match t.val with
  | 0 => caps000
  | 1 => caps001
  | 2 => caps000
  | 3 => caps000
  | 4 => caps002
  | 5 => caps000
  | 6 => caps003
  | 7 => caps004
  | 8 => caps003
  | 9 => caps000
  | 11 => caps005
  | 12 => caps006
  | 13 => caps007
  | 14 => caps005
  | 15 => caps000
  | 16 => caps000
  | 17 => caps008
  | 18 => caps009
  | 19 => caps000
  | 20 => caps000
  | 21 => caps000
  | 22 => caps000
  | 23 => caps010
  | 24 => caps011
  | 25 => caps012
  | 26 => caps013
  | 27 => caps014
  | 28 => caps015
  | 29 => caps016
  | 30 => caps017
  | 31 => caps018
  | 32 => caps019
  | 33 => caps020
  | _ => fun _ => ⟨0, 0, 0, 0⟩

end Mahjong.Scale12LeavesV1.L000025
