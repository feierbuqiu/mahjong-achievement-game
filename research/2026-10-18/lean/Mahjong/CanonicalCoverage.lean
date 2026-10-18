import Mahjong.CanonicalInventory

set_option autoImplicit false

namespace Mahjong.CanonicalCoverage
open CanonicalInventory LocalSymmetryFrame LocalCacheEncoding MaskedLocalBound Generators PruningAlgebra

abbrev Inventories := Nat → CanonicalInventory.Candidate
def Checked (t : Inventories) : Prop := ∀ b, b < 4 → CanonicalInventory.Checked b (t b)
def ProperSizes (t : Inventories) : Prop := ∀ b, b < 4 → (t b).size = Base5Coverage.size b

def canonBlock (t : Inventories) (b : Nat) (s : State) : State :=
  replaceBlock b s (decodeBlock b ((t b).canonical (encodeBlock b s)))

theorem canonBlock_eq (t : Inventories) (checked : Checked t) (sizes : ProperSizes t)
    (b : Nat) (hb : b < 4) (s : State) (valid : Valid s) :
    canonBlock t b s = applyPath ((t b).witness (encodeBlock b s)) s := by
  apply canonical_context b (t b) (checked b hb) _ _ s (Base5Coverage.decode_encode_same s valid b)
  rw [sizes b hb]
  exact Base5Coverage.encode_range s valid b hb

theorem canonBlock_valid (t : Inventories) (checked : Checked t) (sizes : ProperSizes t)
    (b : Nat) (hb : b < 4) (s : State) (valid : Valid s) : Valid (canonBlock t b s) := by
  rw [canonBlock_eq t checked sizes b hb s valid]
  exact path_valid _ s valid

theorem canonBlock_safe (t : Inventories) (checked : Checked t) (sizes : ProperSizes t)
    (b : Nat) (hb : b < 4) (s : State) (valid : Valid s) : IsSafe (canonBlock t b s) ↔ IsSafe s := by
  rw [canonBlock_eq t checked sizes b hb s valid]
  exact path_safe_iff _ s

theorem encode_replace_self (b : Nat) (s r : State) :
    encodeBlock b (replaceBlock b s r) = encodeBlock b r := by
  apply encode_same
  intro u hu
  simp only [replaceBlock, hu, ↓reduceIte]

theorem encode_replace_other (b d : Nat) (ne : d ≠ b) (s r : State) :
    encodeBlock d (replaceBlock b s r) = encodeBlock d s := by
  apply encode_same
  intro u hu
  simp only [replaceBlock, hu, ne, ↓reduceIte]

theorem canonBlock_fixed (t : Inventories) (checked : Checked t) (sizes : ProperSizes t)
    (b : Nat) (hb : b < 4) (s : State) (valid : Valid s) :
    (t b).canonical (encodeBlock b (canonBlock t b s)) = encodeBlock b (canonBlock t b s) := by
  have inside : encodeBlock b s < (t b).size := by
    rw [sizes b hb]
    exact Base5Coverage.encode_range s valid b hb
  have row := checked_row b (t b) (checked b hb) _ inside
  have canonicalRow := checked_row b (t b) (checked b hb) _ row.range
  simp only [canonBlock, encode_replace_self, canonicalRow.roundtrip]
  exact row.fixed

def normalizePrefix (t : Inventories) : Nat → State → State
  | 0, s => s
  | n + 1, s => canonBlock t n (normalizePrefix t n s)

theorem prefix_valid (t : Inventories) (checked : Checked t) (sizes : ProperSizes t)
    (n : Nat) (hn : n ≤ 4) (s : State) (valid : Valid s) : Valid (normalizePrefix t n s) := by
  induction n with
  | zero => exact valid
  | succ n ih => exact canonBlock_valid t checked sizes n (by omega) _ (ih (by omega))

theorem prefix_safe (t : Inventories) (checked : Checked t) (sizes : ProperSizes t)
    (n : Nat) (hn : n ≤ 4) (s : State) (valid : Valid s) : IsSafe (normalizePrefix t n s) ↔ IsSafe s := by
  induction n with
  | zero => exact Iff.rfl
  | succ n ih =>
    exact (canonBlock_safe t checked sizes n (by omega) _ (prefix_valid t checked sizes n (by omega) s valid)).trans
      (ih (by omega))

theorem prefix_fixed (t : Inventories) (checked : Checked t) (sizes : ProperSizes t)
    (n : Nat) (hn : n ≤ 4) (s : State) (valid : Valid s) :
    ∀ b, b < n → (t b).canonical (encodeBlock b (normalizePrefix t n s)) = encodeBlock b (normalizePrefix t n s) := by
  induction n with
  | zero => intro b hb; omega
  | succ n ih =>
    intro b hb
    by_cases eq : b = n
    · subst b
      exact canonBlock_fixed t checked sizes n (by omega) _ (prefix_valid t checked sizes n (by omega) s valid)
    · simp only [normalizePrefix, canonBlock, encode_replace_other n b eq]
      exact ih (by omega) b (by omega)

theorem path_append (a b : List Generator) (s : State) :
    applyPath (a ++ b) s = applyPath b (applyPath a s) := by
  induction a generalizing s with
  | nil => rfl
  | cons g gs ih => exact ih (act g s)

theorem prefix_witness (t : Inventories) (checked : Checked t) (sizes : ProperSizes t)
    (n : Nat) (hn : n ≤ 4) (s : State) (valid : Valid s) :
    ∃ path, normalizePrefix t n s = applyPath path s := by
  induction n with
  | zero => exact ⟨[], rfl⟩
  | succ n ih =>
    obtain ⟨path, eq⟩ := ih (by omega)
    let w := (t n).witness (encodeBlock n (normalizePrefix t n s))
    refine ⟨path ++ w, ?_⟩
    rw [path_append, ← eq]
    exact canonBlock_eq t checked sizes n (by omega) _ (prefix_valid t checked sizes n (by omega) s valid)

def inventories (raw ids members : Nat → ByteArray) : Inventories :=
  fun b => CanonicalInventory.candidate b (raw b) (ids b) (members b)

theorem retained_orbit_injective (b : Nat) (hb : b < 4) (t : CanonicalInventory.Candidate)
    (checked : CanonicalInventory.Checked b t) (size : t.size = Base5Coverage.size b)
    (j k : Nat) (hj : j < t.count) (hk : k < t.count)
    (path : List Generator) (allowed : AllowedPath b path)
    (same : SameBlock b (decodeBlock b (t.member j)) (applyPath path (decodeBlock b (t.member k)))) : j = k := by
  have mj := checked_member b t checked j hj
  have mk := checked_member b t checked k hk
  have rj := checked_row b t checked _ mj.1
  have rk := checked_row b t checked _ mk.1
  have fj := (retained_iff b t checked _ mj.1).mp ⟨j, hj, rfl⟩
  have fk := (retained_iff b t checked _ mk.1).mp ⟨k, hk, rfl⟩
  have encoded := encode_same b _ _ same
  have inv := canonical_path b hb t checked size path allowed _ (decode_valid b (t.member k))
  have eq : t.member j = t.member k := by
    calc
      t.member j = t.canonical (encodeBlock b (decodeBlock b (t.member j))) := by rw [rj.roundtrip, fj.1]
      _ = t.canonical (encodeBlock b (applyPath path (decodeBlock b (t.member k)))) := congrArg t.canonical encoded
      _ = t.canonical (encodeBlock b (decodeBlock b (t.member k))) := inv
      _ = t.member k := by rw [rk.roundtrip, fk.1]
  exact member_injective b t checked j k hj hk eq

theorem rawAt_pack (core summary raw : Nat → ByteArray) (s : State) (b : Nat) (hb : b < 4) :
    FullSafeData.rawAt (Base5Coverage.tables core summary raw) (Base5Coverage.pack s) b =
      PruningData.rawLabel (raw b) (encodeBlock b s) := by
  change PruningData.rawLabel (raw b) ((Base5Coverage.pack s).get b) = _
  rw [Base5Coverage.pack_get s b hb]

theorem full_parts (f : Nat → Label)
    (h : fullSafe (join (join (join (f 0) (f 1)) (f 2)) (f 3))) :
    ∀ b, b < 4 → passesPartial (f b) := by
  have early := four_block_pruning_complete _ _ _ _ h
  intro b hb
  have options : b = 0 ∨ b = 1 ∨ b = 2 ∨ b = 3 := by omega
  rcases options with rfl | rfl | rfl | rfl
  · exact early.1
  · exact early.2.1
  · exact early.2.2.1
  · exact early.2.2.2.1

theorem safe_raw_partials (core summary raw : Nat → ByteArray)
    (coreSizes : Base5Coverage.ProperSizes core)
    (safeChecked : FullSafeData.Checked (Base5Coverage.tables core summary raw))
    (s : State) (valid : Valid s) (safe : IsSafe s) :
    ∀ b, b < 4 → passesPartial (PruningData.rawLabel (raw b) (encodeBlock b s)) := by
  have full := (Base5Coverage.checked_filter_on_every_valid_state core summary raw coreSizes safeChecked s valid).mpr safe
  unfold FullSafeData.allRaw at full
  rw [rawAt_pack core summary raw s 0 (by decide), rawAt_pack core summary raw s 1 (by decide),
    rawAt_pack core summary raw s 2 (by decide), rawAt_pack core summary raw s 3 (by decide)] at full
  exact full_parts (fun b => PruningData.rawLabel (raw b) (encodeBlock b s)) full

/-- Every original valid SAFE state has a rule-equivalent SAFE representative
whose four encoded local blocks occur in the actual retained member vectors.
This proves local inventory coverage without assuming any global directory,
layer cutoff, or P/N table entry. Three-suit ordering is still separate. -/
theorem every_safe_has_retained_representative (core summary raw ids members : Nat → ByteArray)
    (coreSizes : Base5Coverage.ProperSizes core)
    (safeChecked : FullSafeData.Checked (Base5Coverage.tables core summary raw))
    (inventorySizes : ProperSizes (inventories raw ids members))
    (inventoryChecked : Checked (inventories raw ids members))
    (s : State) (valid : Valid s) (safe : IsSafe s) :
    ∃ r : State, ∃ path : List Generator,
      Valid r ∧ IsSafe r ∧ r = applyPath path s ∧
      ∀ b, b < 4 → ∃ k, k < (inventories raw ids members b).count ∧
        (inventories raw ids members b).member k = encodeBlock b r := by
  let t := inventories raw ids members
  let r := normalizePrefix t 4 s
  have vr : Valid r := prefix_valid t inventoryChecked inventorySizes 4 (by decide) s valid
  have sr : IsSafe r := (prefix_safe t inventoryChecked inventorySizes 4 (by decide) s valid).mpr safe
  obtain ⟨path, witness⟩ := prefix_witness t inventoryChecked inventorySizes 4 (by decide) s valid
  refine ⟨r, path, vr, sr, witness, ?_⟩
  have each := safe_raw_partials core summary raw coreSizes safeChecked r vr sr
  intro b hb
  apply (retained_iff b (t b) (inventoryChecked b hb) (encodeBlock b r) ?_).mpr
  · exact ⟨prefix_fixed t inventoryChecked inventorySizes 4 (by decide) s valid b hb, each b hb⟩
  · rw [inventorySizes b hb]
    exact Base5Coverage.encode_range r vr b hb

end Mahjong.CanonicalCoverage

#print axioms Mahjong.CanonicalCoverage.prefix_fixed
#print axioms Mahjong.CanonicalCoverage.prefix_witness
#print axioms Mahjong.CanonicalCoverage.retained_orbit_injective
#print axioms Mahjong.CanonicalCoverage.every_safe_has_retained_representative
