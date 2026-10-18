import Mahjong.LocalProductStateV19
import Mahjong.TensorLayoutSemanticsV19

set_option autoImplicit false

namespace Mahjong.LocalProductTransitionV19

open PackedRules BlockPlanCheck CachedPackedCheck LocalBlockSoundnessV19
open BlockPlanSoundness (codes Inside AtContext)
open LocalProductStateV19

def tagBase (honor : Nat) : Packed := ⟨0,1,2,honor⟩

def TagBounds (p : Packed) : Prop := ∀ axis, axis<3 → p.get axis<3

theorem map_get (f : Nat → Nat) (p : Packed) (axis : Nat) (bound : axis<3) :
    (MovePlanRefinement.mapNumeric f p).get axis=f (p.get axis) := by
  have choices : axis=0 ∨ axis=1 ∨ axis=2 := by omega
  rcases choices with rfl | rfl | rfl <;> rfl

theorem compare_map (f key imageKey : Nat → Nat) (p : Packed) (a b : Fin 3)
    (bounds : TagBounds p) (agreement : ∀ i, i<3 → imageKey (f i)=key i) :
    MovePlanRefinement.mapNumeric f (SuitSorting.compareSwap key a b p) =
      SuitSorting.compareSwap imageKey a b (MovePlanRefinement.mapNumeric f p) := by
  have ka := agreement (p.get a.val) (bounds a.val a.isLt)
  have kb := agreement (p.get b.val) (bounds b.val b.isLt)
  unfold SuitSorting.compareSwap
  rw [map_get f p a.val a.isLt,map_get f p b.val b.isLt,ka,kb]
  split
  · exact MovePlanRefinement.map_swap f p a b
  · rfl

theorem compare_bounds (key : Nat → Nat) (p : Packed) (a b : Fin 3) (bounds : TagBounds p) :
    TagBounds (SuitSorting.compareSwap key a b p) :=
  SuitSorting.compare_preserves key a b p (fun i => i<3) bounds

theorem sort_map (f key imageKey : Nat → Nat) (p : Packed)
    (bounds : TagBounds p) (agreement : ∀ i, i<3 → imageKey (f i)=key i) :
    MovePlanRefinement.mapNumeric f (SuitSorting.sort key p) =
      SuitSorting.sort imageKey (MovePlanRefinement.mapNumeric f p) := by
  have first := compare_bounds key p 0 1 bounds
  have second := compare_bounds key _ 1 2 first
  unfold SuitSorting.sort
  rw [compare_map f key imageKey _ 0 1 second agreement,
    compare_map f key imageKey _ 1 2 first agreement,compare_map f key imageKey p 0 1 bounds agreement]

def sourceHonor (c : LocalCertificateV19.GroupedCertificate) (source : Block) : Nat := (inventoriesOf c 3).member source.honor

def groupAt (source : Block) (axis : Nat) : Nat := keyGet source.key axis

def changedGroup (c : LocalCertificateV19.GroupedCertificate) (source : Block) (axis j tag : Nat) : Nat :=
  if tag=axis then c.groups.group j else groupAt source tag

def tags (c : LocalCertificateV19.GroupedCertificate) (source : Block) (axis j : Nat) : Packed :=
  SuitSorting.sort (changedGroup c source axis j) (tagBase (sourceHonor c source))

def targetBlock (c : LocalCertificateV19.GroupedCertificate) (source : Block) (axis j : Nat) : Block :=
  let order := tags c source axis j
  ⟨(changedGroup c source axis j order.a,changedGroup c source axis j order.b,
    changedGroup c source axis j order.c),source.honor⟩

def coordinates (x y z : Nat) : Packed := ⟨x,y,z,0⟩

def changedCoordinates (axis member x y z : Nat) : Packed := (coordinates x y z).set axis member

def targetCoordinates (c : LocalCertificateV19.GroupedCertificate) (source : Block) (axis j x y z : Nat) : Packed :=
  MovePlanRefinement.mapNumeric ((changedCoordinates axis (c.groups.member j) x y z).get)
    (tags c source axis j)

theorem tags_bound (c : LocalCertificateV19.GroupedCertificate) (source : Block) (axis j : Nat) : TagBounds (tags c source axis j) := by
  apply SuitSorting.sort_preserves (changedGroup c source axis j) (tagBase (sourceHonor c source)) (fun i => i<3)
  intro tag bound
  have choices : tag=0 ∨ tag=1 ∨ tag=2 := by omega
  rcases choices with rfl | rfl | rfl <;> (simp only [tagBase,Packed.get]; decide)

theorem child_group (c : LocalCertificateV19.GroupedCertificate) (source : Block) (axis j x y z tag : Nat)
    (axisBound : axis<3) (tagBound : tag<3)
    (groups : source.key.1<c.groups.groups ∧ source.key.2.1<c.groups.groups ∧ source.key.2.2<c.groups.groups)
    (hx : x<widthA c source) (hy : y<widthB c source) (hz : z<widthC c source) :
    c.groups.group (((ids c source x y z).set axis j).get tag)=changedGroup c source axis j tag := by
  have facts := ids_facts c source groups x y z hx hy hz
  rw [PackedRules.get_set _ axis tag j (by omega) (by omega)]
  by_cases same : axis=tag
  · simp only [same,if_true,changedGroup]
  · have reverse : tag≠axis := Ne.symm same
    rw [if_neg same]
    simp only [changedGroup,reverse,if_false]
    have choices : tag=0 ∨ tag=1 ∨ tag=2 := by omega
    rcases choices with rfl | rfl | rfl
    · exact facts.2.1
    · exact facts.2.2.1
    · exact facts.2.2.2

theorem child_member (c : LocalCertificateV19.GroupedCertificate) (source : Block) (axis j x y z tag : Nat)
    (axisBound : axis<3) (tagBound : tag<3)
    (groups : source.key.1<c.groups.groups ∧ source.key.2.1<c.groups.groups ∧ source.key.2.2<c.groups.groups)
    (hx : x<widthA c source) (hy : y<widthB c source) (hz : z<widthC c source) :
    c.groups.member (((ids c source x y z).set axis j).get tag)=
      (changedCoordinates axis (c.groups.member j) x y z).get tag := by
  have a := GroupInventory.coordinate_inverse c.groups c.groupChecked source.key.1 x groups.1 hx
  have b := GroupInventory.coordinate_inverse c.groups c.groupChecked source.key.2.1 y groups.2.1 hy
  have cc := GroupInventory.coordinate_inverse c.groups c.groupChecked source.key.2.2 z groups.2.2 hz
  rw [PackedRules.get_set _ axis tag j (by omega) (by omega)]
  unfold changedCoordinates
  rw [PackedRules.get_set _ axis tag (c.groups.member j) (by omega) (by omega)]
  split
  · rfl
  · have choices : tag=0 ∨ tag=1 ∨ tag=2 := by omega
    rcases choices with rfl | rfl | rfl
    · exact a.2.2
    · exact b.2.2
    · exact cc.2.2

theorem sort_actual_ids (c : LocalCertificateV19.GroupedCertificate) (source : Block) (axis j x y z : Nat)
    (axisBound : axis<3)
    (groups : source.key.1<c.groups.groups ∧ source.key.2.1<c.groups.groups ∧ source.key.2.2<c.groups.groups)
    (hx : x<widthA c source) (hy : y<widthB c source) (hz : z<widthC c source) :
    normalizeIds c ((ids c source x y z).set axis j) =
      MovePlanRefinement.mapNumeric (((ids c source x y z).set axis j).get) (tags c source axis j) := by
  have raw : MovePlanRefinement.mapNumeric (((ids c source x y z).set axis j).get)
      (tagBase (sourceHonor c source)) = (ids c source x y z).set axis j := by
    have choices : axis=0 ∨ axis=1 ∨ axis=2 := by omega
    rcases choices with rfl | rfl | rfl <;> rfl
  have bound : TagBounds (tagBase (sourceHonor c source)) := by
    intro tag hb
    have choices : tag=0 ∨ tag=1 ∨ tag=2 := by omega
    rcases choices with rfl | rfl | rfl <;> (simp only [tagBase,Packed.get]; decide)
  have result := sort_map (((ids c source x y z).set axis j).get) (changedGroup c source axis j)
    c.groups.group (tagBase (sourceHonor c source)) bound
    (fun tag hb => child_group c source axis j x y z tag axisBound hb groups hx hy hz)
  rw [raw] at result
  exact result.symm

theorem target_members (c : LocalCertificateV19.GroupedCertificate) (source : Block) (axis j x y z : Nat)
    (axisBound : axis<3)
    (groups : source.key.1<c.groups.groups ∧ source.key.2.1<c.groups.groups ∧ source.key.2.2<c.groups.groups)
    (hx : x<widthA c source) (hy : y<widthB c source) (hz : z<widthC c source) :
    let q := normalizeIds c ((ids c source x y z).set axis j)
    (c.groups.member q.a,c.groups.member q.b,c.groups.member q.c) =
      ((targetCoordinates c source axis j x y z).a,(targetCoordinates c source axis j x y z).b,
        (targetCoordinates c source axis j x y z).c) := by
  dsimp only
  rw [sort_actual_ids c source axis j x y z axisBound groups hx hy hz]
  have bounds := tags_bound c source axis j
  have a := child_member c source axis j x y z (tags c source axis j).a axisBound (bounds 0 (by decide)) groups hx hy hz
  have b := child_member c source axis j x y z (tags c source axis j).b axisBound (bounds 1 (by decide)) groups hx hy hz
  have cc := child_member c source axis j x y z (tags c source axis j).c axisBound (bounds 2 (by decide)) groups hx hy hz
  dsimp only [MovePlanRefinement.mapNumeric,targetCoordinates]
  rw [a,b,cc]

theorem target_block (c : LocalCertificateV19.GroupedCertificate) (source : Block) (axis j x y z : Nat)
    (axisBound : axis<3) (sourceChecked : LocalProductStateV19.checkBlock c source=true)
    (hx : x<widthA c source) (hy : y<widthB c source) (hz : z<widthC c source) :
    blockOf c (normalizeIds c ((ids c source x y z).set axis j))=targetBlock c source axis j := by
  have parts := block_parts c source sourceChecked
  have groups : source.key.1<c.groups.groups ∧ source.key.2.1<c.groups.groups ∧ source.key.2.2<c.groups.groups :=
    ⟨parts.1.1,parts.1.2.1,parts.1.2.2.1⟩
  rw [sort_actual_ids c source axis j x y z axisBound groups hx hy hz]
  have bounds := tags_bound c source axis j
  have a := child_group c source axis j x y z (tags c source axis j).a axisBound (bounds 0 (by decide)) groups hx hy hz
  have b := child_group c source axis j x y z (tags c source axis j).b axisBound (bounds 1 (by decide)) groups hx hy hz
  have cc := child_group c source axis j x y z (tags c source axis j).c axisBound (bounds 2 (by decide)) groups hx hy hz
  have honor := (CanonicalInventory.checked_member 3 (inventoriesOf c 3) (c.inventoryChecked 3 (by decide))
    source.honor parts.1.2.2.2.2.2).2
  dsimp only [blockOf,MovePlanRefinement.mapNumeric,targetBlock]
  rw [a,b,cc]
  have unchanged : (tags c source axis j).h=(inventoriesOf c 3).member source.honor :=
    SuitSorting.sort_honor (changedGroup c source axis j) (tagBase (sourceHonor c source))
  rw [unchanged,honor]

def freePair (axis : Nat) (p : Packed) : Nat × Nat :=
  if axis=0 then (p.b,p.c) else if axis=1 then (p.a,p.c) else (p.a,p.b)

def insert (axis member u v honor : Nat) : Packed :=
  if axis=0 then ⟨member,u,v,honor⟩ else if axis=1 then ⟨u,member,v,honor⟩ else ⟨u,v,member,honor⟩

def tagPattern (sourceAxis targetAxis honor : Nat) : Packed :=
  let pair := freePair sourceAxis (tagBase honor)
  insert targetAxis sourceAxis pair.1 pair.2 honor

/-- Only three tags are sorted/compared. No actual coordinate is scanned. -/
def checkTags (c : LocalCertificateV19.GroupedCertificate) (source : Block) (axis j targetAxis : Nat) : Bool :=
  decide (axis<3 ∧ targetAxis<3 ∧ tags c source axis j=tagPattern axis targetAxis (sourceHonor c source))

theorem targetCoordinates_insert (c : LocalCertificateV19.GroupedCertificate) (source : Block) (axis j targetAxis x y z : Nat)
    (accepted : checkTags c source axis j targetAxis=true) :
    targetCoordinates c source axis j x y z =
      insert targetAxis (c.groups.member j)
        (freePair axis (coordinates x y z)).1 (freePair axis (coordinates x y z)).2 (sourceHonor c source) := by
  have facts : axis<3 ∧ targetAxis<3 ∧ tags c source axis j=tagPattern axis targetAxis (sourceHonor c source) :=
    of_decide_eq_true accepted
  rw [targetCoordinates,facts.2.2]
  have sourceAxes : axis=0 ∨ axis=1 ∨ axis=2 := by omega
  have targetAxes : targetAxis=0 ∨ targetAxis=1 ∨ targetAxis=2 := by omega
  rcases sourceAxes with rfl | rfl | rfl <;> rcases targetAxes with rfl | rfl | rfl <;> rfl

def freeDimensions (w : TensorReachV19.Word) (axis : Nat) : Nat × Nat :=
  if axis=0 then (w.b,w.c) else if axis=1 then (w.a,w.c) else (w.a,w.b)

def freeExponents (w : TensorReachV19.Word) (axis : Nat) : Nat × Nat :=
  if axis=0 then (w.bp,w.cp) else if axis=1 then (w.ap,w.cp) else (w.ap,w.bp)

def checkFree (source target : TensorReachV19.Word) (axis targetAxis : Nat) : Bool :=
  decide (axis<3 ∧ targetAxis<3 ∧ freeDimensions source axis=freeDimensions target targetAxis ∧
    freeExponents source axis=freeExponents target targetAxis)

theorem inserted_bounds (source target : TensorReachV19.Word) (axis targetAxis member x y z honor : Nat)
    (freeChecked : checkFree source target axis targetAxis=true) (memberBound : member<target.size targetAxis)
    (hx : x<source.a) (hy : y<source.b) (hz : z<source.c) :
    let q := insert targetAxis member (freePair axis (coordinates x y z)).1
      (freePair axis (coordinates x y z)).2 honor
    q.a<target.a ∧ q.b<target.b ∧ q.c<target.c := by
  have facts : axis<3 ∧ targetAxis<3 ∧ freeDimensions source axis=freeDimensions target targetAxis ∧
      freeExponents source axis=freeExponents target targetAxis := of_decide_eq_true freeChecked
  have sourceAxes : axis=0 ∨ axis=1 ∨ axis=2 := by omega
  have targetAxes : targetAxis=0 ∨ targetAxis=1 ∨ targetAxis=2 := by omega
  rcases sourceAxes with rfl | rfl | rfl <;> rcases targetAxes with rfl | rfl | rfl
  all_goals simp only [freeDimensions,TensorReachV19.Word.size,insert,freePair,coordinates,
    show ¬1=0 by decide,show ¬2=0 by decide,show ¬2=1 by decide,if_true,if_false,Prod.mk.injEq] at facts memberBound ⊢
  all_goals obtain ⟨_,_,⟨e1,e2⟩,_⟩ := facts
  all_goals omega

theorem inserted_member (axis member u v honor : Nat) (bound : axis<3) :
    let q := insert axis member u v honor
    TensorLayoutSemanticsV19.memberIndex axis q.a q.b q.c=member := by
  have choices : axis=0 ∨ axis=1 ∨ axis=2 := by omega
  rcases choices with rfl | rfl | rfl <;> rfl

theorem inserted_freeIndex (source target : TensorReachV19.Word) (axis targetAxis member x y z honor : Nat)
    (freeChecked : checkFree source target axis targetAxis=true) :
    let q := insert targetAxis member (freePair axis (coordinates x y z)).1
      (freePair axis (coordinates x y z)).2 honor
    TensorLayoutSemanticsV19.freeIndex target targetAxis q.a q.b q.c =
      TensorLayoutSemanticsV19.freeIndex source axis x y z := by
  have facts : axis<3 ∧ targetAxis<3 ∧ freeDimensions source axis=freeDimensions target targetAxis ∧
      freeExponents source axis=freeExponents target targetAxis := of_decide_eq_true freeChecked
  have sourceAxes : axis=0 ∨ axis=1 ∨ axis=2 := by omega
  have targetAxes : targetAxis=0 ∨ targetAxis=1 ∨ targetAxis=2 := by omega
  rcases sourceAxes with rfl | rfl | rfl <;> rcases targetAxes with rfl | rfl | rfl
  all_goals simp only [freeExponents,TensorLayoutSemanticsV19.freeIndex,insert,freePair,coordinates,
    show ¬1=0 by decide,show ¬2=0 by decide,show ¬2=1 by decide,if_true,if_false,Prod.mk.injEq] at facts ⊢
  all_goals rw [facts.2.2.2.1]

theorem plane_target_read (source : TensorReachV19.Word) (p : TensorReachV19.Plane)
    (targetChecked : TensorLayoutSemanticsV19.checkWord p.target=true)
    (planeChecked : TensorReachV19.checkPlane source p=true)
    (freeChecked : checkFree source p.target p.axis p.targetAxis=true)
    (x y z : Nat) (hx : x<source.a) (hy : y<source.b) (hz : z<source.c) :
    let q := insert p.targetAxis p.targetMember (freePair p.axis (coordinates x y z)).1
      (freePair p.axis (coordinates x y z)).2 0
    (p.target.layout p.targetAxis).testBit (p.targetMember*p.target.free p.targetAxis+
      TensorLayoutSemanticsV19.freeIndex source p.axis x y z) =
      p.target.raw.testBit (PadTensorV19.rawIndex p.target.a p.target.b q.a q.b q.c) := by
  have facts : p.axis<3 ∧ p.targetAxis<3 ∧ p.sourceMember<source.size p.axis ∧
      p.targetMember<p.target.size p.targetAxis ∧ source.free p.axis=p.target.free p.targetAxis :=
    of_decide_eq_true planeChecked
  let q := insert p.targetAxis p.targetMember (freePair p.axis (coordinates x y z)).1
    (freePair p.axis (coordinates x y z)).2 0
  have bounds := inserted_bounds source p.target p.axis p.targetAxis p.targetMember x y z 0
    freeChecked facts.2.2.2.1 hx hy hz
  have layout := TensorLayoutSemanticsV19.layout_read p.target targetChecked p.targetAxis facts.2.1
    q.a q.b q.c bounds.1 bounds.2.1 bounds.2.2
  rw [TensorLayoutSemanticsV19.axisIndex_parts p.target p.targetAxis facts.2.1,
    inserted_member p.targetAxis p.targetMember _ _ 0 facts.2.1,
    inserted_freeIndex source p.target p.axis p.targetAxis p.targetMember x y z 0 freeChecked] at layout
  exact layout

end Mahjong.LocalProductTransitionV19

#print axioms Mahjong.LocalProductTransitionV19.sort_map
#print axioms Mahjong.LocalProductTransitionV19.tags_bound
#print axioms Mahjong.LocalProductTransitionV19.child_group
#print axioms Mahjong.LocalProductTransitionV19.child_member
#print axioms Mahjong.LocalProductTransitionV19.sort_actual_ids
#print axioms Mahjong.LocalProductTransitionV19.target_members
#print axioms Mahjong.LocalProductTransitionV19.target_block
#print axioms Mahjong.LocalProductTransitionV19.targetCoordinates_insert
#print axioms Mahjong.LocalProductTransitionV19.inserted_bounds
#print axioms Mahjong.LocalProductTransitionV19.inserted_freeIndex
#print axioms Mahjong.LocalProductTransitionV19.plane_target_read
