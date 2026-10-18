module
prelude
public import Init.Data.Nat.Bitwise.Basic
public section
set_option autoImplicit false
set_option exponentiation.threshold 16777216
set_option maxRecDepth 65536
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
namespace Mahjong.GlobalHelperChannel001V19
noncomputable def mask (width : Nat) : Nat := 2^width-1
noncomputable def cut0 (width input : Nat) : Nat := (input >>> 0) &&& (mask width)
noncomputable def cut1 (width input : Nat) : Nat := (input >>> width) &&& (mask width)
noncomputable def cut2 (width input : Nat) : Nat := (input >>> (2*width)) &&& (mask width)
noncomputable def cut3 (width input : Nat) : Nat := (input >>> (3*width)) &&& (mask width)
noncomputable def cut4 (width input : Nat) : Nat := (input >>> (4*width)) &&& (mask width)
noncomputable def cut5 (width input : Nat) : Nat := (input >>> (5*width)) &&& (mask width)
noncomputable def cut6 (width input : Nat) : Nat := (input >>> (6*width)) &&& (mask width)
noncomputable def cut7 (width input : Nat) : Nat := (input >>> (7*width)) &&& (mask width)
noncomputable def cut8 (width input : Nat) : Nat := (input >>> (8*width)) &&& (mask width)
noncomputable def cut9 (width input : Nat) : Nat := (input >>> (9*width)) &&& (mask width)
noncomputable def cut10 (width input : Nat) : Nat := (input >>> (10*width)) &&& (mask width)
noncomputable def cut11 (width input : Nat) : Nat := (input >>> (11*width)) &&& (mask width)
noncomputable def cut12 (width input : Nat) : Nat := (input >>> (12*width)) &&& (mask width)
noncomputable def cut13 (width input : Nat) : Nat := (input >>> (13*width)) &&& (mask width)
noncomputable def cut14 (width input : Nat) : Nat := (input >>> (14*width)) &&& (mask width)
noncomputable def cut15 (width input : Nat) : Nat := (input >>> (15*width)) &&& (mask width)
noncomputable def cut16 (width input : Nat) : Nat := (input >>> (16*width)) &&& (mask width)
noncomputable def cut17 (width input : Nat) : Nat := (input >>> (17*width)) &&& (mask width)
noncomputable def cut18 (width input : Nat) : Nat := (input >>> (18*width)) &&& (mask width)
noncomputable def cut19 (width input : Nat) : Nat := (input >>> (19*width)) &&& (mask width)
noncomputable def cut20 (width input : Nat) : Nat := (input >>> (20*width)) &&& (mask width)
noncomputable def cut21 (width input : Nat) : Nat := (input >>> (21*width)) &&& (mask width)
noncomputable def lane0part0 (width input : Nat) : Nat := (cut0 width input) ||| (cut1 width input)
noncomputable def lane0part1 (width input : Nat) : Nat := (cut8 width input) ||| (cut15 width input)
noncomputable def lane0part2 (width input : Nat) : Nat := (lane0part0 width input) ||| (lane0part1 width input)
noncomputable def lane0 (width input : Nat) : Nat := (lane0part2 width input)
noncomputable def lane1part3 (width input : Nat) : Nat := (cut0 width input) ||| (cut2 width input)
noncomputable def lane1part4 (width input : Nat) : Nat := (cut9 width input) ||| (cut16 width input)
noncomputable def lane1part5 (width input : Nat) : Nat := (lane1part3 width input) ||| (lane1part4 width input)
noncomputable def lane1 (width input : Nat) : Nat := (lane1part5 width input)
noncomputable def lane2part6 (width input : Nat) : Nat := (cut1 width input) ||| (cut3 width input)
noncomputable def lane2part7 (width input : Nat) : Nat := (cut10 width input) ||| (cut17 width input)
noncomputable def lane2part8 (width input : Nat) : Nat := (cut4 width input) ||| (lane2part7 width input)
noncomputable def lane2part9 (width input : Nat) : Nat := (lane2part6 width input) ||| (lane2part8 width input)
noncomputable def lane2 (width input : Nat) : Nat := (lane2part9 width input)
noncomputable def lane3part10 (width input : Nat) : Nat := (cut11 width input) ||| (cut18 width input)
noncomputable def lane3 (width input : Nat) : Nat := (lane3part10 width input)
noncomputable def lane4part11 (width input : Nat) : Nat := (cut3 width input) ||| (cut5 width input)
noncomputable def lane4part12 (width input : Nat) : Nat := (cut2 width input) ||| (lane4part11 width input)
noncomputable def lane4part13 (width input : Nat) : Nat := (cut12 width input) ||| (cut19 width input)
noncomputable def lane4part14 (width input : Nat) : Nat := (cut6 width input) ||| (lane4part13 width input)
noncomputable def lane4part15 (width input : Nat) : Nat := (lane4part12 width input) ||| (lane4part14 width input)
noncomputable def lane4 (width input : Nat) : Nat := (lane4part15 width input)
noncomputable def lane5part16 (width input : Nat) : Nat := (cut4 width input) ||| (cut5 width input)
noncomputable def lane5part17 (width input : Nat) : Nat := (cut13 width input) ||| (cut20 width input)
noncomputable def lane5part18 (width input : Nat) : Nat := (cut7 width input) ||| (lane5part17 width input)
noncomputable def lane5part19 (width input : Nat) : Nat := (lane5part16 width input) ||| (lane5part18 width input)
noncomputable def lane5 (width input : Nat) : Nat := (lane5part19 width input)
noncomputable def lane6part20 (width input : Nat) : Nat := (cut6 width input) ||| (cut7 width input)
noncomputable def lane6part21 (width input : Nat) : Nat := (cut14 width input) ||| (cut21 width input)
noncomputable def lane6part22 (width input : Nat) : Nat := (lane6part20 width input) ||| (lane6part21 width input)
noncomputable def lane6 (width input : Nat) : Nat := (lane6part22 width input)
noncomputable def concatpart23 (width input : Nat) : Nat := (lane1 width input) <<< width
noncomputable def concatpart24 (width input : Nat) : Nat := (lane0 width input) ||| (concatpart23 width input)
noncomputable def concatpart25 (width input : Nat) : Nat := (lane3 width input) <<< width
noncomputable def concatpart26 (width input : Nat) : Nat := (lane2 width input) ||| (concatpart25 width input)
noncomputable def concatpart27 (width input : Nat) : Nat := (concatpart26 width input) <<< (2*width)
noncomputable def concatpart28 (width input : Nat) : Nat := (concatpart24 width input) ||| (concatpart27 width input)
noncomputable def concatpart29 (width input : Nat) : Nat := (lane5 width input) <<< width
noncomputable def concatpart30 (width input : Nat) : Nat := (lane4 width input) ||| (concatpart29 width input)
noncomputable def concatpart31 (width input : Nat) : Nat := (lane6 width input) <<< (2*width)
noncomputable def concatpart32 (width input : Nat) : Nat := (concatpart30 width input) ||| (concatpart31 width input)
noncomputable def concatpart33 (width input : Nat) : Nat := (concatpart32 width input) <<< (4*width)
noncomputable def concatpart34 (width input : Nat) : Nat := (concatpart28 width input) ||| (concatpart33 width input)
noncomputable def channel (width input : Nat) : Nat := (concatpart34 width input)
theorem marker : (0 : Nat)=0 := rfl
end Mahjong.GlobalHelperChannel001V19
#print axioms Mahjong.GlobalHelperChannel001V19.marker
