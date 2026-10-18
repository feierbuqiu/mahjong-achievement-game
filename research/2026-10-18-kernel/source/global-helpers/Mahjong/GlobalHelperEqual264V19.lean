module
prelude
public import Mahjong.GlobalHelperChannel264V19
public import Mahjong.CartesianChannels33V19
public section
set_option maxRecDepth 65536
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
theorem Mahjong.GlobalHelperEqual264V19.all_inputs (width input : Nat) :
  Mahjong.GlobalHelperChannel264V19.channel width input = Mahjong.CartesianChannels33V19.channel264 width input := by rfl
#print axioms Mahjong.GlobalHelperEqual264V19.all_inputs
