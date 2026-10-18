import Mahjong.LocalCache

namespace Mahjong.LocalCacheEncoding

def powers : Array Nat := #[1, 5, 25, 125, 625, 3125, 15625, 78125, 390625]

def decodeBlock (b code : Nat) : State :=
  let digits := powers.map (fun p => code / p % 5)
  fun u => if u.val / 9 = b then digits[u.val % 9]! else 0

def encodeBlock (b : Nat) (s : State) : Nat :=
  allTiles.foldl (fun v u =>
    if u.val / 9 = b then v + s u * powers[u.val % 9]! else v) 0

def candidate (b : Nat) (data : ByteArray) : LocalCache.Candidate where
  size := data.size
  unrank := decodeBlock b
  rank := encodeBlock b
  value := fun i k => decide (data[i]!.toNat / (2 ^ k) % 2 = 1)

end Mahjong.LocalCacheEncoding
