# Current status: working trust paper and completed scoped results

**As of 19 October 2026, the fixed V17 native verification is complete.**
The empty position is accepted as **P (second player wins)**, with the claim
class **kernel-proved whole-input implication plus native evaluation**.
The actual-input opening Lean declaration remains **`NOT_VERIFIED`**.

The Lean kernel checks a theorem concluding `SecondPlayerWins Step Win empty`
from six finite Boolean acceptance families. A single compiled native build
evaluated those functions on the complete actual input: 778,532,864,302 SAFE
orbits in layers 0–34, 3,686 nonempty buckets and 17,317 committed frames.
No earlier PASS records or seeds were imported. The input identity maps
before and after the run agree. The recorded timers are about 7.6 hours for
this run; they are measurements, not guarantees for another machine or workload.

## Latest paper and subsequent component evidence

The [new English trust/verification supplement](../papers/trust-verification/manuscript.md)
is published as a working main-branch manuscript. It awaits later user-supplied
external review; no new release, tag or freeze is performed.

Later bounded work completed the 28-block / 402-word numerical pilot, with
1,234 layout equalities and a 273-module saved-proof closure. Fresh replay
took 61.828 seconds. It proves specified numerical equations; actual SAFE,
complete target addressing and the game-semantic join remain missing.
The eleven-node physical-game pilot and its import/proof-style variants
retain the same three highlighted nonempty 32-tile conclusions.

A complete local delivery now exists: core/toolchain/source, all historical
inputs and optional saved pilots. A same-host clean extraction/rebuild and
selected-bucket test passed, as did all three saved-proof lanes. These are
not a second complete native run or second physical-machine replication.
The [delivery descriptor](../papers/trust-verification/delivery.json) lists
their identities; **the three local archives are not public downloads here**.
This supersedes the earlier statement that packaging was still incomplete.

## What the whole-input result establishes

The saved records report acceptance of the base finite data, successor lists,
per-bucket metadata, row/frame checks with exact cover, cross-layer byte
identity and empty-root P check. Their counts are P = 203,051,492,021 and
N = 575,481,372,281. This checks the stored September table; it does not
regenerate it or convert every native result into a persisted Lean proof.

See the [current source/evidence](../research/2026-10-19-v17/README.md),
[machine-readable status](../RESEARCH_STATUS.json), [claim table](CLAIMS.md)
and [version glossary](INTERNAL_VERSIONS.md). The old compiled-checker total
of 303,054,865 rows is a historical V16 milestone; it is not the current
all-layer native coverage or a count of closed kernel certificates.

## Independent cross-check and remaining trust

A [separate AI review](../research/2026-10-19-v17/review/INDEPENDENT_REVIEW.md)
reports no defect within its inspected scope. Its own script checked the
17,317-frame ledger, every native frame-result binding, exact bucket cover,
54,548 cross-layer identity references and the root bit. A seeded sample of
62 input files (81,370,822 bytes) had no hash mismatch.

The reviewer did not rerun Lean or the native checker, did not hash all
100.62 GB, and reviewed only the finalizer line by line among the trusted
Python bookkeeping files. This is independent source/record inspection by
another AI, **not independent execution replication or human peer review**.
The execution stack, faithful rule modeling, IO/input custody and external
bookkeeping remain explicit parts of the trust boundary.

## Remaining work

- Independent replication with a different machine, compiler or toolchain,
  starting with base/successor/root checks and clearly specified frame coverage.
- Human review of the formal rules and the remaining trusted bookkeeping.
- A closed Lean theorem for the actual input, if a practical proof-construction,
  persistence and cold-replay method becomes available.
- Further review and revision of the new working manuscript. The two September papers retain their dates.

The earlier V18/V19 whole-table proof-export optimization was stopped.
Later bounded numeric/game experiments and local-delivery tests are recorded separately in the new paper. The legacy
V16 STOP remains in place; the separately authorized V17 run completed without
removing it. No future strict-kernel completion deadline is established, and
this repository publication launches no new research job. Deeper proofs,
alternative approaches, corrections and replication contributions remain welcome.

## Availability and releases

Small source, input hashes and summaries live in Git. The full saved ledger,
all committed frame receipts and native frame-result records are distributed
as a [hash-pinned evidence asset](../research/2026-10-19-v17/assets.json).
The full input dataset is not a public download. Completed local archives
and their same-host validation now exist, with public identity/scope records;
the archives themselves are not uploaded by this update.

The immutable [v1.0.0 release](https://github.com/feierbuqiu/mahjong-achievement-game/releases/tag/v1.0.0)
and the two September manuscripts remain unchanged. The existing separate
evidence-asset tag is preserved. The new paper is a working edition on main;
this update creates no tag or release. See [data availability](DATA_AVAILABILITY.md).
