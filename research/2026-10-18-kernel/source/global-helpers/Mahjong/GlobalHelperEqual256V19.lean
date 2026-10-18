module
prelude
public import Mahjong.GlobalHelperChannel256V19
public import Mahjong.CartesianChannels30V19
public section
set_option maxRecDepth 65536
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
theorem Mahjong.GlobalHelperEqual256V19.all_inputs (width input : Nat) :
  Mahjong.GlobalHelperChannel256V19.channel width input = Mahjong.CartesianChannels30V19.channel256 width input := by rfl
#print axioms Mahjong.GlobalHelperEqual256V19.all_inputs
