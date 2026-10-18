module
prelude
public import Mahjong.CartesianBoolS08C00V19
public import Mahjong.CartesianBoolS08C01V19
public import Mahjong.CartesianBoolS08C02V19
public import Mahjong.CartesianBoolS08C03V19
public section
theorem Mahjong.CartesianBoolAllS08V19.accepted :
  Mahjong.CartesianBoolS08C00V19.checks = true ∧
  Mahjong.CartesianBoolS08C01V19.checks = true ∧
  Mahjong.CartesianBoolS08C02V19.checks = true ∧
  Mahjong.CartesianBoolS08C03V19.checks = true := And.intro Mahjong.CartesianBoolS08C00V19.accepted (And.intro Mahjong.CartesianBoolS08C01V19.accepted (And.intro Mahjong.CartesianBoolS08C02V19.accepted (Mahjong.CartesianBoolS08C03V19.accepted)))
#print axioms Mahjong.CartesianBoolAllS08V19.accepted
