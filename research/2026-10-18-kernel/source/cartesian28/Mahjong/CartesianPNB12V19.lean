module
prelude
public import Mahjong.CartesianChannels12V19
import all Mahjong.CartesianChannels12V19
public import Mahjong.CartesianChannels13V19
import all Mahjong.CartesianChannels13V19
public import Mahjong.CartesianChannels14V19
import all Mahjong.CartesianChannels14V19
public import Mahjong.CartesianData03V19
import all Mahjong.CartesianData03V19
public import Mahjong.CartesianMathV19
import all Mahjong.CartesianMathV19
public section
set_option autoImplicit false
set_option maxRecDepth 131072
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
namespace Mahjong.CartesianPNB12V19
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
theorem provided_PN :
    computedReach = Mahjong.CartesianData03V19.v250 ∧
    (Mahjong.CartesianData03V19.v176 &&& computedReach) = 0 ∧
    (Mahjong.CartesianData03V19.v176 ||| computedReach) = Mahjong.CartesianData03V19.v249 := by decide +kernel
end Mahjong.CartesianPNB12V19
#print axioms Mahjong.CartesianPNB12V19.provided_PN
