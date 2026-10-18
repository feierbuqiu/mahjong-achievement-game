module
prelude
public import Mahjong.CartesianChannels00V19
import all Mahjong.CartesianChannels00V19
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
namespace Mahjong.CartesianPrepB00V19
theorem every_layout_and_valid_mask :
  ((((Mahjong.CartesianData00V19.v3 = Mahjong.CartesianMathV19.pad 7 47 100 3 6 7 Mahjong.CartesianData00V19.v0 ∧
  (Mahjong.CartesianData00V19.v1 = (Mahjong.CartesianMathV19.permute 16 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,15) (List.cons (14,15) List.nil))))))))))))))) Mahjong.CartesianData00V19.v3) ∧
  Mahjong.CartesianData00V19.v2 = (Mahjong.CartesianMathV19.permute 16 (List.cons (3,9) (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) (List.cons (10,15) (List.cons (11,15) (List.cons (12,15) (List.cons (13,15) (List.cons (14,15) List.nil)))))))))))) Mahjong.CartesianData00V19.v3))) ∧
  ((Mahjong.CartesianData00V19.v7 = Mahjong.CartesianMathV19.pad 8 47 100 3 6 7 Mahjong.CartesianData00V19.v4 ∧
  Mahjong.CartesianData00V19.v5 = (Mahjong.CartesianMathV19.permute 16 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,15) (List.cons (14,15) List.nil))))))))))))))) Mahjong.CartesianData00V19.v7)) ∧
  (Mahjong.CartesianData00V19.v6 = (Mahjong.CartesianMathV19.permute 16 (List.cons (3,9) (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) (List.cons (10,15) (List.cons (11,15) (List.cons (12,15) (List.cons (13,15) (List.cons (14,15) List.nil)))))))))))) Mahjong.CartesianData00V19.v7) ∧
  Mahjong.CartesianData00V19.v11 = Mahjong.CartesianMathV19.pad 22 47 100 5 6 7 Mahjong.CartesianData00V19.v8))) ∧
  (((Mahjong.CartesianData00V19.v9 = (Mahjong.CartesianMathV19.permute 18 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,17) (List.cons (13,15) (List.cons (14,16) (List.cons (15,17) (List.cons (16,17) List.nil))))))))))))))))) Mahjong.CartesianData00V19.v11) ∧
  Mahjong.CartesianData00V19.v10 = (Mahjong.CartesianMathV19.permute 18 (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) (List.cons (10,16) (List.cons (11,17) (List.cons (12,17) (List.cons (13,17) (List.cons (14,17) (List.cons (15,17) (List.cons (16,17) List.nil)))))))))))) Mahjong.CartesianData00V19.v11)) ∧
  (Mahjong.CartesianData00V19.v15 = Mahjong.CartesianMathV19.pad 10 47 100 4 6 7 Mahjong.CartesianData00V19.v12 ∧
  Mahjong.CartesianData00V19.v13 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,4) (List.cons (1,5) (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) (List.cons (12,16) (List.cons (13,16) (List.cons (14,16) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData00V19.v15))) ∧
  ((Mahjong.CartesianData00V19.v14 = (Mahjong.CartesianMathV19.permute 17 (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) (List.cons (10,16) (List.cons (11,16) (List.cons (12,16) (List.cons (13,16) (List.cons (14,16) (List.cons (15,16) List.nil)))))))))))) Mahjong.CartesianData00V19.v15) ∧
  Mahjong.CartesianData00V19.v19 = Mahjong.CartesianMathV19.pad 7 46 100 3 6 7 Mahjong.CartesianData00V19.v16) ∧
  (Mahjong.CartesianData00V19.v17 = (Mahjong.CartesianMathV19.permute 16 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,15) (List.cons (14,15) List.nil))))))))))))))) Mahjong.CartesianData00V19.v19) ∧
  Mahjong.CartesianData00V19.v18 = (Mahjong.CartesianMathV19.permute 16 (List.cons (3,9) (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) (List.cons (10,15) (List.cons (11,15) (List.cons (12,15) (List.cons (13,15) (List.cons (14,15) List.nil)))))))))))) Mahjong.CartesianData00V19.v19))))) ∧
  ((((Mahjong.CartesianData00V19.v23 = Mahjong.CartesianMathV19.pad 7 41 100 3 6 7 Mahjong.CartesianData00V19.v20 ∧
  Mahjong.CartesianData00V19.v21 = (Mahjong.CartesianMathV19.permute 16 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,15) (List.cons (14,15) List.nil))))))))))))))) Mahjong.CartesianData00V19.v23)) ∧
  (Mahjong.CartesianData00V19.v22 = (Mahjong.CartesianMathV19.permute 16 (List.cons (3,9) (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) (List.cons (10,15) (List.cons (11,15) (List.cons (12,15) (List.cons (13,15) (List.cons (14,15) List.nil)))))))))))) Mahjong.CartesianData00V19.v23) ∧
  Mahjong.CartesianData00V19.v27 = Mahjong.CartesianMathV19.pad 7 17 100 3 5 7 Mahjong.CartesianData00V19.v24)) ∧
  ((Mahjong.CartesianData00V19.v25 = (Mahjong.CartesianMathV19.permute 15 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) List.nil)))))))))))) Mahjong.CartesianData00V19.v27) ∧
  Mahjong.CartesianData00V19.v26 = (Mahjong.CartesianMathV19.permute 15 (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,13) (List.cons (11,14) (List.cons (12,13) (List.cons (13,14) List.nil))))))))))) Mahjong.CartesianData00V19.v27)) ∧
  (Mahjong.CartesianData00V19.v31 = Mahjong.CartesianMathV19.pad 7 4 100 3 2 7 Mahjong.CartesianData00V19.v28 ∧
  Mahjong.CartesianData00V19.v29 = (Mahjong.CartesianMathV19.permute 12 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) List.nil))))))))) Mahjong.CartesianData00V19.v31)))) ∧
  (((Mahjong.CartesianData00V19.v30 = (Mahjong.CartesianMathV19.permute 12 (List.cons (3,5) (List.cons (4,6) (List.cons (5,7) (List.cons (6,8) (List.cons (7,9) (List.cons (8,10) (List.cons (9,11) (List.cons (10,11) List.nil)))))))) Mahjong.CartesianData00V19.v31) ∧
  Mahjong.CartesianData00V19.v35 = Mahjong.CartesianMathV19.pad 7 47 64 3 6 6 Mahjong.CartesianData00V19.v32) ∧
  (Mahjong.CartesianData00V19.v33 = (Mahjong.CartesianMathV19.permute 15 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) List.nil)))))))))))) Mahjong.CartesianData00V19.v35) ∧
  Mahjong.CartesianData00V19.v34 = (Mahjong.CartesianMathV19.permute 15 (List.cons (3,9) (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) List.nil)))))) Mahjong.CartesianData00V19.v35))) ∧
  ((Mahjong.CartesianData00V19.v39 = Mahjong.CartesianMathV19.pad 7 47 100 3 6 7 Mahjong.CartesianData00V19.v36 ∧
  Mahjong.CartesianData00V19.v37 = (Mahjong.CartesianMathV19.permute 16 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,15) (List.cons (14,15) List.nil))))))))))))))) Mahjong.CartesianData00V19.v39)) ∧
  (Mahjong.CartesianData00V19.v38 = (Mahjong.CartesianMathV19.permute 16 (List.cons (3,9) (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) (List.cons (10,15) (List.cons (11,15) (List.cons (12,15) (List.cons (13,15) (List.cons (14,15) List.nil)))))))))))) Mahjong.CartesianData00V19.v39) ∧
  Mahjong.CartesianData00V19.v40 = Mahjong.CartesianMathV19.pad 7 47 100 3 6 7 (2^32900-1)))))) := by decide +kernel
end Mahjong.CartesianPrepB00V19
#print axioms Mahjong.CartesianPrepB00V19.every_layout_and_valid_mask
