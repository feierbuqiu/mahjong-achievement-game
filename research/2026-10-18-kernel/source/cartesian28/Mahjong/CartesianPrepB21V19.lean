module
prelude
public import Mahjong.CartesianChannels04V19
import all Mahjong.CartesianChannels04V19
public import Mahjong.CartesianChannels21V19
import all Mahjong.CartesianChannels21V19
public import Mahjong.CartesianData01V19
import all Mahjong.CartesianData01V19
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
namespace Mahjong.CartesianPrepB21V19
theorem every_layout_and_valid_mask :
  ((((Mahjong.CartesianData06V19.v62 = Mahjong.CartesianMathV19.pad 26 38 37 5 6 6 Mahjong.CartesianData06V19.v59 ∧
  (Mahjong.CartesianData06V19.v60 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,15) (List.cons (13,16) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData06V19.v62) ∧
  Mahjong.CartesianData06V19.v61 = (Mahjong.CartesianMathV19.permute 17 (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) (List.cons (10,16) List.nil)))))) Mahjong.CartesianData06V19.v62))) ∧
  (Mahjong.CartesianData06V19.v66 = Mahjong.CartesianMathV19.pad 13 38 37 4 6 6 Mahjong.CartesianData06V19.v63 ∧
  (Mahjong.CartesianData06V19.v64 = (Mahjong.CartesianMathV19.permute 16 (List.cons (0,4) (List.cons (1,5) (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) List.nil)))))))))))) Mahjong.CartesianData06V19.v66) ∧
  Mahjong.CartesianData06V19.v65 = (Mahjong.CartesianMathV19.permute 16 (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) List.nil)))))) Mahjong.CartesianData06V19.v66)))) ∧
  ((Mahjong.CartesianData06V19.v70 = Mahjong.CartesianMathV19.pad 13 38 37 4 6 6 Mahjong.CartesianData06V19.v67 ∧
  (Mahjong.CartesianData06V19.v68 = (Mahjong.CartesianMathV19.permute 16 (List.cons (0,4) (List.cons (1,5) (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) List.nil)))))))))))) Mahjong.CartesianData06V19.v70) ∧
  Mahjong.CartesianData06V19.v69 = (Mahjong.CartesianMathV19.permute 16 (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) List.nil)))))) Mahjong.CartesianData06V19.v70))) ∧
  (Mahjong.CartesianData06V19.v74 = Mahjong.CartesianMathV19.pad 9 38 37 4 6 6 Mahjong.CartesianData06V19.v71 ∧
  (Mahjong.CartesianData06V19.v72 = (Mahjong.CartesianMathV19.permute 16 (List.cons (0,4) (List.cons (1,5) (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) List.nil)))))))))))) Mahjong.CartesianData06V19.v74) ∧
  Mahjong.CartesianData06V19.v73 = (Mahjong.CartesianMathV19.permute 16 (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) List.nil)))))) Mahjong.CartesianData06V19.v74))))) ∧
  (((Mahjong.CartesianData06V19.v78 = Mahjong.CartesianMathV19.pad 26 37 100 5 6 7 Mahjong.CartesianData06V19.v75 ∧
  (Mahjong.CartesianData06V19.v76 = (Mahjong.CartesianMathV19.permute 18 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,17) (List.cons (13,15) (List.cons (14,16) (List.cons (15,17) (List.cons (16,17) List.nil))))))))))))))))) Mahjong.CartesianData06V19.v78) ∧
  Mahjong.CartesianData06V19.v77 = (Mahjong.CartesianMathV19.permute 18 (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) (List.cons (10,16) (List.cons (11,17) (List.cons (12,17) (List.cons (13,17) (List.cons (14,17) (List.cons (15,17) (List.cons (16,17) List.nil)))))))))))) Mahjong.CartesianData06V19.v78))) ∧
  (Mahjong.CartesianData06V19.v82 = Mahjong.CartesianMathV19.pad 26 37 173 5 6 8 Mahjong.CartesianData06V19.v79 ∧
  (Mahjong.CartesianData06V19.v80 = (Mahjong.CartesianMathV19.permute 19 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,17) (List.cons (13,18) (List.cons (14,15) (List.cons (15,16) (List.cons (16,17) (List.cons (17,18) List.nil)))))))))))))))))) Mahjong.CartesianData06V19.v82) ∧
  Mahjong.CartesianData06V19.v81 = (Mahjong.CartesianMathV19.permute 19 (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) (List.cons (10,16) (List.cons (11,17) (List.cons (12,18) (List.cons (13,17) (List.cons (14,18) (List.cons (15,17) (List.cons (16,18) List.nil)))))))))))) Mahjong.CartesianData06V19.v82)))) ∧
  ((Mahjong.CartesianData06V19.v86 = Mahjong.CartesianMathV19.pad 26 38 376 5 6 9 Mahjong.CartesianData06V19.v83 ∧
  (Mahjong.CartesianData06V19.v84 = (Mahjong.CartesianMathV19.permute 20 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,17) (List.cons (13,18) (List.cons (14,19) List.nil))))))))))))))) Mahjong.CartesianData06V19.v86) ∧
  Mahjong.CartesianData06V19.v85 = (Mahjong.CartesianMathV19.permute 20 (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) (List.cons (10,16) (List.cons (11,17) (List.cons (12,18) (List.cons (13,19) (List.cons (14,17) (List.cons (15,18) (List.cons (16,19) List.nil)))))))))))) Mahjong.CartesianData06V19.v86))) ∧
  ((Mahjong.CartesianData06V19.v90 = Mahjong.CartesianMathV19.pad 26 38 2 5 6 1 Mahjong.CartesianData06V19.v87 ∧
  Mahjong.CartesianData06V19.v88 = (Mahjong.CartesianMathV19.permute 12 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,10) (List.cons (8,11) (List.cons (9,10) (List.cons (10,11) List.nil))))))))))) Mahjong.CartesianData06V19.v90)) ∧
  (Mahjong.CartesianData06V19.v89 = (Mahjong.CartesianMathV19.permute 12 (List.cons (5,11) (List.cons (6,11) (List.cons (7,11) (List.cons (8,11) (List.cons (9,11) (List.cons (10,11) List.nil)))))) Mahjong.CartesianData06V19.v90) ∧
  Mahjong.CartesianData06V19.v91 = Mahjong.CartesianMathV19.pad 26 38 37 5 6 6 (2^36556-1)))))) := by decide +kernel
end Mahjong.CartesianPrepB21V19
#print axioms Mahjong.CartesianPrepB21V19.every_layout_and_valid_mask
