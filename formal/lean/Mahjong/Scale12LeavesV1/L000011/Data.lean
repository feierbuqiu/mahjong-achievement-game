import Mahjong.StandardBoundCertificate

set_option maxRecDepth 8192
set_option maxHeartbeats 20000000

namespace Mahjong.Scale12LeavesV1.L000011
open StandardBoundCertificate

def state : State := fun t =>
  match t.val with
  | 0 | 2 | 3 | 4 | 9 | 11 | 12 | 14 | 15 | 18 | 20 | 24 => 0
  | 17 | 23 => 2
  | 25 => 3
  | _ => 1

def caps000 : StandardBoundCert := fun p =>
  match p.val with
  | 17 => ⟨1, 0, 2, 0⟩
  | 23 => ⟨1, 0, 1, 0⟩
  | 25 => ⟨1, 0, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps001 : StandardBoundCert := fun p =>
  match p.val with
  | 1 => ⟨1, 0, 2, 0⟩
  | 17 => ⟨1, 0, 2, 0⟩
  | 23 => ⟨1, 0, 1, 0⟩
  | 25 => ⟨1, 0, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps002 : StandardBoundCert := fun p =>
  match p.val with
  | 5 => ⟨1, 0, 2, 0⟩
  | 17 => ⟨1, 0, 2, 0⟩
  | 23 => ⟨1, 0, 1, 0⟩
  | 25 => ⟨1, 0, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps003 : StandardBoundCert := fun p =>
  match p.val with
  | 6 => ⟨0, 0, 2, 0⟩
  | 17 => ⟨1, 0, 2, 0⟩
  | 23 => ⟨1, 0, 1, 0⟩
  | 25 => ⟨1, 0, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps004 : StandardBoundCert := fun p =>
  match p.val with
  | 7 => ⟨0, 0, 2, 0⟩
  | 17 => ⟨1, 0, 2, 0⟩
  | 23 => ⟨1, 0, 1, 0⟩
  | 25 => ⟨1, 0, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps005 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨1, 0, 2, 0⟩
  | 17 => ⟨1, 0, 2, 0⟩
  | 23 => ⟨1, 0, 1, 0⟩
  | 25 => ⟨1, 0, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps006 : StandardBoundCert := fun p =>
  match p.val with
  | 10 => ⟨1, 0, 2, 0⟩
  | 17 => ⟨1, 0, 2, 0⟩
  | 23 => ⟨1, 0, 1, 0⟩
  | 25 => ⟨1, 0, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps007 : StandardBoundCert := fun p =>
  match p.val with
  | 13 => ⟨1, 0, 2, 0⟩
  | 17 => ⟨1, 0, 2, 0⟩
  | 23 => ⟨1, 0, 1, 0⟩
  | 25 => ⟨1, 0, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps008 : StandardBoundCert := fun p =>
  match p.val with
  | 17 => ⟨1, 0, 2, 0⟩
  | 23 => ⟨1, 1, 1, 0⟩
  | 25 => ⟨1, 1, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps009 : StandardBoundCert := fun p =>
  match p.val with
  | 16 => ⟨1, 0, 2, 0⟩
  | 17 => ⟨1, 0, 2, 0⟩
  | 23 => ⟨1, 0, 1, 0⟩
  | 25 => ⟨1, 0, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps010 : StandardBoundCert := fun p =>
  match p.val with
  | 17 => ⟨1, 0, 2, 0⟩
  | 19 => ⟨1, 0, 2, 0⟩
  | 23 => ⟨1, 0, 1, 0⟩
  | 25 => ⟨1, 0, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps011 : StandardBoundCert := fun p =>
  match p.val with
  | 17 => ⟨1, 0, 2, 0⟩
  | 23 => ⟨1, 0, 2, 0⟩
  | 25 => ⟨1, 0, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps012 : StandardBoundCert := fun p =>
  match p.val with
  | 17 => ⟨1, 0, 2, 0⟩
  | 21 => ⟨1, 0, 1, 0⟩
  | 23 => ⟨1, 0, 1, 0⟩
  | 25 => ⟨1, 0, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps013 : StandardBoundCert := fun p =>
  match p.val with
  | 17 => ⟨1, 0, 2, 0⟩
  | 22 => ⟨1, 0, 1, 0⟩
  | 23 => ⟨1, 0, 1, 0⟩
  | 25 => ⟨1, 0, 1, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps014 : StandardBoundCert := fun p =>
  match p.val with
  | 17 => ⟨1, 0, 2, 0⟩
  | 23 => ⟨1, 0, 1, 0⟩
  | 25 => ⟨1, 0, 2, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps015 : StandardBoundCert := fun p =>
  match p.val with
  | 17 => ⟨1, 0, 2, 0⟩
  | 23 => ⟨1, 0, 1, 0⟩
  | 25 => ⟨1, 0, 1, 0⟩
  | 26 => ⟨1, 0, 2, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps016 : StandardBoundCert := fun p =>
  match p.val with
  | 17 => ⟨1, 0, 2, 0⟩
  | 23 => ⟨1, 0, 1, 0⟩
  | 25 => ⟨1, 0, 1, 0⟩
  | 27 => ⟨1, 0, 2, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps017 : StandardBoundCert := fun p =>
  match p.val with
  | 17 => ⟨1, 0, 2, 0⟩
  | 23 => ⟨1, 0, 1, 0⟩
  | 25 => ⟨1, 0, 1, 0⟩
  | 28 => ⟨1, 0, 2, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps018 : StandardBoundCert := fun p =>
  match p.val with
  | 17 => ⟨1, 0, 2, 0⟩
  | 23 => ⟨1, 0, 1, 0⟩
  | 25 => ⟨1, 0, 1, 0⟩
  | 29 => ⟨1, 0, 2, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps019 : StandardBoundCert := fun p =>
  match p.val with
  | 17 => ⟨1, 0, 2, 0⟩
  | 23 => ⟨1, 0, 1, 0⟩
  | 25 => ⟨1, 0, 1, 0⟩
  | 30 => ⟨1, 0, 2, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps020 : StandardBoundCert := fun p =>
  match p.val with
  | 17 => ⟨1, 0, 2, 0⟩
  | 23 => ⟨1, 0, 1, 0⟩
  | 25 => ⟨1, 0, 1, 0⟩
  | 31 => ⟨1, 0, 2, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps021 : StandardBoundCert := fun p =>
  match p.val with
  | 17 => ⟨1, 0, 2, 0⟩
  | 23 => ⟨1, 0, 1, 0⟩
  | 25 => ⟨1, 0, 1, 0⟩
  | 32 => ⟨1, 0, 2, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps022 : StandardBoundCert := fun p =>
  match p.val with
  | 17 => ⟨1, 0, 2, 0⟩
  | 23 => ⟨1, 0, 1, 0⟩
  | 25 => ⟨1, 0, 1, 0⟩
  | 33 => ⟨1, 0, 2, 0⟩
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
  | 6 => caps003
  | 7 => caps004
  | 8 => caps005
  | 9 => caps000
  | 10 => caps006
  | 11 => caps000
  | 12 => caps000
  | 13 => caps007
  | 14 => caps000
  | 15 => caps008
  | 16 => caps009
  | 17 => caps008
  | 18 => caps000
  | 19 => caps010
  | 20 => caps011
  | 21 => caps012
  | 22 => caps013
  | 23 => caps011
  | 24 => caps014
  | 25 => caps000
  | 26 => caps015
  | 27 => caps016
  | 28 => caps017
  | 29 => caps018
  | 30 => caps019
  | 31 => caps020
  | 32 => caps021
  | 33 => caps022
  | _ => fun _ => ⟨0, 0, 0, 0⟩

end Mahjong.Scale12LeavesV1.L000011
