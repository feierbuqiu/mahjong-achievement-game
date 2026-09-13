import Mahjong.StandardBoundCertificate

set_option maxRecDepth 8192
set_option maxHeartbeats 20000000

namespace Mahjong.Scale12LeavesV1.L000073
open StandardBoundCertificate

def state : State := fun t =>
  match t.val with
  | 0 | 1 | 3 | 4 | 5 | 6 | 9 | 15 | 16 | 19 | 20 | 21 | 22 => 0
  | 8 => 2
  | 10 => 3
  | _ => 1

def caps000 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 2, 1, 0⟩
  | 10 => ⟨0, 1, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps001 : StandardBoundCert := fun p =>
  match p.val with
  | 2 => ⟨0, 2, 1, 0⟩
  | 8 => ⟨0, 2, 1, 0⟩
  | 10 => ⟨0, 1, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps002 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 2, 1, 0⟩
  | 10 => ⟨1, 1, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps003 : StandardBoundCert := fun p =>
  match p.val with
  | 7 => ⟨0, 2, 1, 0⟩
  | 8 => ⟨0, 2, 1, 0⟩
  | 10 => ⟨0, 1, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps004 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 2, 1, 0⟩
  | 10 => ⟨0, 2, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps005 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 2, 1, 0⟩
  | 10 => ⟨0, 1, 1, 0⟩
  | 11 => ⟨0, 2, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps006 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 2, 1, 0⟩
  | 10 => ⟨0, 2, 1, 0⟩
  | 12 => ⟨0, 1, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps007 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 2, 1, 0⟩
  | 10 => ⟨0, 1, 1, 0⟩
  | 13 => ⟨0, 1, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps008 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 2, 1, 0⟩
  | 10 => ⟨0, 1, 1, 0⟩
  | 14 => ⟨0, 2, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps009 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 2, 1, 0⟩
  | 10 => ⟨0, 1, 1, 0⟩
  | 17 => ⟨0, 2, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps010 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 2, 1, 0⟩
  | 10 => ⟨0, 1, 1, 0⟩
  | 18 => ⟨0, 2, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps011 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 2, 1, 0⟩
  | 10 => ⟨0, 1, 1, 0⟩
  | 23 => ⟨0, 2, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps012 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 2, 1, 0⟩
  | 10 => ⟨0, 1, 1, 0⟩
  | 24 => ⟨0, 2, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps013 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 2, 1, 0⟩
  | 10 => ⟨0, 1, 1, 0⟩
  | 25 => ⟨0, 2, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps014 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 2, 1, 0⟩
  | 10 => ⟨0, 1, 1, 0⟩
  | 26 => ⟨0, 2, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps015 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 2, 1, 0⟩
  | 10 => ⟨0, 1, 1, 0⟩
  | 27 => ⟨0, 2, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps016 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 2, 1, 0⟩
  | 10 => ⟨0, 1, 1, 0⟩
  | 28 => ⟨0, 2, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps017 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 2, 1, 0⟩
  | 10 => ⟨0, 1, 1, 0⟩
  | 29 => ⟨0, 2, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps018 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 2, 1, 0⟩
  | 10 => ⟨0, 1, 1, 0⟩
  | 30 => ⟨0, 2, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps019 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 2, 1, 0⟩
  | 10 => ⟨0, 1, 1, 0⟩
  | 31 => ⟨0, 2, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps020 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 2, 1, 0⟩
  | 10 => ⟨0, 1, 1, 0⟩
  | 32 => ⟨0, 2, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps021 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 2, 1, 0⟩
  | 10 => ⟨0, 1, 1, 0⟩
  | 33 => ⟨0, 2, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def baseCaps : StandardBoundCert := caps000

def childCaps : Tile → StandardBoundCert := fun t =>
  match t.val with
  | 0 => caps000
  | 1 => caps000
  | 2 => caps001
  | 3 => caps000
  | 4 => caps000
  | 5 => caps000
  | 6 => caps002
  | 7 => caps003
  | 8 => caps002
  | 9 => caps004
  | 10 => caps000
  | 11 => caps005
  | 12 => caps006
  | 13 => caps007
  | 14 => caps008
  | 15 => caps004
  | 16 => caps000
  | 17 => caps009
  | 18 => caps010
  | 19 => caps000
  | 20 => caps000
  | 21 => caps000
  | 22 => caps000
  | 23 => caps011
  | 24 => caps012
  | 25 => caps013
  | 26 => caps014
  | 27 => caps015
  | 28 => caps016
  | 29 => caps017
  | 30 => caps018
  | 31 => caps019
  | 32 => caps020
  | 33 => caps021
  | _ => fun _ => ⟨0, 0, 0, 0⟩

end Mahjong.Scale12LeavesV1.L000073
