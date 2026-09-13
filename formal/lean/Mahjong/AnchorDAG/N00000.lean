import Mahjong.ActualCertificateSmoke
import Mahjong.ResponseCertificate

namespace Mahjong.AnchorDAG.N00000
abbrev state : State := ActualCandidateFacts.candidate
theorem proved : ResponseCertificate.ProvedP state :=
  ⟨ActualCandidateFacts.valid, ActualCandidateSafe.safe, ActualCertificateSmoke.candidate_P⟩
end Mahjong.AnchorDAG.N00000
