module
prelude
public import Mahjong.CartesianChannels11V19
import all Mahjong.CartesianChannels11V19
public import Mahjong.CartesianChannels12V19
import all Mahjong.CartesianChannels12V19
public import Mahjong.CartesianChannels26V19
import all Mahjong.CartesianChannels26V19
public import Mahjong.CartesianChannels27V19
import all Mahjong.CartesianChannels27V19
public import Mahjong.CartesianChannels28V19
import all Mahjong.CartesianChannels28V19
public import Mahjong.CartesianChannels29V19
import all Mahjong.CartesianChannels29V19
public import Mahjong.CartesianChannels30V19
import all Mahjong.CartesianChannels30V19
public import Mahjong.CartesianChannels31V19
import all Mahjong.CartesianChannels31V19
public import Mahjong.CartesianChannels32V19
import all Mahjong.CartesianChannels32V19
public import Mahjong.CartesianChannels33V19
import all Mahjong.CartesianChannels33V19
public import Mahjong.CartesianData00V19
import all Mahjong.CartesianData00V19
public import Mahjong.CartesianData08V19
import all Mahjong.CartesianData08V19
public import Mahjong.CartesianMathV19
import all Mahjong.CartesianMathV19
public section
set_option autoImplicit false
set_option maxRecDepth 131072
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
namespace Mahjong.CartesianPNB27V19
noncomputable def axis0start : Nat := ((Mahjong.CartesianChannels26V19.channel248 32768 Mahjong.CartesianData08V19.v102) ||| ((Mahjong.CartesianChannels26V19.channel249 32768 Mahjong.CartesianData08V19.v106) ||| (Mahjong.CartesianChannels26V19.channel250 32768 Mahjong.CartesianData08V19.v110)))
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
noncomputable def axis1start : Nat := (((Mahjong.CartesianChannels11V19.channel100 1024 Mahjong.CartesianData08V19.v115) ||| (Mahjong.CartesianChannels11V19.channel101 1024 Mahjong.CartesianData08V19.v119)) ||| ((Mahjong.CartesianChannels12V19.channel104 1024 Mahjong.CartesianData08V19.v123) ||| (Mahjong.CartesianChannels12V19.channel105 1024 Mahjong.CartesianData08V19.v127)))
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
noncomputable def axis2start : Nat := ((((Mahjong.CartesianChannels27V19.channel251 128 Mahjong.CartesianData08V19.v132) ||| ((Mahjong.CartesianChannels28V19.channel252 128 Mahjong.CartesianData08V19.v136) ||| (Mahjong.CartesianChannels28V19.channel253 128 Mahjong.CartesianData08V19.v140))) ||| (((Mahjong.CartesianChannels29V19.channel254 128 Mahjong.CartesianData08V19.v144) ||| (Mahjong.CartesianChannels29V19.channel255 128 Mahjong.CartesianData08V19.v148)) ||| ((Mahjong.CartesianChannels30V19.channel256 128 Mahjong.CartesianData08V19.v152) ||| (Mahjong.CartesianChannels31V19.channel257 128 Mahjong.CartesianData08V19.v156)))) ||| (((Mahjong.CartesianChannels32V19.channel258 128 Mahjong.CartesianData08V19.v160) ||| ((Mahjong.CartesianChannels32V19.channel259 128 Mahjong.CartesianData08V19.v164) ||| (Mahjong.CartesianChannels32V19.channel260 128 Mahjong.CartesianData08V19.v168))) ||| (((Mahjong.CartesianChannels32V19.channel261 128 Mahjong.CartesianData08V19.v172) ||| (Mahjong.CartesianChannels33V19.channel262 128 Mahjong.CartesianData08V19.v176)) ||| ((Mahjong.CartesianChannels33V19.channel263 128 Mahjong.CartesianData08V19.v180) ||| (Mahjong.CartesianChannels33V19.channel264 128 Mahjong.CartesianData08V19.v184)))))
noncomputable def computedReach : Nat := ((axis0stage14 ||| axis1stage11) ||| (axis2start ||| (Mahjong.CartesianData08V19.v188 ||| Mahjong.CartesianData08V19.v192)))
theorem provided_PN :
    computedReach = Mahjong.CartesianData08V19.v194 ∧
    (Mahjong.CartesianData08V19.v100 &&& computedReach) = 0 ∧
    (Mahjong.CartesianData08V19.v100 ||| computedReach) = Mahjong.CartesianData08V19.v193 := by decide +kernel
end Mahjong.CartesianPNB27V19
#print axioms Mahjong.CartesianPNB27V19.provided_PN
