module
prelude
public import Mahjong.CartesianChannels12V19
import all Mahjong.CartesianChannels12V19
public import Mahjong.CartesianChannels13V19
import all Mahjong.CartesianChannels13V19
public import Mahjong.CartesianChannels14V19
import all Mahjong.CartesianChannels14V19
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
namespace Mahjong.CartesianPrepB12V19
theorem every_layout_and_valid_mask :
  (((((Mahjong.CartesianData03V19.v176 = Mahjong.CartesianMathV19.pad 6 15 206 3 4 8 Mahjong.CartesianData03V19.v173 ∧
  (Mahjong.CartesianData03V19.v174 = (Mahjong.CartesianMathV19.permute 15 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) List.nil)))))))))))) Mahjong.CartesianData03V19.v176) ∧
  Mahjong.CartesianData03V19.v175 = (Mahjong.CartesianMathV19.permute 15 (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) List.nil)))))))) Mahjong.CartesianData03V19.v176))) ∧
  ((Mahjong.CartesianData03V19.v180 = Mahjong.CartesianMathV19.pad 3 15 206 2 4 8 Mahjong.CartesianData03V19.v177 ∧
  Mahjong.CartesianData03V19.v178 = (Mahjong.CartesianMathV19.permute 14 (List.cons (0,2) (List.cons (1,3) (List.cons (2,4) (List.cons (3,5) (List.cons (4,6) (List.cons (5,7) (List.cons (6,8) (List.cons (7,9) (List.cons (8,10) (List.cons (9,11) (List.cons (10,12) (List.cons (11,13) List.nil)))))))))))) Mahjong.CartesianData03V19.v180)) ∧
  (Mahjong.CartesianData03V19.v179 = (Mahjong.CartesianMathV19.permute 14 (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) List.nil)))))))) Mahjong.CartesianData03V19.v180) ∧
  Mahjong.CartesianData03V19.v184 = Mahjong.CartesianMathV19.pad 17 15 206 5 4 8 Mahjong.CartesianData03V19.v181))) ∧
  ((Mahjong.CartesianData03V19.v182 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,15) (List.cons (13,16) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData03V19.v184) ∧
  (Mahjong.CartesianData03V19.v183 = (Mahjong.CartesianMathV19.permute 17 (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) (List.cons (12,16) List.nil)))))))) Mahjong.CartesianData03V19.v184) ∧
  Mahjong.CartesianData03V19.v188 = Mahjong.CartesianMathV19.pad 1 15 206 0 4 8 Mahjong.CartesianData03V19.v185)) ∧
  ((Mahjong.CartesianData03V19.v186 = (Mahjong.CartesianMathV19.permute 12 List.nil Mahjong.CartesianData03V19.v188) ∧
  Mahjong.CartesianData03V19.v187 = (Mahjong.CartesianMathV19.permute 12 (List.cons (0,4) (List.cons (1,5) (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) List.nil)))))))) Mahjong.CartesianData03V19.v188)) ∧
  (Mahjong.CartesianData03V19.v192 = Mahjong.CartesianMathV19.pad 15 15 206 4 4 8 Mahjong.CartesianData03V19.v189 ∧
  Mahjong.CartesianData03V19.v190 = (Mahjong.CartesianMathV19.permute 16 (List.cons (0,4) (List.cons (1,5) (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) List.nil)))))))))))) Mahjong.CartesianData03V19.v192))))) ∧
  (((Mahjong.CartesianData03V19.v191 = (Mahjong.CartesianMathV19.permute 16 (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) List.nil)))))))) Mahjong.CartesianData03V19.v192) ∧
  (Mahjong.CartesianData03V19.v196 = Mahjong.CartesianMathV19.pad 15 21 206 4 5 8 Mahjong.CartesianData03V19.v193 ∧
  Mahjong.CartesianData03V19.v194 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,4) (List.cons (1,5) (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) (List.cons (12,16) (List.cons (13,16) (List.cons (14,16) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData03V19.v196))) ∧
  ((Mahjong.CartesianData03V19.v195 = (Mahjong.CartesianMathV19.permute 17 (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,14) (List.cons (13,15) (List.cons (14,16) (List.cons (15,16) List.nil)))))))))))) Mahjong.CartesianData03V19.v196) ∧
  Mahjong.CartesianData03V19.v200 = Mahjong.CartesianMathV19.pad 6 26 206 3 5 8 Mahjong.CartesianData03V19.v197) ∧
  (Mahjong.CartesianData03V19.v198 = (Mahjong.CartesianMathV19.permute 16 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,15) (List.cons (14,15) List.nil))))))))))))))) Mahjong.CartesianData03V19.v200) ∧
  Mahjong.CartesianData03V19.v199 = (Mahjong.CartesianMathV19.permute 16 (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,13) (List.cons (12,14) (List.cons (13,15) (List.cons (14,15) List.nil)))))))))))) Mahjong.CartesianData03V19.v200)))) ∧
  (((Mahjong.CartesianData03V19.v204 = Mahjong.CartesianMathV19.pad 6 11 206 3 4 8 Mahjong.CartesianData03V19.v201 ∧
  Mahjong.CartesianData03V19.v202 = (Mahjong.CartesianMathV19.permute 15 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) List.nil)))))))))))) Mahjong.CartesianData03V19.v204)) ∧
  (Mahjong.CartesianData03V19.v203 = (Mahjong.CartesianMathV19.permute 15 (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) List.nil)))))))) Mahjong.CartesianData03V19.v204) ∧
  Mahjong.CartesianData03V19.v208 = Mahjong.CartesianMathV19.pad 6 26 206 3 5 8 Mahjong.CartesianData03V19.v205)) ∧
  ((Mahjong.CartesianData03V19.v206 = (Mahjong.CartesianMathV19.permute 16 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,15) (List.cons (14,15) List.nil))))))))))))))) Mahjong.CartesianData03V19.v208) ∧
  Mahjong.CartesianData03V19.v207 = (Mahjong.CartesianMathV19.permute 16 (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,13) (List.cons (12,14) (List.cons (13,15) (List.cons (14,15) List.nil)))))))))))) Mahjong.CartesianData03V19.v208)) ∧
  (Mahjong.CartesianData03V19.v212 = Mahjong.CartesianMathV19.pad 6 20 206 3 5 8 Mahjong.CartesianData03V19.v209 ∧
  Mahjong.CartesianData03V19.v210 = (Mahjong.CartesianMathV19.permute 16 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,15) (List.cons (14,15) List.nil))))))))))))))) Mahjong.CartesianData03V19.v212)))))) ∧
  ((((Mahjong.CartesianData03V19.v211 = (Mahjong.CartesianMathV19.permute 16 (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,13) (List.cons (12,14) (List.cons (13,15) (List.cons (14,15) List.nil)))))))))))) Mahjong.CartesianData03V19.v212) ∧
  (Mahjong.CartesianData03V19.v216 = Mahjong.CartesianMathV19.pad 6 15 1162 3 4 11 Mahjong.CartesianData03V19.v213 ∧
  Mahjong.CartesianData03V19.v214 = (Mahjong.CartesianMathV19.permute 18 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,16) (List.cons (14,17) List.nil))))))))))))))) Mahjong.CartesianData03V19.v216))) ∧
  ((Mahjong.CartesianData03V19.v215 = (Mahjong.CartesianMathV19.permute 18 (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) (List.cons (12,16) (List.cons (13,17) (List.cons (14,15) (List.cons (15,16) (List.cons (16,17) List.nil)))))))))))))) Mahjong.CartesianData03V19.v216) ∧
  Mahjong.CartesianData03V19.v220 = Mahjong.CartesianMathV19.pad 6 15 8 3 4 3 Mahjong.CartesianData03V19.v217) ∧
  (Mahjong.CartesianData03V19.v218 = (Mahjong.CartesianMathV19.permute 10 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,9) (List.cons (8,9) List.nil))))))))) Mahjong.CartesianData03V19.v220) ∧
  Mahjong.CartesianData03V19.v219 = (Mahjong.CartesianMathV19.permute 10 (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,7) (List.cons (7,8) (List.cons (8,9) List.nil)))))) Mahjong.CartesianData03V19.v220)))) ∧
  ((Mahjong.CartesianData03V19.v224 = Mahjong.CartesianMathV19.pad 6 15 1543 3 4 11 Mahjong.CartesianData03V19.v221 ∧
  (Mahjong.CartesianData03V19.v222 = (Mahjong.CartesianMathV19.permute 18 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,16) (List.cons (14,17) List.nil))))))))))))))) Mahjong.CartesianData03V19.v224) ∧
  Mahjong.CartesianData03V19.v223 = (Mahjong.CartesianMathV19.permute 18 (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) (List.cons (12,16) (List.cons (13,17) (List.cons (14,15) (List.cons (15,16) (List.cons (16,17) List.nil)))))))))))))) Mahjong.CartesianData03V19.v224))) ∧
  ((Mahjong.CartesianData03V19.v228 = Mahjong.CartesianMathV19.pad 6 15 175 3 4 8 Mahjong.CartesianData03V19.v225 ∧
  Mahjong.CartesianData03V19.v226 = (Mahjong.CartesianMathV19.permute 15 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) List.nil)))))))))))) Mahjong.CartesianData03V19.v228)) ∧
  (Mahjong.CartesianData03V19.v227 = (Mahjong.CartesianMathV19.permute 15 (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) List.nil)))))))) Mahjong.CartesianData03V19.v228) ∧
  Mahjong.CartesianData03V19.v232 = Mahjong.CartesianMathV19.pad 6 15 360 3 4 9 Mahjong.CartesianData03V19.v229)))) ∧
  (((Mahjong.CartesianData03V19.v230 = (Mahjong.CartesianMathV19.permute 16 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,15) (List.cons (14,15) List.nil))))))))))))))) Mahjong.CartesianData03V19.v232) ∧
  (Mahjong.CartesianData03V19.v231 = (Mahjong.CartesianMathV19.permute 16 (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) (List.cons (12,15) (List.cons (13,15) (List.cons (14,15) List.nil)))))))))))) Mahjong.CartesianData03V19.v232) ∧
  Mahjong.CartesianData03V19.v236 = Mahjong.CartesianMathV19.pad 6 15 156 3 4 8 Mahjong.CartesianData03V19.v233)) ∧
  ((Mahjong.CartesianData03V19.v234 = (Mahjong.CartesianMathV19.permute 15 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) List.nil)))))))))))) Mahjong.CartesianData03V19.v236) ∧
  Mahjong.CartesianData03V19.v235 = (Mahjong.CartesianMathV19.permute 15 (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) List.nil)))))))) Mahjong.CartesianData03V19.v236)) ∧
  (Mahjong.CartesianData03V19.v240 = Mahjong.CartesianMathV19.pad 6 15 59 3 4 6 Mahjong.CartesianData03V19.v237 ∧
  Mahjong.CartesianData03V19.v238 = (Mahjong.CartesianMathV19.permute 13 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,12) (List.cons (11,12) List.nil)))))))))))) Mahjong.CartesianData03V19.v240)))) ∧
  (((Mahjong.CartesianData03V19.v239 = (Mahjong.CartesianMathV19.permute 13 (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,11) (List.cons (10,12) List.nil)))))))) Mahjong.CartesianData03V19.v240) ∧
  Mahjong.CartesianData03V19.v244 = Mahjong.CartesianMathV19.pad 6 15 206 3 4 8 Mahjong.CartesianData03V19.v241) ∧
  (Mahjong.CartesianData03V19.v242 = (Mahjong.CartesianMathV19.permute 15 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) List.nil)))))))))))) Mahjong.CartesianData03V19.v244) ∧
  Mahjong.CartesianData03V19.v243 = (Mahjong.CartesianMathV19.permute 15 (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) List.nil)))))))) Mahjong.CartesianData03V19.v244))) ∧
  ((Mahjong.CartesianData03V19.v248 = Mahjong.CartesianMathV19.pad 6 15 206 3 4 8 Mahjong.CartesianData03V19.v245 ∧
  Mahjong.CartesianData03V19.v246 = (Mahjong.CartesianMathV19.permute 15 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) List.nil)))))))))))) Mahjong.CartesianData03V19.v248)) ∧
  (Mahjong.CartesianData03V19.v247 = (Mahjong.CartesianMathV19.permute 15 (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) List.nil)))))))) Mahjong.CartesianData03V19.v248) ∧
  Mahjong.CartesianData03V19.v249 = Mahjong.CartesianMathV19.pad 6 15 206 3 4 8 (2^18540-1))))))) := by decide +kernel
end Mahjong.CartesianPrepB12V19
#print axioms Mahjong.CartesianPrepB12V19.every_layout_and_valid_mask
