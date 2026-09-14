import Mahjong.Rules
import Mahjong.SafeGame
import Mahjong.Certificate
import Mahjong.Quotient

/-!
The original Mahjong rules are connected to the generic game proofs here.
The final theorem is deliberately CONDITIONAL on a genuine mathematical
certificate. No external database bit is postulated or hidden in an axiom.
-/
namespace Mahjong
open SafeGame

def IsSafe (s : State) : Prop := Safe Step Win s
def SafeMove (s t : State) : Prop := SafeStep Step Win s t

theorem safe_of_total_le_12 {s : State} (h : total s ≤ 12) : IsSafe s := by
  constructor
  · exact not_win_of_total_lt_14 (by omega)
  · intro t edge
    apply not_win_of_total_lt_14
    have ht := step_total_succ edge
    omega

theorem empty_safe : IsSafe empty := safe_of_total_le_12 (by decide)

theorem first_move_safe {s : State} (edge : Step empty s) : IsSafe s := by
  apply safe_of_total_le_12
  have ht := step_total_succ edge
  simp only [total_empty] at ht
  omega

theorem safe_move_decreases {s t : State} (edge : SafeMove s t) :
    stock t < stock s := step_stock_strict edge.1

theorem original_safe_reduction {s : State} {o : Outcome} (hs : IsSafe s) :
    NormalStrategy SafeMove s o ↔ AchievementStrategy Step Win s o :=
  safe_reduction hs

/-- Original-game meaning, including an actual winning 14-tile subset at leaves. -/
theorem original_second_player_wins_of_safe_P
    (hp : NormalStrategy SafeMove empty .P) : SecondPlayerWins Step Win empty :=
  safe_p_second_player_wins (move := Step) (win := Win) (domain := Valid)
    (fun _ edge => step_target_valid edge)
    (fun _ valid live => nonwinning_has_step valid live)
    empty_valid empty_safe hp

/-- A total physical-state certificate would settle the original empty game.
This theorem does NOT supply that certificate. -/
theorem original_second_player_wins_of_certificate
    (label : State → Outcome)
    (cert : PNCertificate SafeMove stock label)
    (rootP : label empty = .P) : SecondPlayerWins Step Win empty := by
  apply original_second_player_wins_of_safe_P
  simpa only [rootP] using cert.sound empty

/-- The global database is intended to describe only valid SAFE positions. -/
def SafePosition := {s : State // Valid s ∧ IsSafe s}
def safeEmpty : SafePosition := ⟨empty, empty_valid, empty_safe⟩
def RestrictedSafeMove (s t : SafePosition) : Prop := SafeMove s.val t.val

theorem safe_domain_closed {s t : State} (_hs : Valid s ∧ IsSafe s)
    (edge : SafeMove s t) : Valid t ∧ IsSafe t :=
  ⟨step_target_valid edge.1, edge.2⟩

theorem original_second_player_wins_of_restricted_P
    (hp : NormalStrategy RestrictedSafeMove safeEmpty .P) :
    SecondPlayerWins Step Win empty := by
  apply original_second_player_wins_of_safe_P
  exact normalStrategy_subtype (move := SafeMove) safe_domain_closed hp

/-- A quotient table would prove the original result once its transition
coverage and actual certificate are supplied. Their types expose both gaps. -/
theorem original_second_player_wins_of_quotient_certificate
    {Q : Type} (quotientMove : Q → Q → Prop) (encode : SafePosition → Q)
    (rank : Q → Nat) (label : Q → Outcome)
    (quotient : Quotient.TransitionQuotient RestrictedSafeMove quotientMove encode)
    (cert : PNCertificate quotientMove rank label)
    (rootP : label (encode safeEmpty) = .P) :
    SecondPlayerWins Step Win empty := by
  apply original_second_player_wins_of_restricted_P
  simpa only [rootP] using Quotient.quotient_certificate_sound quotient cert safeEmpty

end Mahjong

#print axioms Mahjong.empty_safe
#print axioms Mahjong.first_move_safe
#print axioms Mahjong.original_safe_reduction
#print axioms Mahjong.original_second_player_wins_of_safe_P
#print axioms Mahjong.original_second_player_wins_of_certificate
#print axioms Mahjong.original_second_player_wins_of_quotient_certificate
