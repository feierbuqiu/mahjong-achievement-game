module
prelude
public import Init.Data.Nat.Bitwise.Basic
public section
set_option autoImplicit false
set_option exponentiation.threshold 16777216
set_option maxRecDepth 65536
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
namespace Mahjong.GlobalHelperChannel259V19
noncomputable def mask (width : Nat) : Nat := 2^width-1
noncomputable def cut0 (width input : Nat) : Nat := (input >>> (4*width)) &&& (mask width)
noncomputable def cut1 (width input : Nat) : Nat := (input >>> (10*width)) &&& (mask width)
noncomputable def cut2 (width input : Nat) : Nat := (input >>> (12*width)) &&& (mask width)
noncomputable def cut3 (width input : Nat) : Nat := (input >>> (19*width)) &&& (mask width)
noncomputable def cut4 (width input : Nat) : Nat := (input >>> (21*width)) &&& (mask width)
noncomputable def cut5 (width input : Nat) : Nat := (input >>> (31*width)) &&& (mask width)
noncomputable def cut6 (width input : Nat) : Nat := (input >>> (33*width)) &&& (mask width)
noncomputable def lane6 (width input : Nat) : Nat := (cut0 width input)
noncomputable def lane48 (width input : Nat) : Nat := (cut1 width input)
noncomputable def lane49 (width input : Nat) : Nat := (cut2 width input)
noncomputable def lane187 (width input : Nat) : Nat := (cut3 width input)
noncomputable def lane188 (width input : Nat) : Nat := (cut4 width input)
noncomputable def lane464 (width input : Nat) : Nat := (cut5 width input)
noncomputable def lane465 (width input : Nat) : Nat := (cut6 width input)
noncomputable def concatpart0 (width input : Nat) : Nat := (lane6 width input) <<< (2*width)
noncomputable def concatpart1 (width input : Nat) : Nat := (concatpart0 width input) <<< (4*width)
noncomputable def concatpart2 (width input : Nat) : Nat := (lane49 width input) <<< width
noncomputable def concatpart3 (width input : Nat) : Nat := (lane48 width input) ||| (concatpart2 width input)
noncomputable def concatpart4 (width input : Nat) : Nat := (concatpart3 width input) <<< (16*width)
noncomputable def concatpart5 (width input : Nat) : Nat := (concatpart4 width input) <<< (32*width)
noncomputable def concatpart6 (width input : Nat) : Nat := (concatpart1 width input) ||| (concatpart5 width input)
noncomputable def concatpart7 (width input : Nat) : Nat := (lane187 width input) <<< width
noncomputable def concatpart8 (width input : Nat) : Nat := (concatpart7 width input) <<< (2*width)
noncomputable def concatpart9 (width input : Nat) : Nat := (lane188 width input) <<< (4*width)
noncomputable def concatpart10 (width input : Nat) : Nat := (concatpart8 width input) ||| (concatpart9 width input)
noncomputable def concatpart11 (width input : Nat) : Nat := (concatpart10 width input) <<< (8*width)
noncomputable def concatpart12 (width input : Nat) : Nat := (concatpart11 width input) <<< (16*width)
noncomputable def concatpart13 (width input : Nat) : Nat := (concatpart12 width input) <<< (32*width)
noncomputable def concatpart14 (width input : Nat) : Nat := (concatpart13 width input) <<< (128*width)
noncomputable def concatpart15 (width input : Nat) : Nat := (concatpart6 width input) ||| (concatpart14 width input)
noncomputable def concatpart16 (width input : Nat) : Nat := (lane465 width input) <<< width
noncomputable def concatpart17 (width input : Nat) : Nat := (lane464 width input) ||| (concatpart16 width input)
noncomputable def concatpart18 (width input : Nat) : Nat := (concatpart17 width input) <<< (16*width)
noncomputable def concatpart19 (width input : Nat) : Nat := (concatpart18 width input) <<< (64*width)
noncomputable def concatpart20 (width input : Nat) : Nat := (concatpart19 width input) <<< (128*width)
noncomputable def concatpart21 (width input : Nat) : Nat := (concatpart20 width input) <<< (256*width)
noncomputable def concatpart22 (width input : Nat) : Nat := (concatpart15 width input) ||| (concatpart21 width input)
noncomputable def channel (width input : Nat) : Nat := (concatpart22 width input)
theorem marker : (0 : Nat)=0 := rfl
end Mahjong.GlobalHelperChannel259V19
#print axioms Mahjong.GlobalHelperChannel259V19.marker
