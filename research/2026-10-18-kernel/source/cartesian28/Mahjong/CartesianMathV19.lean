module
prelude
public import Init.Data.Nat.Bitwise.Basic
public section
set_option autoImplicit false
namespace Mahjong.CartesianMathV19
def deltaSwap (input selected distance : Nat) : Nat :=
  let changed := (input ^^^ (input >>> distance)) &&& selected
  input ^^^ changed ^^^ (changed <<< distance)
def repeatMask : Nat → Nat → Nat → Nat
  | 0, _, width => 2^width-1
  | k+1, stride, width =>
    let old := repeatMask k stride width
    old ||| (old <<< ((2^k)*stride))
def scatterStages : Nat → Nat → Nat → Nat → Nat → Nat
  | 0, _, _, _, input => input
  | k+1, done, stride, width, input =>
    let scale := 2^k
    let s := stride*scale
    let w := width*scale
    let selected := repeatMask done (2*s) w
    scatterStages k (done+1) stride width
      ((input &&& selected) ||| ((input &&& (selected <<< w)) <<< (s-w)))
def scatter (k records stride width input : Nat) : Nat :=
  scatterStages k 0 stride width (input &&& (2^(records*width)-1))
def pad (a b c ap bp cp input : Nat) : Nat :=
  scatter cp c (2^(ap+bp)) ((2^ap)*b) (scatter (bp+cp) (b*c) (2^ap) a input)
def lowMask (total lo hi : Nat) : Nat :=
  ((repeatMask (total-lo-1) (2^(lo+1)) (2^lo)) <<< (2^lo)) &&&
    ((2^(2^total)-1) ^^^ ((repeatMask (total-hi-1) (2^(hi+1)) (2^hi)) <<< (2^hi)))
def permute (total : Nat) : List (Nat × Nat) → Nat → Nat
  | .nil, input => input
  | .cons (lo,hi) rest, input => permute total rest (deltaSwap input (lowMask total lo hi) (2^hi-2^lo))
theorem marker : (0 : Nat)=0 := rfl
end Mahjong.CartesianMathV19
#print axioms Mahjong.CartesianMathV19.marker
