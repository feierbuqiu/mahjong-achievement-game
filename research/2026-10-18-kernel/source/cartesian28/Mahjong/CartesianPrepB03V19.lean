module
prelude
public import Mahjong.CartesianChannels05V19
import all Mahjong.CartesianChannels05V19
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
namespace Mahjong.CartesianPrepB03V19
theorem every_layout_and_valid_mask :
  ((((Mahjong.CartesianData01V19.v30 = Mahjong.CartesianMathV19.pad 29 38 41 5 6 6 Mahjong.CartesianData01V19.v27 ∧
  (Mahjong.CartesianData01V19.v28 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,15) (List.cons (13,16) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData01V19.v30) ∧
  Mahjong.CartesianData01V19.v29 = (Mahjong.CartesianMathV19.permute 17 (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) (List.cons (10,16) List.nil)))))) Mahjong.CartesianData01V19.v30))) ∧
  (Mahjong.CartesianData01V19.v34 = Mahjong.CartesianMathV19.pad 38 41 50 6 6 6 Mahjong.CartesianData01V19.v31 ∧
  (Mahjong.CartesianData01V19.v32 = (Mahjong.CartesianMathV19.permute 18 (List.cons (0,6) (List.cons (1,7) (List.cons (2,8) (List.cons (3,9) (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) (List.cons (10,16) (List.cons (11,17) List.nil)))))))))))) Mahjong.CartesianData01V19.v34) ∧
  Mahjong.CartesianData01V19.v33 = (Mahjong.CartesianMathV19.permute 18 (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) (List.cons (10,16) (List.cons (11,17) List.nil)))))) Mahjong.CartesianData01V19.v34)))) ∧
  ((Mahjong.CartesianData01V19.v38 = Mahjong.CartesianMathV19.pad 29 41 52 5 6 6 Mahjong.CartesianData01V19.v35 ∧
  (Mahjong.CartesianData01V19.v36 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,15) (List.cons (13,16) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData01V19.v38) ∧
  Mahjong.CartesianData01V19.v37 = (Mahjong.CartesianMathV19.permute 17 (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) (List.cons (10,16) List.nil)))))) Mahjong.CartesianData01V19.v38))) ∧
  (Mahjong.CartesianData01V19.v42 = Mahjong.CartesianMathV19.pad 29 41 16 5 6 4 Mahjong.CartesianData01V19.v39 ∧
  (Mahjong.CartesianData01V19.v40 = (Mahjong.CartesianMathV19.permute 15 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) List.nil)))))))))) Mahjong.CartesianData01V19.v42) ∧
  Mahjong.CartesianData01V19.v41 = (Mahjong.CartesianMathV19.permute 15 (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,11) (List.cons (10,12) (List.cons (11,13) (List.cons (12,14) List.nil)))))))) Mahjong.CartesianData01V19.v42))))) ∧
  (((Mahjong.CartesianData01V19.v46 = Mahjong.CartesianMathV19.pad 29 38 31 5 6 5 Mahjong.CartesianData01V19.v43 ∧
  (Mahjong.CartesianData01V19.v44 = (Mahjong.CartesianMathV19.permute 16 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,15) (List.cons (12,15) (List.cons (13,15) (List.cons (14,15) List.nil))))))))))))))) Mahjong.CartesianData01V19.v46) ∧
  Mahjong.CartesianData01V19.v45 = (Mahjong.CartesianMathV19.permute 16 (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) (List.cons (10,11) (List.cons (11,12) (List.cons (12,13) (List.cons (13,14) (List.cons (14,15) List.nil)))))))))) Mahjong.CartesianData01V19.v46))) ∧
  (Mahjong.CartesianData01V19.v50 = Mahjong.CartesianMathV19.pad 29 38 14 5 6 4 Mahjong.CartesianData01V19.v47 ∧
  (Mahjong.CartesianData01V19.v48 = (Mahjong.CartesianMathV19.permute 15 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) List.nil)))))))))) Mahjong.CartesianData01V19.v50) ∧
  Mahjong.CartesianData01V19.v49 = (Mahjong.CartesianMathV19.permute 15 (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,11) (List.cons (10,12) (List.cons (11,13) (List.cons (12,14) List.nil)))))))) Mahjong.CartesianData01V19.v50)))) ∧
  ((Mahjong.CartesianData01V19.v54 = Mahjong.CartesianMathV19.pad 29 38 4 5 6 2 Mahjong.CartesianData01V19.v51 ∧
  (Mahjong.CartesianData01V19.v52 = (Mahjong.CartesianMathV19.permute 13 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,10) (List.cons (9,11) (List.cons (10,12) (List.cons (11,12) List.nil)))))))))))) Mahjong.CartesianData01V19.v54) ∧
  Mahjong.CartesianData01V19.v53 = (Mahjong.CartesianMathV19.permute 13 (List.cons (5,11) (List.cons (6,12) (List.cons (7,11) (List.cons (8,12) (List.cons (9,11) (List.cons (10,12) List.nil)))))) Mahjong.CartesianData01V19.v54))) ∧
  ((Mahjong.CartesianData01V19.v58 = Mahjong.CartesianMathV19.pad 29 38 41 5 6 6 Mahjong.CartesianData01V19.v55 ∧
  Mahjong.CartesianData01V19.v56 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,15) (List.cons (13,16) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData01V19.v58)) ∧
  (Mahjong.CartesianData01V19.v57 = (Mahjong.CartesianMathV19.permute 17 (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) (List.cons (10,16) List.nil)))))) Mahjong.CartesianData01V19.v58) ∧
  Mahjong.CartesianData01V19.v59 = Mahjong.CartesianMathV19.pad 29 38 41 5 6 6 (2^45182-1)))))) := by decide +kernel
end Mahjong.CartesianPrepB03V19
#print axioms Mahjong.CartesianPrepB03V19.every_layout_and_valid_mask
