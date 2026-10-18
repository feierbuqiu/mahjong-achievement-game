module
prelude
public import Mahjong.GlobalHelperChannel262V19
public import Mahjong.CartesianChannels33V19
public section
set_option maxRecDepth 65536
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
theorem Mahjong.GlobalHelperEqual262V19.all_inputs (width input : Nat) :
  Mahjong.GlobalHelperChannel262V19.channel width input = Mahjong.CartesianChannels33V19.channel262 width input := by rfl
#print axioms Mahjong.GlobalHelperEqual262V19.all_inputs
