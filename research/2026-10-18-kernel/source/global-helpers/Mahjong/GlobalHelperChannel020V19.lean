module
prelude
public import Init.Data.Nat.Bitwise.Basic
public section
set_option autoImplicit false
set_option exponentiation.threshold 16777216
set_option maxRecDepth 65536
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
namespace Mahjong.GlobalHelperChannel020V19
noncomputable def mask (width : Nat) : Nat := 2^width-1
noncomputable def cut0 (width input : Nat) : Nat := (input >>> (32*width)) &&& (mask width)
noncomputable def cut1 (width input : Nat) : Nat := (input >>> (33*width)) &&& (mask width)
noncomputable def cut2 (width input : Nat) : Nat := (input >>> (34*width)) &&& (mask width)
noncomputable def cut3 (width input : Nat) : Nat := (input >>> (35*width)) &&& (mask width)
noncomputable def cut4 (width input : Nat) : Nat := (input >>> (37*width)) &&& (mask width)
noncomputable def cut5 (width input : Nat) : Nat := (input >>> (38*width)) &&& (mask width)
noncomputable def cut6 (width input : Nat) : Nat := (input >>> (39*width)) &&& (mask width)
noncomputable def cut7 (width input : Nat) : Nat := (input >>> (40*width)) &&& (mask width)
noncomputable def cut8 (width input : Nat) : Nat := (input >>> (41*width)) &&& (mask width)
noncomputable def lane256 (width input : Nat) : Nat := (cut0 width input)
noncomputable def lane258 (width input : Nat) : Nat := (cut1 width input)
noncomputable def lane334 (width input : Nat) : Nat := (cut2 width input)
noncomputable def lane336 (width input : Nat) : Nat := (cut3 width input)
noncomputable def lane351 (width input : Nat) : Nat := (cut4 width input)
noncomputable def lane352 (width input : Nat) : Nat := (cut5 width input)
noncomputable def lane353 (width input : Nat) : Nat := (cut6 width input)
noncomputable def lane354 (width input : Nat) : Nat := (cut7 width input)
noncomputable def lane355 (width input : Nat) : Nat := (cut8 width input)
noncomputable def concatpart0 (width input : Nat) : Nat := (lane258 width input) <<< (2*width)
noncomputable def concatpart1 (width input : Nat) : Nat := (lane256 width input) ||| (concatpart0 width input)
noncomputable def concatpart2 (width input : Nat) : Nat := (lane334 width input) <<< (2*width)
noncomputable def concatpart3 (width input : Nat) : Nat := (concatpart2 width input) <<< (4*width)
noncomputable def concatpart4 (width input : Nat) : Nat := (concatpart3 width input) <<< (8*width)
noncomputable def concatpart5 (width input : Nat) : Nat := (lane351 width input) <<< width
noncomputable def concatpart6 (width input : Nat) : Nat := (concatpart5 width input) <<< (2*width)
noncomputable def concatpart7 (width input : Nat) : Nat := (concatpart6 width input) <<< (4*width)
noncomputable def concatpart8 (width input : Nat) : Nat := (concatpart7 width input) <<< (8*width)
noncomputable def concatpart9 (width input : Nat) : Nat := (lane336 width input) ||| (concatpart8 width input)
noncomputable def concatpart10 (width input : Nat) : Nat := (concatpart9 width input) <<< (16*width)
noncomputable def concatpart11 (width input : Nat) : Nat := (concatpart4 width input) ||| (concatpart10 width input)
noncomputable def concatpart12 (width input : Nat) : Nat := (lane353 width input) <<< width
noncomputable def concatpart13 (width input : Nat) : Nat := (lane352 width input) ||| (concatpart12 width input)
noncomputable def concatpart14 (width input : Nat) : Nat := (lane355 width input) <<< width
noncomputable def concatpart15 (width input : Nat) : Nat := (lane354 width input) ||| (concatpart14 width input)
noncomputable def concatpart16 (width input : Nat) : Nat := (concatpart15 width input) <<< (2*width)
noncomputable def concatpart17 (width input : Nat) : Nat := (concatpart13 width input) ||| (concatpart16 width input)
noncomputable def concatpart18 (width input : Nat) : Nat := (concatpart17 width input) <<< (32*width)
noncomputable def concatpart19 (width input : Nat) : Nat := (concatpart11 width input) ||| (concatpart18 width input)
noncomputable def concatpart20 (width input : Nat) : Nat := (concatpart19 width input) <<< (64*width)
noncomputable def concatpart21 (width input : Nat) : Nat := (concatpart1 width input) ||| (concatpart20 width input)
noncomputable def concatpart22 (width input : Nat) : Nat := (concatpart21 width input) <<< (256*width)
noncomputable def channel (width input : Nat) : Nat := (concatpart22 width input)
theorem marker : (0 : Nat)=0 := rfl
end Mahjong.GlobalHelperChannel020V19
#print axioms Mahjong.GlobalHelperChannel020V19.marker
