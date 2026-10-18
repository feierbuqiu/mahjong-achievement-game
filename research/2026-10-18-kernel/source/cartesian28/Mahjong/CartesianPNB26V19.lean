module
prelude
public import Mahjong.CartesianChannels24V19
import all Mahjong.CartesianChannels24V19
public import Mahjong.CartesianChannels25V19
import all Mahjong.CartesianChannels25V19
public import Mahjong.CartesianChannels26V19
import all Mahjong.CartesianChannels26V19
public import Mahjong.CartesianData00V19
import all Mahjong.CartesianData00V19
public import Mahjong.CartesianData05V19
import all Mahjong.CartesianData05V19
public import Mahjong.CartesianData08V19
import all Mahjong.CartesianData08V19
public import Mahjong.CartesianMathV19
import all Mahjong.CartesianMathV19
public section
set_option autoImplicit false
set_option maxRecDepth 131072
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
namespace Mahjong.CartesianPNB26V19
noncomputable def axis0start : Nat := ((((Mahjong.CartesianChannels24V19.channel234 4096 Mahjong.CartesianData08V19.v32) ||| (Mahjong.CartesianChannels24V19.channel235 4096 Mahjong.CartesianData08V19.v36)) ||| ((Mahjong.CartesianChannels24V19.channel236 4096 Mahjong.CartesianData08V19.v40) ||| (Mahjong.CartesianChannels24V19.channel237 4096 Mahjong.CartesianData08V19.v44))) ||| (((Mahjong.CartesianChannels24V19.channel238 4096 Mahjong.CartesianData08V19.v48) ||| (Mahjong.CartesianChannels24V19.channel239 4096 Mahjong.CartesianData08V19.v52)) ||| ((Mahjong.CartesianChannels24V19.channel240 4096 Mahjong.CartesianData08V19.v56) ||| ((Mahjong.CartesianChannels24V19.channel241 4096 Mahjong.CartesianData08V19.v60) ||| (Mahjong.CartesianChannels24V19.channel242 4096 Mahjong.CartesianData08V19.v64)))))
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
noncomputable def axis1start : Nat := ((Mahjong.CartesianChannels24V19.channel243 4096 Mahjong.CartesianData08V19.v69) ||| (Mahjong.CartesianChannels24V19.channel244 4096 Mahjong.CartesianData08V19.v73))
noncomputable def axis1stage0 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1start Mahjong.CartesianData00V19.v65 30720
noncomputable def axis1stage1 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage0 Mahjong.CartesianData05V19.v19 15360
noncomputable def axis1stage2 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage1 Mahjong.CartesianData05V19.v18 7680
noncomputable def axis1stage3 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage2 Mahjong.CartesianData05V19.v17 3840
noncomputable def axis1stage4 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage3 Mahjong.CartesianData05V19.v16 1920
noncomputable def axis1stage5 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage4 Mahjong.CartesianData05V19.v15 960
noncomputable def axis1stage6 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage5 Mahjong.CartesianData05V19.v14 480
noncomputable def axis1stage7 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage6 Mahjong.CartesianData05V19.v13 240
noncomputable def axis2start : Nat := ((Mahjong.CartesianChannels24V19.channel245 256 Mahjong.CartesianData08V19.v78) ||| ((Mahjong.CartesianChannels25V19.channel246 256 Mahjong.CartesianData08V19.v82) ||| (Mahjong.CartesianChannels26V19.channel247 256 Mahjong.CartesianData08V19.v86)))
noncomputable def computedReach : Nat := ((axis0stage11 ||| axis1stage7) ||| (axis2start ||| (Mahjong.CartesianData08V19.v90 ||| Mahjong.CartesianData08V19.v94)))
theorem provided_PN :
    computedReach = Mahjong.CartesianData08V19.v96 ∧
    (Mahjong.CartesianData08V19.v30 &&& computedReach) = 0 ∧
    (Mahjong.CartesianData08V19.v30 ||| computedReach) = Mahjong.CartesianData08V19.v95 := by decide +kernel
end Mahjong.CartesianPNB26V19
#print axioms Mahjong.CartesianPNB26V19.provided_PN
