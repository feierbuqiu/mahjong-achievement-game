module
prelude
public import Mahjong.GlobalHelperChannel016V19
import all Mahjong.GlobalHelperChannel016V19
public import Mahjong.CartesianChannels03V19
import all Mahjong.CartesianChannels03V19
public section
set_option maxRecDepth 65536
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
theorem Mahjong.GlobalHelperExact016V19.all_inputs (width input : Nat) :
  Mahjong.GlobalHelperChannel016V19.channel width input = Mahjong.CartesianChannels03V19.channel16 width input := by rfl
#print axioms Mahjong.GlobalHelperExact016V19.all_inputs
