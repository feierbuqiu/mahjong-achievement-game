module
prelude
public import Mahjong.CartesianChannels11V19
import all Mahjong.CartesianChannels11V19
public import Mahjong.CartesianChannels12V19
import all Mahjong.CartesianChannels12V19
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
public import Mahjong.CartesianChannels25V19
import all Mahjong.CartesianChannels25V19
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
namespace Mahjong.CartesianBoolS04C06V19
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

namespace B26
noncomputable def axis0start : Nat := ((((Mahjong.CartesianChannels24V19.channel234 4096 Mahjong.CartesianData08V19.v32) ||| (Mahjong.CartesianChannels24V19.channel235 4096 Mahjong.CartesianData08V19.v36)) ||| ((Mahjong.CartesianChannels24V19.channel236 4096 Mahjong.CartesianData08V19.v40) ||| (Mahjong.CartesianChannels24V19.channel237 4096 Mahjong.CartesianData08V19.v44))) ||| (((Mahjong.CartesianChannels24V19.channel238 4096 Mahjong.CartesianData08V19.v48) ||| (Mahjong.CartesianChannels24V19.channel239 4096 Mahjong.CartesianData08V19.v52)) ||| ((Mahjong.CartesianChannels24V19.channel240 4096 Mahjong.CartesianData08V19.v56) ||| ((Mahjong.CartesianChannels24V19.channel241 4096 Mahjong.CartesianData08V19.v60) ||| (Mahjong.CartesianChannels24V19.channel242 4096 Mahjong.CartesianData08V19.v64)))))
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
noncomputable def axis1start : Nat := ((Mahjong.CartesianChannels24V19.channel243 4096 Mahjong.CartesianData08V19.v69) ||| (Mahjong.CartesianChannels24V19.channel244 4096 Mahjong.CartesianData08V19.v73))
noncomputable def axis1stage0 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1start Mahjong.CartesianData00V19.v65 30720
noncomputable def axis1stage1 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage0 Mahjong.CartesianData05V19.v19 15360
noncomputable def axis1stage2 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage1 Mahjong.CartesianData05V19.v18 7680
noncomputable def axis1stage3 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage2 Mahjong.CartesianData05V19.v17 3840
noncomputable def axis1stage4 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage3 Mahjong.CartesianData05V19.v16 1920
noncomputable def axis1stage5 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage4 Mahjong.CartesianData05V19.v15 960
noncomputable def axis1stage6 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage5 Mahjong.CartesianData05V19.v14 480
noncomputable def axis1stage7 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage6 Mahjong.CartesianData05V19.v13 240
noncomputable def axis2start : Nat := ((Mahjong.CartesianChannels24V19.channel245 256 Mahjong.CartesianData08V19.v78) ||| ((Mahjong.CartesianChannels25V19.channel246 256 Mahjong.CartesianData08V19.v82) ||| (Mahjong.CartesianChannels26V19.channel247 256 Mahjong.CartesianData08V19.v86)))
noncomputable def computedReach : Nat := ((axis0stage11 ||| axis1stage7) ||| (axis2start ||| (Mahjong.CartesianData08V19.v90 ||| Mahjong.CartesianData08V19.v94)))
end B26

namespace B27
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
end B27
noncomputable def checks : Bool := (((((Mahjong.CartesianData07V19.v55 &&& B24.computedReach) == 0) && ((Mahjong.CartesianData07V19.v55 ||| B24.computedReach) == Mahjong.CartesianData07V19.v124)) && (((Mahjong.CartesianData07V19.v129 &&& B25.computedReach) == 0) && ((Mahjong.CartesianData07V19.v129 ||| B25.computedReach) == Mahjong.CartesianData08V19.v25))) && ((((Mahjong.CartesianData08V19.v30 &&& B26.computedReach) == 0) && ((Mahjong.CartesianData08V19.v30 ||| B26.computedReach) == Mahjong.CartesianData08V19.v95)) && (((Mahjong.CartesianData08V19.v100 &&& B27.computedReach) == 0) && ((Mahjong.CartesianData08V19.v100 ||| B27.computedReach) == Mahjong.CartesianData08V19.v193))))
theorem accepted : checks = true := by exact Eq.refl true
end Mahjong.CartesianBoolS04C06V19
#print axioms Mahjong.CartesianBoolS04C06V19.accepted
