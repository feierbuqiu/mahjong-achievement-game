import Mahjong.MovePlanRefinement

set_option autoImplicit false

namespace Mahjong.PlanCacheCoverage

def targetGroups (d : GroupInventory.Data) (next : Nat → List Nat) (g : Nat) : List Nat :=
  (((List.range d.count).filter (fun i => decide (d.group i = g))).flatMap
    (fun i => (next i).map d.group)).eraseDups

/-- Union over all local members of a group contains every group needed by
an actual local edge. Duplicate removal does not remove this coverage. -/
theorem target_groups_cover (d : GroupInventory.Data) (next : Nat → List Nat) (i j : Nat)
    (hi : i < d.count) (edge : j ∈ next i) : d.group j ∈ targetGroups d next (d.group i) := by
  simp only [targetGroups,List.mem_eraseDups,List.mem_flatMap,List.mem_filter,List.mem_range,List.mem_map]
  exact ⟨i,⟨hi,by simp⟩,j,edge,rfl⟩

/-- Model of overwriting the reachable target-group offsets at each new
numeric group block. Entries outside this list may remain stale. -/
def fill {α : Type} (current : Nat → α) : List Nat → (Nat → α) → Nat → α
  | [], old => old
  | g :: rest, old => fill current rest (fun k => if k = g then current g else old k)

theorem fill_miss {α : Type} (current old : Nat → α) (groups : List Nat) (g : Nat)
    (miss : g ∉ groups) : fill current groups old g = old g := by
  induction groups generalizing old with
  | nil => rfl
  | cons h rest ih =>
    have parts : g ≠ h ∧ g ∉ rest := by simpa only [List.mem_cons,not_or] using miss
    simp only [fill,ih _ parts.2,if_neg parts.1]

theorem fill_hit {α : Type} (current old : Nat → α) (groups : List Nat) (g : Nat)
    (hit : g ∈ groups) : fill current groups old g = current g := by
  induction groups generalizing old with
  | nil => cases hit
  | cons h rest ih =>
    by_cases later : g ∈ rest
    · exact ih _ later
    · have same : g = h := (List.mem_cons.mp hit).resolve_right later
      rw [fill,fill_miss current _ rest g later]
      simp only [same,↓reduceIte]

theorem every_used_offset_fresh {α : Type} (d : GroupInventory.Data) (next : Nat → List Nat)
    (current old : Nat → α) (i j : Nat) (hi : i < d.count) (edge : j ∈ next i) :
    fill current (targetGroups d next (d.group i)) old (d.group j) = current (d.group j) :=
  fill_hit current old _ _ (target_groups_cover d next i j hi edge)

end Mahjong.PlanCacheCoverage

#print axioms Mahjong.PlanCacheCoverage.target_groups_cover
#print axioms Mahjong.PlanCacheCoverage.fill_miss
#print axioms Mahjong.PlanCacheCoverage.fill_hit
#print axioms Mahjong.PlanCacheCoverage.every_used_offset_fresh
