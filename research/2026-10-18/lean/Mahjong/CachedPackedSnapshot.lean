import Mahjong.CachedPackedFast
set_option autoImplicit false

namespace Mahjong.CachedPackedSnapshot
open CachedPackedCheck

structure Memo (α : Type) where
  values : Array α
  fallback : Nat → α

def buildMemo {α : Type} (n : Nat) (f : Nat → α) : Memo α :=
  ⟨Array.ofFn (fun i : Fin n => f i.val),f⟩

def readMemo {α : Type} (m : Memo α) (i : Nat) : α :=
  if h : i < m.values.size then m.values[i] else m.fallback i

theorem readMemo_build {α : Type} (n : Nat) (f : Nat → α) : readMemo (buildMemo n f) = f := by
  funext i
  by_cases h : i < n <;> simp [readMemo,buildMemo,h]

structure Snapshot where
  labels : Array (Memo PruningAlgebra.Label)
  next : Array (Memo (List Nat))

/-- A concrete data value forces cache construction before a reader closure is
    created. Returning a function directly can otherwise be uncurried by Lean. -/
def build (d : Local) : Snapshot :=
  ⟨Array.ofFn (fun b : Fin 4 => buildMemo (d.rules b.val).summary.core.size (d.rules b.val).raw),
   Array.ofFn (fun b : Fin 4 => buildMemo (d.inventories b.val).count (d.edges b.val).next)⟩

def labelReader (d : Local) (s : Snapshot) (b : Nat) : Nat → PruningAlgebra.Label :=
  if h : b < s.labels.size then readMemo (s.labels[b]) else (d.rules b).raw

def nextReader (d : Local) (s : Snapshot) (b : Nat) : Nat → List Nat :=
  if h : b < s.next.size then readMemo (s.next[b]) else (d.edges b).next

def use (d : Local) (s : Snapshot) : Local :=
  { d with rules := (fun b => { (d.rules b) with raw := labelReader d s b })
           edges := (fun b => { (d.edges b) with next := nextReader d s b }) }

theorem use_build (d : Local) : use d (build d) = d := by
  simp only [use,labelReader,nextReader,build,Array.size_ofFn,Array.getElem_ofFn,readMemo_build]
  congr 1 <;> funext b <;> split <;> rfl

end Mahjong.CachedPackedSnapshot

#print axioms Mahjong.CachedPackedSnapshot.readMemo_build
#print axioms Mahjong.CachedPackedSnapshot.use_build
