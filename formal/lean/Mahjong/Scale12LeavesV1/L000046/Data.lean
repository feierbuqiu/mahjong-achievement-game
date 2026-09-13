import Mahjong.StandardBoundCertificate

set_option maxRecDepth 8192
set_option maxHeartbeats 20000000

namespace Mahjong.Scale12LeavesV1.L000046
open StandardBoundCertificate

def state : State := fun t =>
  match t.val with
  | 0 | 2 | 6 | 8 | 10 | 11 | 12 | 13 | 19 | 20 | 22 | 23 | 24 => 0
  | 4 | 26 => 2
  | 7 => 4
  | _ => 1

def caps000 : StandardBoundCert := fun p =>
  match p.val with
  | 4 => ⟨1, 1, 0, 0⟩
  | 7 => ⟨1, 1, 0, 0⟩
  | 26 => ⟨2, 1, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps001 : StandardBoundCert := fun p =>
  match p.val with
  | 1 => ⟨2, 1, 0, 0⟩
  | 4 => ⟨1, 1, 0, 0⟩
  | 7 => ⟨1, 1, 0, 0⟩
  | 26 => ⟨2, 1, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps002 : StandardBoundCert := fun p =>
  match p.val with
  | 4 => ⟨2, 1, 0, 0⟩
  | 7 => ⟨1, 1, 0, 0⟩
  | 26 => ⟨2, 1, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps003 : StandardBoundCert := fun p =>
  match p.val with
  | 3 => ⟨1, 1, 0, 0⟩
  | 4 => ⟨1, 1, 0, 0⟩
  | 7 => ⟨1, 1, 0, 0⟩
  | 26 => ⟨2, 1, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps004 : StandardBoundCert := fun p =>
  match p.val with
  | 4 => ⟨1, 1, 0, 0⟩
  | 5 => ⟨1, 1, 0, 0⟩
  | 7 => ⟨1, 1, 0, 0⟩
  | 26 => ⟨2, 1, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps005 : StandardBoundCert := fun p =>
  match p.val with
  | 4 => ⟨1, 1, 0, 0⟩
  | 7 => ⟨1, 1, 0, 0⟩
  | 9 => ⟨2, 1, 0, 0⟩
  | 26 => ⟨2, 1, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps006 : StandardBoundCert := fun p =>
  match p.val with
  | 4 => ⟨1, 1, 0, 0⟩
  | 7 => ⟨1, 1, 0, 0⟩
  | 14 => ⟨2, 1, 0, 0⟩
  | 26 => ⟨2, 1, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps007 : StandardBoundCert := fun p =>
  match p.val with
  | 4 => ⟨1, 1, 0, 0⟩
  | 7 => ⟨1, 1, 0, 0⟩
  | 15 => ⟨2, 0, 0, 0⟩
  | 26 => ⟨2, 1, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps008 : StandardBoundCert := fun p =>
  match p.val with
  | 4 => ⟨1, 1, 0, 0⟩
  | 7 => ⟨1, 1, 0, 0⟩
  | 16 => ⟨2, 0, 0, 0⟩
  | 26 => ⟨2, 1, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps009 : StandardBoundCert := fun p =>
  match p.val with
  | 4 => ⟨1, 1, 0, 0⟩
  | 7 => ⟨1, 1, 0, 0⟩
  | 17 => ⟨2, 1, 0, 0⟩
  | 26 => ⟨2, 1, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps010 : StandardBoundCert := fun p =>
  match p.val with
  | 4 => ⟨1, 1, 0, 0⟩
  | 7 => ⟨1, 1, 0, 0⟩
  | 18 => ⟨2, 1, 0, 0⟩
  | 26 => ⟨2, 1, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps011 : StandardBoundCert := fun p =>
  match p.val with
  | 4 => ⟨1, 1, 0, 0⟩
  | 7 => ⟨1, 1, 0, 0⟩
  | 21 => ⟨2, 1, 0, 0⟩
  | 26 => ⟨2, 1, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps012 : StandardBoundCert := fun p =>
  match p.val with
  | 4 => ⟨1, 1, 1, 0⟩
  | 7 => ⟨1, 1, 1, 0⟩
  | 26 => ⟨2, 1, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps013 : StandardBoundCert := fun p =>
  match p.val with
  | 4 => ⟨1, 1, 0, 0⟩
  | 7 => ⟨1, 1, 0, 0⟩
  | 25 => ⟨2, 1, 0, 0⟩
  | 26 => ⟨2, 1, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps014 : StandardBoundCert := fun p =>
  match p.val with
  | 4 => ⟨1, 1, 0, 0⟩
  | 7 => ⟨1, 1, 0, 0⟩
  | 26 => ⟨2, 1, 0, 0⟩
  | 27 => ⟨2, 1, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps015 : StandardBoundCert := fun p =>
  match p.val with
  | 4 => ⟨1, 1, 0, 0⟩
  | 7 => ⟨1, 1, 0, 0⟩
  | 26 => ⟨2, 1, 0, 0⟩
  | 28 => ⟨2, 1, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps016 : StandardBoundCert := fun p =>
  match p.val with
  | 4 => ⟨1, 1, 0, 0⟩
  | 7 => ⟨1, 1, 0, 0⟩
  | 26 => ⟨2, 1, 0, 0⟩
  | 29 => ⟨2, 1, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps017 : StandardBoundCert := fun p =>
  match p.val with
  | 4 => ⟨1, 1, 0, 0⟩
  | 7 => ⟨1, 1, 0, 0⟩
  | 26 => ⟨2, 1, 0, 0⟩
  | 30 => ⟨2, 1, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps018 : StandardBoundCert := fun p =>
  match p.val with
  | 4 => ⟨1, 1, 0, 0⟩
  | 7 => ⟨1, 1, 0, 0⟩
  | 26 => ⟨2, 1, 0, 0⟩
  | 31 => ⟨2, 1, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps019 : StandardBoundCert := fun p =>
  match p.val with
  | 4 => ⟨1, 1, 0, 0⟩
  | 7 => ⟨1, 1, 0, 0⟩
  | 26 => ⟨2, 1, 0, 0⟩
  | 32 => ⟨2, 1, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps020 : StandardBoundCert := fun p =>
  match p.val with
  | 4 => ⟨1, 1, 0, 0⟩
  | 7 => ⟨1, 1, 0, 0⟩
  | 26 => ⟨2, 1, 0, 0⟩
  | 33 => ⟨2, 1, 0, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def baseCaps : StandardBoundCert := caps000

def childCaps : Tile → StandardBoundCert := fun t =>
  match t.val with
  | 0 => caps000
  | 1 => caps001
  | 2 => caps002
  | 3 => caps003
  | 4 => caps002
  | 5 => caps004
  | 6 => caps002
  | 8 => caps000
  | 9 => caps005
  | 10 => caps000
  | 11 => caps000
  | 12 => caps000
  | 13 => caps000
  | 14 => caps006
  | 15 => caps007
  | 16 => caps008
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

end Mahjong.Scale12LeavesV1.L000046
