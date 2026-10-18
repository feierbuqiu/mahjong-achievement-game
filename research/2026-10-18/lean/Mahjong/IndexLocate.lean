import Mahjong.PrefixDirectory

set_option autoImplicit false

namespace Mahjong.IndexLocate
open PrefixDirectory

/-- Index form of the standard upper_bound loop used by Index::block_at. -/
def upperSearch (offset : Nat → Nat) (r first count : Nat) : Nat :=
  if count = 0 then first else
    let half := count/2
    let middle := first+half
    if r < offset middle then upperSearch offset r first half
    else upperSearch offset r (middle+1) (count-half-1)
termination_by count
decreasing_by all_goals omega

theorem upperSearch_cut (offset : Nat → Nat) (r n cut first count : Nat)
    (first_cut : first ≤ cut) (cut_end : cut ≤ first+count) (end_n : first+count ≤ n)
    (cut_rule : ∀ i, i < n → (offset i ≤ r ↔ i < cut)) :
    upperSearch offset r first count = cut := by
  rw [upperSearch]
  split
  · omega
  · rename_i nonzero
    dsimp only
    have inside : first+count/2 < n := by omega
    have rule := cut_rule (first+count/2) inside
    split
    · rename_i before
      have cut_middle : cut ≤ first+count/2 := by
        by_cases small : first+count/2 < cut
        · have h := rule.mpr small; omega
        · omega
      exact upperSearch_cut offset r n cut first (count/2) first_cut cut_middle (by omega) cut_rule
    · rename_i after
      have middle_cut : first+count/2 < cut := rule.mp (by omega)
      exact upperSearch_cut offset r n cut (first+count/2+1) (count-count/2-1)
        (by omega) (by omega) (by omega) cut_rule
termination_by count
decreasing_by all_goals omega

def blockAt (d : Data) (r : Nat) : Nat := upperSearch d.offset r 0 d.blocks - 1

theorem cut_of_interval (d : Data) (checked : check d = true) (b r : Nat)
    (hb : b < d.blocks) (low : d.offset b ≤ r) (high : r < d.offset b+d.size b) :
    ∀ i, i < d.blocks → (d.offset i ≤ r ↔ i < b+1) := by
  intro i hi
  constructor
  · intro below
    by_cases before : i < b+1
    · exact before
    · have sep := separated d checked b i (by omega) hi
      omega
  · intro before
    have mono := offset_mono d checked i b (by omega) hb
    omega

theorem blockAt_interval (d : Data) (checked : check d = true) (b r : Nat)
    (hb : b < d.blocks) (low : d.offset b ≤ r) (high : r < d.offset b+d.size b) :
    blockAt d r = b := by
  have cut := upperSearch_cut d.offset r d.blocks (b+1) 0 d.blocks (by omega) (by omega)
    (by omega) (cut_of_interval d checked b r hb low high)
  simp only [blockAt,cut,Nat.add_sub_cancel]

theorem blockAt_spec (d : Data) (checked : check d = true) (r : Nat) (hr : r < d.total) :
    blockAt d r < d.blocks ∧ d.offset (blockAt d r) ≤ r ∧
      r < d.offset (blockAt d r)+d.size (blockAt d r) := by
  obtain ⟨b,x,hb,hx,eq⟩ := address_surjective d checked r hr
  have low : d.offset b ≤ r := by omega
  have high : r < d.offset b+d.size b := by omega
  rw [blockAt_interval d checked b r hb low high]
  exact ⟨hb,low,high⟩

def locate (d : Data) (r : Nat) : Nat × Nat :=
  let b := blockAt d r
  (b,r-d.offset b)

theorem locate_address (d : Data) (checked : check d = true) (b x : Nat)
    (hb : b < d.blocks) (hx : x < d.size b) :
    locate d (d.offset b+x) = (b,x) := by
  have found := blockAt_interval d checked b (d.offset b+x) hb (by omega) (by omega)
  simp only [locate,found,Nat.add_sub_cancel_left]

theorem address_locate (d : Data) (checked : check d = true) (r : Nat) (hr : r < d.total) :
    (locate d r).1 < d.blocks ∧ (locate d r).2 < d.size (locate d r).1 ∧
      d.offset (locate d r).1+(locate d r).2 = r := by
  have f := blockAt_spec d checked r hr
  simp only [locate]
  exact ⟨f.1,by omega,by omega⟩

end Mahjong.IndexLocate

#print axioms Mahjong.IndexLocate.upperSearch_cut
#print axioms Mahjong.IndexLocate.blockAt_interval
#print axioms Mahjong.IndexLocate.blockAt_spec
#print axioms Mahjong.IndexLocate.locate_address
#print axioms Mahjong.IndexLocate.address_locate
