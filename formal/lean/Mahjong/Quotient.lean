import Mahjong.SafeGame

/-!
Transition-complete quotient games preserve finite normal-play strategies.
The encoding need not be injective. Static winning-profile agreement alone
does not provide either transition premise below.
-/

namespace Mahjong.Quotient

open Mahjong.SafeGame

universe u v

/-- Both directions concern actual edges from every physical representative.
`forward` covers all opponent choices at a P state. `backward` realizes the
selected quotient move at an N state. -/
structure TransitionQuotient {α : Type u} {β : Type v}
    (physicalMove : α → α → Prop) (quotientMove : β → β → Prop)
    (encode : α → β) : Prop where
  forward : ∀ {s t}, physicalMove s t → quotientMove (encode s) (encode t)
  backward : ∀ {s q}, quotientMove (encode s) q →
    ∃ t, physicalMove s t ∧ encode t = q

private theorem normalStrategy_lift_aux {α : Type u} {β : Type v}
    {physicalMove : α → α → Prop} {quotientMove : β → β → Prop}
    {encode : α → β}
    (quotient : TransitionQuotient physicalMove quotientMove encode)
    {q : β} {o : Outcome} (h : NormalStrategy quotientMove q o) :
    ∀ s, encode s = q → NormalStrategy physicalMove s o := by
  induction h with
  | @p q next ih =>
      intro s hs
      apply NormalStrategy.p
      intro t edge
      have mapped := quotient.forward edge
      rw [hs] at mapped
      exact ih (encode t) mapped t rfl
  | @n q r edge child ih =>
      intro s hs
      have mapped : quotientMove (encode s) r := by
        rw [hs]
        exact edge
      obtain ⟨t, physicalEdge, ht⟩ := quotient.backward mapped
      exact NormalStrategy.n physicalEdge (ih t ht)

/-- A quotient proof yields a proof for every physical representative.
No external computation, finite enumeration, rank, or injectivity assumption
is used: the finite strategy proof itself is the induction object. -/
theorem normalStrategy_lift {α : Type u} {β : Type v}
    {physicalMove : α → α → Prop} {quotientMove : β → β → Prop}
    {encode : α → β}
    (quotient : TransitionQuotient physicalMove quotientMove encode)
    {s : α} {o : Outcome}
    (h : NormalStrategy quotientMove (encode s) o) :
    NormalStrategy physicalMove s o :=
  normalStrategy_lift_aux quotient h s rfl

/-- Under the same two-sided transition condition, a physical strategy also
descends to the quotient. -/
theorem normalStrategy_descend {α : Type u} {β : Type v}
    {physicalMove : α → α → Prop} {quotientMove : β → β → Prop}
    {encode : α → β}
    (quotient : TransitionQuotient physicalMove quotientMove encode)
    {s : α} {o : Outcome}
    (h : NormalStrategy physicalMove s o) :
    NormalStrategy quotientMove (encode s) o := by
  induction h with
  | @p s next ih =>
      apply NormalStrategy.p
      intro q edge
      obtain ⟨t, physicalEdge, ht⟩ := quotient.backward edge
      simpa only [ht] using ih t physicalEdge
  | n edge child ih =>
      exact NormalStrategy.n (quotient.forward edge) ih

theorem normalStrategy_iff {α : Type u} {β : Type v}
    {physicalMove : α → α → Prop} {quotientMove : β → β → Prop}
    {encode : α → β}
    (quotient : TransitionQuotient physicalMove quotientMove encode)
    {s : α} {o : Outcome} :
    NormalStrategy physicalMove s o ↔
      NormalStrategy quotientMove (encode s) o :=
  ⟨normalStrategy_descend quotient, normalStrategy_lift quotient⟩

/-- This bridge accepts a quotient P/N certificate only after both transition
directions and the certificate's decreasing-rank equations are proved. -/
theorem quotient_certificate_sound {α : Type u} {β : Type v}
    {physicalMove : α → α → Prop} {quotientMove : β → β → Prop}
    {encode : α → β} {rank : β → Nat} {label : β → Outcome}
    (quotient : TransitionQuotient physicalMove quotientMove encode)
    (cert : PNCertificate quotientMove rank label) (s : α) :
    NormalStrategy physicalMove s (label (encode s)) :=
  normalStrategy_lift quotient (cert.sound (encode s))

namespace MissingEdgeExample

inductive Position where
  | root
  | middle
  | leaf
  deriving DecidableEq, Repr

open Position

/-- The real root has both middle (N) and leaf (P) as successors. -/
def actual : Position → Position → Prop
  | root, middle => True
  | root, leaf => True
  | middle, leaf => True
  | _, _ => False

/-- One legal root-to-leaf edge has been omitted. -/
def truncated : Position → Position → Prop
  | root, middle => True
  | middle, leaf => True
  | _, _ => False

instance (s t : Position) : Decidable (actual s t) := by
  cases s <;> cases t <;> unfold actual <;> infer_instance

instance (s t : Position) : Decidable (truncated s t) := by
  cases s <;> cases t <;> unfold truncated <;> infer_instance

theorem actual_leaf_p : NormalStrategy actual leaf .P := by
  apply NormalStrategy.p
  intro t edge
  cases t <;> cases edge

theorem actual_root_n : NormalStrategy actual root .N :=
  NormalStrategy.n (t := leaf) (by decide) actual_leaf_p

theorem truncated_leaf_p : NormalStrategy truncated leaf .P := by
  apply NormalStrategy.p
  intro t edge
  cases t <;> cases edge

theorem truncated_middle_n : NormalStrategy truncated middle .N :=
  NormalStrategy.n (t := leaf) (by decide) truncated_leaf_p

theorem truncated_root_p : NormalStrategy truncated root .P := by
  apply NormalStrategy.p
  intro t edge
  cases t with
  | root => cases edge
  | middle => exact truncated_middle_n
  | leaf => cases edge

/-- Omitting a P successor flips the root classification. -/
theorem missing_edge_flips_outcome :
    NormalStrategy actual root .N ∧ NormalStrategy truncated root .P :=
  ⟨actual_root_n, truncated_root_p⟩

/-- The remaining listed edges are real, but that one-sided check is not
enough to justify lifting the erroneous truncated P proof. -/
theorem remaining_edges_are_real : ∀ s t, truncated s t → actual s t := by
  intro s t
  cases s <;> cases t <;> decide

theorem omitted_edge_is_real : actual root leaf ∧ ¬ truncated root leaf := by
  decide

theorem incomplete_identity_is_not_quotient :
    ¬ TransitionQuotient actual truncated id := by
  intro quotient
  exact omitted_edge_is_real.2 (quotient.forward omitted_edge_is_real.1)

end MissingEdgeExample

end Mahjong.Quotient

#print axioms Mahjong.Quotient.normalStrategy_lift
#print axioms Mahjong.Quotient.normalStrategy_descend
#print axioms Mahjong.Quotient.quotient_certificate_sound
#print axioms Mahjong.Quotient.MissingEdgeExample.missing_edge_flips_outcome
#print axioms Mahjong.Quotient.MissingEdgeExample.incomplete_identity_is_not_quotient
