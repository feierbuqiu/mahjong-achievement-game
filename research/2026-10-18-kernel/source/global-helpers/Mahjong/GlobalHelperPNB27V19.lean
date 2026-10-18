module
prelude
public import Mahjong.GlobalHelperChannel100V19
import all Mahjong.GlobalHelperChannel100V19
public import Mahjong.GlobalHelperChannel101V19
import all Mahjong.GlobalHelperChannel101V19
public import Mahjong.GlobalHelperChannel104V19
import all Mahjong.GlobalHelperChannel104V19
public import Mahjong.GlobalHelperChannel105V19
import all Mahjong.GlobalHelperChannel105V19
public import Mahjong.GlobalHelperChannel248V19
import all Mahjong.GlobalHelperChannel248V19
public import Mahjong.GlobalHelperChannel249V19
import all Mahjong.GlobalHelperChannel249V19
public import Mahjong.GlobalHelperChannel250V19
import all Mahjong.GlobalHelperChannel250V19
public import Mahjong.GlobalHelperChannel251V19
import all Mahjong.GlobalHelperChannel251V19
public import Mahjong.GlobalHelperChannel252V19
import all Mahjong.GlobalHelperChannel252V19
public import Mahjong.GlobalHelperChannel253V19
import all Mahjong.GlobalHelperChannel253V19
public import Mahjong.GlobalHelperChannel254V19
import all Mahjong.GlobalHelperChannel254V19
public import Mahjong.GlobalHelperChannel255V19
import all Mahjong.GlobalHelperChannel255V19
public import Mahjong.GlobalHelperChannel256V19
import all Mahjong.GlobalHelperChannel256V19
public import Mahjong.GlobalHelperChannel257V19
import all Mahjong.GlobalHelperChannel257V19
public import Mahjong.GlobalHelperChannel258V19
import all Mahjong.GlobalHelperChannel258V19
public import Mahjong.GlobalHelperChannel259V19
import all Mahjong.GlobalHelperChannel259V19
public import Mahjong.GlobalHelperChannel260V19
import all Mahjong.GlobalHelperChannel260V19
public import Mahjong.GlobalHelperChannel261V19
import all Mahjong.GlobalHelperChannel261V19
public import Mahjong.GlobalHelperChannel262V19
import all Mahjong.GlobalHelperChannel262V19
public import Mahjong.GlobalHelperChannel263V19
import all Mahjong.GlobalHelperChannel263V19
public import Mahjong.GlobalHelperChannel264V19
import all Mahjong.GlobalHelperChannel264V19
public import Mahjong.CartesianData00V19
import all Mahjong.CartesianData00V19
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
namespace Mahjong.GlobalHelperPNB27V19
namespace B27
noncomputable def axis0start : Nat := ((Mahjong.GlobalHelperChannel248V19.channel 32768 Mahjong.CartesianData08V19.v102) ||| ((Mahjong.GlobalHelperChannel249V19.channel 32768 Mahjong.CartesianData08V19.v106) ||| (Mahjong.GlobalHelperChannel250V19.channel 32768 Mahjong.CartesianData08V19.v110)))
noncomputable def axis0stage0 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0start Mahjong.CartesianData00V19.v56 16384
noncomputable def axis0stage1 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage0 Mahjong.CartesianData00V19.v151 8192
noncomputable def axis0stage2 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage1 Mahjong.CartesianData00V19.v150 4096
noncomputable def axis0stage3 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage2 Mahjong.CartesianData00V19.v149 2048
noncomputable def axis0stage4 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage3 Mahjong.CartesianData08V19.v205 1024
noncomputable def axis0stage5 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage4 Mahjong.CartesianData08V19.v204 512
noncomputable def axis0stage6 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage5 Mahjong.CartesianData08V19.v203 256
noncomputable def axis0stage7 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage6 Mahjong.CartesianData08V19.v202 128
noncomputable def axis0stage8 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage7 Mahjong.CartesianData08V19.v201 64
noncomputable def axis0stage9 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage8 Mahjong.CartesianData08V19.v200 32
noncomputable def axis0stage10 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage9 Mahjong.CartesianData08V19.v199 16
noncomputable def axis0stage11 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage10 Mahjong.CartesianData08V19.v198 8
noncomputable def axis0stage12 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage11 Mahjong.CartesianData08V19.v197 4
noncomputable def axis0stage13 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage12 Mahjong.CartesianData08V19.v196 2
noncomputable def axis0stage14 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage13 Mahjong.CartesianData08V19.v195 1
noncomputable def axis1start : Nat := (((Mahjong.GlobalHelperChannel100V19.channel 1024 Mahjong.CartesianData08V19.v115) ||| (Mahjong.GlobalHelperChannel101V19.channel 1024 Mahjong.CartesianData08V19.v119)) ||| ((Mahjong.GlobalHelperChannel104V19.channel 1024 Mahjong.CartesianData08V19.v123) ||| (Mahjong.GlobalHelperChannel105V19.channel 1024 Mahjong.CartesianData08V19.v127)))
noncomputable def axis1stage0 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1start Mahjong.CartesianData00V19.v54 28672
noncomputable def axis1stage1 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage0 Mahjong.CartesianData00V19.v53 14336
noncomputable def axis1stage2 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage1 Mahjong.CartesianData00V19.v52 7168
noncomputable def axis1stage3 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage2 Mahjong.CartesianData00V19.v63 32256
noncomputable def axis1stage4 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage3 Mahjong.CartesianData00V19.v62 16128
noncomputable def axis1stage5 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage4 Mahjong.CartesianData00V19.v61 8064
noncomputable def axis1stage6 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage5 Mahjong.CartesianData00V19.v60 4032
noncomputable def axis1stage7 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage6 Mahjong.CartesianData00V19.v59 2016
noncomputable def axis1stage8 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage7 Mahjong.CartesianData00V19.v58 1008
noncomputable def axis1stage9 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage8 Mahjong.CartesianData00V19.v57 504
noncomputable def axis1stage10 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage9 Mahjong.CartesianData08V19.v207 252
noncomputable def axis1stage11 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage10 Mahjong.CartesianData08V19.v206 126
noncomputable def axis2start : Nat := ((((Mahjong.GlobalHelperChannel251V19.channel 128 Mahjong.CartesianData08V19.v132) ||| ((Mahjong.GlobalHelperChannel252V19.channel 128 Mahjong.CartesianData08V19.v136) ||| (Mahjong.GlobalHelperChannel253V19.channel 128 Mahjong.CartesianData08V19.v140))) ||| (((Mahjong.GlobalHelperChannel254V19.channel 128 Mahjong.CartesianData08V19.v144) ||| (Mahjong.GlobalHelperChannel255V19.channel 128 Mahjong.CartesianData08V19.v148)) ||| ((Mahjong.GlobalHelperChannel256V19.channel 128 Mahjong.CartesianData08V19.v152) ||| (Mahjong.GlobalHelperChannel257V19.channel 128 Mahjong.CartesianData08V19.v156)))) ||| (((Mahjong.GlobalHelperChannel258V19.channel 128 Mahjong.CartesianData08V19.v160) ||| ((Mahjong.GlobalHelperChannel259V19.channel 128 Mahjong.CartesianData08V19.v164) ||| (Mahjong.GlobalHelperChannel260V19.channel 128 Mahjong.CartesianData08V19.v168))) ||| (((Mahjong.GlobalHelperChannel261V19.channel 128 Mahjong.CartesianData08V19.v172) ||| (Mahjong.GlobalHelperChannel262V19.channel 128 Mahjong.CartesianData08V19.v176)) ||| ((Mahjong.GlobalHelperChannel263V19.channel 128 Mahjong.CartesianData08V19.v180) ||| (Mahjong.GlobalHelperChannel264V19.channel 128 Mahjong.CartesianData08V19.v184)))))
noncomputable def computedReach : Nat := ((axis0stage14 ||| axis1stage11) ||| (axis2start ||| (Mahjong.CartesianData08V19.v188 ||| Mahjong.CartesianData08V19.v192)))
end B27
noncomputable def checks : Bool := (((Mahjong.CartesianData08V19.v100 &&& B27.computedReach) == 0) && ((Mahjong.CartesianData08V19.v100 ||| B27.computedReach) == Mahjong.CartesianData08V19.v193))
theorem accepted : checks = true := by exact Eq.refl true
end Mahjong.GlobalHelperPNB27V19
#print axioms Mahjong.GlobalHelperPNB27V19.accepted
