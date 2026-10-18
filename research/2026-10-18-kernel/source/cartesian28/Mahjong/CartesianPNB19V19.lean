module
prelude
public import Mahjong.CartesianChannels15V19
import all Mahjong.CartesianChannels15V19
public import Mahjong.CartesianChannels16V19
import all Mahjong.CartesianChannels16V19
public import Mahjong.CartesianChannels20V19
import all Mahjong.CartesianChannels20V19
public import Mahjong.CartesianData01V19
import all Mahjong.CartesianData01V19
public import Mahjong.CartesianData02V19
import all Mahjong.CartesianData02V19
public import Mahjong.CartesianData04V19
import all Mahjong.CartesianData04V19
public import Mahjong.CartesianData05V19
import all Mahjong.CartesianData05V19
public import Mahjong.CartesianData06V19
import all Mahjong.CartesianData06V19
public import Mahjong.CartesianMathV19
import all Mahjong.CartesianMathV19
public section
set_option autoImplicit false
set_option maxRecDepth 131072
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
namespace Mahjong.CartesianPNB19V19
noncomputable def axis0start : Nat := ((((Mahjong.CartesianChannels20V19.channel182 8192 Mahjong.CartesianData05V19.v59) ||| (Mahjong.CartesianChannels20V19.channel183 8192 Mahjong.CartesianData05V19.v63)) ||| ((Mahjong.CartesianChannels20V19.channel184 8192 Mahjong.CartesianData05V19.v67) ||| (Mahjong.CartesianChannels20V19.channel185 8192 Mahjong.CartesianData05V19.v71))) ||| (((Mahjong.CartesianChannels20V19.channel186 8192 Mahjong.CartesianData05V19.v75) ||| (Mahjong.CartesianChannels20V19.channel187 8192 Mahjong.CartesianData05V19.v79)) ||| ((Mahjong.CartesianChannels20V19.channel188 8192 Mahjong.CartesianData05V19.v83) ||| (Mahjong.CartesianChannels20V19.channel189 8192 Mahjong.CartesianData05V19.v87))))
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
noncomputable def axis1start : Nat := (((Mahjong.CartesianChannels15V19.channel157 1024 Mahjong.CartesianData05V19.v93) ||| (Mahjong.CartesianChannels16V19.channel158 1024 Mahjong.CartesianData05V19.v97)) ||| ((Mahjong.CartesianChannels16V19.channel159 1024 Mahjong.CartesianData05V19.v101) ||| ((Mahjong.CartesianChannels16V19.channel160 1024 Mahjong.CartesianData05V19.v105) ||| (Mahjong.CartesianChannels16V19.channel161 1024 Mahjong.CartesianData05V19.v109))))
noncomputable def axis1stage0 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1start Mahjong.CartesianData01V19.v26 32768
noncomputable def axis1stage1 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage0 Mahjong.CartesianData01V19.v25 16384
noncomputable def axis1stage2 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage1 Mahjong.CartesianData04V19.v165 8192
noncomputable def axis1stage3 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage2 Mahjong.CartesianData04V19.v164 4096
noncomputable def axis1stage4 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage3 Mahjong.CartesianData06V19.v28 2048
noncomputable def axis1stage5 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage4 Mahjong.CartesianData06V19.v27 1024
noncomputable def axis1stage6 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage5 Mahjong.CartesianData06V19.v26 65024
noncomputable def axis1stage7 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage6 Mahjong.CartesianData06V19.v25 32512
noncomputable def axis1stage8 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage7 Mahjong.CartesianData06V19.v24 16256
noncomputable def axis1stage9 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage8 Mahjong.CartesianData06V19.v23 8128
noncomputable def axis1stage10 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage9 Mahjong.CartesianData06V19.v22 4064
noncomputable def axis1stage11 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage10 Mahjong.CartesianData06V19.v21 2032
noncomputable def axis2start : Nat := ((((Mahjong.CartesianChannels20V19.channel190 2048 Mahjong.CartesianData05V19.v113) ||| (Mahjong.CartesianChannels20V19.channel191 2048 Mahjong.CartesianData05V19.v117)) ||| ((Mahjong.CartesianChannels20V19.channel192 2048 Mahjong.CartesianData05V19.v121) ||| ((Mahjong.CartesianChannels20V19.channel193 2048 Mahjong.CartesianData05V19.v125) ||| (Mahjong.CartesianChannels20V19.channel194 2048 Mahjong.CartesianData05V19.v129)))) ||| (((Mahjong.CartesianChannels20V19.channel195 2048 Mahjong.CartesianData05V19.v133) ||| (Mahjong.CartesianChannels20V19.channel196 2048 Mahjong.CartesianData05V19.v137)) ||| ((Mahjong.CartesianChannels20V19.channel197 2048 Mahjong.CartesianData05V19.v141) ||| ((Mahjong.CartesianChannels20V19.channel198 2048 Mahjong.CartesianData06V19.v2) ||| (Mahjong.CartesianChannels20V19.channel199 2048 Mahjong.CartesianData06V19.v6)))))
noncomputable def computedReach : Nat := ((axis0stage15 ||| (axis1stage11 ||| axis2start)) ||| (Mahjong.CartesianData06V19.v10 ||| (Mahjong.CartesianData06V19.v14 ||| Mahjong.CartesianData06V19.v18)))
theorem provided_PN :
    computedReach = Mahjong.CartesianData06V19.v20 ∧
    (Mahjong.CartesianData05V19.v57 &&& computedReach) = 0 ∧
    (Mahjong.CartesianData05V19.v57 ||| computedReach) = Mahjong.CartesianData06V19.v19 := by decide +kernel
end Mahjong.CartesianPNB19V19
#print axioms Mahjong.CartesianPNB19V19.provided_PN
