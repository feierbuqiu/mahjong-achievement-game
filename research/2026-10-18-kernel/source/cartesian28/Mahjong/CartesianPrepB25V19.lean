module
prelude
public import Mahjong.CartesianChannels15V19
import all Mahjong.CartesianChannels15V19
public import Mahjong.CartesianChannels24V19
import all Mahjong.CartesianChannels24V19
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
namespace Mahjong.CartesianPrepB25V19
theorem every_layout_and_valid_mask :
  ((((Mahjong.CartesianData07V19.v129 = Mahjong.CartesianMathV19.pad 40 11 78 6 4 7 Mahjong.CartesianData07V19.v126 ∧
  (Mahjong.CartesianData07V19.v127 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,6) (List.cons (1,7) (List.cons (2,8) (List.cons (3,9) (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) (List.cons (10,16) (List.cons (11,12) (List.cons (12,13) (List.cons (13,14) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData07V19.v129) ∧
  Mahjong.CartesianData07V19.v128 = (Mahjong.CartesianMathV19.permute 17 (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) (List.cons (12,16) (List.cons (13,14) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))) Mahjong.CartesianData07V19.v129))) ∧
  (Mahjong.CartesianData08V19.v0 = Mahjong.CartesianMathV19.pad 49 11 78 6 4 7 Mahjong.CartesianData07V19.v130 ∧
  (Mahjong.CartesianData07V19.v131 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,6) (List.cons (1,7) (List.cons (2,8) (List.cons (3,9) (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) (List.cons (10,16) (List.cons (11,12) (List.cons (12,13) (List.cons (13,14) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData08V19.v0) ∧
  Mahjong.CartesianData07V19.v132 = (Mahjong.CartesianMathV19.permute 17 (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) (List.cons (12,16) (List.cons (13,14) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))) Mahjong.CartesianData08V19.v0)))) ∧
  ((Mahjong.CartesianData08V19.v4 = Mahjong.CartesianMathV19.pad 78 11 78 7 4 7 Mahjong.CartesianData08V19.v1 ∧
  (Mahjong.CartesianData08V19.v2 = (Mahjong.CartesianMathV19.permute 18 (List.cons (0,7) (List.cons (1,8) (List.cons (2,9) (List.cons (3,10) (List.cons (4,11) (List.cons (5,12) (List.cons (6,13) (List.cons (7,14) (List.cons (8,15) (List.cons (9,16) (List.cons (10,17) (List.cons (11,14) (List.cons (12,15) (List.cons (13,16) (List.cons (14,17) (List.cons (15,17) (List.cons (16,17) List.nil))))))))))))))))) Mahjong.CartesianData08V19.v4) ∧
  Mahjong.CartesianData08V19.v3 = (Mahjong.CartesianMathV19.permute 18 (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) (List.cons (12,16) (List.cons (13,17) (List.cons (14,15) (List.cons (15,16) (List.cons (16,17) List.nil)))))))))) Mahjong.CartesianData08V19.v4))) ∧
  (Mahjong.CartesianData08V19.v8 = Mahjong.CartesianMathV19.pad 40 78 22 6 7 5 Mahjong.CartesianData08V19.v5 ∧
  (Mahjong.CartesianData08V19.v6 = (Mahjong.CartesianMathV19.permute 18 (List.cons (0,6) (List.cons (1,7) (List.cons (2,8) (List.cons (3,9) (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) (List.cons (10,16) (List.cons (11,17) List.nil)))))))))))) Mahjong.CartesianData08V19.v8) ∧
  Mahjong.CartesianData08V19.v7 = (Mahjong.CartesianMathV19.permute 18 (List.cons (6,13) (List.cons (7,14) (List.cons (8,15) (List.cons (9,16) (List.cons (10,17) (List.cons (11,13) (List.cons (12,14) (List.cons (13,15) (List.cons (14,16) (List.cons (15,17) (List.cons (16,17) List.nil))))))))))) Mahjong.CartesianData08V19.v8))))) ∧
  (((Mahjong.CartesianData08V19.v12 = Mahjong.CartesianMathV19.pad 40 78 16 6 7 4 Mahjong.CartesianData08V19.v9 ∧
  (Mahjong.CartesianData08V19.v10 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,6) (List.cons (1,7) (List.cons (2,8) (List.cons (3,9) (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) (List.cons (10,16) (List.cons (11,12) (List.cons (12,13) (List.cons (13,14) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData08V19.v12) ∧
  Mahjong.CartesianData08V19.v11 = (Mahjong.CartesianMathV19.permute 17 (List.cons (6,13) (List.cons (7,14) (List.cons (8,15) (List.cons (9,16) (List.cons (10,13) (List.cons (11,14) (List.cons (12,15) (List.cons (13,16) (List.cons (14,16) (List.cons (15,16) List.nil)))))))))) Mahjong.CartesianData08V19.v12))) ∧
  (Mahjong.CartesianData08V19.v16 = Mahjong.CartesianMathV19.pad 40 78 4 6 7 2 Mahjong.CartesianData08V19.v13 ∧
  (Mahjong.CartesianData08V19.v14 = (Mahjong.CartesianMathV19.permute 15 (List.cons (0,6) (List.cons (1,7) (List.cons (2,8) (List.cons (3,9) (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,12) (List.cons (10,13) (List.cons (11,14) List.nil)))))))))))) Mahjong.CartesianData08V19.v16) ∧
  Mahjong.CartesianData08V19.v15 = (Mahjong.CartesianMathV19.permute 15 (List.cons (6,13) (List.cons (7,14) (List.cons (8,13) (List.cons (9,14) (List.cons (10,13) (List.cons (11,14) (List.cons (12,13) (List.cons (13,14) List.nil)))))))) Mahjong.CartesianData08V19.v16)))) ∧
  ((Mahjong.CartesianData08V19.v20 = Mahjong.CartesianMathV19.pad 40 11 37 6 4 6 Mahjong.CartesianData08V19.v17 ∧
  (Mahjong.CartesianData08V19.v18 = (Mahjong.CartesianMathV19.permute 16 (List.cons (0,6) (List.cons (1,7) (List.cons (2,8) (List.cons (3,9) (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) (List.cons (10,12) (List.cons (11,13) (List.cons (12,14) (List.cons (13,15) List.nil)))))))))))))) Mahjong.CartesianData08V19.v20) ∧
  Mahjong.CartesianData08V19.v19 = (Mahjong.CartesianMathV19.permute 16 (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) (List.cons (12,14) (List.cons (13,15) List.nil)))))))) Mahjong.CartesianData08V19.v20))) ∧
  ((Mahjong.CartesianData08V19.v24 = Mahjong.CartesianMathV19.pad 40 11 78 6 4 7 Mahjong.CartesianData08V19.v21 ∧
  Mahjong.CartesianData08V19.v22 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,6) (List.cons (1,7) (List.cons (2,8) (List.cons (3,9) (List.cons (4,10) (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) (List.cons (10,16) (List.cons (11,12) (List.cons (12,13) (List.cons (13,14) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData08V19.v24)) ∧
  (Mahjong.CartesianData08V19.v23 = (Mahjong.CartesianMathV19.permute 17 (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,15) (List.cons (12,16) (List.cons (13,14) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))) Mahjong.CartesianData08V19.v24) ∧
  Mahjong.CartesianData08V19.v25 = Mahjong.CartesianMathV19.pad 40 11 78 6 4 7 (2^34320-1)))))) := by decide +kernel
end Mahjong.CartesianPrepB25V19
#print axioms Mahjong.CartesianPrepB25V19.every_layout_and_valid_mask
