module
prelude
public import Mahjong.CartesianChannels12V19
import all Mahjong.CartesianChannels12V19
public import Mahjong.CartesianChannels20V19
import all Mahjong.CartesianChannels20V19
public import Mahjong.CartesianData00V19
import all Mahjong.CartesianData00V19
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
namespace Mahjong.CartesianBoolS01C18V19
namespace B18
noncomputable def axis0start : Nat := ((Mahjong.CartesianChannels12V19.channel115 4096 Mahjong.CartesianData05V19.v25) ||| (Mahjong.CartesianChannels12V19.channel116 4096 Mahjong.CartesianData05V19.v29))
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
noncomputable def axis1start : Nat := (Mahjong.CartesianChannels20V19.channel179 8192 Mahjong.CartesianData05V19.v34)
noncomputable def axis1stage0 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1start Mahjong.CartesianData00V19.v54 28672
noncomputable def axis1stage1 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage0 Mahjong.CartesianData00V19.v53 14336
noncomputable def axis1stage2 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage1 Mahjong.CartesianData00V19.v52 7168
noncomputable def axis1stage3 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage2 Mahjong.CartesianData00V19.v51 3584
noncomputable def axis1stage4 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage3 Mahjong.CartesianData00V19.v50 1792
noncomputable def axis1stage5 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage4 Mahjong.CartesianData00V19.v49 896
noncomputable def axis1stage6 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage5 Mahjong.CartesianData00V19.v48 448
noncomputable def axis1stage7 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage6 Mahjong.CartesianData00V19.v47 224
noncomputable def axis1stage8 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage7 Mahjong.CartesianData00V19.v46 112
noncomputable def axis2start : Nat := ((Mahjong.CartesianChannels20V19.channel180 128 Mahjong.CartesianData05V19.v39) ||| (Mahjong.CartesianChannels20V19.channel181 128 Mahjong.CartesianData05V19.v43))
noncomputable def computedReach : Nat := ((axis0stage11 ||| axis1stage8) ||| (axis2start ||| (Mahjong.CartesianData05V19.v47 ||| Mahjong.CartesianData05V19.v51)))
end B18
noncomputable def checks : Bool := (((Mahjong.CartesianData05V19.v23 &&& B18.computedReach) == 0) && ((Mahjong.CartesianData05V19.v23 ||| B18.computedReach) == Mahjong.CartesianData05V19.v52))
theorem accepted : checks = true := by exact Eq.refl true
end Mahjong.CartesianBoolS01C18V19
#print axioms Mahjong.CartesianBoolS01C18V19.accepted
