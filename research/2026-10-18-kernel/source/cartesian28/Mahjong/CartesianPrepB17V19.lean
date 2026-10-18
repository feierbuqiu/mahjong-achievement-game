module
prelude
public import Mahjong.CartesianChannels12V19
import all Mahjong.CartesianChannels12V19
public import Mahjong.CartesianChannels17V19
import all Mahjong.CartesianChannels17V19
public import Mahjong.CartesianChannels18V19
import all Mahjong.CartesianChannels18V19
public import Mahjong.CartesianChannels19V19
import all Mahjong.CartesianChannels19V19
public import Mahjong.CartesianData00V19
import all Mahjong.CartesianData00V19
public import Mahjong.CartesianData04V19
import all Mahjong.CartesianData04V19
public import Mahjong.CartesianData05V19
import all Mahjong.CartesianData05V19
public import Mahjong.CartesianMathV19
import all Mahjong.CartesianMathV19
public section
set_option autoImplicit false
set_option synthInstance.maxSize 4096
set_option maxRecDepth 131072
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
namespace Mahjong.CartesianPrepB17V19
theorem every_layout_and_valid_mask :
  (((((Mahjong.CartesianData04V19.v169 = Mahjong.CartesianMathV19.pad 15 11 246 4 4 8 Mahjong.CartesianData04V19.v166 ∧
  Mahjong.CartesianData04V19.v167 = (Mahjong.CartesianMathV19.permute 16 (List.cons (0,4) (List.cons (1,5) (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) List.nil)))))))))))) Mahjong.CartesianData04V19.v169)) ∧
  (Mahjong.CartesianData04V19.v168 = (Mahjong.CartesianMathV19.permute 16 (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) List.nil)))))))) Mahjong.CartesianData04V19.v169) ∧
  Mahjong.CartesianData04V19.v173 = Mahjong.CartesianMathV19.pad 11 26 246 4 5 8 Mahjong.CartesianData04V19.v170)) ∧
  ((Mahjong.CartesianData04V19.v171 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,4) (List.cons (1,5) (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) (List.cons (12,16) (List.cons (13,16) (List.cons (14,16) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData04V19.v173) ∧
  Mahjong.CartesianData04V19.v172 = (Mahjong.CartesianMathV19.permute 17 (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,14) (List.cons (13,15) (List.cons (14,16) (List.cons (15,16) List.nil)))))))))))) Mahjong.CartesianData04V19.v173)) ∧
  (Mahjong.CartesianData04V19.v177 = Mahjong.CartesianMathV19.pad 11 9 246 4 4 8 Mahjong.CartesianData04V19.v174 ∧
  Mahjong.CartesianData04V19.v175 = (Mahjong.CartesianMathV19.permute 16 (List.cons (0,4) (List.cons (1,5) (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) List.nil)))))))))))) Mahjong.CartesianData04V19.v177)))) ∧
  (((Mahjong.CartesianData04V19.v176 = (Mahjong.CartesianMathV19.permute 16 (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) List.nil)))))))) Mahjong.CartesianData04V19.v177) ∧
  Mahjong.CartesianData04V19.v181 = Mahjong.CartesianMathV19.pad 11 11 246 4 4 8 Mahjong.CartesianData04V19.v178) ∧
  (Mahjong.CartesianData04V19.v179 = (Mahjong.CartesianMathV19.permute 16 (List.cons (0,4) (List.cons (1,5) (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) List.nil)))))))))))) Mahjong.CartesianData04V19.v181) ∧
  Mahjong.CartesianData04V19.v180 = (Mahjong.CartesianMathV19.permute 16 (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) List.nil)))))))) Mahjong.CartesianData04V19.v181))) ∧
  ((Mahjong.CartesianData04V19.v185 = Mahjong.CartesianMathV19.pad 11 8 246 4 3 8 Mahjong.CartesianData04V19.v182 ∧
  Mahjong.CartesianData04V19.v183 = (Mahjong.CartesianMathV19.permute 15 (List.cons (0,4) (List.cons (1,5) (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,12) (List.cons (12,13) (List.cons (13,14) List.nil)))))))))))))) Mahjong.CartesianData04V19.v185)) ∧
  (Mahjong.CartesianData04V19.v184 = (Mahjong.CartesianMathV19.permute 15 (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,13) (List.cons (13,14) List.nil)))))))))) Mahjong.CartesianData04V19.v185) ∧
  (Mahjong.CartesianData04V19.v189 = Mahjong.CartesianMathV19.pad 15 12 246 4 4 8 Mahjong.CartesianData04V19.v186 ∧
  Mahjong.CartesianData04V19.v187 = (Mahjong.CartesianMathV19.permute 16 (List.cons (0,4) (List.cons (1,5) (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) List.nil)))))))))))) Mahjong.CartesianData04V19.v189)))))) ∧
  ((((Mahjong.CartesianData04V19.v188 = (Mahjong.CartesianMathV19.permute 16 (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) List.nil)))))))) Mahjong.CartesianData04V19.v189) ∧
  Mahjong.CartesianData04V19.v193 = Mahjong.CartesianMathV19.pad 15 5 246 4 3 8 Mahjong.CartesianData04V19.v190) ∧
  (Mahjong.CartesianData04V19.v191 = (Mahjong.CartesianMathV19.permute 15 (List.cons (0,4) (List.cons (1,5) (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,12) (List.cons (12,13) (List.cons (13,14) List.nil)))))))))))))) Mahjong.CartesianData04V19.v193) ∧
  Mahjong.CartesianData04V19.v192 = (Mahjong.CartesianMathV19.permute 15 (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,13) (List.cons (13,14) List.nil)))))))))) Mahjong.CartesianData04V19.v193))) ∧
  ((Mahjong.CartesianData04V19.v197 = Mahjong.CartesianMathV19.pad 15 2 246 4 1 8 Mahjong.CartesianData04V19.v194 ∧
  Mahjong.CartesianData04V19.v195 = (Mahjong.CartesianMathV19.permute 13 (List.cons (0,4) (List.cons (1,5) (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,12) (List.cons (10,12) (List.cons (11,12) List.nil)))))))))))) Mahjong.CartesianData04V19.v197)) ∧
  (Mahjong.CartesianData04V19.v196 = (Mahjong.CartesianMathV19.permute 13 (List.cons (4,5) (List.cons (5,6) (List.cons (6,7) (List.cons (7,8) (List.cons (8,9) (List.cons (9,10) (List.cons (10,11) (List.cons (11,12) List.nil)))))))) Mahjong.CartesianData04V19.v197) ∧
  Mahjong.CartesianData04V19.v201 = Mahjong.CartesianMathV19.pad 15 11 189 4 4 8 Mahjong.CartesianData04V19.v198))) ∧
  (((Mahjong.CartesianData04V19.v199 = (Mahjong.CartesianMathV19.permute 16 (List.cons (0,4) (List.cons (1,5) (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) List.nil)))))))))))) Mahjong.CartesianData04V19.v201) ∧
  Mahjong.CartesianData04V19.v200 = (Mahjong.CartesianMathV19.permute 16 (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) List.nil)))))))) Mahjong.CartesianData04V19.v201)) ∧
  (Mahjong.CartesianData05V19.v2 = Mahjong.CartesianMathV19.pad 15 11 1397 4 4 11 Mahjong.CartesianData04V19.v202 ∧
  Mahjong.CartesianData05V19.v0 = (Mahjong.CartesianMathV19.permute 19 (List.cons (0,4) (List.cons (1,5) (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) (List.cons (12,16) (List.cons (13,17) (List.cons (14,18) (List.cons (15,16) (List.cons (16,17) (List.cons (17,18) List.nil)))))))))))))))))) Mahjong.CartesianData05V19.v2))) ∧
  ((Mahjong.CartesianData05V19.v1 = (Mahjong.CartesianMathV19.permute 19 (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) (List.cons (12,16) (List.cons (13,17) (List.cons (14,18) (List.cons (15,16) (List.cons (16,17) (List.cons (17,18) List.nil)))))))))))))) Mahjong.CartesianData05V19.v2) ∧
  Mahjong.CartesianData05V19.v6 = Mahjong.CartesianMathV19.pad 15 11 246 4 4 8 Mahjong.CartesianData05V19.v3) ∧
  (Mahjong.CartesianData05V19.v4 = (Mahjong.CartesianMathV19.permute 16 (List.cons (0,4) (List.cons (1,5) (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) List.nil)))))))))))) Mahjong.CartesianData05V19.v6) ∧
  (Mahjong.CartesianData05V19.v5 = (Mahjong.CartesianMathV19.permute 16 (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) List.nil)))))))) Mahjong.CartesianData05V19.v6) ∧
  Mahjong.CartesianData05V19.v7 = Mahjong.CartesianMathV19.pad 15 11 246 4 4 8 (2^40590-1))))))) := by decide +kernel
end Mahjong.CartesianPrepB17V19
#print axioms Mahjong.CartesianPrepB17V19.every_layout_and_valid_mask
