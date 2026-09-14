import Mahjong.PreloadedRules
import Mahjong.SummaryEncoding

open Mahjong

def main (args : List String) : IO UInt32 := do
  let [numericFile, honorFile, numericSummaryFile, honorSummaryFile, input, output, mode] := args
    | throw (IO.userError "core-numeric core-honor summary-numeric summary-honor input output safe|successors")
  let numeric ← IO.FS.readBinFile numericFile
  let honors ← IO.FS.readBinFile honorFile
  let numericSummary ← IO.FS.readBinFile numericSummaryFile
  let honorSummary ← IO.FS.readBinFile honorSummaryFile
  let tables : PackedRules.Tables := fun b => SummaryEncoding.candidate b
    (if b = 3 then honors else numeric) (if b = 3 then honorSummary else numericSummary)
  let data ← IO.FS.readFile input
  let file ← IO.FS.Handle.mk output .write
  let mut checked := 0
  for raw in data.splitOn "\n" do
    let row := raw.trimAscii.toString
    if row.isEmpty then continue
    let [layer, _, _, digits, expectedText] := row.splitOn "\t"
      | throw (IO.userError "invalid fixture")
    let counts := digits.toList.toArray.map (fun c => c.toNat - '0'.toNat)
    if counts.size != 34 || !counts.all (fun n => decide (n ≤ 4)) then
      throw (IO.userError "invalid counts")
    let s : State := fun u => counts[u.val]!
    let packed : PackedRules.Packed := ⟨LocalCacheEncoding.encodeBlock 0 s,
      LocalCacheEncoding.encodeBlock 1 s, LocalCacheEncoding.encodeBlock 2 s,
      LocalCacheEncoding.encodeBlock 3 s⟩
    if !allTiles.all (fun u => decide (PackedRules.state tables packed u = s u)) then
      throw (IO.userError "packed input mismatch")
    let some expected := expectedText.toNat? | throw (IO.userError "invalid count")
    let started ← IO.monoNanosNow
    let ok := PreloadedRules.safeB tables packed
    let successors := if mode == "successors" then (allTiles.filter (fun u =>
      PackedRules.available tables packed u && PreloadedRules.safeB tables (PackedRules.add tables packed u))).length else 0
    if !ok || (mode == "successors" && successors != expected) then
      file.putStrLn s!"FAIL layer={layer} state={digits} safe={ok} children={successors} expected={expected}"
      file.flush
      return 1
    let elapsed := (← IO.monoNanosNow) - started
    checked := checked + 1
    file.putStrLn ("{\"sample\":" ++ toString checked ++ ",\"layer\":" ++ layer ++
      ",\"nanoseconds\":" ++ toString elapsed ++ ",\"physical_successors\":" ++ toString successors ++ "}")
  file.flush
  IO.println s!"PASS_PACKED_RULE_BENCHMARK samples={checked} mode={mode}; full_table_NOT_VERIFIED"
  return 0
