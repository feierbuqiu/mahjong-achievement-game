module
prelude
public import Mahjong.GlobalHelperChannel252V19
public import Mahjong.CartesianChannels28V19
public section
set_option maxRecDepth 65536
set_option maxHeartbeats 100000000
set_option profiler.threshold 0
theorem Mahjong.GlobalHelperEqual252V19.all_inputs (width input : Nat) :
  Mahjong.GlobalHelperChannel252V19.channel width input = Mahjong.CartesianChannels28V19.channel252 width input := by rfl
#print axioms Mahjong.GlobalHelperEqual252V19.all_inputs
