import Mahjong.StandardBoundCertificate

set_option maxRecDepth 8192
set_option maxHeartbeats 20000000

namespace Mahjong.Scale12LeavesV1.L000085
open StandardBoundCertificate

def state : State := fun t =>
  match t.val with
  | 0 | 1 | 6 | 10 | 11 | 12 | 13 | 19 | 20 | 22 | 23 | 24 | 27 => 0
  | 7 => 3
  | 26 => 2
  | _ => 1

def caps000 : StandardBoundCert := fun p =>
  match p.val with
  | 7 => ⟨1, 1, 0, 0⟩
  | 26 => ⟨2, 1, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps001 : StandardBoundCert := fun p =>
  match p.val with
  | 2 => ⟨2, 1, 0, 0⟩
  | 7 => ⟨1, 1, 0, 0⟩
  | 26 => ⟨2, 1, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps002 : StandardBoundCert := fun p =>
  match p.val with
  | 3 => ⟨1, 1, 0, 0⟩
  | 7 => ⟨1, 1, 0, 0⟩
  | 26 => ⟨2, 1, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps003 : StandardBoundCert := fun p =>
  match p.val with
  | 4 => ⟨1, 1, 0, 0⟩
  | 7 => ⟨1, 1, 0, 0⟩
  | 26 => ⟨2, 1, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps004 : StandardBoundCert := fun p =>
  match p.val with
  | 5 => ⟨2, 1, 0, 0⟩
  | 7 => ⟨1, 1, 0, 0⟩
  | 26 => ⟨2, 1, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps005 : StandardBoundCert := fun p =>
  match p.val with
  | 7 => ⟨2, 1, 0, 0⟩
  | 26 => ⟨2, 1, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps006 : StandardBoundCert := fun p =>
  match p.val with
  | 7 => ⟨1, 1, 0, 0⟩
  | 8 => ⟨2, 1, 0, 0⟩
  | 26 => ⟨2, 1, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps007 : StandardBoundCert := fun p =>
  match p.val with
  | 7 => ⟨1, 1, 0, 0⟩
  | 9 => ⟨2, 1, 0, 0⟩
  | 26 => ⟨2, 1, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps008 : StandardBoundCert := fun p =>
  match p.val with
  | 7 => ⟨1, 1, 0, 0⟩
  | 14 => ⟨2, 1, 0, 0⟩
  | 26 => ⟨2, 1, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps009 : StandardBoundCert := fun p =>
  match p.val with
  | 7 => ⟨1, 1, 0, 0⟩
  | 15 => ⟨2, 0, 0, 0⟩
  | 26 => ⟨2, 1, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps010 : StandardBoundCert := fun p =>
  match p.val with
  | 7 => ⟨1, 1, 0, 0⟩
  | 16 => ⟨2, 0, 0, 0⟩
  | 26 => ⟨2, 1, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps011 : StandardBoundCert := fun p =>
  match p.val with
  | 7 => ⟨1, 1, 0, 0⟩
  | 17 => ⟨2, 1, 0, 0⟩
  | 26 => ⟨2, 1, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps012 : StandardBoundCert := fun p =>
  match p.val with
  | 7 => ⟨1, 1, 0, 0⟩
  | 18 => ⟨2, 1, 0, 0⟩
  | 26 => ⟨2, 1, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps013 : StandardBoundCert := fun p =>
  match p.val with
  | 7 => ⟨1, 1, 0, 0⟩
  | 21 => ⟨2, 1, 0, 0⟩
  | 26 => ⟨2, 1, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps014 : StandardBoundCert := fun p =>
  match p.val with
  | 7 => ⟨1, 1, 1, 0⟩
  | 26 => ⟨2, 1, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps015 : StandardBoundCert := fun p =>
  match p.val with
  | 7 => ⟨1, 1, 0, 0⟩
  | 25 => ⟨2, 1, 0, 0⟩
  | 26 => ⟨2, 1, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps016 : StandardBoundCert := fun p =>
  match p.val with
  | 7 => ⟨1, 1, 0, 0⟩
  | 26 => ⟨2, 1, 0, 0⟩
  | 28 => ⟨2, 1, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps017 : StandardBoundCert := fun p =>
  match p.val with
  | 7 => ⟨1, 1, 0, 0⟩
  | 26 => ⟨2, 1, 0, 0⟩
  | 29 => ⟨2, 1, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps018 : StandardBoundCert := fun p =>
  match p.val with
  | 7 => ⟨1, 1, 0, 0⟩
  | 26 => ⟨2, 1, 0, 0⟩
  | 30 => ⟨2, 1, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps019 : StandardBoundCert := fun p =>
  match p.val with
  | 7 => ⟨1, 1, 0, 0⟩
  | 26 => ⟨2, 1, 0, 0⟩
  | 31 => ⟨2, 1, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps020 : StandardBoundCert := fun p =>
  match p.val with
  | 7 => ⟨1, 1, 0, 0⟩
  | 26 => ⟨2, 1, 0, 0⟩
  | 32 => ⟨2, 1, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps021 : StandardBoundCert := fun p =>
  match p.val with
  | 7 => ⟨1, 1, 0, 0⟩
  | 26 => ⟨2, 1, 0, 0⟩
  | 33 => ⟨2, 1, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def baseCaps : StandardBoundCert := caps000

def childCaps : Tile → StandardBoundCert := fun t =>
  match t.val with
  | 0 => caps000
  | 1 => caps000
  | 2 => caps001
  | 3 => caps002
  | 4 => caps003
  | 5 => caps004
  | 6 => caps005
  | 7 => caps000
  | 8 => caps006
  | 9 => caps007
  | 10 => caps000
  | 11 => caps000
  | 12 => caps000
  | 13 => caps000
  | 14 => caps008
  | 15 => caps009
  | 16 => caps010
  | 17 => caps011
  | 18 => caps012
  | 19 => caps000
  | 20 => caps000
  | 21 => caps013
  | 22 => caps000
  | 23 => caps000
  | 24 => caps014
  | 25 => caps015
  | 26 => caps014
  | 27 => caps000
  | 28 => caps016
  | 29 => caps017
  | 30 => caps018
  | 31 => caps019
  | 32 => caps020
  | 33 => caps021
  | _ => fun _ => ⟨0, 0, 0, 0⟩

end Mahjong.Scale12LeavesV1.L000085
