import Mahjong.ActualCandidateChildren.Child00
import Mahjong.ActualCandidateChildren.Child01
import Mahjong.ActualCandidateChildren.Child02
import Mahjong.ActualCandidateChildren.Child03
import Mahjong.ActualCandidateChildren.Child04
import Mahjong.ActualCandidateChildren.Child05
import Mahjong.ActualCandidateChildren.Child06
import Mahjong.ActualCandidateChildren.Child07
import Mahjong.ActualCandidateChildren.Child08
import Mahjong.ActualCandidateChildren.Child09
import Mahjong.ActualCandidateChildren.Child10
import Mahjong.ActualCandidateChildren.Child11
import Mahjong.ActualCandidateChildren.Child12
import Mahjong.ActualCandidateChildren.Child13
import Mahjong.ActualCandidateChildren.Child14
import Mahjong.ActualCandidateChildren.Child15
import Mahjong.ActualCandidateChildren.Child16
import Mahjong.ActualCandidateChildren.Child17
import Mahjong.ActualCandidateChildren.Child18
import Mahjong.ActualCandidateChildren.Child19
import Mahjong.ActualCandidateChildren.Child20
import Mahjong.ActualCandidateChildren.Child21
import Mahjong.ActualCandidateChildren.Child22
import Mahjong.ActualCandidateChildren.Child23
import Mahjong.ActualCandidateChildren.Child24
import Mahjong.ActualCandidateChildren.Child25
import Mahjong.ActualCandidateChildren.Child26
import Mahjong.ActualCandidateChildren.Child27
import Mahjong.ActualCandidateChildren.Child28
import Mahjong.ActualCandidateChildren.Child29
import Mahjong.ActualCandidateChildren.Child30
import Mahjong.ActualCandidateChildren.Child31
import Mahjong.ActualCandidateChildren.Child32
import Mahjong.ActualCandidateChildren.Child33

namespace Mahjong.ActualCandidateSafe
open ActualCandidateFacts ActualCandidateChildren

/-- Every kind is checked separately. Three exhausted kinds are rejected by
    winB's Valid guard; only legal additions enter the original-rule theorem. -/
theorem add_notWin_checked (t : Tile) :
    FastRuleChecker.winB (addTile candidate t) = false := by
  have ht := mem_allTiles t
  simp only [allTiles, List.mem_cons, List.not_mem_nil, or_false] at ht
  rcases ht with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
  · exact child00_checked
  · exact child01_checked
  · exact child02_checked
  · exact child03_checked
  · exact child04_checked
  · exact child05_checked
  · exact child06_checked
  · exact child07_checked
  · exact child08_checked
  · exact child09_checked
  · exact child10_checked
  · exact child11_checked
  · exact child12_checked
  · exact child13_checked
  · exact child14_checked
  · exact child15_checked
  · exact child16_checked
  · exact child17_checked
  · exact child18_checked
  · exact child19_checked
  · exact child20_checked
  · exact child21_checked
  · exact child22_checked
  · exact child23_checked
  · exact child24_checked
  · exact child25_checked
  · exact child26_checked
  · exact child27_checked
  · exact child28_checked
  · exact child29_checked
  · exact child30_checked
  · exact child31_checked
  · exact child32_checked
  · exact child33_checked

theorem safe : SafeGame.Safe Step Win candidate := by
  refine ⟨notWin, ?_⟩
  rintro _ ⟨t, ht, rfl⟩ hw
  have hh := (FastRuleChecker.winB_iff _ (valid_add ht.1 ht.2)).2 hw
  rw [add_notWin_checked] at hh
  contradiction

theorem safe_checked : FastRuleChecker.safeB candidate = true :=
  (FastRuleChecker.safeB_iff candidate valid).2 safe

theorem original_safe_checked : RuleChecker.safeB candidate = true :=
  (RuleChecker.safeB_iff candidate valid).2 safe

end Mahjong.ActualCandidateSafe
#print axioms Mahjong.ActualCandidateSafe.safe

