import Mahjong.TerminalBucket
import Init.Data.UInt.Bitwise
import Init.Data.UInt.Lemmas

set_option autoImplicit false

namespace Mahjong.FastBitRead

/-- The old total byte lookup is retained, including its out-of-range value.
Only the bit extraction changes to fixed-width instructions. -/
@[inline] def labelPNat (bits : @& ByteArray) (i : Nat) : Bool :=
  decide ((((bits[i / 8]!) >>> UInt8.ofNat (i % 8)) &&& (1 : UInt8)) = 1)

/-- No conversion of the full index to Nat is needed before division by eight.
UInt8 shifts mask the amount modulo eight, so casting the low byte is enough. -/
@[inline] def labelP64 (bits : @& ByteArray) (i : UInt64) : Bool :=
  decide ((((bits[(i >>> (3 : UInt64)).toNat]!) >>> i.toUInt8) &&& (1 : UInt8)) = 1)

theorem byte_bit (byte shift : UInt8) :
    decide (((byte >>> shift) &&& (1 : UInt8)) = 1) =
      decide ((byte.toNat / 2 ^ (shift.toNat % 8)) % 2 = 1) := by
  simp only [← UInt8.toNat_inj, UInt8.toNat_and, UInt8.toNat_shiftRight,
    UInt8.reduceToNat, Nat.and_one_is_mod, Nat.shiftRight_eq_div_pow]

theorem labelPNat_eq (bits : ByteArray) (i : Nat) :
    labelPNat bits i = TerminalBucket.labelP bits i := by
  rw [labelPNat, byte_bit]
  have small : i % 8 < 256 := Nat.lt_trans (Nat.mod_lt i (by decide)) (by decide)
  simp only [UInt8.toNat_ofNat', Nat.reducePow, Nat.mod_eq_of_lt small, Nat.mod_mod,
    TerminalBucket.labelP]

theorem byte_index64 (i : UInt64) :
    (i >>> (3 : UInt64)).toNat = i.toNat / 8 := by
  simp only [UInt64.toNat_shiftRight, UInt64.reduceToNat, Nat.reduceMod,
    Nat.shiftRight_eq_div_pow, Nat.reducePow]

theorem byte_shift64 (i : UInt64) : i.toUInt8.toNat % 8 = i.toNat % 8 := by
  simp only [UInt64.toNat_toUInt8, Nat.reducePow]
  exact Nat.mod_mod_of_dvd i.toNat (by decide)

theorem labelP64_eq (bits : ByteArray) (i : UInt64) :
    labelP64 bits i = TerminalBucket.labelP bits i.toNat := by
  rw [labelP64, byte_bit, byte_index64, byte_shift64]
  rfl

end Mahjong.FastBitRead

#print axioms Mahjong.FastBitRead.byte_bit
#print axioms Mahjong.FastBitRead.labelPNat_eq
#print axioms Mahjong.FastBitRead.byte_index64
#print axioms Mahjong.FastBitRead.byte_shift64
#print axioms Mahjong.FastBitRead.labelP64_eq
