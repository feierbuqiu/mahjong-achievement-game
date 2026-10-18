module
prelude
public import Mahjong.CartesianChannels15V19
import all Mahjong.CartesianChannels15V19
public import Mahjong.CartesianChannels20V19
import all Mahjong.CartesianChannels20V19
public import Mahjong.CartesianChannels22V19
import all Mahjong.CartesianChannels22V19
public import Mahjong.CartesianChannels23V19
import all Mahjong.CartesianChannels23V19
public import Mahjong.CartesianChannels24V19
import all Mahjong.CartesianChannels24V19
public import Mahjong.CartesianData01V19
import all Mahjong.CartesianData01V19
public import Mahjong.CartesianData02V19
import all Mahjong.CartesianData02V19
public import Mahjong.CartesianData04V19
import all Mahjong.CartesianData04V19
public import Mahjong.CartesianData06V19
import all Mahjong.CartesianData06V19
public import Mahjong.CartesianData07V19
import all Mahjong.CartesianData07V19
public import Mahjong.CartesianData08V19
import all Mahjong.CartesianData08V19
public import Mahjong.CartesianMathV19
import all Mahjong.CartesianMathV19
public section
set_option autoImplicit false
set_option exponentiation.threshold 16777216
set_option maxRecDepth 65536
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
namespace Mahjong.CartesianBoolS02C12V19
namespace B24
noncomputable def axis0start : Nat := ((((Mahjong.CartesianChannels22V19.channel215 4096 Mahjong.CartesianData07V19.v57) ||| (Mahjong.CartesianChannels22V19.channel216 4096 Mahjong.CartesianData07V19.v61)) ||| ((Mahjong.CartesianChannels22V19.channel217 4096 Mahjong.CartesianData07V19.v65) ||| (Mahjong.CartesianChannels22V19.channel218 4096 Mahjong.CartesianData07V19.v69))) ||| (((Mahjong.CartesianChannels22V19.channel219 4096 Mahjong.CartesianData07V19.v73) ||| (Mahjong.CartesianChannels22V19.channel220 4096 Mahjong.CartesianData07V19.v77)) ||| ((Mahjong.CartesianChannels22V19.channel221 4096 Mahjong.CartesianData07V19.v81) ||| (Mahjong.CartesianChannels22V19.channel222 4096 Mahjong.CartesianData07V19.v85))))
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
noncomputable def axis1start : Nat := ((Mahjong.CartesianChannels22V19.channel223 16384 Mahjong.CartesianData07V19.v90) ||| (Mahjong.CartesianChannels22V19.channel224 16384 Mahjong.CartesianData07V19.v94))
noncomputable def axis1stage0 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1start Mahjong.CartesianData01V19.v24 57344
noncomputable def axis1stage1 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage0 Mahjong.CartesianData01V19.v23 28672
noncomputable def axis1stage2 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage1 Mahjong.CartesianData02V19.v90 14336
noncomputable def axis1stage3 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage2 Mahjong.CartesianData02V19.v89 7168
noncomputable def axis1stage4 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage3 Mahjong.CartesianData02V19.v88 3584
noncomputable def axis1stage5 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage4 Mahjong.CartesianData02V19.v87 1792
noncomputable def axis1stage6 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage5 Mahjong.CartesianData02V19.v86 896
noncomputable def axis1stage7 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage6 Mahjong.CartesianData02V19.v85 448
noncomputable def axis1stage8 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage7 Mahjong.CartesianData02V19.v84 224
noncomputable def axis2start : Nat := (((Mahjong.CartesianChannels20V19.channel180 256 Mahjong.CartesianData07V19.v99) ||| ((Mahjong.CartesianChannels20V19.channel181 256 Mahjong.CartesianData07V19.v103) ||| (Mahjong.CartesianChannels23V19.channel225 256 Mahjong.CartesianData07V19.v107))) ||| ((Mahjong.CartesianChannels23V19.channel226 256 Mahjong.CartesianData07V19.v111) ||| ((Mahjong.CartesianChannels23V19.channel227 256 Mahjong.CartesianData07V19.v115) ||| (Mahjong.CartesianChannels23V19.channel228 256 Mahjong.CartesianData07V19.v119))))
noncomputable def computedReach : Nat := ((axis0stage15 ||| axis1stage8) ||| (axis2start ||| Mahjong.CartesianData07V19.v123))
end B24

namespace B25
noncomputable def axis0start : Nat := ((Mahjong.CartesianChannels24V19.channel229 2048 Mahjong.CartesianData07V19.v131) ||| (Mahjong.CartesianChannels24V19.channel230 2048 Mahjong.CartesianData08V19.v2))
noncomputable def axis0stage0 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0start Mahjong.CartesianData01V19.v26 32768
noncomputable def axis0stage1 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage0 Mahjong.CartesianData01V19.v25 16384
noncomputable def axis0stage2 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage1 Mahjong.CartesianData04V19.v165 8192
noncomputable def axis0stage3 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage2 Mahjong.CartesianData04V19.v164 4096
noncomputable def axis0stage4 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage3 Mahjong.CartesianData06V19.v28 2048
noncomputable def axis0stage5 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage4 Mahjong.CartesianData01V19.v66 64512
noncomputable def axis0stage6 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage5 Mahjong.CartesianData01V19.v65 32256
noncomputable def axis0stage7 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage6 Mahjong.CartesianData01V19.v64 16128
noncomputable def axis0stage8 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage7 Mahjong.CartesianData01V19.v63 8064
noncomputable def axis0stage9 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage8 Mahjong.CartesianData01V19.v62 4032
noncomputable def axis0stage10 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage9 Mahjong.CartesianData01V19.v61 2016
noncomputable def axis0stage11 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage10 Mahjong.CartesianData02V19.v57 1008
noncomputable def axis0stage12 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage11 Mahjong.CartesianData07V19.v51 504
noncomputable def axis0stage13 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage12 Mahjong.CartesianData07V19.v50 252
noncomputable def axis0stage14 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage13 Mahjong.CartesianData07V19.v49 126
noncomputable def axis0stage15 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage14 Mahjong.CartesianData07V19.v48 63
noncomputable def axis1start : Nat := ((Mahjong.CartesianChannels24V19.channel231 8192 Mahjong.CartesianData08V19.v8) ||| ((Mahjong.CartesianChannels24V19.channel232 8192 Mahjong.CartesianData08V19.v12) ||| (Mahjong.CartesianChannels24V19.channel233 8192 Mahjong.CartesianData08V19.v16)))
noncomputable def axis1stage0 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1start Mahjong.CartesianData01V19.v26 32768
noncomputable def axis1stage1 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage0 Mahjong.CartesianData01V19.v25 16384
noncomputable def axis1stage2 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage1 Mahjong.CartesianData04V19.v165 8192
noncomputable def axis1stage3 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage2 Mahjong.CartesianData01V19.v136 61440
noncomputable def axis1stage4 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage3 Mahjong.CartesianData01V19.v135 30720
noncomputable def axis1stage5 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage4 Mahjong.CartesianData01V19.v134 15360
noncomputable def axis1stage6 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage5 Mahjong.CartesianData01V19.v133 7680
noncomputable def axis1stage7 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage6 Mahjong.CartesianData01V19.v132 3840
noncomputable def axis1stage8 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage7 Mahjong.CartesianData01V19.v131 1920
noncomputable def axis1stage9 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage8 Mahjong.CartesianData01V19.v130 960
noncomputable def axis2start : Nat := (Mahjong.CartesianChannels15V19.channel157 1024 Mahjong.CartesianData08V19.v20)
noncomputable def computedReach : Nat := ((axis0stage15 ||| axis1stage9) ||| (axis2start ||| Mahjong.CartesianData08V19.v24))
end B25
noncomputable def checks : Bool := ((((Mahjong.CartesianData07V19.v55 &&& B24.computedReach) == 0) && ((Mahjong.CartesianData07V19.v55 ||| B24.computedReach) == Mahjong.CartesianData07V19.v124)) && (((Mahjong.CartesianData07V19.v129 &&& B25.computedReach) == 0) && ((Mahjong.CartesianData07V19.v129 ||| B25.computedReach) == Mahjong.CartesianData08V19.v25)))
theorem accepted : checks = true := by exact Eq.refl true
end Mahjong.CartesianBoolS02C12V19
#print axioms Mahjong.CartesianBoolS02C12V19.accepted
