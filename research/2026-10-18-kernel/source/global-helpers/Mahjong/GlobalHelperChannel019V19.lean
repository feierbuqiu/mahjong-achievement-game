module
prelude
public import Init.Data.Nat.Bitwise.Basic
public section
set_option autoImplicit false
set_option exponentiation.threshold 16777216
set_option maxRecDepth 65536
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
namespace Mahjong.GlobalHelperChannel019V19
noncomputable def mask (width : Nat) : Nat := 2^width-1
noncomputable def cut0 (width input : Nat) : Nat := (input >>> (50*width)) &&& (mask width)
noncomputable def cut1 (width input : Nat) : Nat := (input >>> (51*width)) &&& (mask width)
noncomputable def cut2 (width input : Nat) : Nat := (input >>> (52*width)) &&& (mask width)
noncomputable def cut3 (width input : Nat) : Nat := (input >>> (53*width)) &&& (mask width)
noncomputable def cut4 (width input : Nat) : Nat := (input >>> (54*width)) &&& (mask width)
noncomputable def cut5 (width input : Nat) : Nat := (input >>> (55*width)) &&& (mask width)
noncomputable def cut6 (width input : Nat) : Nat := (input >>> (56*width)) &&& (mask width)
noncomputable def cut7 (width input : Nat) : Nat := (input >>> (57*width)) &&& (mask width)
noncomputable def cut8 (width input : Nat) : Nat := (input >>> (58*width)) &&& (mask width)
noncomputable def cut9 (width input : Nat) : Nat := (input >>> (61*width)) &&& (mask width)
noncomputable def cut10 (width input : Nat) : Nat := (input >>> (67*width)) &&& (mask width)
noncomputable def cut11 (width input : Nat) : Nat := (input >>> (68*width)) &&& (mask width)
noncomputable def cut12 (width input : Nat) : Nat := (input >>> (69*width)) &&& (mask width)
noncomputable def cut13 (width input : Nat) : Nat := (input >>> (70*width)) &&& (mask width)
noncomputable def cut14 (width input : Nat) : Nat := (input >>> (71*width)) &&& (mask width)
noncomputable def cut15 (width input : Nat) : Nat := (input >>> (72*width)) &&& (mask width)
noncomputable def cut16 (width input : Nat) : Nat := (input >>> (73*width)) &&& (mask width)
noncomputable def cut17 (width input : Nat) : Nat := (input >>> (74*width)) &&& (mask width)
noncomputable def cut18 (width input : Nat) : Nat := (input >>> (76*width)) &&& (mask width)
noncomputable def cut19 (width input : Nat) : Nat := (input >>> (77*width)) &&& (mask width)
noncomputable def cut20 (width input : Nat) : Nat := (input >>> (78*width)) &&& (mask width)
noncomputable def cut21 (width input : Nat) : Nat := (input >>> (79*width)) &&& (mask width)
noncomputable def cut22 (width input : Nat) : Nat := (input >>> (80*width)) &&& (mask width)
noncomputable def cut23 (width input : Nat) : Nat := (input >>> (82*width)) &&& (mask width)
noncomputable def cut24 (width input : Nat) : Nat := (input >>> (95*width)) &&& (mask width)
noncomputable def lane254 (width input : Nat) : Nat := (cut0 width input)
noncomputable def lane255 (width input : Nat) : Nat := (cut1 width input)
noncomputable def lane257 (width input : Nat) : Nat := (cut2 width input)
noncomputable def lane259 (width input : Nat) : Nat := (cut3 width input)
noncomputable def lane260 (width input : Nat) : Nat := (cut4 width input)
noncomputable def lane261 (width input : Nat) : Nat := (cut5 width input)
noncomputable def lane262 (width input : Nat) : Nat := (cut6 width input)
noncomputable def lane263 (width input : Nat) : Nat := (cut7 width input)
noncomputable def lane267 (width input : Nat) : Nat := (cut8 width input)
noncomputable def lane271 (width input : Nat) : Nat := (cut9 width input)
noncomputable def lane332 (width input : Nat) : Nat := (cut10 width input)
noncomputable def lane333 (width input : Nat) : Nat := (cut11 width input)
noncomputable def lane335 (width input : Nat) : Nat := (cut12 width input)
noncomputable def lane337 (width input : Nat) : Nat := (cut13 width input)
noncomputable def lane338 (width input : Nat) : Nat := (cut14 width input)
noncomputable def lane339 (width input : Nat) : Nat := (cut15 width input)
noncomputable def lane340 (width input : Nat) : Nat := (cut16 width input)
noncomputable def lane341 (width input : Nat) : Nat := (cut17 width input)
noncomputable def lane350 (width input : Nat) : Nat := (cut18 width input)
noncomputable def lane356 (width input : Nat) : Nat := (cut19 width input)
noncomputable def lane357 (width input : Nat) : Nat := (cut20 width input)
noncomputable def lane358 (width input : Nat) : Nat := (cut21 width input)
noncomputable def lane359 (width input : Nat) : Nat := (cut22 width input)
noncomputable def lane364 (width input : Nat) : Nat := (cut23 width input)
noncomputable def lane392 (width input : Nat) : Nat := (cut24 width input)
noncomputable def concatpart0 (width input : Nat) : Nat := (lane255 width input) <<< width
noncomputable def concatpart1 (width input : Nat) : Nat := (lane254 width input) ||| (concatpart0 width input)
noncomputable def concatpart2 (width input : Nat) : Nat := (concatpart1 width input) <<< (2*width)
noncomputable def concatpart3 (width input : Nat) : Nat := (concatpart2 width input) <<< (4*width)
noncomputable def concatpart4 (width input : Nat) : Nat := (concatpart3 width input) <<< (8*width)
noncomputable def concatpart5 (width input : Nat) : Nat := (concatpart4 width input) <<< (16*width)
noncomputable def concatpart6 (width input : Nat) : Nat := (concatpart5 width input) <<< (32*width)
noncomputable def concatpart7 (width input : Nat) : Nat := (concatpart6 width input) <<< (64*width)
noncomputable def concatpart8 (width input : Nat) : Nat := (concatpart7 width input) <<< (128*width)
noncomputable def concatpart9 (width input : Nat) : Nat := (lane257 width input) <<< width
noncomputable def concatpart10 (width input : Nat) : Nat := (lane259 width input) <<< width
noncomputable def concatpart11 (width input : Nat) : Nat := (concatpart10 width input) <<< (2*width)
noncomputable def concatpart12 (width input : Nat) : Nat := (concatpart9 width input) ||| (concatpart11 width input)
noncomputable def concatpart13 (width input : Nat) : Nat := (lane261 width input) <<< width
noncomputable def concatpart14 (width input : Nat) : Nat := (lane260 width input) ||| (concatpart13 width input)
noncomputable def concatpart15 (width input : Nat) : Nat := (lane263 width input) <<< width
noncomputable def concatpart16 (width input : Nat) : Nat := (lane262 width input) ||| (concatpart15 width input)
noncomputable def concatpart17 (width input : Nat) : Nat := (concatpart16 width input) <<< (2*width)
noncomputable def concatpart18 (width input : Nat) : Nat := (concatpart14 width input) ||| (concatpart17 width input)
noncomputable def concatpart19 (width input : Nat) : Nat := (concatpart18 width input) <<< (4*width)
noncomputable def concatpart20 (width input : Nat) : Nat := (concatpart12 width input) ||| (concatpart19 width input)
noncomputable def concatpart21 (width input : Nat) : Nat := (lane267 width input) <<< width
noncomputable def concatpart22 (width input : Nat) : Nat := (concatpart21 width input) <<< (2*width)
noncomputable def concatpart23 (width input : Nat) : Nat := (lane271 width input) <<< width
noncomputable def concatpart24 (width input : Nat) : Nat := (concatpart23 width input) <<< (2*width)
noncomputable def concatpart25 (width input : Nat) : Nat := (concatpart24 width input) <<< (4*width)
noncomputable def concatpart26 (width input : Nat) : Nat := (concatpart22 width input) ||| (concatpart25 width input)
noncomputable def concatpart27 (width input : Nat) : Nat := (concatpart26 width input) <<< (8*width)
noncomputable def concatpart28 (width input : Nat) : Nat := (concatpart20 width input) ||| (concatpart27 width input)
noncomputable def concatpart29 (width input : Nat) : Nat := (lane333 width input) <<< width
noncomputable def concatpart30 (width input : Nat) : Nat := (lane332 width input) ||| (concatpart29 width input)
noncomputable def concatpart31 (width input : Nat) : Nat := (lane335 width input) <<< width
noncomputable def concatpart32 (width input : Nat) : Nat := (concatpart31 width input) <<< (2*width)
noncomputable def concatpart33 (width input : Nat) : Nat := (concatpart30 width input) ||| (concatpart32 width input)
noncomputable def concatpart34 (width input : Nat) : Nat := (concatpart33 width input) <<< (4*width)
noncomputable def concatpart35 (width input : Nat) : Nat := (concatpart34 width input) <<< (8*width)
noncomputable def concatpart36 (width input : Nat) : Nat := (lane337 width input) <<< width
noncomputable def concatpart37 (width input : Nat) : Nat := (lane339 width input) <<< width
noncomputable def concatpart38 (width input : Nat) : Nat := (lane338 width input) ||| (concatpart37 width input)
noncomputable def concatpart39 (width input : Nat) : Nat := (concatpart38 width input) <<< (2*width)
noncomputable def concatpart40 (width input : Nat) : Nat := (concatpart36 width input) ||| (concatpart39 width input)
noncomputable def concatpart41 (width input : Nat) : Nat := (lane341 width input) <<< width
noncomputable def concatpart42 (width input : Nat) : Nat := (lane340 width input) ||| (concatpart41 width input)
noncomputable def concatpart43 (width input : Nat) : Nat := (concatpart42 width input) <<< (4*width)
noncomputable def concatpart44 (width input : Nat) : Nat := (concatpart40 width input) ||| (concatpart43 width input)
noncomputable def concatpart45 (width input : Nat) : Nat := (lane350 width input) <<< (2*width)
noncomputable def concatpart46 (width input : Nat) : Nat := (concatpart45 width input) <<< (4*width)
noncomputable def concatpart47 (width input : Nat) : Nat := (concatpart46 width input) <<< (8*width)
noncomputable def concatpart48 (width input : Nat) : Nat := (concatpart44 width input) ||| (concatpart47 width input)
noncomputable def concatpart49 (width input : Nat) : Nat := (concatpart48 width input) <<< (16*width)
noncomputable def concatpart50 (width input : Nat) : Nat := (concatpart35 width input) ||| (concatpart49 width input)
noncomputable def concatpart51 (width input : Nat) : Nat := (lane357 width input) <<< width
noncomputable def concatpart52 (width input : Nat) : Nat := (lane356 width input) ||| (concatpart51 width input)
noncomputable def concatpart53 (width input : Nat) : Nat := (lane359 width input) <<< width
noncomputable def concatpart54 (width input : Nat) : Nat := (lane358 width input) ||| (concatpart53 width input)
noncomputable def concatpart55 (width input : Nat) : Nat := (concatpart54 width input) <<< (2*width)
noncomputable def concatpart56 (width input : Nat) : Nat := (concatpart52 width input) ||| (concatpart55 width input)
noncomputable def concatpart57 (width input : Nat) : Nat := (concatpart56 width input) <<< (4*width)
noncomputable def concatpart58 (width input : Nat) : Nat := (lane364 width input) <<< (4*width)
noncomputable def concatpart59 (width input : Nat) : Nat := (concatpart58 width input) <<< (8*width)
noncomputable def concatpart60 (width input : Nat) : Nat := (concatpart57 width input) ||| (concatpart59 width input)
noncomputable def concatpart61 (width input : Nat) : Nat := (concatpart60 width input) <<< (32*width)
noncomputable def concatpart62 (width input : Nat) : Nat := (concatpart50 width input) ||| (concatpart61 width input)
noncomputable def concatpart63 (width input : Nat) : Nat := (concatpart62 width input) <<< (64*width)
noncomputable def concatpart64 (width input : Nat) : Nat := (concatpart28 width input) ||| (concatpart63 width input)
noncomputable def concatpart65 (width input : Nat) : Nat := (lane392 width input) <<< (8*width)
noncomputable def concatpart66 (width input : Nat) : Nat := (concatpart65 width input) <<< (128*width)
noncomputable def concatpart67 (width input : Nat) : Nat := (concatpart64 width input) ||| (concatpart66 width input)
noncomputable def concatpart68 (width input : Nat) : Nat := (concatpart67 width input) <<< (256*width)
noncomputable def concatpart69 (width input : Nat) : Nat := (concatpart8 width input) ||| (concatpart68 width input)
noncomputable def channel (width input : Nat) : Nat := (concatpart69 width input)
theorem marker : (0 : Nat)=0 := rfl
end Mahjong.GlobalHelperChannel019V19
#print axioms Mahjong.GlobalHelperChannel019V19.marker
