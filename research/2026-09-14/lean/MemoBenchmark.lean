import Mahjong.MemoRules
import Mahjong.LocalCacheEncoding

open Mahjong

def parseDigits (digits : String) : Except String State := do
  let chars := digits.toList
  if chars.length != 34 then throw "state requires 34 counts"
  let counts ← chars.toArray.mapM fun c =>
    if '0' ≤ c && c ≤ '4' then pure (c.toNat - '0'.toNat)
    else throw "invalid tile count"
  pure (fun tile => counts[tile.val]!)

def main (args : List String) : IO UInt32 := do
  let [numericFile, honorFile, input, output, mode] := args
    | throw (IO.userError "numeric-cache honor-cache input output safe|successors")
  if mode != "safe" && mode != "successors" then throw (IO.userError "unknown benchmark mode")
  let numeric ← IO.FS.readBinFile numericFile
  let honors ← IO.FS.readBinFile honorFile
  if numeric.size != 1953125 || honors.size != 78125 then throw (IO.userError "cache size mismatch")
  let tables : MemoRules.Tables := fun b => LocalCacheEncoding.candidate b (if b = 3 then honors else numeric)
  let data ← IO.FS.readFile input
  let file ← IO.FS.Handle.mk output .write
  let mut checked := 0
  for raw in data.splitOn "\n" do
    let row := raw.trimAscii.toString
    if row.isEmpty then continue
    let [layer, _, _, digits, expectedText] := row.splitOn "\t"
      | throw (IO.userError "invalid fixture row")
    let s ← match parseDigits digits with
      | .ok s => pure s
      | .error msg => throw (IO.userError msg)
    let some expected := expectedText.toNat? | throw (IO.userError "invalid successor count")
    let started ← IO.monoNanosNow
    let ok := MemoRules.safeB tables s
    let successors := if mode == "successors" then (MemoRules.safeSuccessors tables s).length else 0
    if !ok || (mode == "successors" && successors != expected) then
      file.putStrLn s!"FAIL layer={layer} state={digits} safe={ok} children={successors} expected={expected}"
      file.flush
      return 1
    let elapsed := (← IO.monoNanosNow) - started
    checked := checked + 1
    file.putStrLn ("{\"sample\":" ++ toString checked ++ ",\"layer\":" ++ layer ++
      ",\"nanoseconds\":" ++ toString elapsed ++ ",\"physical_successors\":" ++ toString successors ++ "}")
    file.flush
  IO.println s!"PASS_MEMO_RULE_BENCHMARK samples={checked} mode={mode}; full_table_NOT_VERIFIED"
  return 0
