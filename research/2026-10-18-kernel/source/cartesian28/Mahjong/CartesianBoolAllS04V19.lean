module
prelude
public import Mahjong.CartesianBoolS04C00V19
public import Mahjong.CartesianBoolS04C01V19
public import Mahjong.CartesianBoolS04C02V19
public import Mahjong.CartesianBoolS04C03V19
public import Mahjong.CartesianBoolS04C04V19
public import Mahjong.CartesianBoolS04C05V19
public import Mahjong.CartesianBoolS04C06V19
public section
theorem Mahjong.CartesianBoolAllS04V19.accepted :
  Mahjong.CartesianBoolS04C00V19.checks = true ∧
  Mahjong.CartesianBoolS04C01V19.checks = true ∧
  Mahjong.CartesianBoolS04C02V19.checks = true ∧
  Mahjong.CartesianBoolS04C03V19.checks = true ∧
  Mahjong.CartesianBoolS04C04V19.checks = true ∧
  Mahjong.CartesianBoolS04C05V19.checks = true ∧
  Mahjong.CartesianBoolS04C06V19.checks = true := And.intro Mahjong.CartesianBoolS04C00V19.accepted (And.intro Mahjong.CartesianBoolS04C01V19.accepted (And.intro Mahjong.CartesianBoolS04C02V19.accepted (And.intro Mahjong.CartesianBoolS04C03V19.accepted (And.intro Mahjong.CartesianBoolS04C04V19.accepted (And.intro Mahjong.CartesianBoolS04C05V19.accepted (Mahjong.CartesianBoolS04C06V19.accepted))))))
#print axioms Mahjong.CartesianBoolAllS04V19.accepted
