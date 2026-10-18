module
prelude
public import Mahjong.CartesianChannels05V19
import all Mahjong.CartesianChannels05V19
public import Mahjong.CartesianChannels09V19
import all Mahjong.CartesianChannels09V19
public import Mahjong.CartesianChannels21V19
import all Mahjong.CartesianChannels21V19
public import Mahjong.CartesianData01V19
import all Mahjong.CartesianData01V19
public import Mahjong.CartesianData02V19
import all Mahjong.CartesianData02V19
public import Mahjong.CartesianData06V19
import all Mahjong.CartesianData06V19
public import Mahjong.CartesianMathV19
import all Mahjong.CartesianMathV19
public section
set_option autoImplicit false
set_option synthInstance.maxSize 4096
set_option maxRecDepth 131072
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
namespace Mahjong.CartesianPrepB22V19
theorem every_layout_and_valid_mask :
  ((((Mahjong.CartesianData06V19.v96 = Mahjong.CartesianMathV19.pad 13 12 366 4 4 9 Mahjong.CartesianData06V19.v93 ∧
  (Mahjong.CartesianData06V19.v94 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,4) (List.cons (1,5) (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) (List.cons (12,16) (List.cons (13,16) (List.cons (14,16) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData06V19.v96) ∧
  Mahjong.CartesianData06V19.v95 = (Mahjong.CartesianMathV19.permute 17 (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) (List.cons (12,16) (List.cons (13,16) (List.cons (14,16) (List.cons (15,16) List.nil)))))))))))) Mahjong.CartesianData06V19.v96))) ∧
  (Mahjong.CartesianData06V19.v100 = Mahjong.CartesianMathV19.pad 12 5 366 4 3 9 Mahjong.CartesianData06V19.v97 ∧
  (Mahjong.CartesianData06V19.v98 = (Mahjong.CartesianMathV19.permute 16 (List.cons (0,4) (List.cons (1,5) (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) List.nil)))))))))))) Mahjong.CartesianData06V19.v100) ∧
  Mahjong.CartesianData06V19.v99 = (Mahjong.CartesianMathV19.permute 16 (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) List.nil))))))))) Mahjong.CartesianData06V19.v100)))) ∧
  ((Mahjong.CartesianData06V19.v104 = Mahjong.CartesianMathV19.pad 12 1 366 4 0 9 Mahjong.CartesianData06V19.v101 ∧
  (Mahjong.CartesianData06V19.v102 = (Mahjong.CartesianMathV19.permute 13 (List.cons (0,4) (List.cons (1,5) (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,12) (List.cons (10,12) (List.cons (11,12) List.nil)))))))))))) Mahjong.CartesianData06V19.v104) ∧
  Mahjong.CartesianData06V19.v103 = (Mahjong.CartesianMathV19.permute 13 List.nil Mahjong.CartesianData06V19.v104))) ∧
  (Mahjong.CartesianData06V19.v108 = Mahjong.CartesianMathV19.pad 13 22 366 4 5 9 Mahjong.CartesianData06V19.v105 ∧
  (Mahjong.CartesianData06V19.v106 = (Mahjong.CartesianMathV19.permute 18 (List.cons (0,4) (List.cons (1,5) (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) (List.cons (12,16) (List.cons (13,17) (List.cons (14,16) (List.cons (15,17) List.nil)))))))))))))))) Mahjong.CartesianData06V19.v108) ∧
  Mahjong.CartesianData06V19.v107 = (Mahjong.CartesianMathV19.permute 18 (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,17) (List.cons (13,14) (List.cons (14,15) (List.cons (15,16) (List.cons (16,17) List.nil))))))))))))) Mahjong.CartesianData06V19.v108))))) ∧
  (((Mahjong.CartesianData06V19.v112 = Mahjong.CartesianMathV19.pad 13 47 366 4 6 9 Mahjong.CartesianData06V19.v109 ∧
  (Mahjong.CartesianData06V19.v110 = (Mahjong.CartesianMathV19.permute 19 (List.cons (0,4) (List.cons (1,5) (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) (List.cons (12,16) (List.cons (13,17) (List.cons (14,18) (List.cons (15,16) (List.cons (16,17) (List.cons (17,18) List.nil)))))))))))))))))) Mahjong.CartesianData06V19.v112) ∧
  Mahjong.CartesianData06V19.v111 = (Mahjong.CartesianMathV19.permute 19 (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) (List.cons (10,16) (List.cons (11,17) (List.cons (12,18) (List.cons (13,16) (List.cons (14,17) (List.cons (15,18) List.nil)))))))))))) Mahjong.CartesianData06V19.v112))) ∧
  (Mahjong.CartesianData06V19.v116 = Mahjong.CartesianMathV19.pad 13 12 177 4 4 8 Mahjong.CartesianData06V19.v113 ∧
  (Mahjong.CartesianData06V19.v114 = (Mahjong.CartesianMathV19.permute 16 (List.cons (0,4) (List.cons (1,5) (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) List.nil)))))))))))) Mahjong.CartesianData06V19.v116) ∧
  Mahjong.CartesianData06V19.v115 = (Mahjong.CartesianMathV19.permute 16 (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) List.nil)))))))) Mahjong.CartesianData06V19.v116)))) ∧
  ((Mahjong.CartesianData06V19.v120 = Mahjong.CartesianMathV19.pad 13 12 88 4 4 7 Mahjong.CartesianData06V19.v117 ∧
  (Mahjong.CartesianData06V19.v118 = (Mahjong.CartesianMathV19.permute 15 (List.cons (0,4) (List.cons (1,5) (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,12) (List.cons (12,13) (List.cons (13,14) List.nil)))))))))))))) Mahjong.CartesianData06V19.v120) ∧
  Mahjong.CartesianData06V19.v119 = (Mahjong.CartesianMathV19.permute 15 (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,12) (List.cons (12,13) (List.cons (13,14) List.nil)))))))))) Mahjong.CartesianData06V19.v120))) ∧
  ((Mahjong.CartesianData06V19.v124 = Mahjong.CartesianMathV19.pad 13 12 366 4 4 9 Mahjong.CartesianData06V19.v121 ∧
  Mahjong.CartesianData06V19.v122 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,4) (List.cons (1,5) (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) (List.cons (12,16) (List.cons (13,16) (List.cons (14,16) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData06V19.v124)) ∧
  (Mahjong.CartesianData06V19.v123 = (Mahjong.CartesianMathV19.permute 17 (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) (List.cons (12,16) (List.cons (13,16) (List.cons (14,16) (List.cons (15,16) List.nil)))))))))))) Mahjong.CartesianData06V19.v124) ∧
  Mahjong.CartesianData06V19.v125 = Mahjong.CartesianMathV19.pad 13 12 366 4 4 9 (2^57096-1)))))) := by decide +kernel
end Mahjong.CartesianPrepB22V19
#print axioms Mahjong.CartesianPrepB22V19.every_layout_and_valid_mask
