import Mahjong.IndexDecoder

set_option autoImplicit false

namespace Mahjong.IndexInputBounds
open Ranking IndexSearch

theorem allThree_pair_input (n r : Nat) (maximum : n ≤ 3403) (bound : r < c3 n) :
    r-c3 (tripleFloor r n) < c2 3403 := by
  have f := tripleFloor_spec r n bound
  have next := c3_succ (tripleFloor r n)
  have mono := c2_mono (a:=tripleFloor r n+1) (b:=3403) (by omega)
  omega

theorem firstTwo_pair_input (n r : Nat) (positive : 0 < n) (maximum : n ≤ 3403) :
    r%c2 n < c2 3403 := by
  have bound := Nat.mod_lt r (WeightedBlocks.c2_positive n positive)
  have mono := c2_mono maximum
  omega

theorem lastTwo_pair_input (a n r : Nat) (positive : 0 < a) (maximum : n ≤ 3403)
    (bound : r < a*c2 n) : r/a < c2 3403 := by
  have small : r/a < c2 n := (Nat.div_lt_iff_lt_mul positive).mpr (by simpa [Nat.mul_comm] using bound)
  have mono := c2_mono maximum
  omega

end Mahjong.IndexInputBounds

#print axioms Mahjong.IndexInputBounds.allThree_pair_input
#print axioms Mahjong.IndexInputBounds.firstTwo_pair_input
#print axioms Mahjong.IndexInputBounds.lastTwo_pair_input
