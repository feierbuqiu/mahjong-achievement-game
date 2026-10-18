module
prelude
public import Mahjong.CartesianChannels11V19
import all Mahjong.CartesianChannels11V19
public import Mahjong.CartesianChannels12V19
import all Mahjong.CartesianChannels12V19
public import Mahjong.CartesianChannels21V19
import all Mahjong.CartesianChannels21V19
public import Mahjong.CartesianChannels22V19
import all Mahjong.CartesianChannels22V19
public import Mahjong.CartesianData01V19
import all Mahjong.CartesianData01V19
public import Mahjong.CartesianData02V19
import all Mahjong.CartesianData02V19
public import Mahjong.CartesianData04V19
import all Mahjong.CartesianData04V19
public import Mahjong.CartesianData06V19
import all Mahjong.CartesianData06V19
public import Mahjong.CartesianData07V19
import all Mahjong.CartesianData07V19
public import Mahjong.CartesianMathV19
import all Mahjong.CartesianMathV19
public section
set_option autoImplicit false
set_option synthInstance.maxSize 4096
set_option maxRecDepth 131072
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
namespace Mahjong.CartesianPrepB23V19
theorem every_layout_and_valid_mask :
  (((((Mahjong.CartesianData07V19.v1 = Mahjong.CartesianMathV19.pad 52 72 10 6 7 4 Mahjong.CartesianData06V19.v127 ∧
  Mahjong.CartesianData06V19.v128 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,6) (List.cons (1,7) (List.cons (2,8) (List.cons (3,9) (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) (List.cons (10,16) (List.cons (11,12) (List.cons (12,13) (List.cons (13,14) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData07V19.v1)) ∧
  (Mahjong.CartesianData07V19.v0 = (Mahjong.CartesianMathV19.permute 17 (List.cons (6,13) (List.cons (7,14) (List.cons (8,15) (List.cons (9,16) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,16) (List.cons (14,16) (List.cons (15,16) List.nil)))))))))) Mahjong.CartesianData07V19.v1) ∧
  Mahjong.CartesianData07V19.v5 = Mahjong.CartesianMathV19.pad 16 72 10 4 7 4 Mahjong.CartesianData07V19.v2)) ∧
  ((Mahjong.CartesianData07V19.v3 = (Mahjong.CartesianMathV19.permute 15 (List.cons (0,4) (List.cons (1,5) (List.cons (2,6) (List.cons (3,7) (List.cons (4,8) (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,12) (List.cons (12,13) (List.cons (13,14) List.nil)))))))))))))) Mahjong.CartesianData07V19.v5) ∧
  Mahjong.CartesianData07V19.v4 = (Mahjong.CartesianMathV19.permute 15 (List.cons (4,11) (List.cons (5,12) (List.cons (6,13) (List.cons (7,14) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) (List.cons (12,14) (List.cons (13,14) List.nil)))))))))) Mahjong.CartesianData07V19.v5)) ∧
  (Mahjong.CartesianData07V19.v9 = Mahjong.CartesianMathV19.pad 5 72 10 3 7 4 Mahjong.CartesianData07V19.v6 ∧
  (Mahjong.CartesianData07V19.v7 = (Mahjong.CartesianMathV19.permute 14 (List.cons (0,3) (List.cons (1,4) (List.cons (2,5) (List.cons (3,6) (List.cons (4,7) (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,12) (List.cons (12,13) List.nil))))))))))))) Mahjong.CartesianData07V19.v9) ∧
  Mahjong.CartesianData07V19.v8 = (Mahjong.CartesianMathV19.permute 14 (List.cons (3,10) (List.cons (4,11) (List.cons (5,12) (List.cons (6,13) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) (List.cons (11,13) (List.cons (12,13) List.nil)))))))))) Mahjong.CartesianData07V19.v9))))) ∧
  (((Mahjong.CartesianData07V19.v13 = Mahjong.CartesianMathV19.pad 78 72 10 7 7 4 Mahjong.CartesianData07V19.v10 ∧
  Mahjong.CartesianData07V19.v11 = (Mahjong.CartesianMathV19.permute 18 (List.cons (0,7) (List.cons (1,8) (List.cons (2,9) (List.cons (3,10) (List.cons (4,11) (List.cons (5,12) (List.cons (6,13) (List.cons (7,14) (List.cons (8,15) (List.cons (9,16) (List.cons (10,17) (List.cons (11,14) (List.cons (12,15) (List.cons (13,16) (List.cons (14,17) (List.cons (15,17) (List.cons (16,17) List.nil))))))))))))))))) Mahjong.CartesianData07V19.v13)) ∧
  (Mahjong.CartesianData07V19.v12 = (Mahjong.CartesianMathV19.permute 18 (List.cons (7,14) (List.cons (8,15) (List.cons (9,16) (List.cons (10,17) (List.cons (11,14) (List.cons (12,15) (List.cons (13,16) (List.cons (14,17) (List.cons (15,17) (List.cons (16,17) List.nil)))))))))) Mahjong.CartesianData07V19.v13) ∧
  Mahjong.CartesianData07V19.v17 = Mahjong.CartesianMathV19.pad 52 72 10 6 7 4 Mahjong.CartesianData07V19.v14)) ∧
  ((Mahjong.CartesianData07V19.v15 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,6) (List.cons (1,7) (List.cons (2,8) (List.cons (3,9) (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) (List.cons (10,16) (List.cons (11,12) (List.cons (12,13) (List.cons (13,14) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData07V19.v17) ∧
  Mahjong.CartesianData07V19.v16 = (Mahjong.CartesianMathV19.permute 17 (List.cons (6,13) (List.cons (7,14) (List.cons (8,15) (List.cons (9,16) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,16) (List.cons (14,16) (List.cons (15,16) List.nil)))))))))) Mahjong.CartesianData07V19.v17)) ∧
  (Mahjong.CartesianData07V19.v21 = Mahjong.CartesianMathV19.pad 52 10 243 6 4 8 Mahjong.CartesianData07V19.v18 ∧
  (Mahjong.CartesianData07V19.v19 = (Mahjong.CartesianMathV19.permute 18 (List.cons (0,6) (List.cons (1,7) (List.cons (2,8) (List.cons (3,9) (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) (List.cons (10,16) (List.cons (11,17) List.nil)))))))))))) Mahjong.CartesianData07V19.v21) ∧
  Mahjong.CartesianData07V19.v20 = (Mahjong.CartesianMathV19.permute 18 (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) (List.cons (12,16) (List.cons (13,17) List.nil)))))))) Mahjong.CartesianData07V19.v21)))))) ∧
  ((((Mahjong.CartesianData07V19.v25 = Mahjong.CartesianMathV19.pad 52 10 681 6 4 10 Mahjong.CartesianData07V19.v22 ∧
  Mahjong.CartesianData07V19.v23 = (Mahjong.CartesianMathV19.permute 20 (List.cons (0,6) (List.cons (1,7) (List.cons (2,8) (List.cons (3,9) (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) (List.cons (10,16) (List.cons (11,17) (List.cons (12,18) (List.cons (13,19) (List.cons (14,18) (List.cons (15,19) (List.cons (16,18) (List.cons (17,19) List.nil)))))))))))))))))) Mahjong.CartesianData07V19.v25)) ∧
  (Mahjong.CartesianData07V19.v24 = (Mahjong.CartesianMathV19.permute 20 (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) (List.cons (12,16) (List.cons (13,17) (List.cons (14,18) (List.cons (15,19) (List.cons (16,18) (List.cons (17,19) List.nil)))))))))))) Mahjong.CartesianData07V19.v25) ∧
  Mahjong.CartesianData07V19.v29 = Mahjong.CartesianMathV19.pad 52 10 80 6 4 7 Mahjong.CartesianData07V19.v26)) ∧
  ((Mahjong.CartesianData07V19.v27 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,6) (List.cons (1,7) (List.cons (2,8) (List.cons (3,9) (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) (List.cons (10,16) (List.cons (11,12) (List.cons (12,13) (List.cons (13,14) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData07V19.v29) ∧
  Mahjong.CartesianData07V19.v28 = (Mahjong.CartesianMathV19.permute 17 (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) (List.cons (12,16) (List.cons (13,14) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))) Mahjong.CartesianData07V19.v29)) ∧
  (Mahjong.CartesianData07V19.v33 = Mahjong.CartesianMathV19.pad 52 72 80 6 7 7 Mahjong.CartesianData07V19.v30 ∧
  (Mahjong.CartesianData07V19.v31 = (Mahjong.CartesianMathV19.permute 20 (List.cons (0,6) (List.cons (1,7) (List.cons (2,8) (List.cons (3,9) (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) (List.cons (10,16) (List.cons (11,17) (List.cons (12,18) (List.cons (13,19) (List.cons (14,18) (List.cons (15,19) (List.cons (16,18) (List.cons (17,19) List.nil)))))))))))))))))) Mahjong.CartesianData07V19.v33) ∧
  Mahjong.CartesianData07V19.v32 = (Mahjong.CartesianMathV19.permute 20 (List.cons (6,13) (List.cons (7,14) (List.cons (8,15) (List.cons (9,16) (List.cons (10,17) (List.cons (11,18) (List.cons (12,19) List.nil))))))) Mahjong.CartesianData07V19.v33))))) ∧
  (((Mahjong.CartesianData07V19.v37 = Mahjong.CartesianMathV19.pad 52 72 97 6 7 7 Mahjong.CartesianData07V19.v34 ∧
  Mahjong.CartesianData07V19.v35 = (Mahjong.CartesianMathV19.permute 20 (List.cons (0,6) (List.cons (1,7) (List.cons (2,8) (List.cons (3,9) (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) (List.cons (10,16) (List.cons (11,17) (List.cons (12,18) (List.cons (13,19) (List.cons (14,18) (List.cons (15,19) (List.cons (16,18) (List.cons (17,19) List.nil)))))))))))))))))) Mahjong.CartesianData07V19.v37)) ∧
  (Mahjong.CartesianData07V19.v36 = (Mahjong.CartesianMathV19.permute 20 (List.cons (6,13) (List.cons (7,14) (List.cons (8,15) (List.cons (9,16) (List.cons (10,17) (List.cons (11,18) (List.cons (12,19) List.nil))))))) Mahjong.CartesianData07V19.v37) ∧
  (Mahjong.CartesianData07V19.v41 = Mahjong.CartesianMathV19.pad 52 72 10 6 7 4 Mahjong.CartesianData07V19.v38 ∧
  Mahjong.CartesianData07V19.v39 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,6) (List.cons (1,7) (List.cons (2,8) (List.cons (3,9) (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) (List.cons (10,16) (List.cons (11,12) (List.cons (12,13) (List.cons (13,14) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData07V19.v41)))) ∧
  ((Mahjong.CartesianData07V19.v40 = (Mahjong.CartesianMathV19.permute 17 (List.cons (6,13) (List.cons (7,14) (List.cons (8,15) (List.cons (9,16) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,16) (List.cons (14,16) (List.cons (15,16) List.nil)))))))))) Mahjong.CartesianData07V19.v41) ∧
  Mahjong.CartesianData07V19.v45 = Mahjong.CartesianMathV19.pad 52 72 10 6 7 4 Mahjong.CartesianData07V19.v42) ∧
  (Mahjong.CartesianData07V19.v43 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,6) (List.cons (1,7) (List.cons (2,8) (List.cons (3,9) (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) (List.cons (10,16) (List.cons (11,12) (List.cons (12,13) (List.cons (13,14) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData07V19.v45) ∧
  (Mahjong.CartesianData07V19.v44 = (Mahjong.CartesianMathV19.permute 17 (List.cons (6,13) (List.cons (7,14) (List.cons (8,15) (List.cons (9,16) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,16) (List.cons (14,16) (List.cons (15,16) List.nil)))))))))) Mahjong.CartesianData07V19.v45) ∧
  Mahjong.CartesianData07V19.v46 = Mahjong.CartesianMathV19.pad 52 72 10 6 7 4 (2^37440-1))))))) := by decide +kernel
end Mahjong.CartesianPrepB23V19
#print axioms Mahjong.CartesianPrepB23V19.every_layout_and_valid_mask
