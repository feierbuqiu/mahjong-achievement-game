import Mahjong.FactorizedRules
import Mahjong.Bridge

set_option autoImplicit false

/-!+# Independent original-game pilot checker

This small sparse DAG checker uses the original 34 physical tile counts and
the existing proved FactorizedRules predicate. It has no global enumeration
certificate, target table, symmetry quotient, historical P/N fact, or assumed
terminal leaf. Every P entry checks every legal addition whose target is SAFE;
an N entry checks one actual addition to a P entry already justified in its
tail. Every source, including every alleged leaf, is checked valid and SAFE.

An actual pilot is instantiated by finite literal Nodes and closed proofs of
checkTrace acceptance in the ordinary Lean kernel. Generic soundness below
does not assert that any supplied data has passed, and historical labels are
only untrusted proposals. No result here concerns the empty opening unless a
separate fully closed actual proof for that position is supplied.

This checker intentionally differs from the V17 indexed-byte fast checker.
Its pilot timing must not be extrapolated as V17 whole-table throughput.
-/

namespace Mahjong.PilotGameV18

open SafeGame

/-- P references are indexed by the actual physical tile kind. All references
address the strict tail of the current trace, preventing cyclic support.
N's unused P vector is still required to have the same 34-entry shape.
-/
structure Node where
  counts : Array Nat
  label : Outcome
  pRefs : Array Nat
  nKind : Nat
  nRef : Nat
  deriving DecidableEq, Repr

def state (node : Node) : State := fun tile => node.counts.getD tile.val 0

def Fact (s : State) (label : Outcome) : Prop :=
  Valid s ∧ IsSafe s ∧ NormalStrategy SafeMove s label

def NodeFact (node : Node) : Prop := Fact (state node) node.label

/-- Finite lookup rejects an out-of-range index. Equality is checked over all
34 counts; neither a canonical ID nor a P/N count can stand in for a child.
-/
def known : List Node → Nat → State → Outcome → Bool
  | [], _, _, _ => false
  | node :: _, 0, s, label =>
      MoveEnumeration.stateEqB (state node) s && decide (node.label = label)
  | _ :: rest, index + 1, s, label => known rest index s label

theorem known_sound (tail : List Node)
    (truth : ∀ node, node ∈ tail → NodeFact node)
    (index : Nat) (s : State) (label : Outcome)
    (accepted : known tail index s label = true) : Fact s label := by
  induction tail generalizing index with
  | nil => cases accepted
  | cons node rest ih =>
    cases index with
    | zero =>
      have parts : MoveEnumeration.stateEqB (state node) s = true ∧ node.label = label := by
        simpa only [known, Bool.and_eq_true, decide_eq_true_eq] using accepted
      have result := truth node List.mem_cons_self
      have physical := (MoveEnumeration.stateEqB_iff (state node) s).mp parts.1
      simpa only [NodeFact, Fact, physical, parts.2] using result
    | succ index =>
      exact ih (fun other member => truth other (List.mem_cons_of_mem node member)) index accepted

/-- This is a rule computation, not an untrusted SAFE flag. -/
theorem safe_facts (s : State) (accepted : FactorizedRules.safeB s = true) :
    Valid s ∧ IsSafe s := by
  have pieces := accepted
  simp only [FactorizedRules.safeB, Bool.and_eq_true] at pieces
  have valid : Valid s := (RuleChecker.validB_iff s).mp pieces.1.1
  have safe : IsSafe s := by
    apply (FastRuleChecker.safeB_iff s valid).mp
    rw [← FactorizedRules.safeB_eq]
    exact accepted
  exact ⟨valid, safe⟩

def checkRule (tail : List Node) (node : Node) : Bool :=
  let s := state node
  match node.label with
  | .P => allTiles.all fun tile =>
      if s tile < 4 then
        let child := addTile s tile
        if FactorizedRules.safeB child then
          known tail (node.pRefs.getD tile.val tail.length) child .N
        else true
      else true
  | .N =>
      if inside : node.nKind < 34 then
        let tile : Tile := ⟨node.nKind, inside⟩
        decide (s tile < 4) && known tail node.nRef (addTile s tile) .P
      else false

def checkNode (tail : List Node) (node : Node) : Bool :=
  decide (node.counts.size = 34 ∧ node.pRefs.size = 34) &&
    FactorizedRules.safeB (state node) && checkRule tail node

def checkTrace : List Node → Bool
  | [] => true
  | node :: tail => checkTrace tail && checkNode tail node

theorem checkNode_sound (tail : List Node)
    (truth : ∀ node, node ∈ tail → NodeFact node)
    (node : Node) (accepted : checkNode tail node = true) : NodeFact node := by
  have parts : ((node.counts.size = 34 ∧ node.pRefs.size = 34) ∧
      FactorizedRules.safeB (state node) = true) ∧ checkRule tail node = true := by
    simpa only [checkNode, Bool.and_eq_true, decide_eq_true_eq] using accepted
  have source := safe_facts (state node) parts.1.2
  refine ⟨source.1, source.2, ?_⟩
  have rule := parts.2
  cases tag : node.label with
  | P =>
    have all : allTiles.all (fun tile =>
        if state node tile < 4 then
          if FactorizedRules.safeB (addTile (state node) tile) then
            known tail (node.pRefs.getD tile.val tail.length) (addTile (state node) tile) .N
          else true
        else true) = true := by
      simpa only [checkRule, tag] using rule
    apply NormalStrategy.p
    intro target edge
    obtain ⟨⟨tile, legal, same⟩, safe⟩ := edge
    subst target
    have childSafe : FactorizedRules.safeB (addTile (state node) tile) = true := by
      rw [FactorizedRules.safeB_eq]
      exact (FastRuleChecker.safeB_iff _ (valid_add legal.1 legal.2)).mpr safe
    have checked := List.all_eq_true.mp all tile (mem_allTiles tile)
    simp only [legal.2, childSafe, ↓reduceIte] at checked
    exact (known_sound tail truth (node.pRefs.getD tile.val tail.length)
      (addTile (state node) tile) .N checked).2.2
  | N =>
    simp only [checkRule, tag] at rule
    split at rule
    next inside =>
      have checked : state node ⟨node.nKind, inside⟩ < 4 ∧
          known tail node.nRef (addTile (state node) ⟨node.nKind, inside⟩) .P = true := by
        simpa only [Bool.and_eq_true, decide_eq_true_eq] using rule
      have child := known_sound tail truth node.nRef
        (addTile (state node) ⟨node.nKind, inside⟩) .P checked.2
      apply NormalStrategy.n (t := addTile (state node) ⟨node.nKind, inside⟩)
      · exact ⟨⟨⟨node.nKind, inside⟩, ⟨source.1, checked.1⟩, rfl⟩, child.2.1⟩
      · exact child.2.2
    next outside => cases rule

/-- The base trace has no assumed facts. In particular, alleged P leaves
must still check every real SAFE move; an external terminal flag is unused.
-/
theorem trace_sound (trace : List Node) (accepted : checkTrace trace = true) :
    ∀ node, node ∈ trace → NodeFact node := by
  induction trace with
  | nil => intro node absent; cases absent
  | cons node tail ih =>
    have parts : checkTrace tail = true ∧ checkNode tail node = true := by
      simpa only [checkTrace, Bool.and_eq_true] using accepted
    have truths := ih parts.1
    intro selected member
    rcases List.mem_cons.mp member with same | old
    · subst selected
      exact checkNode_sound tail truths node parts.2
    · exact truths selected old

theorem normal_sound (trace : List Node) (accepted : checkTrace trace = true)
    (node : Node) (member : node ∈ trace) : NormalStrategy SafeMove (state node) node.label :=
  (trace_sound trace accepted node member).2.2

theorem achievement_sound (trace : List Node) (accepted : checkTrace trace = true)
    (node : Node) (member : node ∈ trace) : AchievementStrategy Step Win (state node) node.label := by
  have fact := trace_sound trace accepted node member
  exact normal_to_achievement fact.2.2 fact.2.1

/-- Nonempty P positions receive the SAME original-game winning meaning as
the empty position would: every legal first move has an actual winning reply
strategy whose leaves contain a legal winning 14-tile subset.
-/
theorem second_player_wins (trace : List Node) (accepted : checkTrace trace = true)
    (node : Node) (member : node ∈ trace) (tag : node.label = .P) :
    SecondPlayerWins Step Win (state node) := by
  have fact := trace_sound trace accepted node member
  apply safe_p_second_player_wins (move := Step) (win := Win) (domain := Valid)
    (fun _ edge => step_target_valid edge)
    (fun _ valid live => nonwinning_has_step valid live)
    fact.1 fact.2.1
  change NormalStrategy SafeMove (state node) .P
  rw [← tag]
  exact fact.2.2

theorem first_player_wins (trace : List Node) (accepted : checkTrace trace = true)
    (node : Node) (member : node ∈ trace) (tag : node.label = .N) :
    WinningStrategy Step Win (state node) := by
  have fact := trace_sound trace accepted node member
  have game := achievement_sound trace accepted node member
  have meaning := achievement_meaning (move := Step) (win := Win) (domain := Valid)
    (fun _ edge => step_target_valid edge)
    (fun _ valid live => nonwinning_has_step valid live) game fact.1
  simpa only [tag, AchievementMeaning] using meaning

end Mahjong.PilotGameV18

#print axioms Mahjong.PilotGameV18.known_sound
#print axioms Mahjong.PilotGameV18.safe_facts
#print axioms Mahjong.PilotGameV18.checkNode_sound
#print axioms Mahjong.PilotGameV18.trace_sound
#print axioms Mahjong.PilotGameV18.normal_sound
#print axioms Mahjong.PilotGameV18.achievement_sound
#print axioms Mahjong.PilotGameV18.second_player_wins
#print axioms Mahjong.PilotGameV18.first_player_wins
