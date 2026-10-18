module
prelude
public import Init.Data.Nat.Bitwise.Basic
public section
set_option autoImplicit false
set_option exponentiation.threshold 16777216
set_option maxRecDepth 65536
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
namespace Mahjong.GlobalHelperChannel101V19
noncomputable def mask (width : Nat) : Nat := 2^width-1
noncomputable def cut0 (width input : Nat) : Nat := (input >>> 0) &&& (mask width)
noncomputable def cut1 (width input : Nat) : Nat := (input >>> width) &&& (mask width)
noncomputable def cut2 (width input : Nat) : Nat := (input >>> (2*width)) &&& (mask width)
noncomputable def cut3 (width input : Nat) : Nat := (input >>> (3*width)) &&& (mask width)
noncomputable def cut4 (width input : Nat) : Nat := (input >>> (4*width)) &&& (mask width)
noncomputable def lane0 (width input : Nat) : Nat := (cut0 width input)
noncomputable def lane1 (width input : Nat) : Nat := (cut1 width input)
noncomputable def lane2 (width input : Nat) : Nat := (cut2 width input)
noncomputable def lane9 (width input : Nat) : Nat := (cut3 width input)
noncomputable def lane12 (width input : Nat) : Nat := (cut0 width input)
noncomputable def lane13 (width input : Nat) : Nat := (cut1 width input)
noncomputable def lane14 (width input : Nat) : Nat := (cut2 width input)
noncomputable def lane27 (width input : Nat) : Nat := (cut0 width input)
noncomputable def lane29 (width input : Nat) : Nat := (cut1 width input)
noncomputable def lane31 (width input : Nat) : Nat := (cut0 width input)
noncomputable def lane33 (width input : Nat) : Nat := (cut1 width input)
noncomputable def lane34 (width input : Nat) : Nat := (cut2 width input)
noncomputable def lane36 (width input : Nat) : Nat := (cut2 width input)
noncomputable def lane37 (width input : Nat) : Nat := (cut3 width input)
noncomputable def lane39 (width input : Nat) : Nat := (cut3 width input)
noncomputable def lane41 (width input : Nat) : Nat := (cut3 width input)
noncomputable def lane42 (width input : Nat) : Nat := (cut4 width input)
noncomputable def lane47 (width input : Nat) : Nat := (cut4 width input)
noncomputable def lane49 (width input : Nat) : Nat := (cut4 width input)
noncomputable def lane51 (width input : Nat) : Nat := (cut4 width input)
noncomputable def concatpart0 (width input : Nat) : Nat := (lane1 width input) <<< width
noncomputable def concatpart1 (width input : Nat) : Nat := (lane0 width input) ||| (concatpart0 width input)
noncomputable def concatpart2 (width input : Nat) : Nat := (lane2 width input) <<< (2*width)
noncomputable def concatpart3 (width input : Nat) : Nat := (concatpart1 width input) ||| (concatpart2 width input)
noncomputable def concatpart4 (width input : Nat) : Nat := (lane9 width input) <<< width
noncomputable def concatpart5 (width input : Nat) : Nat := (lane13 width input) <<< width
noncomputable def concatpart6 (width input : Nat) : Nat := (lane12 width input) ||| (concatpart5 width input)
noncomputable def concatpart7 (width input : Nat) : Nat := (lane14 width input) <<< (2*width)
noncomputable def concatpart8 (width input : Nat) : Nat := (concatpart6 width input) ||| (concatpart7 width input)
noncomputable def concatpart9 (width input : Nat) : Nat := (concatpart8 width input) <<< (4*width)
noncomputable def concatpart10 (width input : Nat) : Nat := (concatpart4 width input) ||| (concatpart9 width input)
noncomputable def concatpart11 (width input : Nat) : Nat := (concatpart10 width input) <<< (8*width)
noncomputable def concatpart12 (width input : Nat) : Nat := (concatpart3 width input) ||| (concatpart11 width input)
noncomputable def concatpart13 (width input : Nat) : Nat := (lane27 width input) <<< width
noncomputable def concatpart14 (width input : Nat) : Nat := (concatpart13 width input) <<< (2*width)
noncomputable def concatpart15 (width input : Nat) : Nat := (lane29 width input) <<< width
noncomputable def concatpart16 (width input : Nat) : Nat := (lane31 width input) <<< width
noncomputable def concatpart17 (width input : Nat) : Nat := (concatpart16 width input) <<< (2*width)
noncomputable def concatpart18 (width input : Nat) : Nat := (concatpart15 width input) ||| (concatpart17 width input)
noncomputable def concatpart19 (width input : Nat) : Nat := (concatpart18 width input) <<< (4*width)
noncomputable def concatpart20 (width input : Nat) : Nat := (concatpart14 width input) ||| (concatpart19 width input)
noncomputable def concatpart21 (width input : Nat) : Nat := (concatpart20 width input) <<< (8*width)
noncomputable def concatpart22 (width input : Nat) : Nat := (concatpart21 width input) <<< (16*width)
noncomputable def concatpart23 (width input : Nat) : Nat := (concatpart12 width input) ||| (concatpart22 width input)
noncomputable def concatpart24 (width input : Nat) : Nat := (lane33 width input) <<< width
noncomputable def concatpart25 (width input : Nat) : Nat := (lane34 width input) <<< (2*width)
noncomputable def concatpart26 (width input : Nat) : Nat := (concatpart24 width input) ||| (concatpart25 width input)
noncomputable def concatpart27 (width input : Nat) : Nat := (lane37 width input) <<< width
noncomputable def concatpart28 (width input : Nat) : Nat := (lane36 width input) ||| (concatpart27 width input)
noncomputable def concatpart29 (width input : Nat) : Nat := (lane39 width input) <<< width
noncomputable def concatpart30 (width input : Nat) : Nat := (concatpart29 width input) <<< (2*width)
noncomputable def concatpart31 (width input : Nat) : Nat := (concatpart28 width input) ||| (concatpart30 width input)
noncomputable def concatpart32 (width input : Nat) : Nat := (concatpart31 width input) <<< (4*width)
noncomputable def concatpart33 (width input : Nat) : Nat := (concatpart26 width input) ||| (concatpart32 width input)
noncomputable def concatpart34 (width input : Nat) : Nat := (lane41 width input) <<< width
noncomputable def concatpart35 (width input : Nat) : Nat := (lane42 width input) <<< (2*width)
noncomputable def concatpart36 (width input : Nat) : Nat := (concatpart34 width input) ||| (concatpart35 width input)
noncomputable def concatpart37 (width input : Nat) : Nat := (lane47 width input) <<< width
noncomputable def concatpart38 (width input : Nat) : Nat := (concatpart37 width input) <<< (2*width)
noncomputable def concatpart39 (width input : Nat) : Nat := (concatpart38 width input) <<< (4*width)
noncomputable def concatpart40 (width input : Nat) : Nat := (concatpart36 width input) ||| (concatpart39 width input)
noncomputable def concatpart41 (width input : Nat) : Nat := (concatpart40 width input) <<< (8*width)
noncomputable def concatpart42 (width input : Nat) : Nat := (concatpart33 width input) ||| (concatpart41 width input)
noncomputable def concatpart43 (width input : Nat) : Nat := (lane49 width input) <<< width
noncomputable def concatpart44 (width input : Nat) : Nat := (lane51 width input) <<< width
noncomputable def concatpart45 (width input : Nat) : Nat := (concatpart44 width input) <<< (2*width)
noncomputable def concatpart46 (width input : Nat) : Nat := (concatpart43 width input) ||| (concatpart45 width input)
noncomputable def concatpart47 (width input : Nat) : Nat := (concatpart46 width input) <<< (16*width)
noncomputable def concatpart48 (width input : Nat) : Nat := (concatpart42 width input) ||| (concatpart47 width input)
noncomputable def concatpart49 (width input : Nat) : Nat := (concatpart48 width input) <<< (32*width)
noncomputable def concatpart50 (width input : Nat) : Nat := (concatpart23 width input) ||| (concatpart49 width input)
noncomputable def channel (width input : Nat) : Nat := (concatpart50 width input)
theorem marker : (0 : Nat)=0 := rfl
end Mahjong.GlobalHelperChannel101V19
#print axioms Mahjong.GlobalHelperChannel101V19.marker
