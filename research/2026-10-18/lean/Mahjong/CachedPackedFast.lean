import Mahjong.CachedPackedCheck
set_option autoImplicit false

namespace Mahjong.CachedPackedFast
open PackedRules GeneralLayer CachedPackedCheck

/-- Share canonicalization and rank proposal across the reference guard and
    label lookup. The executable still checks the complete Packed equality. -/
def labelB (d : Local) (target : Target) (s : Packed) (wantP : Bool) : Bool :=
  let canonical := normalize d s
  let r := target.locate canonical
  decide (r.index < target.size r.bucket) &&
    decide (target.unrank r.bucket r.index = canonical) &&
    (if wantP then target.labelP r.bucket r.index else !target.labelP r.bucket r.index)

theorem labelB_eq (d : Local) (target : Target) (s : Packed) (wantP : Bool) :
    labelB d target s wantP =
      (refB d target s && (if wantP then isP d target s else !isP d target s)) := by
  cases wantP <;> rfl

def row (d : Local) (target : Target) (s : Packed) (sourceP : Bool) : Bool :=
  initial d s && if sourceP then
    (raw d s).all (fun q => !safeB d q || labelB d target q false)
  else
    (raw d s).any (fun q => safeB d q && labelB d target q true)

theorem row_eq (d : Local) (target : Target) (s : Packed) (sourceP : Bool) :
    row d target s sourceP = CachedPackedCheck.row d target s sourceP := by
  simp only [row,CachedPackedCheck.row,labelB_eq,Bool.false_eq_true,if_false,
    if_true,Bool.and_assoc]

def single (d : Local) (target : Target) (s : Packed) (b j : Nat) : Bool :=
  initial d s && decide (b < 4) &&
    decide (j ∈ (d.edges b).next (sourceId d s b)) &&
    safeB d (replace d s b j) && labelB d target (replace d s b j) true

theorem single_eq (d : Local) (target : Target) (s : Packed) (b j : Nat) :
    single d target s b j = CachedPackedCheck.single d target s b j := by
  simp only [single,CachedPackedCheck.single,labelB_eq,if_true,Bool.and_assoc]

end Mahjong.CachedPackedFast

#print axioms Mahjong.CachedPackedFast.labelB_eq
#print axioms Mahjong.CachedPackedFast.row_eq
#print axioms Mahjong.CachedPackedFast.single_eq
