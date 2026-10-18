module
prelude
public import Mahjong.CartesianChannels04V19
import all Mahjong.CartesianChannels04V19
public import Mahjong.CartesianChannels09V19
import all Mahjong.CartesianChannels09V19
public import Mahjong.CartesianChannels10V19
import all Mahjong.CartesianChannels10V19
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
namespace Mahjong.CartesianPrepB07V19
theorem every_layout_and_valid_mask :
  ((((Mahjong.CartesianData02V19.v61 = Mahjong.CartesianMathV19.pad 26 5 366 5 3 9 Mahjong.CartesianData02V19.v58 ∧
  Mahjong.CartesianData02V19.v59 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,15) (List.cons (13,16) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData02V19.v61)) ∧
  (Mahjong.CartesianData02V19.v60 = (Mahjong.CartesianMathV19.permute 17 (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,16) List.nil))))))))) Mahjong.CartesianData02V19.v61) ∧
  Mahjong.CartesianData02V19.v65 = Mahjong.CartesianMathV19.pad 12 5 366 4 3 9 Mahjong.CartesianData02V19.v62)) ∧
  ((Mahjong.CartesianData02V19.v63 = (Mahjong.CartesianMathV19.permute 16 (List.cons (0,4) (List.cons (1,5) (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) List.nil)))))))))))) Mahjong.CartesianData02V19.v65) ∧
  Mahjong.CartesianData02V19.v64 = (Mahjong.CartesianMathV19.permute 16 (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) List.nil))))))))) Mahjong.CartesianData02V19.v65)) ∧
  (Mahjong.CartesianData02V19.v69 = Mahjong.CartesianMathV19.pad 13 5 366 4 3 9 Mahjong.CartesianData02V19.v66 ∧
  (Mahjong.CartesianData02V19.v67 = (Mahjong.CartesianMathV19.permute 16 (List.cons (0,4) (List.cons (1,5) (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) List.nil)))))))))))) Mahjong.CartesianData02V19.v69) ∧
  Mahjong.CartesianData02V19.v68 = (Mahjong.CartesianMathV19.permute 16 (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) List.nil))))))))) Mahjong.CartesianData02V19.v69))))) ∧
  (((Mahjong.CartesianData02V19.v73 = Mahjong.CartesianMathV19.pad 26 5 177 5 3 8 Mahjong.CartesianData02V19.v70 ∧
  Mahjong.CartesianData02V19.v71 = (Mahjong.CartesianMathV19.permute 16 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,15) (List.cons (12,15) (List.cons (13,15) (List.cons (14,15) List.nil))))))))))))))) Mahjong.CartesianData02V19.v73)) ∧
  (Mahjong.CartesianData02V19.v72 = (Mahjong.CartesianMathV19.permute 16 (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,14) (List.cons (14,15) List.nil)))))))))) Mahjong.CartesianData02V19.v73) ∧
  (Mahjong.CartesianData02V19.v77 = Mahjong.CartesianMathV19.pad 26 5 276 5 3 9 Mahjong.CartesianData02V19.v74 ∧
  Mahjong.CartesianData02V19.v75 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,15) (List.cons (13,16) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData02V19.v77)))) ∧
  ((Mahjong.CartesianData02V19.v76 = (Mahjong.CartesianMathV19.permute 17 (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,16) List.nil))))))))) Mahjong.CartesianData02V19.v77) ∧
  Mahjong.CartesianData02V19.v81 = Mahjong.CartesianMathV19.pad 26 5 366 5 3 9 Mahjong.CartesianData02V19.v78) ∧
  (Mahjong.CartesianData02V19.v79 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,15) (List.cons (13,16) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData02V19.v81) ∧
  (Mahjong.CartesianData02V19.v80 = (Mahjong.CartesianMathV19.permute 17 (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,16) List.nil))))))))) Mahjong.CartesianData02V19.v81) ∧
  Mahjong.CartesianData02V19.v82 = Mahjong.CartesianMathV19.pad 26 5 366 5 3 9 (2^47580-1)))))) := by decide +kernel
end Mahjong.CartesianPrepB07V19
#print axioms Mahjong.CartesianPrepB07V19.every_layout_and_valid_mask
