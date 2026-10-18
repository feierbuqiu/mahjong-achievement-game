import Mahjong.LocalProductTransitionV19

set_option autoImplicit false

namespace Mahjong.LocalProductTensorPlanV19

open PackedRules CachedPackedCheck BlockPlanCheck GeneralLayer LocalBlockSoundnessV19
open BlockPlanSoundness (codes Inside AtContext)
open LocalProductStateV19 LocalProductTransitionV19 TensorLayoutSemanticsV19

structure Bank where
  count : Nat
  blocks : Nat → Block
  labels : Nat → Nat
  lookup : Block → Nat
  words : Nat → TensorReachV19.Word

def target (c : LocalCertificateV19.GroupedCertificate) (bank : Bank) : Target :=
  productTarget c bank.count bank.blocks bank.labels bank.lookup

def wordFor (bank : Bank) (block : Block) : TensorReachV19.Word := bank.words (bank.lookup block)

/-- Scalar directory identity and whole-word preparation are checked once
per block/target word; no per-row labels or addresses are checked here. -/
def checkBoundWord (c : LocalCertificateV19.GroupedCertificate) (bank : Bank) (block : Block) : Bool :=
  checkLookup bank.count bank.blocks bank.lookup block && checkWord (wordFor bank block) &&
    decide ((wordFor bank block).a=widthA c block ∧ (wordFor bank block).b=widthB c block ∧
      (wordFor bank block).c=widthC c block ∧ (wordFor bank block).raw=bank.labels (bank.lookup block))

structure BoundWordFacts (c : LocalCertificateV19.GroupedCertificate) (bank : Bank) (block : Block) : Prop where
  lookup : checkLookup bank.count bank.blocks bank.lookup block=true
  prepared : checkWord (wordFor bank block)=true
  a : (wordFor bank block).a=widthA c block
  b : (wordFor bank block).b=widthB c block
  c : (wordFor bank block).c=widthC c block
  raw : (wordFor bank block).raw=bank.labels (bank.lookup block)

theorem bound_word_facts (c : LocalCertificateV19.GroupedCertificate) (bank : Bank) (block : Block)
    (accepted : checkBoundWord c bank block=true) : BoundWordFacts c bank block := by
  have parts : (checkLookup bank.count bank.blocks bank.lookup block=true ∧ checkWord (wordFor bank block)=true) ∧
      ((wordFor bank block).a=widthA c block ∧ (wordFor bank block).b=widthB c block ∧
        (wordFor bank block).c=widthC c block ∧ (wordFor bank block).raw=bank.labels (bank.lookup block)) := by
    simpa only [checkBoundWord,Bool.and_eq_true,decide_eq_true_eq] using accepted
  exact ⟨parts.1.1,parts.1.2,parts.2.1,parts.2.2.1,parts.2.2.2.1,parts.2.2.2.2⟩


/-- The source word is deliberately OUTSIDE the next-layer Target. A proof
of TargetCorrect therefore never assumes correctness of the source itself.
Only dimensions, bit-layout preparation and the candidate Nat getter bind it. -/
def checkSourceWord (c : LocalCertificateV19.GroupedCertificate) (bank : Bank) (source : Block) : Bool :=
  decide (bank.count≤bank.lookup source) && checkWord (wordFor bank source) &&
    decide ((wordFor bank source).a=widthA c source ∧ (wordFor bank source).b=widthB c source ∧
      (wordFor bank source).c=widthC c source ∧ (wordFor bank source).raw=bank.labels (bank.lookup source))

structure SourceWordFacts (c : LocalCertificateV19.GroupedCertificate) (bank : Bank) (source : Block) : Prop where
  outside : bank.count≤bank.lookup source
  prepared : checkWord (wordFor bank source)=true
  a : (wordFor bank source).a=widthA c source
  b : (wordFor bank source).b=widthB c source
  c : (wordFor bank source).c=widthC c source
  raw : (wordFor bank source).raw=bank.labels (bank.lookup source)

theorem source_word_facts (c : LocalCertificateV19.GroupedCertificate) (bank : Bank) (source : Block)
    (checked : checkSourceWord c bank source=true) : SourceWordFacts c bank source := by
  have parts : ((bank.count≤bank.lookup source) ∧ checkWord (wordFor bank source)=true) ∧
      ((wordFor bank source).a=widthA c source ∧ (wordFor bank source).b=widthB c source ∧
      (wordFor bank source).c=widthC c source ∧ (wordFor bank source).raw=bank.labels (bank.lookup source)) := by
    simpa only [checkSourceWord,Bool.and_eq_true,decide_eq_true_eq] using checked
  exact ⟨parts.1.1,parts.1.2,parts.2.1,parts.2.2.1,parts.2.2.2.1,parts.2.2.2.2⟩

theorem source_outside_target (c : LocalCertificateV19.GroupedCertificate) (bank : Bank) (source : Block)
    (checked : checkSourceWord c bank source=true) : (target c bank).size (bank.lookup source)=0 := by
  have facts := source_word_facts c bank source checked
  have bound := facts.outside
  have outside : ¬bank.lookup source<bank.count := by omega
  simp only [target,productTarget,if_neg outside]

def context (c : LocalCertificateV19.GroupedCertificate) (source : Block) : Context :=
  ⟨0,0,source.key,(inventoriesOf c 3).member source.honor⟩

def safeNumeric (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (source : Block) (axis j : Nat) : Bool :=
  expectedSafe c.groups (ofCertificate c data) (context c source) axis j

def plane (c : LocalCertificateV19.GroupedCertificate) (bank : Bank) (source : Block) (axis member j targetAxis : Nat) : TensorReachV19.Plane :=
  ⟨axis,member,wordFor bank (targetBlock c source axis j),targetAxis,c.groups.member j⟩

def checkNumeric (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (bank : Bank) (source : Block)
    (axis member j targetAxis : Nat) : Bool :=
  decide (axis<3 ∧ member<c.groups.size (groupAt source axis) ∧ j<c.groups.count) &&
    if safeNumeric c data source axis j then
      checkTags c source axis j targetAxis && checkBoundWord c bank (targetBlock c source axis j) &&
      checkFree (wordFor bank source) (wordFor bank (targetBlock c source axis j)) axis targetAxis &&
      TensorReachV19.checkPlane (wordFor bank source) (plane c bank source axis member j targetAxis)
    else true

structure NumericFacts (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (bank : Bank) (source : Block)
    (axis member j targetAxis : Nat) : Prop where
  axisBound : axis<3
  memberBound : member<c.groups.size (groupAt source axis)
  jBound : j<c.groups.count
  tags : checkTags c source axis j targetAxis=true
  word : checkBoundWord c bank (targetBlock c source axis j)=true
  free : checkFree (wordFor bank source) (wordFor bank (targetBlock c source axis j)) axis targetAxis=true
  plane : TensorReachV19.checkPlane (wordFor bank source) (plane c bank source axis member j targetAxis)=true

theorem numeric_facts (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (bank : Bank) (source : Block)
    (axis member j targetAxis : Nat) (accepted : checkNumeric c data bank source axis member j targetAxis=true)
    (safe : safeNumeric c data source axis j=true) : NumericFacts c data bank source axis member j targetAxis := by
  have parts : (axis<3 ∧ member<c.groups.size (groupAt source axis) ∧ j<c.groups.count) ∧
      (((checkTags c source axis j targetAxis=true ∧ checkBoundWord c bank (targetBlock c source axis j)=true) ∧
      checkFree (wordFor bank source) (wordFor bank (targetBlock c source axis j)) axis targetAxis=true) ∧
      TensorReachV19.checkPlane (wordFor bank source) (plane c bank source axis member j targetAxis)=true) := by
    simpa only [checkNumeric,safe,if_true,Bool.and_eq_true,decide_eq_true_eq] using accepted
  exact ⟨parts.1.1,parts.1.2.1,parts.1.2.2,parts.2.1.1.1,parts.2.1.1.2,parts.2.1.2,parts.2.2⟩

theorem source_groups (c : LocalCertificateV19.GroupedCertificate) (source : Block) (checked : LocalProductStateV19.checkBlock c source=true) :
    source.key.1<c.groups.groups ∧ source.key.2.1<c.groups.groups ∧ source.key.2.2<c.groups.groups := by
  have facts := block_parts c source checked
  exact ⟨facts.1.1,facts.1.2.1,facts.1.2.2.1⟩

theorem numeric_label (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (bank : Bank) (source : Block)
    (sourceChecked : LocalProductStateV19.checkBlock c source=true)
    (axis member j targetAxis x y z : Nat)
    (checked : checkNumeric c data bank source axis member j targetAxis=true)
    (safe : safeNumeric c data source axis j=true)
    (hx : x<widthA c source) (hy : y<widthB c source) (hz : z<widthC c source) :
    let q := targetCoordinates c source axis j x y z
    LocalProductStateV19.isP c (target c bank)
      (CachedPackedCheck.replace (ofCertificate c data) (packed c source x y z) axis j) =
        (wordFor bank (targetBlock c source axis j)).raw.testBit
          (PadTensorV19.rawIndex (wordFor bank (targetBlock c source axis j)).a
            (wordFor bank (targetBlock c source axis j)).b q.a q.b q.c) := by
  dsimp only
  have facts := numeric_facts c data bank source axis member j targetAxis checked safe
  have axisBound : axis<3 := facts.axisBound
  have axis4 : axis<4 := Nat.lt_trans facts.axisBound (by decide)
  have groups := source_groups c source sourceChecked
  have ip := (ids_facts c source groups x y z hx hy hz).1
  have iq := rawChild_inside c.groups (ofCertificate c data) (ids c source x y z) ip axis j axis4
    (by simpa only [if_pos facts.axisBound] using facts.jBound)
  have replaced : CachedPackedCheck.replace (ofCertificate c data) (packed c source x y z) axis j =
      codes c.groups ((ids c source x y z).set axis j) := by
    rw [packed,rawChild_codes c data _ axis j axis4]
    simp only [rawChild,if_pos facts.axisBound]
  have inside : Inside c.groups ((ids c source x y z).set axis j) := by
    simpa only [rawChild,if_pos facts.axisBound] using iq
  unfold target
  rw [replaced,LocalProductStateV19.product_label_at c bank.count bank.blocks bank.labels bank.lookup _ inside]
  have blockEq := target_block c source axis j x y z facts.axisBound sourceChecked hx hy hz
  have coords := target_members c source axis j x y z facts.axisBound groups hx hy hz
  have a := congrArg (fun t : Nat × Nat × Nat => t.1) coords
  have b := congrArg (fun t : Nat × Nat × Nat => t.2.1) coords
  have cc := congrArg (fun t : Nat × Nat × Nat => t.2.2) coords
  dsimp only at a b cc
  rw [blockEq,a,b,cc]
  have word := bound_word_facts c bank _ facts.word
  rw [word.raw,word.a,word.b]
  rfl

theorem insert_numeric (axis member u v h1 h2 : Nat) :
    ((LocalProductTransitionV19.insert axis member u v h1).a,(LocalProductTransitionV19.insert axis member u v h1).b,(LocalProductTransitionV19.insert axis member u v h1).c)=
      ((LocalProductTransitionV19.insert axis member u v h2).a,(LocalProductTransitionV19.insert axis member u v h2).b,(LocalProductTransitionV19.insert axis member u v h2).c) := by
  unfold LocalProductTransitionV19.insert
  split
  · rfl
  · split <;> rfl

theorem numeric_hit (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (bank : Bank) (source : Block)
    (sourceChecked : LocalProductStateV19.checkBlock c source=true)
    (sourceWord : checkSourceWord c bank source=true) (axis member j targetAxis x y z : Nat)
    (checked : checkNumeric c data bank source axis member j targetAxis=true)
    (safe : safeNumeric c data source axis j=true)
    (hx : x<widthA c source) (hy : y<widthB c source) (hz : z<widthC c source) :
    planeHit (wordFor bank source) (plane c bank source axis member j targetAxis) x y z ↔
      memberIndex axis x y z=member ∧ LocalProductStateV19.isP c (target c bank)
        (CachedPackedCheck.replace (ofCertificate c data) (packed c source x y z) axis j)=true := by
  have facts := numeric_facts c data bank source axis member j targetAxis checked safe
  have axisBound : axis<3 := facts.axisBound
  have sourceFacts := source_word_facts c bank source sourceWord
  have targetFacts := bound_word_facts c bank _ facts.word
  have sx : x<(wordFor bank source).a := by rw [sourceFacts.a]; exact hx
  have sy : y<(wordFor bank source).b := by rw [sourceFacts.b]; exact hy
  have sz : z<(wordFor bank source).c := by rw [sourceFacts.c]; exact hz
  have read := plane_target_read (wordFor bank source) (plane c bank source axis member j targetAxis)
    targetFacts.prepared facts.plane facts.free x y z sx sy sz
  have label := numeric_label c data bank source sourceChecked axis member j targetAxis x y z checked safe hx hy hz
  rw [targetCoordinates_insert c source axis j targetAxis x y z facts.tags] at label
  dsimp only at label read
  have eq := insert_numeric targetAxis (c.groups.member j) (freePair axis (coordinates x y z)).1
    (freePair axis (coordinates x y z)).2 (sourceHonor c source) 0
  have a := congrArg (fun t : Nat × Nat × Nat => t.1) eq
  have b := congrArg (fun t : Nat × Nat × Nat => t.2.1) eq
  have cc := congrArg (fun t : Nat × Nat × Nat => t.2.2) eq
  dsimp only at a b cc
  rw [a,b,cc] at label
  unfold planeHit
  dsimp only [plane] at read ⊢
  rw [read,←label]

theorem numeric_ref (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (bank : Bank) (source : Block)
    (sourceChecked : LocalProductStateV19.checkBlock c source=true) (axis member j targetAxis x y z : Nat)
    (checked : checkNumeric c data bank source axis member j targetAxis=true)
    (safe : safeNumeric c data source axis j=true)
    (hx : x<widthA c source) (hy : y<widthB c source) (hz : z<widthC c source) :
    LocalProductStateV19.refB c (target c bank)
      (CachedPackedCheck.replace (ofCertificate c data) (packed c source x y z) axis j)=true := by
  have facts := numeric_facts c data bank source axis member j targetAxis checked safe
  have axisBound : axis<3 := facts.axisBound
  have axis4 : axis<4 := Nat.lt_trans facts.axisBound (by decide)
  have groups := source_groups c source sourceChecked
  have ip := (ids_facts c source groups x y z hx hy hz).1
  have iq := rawChild_inside c.groups (ofCertificate c data) (ids c source x y z) ip axis j axis4
    (by simpa only [if_pos facts.axisBound] using facts.jBound)
  have iq' : Inside c.groups ((ids c source x y z).set axis j) := by
    simpa only [rawChild,if_pos facts.axisBound] using iq
  have parts := block_parts c source sourceChecked
  have honor : ∃ h, h<(inventoriesOf c 3).count ∧ (inventoriesOf c 3).member h=((ids c source x y z).set axis j).h := by
    refine ⟨source.honor,parts.1.2.2.2.2.2,?_⟩
    have choices : axis=0 ∨ axis=1 ∨ axis=2 := by omega
    rcases choices with rfl | rfl | rfl <;> rfl
  have targetWord := bound_word_facts c bank _ facts.word
  have lookup : checkLookup bank.count bank.blocks bank.lookup (blockOf c (normalizeIds c ((ids c source x y z).set axis j)))=true := by
    rw [target_block c source axis j x y z facts.axisBound sourceChecked hx hy hz]
    exact targetWord.lookup
  have ref := product_ref_checked c bank.count bank.blocks bank.labels bank.lookup _ iq' honor lookup
  unfold target
  rw [packed,rawChild_codes c data _ axis j axis4]
  simpa only [rawChild,if_pos facts.axisBound] using ref

theorem actual_safe (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (source : Block)
    (sourceChecked : LocalProductStateV19.checkBlock c source=true) (axis j x y z : Nat) (axisBound : axis<4)
    (jBound : j<if axis<3 then c.groups.count else (inventoriesOf c 3).count)
    (hx : x<widthA c source) (hy : y<widthB c source) (hz : z<widthC c source) :
    CachedPackedCheck.safeB (ofCertificate c data)
      (CachedPackedCheck.replace (ofCertificate c data) (packed c source x y z) axis j)=
        safeNumeric c data source axis j := by
  have groups := source_groups c source sourceChecked
  have f := ids_facts c source groups x y z hx hy hz
  have atContext : AtContext c.groups (context c source) (ids c source x y z) :=
    ⟨f.2.1,f.2.2.1,f.2.2.2,rfl⟩
  have parts := block_parts c source sourceChecked
  have honor : ∃ h, h<(inventoriesOf c 3).count ∧ (inventoriesOf c 3).member h=(ids c source x y z).h :=
    ⟨source.honor,parts.1.2.2.2.2.2,rfl⟩
  rw [packed,rawChild_codes c data _ axis j axisBound]
  exact safe_of_ids c data (context c source) _ f.1 atContext honor axis j axisBound jBound

theorem source_id_generic (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (p : Packed)
    (inside : Inside c.groups p) (axis : Nat) (axisBound : axis<4) (h : Nat)
    (honorBound : h<(inventoriesOf c 3).count) (honorEq : p.h=(inventoriesOf c 3).member h) :
    CachedPackedCheck.sourceId (ofCertificate c data) (codes c.groups p) axis=
      if axis<3 then p.get axis else h := by
  have choices : axis=0 ∨ axis=1 ∨ axis=2 ∨ axis=3 := by omega
  rcases choices with rfl | rfl | rfl | rfl
  · exact id_of_member c 0 (by decide) p.a inside.1
  · exact id_of_member c 1 (by decide) p.b inside.2.1
  · exact id_of_member c 2 (by decide) p.c inside.2.2
  · change (inventoriesOf c 3).id p.h=h
    rw [honorEq]
    exact (CanonicalInventory.checked_member 3 (inventoriesOf c 3) (c.inventoryChecked 3 (by decide)) h honorBound).2

theorem ids_axis (c : LocalCertificateV19.GroupedCertificate) (source : Block) (axis x y z : Nat) (axisBound : axis<3) :
    (ids c source x y z).get axis=c.groups.first (groupAt source axis)+memberIndex axis x y z := by
  have choices : axis=0 ∨ axis=1 ∨ axis=2 := by omega
  rcases choices with rfl | rfl | rfl <;> rfl

theorem actual_source_id (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (source : Block)
    (sourceChecked : LocalProductStateV19.checkBlock c source=true) (axis x y z : Nat) (axisBound : axis<4)
    (hx : x<widthA c source) (hy : y<widthB c source) (hz : z<widthC c source) :
    CachedPackedCheck.sourceId (ofCertificate c data) (packed c source x y z) axis=
      if axis<3 then c.groups.first (groupAt source axis)+memberIndex axis x y z else source.honor := by
  have groups := source_groups c source sourceChecked
  have f := ids_facts c source groups x y z hx hy hz
  have parts := block_parts c source sourceChecked
  have generic := source_id_generic c data (ids c source x y z) f.1 axis axisBound source.honor
    parts.1.2.2.2.2.2 rfl
  change CachedPackedCheck.sourceId (ofCertificate c data) (codes c.groups (ids c source x y z)) axis=_
  rw [generic]
  split
  next h => rw [ids_axis c source axis x y z h]
  next _ => rfl

abbrev Key := Nat × Nat × Nat

/-- Enumerate actual local next lists once per member of each group, never
once per Cartesian source tuple. Unsafe successors remain in this metadata
enumeration and are filtered only by the exact original group SAFE test. -/
def keys (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (source : Block) : List Key :=
  (List.range 3).flatMap fun axis =>
    (List.range (c.groups.size (groupAt source axis))).flatMap fun member =>
      ((data axis).next (c.groups.first (groupAt source axis)+member)).map fun j => (axis,member,j)

theorem key_mem (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (source : Block) (axis member j : Nat) :
    (axis,member,j)∈keys c data source ↔ axis<3 ∧ member<c.groups.size (groupAt source axis) ∧
      j∈(data axis).next (c.groups.first (groupAt source axis)+member) := by
  simp only [keys,List.mem_flatMap,List.mem_range,List.mem_map,Prod.mk.injEq]
  constructor
  · rintro ⟨a,ha,m,hm,k,hk,e1,e2,e3⟩
    subst a; subst m; subst k
    exact ⟨ha,hm,hk⟩
  · rintro ⟨ha,hm,hj⟩
    exact ⟨axis,ha,member,hm,j,hj,rfl,rfl,rfl⟩


theorem sort_fixed (key : Nat → Nat) (p : Packed) (ab : key p.a≤key p.b) (bc : key p.b≤key p.c) :
    SuitSorting.sort key p=p := by
  have n1 : ¬key p.a>key p.b := by omega
  have n2 : ¬key p.b>key p.c := by omega
  simp only [SuitSorting.sort,SuitSorting.compare01,SuitSorting.compare12,if_neg n1,if_neg n2]

theorem source_normalized (c : LocalCertificateV19.GroupedCertificate) (source : Block) (checked : LocalProductStateV19.checkBlock c source=true)
    (x y z : Nat) (hx : x<widthA c source) (hy : y<widthB c source) (hz : z<widthC c source) :
    normalizeIds c (ids c source x y z)=ids c source x y z := by
  have parts := block_parts c source checked
  have f := ids_facts c source (source_groups c source checked) x y z hx hy hz
  exact sort_fixed c.groups.group _ (by rw [f.2.1,f.2.2.1]; exact parts.1.2.2.2.1)
    (by rw [f.2.2.1,f.2.2.2]; exact parts.1.2.2.2.2.1)

theorem source_geometry (c : LocalCertificateV19.GroupedCertificate) (source : Block) (checked : LocalProductStateV19.checkBlock c source=true)
    (x y z : Nat) (hx : x<widthA c source) (hy : y<widthB c source) (hz : z<widthC c source) :
    blockOf c (ids c source x y z)=source ∧
    c.groups.member (ids c source x y z).a=x ∧ c.groups.member (ids c source x y z).b=y ∧
    c.groups.member (ids c source x y z).c=z := by
  have parts := block_parts c source checked
  have groups := source_groups c source checked
  have f := ids_facts c source groups x y z hx hy hz
  have a := GroupInventory.coordinate_inverse c.groups c.groupChecked source.key.1 x groups.1 hx
  have b := GroupInventory.coordinate_inverse c.groups c.groupChecked source.key.2.1 y groups.2.1 hy
  have cc := GroupInventory.coordinate_inverse c.groups c.groupChecked source.key.2.2 z groups.2.2 hz
  have h := (CanonicalInventory.checked_member 3 (inventoriesOf c 3) (c.inventoryChecked 3 (by decide))
    source.honor parts.1.2.2.2.2.2).2
  refine ⟨?_,a.2.2,b.2.2,cc.2.2⟩
  unfold blockOf
  rw [f.2.1,f.2.2.1,f.2.2.2]
  change ({key:=source.key,honor:=(inventoriesOf c 3).id ((inventoriesOf c 3).member source.honor)} : Block)=source
  rw [h]

theorem source_label (c : LocalCertificateV19.GroupedCertificate) (bank : Bank) (source : Block)
    (checked : LocalProductStateV19.checkBlock c source=true) (x y z : Nat)
    (hx : x<widthA c source) (hy : y<widthB c source) (hz : z<widthC c source) :
    LocalProductStateV19.isP c (target c bank) (packed c source x y z)=
      (bank.labels (bank.lookup source)).testBit (PadTensorV19.rawIndex (widthA c source) (widthB c source) x y z) := by
  have f := ids_facts c source (source_groups c source checked) x y z hx hy hz
  have geo := source_geometry c source checked x y z hx hy hz
  unfold target
  rw [packed,product_label_at c bank.count bank.blocks bank.labels bank.lookup _ f.1,
    source_normalized c source checked x y z hx hy hz,geo.1,geo.2.1,geo.2.2.1,geo.2.2.2]
  rfl

theorem source_ref (c : LocalCertificateV19.GroupedCertificate) (bank : Bank) (source : Block)
    (checked : LocalProductStateV19.checkBlock c source=true)
    (lookup : checkLookup bank.count bank.blocks bank.lookup source=true) (x y z : Nat)
    (hx : x<widthA c source) (hy : y<widthB c source) (hz : z<widthC c source) :
    LocalProductStateV19.refB c (target c bank) (packed c source x y z)=true := by
  have f := ids_facts c source (source_groups c source checked) x y z hx hy hz
  have parts := block_parts c source checked
  have geo := source_geometry c source checked x y z hx hy hz
  apply product_ref_checked c bank.count bank.blocks bank.labels bank.lookup _ f.1
    ⟨source.honor,parts.1.2.2.2.2.2,rfl⟩
  rwa [source_normalized c source checked x y z hx hy hz,geo.1]

def honorBlock (source : Block) (j : Nat) : Block := ⟨source.key,j⟩

def checkHonor (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (bank : Bank) (source : Block) (j : Nat) : Bool :=
  decide (j<(inventoriesOf c 3).count) &&
    if safeNumeric c data source 3 j then
      LocalProductStateV19.checkBlock c (honorBlock source j) && checkBoundWord c bank (honorBlock source j) &&
        decide ((wordFor bank (honorBlock source j)).ap=(wordFor bank source).ap ∧
          (wordFor bank (honorBlock source j)).bp=(wordFor bank source).bp)
    else true

structure HonorFacts (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (bank : Bank) (source : Block) (j : Nat) : Prop where
  bound : j<(inventoriesOf c 3).count
  block : LocalProductStateV19.checkBlock c (honorBlock source j)=true
  word : checkBoundWord c bank (honorBlock source j)=true
  ap : (wordFor bank (honorBlock source j)).ap=(wordFor bank source).ap
  bp : (wordFor bank (honorBlock source j)).bp=(wordFor bank source).bp

theorem honor_facts (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (bank : Bank) (source : Block) (j : Nat)
    (accepted : checkHonor c data bank source j=true) (safe : safeNumeric c data source 3 j=true) :
    HonorFacts c data bank source j := by
  have parts : (j<(inventoriesOf c 3).count) ∧
      ((LocalProductStateV19.checkBlock c (honorBlock source j)=true ∧ checkBoundWord c bank (honorBlock source j)=true) ∧
        ((wordFor bank (honorBlock source j)).ap=(wordFor bank source).ap ∧
          (wordFor bank (honorBlock source j)).bp=(wordFor bank source).bp)) := by
    simpa only [checkHonor,safe,if_true,Bool.and_eq_true,decide_eq_true_eq] using accepted
  exact ⟨parts.1,parts.2.1.1,parts.2.1.2,parts.2.2.1,parts.2.2.2⟩

theorem replace_honor (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (source : Block) (j x y z : Nat) :
    CachedPackedCheck.replace (ofCertificate c data) (packed c source x y z) 3 j=
      packed c (honorBlock source j) x y z := rfl

theorem honor_hit (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (bank : Bank) (source : Block)
    (sourceWord : checkSourceWord c bank source=true) (j x y z : Nat)
    (checked : checkHonor c data bank source j=true) (safe : safeNumeric c data source 3 j=true)
    (hx : x<widthA c source) (hy : y<widthB c source) (hz : z<widthC c source) :
    (wordFor bank (honorBlock source j)).padded.testBit (originalIndex (wordFor bank source) x y z)=
      LocalProductStateV19.isP c (target c bank)
        (CachedPackedCheck.replace (ofCertificate c data) (packed c source x y z) 3 j) := by
  have facts := honor_facts c data bank source j checked safe
  have sourceFacts := source_word_facts c bank source sourceWord
  have targetFacts := bound_word_facts c bank _ facts.word
  have htx : x<(wordFor bank (honorBlock source j)).a := by rw [targetFacts.a]; exact hx
  have hty : y<(wordFor bank (honorBlock source j)).b := by rw [targetFacts.b]; exact hy
  have htz : z<(wordFor bank (honorBlock source j)).c := by rw [targetFacts.c]; exact hz
  have read := padded_read _ targetFacts.prepared x y z htx hty htz
  have idx : originalIndex (wordFor bank (honorBlock source j)) x y z=originalIndex (wordFor bank source) x y z := by
    unfold originalIndex
    rw [facts.ap,facts.bp]
  rw [idx,targetFacts.a,targetFacts.b] at read
  rw [replace_honor c data source j x y z,source_label c bank _ facts.block x y z hx hy hz,read,targetFacts.raw]

theorem honor_ref (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (bank : Bank) (source : Block)
    (j x y z : Nat) (checked : checkHonor c data bank source j=true) (safe : safeNumeric c data source 3 j=true)
    (hx : x<widthA c source) (hy : y<widthB c source) (hz : z<widthC c source) :
    LocalProductStateV19.refB c (target c bank)
      (CachedPackedCheck.replace (ofCertificate c data) (packed c source x y z) 3 j)=true := by
  have facts := honor_facts c data bank source j checked safe
  rw [replace_honor]
  exact source_ref c bank _ facts.block (bound_word_facts c bank _ facts.word).lookup x y z hx hy hz


structure Plan where
  targetAxis : Key → Nat

def safeKeys (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (source : Block) : List Key :=
  (keys c data source).filter fun key => safeNumeric c data source key.1 key.2.2

def planes (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (bank : Bank) (source : Block) (plan : Plan) : List TensorReachV19.Plane :=
  (safeKeys c data source).map fun key => plane c bank source key.1 key.2.1 key.2.2 (plan.targetAxis key)

def honorKeys (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (source : Block) : List Nat :=
  ((data 3).next source.honor).filter fun j => safeNumeric c data source 3 j

def honorWords (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (bank : Bank) (source : Block) : List TensorReachV19.Word :=
  (honorKeys c data source).map fun j => wordFor bank (honorBlock source j)

/-- Complete group-local metadata plus two whole-Nat equations. The local
next lists are enumerated per group member, never per Cartesian tuple.
The only proposed numeric metadata is a target axis; all paths/labels,
SAFE filtering and local-next membership are derived by this checker. -/
def checkPlan (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (bank : Bank) (source : Block) (plan : Plan) : Bool :=
  LocalProductStateV19.checkBlock c source && checkSourceWord c bank source &&
    (keys c data source).all (fun key => checkNumeric c data bank source key.1 key.2.1 key.2.2 (plan.targetAxis key)) &&
    ((data 3).next source.honor).all (checkHonor c data bank source) &&
    TensorReachV19.check (wordFor bank source) (planes c data bank source plan) (honorWords c data bank source)

structure PlanFacts (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (bank : Bank) (source : Block) (plan : Plan) : Prop where
  block : LocalProductStateV19.checkBlock c source=true
  word : checkSourceWord c bank source=true
  numeric : (keys c data source).all (fun key => checkNumeric c data bank source key.1 key.2.1 key.2.2 (plan.targetAxis key))=true
  honor : ((data 3).next source.honor).all (checkHonor c data bank source)=true
  recurrence : TensorReachV19.check (wordFor bank source) (planes c data bank source plan) (honorWords c data bank source)=true

theorem plan_facts (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (bank : Bank) (source : Block) (plan : Plan)
    (accepted : checkPlan c data bank source plan=true) : PlanFacts c data bank source plan := by
  have parts : (((LocalProductStateV19.checkBlock c source=true ∧ checkSourceWord c bank source=true) ∧
      (keys c data source).all (fun key => checkNumeric c data bank source key.1 key.2.1 key.2.2 (plan.targetAxis key))=true) ∧
      ((data 3).next source.honor).all (checkHonor c data bank source)=true) ∧
      TensorReachV19.check (wordFor bank source) (planes c data bank source plan) (honorWords c data bank source)=true := by
    simpa only [checkPlan,Bool.and_eq_true] using accepted
  exact ⟨parts.1.1.1.1,parts.1.1.1.2,parts.1.1.2,parts.1.2,parts.2⟩

theorem member_bound (c : LocalCertificateV19.GroupedCertificate) (source : Block) (axis x y z : Nat) (axisBound : axis<3)
    (hx : x<widthA c source) (hy : y<widthB c source) (hz : z<widthC c source) :
    memberIndex axis x y z<c.groups.size (groupAt source axis) := by
  have choices : axis=0 ∨ axis=1 ∨ axis=2 := by omega
  rcases choices with rfl | rfl | rfl
  · exact hx
  · exact hy
  · exact hz

theorem numeric_bounds (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (bank : Bank) (source : Block)
    (axis member j targetAxis : Nat) (checked : checkNumeric c data bank source axis member j targetAxis=true) :
    axis<3 ∧ member<c.groups.size (groupAt source axis) ∧ j<c.groups.count := by
  simp only [checkNumeric,Bool.and_eq_true] at checked
  exact of_decide_eq_true checked.1

theorem honor_bound (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (bank : Bank) (source : Block)
    (j : Nat) (checked : checkHonor c data bank source j=true) : j<(inventoriesOf c 3).count := by
  simp only [checkHonor,Bool.and_eq_true] at checked
  exact of_decide_eq_true checked.1

theorem actual_numeric_key (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (source : Block)
    (sourceChecked : LocalProductStateV19.checkBlock c source=true) (axis j x y z : Nat)
    (axisBound : axis<3)
    (member : j∈(data axis).next (CachedPackedCheck.sourceId (ofCertificate c data) (packed c source x y z) axis))
    (hx : x<widthA c source) (hy : y<widthB c source) (hz : z<widthC c source) :
    (axis,memberIndex axis x y z,j)∈keys c data source := by
  apply (key_mem c data source axis _ j).mpr
  refine ⟨axisBound,member_bound c source axis x y z axisBound hx hy hz,?_⟩
  rw [actual_source_id c data source sourceChecked axis x y z (by omega) hx hy hz,if_pos axisBound] at member
  exact member

theorem actual_honor_key (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (source : Block)
    (sourceChecked : LocalProductStateV19.checkBlock c source=true) (j x y z : Nat)
    (member : j∈(data 3).next (CachedPackedCheck.sourceId (ofCertificate c data) (packed c source x y z) 3))
    (hx : x<widthA c source) (hy : y<widthB c source) (hz : z<widthC c source) :
    j∈(data 3).next source.honor := by
  rw [actual_source_id c data source sourceChecked 3 x y z (by decide) hx hy hz] at member
  exact member

theorem safe_key_mem (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (source : Block) (key : Key) :
    key∈safeKeys c data source ↔ key∈keys c data source ∧ safeNumeric c data source key.1 key.2.2=true := by
  exact List.mem_filter

theorem honor_key_mem (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (source : Block) (j : Nat) :
    j∈honorKeys c data source ↔ j∈(data 3).next source.honor ∧ safeNumeric c data source 3 j=true := by
  exact List.mem_filter


theorem actual_numeric_metadata (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (bank : Bank) (source : Block) (plan : Plan)
    (checked : checkPlan c data bank source plan=true) (axis j x y z : Nat) (axisBound : axis<3)
    (member : j∈(data axis).next (CachedPackedCheck.sourceId (ofCertificate c data) (packed c source x y z) axis))
    (safe : CachedPackedCheck.safeB (ofCertificate c data)
      (CachedPackedCheck.replace (ofCertificate c data) (packed c source x y z) axis j)=true)
    (hx : x<widthA c source) (hy : y<widthB c source) (hz : z<widthC c source) :
    checkNumeric c data bank source axis (memberIndex axis x y z) j
      (plan.targetAxis (axis,memberIndex axis x y z,j))=true ∧ safeNumeric c data source axis j=true := by
  have facts := plan_facts c data bank source plan checked
  have keyMem := actual_numeric_key c data source facts.block axis j x y z axisBound member hx hy hz
  have accepted := List.all_eq_true.mp facts.numeric _ keyMem
  have bounds := numeric_bounds c data bank source _ _ _ _ accepted
  refine ⟨accepted,?_⟩
  rw [actual_safe c data source facts.block axis j x y z (by omega)
    (by simpa only [if_pos axisBound] using bounds.2.2) hx hy hz] at safe
  exact safe

theorem actual_honor_metadata (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (bank : Bank) (source : Block) (plan : Plan)
    (checked : checkPlan c data bank source plan=true) (j x y z : Nat)
    (member : j∈(data 3).next (CachedPackedCheck.sourceId (ofCertificate c data) (packed c source x y z) 3))
    (safe : CachedPackedCheck.safeB (ofCertificate c data)
      (CachedPackedCheck.replace (ofCertificate c data) (packed c source x y z) 3 j)=true)
    (hx : x<widthA c source) (hy : y<widthB c source) (hz : z<widthC c source) :
    checkHonor c data bank source j=true ∧ safeNumeric c data source 3 j=true := by
  have facts := plan_facts c data bank source plan checked
  have keyMem := actual_honor_key c data source facts.block j x y z member hx hy hz
  have accepted := List.all_eq_true.mp facts.honor _ keyMem
  have bound := honor_bound c data bank source j accepted
  refine ⟨accepted,?_⟩
  rw [actual_safe c data source facts.block 3 j x y z (by decide) bound hx hy hz] at safe
  exact safe

theorem successor_ref (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (bank : Bank) (source : Block) (plan : Plan)
    (checked : checkPlan c data bank source plan=true) (x y z : Nat) (q : Packed)
    (member : q∈CachedPackedCheck.raw (ofCertificate c data) (packed c source x y z))
    (safe : CachedPackedCheck.safeB (ofCertificate c data) q=true)
    (hx : x<widthA c source) (hy : y<widthB c source) (hz : z<widthC c source) :
    LocalProductStateV19.refB c (target c bank) q=true := by
  have facts := plan_facts c data bank source plan checked
  obtain ⟨axis,j,axisBound,next,rfl⟩ := (CachedPackedCheck.raw_mem _ _ q).mp member
  by_cases numeric : axis<3
  · have metadata := actual_numeric_metadata c data bank source plan checked axis j x y z numeric next safe hx hy hz
    exact numeric_ref c data bank source facts.block _ _ _ _ x y z metadata.1 metadata.2 hx hy hz
  · have axis3 : axis=3 := by omega
    subst axis
    have metadata := actual_honor_metadata c data bank source plan checked j x y z next safe hx hy hz
    exact honor_ref c data bank source j x y z metadata.1 metadata.2 hx hy hz

theorem checked_planes (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (bank : Bank) (source : Block) (plan : Plan)
    (checked : checkPlan c data bank source plan=true) :
    (planes c data bank source plan).all (TensorReachV19.checkPlane (wordFor bank source))=true := by
  have accepted := (plan_facts c data bank source plan checked).recurrence
  simp only [TensorReachV19.check,Bool.and_eq_true] at accepted
  exact accepted.1

theorem successor_reaches (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (bank : Bank) (source : Block) (plan : Plan)
    (checked : checkPlan c data bank source plan=true) (x y z : Nat) (q : Packed)
    (member : q∈CachedPackedCheck.raw (ofCertificate c data) (packed c source x y z))
    (safe : CachedPackedCheck.safeB (ofCertificate c data) q=true)
    (label : LocalProductStateV19.isP c (target c bank) q=true)
    (hx : x<widthA c source) (hy : y<widthB c source) (hz : z<widthC c source) :
    (TensorReachV19.reach (wordFor bank source) (planes c data bank source plan) (honorWords c data bank source)).testBit
      (originalIndex (wordFor bank source) x y z)=true := by
  have facts := plan_facts c data bank source plan checked
  have word := source_word_facts c bank source facts.word
  have wx : x<(wordFor bank source).a := by rw [word.a]; exact hx
  have wy : y<(wordFor bank source).b := by rw [word.b]; exact hy
  have wz : z<(wordFor bank source).c := by rw [word.c]; exact hz
  apply (reach_spec _ word.prepared _ _ (checked_planes c data bank source plan checked) x y z wx wy wz).mpr
  obtain ⟨axis,j,axisBound,next,rfl⟩ := (CachedPackedCheck.raw_mem _ _ q).mp member
  by_cases numeric : axis<3
  · have metadata := actual_numeric_metadata c data bank source plan checked axis j x y z numeric next safe hx hy hz
    have keyMem := actual_numeric_key c data source facts.block axis j x y z numeric next hx hy hz
    apply Or.inl
    refine ⟨plane c bank source axis (memberIndex axis x y z) j (plan.targetAxis (axis,memberIndex axis x y z,j)),?_,?_⟩
    · exact List.mem_map.mpr ⟨(axis,memberIndex axis x y z,j),(safe_key_mem c data source _).mpr ⟨keyMem,metadata.2⟩,rfl⟩
    · exact (numeric_hit c data bank source facts.block facts.word _ _ _ _ x y z metadata.1 metadata.2 hx hy hz).mpr ⟨rfl,label⟩
  · have axis3 : axis=3 := by omega
    subst axis
    have metadata := actual_honor_metadata c data bank source plan checked j x y z next safe hx hy hz
    have keyMem := actual_honor_key c data source facts.block j x y z next hx hy hz
    apply Or.inr
    refine ⟨wordFor bank (honorBlock source j),?_,?_⟩
    · exact List.mem_map.mpr ⟨j,(honor_key_mem c data source j).mpr ⟨keyMem,metadata.2⟩,rfl⟩
    · rw [honor_hit c data bank source facts.word j x y z metadata.1 metadata.2 hx hy hz]
      exact label

theorem reaches_successor (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (bank : Bank) (source : Block) (plan : Plan)
    (checked : checkPlan c data bank source plan=true) (x y z : Nat)
    (reached : (TensorReachV19.reach (wordFor bank source) (planes c data bank source plan) (honorWords c data bank source)).testBit
      (originalIndex (wordFor bank source) x y z)=true)
    (hx : x<widthA c source) (hy : y<widthB c source) (hz : z<widthC c source) :
    ∃ q, q∈CachedPackedCheck.raw (ofCertificate c data) (packed c source x y z) ∧
      CachedPackedCheck.safeB (ofCertificate c data) q=true ∧ LocalProductStateV19.refB c (target c bank) q=true ∧
      LocalProductStateV19.isP c (target c bank) q=true := by
  have facts := plan_facts c data bank source plan checked
  have word := source_word_facts c bank source facts.word
  have wx : x<(wordFor bank source).a := by rw [word.a]; exact hx
  have wy : y<(wordFor bank source).b := by rw [word.b]; exact hy
  have wz : z<(wordFor bank source).c := by rw [word.c]; exact hz
  have cases := (reach_spec _ word.prepared _ _ (checked_planes c data bank source plan checked) x y z wx wy wz).mp reached
  rcases cases with ⟨p,pmem,hit⟩ | ⟨h,hmem,hit⟩
  · obtain ⟨key,keyMem,rfl⟩ := List.mem_map.mp pmem
    obtain ⟨axis,member,j⟩ := key
    have km := (safe_key_mem c data source (axis,member,j)).mp keyMem
    have accepted := List.all_eq_true.mp facts.numeric _ km.1
    have bounds := numeric_bounds c data bank source axis member j _ accepted
    have hm := (numeric_hit c data bank source facts.block facts.word axis member j _ x y z accepted km.2 hx hy hz).mp hit
    refine ⟨CachedPackedCheck.replace (ofCertificate c data) (packed c source x y z) axis j,?_,?_,?_,hm.2⟩
    · apply (CachedPackedCheck.raw_mem _ _ _).mpr
      refine ⟨axis,j,by omega,?_,rfl⟩
      rw [actual_source_id c data source facts.block axis x y z (by omega) hx hy hz,if_pos bounds.1,hm.1]
      exact ((key_mem c data source axis member j).mp km.1).2.2
    · rw [actual_safe c data source facts.block axis j x y z (by omega)
        (by simpa only [if_pos bounds.1] using bounds.2.2) hx hy hz]
      exact km.2
    · exact numeric_ref c data bank source facts.block _ _ _ _ x y z accepted km.2 hx hy hz
  · obtain ⟨j,keyMem,rfl⟩ := List.mem_map.mp hmem
    have km := (honor_key_mem c data source j).mp keyMem
    have accepted := List.all_eq_true.mp facts.honor j km.1
    have bound := honor_bound c data bank source j accepted
    refine ⟨CachedPackedCheck.replace (ofCertificate c data) (packed c source x y z) 3 j,?_,?_,?_,?_⟩
    · apply (CachedPackedCheck.raw_mem _ _ _).mpr
      refine ⟨3,j,by decide,?_,rfl⟩
      rw [actual_source_id c data source facts.block 3 x y z (by decide) hx hy hz]
      exact km.1
    · rw [actual_safe c data source facts.block 3 j x y z (by decide) bound hx hy hz]
      exact km.2
    · exact honor_ref c data bank source j x y z accepted km.2 hx hy hz
    · rw [honor_hit c data bank source facts.word j x y z accepted km.2 hx hy hz] at hit
      exact hit


/-- Exact reach of all actual SAFE cached children, rather than merely a
subset of supplied planes. Both directions use the generated local lists. -/
theorem reach_iff_actual_children (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (bank : Bank) (source : Block) (plan : Plan)
    (checked : checkPlan c data bank source plan=true) (x y z : Nat)
    (hx : x<widthA c source) (hy : y<widthB c source) (hz : z<widthC c source) :
    (TensorReachV19.reach (wordFor bank source) (planes c data bank source plan) (honorWords c data bank source)).testBit
      (originalIndex (wordFor bank source) x y z)=true ↔
    ∃ q, q∈CachedPackedCheck.raw (ofCertificate c data) (packed c source x y z) ∧
      CachedPackedCheck.safeB (ofCertificate c data) q=true ∧ LocalProductStateV19.refB c (target c bank) q=true ∧
      LocalProductStateV19.isP c (target c bank) q=true := by
  constructor
  · intro reached
    exact reaches_successor c data bank source plan checked x y z reached hx hy hz
  · rintro ⟨q,member,safe,_,label⟩
    exact successor_reaches c data bank source plan checked x y z q member safe label hx hy hz

/-- The complete packed Bool checker refines the previous literal row PN
checker for every Cartesian coordinate, without running that row checker. -/
theorem accepted_each (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (bank : Bank) (source : Block) (plan : Plan)
    (checked : checkPlan c data bank source plan=true) (x y z : Nat)
    (hx : x<widthA c source) (hy : y<widthB c source) (hz : z<widthC c source) :
    LocalProductStateV19.checkPN c (ofCertificate c data) (target c bank) (packed c source x y z)
      ((bank.labels (bank.lookup source)).testBit (rank c source x y z))=true := by
  have facts := plan_facts c data bank source plan checked
  have word := source_word_facts c bank source facts.word
  have wx : x<(wordFor bank source).a := by rw [word.a]; exact hx
  have wy : y<(wordFor bank source).b := by rw [word.b]; exact hy
  have wz : z<(wordFor bank source).c := by rw [word.c]; exact hz
  have recurrence := packed_recurrence (wordFor bank source) word.prepared _ _ facts.recurrence x y z wx wy wz
  rw [word.raw,word.a,word.b] at recurrence
  change (bank.labels (bank.lookup source)).testBit (rank c source x y z)=_ at recurrence
  cases sourceP : (bank.labels (bank.lookup source)).testBit (rank c source x y z) with
  | true =>
    simp only [LocalProductStateV19.checkPN,if_true]
    apply List.all_eq_true.mpr
    intro q member
    cases safe : CachedPackedCheck.safeB (ofCertificate c data) q with
    | false => simp only [Bool.not_false,Bool.true_or]
    | true =>
      have ref := successor_ref c data bank source plan checked x y z q member safe hx hy hz
      cases label : LocalProductStateV19.isP c (target c bank) q with
      | false => simp only [ref,Bool.not_true,Bool.not_false,Bool.and_self,Bool.false_or]
      | true =>
        have reached := successor_reaches c data bank source plan checked x y z q member safe label hx hy hz
        rw [sourceP,reached] at recurrence
        cases recurrence
  | false =>
    simp only [LocalProductStateV19.checkPN]
    have reached : (TensorReachV19.reach (wordFor bank source) (planes c data bank source plan) (honorWords c data bank source)).testBit
        (originalIndex (wordFor bank source) x y z)=true := by
      cases reachBit : (TensorReachV19.reach (wordFor bank source) (planes c data bank source plan) (honorWords c data bank source)).testBit
        (originalIndex (wordFor bank source) x y z) with
      | false => rw [sourceP,reachBit] at recurrence; cases recurrence
      | true => rfl
    obtain ⟨q,member,safe,ref,label⟩ := reaches_successor c data bank source plan checked x y z reached hx hy hz
    exact List.any_eq_true.mpr ⟨q,member,by simp only [safe,ref,label,Bool.and_self]⟩

/-- Source SAFE and all four actual axes are inherited from the original
finite certificate/cache. TargetCorrect is only the next-layer induction
hypothesis. No per-row correctness or label/address premise is accepted. -/
theorem packed_normal_strategy (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data)
    (cacheChecked : LocalCertificateV19.Successors.Checked c.toCertificate data) (bank : Bank)
    (correct : TargetCorrect (FullSafeData.summaries (ofCertificate c data).rules) (target c bank))
    (source : Block) (plan : Plan) (accepted : checkPlan c data bank source plan=true) (x y z : Nat)
    (hx : x<widthA c source) (hy : y<widthB c source) (hz : z<widthC c source) :
    IsSafe (originalState c source x y z) ∧
      SafeGame.NormalStrategy SafeMove (originalState c source x y z)
        (GeneralLayer.outcome ((bank.labels (bank.lookup source)).testBit (rank c source x y z))) := by
  apply LocalProductStateV19.row_sound c data cacheChecked (target c bank) correct
    (packed c source x y z) ((bank.labels (bank.lookup source)).testBit (rank c source x y z))
  simp only [LocalProductStateV19.row,
    product_initial c data source (plan_facts c data bank source plan accepted).block x y z hx hy hz,
    accepted_each c data bank source plan accepted x y z hx hy hz,Bool.and_self]

/-- Original 34-kind/four-copy achievement-game strategy, not a toy graph.
The finite block checker covers repeated groups as full Cartesian tuples. -/
theorem packed_original_strategy (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data)
    (cacheChecked : LocalCertificateV19.Successors.Checked c.toCertificate data) (bank : Bank)
    (correct : TargetCorrect (FullSafeData.summaries (ofCertificate c data).rules) (target c bank))
    (source : Block) (plan : Plan) (accepted : checkPlan c data bank source plan=true) (x y z : Nat)
    (hx : x<widthA c source) (hy : y<widthB c source) (hz : z<widthC c source) :
    SafeGame.AchievementStrategy Step Win (originalState c source x y z)
      (GeneralLayer.outcome ((bank.labels (bank.lookup source)).testBit (rank c source x y z))) := by
  exact product_strategy c data cacheChecked (target c bank) correct source
    (plan_facts c data bank source plan accepted).block x y z hx hy hz _
    (accepted_each c data bank source plan accepted x y z hx hy hz)


/-- Regression obligations are symbolic, so they cover every actual input. -/
theorem source_in_target_rejected (c : LocalCertificateV19.GroupedCertificate) (bank : Bank) (source : Block)
    (inside : bank.lookup source<bank.count) : checkSourceWord c bank source=false := by
  cases accepted : checkSourceWord c bank source with
  | false => rfl
  | true =>
    have outside := (source_word_facts c bank source accepted).outside
    omega

theorem missing_numeric_target_rejected (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (bank : Bank) (source : Block)
    (axis member j targetAxis : Nat) (safe : safeNumeric c data source axis j=true)
    (missing : bank.count≤bank.lookup (targetBlock c source axis j)) :
    checkNumeric c data bank source axis member j targetAxis=false := by
  cases accepted : checkNumeric c data bank source axis member j targetAxis with
  | false => rfl
  | true =>
    have numeric := numeric_facts c data bank source axis member j targetAxis accepted safe
    have lookup := (bound_word_facts c bank _ numeric.word).lookup
    have bound : bank.lookup (targetBlock c source axis j)<bank.count := (of_decide_eq_true lookup).1
    omega

theorem bad_target_axis_rejected (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (bank : Bank) (source : Block)
    (axis member j targetAxis : Nat) (safe : safeNumeric c data source axis j=true) (bad : 3≤targetAxis) :
    checkNumeric c data bank source axis member j targetAxis=false := by
  cases accepted : checkNumeric c data bank source axis member j targetAxis with
  | false => rfl
  | true =>
    have numeric := numeric_facts c data bank source axis member j targetAxis accepted safe
    have tags : axis<3 ∧ targetAxis<3 ∧ tags c source axis j=tagPattern axis targetAxis (sourceHonor c source) :=
      of_decide_eq_true numeric.tags
    omega

end Mahjong.LocalProductTensorPlanV19

#print axioms Mahjong.LocalProductTensorPlanV19.bound_word_facts
#print axioms Mahjong.LocalProductTensorPlanV19.numeric_facts
#print axioms Mahjong.LocalProductTensorPlanV19.numeric_label
#print axioms Mahjong.LocalProductTensorPlanV19.numeric_hit
#print axioms Mahjong.LocalProductTensorPlanV19.numeric_ref
#print axioms Mahjong.LocalProductTensorPlanV19.actual_safe
#print axioms Mahjong.LocalProductTensorPlanV19.source_id_generic
#print axioms Mahjong.LocalProductTensorPlanV19.ids_axis
#print axioms Mahjong.LocalProductTensorPlanV19.actual_source_id
#print axioms Mahjong.LocalProductTensorPlanV19.key_mem

#print axioms Mahjong.LocalProductTensorPlanV19.source_normalized
#print axioms Mahjong.LocalProductTensorPlanV19.source_geometry
#print axioms Mahjong.LocalProductTensorPlanV19.source_label
#print axioms Mahjong.LocalProductTensorPlanV19.source_ref
#print axioms Mahjong.LocalProductTensorPlanV19.honor_facts
#print axioms Mahjong.LocalProductTensorPlanV19.honor_hit
#print axioms Mahjong.LocalProductTensorPlanV19.honor_ref

#print axioms Mahjong.LocalProductTensorPlanV19.plan_facts
#print axioms Mahjong.LocalProductTensorPlanV19.member_bound
#print axioms Mahjong.LocalProductTensorPlanV19.numeric_bounds
#print axioms Mahjong.LocalProductTensorPlanV19.honor_bound
#print axioms Mahjong.LocalProductTensorPlanV19.actual_numeric_key
#print axioms Mahjong.LocalProductTensorPlanV19.actual_honor_key

#print axioms Mahjong.LocalProductTensorPlanV19.actual_numeric_metadata
#print axioms Mahjong.LocalProductTensorPlanV19.actual_honor_metadata
#print axioms Mahjong.LocalProductTensorPlanV19.successor_ref
#print axioms Mahjong.LocalProductTensorPlanV19.checked_planes
#print axioms Mahjong.LocalProductTensorPlanV19.successor_reaches
#print axioms Mahjong.LocalProductTensorPlanV19.reaches_successor

#print axioms Mahjong.LocalProductTensorPlanV19.reach_iff_actual_children
#print axioms Mahjong.LocalProductTensorPlanV19.accepted_each
#print axioms Mahjong.LocalProductTensorPlanV19.packed_normal_strategy
#print axioms Mahjong.LocalProductTensorPlanV19.packed_original_strategy

#print axioms Mahjong.LocalProductTensorPlanV19.source_word_facts
#print axioms Mahjong.LocalProductTensorPlanV19.source_outside_target

#print axioms Mahjong.LocalProductTensorPlanV19.source_in_target_rejected
#print axioms Mahjong.LocalProductTensorPlanV19.missing_numeric_target_rejected
#print axioms Mahjong.LocalProductTensorPlanV19.bad_target_axis_rejected
