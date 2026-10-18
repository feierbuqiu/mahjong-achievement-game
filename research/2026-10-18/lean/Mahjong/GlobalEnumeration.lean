import Mahjong.GlobalSlotRealization

set_option autoImplicit false

namespace Mahjong.GlobalEnumeration
open CanonicalCoverage GroupedCoverage GlobalOrbitDirectory GlobalSlotRealization GlobalOrbitUniqueness

/-- All premises are local/directory checks or their representation bindings.
There is no assumption about a global P/N table or the opening outcome. -/
structure Certificate where
  core : Nat → ByteArray
  summary : Nat → ByteArray
  raw : Nat → ByteArray
  ids : Nat → ByteArray
  members : Nat → ByteArray
  coreSizes : Base5Coverage.ProperSizes core
  safeChecked : FullSafeData.Checked (Base5Coverage.tables core summary raw)
  inventorySizes : CanonicalCoverage.ProperSizes (inventories raw ids members)
  inventoryChecked : CanonicalCoverage.Checked (inventories raw ids members)
  sharedMembers : SortedCoverage.SharedMembers (inventories raw ids members)
  sharedKeys : GlobalOrbitKey.SharedKeys (inventories raw ids members)
  groups : GroupInventory.Data
  groupChecked : GroupInventory.Checked groups
  link : Link groups (inventories raw ids members) raw
  numericBound : SafeLayerBound.Envelope
  honorBound : SafeLayerBound.Envelope
  twoBound : SafeLayerBound.Envelope
  threeBound : SafeLayerBound.Envelope
  fourBound : SafeLayerBound.Envelope
  localBound : SafeLayerBound.RawChecked numericBound honorBound raw
  twoChecked : SafeLayerBound.checkJoin numericBound numericBound twoBound = true
  threeChecked : SafeLayerBound.checkJoin twoBound numericBound threeBound = true
  fourChecked : SafeLayerBound.checkJoin threeBound honorBound fourBound = true
  finalChecked : SafeLayerBound.checkFinal fourBound 34 = true
  triples : TripleDirectory.Data
  honors : Nat → HonorDirectory.Data
  tripleChecked : TripleDirectory.Checked groups triples
  directoryChecked : ∀ h, h < (inventories raw ids members 3).count →
    HonorDirectory.Checked groups triples (PruningData.rawLabel (raw 3) ((inventories raw ids members 3).member h)) (honors h)

def inventoriesOf (c : Certificate) : Inventories := inventories c.raw c.ids c.members
def ValidSlot (c : Certificate) (a : Nat × Nat × Nat) : Prop := ValidAddress (inventoriesOf c) c.honors a
def decode (seed : Nat → Nat) (c : Certificate) (a : Nat × Nat × Nat) : State :=
  GlobalAddressDecoder.decode seed (inventoriesOf c) c.groups c.triples c.honors a

theorem decoded_safe (seed : Nat → Nat) (c : Certificate) (a : Nat × Nat × Nat) (valid : ValidSlot c a) :
    Valid (decode seed c a) ∧ IsSafe (decode seed c a) :=
  decode_valid_and_safe seed (inventoriesOf c) c.inventoryChecked c.sharedMembers c.groups c.groupChecked
    c.core c.summary c.raw c.link c.coreSizes c.safeChecked c.triples c.honors c.tripleChecked c.directoryChecked a valid

theorem covers_every_original_safe (seed : Nat → Nat) (c : Certificate) (s : State)
    (valid : Valid s) (safe : IsSafe s) : ∃ a, ValidSlot c a ∧ SameOrbit s (decode seed c a) := by
  obtain ⟨e,orbit⟩ := every_safe_has_entry c.core c.summary c.raw c.ids c.members c.coreSizes c.safeChecked
    c.inventorySizes c.inventoryChecked c.sharedMembers c.groups c.groupChecked c.link c.numericBound c.honorBound
    c.twoBound c.threeBound c.fourBound c.localBound c.twoChecked c.threeChecked c.fourChecked c.finalChecked
    c.triples c.honors c.tripleChecked c.directoryChecked s valid safe
  refine ⟨address e,entry_address_bound e c.directoryChecked,?_⟩
  change SameOrbit s (GlobalAddressDecoder.decode seed (inventories c.raw c.ids c.members) c.groups c.triples c.honors (address e))
  rw [GlobalAddressDecoder.decode_entry seed (inventories c.raw c.ids c.members) c.groups c.groupChecked c.raw c.triples c.honors e]
  exact orbit

theorem decoded_orbit_iff_address_eq (seed : Nat → Nat) (c : Certificate) (a b : Nat × Nat × Nat)
    (va : ValidSlot c a) (vb : ValidSlot c b) : SameOrbit (decode seed c a) (decode seed c b) ↔ a = b := by
  constructor
  · exact distinct_addresses_have_distinct_orbits seed (inventoriesOf c) c.inventoryChecked c.inventorySizes
      c.sharedMembers c.sharedKeys c.groups c.groupChecked c.core c.summary c.raw c.link c.coreSizes c.safeChecked
      c.triples c.honors c.tripleChecked c.directoryChecked a b va vb
  · intro eq
    rw [eq]
    exact sameOrbit_refl _

/-- Complete enumeration specification: every address is SAFE, every original
SAFE state is covered, and the chosen symmetry orbits occur exactly once. -/
theorem enumeration_correct (seed : Nat → Nat) (c : Certificate) :
    (∀ a, ValidSlot c a → Valid (decode seed c a) ∧ IsSafe (decode seed c a)) ∧
    (∀ s, Valid s → IsSafe s → ∃ a, ValidSlot c a ∧ SameOrbit s (decode seed c a)) ∧
    (∀ a b, ValidSlot c a → ValidSlot c b → (SameOrbit (decode seed c a) (decode seed c b) ↔ a = b)) :=
  ⟨decoded_safe seed c,covers_every_original_safe seed c,decoded_orbit_iff_address_eq seed c⟩

end Mahjong.GlobalEnumeration

#print axioms Mahjong.GlobalEnumeration.decoded_safe
#print axioms Mahjong.GlobalEnumeration.covers_every_original_safe
#print axioms Mahjong.GlobalEnumeration.decoded_orbit_iff_address_eq
#print axioms Mahjong.GlobalEnumeration.enumeration_correct
