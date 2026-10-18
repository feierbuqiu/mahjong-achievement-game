module
prelude
public import Mahjong.CartesianChannels11V19
import all Mahjong.CartesianChannels11V19
public import Mahjong.CartesianData02V19
import all Mahjong.CartesianData02V19
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
namespace Mahjong.CartesianPrepB09V19
theorem every_layout_and_valid_mask :
  ((((Mahjong.CartesianData03V19.v1 = Mahjong.CartesianMathV19.pad 25 21 21 5 5 5 Mahjong.CartesianData02V19.v187 ∧
  (Mahjong.CartesianData02V19.v188 = (Mahjong.CartesianMathV19.permute 15 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) List.nil)))))))))) Mahjong.CartesianData03V19.v1) ∧
  Mahjong.CartesianData03V19.v0 = (Mahjong.CartesianMathV19.permute 15 (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) List.nil))))) Mahjong.CartesianData03V19.v1))) ∧
  (Mahjong.CartesianData03V19.v5 = Mahjong.CartesianMathV19.pad 21 21 22 5 5 5 Mahjong.CartesianData03V19.v2 ∧
  (Mahjong.CartesianData03V19.v3 = (Mahjong.CartesianMathV19.permute 15 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) List.nil)))))))))) Mahjong.CartesianData03V19.v5) ∧
  Mahjong.CartesianData03V19.v4 = (Mahjong.CartesianMathV19.permute 15 (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) List.nil))))) Mahjong.CartesianData03V19.v5)))) ∧
  ((Mahjong.CartesianData03V19.v9 = Mahjong.CartesianMathV19.pad 21 21 13 5 5 4 Mahjong.CartesianData03V19.v6 ∧
  (Mahjong.CartesianData03V19.v7 = (Mahjong.CartesianMathV19.permute 14 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,10) (List.cons (10,11) (List.cons (11,12) (List.cons (12,13) List.nil))))))))))))) Mahjong.CartesianData03V19.v9) ∧
  Mahjong.CartesianData03V19.v8 = (Mahjong.CartesianMathV19.permute 14 (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,10) (List.cons (10,11) (List.cons (11,12) (List.cons (12,13) List.nil)))))))) Mahjong.CartesianData03V19.v9))) ∧
  (Mahjong.CartesianData03V19.v13 = Mahjong.CartesianMathV19.pad 25 21 242 5 5 8 Mahjong.CartesianData03V19.v10 ∧
  (Mahjong.CartesianData03V19.v11 = (Mahjong.CartesianMathV19.permute 18 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,17) (List.cons (13,15) (List.cons (14,16) (List.cons (15,17) (List.cons (16,17) List.nil))))))))))))))))) Mahjong.CartesianData03V19.v13) ∧
  Mahjong.CartesianData03V19.v12 = (Mahjong.CartesianMathV19.permute 18 (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,17) (List.cons (13,15) (List.cons (14,16) (List.cons (15,17) (List.cons (16,17) List.nil)))))))))))) Mahjong.CartesianData03V19.v13))))) ∧
  (((Mahjong.CartesianData03V19.v17 = Mahjong.CartesianMathV19.pad 25 21 178 5 5 8 Mahjong.CartesianData03V19.v14 ∧
  (Mahjong.CartesianData03V19.v15 = (Mahjong.CartesianMathV19.permute 18 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,17) (List.cons (13,15) (List.cons (14,16) (List.cons (15,17) (List.cons (16,17) List.nil))))))))))))))))) Mahjong.CartesianData03V19.v17) ∧
  Mahjong.CartesianData03V19.v16 = (Mahjong.CartesianMathV19.permute 18 (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,17) (List.cons (13,15) (List.cons (14,16) (List.cons (15,17) (List.cons (16,17) List.nil)))))))))))) Mahjong.CartesianData03V19.v17))) ∧
  (Mahjong.CartesianData03V19.v21 = Mahjong.CartesianMathV19.pad 25 21 157 5 5 8 Mahjong.CartesianData03V19.v18 ∧
  (Mahjong.CartesianData03V19.v19 = (Mahjong.CartesianMathV19.permute 18 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,17) (List.cons (13,15) (List.cons (14,16) (List.cons (15,17) (List.cons (16,17) List.nil))))))))))))))))) Mahjong.CartesianData03V19.v21) ∧
  Mahjong.CartesianData03V19.v20 = (Mahjong.CartesianMathV19.permute 18 (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,17) (List.cons (13,15) (List.cons (14,16) (List.cons (15,17) (List.cons (16,17) List.nil)))))))))))) Mahjong.CartesianData03V19.v21)))) ∧
  ((Mahjong.CartesianData03V19.v25 = Mahjong.CartesianMathV19.pad 25 21 86 5 5 7 Mahjong.CartesianData03V19.v22 ∧
  (Mahjong.CartesianData03V19.v23 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,15) (List.cons (13,16) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData03V19.v25) ∧
  Mahjong.CartesianData03V19.v24 = (Mahjong.CartesianMathV19.permute 17 (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,15) (List.cons (13,16) (List.cons (14,15) (List.cons (15,16) List.nil))))))))))) Mahjong.CartesianData03V19.v25))) ∧
  ((Mahjong.CartesianData03V19.v29 = Mahjong.CartesianMathV19.pad 25 21 21 5 5 5 Mahjong.CartesianData03V19.v26 ∧
  Mahjong.CartesianData03V19.v27 = (Mahjong.CartesianMathV19.permute 15 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) List.nil)))))))))) Mahjong.CartesianData03V19.v29)) ∧
  (Mahjong.CartesianData03V19.v28 = (Mahjong.CartesianMathV19.permute 15 (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) List.nil))))) Mahjong.CartesianData03V19.v29) ∧
  Mahjong.CartesianData03V19.v30 = Mahjong.CartesianMathV19.pad 25 21 21 5 5 5 (2^11025-1)))))) := by decide +kernel
end Mahjong.CartesianPrepB09V19
#print axioms Mahjong.CartesianPrepB09V19.every_layout_and_valid_mask
