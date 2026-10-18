module
prelude
public import Mahjong.CartesianChannels24V19
import all Mahjong.CartesianChannels24V19
public import Mahjong.CartesianChannels25V19
import all Mahjong.CartesianChannels25V19
public import Mahjong.CartesianChannels26V19
import all Mahjong.CartesianChannels26V19
public import Mahjong.CartesianData00V19
import all Mahjong.CartesianData00V19
public import Mahjong.CartesianData05V19
import all Mahjong.CartesianData05V19
public import Mahjong.CartesianData08V19
import all Mahjong.CartesianData08V19
public import Mahjong.CartesianMathV19
import all Mahjong.CartesianMathV19
public section
set_option autoImplicit false
set_option synthInstance.maxSize 4096
set_option maxRecDepth 131072
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
namespace Mahjong.CartesianPrepB26V19
theorem every_layout_and_valid_mask :
  (((((Mahjong.CartesianData08V19.v30 = Mahjong.CartesianMathV19.pad 9 16 243 4 4 8 Mahjong.CartesianData08V19.v27 ∧
  (Mahjong.CartesianData08V19.v28 = (Mahjong.CartesianMathV19.permute 16 (List.cons (0,4) (List.cons (1,5) (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) List.nil)))))))))))) Mahjong.CartesianData08V19.v30) ∧
  Mahjong.CartesianData08V19.v29 = (Mahjong.CartesianMathV19.permute 16 (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) List.nil)))))))) Mahjong.CartesianData08V19.v30))) ∧
  (Mahjong.CartesianData08V19.v34 = Mahjong.CartesianMathV19.pad 5 16 243 3 4 8 Mahjong.CartesianData08V19.v31 ∧
  (Mahjong.CartesianData08V19.v32 = (Mahjong.CartesianMathV19.permute 15 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) List.nil)))))))))))) Mahjong.CartesianData08V19.v34) ∧
  Mahjong.CartesianData08V19.v33 = (Mahjong.CartesianMathV19.permute 15 (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) List.nil)))))))) Mahjong.CartesianData08V19.v34)))) ∧
  ((Mahjong.CartesianData08V19.v38 = Mahjong.CartesianMathV19.pad 9 16 243 4 4 8 Mahjong.CartesianData08V19.v35 ∧
  (Mahjong.CartesianData08V19.v36 = (Mahjong.CartesianMathV19.permute 16 (List.cons (0,4) (List.cons (1,5) (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) List.nil)))))))))))) Mahjong.CartesianData08V19.v38) ∧
  Mahjong.CartesianData08V19.v37 = (Mahjong.CartesianMathV19.permute 16 (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) List.nil)))))))) Mahjong.CartesianData08V19.v38))) ∧
  ((Mahjong.CartesianData08V19.v42 = Mahjong.CartesianMathV19.pad 13 16 243 4 4 8 Mahjong.CartesianData08V19.v39 ∧
  Mahjong.CartesianData08V19.v40 = (Mahjong.CartesianMathV19.permute 16 (List.cons (0,4) (List.cons (1,5) (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) List.nil)))))))))))) Mahjong.CartesianData08V19.v42)) ∧
  (Mahjong.CartesianData08V19.v41 = (Mahjong.CartesianMathV19.permute 16 (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) List.nil)))))))) Mahjong.CartesianData08V19.v42) ∧
  Mahjong.CartesianData08V19.v46 = Mahjong.CartesianMathV19.pad 16 16 243 4 4 8 Mahjong.CartesianData08V19.v43)))) ∧
  (((Mahjong.CartesianData08V19.v44 = (Mahjong.CartesianMathV19.permute 16 (List.cons (0,4) (List.cons (1,5) (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) List.nil)))))))))))) Mahjong.CartesianData08V19.v46) ∧
  (Mahjong.CartesianData08V19.v45 = (Mahjong.CartesianMathV19.permute 16 (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) List.nil)))))))) Mahjong.CartesianData08V19.v46) ∧
  Mahjong.CartesianData08V19.v50 = Mahjong.CartesianMathV19.pad 7 16 243 3 4 8 Mahjong.CartesianData08V19.v47)) ∧
  (Mahjong.CartesianData08V19.v48 = (Mahjong.CartesianMathV19.permute 15 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) List.nil)))))))))))) Mahjong.CartesianData08V19.v50) ∧
  (Mahjong.CartesianData08V19.v49 = (Mahjong.CartesianMathV19.permute 15 (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) List.nil)))))))) Mahjong.CartesianData08V19.v50) ∧
  Mahjong.CartesianData08V19.v54 = Mahjong.CartesianMathV19.pad 6 16 243 3 4 8 Mahjong.CartesianData08V19.v51))) ∧
  ((Mahjong.CartesianData08V19.v52 = (Mahjong.CartesianMathV19.permute 15 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) List.nil)))))))))))) Mahjong.CartesianData08V19.v54) ∧
  (Mahjong.CartesianData08V19.v53 = (Mahjong.CartesianMathV19.permute 15 (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) List.nil)))))))) Mahjong.CartesianData08V19.v54) ∧
  Mahjong.CartesianData08V19.v58 = Mahjong.CartesianMathV19.pad 53 16 243 6 4 8 Mahjong.CartesianData08V19.v55)) ∧
  ((Mahjong.CartesianData08V19.v56 = (Mahjong.CartesianMathV19.permute 18 (List.cons (0,6) (List.cons (1,7) (List.cons (2,8) (List.cons (3,9) (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) (List.cons (10,16) (List.cons (11,17) List.nil)))))))))))) Mahjong.CartesianData08V19.v58) ∧
  Mahjong.CartesianData08V19.v57 = (Mahjong.CartesianMathV19.permute 18 (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) (List.cons (12,16) (List.cons (13,17) List.nil)))))))) Mahjong.CartesianData08V19.v58)) ∧
  (Mahjong.CartesianData08V19.v62 = Mahjong.CartesianMathV19.pad 19 16 243 5 4 8 Mahjong.CartesianData08V19.v59 ∧
  Mahjong.CartesianData08V19.v60 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,15) (List.cons (13,16) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData08V19.v62)))))) ∧
  ((((Mahjong.CartesianData08V19.v61 = (Mahjong.CartesianMathV19.permute 17 (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) (List.cons (12,16) List.nil)))))))) Mahjong.CartesianData08V19.v62) ∧
  (Mahjong.CartesianData08V19.v66 = Mahjong.CartesianMathV19.pad 2 16 243 1 4 8 Mahjong.CartesianData08V19.v63 ∧
  Mahjong.CartesianData08V19.v64 = (Mahjong.CartesianMathV19.permute 13 (List.cons (0,1) (List.cons (1,2) (List.cons (2,3) (List.cons (3,4) (List.cons (4,5) (List.cons (5,6) (List.cons (6,7) (List.cons (7,8) (List.cons (8,9) (List.cons (9,10) (List.cons (10,11) (List.cons (11,12) List.nil)))))))))))) Mahjong.CartesianData08V19.v66))) ∧
  (Mahjong.CartesianData08V19.v65 = (Mahjong.CartesianMathV19.permute 13 (List.cons (1,5) (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) List.nil)))))))) Mahjong.CartesianData08V19.v66) ∧
  (Mahjong.CartesianData08V19.v70 = Mahjong.CartesianMathV19.pad 9 26 243 4 5 8 Mahjong.CartesianData08V19.v67 ∧
  Mahjong.CartesianData08V19.v68 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,4) (List.cons (1,5) (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) (List.cons (12,16) (List.cons (13,16) (List.cons (14,16) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData08V19.v70)))) ∧
  ((Mahjong.CartesianData08V19.v69 = (Mahjong.CartesianMathV19.permute 17 (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,14) (List.cons (13,15) (List.cons (14,16) (List.cons (15,16) List.nil)))))))))))) Mahjong.CartesianData08V19.v70) ∧
  (Mahjong.CartesianData08V19.v74 = Mahjong.CartesianMathV19.pad 9 37 243 4 6 8 Mahjong.CartesianData08V19.v71 ∧
  Mahjong.CartesianData08V19.v72 = (Mahjong.CartesianMathV19.permute 18 (List.cons (0,4) (List.cons (1,5) (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) (List.cons (12,16) (List.cons (13,17) (List.cons (14,16) (List.cons (15,17) List.nil)))))))))))))))) Mahjong.CartesianData08V19.v74))) ∧
  ((Mahjong.CartesianData08V19.v73 = (Mahjong.CartesianMathV19.permute 18 (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) (List.cons (10,16) (List.cons (11,17) (List.cons (12,16) (List.cons (13,17) (List.cons (14,16) (List.cons (15,17) List.nil)))))))))))) Mahjong.CartesianData08V19.v74) ∧
  Mahjong.CartesianData08V19.v78 = Mahjong.CartesianMathV19.pad 9 16 80 4 4 7 Mahjong.CartesianData08V19.v75) ∧
  (Mahjong.CartesianData08V19.v76 = (Mahjong.CartesianMathV19.permute 15 (List.cons (0,4) (List.cons (1,5) (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,12) (List.cons (12,13) (List.cons (13,14) List.nil)))))))))))))) Mahjong.CartesianData08V19.v78) ∧
  Mahjong.CartesianData08V19.v77 = (Mahjong.CartesianMathV19.permute 15 (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,12) (List.cons (12,13) (List.cons (13,14) List.nil)))))))))) Mahjong.CartesianData08V19.v78))))) ∧
  (((Mahjong.CartesianData08V19.v82 = Mahjong.CartesianMathV19.pad 9 16 184 4 4 8 Mahjong.CartesianData08V19.v79 ∧
  (Mahjong.CartesianData08V19.v80 = (Mahjong.CartesianMathV19.permute 16 (List.cons (0,4) (List.cons (1,5) (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) List.nil)))))))))))) Mahjong.CartesianData08V19.v82) ∧
  Mahjong.CartesianData08V19.v81 = (Mahjong.CartesianMathV19.permute 16 (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) List.nil)))))))) Mahjong.CartesianData08V19.v82))) ∧
  (Mahjong.CartesianData08V19.v86 = Mahjong.CartesianMathV19.pad 9 16 844 4 4 10 Mahjong.CartesianData08V19.v83 ∧
  (Mahjong.CartesianData08V19.v84 = (Mahjong.CartesianMathV19.permute 18 (List.cons (0,4) (List.cons (1,5) (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) (List.cons (12,16) (List.cons (13,17) (List.cons (14,16) (List.cons (15,17) List.nil)))))))))))))))) Mahjong.CartesianData08V19.v86) ∧
  Mahjong.CartesianData08V19.v85 = (Mahjong.CartesianMathV19.permute 18 (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) (List.cons (12,16) (List.cons (13,17) (List.cons (14,16) (List.cons (15,17) List.nil)))))))))))) Mahjong.CartesianData08V19.v86)))) ∧
  ((Mahjong.CartesianData08V19.v90 = Mahjong.CartesianMathV19.pad 9 16 243 4 4 8 Mahjong.CartesianData08V19.v87 ∧
  (Mahjong.CartesianData08V19.v88 = (Mahjong.CartesianMathV19.permute 16 (List.cons (0,4) (List.cons (1,5) (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) List.nil)))))))))))) Mahjong.CartesianData08V19.v90) ∧
  Mahjong.CartesianData08V19.v89 = (Mahjong.CartesianMathV19.permute 16 (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) List.nil)))))))) Mahjong.CartesianData08V19.v90))) ∧
  ((Mahjong.CartesianData08V19.v94 = Mahjong.CartesianMathV19.pad 9 16 243 4 4 8 Mahjong.CartesianData08V19.v91 ∧
  Mahjong.CartesianData08V19.v92 = (Mahjong.CartesianMathV19.permute 16 (List.cons (0,4) (List.cons (1,5) (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) List.nil)))))))))))) Mahjong.CartesianData08V19.v94)) ∧
  (Mahjong.CartesianData08V19.v93 = (Mahjong.CartesianMathV19.permute 16 (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) List.nil)))))))) Mahjong.CartesianData08V19.v94) ∧
  Mahjong.CartesianData08V19.v95 = Mahjong.CartesianMathV19.pad 9 16 243 4 4 8 (2^34992-1))))))) := by decide +kernel
end Mahjong.CartesianPrepB26V19
#print axioms Mahjong.CartesianPrepB26V19.every_layout_and_valid_mask
