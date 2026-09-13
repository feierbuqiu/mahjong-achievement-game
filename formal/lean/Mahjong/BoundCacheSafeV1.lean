import Mahjong.BoundCacheInstancesV1

namespace Mahjong.BoundCacheSafeV1
open BoundBenchDataV1 BoundCacheInstancesV1

theorem original_safe : SafeGame.Safe Step Win New34_1 := by
  refine ⟨New34_1_notWin, ?_⟩
  rintro _ ⟨t, ht, rfl⟩
  have hm := mem_allTiles t
  simp only [allTiles, List.mem_cons, List.not_mem_nil, or_false] at hm
  rcases hm with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
  · exact Child00_notWin
  · exact Child01_notWin
  · exact Child02_notWin
  · exact Child03_notWin
  · have hf : ¬ New34_1 4 < 4 := by decide +kernel
    exact False.elim (hf ht.2)
  · have hf : ¬ New34_1 5 < 4 := by decide +kernel
    exact False.elim (hf ht.2)
  · exact Child06_notWin
  · have hf : ¬ New34_1 7 < 4 := by decide +kernel
    exact False.elim (hf ht.2)
  · exact Child08_notWin
  · exact Child09_notWin
  · exact Child10_notWin
  · exact Child11_notWin
  · exact Child12_notWin
  · exact Child13_notWin
  · exact Child14_notWin
  · exact Child15_notWin
  · exact Child16_notWin
  · exact Child17_notWin
  · exact Child18_notWin
  · exact Child19_notWin
  · exact Child20_notWin
  · exact Child21_notWin
  · exact Child22_notWin
  · exact Child23_notWin
  · exact Child24_notWin
  · exact Child25_notWin
  · exact Child26_notWin
  · exact Child27_notWin
  · exact Child28_notWin
  · exact Child29_notWin
  · exact Child30_notWin
  · exact Child31_notWin
  · exact Child32_notWin
  · exact Child33_notWin

end Mahjong.BoundCacheSafeV1
#print axioms Mahjong.BoundCacheSafeV1.original_safe
