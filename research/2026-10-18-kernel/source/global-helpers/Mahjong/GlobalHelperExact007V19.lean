module
prelude
public import Mahjong.GlobalHelperChannel007V19
import all Mahjong.GlobalHelperChannel007V19
public import Mahjong.CartesianChannels00V19
import all Mahjong.CartesianChannels00V19
public section
set_option maxRecDepth 65536
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
theorem Mahjong.GlobalHelperExact007V19.all_inputs (width input : Nat) :
  Mahjong.GlobalHelperChannel007V19.channel width input = Mahjong.CartesianChannels00V19.channel7 width input := by rfl
#print axioms Mahjong.GlobalHelperExact007V19.all_inputs
