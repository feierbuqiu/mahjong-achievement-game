module
prelude
public import Mahjong.CartesianChannels01V19
import all Mahjong.CartesianChannels01V19
public import Mahjong.CartesianChannels02V19
import all Mahjong.CartesianChannels02V19
public import Mahjong.CartesianChannels20V19
import all Mahjong.CartesianChannels20V19
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
namespace Mahjong.CartesianPrepB20V19
theorem every_layout_and_valid_mask :
  ((((Mahjong.CartesianData06V19.v32 = Mahjong.CartesianMathV19.pad 17 8 393 5 3 9 Mahjong.CartesianData06V19.v29 ∧
  Mahjong.CartesianData06V19.v30 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,15) (List.cons (13,16) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData06V19.v32)) ∧
  (Mahjong.CartesianData06V19.v31 = (Mahjong.CartesianMathV19.permute 17 (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,16) List.nil))))))))) Mahjong.CartesianData06V19.v32) ∧
  (Mahjong.CartesianData06V19.v36 = Mahjong.CartesianMathV19.pad 11 8 393 4 3 9 Mahjong.CartesianData06V19.v33 ∧
  Mahjong.CartesianData06V19.v34 = (Mahjong.CartesianMathV19.permute 16 (List.cons (0,4) (List.cons (1,5) (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) List.nil)))))))))))) Mahjong.CartesianData06V19.v36)))) ∧
  ((Mahjong.CartesianData06V19.v35 = (Mahjong.CartesianMathV19.permute 16 (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) List.nil))))))))) Mahjong.CartesianData06V19.v36) ∧
  (Mahjong.CartesianData06V19.v40 = Mahjong.CartesianMathV19.pad 26 8 393 5 3 9 Mahjong.CartesianData06V19.v37 ∧
  Mahjong.CartesianData06V19.v38 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,15) (List.cons (13,16) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData06V19.v40))) ∧
  (Mahjong.CartesianData06V19.v39 = (Mahjong.CartesianMathV19.permute 17 (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,16) List.nil))))))))) Mahjong.CartesianData06V19.v40) ∧
  (Mahjong.CartesianData06V19.v44 = Mahjong.CartesianMathV19.pad 17 393 5 5 9 3 Mahjong.CartesianData06V19.v41 ∧
  Mahjong.CartesianData06V19.v42 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,15) (List.cons (13,16) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData06V19.v44))))) ∧
  (((Mahjong.CartesianData06V19.v43 = (Mahjong.CartesianMathV19.permute 17 (List.cons (5,14) (List.cons (6,15) (List.cons (7,16) (List.cons (8,14) (List.cons (9,15) (List.cons (10,16) (List.cons (11,14) (List.cons (12,15) (List.cons (13,16) List.nil))))))))) Mahjong.CartesianData06V19.v44) ∧
  Mahjong.CartesianData06V19.v48 = Mahjong.CartesianMathV19.pad 17 8 681 5 3 10 Mahjong.CartesianData06V19.v45) ∧
  (Mahjong.CartesianData06V19.v46 = (Mahjong.CartesianMathV19.permute 18 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,17) (List.cons (13,15) (List.cons (14,16) (List.cons (15,17) (List.cons (16,17) List.nil))))))))))))))))) Mahjong.CartesianData06V19.v48) ∧
  (Mahjong.CartesianData06V19.v47 = (Mahjong.CartesianMathV19.permute 18 (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,16) (List.cons (14,17) (List.cons (15,17) (List.cons (16,17) List.nil)))))))))))) Mahjong.CartesianData06V19.v48) ∧
  Mahjong.CartesianData06V19.v52 = Mahjong.CartesianMathV19.pad 17 8 772 5 3 10 Mahjong.CartesianData06V19.v49))) ∧
  ((Mahjong.CartesianData06V19.v50 = (Mahjong.CartesianMathV19.permute 18 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,17) (List.cons (13,15) (List.cons (14,16) (List.cons (15,17) (List.cons (16,17) List.nil))))))))))))))))) Mahjong.CartesianData06V19.v52) ∧
  (Mahjong.CartesianData06V19.v51 = (Mahjong.CartesianMathV19.permute 18 (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,16) (List.cons (14,17) (List.cons (15,17) (List.cons (16,17) List.nil)))))))))))) Mahjong.CartesianData06V19.v52) ∧
  Mahjong.CartesianData06V19.v56 = Mahjong.CartesianMathV19.pad 17 8 393 5 3 9 Mahjong.CartesianData06V19.v53)) ∧
  (Mahjong.CartesianData06V19.v54 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,15) (List.cons (13,16) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData06V19.v56) ∧
  (Mahjong.CartesianData06V19.v55 = (Mahjong.CartesianMathV19.permute 17 (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,16) List.nil))))))))) Mahjong.CartesianData06V19.v56) ∧
  Mahjong.CartesianData06V19.v57 = Mahjong.CartesianMathV19.pad 17 8 393 5 3 9 (2^53448-1)))))) := by decide +kernel
end Mahjong.CartesianPrepB20V19
#print axioms Mahjong.CartesianPrepB20V19.every_layout_and_valid_mask
