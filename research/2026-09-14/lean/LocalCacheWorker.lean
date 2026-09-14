import Mahjong.LocalCacheEncoding

open Mahjong Mahjong.LocalCacheEncoding

def main (args : List String) : IO UInt32 := do
  let [blockText, input, startText, countText, output] := args
    | throw (IO.userError "block cache start count output")
  let some b := blockText.toNat? | throw (IO.userError "invalid block")
  let some start := startText.toNat? | throw (IO.userError "invalid start")
  let some count := countText.toNat? | throw (IO.userError "invalid count")
  if b ≥ 4 then throw (IO.userError "block outside 0..3")
  let data ← IO.FS.readBinFile input
  let required := if b = 3 then 78125 else 1953125
  if data.size != required || start + count > required || count = 0 then
    throw (IO.userError "invalid input length or range")
  let table := candidate b data
  let started ← IO.monoNanosNow
  let ok := LocalCache.checkSpan b table start count
  if !ok then
    IO.eprintln s!"REJECTED_LOCAL_CACHE block={b} start={start} count={count}"
    return 1
  let elapsed := (← IO.monoNanosNow) - started
  IO.FS.writeFile output ("{\"schema\":\"LEAN_LOCAL_CACHE_CHUNK_V1\",\"status\":\"PASS\",\"block\":" ++
    toString b ++ ",\"start\":" ++ toString start ++ ",\"count\":" ++ toString count ++
    ",\"input_bytes\":" ++ toString data.size ++ ",\"nanoseconds\":" ++ toString elapsed ++
    ",\"global_slots_checked\":0,\"full_table_Lean\":\"NOT_VERIFIED\"}\n")
  IO.println s!"PASS_LOCAL_CACHE_CHUNK block={b} start={start} count={count}"
  return 0
