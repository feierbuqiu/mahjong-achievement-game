import Mahjong.LocalProductTensorPlanV19
import Mahjong.GroupChannelV19

set_option autoImplicit false

namespace Mahjong.LocalGroupChannelV19
open BlockPlanSoundness (codes Inside AtContext)
open LocalBlockSoundnessV19 CachedPackedCheck BlockPlanCheck PackedRules
open LocalProductStateV19 LocalProductTransitionV19 TensorLayoutSemanticsV19
open GroupChannelV19 (Channel Channels actualId localTargets checkChannel checkGroup checkGlobal
  channel_facts group_facts global_group actual_next_iff move_ids apply apply_read)

/-! The global channel matrix and its operator are generic and reused
unchanged. Only original-game local rule/group facts are required below.
No full GlobalEnumeration.Certificate is accepted or constructed. -/

theorem tensor_key_iff (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (channels : Channels)
    (accepted : checkGlobal c.groups data channels=true) (source : Block)
    (sourceChecked : LocalProductStateV19.checkBlock c source=true) (axis member j : Nat) :
    (axis,member,j)∈LocalProductTensorPlanV19.keys c data source ↔
      axis<3 ∧ member<c.groups.size (groupAt source axis) ∧
      ∃ channel, channel∈channels (groupAt source axis) ∧
        ∃ move, move∈channel.moves ∧ move.1=member ∧ actualId c.groups channel move.2=j := by
  rw [LocalProductTensorPlanV19.key_mem]
  constructor
  · rintro ⟨ha,hm,hj⟩
    have groups := LocalProductTensorPlanV19.source_groups c source sourceChecked
    have gb : groupAt source axis<c.groups.groups := by
      have choices : axis=0 ∨ axis=1 ∨ axis=2 := by omega
      rcases choices with rfl|rfl|rfl
      · exact groups.1
      · exact groups.2.1
      · exact groups.2.2
    exact ⟨ha,hm,(actual_next_iff c.groups (data axis) _ _ (global_group c.groups data channels accepted axis _ ha gb) member j hm).mp hj⟩
  · rintro ⟨ha,hm,hj⟩
    have groups := LocalProductTensorPlanV19.source_groups c source sourceChecked
    have gb : groupAt source axis<c.groups.groups := by
      have choices : axis=0 ∨ axis=1 ∨ axis=2 := by omega
      rcases choices with rfl|rfl|rfl
      · exact groups.1
      · exact groups.2.1
      · exact groups.2.2
    exact ⟨ha,hm,(actual_next_iff c.groups (data axis) _ _ (global_group c.groups data channels accepted axis _ ha gb) member j hm).mpr hj⟩


theorem same_group_safe (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (source : Block)
    (axis j k : Nat) (axisBound : axis<3) (groupEq : c.groups.group j=c.groups.group k) :
    LocalProductTensorPlanV19.safeNumeric c data source axis j=LocalProductTensorPlanV19.safeNumeric c data source axis k := by
  have notHonor : axis≠3 := by omega
  simp only [LocalProductTensorPlanV19.safeNumeric,expectedSafe,BlockPlanCheck.labels,if_neg notHonor,groupEq]

theorem same_group_tags (c : LocalCertificateV19.GroupedCertificate) (source : Block) (axis j k : Nat)
    (groupEq : c.groups.group j=c.groups.group k) : tags c source axis j=tags c source axis k := by
  have groups : changedGroup c source axis j=changedGroup c source axis k := by
    funext tag
    simp only [changedGroup,groupEq]
  unfold tags
  rw [groups]

theorem same_group_block (c : LocalCertificateV19.GroupedCertificate) (source : Block) (axis j k : Nat)
    (groupEq : c.groups.group j=c.groups.group k) : targetBlock c source axis j=targetBlock c source axis k := by
  have groups : changedGroup c source axis j=changedGroup c source axis k := by
    funext tag
    simp only [changedGroup,groupEq]
  unfold targetBlock
  rw [same_group_tags c source axis j k groupEq,groups]

theorem same_group_checkTags (c : LocalCertificateV19.GroupedCertificate) (source : Block) (axis j k targetAxis : Nat)
    (groupEq : c.groups.group j=c.groups.group k) :
    checkTags c source axis j targetAxis=checkTags c source axis k targetAxis := by
  unfold checkTags
  rw [same_group_tags c source axis j k groupEq]

def representative (g : GroupInventory.Data) (channel : Channel) : Nat := g.first channel.targetGroup

/-- A block checks only one representative geometry/target/SAFE template
per globally certified channel, plus two exact dimension scalars. -/
def checkBlockChannel (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (bank : LocalProductTensorPlanV19.Bank) (source : Block)
    (axis : Nat) (channel : Channel) (targetAxis : Nat) : Bool :=
  let j := representative c.groups channel
  if LocalProductTensorPlanV19.safeNumeric c data source axis j then
    LocalProductTensorPlanV19.checkNumeric c data bank source axis 0 j targetAxis &&
    decide ((LocalProductTensorPlanV19.wordFor bank source).size axis=c.groups.size (groupAt source axis) ∧
      (LocalProductTensorPlanV19.wordFor bank (targetBlock c source axis j)).size targetAxis=c.groups.size channel.targetGroup)
  else true

theorem representative_facts (g : GroupInventory.Data) (checked : GroupInventory.Checked g) (sourceGroup : Nat) (channel : Channel)
    (accepted : checkChannel g sourceGroup channel=true) :
    representative g channel<g.count ∧ g.group (representative g channel)=channel.targetGroup ∧
      g.member (representative g channel)=0 := by
  have f := channel_facts g sourceGroup channel accepted
  simpa only [representative,Nat.add_zero] using
    GroupInventory.coordinate_inverse g checked channel.targetGroup 0 f.targetBound f.positive

theorem block_channel_each (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (bank : LocalProductTensorPlanV19.Bank) (source : Block)
    (axis : Nat) (channel : Channel) (targetAxis : Nat)
    (global : checkChannel c.groups (groupAt source axis) channel=true)
    (accepted : checkBlockChannel c data bank source axis channel targetAxis=true)
    (axisBound : axis<3) (move : Nat × Nat) (member : move∈channel.moves) :
    LocalProductTensorPlanV19.checkNumeric c data bank source axis move.1 (actualId c.groups channel move.2) targetAxis=true := by
  have channelFacts := channel_facts c.groups (groupAt source axis) channel global
  have moveBounds := channelFacts.bounds move member
  have ids := move_ids c.groups c.groupChecked (groupAt source axis) channel global move member
  have rep := representative_facts c.groups c.groupChecked (groupAt source axis) channel global
  have groupEq := ids.2.1.trans rep.2.1.symm
  have safeEq := same_group_safe c data source axis _ _ axisBound groupEq
  by_cases safe : LocalProductTensorPlanV19.safeNumeric c data source axis (representative c.groups channel)=true
  · have metadata : LocalProductTensorPlanV19.checkNumeric c data bank source axis 0 (representative c.groups channel) targetAxis=true ∧
        ((LocalProductTensorPlanV19.wordFor bank source).size axis=c.groups.size (groupAt source axis) ∧
          (LocalProductTensorPlanV19.wordFor bank (targetBlock c source axis (representative c.groups channel))).size targetAxis=c.groups.size channel.targetGroup) := by
      simpa only [checkBlockChannel,safe,if_true,Bool.and_eq_true,decide_eq_true_eq] using accepted
    have numeric := LocalProductTensorPlanV19.numeric_facts c data bank source axis 0 _ targetAxis metadata.1 safe
    have targetEq := same_group_block c source axis _ _ groupEq
    have actualSafe : LocalProductTensorPlanV19.safeNumeric c data source axis (actualId c.groups channel move.2)=true := safeEq.trans safe
    have tagCheck : checkTags c source axis (actualId c.groups channel move.2) targetAxis=true := by
      rw [same_group_checkTags c source axis _ _ targetAxis groupEq]
      exact numeric.tags
    have targetWord : LocalProductTensorPlanV19.checkBoundWord c bank (targetBlock c source axis (actualId c.groups channel move.2))=true := by
      rw [targetEq];exact numeric.word
    have freeCheck : checkFree (LocalProductTensorPlanV19.wordFor bank source)
        (LocalProductTensorPlanV19.wordFor bank (targetBlock c source axis (actualId c.groups channel move.2))) axis targetAxis=true := by
      rw [targetEq];exact numeric.free
    have planeFacts : axis<3 ∧ targetAxis<3 ∧
        0<(LocalProductTensorPlanV19.wordFor bank source).size axis ∧
        c.groups.member (representative c.groups channel)<(LocalProductTensorPlanV19.wordFor bank (targetBlock c source axis (representative c.groups channel))).size targetAxis ∧
        (LocalProductTensorPlanV19.wordFor bank source).free axis=
          (LocalProductTensorPlanV19.wordFor bank (targetBlock c source axis (representative c.groups channel))).free targetAxis :=
      of_decide_eq_true numeric.plane
    have planeCheck : TensorReachV19.checkPlane (LocalProductTensorPlanV19.wordFor bank source)
        (LocalProductTensorPlanV19.plane c bank source axis move.1 (actualId c.groups channel move.2) targetAxis)=true := by
      apply decide_eq_true
      change axis<3 ∧ targetAxis<3 ∧ move.1<(LocalProductTensorPlanV19.wordFor bank source).size axis ∧
        c.groups.member (actualId c.groups channel move.2)<
          (LocalProductTensorPlanV19.wordFor bank (targetBlock c source axis (actualId c.groups channel move.2))).size targetAxis ∧
        (LocalProductTensorPlanV19.wordFor bank source).free axis=
          (LocalProductTensorPlanV19.wordFor bank (targetBlock c source axis (actualId c.groups channel move.2))).free targetAxis
      rw [targetEq,ids.2.2,metadata.2.1,metadata.2.2]
      exact ⟨axisBound,planeFacts.2.1,moveBounds.1,moveBounds.2,planeFacts.2.2.2.2⟩
    simpa only [LocalProductTensorPlanV19.checkNumeric,actualSafe,if_true,Bool.and_eq_true,decide_eq_true_eq] using
      (show (axis<3 ∧ move.1<c.groups.size (groupAt source axis) ∧ actualId c.groups channel move.2<c.groups.count) ∧
        (((checkTags c source axis (actualId c.groups channel move.2) targetAxis=true ∧
          LocalProductTensorPlanV19.checkBoundWord c bank (targetBlock c source axis (actualId c.groups channel move.2))=true) ∧
          checkFree (LocalProductTensorPlanV19.wordFor bank source) (LocalProductTensorPlanV19.wordFor bank (targetBlock c source axis (actualId c.groups channel move.2))) axis targetAxis=true) ∧
          TensorReachV19.checkPlane (LocalProductTensorPlanV19.wordFor bank source)
            (LocalProductTensorPlanV19.plane c bank source axis move.1 (actualId c.groups channel move.2) targetAxis)=true) from
        ⟨⟨axisBound,moveBounds.1,ids.1⟩,⟨⟨⟨tagCheck,targetWord⟩,freeCheck⟩,planeCheck⟩⟩)
  · have notSafe : LocalProductTensorPlanV19.safeNumeric c data source axis (representative c.groups channel)=false := by
      cases h : LocalProductTensorPlanV19.safeNumeric c data source axis (representative c.groups channel) with
      | false => rfl
      | true => exact False.elim (safe h)
    simp only [LocalProductTensorPlanV19.checkNumeric,safeEq,notSafe,Bool.false_eq_true,if_false,Bool.and_true,decide_eq_true_eq]
    exact ⟨axisBound,moveBounds.1,ids.1⟩

def plan (c : LocalCertificateV19.GroupedCertificate) (choose : Nat → Nat → Nat) : LocalProductTensorPlanV19.Plan :=
  ⟨fun key => choose key.1 (c.groups.group key.2.2)⟩

def checkBlockChannels (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (bank : LocalProductTensorPlanV19.Bank) (source : Block)
    (channels : Channels) (choose : Nat → Nat → Nat) : Bool :=
  (List.range 3).all fun axis => (channels (groupAt source axis)).all fun channel =>
    checkBlockChannel c data bank source axis channel (choose axis channel.targetGroup)

/-- All member-specific checks of the complete existing bridge follow from
one global matrix acceptance and only per-channel block metadata checks. -/
theorem numeric_checks_from_channels (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (bank : LocalProductTensorPlanV19.Bank)
    (source : Block) (channels : Channels) (choose : Nat → Nat → Nat)
    (global : checkGlobal c.groups data channels=true)
    (sourceChecked : LocalProductStateV19.checkBlock c source=true)
    (accepted : checkBlockChannels c data bank source channels choose=true) :
    (LocalProductTensorPlanV19.keys c data source).all (fun key =>
      LocalProductTensorPlanV19.checkNumeric c data bank source key.1 key.2.1 key.2.2 ((plan c choose).targetAxis key))=true := by
  apply List.all_eq_true.mpr
  intro key member
  obtain ⟨axis,sourceMember,j⟩ := key
  obtain ⟨axisBound,sourceMemberBound,channel,chMem,move,moveMem,sourceEq,targetEq⟩ :=
    (tensor_key_iff c data channels global source sourceChecked axis sourceMember j).mp member
  have groups := LocalProductTensorPlanV19.source_groups c source sourceChecked
  have gb : groupAt source axis<c.groups.groups := by
    have choices : axis=0 ∨ axis=1 ∨ axis=2 := by omega
    rcases choices with rfl|rfl|rfl
    · exact groups.1
    · exact groups.2.1
    · exact groups.2.2
  have groupFacts := group_facts c.groups (data axis) (groupAt source axis) _
    (global_group c.groups data channels global axis _ axisBound gb)
  have channelCheck := List.all_eq_true.mp groupFacts.channelChecks channel chMem
  have blockCheck := List.all_eq_true.mp (List.all_eq_true.mp accepted axis (List.mem_range.mpr axisBound)) channel chMem
  have numeric := block_channel_each c data bank source axis channel (choose axis channel.targetGroup)
    channelCheck blockCheck axisBound move moveMem
  have ids := move_ids c.groups c.groupChecked _ channel channelCheck move moveMem
  dsimp only [plan]
  rw [←targetEq,ids.2.1,←sourceEq]
  exact numeric


def channelPull (c : LocalCertificateV19.GroupedCertificate) (bank : LocalProductTensorPlanV19.Bank) (source : Block)
    (axis : Nat) (channel : Channel) (targetAxis : Nat) : Nat :=
  apply ((LocalProductTensorPlanV19.wordFor bank source).free axis)
    ((LocalProductTensorPlanV19.wordFor bank (targetBlock c source axis (representative c.groups channel))).layout targetAxis)
    channel.moves

def fastAxisReach (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (bank : LocalProductTensorPlanV19.Bank)
    (source : Block) (channels : Channels) (choose : Nat → Nat → Nat) (axis : Nat) : Nat :=
  PackedRecurrenceV19.reach
    (((channels (groupAt source axis)).filter fun channel =>
      LocalProductTensorPlanV19.safeNumeric c data source axis (representative c.groups channel)).map fun channel =>
        channelPull c bank source axis channel (choose axis channel.targetGroup))

def fastReach (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (bank : LocalProductTensorPlanV19.Bank)
    (source : Block) (channels : Channels) (choose : Nat → Nat → Nat) : Nat :=
  TensorReachV19.restore (LocalProductTensorPlanV19.wordFor bank source) 0 (fastAxisReach c data bank source channels choose 0) |||
    TensorReachV19.restore (LocalProductTensorPlanV19.wordFor bank source) 1 (fastAxisReach c data bank source channels choose 1) |||
    fastAxisReach c data bank source channels choose 2 |||
    PackedRecurrenceV19.reach ((LocalProductTensorPlanV19.honorWords c data bank source).map TensorReachV19.Word.padded)

theorem apply_spec (width input : Nat) (moves : List (Nat × Nat)) (n : Nat) :
    (apply width input moves).testBit n=true ↔
      ∃ move, move∈moves ∧ ((PackedRecurrenceV19.slice input (move.2*width) width) <<< (move.1*width)).testBit n=true := by
  simp only [apply,PackedRecurrenceV19.testBit_reach,List.any_map,List.any_eq_true,Function.comp_apply]

theorem pull_move (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (bank : LocalProductTensorPlanV19.Bank) (source : Block)
    (axis : Nat) (channel : Channel) (targetAxis : Nat)
    (global : checkChannel c.groups (groupAt source axis) channel=true)
    (checked : checkBlockChannel c data bank source axis channel targetAxis=true)
    (safe : LocalProductTensorPlanV19.safeNumeric c data source axis (representative c.groups channel)=true)
    (move : Nat × Nat) (member : move∈channel.moves) :
    TensorReachV19.pull (LocalProductTensorPlanV19.wordFor bank source)
      (LocalProductTensorPlanV19.plane c bank source axis move.1 (actualId c.groups channel move.2) targetAxis)=
      (PackedRecurrenceV19.slice
        ((LocalProductTensorPlanV19.wordFor bank (targetBlock c source axis (representative c.groups channel))).layout targetAxis)
        (move.2*(LocalProductTensorPlanV19.wordFor bank source).free axis)
        ((LocalProductTensorPlanV19.wordFor bank source).free axis)) <<< (move.1*(LocalProductTensorPlanV19.wordFor bank source).free axis) := by
  have metadata : LocalProductTensorPlanV19.checkNumeric c data bank source axis 0 (representative c.groups channel) targetAxis=true ∧
      ((LocalProductTensorPlanV19.wordFor bank source).size axis=c.groups.size (groupAt source axis) ∧
        (LocalProductTensorPlanV19.wordFor bank (targetBlock c source axis (representative c.groups channel))).size targetAxis=c.groups.size channel.targetGroup) := by
    simpa only [checkBlockChannel,safe,if_true,Bool.and_eq_true,decide_eq_true_eq] using checked
  have numeric := LocalProductTensorPlanV19.numeric_facts c data bank source axis 0 _ targetAxis metadata.1 safe
  have ids := move_ids c.groups c.groupChecked _ channel global move member
  have rep := representative_facts c.groups c.groupChecked _ channel global
  have groupEq := ids.2.1.trans rep.2.1.symm
  have targetEq := same_group_block c source axis _ _ groupEq
  have planeFacts : axis<3 ∧ targetAxis<3 ∧
      0<(LocalProductTensorPlanV19.wordFor bank source).size axis ∧
      c.groups.member (representative c.groups channel)<(LocalProductTensorPlanV19.wordFor bank (targetBlock c source axis (representative c.groups channel))).size targetAxis ∧
      (LocalProductTensorPlanV19.wordFor bank source).free axis=
        (LocalProductTensorPlanV19.wordFor bank (targetBlock c source axis (representative c.groups channel))).free targetAxis :=
    of_decide_eq_true numeric.plane
  unfold TensorReachV19.pull LocalProductTensorPlanV19.plane
  rw [targetEq,ids.2.2,←planeFacts.2.2.2.2]

theorem axisReach_bit (source : TensorReachV19.Word) (planes : List TensorReachV19.Plane) (axis n : Nat) :
    (TensorReachV19.axisReach source planes axis).testBit n=true ↔
      ∃ p, p∈planes ∧ p.axis=axis ∧ (TensorReachV19.pull source p).testBit n=true := by
  simp only [TensorReachV19.axisReach,PackedRecurrenceV19.testBit_reach,List.any_map,List.any_eq_true,
    Function.comp_apply,List.mem_filter,beq_iff_eq]
  constructor
  · rintro ⟨p,⟨hm,ha⟩,hit⟩
    exact ⟨p,hm,ha,hit⟩
  · rintro ⟨p,hm,ha,hit⟩
    exact ⟨p,⟨hm,ha⟩,hit⟩

theorem fastAxisReach_bit (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (bank : LocalProductTensorPlanV19.Bank)
    (source : Block) (channels : Channels) (choose : Nat → Nat → Nat) (axis n : Nat) :
    (fastAxisReach c data bank source channels choose axis).testBit n=true ↔
      ∃ channel, channel∈channels (groupAt source axis) ∧
        LocalProductTensorPlanV19.safeNumeric c data source axis (representative c.groups channel)=true ∧
        (channelPull c bank source axis channel (choose axis channel.targetGroup)).testBit n=true := by
  simp only [fastAxisReach,PackedRecurrenceV19.testBit_reach,List.any_map,List.any_eq_true,
    Function.comp_apply,List.mem_filter]
  constructor
  · rintro ⟨p,⟨hm,ha⟩,hit⟩
    exact ⟨p,hm,ha,hit⟩
  · rintro ⟨p,hm,ha,hit⟩
    exact ⟨p,⟨hm,ha⟩,hit⟩

theorem source_group_bound (c : LocalCertificateV19.GroupedCertificate) (source : Block) (checked : LocalProductStateV19.checkBlock c source=true)
    (axis : Nat) (axisBound : axis<3) : groupAt source axis<c.groups.groups := by
  have groups := LocalProductTensorPlanV19.source_groups c source checked
  have choices : axis=0 ∨ axis=1 ∨ axis=2 := by omega
  rcases choices with rfl|rfl|rfl
  · exact groups.1
  · exact groups.2.1
  · exact groups.2.2

theorem channel_axisReach_iff (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (bank : LocalProductTensorPlanV19.Bank)
    (source : Block) (channels : Channels) (choose : Nat → Nat → Nat)
    (global : checkGlobal c.groups data channels=true)
    (sourceChecked : LocalProductStateV19.checkBlock c source=true)
    (accepted : checkBlockChannels c data bank source channels choose=true) (axis n : Nat) (axisBound : axis<3) :
    (TensorReachV19.axisReach (LocalProductTensorPlanV19.wordFor bank source)
      (LocalProductTensorPlanV19.planes c data bank source (plan c choose)) axis).testBit n=true ↔
      (fastAxisReach c data bank source channels choose axis).testBit n=true := by
  have groupFacts := group_facts c.groups (data axis) (groupAt source axis) _
    (global_group c.groups data channels global axis _ axisBound (source_group_bound c source sourceChecked axis axisBound))
  constructor
  · intro hit
    obtain ⟨p,pmem,pa,hit⟩ := (axisReach_bit _ _ axis n).mp hit
    obtain ⟨key,keyMem,rfl⟩ := List.mem_map.mp pmem
    obtain ⟨a,m,j⟩ := key
    change a=axis at pa
    subst a
    have keyFacts := (LocalProductTensorPlanV19.safe_key_mem c data source (axis,m,j)).mp keyMem
    obtain ⟨_,_,channel,chMem,move,moveMem,sourceEq,targetEq⟩ :=
      (tensor_key_iff c data channels global source sourceChecked axis m j).mp keyFacts.1
    have channelCheck := List.all_eq_true.mp groupFacts.channelChecks channel chMem
    have blockCheck := List.all_eq_true.mp (List.all_eq_true.mp accepted axis (List.mem_range.mpr axisBound)) channel chMem
    have ids := move_ids c.groups c.groupChecked _ channel channelCheck move moveMem
    have rep := representative_facts c.groups c.groupChecked _ channel channelCheck
    have safeEq := same_group_safe c data source axis _ _ axisBound (ids.2.1.trans rep.2.1.symm)
    have safe : LocalProductTensorPlanV19.safeNumeric c data source axis (representative c.groups channel)=true := by
      rw [←targetEq,safeEq] at keyFacts
      exact keyFacts.2
    have planeEq : LocalProductTensorPlanV19.plane c bank source axis m j ((plan c choose).targetAxis (axis,m,j))=
        LocalProductTensorPlanV19.plane c bank source axis move.1 (actualId c.groups channel move.2) (choose axis channel.targetGroup) := by
      dsimp only [plan]
      rw [←sourceEq,←targetEq,ids.2.1]
    rw [planeEq,pull_move c data bank source axis channel _ channelCheck blockCheck safe move moveMem] at hit
    apply (fastAxisReach_bit c data bank source channels choose axis n).mpr
    refine ⟨channel,chMem,safe,?_⟩
    exact (apply_spec _ _ channel.moves n).mpr ⟨move,moveMem,hit⟩
  · intro hit
    obtain ⟨channel,chMem,safe,hit⟩ := (fastAxisReach_bit c data bank source channels choose axis n).mp hit
    obtain ⟨move,moveMem,hit⟩ := (apply_spec _ _ channel.moves n).mp hit
    have channelCheck := List.all_eq_true.mp groupFacts.channelChecks channel chMem
    have blockCheck := List.all_eq_true.mp (List.all_eq_true.mp accepted axis (List.mem_range.mpr axisBound)) channel chMem
    have ids := move_ids c.groups c.groupChecked _ channel channelCheck move moveMem
    have rep := representative_facts c.groups c.groupChecked _ channel channelCheck
    have moveBounds := (channel_facts c.groups _ channel channelCheck).bounds move moveMem
    have safeEq := same_group_safe c data source axis _ _ axisBound (ids.2.1.trans rep.2.1.symm)
    have keyMem : (axis,move.1,actualId c.groups channel move.2)∈LocalProductTensorPlanV19.safeKeys c data source := by
      apply (LocalProductTensorPlanV19.safe_key_mem c data source _).mpr
      refine ⟨(tensor_key_iff c data channels global source sourceChecked axis move.1 _).mpr
        ⟨axisBound,moveBounds.1,channel,chMem,move,moveMem,rfl,rfl⟩,safeEq.trans safe⟩
    apply (axisReach_bit _ _ axis n).mpr
    refine ⟨LocalProductTensorPlanV19.plane c bank source axis move.1 (actualId c.groups channel move.2) (choose axis channel.targetGroup),?_,rfl,?_⟩
    · have planeEq : LocalProductTensorPlanV19.plane c bank source axis move.1 (actualId c.groups channel move.2)
          ((plan c choose).targetAxis (axis,move.1,actualId c.groups channel move.2))=
          LocalProductTensorPlanV19.plane c bank source axis move.1 (actualId c.groups channel move.2) (choose axis channel.targetGroup) := by
        dsimp only [plan];rw [ids.2.1]
      exact List.mem_map.mpr ⟨(axis,move.1,actualId c.groups channel move.2),keyMem,planeEq⟩
    · rw [pull_move c data bank source axis channel _ channelCheck blockCheck safe move moveMem]
      exact hit

theorem channel_axisReach_eq (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (bank : LocalProductTensorPlanV19.Bank)
    (source : Block) (channels : Channels) (choose : Nat → Nat → Nat)
    (global : checkGlobal c.groups data channels=true)
    (sourceChecked : LocalProductStateV19.checkBlock c source=true)
    (accepted : checkBlockChannels c data bank source channels choose=true) (axis : Nat) (axisBound : axis<3) :
    TensorReachV19.axisReach (LocalProductTensorPlanV19.wordFor bank source)
      (LocalProductTensorPlanV19.planes c data bank source (plan c choose)) axis=
      fastAxisReach c data bank source channels choose axis := by
  apply Nat.eq_of_testBit_eq
  intro n
  have eq := channel_axisReach_iff c data bank source channels choose global sourceChecked accepted axis n axisBound
  cases a : (TensorReachV19.axisReach (LocalProductTensorPlanV19.wordFor bank source)
    (LocalProductTensorPlanV19.planes c data bank source (plan c choose)) axis).testBit n with
  | false =>
    cases b : (fastAxisReach c data bank source channels choose axis).testBit n with
    | false => rfl
    | true => have bad := eq.mpr b; rw [a] at bad; cases bad
  | true =>
    cases b : (fastAxisReach c data bank source channels choose axis).testBit n with
    | false => have bad := eq.mp a; rw [b] at bad; cases bad
    | true => rfl

theorem channel_reach_eq (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (bank : LocalProductTensorPlanV19.Bank)
    (source : Block) (channels : Channels) (choose : Nat → Nat → Nat)
    (global : checkGlobal c.groups data channels=true)
    (sourceChecked : LocalProductStateV19.checkBlock c source=true)
    (accepted : checkBlockChannels c data bank source channels choose=true) :
    TensorReachV19.reach (LocalProductTensorPlanV19.wordFor bank source)
      (LocalProductTensorPlanV19.planes c data bank source (plan c choose)) (LocalProductTensorPlanV19.honorWords c data bank source)=
      fastReach c data bank source channels choose := by
  unfold TensorReachV19.reach fastReach
  rw [channel_axisReach_eq c data bank source channels choose global sourceChecked accepted 0 (by decide),
    channel_axisReach_eq c data bank source channels choose global sourceChecked accepted 1 (by decide),
    channel_axisReach_eq c data bank source channels choose global sourceChecked accepted 2 (by decide)]


/-- The block executable contains no member/local-edge verification loop:
one SAFE/target/geometry template per channel, the tiny honor list, and two
whole-Nat equations. Its global adjacency certificate is supplied separately. -/
def checkPacked (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (bank : LocalProductTensorPlanV19.Bank)
    (source : Block) (channels : Channels) (choose : Nat → Nat → Nat) : Bool :=
  LocalProductStateV19.checkBlock c source && LocalProductTensorPlanV19.checkSourceWord c bank source &&
    checkBlockChannels c data bank source channels choose &&
    ((data 3).next source.honor).all (LocalProductTensorPlanV19.checkHonor c data bank source) &&
    decide (((LocalProductTensorPlanV19.wordFor bank source).padded &&& fastReach c data bank source channels choose)=0 ∧
      ((LocalProductTensorPlanV19.wordFor bank source).padded ||| fastReach c data bank source channels choose)=
        TensorReachV19.validMask (LocalProductTensorPlanV19.wordFor bank source))

theorem packed_refines (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (bank : LocalProductTensorPlanV19.Bank)
    (source : Block) (channels : Channels) (choose : Nat → Nat → Nat)
    (global : checkGlobal c.groups data channels=true)
    (accepted : checkPacked c data bank source channels choose=true) :
    LocalProductTensorPlanV19.checkPlan c data bank source (plan c choose)=true := by
  have parts : (((LocalProductStateV19.checkBlock c source=true ∧ LocalProductTensorPlanV19.checkSourceWord c bank source=true) ∧
      checkBlockChannels c data bank source channels choose=true) ∧
      ((data 3).next source.honor).all (LocalProductTensorPlanV19.checkHonor c data bank source)=true) ∧
      (((LocalProductTensorPlanV19.wordFor bank source).padded &&& fastReach c data bank source channels choose)=0 ∧
      ((LocalProductTensorPlanV19.wordFor bank source).padded ||| fastReach c data bank source channels choose)=
        TensorReachV19.validMask (LocalProductTensorPlanV19.wordFor bank source)) := by
    simpa only [checkPacked,Bool.and_eq_true,decide_eq_true_eq] using accepted
  have numeric := numeric_checks_from_channels c data bank source channels choose global parts.1.1.1.1 parts.1.1.2
  have planes : (LocalProductTensorPlanV19.planes c data bank source (plan c choose)).all
      (TensorReachV19.checkPlane (LocalProductTensorPlanV19.wordFor bank source))=true := by
    apply List.all_eq_true.mpr
    intro p pmem
    obtain ⟨key,keyMem,rfl⟩ := List.mem_map.mp pmem
    have km := (LocalProductTensorPlanV19.safe_key_mem c data source key).mp keyMem
    have checked := List.all_eq_true.mp numeric key km.1
    exact (LocalProductTensorPlanV19.numeric_facts c data bank source key.1 key.2.1 key.2.2 _ checked km.2).plane
  have oldPN : (((LocalProductTensorPlanV19.wordFor bank source).padded &&&
      TensorReachV19.reach (LocalProductTensorPlanV19.wordFor bank source)
        (LocalProductTensorPlanV19.planes c data bank source (plan c choose)) (LocalProductTensorPlanV19.honorWords c data bank source))=0 ∧
      ((LocalProductTensorPlanV19.wordFor bank source).padded |||
      TensorReachV19.reach (LocalProductTensorPlanV19.wordFor bank source)
        (LocalProductTensorPlanV19.planes c data bank source (plan c choose)) (LocalProductTensorPlanV19.honorWords c data bank source))=
        TensorReachV19.validMask (LocalProductTensorPlanV19.wordFor bank source)) := by
    rw [channel_reach_eq c data bank source channels choose global parts.1.1.1.1 parts.1.1.2]
    exact parts.2
  have recurrence : TensorReachV19.check (LocalProductTensorPlanV19.wordFor bank source)
      (LocalProductTensorPlanV19.planes c data bank source (plan c choose)) (LocalProductTensorPlanV19.honorWords c data bank source)=true := by
    simpa only [TensorReachV19.check,Bool.and_eq_true,decide_eq_true_eq] using And.intro planes oldPN
  simpa only [LocalProductTensorPlanV19.checkPlan,Bool.and_eq_true] using
    And.intro (And.intro (And.intro (And.intro parts.1.1.1.1 parts.1.1.1.2) numeric) parts.1.2) recurrence

theorem packed_each (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data) (bank : LocalProductTensorPlanV19.Bank)
    (source : Block) (channels : Channels) (choose : Nat → Nat → Nat)
    (global : checkGlobal c.groups data channels=true)
    (accepted : checkPacked c data bank source channels choose=true) (x y z : Nat)
    (hx : x<widthA c source) (hy : y<widthB c source) (hz : z<widthC c source) :
    LocalProductStateV19.checkPN c (ofCertificate c data) (LocalProductTensorPlanV19.target c bank) (packed c source x y z)
      ((bank.labels (bank.lookup source)).testBit (rank c source x y z))=true := by
  exact LocalProductTensorPlanV19.accepted_each c data bank source (plan c choose)
    (packed_refines c data bank source channels choose global accepted) x y z hx hy hz

/-- The original achievement-game conclusion needs only next-layer
induction, the old exact finite metadata/cache checks, the GLOBAL channel
check, and the small PER-BLOCK packed checker. No rowwise PN premise. -/
theorem packed_original_strategy (c : LocalCertificateV19.GroupedCertificate) (data : Nat → SuccessorCache.Data)
    (cacheChecked : LocalCertificateV19.Successors.Checked c.toCertificate data) (bank : LocalProductTensorPlanV19.Bank)
    (correct : GeneralLayer.TargetCorrect (FullSafeData.summaries (ofCertificate c data).rules) (LocalProductTensorPlanV19.target c bank))
    (source : Block) (channels : Channels) (choose : Nat → Nat → Nat)
    (global : checkGlobal c.groups data channels=true)
    (accepted : checkPacked c data bank source channels choose=true) (x y z : Nat)
    (hx : x<widthA c source) (hy : y<widthB c source) (hz : z<widthC c source) :
    SafeGame.AchievementStrategy Step Win (originalState c source x y z)
      (GeneralLayer.outcome ((bank.labels (bank.lookup source)).testBit (rank c source x y z))) := by
  exact LocalProductTensorPlanV19.packed_original_strategy c data cacheChecked bank correct source (plan c choose)
    (packed_refines c data bank source channels choose global accepted) x y z hx hy hz

theorem wrong_row_rejected (g : GroupInventory.Data) (data : SuccessorCache.Data) (sourceGroup : Nat) (channels : List Channel)
    (member : Nat) (bound : member<g.size sourceGroup)
    (wrong : localTargets g channels member≠data.next (g.first sourceGroup+member)) :
    checkGroup g data sourceGroup channels=false := by
  cases accepted : checkGroup g data sourceGroup channels with
  | false => rfl
  | true => exact False.elim (wrong ((group_facts g data sourceGroup channels accepted).rows member bound))

theorem bad_move_rejected (g : GroupInventory.Data) (sourceGroup : Nat) (channel : Channel) (move : Nat × Nat)
    (member : move∈channel.moves) (bad : g.size sourceGroup≤move.1 ∨ g.size channel.targetGroup≤move.2) :
    checkChannel g sourceGroup channel=false := by
  cases accepted : checkChannel g sourceGroup channel with
  | false => rfl
  | true =>
    have bound := (channel_facts g sourceGroup channel accepted).bounds move member
    omega

end Mahjong.LocalGroupChannelV19

#print axioms Mahjong.LocalGroupChannelV19.tensor_key_iff
#print axioms Mahjong.LocalGroupChannelV19.same_group_safe
#print axioms Mahjong.LocalGroupChannelV19.same_group_tags
#print axioms Mahjong.LocalGroupChannelV19.same_group_block
#print axioms Mahjong.LocalGroupChannelV19.same_group_checkTags
#print axioms Mahjong.LocalGroupChannelV19.representative_facts
#print axioms Mahjong.LocalGroupChannelV19.block_channel_each
#print axioms Mahjong.LocalGroupChannelV19.numeric_checks_from_channels
#print axioms Mahjong.LocalGroupChannelV19.apply_spec
#print axioms Mahjong.LocalGroupChannelV19.pull_move
#print axioms Mahjong.LocalGroupChannelV19.axisReach_bit
#print axioms Mahjong.LocalGroupChannelV19.fastAxisReach_bit
#print axioms Mahjong.LocalGroupChannelV19.channel_axisReach_iff
#print axioms Mahjong.LocalGroupChannelV19.channel_axisReach_eq
#print axioms Mahjong.LocalGroupChannelV19.channel_reach_eq
#print axioms Mahjong.LocalGroupChannelV19.packed_refines
#print axioms Mahjong.LocalGroupChannelV19.packed_each
#print axioms Mahjong.LocalGroupChannelV19.packed_original_strategy
#print axioms Mahjong.LocalGroupChannelV19.wrong_row_rejected
#print axioms Mahjong.LocalGroupChannelV19.bad_move_rejected
