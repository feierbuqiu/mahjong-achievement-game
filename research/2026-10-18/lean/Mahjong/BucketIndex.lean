import Mahjong.PackedRules

namespace Mahjong.BucketIndex
open PackedRules

def readLE (data : ByteArray) (offset width : Nat) : Nat :=
  (List.range width).foldr (fun j r => r * 256 + (data[offset+j]!).toNat) 0

structure Data where
  numeric : ByteArray
  ids : ByteArray
  groups : ByteArray
  directory : ByteArray
  honorCode : Nat
  size : Nat

def choose2 (x : Nat) : Nat := x * (x+1) / 2
def choose3 (x : Nat) : Nat := x * (x+1) * (x+2) / 6

def floorSearch (f : Nat → Nat) (r : Nat) : Nat → Nat → Nat → Nat
  | 0, lo, _ => lo
  | fuel+1, lo, hi =>
    if hi ≤ lo+1 then lo else
      let mid := (lo+hi)/2
      if f mid ≤ r then floorSearch f r fuel mid hi else floorSearch f r fuel lo mid

def field (d : Data) (block offset width : Nat) : Nat := readLE d.directory (block*32+offset) width
def groupFirst (d : Data) (g : Nat) : Nat := readLE d.groups (g*8) 4
def groupSize (d : Data) (g : Nat) : Nat := readLE d.groups (g*8+4) 4
def blockAt (d : Data) (i : Nat) : Nat :=
  floorSearch (fun b => field d b 0 8) i 64 0 (d.directory.size/32)

def decodeIds (d : Data) (i : Nat) : Nat × Nat × Nat := Id.run do
  let b := blockAt d i
  let g0 := field d b 16 4
  let g1 := field d b 20 4
  let g2 := field d b 24 4
  let r := i-field d b 0 8
  let na := groupSize d g0
  let nb := groupSize d g1
  let nc := groupSize d g2
  let (x,y,z) := if g0 = g2 then
      let z := floorSearch choose3 r 32 0 na
      let r := r-choose3 z
      let y := floorSearch choose2 r 32 0 na
      (r-choose2 y,y,z)
    else if g0 = g1 then
      let z := r/choose2 na
      let q := r%choose2 na
      let y := floorSearch choose2 q 32 0 na
      (q-choose2 y,y,z)
    else if g1 = g2 then
      let q := r/na
      let z := floorSearch choose2 q 32 0 nc
      (r%na,q-choose2 z,z)
    else (r%na,(r/na)%nb,(r/na)/nb)
  return (groupFirst d g0+x,groupFirst d g1+y,groupFirst d g2+z)

def unrank (d : Data) (i : Nat) : Packed :=
  let (a,b,c) := decodeIds d i
  ⟨readLE d.numeric (a*12) 4,readLE d.numeric (b*12) 4,
    readLE d.numeric (c*12) 4,d.honorCode⟩

def rank (d : Data) (s : Packed) : Nat := Id.run do
  let a := readLE d.ids (s.a*4) 4
  let b := readLE d.ids (s.b*4) 4
  let c := readLE d.ids (s.c*4) 4
  let g0 := readLE d.numeric (a*12+4) 4
  let g1 := readLE d.numeric (b*12+4) 4
  let g2 := readLE d.numeric (c*12+4) 4
  let x := readLE d.numeric (a*12+8) 4
  let y := readLE d.numeric (b*12+8) 4
  let z := readLE d.numeric (c*12+8) 4
  let key := g0*1104*1104+g1*1104+g2
  let block := floorSearch (fun k => field d k 16 4*1104*1104+
      field d k 20 4*1104+field d k 24 4) key 64 0 (d.directory.size/32)
  let base := field d block 0 8
  let na := groupSize d g0
  let nb := groupSize d g1
  let within := if g0 = g2 then x+choose2 y+choose3 z
    else if g0 = g1 then x+choose2 y+choose2 na*z
    else if g1 = g2 then x+na*(y+choose2 z)
    else x+na*(y+nb*z)
  return base+within

def roundtrip (d : Data) (i : Nat) : Bool :=
  let s := unrank d i
  let r := rank d s
  decide (r = i) && decide (r < d.size) && decide (unrank d r = s)

theorem visited_injective (d : Data) (i j : Nat)
    (hi : roundtrip d i = true) (hj : roundtrip d j = true)
    (same : unrank d i = unrank d j) : i = j := by
  simp only [roundtrip, Bool.and_eq_true, decide_eq_true_eq] at hi hj
  rw [← hi.1.1, ← hj.1.1, same]

end Mahjong.BucketIndex

#print axioms Mahjong.BucketIndex.visited_injective
