import MahjongNext.ResponseTable

/-!
Bounded groups of row checks for one complete response table. A group is a
contiguous slice of the actual tree rows, not an assumed list of row IDs.
Each check still resolves references against the whole original tree.
-/

namespace Mahjong.ResponseGroups

open ResponseTable

def rows : Tree → List Row
  | .empty => []
  | .branch left row right => rows left ++ row :: rows right

theorem allCheck_eq_rows (test : Row → Bool) (tree : Tree) :
    allCheck test tree = (rows tree).all test := by
  induction tree with
  | empty => rfl
  | branch left row right ihl ihr =>
    simp only [allCheck, rows, List.all_append, List.all_cons, ihl, ihr]

/-- `start` and `count` describe a slice, but all references are looked up
    in the same complete `tree` passed to every group. -/
def checkRange (bounds : Nat → State) (tree : Tree) (start count : Nat) : Bool :=
  (((rows tree).drop start).take count).all (checkRow bounds tree)

/-- Adjacent checked ranges combine without recomputing any row checker. -/
theorem checkRange_append (bounds : Nat → State) (tree : Tree)
    (start firstCount secondCount : Nat)
    (first : checkRange bounds tree start firstCount = true)
    (second : checkRange bounds tree (start + firstCount) secondCount = true) :
    checkRange bounds tree start (firstCount + secondCount) = true := by
  unfold checkRange at *
  rw [List.take_add, List.all_append, List.drop_drop]
  rw [first, second]
  rfl

/-- Checking a prefix that covers the entire actual row list proves the
    original database check, including rows not retrievable by ID lookup. -/
theorem checkDatabase_of_full_range (bounds : Nat → State) (tree : Tree)
    (count : Nat) (covers : (rows tree).length ≤ count)
    (checked : checkRange bounds tree 0 count = true) :
    checkDatabase bounds tree = true := by
  unfold checkRange at checked
  simp only [List.drop_zero] at checked
  rw [List.take_of_length_le covers] at checked
  simpa only [checkDatabase, allCheck_eq_rows] using checked

end Mahjong.ResponseGroups

#print axioms Mahjong.ResponseGroups.allCheck_eq_rows
#print axioms Mahjong.ResponseGroups.checkRange_append
#print axioms Mahjong.ResponseGroups.checkDatabase_of_full_range
