import Mahjong.RuntimeBindingV17

set_option autoImplicit false

namespace Mahjong.BindingControlsV17

open EmptyRootV17

def pBits : ByteArray := ⟨#[1,0,0,0,0,0,0,0]⟩
def nBits : ByteArray := ⟨#[0,0,0,0,0,0,0,0]⟩

/-- The exact observed root projection, including the independent P-bit guard. -/
theorem root_projection_accepts : checkP observedPrefixData pBits = true := by decide

theorem root_n_bit_rejected : checkP observedPrefixData nBits = false := by decide

theorem missing_padded_bits_rejected :
    checkP observedPrefixData (⟨#[1]⟩ : ByteArray) = false := by decide

theorem nonempty_code_rejected :
    check { observedPrefixData with numeric := ⟨#[1,0,0,0,0,0,0,0,0,0,0,0]⟩ } = false := by decide

theorem missing_directory_rejected :
    check { observedPrefixData with directory := ByteArray.empty } = false := by decide

theorem different_bits_not_same_bucket :
    CrossLayerAssemblyV17.sameBucket ⟨observedPrefixData,pBits⟩ ⟨observedPrefixData,nBits⟩ = false := by decide

theorem different_size_not_same_bucket :
    CrossLayerAssemblyV17.sameBucket ⟨observedPrefixData,pBits⟩
      ⟨{observedPrefixData with size := 2},pBits⟩ = false := by decide

end Mahjong.BindingControlsV17

#print axioms Mahjong.BindingControlsV17.root_projection_accepts
#print axioms Mahjong.BindingControlsV17.root_n_bit_rejected
#print axioms Mahjong.BindingControlsV17.missing_padded_bits_rejected
#print axioms Mahjong.BindingControlsV17.nonempty_code_rejected
#print axioms Mahjong.BindingControlsV17.missing_directory_rejected
#print axioms Mahjong.BindingControlsV17.different_bits_not_same_bucket
#print axioms Mahjong.BindingControlsV17.different_size_not_same_bucket
