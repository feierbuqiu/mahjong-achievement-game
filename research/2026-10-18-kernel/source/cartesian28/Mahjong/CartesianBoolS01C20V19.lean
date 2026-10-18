module
prelude
public import Mahjong.CartesianChannels01V19
import all Mahjong.CartesianChannels01V19
public import Mahjong.CartesianChannels02V19
import all Mahjong.CartesianChannels02V19
public import Mahjong.CartesianChannels20V19
import all Mahjong.CartesianChannels20V19
public import Mahjong.CartesianData01V19
import all Mahjong.CartesianData01V19
public import Mahjong.CartesianData02V19
import all Mahjong.CartesianData02V19
public import Mahjong.CartesianData06V19
import all Mahjong.CartesianData06V19
public import Mahjong.CartesianMathV19
import all Mahjong.CartesianMathV19
public section
set_option autoImplicit false
set_option exponentiation.threshold 16777216
set_option maxRecDepth 65536
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
namespace Mahjong.CartesianBoolS01C20V19
namespace B20
noncomputable def axis0start : Nat := ((Mahjong.CartesianChannels20V19.channel200 4096 Mahjong.CartesianData06V19.v34) ||| (Mahjong.CartesianChannels20V19.channel201 4096 Mahjong.CartesianData06V19.v38))
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
noncomputable def axis1start : Nat := (Mahjong.CartesianChannels20V19.channel202 16384 Mahjong.CartesianData06V19.v44)
noncomputable def axis1stage0 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1start Mahjong.CartesianData01V19.v24 57344
noncomputable def axis1stage1 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage0 Mahjong.CartesianData01V19.v23 28672
noncomputable def axis1stage2 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage1 Mahjong.CartesianData02V19.v90 14336
noncomputable def axis1stage3 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage2 Mahjong.CartesianData02V19.v89 7168
noncomputable def axis1stage4 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage3 Mahjong.CartesianData02V19.v88 3584
noncomputable def axis1stage5 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage4 Mahjong.CartesianData02V19.v87 1792
noncomputable def axis1stage6 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage5 Mahjong.CartesianData02V19.v86 896
noncomputable def axis1stage7 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage6 Mahjong.CartesianData02V19.v85 448
noncomputable def axis1stage8 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage7 Mahjong.CartesianData02V19.v84 224
noncomputable def axis2start : Nat := ((Mahjong.CartesianChannels01V19.channel14 256 Mahjong.CartesianData06V19.v48) ||| (Mahjong.CartesianChannels02V19.channel15 256 Mahjong.CartesianData06V19.v52))
noncomputable def computedReach : Nat := ((axis0stage15 ||| axis1stage8) ||| (axis2start ||| Mahjong.CartesianData06V19.v56))
end B20
noncomputable def checks : Bool := (((Mahjong.CartesianData06V19.v32 &&& B20.computedReach) == 0) && ((Mahjong.CartesianData06V19.v32 ||| B20.computedReach) == Mahjong.CartesianData06V19.v57))
theorem accepted : checks = true := by exact Eq.refl true
end Mahjong.CartesianBoolS01C20V19
#print axioms Mahjong.CartesianBoolS01C20V19.accepted
