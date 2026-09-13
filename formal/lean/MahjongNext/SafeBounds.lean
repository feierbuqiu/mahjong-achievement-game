import Mahjong.ResponseCertificate

namespace Mahjong.SafeBounds
open Generators Symmetry

structure Fact where
  state : State
  valid : Valid state
  safe : IsSafe state

theorem path_valid {s : State} (valid : Valid s) (path : List Generator) :
    Valid (applyPath path s) := by
  induction path generalizing s with
  | nil => exact valid
  | cons g gs ih => exact ih (rename_valid g.renaming.bijection valid)

theorem path_safe {s : State} (safe : IsSafe s) (path : List Generator) :
    IsSafe (applyPath path s) := by
  induction path generalizing s with
  | nil => exact safe
  | cons g gs ih => exact ih (rename_safe g.renaming safe)

def Fact.alongPath (fact : Fact) (path : List Generator) : Fact :=
  ⟨applyPath path fact.state, path_valid fact.valid path, path_safe fact.safe path⟩

end Mahjong.SafeBounds

#print axioms Mahjong.SafeBounds.path_valid
#print axioms Mahjong.SafeBounds.path_safe
