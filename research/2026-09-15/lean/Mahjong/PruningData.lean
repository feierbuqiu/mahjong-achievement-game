import Mahjong.PruningSemantics
import Mahjong.SummaryEncoding

set_option autoImplicit false

namespace Mahjong.PruningData
open PruningAlgebra PruningSemantics

structure Candidate where
  summary : LocalSummary.Candidate
  raw : Nat → Label

def view (t : LocalSummary.Candidate) (i : Nat) : Profile :=
  ⟨(t.value i).meld, (t.value i).pair⟩

def expectedAdded (b : Nat) (t : LocalSummary.Candidate) (i : Nat) : Profile :=
  envelope (view t i)
    (((PairProfile.blockTiles b).filter (t.available i)).map (fun u => view t (t.next i u)))

def checkRow (b : Nat) (t : Candidate) (i : Nat) : Bool :=
  let actual := t.raw i
  let future := expectedAdded b t.summary i
  decide (actual.current = view t.summary i) &&
  decide (actual.added.meld ≤ future.meld ∧ actual.added.pair ≤ future.pair) &&
  decide (actual.pairs = (t.summary.value i).pairs) &&
  decide (actual.single = (PairProfile.blockTiles b).any
    (fun u => decide (t.summary.core.unrank i u = 1)))

def checkSpan (b : Nat) (t : Candidate) (start : Nat) : Nat → Bool
  | 0 => true
  | n + 1 => checkRow b t start && checkSpan b t (start + 1) n

theorem checkSpan_add (b : Nat) (t : Candidate) (a c start : Nat) :
    checkSpan b t start (a + c) = (checkSpan b t start a && checkSpan b t (start + a) c) := by
  induction a generalizing start with
  | zero => simp [checkSpan]
  | succ a ih =>
    simp only [Nat.succ_add, checkSpan, ih]
    simp [Nat.add_assoc, Nat.add_comm, Nat.add_left_comm, Bool.and_assoc]

theorem checkSpan_each (b : Nat) (t : Candidate) (count start : Nat)
    (checked : checkSpan b t start count = true) :
    ∀ offset, offset < count → checkRow b t (start + offset) = true := by
  induction count generalizing start with
  | zero => intro offset h; omega
  | succ count ih =>
    have parts : checkRow b t start = true ∧ checkSpan b t (start + 1) count = true := by
      simpa only [checkSpan, Bool.and_eq_true] using checked
    intro offset h
    cases offset with
    | zero => simpa using parts.1
    | succ offset =>
      have x := ih (start + 1) parts.2 offset (by omega)
      simpa [Nat.add_assoc, Nat.add_comm, Nat.add_left_comm] using x

def Checked (b : Nat) (t : LocalSummary.Candidate) : Prop :=
  LocalCache.check b t.core = true ∧ LocalSummary.check b t = true

theorem summary_row (b : Nat) (t : LocalSummary.Candidate) (checked : Checked b t)
    (i : Nat) (inside : i < t.core.size) : LocalSummary.checkRow b t i = true := by
  have h := LocalSummary.checkSpan_each b t t.core.size 0 checked.2 i inside
  simpa using h

theorem view_spec (b : Nat) (t : LocalSummary.Candidate) (checked : Checked b t)
    (i : Nat) (inside : i < t.core.size) : view t i = profileOf b (t.core.unrank i) := by
  have h := LocalSummary.row_spec b t checked.1 i inside (summary_row b t checked i inside)
  exact congrArg (fun v : LocalSummary.Value => Profile.mk v.meld v.pair) h

theorem expectedAdded_spec (b : Nat) (t : LocalSummary.Candidate) (checked : Checked b t)
    (i : Nat) (inside : i < t.core.size) : expectedAdded b t i = addedEnvelope b (t.core.unrank i) := by
  have row := summary_row b t checked i inside
  have available : (PairProfile.blockTiles b).filter (t.available i) =
      (PairProfile.blockTiles b).filter (fun u => decide (t.core.unrank i u < 4)) := by
    apply List.filter_congr
    intro u hu
    exact LocalSummary.row_available b t i row u ((PairProfile.mem_blockTiles b u).mp hu)
  unfold expectedAdded addedEnvelope afterProfiles
  rw [view_spec b t checked i inside, available]
  congr 1
  apply List.map_congr_left
  intro u hu
  obtain ⟨block, avail⟩ := List.mem_filter.mp hu
  have hb := (PairProfile.mem_blockTiles b u).mp block
  have av : t.available i u = true := by rw [LocalSummary.row_available b t i row u hb]; exact avail
  have next := LocalSummary.row_next b t i row u hb av
  rw [view_spec b t checked _ next.1]
  have h := LocalSummary.spec_same b _ _ next.2
  exact congrArg (fun v : LocalSummary.Value => Profile.mk v.meld v.pair) h

/-- Passing a local row supplies the non-circular data premise used by the
original-rule no-false-pruning theorem. Other fields are out of scope. -/
theorem checkRow_sound (b : Nat) (t : Candidate) (checked : Checked b t.summary)
    (i : Nat) (inside : i < t.summary.core.size) (row : checkRow b t i = true) :
    PruningBelow (t.raw i) (labelOf b (t.summary.core.unrank i)) := by
  simp only [checkRow, Bool.and_eq_true, decide_eq_true_eq] at row
  obtain ⟨⟨⟨pr, ad⟩, pairs⟩, single⟩ := row
  have cur := view_spec b t.summary checked i inside
  have future := expectedAdded_spec b t.summary checked i inside
  have spec := LocalSummary.row_spec b t.summary checked.1 i inside
    (summary_row b t.summary checked i inside)
  have qeq := congrArg LocalSummary.Value.pairs spec
  simp only [LocalSummary.spec] at qeq
  refine ⟨?_, ?_, ?_, ?_⟩
  · change ProfileBelow (t.raw i).current (profileOf b (t.summary.core.unrank i))
    rw [pr, cur]
    exact ⟨Nat.le_refl _, Nat.le_refl _⟩
  · change ProfileBelow (t.raw i).added (addedEnvelope b (t.summary.core.unrank i))
    rw [← future]
    exact ad
  · change (t.raw i).pairs ≤ _
    rw [pairs, qeq]
    exact Nat.le_refl _
  · intro h
    change (PairProfile.blockTiles b).any (fun u => decide (t.summary.core.unrank i u = 1)) = true
    rw [← single]
    exact h

def rawLabel (data : ByteArray) (i : Nat) : Label :=
  let pr := data[i*12]!.toNat
  let ad := data[i*12+1]!.toNat
  ⟨⟨pr % 8, pr / 8⟩, ⟨ad % 8, ad / 8⟩,
    data[i*12+2]!.toNat, decide (0 < data[i*12+3]!.toNat),
    data[i*12+4]!.toNat, decide (0 < data[i*12+5]!.toNat), data[i*12+6]!.toNat⟩

def candidate (b : Nat) (core summary raw : ByteArray) : Candidate :=
  ⟨SummaryEncoding.candidate b core summary, rawLabel raw⟩

end Mahjong.PruningData

#print axioms Mahjong.PruningData.checkRow_sound
#print axioms Mahjong.PruningData.checkSpan_each
#print axioms Mahjong.PruningData.checkSpan_add
