import Mahjong.GeneralIndex
import Mahjong.SummaryEncoding

set_option autoImplicit false
open Mahjong GeneralIndex

def number (s : String) : IO Nat :=
  match s.toNat? with | some n => pure n | none => throw (IO.userError "invalid integer")

def stem (n h : Nat) : String :=
  "n" ++ (if n < 10 then "0" else "") ++ toString n ++ "_h" ++
    (if h < 10 then "00" else if h < 100 then "0" else "") ++ toString h

def loadBucket (indexRoot dataRoot : String) (numeric ids groups : ByteArray)
    (n h code size blocks : Nat) : IO Bucket := do
  let name := stem n h
  let directory ← IO.FS.readBinFile (indexRoot ++ "/" ++ name ++ ".dir")
  let bits ← IO.FS.readBinFile (dataRoot ++ "/" ++ name ++ ".bits")
  if bits.size != (size+63)/64*8 || directory.size != blocks*32 || blocks = 0 then
    throw (IO.userError s!"bucket length mismatch: {name}")
  pure ⟨⟨numeric,ids,groups,directory,code,size⟩,bits⟩

def scan (tables : PackedRules.Tables) (next : GeneralLayer.Target) (source : Bucket)
    (start count : Nat) : IO Nat := do
  let began ← IO.monoNanosNow
  if !GeneralIndex.span tables next source start count then
    for i in [start:start+count] do
      if !GeneralIndex.row tables next source i then
        let s := BucketIndex.unrank source.data i
        IO.eprintln s!"FAIL index={i} state={repr s} P={TerminalBucket.labelP source.bits i} roundtrip={BucketIndex.roundtrip source.data i}"
        for e in GeneralLayer.entries tables next s do
          IO.eprintln s!"child={repr e.1} reference=({e.2.bucket},{e.2.index}) canonical={repr e.2.canonical} P={GeneralLayer.entryP next e} check={GeneralLayer.checkRef tables next e} path={repr e.2.restore}"
        break
    throw (IO.userError "general row check failed")
  return (← IO.monoNanosNow)-began

def main (args : List String) : IO UInt32 := do
  let [cacheRoot,indexRoot,dataRoot,catalog,layerText,bucketText,startText,countText,threadsText,output] := args
    | throw (IO.userError "cache-root index-root data-root catalog layer bucket start count threads output")
  let layer ← number layerText
  let bucket ← number bucketText
  let start ← number startText
  let count ← number countText
  let threads ← number threadsText
  if threads = 0 || threads > 12 || count = 0 then throw (IO.userError "invalid bounded work")
  let loadStart ← IO.monoNanosNow
  let numericCore ← IO.FS.readBinFile (cacheRoot ++ "/numeric.bin")
  let honorsCore ← IO.FS.readBinFile (cacheRoot ++ "/honors.bin")
  let numericSummary ← IO.FS.readBinFile (cacheRoot ++ "/summary_numeric.bin")
  let honorSummary ← IO.FS.readBinFile (cacheRoot ++ "/summary_honors.bin")
  if numericCore.size != 1953125 || honorsCore.size != 78125 || numericSummary.size != 7812500 || honorSummary.size != 312500 then
    throw (IO.userError "cache length mismatch")
  let tables : PackedRules.Tables := fun b => SummaryEncoding.candidate b
    (if b = 3 then honorsCore else numericCore) (if b = 3 then honorSummary else numericSummary)
  let numeric ← IO.FS.readBinFile (indexRoot ++ "/numeric.bin")
  let ids ← IO.FS.readBinFile (indexRoot ++ "/numeric_ids.bin")
  let groups ← IO.FS.readBinFile (indexRoot ++ "/groups.bin")
  let honors ← IO.FS.readBinFile (indexRoot ++ "/honor_ids.bin")
  if numeric.size != 131676*12 || ids.size != 1953125*4 || groups.size != 1104*8 || honors.size != 78125*4 then
    throw (IO.userError "index length mismatch")
  let mut source := emptyBucket
  let mut buckets := Array.replicate 184 emptyBucket
  let lines := (← IO.FS.readFile catalog).splitOn "\n"
  for line in lines do
    if line.trimAscii.toString.isEmpty then continue
    let [ns,hs,cs,ss,bs] := line.trimAscii.toString.splitOn "\t"
      | throw (IO.userError "invalid catalog")
    let n ← number ns
    let h ← number hs
    let code ← number cs
    let size ← number ss
    let blocks ← number bs
    if h ≥ 184 || code ≥ 78125 then throw (IO.userError "catalog outside inventory")
    if n = layer && h = bucket then
      source ← loadBucket indexRoot dataRoot numeric ids groups n h code size blocks
  let needed := source.data.honorCode :: (List.range 7).filterMap (fun i =>
    let p := LocalCacheEncoding.powers[i]!
    if source.data.honorCode/p%5 < 4 then
      some (GeneralIndex.normalize ids ⟨0,0,0,source.data.honorCode+p⟩).1.h
    else none)
  for line in lines do
    if line.trimAscii.toString.isEmpty then continue
    let [ns,hs,cs,ss,bs] := line.trimAscii.toString.splitOn "\t"
      | throw (IO.userError "invalid catalog")
    let n ← number ns
    let h ← number hs
    let code ← number cs
    let size ← number ss
    let blocks ← number bs
    if h ≥ 184 || code ≥ 78125 then throw (IO.userError "catalog outside inventory")
    if n = layer+1 && needed.contains code then
      let b ← loadBucket indexRoot dataRoot numeric ids groups n h code size blocks
      buckets := buckets.set! h b
  if start+count > source.data.size then throw (IO.userError "range exceeds source bucket")
  let original := GeneralIndex.target ids honors buckets
  let next : GeneralLayer.Target := {original with locate := fun s =>
    {original.locate s with restore := []}}
  let loaded ← IO.monoNanosNow
  let targetIds := (List.range 184).filter (fun h => decide ((buckets.getD h emptyBucket).data.size > 0))
  let mut tasks : Array (Task (Except IO.Error Nat)) := #[]
  for w in [0:threads] do
    let first := start+count*w/threads
    let stop := start+count*(w+1)/threads
    let task ← IO.asTask (scan tables next source first (stop-first)) .dedicated
    tasks := tasks.push task
  let mut workerNanos : Nat := 0
  for task in tasks do
    let ns ← IO.ofExcept (← IO.wait task)
    workerNanos := workerNanos+ns
  let stopped ← IO.monoNanosNow
  let result := "{\"schema\":\"LEAN_GENERAL_BUCKET_CHUNK_V1\",\"status\":\"PASS\",\"layer\":" ++
    toString layer ++ ",\"bucket\":" ++ toString bucket ++ ",\"start\":" ++ toString start ++
    ",\"count\":" ++ toString count ++ ",\"threads\":" ++ toString threads ++
    ",\"load_nanoseconds\":" ++ toString (loaded-loadStart) ++
    ",\"scan_nanoseconds\":" ++ toString (stopped-loaded) ++ ",\"worker_nanoseconds\":" ++ toString workerNanos ++
    ",\"target_buckets\":[" ++ String.intercalate "," (targetIds.map toString) ++ "]" ++
    ",\"full_table_Lean\":\"NOT_VERIFIED\",\"scope\":\"row equations and all physical references; target correctness supplied separately\"}\n"
  IO.FS.writeFile output result
  IO.println s!"PASS_GENERAL_BUCKET layer={layer} h={bucket} start={start} count={count} threads={threads}"
  return 0
