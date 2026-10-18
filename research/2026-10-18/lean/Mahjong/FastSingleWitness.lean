import Mahjong.SingleWitness
import Mahjong.FullSafeData

set_option autoImplicit false

namespace Mahjong.FastSingleWitness
open PackedRules GeneralLayer

instance fullSafeDecidable (value : PruningAlgebra.Label) : Decidable (PruningAlgebra.fullSafe value) := by
  unfold PruningAlgebra.fullSafe PruningAlgebra.passesPartial
  infer_instance

/-- Four prechecked local labels replace the repeated 34-tile future scan. -/
def safeB (raw : FullSafeData.Tables) (s : Packed) : Bool :=
  inside (FullSafeData.summaries raw) s &&
    decide (PruningAlgebra.fullSafe (FullSafeData.allRaw raw s))

theorem safe_eq (raw : FullSafeData.Tables) (checked : FullSafeData.Checked raw) (s : Packed) :
    safeB raw s = PreloadedRules.safeB (FullSafeData.summaries raw) s := by
  let tables := FullSafeData.summaries raw
  have cache : PackedRules.Checked tables := fun b hb => (checked b hb).1
  by_cases hi : inside tables s = true
  · have fast : safeB raw s = true ↔ IsSafe (state tables s) := by
      have yes : inside (FullSafeData.summaries raw) s = true := hi
      simp only [safeB, yes, Bool.true_and, decide_eq_true_eq]
      exact FullSafeData.checked_full_filter_iff_safe raw checked s hi
    have slow : PreloadedRules.safeB tables s = true ↔ IsSafe (state tables s) := by
      rw [PreloadedRules.safeB_eq, PackedRules.safeB_eq tables cache s hi]
      exact FastRuleChecker.safeB_iff _ (state_valid tables cache s hi)
    have same := fast.trans slow.symm
    cases hf : safeB raw s <;> cases hs : PreloadedRules.safeB tables s <;> simp_all
  · cases he : inside tables s with
    | false =>
      have no : inside (FullSafeData.summaries raw) s = false := he
      simp only [safeB, PreloadedRules.safeB, no, Bool.false_and]
    | true => exact False.elim (hi he)

def childB (raw : FullSafeData.Tables) (s : Packed) (u : Tile) : Bool :=
  let tables := FullSafeData.summaries raw
  available tables s u && safeB raw (add tables s u)

def check (raw : FullSafeData.Tables) (next : Target) (s : Packed) (u : Tile) : Bool :=
  let tables := FullSafeData.summaries raw
  inside tables s && safeB raw s && childB raw s u &&
    checkRef tables next (SingleWitness.entry tables next s u) &&
    entryP next (SingleWitness.entry tables next s u)

theorem check_eq (raw : FullSafeData.Tables) (checked : FullSafeData.Checked raw)
    (next : Target) (s : Packed) (u : Tile) :
    check raw next s u = SingleWitness.check (FullSafeData.summaries raw) next s u := by
  simp only [check, childB, safe_eq raw checked, SingleWitness.check, GeneralLayer.childB]

theorem original (raw : FullSafeData.Tables) (checked : FullSafeData.Checked raw)
    (next : Target) (correct : TargetCorrect (FullSafeData.summaries raw) next)
    (s : Packed) (u : Tile) (accepted : check raw next s u = true) :
    SafeGame.AchievementStrategy Step Win (state (FullSafeData.summaries raw) s) .N := by
  rw [check_eq raw checked] at accepted
  exact SingleWitness.original _ (fun b hb => (checked b hb).1) next correct s u accepted

end Mahjong.FastSingleWitness

#print axioms Mahjong.FastSingleWitness.safe_eq
#print axioms Mahjong.FastSingleWitness.check_eq
#print axioms Mahjong.FastSingleWitness.original
