module
prelude
public import Mahjong.CartesianChannels11V19
import all Mahjong.CartesianChannels11V19
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
namespace Mahjong.CartesianBoolS01C10V19
namespace B10
noncomputable def axis0start : Nat := ((Mahjong.CartesianChannels11V19.channel95 512 Mahjong.CartesianData03V19.v48) ||| (Mahjong.CartesianChannels11V19.channel96 512 Mahjong.CartesianData03V19.v52))
noncomputable def axis0stage0 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0start Mahjong.CartesianData03V19.v72 4096
noncomputable def axis0stage1 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage0 Mahjong.CartesianData03V19.v71 2048
noncomputable def axis0stage2 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage1 Mahjong.CartesianData03V19.v70 1024
noncomputable def axis0stage3 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage2 Mahjong.CartesianData03V19.v69 512
noncomputable def axis0stage4 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage3 Mahjong.CartesianData03V19.v68 7936
noncomputable def axis0stage5 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage4 Mahjong.CartesianData03V19.v67 3968
noncomputable def axis0stage6 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage5 Mahjong.CartesianData03V19.v66 1984
noncomputable def axis0stage7 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage6 Mahjong.CartesianData03V19.v65 992
noncomputable def axis0stage8 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage7 Mahjong.CartesianData03V19.v64 496
noncomputable def axis0stage9 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage8 Mahjong.CartesianData03V19.v63 248
noncomputable def axis0stage10 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage9 Mahjong.CartesianData03V19.v62 124
noncomputable def axis0stage11 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage10 Mahjong.CartesianData03V19.v61 62
noncomputable def axis0stage12 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage11 Mahjong.CartesianData03V19.v60 31
noncomputable def axis1start : Nat := ((Mahjong.CartesianChannels11V19.channel95 512 Mahjong.CartesianData03V19.v48) ||| (Mahjong.CartesianChannels11V19.channel96 512 Mahjong.CartesianData03V19.v52))
noncomputable def axis1stage0 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1start Mahjong.CartesianData03V19.v72 4096
noncomputable def axis1stage1 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage0 Mahjong.CartesianData03V19.v71 2048
noncomputable def axis1stage2 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage1 Mahjong.CartesianData03V19.v70 1024
noncomputable def axis1stage3 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage2 Mahjong.CartesianData03V19.v69 512
noncomputable def axis1stage4 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage3 Mahjong.CartesianData03V19.v68 7936
noncomputable def axis1stage5 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage4 Mahjong.CartesianData03V19.v67 3968
noncomputable def axis1stage6 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage5 Mahjong.CartesianData03V19.v66 1984
noncomputable def axis1stage7 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage6 Mahjong.CartesianData03V19.v65 992
noncomputable def axis2start : Nat := 0
noncomputable def computedReach : Nat := ((axis0stage12 ||| axis1stage7) ||| (axis2start ||| Mahjong.CartesianData03V19.v57))
end B10
noncomputable def checks : Bool := (((Mahjong.CartesianData03V19.v45 &&& B10.computedReach) == 0) && ((Mahjong.CartesianData03V19.v45 ||| B10.computedReach) == Mahjong.CartesianData03V19.v58))
theorem accepted : checks = true := by exact Eq.refl true
end Mahjong.CartesianBoolS01C10V19
#print axioms Mahjong.CartesianBoolS01C10V19.accepted
