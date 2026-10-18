import Mahjong.CachedPackedSnapshot

set_option autoImplicit false

namespace Mahjong.GeneratedLocalCache
open CachedPackedCheck CachedPackedSnapshot

/-- Materialize only the finite next lists. Raw SAFE labels are deliberately not
included; rebuilding millions of label objects is unnecessary for this checker. -/
structure Snapshot where
  next : Array (Memo (List Nat))

@[noinline] def build (d : Local) : Snapshot :=
  ⟨Array.ofFn (fun b : Fin 4 =>
    buildMemo (d.inventories b.val).count (d.edges b.val).next)⟩

def nextReader (d : Local) (s : Snapshot) (b : Nat) : Nat → List Nat :=
  if h : b < s.next.size then readMemo s.next[b] else (d.edges b).next

@[noinline] def use (d : Local) (s : Snapshot) : Local :=
  { d with edges := fun b => { (d.edges b) with next := nextReader d s b } }

/-- All indices, including outside 0..3 and outside the cached local-ID range,
retain exactly the original total function. No data-correctness premise is added. -/
theorem use_build (d : Local) : use d (build d) = d := by
  simp only [use,nextReader,build,Array.size_ofFn,Array.getElem_ofFn,readMemo_build]
  congr 1
  funext b
  split <;> rfl

theorem next_build (d : Local) (b i : Nat) :
    ((use d (build d)).edges b).next i = (d.edges b).next i := by
  rw [use_build]

end Mahjong.GeneratedLocalCache

#print axioms Mahjong.GeneratedLocalCache.use_build
#print axioms Mahjong.GeneratedLocalCache.next_build
