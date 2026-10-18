import Std

namespace Mahjong.PilotHarnessV18

/-- Harness calibration only. This is not a game result or throughput sample. -/
theorem arithmetic_control : (17 : Nat) + 25 = 42 := by decide +kernel

end Mahjong.PilotHarnessV18

#print axioms Mahjong.PilotHarnessV18.arithmetic_control
