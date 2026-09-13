import Mahjong.Rules
import Mahjong.Bridge

/- Concrete rule instances, checked by kernel reduction and ordinary proofs.
   These test the rule specification, not the claimed empty-position winner. -/
namespace Mahjong.RulesExamples

def mixedMelds (i : Fin 4) : Meld :=
  match i.val with
  | 0 => .sequence 0 0
  | 1 => .sequence 1 0
  | 2 => .sequence 2 0
  | _ => .triplet 27

def mixedHand : Counts := countsOf (standardTiles mixedMelds 31)

theorem mixedHand_valid : Valid mixedHand := by unfold Valid; decide
theorem mixedHand_wins : Win mixedHand := by
  exact ⟨mixedHand, ⟨mixedHand_valid, Or.inl ⟨mixedMelds, 31, rfl⟩⟩,
    contains_refl _⟩

def distinctPairs (i : Fin 7) : Tile := ⟨i.val, by omega⟩
def pairsHand : Counts := countsOf (sevenPairsTiles distinctPairs)

theorem distinctPairs_injective : ∀ i j, distinctPairs i = distinctPairs j → i = j := by
  intro i j h
  apply Fin.ext
  exact congrArg (fun t : Tile => t.val) h

theorem pairsHand_wins : Win pairsHand := by
  exact ⟨pairsHand, ⟨by unfold Valid; decide, Or.inr (Or.inl ⟨distinctPairs,
    distinctPairs_injective, rfl⟩)⟩, contains_refl _⟩

def repeatedPairKinds (i : Fin 7) : Tile := if i.val = 1 then 0 else distinctPairs i

/-- Reusing one kind twice is not an admissible seven-pair witness. -/
theorem repeatedPairKinds_rejected :
    ¬ (∀ i j, repeatedPairKinds i = repeatedPairKinds j → i = j) := by
  intro h
  have bad := h 0 1 (by decide)
  have : (0 : Fin 7) ≠ 1 := by decide
  exact this bad

def orphansHand : Counts := countsOf ((0 : Tile) :: orphans)
theorem orphansHand_wins : Win orphansHand := by
  exact ⟨orphansHand, ⟨by unfold Valid; decide, Or.inr (Or.inr ⟨0, by decide, rfl⟩)⟩,
    contains_refl _⟩

/-- The shared table may have more than 14 tiles and still contain a win. -/
theorem fifteen_tiles_win : Win (addTile mixedHand 32) := win_after_add mixedHand_wins 32
theorem fifteen_tiles_total : total (addTile mixedHand 32) = 15 := by decide
theorem fifteen_tiles_valid : Valid (addTile mixedHand 32) := by unfold Valid; decide

theorem opening_any_tile_safe (t : Tile) : IsSafe (addTile empty t) := by
  apply safe_of_total_le_12
  simp only [total_addTile, total_empty]
  decide

end Mahjong.RulesExamples

#print axioms Mahjong.RulesExamples.mixedHand_wins
#print axioms Mahjong.RulesExamples.pairsHand_wins
#print axioms Mahjong.RulesExamples.repeatedPairKinds_rejected
#print axioms Mahjong.RulesExamples.orphansHand_wins
#print axioms Mahjong.RulesExamples.fifteen_tiles_win
#print axioms Mahjong.RulesExamples.opening_any_tile_safe
