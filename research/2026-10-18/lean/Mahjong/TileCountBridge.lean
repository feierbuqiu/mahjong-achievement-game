import Mahjong.CanonicalCoverage

set_option autoImplicit false

namespace Mahjong.TileCountBridge
open PruningAlgebra PruningSemantics

theorem sumAlong_eq (ts : List Tile) (s : State) : sumAlong ts s = (ts.map s).sum := by
  induction ts with
  | nil => rfl
  | cons u us ih => simp only [sumAlong, List.map_cons, List.sum_cons, ih]

theorem block_partition :
    PairProfile.blockTiles 0 ++ PairProfile.blockTiles 1 ++ PairProfile.blockTiles 2 ++ PairProfile.blockTiles 3 = allTiles := by decide

theorem semantic_total (s : State) :
    (labelOf 0 s).tiles + (labelOf 1 s).tiles + (labelOf 2 s).tiles + (labelOf 3 s).tiles = total s := by
  change ((PairProfile.blockTiles 0).map s).sum + ((PairProfile.blockTiles 1).map s).sum +
    ((PairProfile.blockTiles 2).map s).sum + ((PairProfile.blockTiles 3).map s).sum = sumAlong allTiles s
  rw [sumAlong_eq, ← block_partition]
  simp only [List.map_append, List.sum_append]

theorem raw_tiles (core summary raw : Nat → ByteArray)
    (sizes : Base5Coverage.ProperSizes core)
    (checked : FullSafeData.Checked (Base5Coverage.tables core summary raw))
    (s : State) (valid : Valid s) (b : Nat) (hb : b < 4) :
    (PruningData.rawLabel (raw b) (LocalCacheEncoding.encodeBlock b s)).tiles = (labelOf b s).tiles := by
  have f := FullSafeData.checked_facts (Base5Coverage.tables core summary raw) checked (Base5Coverage.pack s)
    (Base5Coverage.pack_inside core summary raw sizes s valid) b hb
  have eq := f.2.2.2.1
  rw [Base5Coverage.packed_state_eq core summary raw s valid] at eq
  rw [CanonicalCoverage.rawAt_pack core summary raw s b hb] at eq
  exact eq

theorem raw_total (core summary raw : Nat → ByteArray)
    (sizes : Base5Coverage.ProperSizes core)
    (checked : FullSafeData.Checked (Base5Coverage.tables core summary raw))
    (s : State) (valid : Valid s) :
    (FullSafeData.allRaw (Base5Coverage.tables core summary raw) (Base5Coverage.pack s)).tiles = total s := by
  have t0 := raw_tiles core summary raw sizes checked s valid 0 (by decide)
  have t1 := raw_tiles core summary raw sizes checked s valid 1 (by decide)
  have t2 := raw_tiles core summary raw sizes checked s valid 2 (by decide)
  have t3 := raw_tiles core summary raw sizes checked s valid 3 (by decide)
  unfold FullSafeData.allRaw
  rw [CanonicalCoverage.rawAt_pack core summary raw s 0 (by decide),
    CanonicalCoverage.rawAt_pack core summary raw s 1 (by decide),
    CanonicalCoverage.rawAt_pack core summary raw s 2 (by decide),
    CanonicalCoverage.rawAt_pack core summary raw s 3 (by decide)]
  simp only [join, t0, t1, t2, t3]
  exact semantic_total s

end Mahjong.TileCountBridge

#print axioms Mahjong.TileCountBridge.raw_total
