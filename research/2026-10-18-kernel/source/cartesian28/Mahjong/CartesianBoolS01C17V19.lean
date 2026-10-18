module
prelude
public import Mahjong.CartesianChannels12V19
import all Mahjong.CartesianChannels12V19
public import Mahjong.CartesianChannels17V19
import all Mahjong.CartesianChannels17V19
public import Mahjong.CartesianChannels18V19
import all Mahjong.CartesianChannels18V19
public import Mahjong.CartesianChannels19V19
import all Mahjong.CartesianChannels19V19
public import Mahjong.CartesianData00V19
import all Mahjong.CartesianData00V19
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
namespace Mahjong.CartesianBoolS01C17V19
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
noncomputable def checks : Bool := (((Mahjong.CartesianData04V19.v169 &&& B17.computedReach) == 0) && ((Mahjong.CartesianData04V19.v169 ||| B17.computedReach) == Mahjong.CartesianData05V19.v7))
theorem accepted : checks = true := by exact Eq.refl true
end Mahjong.CartesianBoolS01C17V19
#print axioms Mahjong.CartesianBoolS01C17V19.accepted
