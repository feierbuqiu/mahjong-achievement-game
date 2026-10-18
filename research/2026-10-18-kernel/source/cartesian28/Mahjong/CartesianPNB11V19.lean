module
prelude
public import Mahjong.CartesianChannels07V19
import all Mahjong.CartesianChannels07V19
public import Mahjong.CartesianChannels11V19
import all Mahjong.CartesianChannels11V19
public import Mahjong.CartesianChannels12V19
import all Mahjong.CartesianChannels12V19
public import Mahjong.CartesianData03V19
import all Mahjong.CartesianData03V19
public import Mahjong.CartesianMathV19
import all Mahjong.CartesianMathV19
public section
set_option autoImplicit false
set_option maxRecDepth 131072
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
namespace Mahjong.CartesianPNB11V19
noncomputable def axis0start : Nat := (((Mahjong.CartesianChannels07V19.channel53 4096 Mahjong.CartesianData03V19.v78) ||| (Mahjong.CartesianChannels11V19.channel97 4096 Mahjong.CartesianData03V19.v82)) ||| ((Mahjong.CartesianChannels07V19.channel54 4096 Mahjong.CartesianData03V19.v86) ||| ((Mahjong.CartesianChannels11V19.channel98 4096 Mahjong.CartesianData03V19.v90) ||| (Mahjong.CartesianChannels11V19.channel99 4096 Mahjong.CartesianData03V19.v94))))
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
noncomputable def axis1start : Nat := ((((Mahjong.CartesianChannels11V19.channel100 512 Mahjong.CartesianData03V19.v100) ||| (Mahjong.CartesianChannels11V19.channel101 512 Mahjong.CartesianData03V19.v104)) ||| ((Mahjong.CartesianChannels11V19.channel102 512 Mahjong.CartesianData03V19.v108) ||| ((Mahjong.CartesianChannels11V19.channel103 512 Mahjong.CartesianData03V19.v112) ||| (Mahjong.CartesianChannels12V19.channel104 512 Mahjong.CartesianData03V19.v116)))) ||| (((Mahjong.CartesianChannels12V19.channel105 512 Mahjong.CartesianData03V19.v120) ||| (Mahjong.CartesianChannels12V19.channel106 512 Mahjong.CartesianData03V19.v124)) ||| ((Mahjong.CartesianChannels12V19.channel107 512 Mahjong.CartesianData03V19.v128) ||| ((Mahjong.CartesianChannels12V19.channel108 512 Mahjong.CartesianData03V19.v132) ||| (Mahjong.CartesianChannels12V19.channel109 512 Mahjong.CartesianData03V19.v136)))))
noncomputable def axis1stage0 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1start Mahjong.CartesianData03V19.v172 16128
noncomputable def axis1stage1 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage0 Mahjong.CartesianData03V19.v171 8064
noncomputable def axis1stage2 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage1 Mahjong.CartesianData03V19.v170 4032
noncomputable def axis1stage3 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage2 Mahjong.CartesianData03V19.v169 2016
noncomputable def axis1stage4 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage3 Mahjong.CartesianData03V19.v168 1008
noncomputable def axis1stage5 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage4 Mahjong.CartesianData03V19.v167 504
noncomputable def axis2start : Nat := ((((Mahjong.CartesianChannels11V19.channel100 512 Mahjong.CartesianData03V19.v100) ||| (Mahjong.CartesianChannels11V19.channel101 512 Mahjong.CartesianData03V19.v104)) ||| ((Mahjong.CartesianChannels11V19.channel102 512 Mahjong.CartesianData03V19.v108) ||| ((Mahjong.CartesianChannels11V19.channel103 512 Mahjong.CartesianData03V19.v112) ||| (Mahjong.CartesianChannels12V19.channel104 512 Mahjong.CartesianData03V19.v116)))) ||| (((Mahjong.CartesianChannels12V19.channel105 512 Mahjong.CartesianData03V19.v120) ||| (Mahjong.CartesianChannels12V19.channel106 512 Mahjong.CartesianData03V19.v124)) ||| ((Mahjong.CartesianChannels12V19.channel107 512 Mahjong.CartesianData03V19.v128) ||| ((Mahjong.CartesianChannels12V19.channel108 512 Mahjong.CartesianData03V19.v132) ||| (Mahjong.CartesianChannels12V19.channel109 512 Mahjong.CartesianData03V19.v136)))))
noncomputable def computedReach : Nat := ((axis0stage11 ||| (axis1stage5 ||| axis2start)) ||| ((Mahjong.CartesianData03V19.v140 ||| Mahjong.CartesianData03V19.v144) ||| (Mahjong.CartesianData03V19.v148 ||| Mahjong.CartesianData03V19.v152)))
theorem provided_PN :
    computedReach = Mahjong.CartesianData03V19.v154 ∧
    (Mahjong.CartesianData03V19.v76 &&& computedReach) = 0 ∧
    (Mahjong.CartesianData03V19.v76 ||| computedReach) = Mahjong.CartesianData03V19.v153 := by decide +kernel
end Mahjong.CartesianPNB11V19
#print axioms Mahjong.CartesianPNB11V19.provided_PN
