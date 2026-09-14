import Mahjong.MemoRules
import Mahjong.WholeTable

namespace Mahjong.CachedWholeTable

def checkCaches (tables : MemoRules.Tables) : Bool :=
  LocalCache.check 0 (tables 0) && LocalCache.check 1 (tables 1) &&
    LocalCache.check 2 (tables 2) && LocalCache.check 3 (tables 3)

theorem checkCaches_sound (tables : MemoRules.Tables) (checked : checkCaches tables = true) :
    MemoRules.Checked tables := by
  simp only [checkCaches, Bool.and_eq_true] at checked
  intro b hb
  have cases : b = 0 ∨ b = 1 ∨ b = 2 ∨ b = 3 := by omega
  rcases cases with rfl | rfl | rfl | rfl
  · exact checked.1.1.1
  · exact checked.1.1.2
  · exact checked.1.2
  · exact checked.2

def checkRow (tables : MemoRules.Tables) (table : WholeTable.Candidate) (i : Nat) : Bool :=
  let s := table.unrank i
  let next := MemoRules.safeSuccessors tables s
  RuleChecker.validB s && MemoRules.safeB tables s &&
    next.all (WholeTable.checkRef table (stock s)) && WholeTable.checkPN table next (table.label i)

theorem checkRow_eq (tables : MemoRules.Tables) (checked : MemoRules.Checked tables)
    (table : WholeTable.Candidate) (i : Nat) : checkRow tables table i = WholeTable.checkRow table i := by
  simp only [checkRow, WholeTable.checkRow, MemoRules.safeB_eq tables checked,
    MemoRules.safeSuccessors_eq tables checked]

def checkSpan (tables : MemoRules.Tables) (table : WholeTable.Candidate) (start : Nat) : Nat → Bool
  | 0 => true
  | count + 1 => checkRow tables table start && checkSpan tables table (start + 1) count

theorem checkSpan_eq (tables : MemoRules.Tables) (checked : MemoRules.Checked tables)
    (table : WholeTable.Candidate) (count start : Nat) :
    checkSpan tables table start count = WholeTable.checkSpan table start count := by
  induction count generalizing start with
  | zero => rfl
  | succ count ih => simp only [checkSpan, WholeTable.checkSpan, checkRow_eq tables checked, ih]

def check (tables : MemoRules.Tables) (table : WholeTable.Candidate) : Bool :=
  checkCaches tables && checkSpan tables table 0 table.size

theorem checked_empty_wins (tables : MemoRules.Tables) (table : WholeTable.Candidate) (i : Nat)
    (checked : check tables table = true) (root : WholeTable.checkRoot table i = true) :
    SafeGame.SecondPlayerWins Step Win empty := by
  simp only [check, Bool.and_eq_true] at checked
  have hc := checkCaches_sound tables checked.1
  apply WholeTable.checked_empty_wins table i _ root
  simpa only [WholeTable.check, checkSpan_eq tables hc] using checked.2

end Mahjong.CachedWholeTable

#print axioms Mahjong.CachedWholeTable.checked_empty_wins
