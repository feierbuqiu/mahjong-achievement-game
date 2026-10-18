module
prelude
public import Mahjong.GlobalHelperChannel008V19
import all Mahjong.GlobalHelperChannel008V19
public import Mahjong.CartesianChannels00V19
import all Mahjong.CartesianChannels00V19
public section
set_option maxRecDepth 65536
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
theorem Mahjong.GlobalHelperExact008V19.all_inputs (width input : Nat) :
  Mahjong.GlobalHelperChannel008V19.channel width input = Mahjong.CartesianChannels00V19.channel8 width input := by rfl
#print axioms Mahjong.GlobalHelperExact008V19.all_inputs
