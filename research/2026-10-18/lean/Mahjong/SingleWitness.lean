import Mahjong.GeneralOriginalSoundness

set_option autoImplicit false

namespace Mahjong.SingleWitness
open PackedRules GeneralLayer

/-- A GPU/search oracle may propose a physical tile. The oracle is untrusted:
the CPU checks the actual move and the one referenced P child. -/
def entry (tables : Tables) (next : Target) (s : Packed) (u : Tile) : Packed × Reference :=
  let q := add tables s u
  (q, next.locate q)

def check (tables : Tables) (next : Target) (s : Packed) (u : Tile) : Bool :=
  inside tables s && PreloadedRules.safeB tables s && childB tables s u &&
    checkRef tables next (entry tables next s u) && entryP next (entry tables next s u)

/-- No premise about a GPU's correctness and no enumeration of all children.
Correct higher layers and the already checked local tables remain explicit. -/
theorem sound (tables : Tables) (cache : Checked tables) (next : Target)
    (correct : TargetCorrect tables next) (s : Packed) (u : Tile)
    (accepted : check tables next s u = true) :
    IsSafe (state tables s) ∧ SafeGame.NormalStrategy SafeMove (state tables s) .N := by
  simp only [check, Bool.and_eq_true] at accepted
  have valid := accepted.1.1.1.1
  have safe : IsSafe (state tables s) := by
    apply (FastRuleChecker.safeB_iff _ (state_valid tables cache s valid)).mp
    rw [← PackedRules.safeB_eq tables cache s valid, ← PreloadedRules.safeB_eq]
    exact accepted.1.1.1.2
  have edge := childB_sound tables cache s valid u accepted.1.1.2
  have child := ref_sound tables next correct (entry tables next s u) accepted.1.2
  rw [accepted.2] at child
  have winning := SafeGame.NormalStrategy.n edge child
  exact ⟨safe, winning⟩

theorem original (tables : Tables) (cache : Checked tables) (next : Target)
    (correct : TargetCorrect tables next) (s : Packed) (u : Tile)
    (accepted : check tables next s u = true) :
    SafeGame.AchievementStrategy Step Win (state tables s) .N := by
  have h := sound tables cache next correct s u accepted
  exact (original_safe_reduction h.1).mp h.2

end Mahjong.SingleWitness

#print axioms Mahjong.SingleWitness.sound
#print axioms Mahjong.SingleWitness.original
