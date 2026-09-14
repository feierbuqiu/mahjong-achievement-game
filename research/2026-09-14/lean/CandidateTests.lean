import Mahjong.WholeTable

open Mahjong Mahjong.WholeTable Mahjong.SafeGame

def parseFixtureDigits (digits : String) : Except String State := do
  let chars := digits.toList
  if chars.length != 34 then throw "state requires 34 counts"
  let counts ← chars.toArray.mapM fun c =>
    if '0' ≤ c && c ≤ '4' then pure (c.toNat - '0'.toNat)
    else throw "invalid tile count"
  pure (fun tile => counts[tile.val]!)

def tableFromRows (rows : Array (State × Outcome)) : Candidate where
  size := rows.size
  unrank i := (rows[i]?.getD (empty, .P)).1
  rank s := rows.findIdx (fun row => Generators.stateEqB row.1 s)
  canonical s := s
  restore _ := []
  label i := (rows[i]?.getD (empty, .P)).2

def main (args : List String) : IO UInt32 := do
  let [input] := args | throw (IO.userError "candidate fixture file required")
  let data ← IO.FS.readFile input
  let mut rows : Array (State × Outcome) := #[]
  for raw in data.splitOn "\n" do
    let line := raw.trimAscii.toString
    if line.isEmpty then continue
    let [digits, label] := line.splitOn "\t" | throw (IO.userError "invalid row")
    let s ← match parseFixtureDigits digits with
      | .ok s => pure s
      | .error msg => throw (IO.userError msg)
    if label != "P" && label != "N" then throw (IO.userError "invalid label")
    rows := rows.push (s, if label == "P" then .P else .N)
  if rows.size < 2 then throw (IO.userError "nonterminal fixture required")
  let table := tableFromRows rows
  let positive := check table
  let missing := check (tableFromRows rows.pop)
  let flipped := check {table with label := fun i => if i == 0 then (table.label i).opposite else table.label i}
  let collision := check {table with rank := fun _ => 0}
  let outOfRange := check {table with rank := fun _ => table.size}
  let badCanonical := check {table with canonical := fun _ => empty}
  let badRoot := checkRoot table 0
  let duplicate := check (tableFromRows (rows.push (rows[rows.size-1]?.getD (empty, .P))))
  let ok := positive && !missing && !flipped && !collision && !outOfRange && !badCanonical && !badRoot && duplicate
  IO.println s!"rows={rows.size} positive={positive} missing={missing} flipped={flipped} collision={collision} outOfRange={outOfRange} badCanonical={badCanonical} falseEmptyRoot={badRoot} consistentDuplicate={duplicate}"
  IO.println s!"NATIVE_CANDIDATE_TESTS_PASS={ok}; full_table_NOT_VERIFIED"
  return if ok then 0 else 1
