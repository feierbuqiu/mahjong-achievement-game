module
prelude
public import Mahjong.CartesianChannels04V19
import all Mahjong.CartesianChannels04V19
public import Mahjong.CartesianChannels12V19
import all Mahjong.CartesianChannels12V19
public import Mahjong.CartesianChannels13V19
import all Mahjong.CartesianChannels13V19
public import Mahjong.CartesianChannels14V19
import all Mahjong.CartesianChannels14V19
public import Mahjong.CartesianChannels15V19
import all Mahjong.CartesianChannels15V19
public import Mahjong.CartesianData03V19
import all Mahjong.CartesianData03V19
public import Mahjong.CartesianMathV19
import all Mahjong.CartesianMathV19
public section
set_option autoImplicit false
set_option exponentiation.threshold 16777216
set_option maxRecDepth 65536
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
namespace Mahjong.CartesianBoolS02C06V19
namespace B12
noncomputable def axis0start : Nat := (((Mahjong.CartesianChannels12V19.channel110 4096 Mahjong.CartesianData03V19.v178) ||| (Mahjong.CartesianChannels12V19.channel111 4096 Mahjong.CartesianData03V19.v182)) ||| ((Mahjong.CartesianChannels12V19.channel112 4096 Mahjong.CartesianData03V19.v186) ||| ((Mahjong.CartesianChannels12V19.channel113 4096 Mahjong.CartesianData03V19.v190) ||| (Mahjong.CartesianChannels12V19.channel114 4096 Mahjong.CartesianData03V19.v195))))
noncomputable def axis0stage0 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0start Mahjong.CartesianData03V19.v166 14336
noncomputable def axis0stage1 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage0 Mahjong.CartesianData03V19.v165 7168
noncomputable def axis0stage2 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage1 Mahjong.CartesianData03V19.v164 3584
noncomputable def axis0stage3 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage2 Mahjong.CartesianData03V19.v163 1792
noncomputable def axis0stage4 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage3 Mahjong.CartesianData03V19.v162 896
noncomputable def axis0stage5 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage4 Mahjong.CartesianData03V19.v161 448
noncomputable def axis0stage6 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage5 Mahjong.CartesianData03V19.v160 224
noncomputable def axis0stage7 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage6 Mahjong.CartesianData03V19.v159 112
noncomputable def axis0stage8 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage7 Mahjong.CartesianData03V19.v158 56
noncomputable def axis0stage9 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage8 Mahjong.CartesianData03V19.v157 28
noncomputable def axis0stage10 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage9 Mahjong.CartesianData03V19.v156 14
noncomputable def axis0stage11 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage10 Mahjong.CartesianData03V19.v155 7
noncomputable def axis1start : Nat := (((Mahjong.CartesianChannels12V19.channel115 2048 Mahjong.CartesianData03V19.v199) ||| (Mahjong.CartesianChannels12V19.channel116 2048 Mahjong.CartesianData03V19.v203)) ||| ((Mahjong.CartesianChannels12V19.channel117 2048 Mahjong.CartesianData03V19.v207) ||| (Mahjong.CartesianChannels12V19.channel118 2048 Mahjong.CartesianData03V19.v211)))
noncomputable def axis1stage0 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1start Mahjong.CartesianData03V19.v258 15360
noncomputable def axis1stage1 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage0 Mahjong.CartesianData03V19.v257 7680
noncomputable def axis1stage2 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage1 Mahjong.CartesianData03V19.v256 3840
noncomputable def axis1stage3 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage2 Mahjong.CartesianData03V19.v255 1920
noncomputable def axis1stage4 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage3 Mahjong.CartesianData03V19.v254 960
noncomputable def axis1stage5 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage4 Mahjong.CartesianData03V19.v253 480
noncomputable def axis1stage6 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage5 Mahjong.CartesianData03V19.v252 240
noncomputable def axis1stage7 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage6 Mahjong.CartesianData03V19.v251 120
noncomputable def axis2start : Nat := (((Mahjong.CartesianChannels12V19.channel119 128 Mahjong.CartesianData03V19.v216) ||| ((Mahjong.CartesianChannels12V19.channel120 128 Mahjong.CartesianData03V19.v220) ||| (Mahjong.CartesianChannels13V19.channel121 128 Mahjong.CartesianData03V19.v224))) ||| (((Mahjong.CartesianChannels13V19.channel122 128 Mahjong.CartesianData03V19.v228) ||| (Mahjong.CartesianChannels14V19.channel123 128 Mahjong.CartesianData03V19.v232)) ||| ((Mahjong.CartesianChannels14V19.channel124 128 Mahjong.CartesianData03V19.v236) ||| (Mahjong.CartesianChannels14V19.channel125 128 Mahjong.CartesianData03V19.v240))))
noncomputable def computedReach : Nat := ((axis0stage11 ||| axis1stage7) ||| (axis2start ||| (Mahjong.CartesianData03V19.v244 ||| Mahjong.CartesianData03V19.v248)))
end B12

namespace B13
noncomputable def axis0start : Nat := (((Mahjong.CartesianChannels14V19.channel126 2048 Mahjong.CartesianData03V19.v264) ||| (Mahjong.CartesianChannels14V19.channel127 2048 Mahjong.CartesianData03V19.v268)) ||| ((Mahjong.CartesianChannels14V19.channel128 2048 Mahjong.CartesianData03V19.v273) ||| (Mahjong.CartesianChannels14V19.channel129 2048 Mahjong.CartesianData03V19.v277)))
noncomputable def axis0stage0 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0start Mahjong.CartesianData03V19.v392 2048
noncomputable def axis0stage1 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage0 Mahjong.CartesianData03V19.v391 3072
noncomputable def axis0stage2 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage1 Mahjong.CartesianData03V19.v390 1536
noncomputable def axis0stage3 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage2 Mahjong.CartesianData03V19.v389 768
noncomputable def axis0stage4 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage3 Mahjong.CartesianData03V19.v388 384
noncomputable def axis0stage5 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage4 Mahjong.CartesianData03V19.v387 192
noncomputable def axis0stage6 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage5 Mahjong.CartesianData03V19.v386 96
noncomputable def axis0stage7 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage6 Mahjong.CartesianData03V19.v385 48
noncomputable def axis0stage8 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage7 Mahjong.CartesianData03V19.v384 24
noncomputable def axis0stage9 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage8 Mahjong.CartesianData03V19.v383 12
noncomputable def axis0stage10 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage9 Mahjong.CartesianData03V19.v382 6
noncomputable def axis0stage11 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage10 Mahjong.CartesianData03V19.v381 3
noncomputable def axis1start : Nat := ((((Mahjong.CartesianChannels04V19.channel28 256 Mahjong.CartesianData03V19.v281) ||| (Mahjong.CartesianChannels04V19.channel29 256 Mahjong.CartesianData03V19.v285)) ||| ((Mahjong.CartesianChannels04V19.channel30 256 Mahjong.CartesianData03V19.v289) ||| ((Mahjong.CartesianChannels04V19.channel31 256 Mahjong.CartesianData03V19.v293) ||| (Mahjong.CartesianChannels04V19.channel32 256 Mahjong.CartesianData03V19.v297)))) ||| (((Mahjong.CartesianChannels04V19.channel33 256 Mahjong.CartesianData03V19.v301) ||| (Mahjong.CartesianChannels04V19.channel34 256 Mahjong.CartesianData03V19.v305)) ||| ((Mahjong.CartesianChannels04V19.channel35 256 Mahjong.CartesianData03V19.v309) ||| ((Mahjong.CartesianChannels04V19.channel36 256 Mahjong.CartesianData03V19.v313) ||| (Mahjong.CartesianChannels04V19.channel37 256 Mahjong.CartesianData03V19.v317)))))
noncomputable def axis1stage0 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1start Mahjong.CartesianData03V19.v392 2048
noncomputable def axis1stage1 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage0 Mahjong.CartesianData03V19.v391 3072
noncomputable def axis1stage2 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage1 Mahjong.CartesianData03V19.v400 3584
noncomputable def axis1stage3 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage2 Mahjong.CartesianData03V19.v399 3840
noncomputable def axis1stage4 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage3 Mahjong.CartesianData03V19.v398 3968
noncomputable def axis1stage5 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage4 Mahjong.CartesianData03V19.v397 1984
noncomputable def axis1stage6 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage5 Mahjong.CartesianData03V19.v396 992
noncomputable def axis1stage7 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage6 Mahjong.CartesianData03V19.v395 496
noncomputable def axis1stage8 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage7 Mahjong.CartesianData03V19.v394 248
noncomputable def axis1stage9 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage8 Mahjong.CartesianData03V19.v393 124
noncomputable def axis2start : Nat := ((((Mahjong.CartesianChannels14V19.channel130 128 Mahjong.CartesianData03V19.v322) ||| ((Mahjong.CartesianChannels14V19.channel131 128 Mahjong.CartesianData03V19.v326) ||| (Mahjong.CartesianChannels14V19.channel132 128 Mahjong.CartesianData03V19.v330))) ||| ((Mahjong.CartesianChannels14V19.channel133 128 Mahjong.CartesianData03V19.v334) ||| ((Mahjong.CartesianChannels15V19.channel134 128 Mahjong.CartesianData03V19.v338) ||| (Mahjong.CartesianChannels15V19.channel135 128 Mahjong.CartesianData03V19.v342)))) ||| (((Mahjong.CartesianChannels15V19.channel136 128 Mahjong.CartesianData03V19.v346) ||| ((Mahjong.CartesianChannels15V19.channel137 128 Mahjong.CartesianData03V19.v350) ||| (Mahjong.CartesianChannels15V19.channel138 128 Mahjong.CartesianData03V19.v354))) ||| ((Mahjong.CartesianChannels15V19.channel139 128 Mahjong.CartesianData03V19.v358) ||| ((Mahjong.CartesianChannels15V19.channel140 128 Mahjong.CartesianData03V19.v362) ||| (Mahjong.CartesianChannels15V19.channel141 128 Mahjong.CartesianData03V19.v366)))))
noncomputable def computedReach : Nat := ((axis0stage11 ||| (axis1stage9 ||| axis2start)) ||| (Mahjong.CartesianData03V19.v370 ||| (Mahjong.CartesianData03V19.v374 ||| Mahjong.CartesianData03V19.v378)))
end B13
noncomputable def checks : Bool := ((((Mahjong.CartesianData03V19.v176 &&& B12.computedReach) == 0) && ((Mahjong.CartesianData03V19.v176 ||| B12.computedReach) == Mahjong.CartesianData03V19.v249)) && (((Mahjong.CartesianData03V19.v262 &&& B13.computedReach) == 0) && ((Mahjong.CartesianData03V19.v262 ||| B13.computedReach) == Mahjong.CartesianData03V19.v379)))
theorem accepted : checks = true := by exact Eq.refl true
end Mahjong.CartesianBoolS02C06V19
#print axioms Mahjong.CartesianBoolS02C06V19.accepted
