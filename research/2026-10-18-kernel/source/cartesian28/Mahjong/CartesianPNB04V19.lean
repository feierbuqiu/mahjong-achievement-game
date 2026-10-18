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
public import Mahjong.CartesianData01V19
import all Mahjong.CartesianData01V19
public import Mahjong.CartesianMathV19
import all Mahjong.CartesianMathV19
public section
set_option autoImplicit false
set_option maxRecDepth 131072
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
namespace Mahjong.CartesianPNB04V19
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
theorem provided_PN :
    computedReach = Mahjong.CartesianData01V19.v128 ∧
    (Mahjong.CartesianData01V19.v70 &&& computedReach) = 0 ∧
    (Mahjong.CartesianData01V19.v70 ||| computedReach) = Mahjong.CartesianData01V19.v127 := by decide +kernel
end Mahjong.CartesianPNB04V19
#print axioms Mahjong.CartesianPNB04V19.provided_PN
