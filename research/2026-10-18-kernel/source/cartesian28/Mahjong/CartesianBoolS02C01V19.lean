module
prelude
public import Mahjong.CartesianChannels00V19
import all Mahjong.CartesianChannels00V19
public import Mahjong.CartesianChannels04V19
import all Mahjong.CartesianChannels04V19
public import Mahjong.CartesianChannels05V19
import all Mahjong.CartesianChannels05V19
public import Mahjong.CartesianData00V19
import all Mahjong.CartesianData00V19
public import Mahjong.CartesianData01V19
import all Mahjong.CartesianData01V19
public import Mahjong.CartesianMathV19
import all Mahjong.CartesianMathV19
public section
set_option autoImplicit false
set_option exponentiation.threshold 16777216
set_option maxRecDepth 65536
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
namespace Mahjong.CartesianBoolS02C01V19
namespace B02
noncomputable def axis0start : Nat := (((Mahjong.CartesianChannels04V19.channel21 4096 Mahjong.CartesianData00V19.v158) ||| ((Mahjong.CartesianChannels04V19.channel22 4096 Mahjong.CartesianData00V19.v162) ||| (Mahjong.CartesianChannels04V19.channel23 4096 Mahjong.CartesianData00V19.v166))) ||| (((Mahjong.CartesianChannels04V19.channel24 4096 Mahjong.CartesianData00V19.v170) ||| (Mahjong.CartesianChannels04V19.channel25 4096 Mahjong.CartesianData00V19.v174)) ||| ((Mahjong.CartesianChannels04V19.channel26 4096 Mahjong.CartesianData00V19.v178) ||| (Mahjong.CartesianChannels04V19.channel27 4096 Mahjong.CartesianData00V19.v182))))
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
noncomputable def axis1start : Nat := ((((Mahjong.CartesianChannels04V19.channel28 4096 Mahjong.CartesianData00V19.v186) ||| (Mahjong.CartesianChannels04V19.channel29 4096 Mahjong.CartesianData00V19.v190)) ||| ((Mahjong.CartesianChannels04V19.channel30 4096 Mahjong.CartesianData00V19.v194) ||| ((Mahjong.CartesianChannels04V19.channel31 4096 Mahjong.CartesianData00V19.v198) ||| (Mahjong.CartesianChannels04V19.channel32 4096 Mahjong.CartesianData00V19.v202)))) ||| (((Mahjong.CartesianChannels04V19.channel33 4096 Mahjong.CartesianData00V19.v206) ||| (Mahjong.CartesianChannels04V19.channel34 4096 Mahjong.CartesianData00V19.v210)) ||| ((Mahjong.CartesianChannels04V19.channel35 4096 Mahjong.CartesianData00V19.v214) ||| ((Mahjong.CartesianChannels04V19.channel36 4096 Mahjong.CartesianData00V19.v218) ||| (Mahjong.CartesianChannels04V19.channel37 4096 Mahjong.CartesianData00V19.v222)))))
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
noncomputable def axis2start : Nat := ((Mahjong.CartesianChannels00V19.channel7 1024 Mahjong.CartesianData00V19.v227) ||| ((Mahjong.CartesianChannels05V19.channel38 1024 Mahjong.CartesianData01V19.v0) ||| (Mahjong.CartesianChannels05V19.channel39 1024 Mahjong.CartesianData01V19.v4)))
noncomputable def computedReach : Nat := ((axis0stage15 ||| axis1stage10) ||| (axis2start ||| Mahjong.CartesianData01V19.v8))
end B02

namespace B03
noncomputable def axis0start : Nat := (Mahjong.CartesianChannels05V19.channel40 4096 Mahjong.CartesianData01V19.v34)
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
noncomputable def axis1start : Nat := ((Mahjong.CartesianChannels05V19.channel41 2048 Mahjong.CartesianData01V19.v38) ||| (Mahjong.CartesianChannels05V19.channel42 2048 Mahjong.CartesianData01V19.v42))
noncomputable def axis1stage0 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1start Mahjong.CartesianData01V19.v66 64512
noncomputable def axis1stage1 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage0 Mahjong.CartesianData01V19.v65 32256
noncomputable def axis1stage2 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage1 Mahjong.CartesianData01V19.v64 16128
noncomputable def axis1stage3 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage2 Mahjong.CartesianData01V19.v63 8064
noncomputable def axis1stage4 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage3 Mahjong.CartesianData01V19.v62 4032
noncomputable def axis1stage5 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage4 Mahjong.CartesianData01V19.v61 2016
noncomputable def axis2start : Nat := ((Mahjong.CartesianChannels05V19.channel43 2048 Mahjong.CartesianData01V19.v46) ||| ((Mahjong.CartesianChannels05V19.channel44 2048 Mahjong.CartesianData01V19.v50) ||| (Mahjong.CartesianChannels05V19.channel45 2048 Mahjong.CartesianData01V19.v54)))
noncomputable def computedReach : Nat := ((axis0stage15 ||| axis1stage5) ||| (axis2start ||| Mahjong.CartesianData01V19.v58))
end B03
noncomputable def checks : Bool := ((((Mahjong.CartesianData00V19.v155 &&& B02.computedReach) == 0) && ((Mahjong.CartesianData00V19.v155 ||| B02.computedReach) == Mahjong.CartesianData01V19.v9)) && (((Mahjong.CartesianData01V19.v30 &&& B03.computedReach) == 0) && ((Mahjong.CartesianData01V19.v30 ||| B03.computedReach) == Mahjong.CartesianData01V19.v59)))
theorem accepted : checks = true := by exact Eq.refl true
end Mahjong.CartesianBoolS02C01V19
#print axioms Mahjong.CartesianBoolS02C01V19.accepted
