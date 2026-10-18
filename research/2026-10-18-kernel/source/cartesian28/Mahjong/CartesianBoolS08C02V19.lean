module
prelude
public import Mahjong.CartesianChannels01V19
import all Mahjong.CartesianChannels01V19
public import Mahjong.CartesianChannels02V19
import all Mahjong.CartesianChannels02V19
public import Mahjong.CartesianChannels04V19
import all Mahjong.CartesianChannels04V19
public import Mahjong.CartesianChannels05V19
import all Mahjong.CartesianChannels05V19
public import Mahjong.CartesianChannels09V19
import all Mahjong.CartesianChannels09V19
public import Mahjong.CartesianChannels11V19
import all Mahjong.CartesianChannels11V19
public import Mahjong.CartesianChannels12V19
import all Mahjong.CartesianChannels12V19
public import Mahjong.CartesianChannels15V19
import all Mahjong.CartesianChannels15V19
public import Mahjong.CartesianChannels16V19
import all Mahjong.CartesianChannels16V19
public import Mahjong.CartesianChannels17V19
import all Mahjong.CartesianChannels17V19
public import Mahjong.CartesianChannels18V19
import all Mahjong.CartesianChannels18V19
public import Mahjong.CartesianChannels19V19
import all Mahjong.CartesianChannels19V19
public import Mahjong.CartesianChannels20V19
import all Mahjong.CartesianChannels20V19
public import Mahjong.CartesianChannels21V19
import all Mahjong.CartesianChannels21V19
public import Mahjong.CartesianChannels22V19
import all Mahjong.CartesianChannels22V19
public import Mahjong.CartesianData00V19
import all Mahjong.CartesianData00V19
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
namespace Mahjong.CartesianBoolS08C02V19
namespace B16
noncomputable def axis0start : Nat := ((Mahjong.CartesianChannels16V19.channel162 16384 Mahjong.CartesianData04V19.v114) ||| ((Mahjong.CartesianChannels16V19.channel163 16384 Mahjong.CartesianData04V19.v118) ||| (Mahjong.CartesianChannels16V19.channel164 16384 Mahjong.CartesianData04V19.v122)))
noncomputable def axis0stage0 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0start Mahjong.CartesianData01V19.v26 32768
noncomputable def axis0stage1 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage0 Mahjong.CartesianData01V19.v25 16384
noncomputable def axis0stage2 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage1 Mahjong.CartesianData01V19.v24 57344
noncomputable def axis0stage3 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage2 Mahjong.CartesianData01V19.v23 28672
noncomputable def axis0stage4 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage3 Mahjong.CartesianData02V19.v90 14336
noncomputable def axis0stage5 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage4 Mahjong.CartesianData02V19.v89 7168
noncomputable def axis0stage6 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage5 Mahjong.CartesianData02V19.v88 3584
noncomputable def axis0stage7 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage6 Mahjong.CartesianData02V19.v87 1792
noncomputable def axis0stage8 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage7 Mahjong.CartesianData02V19.v86 896
noncomputable def axis0stage9 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage8 Mahjong.CartesianData02V19.v85 448
noncomputable def axis0stage10 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage9 Mahjong.CartesianData02V19.v84 224
noncomputable def axis0stage11 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage10 Mahjong.CartesianData04V19.v163 112
noncomputable def axis0stage12 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage11 Mahjong.CartesianData04V19.v162 56
noncomputable def axis0stage13 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage12 Mahjong.CartesianData04V19.v161 28
noncomputable def axis0stage14 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage13 Mahjong.CartesianData04V19.v160 14
noncomputable def axis0stage15 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage14 Mahjong.CartesianData04V19.v159 7
noncomputable def axis1start : Nat := (((Mahjong.CartesianChannels16V19.channel165 4096 Mahjong.CartesianData04V19.v127) ||| (Mahjong.CartesianChannels16V19.channel166 4096 Mahjong.CartesianData04V19.v131)) ||| ((Mahjong.CartesianChannels16V19.channel167 4096 Mahjong.CartesianData04V19.v135) ||| ((Mahjong.CartesianChannels16V19.channel168 4096 Mahjong.CartesianData04V19.v139) ||| (Mahjong.CartesianChannels16V19.channel169 4096 Mahjong.CartesianData04V19.v143))))
noncomputable def axis1stage0 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1start Mahjong.CartesianData01V19.v26 32768
noncomputable def axis1stage1 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage0 Mahjong.CartesianData01V19.v25 16384
noncomputable def axis1stage2 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage1 Mahjong.CartesianData04V19.v165 8192
noncomputable def axis1stage3 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage2 Mahjong.CartesianData04V19.v164 4096
noncomputable def axis1stage4 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage3 Mahjong.CartesianData01V19.v22 63488
noncomputable def axis1stage5 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage4 Mahjong.CartesianData01V19.v21 31744
noncomputable def axis1stage6 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage5 Mahjong.CartesianData01V19.v20 15872
noncomputable def axis1stage7 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage6 Mahjong.CartesianData01V19.v19 7936
noncomputable def axis1stage8 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage7 Mahjong.CartesianData01V19.v18 3968
noncomputable def axis1stage9 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage8 Mahjong.CartesianData01V19.v17 1984
noncomputable def axis1stage10 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage9 Mahjong.CartesianData01V19.v16 992
noncomputable def axis1stage11 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage10 Mahjong.CartesianData01V19.v15 496
noncomputable def axis1stage12 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage11 Mahjong.CartesianData01V19.v14 248
noncomputable def axis2start : Nat := ((Mahjong.CartesianChannels17V19.channel170 256 Mahjong.CartesianData04V19.v148) ||| (Mahjong.CartesianChannels17V19.channel171 256 Mahjong.CartesianData04V19.v152))
noncomputable def computedReach : Nat := ((axis0stage15 ||| axis1stage12) ||| (axis2start ||| Mahjong.CartesianData04V19.v156))
end B16

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

namespace B18
noncomputable def axis0start : Nat := ((Mahjong.CartesianChannels12V19.channel115 4096 Mahjong.CartesianData05V19.v25) ||| (Mahjong.CartesianChannels12V19.channel116 4096 Mahjong.CartesianData05V19.v29))
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
noncomputable def axis1start : Nat := (Mahjong.CartesianChannels20V19.channel179 8192 Mahjong.CartesianData05V19.v34)
noncomputable def axis1stage0 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1start Mahjong.CartesianData00V19.v54 28672
noncomputable def axis1stage1 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage0 Mahjong.CartesianData00V19.v53 14336
noncomputable def axis1stage2 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage1 Mahjong.CartesianData00V19.v52 7168
noncomputable def axis1stage3 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage2 Mahjong.CartesianData00V19.v51 3584
noncomputable def axis1stage4 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage3 Mahjong.CartesianData00V19.v50 1792
noncomputable def axis1stage5 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage4 Mahjong.CartesianData00V19.v49 896
noncomputable def axis1stage6 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage5 Mahjong.CartesianData00V19.v48 448
noncomputable def axis1stage7 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage6 Mahjong.CartesianData00V19.v47 224
noncomputable def axis1stage8 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage7 Mahjong.CartesianData00V19.v46 112
noncomputable def axis2start : Nat := ((Mahjong.CartesianChannels20V19.channel180 128 Mahjong.CartesianData05V19.v39) ||| (Mahjong.CartesianChannels20V19.channel181 128 Mahjong.CartesianData05V19.v43))
noncomputable def computedReach : Nat := ((axis0stage11 ||| axis1stage8) ||| (axis2start ||| (Mahjong.CartesianData05V19.v47 ||| Mahjong.CartesianData05V19.v51)))
end B18

namespace B19
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
end B19

namespace B20
noncomputable def axis0start : Nat := ((Mahjong.CartesianChannels20V19.channel200 4096 Mahjong.CartesianData06V19.v34) ||| (Mahjong.CartesianChannels20V19.channel201 4096 Mahjong.CartesianData06V19.v38))
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
noncomputable def axis1start : Nat := (Mahjong.CartesianChannels20V19.channel202 16384 Mahjong.CartesianData06V19.v44)
noncomputable def axis1stage0 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1start Mahjong.CartesianData01V19.v24 57344
noncomputable def axis1stage1 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage0 Mahjong.CartesianData01V19.v23 28672
noncomputable def axis1stage2 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage1 Mahjong.CartesianData02V19.v90 14336
noncomputable def axis1stage3 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage2 Mahjong.CartesianData02V19.v89 7168
noncomputable def axis1stage4 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage3 Mahjong.CartesianData02V19.v88 3584
noncomputable def axis1stage5 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage4 Mahjong.CartesianData02V19.v87 1792
noncomputable def axis1stage6 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage5 Mahjong.CartesianData02V19.v86 896
noncomputable def axis1stage7 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage6 Mahjong.CartesianData02V19.v85 448
noncomputable def axis1stage8 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage7 Mahjong.CartesianData02V19.v84 224
noncomputable def axis2start : Nat := ((Mahjong.CartesianChannels01V19.channel14 256 Mahjong.CartesianData06V19.v48) ||| (Mahjong.CartesianChannels02V19.channel15 256 Mahjong.CartesianData06V19.v52))
noncomputable def computedReach : Nat := ((axis0stage15 ||| axis1stage8) ||| (axis2start ||| Mahjong.CartesianData06V19.v56))
end B20

namespace B21
noncomputable def axis0start : Nat := ((Mahjong.CartesianChannels04V19.channel29 4096 Mahjong.CartesianData06V19.v64) ||| ((Mahjong.CartesianChannels04V19.channel30 4096 Mahjong.CartesianData06V19.v68) ||| (Mahjong.CartesianChannels04V19.channel33 4096 Mahjong.CartesianData06V19.v72)))
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
noncomputable def axis1start : Nat := ((Mahjong.CartesianChannels21V19.channel203 2048 Mahjong.CartesianData06V19.v78) ||| (Mahjong.CartesianChannels21V19.channel204 2048 Mahjong.CartesianData06V19.v82))
noncomputable def axis1stage0 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1start Mahjong.CartesianData01V19.v66 64512
noncomputable def axis1stage1 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage0 Mahjong.CartesianData01V19.v65 32256
noncomputable def axis1stage2 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage1 Mahjong.CartesianData01V19.v64 16128
noncomputable def axis1stage3 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage2 Mahjong.CartesianData01V19.v63 8064
noncomputable def axis1stage4 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage3 Mahjong.CartesianData01V19.v62 4032
noncomputable def axis1stage5 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage4 Mahjong.CartesianData01V19.v61 2016
noncomputable def axis2start : Nat := ((Mahjong.CartesianChannels21V19.channel205 2048 Mahjong.CartesianData06V19.v86) ||| (Mahjong.CartesianChannels21V19.channel206 2048 Mahjong.CartesianData06V19.v90))
noncomputable def computedReach : Nat := (axis0stage15 ||| (axis1stage5 ||| axis2start))
end B21

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
noncomputable def checks : Bool := ((((((Mahjong.CartesianData04V19.v112 &&& B16.computedReach) == 0) && ((Mahjong.CartesianData04V19.v112 ||| B16.computedReach) == Mahjong.CartesianData04V19.v157)) && (((Mahjong.CartesianData04V19.v169 &&& B17.computedReach) == 0) && ((Mahjong.CartesianData04V19.v169 ||| B17.computedReach) == Mahjong.CartesianData05V19.v7))) && ((((Mahjong.CartesianData05V19.v23 &&& B18.computedReach) == 0) && ((Mahjong.CartesianData05V19.v23 ||| B18.computedReach) == Mahjong.CartesianData05V19.v52)) && (((Mahjong.CartesianData05V19.v57 &&& B19.computedReach) == 0) && ((Mahjong.CartesianData05V19.v57 ||| B19.computedReach) == Mahjong.CartesianData06V19.v19)))) && (((((Mahjong.CartesianData06V19.v32 &&& B20.computedReach) == 0) && ((Mahjong.CartesianData06V19.v32 ||| B20.computedReach) == Mahjong.CartesianData06V19.v57)) && (((Mahjong.CartesianData06V19.v62 &&& B21.computedReach) == 0) && ((Mahjong.CartesianData06V19.v62 ||| B21.computedReach) == Mahjong.CartesianData06V19.v91))) && ((((Mahjong.CartesianData06V19.v96 &&& B22.computedReach) == 0) && ((Mahjong.CartesianData06V19.v96 ||| B22.computedReach) == Mahjong.CartesianData06V19.v125)) && (((Mahjong.CartesianData07V19.v1 &&& B23.computedReach) == 0) && ((Mahjong.CartesianData07V19.v1 ||| B23.computedReach) == Mahjong.CartesianData07V19.v46)))))
theorem accepted : checks = true := by exact Eq.refl true
end Mahjong.CartesianBoolS08C02V19
#print axioms Mahjong.CartesianBoolS08C02V19.accepted
