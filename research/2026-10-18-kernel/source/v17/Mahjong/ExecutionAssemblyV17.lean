import Mahjong.RuntimeBindingV17

set_option autoImplicit false

/-!
Fast proof assembly need not execute the reference checker for a second time.
This module composes finite row-acceptance equations supplied by the proven
scan loop. All choice and row witnesses are inside proofs and are erased.
The actual all-row equations still have to come from that scan; they are not
inferred from a receipt, row count, or a semantic strategy hypothesis.
-/

namespace Mahjong.ExecutionAssemblyV17

open SafeGame PackedRules GeneralLayer CrossLayerAssemblyV17

def proposalAccepted (c : GlobalEnumeration.Certificate) (data : Nat → SuccessorCache.Data)
    (source : GeneralIndex.Bucket) (w : BucketWork c data source) (p : RowProposal) (r : Nat) : Bool :=
  checkActualRow c data source { w with propose := fun _ => p } r

def targetChecks {c : GlobalEnumeration.Certificate} {data : Nat → SuccessorCache.Data}
    (table : Candidate c data) : Bool :=
  (List.range layerCount).all fun n => (List.range bucketCount).all fun h =>
    if nl : n < layerCount then
      if hb : h < bucketCount then
        if positive : 0 < (table.sources ⟨n,nl⟩ ⟨h,hb⟩).data.size then
          checkTargets table n (table.work ⟨n,nl⟩ ⟨h,hb⟩ positive).next
        else true
      else false
    else false

/-- A finite family of Boolean row equations. No game strategy, next-layer
correctness, coordinate correctness or GPU correctness is assumed. -/
def RowChecks {c : GlobalEnumeration.Certificate} {data : Nat → SuccessorCache.Data}
    (table : Candidate c data) : Prop :=
  ∀ (n : Fin layerCount) (h : Fin bucketCount)
    (positive : 0 < (table.sources n h).data.size) (r : Nat),
    r < (table.sources n h).data.size →
      ∃ p, proposalAccepted c data (table.sources n h) (table.work n h positive) p r = true

theorem targetChecks_cell {c : GlobalEnumeration.Certificate} {data : Nat → SuccessorCache.Data}
    (table : Candidate c data) (accepted : targetChecks table = true)
    (n : Fin layerCount) (h : Fin bucketCount) (positive : 0 < (table.sources n h).data.size) :
    checkTargets table n.val (table.work n h positive).next = true := by
  have layer := List.all_eq_true.mp accepted n.val (List.mem_range.mpr n.isLt)
  have cell := List.all_eq_true.mp layer h.val (List.mem_range.mpr h.isLt)
  simpa only [n.isLt, h.isLt, positive, ↓reduceDIte] using cell

theorem layer_step (c : GlobalEnumeration.Certificate) (data : Nat → SuccessorCache.Data)
    (cacheChecked : GlobalSuccessorBridge.Checked c data) (table : Candidate c data)
    (targets : targetChecks table = true) (rows : RowChecks table)
    (n : Nat) (nl : n < layerCount) (next : LayerSound table (n + 1)) : LayerSound table n := by
  intro h r bound
  by_cases hb : h < bucketCount
  · let source := table.sources ⟨n,nl⟩ ⟨h,hb⟩
    have eqSource : sourceAt table n h = source := by
      simp only [sourceAt, nl, hb, ↓reduceDIte, source]
    rw [eqSource] at bound ⊢
    have positive : 0 < source.data.size := by omega
    let w := table.work ⟨n,nl⟩ ⟨h,hb⟩ positive
    have identity := targetChecks_cell table targets ⟨n,nl⟩ ⟨h,hb⟩ positive
    have correct := targets_of_next_layer table n w.next identity next
    obtain ⟨p, accepted⟩ := rows ⟨n,nl⟩ ⟨h,hb⟩ positive r bound
    exact (checked_actual_row_sound c data cacheChecked source
      { w with propose := fun _ => p } correct r accepted).2
  · have zero := sourceAt_outside_bucket table n h hb
    omega

/-- This theorem consumes the scan results without running any scan or
GeneratedPlanCheck.checkPlan again. Its proof performs the descending game
induction, including the genuinely empty layer after layer 34. -/
theorem all_layers (c : GlobalEnumeration.Certificate) (data : Nat → SuccessorCache.Data)
    (cacheChecked : GlobalSuccessorBridge.Checked c data) (table : Candidate c data)
    (targets : targetChecks table = true) (rows : RowChecks table) : ∀ n, LayerSound table n := by
  apply descending_layers layerCount (LayerSound table)
  · intro n outside h r bound
    have zero := sourceAt_outside_layer table n h (by omega)
    omega
  · exact layer_step c data cacheChecked table targets rows

theorem empty_normal (c : GlobalEnumeration.Certificate) (data : Nat → SuccessorCache.Data)
    (cacheChecked : GlobalSuccessorBridge.Checked c data) (table : Candidate c data)
    (targets : targetChecks table = true) (rows : RowChecks table)
    (root : EmptyRootV17.checkP (RuntimeBindingV17.root table).data
      (RuntimeBindingV17.root table).bits = true) : NormalStrategy SafeMove empty .P := by
  have facts := EmptyRootV17.checkP_parts (RuntimeBindingV17.root table).data
    (RuntimeBindingV17.root table).bits root
  have inside := EmptyRootV17.inside (RuntimeBindingV17.root table).data facts.1
  have same := EmptyRootV17.decode_empty (RuntimeBindingV17.root table).data facts.1
  have strategy := (all_layers c data cacheChecked table targets rows 0 0 0 inside).2
  change NormalStrategy SafeMove
    (Base5Coverage.unpack (BucketIndex.unrank (RuntimeBindingV17.root table).data 0))
    (outcome (TerminalBucket.labelP (RuntimeBindingV17.root table).bits 0)) at strategy
  simpa only [same, facts.2.2, outcome, ↓reduceIte] using strategy

theorem empty_second_player_wins (c : GlobalEnumeration.Certificate)
    (data : Nat → SuccessorCache.Data) (cacheChecked : GlobalSuccessorBridge.Checked c data)
    (table : Candidate c data) (targets : targetChecks table = true) (rows : RowChecks table)
    (root : EmptyRootV17.checkP (RuntimeBindingV17.root table).data
      (RuntimeBindingV17.root table).bits = true) : SecondPlayerWins Step Win empty :=
  original_second_player_wins_of_safe_P (empty_normal c data cacheChecked table targets rows root)

end Mahjong.ExecutionAssemblyV17

#print axioms Mahjong.ExecutionAssemblyV17.targetChecks_cell
#print axioms Mahjong.ExecutionAssemblyV17.layer_step
#print axioms Mahjong.ExecutionAssemblyV17.all_layers
#print axioms Mahjong.ExecutionAssemblyV17.empty_normal
#print axioms Mahjong.ExecutionAssemblyV17.empty_second_player_wins
