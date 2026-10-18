module
prelude
public import Mahjong.GlobalHelperChannel005V19
import all Mahjong.GlobalHelperChannel005V19
public import Mahjong.CartesianChannels00V19
import all Mahjong.CartesianChannels00V19
public section
set_option maxRecDepth 65536
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
theorem Mahjong.GlobalHelperExact005V19.all_inputs (width input : Nat) :
  Mahjong.GlobalHelperChannel005V19.channel width input = Mahjong.CartesianChannels00V19.channel5 width input := by rfl
#print axioms Mahjong.GlobalHelperExact005V19.all_inputs
