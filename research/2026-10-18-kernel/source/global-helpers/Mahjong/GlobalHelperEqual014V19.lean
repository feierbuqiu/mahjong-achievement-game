module
prelude
public import Mahjong.GlobalHelperChannel014V19
public import Mahjong.CartesianChannels01V19
public section
set_option maxRecDepth 65536
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
theorem Mahjong.GlobalHelperEqual014V19.all_inputs (width input : Nat) :
  Mahjong.GlobalHelperChannel014V19.channel width input = Mahjong.CartesianChannels01V19.channel14 width input := by rfl
#print axioms Mahjong.GlobalHelperEqual014V19.all_inputs
