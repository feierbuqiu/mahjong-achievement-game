import Mahjong.PrefixDirectory

set_option autoImplicit false

namespace Mahjong.PrefixData
open CanonicalInventory PrefixDirectory

def read64 (bytes : ByteArray) (offset : Nat) : Nat :=
  read32 bytes offset + 4294967296 * read32 bytes (offset+4)

def candidate (bytes : ByteArray) (base count total : Nat) : Data where
  blocks := count
  total := total
  offset := fun b => read64 bytes (base+20*b+4)
  size := fun b => read64 bytes (base+20*b+12)

theorem checked_addresses (bytes : ByteArray) (base count total : Nat)
    (checked : check (candidate bytes base count total) = true) :
    (∀ b r, b < count → r < (candidate bytes base count total).size b →
      (candidate bytes base count total).offset b + r < total) ∧
    (∀ r, r < total → ∃ b x, b < count ∧ x < (candidate bytes base count total).size b ∧
      (candidate bytes base count total).offset b + x = r) ∧
    (∀ a b x y, a < count → b < count → x < (candidate bytes base count total).size a →
      y < (candidate bytes base count total).size b →
      (candidate bytes base count total).offset a + x = (candidate bytes base count total).offset b + y →
      a = b ∧ x = y) := by
  exact ⟨address_bound _ checked,address_surjective _ checked,address_injective _ checked⟩

end Mahjong.PrefixData

#print axioms Mahjong.PrefixData.checked_addresses
