import Mahjong.BlockWordAddress
import Mahjong.CachedTargetModels
import Mahjong.MovePlanRefinement

set_option autoImplicit false

namespace Mahjong.BlockPlanCheck
open PackedRules GeneralLayer GroupCandidates CanonicalInventory

structure Shared where
  numeric : ByteArray
  ids : ByteArray
  groups : ByteArray
  raw : ByteArray
  members : ByteArray

structure Bucket where
  directory : ByteArray
  honorCode : Nat
  size : Nat
  bits : ByteArray

structure Bank where
  shared : Shared
  buckets : Nat → Bucket

def groupData (bank : Bank) : GroupInventory.Data :=
  GroupInventory.candidate bank.shared.numeric bank.shared.groups bank.shared.raw bank.shared.members

def legacyBucket (bank : Bank) (h : Nat) : GeneralIndex.Bucket :=
  let b := bank.buckets h
  ⟨⟨bank.shared.numeric,bank.shared.ids,bank.shared.groups,b.directory,b.honorCode,b.size⟩,b.bits⟩

def guardedBank (bank : Bank) : GuardedTargetRef.Data :=
  ⟨bank.shared.raw,bank.shared.members,legacyBucket bank,fun _ => (0,0,(0,0,0))⟩

def model (bank : Bank) (h : Nat) : IndexOperations.Data := GuardedTargetRef.model (guardedBank bank) h

structure Context where
  sourceHonor : Nat
  sourceBlock : Nat
  key : Triple
  honorCode : Nat

structure Edge where
  j : Nat
  safe : Bool
  targetHonor : Nat
  targetBlock : Nat
  word : BlockWordAddress.View

structure Plan where
  rows : Nat → Nat → List Edge

def keyGet (key : Triple) (b : Nat) : Nat :=
  if b = 0 then key.1 else if b = 1 then key.2.1 else key.2.2

def labels (g : GroupInventory.Data) (localData : CachedPackedCheck.Local)
    (ctx : Context) (b j : Nat) : PruningAlgebra.Label :=
  let a := g.label (if b = 0 then g.group j else ctx.key.1)
  let bb := g.label (if b = 1 then g.group j else ctx.key.2.1)
  let c := g.label (if b = 2 then g.group j else ctx.key.2.2)
  let h := (localData.rules 3).raw (if b = 3 then (localData.inventories 3).member j else ctx.honorCode)
  PruningAlgebra.join (PruningAlgebra.join (PruningAlgebra.join a bb) c) h

def expectedSafe (g : GroupInventory.Data) (localData : CachedPackedCheck.Local)
    (ctx : Context) (b j : Nat) : Bool := decide (PruningAlgebra.fullSafe (labels g localData ctx b j))

def shadow (g : GroupInventory.Data) (ctx : Context) : Packed :=
  ⟨g.first ctx.key.1,g.first ctx.key.2.1,g.first ctx.key.2.2,ctx.honorCode⟩

def rawChild (localData : CachedPackedCheck.Local) (p : Packed) (b j : Nat) : Packed :=
  if b < 3 then p.set b j else { p with h := (localData.inventories 3).member j }

def shadowChild (g : GroupInventory.Data) (localData : CachedPackedCheck.Local)
    (ctx : Context) (b j : Nat) : Packed :=
  rawChild localData (shadow g ctx) b (if b < 3 then g.first (g.group j) else j)

def groupKey (g : GroupInventory.Data) (p : Packed) : Triple := (g.group p.a,g.group p.b,g.group p.c)

def checkEdge (localData : CachedPackedCheck.Local) (bank : Bank) (ctx : Context) (b : Nat) (e : Edge) : Bool :=
  let g := groupData bank
  decide (e.j < if b < 3 then g.count else (localData.inventories 3).count) &&
    decide (e.safe = expectedSafe g localData ctx b e.j) &&
    if e.safe then
      let q := SuitSorting.sort id (shadowChild g localData ctx b e.j)
      let m := model bank e.targetHonor
      decide (0 < (bank.buckets e.targetHonor).size) &&
        decide ((bank.buckets e.targetHonor).honorCode = q.h) &&
        decide (e.targetBlock < m.directory.blocks) && decide (m.key e.targetBlock = groupKey g q) &&
        BlockWordAddress.check m e.targetBlock e.word
    else true

def sourceId (localData : CachedPackedCheck.Local) (ctx : Context) (p : Packed) (b : Nat) : Nat :=
  if b < 3 then p.get b else (localData.inventories 3).id ctx.honorCode

/-- Honor plans use index zero so the hot path never rebuilds an inventory. -/
def planIndex (p : Packed) (b : Nat) : Nat := if b < 3 then p.get b else 0

def checkRow (localData : CachedPackedCheck.Local) (bank : Bank) (ctx : Context)
    (plan : Plan) (b i : Nat) : Bool :=
  let es := plan.rows b (if b < 3 then i else 0)
  decide (es.map Edge.j = (localData.edges b).next i) && es.all (checkEdge localData bank ctx b)

def checkContext (localData : CachedPackedCheck.Local) (bank : Bank) (source : IndexOperations.Data)
    (ctx : Context) : Bool :=
  let g := groupData bank
  decide (ctx.key.1 < g.groups ∧ ctx.key.2.1 < g.groups ∧ ctx.key.2.2 < g.groups ∧
    ctx.key.1 ≤ ctx.key.2.1 ∧ ctx.key.2.1 ≤ ctx.key.2.2) &&
    decide (ctx.sourceBlock < source.directory.blocks ∧ source.key ctx.sourceBlock = ctx.key) &&
    decide (ctx.honorCode = (bank.buckets ctx.sourceHonor).honorCode) &&
    decide (ctx.honorCode < (localData.rules 3).summary.core.size) &&
    decide ((localData.inventories 3).id ctx.honorCode < (localData.inventories 3).count ∧
      (localData.inventories 3).member ((localData.inventories 3).id ctx.honorCode) = ctx.honorCode) &&
    expectedSafe g localData ctx 4 0

def checkPlan (localData : CachedPackedCheck.Local) (bank : Bank) (source : IndexOperations.Data)
    (ctx : Context) (plan : Plan) : Bool :=
  checkContext localData bank source ctx && (List.range 3).all (fun b =>
    checkSpan (checkRow localData bank ctx plan b) ((groupData bank).first (keyGet ctx.key b))
      ((groupData bank).size (keyGet ctx.key b))) &&
    checkRow localData bank ctx plan 3 ((localData.inventories 3).id ctx.honorCode)

def packIds (ctx : Context) (ids : Triple) : Packed := ⟨ids.1,ids.2.1,ids.2.2,ctx.honorCode⟩

/-- Only numeric IDs participate in the address. Honor output was checked
once in checkEdge and is not reconstructed for each visited source row. -/
def childNumeric (ids : Packed) (b j : Nat) : Triple :=
  let q := SuitSorting.sort id (if b < 3 then ids.set b j else ids)
  (q.a,q.b,q.c)

def label (bank : Bank) (p : Packed) (b : Nat) (e : Edge) : Bool :=
  TerminalBucket.labelP (bank.buckets e.targetHonor).bits
    (BlockWordAddress.address e.word (childNumeric p b e.j)).toNat

def row (bank : Bank) (source : IndexOperations.Data) (ctx : Context) (plan : Plan)
    (ids : Triple) (r : Nat) (sourceP : Bool) : Bool :=
  GuardedIndexAccess.checkAddress source ctx.sourceBlock ids r &&
    let p := packIds ctx ids
    if sourceP then (List.range 4).all (fun b =>
      (plan.rows b (planIndex p b)).all (fun e => !e.safe || !label bank p b e))
    else (List.range 4).any (fun b =>
      (plan.rows b (planIndex p b)).any (fun e => e.safe && label bank p b e))

def single (bank : Bank) (source : IndexOperations.Data) (ctx : Context) (plan : Plan)
    (ids : Triple) (r b j : Nat) : Bool :=
  GuardedIndexAccess.checkAddress source ctx.sourceBlock ids r && decide (b < 4) &&
    let p := packIds ctx ids
    (plan.rows b (planIndex p b)).any (fun e => decide (e.j = j) && e.safe && label bank p b e)

end Mahjong.BlockPlanCheck
