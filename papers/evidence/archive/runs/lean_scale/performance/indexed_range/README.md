> Archived evidence from the dated local research record. Historical progress and commands describe that record; current supported commands are in the repository reproduction guide. Links to retained attachments lead to their availability entries.

# Proved cached-size range reading on the actual 757-row table

The generic `Mahjong.Scale.IndexedRange` reader and four real old/new range checks passed Lean 4.33.1 with `--trust=0`. The fixed benchmark covers 16 P rows, 544 tile positions and 538 legal first-step responses from the already certified Actual12V2 table. It does not establish a new opening result.

## Trust boundary and API

- `Raw.branch cached left row right` accepts untrusted size data.
- `wellSizedB_iff` proves the recursive Boolean size check equivalent to `WellSized`; `Index` contains that proof. A false cache cannot be accepted by `fromChecked`.
- `rawRead_eq` proves the reader equals `rows(tree).drop(start).take(count)` for all natural start/count values.
- `checkRange_eq` gives exact equality with ResponseGroups; `checkExternalRange_eq` gives exact equality with ExternalResponses while retaining the proved FastExternal row checker.
- The supplied index must additionally satisfy `same : index.tree = database`. The actual757 test proves that exact erasure equality, not just equal counts or IDs.

Typical use after generating literal cache fields:

    def raw : IndexedRange.Raw := ...
    theorem sizes_checked : IndexedRange.wellSizedB raw = true := by decide +kernel
    def index : IndexedRange.Index := IndexedRange.fromChecked raw sizes_checked
    theorem same : index.tree = database := by rfl
    theorem fast_checked : IndexedRange.checkExternalRange registry overrides bounds database index start count = true := by decide +kernel
    theorem original_checked : ExternalResponses.checkRange registry overrides bounds database start count = true :=
      (IndexedRange.checkExternalRange_eq registry overrides bounds database index same start count).symm.trans fast_checked

The `fromTree` conversion is a proved convenience path, not the measured fast path: reducing its root size can traverse the input tree. The benchmark supplies 757 literal cached sizes, checks them once, and reuses the proved index.

## Measurements

Each process used one Lean worker, a 90-second limit and a 3,000,000,000-byte private/RSS watchdog. All processes exited. The generic proof module cost 1.845 s and 877170688 peak private bytes. The separate 757-row cache-validation module cost 2.102 s / 2.047 CPU s and 1074278400 peak private bytes. That cost is excluded from per-range comparisons.

| Actual IDs | Legal responses | CPU old/new (s) | Wall old/new (s) | Kernel type checking old/new (s) | Peak private old/new (GB, decimal) |
| --- | ---: | ---: | ---: | ---: | ---: |
| 0–7 | 266 | 2.797 / 2.781 | 2.869 / 2.803 | 1.23 / 1.2 | 1.226 / 1.229 |
| 744–751 | 272 | 5.641 / 5.359 | 5.679 / 5.399 | 4.06 / 3.77 | 1.666 / 1.630 |

The late eight-row sample reduced CPU by 4.99%; the first sample changed by only 0.56%. This is one small paired run, not a robust throughput estimate. Both sides import the same cache module and use identical FastExternal row checks. Exact equality is a generic theorem independent of these timings. Most work in these samples remains actual rule/response checking; repeated imports and existing reply lookup are unchanged. No million-row or complete-certificate speedup is claimed.

Cache boundary checks covered start/count = (0,8), (744,8), (752,8), (757,8), (750,0), including a partial final slice, beyond-end and zero count. A one-row cache claiming size 2 was kernel-rejected. All printed axiom reports use only propext, Classical.choice and Quot.sound, or subsets thereof. No sorry, native_decide, or additional axiom is used.

## Reproduction and evidence

- Generator: `build/lean_scale/performance/indexed_range/generate.cjs`; it copies only passed, source/hash-verified dependencies and preserves existing identical-source library files. Every actual object used is recorded; existing objects are not silently relabeled as parent receipt objects.
- Definition/source provenance and recursive dependency hashes: `generation.json`.
- Generic proof: `logic_v1/result.json`.
- Literal cache and erasure checks: `index_v1/result.json`.
- Paired real checks: `paired_v1/result.json`.
- Machine-readable metrics, complete axiom lists and state fixtures: `summary.json`.

Commands run from the research root (evidence tags refuse reuse):

    node build/lean_scale/performance/indexed_range/generate.cjs
    & build/lean_scale/performance/compile.ps1 -Modules 'MahjongScale.IndexedRange' -Tag 'indexed_range/logic_v1'
    & build/lean_scale/performance/compile.ps1 -Modules 'MahjongScale.RangeBench.Index' -Tag 'indexed_range/index_v1'
    & build/lean_scale/performance/compile.ps1 -Modules @('MahjongScale.RangeBench.Baseline0','MahjongScale.RangeBench.Indexed0','MahjongScale.RangeBench.Baseline1','MahjongScale.RangeBench.Indexed1') -Tag 'indexed_range/paired_v1'

The commands are documented as executed; reproduction in the same workspace needs fresh output tags/directories rather than overwriting retained evidence. Only new performance-project files were written. Frozen 757-row proofs and old data/checkpoints were not changed.

Generic source SHA-256: b2f894a09457ae7cd110ab8b59a7faa4f72720aa81552ca3cba02518b83d022f
Generic olean SHA-256: 9ad5c65484f22532998eaf373802f70e31f2dd73158808f50522ab0a7bad4dd7
Summary SHA-256: ff452b5ee08973e48188f680f25d290617fc7816abbca9853cf5f3b79870197a
