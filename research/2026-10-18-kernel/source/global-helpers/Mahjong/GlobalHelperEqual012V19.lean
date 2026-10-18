module
prelude
public import Mahjong.GlobalHelperChannel012V19
public import Mahjong.CartesianChannels00V19
public section
set_option maxRecDepth 65536
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
theorem Mahjong.GlobalHelperEqual012V19.all_inputs (width input : Nat) :
  Mahjong.GlobalHelperChannel012V19.channel width input = Mahjong.CartesianChannels00V19.channel12 width input := by rfl
#print axioms Mahjong.GlobalHelperEqual012V19.all_inputs
