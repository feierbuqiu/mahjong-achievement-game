module
prelude
public import Mahjong.CartesianChannels04V19
import all Mahjong.CartesianChannels04V19
public import Mahjong.CartesianChannels08V19
import all Mahjong.CartesianChannels08V19
public import Mahjong.CartesianChannels09V19
import all Mahjong.CartesianChannels09V19
public import Mahjong.CartesianChannels10V19
import all Mahjong.CartesianChannels10V19
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
namespace Mahjong.CartesianBoolS02C03V19
namespace B06
noncomputable def axis0start : Nat := (((Mahjong.CartesianChannels08V19.channel61 8192 Mahjong.CartesianData02V19.v18) ||| (Mahjong.CartesianChannels08V19.channel62 8192 Mahjong.CartesianData02V19.v22)) ||| ((Mahjong.CartesianChannels08V19.channel63 8192 Mahjong.CartesianData02V19.v26) ||| (Mahjong.CartesianChannels08V19.channel64 8192 Mahjong.CartesianData02V19.v30)))
noncomputable def axis0stage0 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0start Mahjong.CartesianData01V19.v26 32768
noncomputable def axis0stage1 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage0 Mahjong.CartesianData02V19.v56 49152
noncomputable def axis0stage2 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage1 Mahjong.CartesianData01V19.v24 57344
noncomputable def axis0stage3 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage2 Mahjong.CartesianData01V19.v136 61440
noncomputable def axis0stage4 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage3 Mahjong.CartesianData01V19.v135 30720
noncomputable def axis0stage5 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage4 Mahjong.CartesianData01V19.v134 15360
noncomputable def axis0stage6 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage5 Mahjong.CartesianData01V19.v133 7680
noncomputable def axis0stage7 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage6 Mahjong.CartesianData01V19.v132 3840
noncomputable def axis0stage8 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage7 Mahjong.CartesianData01V19.v131 1920
noncomputable def axis0stage9 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage8 Mahjong.CartesianData01V19.v130 960
noncomputable def axis0stage10 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage9 Mahjong.CartesianData01V19.v129 480
noncomputable def axis0stage11 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage10 Mahjong.CartesianData02V19.v55 240
noncomputable def axis0stage12 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage11 Mahjong.CartesianData02V19.v54 120
noncomputable def axis0stage13 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage12 Mahjong.CartesianData02V19.v53 60
noncomputable def axis0stage14 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage13 Mahjong.CartesianData02V19.v52 30
noncomputable def axis0stage15 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage14 Mahjong.CartesianData02V19.v51 15
noncomputable def axis1start : Nat := (Mahjong.CartesianChannels09V19.channel65 2048 Mahjong.CartesianData02V19.v36)
noncomputable def axis1stage0 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1start Mahjong.CartesianData01V19.v26 32768
noncomputable def axis1stage1 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage0 Mahjong.CartesianData02V19.v56 49152
noncomputable def axis1stage2 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage1 Mahjong.CartesianData01V19.v24 57344
noncomputable def axis1stage3 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage2 Mahjong.CartesianData01V19.v136 61440
noncomputable def axis1stage4 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage3 Mahjong.CartesianData01V19.v22 63488
noncomputable def axis1stage5 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage4 Mahjong.CartesianData01V19.v66 64512
noncomputable def axis1stage6 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage5 Mahjong.CartesianData01V19.v65 32256
noncomputable def axis1stage7 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage6 Mahjong.CartesianData01V19.v64 16128
noncomputable def axis1stage8 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage7 Mahjong.CartesianData01V19.v63 8064
noncomputable def axis1stage9 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage8 Mahjong.CartesianData01V19.v62 4032
noncomputable def axis1stage10 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage9 Mahjong.CartesianData01V19.v61 2016
noncomputable def axis1stage11 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage10 Mahjong.CartesianData02V19.v57 1008
noncomputable def axis2start : Nat := ((Mahjong.CartesianChannels09V19.channel66 1024 Mahjong.CartesianData02V19.v40) ||| (Mahjong.CartesianChannels09V19.channel67 1024 Mahjong.CartesianData02V19.v44))
noncomputable def computedReach : Nat := ((axis0stage15 ||| axis1stage11) ||| (axis2start ||| Mahjong.CartesianData02V19.v48))
end B06

namespace B07
noncomputable def axis0start : Nat := ((Mahjong.CartesianChannels04V19.channel28 4096 Mahjong.CartesianData02V19.v63) ||| (Mahjong.CartesianChannels04V19.channel29 4096 Mahjong.CartesianData02V19.v67))
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
noncomputable def axis1start : Nat := 0
noncomputable def axis1stage0 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1start Mahjong.CartesianData01V19.v24 57344
noncomputable def axis1stage1 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage0 Mahjong.CartesianData01V19.v23 28672
noncomputable def axis1stage2 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage1 Mahjong.CartesianData02V19.v90 14336
noncomputable def axis1stage3 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage2 Mahjong.CartesianData02V19.v89 7168
noncomputable def axis1stage4 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage3 Mahjong.CartesianData02V19.v88 3584
noncomputable def axis1stage5 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage4 Mahjong.CartesianData02V19.v87 1792
noncomputable def axis1stage6 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage5 Mahjong.CartesianData02V19.v86 896
noncomputable def axis1stage7 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage6 Mahjong.CartesianData02V19.v85 448
noncomputable def axis1stage8 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage7 Mahjong.CartesianData02V19.v84 224
noncomputable def axis2start : Nat := ((Mahjong.CartesianChannels09V19.channel68 256 Mahjong.CartesianData02V19.v73) ||| (Mahjong.CartesianChannels10V19.channel69 256 Mahjong.CartesianData02V19.v77))
noncomputable def computedReach : Nat := ((axis0stage15 ||| axis1stage8) ||| (axis2start ||| Mahjong.CartesianData02V19.v81))
end B07
noncomputable def checks : Bool := ((((Mahjong.CartesianData02V19.v16 &&& B06.computedReach) == 0) && ((Mahjong.CartesianData02V19.v16 ||| B06.computedReach) == Mahjong.CartesianData02V19.v49)) && (((Mahjong.CartesianData02V19.v61 &&& B07.computedReach) == 0) && ((Mahjong.CartesianData02V19.v61 ||| B07.computedReach) == Mahjong.CartesianData02V19.v82)))
theorem accepted : checks = true := by exact Eq.refl true
end Mahjong.CartesianBoolS02C03V19
#print axioms Mahjong.CartesianBoolS02C03V19.accepted
