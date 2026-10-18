module
prelude
public import Mahjong.GlobalHelperChannel259V19
import all Mahjong.GlobalHelperChannel259V19
public import Mahjong.CartesianChannels32V19
import all Mahjong.CartesianChannels32V19
public section
set_option maxRecDepth 65536
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
theorem Mahjong.GlobalHelperExact259V19.all_inputs (width input : Nat) :
  Mahjong.GlobalHelperChannel259V19.channel width input = Mahjong.CartesianChannels32V19.channel259 width input := by rfl
#print axioms Mahjong.GlobalHelperExact259V19.all_inputs
