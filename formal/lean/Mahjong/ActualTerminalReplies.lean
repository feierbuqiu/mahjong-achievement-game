import Mahjong.ActualCandidateFacts

set_option maxRecDepth 8192
set_option maxHeartbeats 20000000

namespace Mahjong.ActualTerminalReplies

open ActualCandidateFacts

/-- Candidate data only; no external PASS is assumed. -/
def reply (t : Tile) : Tile :=
  match t.val with
  | 0 => 0
  | 1 => 3
  | 2 => 3
  | 3 => 0
  | 6 => 0
  | 8 => 0
  | 9 => 0
  | 10 => 0
  | 11 => 0
  | 12 => 0
  | 13 => 0
  | 14 => 0
  | 15 => 0
  | 16 => 0
  | 17 => 0
  | 18 => 0
  | 19 => 0
  | 20 => 0
  | 21 => 0
  | 22 => 0
  | 23 => 0
  | 24 => 0
  | 25 => 0
  | 26 => 0
  | 27 => 0
  | 28 => 0
  | 29 => 0
  | 30 => 0
  | 31 => 0
  | 32 => 0
  | 33 => 0
  | _ => 0

def isOrphan (t : Tile) : Bool :=
  match t.val with
  | 0 | 8 | 9 | 17 | 18 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 33 => true
  | _ => false

def pair (t : Tile) : Tile :=
  match t.val with
  | 0 => 0
  | 1 => 1
  | 2 => 2
  | 3 => 4
  | 6 => 4
  | 8 => 8
  | 9 => 9
  | 10 => 4
  | 11 => 11
  | 12 => 4
  | 13 => 13
  | 14 => 14
  | 15 => 4
  | 16 => 16
  | 17 => 17
  | 18 => 18
  | 19 => 4
  | 20 => 20
  | 21 => 4
  | 22 => 22
  | 23 => 23
  | 24 => 4
  | 25 => 25
  | 26 => 26
  | 27 => 27
  | 28 => 28
  | 29 => 29
  | 30 => 30
  | 31 => 31
  | 32 => 32
  | 33 => 33
  | _ => 0

def melds (t : Tile) (i : Fin 4) : Meld :=
  match t.val with
  | 1 => match i.val with
    | 0 => .triplet 4
    | 1 => .triplet 5
    | 2 => .triplet 7
    | _ => .sequence 0 2
  | 2 => match i.val with
    | 0 => .triplet 4
    | 1 => .triplet 5
    | 2 => .triplet 7
    | _ => .sequence 0 3
  | 3 => match i.val with
    | 0 => .triplet 5
    | 1 => .triplet 7
    | 2 => .sequence 0 0
    | _ => .sequence 0 3
  | 6 => match i.val with
    | 0 => .triplet 5
    | 1 => .triplet 7
    | 2 => .sequence 0 0
    | _ => .sequence 0 4
  | 10 => match i.val with
    | 0 => .triplet 5
    | 1 => .triplet 7
    | 2 => .sequence 0 0
    | _ => .sequence 1 0
  | 11 => match i.val with
    | 0 => .triplet 4
    | 1 => .triplet 5
    | 2 => .triplet 7
    | _ => .sequence 0 0
  | 12 => match i.val with
    | 0 => .triplet 5
    | 1 => .triplet 7
    | 2 => .sequence 0 0
    | _ => .sequence 1 2
  | 13 => match i.val with
    | 0 => .triplet 4
    | 1 => .triplet 5
    | 2 => .triplet 7
    | _ => .sequence 0 0
  | 14 => match i.val with
    | 0 => .triplet 4
    | 1 => .triplet 5
    | 2 => .triplet 7
    | _ => .sequence 0 0
  | 15 => match i.val with
    | 0 => .triplet 5
    | 1 => .triplet 7
    | 2 => .sequence 0 0
    | _ => .sequence 1 4
  | 16 => match i.val with
    | 0 => .triplet 4
    | 1 => .triplet 5
    | 2 => .triplet 7
    | _ => .sequence 0 0
  | 19 => match i.val with
    | 0 => .triplet 5
    | 1 => .triplet 7
    | 2 => .sequence 0 0
    | _ => .sequence 2 0
  | 20 => match i.val with
    | 0 => .triplet 4
    | 1 => .triplet 5
    | 2 => .triplet 7
    | _ => .sequence 0 0
  | 21 => match i.val with
    | 0 => .triplet 5
    | 1 => .triplet 7
    | 2 => .sequence 0 0
    | _ => .sequence 2 2
  | 22 => match i.val with
    | 0 => .triplet 4
    | 1 => .triplet 5
    | 2 => .triplet 7
    | _ => .sequence 0 0
  | 23 => match i.val with
    | 0 => .triplet 4
    | 1 => .triplet 5
    | 2 => .triplet 7
    | _ => .sequence 0 0
  | 24 => match i.val with
    | 0 => .triplet 5
    | 1 => .triplet 7
    | 2 => .sequence 0 0
    | _ => .sequence 2 4
  | 25 => match i.val with
    | 0 => .triplet 4
    | 1 => .triplet 5
    | 2 => .triplet 7
    | _ => .sequence 0 0
  | _ => .triplet 0

def target (t : Tile) : Counts :=
  countsOf (if isOrphan t then pair t :: orphans else standardTiles (melds t) (pair t))

def twoStep (t : Tile) : State := addTile (addTile candidate t) (reply t)

theorem reply_bound_checked : ∀ t : Tile, candidate t < 4 →
    (addTile candidate t) (reply t) < 4 := by decide +kernel

theorem orphan_pair_checked : ∀ t : Tile, isOrphan t = true → pair t ∈ orphans := by
  decide +kernel

theorem target_contained_checked : ∀ t : Tile, candidate t < 4 →
    RuleChecker.containsB (target t) (twoStep t) = true := by decide +kernel

theorem target_shape (t : Tile) :
    Standard (target t) ∨ SevenPairs (target t) ∨ ThirteenOrphans (target t) := by
  by_cases h : isOrphan t = true
  · exact Or.inr (Or.inr ⟨pair t, orphan_pair_checked t h, by simp [target, h]⟩)
  · exact Or.inl ⟨melds t, pair t, by simp [target, h]⟩

theorem reply_legal (t : Tile) (ht : LegalAdd candidate t) :
    LegalAdd (addTile candidate t) (reply t) :=
  ⟨valid_add ht.1 ht.2, reply_bound_checked t ht.2⟩

theorem twoStep_win (t : Tile) (ht : LegalAdd candidate t) : Win (twoStep t) := by
  have contained : Contains (target t) (twoStep t) :=
    (RuleChecker.containsB_iff _ _).1 (target_contained_checked t ht.2)
  have hv : Valid (twoStep t) := valid_add (reply_legal t ht).1 (reply_legal t ht).2
  exact ⟨target t, ⟨contains_valid contained hv, target_shape t⟩, contained⟩

theorem child_not_safe (t : Tile) (ht : LegalAdd candidate t) :
    ¬ SafeGame.Safe Step Win (addTile candidate t) := by
  intro safe
  exact safe.2 (twoStep t) ⟨reply t, reply_legal t ht, rfl⟩ (twoStep_win t ht)

theorem no_safe_step (s : State) : ¬ SafeGame.SafeStep Step Win candidate s := by
  rintro ⟨⟨t, ht, rfl⟩, hs⟩
  exact child_not_safe t ht hs

theorem candidate_normalP :
    SafeGame.NormalStrategy (SafeGame.SafeStep Step Win) candidate .P := by
  apply SafeGame.NormalStrategy.p
  intro s hs
  exact False.elim (no_safe_step s hs)

end Mahjong.ActualTerminalReplies

#print axioms Mahjong.ActualTerminalReplies.target_contained_checked
#print axioms Mahjong.ActualTerminalReplies.twoStep_win
#print axioms Mahjong.ActualTerminalReplies.child_not_safe
#print axioms Mahjong.ActualTerminalReplies.candidate_normalP
