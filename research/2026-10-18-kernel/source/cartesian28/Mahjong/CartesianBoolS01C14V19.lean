module
prelude
public import Mahjong.CartesianChannels11V19
import all Mahjong.CartesianChannels11V19
public import Mahjong.CartesianChannels15V19
import all Mahjong.CartesianChannels15V19
public import Mahjong.CartesianData00V19
import all Mahjong.CartesianData00V19
public import Mahjong.CartesianData02V19
import all Mahjong.CartesianData02V19
public import Mahjong.CartesianData03V19
import all Mahjong.CartesianData03V19
public import Mahjong.CartesianData04V19
import all Mahjong.CartesianData04V19
public import Mahjong.CartesianMathV19
import all Mahjong.CartesianMathV19
public section
set_option autoImplicit false
set_option exponentiation.threshold 16777216
set_option maxRecDepth 65536
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
namespace Mahjong.CartesianBoolS01C14V19
namespace B14
noncomputable def axis0start : Nat := (((Mahjong.CartesianChannels11V19.channel89 2048 Mahjong.CartesianData03V19.v406) ||| ((Mahjong.CartesianChannels11V19.channel90 2048 Mahjong.CartesianData03V19.v411) ||| (Mahjong.CartesianChannels15V19.channel142 2048 Mahjong.CartesianData03V19.v415))) ||| ((Mahjong.CartesianChannels15V19.channel143 2048 Mahjong.CartesianData03V19.v419) ||| ((Mahjong.CartesianChannels15V19.channel144 2048 Mahjong.CartesianData03V19.v423) ||| (Mahjong.CartesianChannels15V19.channel145 2048 Mahjong.CartesianData03V19.v427))))
noncomputable def axis0stage0 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0start Mahjong.CartesianData00V19.v56 16384
noncomputable def axis0stage1 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage0 Mahjong.CartesianData00V19.v55 24576
noncomputable def axis0stage2 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage1 Mahjong.CartesianData00V19.v54 28672
noncomputable def axis0stage3 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage2 Mahjong.CartesianData00V19.v65 30720
noncomputable def axis0stage4 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage3 Mahjong.CartesianData00V19.v64 31744
noncomputable def axis0stage5 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage4 Mahjong.CartesianData00V19.v148 15872
noncomputable def axis0stage6 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage5 Mahjong.CartesianData00V19.v147 7936
noncomputable def axis0stage7 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage6 Mahjong.CartesianData00V19.v146 3968
noncomputable def axis0stage8 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage7 Mahjong.CartesianData00V19.v145 1984
noncomputable def axis0stage9 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage8 Mahjong.CartesianData00V19.v144 992
noncomputable def axis0stage10 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage9 Mahjong.CartesianData00V19.v143 496
noncomputable def axis0stage11 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage10 Mahjong.CartesianData00V19.v142 248
noncomputable def axis0stage12 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage11 Mahjong.CartesianData00V19.v141 124
noncomputable def axis0stage13 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage12 Mahjong.CartesianData02V19.v186 62
noncomputable def axis0stage14 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage13 Mahjong.CartesianData02V19.v185 31
noncomputable def axis1start : Nat := (((Mahjong.CartesianChannels15V19.channel146 2048 Mahjong.CartesianData03V19.v431) ||| (Mahjong.CartesianChannels15V19.channel147 2048 Mahjong.CartesianData03V19.v435)) ||| ((Mahjong.CartesianChannels15V19.channel148 2048 Mahjong.CartesianData03V19.v439) ||| (Mahjong.CartesianChannels15V19.channel149 2048 Mahjong.CartesianData03V19.v443)))
noncomputable def axis1stage0 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1start Mahjong.CartesianData00V19.v56 16384
noncomputable def axis1stage1 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage0 Mahjong.CartesianData00V19.v55 24576
noncomputable def axis1stage2 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage1 Mahjong.CartesianData00V19.v54 28672
noncomputable def axis1stage3 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage2 Mahjong.CartesianData00V19.v65 30720
noncomputable def axis1stage4 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage3 Mahjong.CartesianData00V19.v64 31744
noncomputable def axis1stage5 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage4 Mahjong.CartesianData00V19.v148 15872
noncomputable def axis1stage6 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage5 Mahjong.CartesianData00V19.v147 7936
noncomputable def axis1stage7 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage6 Mahjong.CartesianData00V19.v146 3968
noncomputable def axis1stage8 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage7 Mahjong.CartesianData00V19.v145 1984
noncomputable def axis1stage9 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage8 Mahjong.CartesianData00V19.v144 992
noncomputable def axis2start : Nat := (((Mahjong.CartesianChannels15V19.channel150 1024 Mahjong.CartesianData03V19.v448) ||| ((Mahjong.CartesianChannels15V19.channel151 1024 Mahjong.CartesianData03V19.v452) ||| (Mahjong.CartesianChannels15V19.channel152 1024 Mahjong.CartesianData03V19.v456))) ||| (((Mahjong.CartesianChannels15V19.channel153 1024 Mahjong.CartesianData03V19.v460) ||| (Mahjong.CartesianChannels15V19.channel154 1024 Mahjong.CartesianData03V19.v464)) ||| ((Mahjong.CartesianChannels15V19.channel155 1024 Mahjong.CartesianData03V19.v468) ||| (Mahjong.CartesianChannels15V19.channel156 1024 Mahjong.CartesianData04V19.v0))))
noncomputable def computedReach : Nat := ((axis0stage14 ||| axis1stage9) ||| (axis2start ||| (Mahjong.CartesianData04V19.v4 ||| Mahjong.CartesianData04V19.v8)))
end B14
noncomputable def checks : Bool := (((Mahjong.CartesianData03V19.v404 &&& B14.computedReach) == 0) && ((Mahjong.CartesianData03V19.v404 ||| B14.computedReach) == Mahjong.CartesianData04V19.v9))
theorem accepted : checks = true := by exact Eq.refl true
end Mahjong.CartesianBoolS01C14V19
#print axioms Mahjong.CartesianBoolS01C14V19.accepted
