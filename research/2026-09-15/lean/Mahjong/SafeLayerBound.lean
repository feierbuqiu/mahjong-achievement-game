import Mahjong.TileCountBridge

set_option autoImplicit false

namespace Mahjong.SafeLayerBound
open PruningAlgebra CanonicalInventory

/-- Orphan fields are intentionally omitted. A bound using only necessary
partial filters also bounds the stronger original SAFE predicate. -/
structure Shape where
  current : Profile
  added : Profile
  pairs : Nat
  single : Bool
  deriving DecidableEq, Repr

def shape (a : Label) : Shape := ⟨a.current,a.added,a.pairs,a.single⟩
def model (a : Shape) (tiles : Nat) : Label := ⟨a.current,a.added,a.pairs,a.single,0,false,tiles⟩
def shapeJoin (a b : Shape) : Shape := shape (join (model a 0) (model b 0))
def passes (a : Shape) : Prop := passesPartial (model a 0)
instance (a : Shape) : Decidable (passes a) := by unfold passes; infer_instance

structure Envelope where
  size : Nat
  key : Nat → Shape
  bound : Nat → Nat
  index : Shape → Nat

def Covered (e : Envelope) (a : Label) : Prop :=
  ∃ i, i < e.size ∧ e.key i = shape a ∧ a.tiles ≤ e.bound i

def checkLookup (e : Envelope) (a : Shape) (tiles : Nat) : Bool :=
  let i := e.index a
  decide (i < e.size) && decide (e.key i = a) && decide (tiles ≤ e.bound i)

theorem lookup_sound (e : Envelope) (a : Shape) (tiles : Nat)
    (h : checkLookup e a tiles = true) : ∃ i, i < e.size ∧ e.key i = a ∧ tiles ≤ e.bound i := by
  simp only [checkLookup, Bool.and_eq_true, decide_eq_true_eq] at h
  exact ⟨e.index a, h.1.1, h.1.2, h.2⟩

def checkRaw (e : Envelope) (raw : ByteArray) (i : Nat) : Bool :=
  let a := PruningData.rawLabel raw i
  if passesPartial a then checkLookup e (shape a) a.tiles else true

theorem raw_covered (e : Envelope) (raw : ByteArray) (count i : Nat)
    (h : checkSpan (checkRaw e raw) 0 count = true) (inside : i < count)
    (pass : passesPartial (PruningData.rawLabel raw i)) : Covered e (PruningData.rawLabel raw i) := by
  have row := checkSpan_each (checkRaw e raw) count 0 h i inside
  simp only [Nat.zero_add, checkRaw, pass, ↓reduceIte] at row
  exact lookup_sound _ _ _ row

def checkPair (a b c : Envelope) (i j : Nat) : Bool :=
  let key := shapeJoin (a.key i) (b.key j)
  if passes key then checkLookup c key (a.bound i + b.bound j) else true

def checkJoin (a b c : Envelope) : Bool :=
  checkSpan (fun i => checkSpan (checkPair a b c i) 0 b.size) 0 a.size

theorem covered_join (a b c : Envelope) (checked : checkJoin a b c = true)
    (u v : Label) (hu : Covered a u) (hv : Covered b v) (pass : passesPartial (join u v)) :
    Covered c (join u v) := by
  obtain ⟨i, hi, ei, wi⟩ := hu
  obtain ⟨j, hj, ej, wj⟩ := hv
  have row := checkSpan_each (fun i => checkSpan (checkPair a b c i) 0 b.size) a.size 0 checked i hi
  have pair := checkSpan_each (checkPair a b c i) b.size 0 (by simpa using row) j hj
  have passed : passes (shapeJoin (a.key i) (b.key j)) := by rw [ei, ej]; exact pass
  simp only [Nat.zero_add, checkPair, passed, ↓reduceIte] at pair
  obtain ⟨k, hk, ek, wk⟩ := lookup_sound _ _ _ pair
  refine ⟨k, hk, ?_, ?_⟩
  · rw [ei, ej] at ek
    exact ek
  · change u.tiles + v.tiles ≤ c.bound k
    omega

def checkFinal (e : Envelope) (limit : Nat) : Bool := checkSpan (fun i => decide (e.bound i ≤ limit)) 0 e.size

theorem covered_bound (e : Envelope) (limit : Nat) (checked : checkFinal e limit = true)
    (a : Label) (covered : Covered e a) : a.tiles ≤ limit := by
  obtain ⟨i, hi, _, bound⟩ := covered
  have row := checkSpan_each (fun i => decide (e.bound i ≤ limit)) e.size 0 checked i hi
  have last : e.bound i ≤ limit := by simpa using row
  omega

theorem four_bound (num hon two three four : Envelope) (limit : Nat)
    (c2 : checkJoin num num two = true) (c3 : checkJoin two num three = true)
    (c4 : checkJoin three hon four = true) (last : checkFinal four limit = true)
    (a b c h : Label) (ha : Covered num a) (hb : Covered num b) (hc : Covered num c) (hh : Covered hon h)
    (safe : fullSafe (join (join (join a b) c) h)) : (join (join (join a b) c) h).tiles ≤ limit := by
  have early := four_block_pruning_complete _ _ _ _ safe
  have ab := covered_join num num two c2 a b ha hb early.2.2.2.2.1
  have abc := covered_join two num three c3 _ c ab hc early.2.2.2.2.2
  have all := covered_join three hon four c4 _ h abc hh safe.1
  exact covered_bound four limit last _ all

def RawChecked (num hon : Envelope) (raw : Nat → ByteArray) : Prop :=
  ∀ b, b < 4 → checkSpan (checkRaw (if b = 3 then hon else num) (raw b)) 0 (Base5Coverage.size b) = true

theorem original_safe_bound (core summary raw : Nat → ByteArray)
    (sizes : Base5Coverage.ProperSizes core)
    (checked : FullSafeData.Checked (Base5Coverage.tables core summary raw))
    (num hon two three four : Envelope) (limit : Nat) (localChecked : RawChecked num hon raw)
    (c2 : checkJoin num num two = true) (c3 : checkJoin two num three = true)
    (c4 : checkJoin three hon four = true) (last : checkFinal four limit = true)
    (s : State) (valid : Valid s) (safe : IsSafe s) : total s ≤ limit := by
  have full := (Base5Coverage.checked_filter_on_every_valid_state core summary raw sizes checked s valid).mpr safe
  have early := CanonicalCoverage.safe_raw_partials core summary raw sizes checked s valid safe
  have cover (b : Nat) (hb : b < 4) :
      Covered (if b = 3 then hon else num)
        (FullSafeData.rawAt (Base5Coverage.tables core summary raw) (Base5Coverage.pack s) b) := by
    rw [CanonicalCoverage.rawAt_pack core summary raw s b hb]
    exact raw_covered _ _ _ _ (localChecked b hb) (Base5Coverage.encode_range s valid b hb) (early b hb)
  have bound := four_bound num hon two three four limit c2 c3 c4 last _ _ _ _
    (cover 0 (by decide)) (cover 1 (by decide)) (cover 2 (by decide)) (cover 3 (by decide)) full
  change (FullSafeData.allRaw (Base5Coverage.tables core summary raw) (Base5Coverage.pack s)).tiles ≤ limit at bound
  rwa [TileCountBridge.raw_total core summary raw sizes checked s valid] at bound

def shapeKey (a : Shape) : Nat :=
  a.current.meld + 8*a.current.pair + 64*(a.added.meld + 8*a.added.pair) + 4096*a.pairs + (if a.single then 32768 else 0)

def decodeKey (key : Nat) : Shape :=
  ⟨⟨key % 8,key / 8 % 8⟩,⟨key / 64 % 8,key / 512 % 8⟩,key / 4096 % 8,decide (key / 32768 % 2 = 1)⟩

def candidate (entries index : ByteArray) : Envelope where
  size := entries.size / 8
  key := fun i => decodeKey (read32 entries (i*8))
  bound := fun i => read32 entries (i*8+4)
  index := fun a => read32 index (4*shapeKey a)

end Mahjong.SafeLayerBound

#print axioms Mahjong.SafeLayerBound.lookup_sound
#print axioms Mahjong.SafeLayerBound.covered_join
#print axioms Mahjong.SafeLayerBound.four_bound
#print axioms Mahjong.SafeLayerBound.original_safe_bound
