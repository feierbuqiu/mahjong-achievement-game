import Std

/-!
Abstract proof layer for finite shared-table achievement games.

No external table, executable result, or native evaluator is trusted here.
`NormalStrategy.p` quantifies over EVERY move. A partial child list cannot
instantiate it without a separate completeness proof.
-/

namespace Mahjong.SafeGame

universe u

inductive Outcome where
  | P
  | N
  deriving DecidableEq, Repr

def Outcome.opposite : Outcome → Outcome
  | .P => .N
  | .N => .P

/-- A finite-height normal-play strategy proof: P covers every opponent move;
N supplies one legal move to P. -/
inductive NormalStrategy {α : Type u} (move : α → α → Prop) : α → Outcome → Prop where
  | p {s} : (∀ t, move s t → NormalStrategy move t .N) → NormalStrategy move s .P
  | n {s t} : move s t → NormalStrategy move t .P → NormalStrategy move s .N

theorem normalStrategy_opposite {α : Type u} {move : α → α → Prop}
    {s : α} {o : Outcome} (h : NormalStrategy move s o) :
    ¬ NormalStrategy move s o.opposite := by
  induction h with
  | p next ih =>
      intro other
      cases other with
      | n edge child => exact ih _ edge child
  | n edge child ih =>
      intro other
      cases other with
      | p next => exact ih (next _ edge)

theorem normalStrategy_not_both {α : Type u} {move : α → α → Prop} {s : α}
    (hp : NormalStrategy move s .P) (hn : NormalStrategy move s .N) : False :=
  normalStrategy_opposite hp hn

/-- The relation may be changed only with completeness in both directions. -/
theorem normalStrategy_transfer {α : Type u} {move declared : α → α → Prop}
    (complete : ∀ s t, move s t ↔ declared s t) {s : α} {o : Outcome}
    (h : NormalStrategy declared s o) : NormalStrategy move s o := by
  induction h with
  | p next ih =>
      apply NormalStrategy.p
      intro t edge
      exact ih t ((complete _ _).mp edge)
  | n edge child ih =>
      exact NormalStrategy.n ((complete _ _).mpr edge) ih

/-- Exact local P/N equations plus a rank decreasing on every legal move. -/
structure PNCertificate {α : Type u} (move : α → α → Prop)
    (rank : α → Nat) (label : α → Outcome) : Prop where
  decreases : ∀ {s t}, move s t → rank t < rank s
  p_label : ∀ s, label s = .P → ∀ t, move s t → label t = .N
  n_label : ∀ s, label s = .N → ∃ t, move s t ∧ label t = .P

theorem PNCertificate.sound {α : Type u} {move : α → α → Prop}
    {rank : α → Nat} {label : α → Outcome}
    (cert : PNCertificate move rank label) (s : α) :
    NormalStrategy move s (label s) := by
  have bounded : ∀ n : Nat, ∀ q : α, rank q ≤ n → NormalStrategy move q (label q) := by
    intro n
    induction n using Nat.strongRecOn with
    | ind n ih =>
        intro q hq
        cases labelq : label q with
        | P =>
            apply NormalStrategy.p
            intro t edge
            have less : rank t < n := Nat.lt_of_lt_of_le (cert.decreases edge) hq
            have child := ih (rank t) less t (Nat.le_refl _)
            have labelt := cert.p_label q labelq t edge
            simpa only [labelt] using child
        | N =>
            obtain ⟨t, edge, labelt⟩ := cert.n_label q labelq
            apply NormalStrategy.n edge
            have less : rank t < n := Nat.lt_of_lt_of_le (cert.decreases edge) hq
            have child := ih (rank t) less t (Nat.le_refl _)
            simpa only [labelt] using child
  exact bounded (rank s) s (Nat.le_refl _)

theorem certificate_sound_of_complete {α : Type u} {move declared : α → α → Prop}
    {rank : α → Nat} {label : α → Outcome}
    (complete : ∀ s t, move s t ↔ declared s t)
    (cert : PNCertificate declared rank label) (s : α) :
    NormalStrategy move s (label s) :=
  normalStrategy_transfer complete (cert.sound s)

/-- A local certificate can cover an invariant domain, provided EVERY real
successor of its states remains inside that domain. -/
theorem normalStrategy_subtype {α : Type u} {move : α → α → Prop}
    {domain : α → Prop}
    (closed : ∀ {s t}, domain s → move s t → domain t)
    {s : Subtype domain} {o : Outcome}
    (h : NormalStrategy (fun a b : Subtype domain => move a.val b.val) s o) :
    NormalStrategy move s.val o := by
  induction h with
  | @p q next ih =>
      apply NormalStrategy.p
      intro t edge
      exact ih ⟨t, closed q.property edge⟩ edge
  | n edge child ih =>
      exact NormalStrategy.n edge ih

theorem local_certificate_sound {α : Type u} {move : α → α → Prop}
    {domain : α → Prop} {rank : Subtype domain → Nat}
    {label : Subtype domain → Outcome}
    (closed : ∀ {s t}, domain s → move s t → domain t)
    (cert : PNCertificate (fun a b : Subtype domain => move a.val b.val) rank label)
    (s : Subtype domain) : NormalStrategy move s.val (label s) :=
  normalStrategy_subtype (move := move) (domain := domain) closed (cert.sound s)

/-- A state is neither already won nor one legal addition away from a win. -/
def Safe {α : Type u} (move : α → α → Prop) (win : α → Prop) (s : α) : Prop :=
  ¬ win s ∧ ∀ t, move s t → ¬ win t

/-- The source is required to be SAFE by reduction theorems; the relation
retains precisely the original moves whose target is SAFE. -/
def SafeStep {α : Type u} (move : α → α → Prop) (win : α → Prop)
    (s t : α) : Prop := move s t ∧ Safe move win t

/-- P/N strategy equations for the original achievement game. -/
inductive AchievementStrategy {α : Type u} (move : α → α → Prop)
    (win : α → Prop) : α → Outcome → Prop where
  | p {s} :
      (¬ win s) →
      (∀ t, move s t → ¬ win t) →
      (∀ t, move s t → AchievementStrategy move win t .N) →
      AchievementStrategy move win s .P
  | n_now {s t} :
      (¬ win s) → move s t → win t → AchievementStrategy move win s .N
  | n_later {s t} :
      (¬ win s) → move s t → AchievementStrategy move win t .P →
      AchievementStrategy move win s .N

theorem achievement_P_safe {α : Type u} {move : α → α → Prop} {win : α → Prop}
    {s : α} (h : AchievementStrategy move win s .P) : Safe move win s := by
  cases h with
  | p live noImmediate next => exact ⟨live, noImmediate⟩

theorem achievement_live {α : Type u} {move : α → α → Prop} {win : α → Prop}
    {s : α} {o : Outcome} (h : AchievementStrategy move win s o) : ¬ win s := by
  cases h with
  | p live noImmediate next => exact live
  | n_now live edge won => exact live
  | n_later live edge next => exact live

theorem unsafe_has_immediate_win {α : Type u} {move : α → α → Prop}
    {win : α → Prop} {s : α} (live : ¬ win s) (notSafe : ¬ Safe move win s) :
    ∃ t, move s t ∧ win t := by
  classical
  apply Classical.byContradiction
  intro none
  apply notSafe
  refine ⟨live, ?_⟩
  intro t edge won
  exact none ⟨t, edge, won⟩

theorem normal_to_achievement {α : Type u} {move : α → α → Prop}
    {win : α → Prop} {s : α} {o : Outcome}
    (h : NormalStrategy (SafeStep move win) s o) (safe : Safe move win s) :
    AchievementStrategy move win s o := by
  classical
  induction h with
  | p next ih =>
      apply AchievementStrategy.p safe.1 safe.2
      intro t edge
      by_cases ht : Safe move win t
      · exact ih t ⟨edge, ht⟩ ht
      · obtain ⟨u, reply, won⟩ := unsafe_has_immediate_win (safe.2 t edge) ht
        exact AchievementStrategy.n_now (safe.2 t edge) reply won
  | n edge child ih =>
      exact AchievementStrategy.n_later safe.1 edge.1 (ih edge.2)

theorem achievement_to_normal {α : Type u} {move : α → α → Prop}
    {win : α → Prop} {s : α} {o : Outcome}
    (h : AchievementStrategy move win s o) (safe : Safe move win s) :
    NormalStrategy (SafeStep move win) s o := by
  induction h with
  | p live noImmediate next ih =>
      apply NormalStrategy.p
      intro t edge
      exact ih t edge.1 edge.2
  | n_now live edge won =>
      exact False.elim (safe.2 _ edge won)
  | n_later live edge child ih =>
      have ht := achievement_P_safe child
      exact NormalStrategy.n ⟨edge, ht⟩ (ih ht)

theorem safe_reduction {α : Type u} {move : α → α → Prop} {win : α → Prop}
    {s : α} {o : Outcome} (safe : Safe move win s) :
    NormalStrategy (SafeStep move win) s o ↔ AchievementStrategy move win s o :=
  ⟨fun h => normal_to_achievement h safe, fun h => achievement_to_normal h safe⟩

theorem achievement_not_both {α : Type u} {move : α → α → Prop} {win : α → Prop}
    {s : α} (hp : AchievementStrategy move win s .P)
    (hn : AchievementStrategy move win s .N) : False :=
  normalStrategy_not_both
    (achievement_to_normal hp (achievement_P_safe hp))
    (achievement_to_normal hn (achievement_P_safe hp))

/-- A genuine achievement-winning strategy. Every leaf is an actual `win`,
not merely an opponent with no moves. The later constructor supplies an own
move and a continuation against every possible nonempty opponent reply. -/
inductive WinningStrategy {α : Type u} (move : α → α → Prop)
    (win : α → Prop) : α → Prop where
  | now {s t} : (¬ win s) → move s t → win t → WinningStrategy move win s
  | later {s t} :
      (¬ win s) → move s t → (¬ win t) →
      (∃ u, move t u) →
      (∀ u, move t u → ¬ win u) →
      (∀ u, move t u → WinningStrategy move win u) →
      WinningStrategy move win s

def AchievementMeaning {α : Type u} (move : α → α → Prop)
    (win : α → Prop) (s : α) : Outcome → Prop
  | .P => Safe move win s ∧ ∀ t, move s t → WinningStrategy move win t
  | .N => WinningStrategy move win s

/-- The domain isolates valid positions. Its no-stuck theorem is necessary:
otherwise a normal-play loss with no moves need not be an achievement win. -/
theorem achievement_meaning {α : Type u} {move : α → α → Prop} {win : α → Prop}
    {domain : α → Prop}
    (closed : ∀ {s t}, domain s → move s t → domain t)
    (noStuck : ∀ s, domain s → ¬ win s → ∃ t, move s t)
    {s : α} {o : Outcome} (h : AchievementStrategy move win s o)
    (valid : domain s) : AchievementMeaning move win s o := by
  induction h with
  | p live noImmediate next ih =>
      refine ⟨⟨live, noImmediate⟩, ?_⟩
      intro t edge
      exact ih t edge (closed valid edge)
  | n_now live edge won =>
      exact WinningStrategy.now live edge won
  | n_later live edge child ih =>
      have childValid := closed valid edge
      have childMeaning := ih childValid
      exact WinningStrategy.later live edge childMeaning.1.1
        (noStuck _ childValid childMeaning.1.1) childMeaning.1.2 childMeaning.2

def SecondPlayerWins {α : Type u} (move : α → α → Prop)
    (win : α → Prop) (s : α) : Prop :=
  ¬ win s ∧ (∃ t, move s t) ∧
    ∀ t, move s t → ¬ win t ∧ WinningStrategy move win t

theorem safe_p_second_player_wins {α : Type u} {move : α → α → Prop}
    {win : α → Prop} {domain : α → Prop}
    (closed : ∀ {s t}, domain s → move s t → domain t)
    (noStuck : ∀ s, domain s → ¬ win s → ∃ t, move s t)
    {s : α} (valid : domain s) (safe : Safe move win s)
    (hp : NormalStrategy (SafeStep move win) s .P) :
    SecondPlayerWins move win s := by
  have meaning := achievement_meaning (move := move) (win := win) (domain := domain)
    closed noStuck (normal_to_achievement hp safe) valid
  refine ⟨safe.1, noStuck s valid safe.1, ?_⟩
  intro t edge
  exact ⟨safe.2 t edge, meaning.2 t edge⟩

theorem certified_safe_p_second_player_wins {α : Type u} {move : α → α → Prop}
    {win : α → Prop} {domain : α → Prop} {rank : α → Nat} {label : α → Outcome}
    (closed : ∀ {s t}, domain s → move s t → domain t)
    (noStuck : ∀ s, domain s → ¬ win s → ∃ t, move s t)
    (cert : PNCertificate (SafeStep move win) rank label)
    {s : α} (valid : domain s) (safe : Safe move win s) (rootP : label s = .P) :
    SecondPlayerWins move win s := by
  apply safe_p_second_player_wins (move := move) (win := win) (domain := domain)
    closed noStuck valid safe
  simpa only [rootP] using cert.sound s

end Mahjong.SafeGame

#print axioms Mahjong.SafeGame.PNCertificate.sound
#print axioms Mahjong.SafeGame.normalStrategy_not_both
#print axioms Mahjong.SafeGame.safe_reduction
#print axioms Mahjong.SafeGame.safe_p_second_player_wins
#print axioms Mahjong.SafeGame.certified_safe_p_second_player_wins
