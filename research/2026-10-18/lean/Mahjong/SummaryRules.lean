import Mahjong.LocalSummary
import Mahjong.ExactMemoRules

namespace Mahjong.SummaryRules
open LocalSummary PairProfile

def others (b : Nat) (p : Nat → Value) : Nat :=
  match b with
  | 0 => (p 1).meld + (p 2).meld + (p 3).meld
  | 1 => (p 0).meld + (p 2).meld + (p 3).meld
  | 2 => (p 0).meld + (p 1).meld + (p 3).meld
  | _ => (p 0).meld + (p 1).meld + (p 2).meld

def noStandardB (p : Nat → Value) : Bool :=
  [0, 1, 2, 3].all (fun b => decide ((p b).pair = 0 ∨ (p b).pair + others b p ≤ 4))

def sevenPairsB (p : Nat → Value) : Bool :=
  decide (7 ≤ (p 0).pairs + (p 1).pairs + (p 2).pairs + (p 3).pairs)

def orphansB (p : Nat → Value) : Bool :=
  ((p 0).orphanAll && (p 1).orphanAll && (p 2).orphanAll && (p 3).orphanAll) &&
  ((p 0).orphanPair || (p 1).orphanPair || (p 2).orphanPair || (p 3).orphanPair)

def noWinB (p : Nat → Value) : Bool := !sevenPairsB p && !orphansB p && noStandardB p

theorem tiles_partition : allTiles = blockTiles 0 ++ blockTiles 1 ++ blockTiles 2 ++ blockTiles 3 := by decide
theorem orphans_partition : orphans = orphanTiles 0 ++ orphanTiles 1 ++ orphanTiles 2 ++ orphanTiles 3 := by decide

theorem sevenPairsB_spec (s : State) : sevenPairsB (fun b => spec b s) = RuleChecker.sevenPairsB s := by
  unfold sevenPairsB RuleChecker.sevenPairsB RuleChecker.pairKinds
  rw [tiles_partition]
  simp only [List.filter_append, List.length_append, spec, Nat.add_assoc]

theorem orphansB_spec (s : State) : orphansB (fun b => spec b s) = FastOrphans.orphansB s := by
  unfold orphansB FastOrphans.orphansB
  rw [orphans_partition]
  simp only [List.all_append, List.any_append, spec, Bool.and_assoc, Bool.or_assoc]

theorem noStandardB_spec (s : State) :
    noStandardB (fun b => spec b s) = PairProfile.noStandardB s := by
  simp only [noStandardB, PairProfile.noStandardB, List.all_cons, List.all_nil,
    others, PairProfile.others, spec]

theorem noWinB_spec (s : State) : noWinB (fun b => spec b s) = FactorizedRules.noWinB s := by
  simp only [noWinB, sevenPairsB_spec, orphansB_spec, noStandardB_spec,
    FastOrphans.orphansB_eq, PairProfile.noStandardB_eq, FactorizedRules.noWinB]

end Mahjong.SummaryRules

#print axioms Mahjong.SummaryRules.noWinB_spec
