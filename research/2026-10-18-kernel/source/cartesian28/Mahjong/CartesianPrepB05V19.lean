module
prelude
public import Mahjong.CartesianChannels07V19
import all Mahjong.CartesianChannels07V19
public import Mahjong.CartesianChannels08V19
import all Mahjong.CartesianChannels08V19
public import Mahjong.CartesianData00V19
import all Mahjong.CartesianData00V19
public import Mahjong.CartesianData01V19
import all Mahjong.CartesianData01V19
public import Mahjong.CartesianData02V19
import all Mahjong.CartesianData02V19
public import Mahjong.CartesianMathV19
import all Mahjong.CartesianMathV19
public section
set_option autoImplicit false
set_option synthInstance.maxSize 4096
set_option maxRecDepth 131072
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
namespace Mahjong.CartesianPrepB05V19
theorem every_layout_and_valid_mask :
  ((((Mahjong.CartesianData01V19.v140 = Mahjong.CartesianMathV19.pad 6 242 28 3 8 5 Mahjong.CartesianData01V19.v137 ∧
  (Mahjong.CartesianData01V19.v138 = (Mahjong.CartesianMathV19.permute 16 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,15) (List.cons (14,15) List.nil))))))))))))))) Mahjong.CartesianData01V19.v140) ∧
  Mahjong.CartesianData01V19.v139 = (Mahjong.CartesianMathV19.permute 16 (List.cons (3,11) (List.cons (4,12) (List.cons (5,13) (List.cons (6,14) (List.cons (7,15) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,14) (List.cons (14,15) List.nil)))))))))))) Mahjong.CartesianData01V19.v140))) ∧
  ((Mahjong.CartesianData01V19.v144 = Mahjong.CartesianMathV19.pad 17 242 28 5 8 5 Mahjong.CartesianData01V19.v141 ∧
  Mahjong.CartesianData01V19.v142 = (Mahjong.CartesianMathV19.permute 18 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,17) (List.cons (13,15) (List.cons (14,16) (List.cons (15,17) (List.cons (16,17) List.nil))))))))))))))))) Mahjong.CartesianData01V19.v144)) ∧
  (Mahjong.CartesianData01V19.v143 = (Mahjong.CartesianMathV19.permute 18 (List.cons (5,13) (List.cons (6,14) (List.cons (7,15) (List.cons (8,16) (List.cons (9,17) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,16) (List.cons (14,17) (List.cons (15,16) (List.cons (16,17) List.nil)))))))))))) Mahjong.CartesianData01V19.v144) ∧
  Mahjong.CartesianData01V19.v148 = Mahjong.CartesianMathV19.pad 15 242 28 4 8 5 Mahjong.CartesianData01V19.v145))) ∧
  ((Mahjong.CartesianData01V19.v146 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,4) (List.cons (1,5) (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) (List.cons (12,16) (List.cons (13,16) (List.cons (14,16) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData01V19.v148) ∧
  (Mahjong.CartesianData01V19.v147 = (Mahjong.CartesianMathV19.permute 17 (List.cons (4,12) (List.cons (5,13) (List.cons (6,14) (List.cons (7,15) (List.cons (8,16) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,16) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))))) Mahjong.CartesianData01V19.v148) ∧
  Mahjong.CartesianData01V19.v152 = Mahjong.CartesianMathV19.pad 6 72 28 3 7 5 Mahjong.CartesianData01V19.v149)) ∧
  ((Mahjong.CartesianData01V19.v150 = (Mahjong.CartesianMathV19.permute 15 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) List.nil)))))))))))) Mahjong.CartesianData01V19.v152) ∧
  Mahjong.CartesianData01V19.v151 = (Mahjong.CartesianMathV19.permute 15 (List.cons (3,10) (List.cons (4,11) (List.cons (5,12) (List.cons (6,13) (List.cons (7,14) (List.cons (8,10) (List.cons (9,11) (List.cons (10,12) (List.cons (11,13) (List.cons (12,14) (List.cons (13,14) List.nil))))))))))) Mahjong.CartesianData01V19.v152)) ∧
  (Mahjong.CartesianData01V19.v156 = Mahjong.CartesianMathV19.pad 6 90 28 3 7 5 Mahjong.CartesianData01V19.v153 ∧
  Mahjong.CartesianData01V19.v154 = (Mahjong.CartesianMathV19.permute 15 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) List.nil)))))))))))) Mahjong.CartesianData01V19.v156))))) ∧
  (((Mahjong.CartesianData01V19.v155 = (Mahjong.CartesianMathV19.permute 15 (List.cons (3,10) (List.cons (4,11) (List.cons (5,12) (List.cons (6,13) (List.cons (7,14) (List.cons (8,10) (List.cons (9,11) (List.cons (10,12) (List.cons (11,13) (List.cons (12,14) (List.cons (13,14) List.nil))))))))))) Mahjong.CartesianData01V19.v156) ∧
  (Mahjong.CartesianData01V19.v160 = Mahjong.CartesianMathV19.pad 6 496 28 3 9 5 Mahjong.CartesianData01V19.v157 ∧
  Mahjong.CartesianData01V19.v158 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,16) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData01V19.v160))) ∧
  ((Mahjong.CartesianData01V19.v159 = (Mahjong.CartesianMathV19.permute 17 (List.cons (3,12) (List.cons (4,13) (List.cons (5,14) (List.cons (6,15) (List.cons (7,16) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) (List.cons (12,16) (List.cons (13,16) (List.cons (14,16) (List.cons (15,16) List.nil))))))))))))) Mahjong.CartesianData01V19.v160) ∧
  Mahjong.CartesianData01V19.v164 = Mahjong.CartesianMathV19.pad 6 97 28 3 7 5 Mahjong.CartesianData01V19.v161) ∧
  (Mahjong.CartesianData01V19.v162 = (Mahjong.CartesianMathV19.permute 15 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) List.nil)))))))))))) Mahjong.CartesianData01V19.v164) ∧
  Mahjong.CartesianData01V19.v163 = (Mahjong.CartesianMathV19.permute 15 (List.cons (3,10) (List.cons (4,11) (List.cons (5,12) (List.cons (6,13) (List.cons (7,14) (List.cons (8,10) (List.cons (9,11) (List.cons (10,12) (List.cons (11,13) (List.cons (12,14) (List.cons (13,14) List.nil))))))))))) Mahjong.CartesianData01V19.v164)))) ∧
  ((Mahjong.CartesianData02V19.v1 = Mahjong.CartesianMathV19.pad 6 242 376 3 8 9 Mahjong.CartesianData01V19.v165 ∧
  (Mahjong.CartesianData01V19.v166 = (Mahjong.CartesianMathV19.permute 20 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,16) (List.cons (14,17) (List.cons (15,18) (List.cons (16,19) (List.cons (17,18) (List.cons (18,19) List.nil))))))))))))))))))) Mahjong.CartesianData02V19.v1) ∧
  Mahjong.CartesianData02V19.v0 = (Mahjong.CartesianMathV19.permute 20 (List.cons (3,11) (List.cons (4,12) (List.cons (5,13) (List.cons (6,14) (List.cons (7,15) (List.cons (8,16) (List.cons (9,17) (List.cons (10,18) (List.cons (11,19) (List.cons (12,19) (List.cons (13,19) (List.cons (14,19) (List.cons (15,19) (List.cons (16,19) (List.cons (17,19) (List.cons (18,19) List.nil)))))))))))))))) Mahjong.CartesianData02V19.v1))) ∧
  ((Mahjong.CartesianData02V19.v5 = Mahjong.CartesianMathV19.pad 6 242 164 3 8 8 Mahjong.CartesianData02V19.v2 ∧
  Mahjong.CartesianData02V19.v3 = (Mahjong.CartesianMathV19.permute 19 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,16) (List.cons (14,17) (List.cons (15,18) (List.cons (16,18) (List.cons (17,18) List.nil)))))))))))))))))) Mahjong.CartesianData02V19.v5)) ∧
  (Mahjong.CartesianData02V19.v4 = (Mahjong.CartesianMathV19.permute 19 (List.cons (3,11) (List.cons (4,12) (List.cons (5,13) (List.cons (6,14) (List.cons (7,15) (List.cons (8,16) (List.cons (9,17) (List.cons (10,18) List.nil)))))))) Mahjong.CartesianData02V19.v5) ∧
  Mahjong.CartesianData02V19.v6 = Mahjong.CartesianMathV19.pad 6 242 28 3 8 5 (2^40656-1)))))) := by decide +kernel
end Mahjong.CartesianPrepB05V19
#print axioms Mahjong.CartesianPrepB05V19.every_layout_and_valid_mask
