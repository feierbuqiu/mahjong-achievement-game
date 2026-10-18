import Mahjong.GuardedByteScanV16

set_option autoImplicit false
set_option maxRecDepth 16384
set_option maxHeartbeats 4000000

/-! Actual n32h89 data read footprint, exported by capture/export_rows.py.
This proves literal hot-checker acceptance only. It is not a full
enumeration/metadata certificate, snapshot-global equality or game strategy.
Unused memo indices use explicit defaults; all four actual successor lists
and every accessed template/target bit are captured from the actual files. -/

namespace Mahjong.PilotScanV18
open GroupCandidates BlockPlanCheck

def actualGroup (j : Nat) : Nat := if j = 1017 then 90 else if j = 1127 then 99 else if j = 2495 then 151 else if j = 2496 then 151 else if j = 2497 then 151 else if j = 2498 then 151 else if j = 2499 then 151 else if j = 2500 then 151 else if j = 2501 then 151 else if j = 2502 then 151 else if j = 2507 then 153 else if j = 2508 then 153 else if j = 2509 then 153 else if j = 2510 then 153 else if j = 2511 then 153 else if j = 2512 then 153 else if j = 2513 then 153 else if j = 2514 then 153 else if j = 2515 then 153 else if j = 2516 then 153 else if j = 2517 then 153 else if j = 2518 then 153 else if j = 2519 then 153 else if j = 2520 then 153 else if j = 2521 then 153 else if j = 2522 then 153 else if j = 2727 then 163 else if j = 2728 then 163 else if j = 2734 then 165 else if j = 2735 then 165 else if j = 2736 then 165 else if j = 2737 then 165 else if j = 2738 then 165 else if j = 4382 then 205 else if j = 4383 then 205 else if j = 4384 then 205 else if j = 4385 then 205 else if j = 4386 then 205 else if j = 4387 then 205 else if j = 4388 then 205 else if j = 4389 then 205 else if j = 4853 then 223 else 0
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
theorem p0_source_label : TerminalBucket.labelP p0sourceBits 0 = true := by decide
theorem p0_row_accepted : IndexedByteRowV16.check p0snapshot p0view p0ctx p0ids 128 0 true = true := by decide
theorem p0_scan_accepted : GuardedByteScanV16.scan p0snapshot p0view p0ctx p0sourceBits p0compact 0 1 0 1017 1017 1017 0 = .ok 1 := by
  simp only [GuardedByteScanV16.scan, FastBitRead.labelPNat_eq, p0_source_label]
  change (if IndexedByteRowV16.check p0snapshot p0view p0ctx p0ids 128 0 true then
    (Except.ok 1 : Except Nat Nat) else .error 0) = .ok 1
  rw [p0_row_accepted]
  rfl
theorem p0_bad_byte_rejected : IndexedByteRowV16.check p0snapshot p0view p0ctx p0ids 129 0 true = false := by decide
theorem p0_bad_source_r_rejected : IndexedByteRowV16.check p0snapshot p0view p0ctx p0ids 128 1 true = false := by decide

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
theorem n35_source_label : TerminalBucket.labelP n35sourceBits 35 = false := by decide
theorem n35_row_accepted : IndexedByteRowV16.check n35snapshot n35view n35ctx n35ids 97 35 false = true := by decide
theorem n35_scan_accepted : GuardedByteScanV16.scan n35snapshot n35view n35ctx n35sourceBits n35compact 35 1 35 1017 1017 1127 0 = .ok 0 := by
  simp only [GuardedByteScanV16.scan, FastBitRead.labelPNat_eq, n35_source_label]
  change (if IndexedByteRowV16.check n35snapshot n35view n35ctx n35ids 97 35 false then
    (Except.ok 0 : Except Nat Nat) else .error 35) = .ok 0
  rw [n35_row_accepted]
  rfl
theorem n35_bad_byte_rejected : IndexedByteRowV16.check n35snapshot n35view n35ctx n35ids 127 35 false = false := by decide
theorem n35_bad_source_r_rejected : IndexedByteRowV16.check n35snapshot n35view n35ctx n35ids 97 36 false = false := by decide

end Mahjong.PilotScanV18

#print axioms Mahjong.PilotScanV18.p0_source_label
#print axioms Mahjong.PilotScanV18.p0_row_accepted
#print axioms Mahjong.PilotScanV18.p0_scan_accepted
#print axioms Mahjong.PilotScanV18.p0_bad_byte_rejected
#print axioms Mahjong.PilotScanV18.p0_bad_source_r_rejected
#print axioms Mahjong.PilotScanV18.n35_source_label
#print axioms Mahjong.PilotScanV18.n35_row_accepted
#print axioms Mahjong.PilotScanV18.n35_scan_accepted
#print axioms Mahjong.PilotScanV18.n35_bad_byte_rejected
#print axioms Mahjong.PilotScanV18.n35_bad_source_r_rejected
