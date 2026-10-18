module
prelude
public import Init.Data.Nat.Bitwise.Basic
public section
set_option autoImplicit false
set_option exponentiation.threshold 16777216
set_option maxRecDepth 65536
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
namespace Mahjong.GlobalHelperChannel018V19
noncomputable def mask (width : Nat) : Nat := 2^width-1
noncomputable def cut0 (width input : Nat) : Nat := (input >>> (2*width)) &&& (mask width)
noncomputable def lane224 (width input : Nat) : Nat := (cut0 width input)
noncomputable def lane226 (width input : Nat) : Nat := (cut0 width input)
noncomputable def concatpart0 (width input : Nat) : Nat := (lane226 width input) <<< (2*width)
noncomputable def concatpart1 (width input : Nat) : Nat := (lane224 width input) ||| (concatpart0 width input)
noncomputable def concatpart2 (width input : Nat) : Nat := (concatpart1 width input) <<< (32*width)
noncomputable def concatpart3 (width input : Nat) : Nat := (concatpart2 width input) <<< (64*width)
noncomputable def concatpart4 (width input : Nat) : Nat := (concatpart3 width input) <<< (128*width)
noncomputable def channel (width input : Nat) : Nat := (concatpart4 width input)
theorem marker : (0 : Nat)=0 := rfl
end Mahjong.GlobalHelperChannel018V19
#print axioms Mahjong.GlobalHelperChannel018V19.marker
