import Mahjong.SortedCoverage

set_option autoImplicit false
set_option maxRecDepth 8192
set_option maxHeartbeats 2000000

namespace Mahjong.GlobalOrbitKey
open CanonicalCoverage CanonicalInventory LocalCacheEncoding Base5Coverage Generators
open LocalSymmetryFrame PackedRules SuitSorting

def SharedKeys (t : Inventories) : Prop := ∀ b, b < 3 →
  (t b).canonical = (t 0).canonical ∧ (t b).id = (t 0).id

theorem shared_of_same_files (raw ids members : Nat → ByteArray)
    (rawSame : ∀ b, b < 3 → raw b = raw 0) (idSame : ∀ b, b < 3 → ids b = ids 0) :
    SharedKeys (inventories raw ids members) := by
  intro b hb
  constructor <;> simp only [inventories,CanonicalInventory.candidate,rawSame b hb,idSame b hb]

def blockKey (t : Inventories) (b : Nat) (s : State) : Nat :=
  (t b).id ((t b).canonical (encodeBlock b s))

def localKeys (t : Inventories) (s : State) : Packed :=
  ⟨blockKey t 0 s,blockKey t 1 s,blockKey t 2 s,blockKey t 3 s⟩

theorem localKeys_get (t : Inventories) (s : State) (b : Nat) (hb : b < 4) :
    (localKeys t s).get b = blockKey t b s := get_four (fun b => blockKey t b s) b hb

theorem packed_ext (p q : Packed) (same : ∀ b, b < 4 → p.get b = q.get b) : p = q := by
  have a := same 0 (by decide)
  have b := same 1 (by decide)
  have c := same 2 (by decide)
  have h := same 3 (by decide)
  cases p; cases q
  simp only [Packed.get] at a b c h
  cases a; cases b; cases c; cases h
  rfl

theorem encode_outside (b d : Nat) (g : Generator) (allowed : Allowed b g)
    (s : State) (different : d ≠ b) : encodeBlock d (act g s) = encodeBlock d s := by
  apply encode_same
  intro u hu
  exact congrArg s ((allowed_frame b g allowed u).2 (by omega))

theorem localKeys_local_generator (t : Inventories) (checked : CanonicalCoverage.Checked t)
    (sizes : CanonicalCoverage.ProperSizes t) (s : State) (valid : Valid s)
    (b : Nat) (hb : b < 4) (g : Generator) (allowed : Allowed b g) :
    localKeys t (act g s) = localKeys t s := by
  apply packed_ext
  intro d hd
  rw [localKeys_get t _ d hd,localKeys_get t _ d hd]
  by_cases same : d = b
  · subst d
    exact congrArg (t b).id (canonical_generator b hb (t b) (checked b hb) (sizes b hb) s valid g allowed)
  · simp only [blockKey,encode_outside b d g allowed s same]

theorem fin_three (a : Fin 3) : a = 0 ∨ a = 1 ∨ a = 2 := by
  have h := a.isLt
  have cases : a.val = 0 ∨ a.val = 1 ∨ a.val = 2 := by omega
  rcases cases with h | h | h
  · exact Or.inl (Fin.ext h)
  · exact Or.inr (Or.inl (Fin.ext h))
  · exact Or.inr (Or.inr (Fin.ext h))

theorem encode_swap (a c : Fin 3) (s : State) (b : Nat) (hb : b < 4) :
    encodeBlock b (act (.swapSuits a c) s) = encodeBlock (transposeBlock a c b) s := by
  have cases : b = 0 ∨ b = 1 ∨ b = 2 ∨ b = 3 := by omega
  rcases fin_three a with rfl | rfl | rfl <;>
    rcases fin_three c with rfl | rfl | rfl <;>
    rcases cases with rfl | rfl | rfl | rfl <;>
    simp [transposeBlock,encode0_eq,encode1_eq,encode2_eq,encode3_eq] <;> rfl

theorem localKeys_swap (t : Inventories) (shared : SharedKeys t) (s : State) (a c : Fin 3) :
    localKeys t (act (.swapSuits a c) s) = swapped a c (localKeys t s) := by
  apply packed_ext
  intro b hb
  rw [localKeys_get t _ b hb,swapped_get a c _ b hb]
  have source : transposeBlock a c b < 4 := by
    by_cases num : b < 3
    · have h := numeric_bound a c b num; omega
    · have eq : b = 3 := by omega
      subst b
      have na : 3 ≠ a.val := by have h := a.isLt; omega
      have nc : 3 ≠ c.val := by have h := c.isLt; omega
      simp [transposeBlock,na,nc]
  rw [localKeys_get t s _ source]
  unfold blockKey
  rw [encode_swap a c s b hb]
  by_cases num : b < 3
  · rw [(shared b num).1,(shared b num).2,
        (shared _ (numeric_bound a c b num)).1,(shared _ (numeric_bound a c b num)).2]
  · have eq : b = 3 := by omega
    subst b
    have na : 3 ≠ a.val := by have h := a.isLt; omega
    have nc : 3 ≠ c.val := by have h := c.isLt; omega
    simp only [transposeBlock,na,nc,↓reduceIte]

/-- Min, sum and max uniquely determine a sorted three-element tuple. -/
def signature (p : Packed) : Packed :=
  ⟨min (min p.a p.b) p.c,p.a+p.b+p.c,max (max p.a p.b) p.c,p.h⟩

theorem signature_swap (p : Packed) (a c : Fin 3) : signature (swapped a c p) = signature p := by
  rcases fin_three a with rfl | rfl | rfl <;> rcases fin_three c with rfl | rfl | rfl <;>
    simp [signature,swapped,transposeBlock,Packed.get,Nat.min_comm,Nat.min_left_comm,
      Nat.max_comm,Nat.max_left_comm,Nat.add_comm,Nat.add_left_comm]

def key (t : Inventories) (s : State) : Packed := signature (localKeys t s)

theorem key_generator (t : Inventories) (checked : CanonicalCoverage.Checked t)
    (sizes : CanonicalCoverage.ProperSizes t) (shared : SharedKeys t)
    (g : Generator) (s : State) (valid : Valid s) : key t (act g s) = key t s := by
  cases g with
  | reverseSuit a =>
    unfold key
    rw [localKeys_local_generator t checked sizes s valid a.val (by have h := a.isLt; omega)
      (.reverseSuit a) rfl]
  | swapHonors a c =>
    unfold key
    rw [localKeys_local_generator t checked sizes s valid 3 (by decide) (.swapHonors a c) rfl]
  | swapSuits a c =>
    unfold key
    rw [localKeys_swap t shared s a c,signature_swap]

theorem key_path (t : Inventories) (checked : CanonicalCoverage.Checked t)
    (sizes : CanonicalCoverage.ProperSizes t) (shared : SharedKeys t)
    (path : List Generator) (s : State) (valid : Valid s) : key t (applyPath path s) = key t s := by
  induction path generalizing s with
  | nil => rfl
  | cons g gs ih =>
    exact (ih (act g s) (path_valid [g] s valid)).trans (key_generator t checked sizes shared g s valid)

theorem signature_sorted (p : Packed) (ab : p.a ≤ p.b) (bc : p.b ≤ p.c) :
    signature p = ⟨p.a,p.a+p.b+p.c,p.c,p.h⟩ := by
  simp only [signature,Nat.min_eq_left ab,Nat.min_eq_left (Nat.le_trans ab bc),
    Nat.max_eq_right ab,Nat.max_eq_right bc]

theorem signature_sorted_injective (p q : Packed)
    (pa : p.a ≤ p.b) (pb : p.b ≤ p.c) (qa : q.a ≤ q.b) (qb : q.b ≤ q.c)
    (same : signature p = signature q) : p = q := by
  rw [signature_sorted p pa pb,signature_sorted q qa qb] at same
  have a := congrArg Packed.a same
  have b := congrArg Packed.b same
  have c := congrArg Packed.c same
  have h := congrArg Packed.h same
  dsimp only at a b c h
  apply packed_ext
  intro i hi
  have cases : i = 0 ∨ i = 1 ∨ i = 2 ∨ i = 3 := by omega
  rcases cases with rfl | rfl | rfl | rfl <;> simp only [Packed.get] <;> omega

end Mahjong.GlobalOrbitKey

#print axioms Mahjong.GlobalOrbitKey.shared_of_same_files
#print axioms Mahjong.GlobalOrbitKey.localKeys_local_generator
#print axioms Mahjong.GlobalOrbitKey.encode_swap
#print axioms Mahjong.GlobalOrbitKey.localKeys_swap
#print axioms Mahjong.GlobalOrbitKey.signature_swap
#print axioms Mahjong.GlobalOrbitKey.key_generator
#print axioms Mahjong.GlobalOrbitKey.key_path
#print axioms Mahjong.GlobalOrbitKey.signature_sorted_injective
