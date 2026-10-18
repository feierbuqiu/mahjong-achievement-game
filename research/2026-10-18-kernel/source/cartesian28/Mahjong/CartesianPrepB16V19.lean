module
prelude
public import Mahjong.CartesianChannels16V19
import all Mahjong.CartesianChannels16V19
public import Mahjong.CartesianChannels17V19
import all Mahjong.CartesianChannels17V19
public import Mahjong.CartesianData01V19
import all Mahjong.CartesianData01V19
public import Mahjong.CartesianData02V19
import all Mahjong.CartesianData02V19
public import Mahjong.CartesianData04V19
import all Mahjong.CartesianData04V19
public import Mahjong.CartesianMathV19
import all Mahjong.CartesianMathV19
public section
set_option autoImplicit false
set_option synthInstance.maxSize 4096
set_option maxRecDepth 131072
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
namespace Mahjong.CartesianPrepB16V19
theorem every_layout_and_valid_mask :
  (((((Mahjong.CartesianData04V19.v112 = Mahjong.CartesianMathV19.pad 7 19 384 3 5 9 Mahjong.CartesianData04V19.v109 ∧
  Mahjong.CartesianData04V19.v110 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,16) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData04V19.v112)) ∧
  (Mahjong.CartesianData04V19.v111 = (Mahjong.CartesianMathV19.permute 17 (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,13) (List.cons (13,14) (List.cons (14,15) (List.cons (15,16) List.nil))))))))))))) Mahjong.CartesianData04V19.v112) ∧
  Mahjong.CartesianData04V19.v116 = Mahjong.CartesianMathV19.pad 4 19 384 2 5 9 Mahjong.CartesianData04V19.v113)) ∧
  ((Mahjong.CartesianData04V19.v114 = (Mahjong.CartesianMathV19.permute 16 (List.cons (0,2) (List.cons (1,3) (List.cons (2,4) (List.cons (3,5) (List.cons (4,6) (List.cons (5,7) (List.cons (6,8) (List.cons (7,9) (List.cons (8,10) (List.cons (9,11) (List.cons (10,12) (List.cons (11,13) (List.cons (12,14) (List.cons (13,15) List.nil)))))))))))))) Mahjong.CartesianData04V19.v116) ∧
  Mahjong.CartesianData04V19.v115 = (Mahjong.CartesianMathV19.permute 16 (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,12) (List.cons (12,13) (List.cons (13,14) (List.cons (14,15) List.nil))))))))))))) Mahjong.CartesianData04V19.v116)) ∧
  (Mahjong.CartesianData04V19.v120 = Mahjong.CartesianMathV19.pad 30 19 384 5 5 9 Mahjong.CartesianData04V19.v117 ∧
  (Mahjong.CartesianData04V19.v118 = (Mahjong.CartesianMathV19.permute 19 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,17) (List.cons (13,18) (List.cons (14,15) (List.cons (15,16) (List.cons (16,17) (List.cons (17,18) List.nil)))))))))))))))))) Mahjong.CartesianData04V19.v120) ∧
  Mahjong.CartesianData04V19.v119 = (Mahjong.CartesianMathV19.permute 19 (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,17) (List.cons (13,18) (List.cons (14,15) (List.cons (15,16) (List.cons (16,17) (List.cons (17,18) List.nil))))))))))))) Mahjong.CartesianData04V19.v120))))) ∧
  (((Mahjong.CartesianData04V19.v124 = Mahjong.CartesianMathV19.pad 10 19 384 4 5 9 Mahjong.CartesianData04V19.v121 ∧
  Mahjong.CartesianData04V19.v122 = (Mahjong.CartesianMathV19.permute 18 (List.cons (0,4) (List.cons (1,5) (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) (List.cons (12,16) (List.cons (13,17) (List.cons (14,16) (List.cons (15,17) List.nil)))))))))))))))) Mahjong.CartesianData04V19.v124)) ∧
  (Mahjong.CartesianData04V19.v123 = (Mahjong.CartesianMathV19.permute 18 (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,17) (List.cons (13,14) (List.cons (14,15) (List.cons (15,16) (List.cons (16,17) List.nil))))))))))))) Mahjong.CartesianData04V19.v124) ∧
  Mahjong.CartesianData04V19.v128 = Mahjong.CartesianMathV19.pad 7 8 384 3 3 9 Mahjong.CartesianData04V19.v125)) ∧
  ((Mahjong.CartesianData04V19.v126 = (Mahjong.CartesianMathV19.permute 15 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) List.nil)))))))))))) Mahjong.CartesianData04V19.v128) ∧
  Mahjong.CartesianData04V19.v127 = (Mahjong.CartesianMathV19.permute 15 (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) List.nil))))))))) Mahjong.CartesianData04V19.v128)) ∧
  (Mahjong.CartesianData04V19.v132 = Mahjong.CartesianMathV19.pad 7 5 384 3 3 9 Mahjong.CartesianData04V19.v129 ∧
  (Mahjong.CartesianData04V19.v130 = (Mahjong.CartesianMathV19.permute 15 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) List.nil)))))))))))) Mahjong.CartesianData04V19.v132) ∧
  Mahjong.CartesianData04V19.v131 = (Mahjong.CartesianMathV19.permute 15 (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) List.nil))))))))) Mahjong.CartesianData04V19.v132)))))) ∧
  ((((Mahjong.CartesianData04V19.v136 = Mahjong.CartesianMathV19.pad 7 47 384 3 6 9 Mahjong.CartesianData04V19.v133 ∧
  Mahjong.CartesianData04V19.v134 = (Mahjong.CartesianMathV19.permute 18 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,16) (List.cons (14,17) List.nil))))))))))))))) Mahjong.CartesianData04V19.v136)) ∧
  (Mahjong.CartesianData04V19.v135 = (Mahjong.CartesianMathV19.permute 18 (List.cons (3,9) (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) (List.cons (10,16) (List.cons (11,17) (List.cons (12,15) (List.cons (13,16) (List.cons (14,17) List.nil)))))))))))) Mahjong.CartesianData04V19.v136) ∧
  Mahjong.CartesianData04V19.v140 = Mahjong.CartesianMathV19.pad 7 20 384 3 5 9 Mahjong.CartesianData04V19.v137)) ∧
  ((Mahjong.CartesianData04V19.v138 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,16) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData04V19.v140) ∧
  Mahjong.CartesianData04V19.v139 = (Mahjong.CartesianMathV19.permute 17 (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,13) (List.cons (13,14) (List.cons (14,15) (List.cons (15,16) List.nil))))))))))))) Mahjong.CartesianData04V19.v140)) ∧
  (Mahjong.CartesianData04V19.v144 = Mahjong.CartesianMathV19.pad 7 22 384 3 5 9 Mahjong.CartesianData04V19.v141 ∧
  (Mahjong.CartesianData04V19.v142 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,16) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData04V19.v144) ∧
  Mahjong.CartesianData04V19.v143 = (Mahjong.CartesianMathV19.permute 17 (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,13) (List.cons (13,14) (List.cons (14,15) (List.cons (15,16) List.nil))))))))))))) Mahjong.CartesianData04V19.v144))))) ∧
  (((Mahjong.CartesianData04V19.v148 = Mahjong.CartesianMathV19.pad 7 19 376 3 5 9 Mahjong.CartesianData04V19.v145 ∧
  Mahjong.CartesianData04V19.v146 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,16) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData04V19.v148)) ∧
  (Mahjong.CartesianData04V19.v147 = (Mahjong.CartesianMathV19.permute 17 (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,13) (List.cons (13,14) (List.cons (14,15) (List.cons (15,16) List.nil))))))))))))) Mahjong.CartesianData04V19.v148) ∧
  (Mahjong.CartesianData04V19.v152 = Mahjong.CartesianMathV19.pad 7 19 164 3 5 8 Mahjong.CartesianData04V19.v149 ∧
  Mahjong.CartesianData04V19.v150 = (Mahjong.CartesianMathV19.permute 16 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,15) (List.cons (14,15) List.nil))))))))))))))) Mahjong.CartesianData04V19.v152)))) ∧
  ((Mahjong.CartesianData04V19.v151 = (Mahjong.CartesianMathV19.permute 16 (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,13) (List.cons (12,14) (List.cons (13,15) (List.cons (14,15) List.nil)))))))))))) Mahjong.CartesianData04V19.v152) ∧
  Mahjong.CartesianData04V19.v156 = Mahjong.CartesianMathV19.pad 7 19 384 3 5 9 Mahjong.CartesianData04V19.v153) ∧
  (Mahjong.CartesianData04V19.v154 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,16) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData04V19.v156) ∧
  (Mahjong.CartesianData04V19.v155 = (Mahjong.CartesianMathV19.permute 17 (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,13) (List.cons (13,14) (List.cons (14,15) (List.cons (15,16) List.nil))))))))))))) Mahjong.CartesianData04V19.v156) ∧
  Mahjong.CartesianData04V19.v157 = Mahjong.CartesianMathV19.pad 7 19 384 3 5 9 (2^51072-1))))))) := by decide +kernel
end Mahjong.CartesianPrepB16V19
#print axioms Mahjong.CartesianPrepB16V19.every_layout_and_valid_mask
