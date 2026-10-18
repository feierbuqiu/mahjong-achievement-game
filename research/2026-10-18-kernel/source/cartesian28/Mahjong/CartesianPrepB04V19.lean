module
prelude
public import Mahjong.CartesianChannels04V19
import all Mahjong.CartesianChannels04V19
public import Mahjong.CartesianChannels05V19
import all Mahjong.CartesianChannels05V19
public import Mahjong.CartesianChannels06V19
import all Mahjong.CartesianChannels06V19
public import Mahjong.CartesianChannels07V19
import all Mahjong.CartesianChannels07V19
public import Mahjong.CartesianData01V19
import all Mahjong.CartesianData01V19
public import Mahjong.CartesianMathV19
import all Mahjong.CartesianMathV19
public section
set_option autoImplicit false
set_option synthInstance.maxSize 4096
set_option maxRecDepth 131072
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
namespace Mahjong.CartesianPrepB04V19
theorem every_layout_and_valid_mask :
  (((((Mahjong.CartesianData01V19.v70 = Mahjong.CartesianMathV19.pad 21 13 231 5 4 8 Mahjong.CartesianData01V19.v67 ∧
  Mahjong.CartesianData01V19.v68 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,15) (List.cons (13,16) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData01V19.v70)) ∧
  (Mahjong.CartesianData01V19.v69 = (Mahjong.CartesianMathV19.permute 17 (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) (List.cons (12,16) List.nil)))))))) Mahjong.CartesianData01V19.v70) ∧
  (Mahjong.CartesianData01V19.v74 = Mahjong.CartesianMathV19.pad 30 13 231 5 4 8 Mahjong.CartesianData01V19.v71 ∧
  Mahjong.CartesianData01V19.v72 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,15) (List.cons (13,16) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData01V19.v74)))) ∧
  ((Mahjong.CartesianData01V19.v73 = (Mahjong.CartesianMathV19.permute 17 (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) (List.cons (12,16) List.nil)))))))) Mahjong.CartesianData01V19.v74) ∧
  (Mahjong.CartesianData01V19.v78 = Mahjong.CartesianMathV19.pad 12 13 231 4 4 8 Mahjong.CartesianData01V19.v75 ∧
  Mahjong.CartesianData01V19.v76 = (Mahjong.CartesianMathV19.permute 16 (List.cons (0,4) (List.cons (1,5) (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) List.nil)))))))))))) Mahjong.CartesianData01V19.v78))) ∧
  (Mahjong.CartesianData01V19.v77 = (Mahjong.CartesianMathV19.permute 16 (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) List.nil)))))))) Mahjong.CartesianData01V19.v78) ∧
  (Mahjong.CartesianData01V19.v82 = Mahjong.CartesianMathV19.pad 26 13 231 5 4 8 Mahjong.CartesianData01V19.v79 ∧
  Mahjong.CartesianData01V19.v80 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,15) (List.cons (13,16) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData01V19.v82))))) ∧
  (((Mahjong.CartesianData01V19.v81 = (Mahjong.CartesianMathV19.permute 17 (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) (List.cons (12,16) List.nil)))))))) Mahjong.CartesianData01V19.v82) ∧
  (Mahjong.CartesianData01V19.v86 = Mahjong.CartesianMathV19.pad 20 13 231 5 4 8 Mahjong.CartesianData01V19.v83 ∧
  Mahjong.CartesianData01V19.v84 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,15) (List.cons (13,16) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData01V19.v86))) ∧
  (Mahjong.CartesianData01V19.v85 = (Mahjong.CartesianMathV19.permute 17 (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) (List.cons (12,16) List.nil)))))))) Mahjong.CartesianData01V19.v86) ∧
  (Mahjong.CartesianData01V19.v90 = Mahjong.CartesianMathV19.pad 10 13 231 4 4 8 Mahjong.CartesianData01V19.v87 ∧
  Mahjong.CartesianData01V19.v88 = (Mahjong.CartesianMathV19.permute 16 (List.cons (0,4) (List.cons (1,5) (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) List.nil)))))))))))) Mahjong.CartesianData01V19.v90)))) ∧
  ((Mahjong.CartesianData01V19.v89 = (Mahjong.CartesianMathV19.permute 16 (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) List.nil)))))))) Mahjong.CartesianData01V19.v90) ∧
  (Mahjong.CartesianData01V19.v94 = Mahjong.CartesianMathV19.pad 21 5 231 5 3 8 Mahjong.CartesianData01V19.v91 ∧
  Mahjong.CartesianData01V19.v92 = (Mahjong.CartesianMathV19.permute 16 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,15) (List.cons (12,15) (List.cons (13,15) (List.cons (14,15) List.nil))))))))))))))) Mahjong.CartesianData01V19.v94))) ∧
  (Mahjong.CartesianData01V19.v93 = (Mahjong.CartesianMathV19.permute 16 (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,14) (List.cons (14,15) List.nil)))))))))) Mahjong.CartesianData01V19.v94) ∧
  (Mahjong.CartesianData01V19.v98 = Mahjong.CartesianMathV19.pad 21 1 231 5 0 8 Mahjong.CartesianData01V19.v95 ∧
  Mahjong.CartesianData01V19.v96 = (Mahjong.CartesianMathV19.permute 13 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,10) (List.cons (9,11) (List.cons (10,12) (List.cons (11,12) List.nil)))))))))))) Mahjong.CartesianData01V19.v98)))))) ∧
  ((((Mahjong.CartesianData01V19.v97 = (Mahjong.CartesianMathV19.permute 13 List.nil Mahjong.CartesianData01V19.v98) ∧
  Mahjong.CartesianData01V19.v102 = Mahjong.CartesianMathV19.pad 21 52 231 5 6 8 Mahjong.CartesianData01V19.v99) ∧
  (Mahjong.CartesianData01V19.v100 = (Mahjong.CartesianMathV19.permute 19 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,17) (List.cons (13,18) (List.cons (14,15) (List.cons (15,16) (List.cons (16,17) (List.cons (17,18) List.nil)))))))))))))))))) Mahjong.CartesianData01V19.v102) ∧
  (Mahjong.CartesianData01V19.v101 = (Mahjong.CartesianMathV19.permute 19 (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) (List.cons (10,16) (List.cons (11,17) (List.cons (12,18) (List.cons (13,17) (List.cons (14,18) (List.cons (15,17) (List.cons (16,18) List.nil)))))))))))) Mahjong.CartesianData01V19.v102) ∧
  Mahjong.CartesianData01V19.v106 = Mahjong.CartesianMathV19.pad 21 13 231 5 4 8 Mahjong.CartesianData01V19.v103))) ∧
  ((Mahjong.CartesianData01V19.v104 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,15) (List.cons (13,16) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData01V19.v106) ∧
  (Mahjong.CartesianData01V19.v105 = (Mahjong.CartesianMathV19.permute 17 (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) (List.cons (12,16) List.nil)))))))) Mahjong.CartesianData01V19.v106) ∧
  Mahjong.CartesianData01V19.v110 = Mahjong.CartesianMathV19.pad 21 13 302 5 4 9 Mahjong.CartesianData01V19.v107)) ∧
  (Mahjong.CartesianData01V19.v108 = (Mahjong.CartesianMathV19.permute 18 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,17) (List.cons (13,15) (List.cons (14,16) (List.cons (15,17) (List.cons (16,17) List.nil))))))))))))))))) Mahjong.CartesianData01V19.v110) ∧
  (Mahjong.CartesianData01V19.v109 = (Mahjong.CartesianMathV19.permute 18 (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) (List.cons (12,16) (List.cons (13,17) (List.cons (14,17) (List.cons (15,17) (List.cons (16,17) List.nil)))))))))))) Mahjong.CartesianData01V19.v110) ∧
  Mahjong.CartesianData01V19.v114 = Mahjong.CartesianMathV19.pad 21 13 38 5 4 6 Mahjong.CartesianData01V19.v111)))) ∧
  (((Mahjong.CartesianData01V19.v112 = (Mahjong.CartesianMathV19.permute 15 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) List.nil)))))))))) Mahjong.CartesianData01V19.v114) ∧
  (Mahjong.CartesianData01V19.v113 = (Mahjong.CartesianMathV19.permute 15 (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,13) (List.cons (12,14) List.nil)))))))) Mahjong.CartesianData01V19.v114) ∧
  Mahjong.CartesianData01V19.v118 = Mahjong.CartesianMathV19.pad 21 13 272 5 4 9 Mahjong.CartesianData01V19.v115)) ∧
  (Mahjong.CartesianData01V19.v116 = (Mahjong.CartesianMathV19.permute 18 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,17) (List.cons (13,15) (List.cons (14,16) (List.cons (15,17) (List.cons (16,17) List.nil))))))))))))))))) Mahjong.CartesianData01V19.v118) ∧
  (Mahjong.CartesianData01V19.v117 = (Mahjong.CartesianMathV19.permute 18 (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) (List.cons (12,16) (List.cons (13,17) (List.cons (14,17) (List.cons (15,17) (List.cons (16,17) List.nil)))))))))))) Mahjong.CartesianData01V19.v118) ∧
  Mahjong.CartesianData01V19.v122 = Mahjong.CartesianMathV19.pad 21 13 231 5 4 8 Mahjong.CartesianData01V19.v119))) ∧
  ((Mahjong.CartesianData01V19.v120 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,15) (List.cons (13,16) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData01V19.v122) ∧
  (Mahjong.CartesianData01V19.v121 = (Mahjong.CartesianMathV19.permute 17 (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) (List.cons (12,16) List.nil)))))))) Mahjong.CartesianData01V19.v122) ∧
  Mahjong.CartesianData01V19.v126 = Mahjong.CartesianMathV19.pad 21 13 231 5 4 8 Mahjong.CartesianData01V19.v123)) ∧
  (Mahjong.CartesianData01V19.v124 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,15) (List.cons (13,16) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData01V19.v126) ∧
  (Mahjong.CartesianData01V19.v125 = (Mahjong.CartesianMathV19.permute 17 (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) (List.cons (12,16) List.nil)))))))) Mahjong.CartesianData01V19.v126) ∧
  Mahjong.CartesianData01V19.v127 = Mahjong.CartesianMathV19.pad 21 13 231 5 4 8 (2^63063-1))))))) := by decide +kernel
end Mahjong.CartesianPrepB04V19
#print axioms Mahjong.CartesianPrepB04V19.every_layout_and_valid_mask
