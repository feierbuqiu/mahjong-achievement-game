import Mahjong.FullSafeData

set_option autoImplicit false

namespace Mahjong.Base5Coverage
open LocalCacheEncoding

def size (b : Nat) : Nat := if b = 3 then 78125 else 1953125

theorem encode_mono (b : Nat) (s t : State) (bound : Contains s t) :
    encodeBlock b s ≤ encodeBlock b t := by
  have go (xs : List Tile) (a c : Nat) (ac : a ≤ c) :
      xs.foldl (fun v u => if u.val / 9 = b then v + s u * powers[u.val % 9]! else v) a ≤
      xs.foldl (fun v u => if u.val / 9 = b then v + t u * powers[u.val % 9]! else v) c := by
    induction xs generalizing a c with
    | nil => exact ac
    | cons u xs ih =>
      simp only [List.foldl_cons]
      apply ih
      split
      · exact Nat.add_le_add ac (Nat.mul_le_mul_right _ (bound u))
      · exact ac
  exact go allTiles 0 0 (Nat.le_refl _)

theorem encode_range (s : State) (valid : Valid s) (b : Nat) (hb : b < 4) :
    encodeBlock b s < size b := by
  have bound := encode_mono b s full valid
  have top : encodeBlock b full < size b := by
    have choices : b = 0 ∨ b = 1 ∨ b = 2 ∨ b = 3 := by omega
    rcases choices with rfl | rfl | rfl | rfl <;> decide
  exact Nat.lt_of_le_of_lt bound top

theorem encode_weighted (b : Nat) (s : State) :
    encodeBlock b s = allTiles.foldl
      (fun v u => if u.val / 9 = b then v + powers[u.val % 9]! * s u else v) 0 := by
  apply congrArg (fun f : Nat → Tile → Nat => allTiles.foldl f 0)
  funext v u
  split <;> simp only [Nat.mul_comm]

theorem encode0_eq (s : State) : encodeBlock 0 s = 0 + 1 * s 0 + 5 * s 1 + 25 * s 2 + 125 * s 3 + 625 * s 4 + 3125 * s 5 + 15625 * s 6 + 78125 * s 7 + 390625 * s 8 := by
  rw [encode_weighted]
  rfl

theorem encode1_eq (s : State) : encodeBlock 1 s = 0 + 1 * s 9 + 5 * s 10 + 25 * s 11 + 125 * s 12 + 625 * s 13 + 3125 * s 14 + 15625 * s 15 + 78125 * s 16 + 390625 * s 17 := by
  rw [encode_weighted]
  rfl

theorem encode2_eq (s : State) : encodeBlock 2 s = 0 + 1 * s 18 + 5 * s 19 + 25 * s 20 + 125 * s 21 + 625 * s 22 + 3125 * s 23 + 15625 * s 24 + 78125 * s 25 + 390625 * s 26 := by
  rw [encode_weighted]
  rfl

theorem encode3_eq (s : State) : encodeBlock 3 s = 0 + 1 * s 27 + 5 * s 28 + 25 * s 29 + 125 * s 30 + 625 * s 31 + 3125 * s 32 + 15625 * s 33 := by
  rw [encode_weighted]
  rfl

theorem digits9 (d0 : Nat) (d1 : Nat) (d2 : Nat) (d3 : Nat) (d4 : Nat) (d5 : Nat) (d6 : Nat) (d7 : Nat) (d8 : Nat)
    (h0 : d0 ≤ 4) (h1 : d1 ≤ 4) (h2 : d2 ≤ 4) (h3 : d3 ≤ 4) (h4 : d4 ≤ 4) (h5 : d5 ≤ 4) (h6 : d6 ≤ 4) (h7 : d7 ≤ 4) (h8 : d8 ≤ 4) :
    let code := 0 + 1 * d0 + 5 * d1 + 25 * d2 + 125 * d3 + 625 * d4 + 3125 * d5 + 15625 * d6 + 78125 * d7 + 390625 * d8
    code / 1 % 5 = d0 ∧
    code / 5 % 5 = d1 ∧
    code / 25 % 5 = d2 ∧
    code / 125 % 5 = d3 ∧
    code / 625 % 5 = d4 ∧
    code / 3125 % 5 = d5 ∧
    code / 15625 % 5 = d6 ∧
    code / 78125 % 5 = d7 ∧
    code / 390625 % 5 = d8 := by
  dsimp only
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_, ?_, ?_, ?_⟩ <;> omega

theorem decode_digit (b code : Nat) (u : Tile) (block : u.val / 9 = b) :
    decodeBlock b code u = code / powers[u.val % 9]! % 5 := by
  have bound : u.val % 9 < powers.size := Nat.mod_lt _ (by decide : 0 < 9)
  unfold decodeBlock
  rw [if_pos block, getElem!_pos _ _ (by simpa only [Array.size_map] using bound), Array.getElem_map]
  rw [getElem!_pos powers _ bound]

theorem decode_encode_same (s : State) (valid : Valid s) (b : Nat) :
    MaskedLocalBound.SameBlock b (decodeBlock b (encodeBlock b s)) s := by
  have digits0 := digits9 (s 0) (s 1) (s 2) (s 3) (s 4) (s 5) (s 6) (s 7) (s 8) (valid 0) (valid 1) (valid 2) (valid 3) (valid 4) (valid 5) (valid 6) (valid 7) (valid 8)
  have digits1 := digits9 (s 9) (s 10) (s 11) (s 12) (s 13) (s 14) (s 15) (s 16) (s 17) (valid 9) (valid 10) (valid 11) (valid 12) (valid 13) (valid 14) (valid 15) (valid 16) (valid 17)
  have digits2 := digits9 (s 18) (s 19) (s 20) (s 21) (s 22) (s 23) (s 24) (s 25) (s 26) (valid 18) (valid 19) (valid 20) (valid 21) (valid 22) (valid 23) (valid 24) (valid 25) (valid 26)
  have digits3 := digits9 (s 27) (s 28) (s 29) (s 30) (s 31) (s 32) (s 33) 0 0 (valid 27) (valid 28) (valid 29) (valid 30) (valid 31) (valid 32) (valid 33) (by decide) (by decide)
  simp only [Nat.mul_zero, Nat.add_zero] at digits3
  intro u hu
  have choices := mem_allTiles u
  simp only [allTiles, List.mem_cons, List.not_mem_nil, or_false] at choices
  rcases choices with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
  · have eq : b = 0 := hu.symm.trans (by decide)
    rw [eq, decode_digit 0 _ 0 (by decide)]
    have power : powers[(0 : Tile).val % 9]! = 1 := by decide
    rw [power, encode0_eq]
    exact digits0.1
  · have eq : b = 0 := hu.symm.trans (by decide)
    rw [eq, decode_digit 0 _ 1 (by decide)]
    have power : powers[(1 : Tile).val % 9]! = 5 := by decide
    rw [power, encode0_eq]
    exact digits0.2.1
  · have eq : b = 0 := hu.symm.trans (by decide)
    rw [eq, decode_digit 0 _ 2 (by decide)]
    have power : powers[(2 : Tile).val % 9]! = 25 := by decide
    rw [power, encode0_eq]
    exact digits0.2.2.1
  · have eq : b = 0 := hu.symm.trans (by decide)
    rw [eq, decode_digit 0 _ 3 (by decide)]
    have power : powers[(3 : Tile).val % 9]! = 125 := by decide
    rw [power, encode0_eq]
    exact digits0.2.2.2.1
  · have eq : b = 0 := hu.symm.trans (by decide)
    rw [eq, decode_digit 0 _ 4 (by decide)]
    have power : powers[(4 : Tile).val % 9]! = 625 := by decide
    rw [power, encode0_eq]
    exact digits0.2.2.2.2.1
  · have eq : b = 0 := hu.symm.trans (by decide)
    rw [eq, decode_digit 0 _ 5 (by decide)]
    have power : powers[(5 : Tile).val % 9]! = 3125 := by decide
    rw [power, encode0_eq]
    exact digits0.2.2.2.2.2.1
  · have eq : b = 0 := hu.symm.trans (by decide)
    rw [eq, decode_digit 0 _ 6 (by decide)]
    have power : powers[(6 : Tile).val % 9]! = 15625 := by decide
    rw [power, encode0_eq]
    exact digits0.2.2.2.2.2.2.1
  · have eq : b = 0 := hu.symm.trans (by decide)
    rw [eq, decode_digit 0 _ 7 (by decide)]
    have power : powers[(7 : Tile).val % 9]! = 78125 := by decide
    rw [power, encode0_eq]
    exact digits0.2.2.2.2.2.2.2.1
  · have eq : b = 0 := hu.symm.trans (by decide)
    rw [eq, decode_digit 0 _ 8 (by decide)]
    have power : powers[(8 : Tile).val % 9]! = 390625 := by decide
    rw [power, encode0_eq]
    exact digits0.2.2.2.2.2.2.2.2
  · have eq : b = 1 := hu.symm.trans (by decide)
    rw [eq, decode_digit 1 _ 9 (by decide)]
    have power : powers[(9 : Tile).val % 9]! = 1 := by decide
    rw [power, encode1_eq]
    exact digits1.1
  · have eq : b = 1 := hu.symm.trans (by decide)
    rw [eq, decode_digit 1 _ 10 (by decide)]
    have power : powers[(10 : Tile).val % 9]! = 5 := by decide
    rw [power, encode1_eq]
    exact digits1.2.1
  · have eq : b = 1 := hu.symm.trans (by decide)
    rw [eq, decode_digit 1 _ 11 (by decide)]
    have power : powers[(11 : Tile).val % 9]! = 25 := by decide
    rw [power, encode1_eq]
    exact digits1.2.2.1
  · have eq : b = 1 := hu.symm.trans (by decide)
    rw [eq, decode_digit 1 _ 12 (by decide)]
    have power : powers[(12 : Tile).val % 9]! = 125 := by decide
    rw [power, encode1_eq]
    exact digits1.2.2.2.1
  · have eq : b = 1 := hu.symm.trans (by decide)
    rw [eq, decode_digit 1 _ 13 (by decide)]
    have power : powers[(13 : Tile).val % 9]! = 625 := by decide
    rw [power, encode1_eq]
    exact digits1.2.2.2.2.1
  · have eq : b = 1 := hu.symm.trans (by decide)
    rw [eq, decode_digit 1 _ 14 (by decide)]
    have power : powers[(14 : Tile).val % 9]! = 3125 := by decide
    rw [power, encode1_eq]
    exact digits1.2.2.2.2.2.1
  · have eq : b = 1 := hu.symm.trans (by decide)
    rw [eq, decode_digit 1 _ 15 (by decide)]
    have power : powers[(15 : Tile).val % 9]! = 15625 := by decide
    rw [power, encode1_eq]
    exact digits1.2.2.2.2.2.2.1
  · have eq : b = 1 := hu.symm.trans (by decide)
    rw [eq, decode_digit 1 _ 16 (by decide)]
    have power : powers[(16 : Tile).val % 9]! = 78125 := by decide
    rw [power, encode1_eq]
    exact digits1.2.2.2.2.2.2.2.1
  · have eq : b = 1 := hu.symm.trans (by decide)
    rw [eq, decode_digit 1 _ 17 (by decide)]
    have power : powers[(17 : Tile).val % 9]! = 390625 := by decide
    rw [power, encode1_eq]
    exact digits1.2.2.2.2.2.2.2.2
  · have eq : b = 2 := hu.symm.trans (by decide)
    rw [eq, decode_digit 2 _ 18 (by decide)]
    have power : powers[(18 : Tile).val % 9]! = 1 := by decide
    rw [power, encode2_eq]
    exact digits2.1
  · have eq : b = 2 := hu.symm.trans (by decide)
    rw [eq, decode_digit 2 _ 19 (by decide)]
    have power : powers[(19 : Tile).val % 9]! = 5 := by decide
    rw [power, encode2_eq]
    exact digits2.2.1
  · have eq : b = 2 := hu.symm.trans (by decide)
    rw [eq, decode_digit 2 _ 20 (by decide)]
    have power : powers[(20 : Tile).val % 9]! = 25 := by decide
    rw [power, encode2_eq]
    exact digits2.2.2.1
  · have eq : b = 2 := hu.symm.trans (by decide)
    rw [eq, decode_digit 2 _ 21 (by decide)]
    have power : powers[(21 : Tile).val % 9]! = 125 := by decide
    rw [power, encode2_eq]
    exact digits2.2.2.2.1
  · have eq : b = 2 := hu.symm.trans (by decide)
    rw [eq, decode_digit 2 _ 22 (by decide)]
    have power : powers[(22 : Tile).val % 9]! = 625 := by decide
    rw [power, encode2_eq]
    exact digits2.2.2.2.2.1
  · have eq : b = 2 := hu.symm.trans (by decide)
    rw [eq, decode_digit 2 _ 23 (by decide)]
    have power : powers[(23 : Tile).val % 9]! = 3125 := by decide
    rw [power, encode2_eq]
    exact digits2.2.2.2.2.2.1
  · have eq : b = 2 := hu.symm.trans (by decide)
    rw [eq, decode_digit 2 _ 24 (by decide)]
    have power : powers[(24 : Tile).val % 9]! = 15625 := by decide
    rw [power, encode2_eq]
    exact digits2.2.2.2.2.2.2.1
  · have eq : b = 2 := hu.symm.trans (by decide)
    rw [eq, decode_digit 2 _ 25 (by decide)]
    have power : powers[(25 : Tile).val % 9]! = 78125 := by decide
    rw [power, encode2_eq]
    exact digits2.2.2.2.2.2.2.2.1
  · have eq : b = 2 := hu.symm.trans (by decide)
    rw [eq, decode_digit 2 _ 26 (by decide)]
    have power : powers[(26 : Tile).val % 9]! = 390625 := by decide
    rw [power, encode2_eq]
    exact digits2.2.2.2.2.2.2.2.2
  · have eq : b = 3 := hu.symm.trans (by decide)
    rw [eq, decode_digit 3 _ 27 (by decide)]
    have power : powers[(27 : Tile).val % 9]! = 1 := by decide
    rw [power, encode3_eq]
    exact digits3.1
  · have eq : b = 3 := hu.symm.trans (by decide)
    rw [eq, decode_digit 3 _ 28 (by decide)]
    have power : powers[(28 : Tile).val % 9]! = 5 := by decide
    rw [power, encode3_eq]
    exact digits3.2.1
  · have eq : b = 3 := hu.symm.trans (by decide)
    rw [eq, decode_digit 3 _ 29 (by decide)]
    have power : powers[(29 : Tile).val % 9]! = 25 := by decide
    rw [power, encode3_eq]
    exact digits3.2.2.1
  · have eq : b = 3 := hu.symm.trans (by decide)
    rw [eq, decode_digit 3 _ 30 (by decide)]
    have power : powers[(30 : Tile).val % 9]! = 125 := by decide
    rw [power, encode3_eq]
    exact digits3.2.2.2.1
  · have eq : b = 3 := hu.symm.trans (by decide)
    rw [eq, decode_digit 3 _ 31 (by decide)]
    have power : powers[(31 : Tile).val % 9]! = 625 := by decide
    rw [power, encode3_eq]
    exact digits3.2.2.2.2.1
  · have eq : b = 3 := hu.symm.trans (by decide)
    rw [eq, decode_digit 3 _ 32 (by decide)]
    have power : powers[(32 : Tile).val % 9]! = 3125 := by decide
    rw [power, encode3_eq]
    exact digits3.2.2.2.2.2.1
  · have eq : b = 3 := hu.symm.trans (by decide)
    rw [eq, decode_digit 3 _ 33 (by decide)]
    have power : powers[(33 : Tile).val % 9]! = 15625 := by decide
    rw [power, encode3_eq]
    exact digits3.2.2.2.2.2.2.1

def pack (s : State) : PackedRules.Packed :=
  ⟨encodeBlock 0 s, encodeBlock 1 s, encodeBlock 2 s, encodeBlock 3 s⟩

def unpack (p : PackedRules.Packed) : State :=
  fun u => decodeBlock (u.val / 9) (p.get (u.val / 9)) u

theorem get_four (f : Nat → Nat) (b : Nat) (hb : b < 4) :
    (PackedRules.Packed.mk (f 0) (f 1) (f 2) (f 3)).get b = f b := by
  have choices : b = 0 ∨ b = 1 ∨ b = 2 ∨ b = 3 := by omega
  rcases choices with rfl | rfl | rfl | rfl <;> rfl

theorem pack_get (s : State) (b : Nat) (hb : b < 4) :
    (pack s).get b = encodeBlock b s := get_four (fun k => encodeBlock k s) b hb

/-- All 34 tile counts, including saturated count four, are recovered. -/
theorem unpack_pack (s : State) (valid : Valid s) : unpack (pack s) = s := by
  funext u
  have hb : u.val / 9 < 4 := by have hu := u.isLt; omega
  unfold unpack
  rw [pack_get s _ hb]
  exact decode_encode_same s valid _ u rfl

theorem pack_injective (s t : State) (vs : Valid s) (vt : Valid t)
    (equal : pack s = pack t) : s = t := by
  have h := congrArg unpack equal
  rwa [unpack_pack s vs, unpack_pack t vt] at h

def tables (core summary raw : Nat → ByteArray) : FullSafeData.Tables :=
  fun b => PruningData.candidate b (core b) (summary b) (raw b)

def ProperSizes (core : Nat → ByteArray) : Prop := ∀ b, b < 4 → (core b).size = size b

theorem pack_inside (core summary raw : Nat → ByteArray) (sizes : ProperSizes core)
    (s : State) (valid : Valid s) :
    PackedRules.inside (FullSafeData.summaries (tables core summary raw)) (pack s) = true := by
  apply List.all_eq_true.mpr
  intro b hb
  have choices : b = 0 ∨ b = 1 ∨ b = 2 ∨ b = 3 := by simpa using hb
  have range : b < 4 := by omega
  apply decide_eq_true
  change (pack s).get b < (core b).size
  rw [pack_get s b range, sizes b range]
  exact encode_range s valid b range

theorem packed_state_eq (core summary raw : Nat → ByteArray) (s : State) (valid : Valid s) :
    PackedRules.state (FullSafeData.summaries (tables core summary raw)) (pack s) = s :=
  unpack_pack s valid

/-- Full predicate correctness for EVERY original valid state. The only data
premises are finite local checks and input sizes; there is no assumed global
directory coverage, SAFE layer bound, or P/N table correctness. -/
theorem checked_filter_on_every_valid_state (core summary raw : Nat → ByteArray)
    (sizes : ProperSizes core) (checked : FullSafeData.Checked (tables core summary raw))
    (s : State) (valid : Valid s) :
    PruningAlgebra.fullSafe (FullSafeData.allRaw (tables core summary raw) (pack s)) ↔ IsSafe s := by
  have h := FullSafeData.checked_full_filter_iff_safe (tables core summary raw) checked (pack s)
    (pack_inside core summary raw sizes s valid)
  rwa [packed_state_eq core summary raw s valid] at h

end Mahjong.Base5Coverage

#print axioms Mahjong.Base5Coverage.encode_range

#print axioms Mahjong.Base5Coverage.decode_encode_same
#print axioms Mahjong.Base5Coverage.unpack_pack
#print axioms Mahjong.Base5Coverage.pack_injective
#print axioms Mahjong.Base5Coverage.checked_filter_on_every_valid_state
