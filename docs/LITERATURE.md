# Selected literature and precedents

These repository notes were added after publication of the three frozen
papers. They do not replace their bibliographies or claim a comprehensive
survey. Entries below were checked against publisher or author-hosted primary
records on 19 October 2026. They provide context, not verification of this
Mahjong result.

| Topic | Primary source | Relevance and boundary |
| --- | --- | --- |
| Certifying algorithms | McConnell, R. M., Mehlhorn, K., Näher, S., and Schweitzer, P. (2011). [Certifying algorithms](https://www.sciencedirect.com/science/article/pii/S1574013710000560). *Computer Science Review*, 5(2), 119-161. DOI: 10.1016/j.cosrev.2010.09.009. | Separates producing an answer from checking an instance certificate. An untrusted proposer is an established pattern; our project does not originate it. |
| Proof-checking foundations | Barendregt, H., and Wiedijk, F. (2005). [The challenge of computer mathematics](https://www.cs.ru.nl/~freek/pubs/rspaper.pdf). *Philosophical Transactions of the Royal Society A*, 363(1835), 2351-2375. | Context for small proof-checking kernels and the de Bruijn criterion. A checked implication still needs faithful interpretation and actual premises. |
| Four-colour formal proof | Gonthier, G. (2008). [Formal proof: The four-color theorem](https://www.ams.org/notices/200811/tx081101382p.pdf). *Notices of the AMS*, 55(11), 1382-1393. | A precedent for formalizing the mathematical specification and computational argument together. It does not make our unjoined components a completed proof. |
| Kepler formal proof | Hales, T., et al. [A formal proof of the Kepler conjecture](https://arxiv.org/abs/1501.02155), author preprint first posted in 2015; journal publication in 2017. | A large collaborative formal proof using HOL Light and Isabelle. The distinction between execution evidence and a checked proof is relevant here. |
| Large SAT certificates | Heule, M. J. H., Kullmann, O., and Marek, V. W. (2016). [Solving and verifying the Boolean Pythagorean triples problem via cube-and-conquer](https://arxiv.org/abs/1605.00723). | A precedent for separating a large search from an independently checkable certificate, including substantial certificate-distribution costs. |
| Certified SAT checking | Cruz-Filipe, L., Heule, M., Hunt, W., Kaufmann, M., and Schneider-Kamp, P. [Efficient certified RAT verification](https://arxiv.org/abs/1612.02353), preprint first posted in 2016. | LRAT supplies hints for simple validation and certified checkers. A receipt or content hash is not an analogous mathematical proof by itself. |
| Alternate Lean checking | Carneiro, M. (2024). [Lean4Lean: Towards a formalized metatheory for the Lean theorem prover](https://arxiv.org/abs/2403.14064v1), version 1. | A separate Lean typechecker and metatheory project. We have not replayed our opening through it; citing it is not evidence of such a replay. |
| Solving games | van den Herik, H. J., Uiterwijk, J. W. H. M., and van Rijswijck, J. (2002). [Games solved: Now and in the future](https://www.sciencedirect.com/science/article/pii/S0004370201001527). *Artificial Intelligence*, 134(1-2), 277-311. DOI: 10.1016/S0004-3702(01)00152-7. | Context for game-solving methods, search and the distinction between the size of a state space and practical decision complexity. |

For the implementation discussed in this repository, use the pinned Lean
4.33.1 source tag and recorded hashes. A moving `/latest/` documentation page
can explain a concept, but does not identify the implementation that ran.
The recorded theorem type, actual data binding, execution route and remaining
assumptions must be assessed separately.
