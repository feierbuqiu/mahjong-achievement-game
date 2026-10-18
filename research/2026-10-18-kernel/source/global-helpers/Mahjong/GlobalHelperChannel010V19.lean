module
prelude
public import Init.Data.Nat.Bitwise.Basic
public section
set_option autoImplicit false
set_option exponentiation.threshold 16777216
set_option maxRecDepth 65536
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
namespace Mahjong.GlobalHelperChannel010V19
noncomputable def mask (width : Nat) : Nat := 2^width-1
noncomputable def cut0 (width input : Nat) : Nat := (input >>> 0) &&& (mask width)
noncomputable def cut1 (width input : Nat) : Nat := (input >>> width) &&& (mask width)
noncomputable def cut2 (width input : Nat) : Nat := (input >>> (2*width)) &&& (mask width)
noncomputable def cut3 (width input : Nat) : Nat := (input >>> (3*width)) &&& (mask width)
noncomputable def cut4 (width input : Nat) : Nat := (input >>> (4*width)) &&& (mask width)
noncomputable def cut5 (width input : Nat) : Nat := (input >>> (5*width)) &&& (mask width)
noncomputable def lane0part0 (width input : Nat) : Nat := (cut0 width input) ||| (cut1 width input)
noncomputable def lane0part1 (width input : Nat) : Nat := (cut3 width input) ||| (cut5 width input)
noncomputable def lane0part2 (width input : Nat) : Nat := (lane0part0 width input) ||| (lane0part1 width input)
noncomputable def lane0 (width input : Nat) : Nat := (lane0part2 width input)
noncomputable def lane1part3 (width input : Nat) : Nat := (cut3 width input) ||| (cut4 width input)
noncomputable def lane1part4 (width input : Nat) : Nat := (cut2 width input) ||| (lane1part3 width input)
noncomputable def lane1 (width input : Nat) : Nat := (lane1part4 width input)
noncomputable def lane2part5 (width input : Nat) : Nat := (cut1 width input) ||| (cut2 width input)
noncomputable def lane2 (width input : Nat) : Nat := (lane2part5 width input)
noncomputable def lane3 (width input : Nat) : Nat := (cut0 width input)
noncomputable def concatpart6 (width input : Nat) : Nat := (lane1 width input) <<< width
noncomputable def concatpart7 (width input : Nat) : Nat := (lane0 width input) ||| (concatpart6 width input)
noncomputable def concatpart8 (width input : Nat) : Nat := (lane3 width input) <<< width
noncomputable def concatpart9 (width input : Nat) : Nat := (lane2 width input) ||| (concatpart8 width input)
noncomputable def concatpart10 (width input : Nat) : Nat := (concatpart9 width input) <<< (2*width)
noncomputable def concatpart11 (width input : Nat) : Nat := (concatpart7 width input) ||| (concatpart10 width input)
noncomputable def channel (width input : Nat) : Nat := (concatpart11 width input)
theorem marker : (0 : Nat)=0 := rfl
end Mahjong.GlobalHelperChannel010V19
#print axioms Mahjong.GlobalHelperChannel010V19.marker
