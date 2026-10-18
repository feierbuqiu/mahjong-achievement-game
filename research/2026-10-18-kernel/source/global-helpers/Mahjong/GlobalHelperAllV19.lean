module
prelude
public import Mahjong.GlobalHelperPNB00V19
public import Mahjong.GlobalHelperPNB01V19
public import Mahjong.GlobalHelperPNB27V19
public section
theorem Mahjong.GlobalHelperAllV19.accepted :
  Mahjong.GlobalHelperPNB00V19.checks = true ∧
  Mahjong.GlobalHelperPNB01V19.checks = true ∧
  Mahjong.GlobalHelperPNB27V19.checks = true := And.intro Mahjong.GlobalHelperPNB00V19.accepted (And.intro Mahjong.GlobalHelperPNB01V19.accepted Mahjong.GlobalHelperPNB27V19.accepted)
#print axioms Mahjong.GlobalHelperAllV19.accepted
