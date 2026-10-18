import Mahjong.GroupInventory

set_option autoImplicit false

namespace Mahjong.GroupCandidates
open GroupInventory PruningAlgebra CanonicalInventory

abbrev Triple := Nat × Nat × Nat
def allTriples (n : Nat) : List Triple :=
  (List.range n).flatMap (fun a => (List.range n).flatMap (fun b => (List.range n).map (fun c => (a,b,c))))

theorem mem_allTriples (n a b c : Nat) : (a,b,c) ∈ allTriples n ↔ a < n ∧ b < n ∧ c < n := by
  simp only [allTriples, List.mem_flatMap, List.mem_range, List.mem_map, Prod.mk.injEq]
  constructor
  · rintro ⟨a',ha,b',hb,c',hc,ea,eb,ec⟩
    subst a'; subst b'; subst c'
    exact ⟨ha,hb,hc⟩
  · rintro ⟨ha,hb,hc⟩
    exact ⟨a,ha,b,hb,c,hc,rfl,rfl,rfl⟩

def three (d : Data) (t : Triple) : Label := join (join (d.label t.1) (d.label t.2.1)) (d.label t.2.2)

def candidates (d : Data) : List Triple :=
  (allTriples d.groups).filter (fun t => decide (t.1 ≤ t.2.1 ∧ t.2.1 ≤ t.2.2 ∧
    passesPartial (join (d.label t.1) (d.label t.2.1)) ∧ passesPartial (three d t)))

instance (a : Label) : Decidable (fullSafe a) := by unfold fullSafe; infer_instance

def bucket (d : Data) (h : Label) (n : Nat) : List Triple :=
  (candidates d).filter (fun t => decide (fullSafe (join (three d t) h) ∧ (join (three d t) h).tiles = n))

/-- The nested range/early-filter/bucket-filter specification includes exactly
all eligible group triples. No previously counted total is used. -/
theorem mem_bucket (d : Data) (h : Label) (n a b c : Nat) :
    (a,b,c) ∈ bucket d h n ↔ a < d.groups ∧ b < d.groups ∧ c < d.groups ∧
      a ≤ b ∧ b ≤ c ∧ fullSafe (join (three d (a,b,c)) h) ∧ (join (three d (a,b,c)) h).tiles = n := by
  simp only [bucket, candidates, List.mem_filter, mem_allTriples, decide_eq_true_eq]
  constructor
  · rintro ⟨⟨⟨ha,hb,hc⟩,ab,bc,_,_⟩,safe,tiles⟩
    exact ⟨ha,hb,hc,ab,bc,safe,tiles⟩
  · rintro ⟨ha,hb,hc,ab,bc,safe,tiles⟩
    have early := four_block_pruning_complete (d.label a) (d.label b) (d.label c) h safe
    exact ⟨⟨⟨ha,hb,hc⟩,ab,bc,early.2.2.2.2.1,early.2.2.2.2.2⟩,safe,tiles⟩

def Coordinates (d : Data) (a b c x y z : Nat) : Prop :=
  x < d.size a ∧ y < d.size b ∧ z < d.size c ∧ (a = b → x ≤ y) ∧ (b = c → y ≤ z)

theorem member_label (d : Data) (checked : GroupInventory.Checked d) (i : Nat) (hi : i < d.count) :
    d.raw (d.retained i) = d.label (d.group i) := by
  have row := member_facts d checked i hi
  simpa only [row.code] using row.label

theorem member_coordinates (d : Data) (checked : GroupInventory.Checked d) (i j k : Nat)
    (hi : i < d.count) (hj : j < d.count) (hk : k < d.count) (ij : i ≤ j) (jk : j ≤ k) :
    Coordinates d (d.group i) (d.group j) (d.group k) (d.member i) (d.member j) (d.member k) := by
  have a := member_facts d checked i hi
  have b := member_facts d checked j hj
  have c := member_facts d checked k hk
  refine ⟨a.member,b.member,c.member,?_,?_⟩
  · intro eq
    have ai := a.offset
    have bj := b.offset
    rw [eq] at ai
    omega
  · intro eq
    have bj := b.offset
    have ck := c.offset
    rw [eq] at bj
    omega

theorem coordinate_order (d : Data) (checked : GroupInventory.Checked d)
    (a b c x y z : Nat) (ha : a < d.groups) (hb : b < d.groups) (hc : c < d.groups)
    (ab : a ≤ b) (bc : b ≤ c) (coords : Coordinates d a b c x y z) :
    d.first a + x ≤ d.first b + y ∧ d.first b + y ≤ d.first c + z := by
  constructor
  · by_cases eq : a = b
    · have xy := coords.2.2.2.1 eq
      rw [eq]
      omega
    · have sep := separated d checked a b (by omega) hb
      have hx := coords.1
      omega
  · by_cases eq : b = c
    · have yz := coords.2.2.2.2 eq
      rw [eq]
      omega
    · have sep := separated d checked b c (by omega) hc
      have hy := coords.2.1
      omega

theorem safe_members_in_bucket (d : Data) (checked : GroupInventory.Checked d) (h : Label) (n i j k : Nat)
    (hi : i < d.count) (hj : j < d.count) (hk : k < d.count) (ij : i ≤ j) (jk : j ≤ k)
    (safe : fullSafe (join (join (join (d.raw (d.retained i)) (d.raw (d.retained j))) (d.raw (d.retained k))) h))
    (tiles : (join (join (join (d.raw (d.retained i)) (d.raw (d.retained j))) (d.raw (d.retained k))) h).tiles = n) :
    (d.group i,d.group j,d.group k) ∈ bucket d h n ∧
    Coordinates d (d.group i) (d.group j) (d.group k) (d.member i) (d.member j) (d.member k) := by
  rw [member_label d checked i hi, member_label d checked j hj, member_label d checked k hk] at safe tiles
  refine ⟨?_,member_coordinates d checked i j k hi hj hk ij jk⟩
  exact (mem_bucket d h n _ _ _).mpr ⟨(member_facts d checked i hi).group,
    (member_facts d checked j hj).group,(member_facts d checked k hk).group,
    group_monotone d checked i j hi hj ij,group_monotone d checked j k hj hk jk,safe,tiles⟩

theorem bucket_coordinates_safe (d : Data) (checked : GroupInventory.Checked d) (h : Label) (n a b c x y z : Nat)
    (present : (a,b,c) ∈ bucket d h n) (coords : Coordinates d a b c x y z) :
    fullSafe (join
      (join (join (d.raw (d.retained (d.first a+x))) (d.raw (d.retained (d.first b+y))))
        (d.raw (d.retained (d.first c+z)))) h) := by
  have facts := (mem_bucket d h n a b c).mp present
  rw [group_label_at_coordinate d checked a x facts.1 coords.1,
    group_label_at_coordinate d checked b y facts.2.1 coords.2.1,
    group_label_at_coordinate d checked c z facts.2.2.1 coords.2.2.1]
  exact facts.2.2.2.2.2.1

end Mahjong.GroupCandidates

#print axioms Mahjong.GroupCandidates.mem_bucket
#print axioms Mahjong.GroupCandidates.member_coordinates
#print axioms Mahjong.GroupCandidates.safe_members_in_bucket
#print axioms Mahjong.GroupCandidates.bucket_coordinates_safe
