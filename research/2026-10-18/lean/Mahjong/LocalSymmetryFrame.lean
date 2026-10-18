import Mahjong.Base5Coverage
import Mahjong.Generators

set_option autoImplicit false

namespace Mahjong.LocalSymmetryFrame
open Generators Symmetry

def Allowed (b : Nat) : Generator → Prop
  | .reverseSuit a => a.val = b
  | .swapHonors _ _ => b = 3
  | .swapSuits _ _ => False

def AllowedPath (b : Nat) (path : List Generator) : Prop := ∀ g, g ∈ path → Allowed b g

theorem allowed_frame (b : Nat) (g : Generator) (allowed : Allowed b g) (u : Tile) :
    (g.renaming.bijection.inverse u).val / 9 = u.val / 9 ∧
      (u.val / 9 ≠ b → g.renaming.bijection.inverse u = u) := by
  cases g with
  | reverseSuit a =>
    change a.val = b at allowed
    subst b
    exact (by decide : ∀ a : Fin 3, ∀ u : Tile,
      (reverseSuit a u).val / 9 = u.val / 9 ∧ (u.val / 9 ≠ a.val → reverseSuit a u = u)) a u
  | swapHonors a c =>
    change b = 3 at allowed
    subst b
    exact (by decide : ∀ a c : Fin 7, ∀ u : Tile,
      (swapHonors a c u).val / 9 = u.val / 9 ∧ (u.val / 9 ≠ 3 → swapHonors a c u = u)) a c u
  | swapSuits a c => cases allowed

theorem sameBlock_act (b : Nat) (g : Generator) (allowed : Allowed b g)
    (s t : State) (same : MaskedLocalBound.SameBlock b s t) :
    MaskedLocalBound.SameBlock b (act g s) (act g t) := by
  intro u hu
  exact same _ ((allowed_frame b g allowed u).1.trans hu)

theorem sameBlock_path (b : Nat) (path : List Generator) (allowed : AllowedPath b path)
    (s t : State) (same : MaskedLocalBound.SameBlock b s t) :
    MaskedLocalBound.SameBlock b (applyPath path s) (applyPath path t) := by
  induction path generalizing s t with
  | nil => exact same
  | cons g gs ih =>
    apply ih (fun k hk => allowed k (List.mem_cons_of_mem g hk))
    exact sameBlock_act b g (allowed g (by simp)) s t same

theorem path_outside (b : Nat) (path : List Generator) (allowed : AllowedPath b path)
    (s : State) (u : Tile) (outside : u.val / 9 ≠ b) : applyPath path s u = s u := by
  induction path generalizing s with
  | nil => rfl
  | cons g gs ih =>
    change applyPath gs (act g s) u = s u
    rw [ih (fun k hk => allowed k (List.mem_cons_of_mem g hk))]
    exact congrArg s ((allowed_frame b g (allowed g (by simp)) u).2 outside)

def replaceBlock (b : Nat) (s t : State) : State := fun u => if u.val / 9 = b then t u else s u

theorem lift_witness (b : Nat) (path : List Generator) (allowed : AllowedPath b path)
    (input context output : State) (source : MaskedLocalBound.SameBlock b input context)
    (witness : MaskedLocalBound.SameBlock b output (applyPath path input)) :
    replaceBlock b context output = applyPath path context := by
  funext u
  by_cases hu : u.val / 9 = b
  · rw [replaceBlock, if_pos hu]
    exact (witness u hu).trans (sameBlock_path b path allowed input context source u hu)
  · rw [replaceBlock, if_neg hu, path_outside b path allowed context u hu]

theorem path_safe_iff (path : List Generator) (s : State) : IsSafe (applyPath path s) ↔ IsSafe s := by
  induction path generalizing s with
  | nil => exact Iff.rfl
  | cons g gs ih =>
    exact (ih (act g s)).trans (rename_safe_iff g.renaming)

theorem path_valid (path : List Generator) (s : State) (valid : Valid s) : Valid (applyPath path s) := by
  induction path generalizing s with
  | nil => exact valid
  | cons g gs ih => exact ih _ (rename_valid g.renaming.bijection valid)

theorem unpack_set (p : PackedRules.Packed) (b code : Nat) (hb : b < 4) :
    Base5Coverage.unpack (p.set b code) =
      replaceBlock b (Base5Coverage.unpack p) (LocalCacheEncoding.decodeBlock b code) := by
  funext u
  have ub : u.val / 9 < 4 := by have hu := u.isLt; omega
  simp only [Base5Coverage.unpack, PackedRules.get_set p b _ code hb ub, replaceBlock]
  by_cases eq : u.val / 9 = b
  · simp only [eq, ↓reduceIte]
  · simp only [eq, Ne.symm eq, ↓reduceIte]

theorem decode_valid (b code : Nat) : Valid (LocalCacheEncoding.decodeBlock b code) := by
  intro u
  by_cases block : u.val / 9 = b
  · rw [Base5Coverage.decode_digit b code u block]
    have h := Nat.mod_lt (code / LocalCacheEncoding.powers[u.val % 9]!) (by decide : 0 < 5)
    omega
  · simp [LocalCacheEncoding.decodeBlock, block]

end Mahjong.LocalSymmetryFrame

#print axioms Mahjong.LocalSymmetryFrame.lift_witness
#print axioms Mahjong.LocalSymmetryFrame.path_safe_iff
#print axioms Mahjong.LocalSymmetryFrame.decode_valid
