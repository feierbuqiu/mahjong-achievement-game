module
prelude
public import Mahjong.GlobalHelperChannel101V19
public import Mahjong.CartesianChannels11V19
public section
set_option maxRecDepth 65536
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
theorem Mahjong.GlobalHelperEqual101V19.all_inputs (width input : Nat) :
  Mahjong.GlobalHelperChannel101V19.channel width input = Mahjong.CartesianChannels11V19.channel101 width input := by rfl
#print axioms Mahjong.GlobalHelperEqual101V19.all_inputs
