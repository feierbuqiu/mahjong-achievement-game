import Mahjong.IndexLocate

set_option autoImplicit false

namespace Mahjong.PrefixCursor
open PrefixDirectory

def Valid (d : Data) (p : Nat × Nat) : Prop := p.1 < d.blocks ∧ p.2 < d.size p.1
def address (d : Data) (p : Nat × Nat) : Nat := d.offset p.1+p.2

def advance (d : Data) (p : Nat × Nat) : Option (Nat × Nat) :=
  if p.2+1 = d.size p.1 then
    if p.1+1 < d.blocks then some (p.1+1,0) else none
  else some (p.1,p.2+1)

theorem advance_some (d : Data) (checked : check d = true) (p : Nat × Nat)
    (valid : Valid d p) (interior : address d p+1 < d.total) :
    ∃ q, advance d p = some q ∧ Valid d q ∧ address d q = address d p+1 := by
  rcases p with ⟨b,x⟩
  simp only [Valid] at valid
  have f := row_facts d checked b valid.1
  simp only [advance]
  split
  · rename_i endBlock
    have next : b+1 < d.blocks := by
      by_cases h : b+1 < d.blocks
      · exact h
      · have last := f.last (by have h := valid.1; omega)
        simp only [address] at interior
        omega
    have g := row_facts d checked (b+1) next
    have offset := f.next next
    simp only [next,↓reduceIte]
    exact ⟨(b+1,0),rfl,⟨next,g.positive⟩,by simp only [address,Nat.add_zero]; omega⟩
  · rename_i notEnd
    exact ⟨(b,x+1),rfl,⟨valid.1,by dsimp only; have h := valid.2; omega⟩,by simp only [address,Nat.add_assoc]⟩

theorem advance_none_iff (d : Data) (checked : check d = true) (p : Nat × Nat)
    (valid : Valid d p) : advance d p = none ↔ address d p+1 = d.total := by
  rcases p with ⟨b,x⟩
  simp only [Valid] at valid
  have f := row_facts d checked b valid.1
  have bound := f.bound
  constructor
  · intro h
    simp only [advance] at h
    split at h
    · rename_i endBlock
      split at h
      · contradiction
      · rename_i notNext
        have last := f.last (by have h := valid.1; omega)
        simp only [address]
        omega
    · contradiction
  · intro final
    have endBlock : x+1 = d.size b := by
      simp only [address] at final
      have h := valid.2
      omega
    have last : ¬ b+1 < d.blocks := by
      intro next
      have g := row_facts d checked (b+1) next
      have gb := g.bound
      have gp := g.positive
      have offset := f.next next
      simp only [address] at final
      omega
    simp only [advance,endBlock,last,↓reduceIte]

theorem advance_is_locate_next (d : Data) (checked : check d = true) (r : Nat)
    (interior : r+1 < d.total) :
    advance d (IndexLocate.locate d r) = some (IndexLocate.locate d (r+1)) := by
  have p := IndexLocate.address_locate d checked r (by omega)
  obtain ⟨q,eq,vq,next⟩ := advance_some d checked (IndexLocate.locate d r) ⟨p.1,p.2.1⟩
    (by simp only [address]; rw [p.2.2]; exact interior)
  have found := IndexLocate.locate_address d checked q.1 q.2 vq.1 vq.2
  have nr : d.offset q.1+q.2 = r+1 := by
    simpa only [address,p.2.2] using next
  rw [nr] at found
  have eta : (q.1,q.2) = q := by cases q; rfl
  rw [eta] at found
  rw [found]
  exact eq

end Mahjong.PrefixCursor

#print axioms Mahjong.PrefixCursor.advance_some
#print axioms Mahjong.PrefixCursor.advance_none_iff
#print axioms Mahjong.PrefixCursor.advance_is_locate_next
