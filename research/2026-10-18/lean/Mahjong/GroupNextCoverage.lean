import Mahjong.SparseTemplatePlanCheck

set_option autoImplicit false

namespace Mahjong.GroupNextCoverage
open PackedRules GroupCandidates CanonicalInventory BlockPlanCheck

/-- Untrusted overapproximations of the target keys of the actual local cache.
Numeric domains are source groups; honor domains are actual local honor IDs.
This is coverage of edges, not an assertion of future-game equivalence. -/
structure Data where
  keys : Nat → Nat → List Nat

def domainCount (g : @& GroupInventory.Data) (localData : @& CachedPackedCheck.Local)
    (b : Nat) : Nat :=
  if b < 3 then g.groups else (localData.inventories 3).count

def rowFirst (g : @& GroupInventory.Data) (b k : Nat) : Nat :=
  if b < 3 then g.first k else k

def rowCount (g : @& GroupInventory.Data) (b k : Nat) : Nat :=
  if b < 3 then g.size k else 1

def checkNext (g : @& GroupInventory.Data) (localData : @& CachedPackedCheck.Local)
    (coverage : @& Data) (b k i : Nat) : Bool :=
  ((localData.edges b).next i).all fun j =>
    decide (j < (if b < 3 then g.count else (localData.inventories 3).count) ∧
      TemplatePlanCheck.key g b j ∈ coverage.keys b k)

def checkGroup (g : @& GroupInventory.Data) (localData : @& CachedPackedCheck.Local)
    (coverage : @& Data) (b k : Nat) : Bool :=
  checkSpan (checkNext g localData coverage b k) (rowFirst g b k) (rowCount g b k)

/-- Executed once for the fixed local caches, before any per-block plan.
Every actual local successor is visited here, including unsafe successors. -/
def check (g : @& GroupInventory.Data) (localData : @& CachedPackedCheck.Local)
    (coverage : @& Data) : Bool :=
  (List.range 4).all fun b =>
    checkSpan (checkGroup g localData coverage b) 0 (domainCount g localData b)

theorem checked_group (g : GroupInventory.Data) (localData : CachedPackedCheck.Local)
    (coverage : Data) (b k : Nat) (accepted : check g localData coverage = true)
    (blockBound : b < 4) (keyBound : k < domainCount g localData b) :
    checkGroup g localData coverage b k = true := by
  have groups := List.all_eq_true.mp accepted b (List.mem_range.mpr blockBound)
  have atKey := checkSpan_each (checkGroup g localData coverage b)
    (domainCount g localData b) 0 groups k keyBound
  simpa only [Nat.zero_add] using atKey

theorem covered (g : GroupInventory.Data) (localData : CachedPackedCheck.Local)
    (coverage : Data) (b k i j : Nat) (accepted : check g localData coverage = true)
    (blockBound : b < 4) (keyBound : k < domainCount g localData b)
    (lower : rowFirst g b k ≤ i) (upper : i-rowFirst g b k < rowCount g b k)
    (member : j ∈ (localData.edges b).next i) :
    j < (if b < 3 then g.count else (localData.inventories 3).count) ∧
      TemplatePlanCheck.key g b j ∈ coverage.keys b k := by
  have group := checked_group g localData coverage b k accepted blockBound keyBound
  have row := checkSpan_each (checkNext g localData coverage b k)
    (rowCount g b k) (rowFirst g b k) group (i-rowFirst g b k) upper
  have same : rowFirst g b k + (i-rowFirst g b k) = i := by omega
  rw [same] at row
  exact of_decide_eq_true (List.all_eq_true.mp row j member)

end Mahjong.GroupNextCoverage

#print axioms Mahjong.GroupNextCoverage.checked_group
#print axioms Mahjong.GroupNextCoverage.covered
