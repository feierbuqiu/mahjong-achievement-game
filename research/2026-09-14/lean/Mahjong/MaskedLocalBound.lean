import Mahjong.StandardBoundCertificate

/-!
Reuse a checked bound using exact local tile counts. The local meld search
cannot inspect another block. This is only a lemma about current hand search;
it is not a quotient of the future game or an equivalence of P/N positions.
-/

namespace Mahjong.MaskedLocalBound

open StandardBoundCertificate

/-- Blocks 0, 1, 2 contain nine numeric kinds; block 3 contains seven honors. -/
def SameBlock (b : Nat) (s t : State) : Prop :=
  ∀ u : Tile, u.val / 9 = b → s u = t u

def sameBlockB (b : Nat) (s t : State) : Bool :=
  allTiles.all (fun u => if u.val / 9 = b then decide (s u = t u) else true)

theorem sameBlockB_iff (b : Nat) (s t : State) :
    sameBlockB b s t = true ↔ SameBlock b s t := by
  simp only [sameBlockB, List.all_eq_true]
  constructor
  · intro checked u hb
    have hh := checked u (mem_allTiles u)
    simpa only [if_pos hb, decide_eq_true_eq] using hh
  · intro same u _
    by_cases hb : u.val / 9 = b
    · simp only [if_pos hb, decide_eq_true_eq]
      exact same u hb
    · simp only [if_neg hb]

theorem sameBlockB_sound {b : Nat} {s t : State}
    (checked : sameBlockB b s t = true) : SameBlock b s t :=
  (sameBlockB_iff b s t).1 checked

def mask (b : Nat) (s : State) : State :=
  fun u => if u.val / 9 = b then s u else 0

theorem sameBlock_mask (b : Nat) (s : State) : SameBlock b (mask b s) s := by
  intro u hb
  simp only [mask, if_pos hb]

theorem mask_eq_of_sameBlock {b : Nat} {s t : State} (same : SameBlock b s t) :
    mask b s = mask b t := by
  funext u
  by_cases hb : u.val / 9 = b
  · simp only [mask, if_pos hb, same u hb]
  · simp only [mask, if_neg hb]

theorem sameBlock_removeMeld {b : Nat} {s t : State} (same : SameBlock b s t)
    (m : Meld) :
    SameBlock b (FastRuleChecker.removeMeld s m) (FastRuleChecker.removeMeld t m) := by
  intro u hb
  cases m <;> simp only [FastRuleChecker.removeMeld, same u hb]

theorem sameBlock_removePair {b : Nat} {s t : State} (same : SameBlock b s t)
    (pair : Tile) :
    SameBlock b (FastRuleChecker.removePair s pair) (FastRuleChecker.removePair t pair) := by
  intro u hb
  simp only [FastRuleChecker.removePair, same u hb]

theorem local_meldAvailable_eq {b : Nat} {s t : State} (same : SameBlock b s t)
    (m : Meld) (belongs : meldBlock m = b) :
    FastRuleChecker.meldAvailableB s m = FastRuleChecker.meldAvailableB t m := by
  cases m with
  | triplet u =>
    change u.val / 9 = b at belongs
    simp only [FastRuleChecker.meldAvailableB, same u belongs]
  | sequence suit start =>
    change suit.val = b at belongs
    have h0 := same (seqTile suit start 0) ((seqTile_same_suit suit start 0).trans belongs)
    have h1 := same (seqTile suit start 1) ((seqTile_same_suit suit start 1).trans belongs)
    have h2 := same (seqTile suit start 2) ((seqTile_same_suit suit start 2).trans belongs)
    simp only [FastRuleChecker.meldAvailableB, h0, h1, h2]

private theorem any_eq_of_on_list (ms : List Meld) (p q : Meld → Bool)
    (same : ∀ m, m ∈ ms → p m = q m) : ms.any p = ms.any q := by
  induction ms with
  | nil => rfl
  | cons m ms ih =>
    simp only [List.any_cons]
    rw [same m (by simp), ih (fun n hn => same n (List.mem_cons_of_mem _ hn))]

/-- Exact local counts suffice at every recursive depth, including after
    arbitrary repeated meld removal. No four-copy or search-result premise
    is needed for this extensional identity. -/
theorem search_local_eq (b k : Nat) (s t : State) (same : SameBlock b s t) :
    searchWith (localMelds b) k s = searchWith (localMelds b) k t := by
  induction k generalizing s t with
  | zero => rfl
  | succ k ih =>
    simp only [searchWith]
    apply any_eq_of_on_list
    intro m hm
    rw [local_meldAvailable_eq same m ((mem_localMelds b m).1 hm),
      ih _ _ (sameBlock_removeMeld same m)]

theorem search_mask_eq (b k : Nat) (s : State) :
    searchWith (localMelds b) k (mask b s) = searchWith (localMelds b) k s :=
  search_local_eq b k _ _ (sameBlock_mask b s)

/-- A cached proof is reused only after all nine or seven local counts match.
    The cached upper bound itself must already be a kernel theorem. -/
theorem transfer_false (b cap : Nat) (s cached : State)
    (checked : sameBlockB b s cached = true)
    (hcached : searchWith (localMelds b) (cap + 1) (mask b cached) = false) :
    searchWith (localMelds b) (cap + 1) s = false := by
  rw [search_local_eq b (cap + 1) s cached (sameBlockB_sound checked)]
  rw [← search_mask_eq b (cap + 1) cached]
  exact hcached

namespace Tests

def cachedPair : State := fun u => if u = 0 then 2 else 0
def sameSuitWithHonorQuad : State := fun u => if u = 27 then 4 else cachedPair u

theorem checked_local_match : sameBlockB 0 sameSuitWithHonorQuad cachedPair = true := by
  decide +kernel

theorem checked_cached_bound : searchWith (localMelds 0) 1 (mask 0 cachedPair) = false := by
  decide +kernel

theorem transferred_bound : searchWith (localMelds 0) 1 sameSuitWithHonorQuad = false :=
  transfer_false 0 0 sameSuitWithHonorQuad cachedPair checked_local_match checked_cached_bound

end Tests

end Mahjong.MaskedLocalBound

#print axioms Mahjong.MaskedLocalBound.sameBlockB_iff
#print axioms Mahjong.MaskedLocalBound.search_local_eq
#print axioms Mahjong.MaskedLocalBound.search_mask_eq
#print axioms Mahjong.MaskedLocalBound.transfer_false
#print axioms Mahjong.MaskedLocalBound.Tests.transferred_bound
