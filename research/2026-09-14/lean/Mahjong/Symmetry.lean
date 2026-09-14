import Mahjong.Rules
import Mahjong.Quotient

set_option maxRecDepth 8192
set_option maxHeartbeats 800000

/-!
Rule-preserving tile renamings. Counts are pulled back by the inverse tile
bijection. All three target constructors, every legal addition, and SAFE
transitions are preserved. Concrete generators are checked on the finite
tile/meld domains by kernel `decide`.

This does not identify the C++ canonicalizer with the orbit quotient. Such a
connection still needs a representation theorem and complete transitions.
-/

namespace Mahjong.Symmetry

open Mahjong.SafeGame Mahjong.Quotient

structure TileBijection where
  forward : Tile → Tile
  inverse : Tile → Tile
  left_inv : ∀ t, inverse (forward t) = t
  right_inv : ∀ t, forward (inverse t) = t

def TileBijection.symm (b : TileBijection) : TileBijection where
  forward := b.inverse
  inverse := b.forward
  left_inv := b.right_inv
  right_inv := b.left_inv

def rename (b : TileBijection) (s : Counts) : Counts := fun t => s (b.inverse t)

theorem TileBijection.injective (b : TileBijection) {s t : Tile}
    (h : b.forward s = b.forward t) : s = t := by
  have hi := congrArg b.inverse h
  simpa only [b.left_inv] using hi

theorem TileBijection.inverse_eq_iff (b : TileBijection) (s t : Tile) :
    b.inverse s = t ↔ s = b.forward t := by
  constructor
  · intro h
    have hi := congrArg b.forward h
    simpa only [b.right_inv] using hi
  · intro h
    rw [h, b.left_inv]

@[simp] theorem rename_forward (b : TileBijection) (s : Counts) (t : Tile) :
    rename b s (b.forward t) = s t := by
  simp only [rename, b.left_inv]

@[simp] theorem rename_symm_rename (b : TileBijection) (s : Counts) :
    rename b.symm (rename b s) = s := by
  funext t
  exact congrArg s (b.left_inv t)

@[simp] theorem rename_rename_symm (b : TileBijection) (s : Counts) :
    rename b (rename b.symm s) = s := by
  funext t
  exact congrArg s (b.right_inv t)

theorem rename_valid (b : TileBijection) {s : Counts} (h : Valid s) :
    Valid (rename b s) := fun t => h (b.inverse t)

theorem rename_contains (b : TileBijection) {s t : Counts} (h : Contains s t) :
    Contains (rename b s) (rename b t) := fun u => h (b.inverse u)

theorem rename_addTile (b : TileBijection) (s : Counts) (t : Tile) :
    rename b (addTile s t) = addTile (rename b s) (b.forward t) := by
  funext u
  simp only [rename, addTile, unit, b.inverse_eq_iff]

theorem rename_step (b : TileBijection) {s t : State} (h : Step s t) :
    Step (rename b s) (rename b t) := by
  obtain ⟨tile, legal, rfl⟩ := h
  refine ⟨b.forward tile, ⟨rename_valid b legal.1, ?_⟩, rename_addTile b s tile⟩
  simpa only [rename_forward] using legal.2

theorem rename_step_iff (b : TileBijection) {s t : State} :
    Step (rename b s) (rename b t) ↔ Step s t := by
  constructor
  · intro h
    simpa only [rename_symm_rename] using rename_step b.symm h
  · exact rename_step b

theorem countsOf_perm {xs ys : List Tile} (h : xs.Perm ys) :
    countsOf xs = countsOf ys := by
  funext t
  induction h with
  | nil => rfl
  | cons a p ih => simp only [countsOf, addTile, ih]
  | swap a b ts =>
      simp only [countsOf, addTile]
      omega
  | trans p q ihp ihq => exact ihp.trans ihq

theorem rename_countsOf (b : TileBijection) (ts : List Tile) :
    rename b (countsOf ts) = countsOf (ts.map b.forward) := by
  induction ts with
  | nil => rfl
  | cons t ts ih =>
      simp only [countsOf, List.map_cons]
      rw [rename_addTile, ih]

/-- A finite, explicit witness that a tile map respects the target shapes. -/
structure TargetMap (f : Tile → Tile) where
  meldMap : Meld → Meld
  meldPerm : ∀ m : Meld, (m.tiles.map f).Perm (meldMap m).tiles
  orphansPerm : (orphans.map f).Perm orphans

/-- Forward and inverse target witnesses are both required. -/
structure TileRenaming where
  bijection : TileBijection
  forwardTargets : TargetMap bijection.forward
  inverseTargets : TargetMap bijection.inverse

def TileRenaming.symm (r : TileRenaming) : TileRenaming where
  bijection := r.bijection.symm
  forwardTargets := r.inverseTargets
  inverseTargets := r.forwardTargets

def ofInvolution (f : Tile → Tile) (hf : ∀ t, f (f t) = t)
    (targets : TargetMap f) : TileRenaming where
  bijection := ⟨f, f, hf, hf⟩
  forwardTargets := targets
  inverseTargets := targets

theorem rename_standard (b : TileBijection) (targets : TargetMap b.forward)
    {s : Counts} (h : Standard s) : Standard (rename b s) := by
  obtain ⟨melds, pair, rfl⟩ := h
  refine ⟨fun i => targets.meldMap (melds i), b.forward pair, ?_⟩
  rw [rename_countsOf]
  apply countsOf_perm
  simp only [standardTiles, List.map_append, List.map_cons, List.map_nil]
  exact ((((targets.meldPerm (melds 0)).append (targets.meldPerm (melds 1))).append
    (targets.meldPerm (melds 2))).append (targets.meldPerm (melds 3))).append
      (List.Perm.refl _)

theorem rename_sevenPairs (b : TileBijection) {s : Counts} (h : SevenPairs s) :
    SevenPairs (rename b s) := by
  obtain ⟨pairs, distinct, rfl⟩ := h
  refine ⟨fun i => b.forward (pairs i), ?_, ?_⟩
  · intro i j same
    exact distinct i j (b.injective same)
  · rw [rename_countsOf]
    rfl

theorem rename_thirteenOrphans (b : TileBijection) (targets : TargetMap b.forward)
    {s : Counts} (h : ThirteenOrphans s) : ThirteenOrphans (rename b s) := by
  obtain ⟨pair, member, rfl⟩ := h
  refine ⟨b.forward pair, ?_, ?_⟩
  · apply targets.orphansPerm.mem_iff.mp
    exact List.mem_map.mpr ⟨pair, member, rfl⟩
  · rw [rename_countsOf]
    exact countsOf_perm (targets.orphansPerm.cons (b.forward pair))

theorem rename_winningHand (b : TileBijection) (targets : TargetMap b.forward)
    {s : Counts} (h : WinningHand s) : WinningHand (rename b s) := by
  refine ⟨rename_valid b h.1, ?_⟩
  rcases h.2 with standard | pairs | orphan
  · exact Or.inl (rename_standard b targets standard)
  · exact Or.inr (Or.inl (rename_sevenPairs b pairs))
  · exact Or.inr (Or.inr (rename_thirteenOrphans b targets orphan))

theorem rename_win_forward (b : TileBijection) (targets : TargetMap b.forward)
    {s : State} (h : Win s) : Win (rename b s) := by
  obtain ⟨target, hand, contained⟩ := h
  exact ⟨rename b target, rename_winningHand b targets hand, rename_contains b contained⟩

theorem rename_win_iff (r : TileRenaming) {s : State} :
    Win (rename r.bijection s) ↔ Win s := by
  constructor
  · intro h
    have hi := rename_win_forward r.bijection.symm r.inverseTargets h
    simpa only [rename_symm_rename] using hi
  · exact rename_win_forward r.bijection r.forwardTargets

theorem rename_safe (r : TileRenaming) {s : State} (h : Safe Step Win s) :
    Safe Step Win (rename r.bijection s) := by
  refine ⟨fun won => h.1 ((rename_win_iff r).mp won), ?_⟩
  intro t edge won
  have originalEdge : Step s (rename r.bijection.symm t) := by
    simpa only [rename_symm_rename] using rename_step r.bijection.symm edge
  have originalWin : Win (rename r.bijection.symm t) :=
    rename_win_forward r.bijection.symm r.inverseTargets won
  exact h.2 _ originalEdge originalWin

theorem rename_safe_iff (r : TileRenaming) {s : State} :
    Safe Step Win (rename r.bijection s) ↔ Safe Step Win s := by
  constructor
  · intro h
    have hi := rename_safe r.symm h
    simpa only [TileRenaming.symm, rename_symm_rename] using hi
  · exact rename_safe r

theorem rename_safeStep (r : TileRenaming) {s t : State}
    (h : SafeStep Step Win s t) :
    SafeStep Step Win (rename r.bijection s) (rename r.bijection t) :=
  ⟨rename_step r.bijection h.1, rename_safe r h.2⟩

theorem rename_safeStep_iff (r : TileRenaming) {s t : State} :
    SafeStep Step Win (rename r.bijection s) (rename r.bijection t) ↔
      SafeStep Step Win s t := by
  constructor
  · rintro ⟨edge, safe⟩
    exact ⟨(rename_step_iff r.bijection).mp edge, (rename_safe_iff r).mp safe⟩
  · exact rename_safeStep r

theorem renaming_transitionQuotient (r : TileRenaming) :
    TransitionQuotient (SafeStep Step Win) (SafeStep Step Win) (rename r.bijection) := by
  refine ⟨rename_safeStep r, ?_⟩
  intro s q edge
  refine ⟨rename r.bijection.symm q, ?_, rename_rename_symm r.bijection q⟩
  have hi := rename_safeStep r.symm edge
  simpa only [TileRenaming.symm, rename_symm_rename] using hi

theorem renaming_preserves_outcome (r : TileRenaming) {s : State} {o : Outcome} :
    NormalStrategy (SafeStep Step Win) s o ↔
      NormalStrategy (SafeStep Step Win) (rename r.bijection s) o :=
  normalStrategy_iff (renaming_transitionQuotient r)

/-! Three explicit generators, each with finite kernel-checked shape witnesses. -/

/-- Reflect the first numeric suit: 1m ↔ 9m, 2m ↔ 8m, etc. -/
def reflectFirst (t : Tile) : Tile :=
  if t.val < 9 then ⟨8 - t.val, by omega⟩ else t

def reflectedStart (start : Fin 7) : Fin 7 := ⟨6 - start.val, by omega⟩

def reflectFirstMeld : Meld → Meld
  | .triplet t => .triplet (reflectFirst t)
  | .sequence suit start =>
      if suit = 0 then .sequence 0 (reflectedStart start) else .sequence suit start

theorem reflectFirst_involutive : ∀ t : Tile, reflectFirst (reflectFirst t) = t := by
  decide

theorem reflectFirst_meld_perm (m : Meld) :
    (m.tiles.map reflectFirst).Perm (reflectFirstMeld m).tiles := by
  cases m with
  | triplet t =>
      exact (by decide : ∀ t : Tile,
        ((Meld.triplet t).tiles.map reflectFirst).Perm
          (reflectFirstMeld (.triplet t)).tiles) t
  | sequence suit start =>
      exact (by decide : ∀ suit : Fin 3, ∀ start : Fin 7,
        ((Meld.sequence suit start).tiles.map reflectFirst).Perm
          (reflectFirstMeld (.sequence suit start)).tiles) suit start

def reflectFirstTargets : TargetMap reflectFirst where
  meldMap := reflectFirstMeld
  meldPerm := reflectFirst_meld_perm
  orphansPerm := by decide

def reflectFirstRenaming : TileRenaming :=
  ofInvolution reflectFirst reflectFirst_involutive reflectFirstTargets

/-- Exchange the first and second numeric suits, preserving every rank. -/
def swapFirstTwo (t : Tile) : Tile :=
  if small : t.val < 9 then ⟨t.val + 9, by omega⟩
  else if t.val < 18 then ⟨t.val - 9, by omega⟩ else t

def swapFirstTwoSuit (suit : Fin 3) : Fin 3 :=
  if suit = 0 then 1 else if suit = 1 then 0 else suit

def swapFirstTwoMeld : Meld → Meld
  | .triplet t => .triplet (swapFirstTwo t)
  | .sequence suit start => .sequence (swapFirstTwoSuit suit) start

theorem swapFirstTwo_involutive : ∀ t : Tile, swapFirstTwo (swapFirstTwo t) = t := by
  decide

theorem swapFirstTwo_meld_perm (m : Meld) :
    (m.tiles.map swapFirstTwo).Perm (swapFirstTwoMeld m).tiles := by
  cases m with
  | triplet t =>
      exact (by decide : ∀ t : Tile,
        ((Meld.triplet t).tiles.map swapFirstTwo).Perm
          (swapFirstTwoMeld (.triplet t)).tiles) t
  | sequence suit start =>
      exact (by decide : ∀ suit : Fin 3, ∀ start : Fin 7,
        ((Meld.sequence suit start).tiles.map swapFirstTwo).Perm
          (swapFirstTwoMeld (.sequence suit start)).tiles) suit start

def swapFirstTwoTargets : TargetMap swapFirstTwo where
  meldMap := swapFirstTwoMeld
  meldPerm := swapFirstTwo_meld_perm
  orphansPerm := by decide

def swapFirstTwoRenaming : TileRenaming :=
  ofInvolution swapFirstTwo swapFirstTwo_involutive swapFirstTwoTargets

/-- Exchange East and South (indices 27, 28); numeric sequences stay unchanged. -/
def swapTwoHonors (t : Tile) : Tile :=
  if t = 27 then 28 else if t = 28 then 27 else t

def swapTwoHonorsMeld : Meld → Meld
  | .triplet t => .triplet (swapTwoHonors t)
  | .sequence suit start => .sequence suit start

theorem swapTwoHonors_involutive : ∀ t : Tile, swapTwoHonors (swapTwoHonors t) = t := by
  decide

theorem swapTwoHonors_meld_perm (m : Meld) :
    (m.tiles.map swapTwoHonors).Perm (swapTwoHonorsMeld m).tiles := by
  cases m with
  | triplet t =>
      exact (by decide : ∀ t : Tile,
        ((Meld.triplet t).tiles.map swapTwoHonors).Perm
          (swapTwoHonorsMeld (.triplet t)).tiles) t
  | sequence suit start =>
      exact (by decide : ∀ suit : Fin 3, ∀ start : Fin 7,
        ((Meld.sequence suit start).tiles.map swapTwoHonors).Perm
          (swapTwoHonorsMeld (.sequence suit start)).tiles) suit start

def swapTwoHonorsTargets : TargetMap swapTwoHonors where
  meldMap := swapTwoHonorsMeld
  meldPerm := swapTwoHonors_meld_perm
  orphansPerm := by decide

def swapTwoHonorsRenaming : TileRenaming :=
  ofInvolution swapTwoHonors swapTwoHonors_involutive swapTwoHonorsTargets

theorem reflectFirst_preserves_outcome {s : State} {o : Outcome} :
    NormalStrategy (SafeStep Step Win) s o ↔
      NormalStrategy (SafeStep Step Win) (rename reflectFirstRenaming.bijection s) o :=
  renaming_preserves_outcome reflectFirstRenaming

theorem swapFirstTwo_preserves_outcome {s : State} {o : Outcome} :
    NormalStrategy (SafeStep Step Win) s o ↔
      NormalStrategy (SafeStep Step Win) (rename swapFirstTwoRenaming.bijection s) o :=
  renaming_preserves_outcome swapFirstTwoRenaming

theorem swapTwoHonors_preserves_outcome {s : State} {o : Outcome} :
    NormalStrategy (SafeStep Step Win) s o ↔
      NormalStrategy (SafeStep Step Win) (rename swapTwoHonorsRenaming.bijection s) o :=
  renaming_preserves_outcome swapTwoHonorsRenaming

end Mahjong.Symmetry

#print axioms Mahjong.Symmetry.rename_step_iff
#print axioms Mahjong.Symmetry.rename_win_iff
#print axioms Mahjong.Symmetry.rename_safeStep_iff
#print axioms Mahjong.Symmetry.renaming_preserves_outcome
#print axioms Mahjong.Symmetry.reflectFirst_preserves_outcome
#print axioms Mahjong.Symmetry.swapFirstTwo_preserves_outcome
#print axioms Mahjong.Symmetry.swapTwoHonors_preserves_outcome
