module
prelude
public import Init.Data.Nat.Bitwise.Basic
public section
set_option autoImplicit false
set_option exponentiation.threshold 16777216
set_option maxRecDepth 65536
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
namespace Mahjong.GlobalHelperChannel006V19
noncomputable def mask (width : Nat) : Nat := 2^width-1
noncomputable def cut0 (width input : Nat) : Nat := (input >>> 0) &&& (mask width)
noncomputable def lane33 (width input : Nat) : Nat := (cut0 width input)
noncomputable def concatpart0 (width input : Nat) : Nat := (lane33 width input) <<< width
noncomputable def concatpart1 (width input : Nat) : Nat := (concatpart0 width input) <<< (32*width)
noncomputable def channel (width input : Nat) : Nat := (concatpart1 width input)
theorem marker : (0 : Nat)=0 := rfl
end Mahjong.GlobalHelperChannel006V19
#print axioms Mahjong.GlobalHelperChannel006V19.marker
