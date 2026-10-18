import Lean.Data.Json
import Mahjong.BlockPlanFastSource
import Mahjong.BlockPlanSoundness
import Mahjong.TemplatePlanCertifiedRow
import Mahjong.GeneratedPlanCheck
import Mahjong.CheckedPlanConstructor
import Mahjong.IndexedByteRowV16
import Mahjong.GuardedByteScanV16
import Mahjong.GeneratedLocalCache
import Mahjong.MaterializedLocal
import Mahjong.CompactHotRow
import Mahjong.IndexedByteStreamTransportV16
import PackedLabelSpan
import Mahjong.RowScheduleV13
import Mahjong.IndexedByteRowInputV16
set_option autoImplicit false
open Mahjong PackedRules
namespace JointIndexedFramesV16

abbrev OldBucket := GeneralIndex.Bucket

def number (s : String) : IO Nat :=
  match s.toNat? with | some n => pure n | none => throw (IO.userError "invalid integer")

def stem (n h : Nat) : String :=
  "n" ++ (if n < 10 then "0" else "") ++ toString n ++ "_h" ++
    (if h < 10 then "00" else if h < 100 then "0" else "") ++ toString h

def loadBucket (indexRoot dataRoot : String) (numeric ids groups : ByteArray)
    (n h code size blocks : Nat) : IO OldBucket := do
  let name := stem n h
  let directory ← IO.FS.readBinFile (indexRoot ++ "/" ++ name ++ ".dir")
  let bits ← IO.FS.readBinFile (dataRoot ++ "/" ++ name ++ ".bits")
  if bits.size != (size+63)/64*8 || directory.size != blocks*32 || blocks = 0 then
    throw (IO.userError s!"bucket length mismatch: {name}")
  pure ⟨⟨numeric,ids,groups,directory,code,size⟩,bits⟩

def directoryKeys (directory : ByteArray) : Array Nat := Id.run do
  let mut keys := #[]
  for b in [:directory.size/32] do
    keys := keys.push (CanonicalInventory.read32 directory (b*32+16)*1104*1104+
      CanonicalInventory.read32 directory (b*32+20)*1104+CanonicalInventory.read32 directory (b*32+24))
  return keys

def proposeBlock (keys : Array Nat) (key : GroupCandidates.Triple) : Nat :=
  let k := key.1*1104*1104+key.2.1*1104+key.2.2
  BucketIndex.floorSearch (fun i => keys[i]!) k 64 0 keys.size

def zeroWord : BlockWordAddress.View := ⟨0,0,0,0,0,0,0,0,0⟩

/-- The producer is not trusted. Every field, the complete local next list,
    and both accepted and rejected SAFE decisions are checked by checkPlan. -/
structure PreparedCoverage where
  data : GroupNextCoverage.Data
  slots : Nat → Nat → Array Nat
  edgeCounts : Nat → Nat → Nat
  templateCounts : Nat → Nat → Nat
  actualEdges : Nat
  hotShared : BorrowedNextGeneratedHotPlan.Shared

def makeCoverage (localData : CachedPackedCheck.Local) (g : GroupInventory.Data) : IO PreparedCoverage := do
  let mut keyTables : Array (Array (List Nat)) := #[]
  let mut slotTables : Array (Array (Array Nat)) := #[]
  let mut edgeTables : Array (Array Nat) := #[]
  let mut templateTables : Array (Array Nat) := #[]
  let mut actualEdges := 0
  for b in [:4] do
    let domains := GroupNextCoverage.domainCount g localData b
    let capacity := if b < 3 then g.groups else (localData.inventories 3).count
    let targetBound := if b < 3 then g.count else (localData.inventories 3).count
    let mut keys : Array (List Nat) := #[]
    let mut slots : Array (Array Nat) := #[]
    let mut edgeCounts : Array Nat := #[]
    let mut templateCounts : Array Nat := #[]
    for k in [:domains] do
      let mut reached : Array Nat := #[]
      let mut lookup := Array.replicate capacity capacity
      let mut count := 0
      let first := GroupNextCoverage.rowFirst g b k
      let size := GroupNextCoverage.rowCount g b k
      for i in [first:first+size] do
        let next := (localData.edges b).next i
        count := count+next.length
        for j in next do
          let targetKey := TemplatePlanCheck.key g b j
          if j ≥ targetBound || targetKey ≥ capacity then
            throw (IO.userError "GLOBAL_COVERAGE_PRODUCER_DOMAIN_REJECTED")
          if lookup.getD targetKey capacity = capacity then
            lookup := lookup.set! targetKey reached.size
            reached := reached.push targetKey
      keys := keys.push reached.toList
      templateCounts := templateCounts.push reached.size
      slots := slots.push lookup
      edgeCounts := edgeCounts.push count
      actualEdges := actualEdges+count
    keyTables := keyTables.push keys
    slotTables := slotTables.push slots
    edgeTables := edgeTables.push edgeCounts
    templateTables := templateTables.push templateCounts
  let data : GroupNextCoverage.Data := ⟨fun b k => (keyTables.getD b #[]).getD k []⟩
  let result : PreparedCoverage := ⟨data,
    (fun b k => (slotTables.getD b #[]).getD k #[]),
    (fun b k => (edgeTables.getD b #[]).getD k 0),
    (fun b k => (templateTables.getD b #[]).getD k 0),actualEdges,BorrowedNextGeneratedHotPlan.buildShared g localData⟩
  if !GroupNextCoverage.check g localData result.data then
    throw (IO.userError "GLOBAL_ACTUAL_NEXT_COVERAGE_REJECTED")
  return result

def diagnosticWork (localData : CachedPackedCheck.Local) (coverage : PreparedCoverage)
    (g : GroupInventory.Data) (ctx : BlockPlanCheck.Context) : Nat × Nat × Nat := Id.run do
  let mut rows := 1
  let mut edges := 0
  let mut templates := 0
  for b in [:4] do
    let k := GeneratedPlanCheck.sourceKey localData ctx b
    edges := edges+coverage.edgeCounts b k
    templates := templates+coverage.templateCounts b k
    if b < 3 then rows := rows+g.size k
  return (rows,edges,templates)

/-- The proposal cannot set SAFE or supply an unchecked offset/view. -/
def targetProposal (bank : @& BlockPlanCheck.Bank) (honors : @& ByteArray)
    (keys : @& Array (Array Nat)) : CheckedPlanConstructor.Proposal :=
  let g := BlockPlanCheck.groupData bank
  fun q =>
    let h := CanonicalInventory.read32 honors (q.h*4)
    (h,proposeBlock (keys.getD h #[]) (BlockPlanCheck.groupKey g q))

@[noinline] def prepareCheckedIO (localData : CachedPackedCheck.Local) (bank : BlockPlanCheck.Bank)
    (coverage : PreparedCoverage) (source : IndexOperations.Data) (ctx : BlockPlanCheck.Context)
    (honors : ByteArray) (keys : Array (Array Nat)) :
    IO (Option (CheckedPlanConstructor.CheckedPlan localData bank source ctx coverage.data)) :=
  pure (CheckedPlanConstructor.preparePlan localData bank source ctx coverage.data
    (targetProposal bank honors keys) coverage.slots)

/-- Fixed before measurement: small complete plans use one preparation task.
All row tasks and all source blocks/keys are unchanged. -/
def planWorkerCount (threads blocks completeTemplates : Nat) : Nat :=
  if completeTemplates ≤ 4096 then min 1 blocks else min threads blocks

@[noinline] def buildHotIO (localData : CachedPackedCheck.Local) (bank : BlockPlanCheck.Bank)
    (coverage : PreparedCoverage) (ctx : BlockPlanCheck.Context)
    (tables : GeneratedPlanCheck.Tables) : IO BorrowedNextGeneratedHotPlan.Snapshot :=
  pure (BorrowedNextGeneratedHotPlan.buildWithShared localData bank ctx tables coverage.hotShared)

def corruptPlan (mode : String) (plan : BlockPlanCheck.Plan) : BlockPlanCheck.Plan :=
  if mode.isEmpty then plan else ⟨fun b i =>
    let es := plan.rows b i
    if mode = "drop_edge" then es.drop 1 else
      es.map fun e =>
        if mode = "flip_safe" then {e with safe := !e.safe}
        else if mode = "bad_word_offset" && e.safe then {e with word := {e.word with offset := e.word.offset+1}}
        else e⟩

structure ActivePlan where
  ctx : BlockPlanCheck.Context
  sourceView : SourceBlockGuard.View
  hot : BorrowedNextGeneratedHotPlan.Snapshot

def emptyHotTable : BorrowedNextGeneratedHotPlan.Table := ⟨#[],#[]⟩

def emptyActive : ActivePlan :=
  ⟨⟨0,0,(0,0,0),0⟩,⟨zeroWord,(0,0,0)⟩,BorrowedNextGeneratedHotPlan.empty⟩

/-- These intervals are proposals, independently checked by the original
adjacent-cover checker before the hot loop executes. No source row can be
silently omitted by a wrong block boundary. -/
def blockRuns (source : @& OldBucket) (plans : @& Array ActivePlan)
    (firstBlock first count : Nat) : IO (Array (Nat × RowScheduleV13.Chunk)) := do
  let mut runs := #[]
  let mut cursor := first
  let mut block := BucketIndex.blockAt source.data first
  while cursor < first+count do
    if block < firstBlock || block-firstBlock ≥ plans.size then
      throw (IO.userError "BYTE_CURSOR_PLAN_BLOCK_OUTSIDE_FRAME")
    let stop := min (first+count) (if block+1-firstBlock < plans.size then
      (plans.getD (block+1-firstBlock) emptyActive).sourceView.word.offset.toNat
      else source.data.size)
    if stop ≤ cursor then throw (IO.userError "BYTE_CURSOR_NONPOSITIVE_BLOCK_RUN")
    runs := runs.push (block,⟨cursor,stop-cursor⟩)
    cursor := stop
    block := block+1
  if !RowScheduleV13.checkCover (runs.toList.map (fun x => x.2)) first (first+count) then
    throw (IO.userError "BYTE_CURSOR_BLOCK_RUN_COVER_REJECTED")
  return runs

/-- A proposal only. Every proposed coordinate is independently checked against
the original absolute source r before any row is accepted. a is the fastest
coordinate in all four frozen within_sorted layouts. -/
@[inline] def nextIds (view : @& SourceBlockGuard.View)
    (a b c : Nat) : GroupCandidates.Triple :=
  let x := a-view.word.firstA
  let y := b-view.word.firstB
  let z := c-view.word.firstC
  let (nx,ny,nz) := if view.word.a = view.word.c then
      if x < y then (x+1,y,z) else if y < z then (0,y+1,z) else (0,0,z+1)
    else if view.word.a = view.word.b then
      if x < y then (x+1,y,z) else if y+1 < view.sizes.1 then (0,y+1,z) else (0,0,z+1)
    else if view.word.b = view.word.c then
      if x+1 < view.sizes.1 then (x+1,y,z) else if y < z then (0,y+1,z) else (0,0,z+1)
    else
      if x+1 < view.sizes.1 then (x+1,y,z) else if y+1 < view.sizes.2.1 then (0,y+1,z) else (0,0,z+1)
  (view.word.firstA+nx,view.word.firstB+ny,view.word.firstC+nz)

/-- Reuse a borrowed prepared plan for an entire checked block run. Coordinates
are proposals, sourceP is always read from the immutable actual source bits.
All rows still execute the original range/order/rank-address guard. -/
def part (bank : @& BlockPlanCheck.Bank) (source : @& OldBucket) (plans : @& Array ActivePlan)
    (firstBlock : Nat) (compact : @& ByteArray) (start first count : Nat) : IO (Nat × Nat) := do
  if count = 0 then return (0,0)
  let runs ← blockRuns source plans firstBlock first count
  let mut p := 0
  for run in runs do
    let active := plans.getD (run.1-firstBlock) emptyActive
    let initial := BucketIndex.decodeIds source.data run.2.first
    match Mahjong.GuardedByteScanV16.scan active.hot active.sourceView active.ctx source.bits compact start
        run.2.count run.2.first initial.1 initial.2.1 initial.2.2 p with
    | .error i => throw (IO.userError s!"REJECTED_INDEXED_BYTE_ROW index={i}")
    | .ok acceptedP => p := acceptedP
  return (p,runs.size)

structure ScheduledChunk where
  chunk : Nat
  first : Nat
  count : Nat
  deriving Lean.ToJson

structure WorkerReport where
  worker : Nat
  wall_ns : Nat
  P_rows : Nat
  N_rows : Nat
  assigned_rows : Nat
  chunk_count : Nat
  nonempty_chunks : Nat
  source_cursor_initializations : Nat
  chunks : Array ScheduledChunk
  deriving Lean.ToJson

structure BatchResult where
  wallNs : Nat
  p : Nat
  workers : Array WorkerReport
  initializations : Nat
  cursorInitializations : Nat

def makeSchedule (start count threads rounds : Nat) : List RowScheduleV13.Chunk := Id.run do
  let mut chunks := #[]
  let total := threads*rounds
  for k in [:total] do
    let first := start+count*k/total
    let stop := start+count*(k+1)/total
    chunks := chunks.push ⟨first,stop-first⟩
  return chunks.toList

/-- All buffers are independently allocated from consecutive wire bytes.
The parent retains this array until every actual checker task has joined. -/
structure FragmentedPayload where
  schedule : List RowScheduleV13.Chunk
  buffers : Array ByteArray
  totalBytes : Nat
  maximumPieceBytes : Nat

def validatePayload (payload : @& FragmentedPayload) (start count threads rounds : Nat) : Bool :=
  threads == 12 && rounds == 1 && payload.buffers.size == threads &&
  payload.totalBytes == count &&
  RowScheduleV13.checkSchedule payload.schedule start count threads rounds &&
  (List.range threads).all (fun w =>
    (payload.buffers.getD w ByteArray.empty).size ==
      (RowScheduleV13.get payload.schedule w).count &&
    decide ((RowScheduleV13.get payload.schedule w).count ≤ 5592406))

/-- Read each original schedule chunk directly into its own storage. The wire
is count bytes, immediately followed by the original24-byte marker.
No task is spawned until this function has checked the complete marker. -/
def readPayload (input : IO.FS.Stream) (start count : Nat) : IO FragmentedPayload := do
  if count = 0 || count > Mahjong.IndexedByteStreamTransportV16.countCap then
    throw (IO.userError "INDEXED_BYTE_INPUT_COUNT_LIMIT")
  let schedule := makeSchedule start count 12 1
  if !RowScheduleV13.checkSchedule schedule start count 12 1 then
    throw (IO.userError "INDEXED_BYTE_INPUT_SCHEDULE_REJECTED")
  let mut buffers : Array ByteArray := #[]
  let mut totalBytes := 0
  let mut maximumPieceBytes := 0
  for w in [:12] do
    let piece := RowScheduleV13.get schedule w
    if piece.count > 5592406 then
      throw (IO.userError "INDEXED_BYTE_INPUT_SINGLE_ALLOCATION_CAP")
    let pieceBytes ← Mahjong.IndexedByteStreamTransportV16.readExact input (piece.count) "COMPACT_FRAGMENT"
    if pieceBytes.size != piece.count then
      throw (IO.userError "INDEXED_BYTE_INPUT_PIECE_LENGTH")
    totalBytes := totalBytes+pieceBytes.size
    maximumPieceBytes := max maximumPieceBytes pieceBytes.size
    buffers := buffers.push pieceBytes
  let payload := FragmentedPayload.mk schedule buffers totalBytes maximumPieceBytes
  if !validatePayload payload start count 12 1 then
    throw (IO.userError "INDEXED_BYTE_INPUT_TOTAL_OR_PARTITION")
  Mahjong.IndexedByteStreamTransportV16.finishPayload input
  return payload

def workerPart (bank : @& BlockPlanCheck.Bank) (source : @& OldBucket) (plans : @& Array ActivePlan)
    (firstBlock : Nat) (compact : @& ByteArray) (start threads rounds worker : Nat)
    (schedule : @& List RowScheduleV13.Chunk) : IO WorkerReport := do
  let began ← IO.monoNanosNow
  let mut p := 0
  let mut assigned := 0
  let mut initialized := 0
  let mut cursors := 0
  let mut chunks := #[]
  for r in [:rounds] do
    let k := worker+r*threads
    let piece := RowScheduleV13.get schedule k
    let checked ← part bank source plans firstBlock compact start piece.first piece.count
    p := p+checked.1
    cursors := cursors+checked.2
    assigned := assigned+piece.count
    if piece.count > 0 then initialized := initialized+1
    chunks := chunks.push ⟨k,piece.first,piece.count⟩
  let wall := (← IO.monoNanosNow)-began
  return ⟨worker,wall,p,assigned-p,assigned,rounds,initialized,cursors,chunks⟩

def batch (bank : BlockPlanCheck.Bank) (source : OldBucket) (plans : Array ActivePlan)
    (firstBlock : Nat) (payload : FragmentedPayload) (start count threads rounds : Nat) : IO BatchResult := do
  let began ← IO.monoNanosNow
  if !validatePayload payload start count threads rounds then
    throw (IO.userError "INDEXED_BYTE_BATCH_PAYLOAD_OR_SCHEDULE_REJECTED")
  let schedule := payload.schedule
  let mut tasks : Array (Task (Except IO.Error WorkerReport)) := #[]
  let mut failure : Option IO.Error := none
  try
    for w in [:threads] do
      let piece := RowScheduleV13.get schedule w
      -- Capture this one ByteArray, never the payload/buffers array or a slice
      -- of a shared whole-frame backing allocation. round1 is checked above.
      let pieceBytes := payload.buffers.getD w ByteArray.empty
      let task ← IO.asTask
        (workerPart bank source plans firstBlock pieceBytes piece.first threads rounds w schedule) .default
      tasks := tasks.push task
  catch error => failure := some error
  let mut p := 0
  let mut assigned := 0
  let mut initialized := 0
  let mut cursors := 0
  let mut workers := #[]
  -- Even an ordinary task-spawn or task-body error joins every created task.
  -- Uncatchable process failure yields no result and is handled by the scope.
  for task in tasks do
    match ← IO.wait task with
    | .error error => failure := some error
    | .ok checked =>
      p := p+checked.P_rows
      assigned := assigned+checked.assigned_rows
      initialized := initialized+checked.nonempty_chunks
      cursors := cursors+checked.source_cursor_initializations
      workers := workers.push checked
  if let some error := failure then throw error
  if assigned != count || p > count || workers.size != threads then
    throw (IO.userError "ROW_SCHEDULE_RESULT_ACCOUNTING_REJECTED")
  return ⟨(← IO.monoNanosNow)-began,p,workers,initialized,cursors⟩



open Lean (toJson)

structure PreparedPlans where
  plans : Array ActivePlan
  rawNs : Nat
  checkNs : Nat
  hotNs : Nat
  rows : Nat
  edges : Nat
  templates : Nat
  reused : Nat

def preparePart (localData : CachedPackedCheck.Local) (bank : BlockPlanCheck.Bank)
    (coverage : PreparedCoverage) (sourceModel : IndexOperations.Data) (source : OldBucket) (honors : ByteArray)
    (keys : Array (Array Nat)) (bucket first stop : Nat)
    (previous : Option (Nat × ActivePlan)) : IO PreparedPlans := do
  let mut plans : Array ActivePlan := #[]
  let mut rawNs := 0
  let mut checkNs := 0
  let mut hotNs := 0
  let mut rows := 0
  let mut edges := 0
  let mut templates := 0
  let mut reused := 0
  for b in [first:stop] do
    if let some (savedBlock,savedPlan) := previous then
      if b = savedBlock then
        plans := plans.push savedPlan
        reused := reused+1
        continue
    let began ← IO.monoNanosNow
    let ctx : BlockPlanCheck.Context := ⟨bucket,b,sourceModel.key b,source.data.honorCode⟩
    let g := BlockPlanCheck.groupData bank
    let work := diagnosticWork localData coverage g ctx
    let view := SourceBlockGuard.ofModel sourceModel b
    rawNs := rawNs+(← IO.monoNanosNow)-began
    let checking ← IO.monoNanosNow
    let made ← prepareCheckedIO localData bank coverage sourceModel ctx honors keys
    let checked ← match made with
      | none => throw (IO.userError s!"REJECTED_CHECKED_TEMPLATE_CONSTRUCTOR source_block={b}")
      | some prepared => pure prepared
    if !SourceBlockGuard.check sourceModel ctx.sourceBlock view then
      throw (IO.userError s!"REJECTED_BLOCK_SOURCE_VIEW source_block={b}")
    checkNs := checkNs+(← IO.monoNanosNow)-checking
    let hotStart ← IO.monoNanosNow
    let hot ← buildHotIO localData bank coverage ctx checked.val
    hotNs := hotNs+(← IO.monoNanosNow)-hotStart
    rows := rows+work.1
    edges := edges+work.2.1
    templates := templates+work.2.2
    plans := plans.push ⟨ctx,view,hot⟩
  pure ⟨plans,rawNs,checkNs,hotNs,rows,edges,templates,reused⟩

def preparePlans (localData : CachedPackedCheck.Local) (bank : BlockPlanCheck.Bank)
    (coverage : PreparedCoverage) (sourceModel : IndexOperations.Data) (source : OldBucket) (honors : ByteArray)
    (keys : Array (Array Nat)) (bucket first stop threads completeTemplates : Nat)
    (previous : Option (Nat × ActivePlan)) : IO PreparedPlans := do
  let workers := planWorkerCount threads (stop-first) completeTemplates
  if workers = 1 then
    return (← preparePart localData bank coverage sourceModel source honors keys bucket first stop previous)
  let mut tasks : Array (Task (Except IO.Error PreparedPlans)) := #[]
  for w in [:workers] do
    let begin := first+(stop-first)*w/workers
    let endBlock := first+(stop-first)*(w+1)/workers
    let task ← IO.asTask (preparePart localData bank coverage sourceModel source honors keys bucket begin endBlock previous) .default
    tasks := tasks.push task
  let mut result : PreparedPlans := ⟨#[],0,0,0,0,0,0,0⟩
  let mut failure : Option IO.Error := none
  for task in tasks do
    match ← IO.wait task with
    | .error error => failure := some error
    | .ok part =>
      result := ⟨result.plans++part.plans,result.rawNs+part.rawNs,result.checkNs+part.checkNs,
        result.hotNs+part.hotNs,result.rows+part.rows,result.edges+part.edges,
        result.templates+part.templates,result.reused+part.reused⟩
  if let some error := failure then throw error
  pure result

def jsonNat (j : Lean.Json) (key : String) : IO Nat :=
  match j.getObjVal? key >>= Lean.Json.getNat? with
  | .ok n => pure n
  | .error message => throw (IO.userError ("command field " ++ key ++ ": " ++ message))

def jsonString (j : Lean.Json) (key : String) : IO String :=
  match j.getObjVal? key >>= Lean.Json.getStr? with
  | .ok value => pure value
  | .error message => throw (IO.userError ("command field " ++ key ++ ": " ++ message))

def emit (fields : List (String × Lean.Json)) : IO Unit := do
  let out ← IO.getStdout
  out.putStrLn (Lean.Json.mkObj fields).compress
  out.flush

/-- Diagnostics only, emitted on stderr so the accepted stdout protocol is unchanged. -/
def phase (stage : String) (start count blocks rows edges : Nat) : IO Unit := do
  let err ← IO.getStderr
  err.putStrLn (Lean.Json.mkObj [("event",.str "NATIVE_PHASE"),("stage",.str stage),
    ("start",toJson start),("count",toJson count),("blocks",toJson blocks),
    ("plan_rows",toJson rows),("plan_edges",toJson edges),
    ("mono_ns",toJson (← IO.monoNanosNow))]).compress
  err.flush

/-- Resource accounting only. Complete reachable keys, including unsafe keys,
are counted once for each source block and axis. No actual edge is expanded or
omitted by this guard. Counts are cached with the checked global coverage. -/
def fullSpanTemplates (localData : CachedPackedCheck.Local) (coverage : PreparedCoverage)
    (sourceModel : IndexOperations.Data) (source : OldBucket) (bucket first stop : Nat) : Nat := Id.run do
  let mut templates := 0
  for block in [first:stop] do
    let ctx : BlockPlanCheck.Context := ⟨bucket,block,sourceModel.key block,source.data.honorCode⟩
    for axis in [:4] do
      templates := templates+coverage.templateCounts axis (GeneratedPlanCheck.sourceKey localData ctx axis)
  return templates

def runSpan (localData : CachedPackedCheck.Local) (bank : BlockPlanCheck.Bank)
    (coverage : PreparedCoverage) (sourceModel : IndexOperations.Data) (source : OldBucket) (rawTables : FullSafeData.Tables)
    (reference : GeneralLayer.Target) (honors : ByteArray) (keys : Array (Array Nat))
    (layer bucket threads rowRounds metadataNs sharedLoadNs sharedAttribution start count proposalReadNs : Nat)
    (payload : @& FragmentedPayload) (runReference : Bool) (output : String)
    (previous : Option (Nat × ActivePlan)) : IO (Nat × Option (Nat × ActivePlan)) := do
  if count = 0 || count > Mahjong.IndexedByteStreamTransportV16.countCap || start+count > source.data.size then
    throw (IO.userError "resident source span outside bounded bucket")
  if (← System.FilePath.pathExists output) || (← System.FilePath.pathExists (output ++ ".labels.bin")) then
    throw (IO.userError "output exists; resume controller must verify and omit committed spans")
  let fault := ""
  if !validatePayload payload start count threads rowRounds then
    throw (IO.userError "INDEXED_BYTE_INTERNAL_PAYLOAD_OR_SCHEDULE")
  phase "SPAN_BEGIN" start count 0 0 0
  let referenceStart ← IO.monoNanosNow
  let referenceCount := if runReference then min count 64 else 0
  for j in [:referenceCount] do
    let i := start+count*j/referenceCount
    if !GeneralIndex.row (FullSafeData.summaries rawTables) reference source i then
      throw (IO.userError s!"REJECTED_OLD_REFERENCE index={i}")
  let referenceNs := (← IO.monoNanosNow)-referenceStart
  let planPhaseStart ← IO.monoNanosNow
  let firstBlock := BucketIndex.blockAt source.data start
  let lastBlock := BucketIndex.blockAt source.data (start+count-1)
  if lastBlock-firstBlock+1 > Mahjong.IndexedByteStreamTransportV16.blockCap then
    throw (IO.userError "LARGE_FRAME_SOURCE_BLOCK_BUDGET_REJECTED")
  let fullTemplates := fullSpanTemplates localData coverage sourceModel source bucket firstBlock (lastBlock+1)
  if fullTemplates > Mahjong.IndexedByteStreamTransportV16.templateCap then
    throw (IO.userError "LARGE_FRAME_COMPLETE_TEMPLATE_BUDGET_REJECTED")
  phase "PLAN_BEGIN" start count (lastBlock-firstBlock+1) 0 0
  let prepared ← preparePlans localData bank coverage sourceModel source honors keys bucket firstBlock (lastBlock+1) threads fullTemplates previous
  let planPhaseWallNs := (← IO.monoNanosNow)-planPhaseStart
  let plans := prepared.plans
  let planBuildNs := prepared.rawNs
  let planCheckNs := prepared.checkNs
  let hotBuildNs := prepared.hotNs
  let planRows := prepared.rows
  let planEdges := prepared.edges
  let reused := prepared.reused
  phase "PLAN_DONE_ROW_BEGIN" start count plans.size planRows planEdges
  let rowResult ← batch bank source plans firstBlock payload start count threads rowRounds
  let rowNs := rowResult.wallNs
  let p := rowResult.p
  phase "ROW_DONE_SAVE_BEGIN" start count plans.size planRows planEdges
  let workNs := planPhaseWallNs+rowNs
  let saveStart ← IO.monoNanosNow
  let labels := PackedLabelSpan.build source.bits start count
  IO.FS.writeBinFile (output ++ ".labels.bin.tmp") labels
  IO.FS.rename (output ++ ".labels.bin.tmp") (output ++ ".labels.bin")
  let result := "{\"schema\":\"PACKED_INDEXED_BYTE_FRAME_LEAN_PERSISTENT_SPAN_V16\",\"status\":\"PASS_COMPILED_LEAN_PACKED_INDEXED_BYTE_FRAME_PERSISTENT_SPAN_V16\",\"layer\":" ++
    toString layer ++ ",\"honor\":" ++ toString bucket ++ ",\"start\":" ++ toString start ++
    ",\"count\":" ++ toString count ++ ",\"resident_count_cap\":67108864,\"resident_mode\":true,\"transport\":\"indexed_actual_next_byte_v16\"" ++
    ",\"large_frame_policy\":\"BOUNDED_64MI_ROWS_COMPLETE_T_INDEXED_BYTE_V16\",\"frame_block_cap\":8192,\"frame_template_cap\":500000,\"native_epoch_frame_cap\":16" ++
    ",\"frame_full_templates_without_reuse\":" ++ toString fullTemplates ++ ",\"frame_template_count_includes_SAFE_and_unsafe\":true" ++
    ",\"runtime_task_mode\":\"REGULAR_POOL\",\"phase_diagnostics\":\"STDERR_JSONL\"" ++
    ",\"input_memory_lifetime\":\"MAIN_PIECE_OWNERS_UNTIL_ALL_TASKS_JOIN_V16\"" ++
    ",\"input_fragment_count\":12,\"input_fragment_max_bytes\":" ++ toString payload.maximumPieceBytes ++
    ",\"label_format\":\"PACKED_LSB0\",\"label_bytes\":" ++ toString labels.size ++
    ",\"label_valid_bits\":" ++ toString count ++ ",\"label_padding_bits\":" ++ toString ((8-count%8)%8) ++
    ",\"checked_rows\":" ++ toString count ++ ",\"P_rows\":" ++ toString p ++ ",\"N_rows\":" ++ toString (count-p) ++
    ",\"load_ns\":" ++ toString (proposalReadNs+sharedAttribution) ++ ",\"metadata_check_ns\":" ++ toString (if sharedAttribution > 0 then metadataNs else 0) ++
    ",\"plan_phase_wall_ns\":" ++ toString planPhaseWallNs ++ ",\"plan_prepare_workers\":" ++ toString (planWorkerCount threads (lastBlock-firstBlock+1) fullTemplates) ++
    ",\"template_plan_checker\":true,\"plan_checker_kind\":\"PROVED_BORROWED_NEXT_GLOBAL_NEXT_GENERATED_PLAN_V12\",\"actual_successors_all_checked\":true,\"plan_templates\":" ++ toString prepared.templates ++ ",\"producer_cache_hits\":" ++ toString (prepared.edges-prepared.templates) ++
    ",\"plan_constructor_kind\":\"PROVED_ONCE_CHECKED_TEMPLATE_CONSTRUCTOR_V16\",\"small_plan_serial_template_threshold\":4096" ++
    ",\"constructor_build_and_check_task_sum_ns\":" ++ toString planCheckNs ++ ",\"plan_check_ns_includes_constructor_build\":true,\"raw_plan_build_ns_is_context_only\":true" ++
    ",\"row_checker_kind\":\"PROVED_INDEXED_NEXT_BYTE_SCALAR_SCAN_V16\",\"pure_checker_theorem_fingerprints\":104" ++
    ",\"plan_component_timing\":\"PARALLEL_TASK_SUMS_NOT_WALL\",\"raw_plan_build_ns\":" ++ toString planBuildNs ++ ",\"hot_snapshot_build_ns\":" ++ toString hotBuildNs ++
    ",\"shared_load_ns\":" ++ toString sharedLoadNs ++ ",\"shared_load_attributed_ns\":" ++ toString sharedAttribution ++
    ",\"proposal_load_ns\":" ++ toString proposalReadNs ++ ",\"stream_payload_read_ns\":" ++ toString proposalReadNs ++
    ",\"compact_bytes\":" ++ toString payload.totalBytes ++ ",\"payload_end_bytes\":24,\"plans_reused\":" ++ toString reused ++
    ",\"plan_build_ns\":" ++ toString (planBuildNs+hotBuildNs) ++ ",\"plan_check_ns\":" ++ toString planCheckNs ++
    ",\"hot_ns\":" ++ toString rowNs ++ ",\"work_ns\":" ++ toString workNs ++
    ",\"row_scan_ns\":" ++ toString rowNs ++ ",\"scan_ns\":" ++ toString workNs ++
    ",\"effective_work_ns\":" ++ toString workNs ++ ",\"scan_includes_plan_build_and_check\":true,\"plan_blocks\":" ++
    toString plans.size ++ ",\"plan_rows\":" ++ toString planRows ++ ",\"plan_edges\":" ++ toString planEdges ++
    ",\"reference_rows\":" ++ toString referenceCount ++ ",\"reference_ns\":" ++ toString referenceNs ++ ",\"reference_policy\":\"ONCE_FIRST_SPAN_PER_BUCKET_DIAGNOSTIC\"" ++
    ",\"threads\":" ++ toString threads ++ ",\"gpu_witness_mode\":true,\"gpu_source_packet_mode\":false,\"compact_word_mode\":false,\"indexed_byte_mode\":true,\"source_r_guard_every_row\":true,\"source_block_cover_checked\":true" ++
    ",\"row_schedule_kind\":\"PROVED_CONTIGUOUS_PARTITION_STRIDED_FIXED_ROUNDS_V13\",\"row_rounds\":" ++ toString rowRounds ++
    ",\"row_partition_checked\":true,\"row_partition_chunks\":" ++ toString (threads*rowRounds) ++
    ",\"row_worker_diagnostics\":" ++ (Lean.toJson rowResult.workers).compress ++
    ",\"per_row_timing_or_sampling_added\":false" ++
    ",\"source_decode_calls_kind\":\"ONCE_PER_CHECKED_SOURCE_BLOCK_RUN\",\"source_decode_calls\":" ++ toString rowResult.cursorInitializations ++ ",\"worker_nonempty_chunk_initializations\":" ++ toString rowResult.initializations ++
    ",\"source_roundtrips\":0,\"child_roundtrips\":0,\"save_ns\":" ++ toString ((← IO.monoNanosNow)-saveStart) ++
    ",\"full_table_Lean\":\"NOT_VERIFIED\"}\n"
  IO.FS.writeFile (output ++ ".tmp") result
  IO.FS.rename (output ++ ".tmp") output
  phase "SPAN_RESULT_WRITTEN" start count plans.size planRows planEdges
  pure (p,some (lastBlock,plans.getD (plans.size-1) emptyActive))

def run (rowRounds : Nat) (args : List String) : IO UInt32 := do
  if rowRounds != 1 then
    throw (IO.userError "indexed byte candidate supports only fixed round1")
  let [cacheRoot,rawRoot,inventoryRoot,indexRoot,successorRoot,dataRoot,catalog,
      layerText,bucketText,threadsText] := args
    | throw (IO.userError "cache raw inventory index successor data catalog layer honor threads; framed binary stdin")
  let layer ← number layerText
  let bucket ← number bucketText
  let threads ← number threadsText
  if threads != 12 then throw (IO.userError "indexed byte candidate requires exactly12 workers")
  let loadStart ← IO.monoNanosNow
  let numericCore ← IO.FS.readBinFile (cacheRoot ++ "/numeric.bin")
  let honorCore ← IO.FS.readBinFile (cacheRoot ++ "/honors.bin")
  let numericSummary ← IO.FS.readBinFile (cacheRoot ++ "/summary_numeric.bin")
  let honorSummary ← IO.FS.readBinFile (cacheRoot ++ "/summary_honors.bin")
  let rawNumeric ← IO.FS.readBinFile (rawRoot ++ "/raw_numeric.bin")
  let rawHonor ← IO.FS.readBinFile (rawRoot ++ "/raw_honors.bin")
  if numericCore.size != 1953125 || honorCore.size != 78125 || numericSummary.size != 7812500 ||
      honorSummary.size != 312500 || rawNumeric.size != 1953125*12 || rawHonor.size != 78125*12 then
    throw (IO.userError "raw/summary length mismatch")
  let rawTables : FullSafeData.Tables := fun b => PruningData.candidate b
    (if b = 3 then honorCore else numericCore) (if b = 3 then honorSummary else numericSummary)
    (if b = 3 then rawHonor else rawNumeric)
  let idsNumeric ← IO.FS.readBinFile (inventoryRoot ++ "/ids_numeric.bin")
  let idsHonor ← IO.FS.readBinFile (inventoryRoot ++ "/ids_honors.bin")
  let membersNumeric ← IO.FS.readBinFile (inventoryRoot ++ "/members_numeric.bin")
  let membersHonor ← IO.FS.readBinFile (inventoryRoot ++ "/members_honors.bin")
  let successorsNumeric ← IO.FS.readBinFile (successorRoot ++ "/numeric.bin")
  let successorsHonor ← IO.FS.readBinFile (successorRoot ++ "/honors.bin")
  if idsNumeric.size != 1953125*4 || idsHonor.size != 78125*4 || membersNumeric.size != 131676*4 ||
      membersHonor.size != 184*4 || successorsNumeric.size != 131676*44 || successorsHonor.size != 184*24 then
    throw (IO.userError "inventory/successor length mismatch")
  let unmaterialized : CachedPackedCheck.Local := ⟨rawTables,
    (fun b => CanonicalInventory.candidate b (if b = 3 then rawHonor else rawNumeric)
      (if b = 3 then idsHonor else idsNumeric) (if b = 3 then membersHonor else membersNumeric)),
    (fun b => SuccessorCache.candidate b (if b = 3 then successorsHonor else successorsNumeric))⟩
  let nextCache := GeneratedLocalCache.build unmaterialized
  let cachedLocal := GeneratedLocalCache.use unmaterialized nextCache
  let views := MaterializedLocal.build cachedLocal
  let localData := MaterializedLocal.use views
  let numeric ← IO.FS.readBinFile (indexRoot ++ "/numeric.bin")
  let ids ← IO.FS.readBinFile (indexRoot ++ "/numeric_ids.bin")
  let groups ← IO.FS.readBinFile (indexRoot ++ "/groups.bin")
  let honors ← IO.FS.readBinFile (indexRoot ++ "/honor_ids.bin")
  if numeric.size != 131676*12 || ids.size != 1953125*4 || groups.size != 1104*8 || honors.size != 78125*4 then
    throw (IO.userError "index length mismatch")
  let mut source := GeneralIndex.emptyBucket
  let mut oldBuckets := Array.replicate 184 GeneralIndex.emptyBucket
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
  if source.data.size = 0 then
    throw (IO.userError "source span outside bucket")
  let needed := bucket :: (localData.edges 3).next bucket
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
    if n = layer+1 && needed.contains h then
      oldBuckets := oldBuckets.set! h (← loadBucket indexRoot dataRoot numeric ids groups n h code size blocks)
  let mut infoBuckets : Array BlockPlanCheck.Bucket := #[]
  let mut keys : Array (Array Nat) := #[]
  for h in [:184] do
    let old := oldBuckets.getD h GeneralIndex.emptyBucket
    if old.data.size > 0 && old.data.honorCode != (localData.inventories 3).member h then
      throw (IO.userError s!"target catalog honor binding rejected bucket={h}")
    infoBuckets := infoBuckets.push ⟨old.data.directory,(localData.inventories 3).member h,old.data.size,old.bits⟩
    keys := keys.push (directoryKeys old.data.directory)
  let emptyInfo : BlockPlanCheck.Bucket := ⟨ByteArray.empty,0,0,ByteArray.empty⟩
  let bank : BlockPlanCheck.Bank := ⟨⟨numeric,ids,groups,rawNumeric,membersNumeric⟩,
    fun h => infoBuckets.getD h emptyInfo⟩
  let sourceModel := GuardedIndexAccess.model (BlockPlanCheck.groupData bank) source.data.directory source.data.size
  let coverageStart ← IO.monoNanosNow
  let coverage ← makeCoverage localData (BlockPlanCheck.groupData bank)
  let coverageNs := (← IO.monoNanosNow)-coverageStart
  let metadataStart ← IO.monoNanosNow
  if !(GuardedIndexAccess.check sourceModel && WordLimits.bucketFits sourceModel.directory.blocks source.data.size &&
      CanonicalInventory.checkSpan (IndexHelperCheck.groupRow groups) 0 1104) then
    throw (IO.userError "source directory finite checks rejected")
  for h in [:184] do
    if (bank.buckets h).size > 0 then
      let model := BlockPlanCheck.model bank h
      if !(GuardedIndexAccess.check model && WordLimits.bucketFits model.directory.blocks (bank.buckets h).size) then
        throw (IO.userError s!"target directory finite checks rejected bucket={h}")
  let metadataNs := (← IO.monoNanosNow)-metadataStart

  let reference := GeneralIndex.target ids honors oldBuckets
  let sharedLoadNs := (← IO.monoNanosNow)-loadStart
  emit [("event",.str "READY"),("schema",.str "INDEXED_BYTE_LARGE_FRAME_RESIDENT_PROTOCOL_V16"),
    ("record_bytes",.num 1),("plan_constructor_kind",.str "PROVED_ONCE_CHECKED_TEMPLATE_CONSTRUCTOR_V16"),
    ("small_plan_serial_template_threshold",.num 4096),
    ("row_checker_kind",.str "PROVED_INDEXED_NEXT_BYTE_SCALAR_SCAN_V16"),("pure_checker_theorem_fingerprints",.num 104),
    ("source_r_guard_every_row",.bool true),("source_block_cover_checked",.bool true),
    ("transport",.str Mahjong.IndexedByteStreamTransportV16.transport),("resident_count_cap",toJson Mahjong.IndexedByteStreamTransportV16.countCap),
    ("large_frame_policy",.str "BOUNDED_64MI_ROWS_COMPLETE_T_INDEXED_BYTE_V16"),
    ("input_fragment_count",toJson (12:Nat)),
    ("input_memory_lifetime",.str "MAIN_PIECE_OWNERS_UNTIL_ALL_TASKS_JOIN_V16"),
    ("frame_block_cap",toJson Mahjong.IndexedByteStreamTransportV16.blockCap),
    ("frame_template_cap",toJson Mahjong.IndexedByteStreamTransportV16.templateCap),
    ("native_epoch_frame_cap",toJson Mahjong.IndexedByteStreamTransportV16.epochFrameCap),
    ("layer",toJson layer),("honor",toJson bucket),("shared_load_ns",toJson sharedLoadNs),
    ("metadata_check_ns",toJson metadataNs),("coverage_check_ns",toJson coverageNs),
    ("global_actual_local_edges",toJson coverage.actualEdges),("threads",toJson threads),
    ("row_schedule_kind",.str "PROVED_CONTIGUOUS_PARTITION_STRIDED_FIXED_ROUNDS_V13"),("row_rounds",toJson rowRounds)]
  let input ← IO.getStdin
  let mut completed := 0
  let mut checked := 0
  let mut previous : Option (Nat × ActivePlan) := none
  while true do
    let line? ← Mahjong.IndexedByteStreamTransportV16.readLine input
    if line?.isNone then break
    let command ← Mahjong.IndexedByteStreamTransportV16.parseCommand (line?.getD "")
    match command with
    | .stop =>
      Mahjong.IndexedByteStreamTransportV16.requireEOF input
      break
    | .span span =>
      if completed ≥ Mahjong.IndexedByteStreamTransportV16.epochFrameCap then
        throw (IO.userError "LARGE_FRAME_NATIVE_EPOCH_LIMIT_REQUIRES_NORMAL_ROTATION")
      let start := span.start
      let count := span.count
      let output := span.output
      if start+count > source.data.size then throw (IO.userError "STREAM_SPAN_OUTSIDE_BUCKET")
      if (← System.FilePath.pathExists output) || (← System.FilePath.pathExists (output ++ ".labels.bin")) then
        throw (IO.userError "output exists; resume controller must verify and omit committed spans")
      let proposalStart ← IO.monoNanosNow
      let payload ← readPayload input start count
      let proposalReadNs := (← IO.monoNanosNow)-proposalStart
      let attributed := if completed = 0 then sharedLoadNs else 0
      let (p,lastPlan) ← runSpan localData bank coverage sourceModel source rawTables reference honors keys
        layer bucket threads rowRounds metadataNs sharedLoadNs attributed start count proposalReadNs
        payload (completed = 0) output previous
      previous := lastPlan
      phase "SPAN_RETURNED_IDLE" start count 0 0 0
      completed := completed+1
      checked := checked+count
      emit [("event",.str "SPAN_DONE"),("schema",.str "INDEXED_BYTE_LARGE_FRAME_RESIDENT_PROTOCOL_V16"),
        ("transport",.str Mahjong.IndexedByteStreamTransportV16.transport),
        ("output",.str output),("start",toJson start),("count",toJson count),
        ("P_rows",toJson p),("N_rows",toJson (count-p)),("completed_spans",toJson completed)]
  emit [("event",.str "STOPPED"),("schema",.str "INDEXED_BYTE_LARGE_FRAME_RESIDENT_PROTOCOL_V16"),
    ("completed_spans",toJson completed),("checked_rows",toJson checked)]
  return 0

end JointIndexedFramesV16
