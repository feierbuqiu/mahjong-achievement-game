import Mahjong.CursorLayouts

set_option autoImplicit false

namespace Mahjong.AbsoluteCursor
open GroupCandidates

def absolute (d : GroupInventory.Data) (a b c : Nat) (q : Triple) : Triple :=
  (d.first a+q.1,d.first b+q.2.1,d.first c+q.2.2)

/-- Natural-number model of Cursor::advance after its block-boundary test. -/
def step (d : GroupInventory.Data) (a b c : Nat) (q : Triple) : Triple :=
  if a = c then
    if q.1+1 ≤ q.2.1 then (q.1+1,q.2.1,q.2.2)
    else if q.2.1+1 ≤ q.2.2 then (d.first a,q.2.1+1,q.2.2)
    else (d.first a,d.first b,q.2.2+1)
  else if a = b then
    if q.1+1 ≤ q.2.1 then (q.1+1,q.2.1,q.2.2)
    else if q.2.1+1 < d.first a+d.size a then (d.first a,q.2.1+1,q.2.2)
    else (d.first a,d.first b,q.2.2+1)
  else if b = c then
    if q.1+1 < d.first a+d.size a then (q.1+1,q.2.1,q.2.2)
    else if q.2.1+1 ≤ q.2.2 then (d.first a,q.2.1+1,q.2.2)
    else (d.first a,d.first b,q.2.2+1)
  else
    if q.1+1 < d.first a+d.size a then (q.1+1,q.2.1,q.2.2)
    else if q.2.1+1 < d.first b+d.size b then (d.first a,q.2.1+1,q.2.2)
    else (d.first a,d.first b,q.2.2+1)

theorem step_translation (d : GroupInventory.Data) (a b c : Nat) (q : Triple)
    (ab : a ≤ b) (bc : b ≤ c) :
    step d a b c (absolute d a b c q) = absolute d a b c (CursorLayouts.step d a b c q) := by
  rcases q with ⟨x,y,z⟩
  by_cases ac : a = c
  · have ba : b = a := by omega
    subst b; subst c
    simp only [step,absolute,CursorLayouts.step,CursorLayouts.allThree,↓reduceIte,
      Nat.add_assoc,Nat.add_le_add_iff_left]
    split <;> first | rfl | (split <;> rfl)
  · by_cases same : a = b
    · subst b
      simp only [step,absolute,CursorLayouts.step,CursorLayouts.firstTwo,ac,↓reduceIte,
        Nat.add_assoc,Nat.add_le_add_iff_left,Nat.add_lt_add_iff_left]
      split <;> first | rfl | (split <;> rfl)
    · by_cases same2 : b = c
      · subst c
        simp only [step,absolute,CursorLayouts.step,CursorLayouts.lastTwo,same,↓reduceIte,
          Nat.add_assoc,Nat.add_le_add_iff_left,Nat.add_lt_add_iff_left]
        split <;> first | rfl | (split <;> rfl)
      · simp only [step,absolute,CursorLayouts.step,CursorLayouts.distinct,ac,same,same2,↓reduceIte,
          Nat.add_assoc,Nat.add_lt_add_iff_left]
        split <;> first | rfl | (split <;> rfl)

theorem absolute_injective (d : GroupInventory.Data) (a b c : Nat) (p q : Triple)
    (eq : absolute d a b c p = absolute d a b c q) : p = q := by
  have hx := congrArg (fun t : Triple => t.1) eq
  have hy := congrArg (fun t : Triple => t.2.1) eq
  have hz := congrArg (fun t : Triple => t.2.2) eq
  simp only [absolute,Nat.add_left_cancel_iff] at hx hy hz
  exact Prod.ext hx (Prod.ext hy hz)

end Mahjong.AbsoluteCursor

#print axioms Mahjong.AbsoluteCursor.step_translation
#print axioms Mahjong.AbsoluteCursor.absolute_injective
