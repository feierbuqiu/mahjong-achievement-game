module
prelude
public import Mahjong.CartesianChannels05V19
import all Mahjong.CartesianChannels05V19
public import Mahjong.CartesianChannels09V19
import all Mahjong.CartesianChannels09V19
public import Mahjong.CartesianChannels11V19
import all Mahjong.CartesianChannels11V19
public import Mahjong.CartesianChannels12V19
import all Mahjong.CartesianChannels12V19
public import Mahjong.CartesianChannels21V19
import all Mahjong.CartesianChannels21V19
public import Mahjong.CartesianChannels22V19
import all Mahjong.CartesianChannels22V19
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
public import Mahjong.CartesianMathV19
import all Mahjong.CartesianMathV19
public section
set_option autoImplicit false
set_option exponentiation.threshold 16777216
set_option maxRecDepth 65536
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
namespace Mahjong.CartesianBoolS02C11V19
namespace B22
noncomputable def axis0start : Nat := ((Mahjong.CartesianChannels05V19.channel46 8192 Mahjong.CartesianData06V19.v99) ||| (Mahjong.CartesianChannels05V19.channel47 8192 Mahjong.CartesianData06V19.v103))
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
noncomputable def axis1start : Nat := ((Mahjong.CartesianChannels21V19.channel207 8192 Mahjong.CartesianData06V19.v107) ||| (Mahjong.CartesianChannels21V19.channel208 8192 Mahjong.CartesianData06V19.v111))
noncomputable def axis1stage0 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1start Mahjong.CartesianData01V19.v26 32768
noncomputable def axis1stage1 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage0 Mahjong.CartesianData02V19.v56 49152
noncomputable def axis1stage2 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage1 Mahjong.CartesianData01V19.v24 57344
noncomputable def axis1stage3 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage2 Mahjong.CartesianData01V19.v136 61440
noncomputable def axis1stage4 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage3 Mahjong.CartesianData01V19.v135 30720
noncomputable def axis1stage5 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage4 Mahjong.CartesianData01V19.v134 15360
noncomputable def axis1stage6 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage5 Mahjong.CartesianData01V19.v133 7680
noncomputable def axis1stage7 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage6 Mahjong.CartesianData01V19.v132 3840
noncomputable def axis1stage8 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage7 Mahjong.CartesianData01V19.v131 1920
noncomputable def axis1stage9 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage8 Mahjong.CartesianData01V19.v130 960
noncomputable def axis1stage10 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage9 Mahjong.CartesianData01V19.v129 480
noncomputable def axis1stage11 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage10 Mahjong.CartesianData02V19.v55 240
noncomputable def axis2start : Nat := ((Mahjong.CartesianChannels09V19.channel68 256 Mahjong.CartesianData06V19.v116) ||| (Mahjong.CartesianChannels21V19.channel209 256 Mahjong.CartesianData06V19.v120))
noncomputable def computedReach : Nat := ((axis0stage15 ||| axis1stage11) ||| (axis2start ||| Mahjong.CartesianData06V19.v124))
end B22

namespace B23
noncomputable def axis0start : Nat := (((Mahjong.CartesianChannels11V19.channel100 2048 Mahjong.CartesianData07V19.v3) ||| (Mahjong.CartesianChannels11V19.channel101 2048 Mahjong.CartesianData07V19.v7)) ||| ((Mahjong.CartesianChannels12V19.channel104 2048 Mahjong.CartesianData07V19.v11) ||| (Mahjong.CartesianChannels12V19.channel105 2048 Mahjong.CartesianData07V19.v15)))
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
noncomputable def axis1start : Nat := ((Mahjong.CartesianChannels21V19.channel210 1024 Mahjong.CartesianData07V19.v21) ||| ((Mahjong.CartesianChannels22V19.channel211 1024 Mahjong.CartesianData07V19.v25) ||| (Mahjong.CartesianChannels22V19.channel212 1024 Mahjong.CartesianData07V19.v29)))
noncomputable def axis1stage0 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1start Mahjong.CartesianData01V19.v26 32768
noncomputable def axis1stage1 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage0 Mahjong.CartesianData02V19.v56 49152
noncomputable def axis1stage2 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage1 Mahjong.CartesianData01V19.v24 57344
noncomputable def axis1stage3 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage2 Mahjong.CartesianData01V19.v23 28672
noncomputable def axis1stage4 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage3 Mahjong.CartesianData02V19.v90 14336
noncomputable def axis1stage5 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage4 Mahjong.CartesianData02V19.v89 7168
noncomputable def axis1stage6 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage5 Mahjong.CartesianData06V19.v26 65024
noncomputable def axis1stage7 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage6 Mahjong.CartesianData06V19.v25 32512
noncomputable def axis1stage8 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage7 Mahjong.CartesianData06V19.v24 16256
noncomputable def axis1stage9 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage8 Mahjong.CartesianData06V19.v23 8128
noncomputable def axis2start : Nat := ((Mahjong.CartesianChannels22V19.channel213 8192 Mahjong.CartesianData07V19.v33) ||| (Mahjong.CartesianChannels22V19.channel214 8192 Mahjong.CartesianData07V19.v37))
noncomputable def computedReach : Nat := ((axis0stage15 ||| axis1stage9) ||| (axis2start ||| (Mahjong.CartesianData07V19.v41 ||| Mahjong.CartesianData07V19.v45)))
end B23
noncomputable def checks : Bool := ((((Mahjong.CartesianData06V19.v96 &&& B22.computedReach) == 0) && ((Mahjong.CartesianData06V19.v96 ||| B22.computedReach) == Mahjong.CartesianData06V19.v125)) && (((Mahjong.CartesianData07V19.v1 &&& B23.computedReach) == 0) && ((Mahjong.CartesianData07V19.v1 ||| B23.computedReach) == Mahjong.CartesianData07V19.v46)))
theorem accepted : checks = true := by exact Eq.refl true
end Mahjong.CartesianBoolS02C11V19
#print axioms Mahjong.CartesianBoolS02C11V19.accepted
