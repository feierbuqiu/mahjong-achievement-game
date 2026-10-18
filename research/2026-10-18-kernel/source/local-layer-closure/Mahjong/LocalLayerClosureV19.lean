import Mahjong.LocalGroupChannelV19

set_option autoImplicit false

/-! A finite descending original-game strategy closure. Layers need not be
complete global directories, need not be unique, and have no assumed SAFE
height bound. All actual SAFE children of each certified source are checked
by the previously proved packed/group-channel checker. Source and target
words come from the SAME family below, not an external hash/ledger assertion.
No actual family, local certificate or root acceptance is supplied here. -/

namespace Mahjong.LocalLayerClosureV19

open PackedRules GeneralLayer SafeGame
open LocalProductStateV19
open LocalProductTensorPlanV19 (Bank)

abbrev Family := Nat → Bank

def layerTarget (c : LocalCertificateV19.GroupedCertificate) (layer : Bank) : Target :=
  LocalProductTensorPlanV19.target c layer

/-- A current source occupies a fresh OUTSIDE slot of the next Target.
The in-range target data are definitionally the next family layer. Source
aliasing with an actual child block is therefore rejected by checkBoundWord.
This is a data construction, not an assumed source/target-correctness Prop. -/
def sourceBank (family : Family) (layer bucket : Nat) : Bank where
  count := (family (layer+1)).count
  blocks := (family (layer+1)).blocks
  labels := fun i => if i < (family (layer+1)).count then (family (layer+1)).labels i
    else (family layer).labels bucket
  lookup := fun block => if block = (family layer).blocks bucket then (family (layer+1)).count
    else (family (layer+1)).lookup block
  words := fun i => if i < (family (layer+1)).count then (family (layer+1)).words i
    else (family layer).words bucket

theorem source_slot (family : Family) (layer bucket : Nat) :
    (sourceBank family layer bucket).lookup ((family layer).blocks bucket) = (family (layer+1)).count := by
  simp [sourceBank]

theorem source_label (family : Family) (layer bucket : Nat) :
    (sourceBank family layer bucket).labels
      ((sourceBank family layer bucket).lookup ((family layer).blocks bucket)) = (family layer).labels bucket := by
  rw [source_slot]
  simp only [sourceBank, Nat.lt_irrefl, ↓reduceIte]

theorem source_word (family : Family) (layer bucket : Nat) :
    LocalProductTensorPlanV19.wordFor (sourceBank family layer bucket) ((family layer).blocks bucket) =
      (family layer).words bucket := by
  unfold LocalProductTensorPlanV19.wordFor
  rw [source_slot]
  simp only [sourceBank, Nat.lt_irrefl, ↓reduceIte]

theorem source_outside (c : LocalCertificateV19.GroupedCertificate) (family : Family) (layer bucket : Nat) :
    (layerTarget c (sourceBank family layer bucket)).size
      ((sourceBank family layer bucket).lookup ((family layer).blocks bucket)) = 0 := by
  rw [source_slot]
  simp only [layerTarget,LocalProductTensorPlanV19.target,productTarget,sourceBank,Nat.lt_irrefl,↓reduceIte]

/-- Correctness of the next layer transfers without any label/hash equality
premise. TargetCorrect never reads locate, and all its in-range getters are
the same next-layer data by construction. -/
theorem next_correct (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data)
    (family : Family) (layer bucket : Nat)
    (correct : TargetCorrect (FullSafeData.summaries (LocalBlockSoundnessV19.ofCertificate c data).rules)
      (layerTarget c (family (layer+1)))) :
    TargetCorrect (FullSafeData.summaries (LocalBlockSoundnessV19.ofCertificate c data).rules)
      (layerTarget c (sourceBank family layer bucket)) := by
  intro b r bound
  have inRange : b < (family (layer+1)).count := by
    by_cases inside : b < (family (layer+1)).count
    · exact inside
    · change r < (if b < (family (layer+1)).count then size c ((family (layer+1)).blocks b) else 0) at bound
      rw [if_neg inside] at bound
      omega
  have targetBound : r < (layerTarget c (family (layer+1))).size b := by
    exact bound
  have result := correct b r targetBound
  simpa only [layerTarget,LocalProductTensorPlanV19.target,productTarget,sourceBank,if_pos inRange] using result

/-- A generic finite arithmetic identity, not an enumeration of row ranks. -/
theorem rank_unrank_index (a b r : Nat) :
    PadTensorV19.rawIndex a b (r%a) ((r/a)%b) (r/(a*b)) = r := by
  rw [PadTensorV19.rawIndex, ← Nat.div_div_eq_div_mul, Nat.div_add_mod, Nat.div_add_mod]

theorem unrank_bounds (a b d r : Nat) (bound : r < a*b*d) :
    r%a<a ∧ (r/a)%b<b ∧ r/(a*b)<d := by
  have ha : 0<a := by
    by_cases zero : a=0
    · simp only [zero,Nat.zero_mul] at bound
      omega
    · omega
  have hb : 0<b := by
    by_cases zero : b=0
    · simp only [zero,Nat.mul_zero,Nat.zero_mul] at bound
      omega
    · omega
  refine ⟨Nat.mod_lt _ ha,Nat.mod_lt _ hb,?_⟩
  apply (Nat.div_lt_iff_lt_mul (Nat.mul_pos ha hb)).mpr
  simpa only [Nat.mul_comm d (a*b)] using bound

def checkLayer (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data)
    (family : Family) (channels : GroupChannelV19.Channels) (choose : Nat → Nat → Nat → Nat → Nat)
    (layer : Nat) : Bool :=
  (List.range (family layer).count).all (fun bucket =>
    LocalGroupChannelV19.checkPacked c data (sourceBank family layer bucket) ((family layer).blocks bucket)
      channels (choose layer bucket))

theorem checkLayer_each (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data)
    (family : Family) (channels : GroupChannelV19.Channels) (choose : Nat → Nat → Nat → Nat → Nat)
    (layer bucket : Nat) (accepted : checkLayer c data family channels choose layer=true)
    (bound : bucket < (family layer).count) :
    LocalGroupChannelV19.checkPacked c data (sourceBank family layer bucket) ((family layer).blocks bucket)
      channels (choose layer bucket)=true :=
  List.all_eq_true.mp accepted bucket (List.mem_range.mpr bound)

/-- Every source row receives a strategy by the complete actual-child
packed theorem; there is no rowwise strategy/PN premise in this interface. -/
theorem layer_correct (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data)
    (cacheChecked : LocalCertificateV19.Successors.Checked c.toCertificate data)
    (family : Family) (channels : GroupChannelV19.Channels) (choose : Nat → Nat → Nat → Nat → Nat)
    (globalChannels : GroupChannelV19.checkGlobal c.groups data channels=true) (layer : Nat)
    (next : TargetCorrect (FullSafeData.summaries (LocalBlockSoundnessV19.ofCertificate c data).rules)
      (layerTarget c (family (layer+1))))
    (accepted : checkLayer c data family channels choose layer=true) :
    TargetCorrect (FullSafeData.summaries (LocalBlockSoundnessV19.ofCertificate c data).rules)
      (layerTarget c (family layer)) := by
  intro bucket r bound
  have inRange : bucket < (family layer).count := by
    by_cases inside : bucket < (family layer).count
    · exact inside
    · change r < (if bucket < (family layer).count then size c ((family layer).blocks bucket) else 0) at bound
      rw [if_neg inside] at bound
      omega
  have rowBound : r < size c ((family layer).blocks bucket) := by
    simpa only [layerTarget,LocalProductTensorPlanV19.target,productTarget,if_pos inRange] using bound
  have coords := unrank_bounds (widthA c ((family layer).blocks bucket))
    (widthB c ((family layer).blocks bucket)) (widthC c ((family layer).blocks bucket)) r rowBound
  have blockChecked := checkLayer_each c data family channels choose layer bucket accepted inRange
  have planChecked := LocalGroupChannelV19.packed_refines c data (sourceBank family layer bucket)
    ((family layer).blocks bucket) channels (choose layer bucket) globalChannels blockChecked
  have strategy := (LocalProductTensorPlanV19.packed_normal_strategy c data cacheChecked (sourceBank family layer bucket)
    (next_correct c data family layer bucket next) ((family layer).blocks bucket)
    (LocalGroupChannelV19.plan c (choose layer bucket)) planChecked
    (r%widthA c ((family layer).blocks bucket)) ((r/widthA c ((family layer).blocks bucket))%widthB c ((family layer).blocks bucket))
    (r/(widthA c ((family layer).blocks bucket)*widthB c ((family layer).blocks bucket)))
    coords.1 coords.2.1 coords.2.2).2
  rw [source_label] at strategy
  have rankEq : rank c ((family layer).blocks bucket)
      (r%widthA c ((family layer).blocks bucket)) ((r/widthA c ((family layer).blocks bucket))%widthB c ((family layer).blocks bucket))
      (r/(widthA c ((family layer).blocks bucket)*widthB c ((family layer).blocks bucket))) = r :=
    rank_unrank_index _ _ _
  rw [rankEq] at strategy
  change NormalStrategy SafeMove
    (Base5Coverage.unpack (unrank c ((family layer).blocks bucket) r))
    (outcome (((family layer).labels bucket).testBit r)) at strategy
  exact strategy

theorem empty_correct (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data)
    (bank : Bank) (emptyChecked : bank.count=0) :
    TargetCorrect (FullSafeData.summaries (LocalBlockSoundnessV19.ofCertificate c data).rules) (layerTarget c bank) := by
  intro bucket r bound
  simp only [layerTarget,LocalProductTensorPlanV19.target,productTarget,emptyChecked,Nat.not_lt_zero,↓reduceIte] at bound

/-- The final layer is checked empty. This does NOT assume that all SAFE
states globally have at most 34 tiles. If a checked source has an omitted
SAFE child, the exact target lookup check cannot pass. -/
def checkLayers (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data)
    (family : Family) (channels : GroupChannelV19.Channels) (choose : Nat → Nat → Nat → Nat → Nat) : Nat → Nat → Bool
  | layer, 0 => decide ((family layer).count=0)
  | layer, depth+1 => checkLayer c data family channels choose layer &&
      checkLayers c data family channels choose (layer+1) depth

theorem layers_correct (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data)
    (cacheChecked : LocalCertificateV19.Successors.Checked c.toCertificate data)
    (family : Family) (channels : GroupChannelV19.Channels) (choose : Nat → Nat → Nat → Nat → Nat)
    (globalChannels : GroupChannelV19.checkGlobal c.groups data channels=true) (layer depth : Nat)
    (accepted : checkLayers c data family channels choose layer depth=true) :
    TargetCorrect (FullSafeData.summaries (LocalBlockSoundnessV19.ofCertificate c data).rules) (layerTarget c (family layer)) := by
  induction depth generalizing layer with
  | zero =>
    exact empty_correct c data (family layer) (of_decide_eq_true accepted)
  | succ depth ih =>
    have parts : checkLayer c data family channels choose layer=true ∧
        checkLayers c data family channels choose (layer+1) depth=true := by
      simpa only [checkLayers,Bool.and_eq_true] using accepted
    exact layer_correct c data cacheChecked family channels choose globalChannels layer
      (ih (layer+1) parts.2) parts.1

def checkSuccessors (c : LocalCertificateV19.Certificate) (data : Nat → SuccessorCache.Data) : Bool :=
  (List.range 4).all (fun b => CanonicalInventory.checkSpan
    (SuccessorCache.checkRow b (LocalCertificateV19.inventoriesOf c b) (LocalCertificateV19.Successors.summaries c b) (data b))
    0 (LocalCertificateV19.inventoriesOf c b).count)

theorem successors_checked (c : LocalCertificateV19.Certificate) (data : Nat → SuccessorCache.Data)
    (accepted : checkSuccessors c data=true) : LocalCertificateV19.Successors.Checked c data := by
  intro b bound
  exact List.all_eq_true.mp accepted b (List.mem_range.mpr bound)

structure Root where
  bucket : Nat
  index : Nat
  deriving DecidableEq

/-- Root identity is an executable finite packed-zero comparison. In a
concrete data instance one may use bucket/group/ordinal zero, but those
numbers are not trusted to mean the empty physical state without this test. -/
def checkRoot (c : LocalCertificateV19.GroupedCertificate) (layer : Bank) (root : Root) : Bool :=
  decide (root.bucket<layer.count ∧ root.index<size c (layer.blocks root.bucket) ∧
    unrank c (layer.blocks root.bucket) root.index = Packed.mk 0 0 0 0) &&
    (layer.labels root.bucket).testBit root.index

theorem unpack_zero : Base5Coverage.unpack (Packed.mk 0 0 0 0) = empty := by
  have packedEmpty : Base5Coverage.pack empty = Packed.mk 0 0 0 0 := by decide +kernel
  rw [← packedEmpty,Base5Coverage.unpack_pack empty empty_valid]

theorem root_sound (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data)
    (layer : Bank) (root : Root)
    (correct : TargetCorrect (FullSafeData.summaries (LocalBlockSoundnessV19.ofCertificate c data).rules) (layerTarget c layer))
    (accepted : checkRoot c layer root=true) : SecondPlayerWins Step Win empty := by
  have parts : (root.bucket<layer.count ∧ root.index<size c (layer.blocks root.bucket) ∧
      unrank c (layer.blocks root.bucket) root.index=Packed.mk 0 0 0 0) ∧
      (layer.labels root.bucket).testBit root.index=true := by
    simpa only [checkRoot,Bool.and_eq_true,decide_eq_true_eq] using accepted
  have bound : root.index < (layerTarget c layer).size root.bucket := by
    simpa only [layerTarget,LocalProductTensorPlanV19.target,productTarget,if_pos parts.1.1] using parts.1.2.1
  have result := correct root.bucket root.index bound
  change NormalStrategy SafeMove (Base5Coverage.unpack (unrank c (layer.blocks root.bucket) root.index))
    (outcome ((layer.labels root.bucket).testBit root.index)) at result
  rw [parts.1.2.2,unpack_zero,parts.2] at result
  exact original_second_player_wins_of_safe_P result

def checkAll (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data)
    (family : Family) (channels : GroupChannelV19.Channels) (choose : Nat → Nat → Nat → Nat → Nat)
    (depth : Nat) (root : Root) : Bool :=
  checkSuccessors c.toCertificate data && GroupChannelV19.checkGlobal c.groups data channels &&
    checkLayers c data family channels choose 0 depth && checkRoot c (family 0) root

/-- Final conditional empty-game theorem. It has NO TargetCorrect, arbitrary
row-strategy, global-directory or global SAFE-height premise. Its finite
Bool checks and the original local-only metadata certificate still need an
actual closed accepted instance; this source does not claim one exists. -/
theorem empty_second_player_wins (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data)
    (family : Family) (channels : GroupChannelV19.Channels) (choose : Nat → Nat → Nat → Nat → Nat)
    (depth : Nat) (root : Root) (accepted : checkAll c data family channels choose depth root=true) :
    SecondPlayerWins Step Win empty := by
  have parts : ((checkSuccessors c.toCertificate data=true ∧ GroupChannelV19.checkGlobal c.groups data channels=true) ∧
      checkLayers c data family channels choose 0 depth=true) ∧ checkRoot c (family 0) root=true := by
    simpa only [checkAll,Bool.and_eq_true] using accepted
  exact root_sound c data (family 0) root
    (layers_correct c data (successors_checked c.toCertificate data parts.1.1.1)
      family channels choose parts.1.1.2 0 depth parts.1.2) parts.2

/-- Generic negative controls: a nonempty terminus or a nonempty physical
root is rejected regardless of proposed labels or previous JSON results. -/
theorem nonempty_terminus_rejected (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data)
    (family : Family) (channels : GroupChannelV19.Channels) (choose : Nat → Nat → Nat → Nat → Nat)
    (layer : Nat) (nonempty : (family layer).count≠0) :
    checkLayers c data family channels choose layer 0=false := by
  simp only [checkLayers,decide_eq_false nonempty]

theorem wrong_root_rejected (c : LocalCertificateV19.GroupedCertificate) (layer : Bank) (root : Root)
    (wrong : unrank c (layer.blocks root.bucket) root.index≠Packed.mk 0 0 0 0) : checkRoot c layer root=false := by
  simp only [checkRoot,wrong,and_false,decide_false,Bool.false_and]

end Mahjong.LocalLayerClosureV19

#print axioms Mahjong.LocalLayerClosureV19.source_slot
#print axioms Mahjong.LocalLayerClosureV19.source_label
#print axioms Mahjong.LocalLayerClosureV19.source_word
#print axioms Mahjong.LocalLayerClosureV19.source_outside
#print axioms Mahjong.LocalLayerClosureV19.next_correct
#print axioms Mahjong.LocalLayerClosureV19.rank_unrank_index
#print axioms Mahjong.LocalLayerClosureV19.unrank_bounds
#print axioms Mahjong.LocalLayerClosureV19.checkLayer_each
#print axioms Mahjong.LocalLayerClosureV19.layer_correct
#print axioms Mahjong.LocalLayerClosureV19.empty_correct
#print axioms Mahjong.LocalLayerClosureV19.layers_correct
#print axioms Mahjong.LocalLayerClosureV19.successors_checked
#print axioms Mahjong.LocalLayerClosureV19.unpack_zero
#print axioms Mahjong.LocalLayerClosureV19.root_sound
#print axioms Mahjong.LocalLayerClosureV19.empty_second_player_wins
#print axioms Mahjong.LocalLayerClosureV19.nonempty_terminus_rejected
#print axioms Mahjong.LocalLayerClosureV19.wrong_root_rejected
