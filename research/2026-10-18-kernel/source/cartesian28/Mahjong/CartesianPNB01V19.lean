module
prelude
public import Mahjong.CartesianChannels00V19
import all Mahjong.CartesianChannels00V19
public import Mahjong.CartesianChannels01V19
import all Mahjong.CartesianChannels01V19
public import Mahjong.CartesianChannels02V19
import all Mahjong.CartesianChannels02V19
public import Mahjong.CartesianChannels03V19
import all Mahjong.CartesianChannels03V19
public import Mahjong.CartesianChannels04V19
import all Mahjong.CartesianChannels04V19
public import Mahjong.CartesianData00V19
import all Mahjong.CartesianData00V19
public import Mahjong.CartesianMathV19
import all Mahjong.CartesianMathV19
public section
set_option autoImplicit false
set_option maxRecDepth 131072
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
namespace Mahjong.CartesianPNB01V19
noncomputable def axis0start : Nat := (((Mahjong.CartesianChannels00V19.channel8 16384 Mahjong.CartesianData00V19.v71) ||| (Mahjong.CartesianChannels00V19.channel9 16384 Mahjong.CartesianData00V19.v75)) ||| ((Mahjong.CartesianChannels00V19.channel10 16384 Mahjong.CartesianData00V19.v79) ||| (Mahjong.CartesianChannels00V19.channel11 16384 Mahjong.CartesianData00V19.v83)))
noncomputable def axis0stage0 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0start Mahjong.CartesianData00V19.v55 24576
noncomputable def axis0stage1 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage0 Mahjong.CartesianData00V19.v140 12288
noncomputable def axis0stage2 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage1 Mahjong.CartesianData00V19.v139 6144
noncomputable def axis0stage3 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage2 Mahjong.CartesianData00V19.v138 3072
noncomputable def axis0stage4 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage3 Mahjong.CartesianData00V19.v137 1536
noncomputable def axis0stage5 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage4 Mahjong.CartesianData00V19.v136 768
noncomputable def axis0stage6 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage5 Mahjong.CartesianData00V19.v135 384
noncomputable def axis0stage7 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage6 Mahjong.CartesianData00V19.v134 192
noncomputable def axis0stage8 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage7 Mahjong.CartesianData00V19.v133 96
noncomputable def axis0stage9 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage8 Mahjong.CartesianData00V19.v132 48
noncomputable def axis0stage10 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage9 Mahjong.CartesianData00V19.v131 24
noncomputable def axis0stage11 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage10 Mahjong.CartesianData00V19.v130 12
noncomputable def axis0stage12 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage11 Mahjong.CartesianData00V19.v129 6
noncomputable def axis0stage13 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage12 Mahjong.CartesianData00V19.v128 3
noncomputable def axis1start : Nat := ((Mahjong.CartesianChannels00V19.channel12 2048 Mahjong.CartesianData00V19.v89) ||| (Mahjong.CartesianChannels00V19.channel13 2048 Mahjong.CartesianData00V19.v93))
noncomputable def axis1stage0 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1start Mahjong.CartesianData00V19.v56 16384
noncomputable def axis1stage1 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage0 Mahjong.CartesianData00V19.v151 8192
noncomputable def axis1stage2 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage1 Mahjong.CartesianData00V19.v150 4096
noncomputable def axis1stage3 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage2 Mahjong.CartesianData00V19.v149 2048
noncomputable def axis1stage4 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage3 Mahjong.CartesianData00V19.v64 31744
noncomputable def axis1stage5 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage4 Mahjong.CartesianData00V19.v148 15872
noncomputable def axis1stage6 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage5 Mahjong.CartesianData00V19.v147 7936
noncomputable def axis1stage7 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage6 Mahjong.CartesianData00V19.v146 3968
noncomputable def axis1stage8 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage7 Mahjong.CartesianData00V19.v145 1984
noncomputable def axis1stage9 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage8 Mahjong.CartesianData00V19.v144 992
noncomputable def axis1stage10 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage9 Mahjong.CartesianData00V19.v143 496
noncomputable def axis1stage11 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage10 Mahjong.CartesianData00V19.v142 248
noncomputable def axis1stage12 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage11 Mahjong.CartesianData00V19.v141 124
noncomputable def axis2start : Nat := (((Mahjong.CartesianChannels01V19.channel14 128 Mahjong.CartesianData00V19.v97) ||| ((Mahjong.CartesianChannels02V19.channel15 128 Mahjong.CartesianData00V19.v101) ||| (Mahjong.CartesianChannels03V19.channel16 128 Mahjong.CartesianData00V19.v105))) ||| (((Mahjong.CartesianChannels04V19.channel17 128 Mahjong.CartesianData00V19.v109) ||| (Mahjong.CartesianChannels04V19.channel18 128 Mahjong.CartesianData00V19.v113)) ||| ((Mahjong.CartesianChannels04V19.channel19 128 Mahjong.CartesianData00V19.v117) ||| (Mahjong.CartesianChannels04V19.channel20 128 Mahjong.CartesianData00V19.v121))))
noncomputable def computedReach : Nat := ((axis0stage13 ||| axis1stage12) ||| (axis2start ||| Mahjong.CartesianData00V19.v125))
theorem provided_PN :
    computedReach = Mahjong.CartesianData00V19.v127 ∧
    (Mahjong.CartesianData00V19.v69 &&& computedReach) = 0 ∧
    (Mahjong.CartesianData00V19.v69 ||| computedReach) = Mahjong.CartesianData00V19.v126 := by decide +kernel
end Mahjong.CartesianPNB01V19
#print axioms Mahjong.CartesianPNB01V19.provided_PN
