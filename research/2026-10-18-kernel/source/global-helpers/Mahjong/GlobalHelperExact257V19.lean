module
prelude
public import Mahjong.GlobalHelperChannel257V19
import all Mahjong.GlobalHelperChannel257V19
public import Mahjong.CartesianChannels31V19
import all Mahjong.CartesianChannels31V19
public section
set_option maxRecDepth 65536
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
theorem Mahjong.GlobalHelperExact257V19.all_inputs (width input : Nat) :
  Mahjong.GlobalHelperChannel257V19.channel width input = Mahjong.CartesianChannels31V19.channel257 width input := by rfl
#print axioms Mahjong.GlobalHelperExact257V19.all_inputs
