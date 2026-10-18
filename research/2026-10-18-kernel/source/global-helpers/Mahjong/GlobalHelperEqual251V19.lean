module
prelude
public import Mahjong.GlobalHelperChannel251V19
public import Mahjong.CartesianChannels27V19
public section
set_option maxRecDepth 65536
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
theorem Mahjong.GlobalHelperEqual251V19.all_inputs (width input : Nat) :
  Mahjong.GlobalHelperChannel251V19.channel width input = Mahjong.CartesianChannels27V19.channel251 width input := by rfl
#print axioms Mahjong.GlobalHelperEqual251V19.all_inputs
