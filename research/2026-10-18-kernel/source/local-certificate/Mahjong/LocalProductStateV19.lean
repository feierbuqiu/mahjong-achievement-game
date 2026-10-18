import Mahjong.LocalBlockSoundnessV19
import Mahjong.GroupProductStateV19
import Mahjong.PadTensorV19

set_option autoImplicit false

/-! A Cartesian superset representation of the actual 34-kind SAFE game.
Equal numeric groups retain all ordered member tuples. No historical C++
P/N bits, colex rank, symmetry of proposed labels, or row-correctness Prop is
assumed. The next-layer TargetCorrect premise is explicitly inductive. -/

namespace Mahjong.LocalProductStateV19

open PackedRules GeneralLayer CachedPackedCheck SafeGame Generators
open CanonicalCoverage GlobalOrbitUniqueness BlockPlanCheck LocalBlockSoundnessV19
open BlockPlanSoundness (codes Inside AtContext)

abbrev Block := GroupProductStateV19.Block

def widthA (c : LocalCertificateV19.GroupedCertificate) (block : Block) : Nat := c.groups.size block.key.1
def widthB (c : LocalCertificateV19.GroupedCertificate) (block : Block) : Nat := c.groups.size block.key.2.1
def widthC (c : LocalCertificateV19.GroupedCertificate) (block : Block) : Nat := c.groups.size block.key.2.2
def size (c : LocalCertificateV19.GroupedCertificate) (block : Block) : Nat := widthA c block * widthB c block * widthC c block

def ids (c : LocalCertificateV19.GroupedCertificate) (block : Block) (x y z : Nat) : Packed :=
  ⟨c.groups.first block.key.1+x, c.groups.first block.key.2.1+y,
    c.groups.first block.key.2.2+z, (inventoriesOf c 3).member block.honor⟩

def packed (c : LocalCertificateV19.GroupedCertificate) (block : Block) (x y z : Nat) : Packed :=
  codes c.groups (ids c block x y z)

def originalState (c : LocalCertificateV19.GroupedCertificate) (block : Block) (x y z : Nat) : State :=
  Base5Coverage.unpack (packed c block x y z)

def rawLabel (c : LocalCertificateV19.GroupedCertificate) (block : Block) : PruningAlgebra.Label :=
  PruningAlgebra.join (PruningAlgebra.join (PruningAlgebra.join
    (c.groups.label block.key.1) (c.groups.label block.key.2.1)) (c.groups.label block.key.2.2))
      (PruningData.rawLabel (c.raw 3) ((inventoriesOf c 3).member block.honor))

def checkBlock (c : LocalCertificateV19.GroupedCertificate) (block : Block) : Bool :=
  decide (block.key.1 < c.groups.groups ∧ block.key.2.1 < c.groups.groups ∧
    block.key.2.2 < c.groups.groups ∧ block.key.1 ≤ block.key.2.1 ∧
    block.key.2.1 ≤ block.key.2.2 ∧ block.honor < (inventoriesOf c 3).count) &&
    decide (PruningAlgebra.fullSafe (rawLabel c block))

theorem block_parts (c : LocalCertificateV19.GroupedCertificate) (block : Block) (checked : checkBlock c block = true) :
    (block.key.1 < c.groups.groups ∧ block.key.2.1 < c.groups.groups ∧
      block.key.2.2 < c.groups.groups ∧ block.key.1 ≤ block.key.2.1 ∧
      block.key.2.1 ≤ block.key.2.2 ∧ block.honor < (inventoriesOf c 3).count) ∧
    PruningAlgebra.fullSafe (rawLabel c block) := by
  simpa only [checkBlock, Bool.and_eq_true, decide_eq_true_eq] using checked

theorem ids_facts (c : LocalCertificateV19.GroupedCertificate) (block : Block)
    (groups : block.key.1 < c.groups.groups ∧ block.key.2.1 < c.groups.groups ∧ block.key.2.2 < c.groups.groups)
    (x y z : Nat) (hx : x < widthA c block) (hy : y < widthB c block) (hz : z < widthC c block) :
    Inside c.groups (ids c block x y z) ∧
      c.groups.group (ids c block x y z).a = block.key.1 ∧
      c.groups.group (ids c block x y z).b = block.key.2.1 ∧
      c.groups.group (ids c block x y z).c = block.key.2.2 := by
  have a := GroupInventory.coordinate_inverse c.groups c.groupChecked block.key.1 x groups.1 hx
  have b := GroupInventory.coordinate_inverse c.groups c.groupChecked block.key.2.1 y groups.2.1 hy
  have cc := GroupInventory.coordinate_inverse c.groups c.groupChecked block.key.2.2 z groups.2.2 hz
  exact ⟨⟨a.1,b.1,cc.1⟩,a.2.1,b.2.1,cc.2.1⟩

theorem rawLabel_at (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (block : Block)
    (groups : block.key.1 < c.groups.groups ∧ block.key.2.1 < c.groups.groups ∧ block.key.2.2 < c.groups.groups)
    (x y z : Nat) (hx : x < widthA c block) (hy : y < widthB c block) (hz : z < widthC c block) :
    FullSafeData.allRaw (ofCertificate c data).rules (packed c block x y z) = rawLabel c block := by
  have facts := ids_facts c block groups x y z hx hy hz
  rw [packed, raw_of_ids c data _ facts.1, facts.2.1, facts.2.2.1, facts.2.2.2]
  rfl

/-- A single finite group-label SAFE check covers every Cartesian coordinate,
including equal-group tuples whose member IDs are not sorted. -/
theorem product_initial (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (block : Block)
    (checked : checkBlock c block = true) (x y z : Nat)
    (hx : x < widthA c block) (hy : y < widthB c block) (hz : z < widthC c block) :
    CachedPackedCheck.initial (ofCertificate c data) (packed c block x y z) = true := by
  have parts := block_parts c block checked
  have groups : block.key.1 < c.groups.groups ∧ block.key.2.1 < c.groups.groups ∧ block.key.2.2 < c.groups.groups :=
    ⟨parts.1.1, parts.1.2.1, parts.1.2.2.1⟩
  have facts := ids_facts c block groups x y z hx hy hz
  have honor : ∃ h, h < (inventoriesOf c 3).count ∧ (inventoriesOf c 3).member h = (ids c block x y z).h :=
    ⟨block.honor,parts.1.2.2.2.2.2,rfl⟩
  have inside := codes_inside c data _ facts.1 honor
  have retained := codes_retainedB c data _ facts.1 honor
  have safe : CachedPackedCheck.safeB (ofCertificate c data) (packed c block x y z) = true := by
    change (PackedRules.inside _ _ && decide (PruningAlgebra.fullSafe (FullSafeData.allRaw _ _))) = true
    rw [show PackedRules.inside (FullSafeData.summaries (ofCertificate c data).rules) (packed c block x y z) = true from inside,
      Bool.true_and, rawLabel_at c data block groups x y z hx hy hz]
    exact decide_eq_true parts.2
  change (PackedRules.inside _ _ && retainedB _ _ && CachedPackedCheck.safeB _ _) = true
  simp only [show PackedRules.inside (FullSafeData.summaries (ofCertificate c data).rules) (packed c block x y z) = true from inside,
    show retainedB (ofCertificate c data) (packed c block x y z) = true from retained, safe, Bool.and_self]

theorem product_safe (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (block : Block)
    (checked : checkBlock c block = true) (x y z : Nat)
    (hx : x < widthA c block) (hy : y < widthB c block) (hz : z < widthC c block) :
    IsSafe (originalState c block x y z) :=
  (LocalCertificateV19.Cached.initial_facts c.toCertificate data _ (product_initial c data block checked x y z hx hy hz)).2.2

def rank (c : LocalCertificateV19.GroupedCertificate) (block : Block) (x y z : Nat) : Nat :=
  PadTensorV19.rawIndex (widthA c block) (widthB c block) x y z

def unrank (c : LocalCertificateV19.GroupedCertificate) (block : Block) (r : Nat) : Packed :=
  packed c block (r % widthA c block) ((r / widthA c block) % widthB c block)
    (r / (widthA c block * widthB c block))

theorem rank_bound (c : LocalCertificateV19.GroupedCertificate) (block : Block) (x y z : Nat)
    (hx : x < widthA c block) (hy : y < widthB c block) (hz : z < widthC c block) :
    rank c block x y z < size c block := PadTensorV19.rawIndex_bound _ _ _ _ _ _ hx hy hz

theorem unrank_at (c : LocalCertificateV19.GroupedCertificate) (block : Block) (x y z : Nat)
    (hx : x < widthA c block) (hy : y < widthB c block) :
    unrank c block (rank c block x y z) = packed c block x y z := by
  have positiveA : 0 < widthA c block := by omega
  have positiveB : 0 < widthB c block := by omega
  have divideA : rank c block x y z / widthA c block = widthB c block*z+y := by
    simp only [rank, PadTensorV19.rawIndex, Nat.mul_add_div positiveA, Nat.div_eq_of_lt hx, Nat.add_zero]
  have modulusA : rank c block x y z % widthA c block = x := by
    simp only [rank, PadTensorV19.rawIndex, Nat.mul_add_mod, Nat.mod_eq_of_lt hx]
  have divideB : (widthB c block*z+y) / widthB c block = z := by
    rw [Nat.mul_add_div positiveB, Nat.div_eq_of_lt hy, Nat.add_zero]
  have modulusB : (widthB c block*z+y) % widthB c block = y := by
    rw [Nat.mul_add_mod, Nat.mod_eq_of_lt hy]
  rw [unrank, modulusA, divideA, modulusB, ← Nat.div_div_eq_div_mul, divideA, divideB]

def blockOf (c : LocalCertificateV19.GroupedCertificate) (p : Packed) : Block :=
  ⟨(c.groups.group p.a,c.groups.group p.b,c.groups.group p.c), (inventoriesOf c 3).id p.h⟩

theorem rebuild (c : LocalCertificateV19.GroupedCertificate) (p : Packed) (ip : Inside c.groups p)
    (honor : ∃ h, h < (inventoriesOf c 3).count ∧ (inventoriesOf c 3).member h = p.h) :
    packed c (blockOf c p) (c.groups.member p.a) (c.groups.member p.b) (c.groups.member p.c) = codes c.groups p := by
  obtain ⟨h,hh,heq⟩ := honor
  have reverse := (CanonicalInventory.checked_member 3 (inventoriesOf c 3) (c.inventoryChecked 3 (by decide)) h hh).2
  have a := (GroupInventory.member_facts c.groups c.groupChecked p.a ip.1).offset
  have b := (GroupInventory.member_facts c.groups c.groupChecked p.b ip.2.1).offset
  have cc := (GroupInventory.member_facts c.groups c.groupChecked p.c ip.2.2).offset
  dsimp only [packed, blockOf, ids]
  rw [←a,←b,←cc,←heq,reverse,heq]

def normalizeIds (c : LocalCertificateV19.GroupedCertificate) (p : Packed) : Packed := SuitSorting.sort c.groups.group p

theorem normalize_inside (c : LocalCertificateV19.GroupedCertificate) (p : Packed) (ip : Inside c.groups p) :
    Inside c.groups (normalizeIds c p) := by
  have bounds : ∀ axis, axis < 3 → p.get axis < c.groups.count := by
    intro axis ha
    have choices : axis=0 ∨ axis=1 ∨ axis=2 := by omega
    rcases choices with rfl | rfl | rfl
    · exact ip.1
    · exact ip.2.1
    · exact ip.2.2
  have result := SuitSorting.sort_preserves c.groups.group p (fun i => i<c.groups.count) bounds
  exact ⟨result 0 (by decide),result 1 (by decide),result 2 (by decide)⟩

theorem mapped_compare_path (f key : Nat → Nat) (p : Packed) (a b : Fin 3) :
    ∃ path, Base5Coverage.unpack (MovePlanRefinement.mapNumeric f (SuitSorting.compareSwap key a b p)) =
      applyPath path (Base5Coverage.unpack (MovePlanRefinement.mapNumeric f p)) := by
  unfold SuitSorting.compareSwap
  split
  · exact ⟨[.swapSuits a b],by rw [MovePlanRefinement.map_swap]; exact SuitSorting.swapped_state a b _⟩
  · exact ⟨[],rfl⟩

theorem mapped_sort_path (f key : Nat → Nat) (p : Packed) :
    ∃ path, Base5Coverage.unpack (MovePlanRefinement.mapNumeric f (SuitSorting.sort key p)) =
      applyPath path (Base5Coverage.unpack (MovePlanRefinement.mapNumeric f p)) := by
  obtain ⟨a,ha⟩ := mapped_compare_path f key p 0 1
  obtain ⟨b,hb⟩ := mapped_compare_path f key (SuitSorting.compareSwap key 0 1 p) 1 2
  obtain ⟨cc,hc⟩ := mapped_compare_path f key (SuitSorting.compareSwap key 1 2 (SuitSorting.compareSwap key 0 1 p)) 0 1
  refine ⟨a++b++cc,?_⟩
  rw [CanonicalCoverage.path_append,CanonicalCoverage.path_append,← ha,← hb]
  exact hc

/-- Stable sorting by group, rather than by member ID, is sufficient. Ties
never impose an order on member IDs and can represent repeated physical states. -/
theorem normalized_product (c : LocalCertificateV19.GroupedCertificate) (p : Packed) (ip : Inside c.groups p)
    (honor : ∃ h, h < (inventoriesOf c 3).count ∧ (inventoriesOf c 3).member h = p.h) :
    let q := normalizeIds c p
    (blockOf c q).key.1 ≤ (blockOf c q).key.2.1 ∧
      (blockOf c q).key.2.1 ≤ (blockOf c q).key.2.2 ∧
      c.groups.member q.a < widthA c (blockOf c q) ∧
      c.groups.member q.b < widthB c (blockOf c q) ∧
      c.groups.member q.c < widthC c (blockOf c q) ∧
      ∃ path, originalState c (blockOf c q) (c.groups.member q.a) (c.groups.member q.b) (c.groups.member q.c) =
        applyPath path (Base5Coverage.unpack (codes c.groups p)) := by
  dsimp only
  have iq := normalize_inside c p ip
  have honorEq : (normalizeIds c p).h = p.h := SuitSorting.sort_honor c.groups.group p
  have honorQ : ∃ h, h < (inventoriesOf c 3).count ∧ (inventoriesOf c 3).member h = (normalizeIds c p).h := by
    rwa [honorEq]
  have order := SuitSorting.sorted_order c.groups.group p
  have a := GroupInventory.member_facts c.groups c.groupChecked (normalizeIds c p).a iq.1
  have b := GroupInventory.member_facts c.groups c.groupChecked (normalizeIds c p).b iq.2.1
  have cc := GroupInventory.member_facts c.groups c.groupChecked (normalizeIds c p).c iq.2.2
  refine ⟨order.1,order.2,a.member,b.member,cc.member,?_⟩
  unfold originalState
  rw [rebuild c _ iq honorQ]
  exact mapped_sort_path c.groups.retained c.groups.group p

/-- Every actual cached local child is represented in the new product space
up to a proved original-game suit permutation, for all four axes and ties. -/
theorem child_product (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data)
    (p : Packed) (ip : Inside c.groups p)
    (honor : ∃ h, h < (inventoriesOf c 3).count ∧ (inventoriesOf c 3).member h = p.h)
    (axis j : Nat) (axisBound : axis < 4)
    (jBound : j < if axis < 3 then c.groups.count else (inventoriesOf c 3).count) :
    let q := normalizeIds c (rawChild (ofCertificate c data) p axis j)
    c.groups.member q.a < widthA c (blockOf c q) ∧
      c.groups.member q.b < widthB c (blockOf c q) ∧
      c.groups.member q.c < widthC c (blockOf c q) ∧
      ∃ path, originalState c (blockOf c q) (c.groups.member q.a) (c.groups.member q.b) (c.groups.member q.c) =
        applyPath path (Base5Coverage.unpack (CachedPackedCheck.replace (ofCertificate c data) (codes c.groups p) axis j)) := by
  have iq := rawChild_inside c.groups (ofCertificate c data) p ip axis j axisBound jBound
  have hq := rawChild_honor c.groups (ofCertificate c data) p honor axis j axisBound jBound
  have result := normalized_product c _ iq hq
  rw [rawChild_codes c data p axis j axisBound]
  exact result.2.2


def groupKeyCode (c : LocalCertificateV19.GroupedCertificate) (code : Nat) : Nat :=
  c.groups.group ((inventoriesOf c 0).id code)

theorem code_group (c : LocalCertificateV19.GroupedCertificate) (i : Nat) (hi : i < c.groups.count) :
    groupKeyCode c (c.groups.retained i) = c.groups.group i := by
  rw [groupKeyCode,id_of_member c 0 (by decide) i hi]

theorem inside_get (c : LocalCertificateV19.GroupedCertificate) (p : Packed) (ip : Inside c.groups p) (axis : Nat) (ha : axis < 3) :
    p.get axis < c.groups.count := by
  have choices : axis=0 ∨ axis=1 ∨ axis=2 := by omega
  rcases choices with rfl | rfl | rfl
  · exact ip.1
  · exact ip.2.1
  · exact ip.2.2

theorem compare_inside (c : LocalCertificateV19.GroupedCertificate) (p : Packed) (ip : Inside c.groups p) (a b : Fin 3) :
    Inside c.groups (SuitSorting.compareSwap c.groups.group a b p) := by
  have facts := SuitSorting.compare_preserves c.groups.group a b p (fun i => i < c.groups.count)
    (inside_get c p ip)
  exact ⟨facts 0 (by decide),facts 1 (by decide),facts 2 (by decide)⟩

theorem compare_codes (c : LocalCertificateV19.GroupedCertificate) (p : Packed) (ip : Inside c.groups p) (a b : Fin 3) :
    codes c.groups (SuitSorting.compareSwap c.groups.group a b p) =
      SuitSorting.compareSwap (groupKeyCode c) a b (codes c.groups p) := by
  have getCode (axis : Fin 3) :
      (codes c.groups p).get axis.val = c.groups.retained (p.get axis.val) := by
    rcases GlobalOrbitKey.fin_three axis with rfl | rfl | rfl <;> rfl
  have ka := code_group c (p.get a.val) (inside_get c p ip a.val a.isLt)
  have kb := code_group c (p.get b.val) (inside_get c p ip b.val b.isLt)
  unfold SuitSorting.compareSwap
  rw [getCode a,getCode b,ka,kb]
  split
  · exact MovePlanRefinement.map_swap c.groups.retained p a b
  · rfl

theorem normalize_codes (c : LocalCertificateV19.GroupedCertificate) (p : Packed) (ip : Inside c.groups p) :
    codes c.groups (normalizeIds c p) = SuitSorting.sort (groupKeyCode c) (codes c.groups p) := by
  have ip1 := compare_inside c p ip 0 1
  have ip2 := compare_inside c _ ip1 1 2
  unfold normalizeIds SuitSorting.sort
  rw [compare_codes c _ ip2 0 1, compare_codes c _ ip1 1 2, compare_codes c p ip 0 1]

def normalize (c : LocalCertificateV19.GroupedCertificate) (s : Packed) : Packed := SuitSorting.sort (groupKeyCode c) s

def reference (c : LocalCertificateV19.GroupedCertificate) (target : Target) (s : Packed) : Reference := target.locate (normalize c s)

def refB (c : LocalCertificateV19.GroupedCertificate) (target : Target) (s : Packed) : Bool :=
  let r := reference c target s
  decide (r.index < target.size r.bucket) && decide (target.unrank r.bucket r.index = normalize c s)

def isP (c : LocalCertificateV19.GroupedCertificate) (target : Target) (s : Packed) : Bool :=
  let r := reference c target s
  target.labelP r.bucket r.index

def idsOfCodes (c : LocalCertificateV19.GroupedCertificate) (s : Packed) : Packed :=
  ⟨(inventoriesOf c 0).id s.a,(inventoriesOf c 0).id s.b,(inventoriesOf c 0).id s.c,s.h⟩

theorem idsOfCodes_codes (c : LocalCertificateV19.GroupedCertificate) (p : Packed) (ip : Inside c.groups p) :
    idsOfCodes c (codes c.groups p) = p := by
  dsimp only [idsOfCodes,codes,MovePlanRefinement.mapNumeric]
  rw [id_of_member c 0 (by decide) p.a ip.1,
    id_of_member c 0 (by decide) p.b ip.2.1,id_of_member c 0 (by decide) p.c ip.2.2]

/-- Each Target bucket here is one complete Cartesian block. Its labels are
bits of a Nat, not materialized bytes. Missing bucket IDs have size zero. -/
def productTarget (c : LocalCertificateV19.GroupedCertificate) (count : Nat) (blocks : Nat → Block) (labels : Nat → Nat)
    (lookup : Block → Nat) : Target where
  size := fun b => if b < count then size c (blocks b) else 0
  unrank := fun b r => unrank c (blocks b) r
  labelP := fun b r => (labels b).testBit r
  locate := fun s =>
    let p := idsOfCodes c s
    let block := blockOf c p
    ⟨lookup block,rank c block (c.groups.member p.a) (c.groups.member p.b) (c.groups.member p.c),s,[]⟩

def checkLookup (count : Nat) (blocks : Nat → Block) (lookup : Block → Nat) (block : Block) : Bool :=
  decide (lookup block < count ∧ blocks (lookup block) = block)

theorem productTarget_label (c : LocalCertificateV19.GroupedCertificate) (count : Nat) (blocks : Nat → Block) (labels : Nat → Nat)
    (lookup : Block → Nat) (b r : Nat) :
    (productTarget c count blocks labels lookup).labelP b r = (labels b).testBit r := rfl

theorem reference_product (c : LocalCertificateV19.GroupedCertificate) (count : Nat) (blocks : Nat → Block) (labels : Nat → Nat)
    (lookup : Block → Nat) (p : Packed) (ip : Inside c.groups p) :
    let q := normalizeIds c p
    reference c (productTarget c count blocks labels lookup) (codes c.groups p) =
      ⟨lookup (blockOf c q),rank c (blockOf c q) (c.groups.member q.a) (c.groups.member q.b) (c.groups.member q.c),
        codes c.groups q,[]⟩ := by
  dsimp only
  have sorted : normalize c (codes c.groups p) = codes c.groups (normalizeIds c p) :=
    (normalize_codes c p ip).symm
  unfold reference
  rw [sorted]
  simp only [productTarget,idsOfCodes_codes c _ (normalize_inside c p ip)]

/-- A finite block-lookup check, independent of coordinate labels, proves the
literal Target unrank check for every tuple. No per-row address correspondence
assumption is introduced. All ties are covered by the same statement. -/
theorem product_ref_checked (c : LocalCertificateV19.GroupedCertificate) (count : Nat) (blocks : Nat → Block) (labels : Nat → Nat)
    (lookup : Block → Nat) (p : Packed) (ip : Inside c.groups p)
    (honor : ∃ h, h < (inventoriesOf c 3).count ∧ (inventoriesOf c 3).member h = p.h)
    (lookupChecked : checkLookup count blocks lookup (blockOf c (normalizeIds c p)) = true) :
    refB c (productTarget c count blocks labels lookup) (codes c.groups p) = true := by
  have qInside := normalize_inside c p ip
  have hq : ∃ h, h < (inventoriesOf c 3).count ∧ (inventoriesOf c 3).member h = (normalizeIds c p).h := by
    rwa [show (normalizeIds c p).h=p.h from SuitSorting.sort_honor c.groups.group p]
  have a := (GroupInventory.member_facts c.groups c.groupChecked (normalizeIds c p).a qInside.1).member
  have b := (GroupInventory.member_facts c.groups c.groupChecked (normalizeIds c p).b qInside.2.1).member
  have cc := (GroupInventory.member_facts c.groups c.groupChecked (normalizeIds c p).c qInside.2.2).member
  have lookupFacts : lookup (blockOf c (normalizeIds c p)) < count ∧
      blocks (lookup (blockOf c (normalizeIds c p))) = blockOf c (normalizeIds c p) :=
    of_decide_eq_true lookupChecked
  rw [refB,reference_product c count blocks labels lookup p ip]
  simp only [productTarget,lookupFacts.1,if_true,lookupFacts.2,Bool.and_eq_true,decide_eq_true_eq]
  refine ⟨rank_bound c _ _ _ _ a b cc,?_⟩
  rw [unrank_at c _ _ _ _ a b,rebuild c _ qInside hq]
  exact normalize_codes c p ip

theorem product_label_at (c : LocalCertificateV19.GroupedCertificate) (count : Nat) (blocks : Nat → Block) (labels : Nat → Nat)
    (lookup : Block → Nat) (p : Packed) (ip : Inside c.groups p) :
    let q := normalizeIds c p
    isP c (productTarget c count blocks labels lookup) (codes c.groups p) =
      (labels (lookup (blockOf c q))).testBit
        (rank c (blockOf c q) (c.groups.member q.a) (c.groups.member q.b) (c.groups.member q.c)) := by
  rw [isP,reference_product c count blocks labels lookup p ip]
  rfl

/-- The exact all-actual-successors PN specification. Packed planes must
refine this, rather than checking only a supplied subset of edges. -/
def checkPN (c : LocalCertificateV19.GroupedCertificate) (d : Local) (target : Target) (s : Packed) (labelP : Bool) : Bool :=
  if labelP then
    (raw d s).all (fun q => !CachedPackedCheck.safeB d q || (refB c target q && !isP c target q))
  else
    (raw d s).any (fun q => CachedPackedCheck.safeB d q && refB c target q && isP c target q)

/-- Reference row semantics, not a claimed sublinear implementation. -/
def row (c : LocalCertificateV19.GroupedCertificate) (d : Local) (target : Target) (s : Packed) (labelP : Bool) : Bool :=
  CachedPackedCheck.initial d s && checkPN c d target s labelP

theorem reference_strategy (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (target : Target)
    (correct : TargetCorrect (FullSafeData.summaries (ofCertificate c data).rules) target)
    (s : Packed) (accepted : refB c target s = true) :
    NormalStrategy SafeMove (Base5Coverage.unpack s) (outcome (isP c target s)) := by
  simp only [refB,Bool.and_eq_true,decide_eq_true_eq] at accepted
  have result := correct (reference c target s).bucket (reference c target s).index accepted.1
  rw [accepted.2] at result
  obtain ⟨path,eq⟩ := SuitSorting.sort_path (groupKeyCode c) s
  change NormalStrategy SafeMove (Base5Coverage.unpack (normalize c s)) (outcome (isP c target s)) at result
  change Base5Coverage.unpack (normalize c s) = _ at eq
  rw [eq] at result
  exact (path_preserves_outcome path (Base5Coverage.unpack s) _).mpr result

/-- The target may use Cartesian product unrank and packed Nat getters.
There is no fixed colex model or ByteArray label function in this theorem.
TargetCorrect is precisely the next-layer induction hypothesis. -/
theorem row_sound (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data)
    (checked : LocalCertificateV19.Successors.Checked c.toCertificate data) (target : Target)
    (correct : TargetCorrect (FullSafeData.summaries (ofCertificate c data).rules) target)
    (s : Packed) (labelP : Bool) (accepted : row c (ofCertificate c data) target s labelP = true) :
    IsSafe (Base5Coverage.unpack s) ∧ NormalStrategy SafeMove (Base5Coverage.unpack s) (outcome labelP) := by
  simp only [row,Bool.and_eq_true] at accepted
  have facts := LocalCertificateV19.Cached.initial_facts c.toCertificate data s accepted.1
  refine ⟨facts.2.2,?_⟩
  cases labelP with
  | true =>
    have scan := accepted.2
    change (raw (ofCertificate c data) s).all _ = true at scan
    apply NormalStrategy.p
    intro t edge
    obtain ⟨q,member,orbit⟩ := LocalCertificateV19.Cached.children_complete c.toCertificate data checked s facts.1 facts.2.1 t edge
    obtain ⟨rawMem,safe⟩ := List.mem_filter.mp member
    change CachedPackedCheck.safeB (ofCertificate c data) q=true at safe
    have pass := List.all_eq_true.mp scan q rawMem
    simp only [safe,Bool.not_true,Bool.false_or,Bool.and_eq_true,Bool.not_eq_true'] at pass
    have strategy := reference_strategy c data target correct q pass.1
    simp only [pass.2,outcome,Bool.false_eq_true,↓reduceIte] at strategy
    obtain ⟨path,eq⟩ := orbit
    rw [eq] at strategy
    exact (path_preserves_outcome path t .N).mpr strategy
  | false =>
    have scan := accepted.2
    change (raw (ofCertificate c data) s).any _ = true at scan
    obtain ⟨q,rawMem,pass⟩ := List.any_eq_true.mp scan
    simp only [Bool.and_eq_true] at pass
    have member : q ∈ CachedPackedCheck.children (ofCertificate c data) s := List.mem_filter.mpr ⟨rawMem,pass.1.1⟩
    have cached := LocalCertificateV19.Cached.child_edge c.toCertificate data checked s q facts.1 facts.2.1 member
    obtain ⟨t,edge,orbit,_⟩ := LocalCertificateV19.Successors.edge_sound c.toCertificate data checked
      (Base5Coverage.unpack s) (Base5Coverage.unpack q) (LocalCertificateV19.Cached.packed_valid c.toCertificate data s facts.1) cached
    have strategy := reference_strategy c data target correct q pass.1.2
    simp only [pass.2,outcome,↓reduceIte] at strategy
    apply NormalStrategy.n edge
    obtain ⟨path,eq⟩ := orbit
    rw [eq] at strategy
    exact (path_preserves_outcome path t .P).mpr strategy

theorem row_original (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data)
    (checked : LocalCertificateV19.Successors.Checked c.toCertificate data) (target : Target)
    (correct : TargetCorrect (FullSafeData.summaries (ofCertificate c data).rules) target)
    (s : Packed) (labelP : Bool) (accepted : row c (ofCertificate c data) target s labelP = true) :
    AchievementStrategy Step Win (Base5Coverage.unpack s) (outcome labelP) := by
  have result := row_sound c data checked target correct s labelP accepted
  exact (original_safe_reduction result.1).mp result.2

/-- Source safety and local validity come from the single block metadata
check. Only the full actual PN specification remains for a packed refinement. -/
theorem product_strategy (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data)
    (checked : LocalCertificateV19.Successors.Checked c.toCertificate data) (target : Target)
    (correct : TargetCorrect (FullSafeData.summaries (ofCertificate c data).rules) target)
    (block : Block) (blockChecked : checkBlock c block = true) (x y z : Nat)
    (hx : x < widthA c block) (hy : y < widthB c block) (hz : z < widthC c block)
    (labelP : Bool)
    (accepted : checkPN c (ofCertificate c data) target (packed c block x y z) labelP = true) :
    AchievementStrategy Step Win (originalState c block x y z) (outcome labelP) := by
  apply row_original c data checked target correct (packed c block x y z) labelP
  simp only [row, product_initial c data block blockChecked x y z hx hy hz, accepted, Bool.and_self]

theorem finite_stable_sort_controls :
    SuitSorting.sort (fun i => i/3) ⟨5,4,7,0⟩ = ⟨5,4,7,0⟩ ∧
    SuitSorting.sort (fun i => i/3) ⟨8,4,7,0⟩ = ⟨4,8,7,0⟩ ∧
    SuitSorting.sort (fun i => i/3) ⟨5,8,4,0⟩ = ⟨5,4,8,0⟩ ∧
    SuitSorting.sort (fun i => i/3) ⟨8,7,5,0⟩ = ⟨5,8,7,0⟩ := by decide +kernel

end Mahjong.LocalProductStateV19

#print axioms Mahjong.LocalProductStateV19.block_parts
#print axioms Mahjong.LocalProductStateV19.ids_facts
#print axioms Mahjong.LocalProductStateV19.rawLabel_at
#print axioms Mahjong.LocalProductStateV19.product_initial
#print axioms Mahjong.LocalProductStateV19.product_safe
#print axioms Mahjong.LocalProductStateV19.rank_bound
#print axioms Mahjong.LocalProductStateV19.unrank_at
#print axioms Mahjong.LocalProductStateV19.rebuild
#print axioms Mahjong.LocalProductStateV19.normalize_inside
#print axioms Mahjong.LocalProductStateV19.mapped_sort_path
#print axioms Mahjong.LocalProductStateV19.normalized_product
#print axioms Mahjong.LocalProductStateV19.child_product
#print axioms Mahjong.LocalProductStateV19.code_group
#print axioms Mahjong.LocalProductStateV19.compare_codes
#print axioms Mahjong.LocalProductStateV19.normalize_codes
#print axioms Mahjong.LocalProductStateV19.idsOfCodes_codes
#print axioms Mahjong.LocalProductStateV19.productTarget_label
#print axioms Mahjong.LocalProductStateV19.reference_product
#print axioms Mahjong.LocalProductStateV19.product_ref_checked
#print axioms Mahjong.LocalProductStateV19.product_label_at
#print axioms Mahjong.LocalProductStateV19.reference_strategy
#print axioms Mahjong.LocalProductStateV19.row_sound
#print axioms Mahjong.LocalProductStateV19.row_original
#print axioms Mahjong.LocalProductStateV19.product_strategy
#print axioms Mahjong.LocalProductStateV19.finite_stable_sort_controls
