import Mahjong.CachedPackedSnapshot

set_option autoImplicit false

namespace Mahjong.MaterializedLocal
open CachedPackedCheck CachedPackedSnapshot

/-- Cache whole candidate structures as well as their row data. Otherwise a
reader closure can reconstruct many candidate structures on every lookup. -/
structure Views where
  rules : Memo PruningData.Candidate
  inventories : Memo CanonicalInventory.Candidate
  edges : Memo SuccessorCache.Data

def build (d : Local) : Views :=
  ⟨buildMemo 4 d.rules,buildMemo 4 d.inventories,buildMemo 4 d.edges⟩

def use (v : Views) : Local :=
  ⟨readMemo v.rules,readMemo v.inventories,readMemo v.edges⟩

/-- Equality is for all indices, including the fallback outside 0..3. No
external cache assertion or unchecked reader-correctness premise is needed. -/
theorem use_build (d : Local) : use (build d) = d := by
  simp only [use,build,readMemo_build]

theorem row_eq (d : Local) (target : GeneralLayer.Target) (s : PackedRules.Packed) (isP : Bool) :
    CachedPackedFast.row (use (build d)) target s isP = CachedPackedFast.row d target s isP := by
  rw [use_build]

end Mahjong.MaterializedLocal

#print axioms Mahjong.MaterializedLocal.use_build
#print axioms Mahjong.MaterializedLocal.row_eq
