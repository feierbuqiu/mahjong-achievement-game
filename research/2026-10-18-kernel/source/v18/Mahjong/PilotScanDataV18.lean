import Mahjong.GuardedByteScanV16

set_option autoImplicit false

/-! Actual n32h89 data read footprint, exported by capture/export_rows.py.
This proves literal hot-checker acceptance only. It is not a full
enumeration/metadata certificate, snapshot-global equality or game strategy.
Unused memo indices use explicit defaults; all four actual successor lists
and every accessed template/target bit are captured from the actual files. -/

namespace Mahjong.PilotScanDataV18
open GroupCandidates BlockPlanCheck

def actualGroup (j : Nat) : Nat := if j = 1017 then 90 else if j = 1018 then 90 else if j = 1019 then 90 else if j = 1020 then 90 else if j = 1021 then 90 else if j = 1127 then 99 else if j = 2495 then 151 else if j = 2496 then 151 else if j = 2497 then 151 else if j = 2498 then 151 else if j = 2499 then 151 else if j = 2500 then 151 else if j = 2501 then 151 else if j = 2502 then 151 else if j = 2507 then 153 else if j = 2508 then 153 else if j = 2509 then 153 else if j = 2510 then 153 else if j = 2511 then 153 else if j = 2512 then 153 else if j = 2513 then 153 else if j = 2514 then 153 else if j = 2515 then 153 else if j = 2516 then 153 else if j = 2517 then 153 else if j = 2518 then 153 else if j = 2519 then 153 else if j = 2520 then 153 else if j = 2521 then 153 else if j = 2522 then 153 else if j = 2727 then 163 else if j = 2728 then 163 else if j = 2734 then 165 else if j = 2735 then 165 else if j = 2736 then 165 else if j = 2737 then 165 else if j = 2738 then 165 else if j = 4382 then 205 else if j = 4383 then 205 else if j = 4384 then 205 else if j = 4385 then 205 else if j = 4386 then 205 else if j = 4387 then 205 else if j = 4388 then 205 else if j = 4389 then 205 else if j = 4853 then 223 else 0
def actualNext (axis i : Nat) : List Nat :=
  if axis < 3 then if i = 1017 then [2495,2497,2501,2507,2508,2509,2515,4382,4389] else if i = 1018 then [2496,2497,2500,2510,2512,2514,2516,4383,4387] else if i = 1019 then [2496,2498,2511,2513,4384] else if i = 1020 then [2499,2501,2502,2517,2518,2519,2522,4385,4388] else if i = 1021 then [2500,2502,2520,2521,4386] else if i = 1127 then [2501,2727,2728,2734,2735,2736,2737,2738,4853] else []
  else if i = 89 then [99,125] else if i = 99 then [135] else if i = 125 then [135,167] else []

def p0table0 : GeneratedHotPlan.Table := ⟨(((Array.replicate 1104 1104).set! 151 0).set! 153 1).set! 205 2, #[⟨2495,false,(ByteArray.mk #[]),⟨0,0,0,0,0,0,0,0⟩⟩,⟨2507,false,(ByteArray.mk #[]),⟨0,0,0,0,0,0,0,0⟩⟩,⟨4382,false,(ByteArray.mk #[]),⟨0,0,0,0,0,0,0,0⟩⟩]⟩
def p0table1 : GeneratedHotPlan.Table := ⟨(((Array.replicate 1104 1104).set! 151 0).set! 153 1).set! 205 2, #[⟨2495,false,(ByteArray.mk #[]),⟨0,0,0,0,0,0,0,0⟩⟩,⟨2507,false,(ByteArray.mk #[]),⟨0,0,0,0,0,0,0,0⟩⟩,⟨4382,false,(ByteArray.mk #[]),⟨0,0,0,0,0,0,0,0⟩⟩]⟩
def p0table2 : GeneratedHotPlan.Table := ⟨(((Array.replicate 1104 1104).set! 151 0).set! 153 1).set! 205 2, #[⟨2495,false,(ByteArray.mk #[]),⟨0,0,0,0,0,0,0,0⟩⟩,⟨2507,false,(ByteArray.mk #[]),⟨0,0,0,0,0,0,0,0⟩⟩,⟨4382,false,(ByteArray.mk #[]),⟨0,0,0,0,0,0,0,0⟩⟩]⟩
def p0table3 : GeneratedHotPlan.Table := ⟨((Array.replicate 184 184).set! 99 0).set! 125 1, #[⟨99,false,(ByteArray.mk #[]),⟨0,0,0,0,0,0,0,0⟩⟩,⟨125,false,(ByteArray.mk #[]),⟨0,0,0,0,0,0,0,0⟩⟩]⟩
def p0tables : Array GeneratedHotPlan.Table := #[p0table0,p0table1,p0table2,p0table3]
def p0fallback : HotBlockPlan.HotEdge := ⟨0,false,ByteArray.empty,⟨0,0,0,0,0,0,0,0⟩⟩
def p0hot : BorrowedGeneratedHotPlan.Snapshot :=
  ⟨p0tables,fun b => p0tables.getD b ⟨#[],#[]⟩,p0fallback,⟨#[],actualGroup⟩,actualNext⟩
def p0snapshot : BorrowedNextGeneratedHotPlan.Snapshot :=
  ⟨p0hot,⟨#[⟨#[],actualNext 0⟩,⟨#[],actualNext 1⟩,⟨#[],actualNext 2⟩]⟩,[99,125]⟩
def p0view : SourceBlockGuard.View := ⟨⟨90,90,90,1017,1017,1017,5,5,0⟩,(5,5,5)⟩
def p0ctx : Context := ⟨89,0,(90,90,90),874⟩
def p0ids : Triple := (1017,1017,1017)
def p0sourceBits : ByteArray := (ByteArray.mk #[255,255,255,255,7,0,252,0])
def p0compact : ByteArray := (ByteArray.mk #[128])

def n35table0 : GeneratedHotPlan.Table := ⟨(((Array.replicate 1104 1104).set! 151 0).set! 153 1).set! 205 2, #[⟨2495,false,(ByteArray.mk #[]),⟨0,0,0,0,0,0,0,0⟩⟩,⟨2507,false,(ByteArray.mk #[]),⟨0,0,0,0,0,0,0,0⟩⟩,⟨4382,false,(ByteArray.mk #[]),⟨0,0,0,0,0,0,0,0⟩⟩]⟩
def n35table1 : GeneratedHotPlan.Table := ⟨(((Array.replicate 1104 1104).set! 151 0).set! 153 1).set! 205 2, #[⟨2495,false,(ByteArray.mk #[]),⟨0,0,0,0,0,0,0,0⟩⟩,⟨2507,false,(ByteArray.mk #[]),⟨0,0,0,0,0,0,0,0⟩⟩,⟨4382,false,(ByteArray.mk #[]),⟨0,0,0,0,0,0,0,0⟩⟩]⟩
def n35table2 : GeneratedHotPlan.Table := ⟨((((Array.replicate 1104 1104).set! 151 0).set! 163 1).set! 165 2).set! 223 3, #[⟨2495,false,(ByteArray.mk #[]),⟨0,0,0,0,0,0,0,0⟩⟩,⟨2727,false,(ByteArray.mk #[]),⟨0,0,0,0,0,0,0,0⟩⟩,⟨2734,false,(ByteArray.mk #[]),⟨0,0,0,0,0,0,0,0⟩⟩,⟨4853,false,(ByteArray.mk #[]),⟨0,0,0,0,0,0,0,0⟩⟩]⟩
def n35table3 : GeneratedHotPlan.Table := ⟨((Array.replicate 184 184).set! 99 0).set! 125 1, #[⟨99,false,(ByteArray.mk #[]),⟨0,0,0,0,0,0,0,0⟩⟩,⟨125,true,(ByteArray.mk #[255,127,0,0,0,0,0,0]),⟨1017,1017,1127,5,5,15,0,1⟩⟩]⟩
def n35tables : Array GeneratedHotPlan.Table := #[n35table0,n35table1,n35table2,n35table3]
def n35fallback : HotBlockPlan.HotEdge := ⟨0,false,ByteArray.empty,⟨0,0,0,0,0,0,0,0⟩⟩
def n35hot : BorrowedGeneratedHotPlan.Snapshot :=
  ⟨n35tables,fun b => n35tables.getD b ⟨#[],#[]⟩,n35fallback,⟨#[],actualGroup⟩,actualNext⟩
def n35snapshot : BorrowedNextGeneratedHotPlan.Snapshot :=
  ⟨n35hot,⟨#[⟨#[],actualNext 0⟩,⟨#[],actualNext 1⟩,⟨#[],actualNext 2⟩]⟩,[99,125]⟩
def n35view : SourceBlockGuard.View := ⟨⟨90,90,99,1017,1017,1127,5,5,35⟩,(5,5,1)⟩
def n35ctx : Context := ⟨89,1,(90,90,99),874⟩
def n35ids : Triple := (1017,1017,1127)
def n35sourceBits : ByteArray := (ByteArray.mk #[255,255,255,255,7,0,252,0])
def n35compact : ByteArray := (ByteArray.mk #[97])

def p50table0 : GeneratedHotPlan.Table := ⟨(((Array.replicate 1104 1104).set! 151 0).set! 153 1).set! 205 2, #[⟨2495,false,(ByteArray.mk #[]),⟨0,0,0,0,0,0,0,0⟩⟩,⟨2507,false,(ByteArray.mk #[]),⟨0,0,0,0,0,0,0,0⟩⟩,⟨4382,false,(ByteArray.mk #[]),⟨0,0,0,0,0,0,0,0⟩⟩]⟩
def p50table1 : GeneratedHotPlan.Table := ⟨((((Array.replicate 1104 1104).set! 151 0).set! 163 1).set! 165 2).set! 223 3, #[⟨2495,false,(ByteArray.mk #[]),⟨0,0,0,0,0,0,0,0⟩⟩,⟨2727,false,(ByteArray.mk #[]),⟨0,0,0,0,0,0,0,0⟩⟩,⟨2734,false,(ByteArray.mk #[]),⟨0,0,0,0,0,0,0,0⟩⟩,⟨4853,false,(ByteArray.mk #[]),⟨0,0,0,0,0,0,0,0⟩⟩]⟩
def p50table2 : GeneratedHotPlan.Table := ⟨((((Array.replicate 1104 1104).set! 151 0).set! 163 1).set! 165 2).set! 223 3, #[⟨2495,false,(ByteArray.mk #[]),⟨0,0,0,0,0,0,0,0⟩⟩,⟨2727,false,(ByteArray.mk #[]),⟨0,0,0,0,0,0,0,0⟩⟩,⟨2734,false,(ByteArray.mk #[]),⟨0,0,0,0,0,0,0,0⟩⟩,⟨4853,false,(ByteArray.mk #[]),⟨0,0,0,0,0,0,0,0⟩⟩]⟩
def p50table3 : GeneratedHotPlan.Table := ⟨((Array.replicate 184 184).set! 99 0).set! 125 1, #[⟨99,false,(ByteArray.mk #[]),⟨0,0,0,0,0,0,0,0⟩⟩,⟨125,true,(ByteArray.mk #[255,127,0,0,0,0,0,0]),⟨1017,1127,1127,5,1,15,15,2⟩⟩]⟩
def p50tables : Array GeneratedHotPlan.Table := #[p50table0,p50table1,p50table2,p50table3]
def p50fallback : HotBlockPlan.HotEdge := ⟨0,false,ByteArray.empty,⟨0,0,0,0,0,0,0,0⟩⟩
def p50hot : BorrowedGeneratedHotPlan.Snapshot :=
  ⟨p50tables,fun b => p50tables.getD b ⟨#[],#[]⟩,p50fallback,⟨#[],actualGroup⟩,actualNext⟩
def p50snapshot : BorrowedNextGeneratedHotPlan.Snapshot :=
  ⟨p50hot,⟨#[⟨#[],actualNext 0⟩,⟨#[],actualNext 1⟩,⟨#[],actualNext 2⟩]⟩,[99,125]⟩
def p50view : SourceBlockGuard.View := ⟨⟨90,99,99,1017,1127,1127,5,1,50⟩,(5,1,1)⟩
def p50ctx : Context := ⟨89,2,(90,99,99),874⟩
def p50ids : Triple := (1017,1127,1127)
def p50sourceBits : ByteArray := (ByteArray.mk #[255,255,255,255,7,0,252,0])
def p50compact : ByteArray := (ByteArray.mk #[128])

def p55table0 : GeneratedHotPlan.Table := ⟨((((Array.replicate 1104 1104).set! 151 0).set! 163 1).set! 165 2).set! 223 3, #[⟨2495,false,(ByteArray.mk #[]),⟨0,0,0,0,0,0,0,0⟩⟩,⟨2727,false,(ByteArray.mk #[]),⟨0,0,0,0,0,0,0,0⟩⟩,⟨2734,false,(ByteArray.mk #[]),⟨0,0,0,0,0,0,0,0⟩⟩,⟨4853,false,(ByteArray.mk #[]),⟨0,0,0,0,0,0,0,0⟩⟩]⟩
def p55table1 : GeneratedHotPlan.Table := ⟨((((Array.replicate 1104 1104).set! 151 0).set! 163 1).set! 165 2).set! 223 3, #[⟨2495,false,(ByteArray.mk #[]),⟨0,0,0,0,0,0,0,0⟩⟩,⟨2727,false,(ByteArray.mk #[]),⟨0,0,0,0,0,0,0,0⟩⟩,⟨2734,false,(ByteArray.mk #[]),⟨0,0,0,0,0,0,0,0⟩⟩,⟨4853,false,(ByteArray.mk #[]),⟨0,0,0,0,0,0,0,0⟩⟩]⟩
def p55table2 : GeneratedHotPlan.Table := ⟨((((Array.replicate 1104 1104).set! 151 0).set! 163 1).set! 165 2).set! 223 3, #[⟨2495,false,(ByteArray.mk #[]),⟨0,0,0,0,0,0,0,0⟩⟩,⟨2727,false,(ByteArray.mk #[]),⟨0,0,0,0,0,0,0,0⟩⟩,⟨2734,false,(ByteArray.mk #[]),⟨0,0,0,0,0,0,0,0⟩⟩,⟨4853,false,(ByteArray.mk #[]),⟨0,0,0,0,0,0,0,0⟩⟩]⟩
def p55table3 : GeneratedHotPlan.Table := ⟨((Array.replicate 184 184).set! 99 0).set! 125 1, #[⟨99,false,(ByteArray.mk #[]),⟨0,0,0,0,0,0,0,0⟩⟩,⟨125,true,(ByteArray.mk #[255,127,0,0,0,0,0,0]),⟨1127,1127,1127,1,1,1,20,0⟩⟩]⟩
def p55tables : Array GeneratedHotPlan.Table := #[p55table0,p55table1,p55table2,p55table3]
def p55fallback : HotBlockPlan.HotEdge := ⟨0,false,ByteArray.empty,⟨0,0,0,0,0,0,0,0⟩⟩
def p55hot : BorrowedGeneratedHotPlan.Snapshot :=
  ⟨p55tables,fun b => p55tables.getD b ⟨#[],#[]⟩,p55fallback,⟨#[],actualGroup⟩,actualNext⟩
def p55snapshot : BorrowedNextGeneratedHotPlan.Snapshot :=
  ⟨p55hot,⟨#[⟨#[],actualNext 0⟩,⟨#[],actualNext 1⟩,⟨#[],actualNext 2⟩]⟩,[99,125]⟩
def p55view : SourceBlockGuard.View := ⟨⟨99,99,99,1127,1127,1127,1,1,55⟩,(1,1,1)⟩
def p55ctx : Context := ⟨89,3,(99,99,99),874⟩
def p55ids : Triple := (1127,1127,1127)
def p55sourceBits : ByteArray := (ByteArray.mk #[255,255,255,255,7,0,252,0])
def p55compact : ByteArray := (ByteArray.mk #[128])



/-- Actual ordinal order r=0..55. No row is repeated to enlarge a count. -/
structure Entry where
  block : Nat
  ids : Triple
  byte : UInt8

def entries : Array Entry := #[
  ⟨0,(1017,1017,1017),128⟩,
  ⟨0,(1017,1017,1018),128⟩,
  ⟨0,(1017,1018,1018),128⟩,
  ⟨0,(1018,1018,1018),128⟩,
  ⟨0,(1017,1017,1019),128⟩,
  ⟨0,(1017,1018,1019),128⟩,
  ⟨0,(1018,1018,1019),128⟩,
  ⟨0,(1017,1019,1019),128⟩,
  ⟨0,(1018,1019,1019),128⟩,
  ⟨0,(1019,1019,1019),128⟩,
  ⟨0,(1017,1017,1020),128⟩,
  ⟨0,(1017,1018,1020),128⟩,
  ⟨0,(1018,1018,1020),128⟩,
  ⟨0,(1017,1019,1020),128⟩,
  ⟨0,(1018,1019,1020),128⟩,
  ⟨0,(1019,1019,1020),128⟩,
  ⟨0,(1017,1020,1020),128⟩,
  ⟨0,(1018,1020,1020),128⟩,
  ⟨0,(1019,1020,1020),128⟩,
  ⟨0,(1020,1020,1020),128⟩,
  ⟨0,(1017,1017,1021),128⟩,
  ⟨0,(1017,1018,1021),128⟩,
  ⟨0,(1018,1018,1021),128⟩,
  ⟨0,(1017,1019,1021),128⟩,
  ⟨0,(1018,1019,1021),128⟩,
  ⟨0,(1019,1019,1021),128⟩,
  ⟨0,(1017,1020,1021),128⟩,
  ⟨0,(1018,1020,1021),128⟩,
  ⟨0,(1019,1020,1021),128⟩,
  ⟨0,(1020,1020,1021),128⟩,
  ⟨0,(1017,1021,1021),128⟩,
  ⟨0,(1018,1021,1021),128⟩,
  ⟨0,(1019,1021,1021),128⟩,
  ⟨0,(1020,1021,1021),128⟩,
  ⟨0,(1021,1021,1021),128⟩,
  ⟨1,(1017,1017,1127),97⟩,
  ⟨1,(1017,1018,1127),97⟩,
  ⟨1,(1018,1018,1127),97⟩,
  ⟨1,(1017,1019,1127),97⟩,
  ⟨1,(1018,1019,1127),97⟩,
  ⟨1,(1019,1019,1127),97⟩,
  ⟨1,(1017,1020,1127),97⟩,
  ⟨1,(1018,1020,1127),97⟩,
  ⟨1,(1019,1020,1127),97⟩,
  ⟨1,(1020,1020,1127),97⟩,
  ⟨1,(1017,1021,1127),97⟩,
  ⟨1,(1018,1021,1127),97⟩,
  ⟨1,(1019,1021,1127),97⟩,
  ⟨1,(1020,1021,1127),97⟩,
  ⟨1,(1021,1021,1127),97⟩,
  ⟨2,(1017,1127,1127),128⟩,
  ⟨2,(1018,1127,1127),128⟩,
  ⟨2,(1019,1127,1127),128⟩,
  ⟨2,(1020,1127,1127),128⟩,
  ⟨2,(1021,1127,1127),128⟩,
  ⟨3,(1127,1127,1127),128⟩
]

def sourceBits : ByteArray := p0sourceBits

def rowSnapshot (block : Nat) : BorrowedNextGeneratedHotPlan.Snapshot :=
  if block = 0 then p0snapshot else if block = 1 then n35snapshot
  else if block = 2 then p50snapshot else p55snapshot

def rowView (block : Nat) : SourceBlockGuard.View :=
  if block = 0 then p0view else if block = 1 then n35view
  else if block = 2 then p50view else p55view

def rowContext (block : Nat) : Context :=
  if block = 0 then p0ctx else if block = 1 then n35ctx
  else if block = 2 then p50ctx else p55ctx

/-- Each absolute r uses the SAME frozen scalar checker and actual bit. -/
def checkRow (r : Nat) : Bool :=
  let e := entries.getD r ⟨0,(1017,1017,1017),128⟩
  decide (r < entries.size ∧ e.block < 4) &&
    IndexedByteRowV16.check (rowSnapshot e.block) (rowView e.block)
      (rowContext e.block) e.ids e.byte r (TerminalBucket.labelP sourceBits r)

def checkPrefix (count : Nat) : Bool := CanonicalInventory.checkSpan checkRow 0 count

/-- Metadata-only baseline: no checkRow call is reduced here. -/
theorem literal_row_count : entries.size = 56 := by decide +kernel

end Mahjong.PilotScanDataV18

#print axioms Mahjong.PilotScanDataV18.literal_row_count
