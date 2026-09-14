import Mahjong.CachedTransitionQuotient

set_option autoImplicit false

namespace Mahjong.SuccessorCoverage
open CanonicalInventory GlobalEnumeration SuccessorCache

theorem span_of_each (row : Nat → Bool) (count start : Nat)
    (all : ∀ k, k < count → row (start+k) = true) : checkSpan row start count = true := by
  induction count generalizing start with
  | zero => rfl
  | succ count ih =>
    simp only [checkSpan,Bool.and_eq_true]
    constructor
    · simpa only [Nat.add_zero] using all 0 (Nat.zero_lt_succ count)
    · apply ih
      intro k hk
      have h := all (k+1) (by omega)
      simpa only [Nat.add_assoc,Nat.add_comm,Nat.add_left_comm] using h

/-- Every row is checked if successful chunks cover its index. This does not
turn external process receipts into assumptions hidden in a proof. -/
theorem chunks_pass (row : Nat → Bool) (count : Nat) (chunks : List (Nat × Nat))
    (passed : ∀ chunk, chunk ∈ chunks → checkSpan row chunk.1 chunk.2 = true)
    (covers : ∀ i, i < count → ∃ chunk, chunk ∈ chunks ∧ chunk.1 ≤ i ∧ i < chunk.1+chunk.2) :
    checkSpan row 0 count = true := by
  apply span_of_each
  intro i hi
  obtain ⟨chunk,member,lo,up⟩ := covers i hi
  have h := checkSpan_each row chunk.2 chunk.1 (passed chunk member) (i-chunk.1) (by omega)
  simpa only [Nat.zero_add,Nat.add_sub_of_le lo] using h

def numericChunks : List (Nat × Nat) :=
  [(0,16384),(16384,16384),(32768,16384),(49152,16384),(65536,16384),
   (81920,16384),(98304,16384),(114688,16384),(131072,604)]

theorem numeric_chunks_cover (i : Nat) (hi : i < 131676) :
    ∃ chunk, chunk ∈ numericChunks ∧ chunk.1 ≤ i ∧ i < chunk.1+chunk.2 := by
  by_cases h0 : i < 16384
  · exact ⟨(0,16384),by simp [numericChunks],by dsimp; omega⟩
  by_cases h1 : i < 32768
  · exact ⟨(16384,16384),by simp [numericChunks],by dsimp; omega⟩
  by_cases h2 : i < 49152
  · exact ⟨(32768,16384),by simp [numericChunks],by dsimp; omega⟩
  by_cases h3 : i < 65536
  · exact ⟨(49152,16384),by simp [numericChunks],by dsimp; omega⟩
  by_cases h4 : i < 81920
  · exact ⟨(65536,16384),by simp [numericChunks],by dsimp; omega⟩
  by_cases h5 : i < 98304
  · exact ⟨(81920,16384),by simp [numericChunks],by dsimp; omega⟩
  by_cases h6 : i < 114688
  · exact ⟨(98304,16384),by simp [numericChunks],by dsimp; omega⟩
  by_cases h7 : i < 131072
  · exact ⟨(114688,16384),by simp [numericChunks],by dsimp; omega⟩
  exact ⟨(131072,604),by simp [numericChunks],by dsimp; omega⟩

def SharedInputs (c : Certificate) : Prop :=
  ∀ b, b < 3 → c.core b = c.core 0 ∧ c.summary b = c.summary 0 ∧
    c.raw b = c.raw 0 ∧ c.ids b = c.ids 0 ∧ c.members b = c.members 0

def data (numeric honors : ByteArray) (b : Nat) : SuccessorCache.Data :=
  SuccessorCache.candidate b (if b = 3 then honors else numeric)

theorem checked_from_two_files (c : Certificate) (shared : SharedInputs c)
    (numeric honors : ByteArray)
    (np : checkSpan (checkRow 0 (inventoriesOf c 0) (GlobalSuccessorBridge.summaries c 0)
      (SuccessorCache.candidate 0 numeric)) 0 (inventoriesOf c 0).count = true)
    (hp : checkSpan (checkRow 3 (inventoriesOf c 3) (GlobalSuccessorBridge.summaries c 3)
      (SuccessorCache.candidate 3 honors)) 0 (inventoriesOf c 3).count = true) :
    GlobalSuccessorBridge.Checked c (data numeric honors) := by
  intro b hb
  by_cases h3 : b = 3
  · subst b
    exact hp
  · have hn : b < 3 := by omega
    obtain ⟨hc,hs,hr,hi,hm⟩ := shared b hn
    change checkSpan (checkRow b (CanonicalInventory.candidate b (c.raw b) (c.ids b) (c.members b))
      (SummaryEncoding.candidate b (c.core b) (c.summary b))
      (SuccessorCache.candidate b (if b = 3 then honors else numeric))) 0 ((c.members b).size/4) = true
    rw [if_neg h3,hc,hs,hr,hi,hm,numeric_span_shared b hn]
    exact np

end Mahjong.SuccessorCoverage

#print axioms Mahjong.SuccessorCoverage.span_of_each
#print axioms Mahjong.SuccessorCoverage.chunks_pass
#print axioms Mahjong.SuccessorCoverage.numeric_chunks_cover
#print axioms Mahjong.SuccessorCoverage.checked_from_two_files
