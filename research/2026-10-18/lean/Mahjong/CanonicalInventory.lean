import Mahjong.LocalSymmetryFrame

set_option autoImplicit false

namespace Mahjong.CanonicalInventory
open LocalSymmetryFrame LocalCacheEncoding MaskedLocalBound Generators PruningAlgebra

instance (a : Label) : Decidable (passesPartial a) := by
  unfold passesPartial
  infer_instance

def allowedB (b : Nat) : Generator → Bool
  | .reverseSuit a => decide (a.val = b)
  | .swapHonors _ _ => decide (b = 3)
  | .swapSuits _ _ => false

theorem allowedB_sound (b : Nat) (g : Generator) (h : allowedB b g = true) : Allowed b g := by
  cases g <;> simpa [allowedB, Allowed] using h

def generators (b : Nat) : List Generator :=
  if h : b < 3 then [.reverseSuit ⟨b, h⟩]
  else (List.finRange 7).flatMap (fun a => (List.finRange 7).map (fun c => .swapHonors a c))

theorem generators_complete (b : Nat) (g : Generator) (h : Allowed b g) : g ∈ generators b := by
  cases g with
  | reverseSuit a =>
    change a.val = b at h
    subst b
    simp [generators, a.isLt]
  | swapHonors a c =>
    change b = 3 at h
    subst b
    simp [generators, List.mem_flatMap]
  | swapSuits a c => cases h

structure Candidate where
  size : Nat
  count : Nat
  canonical : Nat → Nat
  raw : Nat → Label
  id : Nat → Nat
  member : Nat → Nat
  witness : Nat → List Generator

def checkRow (b : Nat) (t : Candidate) (i : Nat) : Bool :=
  let c := t.canonical i
  let s := decodeBlock b i
  decide (c < t.size) &&
  decide (t.canonical c = c) &&
  decide (encodeBlock b s = i) &&
  (t.witness i).all (allowedB b) &&
  sameBlockB b (decodeBlock b c) (applyPath (t.witness i) s) &&
  decide (t.id i < t.count ↔ c = i ∧ passesPartial (t.raw i)) &&
  (if t.id i < t.count then decide (t.member (t.id i) = i) else true) &&
  (generators b).all (fun g =>
    let k := encodeBlock b (act g s)
    decide (k < t.size) && decide (t.canonical k = c))

def checkMember (t : Candidate) (k : Nat) : Bool :=
  decide (t.member k < t.size) && decide (t.id (t.member k) = k)

def checkSpan (row : Nat → Bool) (start : Nat) : Nat → Bool
  | 0 => true
  | n + 1 => row start && checkSpan row (start + 1) n

theorem checkSpan_add (row : Nat → Bool) (a c start : Nat) :
    checkSpan row start (a + c) = (checkSpan row start a && checkSpan row (start + a) c) := by
  induction a generalizing start with
  | zero => simp [checkSpan]
  | succ a ih =>
    simp only [Nat.succ_add, checkSpan, ih]
    simp [Nat.add_assoc, Nat.add_comm, Nat.add_left_comm, Bool.and_assoc]

theorem checkSpan_each (row : Nat → Bool) (count start : Nat)
    (checked : checkSpan row start count = true) :
    ∀ offset, offset < count → row (start + offset) = true := by
  induction count generalizing start with
  | zero => intro offset h; omega
  | succ count ih =>
    have parts : row start = true ∧ checkSpan row (start + 1) count = true := by
      simpa only [checkSpan, Bool.and_eq_true] using checked
    intro offset h
    cases offset with
    | zero => simpa using parts.1
    | succ offset =>
      have x := ih (start + 1) parts.2 offset (by omega)
      simpa [Nat.add_assoc, Nat.add_comm, Nat.add_left_comm] using x

structure RowFacts (b : Nat) (t : Candidate) (i : Nat) : Prop where
  range : t.canonical i < t.size
  fixed : t.canonical (t.canonical i) = t.canonical i
  roundtrip : encodeBlock b (decodeBlock b i) = i
  allowed : AllowedPath b (t.witness i)
  witness : SameBlock b (decodeBlock b (t.canonical i)) (applyPath (t.witness i) (decodeBlock b i))
  kept : t.id i < t.count ↔ t.canonical i = i ∧ passesPartial (t.raw i)
  reverse : t.id i < t.count → t.member (t.id i) = i
  invariant : ∀ g, Allowed b g →
    t.canonical (encodeBlock b (act g (decodeBlock b i))) = t.canonical i

theorem checkRow_sound (b : Nat) (t : Candidate) (i : Nat)
    (checked : checkRow b t i = true) : RowFacts b t i := by
  simp only [checkRow, Bool.and_eq_true, decide_eq_true_eq] at checked
  obtain ⟨⟨⟨⟨⟨⟨⟨range, fixed⟩, roundtrip⟩, allowed⟩, witness⟩, kept⟩, rev⟩, inv⟩ := checked
  refine ⟨range, fixed, roundtrip, ?_, sameBlockB_sound witness, kept, ?_, ?_⟩
  · intro g hg
    exact allowedB_sound b g (List.all_eq_true.mp allowed g hg)
  · intro h
    simpa [h] using rev
  · intro g hg
    have r := List.all_eq_true.mp inv g (generators_complete b g hg)
    simp only [Bool.and_eq_true, decide_eq_true_eq] at r
    exact r.2

def Checked (b : Nat) (t : Candidate) : Prop :=
  checkSpan (checkRow b t) 0 t.size = true ∧ checkSpan (checkMember t) 0 t.count = true

theorem checked_row (b : Nat) (t : Candidate) (checked : Checked b t)
    (i : Nat) (inside : i < t.size) : RowFacts b t i := by
  apply checkRow_sound
  simpa using checkSpan_each (checkRow b t) t.size 0 checked.1 i inside

theorem checked_member (b : Nat) (t : Candidate) (checked : Checked b t)
    (k : Nat) (inside : k < t.count) : t.member k < t.size ∧ t.id (t.member k) = k := by
  have row := checkSpan_each (checkMember t) t.count 0 checked.2 k inside
  simpa only [Nat.zero_add, checkMember, Bool.and_eq_true, decide_eq_true_eq] using row

/-- The retained vector is exactly the fixed canonical codes passing the local
filter, with both inverse equations; labels never merge distinct members. -/
theorem retained_iff (b : Nat) (t : Candidate) (checked : Checked b t)
    (i : Nat) (inside : i < t.size) :
    (∃ k, k < t.count ∧ t.member k = i) ↔ t.canonical i = i ∧ passesPartial (t.raw i) := by
  constructor
  · rintro ⟨k, hk, eq⟩
    have inv := (checked_member b t checked k hk).2
    rw [eq] at inv
    exact (checked_row b t checked i inside).kept.mp (by omega)
  · intro h
    have row := checked_row b t checked i inside
    exact ⟨t.id i, row.kept.mpr h, row.reverse (row.kept.mpr h)⟩

theorem member_injective (b : Nat) (t : Candidate) (checked : Checked b t)
    (j k : Nat) (hj : j < t.count) (hk : k < t.count) (eq : t.member j = t.member k) : j = k := by
  have e := congrArg t.id eq
  rwa [(checked_member b t checked j hj).2, (checked_member b t checked k hk).2] at e

theorem canonical_context (b : Nat) (t : Candidate) (checked : Checked b t)
    (i : Nat) (inside : i < t.size) (s : State) (same : SameBlock b (decodeBlock b i) s) :
    replaceBlock b s (decodeBlock b (t.canonical i)) = applyPath (t.witness i) s :=
  lift_witness b (t.witness i) (checked_row b t checked i inside).allowed
    _ _ _ same (checked_row b t checked i inside).witness

theorem canonical_safe_iff (b : Nat) (t : Candidate) (checked : Checked b t)
    (i : Nat) (inside : i < t.size) (s : State) (same : SameBlock b (decodeBlock b i) s) :
    IsSafe (replaceBlock b s (decodeBlock b (t.canonical i))) ↔ IsSafe s := by
  rw [canonical_context b t checked i inside s same]
  exact path_safe_iff _ _

theorem encode_same (b : Nat) (s t : State) (same : SameBlock b s t) : encodeBlock b s = encodeBlock b t := by
  have eq : (fun (v : Nat) (u : Tile) => if u.val / 9 = b then v + s u * powers[u.val % 9]! else v) =
      (fun v u => if u.val / 9 = b then v + t u * powers[u.val % 9]! else v) := by
    funext v u
    by_cases hu : u.val / 9 = b
    · simp only [hu, ↓reduceIte, same u hu]
    · simp only [hu, ↓reduceIte]
  unfold encodeBlock
  rw [eq]

theorem canonical_generator (b : Nat) (hb : b < 4) (t : Candidate) (checked : Checked b t)
    (size : t.size = Base5Coverage.size b) (s : State) (valid : Valid s)
    (g : Generator) (allowed : Allowed b g) :
    t.canonical (encodeBlock b (act g s)) = t.canonical (encodeBlock b s) := by
  have inside : encodeBlock b s < t.size := by rw [size]; exact Base5Coverage.encode_range s valid b hb
  have inv := (checked_row b t checked _ inside).invariant g allowed
  have eq := encode_same b _ _ (sameBlock_act b g allowed _ _ (Base5Coverage.decode_encode_same s valid b))
  rwa [eq] at inv

/-- Equal representatives for any finite allowed local symmetry path, including
arbitrarily many honor swaps. This is stronger than checking idempotence alone. -/
theorem canonical_path (b : Nat) (hb : b < 4) (t : Candidate) (checked : Checked b t)
    (size : t.size = Base5Coverage.size b) (path : List Generator) (allowed : AllowedPath b path)
    (s : State) (valid : Valid s) :
    t.canonical (encodeBlock b (applyPath path s)) = t.canonical (encodeBlock b s) := by
  induction path generalizing s with
  | nil => rfl
  | cons g gs ih =>
    exact (ih (fun k hk => allowed k (List.mem_cons_of_mem g hk)) _
      (path_valid [g] s valid)).trans (canonical_generator b hb t checked size s valid g (allowed g (by simp)))

def read32 (bytes : ByteArray) (offset : Nat) : Nat :=
  bytes[offset]!.toNat + bytes[offset+1]!.toNat * 256 +
  bytes[offset+2]!.toNat * 65536 + bytes[offset+3]!.toNat * 16777216

/-- Candidate witness generation is not trusted: allowed generators and exact
decoded equality are checked independently by checkRow. -/
def makeWitness (b code c : Nat) : List Generator := Id.run do
  if b < 3 then
    return if c = code then [] else [.reverseSuit ⟨b % 3, Nat.mod_lt _ (by decide)⟩]
  let mut r := code
  let mut path : List Generator := []
  for i in [0:7] do
    for j in [i+1:7] do
      let pi := powers[i]!
      let pj := powers[j]!
      let di := r / pi % 5
      let dj := r / pj % 5
      if di < dj then
        r := r - di*pi - dj*pj + dj*pi + di*pj
        path := .swapHonors ⟨i%7, Nat.mod_lt _ (by decide)⟩ ⟨j%7, Nat.mod_lt _ (by decide)⟩ :: path
  return path.reverse

def candidate (b : Nat) (raw ids members : ByteArray) : Candidate where
  size := raw.size / 12
  count := members.size / 4
  canonical := fun i => read32 raw (12*i+8)
  raw := PruningData.rawLabel raw
  id := fun i => read32 ids (4*i)
  member := fun k => read32 members (4*k)
  witness := fun i => makeWitness b i (read32 raw (12*i+8))

end Mahjong.CanonicalInventory

#print axioms Mahjong.CanonicalInventory.checkRow_sound
#print axioms Mahjong.CanonicalInventory.checkSpan_add
#print axioms Mahjong.CanonicalInventory.checkSpan_each
#print axioms Mahjong.CanonicalInventory.retained_iff
#print axioms Mahjong.CanonicalInventory.member_injective
#print axioms Mahjong.CanonicalInventory.canonical_safe_iff
#print axioms Mahjong.CanonicalInventory.canonical_path
