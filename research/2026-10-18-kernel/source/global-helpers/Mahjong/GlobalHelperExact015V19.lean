module
prelude
public import Mahjong.GlobalHelperChannel015V19
import all Mahjong.GlobalHelperChannel015V19
public import Mahjong.CartesianChannels02V19
import all Mahjong.CartesianChannels02V19
public section
set_option maxRecDepth 65536
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
theorem Mahjong.GlobalHelperExact015V19.all_inputs (width input : Nat) :
  Mahjong.GlobalHelperChannel015V19.channel width input = Mahjong.CartesianChannels02V19.channel15 width input := by rfl
#print axioms Mahjong.GlobalHelperExact015V19.all_inputs
