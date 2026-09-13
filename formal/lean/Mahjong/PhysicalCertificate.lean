import Mahjong.MoveEnumeration
import Mahjong.Certificate
import Mahjong.IndexedCertificate
import Mahjong.Bridge

/-!
This bridge instantiates the certificate checker with the ORIGINAL physical
rules. Successor completeness is proved, not supplied by the external producer.
An actual accepted trace still has to be supplied; the database is not an axiom.
-/
namespace Mahjong.PhysicalCertificate

open SafeGame MoveEnumeration

theorem trace_sound (trace : List (Certificate.Claim State))
    (checked : Certificate.checkTrace safeSuccessors trace = true)
    (c : Certificate.Claim State) (hc : c ∈ trace) :
    NormalStrategy SafeMove c.state c.outcome :=
  Certificate.checkTrace_sound safeSuccessors SafeMove safeSuccessors_iff
    trace checked c hc

theorem checked_empty_trace_wins (trace : List (Certificate.Claim State))
    (checked : Certificate.checkTrace safeSuccessors trace = true)
    (hasRoot : (⟨empty, .P⟩ : Certificate.Claim State) ∈ trace) :
    SecondPlayerWins Step Win empty :=
  original_second_player_wins_of_safe_P
    (trace_sound trace checked ⟨empty, .P⟩ hasRoot)

theorem indexed_sound (tree : IndexedCertificate.Tree State)
    (checked : IndexedCertificate.checkDatabase safeSuccessors tree = true)
    (id : Nat) (node : IndexedCertificate.Node State)
    (found : IndexedCertificate.lookup tree id = some node) :
    NormalStrategy SafeMove node.state node.outcome :=
  IndexedCertificate.checkDatabase_sound safeSuccessors SafeMove safeSuccessors_iff
    tree checked id node found

theorem checked_empty_tree_wins (tree : IndexedCertificate.Tree State)
    (checked : IndexedCertificate.checkDatabase safeSuccessors tree = true)
    (id : Nat) (refs : List Nat)
    (found : IndexedCertificate.lookup tree id = some ⟨id, empty, .P, refs⟩) :
    SecondPlayerWins Step Win empty :=
  original_second_player_wins_of_safe_P
    (indexed_sound tree checked id ⟨id, empty, .P, refs⟩ found)

end Mahjong.PhysicalCertificate

#print axioms Mahjong.PhysicalCertificate.trace_sound
#print axioms Mahjong.PhysicalCertificate.checked_empty_trace_wins
#print axioms Mahjong.PhysicalCertificate.checked_empty_tree_wins
