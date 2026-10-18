module
prelude
public import Mahjong.CartesianChannels20V19
import all Mahjong.CartesianChannels20V19
public import Mahjong.CartesianChannels22V19
import all Mahjong.CartesianChannels22V19
public import Mahjong.CartesianChannels23V19
import all Mahjong.CartesianChannels23V19
public import Mahjong.CartesianData01V19
import all Mahjong.CartesianData01V19
public import Mahjong.CartesianData02V19
import all Mahjong.CartesianData02V19
public import Mahjong.CartesianData07V19
import all Mahjong.CartesianData07V19
public import Mahjong.CartesianMathV19
import all Mahjong.CartesianMathV19
public section
set_option autoImplicit false
set_option synthInstance.maxSize 4096
set_option maxRecDepth 131072
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
namespace Mahjong.CartesianPrepB24V19
theorem every_layout_and_valid_mask :
  (((((Mahjong.CartesianData07V19.v55 = Mahjong.CartesianMathV19.pad 29 5 332 5 3 9 Mahjong.CartesianData07V19.v52 ∧
  (Mahjong.CartesianData07V19.v53 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,15) (List.cons (13,16) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData07V19.v55) ∧
  Mahjong.CartesianData07V19.v54 = (Mahjong.CartesianMathV19.permute 17 (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,16) List.nil))))))))) Mahjong.CartesianData07V19.v55))) ∧
  (Mahjong.CartesianData07V19.v59 = Mahjong.CartesianMathV19.pad 53 5 332 6 3 9 Mahjong.CartesianData07V19.v56 ∧
  (Mahjong.CartesianData07V19.v57 = (Mahjong.CartesianMathV19.permute 18 (List.cons (0,6) (List.cons (1,7) (List.cons (2,8) (List.cons (3,9) (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) (List.cons (10,16) (List.cons (11,17) List.nil)))))))))))) Mahjong.CartesianData07V19.v59) ∧
  Mahjong.CartesianData07V19.v58 = (Mahjong.CartesianMathV19.permute 18 (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,16) (List.cons (14,17) List.nil))))))))) Mahjong.CartesianData07V19.v59)))) ∧
  ((Mahjong.CartesianData07V19.v63 = Mahjong.CartesianMathV19.pad 7 5 332 3 3 9 Mahjong.CartesianData07V19.v60 ∧
  (Mahjong.CartesianData07V19.v61 = (Mahjong.CartesianMathV19.permute 15 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) List.nil)))))))))))) Mahjong.CartesianData07V19.v63) ∧
  Mahjong.CartesianData07V19.v62 = (Mahjong.CartesianMathV19.permute 15 (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) List.nil))))))))) Mahjong.CartesianData07V19.v63))) ∧
  ((Mahjong.CartesianData07V19.v67 = Mahjong.CartesianMathV19.pad 21 5 332 5 3 9 Mahjong.CartesianData07V19.v64 ∧
  Mahjong.CartesianData07V19.v65 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,15) (List.cons (13,16) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData07V19.v67)) ∧
  (Mahjong.CartesianData07V19.v66 = (Mahjong.CartesianMathV19.permute 17 (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,16) List.nil))))))))) Mahjong.CartesianData07V19.v67) ∧
  Mahjong.CartesianData07V19.v71 = Mahjong.CartesianMathV19.pad 51 5 332 6 3 9 Mahjong.CartesianData07V19.v68)))) ∧
  (((Mahjong.CartesianData07V19.v69 = (Mahjong.CartesianMathV19.permute 18 (List.cons (0,6) (List.cons (1,7) (List.cons (2,8) (List.cons (3,9) (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) (List.cons (10,16) (List.cons (11,17) List.nil)))))))))))) Mahjong.CartesianData07V19.v71) ∧
  (Mahjong.CartesianData07V19.v70 = (Mahjong.CartesianMathV19.permute 18 (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,16) (List.cons (14,17) List.nil))))))))) Mahjong.CartesianData07V19.v71) ∧
  Mahjong.CartesianData07V19.v75 = Mahjong.CartesianMathV19.pad 38 5 332 6 3 9 Mahjong.CartesianData07V19.v72)) ∧
  ((Mahjong.CartesianData07V19.v73 = (Mahjong.CartesianMathV19.permute 18 (List.cons (0,6) (List.cons (1,7) (List.cons (2,8) (List.cons (3,9) (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) (List.cons (10,16) (List.cons (11,17) List.nil)))))))))))) Mahjong.CartesianData07V19.v75) ∧
  Mahjong.CartesianData07V19.v74 = (Mahjong.CartesianMathV19.permute 18 (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,16) (List.cons (14,17) List.nil))))))))) Mahjong.CartesianData07V19.v75)) ∧
  (Mahjong.CartesianData07V19.v79 = Mahjong.CartesianMathV19.pad 18 5 332 5 3 9 Mahjong.CartesianData07V19.v76 ∧
  Mahjong.CartesianData07V19.v77 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,15) (List.cons (13,16) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData07V19.v79)))) ∧
  ((Mahjong.CartesianData07V19.v78 = (Mahjong.CartesianMathV19.permute 17 (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,16) List.nil))))))))) Mahjong.CartesianData07V19.v79) ∧
  (Mahjong.CartesianData07V19.v83 = Mahjong.CartesianMathV19.pad 16 5 332 4 3 9 Mahjong.CartesianData07V19.v80 ∧
  Mahjong.CartesianData07V19.v81 = (Mahjong.CartesianMathV19.permute 16 (List.cons (0,4) (List.cons (1,5) (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) List.nil)))))))))))) Mahjong.CartesianData07V19.v83))) ∧
  ((Mahjong.CartesianData07V19.v82 = (Mahjong.CartesianMathV19.permute 16 (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) List.nil))))))))) Mahjong.CartesianData07V19.v83) ∧
  Mahjong.CartesianData07V19.v87 = Mahjong.CartesianMathV19.pad 8 5 332 3 3 9 Mahjong.CartesianData07V19.v84) ∧
  (Mahjong.CartesianData07V19.v85 = (Mahjong.CartesianMathV19.permute 15 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) List.nil)))))))))))) Mahjong.CartesianData07V19.v87) ∧
  Mahjong.CartesianData07V19.v86 = (Mahjong.CartesianMathV19.permute 15 (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) List.nil))))))))) Mahjong.CartesianData07V19.v87)))))) ∧
  ((((Mahjong.CartesianData07V19.v91 = Mahjong.CartesianMathV19.pad 29 16 332 5 4 9 Mahjong.CartesianData07V19.v88 ∧
  (Mahjong.CartesianData07V19.v89 = (Mahjong.CartesianMathV19.permute 18 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,17) (List.cons (13,15) (List.cons (14,16) (List.cons (15,17) (List.cons (16,17) List.nil))))))))))))))))) Mahjong.CartesianData07V19.v91) ∧
  Mahjong.CartesianData07V19.v90 = (Mahjong.CartesianMathV19.permute 18 (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) (List.cons (12,16) (List.cons (13,17) (List.cons (14,17) (List.cons (15,17) (List.cons (16,17) List.nil)))))))))))) Mahjong.CartesianData07V19.v91))) ∧
  ((Mahjong.CartesianData07V19.v95 = Mahjong.CartesianMathV19.pad 29 8 332 5 3 9 Mahjong.CartesianData07V19.v92 ∧
  Mahjong.CartesianData07V19.v93 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,15) (List.cons (13,16) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData07V19.v95)) ∧
  (Mahjong.CartesianData07V19.v94 = (Mahjong.CartesianMathV19.permute 17 (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,16) List.nil))))))))) Mahjong.CartesianData07V19.v95) ∧
  Mahjong.CartesianData07V19.v99 = Mahjong.CartesianMathV19.pad 29 5 86 5 3 7 Mahjong.CartesianData07V19.v96))) ∧
  ((Mahjong.CartesianData07V19.v97 = (Mahjong.CartesianMathV19.permute 15 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) List.nil)))))))))) Mahjong.CartesianData07V19.v99) ∧
  (Mahjong.CartesianData07V19.v98 = (Mahjong.CartesianMathV19.permute 15 (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,14) (List.cons (13,14) List.nil))))))))) Mahjong.CartesianData07V19.v99) ∧
  Mahjong.CartesianData07V19.v103 = Mahjong.CartesianMathV19.pad 29 5 30 5 3 5 Mahjong.CartesianData07V19.v100)) ∧
  ((Mahjong.CartesianData07V19.v101 = (Mahjong.CartesianMathV19.permute 13 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,10) (List.cons (9,11) (List.cons (10,12) (List.cons (11,12) List.nil)))))))))))) Mahjong.CartesianData07V19.v103) ∧
  Mahjong.CartesianData07V19.v102 = (Mahjong.CartesianMathV19.permute 13 (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,11) (List.cons (11,12) List.nil))))))) Mahjong.CartesianData07V19.v103)) ∧
  (Mahjong.CartesianData07V19.v107 = Mahjong.CartesianMathV19.pad 29 5 136 5 3 8 Mahjong.CartesianData07V19.v104 ∧
  Mahjong.CartesianData07V19.v105 = (Mahjong.CartesianMathV19.permute 16 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,15) (List.cons (12,15) (List.cons (13,15) (List.cons (14,15) List.nil))))))))))))))) Mahjong.CartesianData07V19.v107))))) ∧
  (((Mahjong.CartesianData07V19.v106 = (Mahjong.CartesianMathV19.permute 16 (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,14) (List.cons (14,15) List.nil)))))))))) Mahjong.CartesianData07V19.v107) ∧
  (Mahjong.CartesianData07V19.v111 = Mahjong.CartesianMathV19.pad 29 5 396 5 3 9 Mahjong.CartesianData07V19.v108 ∧
  Mahjong.CartesianData07V19.v109 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,15) (List.cons (13,16) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData07V19.v111))) ∧
  ((Mahjong.CartesianData07V19.v110 = (Mahjong.CartesianMathV19.permute 17 (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,16) List.nil))))))))) Mahjong.CartesianData07V19.v111) ∧
  Mahjong.CartesianData07V19.v115 = Mahjong.CartesianMathV19.pad 29 5 34 5 3 6 Mahjong.CartesianData07V19.v112) ∧
  (Mahjong.CartesianData07V19.v113 = (Mahjong.CartesianMathV19.permute 14 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,10) (List.cons (10,11) (List.cons (11,12) (List.cons (12,13) List.nil))))))))))))) Mahjong.CartesianData07V19.v115) ∧
  Mahjong.CartesianData07V19.v114 = (Mahjong.CartesianMathV19.permute 14 (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) List.nil)))))) Mahjong.CartesianData07V19.v115)))) ∧
  ((Mahjong.CartesianData07V19.v119 = Mahjong.CartesianMathV19.pad 29 5 45 5 3 6 Mahjong.CartesianData07V19.v116 ∧
  (Mahjong.CartesianData07V19.v117 = (Mahjong.CartesianMathV19.permute 14 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,10) (List.cons (10,11) (List.cons (11,12) (List.cons (12,13) List.nil))))))))))))) Mahjong.CartesianData07V19.v119) ∧
  Mahjong.CartesianData07V19.v118 = (Mahjong.CartesianMathV19.permute 14 (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) List.nil)))))) Mahjong.CartesianData07V19.v119))) ∧
  ((Mahjong.CartesianData07V19.v123 = Mahjong.CartesianMathV19.pad 29 5 332 5 3 9 Mahjong.CartesianData07V19.v120 ∧
  Mahjong.CartesianData07V19.v121 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,15) (List.cons (13,16) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData07V19.v123)) ∧
  (Mahjong.CartesianData07V19.v122 = (Mahjong.CartesianMathV19.permute 17 (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,16) List.nil))))))))) Mahjong.CartesianData07V19.v123) ∧
  Mahjong.CartesianData07V19.v124 = Mahjong.CartesianMathV19.pad 29 5 332 5 3 9 (2^48140-1))))))) := by decide +kernel
end Mahjong.CartesianPrepB24V19
#print axioms Mahjong.CartesianPrepB24V19.every_layout_and_valid_mask
