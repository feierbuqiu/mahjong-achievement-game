import Mahjong.Symmetry

set_option maxRecDepth 16384
set_option maxHeartbeats 2000000

/-!
Every numeric-suit reflection, numeric-suit transposition, and honor
transposition is certified directly against the original rules. A finite
generator path can accompany a certificate reference; equality to the
transformed physical state, rather than a C++ canonical index, is checked.
-/

namespace Mahjong.Generators

open Mahjong.SafeGame Mahjong.Symmetry

def reverseSuit (suit : Fin 3) (t : Tile) : Tile :=
  if t.val < 27 ∧ t.val / 9 = suit.val then
    ⟨9 * suit.val + (8 - t.val % 9), by have hs := suit.isLt; omega⟩
  else t

def reverseSuitMeld (suit : Fin 3) : Meld → Meld
  | .triplet t => .triplet (reverseSuit suit t)
  | .sequence s start =>
      if s = suit then .sequence s (reflectedStart start) else .sequence s start

theorem reverseSuit_involutive :
    ∀ suit : Fin 3, ∀ t : Tile, reverseSuit suit (reverseSuit suit t) = t := by
  decide

theorem reverseSuit_meld_perm (a : Fin 3) (m : Meld) :
    (m.tiles.map (reverseSuit a)).Perm (reverseSuitMeld a m).tiles := by
  cases m with
  | triplet t =>
      exact (by decide : ∀ a : Fin 3, ∀ t : Tile,
        ((Meld.triplet t).tiles.map (reverseSuit a)).Perm
          (reverseSuitMeld a (.triplet t)).tiles) a t
  | sequence suit start =>
      exact (by decide : ∀ a : Fin 3, ∀ suit : Fin 3, ∀ start : Fin 7,
        ((Meld.sequence suit start).tiles.map (reverseSuit a)).Perm
          (reverseSuitMeld a (.sequence suit start)).tiles) a suit start

def reverseSuitTargets (a : Fin 3) : TargetMap (reverseSuit a) where
  meldMap := reverseSuitMeld a
  meldPerm := reverseSuit_meld_perm a
  orphansPerm := (by decide : ∀ a : Fin 3, (orphans.map (reverseSuit a)).Perm orphans) a

def reverseSuitRenaming (a : Fin 3) : TileRenaming :=
  ofInvolution (reverseSuit a) (reverseSuit_involutive a) (reverseSuitTargets a)

def transposedSuit (a b suit : Fin 3) : Fin 3 :=
  if suit = a then b else if suit = b then a else suit

def swapSuits (a b : Fin 3) (t : Tile) : Tile :=
  if t.val < 27 then
    if t.val / 9 = a.val then
      ⟨9 * b.val + t.val % 9, by
        have hb := b.isLt
        have hm := Nat.mod_lt t.val (by decide : 0 < 9)
        omega⟩
    else if t.val / 9 = b.val then
      ⟨9 * a.val + t.val % 9, by
        have ha := a.isLt
        have hm := Nat.mod_lt t.val (by decide : 0 < 9)
        omega⟩
    else t
  else t

def swapSuitsMeld (a b : Fin 3) : Meld → Meld
  | .triplet t => .triplet (swapSuits a b t)
  | .sequence suit start => .sequence (transposedSuit a b suit) start

theorem swapSuits_involutive :
    ∀ a b : Fin 3, ∀ t : Tile, swapSuits a b (swapSuits a b t) = t := by
  decide

theorem swapSuits_meld_perm (a b : Fin 3) (m : Meld) :
    (m.tiles.map (swapSuits a b)).Perm (swapSuitsMeld a b m).tiles := by
  cases m with
  | triplet t =>
      exact (by decide : ∀ a b : Fin 3, ∀ t : Tile,
        ((Meld.triplet t).tiles.map (swapSuits a b)).Perm
          (swapSuitsMeld a b (.triplet t)).tiles) a b t
  | sequence suit start =>
      exact (by decide : ∀ a b : Fin 3, ∀ suit : Fin 3, ∀ start : Fin 7,
        ((Meld.sequence suit start).tiles.map (swapSuits a b)).Perm
          (swapSuitsMeld a b (.sequence suit start)).tiles) a b suit start

def swapSuitsTargets (a b : Fin 3) : TargetMap (swapSuits a b) where
  meldMap := swapSuitsMeld a b
  meldPerm := swapSuits_meld_perm a b
  orphansPerm := (by decide : ∀ a b : Fin 3,
    (orphans.map (swapSuits a b)).Perm orphans) a b

def swapSuitsRenaming (a b : Fin 3) : TileRenaming :=
  ofInvolution (swapSuits a b) (swapSuits_involutive a b) (swapSuitsTargets a b)

def honorTile (h : Fin 7) : Tile := ⟨27 + h.val, by omega⟩

def swapHonors (a b : Fin 7) (t : Tile) : Tile :=
  if t = honorTile a then honorTile b else if t = honorTile b then honorTile a else t

def swapHonorsMeld (a b : Fin 7) : Meld → Meld
  | .triplet t => .triplet (swapHonors a b t)
  | .sequence suit start => .sequence suit start

theorem swapHonors_involutive :
    ∀ a b : Fin 7, ∀ t : Tile, swapHonors a b (swapHonors a b t) = t := by
  decide

theorem swapHonors_meld_perm (a b : Fin 7) (m : Meld) :
    (m.tiles.map (swapHonors a b)).Perm (swapHonorsMeld a b m).tiles := by
  cases m with
  | triplet t =>
      exact (by decide : ∀ a b : Fin 7, ∀ t : Tile,
        ((Meld.triplet t).tiles.map (swapHonors a b)).Perm
          (swapHonorsMeld a b (.triplet t)).tiles) a b t
  | sequence suit start =>
      exact (by decide : ∀ a b : Fin 7, ∀ suit : Fin 3, ∀ start : Fin 7,
        ((Meld.sequence suit start).tiles.map (swapHonors a b)).Perm
          (swapHonorsMeld a b (.sequence suit start)).tiles) a b suit start

def swapHonorsTargets (a b : Fin 7) : TargetMap (swapHonors a b) where
  meldMap := swapHonorsMeld a b
  meldPerm := swapHonors_meld_perm a b
  orphansPerm := (by decide : ∀ a b : Fin 7,
    (orphans.map (swapHonors a b)).Perm orphans) a b

def swapHonorsRenaming (a b : Fin 7) : TileRenaming :=
  ofInvolution (swapHonors a b) (swapHonors_involutive a b) (swapHonorsTargets a b)

inductive Generator where
  | reverseSuit (suit : Fin 3)
  | swapSuits (a b : Fin 3)
  | swapHonors (a b : Fin 7)
  deriving DecidableEq, Repr

def Generator.renaming : Generator → TileRenaming
  | .reverseSuit suit => reverseSuitRenaming suit
  | .swapSuits a b => swapSuitsRenaming a b
  | .swapHonors a b => swapHonorsRenaming a b

def act (g : Generator) (s : State) : State := rename g.renaming.bijection s

/-- A path acts left to right: its head is applied first. -/
def applyPath : List Generator → State → State
  | [], s => s
  | g :: gs, s => applyPath gs (act g s)

theorem generator_preserves_outcome (g : Generator) {s : State} {o : Outcome} :
    NormalStrategy (SafeStep Step Win) s o ↔
      NormalStrategy (SafeStep Step Win) (act g s) o :=
  renaming_preserves_outcome g.renaming

theorem path_preserves_outcome (path : List Generator) (s : State) (o : Outcome) :
    NormalStrategy (SafeStep Step Win) s o ↔
      NormalStrategy (SafeStep Step Win) (applyPath path s) o := by
  induction path generalizing s with
  | nil => exact Iff.rfl
  | cons g gs ih =>
      exact (generator_preserves_outcome g).trans (ih (act g s))

theorem path_reference_sound {proved physical : State} {o : Outcome}
    (path : List Generator)
    (equality : physical = applyPath path proved)
    (h : NormalStrategy (SafeStep Step Win) proved o) :
    NormalStrategy (SafeStep Step Win) physical o := by
  rw [equality]
  exact (path_preserves_outcome path proved o).mp h

/-- This comparison checks all 34 physical counts, not a hash or profile. -/
def stateEqB (s t : State) : Bool := allTiles.all (fun tile => s tile == t tile)

theorem stateEqB_sound {s t : State} (h : stateEqB s t = true) : s = t := by
  funext tile
  have he := List.all_eq_true.mp h tile (mem_allTiles tile)
  exact of_decide_eq_true he

def checkReference (path : List Generator) (proved physical : State) : Bool :=
  stateEqB physical (applyPath path proved)

theorem checked_reference_sound {proved physical : State} {o : Outcome}
    (path : List Generator) (checked : checkReference path proved physical = true)
    (h : NormalStrategy (SafeStep Step Win) proved o) :
    NormalStrategy (SafeStep Step Win) physical o :=
  path_reference_sound path (stateEqB_sound checked) h

end Mahjong.Generators

#print axioms Mahjong.Generators.reverseSuit_involutive
#print axioms Mahjong.Generators.swapSuits_involutive
#print axioms Mahjong.Generators.swapHonors_involutive
#print axioms Mahjong.Generators.generator_preserves_outcome
#print axioms Mahjong.Generators.path_preserves_outcome
#print axioms Mahjong.Generators.checked_reference_sound
