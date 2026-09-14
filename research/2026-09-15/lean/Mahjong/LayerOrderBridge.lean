import Mahjong.CachedSuccessorList

set_option autoImplicit false

namespace Mahjong.LayerOrderBridge
open GlobalEnumeration SafeGame

theorem safe_bound (c : Certificate) (s : SafePosition) : total s.val ≤ 34 :=
  SafeLayerBound.original_safe_bound c.core c.summary c.raw c.coreSizes c.safeChecked
    c.numericBound c.honorBound c.twoBound c.threeBound c.fourBound 34
    c.localBound c.twoChecked c.threeChecked c.fourChecked c.finalChecked s.val s.property.1 s.property.2

def rank (s : SafePosition) : Nat := 34-total s.val

theorem move_decreases (c : Certificate) (s t : SafePosition) (edge : RestrictedSafeMove s t) :
    rank t < rank s := by
  have bound := safe_bound c t
  have grows := step_total_succ edge.1
  simp only [rank]
  omega

theorem descending_tiles_order (s t : SafePosition) (order : total t.val ≤ total s.val) :
    rank s ≤ rank t := by simp only [rank]; omega

/-- The omitted child loading at n=34 is justified by the original SAFE
bound, rather than by an empty external child list being accepted on faith. -/
theorem terminal_layer_p (c : Certificate) (s : SafePosition) (last : total s.val = 34) :
    NormalStrategy RestrictedSafeMove s .P := by
  apply NormalStrategy.p
  intro t edge
  have bound := safe_bound c t
  have grows := step_total_succ edge.1
  omega

end Mahjong.LayerOrderBridge

#print axioms Mahjong.LayerOrderBridge.safe_bound
#print axioms Mahjong.LayerOrderBridge.move_decreases
#print axioms Mahjong.LayerOrderBridge.descending_tiles_order
#print axioms Mahjong.LayerOrderBridge.terminal_layer_p
