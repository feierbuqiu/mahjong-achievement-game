import Mahjong.LocalSummary
import Mahjong.LocalCacheEncoding

namespace Mahjong.SummaryEncoding

def word (data : ByteArray) (i : Nat) : Nat :=
  data[4*i]!.toNat + data[4*i+1]!.toNat * 256 + data[4*i+2]!.toNat * 65536 +
    data[4*i+3]!.toNat * 16777216

def value (data : ByteArray) (i : Nat) : LocalSummary.Value :=
  let v := word data i
  ⟨v % 8, v / 8 % 8, v / 64 % 16, decide (v / 1024 % 2 = 1), decide (v / 2048 % 2 = 1)⟩

def candidate (b : Nat) (core summary : ByteArray) : LocalSummary.Candidate where
  core := LocalCacheEncoding.candidate b core
  value := value summary
  next := fun i u => i + LocalCacheEncoding.powers[u.val % 9]!
  available := fun i u => decide (word summary i / 4096 / (2 ^ (u.val % 9)) % 2 = 1)

end Mahjong.SummaryEncoding
