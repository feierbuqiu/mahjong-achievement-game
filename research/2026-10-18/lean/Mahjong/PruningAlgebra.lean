import Std

/-!
Natural-number specification of the production profile and passesPartial-filter
algebra. Pair coordinate zero means unavailable; p>0 means p-1 melds with
one pair. This is not a claim about the machine implementation or raw inputs.
-/
set_option autoImplicit false

namespace Mahjong.PruningAlgebra

structure Profile where
  meld : Nat
  pair : Nat
  deriving DecidableEq, Repr

def liftPair (p m : Nat) : Nat := if p = 0 then 0 else min 5 (p + m)

def combine (a b : Profile) : Profile :=
  ⟨min 4 (a.meld + b.meld), max (liftPair a.pair b.meld) (liftPair b.pair a.meld)⟩

def unify (a b : Profile) : Profile := ⟨max a.meld b.meld, max a.pair b.pair⟩

theorem liftPair_max_first (p q m : Nat) :
    liftPair (max p q) m = max (liftPair p m) (liftPair q m) := by
  by_cases hp : p = 0 <;> by_cases hq : q = 0
  all_goals simp only [liftPair]
  all_goals split <;> omega

theorem liftPair_max_second (p m n : Nat) :
    liftPair p (max m n) = max (liftPair p m) (liftPair p n) := by
  unfold liftPair
  split <;> omega

theorem combine_unify_left (a b c : Profile) :
    combine (unify a b) c = unify (combine a c) (combine b c) := by
  cases a; cases b; cases c
  simp only [combine, unify, liftPair_max_first, liftPair_max_second, Profile.mk.injEq]
  constructor <;> omega

theorem combine_unify_right (a b c : Profile) :
    combine a (unify b c) = unify (combine a b) (combine a c) := by
  cases a; cases b; cases c
  simp only [combine, unify, liftPair_max_first, liftPair_max_second, Profile.mk.injEq]
  constructor <;> omega

theorem unify_self (p : Profile) : unify p p = p := by cases p; simp [unify]

def envelope (base : Profile) : List Profile → Profile
  | [] => base
  | p :: ps => unify p (envelope base ps)

def ProfileBelow (a b : Profile) : Prop := a.meld ≤ b.meld ∧ a.pair ≤ b.pair

theorem combine_mono (a b c d : Profile) (ac : ProfileBelow a c) (bd : ProfileBelow b d) :
    ProfileBelow (combine a b) (combine c d) := by
  have lift_mono (p q m n : Nat) (pq : p ≤ q) (mn : m ≤ n) : liftPair p m ≤ liftPair q n := by
    unfold liftPair
    split <;> split <;> omega
  have x := lift_mono a.pair c.pair b.meld d.meld ac.2 bd.1
  have y := lift_mono b.pair d.pair a.meld c.meld bd.2 ac.1
  simp only [ProfileBelow, combine] at *
  constructor <;> omega

theorem unify_mono (a b c d : Profile) (ac : ProfileBelow a c) (bd : ProfileBelow b d) :
    ProfileBelow (unify a b) (unify c d) := by
  simp only [ProfileBelow, unify] at *
  constructor <;> omega

def contributes (p m : Nat) : Prop := 0 < p ∧ 5 ≤ p + m

theorem contributes_max (p q m : Nat) :
    contributes (max p q) m ↔ contributes p m ∨ contributes q m := by
  unfold contributes
  omega

theorem contributes_lift (p m k : Nat) :
    contributes (liftPair p m) k ↔ contributes p (m + k) := by
  unfold contributes liftPair
  split <;> omega

theorem contributes_cap (p m k : Nat) :
    contributes p (min 4 m + k) ↔ contributes p (m + k) := by
  unfold contributes
  omega

theorem contributes_combine (a b : Profile) (k : Nat) :
    contributes (combine a b).pair k ↔
      contributes a.pair (b.meld + k) ∨ contributes b.pair (a.meld + k) := by
  simp only [combine, contributes_max, contributes_lift]

theorem contributes_unify (a b : Profile) (k : Nat) :
    contributes (unify a b).pair k ↔ contributes a.pair k ∨ contributes b.pair k :=
  contributes_max _ _ _

theorem contributes_envelope (base : Profile) (ps : List Profile) (k : Nat) :
    contributes (envelope base ps).pair k ↔
      contributes base.pair k ∨ ∃ p, p ∈ ps ∧ contributes p.pair k := by
  induction ps with
  | nil => simp [envelope]
  | cons p ps ih => simp [envelope, contributes_unify, ih, or_left_comm]

theorem map_envelope (f : Profile → Profile)
    (distributes : ∀ p q, f (unify p q) = unify (f p) (f q)) (base : Profile) (ps : List Profile) :
    f (envelope base ps) = envelope (f base) (ps.map f) := by
  induction ps with
  | nil => rfl
  | cons p ps ih => simp only [envelope, distributes, ih, List.map_cons]

theorem pair_large_left (a b : Profile) (h : 5 ≤ a.pair) : 5 ≤ (combine a b).pair := by
  have x := (contributes_combine a b 0).2 (Or.inl (by unfold contributes; omega))
  unfold contributes at x
  omega

theorem pair_large_right (a b : Profile) (h : 5 ≤ b.pair) : 5 ≤ (combine a b).pair := by
  have x := (contributes_combine a b 0).2 (Or.inr (by unfold contributes; omega))
  unfold contributes at x
  omega

structure Label where
  current : Profile
  added : Profile
  pairs : Nat
  single : Bool
  missing : Nat
  orphanPair : Bool
  tiles : Nat
  deriving DecidableEq, Repr

def join (a b : Label) : Label :=
  ⟨combine a.current b.current,
   unify (combine a.added b.current) (combine a.current b.added),
   a.pairs + b.pairs, a.single || b.single,
   a.missing + b.missing, a.orphanPair || b.orphanPair, a.tiles + b.tiles⟩

def four (a b c d : Profile) : Profile := combine (combine (combine a b) c) d

theorem four_added (a b c d : Label) :
    (join (join (join a b) c) d).added =
      unify (unify (unify (four a.added b.current c.current d.current)
        (four a.current b.added c.current d.current))
        (four a.current b.current c.added d.current))
        (four a.current b.current c.current d.added) := by
  simp only [join, combine_unify_left, four]

theorem four_added_contributes (a b c d : Label) :
    contributes (join (join (join a b) c) d).added.pair 0 ↔
      contributes (four a.added b.current c.current d.current).pair 0 ∨
      contributes (four a.current b.added c.current d.current).pair 0 ∨
      contributes (four a.current b.current c.added d.current).pair 0 ∨
      contributes (four a.current b.current c.current d.added).pair 0 := by
  rw [four_added]
  simp only [contributes_unify, or_assoc]

def passesPartial (a : Label) : Prop :=
  a.pairs < 7 ∧ a.current.pair < 5 ∧ a.added.pair < 5 ∧
    ¬ (a.pairs = 6 ∧ a.single = true)

def fullSafe (a : Label) : Prop := passesPartial a ∧
  ¬ (a.missing = 0 ∨ (a.missing = 1 ∧ a.orphanPair = true))

def PruningBelow (a b : Label) : Prop := ProfileBelow a.current b.current ∧
  ProfileBelow a.added b.added ∧ a.pairs ≤ b.pairs ∧ (a.single = true → b.single = true)

theorem join_mono (a b c d : Label) (ac : PruningBelow a c) (bd : PruningBelow b d) :
    PruningBelow (join a b) (join c d) := by
  refine ⟨combine_mono _ _ _ _ ac.1 bd.1,
    unify_mono _ _ _ _ (combine_mono _ _ _ _ ac.2.1 bd.1)
      (combine_mono _ _ _ _ ac.1 bd.2.1), Nat.add_le_add ac.2.2.1 bd.2.2.1, ?_⟩
  change (a.single || b.single) = true → (c.single || d.single) = true
  simp only [Bool.or_eq_true]
  intro h
  exact h.elim (fun ha => Or.inl (ac.2.2.2 ha)) (fun hb => Or.inr (bd.2.2.2 hb))

theorem partial_of_below (a b : Label) (below : PruningBelow a b) (h : passesPartial b) :
    passesPartial a := by
  refine ⟨Nat.lt_of_le_of_lt below.2.2.1 h.1,
    Nat.lt_of_le_of_lt below.1.2 h.2.1, Nat.lt_of_le_of_lt below.2.1.2 h.2.2.1, ?_⟩
  rintro ⟨six, single⟩
  have eq : b.pairs = 6 := by have lo := below.2.2.1; have hi := h.1; omega
  exact h.2.2.2 ⟨eq, below.2.2.2 single⟩

theorem partial_left (a b : Label) (h : passesPartial (join a b)) : passesPartial a := by
  obtain ⟨q, pr, ad, si⟩ := h
  have prBound : a.current.pair < 5 := by
    apply Nat.lt_of_not_ge
    intro no
    have large := pair_large_left a.current b.current (by omega)
    change (combine a.current b.current).pair < 5 at pr
    omega
  have adBound : a.added.pair < 5 := by
    apply Nat.lt_of_not_ge
    intro no
    have large := pair_large_left a.added b.current (by omega)
    change max (combine a.added b.current).pair (combine a.current b.added).pair < 5 at ad
    omega
  change a.pairs + b.pairs < 7 at q
  refine ⟨by omega, prBound, adBound, ?_⟩
  rintro ⟨six, single⟩
  apply si
  change a.pairs + b.pairs = 6 ∧ (a.single || b.single) = true
  exact ⟨by omega, by simp [single]⟩

theorem partial_right (a b : Label) (h : passesPartial (join a b)) : passesPartial b := by
  obtain ⟨q, pr, ad, si⟩ := h
  have prBound : b.current.pair < 5 := by
    apply Nat.lt_of_not_ge
    intro no
    have large := pair_large_right a.current b.current (by omega)
    change (combine a.current b.current).pair < 5 at pr
    omega
  have adBound : b.added.pair < 5 := by
    apply Nat.lt_of_not_ge
    intro no
    have large := pair_large_right a.current b.added (by omega)
    change max (combine a.added b.current).pair (combine a.current b.added).pair < 5 at ad
    omega
  change a.pairs + b.pairs < 7 at q
  refine ⟨by omega, prBound, adBound, ?_⟩
  rintro ⟨six, single⟩
  apply si
  change a.pairs + b.pairs = 6 ∧ (a.single || b.single) = true
  exact ⟨by omega, by simp [single]⟩

/-- No early passesPartial rejection can remove a four-block label that passes the
final full filter. No assumptions on enumerated tables or their total count. -/
theorem four_block_pruning_complete (a b c h : Label)
    (safe : fullSafe (join (join (join a b) c) h)) :
    passesPartial a ∧ passesPartial b ∧ passesPartial c ∧ passesPartial h ∧
    passesPartial (join a b) ∧ passesPartial (join (join a b) c) := by
  have abc := partial_left _ _ safe.1
  have ab := partial_left _ _ abc
  exact ⟨partial_left _ _ ab, partial_right _ _ ab,
    partial_right _ _ abc, partial_right _ _ safe.1, ab, abc⟩

theorem four_current_pair (a b c d : Profile) :
    contributes (combine (combine (combine a b) c) d).pair 0 ↔
      contributes a.pair (b.meld + c.meld + d.meld) ∨
      contributes b.pair (a.meld + c.meld + d.meld) ∨
      contributes c.pair (a.meld + b.meld + d.meld) ∨
      contributes d.pair (a.meld + b.meld + c.meld) := by
  simp only [contributes_combine, Nat.add_zero]
  change ((contributes a.pair (b.meld + (c.meld + d.meld)) ∨
    contributes b.pair (a.meld + (c.meld + d.meld))) ∨
    contributes c.pair (min 4 (a.meld + b.meld) + d.meld)) ∨
    contributes d.pair (min 4 (min 4 (a.meld + b.meld) + c.meld)) ↔ _
  have last := contributes_cap d.pair (min 4 (a.meld + b.meld) + c.meld) 0
  simp only [Nat.add_zero] at last
  rw [last]
  simp only [contributes_cap, Nat.add_assoc, or_assoc]

end Mahjong.PruningAlgebra

#print axioms Mahjong.PruningAlgebra.contributes_combine
#print axioms Mahjong.PruningAlgebra.combine_unify_left
#print axioms Mahjong.PruningAlgebra.combine_unify_right
#print axioms Mahjong.PruningAlgebra.four_added_contributes
#print axioms Mahjong.PruningAlgebra.four_current_pair
#print axioms Mahjong.PruningAlgebra.four_block_pruning_complete
