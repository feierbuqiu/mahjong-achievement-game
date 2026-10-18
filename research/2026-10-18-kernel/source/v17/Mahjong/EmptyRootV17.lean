import Mahjong.Base5Coverage
import Mahjong.BucketIndex
import Mahjong.TerminalBucket
import Mahjong.Bridge

set_option autoImplicit false

/-!
The actual opening directory is n00_h000.dir, 32 bytes, SHA256
49293309d25cafc914c11063c2d1cd286a4500d519b11b4fc98500efb85f6d9c.
Its little-endian (offset,width,g0,g1,g2,tag) is (0,1,0,0,0,0).

Freshly read relevant prefixes are groups[0:8] = (first=0,size=1),
numeric[0:12] = (code=0,group=0,coordinate=0), numeric_ids[0:4] = 0.
The small literal below records these prefixes; it is not a replacement for
the full actual input files. check is evaluated on the full runtime Data and
proves the actual unrank result, with no assumed decode=empty premise.

Root P is a separate boolean check. A historical P bit alone is never an
original-game winning proof: the final theorems retain the actual strategy
premise that must come from the complete verified certificate chain.
-/
namespace Mahjong.EmptyRootV17
open PackedRules SafeGame

def packedZero : Packed := ⟨0, 0, 0, 0⟩

/-- All root-relevant fields, including bounds before defaulting byte reads. -/
def check (d : BucketIndex.Data) : Bool := decide (
    d.size = 1 ∧ d.honorCode = 0 ∧ d.directory.size = 32 ∧
    12 ≤ d.numeric.size ∧ 4 ≤ d.ids.size ∧ 8 ≤ d.groups.size ∧
    BucketIndex.field d 0 0 8 = 0 ∧ BucketIndex.field d 0 8 8 = 1 ∧
    BucketIndex.field d 0 16 4 = 0 ∧ BucketIndex.field d 0 20 4 = 0 ∧
    BucketIndex.field d 0 24 4 = 0 ∧ BucketIndex.field d 0 28 4 = 0 ∧
    BucketIndex.groupFirst d 0 = 0 ∧ BucketIndex.groupSize d 0 = 1 ∧
    BucketIndex.readLE d.numeric 0 4 = 0 ∧
    BucketIndex.readLE d.numeric 4 4 = 0 ∧
    BucketIndex.readLE d.numeric 8 4 = 0 ∧
    BucketIndex.readLE d.ids 0 4 = 0)

structure Facts (d : BucketIndex.Data) : Prop where
  size : d.size = 1
  honor : d.honorCode = 0
  directorySize : d.directory.size = 32
  numericSize : 12 ≤ d.numeric.size
  idsSize : 4 ≤ d.ids.size
  groupsSize : 8 ≤ d.groups.size
  offset : BucketIndex.field d 0 0 8 = 0
  width : BucketIndex.field d 0 8 8 = 1
  a : BucketIndex.field d 0 16 4 = 0
  b : BucketIndex.field d 0 20 4 = 0
  c : BucketIndex.field d 0 24 4 = 0
  tag : BucketIndex.field d 0 28 4 = 0
  first : BucketIndex.groupFirst d 0 = 0
  groupSize : BucketIndex.groupSize d 0 = 1
  code : BucketIndex.readLE d.numeric 0 4 = 0
  group : BucketIndex.readLE d.numeric 4 4 = 0
  member : BucketIndex.readLE d.numeric 8 4 = 0
  id : BucketIndex.readLE d.ids 0 4 = 0

theorem facts (d : BucketIndex.Data) (accepted : check d = true) : Facts d := by
  simp only [check, decide_eq_true_eq] at accepted
  rcases accepted with ⟨hs, hh, hd, hn, hi, hg, ho, hw, ha, hb, hc, ht, hf, hgs, hcode, hgroup, hmember, hid⟩
  exact ⟨hs, hh, hd, hn, hi, hg, ho, hw, ha, hb, hc, ht, hf, hgs, hcode, hgroup, hmember, hid⟩

theorem inside (d : BucketIndex.Data) (accepted : check d = true) : 0 < d.size := by
  rw [(facts d accepted).size]
  decide

theorem block_zero (d : BucketIndex.Data) (accepted : check d = true) :
    BucketIndex.blockAt d 0 = 0 := by
  unfold BucketIndex.blockAt
  rw [(facts d accepted).directorySize]
  rfl

theorem ids_zero (d : BucketIndex.Data) (accepted : check d = true) :
    BucketIndex.decodeIds d 0 = (0, 0, 0) := by
  have h := facts d accepted
  simp [BucketIndex.decodeIds, block_zero d accepted, h.a, h.b, h.c,
    h.offset, h.first, h.groupSize, BucketIndex.floorSearch,
    BucketIndex.choose2, BucketIndex.choose3]

theorem unrank_zero (d : BucketIndex.Data) (accepted : check d = true) :
    BucketIndex.unrank d 0 = packedZero := by
  have h := facts d accepted
  simp [BucketIndex.unrank, ids_zero d accepted, h.code, h.honor, packedZero]

theorem rank_zero (d : BucketIndex.Data) (accepted : check d = true) :
    BucketIndex.rank d packedZero = 0 := by
  have h := facts d accepted
  simp [BucketIndex.rank, packedZero, h.id, h.group, h.member,
    h.directorySize, h.offset,
    BucketIndex.floorSearch, BucketIndex.choose2, BucketIndex.choose3]

theorem pack_empty : Base5Coverage.pack empty = packedZero := by
  decide

theorem unpack_zero : Base5Coverage.unpack packedZero = empty := by
  have h := Base5Coverage.unpack_pack empty empty_valid
  rw [pack_empty] at h
  exact h

/-- Decoding is a proved consequence of finite actual data checks. -/
theorem decode_empty (d : BucketIndex.Data) (accepted : check d = true) :
    Base5Coverage.unpack (BucketIndex.unrank d 0) = empty := by
  rw [unrank_zero d accepted, unpack_zero]

theorem rank_empty (d : BucketIndex.Data) (accepted : check d = true) :
    BucketIndex.rank d (Base5Coverage.pack empty) = 0 := by
  rw [pack_empty]
  exact rank_zero d accepted

/-- One actual root row is present and its decoded physical position is empty. -/
theorem checked_root (d : BucketIndex.Data) (accepted : check d = true) :
    0 < d.size ∧ Base5Coverage.unpack (BucketIndex.unrank d 0) = empty :=
  ⟨inside d accepted, decode_empty d accepted⟩

/-- Old files are 64-bit padded. Higher unused bits are not constrained. -/
def checkP (d : BucketIndex.Data) (bits : ByteArray) : Bool :=
  check d && decide (bits.size = 8) && TerminalBucket.labelP bits 0

def rootOutcome (bits : ByteArray) : Outcome :=
  if TerminalBucket.labelP bits 0 then .P else .N

theorem checkP_parts (d : BucketIndex.Data) (bits : ByteArray)
    (accepted : checkP d bits = true) :
    check d = true ∧ bits.size = 8 ∧ TerminalBucket.labelP bits 0 = true := by
  simp only [checkP, Bool.and_eq_true, decide_eq_true_eq] at accepted
  exact ⟨accepted.1.1, accepted.1.2, accepted.2⟩

theorem second_player_of_normal (d : BucketIndex.Data) (accepted : check d = true)
    (strategy : NormalStrategy SafeMove
      (Base5Coverage.unpack (BucketIndex.unrank d 0)) .P) :
    SecondPlayerWins Step Win empty := by
  rw [decode_empty d accepted] at strategy
  exact original_second_player_wins_of_safe_P strategy

theorem second_player_of_achievement (d : BucketIndex.Data) (accepted : check d = true)
    (strategy : AchievementStrategy Step Win
      (Base5Coverage.unpack (BucketIndex.unrank d 0)) .P) :
    SecondPlayerWins Step Win empty := by
  rw [decode_empty d accepted] at strategy
  apply original_second_player_wins_of_safe_P
  exact (original_safe_reduction empty_safe).mpr strategy

/-- The full certificate supplies strategy; a root bit never supplies it. -/
theorem checked_second_player (d : BucketIndex.Data) (bits : ByteArray)
    (accepted : checkP d bits = true)
    (strategy : AchievementStrategy Step Win
      (Base5Coverage.unpack (BucketIndex.unrank d 0)) (rootOutcome bits)) :
    SecondPlayerWins Step Win empty := by
  have h := checkP_parts d bits accepted
  apply second_player_of_achievement d h.1
  simpa [rootOutcome, h.2.2] using strategy

def observedDirectory : ByteArray :=
  ⟨#[0,0,0,0,0,0,0,0, 1,0,0,0,0,0,0,0,
     0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0]⟩

def observedGroupsPrefix : ByteArray := ⟨#[0,0,0,0,1,0,0,0]⟩
def observedNumericPrefix : ByteArray := ⟨#[0,0,0,0,0,0,0,0,0,0,0,0]⟩
def observedIdsPrefix : ByteArray := ⟨#[0,0,0,0]⟩

/-- A small, exact root-relevant projection, not the whole numeric catalogue. -/
def observedPrefixData : BucketIndex.Data where
  numeric := observedNumericPrefix
  ids := observedIdsPrefix
  groups := observedGroupsPrefix
  directory := observedDirectory
  honorCode := 0
  size := 1

theorem observed_check : check observedPrefixData = true := by decide

theorem observed_decode_empty :
    Base5Coverage.unpack (BucketIndex.unrank observedPrefixData 0) = empty :=
  decode_empty observedPrefixData observed_check

theorem observed_rank_zero : BucketIndex.rank observedPrefixData packedZero = 0 :=
  rank_zero observedPrefixData observed_check

end Mahjong.EmptyRootV17

#print axioms Mahjong.EmptyRootV17.facts
#print axioms Mahjong.EmptyRootV17.inside
#print axioms Mahjong.EmptyRootV17.block_zero
#print axioms Mahjong.EmptyRootV17.ids_zero
#print axioms Mahjong.EmptyRootV17.unrank_zero
#print axioms Mahjong.EmptyRootV17.rank_zero
#print axioms Mahjong.EmptyRootV17.pack_empty
#print axioms Mahjong.EmptyRootV17.unpack_zero
#print axioms Mahjong.EmptyRootV17.decode_empty
#print axioms Mahjong.EmptyRootV17.rank_empty
#print axioms Mahjong.EmptyRootV17.checked_root
#print axioms Mahjong.EmptyRootV17.checkP_parts
#print axioms Mahjong.EmptyRootV17.second_player_of_normal
#print axioms Mahjong.EmptyRootV17.second_player_of_achievement
#print axioms Mahjong.EmptyRootV17.checked_second_player
#print axioms Mahjong.EmptyRootV17.observed_check
#print axioms Mahjong.EmptyRootV17.observed_decode_empty
#print axioms Mahjong.EmptyRootV17.observed_rank_zero
