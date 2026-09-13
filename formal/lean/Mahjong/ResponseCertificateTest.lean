import Mahjong.ResponseCertificate
import Mahjong.FastRuleChecker

set_option maxRecDepth 8192
set_option maxHeartbeats 20000000

namespace Mahjong.ResponseCertificate.Tests

open SafeGame Generators

/- Negative guard: 1112223334445m is not winning yet. Every legal first tile
   admits the legal response 5m with a winning target. Nevertheless taking 5m
   as the FIRST move already wins, so responding later is meaningless. -/
def alreadyThreatened : State :=
  countsOf [0,0,0,1,1,1,2,2,2,3,3,3,4]

def numericTriplets (i : Fin 4) : Meld := .triplet (Fin.castLE (by decide) i)

def threatenedTarget : Counts := countsOf (standardTiles numericTriplets 4)

theorem threatened_valid : Valid alreadyThreatened := by unfold Valid; decide +kernel

theorem threatened_notWin : Not (Win alreadyThreatened) :=
  not_win_of_total_lt_14 (by decide +kernel)

theorem first_step_already_wins : Win (addTile alreadyThreatened 4) := by
  refine Exists.intro threatenedTarget (And.intro ?_ ?_)
  · exact And.intro (by unfold Valid; decide +kernel)
      (Or.inl (Exists.intro numericTriplets (Exists.intro 4 rfl)))
  · unfold Contains; decide +kernel

theorem threatened_has_all_responses : Responses alreadyThreatened := by
  intro first legalFirst
  have legalSecond : LegalAdd (addTile alreadyThreatened first) 4 :=
    And.intro (valid_add legalFirst.1 legalFirst.2)
      ((by decide +kernel : forall first : Tile,
        (addTile alreadyThreatened first) 4 < 4) first)
  apply Reply.win 4 legalSecond
  exact win_mono (addTile_mono (addTile_contains alreadyThreatened first) 4)
    first_step_already_wins

theorem threatened_notSafe : Not (IsSafe alreadyThreatened) := by
  intro safe
  exact safe.2 _ (Exists.intro 4 (And.intro
    (And.intro threatened_valid (by decide +kernel)) rfl)) first_step_already_wins

theorem threatened_not_proved : Not (ProvedP alreadyThreatened) :=
  fun proved => threatened_notSafe proved.safe

theorem nonwinning_and_responses_are_insufficient :
    Valid alreadyThreatened ∧ Not (Win alreadyThreatened) ∧
      Responses alreadyThreatened ∧ Not (ProvedP alreadyThreatened) :=
  And.intro threatened_valid (And.intro threatened_notWin
    (And.intro threatened_has_all_responses threatened_not_proved))

end Mahjong.ResponseCertificate.Tests

#print axioms Mahjong.ResponseCertificate.Tests.nonwinning_and_responses_are_insufficient
