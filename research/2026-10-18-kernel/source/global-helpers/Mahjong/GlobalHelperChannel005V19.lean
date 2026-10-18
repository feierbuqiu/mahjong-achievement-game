module
prelude
public import Init.Data.Nat.Bitwise.Basic
public section
set_option autoImplicit false
set_option exponentiation.threshold 16777216
set_option maxRecDepth 65536
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
namespace Mahjong.GlobalHelperChannel005V19
noncomputable def mask (width : Nat) : Nat := 2^width-1
noncomputable def cut0 (width input : Nat) : Nat := (input >>> 0) &&& (mask width)
noncomputable def cut1 (width input : Nat) : Nat := (input >>> width) &&& (mask width)
noncomputable def cut2 (width input : Nat) : Nat := (input >>> (2*width)) &&& (mask width)
noncomputable def cut3 (width input : Nat) : Nat := (input >>> (3*width)) &&& (mask width)
noncomputable def cut4 (width input : Nat) : Nat := (input >>> (4*width)) &&& (mask width)
noncomputable def cut5 (width input : Nat) : Nat := (input >>> (7*width)) &&& (mask width)
noncomputable def cut6 (width input : Nat) : Nat := (input >>> (8*width)) &&& (mask width)
noncomputable def cut7 (width input : Nat) : Nat := (input >>> (10*width)) &&& (mask width)
noncomputable def cut8 (width input : Nat) : Nat := (input >>> (11*width)) &&& (mask width)
noncomputable def lane12 (width input : Nat) : Nat := (cut0 width input)
noncomputable def lane13 (width input : Nat) : Nat := (cut0 width input)
noncomputable def lane14 (width input : Nat) : Nat := (cut0 width input)
noncomputable def lane20 (width input : Nat) : Nat := (cut1 width input)
noncomputable def lane21 (width input : Nat) : Nat := (cut1 width input)
noncomputable def lane22part0 (width input : Nat) : Nat := (cut1 width input) ||| (cut2 width input)
noncomputable def lane22 (width input : Nat) : Nat := (lane22part0 width input)
noncomputable def lane25 (width input : Nat) : Nat := (cut3 width input)
noncomputable def lane26 (width input : Nat) : Nat := (cut3 width input)
noncomputable def lane27part1 (width input : Nat) : Nat := (cut3 width input) ||| (cut4 width input)
noncomputable def lane27 (width input : Nat) : Nat := (lane27part1 width input)
noncomputable def lane36 (width input : Nat) : Nat := (cut5 width input)
noncomputable def lane37 (width input : Nat) : Nat := (cut5 width input)
noncomputable def lane38part2 (width input : Nat) : Nat := (cut5 width input) ||| (cut6 width input)
noncomputable def lane38 (width input : Nat) : Nat := (lane38part2 width input)
noncomputable def lane42 (width input : Nat) : Nat := (cut7 width input)
noncomputable def lane43 (width input : Nat) : Nat := (cut7 width input)
noncomputable def lane44part3 (width input : Nat) : Nat := (cut7 width input) ||| (cut8 width input)
noncomputable def lane44 (width input : Nat) : Nat := (lane44part3 width input)
noncomputable def concatpart4 (width input : Nat) : Nat := (lane13 width input) <<< width
noncomputable def concatpart5 (width input : Nat) : Nat := (lane12 width input) ||| (concatpart4 width input)
noncomputable def concatpart6 (width input : Nat) : Nat := (lane14 width input) <<< (2*width)
noncomputable def concatpart7 (width input : Nat) : Nat := (concatpart5 width input) ||| (concatpart6 width input)
noncomputable def concatpart8 (width input : Nat) : Nat := (concatpart7 width input) <<< (4*width)
noncomputable def concatpart9 (width input : Nat) : Nat := (concatpart8 width input) <<< (8*width)
noncomputable def concatpart10 (width input : Nat) : Nat := (lane21 width input) <<< width
noncomputable def concatpart11 (width input : Nat) : Nat := (lane20 width input) ||| (concatpart10 width input)
noncomputable def concatpart12 (width input : Nat) : Nat := (lane22 width input) <<< (2*width)
noncomputable def concatpart13 (width input : Nat) : Nat := (concatpart11 width input) ||| (concatpart12 width input)
noncomputable def concatpart14 (width input : Nat) : Nat := (concatpart13 width input) <<< (4*width)
noncomputable def concatpart15 (width input : Nat) : Nat := (lane25 width input) <<< width
noncomputable def concatpart16 (width input : Nat) : Nat := (lane27 width input) <<< width
noncomputable def concatpart17 (width input : Nat) : Nat := (lane26 width input) ||| (concatpart16 width input)
noncomputable def concatpart18 (width input : Nat) : Nat := (concatpart17 width input) <<< (2*width)
noncomputable def concatpart19 (width input : Nat) : Nat := (concatpart15 width input) ||| (concatpart18 width input)
noncomputable def concatpart20 (width input : Nat) : Nat := (concatpart19 width input) <<< (8*width)
noncomputable def concatpart21 (width input : Nat) : Nat := (concatpart14 width input) ||| (concatpart20 width input)
noncomputable def concatpart22 (width input : Nat) : Nat := (concatpart21 width input) <<< (16*width)
noncomputable def concatpart23 (width input : Nat) : Nat := (concatpart9 width input) ||| (concatpart22 width input)
noncomputable def concatpart24 (width input : Nat) : Nat := (lane37 width input) <<< width
noncomputable def concatpart25 (width input : Nat) : Nat := (lane36 width input) ||| (concatpart24 width input)
noncomputable def concatpart26 (width input : Nat) : Nat := (lane38 width input) <<< (2*width)
noncomputable def concatpart27 (width input : Nat) : Nat := (concatpart25 width input) ||| (concatpart26 width input)
noncomputable def concatpart28 (width input : Nat) : Nat := (concatpart27 width input) <<< (4*width)
noncomputable def concatpart29 (width input : Nat) : Nat := (lane43 width input) <<< width
noncomputable def concatpart30 (width input : Nat) : Nat := (lane42 width input) ||| (concatpart29 width input)
noncomputable def concatpart31 (width input : Nat) : Nat := (concatpart30 width input) <<< (2*width)
noncomputable def concatpart32 (width input : Nat) : Nat := (lane44 width input) <<< (4*width)
noncomputable def concatpart33 (width input : Nat) : Nat := (concatpart31 width input) ||| (concatpart32 width input)
noncomputable def concatpart34 (width input : Nat) : Nat := (concatpart33 width input) <<< (8*width)
noncomputable def concatpart35 (width input : Nat) : Nat := (concatpart28 width input) ||| (concatpart34 width input)
noncomputable def concatpart36 (width input : Nat) : Nat := (concatpart35 width input) <<< (32*width)
noncomputable def concatpart37 (width input : Nat) : Nat := (concatpart23 width input) ||| (concatpart36 width input)
noncomputable def channel (width input : Nat) : Nat := (concatpart37 width input)
theorem marker : (0 : Nat)=0 := rfl
end Mahjong.GlobalHelperChannel005V19
#print axioms Mahjong.GlobalHelperChannel005V19.marker
