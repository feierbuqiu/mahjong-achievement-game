import Mahjong.WordLimits

set_option autoImplicit false

namespace Mahjong.WordRank
open Ranking EnumerationBlocks IndexWordArithmetic WordLimits

/-- The four arithmetic expressions in the frozen C++ within_sorted method,
after its widening of member IDs and group sizes to uint64_t. -/
def within (a b c : Nat) (na nb x y z : UInt64) : UInt64 :=
  if a = c then x+wordC2 y+wordC3 z
  else if a = b then x+wordC2 y+wordC2 na*z
  else if b = c then x+na*(y+wordC2 z)
  else x+na*(y+nb*z)

theorem within_correct (d : GroupInventory.Data) (a b c : Nat) (na nb x y z : UInt64)
    (sa : na.toNat = d.size a) (sb : nb.toNat = d.size b)
    (ba : na.toNat ≤ 3403) (bb : nb.toNat ≤ 3403)
    (bx : x.toNat ≤ 3403) (by' : y.toNat ≤ 3403) (bz : z.toNat ≤ 3403) :
    (within a b c na nb x y z).toNat = WeightedBlocks.rank d a b c x.toNat y.toNat z.toNat := by
  have cy := wordC2_correct y (by omega)
  have cz := wordC2_correct z (by omega)
  have cn := wordC2_correct na (by omega)
  have tz := wordC3_correct z (by omega)
  have hy := c2_mono by'
  have hz := c2_mono bz
  have hn := c2_mono ba
  have ht := c3_mono bz
  have c2value : c2 3403 = 5791906 := rfl
  have c3value : c3 3403 = 6573813310 := rfl
  have pny := Nat.mul_le_mul hn bz
  have pyz := Nat.mul_le_mul bb bz
  have mixc := Nat.mul_le_mul ba (show y.toNat+c2 z.toNat ≤ 3403+c2 3403 by omega)
  have mixd := Nat.mul_le_mul ba (show y.toNat+nb.toNat*z.toNat ≤ 3403+3403*3403 by omega)
  have xy : (x+wordC2 y).toNat = x.toNat+c2 y.toNat := by
    rw [add64 x (wordC2 y) (by rw [cy]; omega),cy]
  by_cases ac : a = c
  · simp only [within,WeightedBlocks.rank,ac,↓reduceIte,rank3]
    rw [add64 (x+wordC2 y) (wordC3 z) (by rw [xy,tz]; omega),xy,tz]
  · by_cases ab : a = b
    · have prod : (wordC2 na*z).toNat = c2 na.toNat*z.toNat := by
        rw [mul64 (wordC2 na) z (by rw [cn]; omega),cn]
      simp only [within,WeightedBlocks.rank,if_neg ac,if_pos ab,rank2,radix]
      rw [add64 (x+wordC2 y) (wordC2 na*z) (by rw [xy,prod]; omega),xy,prod,sa]
    · by_cases bc : b = c
      · have inner : (y+wordC2 z).toNat = y.toNat+c2 z.toNat := by
          rw [add64 y (wordC2 z) (by rw [cz]; omega),cz]
        have prod : (na*(y+wordC2 z)).toNat = na.toNat*(y.toNat+c2 z.toNat) := by
          rw [mul64 na (y+wordC2 z) (by rw [inner]; omega),inner]
        simp only [within,WeightedBlocks.rank,if_neg ac,if_neg ab,if_pos bc,rank2,radix]
        rw [add64 x (na*(y+wordC2 z)) (by rw [prod]; omega),prod,sa]
      · have yz : (nb*z).toNat = nb.toNat*z.toNat := mul64 nb z (by omega)
        have inner : (y+nb*z).toNat = y.toNat+nb.toNat*z.toNat := by
          rw [add64 y (nb*z) (by rw [yz]; omega),yz]
        have prod : (na*(y+nb*z)).toNat = na.toNat*(y.toNat+nb.toNat*z.toNat) := by
          rw [mul64 na (y+nb*z) (by rw [inner]; omega),inner]
        simp only [within,WeightedBlocks.rank,if_neg ac,if_neg ab,if_neg bc,radix]
        rw [add64 x (na*(y+nb*z)) (by rw [prod]; omega),prod,sa,sb]

def withinAt (d : IndexOperations.Data) (p : IndexOperations.Position) : UInt64 :=
  let g := d.key p.1
  within g.1 g.2.1 g.2.2 (UInt64.ofNat (d.groups.size g.1)) (UInt64.ofNat (d.groups.size g.2.1))
    (UInt64.ofNat p.2.1) (UInt64.ofNat p.2.2.1) (UInt64.ofNat p.2.2.2)

theorem withinAt_correct (d : IndexOperations.Data) (checked : IndexOperations.Checked d)
    (fits : GroupsFit d.groups) (p : IndexOperations.Position) (valid : IndexOperations.Valid d p) :
    (withinAt d p).toNat = IndexOperations.within d p := by
  have f := checked.row p.1 valid.1
  have a := fits.2.2 _ f.1
  have b := fits.2.2 _ f.2.1
  have c := fits.2.2 _ f.2.2.1
  have x : p.2.1 ≤ 3403 := by have h := valid.2.1; omega
  have y : p.2.2.1 ≤ 3403 := by have h := valid.2.2.1; omega
  have z : p.2.2.2 ≤ 3403 := by have h := valid.2.2.2.1; omega
  have cast (n : Nat) (hn : n ≤ 3403) : (UInt64.ofNat n).toNat = n :=
    UInt64.toNat_ofNat_of_lt' (by change n < 2^64; omega)
  have result := within_correct d.groups (d.key p.1).1 (d.key p.1).2.1 (d.key p.1).2.2
    (UInt64.ofNat (d.groups.size (d.key p.1).1)) (UInt64.ofNat (d.groups.size (d.key p.1).2.1))
    (UInt64.ofNat p.2.1) (UInt64.ofNat p.2.2.1) (UInt64.ofNat p.2.2.2)
    (cast _ a.2.1) (cast _ b.2.1)
    (by rw [cast _ a.2.1]; exact a.2.1) (by rw [cast _ b.2.1]; exact b.2.1)
    (by rw [cast _ x]; exact x) (by rw [cast _ y]; exact y) (by rw [cast _ z]; exact z)
  simpa only [withinAt,IndexOperations.within,cast _ x,cast _ y,cast _ z] using result

def rank (d : IndexOperations.Data) (p : IndexOperations.Position) : UInt64 :=
  UInt64.ofNat (d.directory.offset p.1)+withinAt d p

theorem rank_correct (d : IndexOperations.Data) (checked : IndexOperations.Checked d)
    (fits : GroupsFit d.groups) (bucket : bucketFits d.directory.blocks d.directory.total = true)
    (p : IndexOperations.Position) (valid : IndexOperations.Valid d p) :
    (rank d p).toNat = IndexOperations.rank d p := by
  have w := withinAt_correct d checked fits p valid
  have bounds := prefix_arithmetic_bounds d.directory checked.intervals bucket p.1 (IndexOperations.within d p)
    valid.1 (IndexOperations.within_bound d checked p valid)
  have offset : (UInt64.ofNat (d.directory.offset p.1)).toNat = d.directory.offset p.1 :=
    UInt64.toNat_ofNat_of_lt' (by change d.directory.offset p.1 < 2^64; omega)
  unfold rank
  rw [add64 _ _ (by rw [offset,w]; exact bounds.1),offset,w]
  rfl

theorem rank_injective (d : IndexOperations.Data) (checked : IndexOperations.Checked d)
    (fits : GroupsFit d.groups) (bucket : bucketFits d.directory.blocks d.directory.total = true)
    (p q : IndexOperations.Position) (vp : IndexOperations.Valid d p) (vq : IndexOperations.Valid d q)
    (same : rank d p = rank d q) : p = q := by
  apply IndexOperations.rank_injective d checked p q vp vq
  have eq := congrArg UInt64.toNat same
  simpa only [rank_correct d checked fits bucket p vp,rank_correct d checked fits bucket q vq] using eq

theorem rank_not_bad (d : IndexOperations.Data) (checked : IndexOperations.Checked d)
    (fits : GroupsFit d.groups) (bucket : bucketFits d.directory.blocks d.directory.total = true)
    (p : IndexOperations.Position) (valid : IndexOperations.Valid d p) : rank d p ≠ UInt64.ofNat (2^64-1) := by
  intro same
  have eq := congrArg UInt64.toNat same
  rw [rank_correct d checked fits bucket p valid] at eq
  have bound := IndexOperations.rank_bound d checked p valid
  have total := (bucket_facts _ _ bucket).2
  have bad : (UInt64.ofNat (2^64-1)).toNat = 2^64-1 := rfl
  rw [bad] at eq
  omega

end Mahjong.WordRank

#print axioms Mahjong.WordRank.within_correct
#print axioms Mahjong.WordRank.withinAt_correct
#print axioms Mahjong.WordRank.rank_correct
#print axioms Mahjong.WordRank.rank_injective
#print axioms Mahjong.WordRank.rank_not_bad
