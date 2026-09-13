import Mahjong.DownwardClosure
import Mahjong.Generators

/-!
Composable two-ply response certificates for the original achievement game.

A node covers every legal first tile. Its second move must be legal and either
contain an explicit winning hand or reach an already proved SAFE P position.
No N-node SAFE search, global index, or giant database decision is required.

Source safety is essential: a first move that already wins ends the game before
the proposed response. It can be inherited from any valid SAFE extension via
`node_of_safe_extension`, rather than recomputed at every P node.
-/

namespace Mahjong.ResponseCertificate

open Mahjong.SafeGame Mahjong.Symmetry Mahjong.Generators

/-- A reusable physical P fact includes its domain and SAFE evidence. -/
structure ProvedP (s : State) : Prop where
  valid : Valid s
  safe : IsSafe s
  strategy : NormalStrategy SafeMove s .P

/-- A response does not assert that the opponent's first move was nonwinning.
That fact is supplied by the source SAFE proof when building a node. -/
inductive Reply (s : State) (first : Tile) : Prop where
  | win (second : Tile)
      (legal : LegalAdd (addTile s first) second)
      (won : Win (addTile (addTile s first) second)) : Reply s first
  | back (second : Tile)
      (legal : LegalAdd (addTile s first) second)
      (child : ProvedP (addTile (addTile s first) second)) : Reply s first

/-- Tile is Fin 34: no available opponent first move can be omitted. -/
def Responses (s : State) : Prop :=
  ∀ first : Tile, LegalAdd s first → Reply s first

theorem responses_of_allTiles {s : State}
    (covered : ∀ first : Tile, first ∈ allTiles → LegalAdd s first → Reply s first) :
    Responses s := fun first legal => covered first (mem_allTiles first) legal

/-- Assemble a physical P node without enumerating SAFE successors of N nodes. -/
theorem node {s : State} (valid : Valid s) (safe : IsSafe s)
    (responses : Responses s) : ProvedP s := by
  refine ⟨valid, safe, ?_⟩
  apply NormalStrategy.p
  rintro afterFirst ⟨⟨first, firstLegal, rfl⟩, firstSafe⟩
  cases responses first firstLegal with
  | win second secondLegal won =>
      exact False.elim (firstSafe.2 _ ⟨second, secondLegal, rfl⟩ won)
  | back second secondLegal child =>
      exact NormalStrategy.n ⟨⟨second, secondLegal, rfl⟩, child.safe⟩ child.strategy

/-- One checked SAFE extension suffices for the source SAFE condition.
Containment is just 34 count inequalities; no unsafe-state oracle is assumed. -/
theorem node_of_safe_extension {s anchor : State}
    (contained : Contains s anchor) (anchorValid : Valid anchor)
    (anchorSafe : IsSafe anchor) (responses : Responses s) : ProvedP s :=
  node (contains_valid contained anchorValid)
    (safe_of_contains contained anchorValid anchorSafe) responses

theorem node_of_proved_extension {s anchor : State}
    (contained : Contains s anchor) (anchorProof : ProvedP anchor)
    (responses : Responses s) : ProvedP s :=
  node_of_safe_extension contained anchorProof.valid anchorProof.safe responses

/-- A returning response may itself supply the needed SAFE extension. -/
theorem node_of_back_anchor {s : State} (first second : Tile)
    (anchorProof : ProvedP (addTile (addTile s first) second))
    (responses : Responses s) : ProvedP s :=
  node_of_proved_extension
    (contains_trans (addTile_contains s first) (addTile_contains (addTile s first) second))
    anchorProof responses

/-- Checking an explicit target uses only its shape and 34 containment bounds.
The target's four-copy bound follows from the legal resulting physical state. -/
theorem Reply.win_of_target {s : State} (first second : Tile)
    (secondLegal : LegalAdd (addTile s first) second)
    (target : Counts)
    (shape : Standard target ∨ SevenPairs target ∨ ThirteenOrphans target)
    (contained : Contains target (addTile (addTile s first) second)) : Reply s first :=
  Reply.win second secondLegal
    ⟨target, ⟨contains_valid contained (valid_add secondLegal.1 secondLegal.2), shape⟩,
      contained⟩

theorem ProvedP.renamed {s : State} (proved : ProvedP s) (r : TileRenaming) :
    ProvedP (rename r.bijection s) :=
  ⟨rename_valid r.bijection proved.valid, rename_safe r proved.safe,
    (renaming_preserves_outcome r).mp proved.strategy⟩

theorem ProvedP.alongPath {s : State} (proved : ProvedP s) (path : List Generator) :
    ProvedP (applyPath path s) := by
  induction path generalizing s with
  | nil => exact proved
  | cons g gs ih => exact ih (proved.renamed g.renaming)

theorem ProvedP.ofPath {known actual : State} (proved : ProvedP known)
    (path : List Generator) (same : actual = applyPath path known) : ProvedP actual := by
  rw [same]
  exact proved.alongPath path

theorem Reply.backAlongPath {s known : State} (first second : Tile)
    (secondLegal : LegalAdd (addTile s first) second) (proved : ProvedP known)
    (path : List Generator)
    (same : addTile (addTile s first) second = applyPath path known) : Reply s first :=
  Reply.back second secondLegal (proved.ofPath path same)

theorem Reply.backAlongCheckedPath {s known : State} (first second : Tile)
    (secondLegal : LegalAdd (addTile s first) second) (proved : ProvedP known)
    (path : List Generator)
    (checked : checkReference path known (addTile (addTile s first) second) = true) :
    Reply s first :=
  Reply.backAlongPath first second secondLegal proved path (stateEqB_sound checked)

/-- Original-game meaning includes an actual win; illegal replies cannot be used. -/
theorem ProvedP.secondPlayerWins {s : State} (proved : ProvedP s) :
    SecondPlayerWins Step Win s :=
  safe_p_second_player_wins (move := Step) (win := Win) (domain := Valid)
    (fun _ edge => step_target_valid edge)
    (fun _ valid live => nonwinning_has_step valid live)
    proved.valid proved.safe proved.strategy

theorem empty_wins (proved : ProvedP empty) : SecondPlayerWins Step Win empty :=
  proved.secondPlayerWins

end Mahjong.ResponseCertificate

#print axioms Mahjong.ResponseCertificate.node
#print axioms Mahjong.ResponseCertificate.node_of_safe_extension
#print axioms Mahjong.ResponseCertificate.node_of_back_anchor
#print axioms Mahjong.ResponseCertificate.Reply.win_of_target
#print axioms Mahjong.ResponseCertificate.Reply.backAlongCheckedPath
#print axioms Mahjong.ResponseCertificate.ProvedP.secondPlayerWins
#print axioms Mahjong.ResponseCertificate.empty_wins
