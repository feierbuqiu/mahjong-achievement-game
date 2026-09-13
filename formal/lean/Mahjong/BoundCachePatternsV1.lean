import Mahjong.CachedStandardBounds

set_option maxRecDepth 8192
set_option maxHeartbeats 20000000

namespace Mahjong.BoundCachePatternsV1
open StandardBoundCertificate MaskedLocalBound

def pattern000 : State := fun t =>
  match t.val with
  | 1 | 2 | 8 => 1
  | 4 => 2
  | 5 | 7 => 4
  | _ => 0
theorem pattern000_checked : searchWith (localMelds 0) 3 (mask 0 pattern000) = false := by decide +kernel

def pattern001 : State := fun t =>
  match t.val with
  | 1 | 2 | 8 => 1
  | 4 | 7 => 4
  | 5 => 2
  | _ => 0
theorem pattern001_checked : searchWith (localMelds 0) 3 (mask 0 pattern001) = false := by decide +kernel

def pattern002 : State := fun t =>
  match t.val with
  | 1 | 2 | 8 => 1
  | 4 | 5 => 4
  | 7 => 2
  | _ => 0
theorem pattern002_checked : searchWith (localMelds 0) 3 (mask 0 pattern002) = false := by decide +kernel

def pattern003 : State := fun t =>
  match t.val with
  | 0 | 2 => 1
  | 4 | 8 => 2
  | 5 | 7 => 4
  | _ => 0
theorem pattern003_checked : searchWith (localMelds 0) 3 (mask 0 pattern003) = false := by decide +kernel

def pattern004 : State := fun t =>
  match t.val with
  | 0 | 2 => 1
  | 4 | 7 => 4
  | 5 | 8 => 2
  | _ => 0
theorem pattern004_checked : searchWith (localMelds 0) 3 (mask 0 pattern004) = false := by decide +kernel

def pattern005 : State := fun t =>
  match t.val with
  | 0 | 2 => 1
  | 4 | 5 => 4
  | 7 | 8 => 2
  | _ => 0
theorem pattern005_checked : searchWith (localMelds 0) 3 (mask 0 pattern005) = false := by decide +kernel

def pattern006 : State := fun t =>
  match t.val with
  | 0 | 8 => 1
  | 2 | 4 => 2
  | 5 | 7 => 4
  | _ => 0
theorem pattern006_checked : searchWith (localMelds 0) 3 (mask 0 pattern006) = false := by decide +kernel

def pattern007 : State := fun t =>
  match t.val with
  | 0 | 8 => 1
  | 2 | 5 => 2
  | 4 | 7 => 4
  | _ => 0
theorem pattern007_checked : searchWith (localMelds 0) 3 (mask 0 pattern007) = false := by decide +kernel

def pattern008 : State := fun t =>
  match t.val with
  | 0 | 8 => 1
  | 2 | 7 => 2
  | 4 | 5 => 4
  | _ => 0
theorem pattern008_checked : searchWith (localMelds 0) 3 (mask 0 pattern008) = false := by decide +kernel

def pattern009 : State := fun t =>
  match t.val with
  | 0 | 4 => 2
  | 2 | 8 => 1
  | 5 | 7 => 4
  | _ => 0
theorem pattern009_checked : searchWith (localMelds 0) 3 (mask 0 pattern009) = false := by decide +kernel

def pattern010 : State := fun t =>
  match t.val with
  | 0 | 5 => 2
  | 2 | 8 => 1
  | 4 | 7 => 4
  | _ => 0
theorem pattern010_checked : searchWith (localMelds 0) 3 (mask 0 pattern010) = false := by decide +kernel

def pattern011 : State := fun t =>
  match t.val with
  | 0 | 7 => 2
  | 2 | 8 => 1
  | 4 | 5 => 4
  | _ => 0
theorem pattern011_checked : searchWith (localMelds 0) 3 (mask 0 pattern011) = false := by decide +kernel

def pattern012 : State := fun t =>
  match t.val with
  | 0 | 2 | 6 | 8 => 1
  | 4 => 2
  | 5 | 7 => 4
  | _ => 0
theorem pattern012_checked : searchWith (localMelds 0) 4 (mask 0 pattern012) = false := by decide +kernel

def pattern013 : State := fun t =>
  match t.val with
  | 0 | 2 | 6 | 8 => 1
  | 4 | 7 => 4
  | 5 => 2
  | _ => 0
theorem pattern013_checked : searchWith (localMelds 0) 4 (mask 0 pattern013) = false := by decide +kernel

def pattern014 : State := fun t =>
  match t.val with
  | 0 | 2 | 8 => 1
  | 4 | 5 | 7 => 4
  | _ => 0
theorem pattern014_checked : searchWith (localMelds 0) 4 (mask 0 pattern014) = false := by decide +kernel

def pattern015 : State := fun t =>
  match t.val with
  | 0 | 2 | 6 | 8 => 1
  | 4 | 5 => 4
  | 7 => 2
  | _ => 0
theorem pattern015_checked : searchWith (localMelds 0) 4 (mask 0 pattern015) = false := by decide +kernel

def pattern016 : State := fun t =>
  match t.val with
  | 0 | 2 | 3 | 8 => 1
  | 4 => 2
  | 5 | 7 => 4
  | _ => 0
theorem pattern016_checked : searchWith (localMelds 0) 4 (mask 0 pattern016) = false := by decide +kernel

def pattern017 : State := fun t =>
  match t.val with
  | 0 | 2 | 3 | 8 => 1
  | 4 | 7 => 4
  | 5 => 2
  | _ => 0
theorem pattern017_checked : searchWith (localMelds 0) 4 (mask 0 pattern017) = false := by decide +kernel

def pattern018 : State := fun t =>
  match t.val with
  | 0 | 2 | 3 | 8 => 1
  | 4 | 5 => 4
  | 7 => 2
  | _ => 0
theorem pattern018_checked : searchWith (localMelds 0) 4 (mask 0 pattern018) = false := by decide +kernel

def pattern019 : State := fun t =>
  match t.val with
  | 0 | 1 | 2 | 8 => 1
  | 4 => 2
  | 5 | 7 => 4
  | _ => 0
theorem pattern019_checked : searchWith (localMelds 0) 4 (mask 0 pattern019) = false := by decide +kernel

def pattern020 : State := fun t =>
  match t.val with
  | 0 | 1 | 2 | 8 => 1
  | 4 | 7 => 4
  | 5 => 2
  | _ => 0
theorem pattern020_checked : searchWith (localMelds 0) 4 (mask 0 pattern020) = false := by decide +kernel

def pattern021 : State := fun t =>
  match t.val with
  | 0 | 1 | 2 | 8 => 1
  | 4 | 5 => 4
  | 7 => 2
  | _ => 0
theorem pattern021_checked : searchWith (localMelds 0) 4 (mask 0 pattern021) = false := by decide +kernel

def pattern022 : State := fun t =>
  match t.val with
  | 10 | 11 | 13 | 14 | 16 | 17 => 2
  | _ => 0
theorem pattern022_checked : searchWith (localMelds 1) 1 (mask 1 pattern022) = false := by decide +kernel

def pattern023 : State := fun t =>
  match t.val with
  | 9 | 11 | 13 | 14 | 16 | 17 => 2
  | _ => 0
theorem pattern023_checked : searchWith (localMelds 1) 1 (mask 1 pattern023) = false := by decide +kernel

def pattern024 : State := fun t =>
  match t.val with
  | 9 | 11 | 12 | 14 | 16 | 17 => 2
  | _ => 0
theorem pattern024_checked : searchWith (localMelds 1) 1 (mask 1 pattern024) = false := by decide +kernel

def pattern025 : State := fun t =>
  match t.val with
  | 9 | 10 | 13 | 14 | 16 | 17 => 2
  | _ => 0
theorem pattern025_checked : searchWith (localMelds 1) 1 (mask 1 pattern025) = false := by decide +kernel

def pattern026 : State := fun t =>
  match t.val with
  | 10 | 11 | 13 | 14 | 15 | 16 | 17 => 1
  | _ => 0
theorem pattern026_checked : searchWith (localMelds 1) 2 (mask 1 pattern026) = false := by decide +kernel

def pattern027 : State := fun t =>
  match t.val with
  | 10 | 11 | 12 | 13 | 14 | 16 | 17 => 1
  | _ => 0
theorem pattern027_checked : searchWith (localMelds 1) 2 (mask 1 pattern027) = false := by decide +kernel

def pattern028 : State := fun t =>
  match t.val with
  | 9 | 10 | 11 | 13 | 14 | 16 | 17 => 1
  | _ => 0
theorem pattern028_checked : searchWith (localMelds 1) 2 (mask 1 pattern028) = false := by decide +kernel

def pattern029 : State := fun t =>
  match t.val with
  | 18 | 20 | 22 | 23 | 25 | 26 => 2
  | _ => 0
theorem pattern029_checked : searchWith (localMelds 2) 1 (mask 2 pattern029) = false := by decide +kernel

def pattern030 : State := fun t =>
  match t.val with
  | 18 | 20 | 22 | 23 | 24 | 25 | 26 => 1
  | _ => 0
theorem pattern030_checked : searchWith (localMelds 2) 2 (mask 2 pattern030) = false := by decide +kernel

def pattern031 : State := fun t =>
  match t.val with
  | 18 | 20 | 21 | 22 | 23 | 25 | 26 => 1
  | _ => 0
theorem pattern031_checked : searchWith (localMelds 2) 2 (mask 2 pattern031) = false := by decide +kernel

def pattern032 : State := fun t =>
  match t.val with
  | 18 | 19 | 20 | 22 | 23 | 25 | 26 => 1
  | _ => 0
theorem pattern032_checked : searchWith (localMelds 2) 2 (mask 2 pattern032) = false := by decide +kernel

def pattern033 : State := fun t =>
  match t.val with
  | 27 | 28 | 29 | 30 | 31 | 32 | 33 => 2
  | _ => 0
theorem pattern033_checked : searchWith (localMelds 3) 1 (mask 3 pattern033) = false := by decide +kernel

end Mahjong.BoundCachePatternsV1
#print axioms Mahjong.BoundCachePatternsV1.pattern000_checked
#print axioms Mahjong.BoundCachePatternsV1.pattern001_checked
#print axioms Mahjong.BoundCachePatternsV1.pattern002_checked
#print axioms Mahjong.BoundCachePatternsV1.pattern003_checked
#print axioms Mahjong.BoundCachePatternsV1.pattern004_checked
#print axioms Mahjong.BoundCachePatternsV1.pattern005_checked
#print axioms Mahjong.BoundCachePatternsV1.pattern006_checked
#print axioms Mahjong.BoundCachePatternsV1.pattern007_checked
#print axioms Mahjong.BoundCachePatternsV1.pattern008_checked
#print axioms Mahjong.BoundCachePatternsV1.pattern009_checked
#print axioms Mahjong.BoundCachePatternsV1.pattern010_checked
#print axioms Mahjong.BoundCachePatternsV1.pattern011_checked
#print axioms Mahjong.BoundCachePatternsV1.pattern012_checked
#print axioms Mahjong.BoundCachePatternsV1.pattern013_checked
#print axioms Mahjong.BoundCachePatternsV1.pattern014_checked
#print axioms Mahjong.BoundCachePatternsV1.pattern015_checked
#print axioms Mahjong.BoundCachePatternsV1.pattern016_checked
#print axioms Mahjong.BoundCachePatternsV1.pattern017_checked
#print axioms Mahjong.BoundCachePatternsV1.pattern018_checked
#print axioms Mahjong.BoundCachePatternsV1.pattern019_checked
#print axioms Mahjong.BoundCachePatternsV1.pattern020_checked
#print axioms Mahjong.BoundCachePatternsV1.pattern021_checked
#print axioms Mahjong.BoundCachePatternsV1.pattern022_checked
#print axioms Mahjong.BoundCachePatternsV1.pattern023_checked
#print axioms Mahjong.BoundCachePatternsV1.pattern024_checked
#print axioms Mahjong.BoundCachePatternsV1.pattern025_checked
#print axioms Mahjong.BoundCachePatternsV1.pattern026_checked
#print axioms Mahjong.BoundCachePatternsV1.pattern027_checked
#print axioms Mahjong.BoundCachePatternsV1.pattern028_checked
#print axioms Mahjong.BoundCachePatternsV1.pattern029_checked
#print axioms Mahjong.BoundCachePatternsV1.pattern030_checked
#print axioms Mahjong.BoundCachePatternsV1.pattern031_checked
#print axioms Mahjong.BoundCachePatternsV1.pattern032_checked
#print axioms Mahjong.BoundCachePatternsV1.pattern033_checked
