module
prelude
public import Mahjong.GlobalHelperChannel001V19
import all Mahjong.GlobalHelperChannel001V19
public import Mahjong.CartesianChannels00V19
import all Mahjong.CartesianChannels00V19
public section
set_option maxRecDepth 65536
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
theorem Mahjong.GlobalHelperExact001V19.all_inputs (width input : Nat) :
  Mahjong.GlobalHelperChannel001V19.channel width input = Mahjong.CartesianChannels00V19.channel1 width input := by rfl
#print axioms Mahjong.GlobalHelperExact001V19.all_inputs
