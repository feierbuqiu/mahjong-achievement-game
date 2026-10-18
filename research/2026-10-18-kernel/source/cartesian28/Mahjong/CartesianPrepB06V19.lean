module
prelude
public import Mahjong.CartesianChannels08V19
import all Mahjong.CartesianChannels08V19
public import Mahjong.CartesianChannels09V19
import all Mahjong.CartesianChannels09V19
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
namespace Mahjong.CartesianPrepB06V19
theorem every_layout_and_valid_mask :
  ((((Mahjong.CartesianData02V19.v16 = Mahjong.CartesianMathV19.pad 10 50 90 4 6 7 Mahjong.CartesianData02V19.v13 ∧
  (Mahjong.CartesianData02V19.v14 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,4) (List.cons (1,5) (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) (List.cons (12,16) (List.cons (13,16) (List.cons (14,16) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData02V19.v16) ∧
  Mahjong.CartesianData02V19.v15 = (Mahjong.CartesianMathV19.permute 17 (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) (List.cons (10,16) (List.cons (11,16) (List.cons (12,16) (List.cons (13,16) (List.cons (14,16) (List.cons (15,16) List.nil)))))))))))) Mahjong.CartesianData02V19.v16))) ∧
  ((Mahjong.CartesianData02V19.v20 = Mahjong.CartesianMathV19.pad 3 50 90 2 6 7 Mahjong.CartesianData02V19.v17 ∧
  Mahjong.CartesianData02V19.v18 = (Mahjong.CartesianMathV19.permute 15 (List.cons (0,2) (List.cons (1,3) (List.cons (2,4) (List.cons (3,5) (List.cons (4,6) (List.cons (5,7) (List.cons (6,8) (List.cons (7,9) (List.cons (8,10) (List.cons (9,11) (List.cons (10,12) (List.cons (11,13) (List.cons (12,14) (List.cons (13,14) List.nil)))))))))))))) Mahjong.CartesianData02V19.v20)) ∧
  (Mahjong.CartesianData02V19.v19 = (Mahjong.CartesianMathV19.permute 15 (List.cons (2,8) (List.cons (3,9) (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,14) (List.cons (10,14) (List.cons (11,14) (List.cons (12,14) (List.cons (13,14) List.nil)))))))))))) Mahjong.CartesianData02V19.v20) ∧
  Mahjong.CartesianData02V19.v24 = Mahjong.CartesianMathV19.pad 1 50 90 0 6 7 Mahjong.CartesianData02V19.v21))) ∧
  ((Mahjong.CartesianData02V19.v22 = (Mahjong.CartesianMathV19.permute 13 List.nil Mahjong.CartesianData02V19.v24) ∧
  (Mahjong.CartesianData02V19.v23 = (Mahjong.CartesianMathV19.permute 13 (List.cons (0,6) (List.cons (1,7) (List.cons (2,8) (List.cons (3,9) (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,12) (List.cons (8,12) (List.cons (9,12) (List.cons (10,12) (List.cons (11,12) List.nil)))))))))))) Mahjong.CartesianData02V19.v24) ∧
  Mahjong.CartesianData02V19.v28 = Mahjong.CartesianMathV19.pad 25 50 90 5 6 7 Mahjong.CartesianData02V19.v25)) ∧
  ((Mahjong.CartesianData02V19.v26 = (Mahjong.CartesianMathV19.permute 18 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,17) (List.cons (13,15) (List.cons (14,16) (List.cons (15,17) (List.cons (16,17) List.nil))))))))))))))))) Mahjong.CartesianData02V19.v28) ∧
  Mahjong.CartesianData02V19.v27 = (Mahjong.CartesianMathV19.permute 18 (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) (List.cons (10,16) (List.cons (11,17) (List.cons (12,17) (List.cons (13,17) (List.cons (14,17) (List.cons (15,17) (List.cons (16,17) List.nil)))))))))))) Mahjong.CartesianData02V19.v28)) ∧
  (Mahjong.CartesianData02V19.v32 = Mahjong.CartesianMathV19.pad 16 50 90 4 6 7 Mahjong.CartesianData02V19.v29 ∧
  Mahjong.CartesianData02V19.v30 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,4) (List.cons (1,5) (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) (List.cons (12,16) (List.cons (13,16) (List.cons (14,16) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData02V19.v32))))) ∧
  (((Mahjong.CartesianData02V19.v31 = (Mahjong.CartesianMathV19.permute 17 (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) (List.cons (10,16) (List.cons (11,16) (List.cons (12,16) (List.cons (13,16) (List.cons (14,16) (List.cons (15,16) List.nil)))))))))))) Mahjong.CartesianData02V19.v32) ∧
  (Mahjong.CartesianData02V19.v36 = Mahjong.CartesianMathV19.pad 10 90 10 4 7 4 Mahjong.CartesianData02V19.v33 ∧
  Mahjong.CartesianData02V19.v34 = (Mahjong.CartesianMathV19.permute 15 (List.cons (0,4) (List.cons (1,5) (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,12) (List.cons (12,13) (List.cons (13,14) List.nil)))))))))))))) Mahjong.CartesianData02V19.v36))) ∧
  ((Mahjong.CartesianData02V19.v35 = (Mahjong.CartesianMathV19.permute 15 (List.cons (4,11) (List.cons (5,12) (List.cons (6,13) (List.cons (7,14) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,14) (List.cons (13,14) List.nil)))))))))) Mahjong.CartesianData02V19.v36) ∧
  Mahjong.CartesianData02V19.v40 = Mahjong.CartesianMathV19.pad 10 50 243 4 6 8 Mahjong.CartesianData02V19.v37) ∧
  (Mahjong.CartesianData02V19.v38 = (Mahjong.CartesianMathV19.permute 18 (List.cons (0,4) (List.cons (1,5) (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) (List.cons (12,16) (List.cons (13,17) (List.cons (14,16) (List.cons (15,17) List.nil)))))))))))))))) Mahjong.CartesianData02V19.v40) ∧
  Mahjong.CartesianData02V19.v39 = (Mahjong.CartesianMathV19.permute 18 (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) (List.cons (10,16) (List.cons (11,17) (List.cons (12,16) (List.cons (13,17) (List.cons (14,16) (List.cons (15,17) List.nil)))))))))))) Mahjong.CartesianData02V19.v40)))) ∧
  ((Mahjong.CartesianData02V19.v44 = Mahjong.CartesianMathV19.pad 10 50 302 4 6 9 Mahjong.CartesianData02V19.v41 ∧
  (Mahjong.CartesianData02V19.v42 = (Mahjong.CartesianMathV19.permute 19 (List.cons (0,4) (List.cons (1,5) (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) (List.cons (12,16) (List.cons (13,17) (List.cons (14,18) (List.cons (15,16) (List.cons (16,17) (List.cons (17,18) List.nil)))))))))))))))))) Mahjong.CartesianData02V19.v44) ∧
  Mahjong.CartesianData02V19.v43 = (Mahjong.CartesianMathV19.permute 19 (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) (List.cons (10,16) (List.cons (11,17) (List.cons (12,18) (List.cons (13,16) (List.cons (14,17) (List.cons (15,18) List.nil)))))))))))) Mahjong.CartesianData02V19.v44))) ∧
  ((Mahjong.CartesianData02V19.v48 = Mahjong.CartesianMathV19.pad 10 50 90 4 6 7 Mahjong.CartesianData02V19.v45 ∧
  Mahjong.CartesianData02V19.v46 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,4) (List.cons (1,5) (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) (List.cons (12,16) (List.cons (13,16) (List.cons (14,16) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData02V19.v48)) ∧
  (Mahjong.CartesianData02V19.v47 = (Mahjong.CartesianMathV19.permute 17 (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) (List.cons (10,16) (List.cons (11,16) (List.cons (12,16) (List.cons (13,16) (List.cons (14,16) (List.cons (15,16) List.nil)))))))))))) Mahjong.CartesianData02V19.v48) ∧
  Mahjong.CartesianData02V19.v49 = Mahjong.CartesianMathV19.pad 10 50 90 4 6 7 (2^45000-1)))))) := by decide +kernel
end Mahjong.CartesianPrepB06V19
#print axioms Mahjong.CartesianPrepB06V19.every_layout_and_valid_mask
