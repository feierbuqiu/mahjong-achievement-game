module
prelude
public import Mahjong.GlobalHelperChannel017V19
public import Mahjong.CartesianChannels04V19
public section
set_option maxRecDepth 65536
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
theorem Mahjong.GlobalHelperEqual017V19.all_inputs (width input : Nat) :
  Mahjong.GlobalHelperChannel017V19.channel width input = Mahjong.CartesianChannels04V19.channel17 width input := by rfl
#print axioms Mahjong.GlobalHelperEqual017V19.all_inputs
