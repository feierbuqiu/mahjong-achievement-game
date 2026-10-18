module
prelude
public import Mahjong.CartesianChannels04V19
import all Mahjong.CartesianChannels04V19
public import Mahjong.CartesianChannels10V19
import all Mahjong.CartesianChannels10V19
public import Mahjong.CartesianChannels15V19
import all Mahjong.CartesianChannels15V19
public import Mahjong.CartesianChannels16V19
import all Mahjong.CartesianChannels16V19
public import Mahjong.CartesianData01V19
import all Mahjong.CartesianData01V19
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
namespace Mahjong.CartesianBoolS01C15V19
namespace B15
noncomputable def axis0start : Nat := (((Mahjong.CartesianChannels04V19.channel21 4096 Mahjong.CartesianData04V19.v16) ||| ((Mahjong.CartesianChannels04V19.channel22 4096 Mahjong.CartesianData04V19.v21) ||| (Mahjong.CartesianChannels04V19.channel23 4096 Mahjong.CartesianData04V19.v25))) ||| (((Mahjong.CartesianChannels04V19.channel24 4096 Mahjong.CartesianData04V19.v29) ||| (Mahjong.CartesianChannels04V19.channel25 4096 Mahjong.CartesianData04V19.v33)) ||| ((Mahjong.CartesianChannels04V19.channel26 4096 Mahjong.CartesianData04V19.v37) ||| (Mahjong.CartesianChannels04V19.channel27 4096 Mahjong.CartesianData04V19.v41))))
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
noncomputable def axis1start : Nat := ((((Mahjong.CartesianChannels10V19.channel70 4096 Mahjong.CartesianData04V19.v45) ||| (Mahjong.CartesianChannels10V19.channel71 4096 Mahjong.CartesianData04V19.v49)) ||| ((Mahjong.CartesianChannels10V19.channel72 4096 Mahjong.CartesianData04V19.v53) ||| (Mahjong.CartesianChannels10V19.channel73 4096 Mahjong.CartesianData04V19.v57))) ||| (((Mahjong.CartesianChannels10V19.channel74 4096 Mahjong.CartesianData04V19.v61) ||| (Mahjong.CartesianChannels10V19.channel75 4096 Mahjong.CartesianData04V19.v65)) ||| ((Mahjong.CartesianChannels10V19.channel76 4096 Mahjong.CartesianData04V19.v69) ||| ((Mahjong.CartesianChannels10V19.channel77 4096 Mahjong.CartesianData04V19.v73) ||| (Mahjong.CartesianChannels10V19.channel78 4096 Mahjong.CartesianData04V19.v77)))))
noncomputable def axis1stage0 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1start Mahjong.CartesianData01V19.v26 32768
noncomputable def axis1stage1 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage0 Mahjong.CartesianData01V19.v25 16384
noncomputable def axis1stage2 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage1 Mahjong.CartesianData01V19.v24 57344
noncomputable def axis1stage3 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage2 Mahjong.CartesianData01V19.v23 28672
noncomputable def axis1stage4 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage3 Mahjong.CartesianData01V19.v22 63488
noncomputable def axis1stage5 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage4 Mahjong.CartesianData01V19.v21 31744
noncomputable def axis1stage6 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage5 Mahjong.CartesianData01V19.v20 15872
noncomputable def axis1stage7 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage6 Mahjong.CartesianData01V19.v19 7936
noncomputable def axis1stage8 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage7 Mahjong.CartesianData01V19.v18 3968
noncomputable def axis1stage9 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage8 Mahjong.CartesianData01V19.v17 1984
noncomputable def axis1stage10 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage9 Mahjong.CartesianData01V19.v16 992
noncomputable def axis2start : Nat := (((Mahjong.CartesianChannels15V19.channel157 1024 Mahjong.CartesianData04V19.v82) ||| (Mahjong.CartesianChannels16V19.channel158 1024 Mahjong.CartesianData04V19.v86)) ||| ((Mahjong.CartesianChannels16V19.channel159 1024 Mahjong.CartesianData04V19.v90) ||| ((Mahjong.CartesianChannels16V19.channel160 1024 Mahjong.CartesianData04V19.v94) ||| (Mahjong.CartesianChannels16V19.channel161 1024 Mahjong.CartesianData04V19.v98))))
noncomputable def computedReach : Nat := ((axis0stage15 ||| axis1stage10) ||| (axis2start ||| (Mahjong.CartesianData04V19.v102 ||| Mahjong.CartesianData04V19.v106)))
end B15
noncomputable def checks : Bool := (((Mahjong.CartesianData04V19.v14 &&& B15.computedReach) == 0) && ((Mahjong.CartesianData04V19.v14 ||| B15.computedReach) == Mahjong.CartesianData04V19.v107))
theorem accepted : checks = true := by exact Eq.refl true
end Mahjong.CartesianBoolS01C15V19
#print axioms Mahjong.CartesianBoolS01C15V19.accepted
