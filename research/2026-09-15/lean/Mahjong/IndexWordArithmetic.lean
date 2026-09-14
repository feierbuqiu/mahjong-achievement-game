import Mahjong.IndexOperations
import Init.Data.UInt.Lemmas

set_option autoImplicit false

namespace Mahjong.IndexWordArithmetic
open Ranking EnumerationBlocks

theorem add64 (a b : UInt64) (bound : a.toNat+b.toNat < 2^64) :
    (a+b).toNat = a.toNat+b.toNat := by
  rw [UInt64.toNat_add,Nat.mod_eq_of_lt bound]

theorem mul64 (a b : UInt64) (bound : a.toNat*b.toNat < 2^64) :
    (a*b).toNat = a.toNat*b.toNat := by
  rw [UInt64.toNat_mul,Nat.mod_eq_of_lt bound]

def wordC2 (x : UInt64) : UInt64 := x*(x+1)/2
def wordC3 (x : UInt64) : UInt64 := x*(x+1)*(x+2)/6

theorem wordC2_correct (x : UInt64) (bound : x.toNat ≤ 3404) :
    (wordC2 x).toNat = c2 x.toNat := by
  have add : (x+1).toNat = x.toNat+1 := add64 x 1 (by change x.toNat+1 < 2^64; omega)
  have prod := Nat.mul_le_mul bound (show x.toNat+1 ≤ 3405 by omega)
  have mul : (x*(x+1)).toNat = x.toNat*(x.toNat+1) := by
    rw [mul64 x (x+1) (by rw [add]; omega),add]
  simp only [wordC2,UInt64.toNat_div,mul,c2]
  rfl

theorem wordC3_correct (x : UInt64) (bound : x.toNat ≤ 3404) :
    (wordC3 x).toNat = c3 x.toNat := by
  have a1 : (x+1).toNat = x.toNat+1 := add64 x 1 (by change x.toNat+1 < 2^64; omega)
  have a2 : (x+2).toNat = x.toNat+2 := add64 x 2 (by change x.toNat+2 < 2^64; omega)
  have p2 := Nat.mul_le_mul bound (show x.toNat+1 ≤ 3405 by omega)
  have m2 : (x*(x+1)).toNat = x.toNat*(x.toNat+1) := by
    rw [mul64 x (x+1) (by rw [a1]; omega),a1]
  have p3 := Nat.mul_le_mul p2 (show x.toNat+2 ≤ 3406 by omega)
  have m3 : (x*(x+1)*(x+2)).toNat = x.toNat*(x.toNat+1)*(x.toNat+2) := by
    rw [mul64 (x*(x+1)) (x+2) (by rw [m2,a2]; omega),m2,a2]
  simp only [wordC3,UInt64.toNat_div,m3,c3]
  rfl

theorem radix64 (a x y : UInt64) (product : a.toNat*y.toNat < 2^64)
    (sum : x.toNat+a.toNat*y.toNat < 2^64) :
    (x+a*y).toNat = radix a.toNat x.toNat y.toNat := by
  have mul := mul64 a y product
  rw [add64 x (a*y) (by rw [mul]; exact sum),mul]
  rfl

theorem absolute32 (first coordinate : Nat) (bound : first+coordinate < 2^32) :
    ((UInt32.ofNat first)+(UInt32.ofNat coordinate)).toNat = first+coordinate := by
  have f := UInt32.toNat_ofNat_of_lt' (n:=first) (by change first < 2^32; omega)
  have c := UInt32.toNat_ofNat_of_lt' (n:=coordinate) (by change coordinate < 2^32; omega)
  rw [UInt32.toNat_add,f,c,Nat.mod_eq_of_lt bound]

end Mahjong.IndexWordArithmetic

#print axioms Mahjong.IndexWordArithmetic.add64
#print axioms Mahjong.IndexWordArithmetic.mul64
#print axioms Mahjong.IndexWordArithmetic.wordC2_correct
#print axioms Mahjong.IndexWordArithmetic.wordC3_correct
#print axioms Mahjong.IndexWordArithmetic.radix64
#print axioms Mahjong.IndexWordArithmetic.absolute32
