import Mahjong.GuardedIndexAccess
import Mahjong.BucketIndex
import Mahjong.IndexInputBounds

set_option autoImplicit false

namespace Mahjong.LegacyIndexRefinement
open CanonicalInventory Ranking IndexSearch

theorem read4 (bytes : ByteArray) (offset : Nat) :
    BucketIndex.readLE bytes offset 4 = read32 bytes offset := by
  simp [BucketIndex.readLE,List.range_succ,read32,Nat.mul_add,Nat.add_mul,
    Nat.add_assoc,Nat.mul_assoc,Nat.add_comm,Nat.add_left_comm]

theorem read8 (bytes : ByteArray) (offset : Nat) :
    BucketIndex.readLE bytes offset 8 = PrefixData.read64 bytes offset := by
  simp [BucketIndex.readLE,List.range_succ,PrefixData.read64,read32,Nat.mul_add,Nat.add_mul,
    Nat.add_assoc,Nat.mul_assoc,Nat.add_comm,Nat.add_left_comm] <;> omega

/-- The old bounded binary search cannot exhaust its fuel on a 64-bit
interval. This is a theorem about the actual BucketIndex implementation. -/
theorem search_eq (fuel : Nat) (f : Nat → Nat) (r lo hi : Nat)
    (ordered : lo ≤ hi) (enough : hi-lo ≤ 2^fuel) :
    BucketIndex.floorSearch f r fuel lo hi = bracketSearch f r lo hi := by
  induction fuel generalizing lo hi with
  | zero =>
    have stop : ¬ lo+1 < hi := by simp only [Nat.pow_zero] at enough; omega
    rw [BucketIndex.floorSearch,bracketSearch,if_neg stop]
  | succ fuel ih =>
    rw [BucketIndex.floorSearch,bracketSearch]
    by_cases span : lo+1 < hi
    · have notStop : ¬ hi ≤ lo+1 := by omega
      simp only [if_pos span,if_neg notStop]
      have power : 2^(fuel+1) = 2^fuel*2 := Nat.pow_succ 2 fuel
      rw [power] at enough
      by_cases middle : f ((lo+hi)/2) ≤ r
      · simp only [if_pos middle]
        exact ih _ _ (by omega) (by omega)
      · simp only [if_neg middle]
        exact ih _ _ (by omega) (by omega)
    · have stop : hi ≤ lo+1 := by omega
      simp only [if_pos stop,if_neg span]

theorem search_congr (fuel : Nat) (f g : Nat → Nat) (r lo hi : Nat)
    (equal : ∀ i, lo ≤ i → i < hi → f i = g i) :
    BucketIndex.floorSearch f r fuel lo hi = BucketIndex.floorSearch g r fuel lo hi := by
  induction fuel generalizing lo hi with
  | zero => rfl
  | succ fuel ih =>
    rw [BucketIndex.floorSearch,BucketIndex.floorSearch]
    by_cases stop : hi ≤ lo+1
    · simp only [if_pos stop]
    · simp only [if_neg stop]
      have mid := equal ((lo+hi)/2) (by omega) (by omega)
      rw [mid]
      split
      · apply ih
        intro i lower upper
        exact equal i (by omega) upper
      · apply ih
        intro i lower upper
        exact equal i lower (by omega)

theorem search_pair (r n : Nat) (limit : n ≤ 3403) (bound : r < c2 n) :
    BucketIndex.floorSearch BucketIndex.choose2 r 32 0 n = pairFloor r 0 := by
  have same : BucketIndex.choose2 = c2 := rfl
  rw [same,search_eq 32 c2 r 0 n (by omega) (by omega)]
  have positive : 0 < n := by
    by_cases z : n = 0
    · simp [z,c2] at bound
    · omega
  have f := bracketSearch_spec c2 r 0 n positive (by simp [c2]) bound
  have q := pairFloor_spec r 0
  by_cases less : bracketSearch c2 r 0 n < pairFloor r 0
  · have mono := c2_mono (a := bracketSearch c2 r 0 n+1) (b := pairFloor r 0) (by omega)
    omega
  · by_cases more : pairFloor r 0 < bracketSearch c2 r 0 n
    · have mono := c2_mono (a := pairFloor r 0+1) (b := bracketSearch c2 r 0 n) (by omega)
      omega
    · omega

theorem search_triple (r n : Nat) (limit : n ≤ 3403) :
    BucketIndex.floorSearch BucketIndex.choose3 r 32 0 n = tripleFloor r n := by
  exact search_eq 32 c3 r 0 n (by omega) (by omega)

theorem search_cut (fuel : Nat) (f : Nat → Nat) (r lo hi b : Nat)
    (lower : lo ≤ b) (upper : b < hi) (enough : hi-lo ≤ 2^fuel)
    (cut : ∀ i, lo ≤ i → i < hi → (f i ≤ r ↔ i ≤ b)) :
    BucketIndex.floorSearch f r fuel lo hi = b := by
  induction fuel generalizing lo hi with
  | zero =>
    simp only [Nat.pow_zero] at enough
    have same : lo = b := by omega
    simp only [BucketIndex.floorSearch,same]
  | succ fuel ih =>
    rw [BucketIndex.floorSearch]
    by_cases stop : hi ≤ lo+1
    · have same : lo = b := by omega
      rw [if_pos stop]
      exact same
    · simp only [if_neg stop]
      have power : 2^(fuel+1) = 2^fuel*2 := Nat.pow_succ 2 fuel
      rw [power] at enough
      have rule := cut ((lo+hi)/2) (by omega) (by omega)
      by_cases middle : f ((lo+hi)/2) ≤ r
      · simp only [if_pos middle]
        apply ih _ _ (rule.mp middle) upper (by omega)
        intro i low high
        exact cut i (by omega) high
      · simp only [if_neg middle]
        have above : b < (lo+hi)/2 := by
          have h : ¬ (lo+hi)/2 ≤ b := fun h => middle (rule.mpr h)
          omega
        apply ih _ _ lower above (by omega)
        intro i low high
        exact cut i low (by omega)

abbrev groups (d : BucketIndex.Data) (raw members : ByteArray) : GroupInventory.Data :=
  GroupInventory.candidate d.numeric d.groups raw members

abbrev model (d : BucketIndex.Data) (raw members : ByteArray) : IndexOperations.Data :=
  GuardedIndexAccess.model (groups d raw members) d.directory d.size

theorem blockAt_eq (d : BucketIndex.Data) (raw members : ByteArray)
    (checked : IndexOperations.Checked (model d raw members))
    (limits : WordLimits.bucketFits (model d raw members).directory.blocks d.size = true)
    (r : Nat) (bound : r < d.size) :
    BucketIndex.blockAt d r = IndexLocate.blockAt (model d raw members).directory r := by
  let p := (model d raw members).directory
  let b := IndexLocate.blockAt p r
  have found := IndexLocate.blockAt_spec p checked.intervals r bound
  have cut := IndexLocate.cut_of_interval p checked.intervals b r found.1 found.2.1 found.2.2
  have size := (WordLimits.bucket_facts _ _ limits).1
  have sizep : p.blocks < 2^32 := size
  have result := search_cut 64 (fun k => BucketIndex.field d k 0 8) r 0 p.blocks b
    (by omega) found.1 (by omega) (by
      intro i _ hi
      have eq : BucketIndex.field d i 0 8 = p.offset i := by
        simp only [BucketIndex.field,read8,p,model,GuardedIndexAccess.model,Nat.add_zero,Nat.mul_comm]
      rw [eq,cut i hi]
      omega)
  exact result

def legacyWithin (g : GroupInventory.Data) (a b c r : Nat) : GroupCandidates.Triple :=
  let na := g.size a
  let nb := g.size b
  let nc := g.size c
  if a = c then
    let z := BucketIndex.floorSearch BucketIndex.choose3 r 32 0 na
    let rem := r-BucketIndex.choose3 z
    let y := BucketIndex.floorSearch BucketIndex.choose2 rem 32 0 na
    (rem-BucketIndex.choose2 y,y,z)
  else if a = b then
    let rem := r%BucketIndex.choose2 na
    let y := BucketIndex.floorSearch BucketIndex.choose2 rem 32 0 na
    (rem-BucketIndex.choose2 y,y,r/BucketIndex.choose2 na)
  else if b = c then
    let rem := r/na
    let z := BucketIndex.floorSearch BucketIndex.choose2 rem 32 0 nc
    (r%na,rem-BucketIndex.choose2 z,z)
  else (r%na,(r/na)%nb,(r/na)/nb)

theorem within_eq (g : GroupInventory.Data) (checked : GroupInventory.Checked g)
    (fits : WordLimits.GroupsFit g) (a b c r : Nat)
    (ha : a < g.groups) (hb : b < g.groups) (hc : c < g.groups)
    (bound : r < WeightedBlocks.size g a b c) :
    legacyWithin g a b c r = IndexDecoder.decode (fun _ => 0) g a b c r := by
  have sa := fits.2.2 a ha
  have sb := fits.2.2 b hb
  have sc := fits.2.2 c hc
  by_cases ac : a = c
  · simp only [legacyWithin,IndexDecoder.decode,if_pos ac]
    rw [search_triple r (g.size a) sa.2.1]
    have rem : r-c3 (tripleFloor r (g.size a)) < c2 (g.size a) := by
      have bound' : r < c3 (g.size a) := by
        simpa only [WeightedBlocks.size,if_pos ac] using bound
      have f := tripleFloor_spec r (g.size a) bound'
      have step := c3_succ (tripleFloor r (g.size a))
      have mono := c2_mono (a:=tripleFloor r (g.size a)+1) (b:=g.size a) (by omega)
      omega
    rw [search_pair (r-BucketIndex.choose3 (tripleFloor r (g.size a))) _ sa.2.1 rem]
    rfl
  · by_cases ab : a = b
    · simp only [legacyWithin,IndexDecoder.decode,if_neg ac,if_pos ab]
      have pos := WeightedBlocks.c2_positive (g.size a) sa.1
      rw [search_pair (r%BucketIndex.choose2 (g.size a)) _ sa.2.1 (Nat.mod_lt r pos)]
      rfl
    · by_cases bc : b = c
      · simp only [legacyWithin,IndexDecoder.decode,if_neg ac,if_neg ab,if_pos bc]
        have rem : r/g.size a < c2 (g.size c) := by
          have bound' : r < g.size a*c2 (g.size c) := by
            simpa only [WeightedBlocks.size,if_neg ac,if_neg ab,if_pos bc,bc,↓reduceIte] using bound
          exact (Nat.div_lt_iff_lt_mul sa.1).mpr (by simpa [Nat.mul_comm] using bound')
        rw [search_pair _ _ sc.2.1 rem]
        rfl
      · simp only [legacyWithin,IndexDecoder.decode,if_neg ac,if_neg ab,if_neg bc,IndexDecoder.distinct]

theorem decodeIds_form (d : BucketIndex.Data) (raw members : ByteArray) (r : Nat) :
    BucketIndex.decodeIds d r =
      let b := BucketIndex.blockAt d r
      let key := (model d raw members).key b
      AbsoluteCursor.absolute (groups d raw members) key.1 key.2.1 key.2.2
        (legacyWithin (groups d raw members) key.1 key.2.1 key.2.2
          (r-(model d raw members).directory.offset b)) := by
  have first : BucketIndex.groupFirst d = (groups d raw members).first := by
    funext g
    simp only [BucketIndex.groupFirst,read4,groups,GroupInventory.candidate,Nat.mul_comm]
  have size : BucketIndex.groupSize d = (groups d raw members).size := by
    funext g
    simp only [BucketIndex.groupSize,read4,groups,GroupInventory.candidate,Nat.mul_comm]
  have key : (model d raw members).key (BucketIndex.blockAt d r) =
      (BucketIndex.field d (BucketIndex.blockAt d r) 16 4,
       BucketIndex.field d (BucketIndex.blockAt d r) 20 4,
       BucketIndex.field d (BucketIndex.blockAt d r) 24 4) := by
    simp only [model,GuardedIndexAccess.model,BucketIndex.field,read4,Nat.mul_comm]
  have offset : (model d raw members).directory.offset (BucketIndex.blockAt d r) =
      BucketIndex.field d (BucketIndex.blockAt d r) 0 8 := by
    simp only [model,GuardedIndexAccess.model,BucketIndex.field,read8,Nat.add_zero,Nat.mul_comm]
  simp only [key,offset,BucketIndex.decodeIds,Id.run,first,size,legacyWithin,AbsoluteCursor.absolute]
  rfl

theorem decodeIds_eq (d : BucketIndex.Data) (raw members : ByteArray)
    (checked : IndexOperations.Checked (model d raw members))
    (fits : WordLimits.GroupsFit (groups d raw members))
    (limits : WordLimits.bucketFits (model d raw members).directory.blocks d.size = true)
    (r : Nat) (bound : r < d.size) :
    BucketIndex.decodeIds d r =
      IndexOperations.absolute (model d raw members)
        (IndexOperations.unrank (fun _ => 0) (model d raw members) r) := by
  rw [decodeIds_form d raw members r,blockAt_eq d raw members checked limits r bound]
  let m := model d raw members
  let b := IndexLocate.blockAt m.directory r
  have located := IndexLocate.address_locate m.directory checked.intervals r bound
  have row := checked.row b located.1
  have small : r-m.directory.offset b < WeightedBlocks.size m.groups (m.key b).1 (m.key b).2.1 (m.key b).2.2 := by
    rw [← row.2.2.2.2.2]
    exact located.2.1
  have decoded := within_eq m.groups checked.groups fits (m.key b).1 (m.key b).2.1 (m.key b).2.2
    (r-m.directory.offset b) row.1 row.2.1 row.2.2.1 small
  change AbsoluteCursor.absolute m.groups (m.key b).1 (m.key b).2.1 (m.key b).2.2
      (legacyWithin m.groups (m.key b).1 (m.key b).2.1 (m.key b).2.2 (r-m.directory.offset b)) =
    AbsoluteCursor.absolute m.groups (m.key b).1 (m.key b).2.1 (m.key b).2.2
      (IndexDecoder.decode (fun _ => 0) m.groups (m.key b).1 (m.key b).2.1 (m.key b).2.2
        (r-m.directory.offset b))
  rw [decoded]

def codes (d : BucketIndex.Data) (raw members : ByteArray) (ids : GroupCandidates.Triple) : PackedRules.Packed :=
  ⟨(groups d raw members).retained ids.1,(groups d raw members).retained ids.2.1,
    (groups d raw members).retained ids.2.2,d.honorCode⟩

theorem unrank_eq (d : BucketIndex.Data) (raw members : ByteArray)
    (checked : IndexOperations.Checked (model d raw members))
    (fits : WordLimits.GroupsFit (groups d raw members))
    (limits : WordLimits.bucketFits (model d raw members).directory.blocks d.size = true)
    (r : Nat) (bound : r < d.size) :
    BucketIndex.unrank d r = codes d raw members
      (IndexOperations.absolute (model d raw members)
        (IndexOperations.unrank (fun _ => 0) (model d raw members) r)) := by
  have decoded := IndexOperations.rank_unrank (fun _ => 0) (model d raw members) checked r bound
  have ids := IndexOperations.absolute_lookup (model d raw members) checked _ decoded.1
  have a := (GroupInventory.member_facts (groups d raw members) checked.groups _ ids.1).code
  have b := (GroupInventory.member_facts (groups d raw members) checked.groups _ ids.2.1).code
  have c := (GroupInventory.member_facts (groups d raw members) checked.groups _ ids.2.2.1).code
  unfold BucketIndex.unrank
  rw [decodeIds_eq d raw members checked fits limits r bound]
  simp only [codes,read4]
  simp only [PackedRules.Packed.mk.injEq]
  constructor
  · simpa only [groups,GroupInventory.candidate,Nat.mul_comm] using a
  constructor
  · simpa only [groups,GroupInventory.candidate,Nat.mul_comm] using b
  exact ⟨by simpa only [groups,GroupInventory.candidate,Nat.mul_comm] using c,True.intro⟩

/-- Actual legacy target inverse, without executing it in the checked path. -/
theorem guarded_legacy_inverse (d : BucketIndex.Data) (raw members : ByteArray)
    (checked : IndexOperations.Checked (model d raw members))
    (fits : WordLimits.GroupsFit (groups d raw members))
    (limits : WordLimits.bucketFits (model d raw members).directory.blocks d.size = true)
    (b : Nat) (ids : GroupCandidates.Triple)
    (accepted : GuardedIndexAccess.guard (model d raw members) b ids = true) :
    BucketIndex.unrank d (GuardedIndexAccess.address (model d raw members) b ids).toNat =
      codes d raw members ids := by
  rw [unrank_eq d raw members checked fits limits _
    (GuardedIndexAccess.address_bound _ checked fits limits b ids accepted)]
  rw [GuardedIndexAccess.address_inverse (fun _ => 0) _ checked fits limits b ids accepted]

end Mahjong.LegacyIndexRefinement

#print axioms Mahjong.LegacyIndexRefinement.read4
#print axioms Mahjong.LegacyIndexRefinement.read8
#print axioms Mahjong.LegacyIndexRefinement.search_eq
#print axioms Mahjong.LegacyIndexRefinement.search_congr
#print axioms Mahjong.LegacyIndexRefinement.search_pair
#print axioms Mahjong.LegacyIndexRefinement.search_triple
#print axioms Mahjong.LegacyIndexRefinement.search_cut
#print axioms Mahjong.LegacyIndexRefinement.blockAt_eq
#print axioms Mahjong.LegacyIndexRefinement.within_eq
#print axioms Mahjong.LegacyIndexRefinement.decodeIds_form
#print axioms Mahjong.LegacyIndexRefinement.decodeIds_eq
#print axioms Mahjong.LegacyIndexRefinement.unrank_eq
#print axioms Mahjong.LegacyIndexRefinement.guarded_legacy_inverse
