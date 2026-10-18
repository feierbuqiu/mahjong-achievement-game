module
prelude
public import Mahjong.CartesianChannels07V19
import all Mahjong.CartesianChannels07V19
public import Mahjong.CartesianChannels11V19
import all Mahjong.CartesianChannels11V19
public import Mahjong.CartesianChannels12V19
import all Mahjong.CartesianChannels12V19
public import Mahjong.CartesianData03V19
import all Mahjong.CartesianData03V19
public import Mahjong.CartesianMathV19
import all Mahjong.CartesianMathV19
public section
set_option autoImplicit false
set_option synthInstance.maxSize 4096
set_option maxRecDepth 131072
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
namespace Mahjong.CartesianPrepB11V19
theorem every_layout_and_valid_mask :
  (((((Mahjong.CartesianData03V19.v76 = Mahjong.CartesianMathV19.pad 6 52 52 3 6 6 Mahjong.CartesianData03V19.v73 ∧
  (Mahjong.CartesianData03V19.v74 = (Mahjong.CartesianMathV19.permute 15 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) List.nil)))))))))))) Mahjong.CartesianData03V19.v76) ∧
  Mahjong.CartesianData03V19.v75 = (Mahjong.CartesianMathV19.permute 15 (List.cons (3,9) (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) List.nil)))))) Mahjong.CartesianData03V19.v76))) ∧
  ((Mahjong.CartesianData03V19.v80 = Mahjong.CartesianMathV19.pad 17 52 52 5 6 6 Mahjong.CartesianData03V19.v77 ∧
  Mahjong.CartesianData03V19.v78 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,15) (List.cons (13,16) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData03V19.v80)) ∧
  (Mahjong.CartesianData03V19.v79 = (Mahjong.CartesianMathV19.permute 17 (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) (List.cons (10,16) List.nil)))))) Mahjong.CartesianData03V19.v80) ∧
  Mahjong.CartesianData03V19.v84 = Mahjong.CartesianMathV19.pad 1 52 52 0 6 6 Mahjong.CartesianData03V19.v81))) ∧
  (((Mahjong.CartesianData03V19.v82 = (Mahjong.CartesianMathV19.permute 12 List.nil Mahjong.CartesianData03V19.v84) ∧
  Mahjong.CartesianData03V19.v83 = (Mahjong.CartesianMathV19.permute 12 (List.cons (0,6) (List.cons (1,7) (List.cons (2,8) (List.cons (3,9) (List.cons (4,10) (List.cons (5,11) List.nil)))))) Mahjong.CartesianData03V19.v84)) ∧
  (Mahjong.CartesianData03V19.v88 = Mahjong.CartesianMathV19.pad 15 52 52 4 6 6 Mahjong.CartesianData03V19.v85 ∧
  Mahjong.CartesianData03V19.v86 = (Mahjong.CartesianMathV19.permute 16 (List.cons (0,4) (List.cons (1,5) (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) List.nil)))))))))))) Mahjong.CartesianData03V19.v88))) ∧
  ((Mahjong.CartesianData03V19.v87 = (Mahjong.CartesianMathV19.permute 16 (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) List.nil)))))) Mahjong.CartesianData03V19.v88) ∧
  Mahjong.CartesianData03V19.v92 = Mahjong.CartesianMathV19.pad 3 52 52 2 6 6 Mahjong.CartesianData03V19.v89) ∧
  (Mahjong.CartesianData03V19.v90 = (Mahjong.CartesianMathV19.permute 14 (List.cons (0,2) (List.cons (1,3) (List.cons (2,4) (List.cons (3,5) (List.cons (4,6) (List.cons (5,7) (List.cons (6,8) (List.cons (7,9) (List.cons (8,10) (List.cons (9,11) (List.cons (10,12) (List.cons (11,13) List.nil)))))))))))) Mahjong.CartesianData03V19.v92) ∧
  Mahjong.CartesianData03V19.v91 = (Mahjong.CartesianMathV19.permute 14 (List.cons (2,8) (List.cons (3,9) (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) List.nil)))))) Mahjong.CartesianData03V19.v92))))) ∧
  (((Mahjong.CartesianData03V19.v96 = Mahjong.CartesianMathV19.pad 21 52 52 5 6 6 Mahjong.CartesianData03V19.v93 ∧
  (Mahjong.CartesianData03V19.v94 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,15) (List.cons (13,16) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData03V19.v96) ∧
  Mahjong.CartesianData03V19.v95 = (Mahjong.CartesianMathV19.permute 17 (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) (List.cons (10,16) List.nil)))))) Mahjong.CartesianData03V19.v96))) ∧
  ((Mahjong.CartesianData03V19.v100 = Mahjong.CartesianMathV19.pad 6 52 16 3 6 4 Mahjong.CartesianData03V19.v97 ∧
  Mahjong.CartesianData03V19.v98 = (Mahjong.CartesianMathV19.permute 13 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,12) (List.cons (11,12) List.nil)))))))))))) Mahjong.CartesianData03V19.v100)) ∧
  (Mahjong.CartesianData03V19.v99 = (Mahjong.CartesianMathV19.permute 13 (List.cons (3,9) (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,9) (List.cons (8,10) (List.cons (9,11) (List.cons (10,12) List.nil)))))))) Mahjong.CartesianData03V19.v100) ∧
  Mahjong.CartesianData03V19.v104 = Mahjong.CartesianMathV19.pad 6 52 5 3 6 3 Mahjong.CartesianData03V19.v101))) ∧
  (((Mahjong.CartesianData03V19.v102 = (Mahjong.CartesianMathV19.permute 12 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) List.nil))))))))) Mahjong.CartesianData03V19.v104) ∧
  Mahjong.CartesianData03V19.v103 = (Mahjong.CartesianMathV19.permute 12 (List.cons (3,9) (List.cons (4,10) (List.cons (5,11) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) List.nil)))))) Mahjong.CartesianData03V19.v104)) ∧
  (Mahjong.CartesianData03V19.v108 = Mahjong.CartesianMathV19.pad 6 52 160 3 6 8 Mahjong.CartesianData03V19.v105 ∧
  Mahjong.CartesianData03V19.v106 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,16) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData03V19.v108))) ∧
  ((Mahjong.CartesianData03V19.v107 = (Mahjong.CartesianMathV19.permute 17 (List.cons (3,9) (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) (List.cons (10,16) (List.cons (11,15) (List.cons (12,16) (List.cons (13,15) (List.cons (14,16) List.nil)))))))))))) Mahjong.CartesianData03V19.v108) ∧
  Mahjong.CartesianData03V19.v112 = Mahjong.CartesianMathV19.pad 6 52 49 3 6 6 Mahjong.CartesianData03V19.v109) ∧
  (Mahjong.CartesianData03V19.v110 = (Mahjong.CartesianMathV19.permute 15 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) List.nil)))))))))))) Mahjong.CartesianData03V19.v112) ∧
  Mahjong.CartesianData03V19.v111 = (Mahjong.CartesianMathV19.permute 15 (List.cons (3,9) (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) List.nil)))))) Mahjong.CartesianData03V19.v112)))))) ∧
  ((((Mahjong.CartesianData03V19.v116 = Mahjong.CartesianMathV19.pad 6 52 78 3 6 7 Mahjong.CartesianData03V19.v113 ∧
  (Mahjong.CartesianData03V19.v114 = (Mahjong.CartesianMathV19.permute 16 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,15) (List.cons (14,15) List.nil))))))))))))))) Mahjong.CartesianData03V19.v116) ∧
  Mahjong.CartesianData03V19.v115 = (Mahjong.CartesianMathV19.permute 16 (List.cons (3,9) (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) (List.cons (10,15) (List.cons (11,15) (List.cons (12,15) (List.cons (13,15) (List.cons (14,15) List.nil)))))))))))) Mahjong.CartesianData03V19.v116))) ∧
  ((Mahjong.CartesianData03V19.v120 = Mahjong.CartesianMathV19.pad 6 52 52 3 6 6 Mahjong.CartesianData03V19.v117 ∧
  Mahjong.CartesianData03V19.v118 = (Mahjong.CartesianMathV19.permute 15 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) List.nil)))))))))))) Mahjong.CartesianData03V19.v120)) ∧
  (Mahjong.CartesianData03V19.v119 = (Mahjong.CartesianMathV19.permute 15 (List.cons (3,9) (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) List.nil)))))) Mahjong.CartesianData03V19.v120) ∧
  Mahjong.CartesianData03V19.v124 = Mahjong.CartesianMathV19.pad 6 52 53 3 6 6 Mahjong.CartesianData03V19.v121))) ∧
  (((Mahjong.CartesianData03V19.v122 = (Mahjong.CartesianMathV19.permute 15 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) List.nil)))))))))))) Mahjong.CartesianData03V19.v124) ∧
  Mahjong.CartesianData03V19.v123 = (Mahjong.CartesianMathV19.permute 15 (List.cons (3,9) (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) List.nil)))))) Mahjong.CartesianData03V19.v124)) ∧
  (Mahjong.CartesianData03V19.v128 = Mahjong.CartesianMathV19.pad 6 52 29 3 6 5 Mahjong.CartesianData03V19.v125 ∧
  Mahjong.CartesianData03V19.v126 = (Mahjong.CartesianMathV19.permute 14 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,12) (List.cons (12,13) List.nil))))))))))))) Mahjong.CartesianData03V19.v128))) ∧
  ((Mahjong.CartesianData03V19.v127 = (Mahjong.CartesianMathV19.permute 14 (List.cons (3,9) (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,9) (List.cons (9,10) (List.cons (10,11) (List.cons (11,12) (List.cons (12,13) List.nil)))))))))) Mahjong.CartesianData03V19.v128) ∧
  Mahjong.CartesianData03V19.v132 = Mahjong.CartesianMathV19.pad 6 52 10 3 6 4 Mahjong.CartesianData03V19.v129) ∧
  (Mahjong.CartesianData03V19.v130 = (Mahjong.CartesianMathV19.permute 13 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,12) (List.cons (11,12) List.nil)))))))))))) Mahjong.CartesianData03V19.v132) ∧
  Mahjong.CartesianData03V19.v131 = (Mahjong.CartesianMathV19.permute 13 (List.cons (3,9) (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,9) (List.cons (8,10) (List.cons (9,11) (List.cons (10,12) List.nil)))))))) Mahjong.CartesianData03V19.v132))))) ∧
  ((((Mahjong.CartesianData03V19.v136 = Mahjong.CartesianMathV19.pad 6 52 80 3 6 7 Mahjong.CartesianData03V19.v133 ∧
  Mahjong.CartesianData03V19.v134 = (Mahjong.CartesianMathV19.permute 16 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,15) (List.cons (14,15) List.nil))))))))))))))) Mahjong.CartesianData03V19.v136)) ∧
  (Mahjong.CartesianData03V19.v135 = (Mahjong.CartesianMathV19.permute 16 (List.cons (3,9) (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) (List.cons (10,15) (List.cons (11,15) (List.cons (12,15) (List.cons (13,15) (List.cons (14,15) List.nil)))))))))))) Mahjong.CartesianData03V19.v136) ∧
  Mahjong.CartesianData03V19.v140 = Mahjong.CartesianMathV19.pad 6 52 52 3 6 6 Mahjong.CartesianData03V19.v137)) ∧
  ((Mahjong.CartesianData03V19.v138 = (Mahjong.CartesianMathV19.permute 15 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) List.nil)))))))))))) Mahjong.CartesianData03V19.v140) ∧
  Mahjong.CartesianData03V19.v139 = (Mahjong.CartesianMathV19.permute 15 (List.cons (3,9) (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) List.nil)))))) Mahjong.CartesianData03V19.v140)) ∧
  (Mahjong.CartesianData03V19.v144 = Mahjong.CartesianMathV19.pad 6 52 52 3 6 6 Mahjong.CartesianData03V19.v141 ∧
  Mahjong.CartesianData03V19.v142 = (Mahjong.CartesianMathV19.permute 15 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) List.nil)))))))))))) Mahjong.CartesianData03V19.v144)))) ∧
  (((Mahjong.CartesianData03V19.v143 = (Mahjong.CartesianMathV19.permute 15 (List.cons (3,9) (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) List.nil)))))) Mahjong.CartesianData03V19.v144) ∧
  Mahjong.CartesianData03V19.v148 = Mahjong.CartesianMathV19.pad 6 52 52 3 6 6 Mahjong.CartesianData03V19.v145) ∧
  (Mahjong.CartesianData03V19.v146 = (Mahjong.CartesianMathV19.permute 15 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) List.nil)))))))))))) Mahjong.CartesianData03V19.v148) ∧
  Mahjong.CartesianData03V19.v147 = (Mahjong.CartesianMathV19.permute 15 (List.cons (3,9) (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) List.nil)))))) Mahjong.CartesianData03V19.v148))) ∧
  ((Mahjong.CartesianData03V19.v152 = Mahjong.CartesianMathV19.pad 6 52 52 3 6 6 Mahjong.CartesianData03V19.v149 ∧
  Mahjong.CartesianData03V19.v150 = (Mahjong.CartesianMathV19.permute 15 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) List.nil)))))))))))) Mahjong.CartesianData03V19.v152)) ∧
  (Mahjong.CartesianData03V19.v151 = (Mahjong.CartesianMathV19.permute 15 (List.cons (3,9) (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) List.nil)))))) Mahjong.CartesianData03V19.v152) ∧
  Mahjong.CartesianData03V19.v153 = Mahjong.CartesianMathV19.pad 6 52 52 3 6 6 (2^16224-1))))))) := by decide +kernel
end Mahjong.CartesianPrepB11V19
#print axioms Mahjong.CartesianPrepB11V19.every_layout_and_valid_mask
