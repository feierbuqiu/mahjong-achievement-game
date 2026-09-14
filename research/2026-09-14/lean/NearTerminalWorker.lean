import Mahjong.NearTerminalBucket
import Mahjong.SummaryEncoding

open Mahjong

def number (s : String) : IO Nat :=
  match s.toNat? with | some n => pure n | none => throw (IO.userError "invalid integer")

def main (args : List String) : IO UInt32 := do
  let [cacheRoot, indexRoot, directory, bitsFile, honorText, sizeText, startText, countText, output] := args
    | throw (IO.userError "cache-root index-root directory bits honor-code size start count output")
  let honor ← number honorText
  let size ← number sizeText
  let start ← number startText
  let count ← number countText
  if count = 0 || start+count > size then throw (IO.userError "invalid span")
  let numeric ← IO.FS.readBinFile (cacheRoot ++ "/numeric.bin")
  let honors ← IO.FS.readBinFile (cacheRoot ++ "/honors.bin")
  let numericSummary ← IO.FS.readBinFile (cacheRoot ++ "/summary_numeric.bin")
  let honorSummary ← IO.FS.readBinFile (cacheRoot ++ "/summary_honors.bin")
  let tables : PackedRules.Tables := fun b => SummaryEncoding.candidate b
    (if b = 3 then honors else numeric) (if b = 3 then honorSummary else numericSummary)
  let d : BucketIndex.Data := ⟨← IO.FS.readBinFile (indexRoot ++ "/numeric.bin"),
    ← IO.FS.readBinFile (indexRoot ++ "/numeric_ids.bin"),
    ← IO.FS.readBinFile (indexRoot ++ "/groups.bin"),
    ← IO.FS.readBinFile directory, honor, size⟩
  let bits ← IO.FS.readBinFile bitsFile
  if bits.size != ((size+63)/64)*8 || d.directory.size % 32 != 0 || d.directory.size = 0 then
    throw (IO.userError "invalid payload length")
  let started ← IO.monoNanosNow
  if !NearTerminalBucket.span tables d bits start count then
    for i in [start:start+count] do
      if !NearTerminalBucket.row tables d bits i then
        IO.eprintln s!"FAIL terminal bucket row={i} state={repr (BucketIndex.unrank d i)} roundtrip={BucketIndex.roundtrip d i}"
        break
    return 1
  let elapsed := (← IO.monoNanosNow)-started
  let result := "{\"schema\":\"LEAN_NEAR_TERMINAL_BUCKET_CHUNK_V1\",\"status\":\"PASS\",\"start\":" ++
    toString start ++ ",\"count\":" ++ toString count ++ ",\"size\":" ++ toString size ++
    ",\"honor_code\":" ++ toString honor ++ ",\"nanoseconds\":" ++ toString elapsed ++
    ",\"global_slots_checked\":" ++ toString count ++ ",\"full_table_Lean\":\"NOT_VERIFIED\"}\n"
  IO.FS.writeFile output result
  IO.println s!"PASS_NEAR_TERMINAL_BUCKET start={start} count={count} nanoseconds={elapsed}"
  return 0
