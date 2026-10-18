module
prelude
public import Mahjong.CartesianChannels12V19
import all Mahjong.CartesianChannels12V19
public import Mahjong.CartesianChannels16V19
import all Mahjong.CartesianChannels16V19
public import Mahjong.CartesianChannels17V19
import all Mahjong.CartesianChannels17V19
public import Mahjong.CartesianChannels18V19
import all Mahjong.CartesianChannels18V19
public import Mahjong.CartesianChannels19V19
import all Mahjong.CartesianChannels19V19
public import Mahjong.CartesianData00V19
import all Mahjong.CartesianData00V19
public import Mahjong.CartesianData01V19
import all Mahjong.CartesianData01V19
public import Mahjong.CartesianData02V19
import all Mahjong.CartesianData02V19
public import Mahjong.CartesianData04V19
import all Mahjong.CartesianData04V19
public import Mahjong.CartesianData05V19
import all Mahjong.CartesianData05V19
public import Mahjong.CartesianMathV19
import all Mahjong.CartesianMathV19
public section
set_option autoImplicit false
set_option exponentiation.threshold 16777216
set_option maxRecDepth 65536
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
namespace Mahjong.CartesianBoolS02C08V19
namespace B16
noncomputable def axis0start : Nat := ((Mahjong.CartesianChannels16V19.channel162 16384 Mahjong.CartesianData04V19.v114) ||| ((Mahjong.CartesianChannels16V19.channel163 16384 Mahjong.CartesianData04V19.v118) ||| (Mahjong.CartesianChannels16V19.channel164 16384 Mahjong.CartesianData04V19.v122)))
noncomputable def axis0stage0 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0start Mahjong.CartesianData01V19.v26 32768
noncomputable def axis0stage1 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage0 Mahjong.CartesianData01V19.v25 16384
noncomputable def axis0stage2 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage1 Mahjong.CartesianData01V19.v24 57344
noncomputable def axis0stage3 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage2 Mahjong.CartesianData01V19.v23 28672
noncomputable def axis0stage4 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage3 Mahjong.CartesianData02V19.v90 14336
noncomputable def axis0stage5 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage4 Mahjong.CartesianData02V19.v89 7168
noncomputable def axis0stage6 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage5 Mahjong.CartesianData02V19.v88 3584
noncomputable def axis0stage7 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage6 Mahjong.CartesianData02V19.v87 1792
noncomputable def axis0stage8 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage7 Mahjong.CartesianData02V19.v86 896
noncomputable def axis0stage9 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage8 Mahjong.CartesianData02V19.v85 448
noncomputable def axis0stage10 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage9 Mahjong.CartesianData02V19.v84 224
noncomputable def axis0stage11 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage10 Mahjong.CartesianData04V19.v163 112
noncomputable def axis0stage12 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage11 Mahjong.CartesianData04V19.v162 56
noncomputable def axis0stage13 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage12 Mahjong.CartesianData04V19.v161 28
noncomputable def axis0stage14 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage13 Mahjong.CartesianData04V19.v160 14
noncomputable def axis0stage15 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage14 Mahjong.CartesianData04V19.v159 7
noncomputable def axis1start : Nat := (((Mahjong.CartesianChannels16V19.channel165 4096 Mahjong.CartesianData04V19.v127) ||| (Mahjong.CartesianChannels16V19.channel166 4096 Mahjong.CartesianData04V19.v131)) ||| ((Mahjong.CartesianChannels16V19.channel167 4096 Mahjong.CartesianData04V19.v135) ||| ((Mahjong.CartesianChannels16V19.channel168 4096 Mahjong.CartesianData04V19.v139) ||| (Mahjong.CartesianChannels16V19.channel169 4096 Mahjong.CartesianData04V19.v143))))
noncomputable def axis1stage0 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1start Mahjong.CartesianData01V19.v26 32768
noncomputable def axis1stage1 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage0 Mahjong.CartesianData01V19.v25 16384
noncomputable def axis1stage2 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage1 Mahjong.CartesianData04V19.v165 8192
noncomputable def axis1stage3 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage2 Mahjong.CartesianData04V19.v164 4096
noncomputable def axis1stage4 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage3 Mahjong.CartesianData01V19.v22 63488
noncomputable def axis1stage5 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage4 Mahjong.CartesianData01V19.v21 31744
noncomputable def axis1stage6 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage5 Mahjong.CartesianData01V19.v20 15872
noncomputable def axis1stage7 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage6 Mahjong.CartesianData01V19.v19 7936
noncomputable def axis1stage8 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage7 Mahjong.CartesianData01V19.v18 3968
noncomputable def axis1stage9 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage8 Mahjong.CartesianData01V19.v17 1984
noncomputable def axis1stage10 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage9 Mahjong.CartesianData01V19.v16 992
noncomputable def axis1stage11 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage10 Mahjong.CartesianData01V19.v15 496
noncomputable def axis1stage12 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage11 Mahjong.CartesianData01V19.v14 248
noncomputable def axis2start : Nat := ((Mahjong.CartesianChannels17V19.channel170 256 Mahjong.CartesianData04V19.v148) ||| (Mahjong.CartesianChannels17V19.channel171 256 Mahjong.CartesianData04V19.v152))
noncomputable def computedReach : Nat := ((axis0stage15 ||| axis1stage12) ||| (axis2start ||| Mahjong.CartesianData04V19.v156))
end B16

namespace B17
noncomputable def axis0start : Nat := (((Mahjong.CartesianChannels12V19.channel115 4096 Mahjong.CartesianData04V19.v172) ||| (Mahjong.CartesianChannels17V19.channel172 4096 Mahjong.CartesianData04V19.v176)) ||| ((Mahjong.CartesianChannels12V19.channel116 4096 Mahjong.CartesianData04V19.v180) ||| (Mahjong.CartesianChannels17V19.channel173 4096 Mahjong.CartesianData04V19.v184)))
noncomputable def axis0stage0 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0start Mahjong.CartesianData00V19.v65 30720
noncomputable def axis0stage1 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage0 Mahjong.CartesianData05V19.v19 15360
noncomputable def axis0stage2 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage1 Mahjong.CartesianData05V19.v18 7680
noncomputable def axis0stage3 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage2 Mahjong.CartesianData05V19.v17 3840
noncomputable def axis0stage4 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage3 Mahjong.CartesianData05V19.v16 1920
noncomputable def axis0stage5 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage4 Mahjong.CartesianData05V19.v15 960
noncomputable def axis0stage6 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage5 Mahjong.CartesianData05V19.v14 480
noncomputable def axis0stage7 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage6 Mahjong.CartesianData05V19.v13 240
noncomputable def axis0stage8 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage7 Mahjong.CartesianData05V19.v12 120
noncomputable def axis0stage9 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage8 Mahjong.CartesianData05V19.v11 60
noncomputable def axis0stage10 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage9 Mahjong.CartesianData05V19.v10 30
noncomputable def axis0stage11 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage10 Mahjong.CartesianData05V19.v9 15
noncomputable def axis1start : Nat := ((Mahjong.CartesianChannels18V19.channel174 4096 Mahjong.CartesianData04V19.v188) ||| ((Mahjong.CartesianChannels18V19.channel175 4096 Mahjong.CartesianData04V19.v192) ||| (Mahjong.CartesianChannels18V19.channel176 4096 Mahjong.CartesianData04V19.v196)))
noncomputable def axis1stage0 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1start Mahjong.CartesianData00V19.v65 30720
noncomputable def axis1stage1 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage0 Mahjong.CartesianData05V19.v19 15360
noncomputable def axis1stage2 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage1 Mahjong.CartesianData05V19.v18 7680
noncomputable def axis1stage3 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage2 Mahjong.CartesianData05V19.v17 3840
noncomputable def axis1stage4 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage3 Mahjong.CartesianData05V19.v16 1920
noncomputable def axis1stage5 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage4 Mahjong.CartesianData05V19.v15 960
noncomputable def axis1stage6 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage5 Mahjong.CartesianData05V19.v14 480
noncomputable def axis1stage7 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage6 Mahjong.CartesianData05V19.v13 240
noncomputable def axis2start : Nat := ((Mahjong.CartesianChannels18V19.channel177 256 Mahjong.CartesianData04V19.v201) ||| (Mahjong.CartesianChannels19V19.channel178 256 Mahjong.CartesianData05V19.v2))
noncomputable def computedReach : Nat := ((axis0stage11 ||| axis1stage7) ||| (axis2start ||| Mahjong.CartesianData05V19.v6))
end B17
noncomputable def checks : Bool := ((((Mahjong.CartesianData04V19.v112 &&& B16.computedReach) == 0) && ((Mahjong.CartesianData04V19.v112 ||| B16.computedReach) == Mahjong.CartesianData04V19.v157)) && (((Mahjong.CartesianData04V19.v169 &&& B17.computedReach) == 0) && ((Mahjong.CartesianData04V19.v169 ||| B17.computedReach) == Mahjong.CartesianData05V19.v7)))
theorem accepted : checks = true := by exact Eq.refl true
end Mahjong.CartesianBoolS02C08V19
#print axioms Mahjong.CartesianBoolS02C08V19.accepted
