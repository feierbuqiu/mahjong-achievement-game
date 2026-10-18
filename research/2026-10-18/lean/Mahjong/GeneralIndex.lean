import Mahjong.GeneralLayer
import Mahjong.BucketIndex
import Mahjong.LocalCacheEncoding
import Mahjong.TerminalBucket

set_option autoImplicit false

namespace Mahjong.GeneralIndex
open PackedRules Generators GeneralLayer

structure Bucket where
  data : BucketIndex.Data
  bits : ByteArray

def emptyBucket : Bucket := ⟨⟨ByteArray.empty,ByteArray.empty,ByteArray.empty,ByteArray.empty,0,0⟩,ByteArray.empty⟩

def reverseCode (code : Nat) : Nat :=
  ((List.range 9).foldl (fun (p : Nat × Nat) _ => (p.1/5,p.2*5+p.1%5)) (code,0)).2

def reflectOne (b : Fin 3) (s : Packed) (path : List Generator) : Packed × List Generator :=
  let code := s.get b.val
  let rev := reverseCode code
  if rev < code then (s.set b.val rev, .reverseSuit b :: path) else (s,path)

def sortOne (ids : ByteArray) (a b : Fin 3) (s : Packed) (path : List Generator) : Packed × List Generator :=
  if BucketIndex.readLE ids (4*s.get a.val) 4 > BucketIndex.readLE ids (4*s.get b.val) 4 then
    ((s.set a.val (s.get b.val)).set b.val (s.get a.val), .swapSuits a b :: path)
  else (s,path)

/-- Produces both a representative and an inverse generator path. The checker
    verifies their full physical equality; this algorithm is not assumed correct. -/
def normalize (ids : ByteArray) (s : Packed) : Packed × List Generator := Id.run do
  let (s,p) := reflectOne ⟨0,by decide⟩ s []
  let (s,p) := reflectOne ⟨1,by decide⟩ s p
  let (s,p) := reflectOne ⟨2,by decide⟩ s p
  let (s,p) := sortOne ids ⟨0,by decide⟩ ⟨1,by decide⟩ s p
  let (s,p) := sortOne ids ⟨1,by decide⟩ ⟨2,by decide⟩ s p
  let (s,p) := sortOne ids ⟨0,by decide⟩ ⟨1,by decide⟩ s p
  let mut code := s.h
  let mut path := p
  for i in [0:7] do
    for j in [i+1:7] do
      let pi := LocalCacheEncoding.powers[i]!
      let pj := LocalCacheEncoding.powers[j]!
      let di := code/pi%5
      let dj := code/pj%5
      if di < dj then
        code := code-di*pi-dj*pj+dj*pi+di*pj
        path := .swapHonors ⟨i%7, Nat.mod_lt _ (by decide)⟩ ⟨j%7, Nat.mod_lt _ (by decide)⟩ :: path
  return ({s with h := code},path)

def locate (ids honors : ByteArray) (buckets : Array Bucket) (s : Packed) : Reference :=
  let (canonical,path) := normalize ids s
  let h := BucketIndex.readLE honors (4*canonical.h) 4
  let bucket := buckets.getD h emptyBucket
  ⟨h,BucketIndex.rank bucket.data canonical,canonical,path⟩

def target (ids honors : ByteArray) (buckets : Array Bucket) : Target where
  size := fun h => (buckets.getD h emptyBucket).data.size
  unrank := fun h i => BucketIndex.unrank (buckets.getD h emptyBucket).data i
  labelP := fun h i => TerminalBucket.labelP (buckets.getD h emptyBucket).bits i
  locate := locate ids honors buckets

def row (tables : Tables) (next : Target) (source : Bucket) (i : Nat) : Bool :=
  BucketIndex.roundtrip source.data i &&
    GeneralLayer.row tables next (BucketIndex.unrank source.data i) (TerminalBucket.labelP source.bits i)

theorem row_sound (tables : Tables) (cache : Checked tables) (next : Target)
    (correct : TargetCorrect tables next) (source : Bucket) (i : Nat)
    (accepted : row tables next source i = true) :
    IsSafe (state tables (BucketIndex.unrank source.data i)) ∧
    SafeGame.NormalStrategy SafeMove (state tables (BucketIndex.unrank source.data i))
      (outcome (TerminalBucket.labelP source.bits i)) := by
  simp only [row, Bool.and_eq_true] at accepted
  exact GeneralLayer.row_sound tables cache next correct _ _ accepted.2

def span (tables : Tables) (next : Target) (source : Bucket) (start : Nat) : Nat → Bool
  | 0 => true
  | count+1 => row tables next source start && span tables next source (start+1) count

theorem span_each (tables : Tables) (next : Target) (source : Bucket) (count start : Nat)
    (h : span tables next source start count = true) :
    ∀ offset, offset < count → row tables next source (start+offset) = true := by
  induction count generalizing start with
  | zero => intro offset h; omega
  | succ count ih =>
    simp only [span, Bool.and_eq_true] at h
    intro offset less
    cases offset with
    | zero => simpa using h.1
    | succ offset =>
      have x := ih (start+1) h.2 offset (by omega)
      simpa [Nat.add_assoc, Nat.add_comm, Nat.add_left_comm] using x

theorem span_add (tables : Tables) (next : Target) (source : Bucket) (a b start : Nat) :
    span tables next source start (a+b) =
      (span tables next source start a && span tables next source (start+a) b) := by
  induction a generalizing start with
  | zero => simp [span]
  | succ a ih =>
    simp only [Nat.succ_add, span, ih]
    simp [Nat.add_assoc, Nat.add_comm, Nat.add_left_comm, Bool.and_assoc]

end Mahjong.GeneralIndex

#print axioms Mahjong.GeneralIndex.row_sound
#print axioms Mahjong.GeneralIndex.span_each
#print axioms Mahjong.GeneralIndex.span_add
