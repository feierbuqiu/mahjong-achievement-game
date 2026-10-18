import Mahjong.DirectoryIndex
import Mahjong.PrefixData

set_option autoImplicit false

namespace Mahjong.DirectorySliceBinding
open CanonicalInventory

structure Slice where
  rowBase : Nat
  byteBase : Nat
  count : Nat
  total : Nat
  deriving Inhabited

def row (u : HonorDirectory.Data) (bytes : ByteArray) (s : Slice) (layer b : Nat) : Bool :=
  decide (u.tid (s.rowBase+b) = read32 bytes (s.byteBase+20*b)) &&
  decide (u.layer (s.rowBase+b) = layer) &&
  decide (u.width (s.rowBase+b) = PrefixData.read64 bytes (s.byteBase+20*b+12))

def checkSlice (u : HonorDirectory.Data) (bytes : ByteArray) (s : Slice) (layer : Nat) : Bool :=
  decide (s.rowBase+s.count ≤ u.count) && decide (s.byteBase+20*s.count ≤ bytes.size) &&
  PrefixDirectory.check (PrefixData.candidate bytes s.byteBase s.count s.total) &&
  checkSpan (row u bytes s layer) 0 s.count

theorem slice_facts (u : HonorDirectory.Data) (bytes : ByteArray) (s : Slice) (layer : Nat)
    (checked : checkSlice u bytes s layer = true) :
    s.rowBase+s.count ≤ u.count ∧ s.byteBase+20*s.count ≤ bytes.size ∧
    PrefixDirectory.check (PrefixData.candidate bytes s.byteBase s.count s.total) = true ∧
    ∀ b, b < s.count → u.tid (s.rowBase+b) = read32 bytes (s.byteBase+20*b) ∧
      u.layer (s.rowBase+b) = layer ∧
      u.width (s.rowBase+b) = (PrefixData.candidate bytes s.byteBase s.count s.total).size b := by
  simp only [checkSlice,Bool.and_eq_true,decide_eq_true_eq] at checked
  refine ⟨checked.1.1.1,checked.1.1.2,checked.1.2,?_⟩
  intro b hb
  have f := checkSpan_each _ s.count 0 checked.2 b hb
  simpa only [row,Nat.zero_add,Bool.and_eq_true,decide_eq_true_eq,and_assoc,PrefixData.candidate] using f

theorem checked_index (d : GroupInventory.Data) (t : TripleDirectory.Data) (u : HonorDirectory.Data)
    (h : PruningAlgebra.Label) (groups : GroupInventory.Checked d) (triples : TripleDirectory.Checked d t)
    (honors : HonorDirectory.Checked d t h u) (bytes : ByteArray) (s : Slice) (layer : Nat)
    (checked : checkSlice u bytes s layer = true) :
    IndexOperations.Checked (DirectoryIndex.candidate d t u
      (PrefixData.candidate bytes s.byteBase s.count s.total) s.rowBase) := by
  have f := slice_facts u bytes s layer checked
  exact DirectoryIndex.checked_slice d t u h _ s.rowBase groups triples honors f.2.2.1 f.1
    (fun b hb => (f.2.2.2 b hb).2.2.symm)

def rowCovered (u : HonorDirectory.Data) (slices : Array Slice) (r : Nat) : Bool :=
  let n := u.layer r
  let s := slices[n]!
  decide (n < slices.size) && decide (s.rowBase ≤ r) && decide (r < s.rowBase+s.count)

def check (u : HonorDirectory.Data) (bytes : ByteArray) (slices : Array Slice) : Bool :=
  decide (slices.size = 35) && checkSpan (fun n => checkSlice u bytes slices[n]! n) 0 slices.size &&
  checkSpan (rowCovered u slices) 0 u.count

theorem every_slice_checked (u : HonorDirectory.Data) (bytes : ByteArray) (slices : Array Slice)
    (checked : check u bytes slices = true) (n : Nat) (hn : n < 35) :
    slices.size = 35 ∧ checkSlice u bytes slices[n]! n = true := by
  simp only [check,Bool.and_eq_true,decide_eq_true_eq] at checked
  refine ⟨checked.1.1,?_⟩
  have f := checkSpan_each _ slices.size 0 checked.1.2 n (by rw [checked.1.1]; exact hn)
  simpa only [Nat.zero_add] using f

theorem every_row_in_slice (u : HonorDirectory.Data) (bytes : ByteArray) (slices : Array Slice)
    (checked : check u bytes slices = true) (r : Nat) (hr : r < u.count) :
    ∃ n b, n < 35 ∧ b < slices[n]!.count ∧ slices[n]!.rowBase+b = r ∧ u.layer r = n := by
  simp only [check,Bool.and_eq_true,decide_eq_true_eq] at checked
  have f := checkSpan_each _ u.count 0 checked.2 r hr
  simp only [rowCovered,Nat.zero_add,Bool.and_eq_true,decide_eq_true_eq] at f
  refine ⟨u.layer r,r-slices[u.layer r]!.rowBase,?_,?_,?_,rfl⟩
  · have h := f.1.1; omega
  · omega
  · omega

end Mahjong.DirectorySliceBinding

#print axioms Mahjong.DirectorySliceBinding.slice_facts
#print axioms Mahjong.DirectorySliceBinding.checked_index
#print axioms Mahjong.DirectorySliceBinding.every_slice_checked
#print axioms Mahjong.DirectorySliceBinding.every_row_in_slice
