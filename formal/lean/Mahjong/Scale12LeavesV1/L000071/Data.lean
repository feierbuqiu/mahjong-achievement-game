import Mahjong.StandardBoundCertificate

set_option maxRecDepth 8192
set_option maxHeartbeats 20000000

namespace Mahjong.Scale12LeavesV1.L000071
open StandardBoundCertificate

def state : State := fun t =>
  match t.val with
  | 0 | 1 | 3 | 4 | 6 | 7 | 9 | 10 | 12 | 13 | 18 | 24 | 25 => 0
  | 8 => 2
  | 19 => 3
  | _ => 1

def caps000 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 1, 2, 0⟩
  | 19 => ⟨0, 1, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps001 : StandardBoundCert := fun p =>
  match p.val with
  | 2 => ⟨0, 1, 2, 0⟩
  | 8 => ⟨0, 1, 2, 0⟩
  | 19 => ⟨0, 1, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps002 : StandardBoundCert := fun p =>
  match p.val with
  | 5 => ⟨0, 1, 2, 0⟩
  | 8 => ⟨0, 1, 2, 0⟩
  | 19 => ⟨0, 1, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps003 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 1, 2, 0⟩
  | 19 => ⟨1, 1, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps004 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 1, 2, 0⟩
  | 11 => ⟨0, 1, 2, 0⟩
  | 19 => ⟨0, 1, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps005 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 1, 2, 0⟩
  | 14 => ⟨0, 1, 2, 0⟩
  | 19 => ⟨0, 1, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps006 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 1, 2, 0⟩
  | 15 => ⟨0, 0, 2, 0⟩
  | 19 => ⟨0, 1, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps007 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 1, 2, 0⟩
  | 16 => ⟨0, 0, 2, 0⟩
  | 19 => ⟨0, 1, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps008 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 1, 2, 0⟩
  | 17 => ⟨0, 1, 2, 0⟩
  | 19 => ⟨0, 1, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps009 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 1, 2, 0⟩
  | 19 => ⟨0, 1, 2, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps010 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 1, 2, 0⟩
  | 19 => ⟨0, 1, 1, 0⟩
  | 20 => ⟨0, 1, 2, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps011 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 1, 2, 0⟩
  | 19 => ⟨0, 1, 2, 0⟩
  | 21 => ⟨0, 1, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps012 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 1, 2, 0⟩
  | 19 => ⟨0, 1, 1, 0⟩
  | 22 => ⟨0, 1, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps013 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 1, 2, 0⟩
  | 19 => ⟨0, 1, 1, 0⟩
  | 23 => ⟨0, 1, 2, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps014 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 1, 2, 0⟩
  | 19 => ⟨0, 1, 1, 0⟩
  | 26 => ⟨0, 1, 2, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps015 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 1, 2, 0⟩
  | 19 => ⟨0, 1, 1, 0⟩
  | 27 => ⟨0, 1, 2, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps016 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 1, 2, 0⟩
  | 19 => ⟨0, 1, 1, 0⟩
  | 28 => ⟨0, 1, 2, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps017 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 1, 2, 0⟩
  | 19 => ⟨0, 1, 1, 0⟩
  | 29 => ⟨0, 1, 2, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps018 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 1, 2, 0⟩
  | 19 => ⟨0, 1, 1, 0⟩
  | 30 => ⟨0, 1, 2, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps019 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 1, 2, 0⟩
  | 19 => ⟨0, 1, 1, 0⟩
  | 31 => ⟨0, 1, 2, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps020 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 1, 2, 0⟩
  | 19 => ⟨0, 1, 1, 0⟩
  | 32 => ⟨0, 1, 2, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps021 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 1, 2, 0⟩
  | 19 => ⟨0, 1, 1, 0⟩
  | 33 => ⟨0, 1, 2, 0⟩
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
  | 6 => caps000
  | 7 => caps000
  | 8 => caps003
  | 9 => caps000
  | 10 => caps000
  | 11 => caps004
  | 12 => caps000
  | 13 => caps000
  | 14 => caps005
  | 15 => caps006
  | 16 => caps007
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

end Mahjong.Scale12LeavesV1.L000071
