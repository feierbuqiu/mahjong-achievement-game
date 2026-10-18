module
prelude
public import Mahjong.CartesianChannels11V19
import all Mahjong.CartesianChannels11V19
public import Mahjong.CartesianChannels15V19
import all Mahjong.CartesianChannels15V19
public import Mahjong.CartesianData00V19
import all Mahjong.CartesianData00V19
public import Mahjong.CartesianData02V19
import all Mahjong.CartesianData02V19
public import Mahjong.CartesianData03V19
import all Mahjong.CartesianData03V19
public import Mahjong.CartesianData04V19
import all Mahjong.CartesianData04V19
public import Mahjong.CartesianMathV19
import all Mahjong.CartesianMathV19
public section
set_option autoImplicit false
set_option synthInstance.maxSize 4096
set_option maxRecDepth 131072
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
namespace Mahjong.CartesianPrepB14V19
theorem every_layout_and_valid_mask :
  (((((Mahjong.CartesianData03V19.v404 = Mahjong.CartesianMathV19.pad 25 22 52 5 5 6 Mahjong.CartesianData03V19.v401 ∧
  (Mahjong.CartesianData03V19.v402 = (Mahjong.CartesianMathV19.permute 16 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,15) (List.cons (12,15) (List.cons (13,15) (List.cons (14,15) List.nil))))))))))))))) Mahjong.CartesianData03V19.v404) ∧
  Mahjong.CartesianData03V19.v403 = (Mahjong.CartesianMathV19.permute 16 (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,15) (List.cons (12,15) (List.cons (13,15) (List.cons (14,15) List.nil)))))))))) Mahjong.CartesianData03V19.v404))) ∧
  ((Mahjong.CartesianData03V19.v408 = Mahjong.CartesianMathV19.pad 22 22 52 5 5 6 Mahjong.CartesianData03V19.v405 ∧
  Mahjong.CartesianData03V19.v406 = (Mahjong.CartesianMathV19.permute 16 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,15) (List.cons (12,15) (List.cons (13,15) (List.cons (14,15) List.nil))))))))))))))) Mahjong.CartesianData03V19.v408)) ∧
  (Mahjong.CartesianData03V19.v407 = (Mahjong.CartesianMathV19.permute 16 (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,15) (List.cons (12,15) (List.cons (13,15) (List.cons (14,15) List.nil)))))))))) Mahjong.CartesianData03V19.v408) ∧
  Mahjong.CartesianData03V19.v412 = Mahjong.CartesianMathV19.pad 22 13 52 5 4 6 Mahjong.CartesianData03V19.v409))) ∧
  (((Mahjong.CartesianData03V19.v410 = (Mahjong.CartesianMathV19.permute 15 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) List.nil)))))))))) Mahjong.CartesianData03V19.v412) ∧
  Mahjong.CartesianData03V19.v411 = (Mahjong.CartesianMathV19.permute 15 (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,13) (List.cons (12,14) List.nil)))))))) Mahjong.CartesianData03V19.v412)) ∧
  (Mahjong.CartesianData03V19.v416 = Mahjong.CartesianMathV19.pad 22 47 52 5 6 6 Mahjong.CartesianData03V19.v413 ∧
  Mahjong.CartesianData03V19.v414 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,15) (List.cons (13,16) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData03V19.v416))) ∧
  ((Mahjong.CartesianData03V19.v415 = (Mahjong.CartesianMathV19.permute 17 (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) (List.cons (10,16) List.nil)))))) Mahjong.CartesianData03V19.v416) ∧
  Mahjong.CartesianData03V19.v420 = Mahjong.CartesianMathV19.pad 22 20 52 5 5 6 Mahjong.CartesianData03V19.v417) ∧
  (Mahjong.CartesianData03V19.v418 = (Mahjong.CartesianMathV19.permute 16 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,15) (List.cons (12,15) (List.cons (13,15) (List.cons (14,15) List.nil))))))))))))))) Mahjong.CartesianData03V19.v420) ∧
  Mahjong.CartesianData03V19.v419 = (Mahjong.CartesianMathV19.permute 16 (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,15) (List.cons (12,15) (List.cons (13,15) (List.cons (14,15) List.nil)))))))))) Mahjong.CartesianData03V19.v420))))) ∧
  (((Mahjong.CartesianData03V19.v424 = Mahjong.CartesianMathV19.pad 22 5 52 5 3 6 Mahjong.CartesianData03V19.v421 ∧
  (Mahjong.CartesianData03V19.v422 = (Mahjong.CartesianMathV19.permute 14 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,10) (List.cons (10,11) (List.cons (11,12) (List.cons (12,13) List.nil))))))))))))) Mahjong.CartesianData03V19.v424) ∧
  Mahjong.CartesianData03V19.v423 = (Mahjong.CartesianMathV19.permute 14 (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) List.nil)))))) Mahjong.CartesianData03V19.v424))) ∧
  ((Mahjong.CartesianData03V19.v428 = Mahjong.CartesianMathV19.pad 22 10 52 5 4 6 Mahjong.CartesianData03V19.v425 ∧
  Mahjong.CartesianData03V19.v426 = (Mahjong.CartesianMathV19.permute 15 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) List.nil)))))))))) Mahjong.CartesianData03V19.v428)) ∧
  (Mahjong.CartesianData03V19.v427 = (Mahjong.CartesianMathV19.permute 15 (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,13) (List.cons (12,14) List.nil)))))))) Mahjong.CartesianData03V19.v428) ∧
  Mahjong.CartesianData03V19.v432 = Mahjong.CartesianMathV19.pad 25 8 52 5 3 6 Mahjong.CartesianData03V19.v429))) ∧
  (((Mahjong.CartesianData03V19.v430 = (Mahjong.CartesianMathV19.permute 14 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,10) (List.cons (10,11) (List.cons (11,12) (List.cons (12,13) List.nil))))))))))))) Mahjong.CartesianData03V19.v432) ∧
  Mahjong.CartesianData03V19.v431 = (Mahjong.CartesianMathV19.permute 14 (List.cons (5,8) (List.cons (6,9) (List.cons (7,10) (List.cons (8,11) (List.cons (9,12) (List.cons (10,13) List.nil)))))) Mahjong.CartesianData03V19.v432)) ∧
  (Mahjong.CartesianData03V19.v436 = Mahjong.CartesianMathV19.pad 25 46 52 5 6 6 Mahjong.CartesianData03V19.v433 ∧
  Mahjong.CartesianData03V19.v434 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,15) (List.cons (13,16) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData03V19.v436))) ∧
  ((Mahjong.CartesianData03V19.v435 = (Mahjong.CartesianMathV19.permute 17 (List.cons (5,11) (List.cons (6,12) (List.cons (7,13) (List.cons (8,14) (List.cons (9,15) (List.cons (10,16) List.nil)))))) Mahjong.CartesianData03V19.v436) ∧
  Mahjong.CartesianData03V19.v440 = Mahjong.CartesianMathV19.pad 25 11 52 5 4 6 Mahjong.CartesianData03V19.v437) ∧
  (Mahjong.CartesianData03V19.v438 = (Mahjong.CartesianMathV19.permute 15 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) List.nil)))))))))) Mahjong.CartesianData03V19.v440) ∧
  Mahjong.CartesianData03V19.v439 = (Mahjong.CartesianMathV19.permute 15 (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,13) (List.cons (12,14) List.nil)))))))) Mahjong.CartesianData03V19.v440)))))) ∧
  ((((Mahjong.CartesianData03V19.v444 = Mahjong.CartesianMathV19.pad 25 14 52 5 4 6 Mahjong.CartesianData03V19.v441 ∧
  (Mahjong.CartesianData03V19.v442 = (Mahjong.CartesianMathV19.permute 15 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) List.nil)))))))))) Mahjong.CartesianData03V19.v444) ∧
  Mahjong.CartesianData03V19.v443 = (Mahjong.CartesianMathV19.permute 15 (List.cons (5,9) (List.cons (6,10) (List.cons (7,11) (List.cons (8,12) (List.cons (9,13) (List.cons (10,14) (List.cons (11,13) (List.cons (12,14) List.nil)))))))) Mahjong.CartesianData03V19.v444))) ∧
  ((Mahjong.CartesianData03V19.v448 = Mahjong.CartesianMathV19.pad 25 22 37 5 5 6 Mahjong.CartesianData03V19.v445 ∧
  Mahjong.CartesianData03V19.v446 = (Mahjong.CartesianMathV19.permute 16 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,15) (List.cons (12,15) (List.cons (13,15) (List.cons (14,15) List.nil))))))))))))))) Mahjong.CartesianData03V19.v448)) ∧
  (Mahjong.CartesianData03V19.v447 = (Mahjong.CartesianMathV19.permute 16 (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,15) (List.cons (12,15) (List.cons (13,15) (List.cons (14,15) List.nil)))))))))) Mahjong.CartesianData03V19.v448) ∧
  Mahjong.CartesianData03V19.v452 = Mahjong.CartesianMathV19.pad 25 22 5 5 5 3 Mahjong.CartesianData03V19.v449))) ∧
  (((Mahjong.CartesianData03V19.v450 = (Mahjong.CartesianMathV19.permute 13 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,10) (List.cons (9,11) (List.cons (10,12) (List.cons (11,12) List.nil)))))))))))) Mahjong.CartesianData03V19.v452) ∧
  Mahjong.CartesianData03V19.v451 = (Mahjong.CartesianMathV19.permute 13 (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,10) (List.cons (9,11) (List.cons (10,12) (List.cons (11,12) List.nil))))))) Mahjong.CartesianData03V19.v452)) ∧
  (Mahjong.CartesianData03V19.v456 = Mahjong.CartesianMathV19.pad 25 22 384 5 5 9 Mahjong.CartesianData03V19.v453 ∧
  Mahjong.CartesianData03V19.v454 = (Mahjong.CartesianMathV19.permute 19 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,17) (List.cons (13,18) (List.cons (14,15) (List.cons (15,16) (List.cons (16,17) (List.cons (17,18) List.nil)))))))))))))))))) Mahjong.CartesianData03V19.v456))) ∧
  ((Mahjong.CartesianData03V19.v455 = (Mahjong.CartesianMathV19.permute 19 (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,17) (List.cons (13,18) (List.cons (14,15) (List.cons (15,16) (List.cons (16,17) (List.cons (17,18) List.nil))))))))))))) Mahjong.CartesianData03V19.v456) ∧
  Mahjong.CartesianData03V19.v460 = Mahjong.CartesianMathV19.pad 25 22 28 5 5 5 Mahjong.CartesianData03V19.v457) ∧
  (Mahjong.CartesianData03V19.v458 = (Mahjong.CartesianMathV19.permute 15 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) List.nil)))))))))) Mahjong.CartesianData03V19.v460) ∧
  Mahjong.CartesianData03V19.v459 = (Mahjong.CartesianMathV19.permute 15 (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) List.nil))))) Mahjong.CartesianData03V19.v460))))) ∧
  ((((Mahjong.CartesianData03V19.v464 = Mahjong.CartesianMathV19.pad 25 22 4 5 5 2 Mahjong.CartesianData03V19.v461 ∧
  Mahjong.CartesianData03V19.v462 = (Mahjong.CartesianMathV19.permute 12 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,10) (List.cons (8,11) (List.cons (9,10) (List.cons (10,11) List.nil))))))))))) Mahjong.CartesianData03V19.v464)) ∧
  (Mahjong.CartesianData03V19.v463 = (Mahjong.CartesianMathV19.permute 12 (List.cons (5,10) (List.cons (6,11) (List.cons (7,10) (List.cons (8,11) (List.cons (9,10) (List.cons (10,11) List.nil)))))) Mahjong.CartesianData03V19.v464) ∧
  Mahjong.CartesianData03V19.v468 = Mahjong.CartesianMathV19.pad 25 22 327 5 5 9 Mahjong.CartesianData03V19.v465)) ∧
  ((Mahjong.CartesianData03V19.v466 = (Mahjong.CartesianMathV19.permute 19 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,17) (List.cons (13,18) (List.cons (14,15) (List.cons (15,16) (List.cons (16,17) (List.cons (17,18) List.nil)))))))))))))))))) Mahjong.CartesianData03V19.v468) ∧
  Mahjong.CartesianData03V19.v467 = (Mahjong.CartesianMathV19.permute 19 (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,17) (List.cons (13,18) (List.cons (14,15) (List.cons (15,16) (List.cons (16,17) (List.cons (17,18) List.nil))))))))))))) Mahjong.CartesianData03V19.v468)) ∧
  (Mahjong.CartesianData04V19.v0 = Mahjong.CartesianMathV19.pad 25 22 72 5 5 7 Mahjong.CartesianData03V19.v469 ∧
  Mahjong.CartesianData03V19.v470 = (Mahjong.CartesianMathV19.permute 17 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,15) (List.cons (13,16) (List.cons (14,15) (List.cons (15,16) List.nil)))))))))))))))) Mahjong.CartesianData04V19.v0)))) ∧
  (((Mahjong.CartesianData03V19.v471 = (Mahjong.CartesianMathV19.permute 17 (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,16) (List.cons (12,15) (List.cons (13,16) (List.cons (14,15) (List.cons (15,16) List.nil))))))))))) Mahjong.CartesianData04V19.v0) ∧
  Mahjong.CartesianData04V19.v4 = Mahjong.CartesianMathV19.pad 25 22 52 5 5 6 Mahjong.CartesianData04V19.v1) ∧
  (Mahjong.CartesianData04V19.v2 = (Mahjong.CartesianMathV19.permute 16 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,15) (List.cons (12,15) (List.cons (13,15) (List.cons (14,15) List.nil))))))))))))))) Mahjong.CartesianData04V19.v4) ∧
  Mahjong.CartesianData04V19.v3 = (Mahjong.CartesianMathV19.permute 16 (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,15) (List.cons (12,15) (List.cons (13,15) (List.cons (14,15) List.nil)))))))))) Mahjong.CartesianData04V19.v4))) ∧
  ((Mahjong.CartesianData04V19.v8 = Mahjong.CartesianMathV19.pad 25 22 52 5 5 6 Mahjong.CartesianData04V19.v5 ∧
  Mahjong.CartesianData04V19.v6 = (Mahjong.CartesianMathV19.permute 16 (List.cons (0,5) (List.cons (1,6) (List.cons (2,7) (List.cons (3,8) (List.cons (4,9) (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,15) (List.cons (12,15) (List.cons (13,15) (List.cons (14,15) List.nil))))))))))))))) Mahjong.CartesianData04V19.v8)) ∧
  (Mahjong.CartesianData04V19.v7 = (Mahjong.CartesianMathV19.permute 16 (List.cons (5,10) (List.cons (6,11) (List.cons (7,12) (List.cons (8,13) (List.cons (9,14) (List.cons (10,15) (List.cons (11,15) (List.cons (12,15) (List.cons (13,15) (List.cons (14,15) List.nil)))))))))) Mahjong.CartesianData04V19.v8) ∧
  Mahjong.CartesianData04V19.v9 = Mahjong.CartesianMathV19.pad 25 22 52 5 5 6 (2^28600-1))))))) := by decide +kernel
end Mahjong.CartesianPrepB14V19
#print axioms Mahjong.CartesianPrepB14V19.every_layout_and_valid_mask
