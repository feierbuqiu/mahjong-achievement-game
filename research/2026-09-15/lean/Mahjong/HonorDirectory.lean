import Mahjong.TripleDirectory

set_option autoImplicit false

namespace Mahjong.HonorDirectory
open PruningAlgebra CanonicalInventory GroupCandidates

structure Data where
  count : Nat
  tid : Nat → Nat
  layer : Nat → Nat
  width : Nat → Nat
  lookup : Nat → Nat

def checkRow (d : GroupInventory.Data) (t : TripleDirectory.Data) (h : Label) (u : Data) (r : Nat) : Bool :=
  let i := u.tid r
  let key := t.key i
  let label := join (t.label i) h
  decide (i < t.count) && decide (fullSafe label) && decide (u.layer r = label.tiles) &&
  decide (u.width r = WeightedBlocks.size d key.1 key.2.1 key.2.2) && decide (u.lookup i = r)

def checkCandidate (t : TripleDirectory.Data) (h : Label) (u : Data) (i : Nat) : Bool :=
  let label := join (t.label i) h
  if fullSafe label then
    let r := u.lookup i
    decide (r < u.count) && decide (u.tid r = i) && decide (u.layer r = label.tiles)
  else true

def Checked (d : GroupInventory.Data) (t : TripleDirectory.Data) (h : Label) (u : Data) : Prop :=
  checkSpan (checkRow d t h u) 0 u.count = true ∧ checkSpan (checkCandidate t h u) 0 t.count = true

structure Facts (d : GroupInventory.Data) (t : TripleDirectory.Data) (h : Label) (u : Data) (r : Nat) : Prop where
  bound : u.tid r < t.count
  safe : fullSafe (join (t.label (u.tid r)) h)
  layer : u.layer r = (join (t.label (u.tid r)) h).tiles
  width : u.width r = WeightedBlocks.size d (t.key (u.tid r)).1 (t.key (u.tid r)).2.1 (t.key (u.tid r)).2.2
  inverse : u.lookup (u.tid r) = r

theorem row_facts (d : GroupInventory.Data) (t : TripleDirectory.Data) (h : Label) (u : Data)
    (checked : Checked d t h u) (r : Nat) (hr : r < u.count) : Facts d t h u r := by
  have f := checkSpan_each (checkRow d t h u) u.count 0 checked.1 r hr
  simp only [Nat.zero_add,checkRow,Bool.and_eq_true,decide_eq_true_eq] at f
  exact ⟨f.1.1.1.1,f.1.1.1.2,f.1.1.2,f.1.2,f.2⟩

theorem candidate_facts (d : GroupInventory.Data) (t : TripleDirectory.Data) (h : Label) (u : Data)
    (checked : Checked d t h u) (i : Nat) (hi : i < t.count) (safe : fullSafe (join (t.label i) h)) :
    u.lookup i < u.count ∧ u.tid (u.lookup i) = i ∧ u.layer (u.lookup i) = (join (t.label i) h).tiles := by
  have f := checkSpan_each (checkCandidate t h u) t.count 0 checked.2 i hi
  simpa only [Nat.zero_add,checkCandidate,safe,↓reduceIte,Bool.and_eq_true,decide_eq_true_eq,and_assoc] using f

/-- Actual rows occur in exactly the buckets specified by the original SAFE filter. -/
theorem actual_iff_bucket (d : GroupInventory.Data) (t : TripleDirectory.Data) (h : Label) (u : Data)
    (triples : TripleDirectory.Checked d t) (checked : Checked d t h u) (a b c n : Nat) :
    (∃ r, r < u.count ∧ t.key (u.tid r) = (a,b,c) ∧ u.layer r = n) ↔ (a,b,c) ∈ bucket d h n := by
  constructor
  · rintro ⟨r,hr,key,layer⟩
    have row := row_facts d t h u checked r hr
    have triple := TripleDirectory.row_facts d t triples (u.tid r) row.bound
    have eligible := triple.1
    have semantic := triple.2.1
    rw [key] at eligible semantic
    have safe := row.safe
    have tiles := row.layer
    rw [semantic] at safe tiles
    rcases eligible with ⟨ha,hb,hc,ab,bc,_,_⟩
    exact (mem_bucket d h n a b c).mpr ⟨ha,hb,hc,ab,bc,safe,by omega⟩
  · intro present
    have f := (mem_bucket d h n a b c).mp present
    rcases f with ⟨ha,hb,hc,ab,bc,safe,tiles⟩
    have early := four_block_pruning_complete (d.label a) (d.label b) (d.label c) h safe
    have eligible : TripleDirectory.Eligible d (a,b,c) :=
      ⟨ha,hb,hc,ab,bc,early.2.2.2.2.1,early.2.2.2.2.2⟩
    have found := TripleDirectory.complete_facts d t triples a b c eligible
    have semantic := (TripleDirectory.row_facts d t triples _ found.1).2.1
    rw [found.2] at semantic
    have safe' : fullSafe (join (t.label (t.lookup (a,b,c))) h) := by rwa [semantic]
    have row := candidate_facts d t h u checked (t.lookup (a,b,c)) found.1 safe'
    refine ⟨u.lookup (t.lookup (a,b,c)),row.1,?_,?_⟩
    · rw [row.2.1,found.2]
    · rw [row.2.2,semantic]
      exact tiles

theorem unique_rows (d : GroupInventory.Data) (t : TripleDirectory.Data) (h : Label) (u : Data)
    (triples : TripleDirectory.Checked d t) (checked : Checked d t h u) (r s : Nat)
    (hr : r < u.count) (hs : s < u.count) (same : t.key (u.tid r) = t.key (u.tid s)) : r = s := by
  have x := row_facts d t h u checked r hr
  have y := row_facts d t h u checked s hs
  have tids := TripleDirectory.unique_rows d t triples _ _ x.bound y.bound same
  have inv := x.inverse
  rw [tids,y.inverse] at inv
  omega

structure Entry where
  tid : Nat
  layer : Nat
  width : Nat
  deriving Inhabited

def candidate (rows : Array Entry) (lookup : Array Nat) : Data where
  count := rows.size
  tid := fun r => (rows[r]!).tid
  layer := fun r => (rows[r]!).layer
  width := fun r => (rows[r]!).width
  lookup := fun i => lookup[i]!

end Mahjong.HonorDirectory

#print axioms Mahjong.HonorDirectory.row_facts
#print axioms Mahjong.HonorDirectory.candidate_facts
#print axioms Mahjong.HonorDirectory.actual_iff_bucket
#print axioms Mahjong.HonorDirectory.unique_rows
