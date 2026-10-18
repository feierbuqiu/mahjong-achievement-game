import Mahjong.SuitSorting
import Mahjong.GroupInventory

set_option autoImplicit false

namespace Mahjong.SortedCoverage
open CanonicalCoverage CanonicalInventory LocalCacheEncoding Base5Coverage SuitSorting Generators

def SharedMembers (t : Inventories) : Prop :=
  ∀ b, b < 3 → (t b).member = (t 0).member ∧ (t b).count = (t 0).count

theorem shared_of_same_files (raw ids members : Nat → ByteArray)
    (same : ∀ b, b < 3 → members b = members 0) : SharedMembers (inventories raw ids members) := by
  intro b hb
  constructor <;> simp only [inventories, CanonicalInventory.candidate, same b hb]

def Retained (t : Inventories) (p : PackedRules.Packed) : Prop :=
  ∀ b, b < 4 → ∃ k, k < (t b).count ∧ (t b).member k = p.get b

theorem sort_retained (t : Inventories) (shared : SharedMembers t)
    (p : PackedRules.Packed) (key : Nat → Nat) (kept : Retained t p) : Retained t (SuitSorting.sort key p) := by
  have initial : ∀ b, b < 3 → ∃ k, k < (t 0).count ∧ (t 0).member k = p.get b := by
    intro b hb
    obtain ⟨k, hk, eq⟩ := kept b (by omega)
    rw [(shared b hb).1] at eq
    rw [(shared b hb).2] at hk
    exact ⟨k, hk, eq⟩
  have after := sort_preserves key p (fun code => ∃ k, k < (t 0).count ∧ (t 0).member k = code) initial
  intro b hb
  by_cases hon : b = 3
  · subst b
    change ∃ k, k < (t 3).count ∧ (t 3).member k = (SuitSorting.sort key p).h
    rw [sort_honor]
    exact kept 3 (by decide)
  · have small : b < 3 := by omega
    rw [(shared b small).1, (shared b small).2]
    exact after b small

theorem retained_inside (t : Inventories) (checked : CanonicalCoverage.Checked t)
    (p : PackedRules.Packed) (kept : Retained t p) (b : Nat) (hb : b < 4) : p.get b < (t b).size := by
  obtain ⟨k, hk, eq⟩ := kept b hb
  have inside := (checked_member b (t b) (checked b hb) k hk).1
  rwa [eq] at inside

theorem sort_representative (t : Inventories) (checked : CanonicalCoverage.Checked t) (shared : SharedMembers t)
    (s : State) (valid : Valid s) (safe : IsSafe s)
    (kept : ∀ b, b < 4 → ∃ k, k < (t b).count ∧ (t b).member k = encodeBlock b s) :
    ∃ r : State, ∃ path : List Generator,
      Valid r ∧ IsSafe r ∧ r = applyPath path s ∧
      (∀ b, b < 4 → ∃ k, k < (t b).count ∧ (t b).member k = encodeBlock b r) ∧
      (t 0).id (encodeBlock 0 r) ≤ (t 0).id (encodeBlock 1 r) ∧
      (t 0).id (encodeBlock 1 r) ≤ (t 0).id (encodeBlock 2 r) := by
  let p := pack s
  let q := SuitSorting.sort (t 0).id p
  have pkept : Retained t p := by
    intro b hb
    rw [pack_get s b hb]
    exact kept b hb
  have qkept := sort_retained t shared p (t 0).id pkept
  obtain ⟨path, witness⟩ := sort_path (t 0).id p
  have eq : unpack q = applyPath path s := by
    rw [unpack_pack s valid] at witness
    exact witness
  have vr : Valid (unpack q) := by rw [eq]; exact LocalSymmetryFrame.path_valid path s valid
  have sr : IsSafe (unpack q) := by rw [eq]; exact (LocalSymmetryFrame.path_safe_iff path s).mpr safe
  have code (b : Nat) (hb : b < 4) : encodeBlock b (unpack q) = q.get b :=
    encode_unpacked q b (t b) (checked b hb) (retained_inside t checked q qkept b hb)
  refine ⟨unpack q, path, vr, sr, eq, ?_, ?_⟩
  · intro b hb
    rw [code b hb]
    exact qkept b hb
  · rw [code 0 (by decide), code 1 (by decide), code 2 (by decide)]
    exact sorted_order (t 0).id p

/-- Original SAFE coverage with the production member-ID order imposed on the
three numeric suits. Neither directory coverage nor the 34-layer cutoff is a premise. -/
theorem every_safe_sorted_representative (core summary raw ids members : Nat → ByteArray)
    (coreSizes : Base5Coverage.ProperSizes core)
    (safeChecked : FullSafeData.Checked (Base5Coverage.tables core summary raw))
    (inventorySizes : CanonicalCoverage.ProperSizes (inventories raw ids members))
    (inventoryChecked : CanonicalCoverage.Checked (inventories raw ids members))
    (shared : SharedMembers (inventories raw ids members))
    (s : State) (valid : Valid s) (safe : IsSafe s) :
    ∃ r : State, ∃ path : List Generator,
      Valid r ∧ IsSafe r ∧ r = applyPath path s ∧
      (∀ b, b < 4 → ∃ k, k < (inventories raw ids members b).count ∧
        (inventories raw ids members b).member k = encodeBlock b r) ∧
      (inventories raw ids members 0).id (encodeBlock 0 r) ≤ (inventories raw ids members 0).id (encodeBlock 1 r) ∧
      (inventories raw ids members 0).id (encodeBlock 1 r) ≤ (inventories raw ids members 0).id (encodeBlock 2 r) := by
  obtain ⟨r, path, vr, sr, eq, kept⟩ := every_safe_has_retained_representative core summary raw ids members
    coreSizes safeChecked inventorySizes inventoryChecked s valid safe
  obtain ⟨u, more, vu, su, next, stored, order⟩ :=
    sort_representative _ inventoryChecked shared r vr sr kept
  refine ⟨u, path ++ more, vu, su, ?_, stored, order⟩
  rw [path_append, ← eq]
  exact next

end Mahjong.SortedCoverage

#print axioms Mahjong.SortedCoverage.shared_of_same_files
#print axioms Mahjong.SortedCoverage.sort_retained
#print axioms Mahjong.SortedCoverage.every_safe_sorted_representative
