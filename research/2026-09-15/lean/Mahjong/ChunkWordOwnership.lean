import Std
import Init.Data.UInt.Lemmas

set_option autoImplicit false

namespace Mahjong.ChunkWordOwnership

/-- Distinct aligned chunk intervals cannot share a writable 64-bit word. -/
theorem separated_words (boundary r s : Nat) (aligned : boundary % 64 = 0)
    (before : r < boundary) (after : boundary ≤ s) : r/64 < s/64 := by omega

theorem chunk_start_aligned (chunk width : Nat) (aligned : width % 64 = 0) :
    (chunk*width)%64 = 0 := by simp [Nat.mul_mod,aligned]

theorem chunk_word_disjoint (a b width r s : Nat) (positive : 0 < width)
    (aligned : width % 64 = 0) (order : a < b)
    (ra : a*width ≤ r ∧ r < (a+1)*width) (sb : b*width ≤ s) : r/64 ≠ s/64 := by
  have sep : (a+1)*width ≤ b*width := Nat.mul_le_mul_right width (by omega)
  have less := separated_words (b*width) r s (chunk_start_aligned b width aligned) (by omega) sb
  omega

/-- The branch uses this mask only for a nonzero remainder below 64; all
64 possible remainder values are checked in the kernel, including zero. -/
theorem tail_mask64 : ∀ n : Fin 64,
    (((1 : UInt64) <<< UInt64.ofNat n.val)-1).toNat = 2^n.val-1 := by decide

theorem full_word64 : (~~~(0 : UInt64)).toNat = 2^64-1 := by decide

theorem single_bit_positions : ∀ n : Fin 64,
    ((1 : UInt64) <<< UInt64.ofNat n.val).toNat = 2^n.val := by decide

end Mahjong.ChunkWordOwnership

#print axioms Mahjong.ChunkWordOwnership.separated_words
#print axioms Mahjong.ChunkWordOwnership.chunk_start_aligned
#print axioms Mahjong.ChunkWordOwnership.chunk_word_disjoint
#print axioms Mahjong.ChunkWordOwnership.tail_mask64
#print axioms Mahjong.ChunkWordOwnership.full_word64
#print axioms Mahjong.ChunkWordOwnership.single_bit_positions
