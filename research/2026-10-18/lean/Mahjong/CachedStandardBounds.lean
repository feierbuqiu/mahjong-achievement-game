import Mahjong.StandardBoundCertificate
import Mahjong.MaskedLocalBound

/-!
Assembly layer for reusable local-capacity proofs. The expensive local false
equations can be established once for a local pattern, then transported to
each occurrence. This module does not recompute local search while composing
the global negative or SAFE fact.
-/
namespace Mahjong.CachedStandardBounds

open StandardBoundCertificate

structure FourLocalBounds (s : State) (c : Caps) : Prop where
  total_lt_four : c.total < 4
  suit0 : searchWith (localMelds 0) (c.suit0 + 1) s = false
  suit1 : searchWith (localMelds 1) (c.suit1 + 1) s = false
  suit2 : searchWith (localMelds 2) (c.suit2 + 1) s = false
  honors : searchWith (localMelds 3) (c.honors + 1) s = false

theorem FourLocalBounds.checked {s : State} {c : Caps} (h : FourLocalBounds s c) :
    checkAfterPair s c = true := by
  simp only [checkAfterPair, h.total_lt_four, decide_true, h.suit0, h.suit1,
    h.suit2, h.honors, Bool.not_false, Bool.and_self]

structure StandardBounds (s : State) (cert : StandardBoundCert) : Prop where
  pair : ∀ p : Tile, FastRuleChecker.pairAvailableB s p = true →
    FourLocalBounds (FastRuleChecker.removePair s p) (cert p)

theorem StandardBounds.checked {s : State} {cert : StandardBoundCert}
    (h : StandardBounds s cert) : checkStandardBound s cert = true := by
  simp only [checkStandardBound, List.all_eq_true]
  intro p _
  by_cases hp : FastRuleChecker.pairAvailableB s p = true
  · simp only [hp, ↓reduceIte]
    exact (h.pair p hp).checked
  · simp [hp]

theorem no_standard_of_bounds {s : State} {cert : StandardBoundCert}
    (h : StandardBounds s cert) : ¬ ∃ target, Standard target ∧ Contains target s :=
  checkStandardBound_sound s cert h.checked

theorem no_win_of_bounds {s : State} {cert : StandardBoundCert}
    (h : StandardBounds s cert)
    (pairs : RuleChecker.sevenPairsB s = false)
    (orphans : RuleChecker.orphansB s = false) : ¬ Win s := by
  rintro ⟨target, ht, hc⟩
  rcases ht.2 with hs | hp | ho
  · exact no_standard_of_bounds h ⟨target, hs, hc⟩
  · have hh := (RuleChecker.sevenPairsB_iff s).2 ⟨target, hp, hc⟩
    rw [pairs] at hh
    contradiction
  · have hh := (RuleChecker.orphansB_iff s).2 ⟨target, ho, hc⟩
    rw [orphans] at hh
    contradiction

/-- A cached upper bound remains true after removing arbitrary tiles. -/
theorem search_false_of_contains (allowed : List Meld) (k : Nat) {small large : State}
    (h : Contains small large) (checked : searchWith allowed k large = false) :
    searchWith allowed k small = false := by
  apply Bool.eq_false_iff.2
  intro hs
  obtain ⟨ms, hl, ha, hc⟩ := (searchWith_iff allowed k small).1 hs
  have ht := (searchWith_iff allowed k large).2 ⟨ms, hl, ha, contains_trans hc h⟩
  rw [checked] at ht
  contradiction

/-- A cached local pattern may dominate the current block, not merely equal it. -/
theorem transfer_upper (b cap : Nat) (s cached : State)
    (covered : RuleChecker.containsB (MaskedLocalBound.mask b s)
      (MaskedLocalBound.mask b cached) = true)
    (checked : searchWith (localMelds b) (cap + 1)
      (MaskedLocalBound.mask b cached) = false) :
    searchWith (localMelds b) (cap + 1) s = false := by
  have hn := search_false_of_contains (localMelds b) (cap + 1)
    ((RuleChecker.containsB_iff _ _).1 covered) checked
  rw [MaskedLocalBound.search_mask_eq] at hn
  exact hn

structure CachedLocalBound (b cap : Nat) (s : State) where
  pattern : State
  covered : RuleChecker.containsB (MaskedLocalBound.mask b s)
    (MaskedLocalBound.mask b pattern) = true
  checked : searchWith (localMelds b) (cap + 1) (MaskedLocalBound.mask b pattern) = false

theorem CachedLocalBound.sound {b cap : Nat} {s : State} (h : CachedLocalBound b cap s) :
    searchWith (localMelds b) (cap + 1) s = false :=
  transfer_upper b cap s h.pattern h.covered h.checked

end Mahjong.CachedStandardBounds

#print axioms Mahjong.CachedStandardBounds.no_win_of_bounds
