import Mahjong.FastRuleChecker
import Mahjong.Generators
import Mahjong.OrbitCertificate
import Mahjong.Bridge

/-!
The complete original Mahjong rules, proved fast successor enumeration, and
all concrete symmetry generators are instantiated here. The candidate producer
and its C++ canonicalizer/index may be entirely untrusted. Every shared reference
must carry a checked sequence of rule-preserving tile permutations.

Only a concrete accepted certificate is missing from the empty-game theorem.
The checker definition and its soundness alone do not certify the external table.
-/
namespace Mahjong.SymmetryCertificate

open SafeGame Generators

abbrev Tree := OrbitCertificate.Tree State Generator
abbrev Node := OrbitCertificate.Node State Generator
abbrev Ref := OrbitCertificate.Ref Generator

def check (tree : Tree) : Bool :=
  OrbitCertificate.checkDatabase FastRuleChecker.safeSuccessors applyPath tree

theorem check_sound (tree : Tree) (checked : check tree = true)
    (id : Nat) (node : Node) (found : OrbitCertificate.lookup tree id = some node) :
    NormalStrategy SafeMove node.state node.outcome :=
  OrbitCertificate.checkDatabase_sound FastRuleChecker.safeSuccessors SafeMove
    FastRuleChecker.safeSuccessors_iff applyPath
    (fun path s o => (path_preserves_outcome path s o).symm)
    tree checked id node found

/-- No unproved rule, enumeration, symmetry, indexing, or SAFE-bound premise.
The remaining premises are the ACTUAL checked finite certificate and its root. -/
theorem checked_empty_tree_wins (tree : Tree) (checked : check tree = true)
    (id : Nat) (refs : List Ref)
    (found : OrbitCertificate.lookup tree id = some ⟨id, empty, .P, refs⟩) :
    SecondPlayerWins Step Win empty :=
  original_second_player_wins_of_safe_P
    (check_sound tree checked id ⟨id, empty, .P, refs⟩ found)

end Mahjong.SymmetryCertificate

#print axioms Mahjong.SymmetryCertificate.check_sound
#print axioms Mahjong.SymmetryCertificate.checked_empty_tree_wins
