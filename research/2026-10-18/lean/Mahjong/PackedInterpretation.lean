import Mahjong.PackedRules

set_option autoImplicit false

namespace Mahjong.PackedInterpretation
open PackedRules

/-- Evaluate each local decoding once before comparing the 34 physical counts. -/
def cachedState (tables : Tables) (s : Packed) : State :=
  let a := (tables 0).core.unrank s.a
  let b := (tables 1).core.unrank s.b
  let c := (tables 2).core.unrank s.c
  let h := (tables 3).core.unrank s.h
  fun u => match u.val/9 with | 0 => a u | 1 => b u | 2 => c u | _ => h u

theorem cachedState_eq (tables : Tables) (s : Packed) : cachedState tables s = state tables s := by
  funext u
  have cases : u.val/9=0 ∨ u.val/9=1 ∨ u.val/9=2 ∨ u.val/9=3 := by have bound := u.isLt; omega
  rcases cases with h | h | h | h <;> simp only [cachedState, state, h, Packed.get]

end Mahjong.PackedInterpretation

#print axioms Mahjong.PackedInterpretation.cachedState_eq
