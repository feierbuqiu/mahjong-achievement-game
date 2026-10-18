module
prelude
public import Mahjong.CartesianChannels04V19
import all Mahjong.CartesianChannels04V19
public import Mahjong.CartesianChannels05V19
import all Mahjong.CartesianChannels05V19
public import Mahjong.CartesianChannels06V19
import all Mahjong.CartesianChannels06V19
public import Mahjong.CartesianChannels07V19
import all Mahjong.CartesianChannels07V19
public import Mahjong.CartesianChannels08V19
import all Mahjong.CartesianChannels08V19
public import Mahjong.CartesianData00V19
import all Mahjong.CartesianData00V19
public import Mahjong.CartesianData01V19
import all Mahjong.CartesianData01V19
public import Mahjong.CartesianData02V19
import all Mahjong.CartesianData02V19
public import Mahjong.CartesianMathV19
import all Mahjong.CartesianMathV19
public section
set_option autoImplicit false
set_option exponentiation.threshold 16777216
set_option maxRecDepth 65536
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
namespace Mahjong.CartesianBoolS02C02V19
namespace B04
noncomputable def axis0start : Nat := (((Mahjong.CartesianChannels04V19.channel21 4096 Mahjong.CartesianData01V19.v72) ||| (Mahjong.CartesianChannels04V19.channel23 4096 Mahjong.CartesianData01V19.v76)) ||| ((Mahjong.CartesianChannels04V19.channel24 4096 Mahjong.CartesianData01V19.v80) ||| ((Mahjong.CartesianChannels04V19.channel25 4096 Mahjong.CartesianData01V19.v84) ||| (Mahjong.CartesianChannels04V19.channel27 4096 Mahjong.CartesianData01V19.v88))))
noncomputable def axis0stage0 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0start Mahjong.CartesianData01V19.v26 32768
noncomputable def axis0stage1 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage0 Mahjong.CartesianData01V19.v25 16384
noncomputable def axis0stage2 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage1 Mahjong.CartesianData01V19.v24 57344
noncomputable def axis0stage3 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage2 Mahjong.CartesianData01V19.v23 28672
noncomputable def axis0stage4 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage3 Mahjong.CartesianData01V19.v22 63488
noncomputable def axis0stage5 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage4 Mahjong.CartesianData01V19.v21 31744
noncomputable def axis0stage6 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage5 Mahjong.CartesianData01V19.v20 15872
noncomputable def axis0stage7 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage6 Mahjong.CartesianData01V19.v19 7936
noncomputable def axis0stage8 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage7 Mahjong.CartesianData01V19.v18 3968
noncomputable def axis0stage9 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage8 Mahjong.CartesianData01V19.v17 1984
noncomputable def axis0stage10 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage9 Mahjong.CartesianData01V19.v16 992
noncomputable def axis0stage11 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage10 Mahjong.CartesianData01V19.v15 496
noncomputable def axis0stage12 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage11 Mahjong.CartesianData01V19.v14 248
noncomputable def axis0stage13 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage12 Mahjong.CartesianData01V19.v13 124
noncomputable def axis0stage14 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage13 Mahjong.CartesianData01V19.v12 62
noncomputable def axis0stage15 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage14 Mahjong.CartesianData01V19.v11 31
noncomputable def axis1start : Nat := (((Mahjong.CartesianChannels05V19.channel46 8192 Mahjong.CartesianData01V19.v93) ||| (Mahjong.CartesianChannels05V19.channel47 8192 Mahjong.CartesianData01V19.v97)) ||| ((Mahjong.CartesianChannels06V19.channel48 8192 Mahjong.CartesianData01V19.v101) ||| (Mahjong.CartesianChannels06V19.channel49 8192 Mahjong.CartesianData01V19.v105)))
noncomputable def axis1stage0 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1start Mahjong.CartesianData01V19.v136 61440
noncomputable def axis1stage1 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage0 Mahjong.CartesianData01V19.v135 30720
noncomputable def axis1stage2 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage1 Mahjong.CartesianData01V19.v134 15360
noncomputable def axis1stage3 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage2 Mahjong.CartesianData01V19.v133 7680
noncomputable def axis1stage4 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage3 Mahjong.CartesianData01V19.v132 3840
noncomputable def axis1stage5 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage4 Mahjong.CartesianData01V19.v131 1920
noncomputable def axis1stage6 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage5 Mahjong.CartesianData01V19.v130 960
noncomputable def axis1stage7 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage6 Mahjong.CartesianData01V19.v129 480
noncomputable def axis2start : Nat := ((Mahjong.CartesianChannels06V19.channel50 512 Mahjong.CartesianData01V19.v110) ||| ((Mahjong.CartesianChannels06V19.channel51 512 Mahjong.CartesianData01V19.v114) ||| (Mahjong.CartesianChannels07V19.channel52 512 Mahjong.CartesianData01V19.v118)))
noncomputable def computedReach : Nat := ((axis0stage15 ||| axis1stage7) ||| (axis2start ||| (Mahjong.CartesianData01V19.v122 ||| Mahjong.CartesianData01V19.v126)))
end B04

namespace B05
noncomputable def axis0start : Nat := ((Mahjong.CartesianChannels07V19.channel53 8192 Mahjong.CartesianData01V19.v142) ||| (Mahjong.CartesianChannels07V19.channel54 8192 Mahjong.CartesianData01V19.v146))
noncomputable def axis0stage0 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0start Mahjong.CartesianData00V19.v56 16384
noncomputable def axis0stage1 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage0 Mahjong.CartesianData00V19.v55 24576
noncomputable def axis0stage2 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage1 Mahjong.CartesianData00V19.v54 28672
noncomputable def axis0stage3 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage2 Mahjong.CartesianData00V19.v53 14336
noncomputable def axis0stage4 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage3 Mahjong.CartesianData00V19.v52 7168
noncomputable def axis0stage5 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage4 Mahjong.CartesianData00V19.v51 3584
noncomputable def axis0stage6 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage5 Mahjong.CartesianData00V19.v50 1792
noncomputable def axis0stage7 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage6 Mahjong.CartesianData00V19.v49 896
noncomputable def axis0stage8 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage7 Mahjong.CartesianData00V19.v48 448
noncomputable def axis0stage9 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage8 Mahjong.CartesianData00V19.v47 224
noncomputable def axis0stage10 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage9 Mahjong.CartesianData00V19.v46 112
noncomputable def axis0stage11 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage10 Mahjong.CartesianData00V19.v45 56
noncomputable def axis0stage12 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage11 Mahjong.CartesianData00V19.v44 28
noncomputable def axis0stage13 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage12 Mahjong.CartesianData00V19.v43 14
noncomputable def axis0stage14 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage13 Mahjong.CartesianData00V19.v42 7
noncomputable def axis1start : Nat := (((Mahjong.CartesianChannels07V19.channel55 256 Mahjong.CartesianData01V19.v151) ||| (Mahjong.CartesianChannels07V19.channel56 256 Mahjong.CartesianData01V19.v155)) ||| ((Mahjong.CartesianChannels08V19.channel57 256 Mahjong.CartesianData01V19.v159) ||| (Mahjong.CartesianChannels08V19.channel58 256 Mahjong.CartesianData01V19.v163)))
noncomputable def axis1stage0 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1start Mahjong.CartesianData00V19.v56 16384
noncomputable def axis1stage1 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage0 Mahjong.CartesianData00V19.v151 8192
noncomputable def axis1stage2 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage1 Mahjong.CartesianData00V19.v54 28672
noncomputable def axis1stage3 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage2 Mahjong.CartesianData00V19.v53 14336
noncomputable def axis1stage4 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage3 Mahjong.CartesianData00V19.v52 7168
noncomputable def axis1stage5 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage4 Mahjong.CartesianData00V19.v51 3584
noncomputable def axis1stage6 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage5 Mahjong.CartesianData00V19.v50 1792
noncomputable def axis1stage7 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage6 Mahjong.CartesianData02V19.v12 32640
noncomputable def axis1stage8 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage7 Mahjong.CartesianData02V19.v11 16320
noncomputable def axis1stage9 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage8 Mahjong.CartesianData02V19.v10 8160
noncomputable def axis1stage10 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage9 Mahjong.CartesianData02V19.v9 4080
noncomputable def axis1stage11 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage10 Mahjong.CartesianData02V19.v8 2040
noncomputable def axis2start : Nat := ((Mahjong.CartesianChannels08V19.channel59 2048 Mahjong.CartesianData02V19.v1) ||| (Mahjong.CartesianChannels08V19.channel60 2048 Mahjong.CartesianData02V19.v5))
noncomputable def computedReach : Nat := (axis0stage14 ||| (axis1stage11 ||| axis2start))
end B05
noncomputable def checks : Bool := ((((Mahjong.CartesianData01V19.v70 &&& B04.computedReach) == 0) && ((Mahjong.CartesianData01V19.v70 ||| B04.computedReach) == Mahjong.CartesianData01V19.v127)) && (((Mahjong.CartesianData01V19.v140 &&& B05.computedReach) == 0) && ((Mahjong.CartesianData01V19.v140 ||| B05.computedReach) == Mahjong.CartesianData02V19.v6)))
theorem accepted : checks = true := by exact Eq.refl true
end Mahjong.CartesianBoolS02C02V19
#print axioms Mahjong.CartesianBoolS02C02V19.accepted
