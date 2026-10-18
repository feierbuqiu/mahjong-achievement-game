module
prelude
public import Mahjong.GlobalHelperChannel263V19
import all Mahjong.GlobalHelperChannel263V19
public import Mahjong.CartesianChannels33V19
import all Mahjong.CartesianChannels33V19
public section
set_option maxRecDepth 65536
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
theorem Mahjong.GlobalHelperExact263V19.all_inputs (width input : Nat) :
  Mahjong.GlobalHelperChannel263V19.channel width input = Mahjong.CartesianChannels33V19.channel263 width input := by rfl
#print axioms Mahjong.GlobalHelperExact263V19.all_inputs
