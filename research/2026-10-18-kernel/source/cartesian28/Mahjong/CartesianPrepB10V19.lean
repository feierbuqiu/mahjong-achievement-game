module
prelude
public import Mahjong.CartesianChannels11V19
import all Mahjong.CartesianChannels11V19
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
namespace Mahjong.CartesianPrepB10V19
theorem every_layout_and_valid_mask :
  (((Mahjong.CartesianData03V19.v45 = Mahjong.CartesianMathV19.pad 18 18 10 5 5 4 Mahjong.CartesianData03V19.v42 ∧
  (Mahjong.CartesianData03V19.v43 = (Mahjong.CartesianMathV19.permute 14 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,10) (List.cons (10,11) (List.cons (11,12) (List.cons (12,13) List.nil))))))))))))) Mahjong.CartesianData03V19.v45) ∧
  Mahjong.CartesianData03V19.v44 = (Mahjong.CartesianMathV19.permute 14 (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,10) (List.cons (10,11) (List.cons (11,12) (List.cons (12,13) List.nil)))))))) Mahjong.CartesianData03V19.v45))) ∧
  (Mahjong.CartesianData03V19.v49 = Mahjong.CartesianMathV19.pad 18 58 10 5 6 4 Mahjong.CartesianData03V19.v46 ∧
  (Mahjong.CartesianData03V19.v47 = (Mahjong.CartesianMathV19.permute 15 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) List.nil)))))))))) Mahjong.CartesianData03V19.v49) ∧
  Mahjong.CartesianData03V19.v48 = (Mahjong.CartesianMathV19.permute 15 (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,11) (List.cons (10,12) (List.cons (11,13) (List.cons (12,14) List.nil)))))))) Mahjong.CartesianData03V19.v49)))) ∧
  ((Mahjong.CartesianData03V19.v53 = Mahjong.CartesianMathV19.pad 18 46 10 5 6 4 Mahjong.CartesianData03V19.v50 ∧
  (Mahjong.CartesianData03V19.v51 = (Mahjong.CartesianMathV19.permute 15 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) List.nil)))))))))) Mahjong.CartesianData03V19.v53) ∧
  Mahjong.CartesianData03V19.v52 = (Mahjong.CartesianMathV19.permute 15 (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,11) (List.cons (10,12) (List.cons (11,13) (List.cons (12,14) List.nil)))))))) Mahjong.CartesianData03V19.v53))) ∧
  ((Mahjong.CartesianData03V19.v57 = Mahjong.CartesianMathV19.pad 18 18 10 5 5 4 Mahjong.CartesianData03V19.v54 ∧
  Mahjong.CartesianData03V19.v55 = (Mahjong.CartesianMathV19.permute 14 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,10) (List.cons (10,11) (List.cons (11,12) (List.cons (12,13) List.nil))))))))))))) Mahjong.CartesianData03V19.v57)) ∧
  (Mahjong.CartesianData03V19.v56 = (Mahjong.CartesianMathV19.permute 14 (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,10) (List.cons (10,11) (List.cons (11,12) (List.cons (12,13) List.nil)))))))) Mahjong.CartesianData03V19.v57) ∧
  Mahjong.CartesianData03V19.v58 = Mahjong.CartesianMathV19.pad 18 18 10 5 5 4 (2^3240-1))))) := by decide +kernel
end Mahjong.CartesianPrepB10V19
#print axioms Mahjong.CartesianPrepB10V19.every_layout_and_valid_mask
