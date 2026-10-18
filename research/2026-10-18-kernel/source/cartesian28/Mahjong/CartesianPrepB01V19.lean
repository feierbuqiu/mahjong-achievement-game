module
prelude
public import Mahjong.CartesianChannels00V19
import all Mahjong.CartesianChannels00V19
public import Mahjong.CartesianChannels01V19
import all Mahjong.CartesianChannels01V19
public import Mahjong.CartesianChannels02V19
import all Mahjong.CartesianChannels02V19
public import Mahjong.CartesianChannels03V19
import all Mahjong.CartesianChannels03V19
public import Mahjong.CartesianChannels04V19
import all Mahjong.CartesianChannels04V19
public import Mahjong.CartesianData00V19
import all Mahjong.CartesianData00V19
public import Mahjong.CartesianMathV19
import all Mahjong.CartesianMathV19
public section
set_option autoImplicit false
set_option synthInstance.maxSize 4096
set_option maxRecDepth 131072
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
namespace Mahjong.CartesianPrepB01V19
theorem every_layout_and_valid_mask :
  (((((Mahjong.CartesianData00V19.v69 = Mahjong.CartesianMathV19.pad 4 26 393 2 5 9 Mahjong.CartesianData00V19.v66 ∧
  Mahjong.CartesianData00V19.v67 = (Mahjong.CartesianMathV19.permute 16 (List.cons (0,2) (List.cons (1,3) (List.cons (2,4) (List.cons (3,5) (List.cons (4,6) (List.cons (5,7) (List.cons (6,8) (List.cons (7,9) (List.cons (8,10) (List.cons (9,11) (List.cons (10,12) (List.cons (11,13) (List.cons (12,14) (List.cons (13,15) List.nil)))))))))))))) Mahjong.CartesianData00V19.v69)) ∧
  (Mahjong.CartesianData00V19.v68 = (Mahjong.CartesianMathV19.permute 16 (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,12) (List.cons (12,13) (List.cons (13,14) (List.cons (14,15) List.nil))))))))))))) Mahjong.CartesianData00V19.v69) ∧
  (Mahjong.CartesianData00V19.v73 = Mahjong.CartesianMathV19.pad 5 26 393 3 5 9 Mahjong.CartesianData00V19.v70 ∧
  Mahjong.CartesianData00V19.v71 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,16) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData00V19.v73)))) ∧
  ((Mahjong.CartesianData00V19.v72 = (Mahjong.CartesianMathV19.permute 17 (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,13) (List.cons (13,14) (List.cons (14,15) (List.cons (15,16) List.nil))))))))))))) Mahjong.CartesianData00V19.v73) ∧
  (Mahjong.CartesianData00V19.v77 = Mahjong.CartesianMathV19.pad 2 26 393 1 5 9 Mahjong.CartesianData00V19.v74 ∧
  Mahjong.CartesianData00V19.v75 = (Mahjong.CartesianMathV19.permute 15 (List.cons (0,1) (List.cons (1,2) (List.cons (2,3) (List.cons (3,4) (List.cons (4,5) (List.cons (5,6) (List.cons (6,7) (List.cons (7,8) (List.cons (8,9) (List.cons (9,10) (List.cons (10,11) (List.cons (11,12) (List.cons (12,13) (List.cons (13,14) List.nil)))))))))))))) Mahjong.CartesianData00V19.v77))) ∧
  (Mahjong.CartesianData00V19.v76 = (Mahjong.CartesianMathV19.permute 15 (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,11) (List.cons (11,12) (List.cons (12,13) (List.cons (13,14) List.nil))))))))))))) Mahjong.CartesianData00V19.v77) ∧
  (Mahjong.CartesianData00V19.v81 = Mahjong.CartesianMathV19.pad 6 26 393 3 5 9 Mahjong.CartesianData00V19.v78 ∧
  Mahjong.CartesianData00V19.v79 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,16) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData00V19.v81))))) ∧
  (((Mahjong.CartesianData00V19.v80 = (Mahjong.CartesianMathV19.permute 17 (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,13) (List.cons (13,14) (List.cons (14,15) (List.cons (15,16) List.nil))))))))))))) Mahjong.CartesianData00V19.v81) ∧
  (Mahjong.CartesianData00V19.v85 = Mahjong.CartesianMathV19.pad 6 26 393 3 5 9 Mahjong.CartesianData00V19.v82 ∧
  Mahjong.CartesianData00V19.v83 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,16) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData00V19.v85))) ∧
  (Mahjong.CartesianData00V19.v84 = (Mahjong.CartesianMathV19.permute 17 (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,13) (List.cons (13,14) (List.cons (14,15) (List.cons (15,16) List.nil))))))))))))) Mahjong.CartesianData00V19.v85) ∧
  (Mahjong.CartesianData00V19.v89 = Mahjong.CartesianMathV19.pad 4 393 243 2 9 8 Mahjong.CartesianData00V19.v86 ∧
  Mahjong.CartesianData00V19.v87 = (Mahjong.CartesianMathV19.permute 19 (List.cons (0,2) (List.cons (1,3) (List.cons (2,4) (List.cons (3,5) (List.cons (4,6) (List.cons (5,7) (List.cons (6,8) (List.cons (7,9) (List.cons (8,10) (List.cons (9,11) (List.cons (10,12) (List.cons (11,13) (List.cons (12,14) (List.cons (13,15) (List.cons (14,16) (List.cons (15,17) (List.cons (16,18) (List.cons (17,18) List.nil)))))))))))))))))) Mahjong.CartesianData00V19.v89)))) ∧
  ((Mahjong.CartesianData00V19.v88 = (Mahjong.CartesianMathV19.permute 19 (List.cons (2,11) (List.cons (3,12) (List.cons (4,13) (List.cons (5,14) (List.cons (6,15) (List.cons (7,16) (List.cons (8,17) (List.cons (9,18) (List.cons (10,11) (List.cons (11,12) (List.cons (12,13) (List.cons (13,14) (List.cons (14,15) (List.cons (15,16) (List.cons (16,17) (List.cons (17,18) List.nil)))))))))))))))) Mahjong.CartesianData00V19.v89) ∧
  (Mahjong.CartesianData00V19.v93 = Mahjong.CartesianMathV19.pad 4 393 3 2 9 2 Mahjong.CartesianData00V19.v90 ∧
  Mahjong.CartesianData00V19.v91 = (Mahjong.CartesianMathV19.permute 13 (List.cons (0,2) (List.cons (1,3) (List.cons (2,4) (List.cons (3,5) (List.cons (4,6) (List.cons (5,7) (List.cons (6,8) (List.cons (7,9) (List.cons (8,10) (List.cons (9,11) (List.cons (10,12) (List.cons (11,12) List.nil)))))))))))) Mahjong.CartesianData00V19.v93))) ∧
  (Mahjong.CartesianData00V19.v92 = (Mahjong.CartesianMathV19.permute 13 (List.cons (2,11) (List.cons (3,12) (List.cons (4,11) (List.cons (5,12) (List.cons (6,11) (List.cons (7,12) (List.cons (8,11) (List.cons (9,12) (List.cons (10,11) (List.cons (11,12) List.nil)))))))))) Mahjong.CartesianData00V19.v93) ∧
  (Mahjong.CartesianData00V19.v97 = Mahjong.CartesianMathV19.pad 4 26 681 2 5 10 Mahjong.CartesianData00V19.v94 ∧
  Mahjong.CartesianData00V19.v95 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,2) (List.cons (1,3) (List.cons (2,4) (List.cons (3,5) (List.cons (4,6) (List.cons (5,7) (List.cons (6,8) (List.cons (7,9) (List.cons (8,10) (List.cons (9,11) (List.cons (10,12) (List.cons (11,13) (List.cons (12,14) (List.cons (13,15) (List.cons (14,16) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData00V19.v97)))))) ∧
  ((((Mahjong.CartesianData00V19.v96 = (Mahjong.CartesianMathV19.permute 17 (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) List.nil)))))))))) Mahjong.CartesianData00V19.v97) ∧
  Mahjong.CartesianData00V19.v101 = Mahjong.CartesianMathV19.pad 4 26 772 2 5 10 Mahjong.CartesianData00V19.v98) ∧
  (Mahjong.CartesianData00V19.v99 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,2) (List.cons (1,3) (List.cons (2,4) (List.cons (3,5) (List.cons (4,6) (List.cons (5,7) (List.cons (6,8) (List.cons (7,9) (List.cons (8,10) (List.cons (9,11) (List.cons (10,12) (List.cons (11,13) (List.cons (12,14) (List.cons (13,15) (List.cons (14,16) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData00V19.v101) ∧
  (Mahjong.CartesianData00V19.v100 = (Mahjong.CartesianMathV19.permute 17 (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) List.nil)))))))))) Mahjong.CartesianData00V19.v101) ∧
  Mahjong.CartesianData00V19.v105 = Mahjong.CartesianMathV19.pad 4 26 532 2 5 10 Mahjong.CartesianData00V19.v102))) ∧
  ((Mahjong.CartesianData00V19.v103 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,2) (List.cons (1,3) (List.cons (2,4) (List.cons (3,5) (List.cons (4,6) (List.cons (5,7) (List.cons (6,8) (List.cons (7,9) (List.cons (8,10) (List.cons (9,11) (List.cons (10,12) (List.cons (11,13) (List.cons (12,14) (List.cons (13,15) (List.cons (14,16) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData00V19.v105) ∧
  (Mahjong.CartesianData00V19.v104 = (Mahjong.CartesianMathV19.permute 17 (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) List.nil)))))))))) Mahjong.CartesianData00V19.v105) ∧
  Mahjong.CartesianData00V19.v109 = Mahjong.CartesianMathV19.pad 4 26 135 2 5 8 Mahjong.CartesianData00V19.v106)) ∧
  (Mahjong.CartesianData00V19.v107 = (Mahjong.CartesianMathV19.permute 15 (List.cons (0,2) (List.cons (1,3) (List.cons (2,4) (List.cons (3,5) (List.cons (4,6) (List.cons (5,7) (List.cons (6,8) (List.cons (7,9) (List.cons (8,10) (List.cons (9,11) (List.cons (10,12) (List.cons (11,13) (List.cons (12,14) (List.cons (13,14) List.nil)))))))))))))) Mahjong.CartesianData00V19.v109) ∧
  (Mahjong.CartesianData00V19.v108 = (Mahjong.CartesianMathV19.permute 15 (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,12) (List.cons (11,13) (List.cons (12,14) (List.cons (13,14) List.nil)))))))))))) Mahjong.CartesianData00V19.v109) ∧
  Mahjong.CartesianData00V19.v113 = Mahjong.CartesianMathV19.pad 4 26 3 2 5 2 Mahjong.CartesianData00V19.v110)))) ∧
  (((Mahjong.CartesianData00V19.v111 = (Mahjong.CartesianMathV19.permute 9 (List.cons (0,2) (List.cons (1,3) (List.cons (2,4) (List.cons (3,5) (List.cons (4,6) (List.cons (5,7) (List.cons (6,8) (List.cons (7,8) List.nil)))))))) Mahjong.CartesianData00V19.v113) ∧
  (Mahjong.CartesianData00V19.v112 = (Mahjong.CartesianMathV19.permute 9 (List.cons (2,7) (List.cons (3,8) (List.cons (4,7) (List.cons (5,8) (List.cons (6,7) (List.cons (7,8) List.nil)))))) Mahjong.CartesianData00V19.v113) ∧
  Mahjong.CartesianData00V19.v117 = Mahjong.CartesianMathV19.pad 4 26 190 2 5 8 Mahjong.CartesianData00V19.v114)) ∧
  (Mahjong.CartesianData00V19.v115 = (Mahjong.CartesianMathV19.permute 15 (List.cons (0,2) (List.cons (1,3) (List.cons (2,4) (List.cons (3,5) (List.cons (4,6) (List.cons (5,7) (List.cons (6,8) (List.cons (7,9) (List.cons (8,10) (List.cons (9,11) (List.cons (10,12) (List.cons (11,13) (List.cons (12,14) (List.cons (13,14) List.nil)))))))))))))) Mahjong.CartesianData00V19.v117) ∧
  (Mahjong.CartesianData00V19.v116 = (Mahjong.CartesianMathV19.permute 15 (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,12) (List.cons (11,13) (List.cons (12,14) (List.cons (13,14) List.nil)))))))))))) Mahjong.CartesianData00V19.v117) ∧
  Mahjong.CartesianData00V19.v121 = Mahjong.CartesianMathV19.pad 4 26 56 2 5 6 Mahjong.CartesianData00V19.v118))) ∧
  ((Mahjong.CartesianData00V19.v119 = (Mahjong.CartesianMathV19.permute 13 (List.cons (0,2) (List.cons (1,3) (List.cons (2,4) (List.cons (3,5) (List.cons (4,6) (List.cons (5,7) (List.cons (6,8) (List.cons (7,9) (List.cons (8,10) (List.cons (9,11) (List.cons (10,12) (List.cons (11,12) List.nil)))))))))))) Mahjong.CartesianData00V19.v121) ∧
  (Mahjong.CartesianData00V19.v120 = (Mahjong.CartesianMathV19.permute 13 (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,12) (List.cons (9,12) (List.cons (10,12) (List.cons (11,12) List.nil)))))))))) Mahjong.CartesianData00V19.v121) ∧
  Mahjong.CartesianData00V19.v125 = Mahjong.CartesianMathV19.pad 4 26 393 2 5 9 Mahjong.CartesianData00V19.v122)) ∧
  (Mahjong.CartesianData00V19.v123 = (Mahjong.CartesianMathV19.permute 16 (List.cons (0,2) (List.cons (1,3) (List.cons (2,4) (List.cons (3,5) (List.cons (4,6) (List.cons (5,7) (List.cons (6,8) (List.cons (7,9) (List.cons (8,10) (List.cons (9,11) (List.cons (10,12) (List.cons (11,13) (List.cons (12,14) (List.cons (13,15) List.nil)))))))))))))) Mahjong.CartesianData00V19.v125) ∧
  (Mahjong.CartesianData00V19.v124 = (Mahjong.CartesianMathV19.permute 16 (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,12) (List.cons (12,13) (List.cons (13,14) (List.cons (14,15) List.nil))))))))))))) Mahjong.CartesianData00V19.v125) ∧
  Mahjong.CartesianData00V19.v126 = Mahjong.CartesianMathV19.pad 4 26 393 2 5 9 (2^40872-1))))))) := by decide +kernel
end Mahjong.CartesianPrepB01V19
#print axioms Mahjong.CartesianPrepB01V19.every_layout_and_valid_mask
