import Lean.Data.Json
import Mahjong.V17NativeWorker
import JointIndexedFramesMainV16

set_option autoImplicit false

/-! Native IO for the unchanged V17 finite checks. Historical IO helpers are
used only for byte transport and untrusted coverage/target proposals. All
accepting row execution goes through V17NativeWorker/RuntimeScanV17. A native
receipt is execution evidence, not a serialized Lean proof. The external
finalizer binds streamed projections to one immutable complete input family. -/

namespace V17Compute
open Mahjong Lean
open V17NativeWorker
open CanonicalInventory

def emit (fields : List (String × Json)) : IO Unit := do
  let out ← IO.getStdout
  out.putStrLn (Json.mkObj fields).compress
  out.flush

def phase (name : String) (fields : List (String × Json) := []) : IO Unit := do
  let err ← IO.getStderr
  err.putStrLn (Json.mkObj (("event", .str "V17_PHASE") :: ("phase", .str name) ::
    ("mono_ns", toJson (← IO.monoNanosNow)) :: fields)).compress
  err.flush

def require {α : Type} (value : Except Failure α) : IO α :=
  match value with
  | .ok result => pure result
  | .error failure => throw (IO.userError (reprStr failure))

structure Config where
  cacheRoot : String
  rawRoot : String
  inventoryRoot : String
  indexRoot : String
  successorRoot : String
  dataRoot : String
  catalogFile : String
  boundRoot : String
  prefixRoot : String
  tripleLabelsFile : String
  targetIndexRoot : String
  targetDataRoot : String

def field (j : Json) (name : String) : IO String :=
  match j.getObjVal? name >>= Json.getStr? with
  | .ok text => pure text
  | .error err => throw (IO.userError s!"config {name}: {err}")

def optField (j : Json) (name fallback : String) : String :=
  match j.getObjVal? name >>= Json.getStr? with | .ok text => text | .error _ => fallback

def loadConfig (path : String) : IO Config := do
  let j ← match Json.parse (← IO.FS.readFile path) with
    | .ok result => pure result
    | .error err => throw (IO.userError err)
  let index ← field j "index_root"
  let data ← field j "data_root"
  return ⟨← field j "cache_root", ← field j "raw_root", ← field j "inventory_root",
    index, ← field j "successor_root", data, ← field j "catalog_file",
    ← field j "bound_root", ← field j "prefix_root", ← field j "triple_labels_file",
    optField j "target_index_root" index, optField j "target_data_root" data⟩

def bin (folder leaf : String) : IO ByteArray := IO.FS.readBinFile (folder ++ "/" ++ leaf)

def loadLocal (config : Config) (name : String) : IO FiniteCertificateV17.LocalFiles := do
  return ⟨← bin config.cacheRoot (name ++ ".bin"),
    ← bin config.cacheRoot ("summary_" ++ name ++ ".bin"),
    ← bin config.rawRoot ("raw_" ++ name ++ ".bin"),
    ← bin config.inventoryRoot ("ids_" ++ name ++ ".bin"),
    ← bin config.inventoryRoot ("members_" ++ name ++ ".bin")⟩

def loadBound (config : Config) (name : String) : IO FiniteCertificateV17.BoundFiles := do
  return ⟨← bin config.boundRoot (name ++ ".entries"), ← bin config.boundRoot (name ++ ".index")⟩

/-- Decode existing exported raw bytes. Header/extent guards are IO format
checks; semantic directory acceptance is the original V17 directoryChecks. -/
def loadHonor (config : Config) (h triples : Nat) : IO FiniteCertificateV17.HonorFiles := do
  let bytes ← bin config.prefixRoot s!"h{h}.bin"
  let mut cursor := 0
  let mut entries : Array HonorDirectory.Entry := #[]
  let mut inverse := Array.replicate triples (triples + 1)
  for n in [:35] do
    if cursor+32 > bytes.size then throw (IO.userError "truncated honor header")
    if PrefixData.read64 bytes cursor != 0x31524944584a4d || read32 bytes (cursor+8) != h ||
        read32 bytes (cursor+12) != n || read32 bytes (cursor+20) != 0 then
      throw (IO.userError s!"honor header mismatch {h}/{n}")
    let count := read32 bytes (cursor+16)
    cursor := cursor+32
    if count > triples || cursor+20*count > bytes.size then
      throw (IO.userError "truncated honor entries")
    for b in [:count] do
      let tid := read32 bytes (cursor+20*b)
      if tid ≥ triples || inverse[tid]! != triples+1 then
        throw (IO.userError "duplicate or out of range triple")
      inverse := inverse.set! tid entries.size
      entries := entries.push ⟨tid,n,PrefixData.read64 bytes (cursor+20*b+12)⟩
    cursor := cursor+20*count
  if cursor != bytes.size then throw (IO.userError "trailing honor directory bytes")
  return ⟨entries,inverse⟩

def loadFinite (config : Config) : IO FiniteCertificateV17.Inputs := do
  let numeric ← loadLocal config "numeric"
  let honor ← loadLocal config "honors"
  let keys ← bin config.prefixRoot "triples.bin"
  if keys.size % 12 != 0 then throw (IO.userError "partial triple key")
  let mut honors := #[]
  for h in [:184] do
    honors := honors.push (← loadHonor config h (keys.size/12))
    phase "LOAD_HONOR" [("honor",toJson h),("rows",toJson ((honors.getD h ⟨#[],#[]⟩).rows.size))]
  return ⟨numeric,honor,← bin config.indexRoot "numeric.bin",← bin config.indexRoot "groups.bin",
    ← loadBound config "num",← loadBound config "hon",← loadBound config "two",
    ← loadBound config "three",← loadBound config "four",keys,
    ← IO.FS.readBinFile config.tripleLabelsFile,honors⟩

structure Cell where
  code : Nat := 0
  size : Nat := 0
  blocks : Nat := 0
  deriving Inhabited

def loadCatalog (path : String) : IO (Array Cell) := do
  let mut cells := Array.replicate (35*184) ({} : Cell)
  let mut seen := Array.replicate (35*184) false
  for line in (← IO.FS.readFile path).splitOn "\n" do
    if line.trimAscii.toString.isEmpty then continue
    let [ns,hs,cs,ss,bs] := line.trimAscii.toString.splitOn "\t"
      | throw (IO.userError "invalid catalog record")
    let n ← JointIndexedFramesV16.number ns
    let h ← JointIndexedFramesV16.number hs
    if n ≥ 35 || h ≥ 184 || seen[n*184+h]! then throw (IO.userError "catalog domain/duplicate")
    cells := cells.set! (n*184+h) ⟨← JointIndexedFramesV16.number cs,
      ← JointIndexedFramesV16.number ss,← JointIndexedFramesV16.number bs⟩
    seen := seen.set! (n*184+h) true
  return cells

def cellAt (cells : Array Cell) (n h : Nat) : Cell := cells.getD (n*184+h) {}

def loadSource (config : Config) (session : Session) (ids : ByteArray)
    (cells : Array Cell) (n h : Nat) (target : Bool := false) : IO GeneralIndex.Bucket := do
  if n ≥ 35 || h ≥ 184 then return GeneralIndex.emptyBucket
  let cell := cellAt cells n h
  if cell.size = 0 then return GeneralIndex.emptyBucket
  return ← JointIndexedFramesV16.loadBucket
    (if target then config.targetIndexRoot else config.indexRoot)
    (if target then config.targetDataRoot else config.dataRoot)
    session.base.inputs.numericRecords ids session.base.inputs.groupRecords
    n h cell.code cell.size cell.blocks

structure LoadedBucket (session : Session) where
  layer : Nat
  honor : Nat
  bucket : BucketSession session
  coverage : JointIndexedFramesV16.PreparedCoverage
  honorIds : ByteArray
  keys : Array (Array Nat)
  targetsChecked : Bool
  rootChecked : Option Bool

def openActual (config : Config) (session : Session) (ids honorIds : ByteArray)
    (cells : Array Cell) (coverage : JointIndexedFramesV16.PreparedCoverage) (n h : Nat) :
    IO (LoadedBucket session) := do
  if n ≥ 35 || h ≥ 184 then throw (IO.userError "open outside table")
  let source ← loadSource config session ids cells n h
  if source.data.size = 0 then throw (IO.userError "open empty bucket")
  let honorInventory := session.localData.inventories 3
  if source.data.honorCode != honorInventory.member h then
    throw (IO.userError "source catalog honor binding rejected")
  let mut targets := Array.replicate 184 CrossLayerAssemblyV17.emptyTargetBucket
  let mut next := Array.replicate 184 GeneralIndex.emptyBucket
  let mut keys := Array.replicate 184 (#[] : Array Nat)
  let needed := h :: (session.data 3).next h
  for targetHonor in needed do
    if targetHonor ≥ 184 then throw (IO.userError "target honor outside bank")
    let loaded ← loadSource config session ids cells (n+1) targetHonor true
    targets := targets.set! targetHonor ⟨loaded.data.directory,loaded.data.honorCode,loaded.data.size,loaded.bits⟩
    keys := keys.set! targetHonor (JointIndexedFramesV16.directoryKeys loaded.data.directory)
    let canonical ← if config.targetIndexRoot = config.indexRoot && config.targetDataRoot = config.dataRoot
      then pure loaded else loadSource config session ids cells (n+1) targetHonor
    next := next.set! targetHonor canonical
  for targetHonor in [:184] do
    let target := targets.getD targetHonor CrossLayerAssemblyV17.emptyTargetBucket
    let code := honorInventory.member targetHonor
    if target.size > 0 && target.honorCode != code then
      throw (IO.userError "target catalog honor binding rejected")
    targets := targets.set! targetHonor { target with honorCode := code }
  let input : BucketInput := ⟨ids,
    (fun i => targets.getD i.val CrossLayerAssemblyV17.emptyTargetBucket),source,coverage.data⟩
  let bucket ← require (openBucket session input)
  let same := checkTargetSources bucket.work.next (fun i => next.getD i GeneralIndex.emptyBucket)
  if !same then throw (IO.userError "actual next-layer byte identity rejected")
  let root := if n = 0 && h = 0 then some (EmptyRootV17.checkP source.data source.bits) else none
  if root = some false then throw (IO.userError "actual empty root/P rejected")
  return ⟨n,h,bucket,coverage,honorIds,keys,same,root⟩

def preparePart {session : Session} (loaded : LoadedBucket session)
    (shared : Shared loaded.bucket) (first stop : Nat) :
    IO (Array (Plan loaded.bucket)) := do
  let _ ← IO.monoNanosNow
  let model := BlockPlanCertifiedRow.sourceModel loaded.bucket.work.next.bank loaded.bucket.input.source.data
  let mut plans := #[]
  for block in [first:stop] do
    let ctx : BlockPlanCheck.Context := ⟨loaded.honor,block,model.key block,loaded.bucket.input.source.data.honorCode⟩
    let view := SourceBlockGuard.ofModel model block
    let proposal := JointIndexedFramesV16.targetProposal loaded.bucket.work.next.bank loaded.honorIds loaded.keys
    plans := plans.push (← require (prepareBlock loaded.bucket shared ctx view proposal loaded.coverage.slots))
  return plans

/-- Disjoint contiguous preparation ranges, joined in source block order.
All started tasks are joined even if a later spawn or preparation rejects. -/
def preparePlans {session : Session} (loaded : LoadedBucket session)
    (shared : Shared loaded.bucket) (first stop : Nat) :
    IO (Array (Plan loaded.bucket)) := do
  if stop ≤ first then throw (IO.userError "empty or reversed preparation interval")
  let workers := min 12 (stop-first)
  let mut tasks : Array (Task (Except IO.Error (Array (Plan loaded.bucket)))) := #[]
  let mut failure : Option IO.Error := none
  try
    for w in [:workers] do
      let begin := first+(stop-first)*w/workers
      let endBlock := first+(stop-first)*(w+1)/workers
      tasks := tasks.push (← IO.asTask (preparePart loaded shared begin endBlock) .default)
  catch err => failure := some err
  let mut plans := #[]
  for task in tasks do
    match ← IO.wait task with
    | .error err => failure := some err
    | .ok result => plans := plans ++ result
  if let some err := failure then throw err
  if plans.size != stop-first then throw (IO.userError "prepared block coverage mismatch")
  return plans

/-- Only proposes block ranges and starting coordinates. The frozen V17 scan
independently checks exact cover and every absolute source address. -/
def fragmentRuns {session : Session} (loaded : LoadedBucket session)
    (plans : Array (Plan loaded.bucket)) (firstBlock first count : Nat) :
    IO (List (Run loaded.bucket)) := do
  let source := loaded.bucket.input.source
  let mut runs := #[]
  let mut cursor := first
  let mut block := BucketIndex.blockAt source.data first
  while cursor < first+count do
    if block < firstBlock || block-firstBlock ≥ plans.size then
      throw (IO.userError "proposed run outside prepared blocks")
    let some plan := plans[block-firstBlock]? | throw (IO.userError "missing prepared plan")
    let stop := min (first+count) (if let some next := plans[block+1-firstBlock]?
      then next.view.word.offset.toNat else source.data.size)
    if stop ≤ cursor then throw (IO.userError "nonpositive proposed block run")
    runs := runs.push ⟨⟨cursor,stop-cursor⟩,plan,BucketIndex.decodeIds source.data cursor⟩
    cursor := stop
    block := block+1
  return runs.toList

/-- Keep the actual pure scalar scan inside the task's IO action. In
particular, do not evaluate require(scanOwnedFragment...) before asTask. -/
def scanFragmentTask {session : Session} (loaded : LoadedBucket session)
    (fragment : Fragment loaded.bucket) : IO (Scanned loaded.bucket) := do
  let _ ← IO.monoNanosNow
  require (scanOwnedFragment loaded.bucket fragment)

def scanFrame {session : Session} (loaded : LoadedBucket session)
    (shared : Shared loaded.bucket) (input : IO.FS.Stream)
    (span : IndexedByteStreamTransportV16.Span) : IO (FrameResult loaded.bucket) := do
  let source := loaded.bucket.input.source
  if span.start+span.count > source.data.size then throw (IO.userError "span outside source")
  if ← System.FilePath.pathExists span.output then throw (IO.userError "frame output already exists")
  let began ← IO.monoNanosNow
  let payload ← JointIndexedFramesV16.readPayload input span.start span.count
  let readNs := (← IO.monoNanosNow)-began
  let firstBlock := BucketIndex.blockAt source.data span.start
  let lastBlock := BucketIndex.blockAt source.data (span.start+span.count-1)
  phase "PLAN_BEGIN" [("start",toJson span.start),("count",toJson span.count)]
  let planStart ← IO.monoNanosNow
  let plans ← preparePlans loaded shared firstBlock (lastBlock+1)
  let planNs := (← IO.monoNanosNow)-planStart
  phase "SCAN_BEGIN" [("plan_blocks",toJson plans.size)]
  let scanStart ← IO.monoNanosNow
  let mut tasks : Array (Task (Except IO.Error (Scanned loaded.bucket))) := #[]
  let mut failure : Option IO.Error := none
  try
    for w in [:12] do
      let chunk := RowScheduleV13.get payload.schedule w
      let runs ← fragmentRuns loaded plans firstBlock chunk.first chunk.count
      let fragment : Fragment loaded.bucket := ⟨chunk,payload.buffers.getD w ByteArray.empty,runs⟩
      tasks := tasks.push (← IO.asTask (scanFragmentTask loaded fragment) .default)
  catch err => failure := some err
  let mut scanned := #[]
  for task in tasks do
    match ← IO.wait task with
    | .error err => failure := some err
    | .ok result => scanned := scanned.push result
  if let some err := failure then throw err
  let result ← require (finishFrame loaded.bucket span.start span.count scanned.toList)
  let scanNs := (← IO.monoNanosNow)-scanStart
  let fields := [("schema",.str "V17_NATIVE_FRAME_RESULT_V1"),("event",.str "FRAME_RESULT"),
    ("status",.str "PASS_NATIVE_V17_FRAME"),("frameAccepted",.bool true),
    ("layer",toJson loaded.layer),("honor",toJson loaded.honor),
    ("start",toJson span.start),("count",toJson span.count),("checked_rows",toJson span.count),
    ("P_rows",toJson result.p),("N_rows",toJson (span.count-result.p)),
    ("payload_read_ns",toJson readNs),("plan_ns",toJson planNs),("scan_ns",toJson scanNs),
    ("wall_ns",toJson ((← IO.monoNanosNow)-began)),("plan_blocks",toJson plans.size),
    ("logical_fragments",toJson (12 : Nat)),("closed_kernel_table_theorem",.bool false)]
  IO.FS.writeFile (span.output ++ ".tmp") ((Json.mkObj fields).compress ++ "\n")
  IO.FS.rename (span.output ++ ".tmp") span.output
  emit fields
  return result

def boolFlag (j : Json) (key : String) : Bool :=
  match j.getObjVal? key >>= Json.getBool? with | .ok true => true | _ => false

/-- Closing a resumed partial bucket records only its actually scanned extents.
The immutable-input finalizer, rather than fabricated typed proofs, combines
committed extents from different process invocations. -/
def bucketLoop {session : Session} (loaded : LoadedBucket session)
    (shared : Shared loaded.bucket) (input : IO.FS.Stream) : IO Unit := do
  let mut ranges : Array (CompletedRange loaded.bucket) := #[]
  let mut checkedRows := 0
  repeat
    let some line ← IndexedByteStreamTransportV16.readLine input
      | throw (IO.userError "EOF with open bucket")
    let j ← match Json.parse line with | .ok j => pure j | .error err => throw (IO.userError err)
    if boolFlag j "close" then
      let exact := ScanFinalV17.checkRanges loaded.bucket.work ranges.toList
      emit [("event",.str "BUCKET_CLOSED"),("layer",toJson loaded.layer),("honor",toJson loaded.honor),
        ("checked_rows",toJson checkedRows),("exactCoverage",.bool exact),
        ("rootChecked",toJson loaded.rootChecked),
        ("ranges",toJson (ranges.map (fun r => (r.chunk.first,r.chunk.count))))]
      return
    match ← IndexedByteStreamTransportV16.parseCommand line with
    | .stop => throw (IO.userError "close bucket before stop")
    | .span span =>
      let checked ← scanFrame loaded shared input span
      ranges := ranges.push checked.range
      checkedRows := checkedRows+span.count

def serve (config : Config) (session : Session) : IO Unit := do
  let ids ← bin config.indexRoot "numeric_ids.bin"
  let honorIds ← bin config.indexRoot "honor_ids.bin"
  let cells ← loadCatalog config.catalogFile
  let coverage ← JointIndexedFramesV16.makeCoverage session.localData session.certificate.groups
  let input ← IO.getStdin
  emit [("event",.str "GLOBAL_READY"),("baseChecked",.bool true),("successorsChecked",.bool true),
    ("layers",toJson (35 : Nat)),("honors",toJson (184 : Nat))]
  repeat
    let some line ← IndexedByteStreamTransportV16.readLine input | throw (IO.userError "missing stop")
    let j ← match Json.parse line with | .ok j => pure j | .error err => throw (IO.userError err)
    if boolFlag j "stop" then
      IndexedByteStreamTransportV16.requireEOF input
      emit [("event",.str "GLOBAL_STOPPED")]
      return
    if !boolFlag j "open" then throw (IO.userError "expected open command")
    let n ← IndexedByteStreamTransportV16.natField j "layer"
    let h ← IndexedByteStreamTransportV16.natField j "honor"
    let began ← IO.monoNanosNow
    let loaded ← openActual config session ids honorIds cells coverage n h
    let shared := buildShared loaded.bucket
    emit [("event",.str "BUCKET_READY"),("layer",toJson n),("honor",toJson h),
      ("size",toJson loaded.bucket.input.source.data.size),("metadataChecked",.bool true),
      ("loaded_target_honors",toJson ((List.range 184).filter (fun targetHonor =>
        decide (0 < (BlockPlanCheck.legacyBucket loaded.bucket.work.next.bank targetHonor).data.size)))),
      ("targetIdentity",.bool loaded.targetsChecked),("rootChecked",toJson loaded.rootChecked),
      ("open_ns",toJson ((← IO.monoNanosNow)-began))]
    bucketLoop loaded shared input

/-- Controls may replace only bucket/catalog transport inputs. The successful
base certificate, successor bytes and common index files stay exactly those
already loaded in this one Session. This is an IO path equality guard, not a
substitute for any source/target/coverage/row acceptance check. -/
def sameControlCommon (original privateConfig : Config) : Bool :=
  original.cacheRoot == privateConfig.cacheRoot &&
  original.rawRoot == privateConfig.rawRoot &&
  original.inventoryRoot == privateConfig.inventoryRoot &&
  original.indexRoot == privateConfig.indexRoot &&
  original.successorRoot == privateConfig.successorRoot &&
  original.boundRoot == privateConfig.boundRoot &&
  original.prefixRoot == privateConfig.prefixRoot &&
  original.tripleLabelsFile == privateConfig.tripleLabelsFile

def controlCaseIds : List String :=
  ["positive_full_bucket", "source_bit_flip", "deleted_last_row", "target_identity_mismatch",
    "truncated_source_bits", "catalog_honor_mismatch"]

/-- A bounded controls-only bucket interaction. The production bucketLoop
above keeps its original fatal-error behavior. A rejected span has already
used the very same readPayload/prepare/scan/join path as production. -/
def controlBucket {session : Session} (caseId : String) (loaded : LoadedBucket session)
    (shared : Shared loaded.bucket) (input : IO.FS.Stream) : IO Unit := do
  let mut ranges : Array (CompletedRange loaded.bucket) := #[]
  let mut checkedRows := 0
  let mut frames := 0
  repeat
    let some line ← IndexedByteStreamTransportV16.readLine input
      | throw (IO.userError "EOF with open control bucket")
    let j ← match Json.parse line with | .ok j => pure j | .error err => throw (IO.userError err)
    if boolFlag j "close" then
      let exact := ScanFinalV17.checkRanges loaded.bucket.work ranges.toList
      emit [("event",.str "BUCKET_CLOSED"),("control_case_id",.str caseId),
        ("layer",toJson loaded.layer),("honor",toJson loaded.honor),
        ("checked_rows",toJson checkedRows),("exactCoverage",.bool exact),
        ("rootChecked",toJson loaded.rootChecked),
        ("ranges",toJson (ranges.map (fun r => (r.chunk.first,r.chunk.count))))]
      return
    match ← IndexedByteStreamTransportV16.parseCommand line with
    | .stop => throw (IO.userError "close control bucket before stop")
    | .span span =>
      if frames ≥ 2 || span.count > 56 || span.start+span.count > 56 then
        throw (IO.userError "CONTROL_SPAN_BOUNDS")
      let checked ← scanFrame loaded shared input span
      ranges := ranges.push checked.range
      checkedRows := checkedRows+span.count
      frames := frames+1

/-- All six private cases reuse this one actually checked base Session.
Exceptions are caught only by this explicit controls mode. No exception is
converted to mathematical acceptance; CONTROL_REJECTED records the actual
error, and the outside harness must verify its precise registered cause.
The caller sends a payload only after BUCKET_READY, so a rejected open cannot
leave queued binary bytes masquerading as another command. -/
def controls (config : Config) (session : Session) : IO Unit := do
  let ids ← bin config.indexRoot "numeric_ids.bin"
  let honorIds ← bin config.indexRoot "honor_ids.bin"
  let coverage ← JointIndexedFramesV16.makeCoverage session.localData session.certificate.groups
  let input ← IO.getStdin
  let mut seen : List String := []
  emit [("event",.str "GLOBAL_READY"),("mode",.str "controls"),
    ("baseChecked",.bool true),("successorsChecked",.bool true),
    ("layers",toJson (35 : Nat)),("honors",toJson (184 : Nat))]
  repeat
    let some line ← IndexedByteStreamTransportV16.readLine input
      | throw (IO.userError "missing controls stop")
    let j ← match Json.parse line with | .ok j => pure j | .error err => throw (IO.userError err)
    if boolFlag j "stop" then
      IndexedByteStreamTransportV16.requireEOF input
      emit [("event",.str "GLOBAL_STOPPED"),("mode",.str "controls"),
        ("completed_controls",toJson seen.length),("control_case_ids",toJson seen.reverse)]
      return
    let caseId ← IndexedByteStreamTransportV16.stringField j "case_id"
    let configPath ← IndexedByteStreamTransportV16.stringField j "config"
    let n ← IndexedByteStreamTransportV16.natField j "layer"
    let h ← IndexedByteStreamTransportV16.natField j "honor"
    if !boolFlag j "control" || !controlCaseIds.contains caseId || seen.contains caseId ||
        n != 32 || h != 89 then
      throw (IO.userError "CONTROL_COMMAND_BOUNDS_OR_DUPLICATE")
    seen := caseId :: seen
    try
      let privateConfig ← loadConfig configPath
      if !sameControlCommon config privateConfig then
        throw (IO.userError "controls cannot replace common base/edge/index files")
      let cells ← loadCatalog privateConfig.catalogFile
      let began ← IO.monoNanosNow
      let loaded ← openActual privateConfig session ids honorIds cells coverage n h
      let shared := buildShared loaded.bucket
      emit [("event",.str "BUCKET_READY"),("control_case_id",.str caseId),
        ("layer",toJson n),("honor",toJson h),
        ("size",toJson loaded.bucket.input.source.data.size),("metadataChecked",.bool true),
        ("loaded_target_honors",toJson ((List.range 184).filter (fun targetHonor =>
          decide (0 < (BlockPlanCheck.legacyBucket loaded.bucket.work.next.bank targetHonor).data.size)))),
        ("targetIdentity",.bool loaded.targetsChecked),("rootChecked",toJson loaded.rootChecked),
        ("open_ns",toJson ((← IO.monoNanosNow)-began))]
      try
        controlBucket caseId loaded shared input
      catch err =>
        emit [("event",.str "CONTROL_REJECTED"),("control_case_id",.str caseId),
          ("stage",.str "frame"),("error",.str err.toString)]
      pure ()
    catch err =>
      emit [("event",.str "CONTROL_REJECTED"),("control_case_id",.str caseId),
        ("stage",.str "open"),("error",.str err.toString)]

def run (args : List String) : IO UInt32 := do
  let mode :: configPath :: remaining := args
    | throw (IO.userError "serve CONFIG.json | controls CONFIG.json | base-check CONFIG.json OUTPUT.json")
  if mode != "serve" && mode != "controls" && mode != "base-check" then throw (IO.userError "unknown mode")
  let config ← loadConfig configPath
  phase "LOAD_BASE_BEGIN"
  let loadStart ← IO.monoNanosNow
  let raw ← loadFinite config
  let loadNs := (← IO.monoNanosNow)-loadStart
  phase "CHECK_BASE_BEGIN" [("load_ns",toJson loadNs)]
  let began ← IO.monoNanosNow
  let base ← require (checkBase raw)
  let baseNs := (← IO.monoNanosNow)-began
  phase "CHECK_SUCCESSORS_BEGIN" [("base_ns",toJson baseNs)]
  let edgeStart ← IO.monoNanosNow
  let session ← require (checkEdges base (← bin config.successorRoot "numeric.bin")
    (← bin config.successorRoot "honors.bin"))
  let edgeNs := (← IO.monoNanosNow)-edgeStart
  let record := [("event",.str "BASE_CHECKED"),("baseChecked",.bool true),
    ("successorsChecked",.bool true),("load_ns",toJson loadNs),("base_ns",toJson baseNs),
    ("successor_ns",toJson edgeNs),("closed_kernel_table_theorem",.bool false)]
  emit record
  if mode = "base-check" then
    let [output] := remaining | throw (IO.userError "base-check needs output path")
    IO.FS.writeFile output ((Json.mkObj record).compress ++ "\n")
  else
    if !remaining.isEmpty then throw (IO.userError "serve/controls has no extra arguments")
    if mode = "controls" then controls config session else serve config session
  return 0

end V17Compute

def main (args : List String) : IO UInt32 := V17Compute.run args
