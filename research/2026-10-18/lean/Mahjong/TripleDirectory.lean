import Mahjong.WeightedBlocks

set_option autoImplicit false

namespace Mahjong.TripleDirectory
open PruningAlgebra GroupCandidates CanonicalInventory

def Eligible (d : GroupInventory.Data) (t : Triple) : Prop :=
  t.1 < d.groups ∧ t.2.1 < d.groups ∧ t.2.2 < d.groups ∧
  t.1 ≤ t.2.1 ∧ t.2.1 ≤ t.2.2 ∧
  passesPartial (join (d.label t.1) (d.label t.2.1)) ∧ passesPartial (three d t)

instance (d : GroupInventory.Data) (t : Triple) : Decidable (Eligible d t) := by
  unfold Eligible
  infer_instance

structure Data where
  count : Nat
  key : Nat → Triple
  label : Nat → Label
  lookup : Triple → Nat

def checkLookup (t : Data) (key : Triple) : Bool :=
  let i := t.lookup key
  decide (i < t.count) && decide (t.key i = key)

def checkRow (d : GroupInventory.Data) (t : Data) (i : Nat) : Bool :=
  decide (Eligible d (t.key i)) && decide (t.label i = three d (t.key i)) &&
  decide (t.lookup (t.key i) = i)

def checkC (d : GroupInventory.Data) (t : Data) (a b c : Nat) : Bool :=
  if passesPartial (three d (a,b,c)) then checkLookup t (a,b,c) else true

def checkB (d : GroupInventory.Data) (t : Data) (a b : Nat) : Bool :=
  if passesPartial (join (d.label a) (d.label b)) then
    checkSpan (checkC d t a b) b (d.groups-b) else true

def checkA (d : GroupInventory.Data) (t : Data) (a : Nat) : Bool :=
  checkSpan (checkB d t a) a (d.groups-a)

def Checked (d : GroupInventory.Data) (t : Data) : Prop :=
  checkSpan (checkRow d t) 0 t.count = true ∧ checkSpan (checkA d t) 0 d.groups = true

theorem row_facts (d : GroupInventory.Data) (t : Data) (checked : Checked d t) (i : Nat) (hi : i < t.count) :
    Eligible d (t.key i) ∧ t.label i = three d (t.key i) ∧ t.lookup (t.key i) = i := by
  have h := checkSpan_each (checkRow d t) t.count 0 checked.1 i hi
  simpa only [Nat.zero_add,checkRow,Bool.and_eq_true,decide_eq_true_eq,and_assoc] using h

theorem complete_facts (d : GroupInventory.Data) (t : Data) (checked : Checked d t)
    (a b c : Nat) (eligible : Eligible d (a,b,c)) : t.lookup (a,b,c) < t.count ∧ t.key (t.lookup (a,b,c)) = (a,b,c) := by
  rcases eligible with ⟨ha,hb,hc,ab,bc,two,tri⟩
  dsimp only at ha hb hc ab bc two tri
  have ra := checkSpan_each (checkA d t) d.groups 0 checked.2 a ha
  simp only [Nat.zero_add,checkA] at ra
  have rb := checkSpan_each (checkB d t a) (d.groups-a) a ra (b-a) (by omega)
  have abb : a+(b-a)=b := by omega
  rw [abb] at rb
  simp only [checkB,two,↓reduceIte] at rb
  have rc := checkSpan_each (checkC d t a b) (d.groups-b) b rb (c-b) (by omega)
  have bcc : b+(c-b)=c := by omega
  rw [bcc] at rc
  simpa only [checkC,tri,↓reduceIte,checkLookup,Bool.and_eq_true,decide_eq_true_eq] using rc

theorem eligible_iff_candidate (d : GroupInventory.Data) (a b c : Nat) :
    Eligible d (a,b,c) ↔ (a,b,c) ∈ candidates d := by
  simp only [candidates,List.mem_filter,mem_allTriples,decide_eq_true_eq,Eligible]
  simp only [and_assoc]

theorem represented_iff_candidate (d : GroupInventory.Data) (t : Data) (checked : Checked d t)
    (a b c : Nat) : (∃ i, i < t.count ∧ t.key i = (a,b,c)) ↔ (a,b,c) ∈ candidates d := by
  constructor
  · rintro ⟨i,hi,eq⟩
    have row := (row_facts d t checked i hi).1
    rw [eq] at row
    exact (eligible_iff_candidate d a b c).mp row
  · intro present
    have facts := complete_facts d t checked a b c ((eligible_iff_candidate d a b c).mpr present)
    exact ⟨t.lookup (a,b,c),facts⟩

theorem unique_rows (d : GroupInventory.Data) (t : Data) (checked : Checked d t)
    (i j : Nat) (hi : i < t.count) (hj : j < t.count) (eq : t.key i = t.key j) : i = j := by
  have x := (row_facts d t checked i hi).2.2
  have y := (row_facts d t checked j hj).2.2
  rw [eq] at x
  omega

def coordinates (bytes : ByteArray) (i : Nat) : Triple :=
  (read32 bytes (12*i),read32 bytes (12*i+4),read32 bytes (12*i+8))

def before (a b : Triple) : Bool :=
  decide (a.1 < b.1) || (decide (a.1 = b.1) &&
    (decide (a.2.1 < b.2.1) || (decide (a.2.1 = b.2.1) && decide (a.2.2 < b.2.2))))

/-- A fallible lookup. Its answers, including completeness, are checked above. -/
def search (bytes : ByteArray) (count : Nat) : Nat → Nat → Nat → Triple → Nat
  | 0,_,_,_ => count
  | fuel+1,lo,hi,key =>
    if lo ≥ hi then count else
      let mid := (lo+hi)/2
      let value := coordinates bytes mid
      if value = key then mid
      else if before value key then search bytes count fuel (mid+1) hi key
      else search bytes count fuel lo mid key

def candidate (bytes labels : ByteArray) : Data where
  count := bytes.size/12
  key := coordinates bytes
  label := PruningData.rawLabel labels
  lookup := search bytes (bytes.size/12) 32 0 (bytes.size/12)

end Mahjong.TripleDirectory

#print axioms Mahjong.TripleDirectory.row_facts
#print axioms Mahjong.TripleDirectory.complete_facts
#print axioms Mahjong.TripleDirectory.represented_iff_candidate
#print axioms Mahjong.TripleDirectory.unique_rows
