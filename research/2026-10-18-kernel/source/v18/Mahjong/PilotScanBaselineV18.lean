import Mahjong.PilotScanDataV18

set_option autoImplicit false

namespace Mahjong.PilotScanBaselineV18

/-- Same closed data/imports; no scalar row acceptance computation. -/
theorem baseline_row_count : PilotScanDataV18.entries.size = 56 :=
  PilotScanDataV18.literal_row_count

end Mahjong.PilotScanBaselineV18

#print axioms Mahjong.PilotScanBaselineV18.baseline_row_count
