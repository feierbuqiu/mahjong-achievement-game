import Mahjong.CachedProfiles

set_option autoImplicit false

namespace Mahjong.FlatProfiles

@[inline] def winValues (a b c h : LocalSummary.Value) : Bool :=
  !(!decide (7 ≤ a.pairs+b.pairs+c.pairs+h.pairs) &&
    !((a.orphanAll && b.orphanAll && c.orphanAll && h.orphanAll) &&
      (a.orphanPair || b.orphanPair || c.orphanPair || h.orphanPair)) &&
    (decide (a.pair=0 ∨ a.pair+(b.meld+c.meld+h.meld)≤4) &&
     decide (b.pair=0 ∨ b.pair+(a.meld+c.meld+h.meld)≤4) &&
     decide (c.pair=0 ∨ c.pair+(a.meld+b.meld+h.meld)≤4) &&
     decide (h.pair=0 ∨ h.pair+(a.meld+b.meld+c.meld)≤4)))

theorem winValues_eq (a b c h : LocalSummary.Value) :
    winValues a b c h = CachedProfiles.winValues a b c h := by
  simp only [winValues, CachedProfiles.winValues, SummaryRules.noWinB,
    SummaryRules.sevenPairsB, SummaryRules.orphansB, SummaryRules.noStandardB,
    SummaryRules.others, List.all_cons, List.all_nil, Bool.and_true, Bool.and_assoc]

end Mahjong.FlatProfiles

#print axioms Mahjong.FlatProfiles.winValues_eq
