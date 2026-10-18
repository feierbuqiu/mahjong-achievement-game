import Init
set_option autoImplicit false

/- This IO output representation is independently compared in full against the
   immutable source bitspan by the controller. It is not a proof premise. -/
namespace PackedLabelSpan

@[inline] def byte (bits : @& ByteArray) (first shift i : Nat) : UInt8 :=
  if shift = 0 then bits[first+i]!
  else (bits[first+i]! >>> shift.toUInt8) |||
    (bits[first+i+1]! <<< (8-shift).toUInt8)

/-- LSB0 output with high padding bits zero. Work is one iteration per output byte. -/
@[noinline] def build (bits : @& ByteArray) (start count : Nat) : ByteArray := Id.run do
  let bytes := (count+7)/8
  let first := start/8
  let shift := start%8
  let remainder := count%8
  let lastMask : UInt8 := if remainder = 0 then 255 else (1 <<< remainder.toUInt8)-1
  let mut output := ByteArray.emptyWithCapacity bytes
  for i in [:bytes] do
    let value := byte bits first shift i
    output := output.push (if i+1 = bytes then value &&& lastMask else value)
  return output

end PackedLabelSpan
