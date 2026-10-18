import Mahjong.GeneralIndex

set_option autoImplicit false

namespace Mahjong.GeneralOriginalSoundness
open PackedRules GeneralLayer

/-- Converts a checked general row to the original shared-table achievement game.
    The higher-layer correctness premise remains explicit. -/
theorem row_original (tables : Tables) (cache : Checked tables) (next : Target)
    (correct : TargetCorrect tables next) (source : GeneralIndex.Bucket) (i : Nat)
    (accepted : GeneralIndex.row tables next source i = true) :
    SafeGame.AchievementStrategy Step Win (state tables (BucketIndex.unrank source.data i))
      (outcome (TerminalBucket.labelP source.bits i)) := by
  have h := GeneralIndex.row_sound tables cache next correct source i accepted
  exact (original_safe_reduction h.1).mp h.2

theorem full_bucket (tables : Tables) (cache : Checked tables) (next : Target)
    (correct : TargetCorrect tables next) (source : GeneralIndex.Bucket)
    (accepted : GeneralIndex.span tables next source 0 source.data.size = true) :
    ∀ i, i < source.data.size → SafeGame.NormalStrategy SafeMove
      (state tables (BucketIndex.unrank source.data i)) (outcome (TerminalBucket.labelP source.bits i)) := by
  intro i hi
  have row := GeneralIndex.span_each tables next source source.data.size 0 accepted i hi
  exact (GeneralIndex.row_sound tables cache next correct source i (by simpa using row)).2

end Mahjong.GeneralOriginalSoundness

#print axioms Mahjong.GeneralOriginalSoundness.row_original
#print axioms Mahjong.GeneralOriginalSoundness.full_bucket
