import Mahjong.IndexSearch
import Mahjong.GroupInventory

set_option autoImplicit false

namespace Mahjong.IndexHelperCheck
open Ranking CanonicalInventory IndexSearch

def pairRow (outputs : ByteArray) (r : Nat) : Bool :=
  let y := read32 outputs (4*r)
  decide (y < 3403) && decide (c2 y ≤ r) && decide (r < c2 (y+1))

theorem pairRow_correct (outputs : ByteArray) (r seed : Nat) (ok : pairRow outputs r = true) :
    read32 outputs (4*r) = pairFloor r seed := by
  simp only [pairRow,Bool.and_eq_true,decide_eq_true_eq] at ok
  have f := pairFloor_spec r seed
  by_cases less : read32 outputs (4*r) < pairFloor r seed
  · have mono := c2_mono (a:=read32 outputs (4*r)+1) (b:=pairFloor r seed) (by omega)
    omega
  · by_cases greater : pairFloor r seed < read32 outputs (4*r)
    · have mono := c2_mono (a:=pairFloor r seed+1) (b:=read32 outputs (4*r)) (by omega)
      omega
    · omega

def groupRow (groups : ByteArray) (g : Nat) : Bool :=
  let first := read32 groups (8*g)
  let size := read32 groups (8*g+4)
  decide (0 < size) && decide (size ≤ 3403) && decide (first+size ≤ 131676)

theorem groupRow_bounds (groups : ByteArray) (g : Nat) (ok : groupRow groups g = true) :
    0 < read32 groups (8*g+4) ∧ read32 groups (8*g+4) ≤ 3403 ∧
      read32 groups (8*g)+read32 groups (8*g+4) ≤ 131676 := by
  simpa only [groupRow,Bool.and_eq_true,decide_eq_true_eq,and_assoc] using ok

theorem checked_pairs (outputs : ByteArray) (start count : Nat)
    (ok : checkSpan (pairRow outputs) start count = true) (i : Nat) (hi : i < count) (seed : Nat) :
    read32 outputs (4*(start+i)) = pairFloor (start+i) seed :=
  pairRow_correct outputs (start+i) seed (checkSpan_each _ count start ok i hi)

end Mahjong.IndexHelperCheck

#print axioms Mahjong.IndexHelperCheck.pairRow_correct
#print axioms Mahjong.IndexHelperCheck.groupRow_bounds
#print axioms Mahjong.IndexHelperCheck.checked_pairs
