import Mahjong.ExplicitWin

/-!
Complete positive target witnesses for the three original winning shapes.
The old ExplicitWin module is unchanged. Seven pairs must use seven different
tile kinds: four copies of one kind never count as two different pairs.
-/

namespace Mahjong.FullWinWitness

inductive Witness where
  | ordinary (witness : ExplicitWin.Witness)
  | sevenPairs (pairs : Fin 7 → Tile)

def standard (a b c d : Meld) (pair : Tile) : Witness :=
  .ordinary (.standard a b c d pair)

def orphans (pair : Tile) : Witness := .ordinary (.orphans pair)

/-- An explicit seven-kind constructor suitable for generated source. -/
def seven (a b c d e f g : Tile) : Witness :=
  .sevenPairs (fun i => match i.val with
    | 0 => a
    | 1 => b
    | 2 => c
    | 3 => d
    | 4 => e
    | 5 => f
    | _ => g)

def target : Witness → Counts
  | .ordinary w => ExplicitWin.target w
  | .sevenPairs pairs => countsOf (sevenPairsTiles pairs)

/-- All 49 finite comparisons are checked, not just pair multiplicities. -/
def shapeB : Witness → Bool
  | .ordinary w => ExplicitWin.shapeB w
  | .sevenPairs pairs => decide (∀ i j : Fin 7, pairs i = pairs j → i = j)

def check (s : State) (w : Witness) : Bool :=
  shapeB w && RuleChecker.containsB (target w) s

theorem shape_sound (w : Witness) (checked : shapeB w = true) :
    Standard (target w) ∨ SevenPairs (target w) ∨ ThirteenOrphans (target w) := by
  cases w with
  | ordinary prior => exact ExplicitWin.shape_sound prior checked
  | sevenPairs pairs =>
    exact Or.inr (Or.inl ⟨pairs, of_decide_eq_true checked, rfl⟩)

theorem sound (s : State) (w : Witness) (valid : Valid s)
    (checked : check s w = true) : Win s := by
  have facts : shapeB w = true ∧ RuleChecker.containsB (target w) s = true := by
    simpa only [check, Bool.and_eq_true] using checked
  have contained := (RuleChecker.containsB_iff _ _).1 facts.2
  exact ⟨target w, ⟨contains_valid contained valid, shape_sound w facts.1⟩, contained⟩

namespace Tests

def sevenDistinct : Witness := seven 0 1 2 3 4 5 6
def duplicateKind : Witness := seven 0 0 1 2 3 4 5

theorem valid_seven_table : Valid (target sevenDistinct) := by
  unfold Valid
  decide +kernel

theorem valid_seven_check : check (target sevenDistinct) sevenDistinct = true := by
  decide +kernel

theorem valid_seven_wins : Win (target sevenDistinct) :=
  sound _ _ valid_seven_table valid_seven_check

/-- This candidate has fourteen tiles and at most four of any kind. Its
    duplicate pair kinds still invalidate the proposed seven-pairs witness. -/
theorem duplicate_table_still_valid : Valid (target duplicateKind) := by
  unfold Valid
  decide +kernel

theorem duplicate_table_has_four_copies : target duplicateKind 0 = 4 := by
  decide +kernel

theorem duplicate_shape_rejected : shapeB duplicateKind = false := by
  decide +kernel

theorem duplicate_check_rejected : check (target duplicateKind) duplicateKind = false := by
  decide +kernel

end Tests

end Mahjong.FullWinWitness

#print axioms Mahjong.FullWinWitness.shape_sound
#print axioms Mahjong.FullWinWitness.sound
#print axioms Mahjong.FullWinWitness.Tests.valid_seven_wins
#print axioms Mahjong.FullWinWitness.Tests.duplicate_check_rejected
