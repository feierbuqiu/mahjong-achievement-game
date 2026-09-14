import Mahjong.SummaryEncoding

open Mahjong

def main (args : List String) : IO UInt32 := do
  let [blockText, coreFile, summaryFile, startText, countText, output] := args
    | throw (IO.userError "block core summary start count output")
  let some b := blockText.toNat? | throw (IO.userError "invalid block")
  let some start := startText.toNat? | throw (IO.userError "invalid start")
  let some count := countText.toNat? | throw (IO.userError "invalid count")
  if b ≥ 4 then throw (IO.userError "block outside 0..3")
  let core ← IO.FS.readBinFile coreFile
  let summary ← IO.FS.readBinFile summaryFile
  let required := if b = 3 then 78125 else 1953125
  if core.size != required || summary.size != required * 4 || start + count > required || count = 0 then
    throw (IO.userError "invalid input length or range")
  let table := SummaryEncoding.candidate b core summary
  let started ← IO.monoNanosNow
  if !LocalSummary.checkSpan b table start count then
    IO.eprintln s!"REJECTED_LOCAL_SUMMARY block={b} start={start} count={count}"
    return 1
  let elapsed := (← IO.monoNanosNow) - started
  IO.FS.writeFile output ("{\"schema\":\"LEAN_LOCAL_SUMMARY_CHUNK_V1\",\"status\":\"PASS\",\"block\":" ++
    toString b ++ ",\"start\":" ++ toString start ++ ",\"count\":" ++ toString count ++
    ",\"input_bytes\":" ++ toString core.size ++ ",\"nanoseconds\":" ++ toString elapsed ++
    ",\"global_slots_checked\":0,\"full_table_Lean\":\"NOT_VERIFIED\"}\n")
  return 0
