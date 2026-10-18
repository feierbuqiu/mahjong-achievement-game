module
prelude
public import Init.Data.Nat.Bitwise.Basic
public section
set_option autoImplicit false
set_option exponentiation.threshold 16777216
set_option maxRecDepth 65536
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
namespace Mahjong.GlobalHelperChannel002V19
noncomputable def mask (width : Nat) : Nat := 2^width-1
noncomputable def cut0 (width input : Nat) : Nat := (input >>> 0) &&& (mask width)
noncomputable def cut1 (width input : Nat) : Nat := (input >>> width) &&& (mask width)
noncomputable def lane1 (width input : Nat) : Nat := (cut0 width input)
noncomputable def lane2 (width input : Nat) : Nat := (cut0 width input)
noncomputable def lane3part0 (width input : Nat) : Nat := (cut0 width input) ||| (cut1 width input)
noncomputable def lane3 (width input : Nat) : Nat := (lane3part0 width input)
noncomputable def concatpart1 (width input : Nat) : Nat := (lane1 width input) <<< width
noncomputable def concatpart2 (width input : Nat) : Nat := (lane3 width input) <<< width
noncomputable def concatpart3 (width input : Nat) : Nat := (lane2 width input) ||| (concatpart2 width input)
noncomputable def concatpart4 (width input : Nat) : Nat := (concatpart3 width input) <<< (2*width)
noncomputable def concatpart5 (width input : Nat) : Nat := (concatpart1 width input) ||| (concatpart4 width input)
noncomputable def channel (width input : Nat) : Nat := (concatpart5 width input)
theorem marker : (0 : Nat)=0 := rfl
end Mahjong.GlobalHelperChannel002V19
#print axioms Mahjong.GlobalHelperChannel002V19.marker
