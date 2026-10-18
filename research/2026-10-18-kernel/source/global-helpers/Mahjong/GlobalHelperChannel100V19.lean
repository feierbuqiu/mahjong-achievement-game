module
prelude
public import Init.Data.Nat.Bitwise.Basic
public section
set_option autoImplicit false
set_option exponentiation.threshold 16777216
set_option maxRecDepth 65536
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
namespace Mahjong.GlobalHelperChannel100V19
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
noncomputable def lane0 (width input : Nat) : Nat := (cut0 width input)
noncomputable def lane1 (width input : Nat) : Nat := (cut1 width input)
noncomputable def lane2 (width input : Nat) : Nat := (cut2 width input)
noncomputable def lane3 (width input : Nat) : Nat := (cut3 width input)
noncomputable def lane4 (width input : Nat) : Nat := (cut4 width input)
noncomputable def lane5 (width input : Nat) : Nat := (cut5 width input)
noncomputable def lane6 (width input : Nat) : Nat := (cut6 width input)
noncomputable def lane7 (width input : Nat) : Nat := (cut7 width input)
noncomputable def lane8 (width input : Nat) : Nat := (cut6 width input)
noncomputable def lane9 (width input : Nat) : Nat := (cut8 width input)
noncomputable def lane10 (width input : Nat) : Nat := (cut9 width input)
noncomputable def lane11 (width input : Nat) : Nat := (cut4 width input)
noncomputable def lane12 (width input : Nat) : Nat := (cut10 width input)
noncomputable def lane13 (width input : Nat) : Nat := (cut11 width input)
noncomputable def lane14 (width input : Nat) : Nat := (cut12 width input)
noncomputable def lane15 (width input : Nat) : Nat := (cut13 width input)
noncomputable def lane16 (width input : Nat) : Nat := (cut9 width input)
noncomputable def lane17 (width input : Nat) : Nat := (cut14 width input)
noncomputable def lane18 (width input : Nat) : Nat := (cut7 width input)
noncomputable def lane19 (width input : Nat) : Nat := (cut15 width input)
noncomputable def lane20 (width input : Nat) : Nat := (cut8 width input)
noncomputable def lane21 (width input : Nat) : Nat := (cut12 width input)
noncomputable def lane22 (width input : Nat) : Nat := (cut2 width input)
noncomputable def lane23 (width input : Nat) : Nat := (cut14 width input)
noncomputable def lane24 (width input : Nat) : Nat := (cut5 width input)
noncomputable def lane25 (width input : Nat) : Nat := (cut11 width input)
noncomputable def lane26 (width input : Nat) : Nat := (cut1 width input)
noncomputable def lane42 (width input : Nat) : Nat := (cut15 width input)
noncomputable def lane43 (width input : Nat) : Nat := (cut13 width input)
noncomputable def lane44 (width input : Nat) : Nat := (cut3 width input)
noncomputable def lane45 (width input : Nat) : Nat := (cut10 width input)
noncomputable def lane46 (width input : Nat) : Nat := (cut0 width input)
noncomputable def concatpart0 (width input : Nat) : Nat := (lane1 width input) <<< width
noncomputable def concatpart1 (width input : Nat) : Nat := (lane0 width input) ||| (concatpart0 width input)
noncomputable def concatpart2 (width input : Nat) : Nat := (lane3 width input) <<< width
noncomputable def concatpart3 (width input : Nat) : Nat := (lane2 width input) ||| (concatpart2 width input)
noncomputable def concatpart4 (width input : Nat) : Nat := (concatpart3 width input) <<< (2*width)
noncomputable def concatpart5 (width input : Nat) : Nat := (concatpart1 width input) ||| (concatpart4 width input)
noncomputable def concatpart6 (width input : Nat) : Nat := (lane5 width input) <<< width
noncomputable def concatpart7 (width input : Nat) : Nat := (lane4 width input) ||| (concatpart6 width input)
noncomputable def concatpart8 (width input : Nat) : Nat := (lane7 width input) <<< width
noncomputable def concatpart9 (width input : Nat) : Nat := (lane6 width input) ||| (concatpart8 width input)
noncomputable def concatpart10 (width input : Nat) : Nat := (concatpart9 width input) <<< (2*width)
noncomputable def concatpart11 (width input : Nat) : Nat := (concatpart7 width input) ||| (concatpart10 width input)
noncomputable def concatpart12 (width input : Nat) : Nat := (concatpart11 width input) <<< (4*width)
noncomputable def concatpart13 (width input : Nat) : Nat := (concatpart5 width input) ||| (concatpart12 width input)
noncomputable def concatpart14 (width input : Nat) : Nat := (lane9 width input) <<< width
noncomputable def concatpart15 (width input : Nat) : Nat := (lane8 width input) ||| (concatpart14 width input)
noncomputable def concatpart16 (width input : Nat) : Nat := (lane11 width input) <<< width
noncomputable def concatpart17 (width input : Nat) : Nat := (lane10 width input) ||| (concatpart16 width input)
noncomputable def concatpart18 (width input : Nat) : Nat := (concatpart17 width input) <<< (2*width)
noncomputable def concatpart19 (width input : Nat) : Nat := (concatpart15 width input) ||| (concatpart18 width input)
noncomputable def concatpart20 (width input : Nat) : Nat := (lane13 width input) <<< width
noncomputable def concatpart21 (width input : Nat) : Nat := (lane12 width input) ||| (concatpart20 width input)
noncomputable def concatpart22 (width input : Nat) : Nat := (lane15 width input) <<< width
noncomputable def concatpart23 (width input : Nat) : Nat := (lane14 width input) ||| (concatpart22 width input)
noncomputable def concatpart24 (width input : Nat) : Nat := (concatpart23 width input) <<< (2*width)
noncomputable def concatpart25 (width input : Nat) : Nat := (concatpart21 width input) ||| (concatpart24 width input)
noncomputable def concatpart26 (width input : Nat) : Nat := (concatpart25 width input) <<< (4*width)
noncomputable def concatpart27 (width input : Nat) : Nat := (concatpart19 width input) ||| (concatpart26 width input)
noncomputable def concatpart28 (width input : Nat) : Nat := (concatpart27 width input) <<< (8*width)
noncomputable def concatpart29 (width input : Nat) : Nat := (concatpart13 width input) ||| (concatpart28 width input)
noncomputable def concatpart30 (width input : Nat) : Nat := (lane17 width input) <<< width
noncomputable def concatpart31 (width input : Nat) : Nat := (lane16 width input) ||| (concatpart30 width input)
noncomputable def concatpart32 (width input : Nat) : Nat := (lane19 width input) <<< width
noncomputable def concatpart33 (width input : Nat) : Nat := (lane18 width input) ||| (concatpart32 width input)
noncomputable def concatpart34 (width input : Nat) : Nat := (concatpart33 width input) <<< (2*width)
noncomputable def concatpart35 (width input : Nat) : Nat := (concatpart31 width input) ||| (concatpart34 width input)
noncomputable def concatpart36 (width input : Nat) : Nat := (lane21 width input) <<< width
noncomputable def concatpart37 (width input : Nat) : Nat := (lane20 width input) ||| (concatpart36 width input)
noncomputable def concatpart38 (width input : Nat) : Nat := (lane23 width input) <<< width
noncomputable def concatpart39 (width input : Nat) : Nat := (lane22 width input) ||| (concatpart38 width input)
noncomputable def concatpart40 (width input : Nat) : Nat := (concatpart39 width input) <<< (2*width)
noncomputable def concatpart41 (width input : Nat) : Nat := (concatpart37 width input) ||| (concatpart40 width input)
noncomputable def concatpart42 (width input : Nat) : Nat := (concatpart41 width input) <<< (4*width)
noncomputable def concatpart43 (width input : Nat) : Nat := (concatpart35 width input) ||| (concatpart42 width input)
noncomputable def concatpart44 (width input : Nat) : Nat := (lane25 width input) <<< width
noncomputable def concatpart45 (width input : Nat) : Nat := (lane24 width input) ||| (concatpart44 width input)
noncomputable def concatpart46 (width input : Nat) : Nat := (lane26 width input) <<< (2*width)
noncomputable def concatpart47 (width input : Nat) : Nat := (concatpart45 width input) ||| (concatpart46 width input)
noncomputable def concatpart48 (width input : Nat) : Nat := (concatpart47 width input) <<< (8*width)
noncomputable def concatpart49 (width input : Nat) : Nat := (concatpart43 width input) ||| (concatpart48 width input)
noncomputable def concatpart50 (width input : Nat) : Nat := (concatpart49 width input) <<< (16*width)
noncomputable def concatpart51 (width input : Nat) : Nat := (concatpart29 width input) ||| (concatpart50 width input)
noncomputable def concatpart52 (width input : Nat) : Nat := (lane43 width input) <<< width
noncomputable def concatpart53 (width input : Nat) : Nat := (lane42 width input) ||| (concatpart52 width input)
noncomputable def concatpart54 (width input : Nat) : Nat := (concatpart53 width input) <<< (2*width)
noncomputable def concatpart55 (width input : Nat) : Nat := (lane45 width input) <<< width
noncomputable def concatpart56 (width input : Nat) : Nat := (lane44 width input) ||| (concatpart55 width input)
noncomputable def concatpart57 (width input : Nat) : Nat := (lane46 width input) <<< (2*width)
noncomputable def concatpart58 (width input : Nat) : Nat := (concatpart56 width input) ||| (concatpart57 width input)
noncomputable def concatpart59 (width input : Nat) : Nat := (concatpart58 width input) <<< (4*width)
noncomputable def concatpart60 (width input : Nat) : Nat := (concatpart54 width input) ||| (concatpart59 width input)
noncomputable def concatpart61 (width input : Nat) : Nat := (concatpart60 width input) <<< (8*width)
noncomputable def concatpart62 (width input : Nat) : Nat := (concatpart61 width input) <<< (32*width)
noncomputable def concatpart63 (width input : Nat) : Nat := (concatpart51 width input) ||| (concatpart62 width input)
noncomputable def channel (width input : Nat) : Nat := (concatpart63 width input)
theorem marker : (0 : Nat)=0 := rfl
end Mahjong.GlobalHelperChannel100V19
#print axioms Mahjong.GlobalHelperChannel100V19.marker
