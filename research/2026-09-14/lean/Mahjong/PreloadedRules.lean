import Mahjong.CachedProfiles

set_option autoImplicit false

namespace Mahjong.PreloadedRules
open PackedRules CachedProfiles

def futureWin (tables : Tables) (s : Packed) (u : Tile)
    (a b c h : LocalSummary.Value) : Bool :=
  let k := u.val/9
  let v := (tables k).value ((tables k).next (s.get k) u)
  match k with
  | 0 => winValues v b c h
  | 1 => winValues a v c h
  | 2 => winValues a b v h
  | _ => winValues a b c v

theorem futureWin_eq (tables : Tables) (s : Packed) (u : Tile) :
    futureWin tables s u ((tables 0).value s.a) ((tables 1).value s.b)
      ((tables 2).value s.c) ((tables 3).value s.h) = CachedProfiles.winB tables (add tables s u) := by
  have cases : u.val/9 = 0 ∨ u.val/9 = 1 ∨ u.val/9 = 2 ∨ u.val/9 = 3 := by have bound := u.isLt; omega
  rcases cases with h | h | h | h <;>
    simp only [futureWin, CachedProfiles.winB, add, h, Packed.set, Packed.get]

def safeB (tables : Tables) (s : Packed) : Bool :=
  let a := (tables 0).value s.a
  let b := (tables 1).value s.b
  let c := (tables 2).value s.c
  let h := (tables 3).value s.h
  inside tables s && !winValues a b c h && allTiles.all (fun u =>
    if available tables s u then !futureWin tables s u a b c h else true)

theorem safeB_eq (tables : Tables) (s : Packed) : safeB tables s = PackedRules.safeB tables s := by
  rw [← CachedProfiles.safeB_eq]
  simp only [safeB, CachedProfiles.safeB, futureWin_eq, CachedProfiles.winB]

end Mahjong.PreloadedRules

#print axioms Mahjong.PreloadedRules.safeB_eq
