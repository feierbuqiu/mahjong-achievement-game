module
prelude
public import Mahjong.GlobalHelperChannel254V19
public import Mahjong.CartesianChannels29V19
public section
set_option maxRecDepth 65536
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
theorem Mahjong.GlobalHelperEqual254V19.all_inputs (width input : Nat) :
  Mahjong.GlobalHelperChannel254V19.channel width input = Mahjong.CartesianChannels29V19.channel254 width input := by rfl
#print axioms Mahjong.GlobalHelperEqual254V19.all_inputs
