module
prelude
public import Mahjong.GlobalHelperChannel253V19
public import Mahjong.CartesianChannels28V19
public section
set_option maxRecDepth 65536
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
theorem Mahjong.GlobalHelperEqual253V19.all_inputs (width input : Nat) :
  Mahjong.GlobalHelperChannel253V19.channel width input = Mahjong.CartesianChannels28V19.channel253 width input := by rfl
#print axioms Mahjong.GlobalHelperEqual253V19.all_inputs
