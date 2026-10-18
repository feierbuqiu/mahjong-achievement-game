module
prelude
public import Init.Data.Nat.Bitwise.Basic
public section
set_option autoImplicit false
set_option exponentiation.threshold 16777216
set_option maxRecDepth 65536
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
namespace Mahjong.GlobalHelperChannel253V19
noncomputable def mask (width : Nat) : Nat := 2^width-1
noncomputable def cut0 (width input : Nat) : Nat := (input >>> (2*width)) &&& (mask width)
noncomputable def cut1 (width input : Nat) : Nat := (input >>> (3*width)) &&& (mask width)
noncomputable def cut2 (width input : Nat) : Nat := (input >>> (6*width)) &&& (mask width)
noncomputable def cut3 (width input : Nat) : Nat := (input >>> (7*width)) &&& (mask width)
noncomputable def cut4 (width input : Nat) : Nat := (input >>> (10*width)) &&& (mask width)
noncomputable def cut5 (width input : Nat) : Nat := (input >>> (11*width)) &&& (mask width)
noncomputable def cut6 (width input : Nat) : Nat := (input >>> (14*width)) &&& (mask width)
noncomputable def cut7 (width input : Nat) : Nat := (input >>> (15*width)) &&& (mask width)
noncomputable def cut8 (width input : Nat) : Nat := (input >>> (18*width)) &&& (mask width)
noncomputable def cut9 (width input : Nat) : Nat := (input >>> (19*width)) &&& (mask width)
noncomputable def lane0 (width input : Nat) : Nat := (cut0 width input)
noncomputable def lane1 (width input : Nat) : Nat := (cut1 width input)
noncomputable def lane7 (width input : Nat) : Nat := (cut2 width input)
noncomputable def lane10 (width input : Nat) : Nat := (cut3 width input)
noncomputable def lane56 (width input : Nat) : Nat := (cut4 width input)
noncomputable def lane67 (width input : Nat) : Nat := (cut5 width input)
noncomputable def lane202 (width input : Nat) : Nat := (cut6 width input)
noncomputable def lane216 (width input : Nat) : Nat := (cut7 width input)
noncomputable def lane483 (width input : Nat) : Nat := (cut8 width input)
noncomputable def lane499 (width input : Nat) : Nat := (cut9 width input)
noncomputable def concatpart0 (width input : Nat) : Nat := (lane1 width input) <<< width
noncomputable def concatpart1 (width input : Nat) : Nat := (lane0 width input) ||| (concatpart0 width input)
noncomputable def concatpart2 (width input : Nat) : Nat := (lane7 width input) <<< width
noncomputable def concatpart3 (width input : Nat) : Nat := (concatpart2 width input) <<< (2*width)
noncomputable def concatpart4 (width input : Nat) : Nat := (concatpart3 width input) <<< (4*width)
noncomputable def concatpart5 (width input : Nat) : Nat := (concatpart1 width input) ||| (concatpart4 width input)
noncomputable def concatpart6 (width input : Nat) : Nat := (lane10 width input) <<< (2*width)
noncomputable def concatpart7 (width input : Nat) : Nat := (concatpart6 width input) <<< (8*width)
noncomputable def concatpart8 (width input : Nat) : Nat := (concatpart5 width input) ||| (concatpart7 width input)
noncomputable def concatpart9 (width input : Nat) : Nat := (lane56 width input) <<< (8*width)
noncomputable def concatpart10 (width input : Nat) : Nat := (concatpart9 width input) <<< (16*width)
noncomputable def concatpart11 (width input : Nat) : Nat := (concatpart10 width input) <<< (32*width)
noncomputable def concatpart12 (width input : Nat) : Nat := (concatpart8 width input) ||| (concatpart11 width input)
noncomputable def concatpart13 (width input : Nat) : Nat := (lane67 width input) <<< width
noncomputable def concatpart14 (width input : Nat) : Nat := (concatpart13 width input) <<< (2*width)
noncomputable def concatpart15 (width input : Nat) : Nat := (concatpart14 width input) <<< (64*width)
noncomputable def concatpart16 (width input : Nat) : Nat := (concatpart12 width input) ||| (concatpart15 width input)
noncomputable def concatpart17 (width input : Nat) : Nat := (lane202 width input) <<< (2*width)
noncomputable def concatpart18 (width input : Nat) : Nat := (concatpart17 width input) <<< (8*width)
noncomputable def concatpart19 (width input : Nat) : Nat := (lane216 width input) <<< (8*width)
noncomputable def concatpart20 (width input : Nat) : Nat := (concatpart19 width input) <<< (16*width)
noncomputable def concatpart21 (width input : Nat) : Nat := (concatpart18 width input) ||| (concatpart20 width input)
noncomputable def concatpart22 (width input : Nat) : Nat := (concatpart21 width input) <<< (64*width)
noncomputable def concatpart23 (width input : Nat) : Nat := (concatpart22 width input) <<< (128*width)
noncomputable def concatpart24 (width input : Nat) : Nat := (concatpart16 width input) ||| (concatpart23 width input)
noncomputable def concatpart25 (width input : Nat) : Nat := (lane483 width input) <<< width
noncomputable def concatpart26 (width input : Nat) : Nat := (concatpart25 width input) <<< (2*width)
noncomputable def concatpart27 (width input : Nat) : Nat := (lane499 width input) <<< width
noncomputable def concatpart28 (width input : Nat) : Nat := (concatpart27 width input) <<< (2*width)
noncomputable def concatpart29 (width input : Nat) : Nat := (concatpart28 width input) <<< (16*width)
noncomputable def concatpart30 (width input : Nat) : Nat := (concatpart26 width input) ||| (concatpart29 width input)
noncomputable def concatpart31 (width input : Nat) : Nat := (concatpart30 width input) <<< (32*width)
noncomputable def concatpart32 (width input : Nat) : Nat := (concatpart31 width input) <<< (64*width)
noncomputable def concatpart33 (width input : Nat) : Nat := (concatpart32 width input) <<< (128*width)
noncomputable def concatpart34 (width input : Nat) : Nat := (concatpart33 width input) <<< (256*width)
noncomputable def concatpart35 (width input : Nat) : Nat := (concatpart24 width input) ||| (concatpart34 width input)
noncomputable def channel (width input : Nat) : Nat := (concatpart35 width input)
theorem marker : (0 : Nat)=0 := rfl
end Mahjong.GlobalHelperChannel253V19
#print axioms Mahjong.GlobalHelperChannel253V19.marker
