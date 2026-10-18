# Project status — October 18, 2026

**The project is approaching its final compiled-Lean verification campaign.**
Following the V16 acceleration work, the maintainer's current working
expectation is to finish the remaining campaign **within 20 hours of an
authorized start**. The known-component estimate is **13.0256 hours including
a 25% margin**. This supersedes the September decision to stop pursuing the
campaign.

**The full scan has not started. Correctness is undergoing independent review.**
The final complete-cost assessment has not passed, and the user's prelaunch
hold remains in force. Six production-cost categories remain outside the
known-component screen. The time expectation is conditional; there is no
active countdown or completed full-run guarantee.

Complete compiled checks now cover layers 32, 33 and 34: **303,054,865 unique
rows**. The remaining plan covers layers 0–31, **778,229,809,437 rows** in
3,568 buckets and 17,197 frames. It reuses the verified higher-layer seeds;
it is not a fresh scan of every layer by one new executable.

The [October source and evidence](../research/2026-10-18/README.md) supply the
132-module V16 Lean closure, 104 selected recorded theorem/axiom fingerprints,
GPU and controller source, calibration and resource records, layer-32 audit,
production controls and a read-only publication checker.

The existing exhaustive computation reports a second-player win from the
empty state. The end-to-end opening and ten-tile Lean targets remain
`NOT_VERIFIED`. The planned campaign retains explicit finite premises, the
Lean compiler/runtime and the reviewed Python/OS coverage and IO boundary;
a pure kernel-level opening finalizer has not been constructed.

Independent review, a stronger formal certificate, deeper mathematics,
alternative methods, corrections and other substantive contributions remain
welcome. After review and complete prelaunch acceptance, starting the scan
still requires explicit release of the user's hold.

## Papers and historical snapshot

| English report | Date | Focus |
| --- | --- | --- |
| [Computational second-player win and partial Lean certification](../papers/manuscript.md) | 13 September 2026 | Original rules, exhaustive computation and early concrete proofs |
| [Strategy certificates, enumeration, and retrograde models](../papers/lean-verification/manuscript.md) | 15 September 2026 | Subsequent Lean development, tests and proof boundaries |

Both reports retain their published text. The immutable
[v1.0.0 release](https://github.com/feierbuqiu/mahjong-achievement-game/releases/tag/v1.0.0)
records the September delivery and its then-current maintenance decision;
this October main-branch update creates no new release. Chinese manuscripts
remain excluded. See [data availability](DATA_AVAILABILITY.md),
[evidence boundaries](EVIDENCE.md) and [reproduction](REPRODUCIBILITY.md).
