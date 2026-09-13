import MahjongNext.ResponseGroups
import Mahjong.FastRuleChecker

namespace Mahjong.Scale.FastPositive

open RuleChecker FastRuleChecker

/-- Consume just the supplied four melds, without searching or counting the
    complete fourteen-tile list separately at each of the 34 tile kinds. -/
def meldsPair (ms : List Meld) (s : State) (pair : Tile) : Bool :=
  match ms with
  | [] => pairAvailableB s pair
  | m :: rest => meldAvailableB s m && meldsPair rest (removeMeld s m) pair

theorem meldsPair_iff (ms : List Meld) (s : State) (pair : Tile) :
    meldsPair ms s pair = true ↔
      Contains (countsOf (ms.flatMap Meld.tiles ++ [pair, pair])) s := by
  induction ms generalizing s with
  | nil =>
    simp only [meldsPair, List.flatMap_nil, List.nil_append,
      pairAvailableB_eq, containsB_iff]
  | cons m rest ih =>
    simp only [meldsPair, Bool.and_eq_true, meldAvailableB_eq,
      containsB_iff, ih, removeMeld_eq, List.flatMap_cons,
      List.append_assoc, contains_append_iff]

theorem meldsPair_eq (ms : List Meld) (s : State) (pair : Tile) :
    meldsPair ms s pair =
      containsB (countsOf (ms.flatMap Meld.tiles ++ [pair, pair])) s := by
  apply Bool.eq_iff_iff.2
  exact (meldsPair_iff ms s pair).trans (containsB_iff _ _).symm

def check (s : State) : FullWinWitness.Witness → Bool
  | .ordinary (.standard a b c d pair) => meldsPair [a,b,c,d] s pair
  | witness => FullWinWitness.check s witness

theorem check_eq (s : State) (witness : FullWinWitness.Witness) :
    check s witness = FullWinWitness.check s witness := by
  cases witness with
  | sevenPairs pairs => rfl
  | ordinary witness =>
    cases witness with
    | orphans pair => rfl
    | standard a b c d pair =>
      rw [check, meldsPair_eq]
      simp only [FullWinWitness.check, FullWinWitness.shapeB,
        ExplicitWin.shapeB, Bool.true_and, FullWinWitness.target,
        ExplicitWin.target, standardTiles, ExplicitWin.four,
        List.flatMap_cons, List.flatMap_nil, List.append_nil,
        List.append_assoc]
      rfl

theorem sound (s : State) (witness : FullWinWitness.Witness)
    (valid : Valid s) (checked : check s witness = true) : Win s :=
  FullWinWitness.sound s witness valid (by simpa only [check_eq] using checked)

open ResponseTable

def checkAction (tree : Tree) (limit : Nat) (s : State) (first : Tile) : Action → Bool
  | .win second witness =>
      decide ((addTile s first) second < 4) && check (afterReply s first second) witness
  | action => ResponseTable.checkAction tree limit s first action

theorem checkAction_eq (tree : Tree) (limit : Nat) (s : State) (first : Tile)
    (action : Action) :
    checkAction tree limit s first action = ResponseTable.checkAction tree limit s first action := by
  cases action with
  | win second witness => simp only [checkAction, ResponseTable.checkAction, check_eq]
  | back second ref path => rfl

def checkRow (bounds : Nat → State) (tree : Tree) (row : Row) : Bool :=
  containsB row.state (bounds row.safeBound) &&
    allTiles.all (fun first => if row.state first < 4 then
      checkAction tree row.id row.state first (row.action first) else true)

theorem checkRow_eq (bounds : Nat → State) (tree : Tree) (row : Row) :
    checkRow bounds tree row = ResponseTable.checkRow bounds tree row := by
  simp only [checkRow, ResponseTable.checkRow, checkAction_eq]

def checkRange (bounds : Nat → State) (tree : Tree) (start count : Nat) : Bool :=
  (((ResponseGroups.rows tree).drop start).take count).all (checkRow bounds tree)

theorem checkRange_eq (bounds : Nat → State) (tree : Tree) (start count : Nat) :
    checkRange bounds tree start count = ResponseGroups.checkRange bounds tree start count := by
  have same := funext (checkRow_eq bounds tree)
  simp only [checkRange, ResponseGroups.checkRange, same]

end Mahjong.Scale.FastPositive

#print axioms Mahjong.Scale.FastPositive.check_eq
#print axioms Mahjong.Scale.FastPositive.sound
#print axioms Mahjong.Scale.FastPositive.checkAction_eq
#print axioms Mahjong.Scale.FastPositive.checkRange_eq
