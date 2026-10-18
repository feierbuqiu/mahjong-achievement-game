module
prelude
public import Mahjong.CartesianChannels11V19
import all Mahjong.CartesianChannels11V19
public import Mahjong.CartesianData02V19
import all Mahjong.CartesianData02V19
public import Mahjong.CartesianData03V19
import all Mahjong.CartesianData03V19
public import Mahjong.CartesianMathV19
import all Mahjong.CartesianMathV19
public section
set_option autoImplicit false
set_option maxRecDepth 131072
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
namespace Mahjong.CartesianPNB09V19
noncomputable def axis0start : Nat := ((Mahjong.CartesianChannels11V19.channel89 1024 Mahjong.CartesianData03V19.v5) ||| (Mahjong.CartesianChannels11V19.channel90 1024 Mahjong.CartesianData03V19.v9))
noncomputable def axis0stage0 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0start Mahjong.CartesianData03V19.v41 15872
noncomputable def axis0stage1 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage0 Mahjong.CartesianData03V19.v40 7936
noncomputable def axis0stage2 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage1 Mahjong.CartesianData03V19.v39 3968
noncomputable def axis0stage3 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage2 Mahjong.CartesianData03V19.v38 1984
noncomputable def axis0stage4 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage3 Mahjong.CartesianData03V19.v37 992
noncomputable def axis0stage5 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage4 Mahjong.CartesianData03V19.v36 496
noncomputable def axis0stage6 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage5 Mahjong.CartesianData03V19.v35 248
noncomputable def axis0stage7 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage6 Mahjong.CartesianData03V19.v34 124
noncomputable def axis0stage8 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage7 Mahjong.CartesianData03V19.v33 62
noncomputable def axis0stage9 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage8 Mahjong.CartesianData03V19.v32 31
noncomputable def axis1start : Nat := (((Mahjong.CartesianChannels11V19.channel91 1024 Mahjong.CartesianData03V19.v13) ||| (Mahjong.CartesianChannels11V19.channel92 1024 Mahjong.CartesianData03V19.v17)) ||| ((Mahjong.CartesianChannels11V19.channel93 1024 Mahjong.CartesianData03V19.v21) ||| (Mahjong.CartesianChannels11V19.channel94 1024 Mahjong.CartesianData03V19.v25)))
noncomputable def axis1stage0 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1start Mahjong.CartesianData03V19.v41 15872
noncomputable def axis1stage1 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage0 Mahjong.CartesianData03V19.v40 7936
noncomputable def axis1stage2 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage1 Mahjong.CartesianData03V19.v39 3968
noncomputable def axis1stage3 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage2 Mahjong.CartesianData03V19.v38 1984
noncomputable def axis1stage4 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage3 Mahjong.CartesianData03V19.v37 992
noncomputable def axis2start : Nat := (((Mahjong.CartesianChannels11V19.channel91 1024 Mahjong.CartesianData03V19.v13) ||| (Mahjong.CartesianChannels11V19.channel92 1024 Mahjong.CartesianData03V19.v17)) ||| ((Mahjong.CartesianChannels11V19.channel93 1024 Mahjong.CartesianData03V19.v21) ||| (Mahjong.CartesianChannels11V19.channel94 1024 Mahjong.CartesianData03V19.v25)))
noncomputable def computedReach : Nat := ((axis0stage9 ||| axis1stage4) ||| (axis2start ||| Mahjong.CartesianData03V19.v29))
theorem provided_PN :
    computedReach = Mahjong.CartesianData03V19.v31 ∧
    (Mahjong.CartesianData03V19.v1 &&& computedReach) = 0 ∧
    (Mahjong.CartesianData03V19.v1 ||| computedReach) = Mahjong.CartesianData03V19.v30 := by decide +kernel
end Mahjong.CartesianPNB09V19
#print axioms Mahjong.CartesianPNB09V19.provided_PN
