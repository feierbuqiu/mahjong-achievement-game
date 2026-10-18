module
prelude
public import Mahjong.GlobalHelperChannel104V19
public import Mahjong.CartesianChannels12V19
public section
set_option maxRecDepth 65536
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
theorem Mahjong.GlobalHelperEqual104V19.all_inputs (width input : Nat) :
  Mahjong.GlobalHelperChannel104V19.channel width input = Mahjong.CartesianChannels12V19.channel104 width input := by rfl
#print axioms Mahjong.GlobalHelperEqual104V19.all_inputs
