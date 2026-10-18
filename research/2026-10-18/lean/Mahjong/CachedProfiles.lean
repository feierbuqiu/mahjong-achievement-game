import Mahjong.PackedRules

set_option autoImplicit false

namespace Mahjong.CachedProfiles
open PackedRules

@[noinline] def winValues (a b c h : LocalSummary.Value) : Bool :=
  !SummaryRules.noWinB (fun k => match k with | 0 => a | 1 => b | 2 => c | _ => h)

def winB (tables : Tables) (s : Packed) : Bool :=
  winValues ((tables 0).value s.a) ((tables 1).value s.b) ((tables 2).value s.c) ((tables 3).value s.h)

theorem winB_eq (tables : Tables) (s : Packed) : winB tables s = PackedRules.winB tables s := by
  simp only [winB, winValues, PackedRules.winB, profiles, Packed.get,
    SummaryRules.noWinB, SummaryRules.sevenPairsB, SummaryRules.orphansB,
    SummaryRules.noStandardB, List.all_cons, List.all_nil, SummaryRules.others]

def safeB (tables : Tables) (s : Packed) : Bool :=
  inside tables s && !winB tables s && allTiles.all (fun u =>
    if available tables s u then !winB tables (add tables s u) else true)

theorem safeB_eq (tables : Tables) (s : Packed) : safeB tables s = PackedRules.safeB tables s := by
  simp only [safeB, PackedRules.safeB, winB_eq]

end Mahjong.CachedProfiles

#print axioms Mahjong.CachedProfiles.safeB_eq
