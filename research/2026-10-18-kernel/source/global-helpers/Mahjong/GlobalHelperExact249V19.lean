module
prelude
public import Mahjong.GlobalHelperChannel249V19
import all Mahjong.GlobalHelperChannel249V19
public import Mahjong.CartesianChannels26V19
import all Mahjong.CartesianChannels26V19
public section
set_option maxRecDepth 65536
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
theorem Mahjong.GlobalHelperExact249V19.all_inputs (width input : Nat) :
  Mahjong.GlobalHelperChannel249V19.channel width input = Mahjong.CartesianChannels26V19.channel249 width input := by rfl
#print axioms Mahjong.GlobalHelperExact249V19.all_inputs
