import Mahjong.IndexedByteRowV16

set_option autoImplicit false

namespace Mahjong.GuardedByteScanV16
open GroupCandidates BlockPlanCheck

/-- Proposal only: check still validates the absolute source r every time. -/
@[inline] def nextIds (view : @& SourceBlockGuard.View)
    (a b c : Nat) : Triple :=
  let x := a-view.word.firstA
  let y := b-view.word.firstB
  let z := c-view.word.firstC
  let (nx,ny,nz) := if view.word.a = view.word.c then
      if x < y then (x+1,y,z) else if y < z then (0,y+1,z) else (0,0,z+1)
    else if view.word.a = view.word.b then
      if x < y then (x+1,y,z) else if y+1 < view.sizes.1 then (0,y+1,z) else (0,0,z+1)
    else if view.word.b = view.word.c then
      if x+1 < view.sizes.1 then (x+1,y,z) else if y < z then (0,y+1,z) else (0,0,z+1)
    else
      if x+1 < view.sizes.1 then (x+1,y,z) else if y+1 < view.sizes.2.1 then (0,y+1,z) else (0,0,z+1)
  (view.word.firstA+nx,view.word.firstB+ny,view.word.firstC+nz)

/-- A scalar tail loop. No tuple of mutable loop state is allocated for each
accepted row. The recursion count, rather than the cursor, controls coverage. -/
def scan (snapshot : @& BorrowedNextGeneratedHotPlan.Snapshot)
    (view : @& SourceBlockGuard.View) (ctx : @& Context)
    (sourceBits compact : @& ByteArray) (base : Nat) :
    Nat → Nat → Nat → Nat → Nat → Nat → Except Nat Nat
  | 0,_,_,_,_,p => .ok p
  | remaining+1,row,a,b,c,p =>
    let isP := FastBitRead.labelPNat sourceBits row
    if Mahjong.IndexedByteRowV16.check snapshot view ctx (a,b,c) (compact[row-base]!) row isP then
      let next := nextIds view a b c
      scan snapshot view ctx sourceBits compact base remaining (row+1)
        next.1 next.2.1 next.2.2 (if isP then p+1 else p)
    else .error row

/-- A successful loop has checked EVERY absolute r in its complete range.
Nothing about correctness of the coordinate cursor is assumed. -/
theorem accepted_checks_every_row
    (snapshot : BorrowedNextGeneratedHotPlan.Snapshot) (view : SourceBlockGuard.View) (ctx : Context)
    (sourceBits compact : ByteArray) (base remaining row a b c p result : Nat)
    (accepted : scan snapshot view ctx sourceBits compact base remaining row a b c p = .ok result) :
    ∀ i, row ≤ i → i < row+remaining → ∃ ids : Triple,
      Mahjong.IndexedByteRowV16.check snapshot view ctx ids (compact[i-base]!) i
        (FastBitRead.labelPNat sourceBits i) = true := by
  induction remaining generalizing row a b c p with
  | zero => intro i lo hi; omega
  | succ remaining ih =>
    simp only [scan] at accepted
    split at accepted
    next checked =>
      intro i lo hi
      by_cases current : i = row
      · subst i
        exact ⟨(a,b,c),checked⟩
      · apply ih _ _ _ _ _ accepted i <;> omega
    next rejected => cases accepted

end Mahjong.GuardedByteScanV16

#print axioms Mahjong.GuardedByteScanV16.accepted_checks_every_row
