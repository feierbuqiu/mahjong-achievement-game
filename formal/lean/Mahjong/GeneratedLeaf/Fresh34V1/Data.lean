import Mahjong.StandardBoundCertificate

set_option maxRecDepth 8192
set_option maxHeartbeats 20000000

namespace Mahjong.GeneratedLeaf.Fresh34V1
open StandardBoundCertificate

def state : State := fun t =>
  match t.val with
  | 0 | 3 | 6 | 10 | 12 | 15 | 19 | 21 | 24 => 0
  | 22 | 23 | 25 => 4
  | _ => 1

def caps000 : StandardBoundCert := fun p =>
  match p.val with
  | 22 => ⟨0, 0, 2, 0⟩
  | 23 => ⟨0, 0, 2, 0⟩
  | 25 => ⟨0, 0, 2, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps001 : StandardBoundCert := fun p =>
  match p.val with
  | 22 => ⟨1, 0, 2, 0⟩
  | 23 => ⟨1, 0, 2, 0⟩
  | 25 => ⟨1, 0, 2, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps002 : StandardBoundCert := fun p =>
  match p.val with
  | 1 => ⟨0, 0, 3, 0⟩
  | 22 => ⟨0, 0, 2, 0⟩
  | 23 => ⟨0, 0, 2, 0⟩
  | 25 => ⟨0, 0, 2, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps003 : StandardBoundCert := fun p =>
  match p.val with
  | 2 => ⟨0, 0, 3, 0⟩
  | 22 => ⟨0, 0, 2, 0⟩
  | 23 => ⟨0, 0, 2, 0⟩
  | 25 => ⟨0, 0, 2, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps004 : StandardBoundCert := fun p =>
  match p.val with
  | 4 => ⟨0, 0, 3, 0⟩
  | 22 => ⟨0, 0, 2, 0⟩
  | 23 => ⟨0, 0, 2, 0⟩
  | 25 => ⟨0, 0, 2, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps005 : StandardBoundCert := fun p =>
  match p.val with
  | 5 => ⟨0, 0, 3, 0⟩
  | 22 => ⟨0, 0, 2, 0⟩
  | 23 => ⟨0, 0, 2, 0⟩
  | 25 => ⟨0, 0, 2, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps006 : StandardBoundCert := fun p =>
  match p.val with
  | 7 => ⟨0, 0, 3, 0⟩
  | 22 => ⟨0, 0, 2, 0⟩
  | 23 => ⟨0, 0, 2, 0⟩
  | 25 => ⟨0, 0, 2, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps007 : StandardBoundCert := fun p =>
  match p.val with
  | 8 => ⟨0, 0, 3, 0⟩
  | 22 => ⟨0, 0, 2, 0⟩
  | 23 => ⟨0, 0, 2, 0⟩
  | 25 => ⟨0, 0, 2, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps008 : StandardBoundCert := fun p =>
  match p.val with
  | 9 => ⟨0, 0, 3, 0⟩
  | 22 => ⟨0, 0, 2, 0⟩
  | 23 => ⟨0, 0, 2, 0⟩
  | 25 => ⟨0, 0, 2, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps009 : StandardBoundCert := fun p =>
  match p.val with
  | 22 => ⟨0, 1, 2, 0⟩
  | 23 => ⟨0, 1, 2, 0⟩
  | 25 => ⟨0, 1, 2, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps010 : StandardBoundCert := fun p =>
  match p.val with
  | 11 => ⟨0, 0, 3, 0⟩
  | 22 => ⟨0, 0, 2, 0⟩
  | 23 => ⟨0, 0, 2, 0⟩
  | 25 => ⟨0, 0, 2, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps011 : StandardBoundCert := fun p =>
  match p.val with
  | 13 => ⟨0, 0, 3, 0⟩
  | 22 => ⟨0, 0, 2, 0⟩
  | 23 => ⟨0, 0, 2, 0⟩
  | 25 => ⟨0, 0, 2, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps012 : StandardBoundCert := fun p =>
  match p.val with
  | 14 => ⟨0, 0, 3, 0⟩
  | 22 => ⟨0, 0, 2, 0⟩
  | 23 => ⟨0, 0, 2, 0⟩
  | 25 => ⟨0, 0, 2, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps013 : StandardBoundCert := fun p =>
  match p.val with
  | 16 => ⟨0, 0, 3, 0⟩
  | 22 => ⟨0, 0, 2, 0⟩
  | 23 => ⟨0, 0, 2, 0⟩
  | 25 => ⟨0, 0, 2, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps014 : StandardBoundCert := fun p =>
  match p.val with
  | 17 => ⟨0, 0, 3, 0⟩
  | 22 => ⟨0, 0, 2, 0⟩
  | 23 => ⟨0, 0, 2, 0⟩
  | 25 => ⟨0, 0, 2, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps015 : StandardBoundCert := fun p =>
  match p.val with
  | 18 => ⟨0, 0, 3, 0⟩
  | 22 => ⟨0, 0, 2, 0⟩
  | 23 => ⟨0, 0, 2, 0⟩
  | 25 => ⟨0, 0, 2, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps016 : StandardBoundCert := fun p =>
  match p.val with
  | 22 => ⟨0, 0, 3, 0⟩
  | 23 => ⟨0, 0, 3, 0⟩
  | 25 => ⟨0, 0, 3, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps017 : StandardBoundCert := fun p =>
  match p.val with
  | 20 => ⟨0, 0, 3, 0⟩
  | 22 => ⟨0, 0, 2, 0⟩
  | 23 => ⟨0, 0, 2, 0⟩
  | 25 => ⟨0, 0, 2, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps018 : StandardBoundCert := fun p =>
  match p.val with
  | 22 => ⟨0, 0, 2, 0⟩
  | 23 => ⟨0, 0, 2, 0⟩
  | 25 => ⟨0, 0, 2, 0⟩
  | 26 => ⟨0, 0, 3, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps019 : StandardBoundCert := fun p =>
  match p.val with
  | 22 => ⟨0, 0, 2, 0⟩
  | 23 => ⟨0, 0, 2, 0⟩
  | 25 => ⟨0, 0, 2, 0⟩
  | 27 => ⟨0, 0, 3, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps020 : StandardBoundCert := fun p =>
  match p.val with
  | 22 => ⟨0, 0, 2, 0⟩
  | 23 => ⟨0, 0, 2, 0⟩
  | 25 => ⟨0, 0, 2, 0⟩
  | 28 => ⟨0, 0, 3, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps021 : StandardBoundCert := fun p =>
  match p.val with
  | 22 => ⟨0, 0, 2, 0⟩
  | 23 => ⟨0, 0, 2, 0⟩
  | 25 => ⟨0, 0, 2, 0⟩
  | 29 => ⟨0, 0, 3, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps022 : StandardBoundCert := fun p =>
  match p.val with
  | 22 => ⟨0, 0, 2, 0⟩
  | 23 => ⟨0, 0, 2, 0⟩
  | 25 => ⟨0, 0, 2, 0⟩
  | 30 => ⟨0, 0, 3, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps023 : StandardBoundCert := fun p =>
  match p.val with
  | 22 => ⟨0, 0, 2, 0⟩
  | 23 => ⟨0, 0, 2, 0⟩
  | 25 => ⟨0, 0, 2, 0⟩
  | 31 => ⟨0, 0, 3, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps024 : StandardBoundCert := fun p =>
  match p.val with
  | 22 => ⟨0, 0, 2, 0⟩
  | 23 => ⟨0, 0, 2, 0⟩
  | 25 => ⟨0, 0, 2, 0⟩
  | 32 => ⟨0, 0, 3, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def caps025 : StandardBoundCert := fun p =>
  match p.val with
  | 22 => ⟨0, 0, 2, 0⟩
  | 23 => ⟨0, 0, 2, 0⟩
  | 25 => ⟨0, 0, 2, 0⟩
  | 33 => ⟨0, 0, 3, 0⟩
  | _ => ⟨0, 0, 0, 0⟩

def baseCaps : StandardBoundCert := caps000

def childCaps : Tile → StandardBoundCert := fun t =>
  match t.val with
  | 0 => caps001
  | 1 => caps002
  | 2 => caps003
  | 3 => caps001
  | 4 => caps004
  | 5 => caps005
  | 6 => caps001
  | 7 => caps006
  | 8 => caps007
  | 9 => caps008
  | 10 => caps009
  | 11 => caps010
  | 12 => caps009
  | 13 => caps011
  | 14 => caps012
  | 15 => caps009
  | 16 => caps013
  | 17 => caps014
  | 18 => caps015
  | 19 => caps016
  | 20 => caps017
  | 21 => caps016
  | 24 => caps016
  | 26 => caps018
  | 27 => caps019
  | 28 => caps020
  | 29 => caps021
  | 30 => caps022
  | 31 => caps023
  | 32 => caps024
  | 33 => caps025
  | _ => fun _ => ⟨0, 0, 0, 0⟩

end Mahjong.GeneratedLeaf.Fresh34V1
