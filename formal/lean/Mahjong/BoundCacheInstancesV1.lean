import Mahjong.BoundCachePatternsV1
import Mahjong.BoundBenchDataV1

set_option maxRecDepth 8192
set_option maxHeartbeats 20000000

namespace Mahjong.BoundCacheInstancesV1
open StandardBoundCertificate CachedStandardBounds BoundCachePatternsV1 BoundBenchDataV1

theorem Layer20_pair4 : FourLocalBounds (FastRuleChecker.removePair Layer20 4) (caps000 4) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Layer20 4) pattern000 (by decide +kernel) pattern000_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Layer20 4) pattern023 (by decide +kernel) pattern023_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Layer20 4) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Layer20 4) pattern033 (by decide +kernel) pattern033_checked

theorem Layer20_pair5 : FourLocalBounds (FastRuleChecker.removePair Layer20 5) (caps000 5) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Layer20 5) pattern001 (by decide +kernel) pattern001_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Layer20 5) pattern023 (by decide +kernel) pattern023_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Layer20 5) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Layer20 5) pattern033 (by decide +kernel) pattern033_checked

theorem Layer20_pair7 : FourLocalBounds (FastRuleChecker.removePair Layer20 7) (caps000 7) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Layer20 7) pattern002 (by decide +kernel) pattern002_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Layer20 7) pattern023 (by decide +kernel) pattern023_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Layer20 7) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Layer20 7) pattern033 (by decide +kernel) pattern033_checked

theorem Layer20_bounds : StandardBounds Layer20 caps000 where
  pair := by
    intro p hp
    have hm := mem_allTiles p
    simp only [allTiles, List.mem_cons, List.not_mem_nil, or_false] at hm
    rcases hm with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
    · have hf : FastRuleChecker.pairAvailableB Layer20 0 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer20 1 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer20 2 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer20 3 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Layer20_pair4
    · exact Layer20_pair5
    · have hf : FastRuleChecker.pairAvailableB Layer20 6 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Layer20_pair7
    · have hf : FastRuleChecker.pairAvailableB Layer20 8 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer20 9 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer20 10 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer20 11 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer20 12 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer20 13 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer20 14 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer20 15 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer20 16 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer20 17 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer20 18 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer20 19 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer20 20 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer20 21 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer20 22 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer20 23 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer20 24 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer20 25 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer20 26 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer20 27 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer20 28 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer20 29 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer20 30 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer20 31 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer20 32 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer20 33 = false := by decide +kernel
      rw [hf] at hp
      contradiction

theorem Layer20_notWin : ¬ Win Layer20 :=
  no_win_of_bounds Layer20_bounds (by decide +kernel) (by decide +kernel)

theorem Layer22_pair4 : FourLocalBounds (FastRuleChecker.removePair Layer22 4) (caps000 4) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Layer22 4) pattern000 (by decide +kernel) pattern000_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Layer22 4) pattern023 (by decide +kernel) pattern023_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Layer22 4) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Layer22 4) pattern033 (by decide +kernel) pattern033_checked

theorem Layer22_pair5 : FourLocalBounds (FastRuleChecker.removePair Layer22 5) (caps000 5) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Layer22 5) pattern001 (by decide +kernel) pattern001_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Layer22 5) pattern023 (by decide +kernel) pattern023_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Layer22 5) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Layer22 5) pattern033 (by decide +kernel) pattern033_checked

theorem Layer22_pair7 : FourLocalBounds (FastRuleChecker.removePair Layer22 7) (caps000 7) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Layer22 7) pattern002 (by decide +kernel) pattern002_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Layer22 7) pattern023 (by decide +kernel) pattern023_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Layer22 7) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Layer22 7) pattern033 (by decide +kernel) pattern033_checked

theorem Layer22_bounds : StandardBounds Layer22 caps000 where
  pair := by
    intro p hp
    have hm := mem_allTiles p
    simp only [allTiles, List.mem_cons, List.not_mem_nil, or_false] at hm
    rcases hm with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
    · have hf : FastRuleChecker.pairAvailableB Layer22 0 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer22 1 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer22 2 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer22 3 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Layer22_pair4
    · exact Layer22_pair5
    · have hf : FastRuleChecker.pairAvailableB Layer22 6 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Layer22_pair7
    · have hf : FastRuleChecker.pairAvailableB Layer22 8 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer22 9 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer22 10 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer22 11 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer22 12 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer22 13 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer22 14 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer22 15 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer22 16 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer22 17 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer22 18 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer22 19 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer22 20 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer22 21 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer22 22 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer22 23 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer22 24 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer22 25 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer22 26 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer22 27 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer22 28 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer22 29 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer22 30 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer22 31 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer22 32 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer22 33 = false := by decide +kernel
      rw [hf] at hp
      contradiction

theorem Layer22_notWin : ¬ Win Layer22 :=
  no_win_of_bounds Layer22_bounds (by decide +kernel) (by decide +kernel)

theorem Layer26_pair4 : FourLocalBounds (FastRuleChecker.removePair Layer26 4) (caps000 4) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Layer26 4) pattern000 (by decide +kernel) pattern000_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Layer26 4) pattern023 (by decide +kernel) pattern023_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Layer26 4) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Layer26 4) pattern033 (by decide +kernel) pattern033_checked

theorem Layer26_pair5 : FourLocalBounds (FastRuleChecker.removePair Layer26 5) (caps000 5) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Layer26 5) pattern001 (by decide +kernel) pattern001_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Layer26 5) pattern023 (by decide +kernel) pattern023_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Layer26 5) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Layer26 5) pattern033 (by decide +kernel) pattern033_checked

theorem Layer26_pair7 : FourLocalBounds (FastRuleChecker.removePair Layer26 7) (caps000 7) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Layer26 7) pattern002 (by decide +kernel) pattern002_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Layer26 7) pattern023 (by decide +kernel) pattern023_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Layer26 7) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Layer26 7) pattern033 (by decide +kernel) pattern033_checked

theorem Layer26_bounds : StandardBounds Layer26 caps000 where
  pair := by
    intro p hp
    have hm := mem_allTiles p
    simp only [allTiles, List.mem_cons, List.not_mem_nil, or_false] at hm
    rcases hm with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
    · have hf : FastRuleChecker.pairAvailableB Layer26 0 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer26 1 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer26 2 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer26 3 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Layer26_pair4
    · exact Layer26_pair5
    · have hf : FastRuleChecker.pairAvailableB Layer26 6 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Layer26_pair7
    · have hf : FastRuleChecker.pairAvailableB Layer26 8 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer26 9 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer26 10 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer26 11 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer26 12 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer26 13 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer26 14 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer26 15 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer26 16 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer26 17 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer26 18 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer26 19 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer26 20 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer26 21 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer26 22 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer26 23 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer26 24 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer26 25 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer26 26 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer26 27 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer26 28 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer26 29 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer26 30 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer26 31 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer26 32 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer26 33 = false := by decide +kernel
      rw [hf] at hp
      contradiction

theorem Layer26_notWin : ¬ Win Layer26 :=
  no_win_of_bounds Layer26_bounds (by decide +kernel) (by decide +kernel)

theorem Layer30_pair4 : FourLocalBounds (FastRuleChecker.removePair Layer30 4) (caps000 4) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Layer30 4) pattern000 (by decide +kernel) pattern000_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Layer30 4) pattern023 (by decide +kernel) pattern023_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Layer30 4) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Layer30 4) pattern033 (by decide +kernel) pattern033_checked

theorem Layer30_pair5 : FourLocalBounds (FastRuleChecker.removePair Layer30 5) (caps000 5) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Layer30 5) pattern001 (by decide +kernel) pattern001_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Layer30 5) pattern023 (by decide +kernel) pattern023_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Layer30 5) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Layer30 5) pattern033 (by decide +kernel) pattern033_checked

theorem Layer30_pair7 : FourLocalBounds (FastRuleChecker.removePair Layer30 7) (caps000 7) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Layer30 7) pattern002 (by decide +kernel) pattern002_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Layer30 7) pattern023 (by decide +kernel) pattern023_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Layer30 7) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Layer30 7) pattern033 (by decide +kernel) pattern033_checked

theorem Layer30_bounds : StandardBounds Layer30 caps000 where
  pair := by
    intro p hp
    have hm := mem_allTiles p
    simp only [allTiles, List.mem_cons, List.not_mem_nil, or_false] at hm
    rcases hm with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
    · have hf : FastRuleChecker.pairAvailableB Layer30 0 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer30 1 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer30 2 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer30 3 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Layer30_pair4
    · exact Layer30_pair5
    · have hf : FastRuleChecker.pairAvailableB Layer30 6 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Layer30_pair7
    · have hf : FastRuleChecker.pairAvailableB Layer30 8 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer30 9 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer30 10 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer30 11 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer30 12 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer30 13 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer30 14 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer30 15 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer30 16 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer30 17 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer30 18 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer30 19 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer30 20 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer30 21 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer30 22 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer30 23 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer30 24 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer30 25 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer30 26 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer30 27 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer30 28 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer30 29 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer30 30 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer30 31 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer30 32 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer30 33 = false := by decide +kernel
      rw [hf] at hp
      contradiction

theorem Layer30_notWin : ¬ Win Layer30 :=
  no_win_of_bounds Layer30_bounds (by decide +kernel) (by decide +kernel)

theorem Layer32_pair4 : FourLocalBounds (FastRuleChecker.removePair Layer32 4) (caps000 4) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Layer32 4) pattern000 (by decide +kernel) pattern000_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Layer32 4) pattern023 (by decide +kernel) pattern023_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Layer32 4) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Layer32 4) pattern033 (by decide +kernel) pattern033_checked

theorem Layer32_pair5 : FourLocalBounds (FastRuleChecker.removePair Layer32 5) (caps000 5) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Layer32 5) pattern001 (by decide +kernel) pattern001_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Layer32 5) pattern023 (by decide +kernel) pattern023_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Layer32 5) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Layer32 5) pattern033 (by decide +kernel) pattern033_checked

theorem Layer32_pair7 : FourLocalBounds (FastRuleChecker.removePair Layer32 7) (caps000 7) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Layer32 7) pattern002 (by decide +kernel) pattern002_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Layer32 7) pattern023 (by decide +kernel) pattern023_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Layer32 7) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Layer32 7) pattern033 (by decide +kernel) pattern033_checked

theorem Layer32_bounds : StandardBounds Layer32 caps000 where
  pair := by
    intro p hp
    have hm := mem_allTiles p
    simp only [allTiles, List.mem_cons, List.not_mem_nil, or_false] at hm
    rcases hm with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
    · have hf : FastRuleChecker.pairAvailableB Layer32 0 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer32 1 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer32 2 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer32 3 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Layer32_pair4
    · exact Layer32_pair5
    · have hf : FastRuleChecker.pairAvailableB Layer32 6 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Layer32_pair7
    · have hf : FastRuleChecker.pairAvailableB Layer32 8 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer32 9 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer32 10 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer32 11 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer32 12 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer32 13 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer32 14 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer32 15 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer32 16 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer32 17 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer32 18 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer32 19 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer32 20 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer32 21 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer32 22 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer32 23 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer32 24 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer32 25 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer32 26 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer32 27 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer32 28 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer32 29 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer32 30 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer32 31 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer32 32 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Layer32 33 = false := by decide +kernel
      rw [hf] at hp
      contradiction

theorem Layer32_notWin : ¬ Win Layer32 :=
  no_win_of_bounds Layer32_bounds (by decide +kernel) (by decide +kernel)

theorem Anchor34_pair4 : FourLocalBounds (FastRuleChecker.removePair Anchor34 4) (caps000 4) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Anchor34 4) pattern000 (by decide +kernel) pattern000_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Anchor34 4) pattern023 (by decide +kernel) pattern023_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Anchor34 4) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Anchor34 4) pattern033 (by decide +kernel) pattern033_checked

theorem Anchor34_pair5 : FourLocalBounds (FastRuleChecker.removePair Anchor34 5) (caps000 5) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Anchor34 5) pattern001 (by decide +kernel) pattern001_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Anchor34 5) pattern023 (by decide +kernel) pattern023_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Anchor34 5) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Anchor34 5) pattern033 (by decide +kernel) pattern033_checked

theorem Anchor34_pair7 : FourLocalBounds (FastRuleChecker.removePair Anchor34 7) (caps000 7) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Anchor34 7) pattern002 (by decide +kernel) pattern002_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Anchor34 7) pattern023 (by decide +kernel) pattern023_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Anchor34 7) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Anchor34 7) pattern033 (by decide +kernel) pattern033_checked

theorem Anchor34_bounds : StandardBounds Anchor34 caps000 where
  pair := by
    intro p hp
    have hm := mem_allTiles p
    simp only [allTiles, List.mem_cons, List.not_mem_nil, or_false] at hm
    rcases hm with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
    · have hf : FastRuleChecker.pairAvailableB Anchor34 0 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Anchor34 1 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Anchor34 2 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Anchor34 3 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Anchor34_pair4
    · exact Anchor34_pair5
    · have hf : FastRuleChecker.pairAvailableB Anchor34 6 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Anchor34_pair7
    · have hf : FastRuleChecker.pairAvailableB Anchor34 8 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Anchor34 9 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Anchor34 10 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Anchor34 11 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Anchor34 12 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Anchor34 13 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Anchor34 14 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Anchor34 15 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Anchor34 16 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Anchor34 17 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Anchor34 18 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Anchor34 19 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Anchor34 20 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Anchor34 21 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Anchor34 22 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Anchor34 23 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Anchor34 24 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Anchor34 25 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Anchor34 26 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Anchor34 27 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Anchor34 28 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Anchor34 29 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Anchor34 30 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Anchor34 31 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Anchor34 32 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Anchor34 33 = false := by decide +kernel
      rw [hf] at hp
      contradiction

theorem Anchor34_notWin : ¬ Win Anchor34 :=
  no_win_of_bounds Anchor34_bounds (by decide +kernel) (by decide +kernel)

theorem New34_1_pair4 : FourLocalBounds (FastRuleChecker.removePair New34_1 4) (caps000 4) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair New34_1 4) pattern003 (by decide +kernel) pattern003_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair New34_1 4) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair New34_1 4) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair New34_1 4) pattern033 (by decide +kernel) pattern033_checked

theorem New34_1_pair5 : FourLocalBounds (FastRuleChecker.removePair New34_1 5) (caps000 5) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair New34_1 5) pattern004 (by decide +kernel) pattern004_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair New34_1 5) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair New34_1 5) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair New34_1 5) pattern033 (by decide +kernel) pattern033_checked

theorem New34_1_pair7 : FourLocalBounds (FastRuleChecker.removePair New34_1 7) (caps000 7) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair New34_1 7) pattern005 (by decide +kernel) pattern005_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair New34_1 7) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair New34_1 7) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair New34_1 7) pattern033 (by decide +kernel) pattern033_checked

theorem New34_1_bounds : StandardBounds New34_1 caps000 where
  pair := by
    intro p hp
    have hm := mem_allTiles p
    simp only [allTiles, List.mem_cons, List.not_mem_nil, or_false] at hm
    rcases hm with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
    · have hf : FastRuleChecker.pairAvailableB New34_1 0 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_1 1 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_1 2 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_1 3 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact New34_1_pair4
    · exact New34_1_pair5
    · have hf : FastRuleChecker.pairAvailableB New34_1 6 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact New34_1_pair7
    · have hf : FastRuleChecker.pairAvailableB New34_1 8 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_1 9 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_1 10 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_1 11 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_1 12 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_1 13 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_1 14 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_1 15 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_1 16 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_1 17 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_1 18 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_1 19 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_1 20 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_1 21 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_1 22 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_1 23 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_1 24 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_1 25 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_1 26 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_1 27 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_1 28 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_1 29 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_1 30 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_1 31 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_1 32 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_1 33 = false := by decide +kernel
      rw [hf] at hp
      contradiction

theorem New34_1_notWin : ¬ Win New34_1 :=
  no_win_of_bounds New34_1_bounds (by decide +kernel) (by decide +kernel)

theorem New34_2_pair4 : FourLocalBounds (FastRuleChecker.removePair New34_2 4) (caps000 4) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair New34_2 4) pattern000 (by decide +kernel) pattern000_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair New34_2 4) pattern025 (by decide +kernel) pattern025_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair New34_2 4) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair New34_2 4) pattern033 (by decide +kernel) pattern033_checked

theorem New34_2_pair5 : FourLocalBounds (FastRuleChecker.removePair New34_2 5) (caps000 5) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair New34_2 5) pattern001 (by decide +kernel) pattern001_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair New34_2 5) pattern025 (by decide +kernel) pattern025_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair New34_2 5) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair New34_2 5) pattern033 (by decide +kernel) pattern033_checked

theorem New34_2_pair7 : FourLocalBounds (FastRuleChecker.removePair New34_2 7) (caps000 7) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair New34_2 7) pattern002 (by decide +kernel) pattern002_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair New34_2 7) pattern025 (by decide +kernel) pattern025_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair New34_2 7) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair New34_2 7) pattern033 (by decide +kernel) pattern033_checked

theorem New34_2_bounds : StandardBounds New34_2 caps000 where
  pair := by
    intro p hp
    have hm := mem_allTiles p
    simp only [allTiles, List.mem_cons, List.not_mem_nil, or_false] at hm
    rcases hm with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
    · have hf : FastRuleChecker.pairAvailableB New34_2 0 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_2 1 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_2 2 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_2 3 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact New34_2_pair4
    · exact New34_2_pair5
    · have hf : FastRuleChecker.pairAvailableB New34_2 6 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact New34_2_pair7
    · have hf : FastRuleChecker.pairAvailableB New34_2 8 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_2 9 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_2 10 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_2 11 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_2 12 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_2 13 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_2 14 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_2 15 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_2 16 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_2 17 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_2 18 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_2 19 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_2 20 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_2 21 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_2 22 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_2 23 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_2 24 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_2 25 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_2 26 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_2 27 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_2 28 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_2 29 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_2 30 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_2 31 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_2 32 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_2 33 = false := by decide +kernel
      rw [hf] at hp
      contradiction

theorem New34_2_notWin : ¬ Win New34_2 :=
  no_win_of_bounds New34_2_bounds (by decide +kernel) (by decide +kernel)

theorem New34_3_pair4 : FourLocalBounds (FastRuleChecker.removePair New34_3 4) (caps000 4) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair New34_3 4) pattern000 (by decide +kernel) pattern000_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair New34_3 4) pattern024 (by decide +kernel) pattern024_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair New34_3 4) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair New34_3 4) pattern033 (by decide +kernel) pattern033_checked

theorem New34_3_pair5 : FourLocalBounds (FastRuleChecker.removePair New34_3 5) (caps000 5) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair New34_3 5) pattern001 (by decide +kernel) pattern001_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair New34_3 5) pattern024 (by decide +kernel) pattern024_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair New34_3 5) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair New34_3 5) pattern033 (by decide +kernel) pattern033_checked

theorem New34_3_pair7 : FourLocalBounds (FastRuleChecker.removePair New34_3 7) (caps000 7) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair New34_3 7) pattern002 (by decide +kernel) pattern002_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair New34_3 7) pattern024 (by decide +kernel) pattern024_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair New34_3 7) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair New34_3 7) pattern033 (by decide +kernel) pattern033_checked

theorem New34_3_bounds : StandardBounds New34_3 caps000 where
  pair := by
    intro p hp
    have hm := mem_allTiles p
    simp only [allTiles, List.mem_cons, List.not_mem_nil, or_false] at hm
    rcases hm with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
    · have hf : FastRuleChecker.pairAvailableB New34_3 0 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_3 1 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_3 2 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_3 3 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact New34_3_pair4
    · exact New34_3_pair5
    · have hf : FastRuleChecker.pairAvailableB New34_3 6 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact New34_3_pair7
    · have hf : FastRuleChecker.pairAvailableB New34_3 8 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_3 9 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_3 10 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_3 11 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_3 12 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_3 13 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_3 14 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_3 15 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_3 16 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_3 17 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_3 18 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_3 19 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_3 20 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_3 21 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_3 22 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_3 23 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_3 24 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_3 25 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_3 26 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_3 27 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_3 28 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_3 29 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_3 30 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_3 31 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_3 32 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB New34_3 33 = false := by decide +kernel
      rw [hf] at hp
      contradiction

theorem New34_3_notWin : ¬ Win New34_3 :=
  no_win_of_bounds New34_3_bounds (by decide +kernel) (by decide +kernel)

def Child00 : State := addTile New34_1 0

theorem Child00_pair0 : FourLocalBounds (FastRuleChecker.removePair Child00 0) (caps001 0) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 3 (FastRuleChecker.removePair Child00 0) pattern014 (by decide +kernel) pattern014_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child00 0) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child00 0) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child00 0) pattern033 (by decide +kernel) pattern033_checked

theorem Child00_pair4 : FourLocalBounds (FastRuleChecker.removePair Child00 4) (caps001 4) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child00 4) pattern009 (by decide +kernel) pattern009_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child00 4) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child00 4) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child00 4) pattern033 (by decide +kernel) pattern033_checked

theorem Child00_pair5 : FourLocalBounds (FastRuleChecker.removePair Child00 5) (caps001 5) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child00 5) pattern010 (by decide +kernel) pattern010_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child00 5) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child00 5) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child00 5) pattern033 (by decide +kernel) pattern033_checked

theorem Child00_pair7 : FourLocalBounds (FastRuleChecker.removePair Child00 7) (caps001 7) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child00 7) pattern011 (by decide +kernel) pattern011_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child00 7) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child00 7) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child00 7) pattern033 (by decide +kernel) pattern033_checked

theorem Child00_bounds : StandardBounds Child00 caps001 where
  pair := by
    intro p hp
    have hm := mem_allTiles p
    simp only [allTiles, List.mem_cons, List.not_mem_nil, or_false] at hm
    rcases hm with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
    · exact Child00_pair0
    · have hf : FastRuleChecker.pairAvailableB Child00 1 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child00 2 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child00 3 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child00_pair4
    · exact Child00_pair5
    · have hf : FastRuleChecker.pairAvailableB Child00 6 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child00_pair7
    · have hf : FastRuleChecker.pairAvailableB Child00 8 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child00 9 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child00 10 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child00 11 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child00 12 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child00 13 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child00 14 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child00 15 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child00 16 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child00 17 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child00 18 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child00 19 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child00 20 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child00 21 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child00 22 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child00 23 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child00 24 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child00 25 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child00 26 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child00 27 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child00 28 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child00 29 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child00 30 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child00 31 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child00 32 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child00 33 = false := by decide +kernel
      rw [hf] at hp
      contradiction

theorem Child00_notWin : ¬ Win Child00 :=
  no_win_of_bounds Child00_bounds (by decide +kernel) (by decide +kernel)

def Child01 : State := addTile New34_1 1

theorem Child01_pair4 : FourLocalBounds (FastRuleChecker.removePair Child01 4) (caps002 4) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 3 (FastRuleChecker.removePair Child01 4) pattern019 (by decide +kernel) pattern019_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child01 4) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child01 4) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child01 4) pattern033 (by decide +kernel) pattern033_checked

theorem Child01_pair5 : FourLocalBounds (FastRuleChecker.removePair Child01 5) (caps002 5) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 3 (FastRuleChecker.removePair Child01 5) pattern020 (by decide +kernel) pattern020_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child01 5) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child01 5) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child01 5) pattern033 (by decide +kernel) pattern033_checked

theorem Child01_pair7 : FourLocalBounds (FastRuleChecker.removePair Child01 7) (caps002 7) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 3 (FastRuleChecker.removePair Child01 7) pattern021 (by decide +kernel) pattern021_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child01 7) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child01 7) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child01 7) pattern033 (by decide +kernel) pattern033_checked

theorem Child01_bounds : StandardBounds Child01 caps002 where
  pair := by
    intro p hp
    have hm := mem_allTiles p
    simp only [allTiles, List.mem_cons, List.not_mem_nil, or_false] at hm
    rcases hm with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
    · have hf : FastRuleChecker.pairAvailableB Child01 0 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child01 1 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child01 2 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child01 3 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child01_pair4
    · exact Child01_pair5
    · have hf : FastRuleChecker.pairAvailableB Child01 6 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child01_pair7
    · have hf : FastRuleChecker.pairAvailableB Child01 8 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child01 9 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child01 10 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child01 11 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child01 12 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child01 13 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child01 14 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child01 15 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child01 16 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child01 17 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child01 18 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child01 19 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child01 20 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child01 21 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child01 22 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child01 23 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child01 24 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child01 25 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child01 26 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child01 27 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child01 28 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child01 29 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child01 30 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child01 31 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child01 32 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child01 33 = false := by decide +kernel
      rw [hf] at hp
      contradiction

theorem Child01_notWin : ¬ Win Child01 :=
  no_win_of_bounds Child01_bounds (by decide +kernel) (by decide +kernel)

def Child02 : State := addTile New34_1 2

theorem Child02_pair2 : FourLocalBounds (FastRuleChecker.removePair Child02 2) (caps003 2) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 3 (FastRuleChecker.removePair Child02 2) pattern014 (by decide +kernel) pattern014_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child02 2) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child02 2) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child02 2) pattern033 (by decide +kernel) pattern033_checked

theorem Child02_pair4 : FourLocalBounds (FastRuleChecker.removePair Child02 4) (caps003 4) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child02 4) pattern006 (by decide +kernel) pattern006_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child02 4) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child02 4) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child02 4) pattern033 (by decide +kernel) pattern033_checked

theorem Child02_pair5 : FourLocalBounds (FastRuleChecker.removePair Child02 5) (caps003 5) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child02 5) pattern007 (by decide +kernel) pattern007_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child02 5) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child02 5) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child02 5) pattern033 (by decide +kernel) pattern033_checked

theorem Child02_pair7 : FourLocalBounds (FastRuleChecker.removePair Child02 7) (caps003 7) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child02 7) pattern008 (by decide +kernel) pattern008_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child02 7) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child02 7) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child02 7) pattern033 (by decide +kernel) pattern033_checked

theorem Child02_bounds : StandardBounds Child02 caps003 where
  pair := by
    intro p hp
    have hm := mem_allTiles p
    simp only [allTiles, List.mem_cons, List.not_mem_nil, or_false] at hm
    rcases hm with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
    · have hf : FastRuleChecker.pairAvailableB Child02 0 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child02 1 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child02_pair2
    · have hf : FastRuleChecker.pairAvailableB Child02 3 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child02_pair4
    · exact Child02_pair5
    · have hf : FastRuleChecker.pairAvailableB Child02 6 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child02_pair7
    · have hf : FastRuleChecker.pairAvailableB Child02 8 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child02 9 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child02 10 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child02 11 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child02 12 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child02 13 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child02 14 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child02 15 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child02 16 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child02 17 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child02 18 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child02 19 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child02 20 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child02 21 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child02 22 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child02 23 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child02 24 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child02 25 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child02 26 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child02 27 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child02 28 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child02 29 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child02 30 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child02 31 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child02 32 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child02 33 = false := by decide +kernel
      rw [hf] at hp
      contradiction

theorem Child02_notWin : ¬ Win Child02 :=
  no_win_of_bounds Child02_bounds (by decide +kernel) (by decide +kernel)

def Child03 : State := addTile New34_1 3

theorem Child03_pair4 : FourLocalBounds (FastRuleChecker.removePair Child03 4) (caps002 4) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 3 (FastRuleChecker.removePair Child03 4) pattern016 (by decide +kernel) pattern016_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child03 4) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child03 4) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child03 4) pattern033 (by decide +kernel) pattern033_checked

theorem Child03_pair5 : FourLocalBounds (FastRuleChecker.removePair Child03 5) (caps002 5) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 3 (FastRuleChecker.removePair Child03 5) pattern017 (by decide +kernel) pattern017_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child03 5) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child03 5) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child03 5) pattern033 (by decide +kernel) pattern033_checked

theorem Child03_pair7 : FourLocalBounds (FastRuleChecker.removePair Child03 7) (caps002 7) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 3 (FastRuleChecker.removePair Child03 7) pattern018 (by decide +kernel) pattern018_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child03 7) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child03 7) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child03 7) pattern033 (by decide +kernel) pattern033_checked

theorem Child03_bounds : StandardBounds Child03 caps002 where
  pair := by
    intro p hp
    have hm := mem_allTiles p
    simp only [allTiles, List.mem_cons, List.not_mem_nil, or_false] at hm
    rcases hm with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
    · have hf : FastRuleChecker.pairAvailableB Child03 0 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child03 1 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child03 2 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child03 3 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child03_pair4
    · exact Child03_pair5
    · have hf : FastRuleChecker.pairAvailableB Child03 6 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child03_pair7
    · have hf : FastRuleChecker.pairAvailableB Child03 8 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child03 9 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child03 10 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child03 11 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child03 12 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child03 13 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child03 14 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child03 15 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child03 16 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child03 17 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child03 18 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child03 19 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child03 20 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child03 21 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child03 22 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child03 23 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child03 24 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child03 25 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child03 26 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child03 27 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child03 28 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child03 29 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child03 30 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child03 31 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child03 32 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child03 33 = false := by decide +kernel
      rw [hf] at hp
      contradiction

theorem Child03_notWin : ¬ Win Child03 :=
  no_win_of_bounds Child03_bounds (by decide +kernel) (by decide +kernel)

def Child06 : State := addTile New34_1 6

theorem Child06_pair4 : FourLocalBounds (FastRuleChecker.removePair Child06 4) (caps002 4) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 3 (FastRuleChecker.removePair Child06 4) pattern012 (by decide +kernel) pattern012_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child06 4) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child06 4) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child06 4) pattern033 (by decide +kernel) pattern033_checked

theorem Child06_pair5 : FourLocalBounds (FastRuleChecker.removePair Child06 5) (caps002 5) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 3 (FastRuleChecker.removePair Child06 5) pattern013 (by decide +kernel) pattern013_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child06 5) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child06 5) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child06 5) pattern033 (by decide +kernel) pattern033_checked

theorem Child06_pair7 : FourLocalBounds (FastRuleChecker.removePair Child06 7) (caps002 7) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 3 (FastRuleChecker.removePair Child06 7) pattern015 (by decide +kernel) pattern015_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child06 7) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child06 7) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child06 7) pattern033 (by decide +kernel) pattern033_checked

theorem Child06_bounds : StandardBounds Child06 caps002 where
  pair := by
    intro p hp
    have hm := mem_allTiles p
    simp only [allTiles, List.mem_cons, List.not_mem_nil, or_false] at hm
    rcases hm with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
    · have hf : FastRuleChecker.pairAvailableB Child06 0 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child06 1 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child06 2 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child06 3 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child06_pair4
    · exact Child06_pair5
    · have hf : FastRuleChecker.pairAvailableB Child06 6 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child06_pair7
    · have hf : FastRuleChecker.pairAvailableB Child06 8 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child06 9 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child06 10 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child06 11 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child06 12 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child06 13 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child06 14 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child06 15 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child06 16 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child06 17 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child06 18 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child06 19 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child06 20 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child06 21 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child06 22 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child06 23 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child06 24 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child06 25 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child06 26 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child06 27 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child06 28 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child06 29 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child06 30 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child06 31 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child06 32 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child06 33 = false := by decide +kernel
      rw [hf] at hp
      contradiction

theorem Child06_notWin : ¬ Win Child06 :=
  no_win_of_bounds Child06_bounds (by decide +kernel) (by decide +kernel)

def Child08 : State := addTile New34_1 8

theorem Child08_pair4 : FourLocalBounds (FastRuleChecker.removePair Child08 4) (caps004 4) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child08 4) pattern003 (by decide +kernel) pattern003_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child08 4) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child08 4) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child08 4) pattern033 (by decide +kernel) pattern033_checked

theorem Child08_pair5 : FourLocalBounds (FastRuleChecker.removePair Child08 5) (caps004 5) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child08 5) pattern004 (by decide +kernel) pattern004_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child08 5) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child08 5) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child08 5) pattern033 (by decide +kernel) pattern033_checked

theorem Child08_pair7 : FourLocalBounds (FastRuleChecker.removePair Child08 7) (caps004 7) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child08 7) pattern005 (by decide +kernel) pattern005_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child08 7) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child08 7) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child08 7) pattern033 (by decide +kernel) pattern033_checked

theorem Child08_pair8 : FourLocalBounds (FastRuleChecker.removePair Child08 8) (caps004 8) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 3 (FastRuleChecker.removePair Child08 8) pattern014 (by decide +kernel) pattern014_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child08 8) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child08 8) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child08 8) pattern033 (by decide +kernel) pattern033_checked

theorem Child08_bounds : StandardBounds Child08 caps004 where
  pair := by
    intro p hp
    have hm := mem_allTiles p
    simp only [allTiles, List.mem_cons, List.not_mem_nil, or_false] at hm
    rcases hm with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
    · have hf : FastRuleChecker.pairAvailableB Child08 0 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child08 1 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child08 2 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child08 3 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child08_pair4
    · exact Child08_pair5
    · have hf : FastRuleChecker.pairAvailableB Child08 6 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child08_pair7
    · exact Child08_pair8
    · have hf : FastRuleChecker.pairAvailableB Child08 9 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child08 10 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child08 11 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child08 12 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child08 13 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child08 14 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child08 15 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child08 16 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child08 17 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child08 18 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child08 19 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child08 20 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child08 21 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child08 22 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child08 23 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child08 24 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child08 25 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child08 26 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child08 27 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child08 28 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child08 29 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child08 30 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child08 31 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child08 32 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child08 33 = false := by decide +kernel
      rw [hf] at hp
      contradiction

theorem Child08_notWin : ¬ Win Child08 :=
  no_win_of_bounds Child08_bounds (by decide +kernel) (by decide +kernel)

def Child09 : State := addTile New34_1 9

theorem Child09_pair4 : FourLocalBounds (FastRuleChecker.removePair Child09 4) (caps005 4) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child09 4) pattern003 (by decide +kernel) pattern003_checked
  suit1 := transfer_upper 1 1 (FastRuleChecker.removePair Child09 4) pattern028 (by decide +kernel) pattern028_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child09 4) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child09 4) pattern033 (by decide +kernel) pattern033_checked

theorem Child09_pair5 : FourLocalBounds (FastRuleChecker.removePair Child09 5) (caps005 5) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child09 5) pattern004 (by decide +kernel) pattern004_checked
  suit1 := transfer_upper 1 1 (FastRuleChecker.removePair Child09 5) pattern028 (by decide +kernel) pattern028_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child09 5) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child09 5) pattern033 (by decide +kernel) pattern033_checked

theorem Child09_pair7 : FourLocalBounds (FastRuleChecker.removePair Child09 7) (caps005 7) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child09 7) pattern005 (by decide +kernel) pattern005_checked
  suit1 := transfer_upper 1 1 (FastRuleChecker.removePair Child09 7) pattern028 (by decide +kernel) pattern028_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child09 7) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child09 7) pattern033 (by decide +kernel) pattern033_checked

theorem Child09_bounds : StandardBounds Child09 caps005 where
  pair := by
    intro p hp
    have hm := mem_allTiles p
    simp only [allTiles, List.mem_cons, List.not_mem_nil, or_false] at hm
    rcases hm with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
    · have hf : FastRuleChecker.pairAvailableB Child09 0 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child09 1 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child09 2 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child09 3 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child09_pair4
    · exact Child09_pair5
    · have hf : FastRuleChecker.pairAvailableB Child09 6 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child09_pair7
    · have hf : FastRuleChecker.pairAvailableB Child09 8 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child09 9 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child09 10 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child09 11 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child09 12 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child09 13 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child09 14 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child09 15 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child09 16 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child09 17 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child09 18 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child09 19 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child09 20 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child09 21 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child09 22 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child09 23 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child09 24 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child09 25 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child09 26 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child09 27 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child09 28 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child09 29 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child09 30 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child09 31 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child09 32 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child09 33 = false := by decide +kernel
      rw [hf] at hp
      contradiction

theorem Child09_notWin : ¬ Win Child09 :=
  no_win_of_bounds Child09_bounds (by decide +kernel) (by decide +kernel)

def Child10 : State := addTile New34_1 10

theorem Child10_pair4 : FourLocalBounds (FastRuleChecker.removePair Child10 4) (caps006 4) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child10 4) pattern003 (by decide +kernel) pattern003_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child10 4) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child10 4) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child10 4) pattern033 (by decide +kernel) pattern033_checked

theorem Child10_pair5 : FourLocalBounds (FastRuleChecker.removePair Child10 5) (caps006 5) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child10 5) pattern004 (by decide +kernel) pattern004_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child10 5) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child10 5) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child10 5) pattern033 (by decide +kernel) pattern033_checked

theorem Child10_pair7 : FourLocalBounds (FastRuleChecker.removePair Child10 7) (caps006 7) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child10 7) pattern005 (by decide +kernel) pattern005_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child10 7) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child10 7) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child10 7) pattern033 (by decide +kernel) pattern033_checked

theorem Child10_pair10 : FourLocalBounds (FastRuleChecker.removePair Child10 10) (caps006 10) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 3 (FastRuleChecker.removePair Child10 10) pattern014 (by decide +kernel) pattern014_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child10 10) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child10 10) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child10 10) pattern033 (by decide +kernel) pattern033_checked

theorem Child10_bounds : StandardBounds Child10 caps006 where
  pair := by
    intro p hp
    have hm := mem_allTiles p
    simp only [allTiles, List.mem_cons, List.not_mem_nil, or_false] at hm
    rcases hm with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
    · have hf : FastRuleChecker.pairAvailableB Child10 0 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child10 1 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child10 2 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child10 3 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child10_pair4
    · exact Child10_pair5
    · have hf : FastRuleChecker.pairAvailableB Child10 6 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child10_pair7
    · have hf : FastRuleChecker.pairAvailableB Child10 8 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child10 9 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child10_pair10
    · have hf : FastRuleChecker.pairAvailableB Child10 11 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child10 12 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child10 13 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child10 14 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child10 15 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child10 16 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child10 17 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child10 18 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child10 19 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child10 20 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child10 21 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child10 22 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child10 23 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child10 24 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child10 25 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child10 26 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child10 27 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child10 28 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child10 29 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child10 30 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child10 31 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child10 32 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child10 33 = false := by decide +kernel
      rw [hf] at hp
      contradiction

theorem Child10_notWin : ¬ Win Child10 :=
  no_win_of_bounds Child10_bounds (by decide +kernel) (by decide +kernel)

def Child11 : State := addTile New34_1 11

theorem Child11_pair4 : FourLocalBounds (FastRuleChecker.removePair Child11 4) (caps007 4) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child11 4) pattern003 (by decide +kernel) pattern003_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child11 4) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child11 4) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child11 4) pattern033 (by decide +kernel) pattern033_checked

theorem Child11_pair5 : FourLocalBounds (FastRuleChecker.removePair Child11 5) (caps007 5) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child11 5) pattern004 (by decide +kernel) pattern004_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child11 5) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child11 5) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child11 5) pattern033 (by decide +kernel) pattern033_checked

theorem Child11_pair7 : FourLocalBounds (FastRuleChecker.removePair Child11 7) (caps007 7) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child11 7) pattern005 (by decide +kernel) pattern005_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child11 7) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child11 7) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child11 7) pattern033 (by decide +kernel) pattern033_checked

theorem Child11_pair11 : FourLocalBounds (FastRuleChecker.removePair Child11 11) (caps007 11) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 3 (FastRuleChecker.removePair Child11 11) pattern014 (by decide +kernel) pattern014_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child11 11) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child11 11) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child11 11) pattern033 (by decide +kernel) pattern033_checked

theorem Child11_bounds : StandardBounds Child11 caps007 where
  pair := by
    intro p hp
    have hm := mem_allTiles p
    simp only [allTiles, List.mem_cons, List.not_mem_nil, or_false] at hm
    rcases hm with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
    · have hf : FastRuleChecker.pairAvailableB Child11 0 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child11 1 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child11 2 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child11 3 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child11_pair4
    · exact Child11_pair5
    · have hf : FastRuleChecker.pairAvailableB Child11 6 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child11_pair7
    · have hf : FastRuleChecker.pairAvailableB Child11 8 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child11 9 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child11 10 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child11_pair11
    · have hf : FastRuleChecker.pairAvailableB Child11 12 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child11 13 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child11 14 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child11 15 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child11 16 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child11 17 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child11 18 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child11 19 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child11 20 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child11 21 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child11 22 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child11 23 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child11 24 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child11 25 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child11 26 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child11 27 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child11 28 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child11 29 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child11 30 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child11 31 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child11 32 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child11 33 = false := by decide +kernel
      rw [hf] at hp
      contradiction

theorem Child11_notWin : ¬ Win Child11 :=
  no_win_of_bounds Child11_bounds (by decide +kernel) (by decide +kernel)

def Child12 : State := addTile New34_1 12

theorem Child12_pair4 : FourLocalBounds (FastRuleChecker.removePair Child12 4) (caps005 4) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child12 4) pattern003 (by decide +kernel) pattern003_checked
  suit1 := transfer_upper 1 1 (FastRuleChecker.removePair Child12 4) pattern027 (by decide +kernel) pattern027_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child12 4) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child12 4) pattern033 (by decide +kernel) pattern033_checked

theorem Child12_pair5 : FourLocalBounds (FastRuleChecker.removePair Child12 5) (caps005 5) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child12 5) pattern004 (by decide +kernel) pattern004_checked
  suit1 := transfer_upper 1 1 (FastRuleChecker.removePair Child12 5) pattern027 (by decide +kernel) pattern027_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child12 5) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child12 5) pattern033 (by decide +kernel) pattern033_checked

theorem Child12_pair7 : FourLocalBounds (FastRuleChecker.removePair Child12 7) (caps005 7) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child12 7) pattern005 (by decide +kernel) pattern005_checked
  suit1 := transfer_upper 1 1 (FastRuleChecker.removePair Child12 7) pattern027 (by decide +kernel) pattern027_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child12 7) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child12 7) pattern033 (by decide +kernel) pattern033_checked

theorem Child12_bounds : StandardBounds Child12 caps005 where
  pair := by
    intro p hp
    have hm := mem_allTiles p
    simp only [allTiles, List.mem_cons, List.not_mem_nil, or_false] at hm
    rcases hm with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
    · have hf : FastRuleChecker.pairAvailableB Child12 0 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child12 1 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child12 2 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child12 3 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child12_pair4
    · exact Child12_pair5
    · have hf : FastRuleChecker.pairAvailableB Child12 6 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child12_pair7
    · have hf : FastRuleChecker.pairAvailableB Child12 8 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child12 9 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child12 10 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child12 11 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child12 12 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child12 13 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child12 14 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child12 15 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child12 16 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child12 17 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child12 18 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child12 19 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child12 20 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child12 21 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child12 22 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child12 23 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child12 24 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child12 25 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child12 26 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child12 27 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child12 28 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child12 29 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child12 30 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child12 31 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child12 32 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child12 33 = false := by decide +kernel
      rw [hf] at hp
      contradiction

theorem Child12_notWin : ¬ Win Child12 :=
  no_win_of_bounds Child12_bounds (by decide +kernel) (by decide +kernel)

def Child13 : State := addTile New34_1 13

theorem Child13_pair4 : FourLocalBounds (FastRuleChecker.removePair Child13 4) (caps008 4) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child13 4) pattern003 (by decide +kernel) pattern003_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child13 4) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child13 4) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child13 4) pattern033 (by decide +kernel) pattern033_checked

theorem Child13_pair5 : FourLocalBounds (FastRuleChecker.removePair Child13 5) (caps008 5) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child13 5) pattern004 (by decide +kernel) pattern004_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child13 5) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child13 5) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child13 5) pattern033 (by decide +kernel) pattern033_checked

theorem Child13_pair7 : FourLocalBounds (FastRuleChecker.removePair Child13 7) (caps008 7) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child13 7) pattern005 (by decide +kernel) pattern005_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child13 7) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child13 7) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child13 7) pattern033 (by decide +kernel) pattern033_checked

theorem Child13_pair13 : FourLocalBounds (FastRuleChecker.removePair Child13 13) (caps008 13) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 3 (FastRuleChecker.removePair Child13 13) pattern014 (by decide +kernel) pattern014_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child13 13) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child13 13) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child13 13) pattern033 (by decide +kernel) pattern033_checked

theorem Child13_bounds : StandardBounds Child13 caps008 where
  pair := by
    intro p hp
    have hm := mem_allTiles p
    simp only [allTiles, List.mem_cons, List.not_mem_nil, or_false] at hm
    rcases hm with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
    · have hf : FastRuleChecker.pairAvailableB Child13 0 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child13 1 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child13 2 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child13 3 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child13_pair4
    · exact Child13_pair5
    · have hf : FastRuleChecker.pairAvailableB Child13 6 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child13_pair7
    · have hf : FastRuleChecker.pairAvailableB Child13 8 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child13 9 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child13 10 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child13 11 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child13 12 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child13_pair13
    · have hf : FastRuleChecker.pairAvailableB Child13 14 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child13 15 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child13 16 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child13 17 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child13 18 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child13 19 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child13 20 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child13 21 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child13 22 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child13 23 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child13 24 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child13 25 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child13 26 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child13 27 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child13 28 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child13 29 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child13 30 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child13 31 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child13 32 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child13 33 = false := by decide +kernel
      rw [hf] at hp
      contradiction

theorem Child13_notWin : ¬ Win Child13 :=
  no_win_of_bounds Child13_bounds (by decide +kernel) (by decide +kernel)

def Child14 : State := addTile New34_1 14

theorem Child14_pair4 : FourLocalBounds (FastRuleChecker.removePair Child14 4) (caps009 4) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child14 4) pattern003 (by decide +kernel) pattern003_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child14 4) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child14 4) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child14 4) pattern033 (by decide +kernel) pattern033_checked

theorem Child14_pair5 : FourLocalBounds (FastRuleChecker.removePair Child14 5) (caps009 5) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child14 5) pattern004 (by decide +kernel) pattern004_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child14 5) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child14 5) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child14 5) pattern033 (by decide +kernel) pattern033_checked

theorem Child14_pair7 : FourLocalBounds (FastRuleChecker.removePair Child14 7) (caps009 7) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child14 7) pattern005 (by decide +kernel) pattern005_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child14 7) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child14 7) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child14 7) pattern033 (by decide +kernel) pattern033_checked

theorem Child14_pair14 : FourLocalBounds (FastRuleChecker.removePair Child14 14) (caps009 14) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 3 (FastRuleChecker.removePair Child14 14) pattern014 (by decide +kernel) pattern014_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child14 14) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child14 14) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child14 14) pattern033 (by decide +kernel) pattern033_checked

theorem Child14_bounds : StandardBounds Child14 caps009 where
  pair := by
    intro p hp
    have hm := mem_allTiles p
    simp only [allTiles, List.mem_cons, List.not_mem_nil, or_false] at hm
    rcases hm with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
    · have hf : FastRuleChecker.pairAvailableB Child14 0 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child14 1 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child14 2 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child14 3 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child14_pair4
    · exact Child14_pair5
    · have hf : FastRuleChecker.pairAvailableB Child14 6 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child14_pair7
    · have hf : FastRuleChecker.pairAvailableB Child14 8 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child14 9 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child14 10 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child14 11 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child14 12 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child14 13 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child14_pair14
    · have hf : FastRuleChecker.pairAvailableB Child14 15 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child14 16 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child14 17 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child14 18 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child14 19 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child14 20 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child14 21 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child14 22 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child14 23 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child14 24 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child14 25 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child14 26 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child14 27 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child14 28 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child14 29 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child14 30 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child14 31 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child14 32 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child14 33 = false := by decide +kernel
      rw [hf] at hp
      contradiction

theorem Child14_notWin : ¬ Win Child14 :=
  no_win_of_bounds Child14_bounds (by decide +kernel) (by decide +kernel)

def Child15 : State := addTile New34_1 15

theorem Child15_pair4 : FourLocalBounds (FastRuleChecker.removePair Child15 4) (caps005 4) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child15 4) pattern003 (by decide +kernel) pattern003_checked
  suit1 := transfer_upper 1 1 (FastRuleChecker.removePair Child15 4) pattern026 (by decide +kernel) pattern026_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child15 4) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child15 4) pattern033 (by decide +kernel) pattern033_checked

theorem Child15_pair5 : FourLocalBounds (FastRuleChecker.removePair Child15 5) (caps005 5) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child15 5) pattern004 (by decide +kernel) pattern004_checked
  suit1 := transfer_upper 1 1 (FastRuleChecker.removePair Child15 5) pattern026 (by decide +kernel) pattern026_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child15 5) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child15 5) pattern033 (by decide +kernel) pattern033_checked

theorem Child15_pair7 : FourLocalBounds (FastRuleChecker.removePair Child15 7) (caps005 7) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child15 7) pattern005 (by decide +kernel) pattern005_checked
  suit1 := transfer_upper 1 1 (FastRuleChecker.removePair Child15 7) pattern026 (by decide +kernel) pattern026_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child15 7) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child15 7) pattern033 (by decide +kernel) pattern033_checked

theorem Child15_bounds : StandardBounds Child15 caps005 where
  pair := by
    intro p hp
    have hm := mem_allTiles p
    simp only [allTiles, List.mem_cons, List.not_mem_nil, or_false] at hm
    rcases hm with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
    · have hf : FastRuleChecker.pairAvailableB Child15 0 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child15 1 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child15 2 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child15 3 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child15_pair4
    · exact Child15_pair5
    · have hf : FastRuleChecker.pairAvailableB Child15 6 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child15_pair7
    · have hf : FastRuleChecker.pairAvailableB Child15 8 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child15 9 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child15 10 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child15 11 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child15 12 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child15 13 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child15 14 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child15 15 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child15 16 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child15 17 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child15 18 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child15 19 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child15 20 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child15 21 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child15 22 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child15 23 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child15 24 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child15 25 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child15 26 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child15 27 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child15 28 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child15 29 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child15 30 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child15 31 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child15 32 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child15 33 = false := by decide +kernel
      rw [hf] at hp
      contradiction

theorem Child15_notWin : ¬ Win Child15 :=
  no_win_of_bounds Child15_bounds (by decide +kernel) (by decide +kernel)

def Child16 : State := addTile New34_1 16

theorem Child16_pair4 : FourLocalBounds (FastRuleChecker.removePair Child16 4) (caps010 4) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child16 4) pattern003 (by decide +kernel) pattern003_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child16 4) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child16 4) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child16 4) pattern033 (by decide +kernel) pattern033_checked

theorem Child16_pair5 : FourLocalBounds (FastRuleChecker.removePair Child16 5) (caps010 5) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child16 5) pattern004 (by decide +kernel) pattern004_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child16 5) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child16 5) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child16 5) pattern033 (by decide +kernel) pattern033_checked

theorem Child16_pair7 : FourLocalBounds (FastRuleChecker.removePair Child16 7) (caps010 7) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child16 7) pattern005 (by decide +kernel) pattern005_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child16 7) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child16 7) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child16 7) pattern033 (by decide +kernel) pattern033_checked

theorem Child16_pair16 : FourLocalBounds (FastRuleChecker.removePair Child16 16) (caps010 16) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 3 (FastRuleChecker.removePair Child16 16) pattern014 (by decide +kernel) pattern014_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child16 16) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child16 16) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child16 16) pattern033 (by decide +kernel) pattern033_checked

theorem Child16_bounds : StandardBounds Child16 caps010 where
  pair := by
    intro p hp
    have hm := mem_allTiles p
    simp only [allTiles, List.mem_cons, List.not_mem_nil, or_false] at hm
    rcases hm with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
    · have hf : FastRuleChecker.pairAvailableB Child16 0 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child16 1 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child16 2 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child16 3 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child16_pair4
    · exact Child16_pair5
    · have hf : FastRuleChecker.pairAvailableB Child16 6 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child16_pair7
    · have hf : FastRuleChecker.pairAvailableB Child16 8 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child16 9 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child16 10 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child16 11 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child16 12 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child16 13 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child16 14 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child16 15 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child16_pair16
    · have hf : FastRuleChecker.pairAvailableB Child16 17 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child16 18 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child16 19 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child16 20 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child16 21 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child16 22 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child16 23 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child16 24 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child16 25 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child16 26 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child16 27 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child16 28 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child16 29 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child16 30 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child16 31 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child16 32 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child16 33 = false := by decide +kernel
      rw [hf] at hp
      contradiction

theorem Child16_notWin : ¬ Win Child16 :=
  no_win_of_bounds Child16_bounds (by decide +kernel) (by decide +kernel)

def Child17 : State := addTile New34_1 17

theorem Child17_pair4 : FourLocalBounds (FastRuleChecker.removePair Child17 4) (caps011 4) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child17 4) pattern003 (by decide +kernel) pattern003_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child17 4) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child17 4) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child17 4) pattern033 (by decide +kernel) pattern033_checked

theorem Child17_pair5 : FourLocalBounds (FastRuleChecker.removePair Child17 5) (caps011 5) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child17 5) pattern004 (by decide +kernel) pattern004_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child17 5) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child17 5) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child17 5) pattern033 (by decide +kernel) pattern033_checked

theorem Child17_pair7 : FourLocalBounds (FastRuleChecker.removePair Child17 7) (caps011 7) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child17 7) pattern005 (by decide +kernel) pattern005_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child17 7) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child17 7) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child17 7) pattern033 (by decide +kernel) pattern033_checked

theorem Child17_pair17 : FourLocalBounds (FastRuleChecker.removePair Child17 17) (caps011 17) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 3 (FastRuleChecker.removePair Child17 17) pattern014 (by decide +kernel) pattern014_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child17 17) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child17 17) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child17 17) pattern033 (by decide +kernel) pattern033_checked

theorem Child17_bounds : StandardBounds Child17 caps011 where
  pair := by
    intro p hp
    have hm := mem_allTiles p
    simp only [allTiles, List.mem_cons, List.not_mem_nil, or_false] at hm
    rcases hm with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
    · have hf : FastRuleChecker.pairAvailableB Child17 0 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child17 1 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child17 2 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child17 3 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child17_pair4
    · exact Child17_pair5
    · have hf : FastRuleChecker.pairAvailableB Child17 6 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child17_pair7
    · have hf : FastRuleChecker.pairAvailableB Child17 8 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child17 9 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child17 10 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child17 11 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child17 12 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child17 13 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child17 14 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child17 15 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child17 16 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child17_pair17
    · have hf : FastRuleChecker.pairAvailableB Child17 18 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child17 19 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child17 20 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child17 21 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child17 22 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child17 23 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child17 24 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child17 25 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child17 26 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child17 27 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child17 28 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child17 29 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child17 30 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child17 31 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child17 32 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child17 33 = false := by decide +kernel
      rw [hf] at hp
      contradiction

theorem Child17_notWin : ¬ Win Child17 :=
  no_win_of_bounds Child17_bounds (by decide +kernel) (by decide +kernel)

def Child18 : State := addTile New34_1 18

theorem Child18_pair4 : FourLocalBounds (FastRuleChecker.removePair Child18 4) (caps012 4) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child18 4) pattern003 (by decide +kernel) pattern003_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child18 4) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child18 4) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child18 4) pattern033 (by decide +kernel) pattern033_checked

theorem Child18_pair5 : FourLocalBounds (FastRuleChecker.removePair Child18 5) (caps012 5) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child18 5) pattern004 (by decide +kernel) pattern004_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child18 5) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child18 5) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child18 5) pattern033 (by decide +kernel) pattern033_checked

theorem Child18_pair7 : FourLocalBounds (FastRuleChecker.removePair Child18 7) (caps012 7) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child18 7) pattern005 (by decide +kernel) pattern005_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child18 7) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child18 7) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child18 7) pattern033 (by decide +kernel) pattern033_checked

theorem Child18_pair18 : FourLocalBounds (FastRuleChecker.removePair Child18 18) (caps012 18) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 3 (FastRuleChecker.removePair Child18 18) pattern014 (by decide +kernel) pattern014_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child18 18) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child18 18) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child18 18) pattern033 (by decide +kernel) pattern033_checked

theorem Child18_bounds : StandardBounds Child18 caps012 where
  pair := by
    intro p hp
    have hm := mem_allTiles p
    simp only [allTiles, List.mem_cons, List.not_mem_nil, or_false] at hm
    rcases hm with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
    · have hf : FastRuleChecker.pairAvailableB Child18 0 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child18 1 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child18 2 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child18 3 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child18_pair4
    · exact Child18_pair5
    · have hf : FastRuleChecker.pairAvailableB Child18 6 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child18_pair7
    · have hf : FastRuleChecker.pairAvailableB Child18 8 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child18 9 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child18 10 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child18 11 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child18 12 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child18 13 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child18 14 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child18 15 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child18 16 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child18 17 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child18_pair18
    · have hf : FastRuleChecker.pairAvailableB Child18 19 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child18 20 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child18 21 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child18 22 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child18 23 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child18 24 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child18 25 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child18 26 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child18 27 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child18 28 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child18 29 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child18 30 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child18 31 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child18 32 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child18 33 = false := by decide +kernel
      rw [hf] at hp
      contradiction

theorem Child18_notWin : ¬ Win Child18 :=
  no_win_of_bounds Child18_bounds (by decide +kernel) (by decide +kernel)

def Child19 : State := addTile New34_1 19

theorem Child19_pair4 : FourLocalBounds (FastRuleChecker.removePair Child19 4) (caps013 4) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child19 4) pattern003 (by decide +kernel) pattern003_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child19 4) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 1 (FastRuleChecker.removePair Child19 4) pattern032 (by decide +kernel) pattern032_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child19 4) pattern033 (by decide +kernel) pattern033_checked

theorem Child19_pair5 : FourLocalBounds (FastRuleChecker.removePair Child19 5) (caps013 5) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child19 5) pattern004 (by decide +kernel) pattern004_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child19 5) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 1 (FastRuleChecker.removePair Child19 5) pattern032 (by decide +kernel) pattern032_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child19 5) pattern033 (by decide +kernel) pattern033_checked

theorem Child19_pair7 : FourLocalBounds (FastRuleChecker.removePair Child19 7) (caps013 7) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child19 7) pattern005 (by decide +kernel) pattern005_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child19 7) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 1 (FastRuleChecker.removePair Child19 7) pattern032 (by decide +kernel) pattern032_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child19 7) pattern033 (by decide +kernel) pattern033_checked

theorem Child19_bounds : StandardBounds Child19 caps013 where
  pair := by
    intro p hp
    have hm := mem_allTiles p
    simp only [allTiles, List.mem_cons, List.not_mem_nil, or_false] at hm
    rcases hm with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
    · have hf : FastRuleChecker.pairAvailableB Child19 0 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child19 1 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child19 2 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child19 3 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child19_pair4
    · exact Child19_pair5
    · have hf : FastRuleChecker.pairAvailableB Child19 6 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child19_pair7
    · have hf : FastRuleChecker.pairAvailableB Child19 8 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child19 9 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child19 10 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child19 11 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child19 12 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child19 13 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child19 14 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child19 15 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child19 16 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child19 17 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child19 18 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child19 19 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child19 20 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child19 21 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child19 22 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child19 23 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child19 24 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child19 25 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child19 26 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child19 27 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child19 28 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child19 29 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child19 30 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child19 31 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child19 32 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child19 33 = false := by decide +kernel
      rw [hf] at hp
      contradiction

theorem Child19_notWin : ¬ Win Child19 :=
  no_win_of_bounds Child19_bounds (by decide +kernel) (by decide +kernel)

def Child20 : State := addTile New34_1 20

theorem Child20_pair4 : FourLocalBounds (FastRuleChecker.removePair Child20 4) (caps014 4) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child20 4) pattern003 (by decide +kernel) pattern003_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child20 4) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child20 4) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child20 4) pattern033 (by decide +kernel) pattern033_checked

theorem Child20_pair5 : FourLocalBounds (FastRuleChecker.removePair Child20 5) (caps014 5) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child20 5) pattern004 (by decide +kernel) pattern004_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child20 5) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child20 5) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child20 5) pattern033 (by decide +kernel) pattern033_checked

theorem Child20_pair7 : FourLocalBounds (FastRuleChecker.removePair Child20 7) (caps014 7) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child20 7) pattern005 (by decide +kernel) pattern005_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child20 7) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child20 7) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child20 7) pattern033 (by decide +kernel) pattern033_checked

theorem Child20_pair20 : FourLocalBounds (FastRuleChecker.removePair Child20 20) (caps014 20) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 3 (FastRuleChecker.removePair Child20 20) pattern014 (by decide +kernel) pattern014_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child20 20) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child20 20) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child20 20) pattern033 (by decide +kernel) pattern033_checked

theorem Child20_bounds : StandardBounds Child20 caps014 where
  pair := by
    intro p hp
    have hm := mem_allTiles p
    simp only [allTiles, List.mem_cons, List.not_mem_nil, or_false] at hm
    rcases hm with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
    · have hf : FastRuleChecker.pairAvailableB Child20 0 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child20 1 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child20 2 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child20 3 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child20_pair4
    · exact Child20_pair5
    · have hf : FastRuleChecker.pairAvailableB Child20 6 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child20_pair7
    · have hf : FastRuleChecker.pairAvailableB Child20 8 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child20 9 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child20 10 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child20 11 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child20 12 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child20 13 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child20 14 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child20 15 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child20 16 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child20 17 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child20 18 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child20 19 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child20_pair20
    · have hf : FastRuleChecker.pairAvailableB Child20 21 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child20 22 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child20 23 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child20 24 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child20 25 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child20 26 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child20 27 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child20 28 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child20 29 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child20 30 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child20 31 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child20 32 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child20 33 = false := by decide +kernel
      rw [hf] at hp
      contradiction

theorem Child20_notWin : ¬ Win Child20 :=
  no_win_of_bounds Child20_bounds (by decide +kernel) (by decide +kernel)

def Child21 : State := addTile New34_1 21

theorem Child21_pair4 : FourLocalBounds (FastRuleChecker.removePair Child21 4) (caps013 4) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child21 4) pattern003 (by decide +kernel) pattern003_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child21 4) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 1 (FastRuleChecker.removePair Child21 4) pattern031 (by decide +kernel) pattern031_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child21 4) pattern033 (by decide +kernel) pattern033_checked

theorem Child21_pair5 : FourLocalBounds (FastRuleChecker.removePair Child21 5) (caps013 5) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child21 5) pattern004 (by decide +kernel) pattern004_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child21 5) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 1 (FastRuleChecker.removePair Child21 5) pattern031 (by decide +kernel) pattern031_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child21 5) pattern033 (by decide +kernel) pattern033_checked

theorem Child21_pair7 : FourLocalBounds (FastRuleChecker.removePair Child21 7) (caps013 7) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child21 7) pattern005 (by decide +kernel) pattern005_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child21 7) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 1 (FastRuleChecker.removePair Child21 7) pattern031 (by decide +kernel) pattern031_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child21 7) pattern033 (by decide +kernel) pattern033_checked

theorem Child21_bounds : StandardBounds Child21 caps013 where
  pair := by
    intro p hp
    have hm := mem_allTiles p
    simp only [allTiles, List.mem_cons, List.not_mem_nil, or_false] at hm
    rcases hm with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
    · have hf : FastRuleChecker.pairAvailableB Child21 0 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child21 1 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child21 2 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child21 3 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child21_pair4
    · exact Child21_pair5
    · have hf : FastRuleChecker.pairAvailableB Child21 6 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child21_pair7
    · have hf : FastRuleChecker.pairAvailableB Child21 8 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child21 9 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child21 10 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child21 11 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child21 12 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child21 13 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child21 14 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child21 15 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child21 16 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child21 17 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child21 18 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child21 19 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child21 20 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child21 21 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child21 22 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child21 23 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child21 24 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child21 25 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child21 26 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child21 27 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child21 28 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child21 29 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child21 30 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child21 31 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child21 32 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child21 33 = false := by decide +kernel
      rw [hf] at hp
      contradiction

theorem Child21_notWin : ¬ Win Child21 :=
  no_win_of_bounds Child21_bounds (by decide +kernel) (by decide +kernel)

def Child22 : State := addTile New34_1 22

theorem Child22_pair4 : FourLocalBounds (FastRuleChecker.removePair Child22 4) (caps015 4) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child22 4) pattern003 (by decide +kernel) pattern003_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child22 4) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child22 4) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child22 4) pattern033 (by decide +kernel) pattern033_checked

theorem Child22_pair5 : FourLocalBounds (FastRuleChecker.removePair Child22 5) (caps015 5) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child22 5) pattern004 (by decide +kernel) pattern004_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child22 5) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child22 5) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child22 5) pattern033 (by decide +kernel) pattern033_checked

theorem Child22_pair7 : FourLocalBounds (FastRuleChecker.removePair Child22 7) (caps015 7) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child22 7) pattern005 (by decide +kernel) pattern005_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child22 7) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child22 7) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child22 7) pattern033 (by decide +kernel) pattern033_checked

theorem Child22_pair22 : FourLocalBounds (FastRuleChecker.removePair Child22 22) (caps015 22) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 3 (FastRuleChecker.removePair Child22 22) pattern014 (by decide +kernel) pattern014_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child22 22) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child22 22) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child22 22) pattern033 (by decide +kernel) pattern033_checked

theorem Child22_bounds : StandardBounds Child22 caps015 where
  pair := by
    intro p hp
    have hm := mem_allTiles p
    simp only [allTiles, List.mem_cons, List.not_mem_nil, or_false] at hm
    rcases hm with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
    · have hf : FastRuleChecker.pairAvailableB Child22 0 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child22 1 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child22 2 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child22 3 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child22_pair4
    · exact Child22_pair5
    · have hf : FastRuleChecker.pairAvailableB Child22 6 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child22_pair7
    · have hf : FastRuleChecker.pairAvailableB Child22 8 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child22 9 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child22 10 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child22 11 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child22 12 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child22 13 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child22 14 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child22 15 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child22 16 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child22 17 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child22 18 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child22 19 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child22 20 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child22 21 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child22_pair22
    · have hf : FastRuleChecker.pairAvailableB Child22 23 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child22 24 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child22 25 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child22 26 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child22 27 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child22 28 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child22 29 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child22 30 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child22 31 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child22 32 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child22 33 = false := by decide +kernel
      rw [hf] at hp
      contradiction

theorem Child22_notWin : ¬ Win Child22 :=
  no_win_of_bounds Child22_bounds (by decide +kernel) (by decide +kernel)

def Child23 : State := addTile New34_1 23

theorem Child23_pair4 : FourLocalBounds (FastRuleChecker.removePair Child23 4) (caps016 4) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child23 4) pattern003 (by decide +kernel) pattern003_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child23 4) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child23 4) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child23 4) pattern033 (by decide +kernel) pattern033_checked

theorem Child23_pair5 : FourLocalBounds (FastRuleChecker.removePair Child23 5) (caps016 5) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child23 5) pattern004 (by decide +kernel) pattern004_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child23 5) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child23 5) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child23 5) pattern033 (by decide +kernel) pattern033_checked

theorem Child23_pair7 : FourLocalBounds (FastRuleChecker.removePair Child23 7) (caps016 7) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child23 7) pattern005 (by decide +kernel) pattern005_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child23 7) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child23 7) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child23 7) pattern033 (by decide +kernel) pattern033_checked

theorem Child23_pair23 : FourLocalBounds (FastRuleChecker.removePair Child23 23) (caps016 23) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 3 (FastRuleChecker.removePair Child23 23) pattern014 (by decide +kernel) pattern014_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child23 23) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child23 23) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child23 23) pattern033 (by decide +kernel) pattern033_checked

theorem Child23_bounds : StandardBounds Child23 caps016 where
  pair := by
    intro p hp
    have hm := mem_allTiles p
    simp only [allTiles, List.mem_cons, List.not_mem_nil, or_false] at hm
    rcases hm with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
    · have hf : FastRuleChecker.pairAvailableB Child23 0 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child23 1 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child23 2 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child23 3 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child23_pair4
    · exact Child23_pair5
    · have hf : FastRuleChecker.pairAvailableB Child23 6 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child23_pair7
    · have hf : FastRuleChecker.pairAvailableB Child23 8 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child23 9 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child23 10 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child23 11 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child23 12 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child23 13 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child23 14 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child23 15 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child23 16 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child23 17 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child23 18 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child23 19 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child23 20 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child23 21 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child23 22 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child23_pair23
    · have hf : FastRuleChecker.pairAvailableB Child23 24 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child23 25 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child23 26 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child23 27 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child23 28 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child23 29 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child23 30 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child23 31 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child23 32 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child23 33 = false := by decide +kernel
      rw [hf] at hp
      contradiction

theorem Child23_notWin : ¬ Win Child23 :=
  no_win_of_bounds Child23_bounds (by decide +kernel) (by decide +kernel)

def Child24 : State := addTile New34_1 24

theorem Child24_pair4 : FourLocalBounds (FastRuleChecker.removePair Child24 4) (caps013 4) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child24 4) pattern003 (by decide +kernel) pattern003_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child24 4) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 1 (FastRuleChecker.removePair Child24 4) pattern030 (by decide +kernel) pattern030_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child24 4) pattern033 (by decide +kernel) pattern033_checked

theorem Child24_pair5 : FourLocalBounds (FastRuleChecker.removePair Child24 5) (caps013 5) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child24 5) pattern004 (by decide +kernel) pattern004_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child24 5) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 1 (FastRuleChecker.removePair Child24 5) pattern030 (by decide +kernel) pattern030_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child24 5) pattern033 (by decide +kernel) pattern033_checked

theorem Child24_pair7 : FourLocalBounds (FastRuleChecker.removePair Child24 7) (caps013 7) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child24 7) pattern005 (by decide +kernel) pattern005_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child24 7) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 1 (FastRuleChecker.removePair Child24 7) pattern030 (by decide +kernel) pattern030_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child24 7) pattern033 (by decide +kernel) pattern033_checked

theorem Child24_bounds : StandardBounds Child24 caps013 where
  pair := by
    intro p hp
    have hm := mem_allTiles p
    simp only [allTiles, List.mem_cons, List.not_mem_nil, or_false] at hm
    rcases hm with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
    · have hf : FastRuleChecker.pairAvailableB Child24 0 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child24 1 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child24 2 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child24 3 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child24_pair4
    · exact Child24_pair5
    · have hf : FastRuleChecker.pairAvailableB Child24 6 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child24_pair7
    · have hf : FastRuleChecker.pairAvailableB Child24 8 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child24 9 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child24 10 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child24 11 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child24 12 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child24 13 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child24 14 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child24 15 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child24 16 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child24 17 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child24 18 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child24 19 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child24 20 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child24 21 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child24 22 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child24 23 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child24 24 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child24 25 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child24 26 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child24 27 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child24 28 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child24 29 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child24 30 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child24 31 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child24 32 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child24 33 = false := by decide +kernel
      rw [hf] at hp
      contradiction

theorem Child24_notWin : ¬ Win Child24 :=
  no_win_of_bounds Child24_bounds (by decide +kernel) (by decide +kernel)

def Child25 : State := addTile New34_1 25

theorem Child25_pair4 : FourLocalBounds (FastRuleChecker.removePair Child25 4) (caps017 4) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child25 4) pattern003 (by decide +kernel) pattern003_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child25 4) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child25 4) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child25 4) pattern033 (by decide +kernel) pattern033_checked

theorem Child25_pair5 : FourLocalBounds (FastRuleChecker.removePair Child25 5) (caps017 5) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child25 5) pattern004 (by decide +kernel) pattern004_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child25 5) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child25 5) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child25 5) pattern033 (by decide +kernel) pattern033_checked

theorem Child25_pair7 : FourLocalBounds (FastRuleChecker.removePair Child25 7) (caps017 7) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child25 7) pattern005 (by decide +kernel) pattern005_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child25 7) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child25 7) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child25 7) pattern033 (by decide +kernel) pattern033_checked

theorem Child25_pair25 : FourLocalBounds (FastRuleChecker.removePair Child25 25) (caps017 25) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 3 (FastRuleChecker.removePair Child25 25) pattern014 (by decide +kernel) pattern014_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child25 25) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child25 25) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child25 25) pattern033 (by decide +kernel) pattern033_checked

theorem Child25_bounds : StandardBounds Child25 caps017 where
  pair := by
    intro p hp
    have hm := mem_allTiles p
    simp only [allTiles, List.mem_cons, List.not_mem_nil, or_false] at hm
    rcases hm with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
    · have hf : FastRuleChecker.pairAvailableB Child25 0 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child25 1 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child25 2 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child25 3 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child25_pair4
    · exact Child25_pair5
    · have hf : FastRuleChecker.pairAvailableB Child25 6 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child25_pair7
    · have hf : FastRuleChecker.pairAvailableB Child25 8 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child25 9 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child25 10 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child25 11 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child25 12 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child25 13 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child25 14 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child25 15 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child25 16 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child25 17 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child25 18 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child25 19 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child25 20 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child25 21 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child25 22 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child25 23 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child25 24 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child25_pair25
    · have hf : FastRuleChecker.pairAvailableB Child25 26 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child25 27 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child25 28 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child25 29 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child25 30 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child25 31 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child25 32 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child25 33 = false := by decide +kernel
      rw [hf] at hp
      contradiction

theorem Child25_notWin : ¬ Win Child25 :=
  no_win_of_bounds Child25_bounds (by decide +kernel) (by decide +kernel)

def Child26 : State := addTile New34_1 26

theorem Child26_pair4 : FourLocalBounds (FastRuleChecker.removePair Child26 4) (caps018 4) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child26 4) pattern003 (by decide +kernel) pattern003_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child26 4) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child26 4) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child26 4) pattern033 (by decide +kernel) pattern033_checked

theorem Child26_pair5 : FourLocalBounds (FastRuleChecker.removePair Child26 5) (caps018 5) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child26 5) pattern004 (by decide +kernel) pattern004_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child26 5) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child26 5) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child26 5) pattern033 (by decide +kernel) pattern033_checked

theorem Child26_pair7 : FourLocalBounds (FastRuleChecker.removePair Child26 7) (caps018 7) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child26 7) pattern005 (by decide +kernel) pattern005_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child26 7) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child26 7) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child26 7) pattern033 (by decide +kernel) pattern033_checked

theorem Child26_pair26 : FourLocalBounds (FastRuleChecker.removePair Child26 26) (caps018 26) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 3 (FastRuleChecker.removePair Child26 26) pattern014 (by decide +kernel) pattern014_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child26 26) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child26 26) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child26 26) pattern033 (by decide +kernel) pattern033_checked

theorem Child26_bounds : StandardBounds Child26 caps018 where
  pair := by
    intro p hp
    have hm := mem_allTiles p
    simp only [allTiles, List.mem_cons, List.not_mem_nil, or_false] at hm
    rcases hm with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
    · have hf : FastRuleChecker.pairAvailableB Child26 0 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child26 1 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child26 2 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child26 3 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child26_pair4
    · exact Child26_pair5
    · have hf : FastRuleChecker.pairAvailableB Child26 6 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child26_pair7
    · have hf : FastRuleChecker.pairAvailableB Child26 8 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child26 9 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child26 10 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child26 11 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child26 12 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child26 13 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child26 14 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child26 15 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child26 16 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child26 17 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child26 18 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child26 19 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child26 20 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child26 21 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child26 22 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child26 23 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child26 24 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child26 25 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child26_pair26
    · have hf : FastRuleChecker.pairAvailableB Child26 27 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child26 28 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child26 29 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child26 30 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child26 31 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child26 32 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child26 33 = false := by decide +kernel
      rw [hf] at hp
      contradiction

theorem Child26_notWin : ¬ Win Child26 :=
  no_win_of_bounds Child26_bounds (by decide +kernel) (by decide +kernel)

def Child27 : State := addTile New34_1 27

theorem Child27_pair4 : FourLocalBounds (FastRuleChecker.removePair Child27 4) (caps019 4) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child27 4) pattern003 (by decide +kernel) pattern003_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child27 4) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child27 4) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child27 4) pattern033 (by decide +kernel) pattern033_checked

theorem Child27_pair5 : FourLocalBounds (FastRuleChecker.removePair Child27 5) (caps019 5) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child27 5) pattern004 (by decide +kernel) pattern004_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child27 5) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child27 5) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child27 5) pattern033 (by decide +kernel) pattern033_checked

theorem Child27_pair7 : FourLocalBounds (FastRuleChecker.removePair Child27 7) (caps019 7) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child27 7) pattern005 (by decide +kernel) pattern005_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child27 7) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child27 7) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child27 7) pattern033 (by decide +kernel) pattern033_checked

theorem Child27_pair27 : FourLocalBounds (FastRuleChecker.removePair Child27 27) (caps019 27) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 3 (FastRuleChecker.removePair Child27 27) pattern014 (by decide +kernel) pattern014_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child27 27) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child27 27) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child27 27) pattern033 (by decide +kernel) pattern033_checked

theorem Child27_bounds : StandardBounds Child27 caps019 where
  pair := by
    intro p hp
    have hm := mem_allTiles p
    simp only [allTiles, List.mem_cons, List.not_mem_nil, or_false] at hm
    rcases hm with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
    · have hf : FastRuleChecker.pairAvailableB Child27 0 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child27 1 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child27 2 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child27 3 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child27_pair4
    · exact Child27_pair5
    · have hf : FastRuleChecker.pairAvailableB Child27 6 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child27_pair7
    · have hf : FastRuleChecker.pairAvailableB Child27 8 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child27 9 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child27 10 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child27 11 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child27 12 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child27 13 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child27 14 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child27 15 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child27 16 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child27 17 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child27 18 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child27 19 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child27 20 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child27 21 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child27 22 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child27 23 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child27 24 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child27 25 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child27 26 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child27_pair27
    · have hf : FastRuleChecker.pairAvailableB Child27 28 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child27 29 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child27 30 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child27 31 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child27 32 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child27 33 = false := by decide +kernel
      rw [hf] at hp
      contradiction

theorem Child27_notWin : ¬ Win Child27 :=
  no_win_of_bounds Child27_bounds (by decide +kernel) (by decide +kernel)

def Child28 : State := addTile New34_1 28

theorem Child28_pair4 : FourLocalBounds (FastRuleChecker.removePair Child28 4) (caps020 4) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child28 4) pattern003 (by decide +kernel) pattern003_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child28 4) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child28 4) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child28 4) pattern033 (by decide +kernel) pattern033_checked

theorem Child28_pair5 : FourLocalBounds (FastRuleChecker.removePair Child28 5) (caps020 5) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child28 5) pattern004 (by decide +kernel) pattern004_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child28 5) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child28 5) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child28 5) pattern033 (by decide +kernel) pattern033_checked

theorem Child28_pair7 : FourLocalBounds (FastRuleChecker.removePair Child28 7) (caps020 7) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child28 7) pattern005 (by decide +kernel) pattern005_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child28 7) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child28 7) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child28 7) pattern033 (by decide +kernel) pattern033_checked

theorem Child28_pair28 : FourLocalBounds (FastRuleChecker.removePair Child28 28) (caps020 28) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 3 (FastRuleChecker.removePair Child28 28) pattern014 (by decide +kernel) pattern014_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child28 28) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child28 28) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child28 28) pattern033 (by decide +kernel) pattern033_checked

theorem Child28_bounds : StandardBounds Child28 caps020 where
  pair := by
    intro p hp
    have hm := mem_allTiles p
    simp only [allTiles, List.mem_cons, List.not_mem_nil, or_false] at hm
    rcases hm with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
    · have hf : FastRuleChecker.pairAvailableB Child28 0 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child28 1 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child28 2 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child28 3 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child28_pair4
    · exact Child28_pair5
    · have hf : FastRuleChecker.pairAvailableB Child28 6 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child28_pair7
    · have hf : FastRuleChecker.pairAvailableB Child28 8 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child28 9 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child28 10 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child28 11 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child28 12 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child28 13 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child28 14 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child28 15 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child28 16 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child28 17 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child28 18 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child28 19 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child28 20 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child28 21 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child28 22 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child28 23 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child28 24 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child28 25 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child28 26 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child28 27 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child28_pair28
    · have hf : FastRuleChecker.pairAvailableB Child28 29 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child28 30 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child28 31 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child28 32 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child28 33 = false := by decide +kernel
      rw [hf] at hp
      contradiction

theorem Child28_notWin : ¬ Win Child28 :=
  no_win_of_bounds Child28_bounds (by decide +kernel) (by decide +kernel)

def Child29 : State := addTile New34_1 29

theorem Child29_pair4 : FourLocalBounds (FastRuleChecker.removePair Child29 4) (caps021 4) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child29 4) pattern003 (by decide +kernel) pattern003_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child29 4) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child29 4) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child29 4) pattern033 (by decide +kernel) pattern033_checked

theorem Child29_pair5 : FourLocalBounds (FastRuleChecker.removePair Child29 5) (caps021 5) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child29 5) pattern004 (by decide +kernel) pattern004_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child29 5) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child29 5) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child29 5) pattern033 (by decide +kernel) pattern033_checked

theorem Child29_pair7 : FourLocalBounds (FastRuleChecker.removePair Child29 7) (caps021 7) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child29 7) pattern005 (by decide +kernel) pattern005_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child29 7) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child29 7) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child29 7) pattern033 (by decide +kernel) pattern033_checked

theorem Child29_pair29 : FourLocalBounds (FastRuleChecker.removePair Child29 29) (caps021 29) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 3 (FastRuleChecker.removePair Child29 29) pattern014 (by decide +kernel) pattern014_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child29 29) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child29 29) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child29 29) pattern033 (by decide +kernel) pattern033_checked

theorem Child29_bounds : StandardBounds Child29 caps021 where
  pair := by
    intro p hp
    have hm := mem_allTiles p
    simp only [allTiles, List.mem_cons, List.not_mem_nil, or_false] at hm
    rcases hm with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
    · have hf : FastRuleChecker.pairAvailableB Child29 0 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child29 1 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child29 2 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child29 3 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child29_pair4
    · exact Child29_pair5
    · have hf : FastRuleChecker.pairAvailableB Child29 6 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child29_pair7
    · have hf : FastRuleChecker.pairAvailableB Child29 8 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child29 9 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child29 10 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child29 11 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child29 12 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child29 13 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child29 14 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child29 15 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child29 16 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child29 17 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child29 18 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child29 19 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child29 20 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child29 21 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child29 22 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child29 23 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child29 24 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child29 25 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child29 26 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child29 27 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child29 28 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child29_pair29
    · have hf : FastRuleChecker.pairAvailableB Child29 30 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child29 31 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child29 32 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child29 33 = false := by decide +kernel
      rw [hf] at hp
      contradiction

theorem Child29_notWin : ¬ Win Child29 :=
  no_win_of_bounds Child29_bounds (by decide +kernel) (by decide +kernel)

def Child30 : State := addTile New34_1 30

theorem Child30_pair4 : FourLocalBounds (FastRuleChecker.removePair Child30 4) (caps022 4) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child30 4) pattern003 (by decide +kernel) pattern003_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child30 4) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child30 4) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child30 4) pattern033 (by decide +kernel) pattern033_checked

theorem Child30_pair5 : FourLocalBounds (FastRuleChecker.removePair Child30 5) (caps022 5) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child30 5) pattern004 (by decide +kernel) pattern004_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child30 5) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child30 5) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child30 5) pattern033 (by decide +kernel) pattern033_checked

theorem Child30_pair7 : FourLocalBounds (FastRuleChecker.removePair Child30 7) (caps022 7) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child30 7) pattern005 (by decide +kernel) pattern005_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child30 7) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child30 7) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child30 7) pattern033 (by decide +kernel) pattern033_checked

theorem Child30_pair30 : FourLocalBounds (FastRuleChecker.removePair Child30 30) (caps022 30) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 3 (FastRuleChecker.removePair Child30 30) pattern014 (by decide +kernel) pattern014_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child30 30) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child30 30) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child30 30) pattern033 (by decide +kernel) pattern033_checked

theorem Child30_bounds : StandardBounds Child30 caps022 where
  pair := by
    intro p hp
    have hm := mem_allTiles p
    simp only [allTiles, List.mem_cons, List.not_mem_nil, or_false] at hm
    rcases hm with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
    · have hf : FastRuleChecker.pairAvailableB Child30 0 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child30 1 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child30 2 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child30 3 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child30_pair4
    · exact Child30_pair5
    · have hf : FastRuleChecker.pairAvailableB Child30 6 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child30_pair7
    · have hf : FastRuleChecker.pairAvailableB Child30 8 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child30 9 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child30 10 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child30 11 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child30 12 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child30 13 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child30 14 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child30 15 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child30 16 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child30 17 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child30 18 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child30 19 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child30 20 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child30 21 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child30 22 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child30 23 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child30 24 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child30 25 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child30 26 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child30 27 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child30 28 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child30 29 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child30_pair30
    · have hf : FastRuleChecker.pairAvailableB Child30 31 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child30 32 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child30 33 = false := by decide +kernel
      rw [hf] at hp
      contradiction

theorem Child30_notWin : ¬ Win Child30 :=
  no_win_of_bounds Child30_bounds (by decide +kernel) (by decide +kernel)

def Child31 : State := addTile New34_1 31

theorem Child31_pair4 : FourLocalBounds (FastRuleChecker.removePair Child31 4) (caps023 4) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child31 4) pattern003 (by decide +kernel) pattern003_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child31 4) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child31 4) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child31 4) pattern033 (by decide +kernel) pattern033_checked

theorem Child31_pair5 : FourLocalBounds (FastRuleChecker.removePair Child31 5) (caps023 5) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child31 5) pattern004 (by decide +kernel) pattern004_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child31 5) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child31 5) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child31 5) pattern033 (by decide +kernel) pattern033_checked

theorem Child31_pair7 : FourLocalBounds (FastRuleChecker.removePair Child31 7) (caps023 7) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child31 7) pattern005 (by decide +kernel) pattern005_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child31 7) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child31 7) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child31 7) pattern033 (by decide +kernel) pattern033_checked

theorem Child31_pair31 : FourLocalBounds (FastRuleChecker.removePair Child31 31) (caps023 31) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 3 (FastRuleChecker.removePair Child31 31) pattern014 (by decide +kernel) pattern014_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child31 31) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child31 31) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child31 31) pattern033 (by decide +kernel) pattern033_checked

theorem Child31_bounds : StandardBounds Child31 caps023 where
  pair := by
    intro p hp
    have hm := mem_allTiles p
    simp only [allTiles, List.mem_cons, List.not_mem_nil, or_false] at hm
    rcases hm with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
    · have hf : FastRuleChecker.pairAvailableB Child31 0 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child31 1 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child31 2 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child31 3 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child31_pair4
    · exact Child31_pair5
    · have hf : FastRuleChecker.pairAvailableB Child31 6 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child31_pair7
    · have hf : FastRuleChecker.pairAvailableB Child31 8 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child31 9 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child31 10 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child31 11 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child31 12 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child31 13 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child31 14 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child31 15 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child31 16 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child31 17 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child31 18 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child31 19 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child31 20 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child31 21 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child31 22 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child31 23 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child31 24 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child31 25 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child31 26 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child31 27 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child31 28 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child31 29 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child31 30 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child31_pair31
    · have hf : FastRuleChecker.pairAvailableB Child31 32 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child31 33 = false := by decide +kernel
      rw [hf] at hp
      contradiction

theorem Child31_notWin : ¬ Win Child31 :=
  no_win_of_bounds Child31_bounds (by decide +kernel) (by decide +kernel)

def Child32 : State := addTile New34_1 32

theorem Child32_pair4 : FourLocalBounds (FastRuleChecker.removePair Child32 4) (caps024 4) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child32 4) pattern003 (by decide +kernel) pattern003_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child32 4) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child32 4) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child32 4) pattern033 (by decide +kernel) pattern033_checked

theorem Child32_pair5 : FourLocalBounds (FastRuleChecker.removePair Child32 5) (caps024 5) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child32 5) pattern004 (by decide +kernel) pattern004_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child32 5) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child32 5) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child32 5) pattern033 (by decide +kernel) pattern033_checked

theorem Child32_pair7 : FourLocalBounds (FastRuleChecker.removePair Child32 7) (caps024 7) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child32 7) pattern005 (by decide +kernel) pattern005_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child32 7) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child32 7) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child32 7) pattern033 (by decide +kernel) pattern033_checked

theorem Child32_pair32 : FourLocalBounds (FastRuleChecker.removePair Child32 32) (caps024 32) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 3 (FastRuleChecker.removePair Child32 32) pattern014 (by decide +kernel) pattern014_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child32 32) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child32 32) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child32 32) pattern033 (by decide +kernel) pattern033_checked

theorem Child32_bounds : StandardBounds Child32 caps024 where
  pair := by
    intro p hp
    have hm := mem_allTiles p
    simp only [allTiles, List.mem_cons, List.not_mem_nil, or_false] at hm
    rcases hm with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
    · have hf : FastRuleChecker.pairAvailableB Child32 0 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child32 1 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child32 2 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child32 3 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child32_pair4
    · exact Child32_pair5
    · have hf : FastRuleChecker.pairAvailableB Child32 6 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child32_pair7
    · have hf : FastRuleChecker.pairAvailableB Child32 8 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child32 9 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child32 10 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child32 11 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child32 12 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child32 13 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child32 14 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child32 15 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child32 16 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child32 17 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child32 18 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child32 19 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child32 20 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child32 21 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child32 22 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child32 23 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child32 24 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child32 25 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child32 26 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child32 27 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child32 28 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child32 29 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child32 30 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child32 31 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child32_pair32
    · have hf : FastRuleChecker.pairAvailableB Child32 33 = false := by decide +kernel
      rw [hf] at hp
      contradiction

theorem Child32_notWin : ¬ Win Child32 :=
  no_win_of_bounds Child32_bounds (by decide +kernel) (by decide +kernel)

def Child33 : State := addTile New34_1 33

theorem Child33_pair4 : FourLocalBounds (FastRuleChecker.removePair Child33 4) (caps025 4) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child33 4) pattern003 (by decide +kernel) pattern003_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child33 4) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child33 4) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child33 4) pattern033 (by decide +kernel) pattern033_checked

theorem Child33_pair5 : FourLocalBounds (FastRuleChecker.removePair Child33 5) (caps025 5) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child33 5) pattern004 (by decide +kernel) pattern004_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child33 5) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child33 5) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child33 5) pattern033 (by decide +kernel) pattern033_checked

theorem Child33_pair7 : FourLocalBounds (FastRuleChecker.removePair Child33 7) (caps025 7) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 2 (FastRuleChecker.removePair Child33 7) pattern005 (by decide +kernel) pattern005_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child33 7) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child33 7) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child33 7) pattern033 (by decide +kernel) pattern033_checked

theorem Child33_pair33 : FourLocalBounds (FastRuleChecker.removePair Child33 33) (caps025 33) where
  total_lt_four := by decide +kernel
  suit0 := transfer_upper 0 3 (FastRuleChecker.removePair Child33 33) pattern014 (by decide +kernel) pattern014_checked
  suit1 := transfer_upper 1 0 (FastRuleChecker.removePair Child33 33) pattern022 (by decide +kernel) pattern022_checked
  suit2 := transfer_upper 2 0 (FastRuleChecker.removePair Child33 33) pattern029 (by decide +kernel) pattern029_checked
  honors := transfer_upper 3 0 (FastRuleChecker.removePair Child33 33) pattern033 (by decide +kernel) pattern033_checked

theorem Child33_bounds : StandardBounds Child33 caps025 where
  pair := by
    intro p hp
    have hm := mem_allTiles p
    simp only [allTiles, List.mem_cons, List.not_mem_nil, or_false] at hm
    rcases hm with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
    · have hf : FastRuleChecker.pairAvailableB Child33 0 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child33 1 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child33 2 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child33 3 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child33_pair4
    · exact Child33_pair5
    · have hf : FastRuleChecker.pairAvailableB Child33 6 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child33_pair7
    · have hf : FastRuleChecker.pairAvailableB Child33 8 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child33 9 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child33 10 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child33 11 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child33 12 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child33 13 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child33 14 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child33 15 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child33 16 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child33 17 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child33 18 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child33 19 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child33 20 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child33 21 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child33 22 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child33 23 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child33 24 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child33 25 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child33 26 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child33 27 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child33 28 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child33 29 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child33 30 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child33 31 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · have hf : FastRuleChecker.pairAvailableB Child33 32 = false := by decide +kernel
      rw [hf] at hp
      contradiction
    · exact Child33_pair33

theorem Child33_notWin : ¬ Win Child33 :=
  no_win_of_bounds Child33_bounds (by decide +kernel) (by decide +kernel)

end Mahjong.BoundCacheInstancesV1
#print axioms Mahjong.BoundCacheInstancesV1.Layer20_notWin
#print axioms Mahjong.BoundCacheInstancesV1.Layer22_notWin
#print axioms Mahjong.BoundCacheInstancesV1.Layer26_notWin
#print axioms Mahjong.BoundCacheInstancesV1.Layer30_notWin
#print axioms Mahjong.BoundCacheInstancesV1.Layer32_notWin
#print axioms Mahjong.BoundCacheInstancesV1.Anchor34_notWin
#print axioms Mahjong.BoundCacheInstancesV1.New34_1_notWin
#print axioms Mahjong.BoundCacheInstancesV1.New34_2_notWin
#print axioms Mahjong.BoundCacheInstancesV1.New34_3_notWin
#print axioms Mahjong.BoundCacheInstancesV1.Child00_notWin
#print axioms Mahjong.BoundCacheInstancesV1.Child01_notWin
#print axioms Mahjong.BoundCacheInstancesV1.Child02_notWin
#print axioms Mahjong.BoundCacheInstancesV1.Child03_notWin
#print axioms Mahjong.BoundCacheInstancesV1.Child06_notWin
#print axioms Mahjong.BoundCacheInstancesV1.Child08_notWin
#print axioms Mahjong.BoundCacheInstancesV1.Child09_notWin
#print axioms Mahjong.BoundCacheInstancesV1.Child10_notWin
#print axioms Mahjong.BoundCacheInstancesV1.Child11_notWin
#print axioms Mahjong.BoundCacheInstancesV1.Child12_notWin
#print axioms Mahjong.BoundCacheInstancesV1.Child13_notWin
#print axioms Mahjong.BoundCacheInstancesV1.Child14_notWin
#print axioms Mahjong.BoundCacheInstancesV1.Child15_notWin
#print axioms Mahjong.BoundCacheInstancesV1.Child16_notWin
#print axioms Mahjong.BoundCacheInstancesV1.Child17_notWin
#print axioms Mahjong.BoundCacheInstancesV1.Child18_notWin
#print axioms Mahjong.BoundCacheInstancesV1.Child19_notWin
#print axioms Mahjong.BoundCacheInstancesV1.Child20_notWin
#print axioms Mahjong.BoundCacheInstancesV1.Child21_notWin
#print axioms Mahjong.BoundCacheInstancesV1.Child22_notWin
#print axioms Mahjong.BoundCacheInstancesV1.Child23_notWin
#print axioms Mahjong.BoundCacheInstancesV1.Child24_notWin
#print axioms Mahjong.BoundCacheInstancesV1.Child25_notWin
#print axioms Mahjong.BoundCacheInstancesV1.Child26_notWin
#print axioms Mahjong.BoundCacheInstancesV1.Child27_notWin
#print axioms Mahjong.BoundCacheInstancesV1.Child28_notWin
#print axioms Mahjong.BoundCacheInstancesV1.Child29_notWin
#print axioms Mahjong.BoundCacheInstancesV1.Child30_notWin
#print axioms Mahjong.BoundCacheInstancesV1.Child31_notWin
#print axioms Mahjong.BoundCacheInstancesV1.Child32_notWin
#print axioms Mahjong.BoundCacheInstancesV1.Child33_notWin
