import Mahjong.RuleChecker

namespace Mahjong.ExplicitWin

/-- Positive witnesses contain just four actual melds and a pair, or an orphan pair.
    The producer is untrusted; the original target shape and inclusion are checked. -/
inductive Witness where
  | standard (a b c d : Meld) (pair : Tile)
  | orphans (pair : Tile)

def four (a b c d : Meld) (i : Fin 4) : Meld :=
  match i.val with
  | 0 => a
  | 1 => b
  | 2 => c
  | _ => d

def target : Witness → Counts
  | .standard a b c d pair => countsOf (standardTiles (four a b c d) pair)
  | .orphans pair => countsOf (pair :: Mahjong.orphans)

def shapeB : Witness → Bool
  | .standard _ _ _ _ _ => true
  | .orphans pair => decide (pair ∈ Mahjong.orphans)

def check (s : State) (w : Witness) : Bool :=
  shapeB w && RuleChecker.containsB (target w) s

theorem shape_sound (w : Witness) (h : shapeB w = true) :
    Standard (target w) ∨ SevenPairs (target w) ∨ ThirteenOrphans (target w) := by
  cases w with
  | standard a b c d pair => exact Or.inl ⟨four a b c d, pair, rfl⟩
  | orphans pair =>
    exact Or.inr (Or.inr ⟨pair, by simpa [shapeB] using h, rfl⟩)

theorem sound (s : State) (w : Witness) (valid : Valid s)
    (checked : check s w = true) : Win s := by
  have hs : shapeB w = true ∧ RuleChecker.containsB (target w) s = true := by
    simpa only [check, Bool.and_eq_true] using checked
  have hc := (RuleChecker.containsB_iff _ _).1 hs.2
  exact ⟨target w, ⟨contains_valid hc valid, shape_sound w hs.1⟩, hc⟩

end Mahjong.ExplicitWin

#print axioms Mahjong.ExplicitWin.sound
