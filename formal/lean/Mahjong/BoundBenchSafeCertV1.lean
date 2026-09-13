import Mahjong.BoundBenchDataV1

set_option maxRecDepth 8192
set_option maxHeartbeats 20000000

namespace Mahjong.BoundBenchSafeCertV1
open BoundBenchDataV1

theorem checked : StandardBoundCertificate.checkSafe New34_1 caps000 safeChildren = true := by decide +kernel
theorem original_safe : SafeGame.Safe Step Win New34_1 :=
  (StandardBoundCertificate.checkSafe_sound New34_1 caps000 safeChildren checked).2

end Mahjong.BoundBenchSafeCertV1
#print axioms Mahjong.BoundBenchSafeCertV1.checked
 #print axioms Mahjong.BoundBenchSafeCertV1.original_safe
