module
prelude
public import Mahjong.CartesianPrepB00V19
public import Mahjong.CartesianPrepB01V19
public import Mahjong.CartesianPrepB02V19
public import Mahjong.CartesianPrepB03V19
public import Mahjong.CartesianPrepB04V19
public import Mahjong.CartesianPrepB05V19
public import Mahjong.CartesianPrepB06V19
public import Mahjong.CartesianPrepB07V19
public import Mahjong.CartesianPrepB08V19
public import Mahjong.CartesianPrepB09V19
public import Mahjong.CartesianPrepB10V19
public import Mahjong.CartesianPrepB11V19
public import Mahjong.CartesianPrepB12V19
public import Mahjong.CartesianPrepB13V19
public import Mahjong.CartesianPrepB14V19
public import Mahjong.CartesianPrepB15V19
public import Mahjong.CartesianPrepB16V19
public import Mahjong.CartesianPrepB17V19
public import Mahjong.CartesianPrepB18V19
public import Mahjong.CartesianPrepB19V19
public import Mahjong.CartesianPrepB20V19
public import Mahjong.CartesianPrepB21V19
public import Mahjong.CartesianPrepB22V19
public import Mahjong.CartesianPrepB23V19
public import Mahjong.CartesianPrepB24V19
public import Mahjong.CartesianPrepB25V19
public import Mahjong.CartesianPrepB26V19
public import Mahjong.CartesianPrepB27V19
public section
set_option autoImplicit false
set_option maxRecDepth 65536
namespace Mahjong.CartesianAllPrepV19
def StatementOf {p : Prop} (_proof : p) : Prop := p
theorem all_closed_actual_blocks :
  StatementOf Mahjong.CartesianPrepB00V19.every_layout_and_valid_mask ∧
  StatementOf Mahjong.CartesianPrepB01V19.every_layout_and_valid_mask ∧
  StatementOf Mahjong.CartesianPrepB02V19.every_layout_and_valid_mask ∧
  StatementOf Mahjong.CartesianPrepB03V19.every_layout_and_valid_mask ∧
  StatementOf Mahjong.CartesianPrepB04V19.every_layout_and_valid_mask ∧
  StatementOf Mahjong.CartesianPrepB05V19.every_layout_and_valid_mask ∧
  StatementOf Mahjong.CartesianPrepB06V19.every_layout_and_valid_mask ∧
  StatementOf Mahjong.CartesianPrepB07V19.every_layout_and_valid_mask ∧
  StatementOf Mahjong.CartesianPrepB08V19.every_layout_and_valid_mask ∧
  StatementOf Mahjong.CartesianPrepB09V19.every_layout_and_valid_mask ∧
  StatementOf Mahjong.CartesianPrepB10V19.every_layout_and_valid_mask ∧
  StatementOf Mahjong.CartesianPrepB11V19.every_layout_and_valid_mask ∧
  StatementOf Mahjong.CartesianPrepB12V19.every_layout_and_valid_mask ∧
  StatementOf Mahjong.CartesianPrepB13V19.every_layout_and_valid_mask ∧
  StatementOf Mahjong.CartesianPrepB14V19.every_layout_and_valid_mask ∧
  StatementOf Mahjong.CartesianPrepB15V19.every_layout_and_valid_mask ∧
  StatementOf Mahjong.CartesianPrepB16V19.every_layout_and_valid_mask ∧
  StatementOf Mahjong.CartesianPrepB17V19.every_layout_and_valid_mask ∧
  StatementOf Mahjong.CartesianPrepB18V19.every_layout_and_valid_mask ∧
  StatementOf Mahjong.CartesianPrepB19V19.every_layout_and_valid_mask ∧
  StatementOf Mahjong.CartesianPrepB20V19.every_layout_and_valid_mask ∧
  StatementOf Mahjong.CartesianPrepB21V19.every_layout_and_valid_mask ∧
  StatementOf Mahjong.CartesianPrepB22V19.every_layout_and_valid_mask ∧
  StatementOf Mahjong.CartesianPrepB23V19.every_layout_and_valid_mask ∧
  StatementOf Mahjong.CartesianPrepB24V19.every_layout_and_valid_mask ∧
  StatementOf Mahjong.CartesianPrepB25V19.every_layout_and_valid_mask ∧
  StatementOf Mahjong.CartesianPrepB26V19.every_layout_and_valid_mask ∧
  StatementOf Mahjong.CartesianPrepB27V19.every_layout_and_valid_mask := And.intro Mahjong.CartesianPrepB00V19.every_layout_and_valid_mask (And.intro Mahjong.CartesianPrepB01V19.every_layout_and_valid_mask (And.intro Mahjong.CartesianPrepB02V19.every_layout_and_valid_mask (And.intro Mahjong.CartesianPrepB03V19.every_layout_and_valid_mask (And.intro Mahjong.CartesianPrepB04V19.every_layout_and_valid_mask (And.intro Mahjong.CartesianPrepB05V19.every_layout_and_valid_mask (And.intro Mahjong.CartesianPrepB06V19.every_layout_and_valid_mask (And.intro Mahjong.CartesianPrepB07V19.every_layout_and_valid_mask (And.intro Mahjong.CartesianPrepB08V19.every_layout_and_valid_mask (And.intro Mahjong.CartesianPrepB09V19.every_layout_and_valid_mask (And.intro Mahjong.CartesianPrepB10V19.every_layout_and_valid_mask (And.intro Mahjong.CartesianPrepB11V19.every_layout_and_valid_mask (And.intro Mahjong.CartesianPrepB12V19.every_layout_and_valid_mask (And.intro Mahjong.CartesianPrepB13V19.every_layout_and_valid_mask (And.intro Mahjong.CartesianPrepB14V19.every_layout_and_valid_mask (And.intro Mahjong.CartesianPrepB15V19.every_layout_and_valid_mask (And.intro Mahjong.CartesianPrepB16V19.every_layout_and_valid_mask (And.intro Mahjong.CartesianPrepB17V19.every_layout_and_valid_mask (And.intro Mahjong.CartesianPrepB18V19.every_layout_and_valid_mask (And.intro Mahjong.CartesianPrepB19V19.every_layout_and_valid_mask (And.intro Mahjong.CartesianPrepB20V19.every_layout_and_valid_mask (And.intro Mahjong.CartesianPrepB21V19.every_layout_and_valid_mask (And.intro Mahjong.CartesianPrepB22V19.every_layout_and_valid_mask (And.intro Mahjong.CartesianPrepB23V19.every_layout_and_valid_mask (And.intro Mahjong.CartesianPrepB24V19.every_layout_and_valid_mask (And.intro Mahjong.CartesianPrepB25V19.every_layout_and_valid_mask (And.intro Mahjong.CartesianPrepB26V19.every_layout_and_valid_mask (Mahjong.CartesianPrepB27V19.every_layout_and_valid_mask)))))))))))))))))))))))))))
end Mahjong.CartesianAllPrepV19
#print axioms Mahjong.CartesianAllPrepV19.all_closed_actual_blocks
