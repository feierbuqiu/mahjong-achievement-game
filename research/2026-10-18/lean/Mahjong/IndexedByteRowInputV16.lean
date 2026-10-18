import Mahjong.RowScheduleV13

set_option autoImplicit false

namespace Mahjong.IndexedByteRowInputV16

/-- Byte base changes from the whole frame to its actual scheduled piece.
The absolute game/source row remains i. -/
def localOffset (piece : RowScheduleV13.Chunk) (i : Nat) : Nat :=
  (i-piece.first)*1

theorem local_row_origin (piece : RowScheduleV13.Chunk) (i : Nat)
    (lower : piece.first ≤ i) : piece.first+(i-piece.first) = i := by
  omega

/-- Every one-byte proposal read by the guarded source loop is in its OWN
independently allocated piece, given the actual runtime length guard. -/
theorem local_word_in_bounds (piece : RowScheduleV13.Chunk) (bytes : ByteArray) (i : Nat)
    (length : bytes.size = piece.count*1)
    (lower : piece.first ≤ i) (upper : i < piece.first+piece.count) :
    localOffset piece i+1 ≤ bytes.size := by
  simp only [localOffset]
  omega

private theorem sum_byte_widths (chunks : List RowScheduleV13.Chunk) :
    (chunks.map (fun c => c.count*1)).sum = (chunks.map RowScheduleV13.Chunk.count).sum*1 := by
  induction chunks with
  | nil => simp
  | cons c cs ih =>
    simp only [List.map_cons,List.sum_cons]
    rw [ih]
    omega

/-- This is the exact count*1 wire length; no padding exists between pieces. -/
theorem checked_schedule_total_bytes (chunks : List RowScheduleV13.Chunk) (start count : Nat)
    (accepted : RowScheduleV13.checkSchedule chunks start count 12 1 = true) :
    (chunks.map (fun c => c.count*1)).sum = count*1 := by
  rw [sum_byte_widths]
  exact congrArg (fun n => n*1) (RowScheduleV13.checked_total_rows chunks start count 12 1 accepted)

/-- The same checked schedule covers every absolute source row after each
round1 worker receives its corresponding independent byte array. P may be the
unchanged certified actual-source-r/P-all/N-member game conclusion. -/
theorem checked_fragments_all_rows (chunks : List RowScheduleV13.Chunk) (start count : Nat)
    (P : Nat → Prop)
    (accepted : RowScheduleV13.checkSchedule chunks start count 12 1 = true)
    (workers : ∀ w, w < 12 → ∀ i,
      (RowScheduleV13.get chunks w).first ≤ i →
      i < (RowScheduleV13.get chunks w).first+(RowScheduleV13.get chunks w).count → P i) :
    ∀ i, start ≤ i → i < start+count → P i := by
  apply RowScheduleV13.scheduled_all_rows chunks start count 12 1 P accepted
  intro w hw r hr i lower upper
  have zero : r = 0 := by omega
  subst r
  exact workers w hw i (by simpa using lower) (by simpa using upper)

#print axioms local_row_origin
#print axioms local_word_in_bounds
#print axioms checked_schedule_total_bytes
#print axioms checked_fragments_all_rows

/-- Checked block sub-runs retain complete worker coverage. The cursor itself
is untrusted; each row still checks SourceBlockGuard.checkAddress. -/
theorem checked_block_runs_all_rows (chunks : List RowScheduleV13.Chunk) (first count : Nat)
    (P : Nat → Prop) (accepted : RowScheduleV13.checkCover chunks first (first+count) = true)
    (each : ∀ k, k < chunks.length → ∀ i, (RowScheduleV13.get chunks k).first ≤ i →
      i < (RowScheduleV13.get chunks k).first+(RowScheduleV13.get chunks k).count → P i) :
    ∀ i, first ≤ i → i < first+count → P i := by
  intro i lo hi
  obtain ⟨k,hk,klo,khi⟩ := RowScheduleV13.checkCover_covers chunks first (first+count) i accepted lo hi
  exact each k hk i klo khi

#print axioms checked_block_runs_all_rows
end Mahjong.IndexedByteRowInputV16
