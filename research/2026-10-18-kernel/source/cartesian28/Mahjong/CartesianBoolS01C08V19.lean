module
prelude
public import Mahjong.CartesianChannels10V19
import all Mahjong.CartesianChannels10V19
public import Mahjong.CartesianChannels11V19
import all Mahjong.CartesianChannels11V19
public import Mahjong.CartesianData00V19
import all Mahjong.CartesianData00V19
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
namespace Mahjong.CartesianBoolS01C08V19
namespace B08
noncomputable def axis0start : Nat := ((((Mahjong.CartesianChannels10V19.channel70 2048 Mahjong.CartesianData02V19.v97) ||| (Mahjong.CartesianChannels10V19.channel71 2048 Mahjong.CartesianData02V19.v101)) ||| ((Mahjong.CartesianChannels10V19.channel72 2048 Mahjong.CartesianData02V19.v105) ||| (Mahjong.CartesianChannels10V19.channel73 2048 Mahjong.CartesianData02V19.v110))) ||| (((Mahjong.CartesianChannels10V19.channel74 2048 Mahjong.CartesianData02V19.v114) ||| (Mahjong.CartesianChannels10V19.channel75 2048 Mahjong.CartesianData02V19.v118)) ||| ((Mahjong.CartesianChannels10V19.channel76 2048 Mahjong.CartesianData02V19.v122) ||| ((Mahjong.CartesianChannels10V19.channel77 2048 Mahjong.CartesianData02V19.v125) ||| (Mahjong.CartesianChannels10V19.channel78 2048 Mahjong.CartesianData02V19.v129)))))
noncomputable def axis0stage0 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0start Mahjong.CartesianData00V19.v56 16384
noncomputable def axis0stage1 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage0 Mahjong.CartesianData00V19.v55 24576
noncomputable def axis0stage2 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage1 Mahjong.CartesianData00V19.v54 28672
noncomputable def axis0stage3 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage2 Mahjong.CartesianData00V19.v65 30720
noncomputable def axis0stage4 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage3 Mahjong.CartesianData00V19.v64 31744
noncomputable def axis0stage5 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage4 Mahjong.CartesianData00V19.v148 15872
noncomputable def axis0stage6 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage5 Mahjong.CartesianData00V19.v147 7936
noncomputable def axis0stage7 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage6 Mahjong.CartesianData00V19.v146 3968
noncomputable def axis0stage8 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage7 Mahjong.CartesianData00V19.v145 1984
noncomputable def axis0stage9 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage8 Mahjong.CartesianData00V19.v144 992
noncomputable def axis0stage10 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage9 Mahjong.CartesianData00V19.v143 496
noncomputable def axis0stage11 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage10 Mahjong.CartesianData00V19.v142 248
noncomputable def axis0stage12 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage11 Mahjong.CartesianData00V19.v141 124
noncomputable def axis0stage13 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage12 Mahjong.CartesianData02V19.v186 62
noncomputable def axis0stage14 : Nat := Mahjong.CartesianMathV19.deltaSwap axis0stage13 Mahjong.CartesianData02V19.v185 31
noncomputable def axis1start : Nat := ((((Mahjong.CartesianChannels10V19.channel70 2048 Mahjong.CartesianData02V19.v97) ||| (Mahjong.CartesianChannels10V19.channel71 2048 Mahjong.CartesianData02V19.v101)) ||| ((Mahjong.CartesianChannels10V19.channel72 2048 Mahjong.CartesianData02V19.v105) ||| (Mahjong.CartesianChannels10V19.channel73 2048 Mahjong.CartesianData02V19.v110))) ||| (((Mahjong.CartesianChannels10V19.channel74 2048 Mahjong.CartesianData02V19.v114) ||| (Mahjong.CartesianChannels10V19.channel75 2048 Mahjong.CartesianData02V19.v118)) ||| ((Mahjong.CartesianChannels10V19.channel76 2048 Mahjong.CartesianData02V19.v122) ||| ((Mahjong.CartesianChannels10V19.channel77 2048 Mahjong.CartesianData02V19.v125) ||| (Mahjong.CartesianChannels10V19.channel78 2048 Mahjong.CartesianData02V19.v129)))))
noncomputable def axis1stage0 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1start Mahjong.CartesianData00V19.v56 16384
noncomputable def axis1stage1 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage0 Mahjong.CartesianData00V19.v55 24576
noncomputable def axis1stage2 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage1 Mahjong.CartesianData00V19.v54 28672
noncomputable def axis1stage3 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage2 Mahjong.CartesianData00V19.v65 30720
noncomputable def axis1stage4 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage3 Mahjong.CartesianData00V19.v64 31744
noncomputable def axis1stage5 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage4 Mahjong.CartesianData00V19.v148 15872
noncomputable def axis1stage6 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage5 Mahjong.CartesianData00V19.v147 7936
noncomputable def axis1stage7 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage6 Mahjong.CartesianData00V19.v146 3968
noncomputable def axis1stage8 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage7 Mahjong.CartesianData00V19.v145 1984
noncomputable def axis1stage9 : Nat := Mahjong.CartesianMathV19.deltaSwap axis1stage8 Mahjong.CartesianData00V19.v144 992
noncomputable def axis2start : Nat := ((((Mahjong.CartesianChannels10V19.channel79 1024 Mahjong.CartesianData02V19.v134) ||| (Mahjong.CartesianChannels10V19.channel80 1024 Mahjong.CartesianData02V19.v138)) ||| ((Mahjong.CartesianChannels10V19.channel81 1024 Mahjong.CartesianData02V19.v142) ||| ((Mahjong.CartesianChannels11V19.channel82 1024 Mahjong.CartesianData02V19.v146) ||| (Mahjong.CartesianChannels11V19.channel83 1024 Mahjong.CartesianData02V19.v150)))) ||| (((Mahjong.CartesianChannels11V19.channel84 1024 Mahjong.CartesianData02V19.v154) ||| (Mahjong.CartesianChannels11V19.channel85 1024 Mahjong.CartesianData02V19.v158)) ||| ((Mahjong.CartesianChannels11V19.channel86 1024 Mahjong.CartesianData02V19.v162) ||| ((Mahjong.CartesianChannels11V19.channel87 1024 Mahjong.CartesianData02V19.v166) ||| (Mahjong.CartesianChannels11V19.channel88 1024 Mahjong.CartesianData02V19.v170)))))
noncomputable def computedReach : Nat := ((axis0stage14 ||| (axis1stage9 ||| axis2start)) ||| (Mahjong.CartesianData02V19.v174 ||| (Mahjong.CartesianData02V19.v178 ||| Mahjong.CartesianData02V19.v182)))
end B08
noncomputable def checks : Bool := (((Mahjong.CartesianData02V19.v94 &&& B08.computedReach) == 0) && ((Mahjong.CartesianData02V19.v94 ||| B08.computedReach) == Mahjong.CartesianData02V19.v183))
theorem accepted : checks = true := by exact Eq.refl true
end Mahjong.CartesianBoolS01C08V19
#print axioms Mahjong.CartesianBoolS01C08V19.accepted
