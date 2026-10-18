import Lean.Data.Json
set_option autoImplicit false

/- Bounded framing for untrusted witness/source proposals. No checker data are trusted here. -/
namespace CompactStreamTransport

def transport : String := "compact_source_witness_u64_v1"
def payloadEnd : ByteArray := "\nCOMPACT_PAYLOAD_END_V1\n".toUTF8
def countCap : Nat := 8388608
def headerCap : Nat := 16384

/-- Use the same binary Stream.read interface for headers, payloads and delimiters. -/
def readLine (input : IO.FS.Stream) : IO (Option String) := do
  let mut bytes := ByteArray.emptyWithCapacity 256
  repeat
    let byte ← input.read 1
    if byte.isEmpty then
      if bytes.isEmpty then return none
      throw (IO.userError "STREAM_TRUNCATED_HEADER")
    if byte.size != 1 then throw (IO.userError "STREAM_HEADER_READ_OVERRUN")
    if byte[0]! = 10 then
      match String.fromUTF8? bytes with
      | some line => return some line
      | none => throw (IO.userError "STREAM_INVALID_HEADER_UTF8")
    if bytes.size ≥ headerCap then throw (IO.userError "STREAM_HEADER_TOO_LONG")
    bytes := bytes.push byte[0]!

/-- Handles arbitrary short reads without interpreting any binary byte as text or EOF. -/
def readExact (input : IO.FS.Stream) (length : Nat) (field : String) : IO ByteArray := do
  let mut bytes := ByteArray.emptyWithCapacity length
  while bytes.size < length do
    let wanted := min (length-bytes.size) 1048576
    let part ← input.read wanted.toUSize
    if part.isEmpty then throw (IO.userError ("STREAM_TRUNCATED_" ++ field))
    if part.size > wanted then throw (IO.userError ("STREAM_READ_OVERRUN_" ++ field))
    bytes := part.copySlice 0 bytes bytes.size part.size false
  return bytes

def finishPayload (input : IO.FS.Stream) : IO Unit := do
  let ending ← readExact input payloadEnd.size "PAYLOAD_END"
  if ending != payloadEnd then throw (IO.userError "STREAM_EXTRA_OR_BAD_PAYLOAD_END")

def requireEOF (input : IO.FS.Stream) : IO Unit := do
  let extra ← input.read 1
  if !extra.isEmpty then throw (IO.userError "STREAM_TRAILING_AFTER_STOP")

def natField (j : Lean.Json) (key : String) : IO Nat :=
  match j.getObjVal? key >>= Lean.Json.getNat? with
  | .ok n => pure n
  | .error _ => throw (IO.userError ("STREAM_INVALID_FIELD_" ++ key))

def stringField (j : Lean.Json) (key : String) : IO String :=
  match j.getObjVal? key >>= Lean.Json.getStr? with
  | .ok s => pure s
  | .error _ => throw (IO.userError ("STREAM_INVALID_FIELD_" ++ key))

structure Span where
  start : Nat
  count : Nat
  output : String

inductive Command where
  | stop
  | span (value : Span)

def parseCommand (line : String) : IO Command := do
  let j ← match Lean.Json.parse line with
    | .ok value => pure value
    | .error _ => throw (IO.userError "STREAM_INVALID_HEADER_JSON")
  let object ← match j.getObj? with
    | .ok value => pure value
    | .error _ => throw (IO.userError "STREAM_HEADER_NOT_OBJECT")
  match j.getObjVal? "stop" >>= Lean.Json.getBool? with
  | .ok true =>
    if object.size != 1 then throw (IO.userError "STREAM_STOP_EXTRA_FIELDS")
    return .stop
  | _ => pure ()
  if object.size != 5 then throw (IO.userError "STREAM_HEADER_FIELDS")
  if (← stringField j "transport") != transport then
    throw (IO.userError "STREAM_INVALID_TRANSPORT")
  let start ← natField j "start"
  let count ← natField j "count"
  let compactBytes ← natField j "compact_bytes"
  let output ← stringField j "output"
  if count = 0 || count > countCap then throw (IO.userError "STREAM_COUNT_OUT_OF_BOUNDS")
  if compactBytes != count*8 then
    throw (IO.userError "STREAM_INVALID_DECLARED_LENGTH")
  if output.isEmpty then throw (IO.userError "STREAM_EMPTY_OUTPUT")
  return .span ⟨start,count,output⟩

end CompactStreamTransport
