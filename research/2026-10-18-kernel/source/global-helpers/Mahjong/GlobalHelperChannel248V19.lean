module
prelude
public import Init.Data.Nat.Bitwise.Basic
public section
set_option autoImplicit false
set_option exponentiation.threshold 16777216
set_option maxRecDepth 65536
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
namespace Mahjong.GlobalHelperChannel248V19
noncomputable def mask (width : Nat) : Nat := 2^width-1
noncomputable def cut0 (width input : Nat) : Nat := (input >>> 0) &&& (mask width)
noncomputable def cut1 (width input : Nat) : Nat := (input >>> width) &&& (mask width)
noncomputable def cut2 (width input : Nat) : Nat := (input >>> (2*width)) &&& (mask width)
noncomputable def cut3 (width input : Nat) : Nat := (input >>> (3*width)) &&& (mask width)
noncomputable def cut4 (width input : Nat) : Nat := (input >>> (4*width)) &&& (mask width)
noncomputable def cut5 (width input : Nat) : Nat := (input >>> (5*width)) &&& (mask width)
noncomputable def cut6 (width input : Nat) : Nat := (input >>> (6*width)) &&& (mask width)
noncomputable def cut7 (width input : Nat) : Nat := (input >>> (7*width)) &&& (mask width)
noncomputable def lane0part0 (width input : Nat) : Nat := (cut1 width input) ||| (cut4 width input)
noncomputable def lane0part1 (width input : Nat) : Nat := (cut0 width input) ||| (lane0part0 width input)
noncomputable def lane0part2 (width input : Nat) : Nat := (cut6 width input) ||| (cut7 width input)
noncomputable def lane0part3 (width input : Nat) : Nat := (cut5 width input) ||| (lane0part2 width input)
noncomputable def lane0part4 (width input : Nat) : Nat := (lane0part1 width input) ||| (lane0part3 width input)
noncomputable def lane0 (width input : Nat) : Nat := (lane0part4 width input)
noncomputable def lane1part5 (width input : Nat) : Nat := (cut3 width input) ||| (cut4 width input)
noncomputable def lane1part6 (width input : Nat) : Nat := (cut2 width input) ||| (lane1part5 width input)
noncomputable def lane1 (width input : Nat) : Nat := (lane1part6 width input)
noncomputable def concatpart7 (width input : Nat) : Nat := (lane1 width input) <<< width
noncomputable def concatpart8 (width input : Nat) : Nat := (lane0 width input) ||| (concatpart7 width input)
noncomputable def channel (width input : Nat) : Nat := (concatpart8 width input)
theorem marker : (0 : Nat)=0 := rfl
end Mahjong.GlobalHelperChannel248V19
#print axioms Mahjong.GlobalHelperChannel248V19.marker
