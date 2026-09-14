> **Publication note:** this is a dated audit record. Its earlier observations about `main` and `v0.3.0` describe the time of that audit. The accompanying release is now `v1.0.0`; see [current availability](README.md).

# Reproduction and availability audit for the Lean supplement

Audit date: 15 September 2026, Australia/Sydney. This memo distinguishes the immutable public snapshot, an uncommitted publication draft, the current local research sources, retained native evidence, and a fresh source replay. It does not initiate the paused research campaign.

## 1. Findings suitable for the paper

1. A new, isolated source replay passed **all 84 modules** in the dependency closure of `Mahjong.OptimizedRetroCertification`. It reproduced the reported axiom sets of **all 79 core declarations**, used fresh project objects, and took **94.172 s** with at most **two Lean processes**. Sampled aggregate process-tree private memory peaked at **2,313,740,288 bytes**. The Windows Job enforced a **15,500,000,000-byte** aggregate commit limit and an **80% CPU** cap; each Lean invocation used `--trust=0 -M3072 -j1`. A separate replay from the ZIP-extracted recipient directory subsequently passed the same 84 modules and 79 axiom records in **93.922 s**, with **2,305,208,320 bytes** sampled peak private memory and the same resource limits. These check mathematical source and proofs. They execute no native checker, supply no finite input instance and certify no additional historical P/N row.
2. The existing read-only current-evidence check also passed: **5,329 retained files**, **79 audited declarations**, acceptance SHA-256 `1f23e423794ce0f64a001367d59a41baab82fd517602e9c48046c95a96b14400`. Its file inventory totals **3,139,914,649 bytes**, including tooling, intermediate files and synthetic test outputs. It contains **no historical `runs/global_retro/*.bits` payloads**. Rehashing this collection is not replaying its computations.
3. Live read-only GitHub checks found public `main` at **`691d2400d09d5ddfb18d4721835d464b0f4ecebb`**, the same commit as immutable **v0.3.0**. At the observation timestamp, its public `research/` directory contained **2026-09-14 only**. Therefore a command under `research/2026-09-15/` must not be presented as an available public command at that commit.
4. The frozen public package contains **1,008 concrete-proof source modules** and a separate **56-module checker archive**. The local current checker tree contains **148 `.lean` files**; its latest algorithm closure contains **84 files / 487,370 source bytes**. Every one of the old public 56 checker sources remains byte-identical in the current local tree. The 148-file count is an inventory, not the size of the replay performed here, and must not be added to the concrete-proof or game-state counts.
5. A local uncommitted September 15 publication draft contains an 84-module archive byte-identical to the current algorithm closure. The draft changed during this audit: its advertised `verify.py` was initially absent and was subsequently created. Its presence in a dirty working tree is not evidence that the corresponding command is published, frozen or accepted by CI.

Primary fresh records: [initial source replay](reproduction/source-replay.json), [recipient-path replay](reproduction/recipient-replay.json), [final recipient/package validation](reproduction/recipient_delivery_validation.json), [public availability](reproduction/public_availability.json), [inventory and release gap](reproduction/inventory.json), [current retained-file check](reproduction/current_retained_evidence_check.log), [public checker receipt check](reproduction/public_v030_handoff_check.log), [public concrete-proof integrity check](reproduction/public_v030_formal_integrity.log).

## 2. Actual public baseline and commands

The following commands apply to the verified public commit, rather than an unspecified future `main`:

```bash
git clone https://github.com/feierbuqiu/mahjong-achievement-game.git
cd mahjong-achievement-game
git checkout --detach 691d2400d09d5ddfb18d4721835d464b0f4ecebb
python3 tools/verify_repository.py
python3 tools/verify_lean.py --check-only
python3 research/2026-09-14/verify.py
```

`verify_lean.py --check-only` returned `PASS_ARTIFACT_INTEGRITY`, with 1,008 source modules and `empty_game_lean: NOT_VERIFIED`, in this audit of the untouched offline checkout. The separate September 14 checker command returned `PASS_PUBLIC_HANDOFF`: 470 artifacts, 56 source modules, 47 benchmark cases, 745,472 evaluations and 356,352 distinct sampled slots. These commands check identities, dependency inventories and receipt arithmetic; neither is a fresh kernel replay.

The exact public fresh concrete-proof commands are:

```bash
python3 tools/verify_lean.py --lean /path/to/lean --workers 2
python3 tools/verify_lean.py --lean /path/to/lean --entry latest --workers 2
python3 tools/verify_lean.py --lean /path/to/lean --entry PipelineAudit --workers 1
```

The default requests all **1,008 distinct modules across seven audit entrypoints**, covering the eight indexed nonempty physical roots. `--entry latest` requests the **374-module** closure for the September 13 milestones, including the twelve-tile root and reusable registry, the fourteen-tile root and the compressed twenty-tile proofs. `--entry PipelineAudit` requests the small independent thirty-four-tile pipeline. Here “latest” is the frozen runner's named September 13 group, not the latest September 15 research.

The public concrete-proof runner checks the frozen provenance and import closure, copies source into a new `runs/` directory, and puts only newly compiled project objects on `LEAN_PATH`. It uses the distribution's standard libraries; there is **no Mathlib or external Lake package dependency**. A successful request reports `kernel_modules: PASS` while preserving `empty_game_lean: NOT_VERIFIED`. Normally the process exits 0 for the requested nonempty proofs; `--require-opening` instead requests exit 2 when the opening remains unproved. A failed Lean module or failed audit is distinct from that deliberate incomplete-opening exit convention.

For the public 56-module checker archive, the actual source command is:

```bash
python3 research/2026-09-14/verify.py --lean /path/to/lean
```

It uses fresh objects, one compiler process at a time, `--trust=0 -M3072 -j1`, and a 300-second per-module timeout. The reported success is `PASS_KERNEL_SOURCE`; it does not execute native workers. The publication's retained cold replay was 105.266 s. This audit did not rerun those 56 modules separately, because the current 84-module replay provides a different, explicitly recorded closure. It would be incorrect to relabel the new 84-module receipt as a rerun of the old 56-module archive.

Evidence: [frozen formal guide](https://github.com/feierbuqiu/mahjong-achievement-game/blob/v0.3.0/formal/README.md), especially its source-replay and recorded-replay sections; [concrete-proof runner](https://github.com/feierbuqiu/mahjong-achievement-game/blob/v0.3.0/tools/verify_lean.py), lines 59–112 for provenance/closure checks and 116 onwards for options and fresh construction; [checker runner](https://github.com/feierbuqiu/mahjong-achievement-game/blob/v0.3.0/research/2026-09-14/verify.py), lines 167–235 for replay; [frozen general reproduction guide](https://github.com/feierbuqiu/mahjong-achievement-game/blob/v0.3.0/docs/REPRODUCIBILITY.md).

Public stable links: [v0.3.0 release](https://github.com/feierbuqiu/mahjong-achievement-game/releases/tag/v0.3.0), [formal guide at the verified commit](https://github.com/feierbuqiu/mahjong-achievement-game/blob/691d2400d09d5ddfb18d4721835d464b0f4ecebb/formal/README.md), [September 14 handoff at the same commit](https://github.com/feierbuqiu/mahjong-achievement-game/blob/691d2400d09d5ddfb18d4721835d464b0f4ecebb/research/2026-09-14/README.md).

## 3. Toolchain and portability

The distribution is pinned to **Lean 4.33.1**. The public `formal/lean/lean-toolchain` is exactly `leanprover/lean4:v4.33.1`. The fresh local execution reported:

```text
Lean (version 4.33.1, x86_64-w64-windows-gnu, commit 819816b2e0a3bf405af45ae5c7af2491d8f5bee6, Release)
```

The tested Windows `lean.exe` SHA-256 is `af49bacfabaa1fea71332ca0feae0fa1a60912219d5902291adc79f905bffb8d`. The retained official distribution receipts identify:

| Distribution | Archive bytes | SHA-256 |
|---|---:|---|
| Windows ZIP | 842,456,015 | `c39360867edfff6b090f20c16e18581c969ce839b71e813d76022ec04ec73e4d` |
| Linux `.tar.zst` | 570,405,234 | `890afd185370f85666025b883914ab4f4b339136f8c96167b69cfb62aecaf235` |

The public Python runners use the standard library and require Python 3.10+. The new local resource-monitored driver used **Python 3.12.14** and **psutil 7.2.2**; its `hashlib.file_digest` implementation requires Python 3.11+ if reused. The audited local resource controller requires Windows `ctypes` Job APIs. The public fresh-source scripts can locate an explicitly supplied Lean executable and do not depend on private runtime paths. Linux/Windows success for the old public concrete-proof package is not a completed Linux/macOS portability test of the new 84-module closure or native controllers. This audit's fresh replay was Windows-only.

`-M3072` is Lean's per-process internal heap limit, not an operating-system guarantee that total private memory never exceeds 3 GiB. The new receipt separately records the Windows Job aggregate limit and sampled process-tree memory. The public concrete-proof guide recommends allowing at least 8 GB available memory for two workers; the old Linux capacity-cache replay failed at a smaller 2 GB setting. Hardware timings are measurements, not portable upper bounds.

Evidence: [distribution receipt](https://github.com/feierbuqiu/mahjong-achievement-game/blob/v0.3.0/formal/evidence/toolchain.json), [pinned Lake configuration](https://github.com/feierbuqiu/mahjong-achievement-game/blob/v0.3.0/formal/lean/lakefile.toml), [fresh result](reproduction/source-replay.json).

## 4. New isolated current-source replay

The original research build script is unsuitable for a fresh isolated audit as supplied: [build.py](evidence-catalogue.md#source-015), lines 3–7, fixes the active build, run and Windows toolchain locations; its build function can copy missing source from an older tree, write active outputs, and reuse matching `.olean`/generated C artifacts. `--native` additionally compiles and links executable code. No such build command was run here.

Instead, this audit added [replay_current_sources.py](evidence-catalogue.md#source-016). It writes only beneath its own `reproduction/` directory, copies source bytes, follows imports, builds fresh project objects, installs the inspected Job limit, monitors memory and a 300-second overall deadline, and checks the 79 declared axiom outputs against the retained acceptance. It does not load saved project `.olean` files. Standard-library objects are still supplied by the fixed Lean distribution, as usual.

From the local research root, using the tested Python executable or an equivalent Python 3.11+ environment with `psutil`:

```powershell
python runs/lean_supplement_20260915/reproduction/replay_current_sources.py --entry Mahjong.OptimizedRetroCertification --workers 2 --seconds 300 --label independent_model_replay_new
```

The label must name a new output directory. The exact executed label was `optimized_source_v2`; its result SHA-256 is **`b77ccc01b5f1c2fcaf09f116068daa3631cd0f51d7e74df0ba470301b6648cef`**. The driver SHA-256 is **`a19590acb6207d86c19ad5ce568269c943ecb34cc21d0de0bb02ee6eebf95ee1`**. The source manifest, dependency order, every invocation, elapsed time, output and log hashes, allowed axioms, tool identity and final coverage are in the receipt. All 84 original source hashes were unchanged after replay.

The frozen source subdirectory contains the **148-file current inventory**, of which exactly the declared 84-file closure was compiled. To request the complete current inventory with the same bounded driver, the supported mode is:

```powershell
python runs/lean_supplement_20260915/reproduction/replay_current_sources.py --all-source --workers 2 --seconds 300 --label full_source_inventory_attempt_new
```

**This all-source command was not executed here.** Its completion status must be read from its own receipt; a deadline produces a partial result. Independent entrypoint closures can instead be selected with repeated `--entry` options and distinct labels. This documents a route to check all current source modules without asserting that the new audit already did so. Compiling a worker's `.lean` module does not execute its native `main` on any dataset.

The first driver attempt, `optimized_source_v1`, stopped after 39 successful Lean modules because of a scheduling assertion in the newly written audit driver. The assertion ran before reconsidering newly satisfied dependencies. The driver was corrected and the v2 replay started with a new source copy and empty project-object directory. The failed/partial first receipt remains preserved; no Lean failure or successful result is being hidden, and its time is not included in the v2 cold-replay measurement.

The executed driver above is a **local research-tree reproduction entry**: it locates the fixed toolchain and the inspected Job-support file relative to the research root. A separate small, self-contained local source bundle has therefore been prepared for recipients who do not have that tree. If using the alternative new public-draft script, its imported September 14 replay helper and preliminary integrity-check dependencies must also be delivered; it should not be copied alone. A source-only recipient does not need the 3.14 GB retained native evidence or the historical P/N table.

### 4.1. Standalone local recipient bundle

The [current model source ZIP](https://github.com/feierbuqiu/mahjong-achievement-game/releases/download/v1.0.0/current_model_source_bundle.zip) contains **91 input files**, including the exact **84 source modules**, `source_manifest.json`, `expected_axioms.json`, `lean-toolchain`, `README.md`, a self-contained `replay.py`, `REPLAY.json` and `FILES.sha256`. The final archive is **175,554 bytes**, with SHA-256 **`fdd9e7ebaaaeac891e746b69f604ee9fc92ccdb85c4c03f92b4affd164f4da33`**. It is a local review artifact and has not been published.

The standalone driver embeds the inspected Windows Job implementation and accepts an explicit Lean executable and optional source directory. It has no dependency on the original research tree, original acceptance directory or private workstation path. From the extracted bundle folder, using Windows and Python 3.11+ with `psutil`:

```powershell
python replay.py --check-only
python replay.py --lean C:/path/to/lean.exe --workers 2 --seconds 300 --label recipient_replay_new
```

The optional form `--source-root C:/path/to/source` still requires the manifest's exact 84 files and import graph. A new label is required for each replay. The complete expected result is `PASS_KERNEL_SOURCE` with 84 modules and 79 matching axiom records; `empty_game_lean` remains `NOT_VERIFIED`. The driver preserves the same two-worker, per-process Lean limit, 15.5 GB Job cap, CPU cap and overall deadline as the executed audit.

The first package's hashes, ZIP integrity, command-line help and source-manifest checks passed, including after relocation to a folder with spaces. Those initial cheap checks remain in [package_validation.json](reproduction/package_validation.json). To exercise the changed wrapper and actual recipient path, the ZIP was then extracted to `reproduction/recipient_delivery_test/`, and its packaged `replay.py` was executed without a `--source-root` override. It passed **84/84 modules and 79/79 axiom declarations**, with no project-object reuse, in **93.922 s**, at a sampled process-tree private-memory peak of **2,305,208,320 bytes** and at most two Lean processes. The same Job and Lean limits were installed. The full recipient-path receipt SHA-256 is **`df7371b2d6d3cc3780c9a7052fd026765f047e8178e2f980c70d2a9f7d4a9ba3`**.

The actual tested ZIP is preserved as [current_model_source_bundle_tested_v1.zip](evidence-catalogue.md#source-017), SHA-256 `ff9a3e9986770dd52191bb93d767a2046054ce629545bdb1539c9709c38479e9`. After the recipient replay, only the README, manifest, checksum list and replay-summary metadata were updated for the final archive. **Every source and replay-driver byte remains identical to the tested archive**; the driver SHA-256 is `7bb0062947ab614fb34b9c895208087c85e9c4feb6da7a8c15159f5aeda16b0c`. Final hashes, ZIP contents, help and integrity checks passed; no third proof compilation was performed. The final record is [recipient_delivery_validation.json](reproduction/recipient_delivery_validation.json).

The new resource-limited driver is Windows-only; Linux/macOS are explicitly rejected and untested. The Lean source remains separable from that controller for future platform validation. Thus the audit demonstrates independence from the original research-source directory and a working delivered Windows path, without claiming cross-platform execution or native-data verification.

## 5. Native evidence, inputs and the 97.32 GB table

| Requested verification | Required material | Historical full P/N table needed? | Logical/execution boundary |
|---|---|---|---|
| Public concrete nonempty theorems | Frozen 1,008-module source archive and standard Lean distribution | No | Kernel replay of closed, state-specific theorems |
| Public September 14 checker source | Its 56 source files and fixed Lean | No | Kernel source; not native data |
| Current algorithm-model closure | 84 current source files, fixed Lean and audited declarations | No | General model theorems with their explicit premises |
| Current retained-evidence identity check | All 5,329 acceptance-listed local files, approximately 3.14 GB total | No | Hash/receipt consistency only |
| Local rule, SAFE, canonical inventory, directory, helper and successor finite checks | Their native Lean workers, exact local binaries, manifests, exporters and controller dependencies | No | Kernel soundness theorems plus compiled finite instances; compiler/runtime/I/O remain trusted |
| Current synthetic production tests | Frozen C++ sources, test harness, generated synthetic input directories and resource controller | No | Bounded tests of production routines; no historical P/N coverage |
| Repeat completed layers 34/33 | Exact source layer bits, directories, verified local summaries and terminal/near-terminal workers | Only the required layer payloads, not necessarily all 97.32 GB | Compiled checks of the stated complete layers |
| Bounded general-layer row equations | Exact source buckets and all referenced higher-layer payloads plus verified index/local inputs | The needed subset; not necessarily all 97.32 GB | Original-game soundness additionally requires higher-layer correctness |
| Full historical P/N reverse replay, whole-table hashing or a new full compiled-Lean campaign | Every required historical bucket and full coverage/aggregation records | Yes, for complete historical coverage | Existing C++ replay is computational; full new Lean campaign remains paused/unclosed |

The full retained table has **97,316,623,312 bytes**. The public source distribution excludes it. Its public reconstruction tools require a 64-bit C++17 environment and substantial resources; the frozen guide recommends at least 110 GB free output storage. Whole-table hash verification is a 97.32 GB I/O task even when no search runs. No such command was executed in this audit.

The new source-model proofs and the native finite-input checks are separate obligations. The current model/finite-evidence route gives general enumeration, transition and retrograde results under explicit contracts. It does not instantiate every required premise as a single kernel certificate for the historical output. A fresh source PASS cannot discharge `historical_output_formally_bound: false`, `universal_whole_cpp_refinement: NOT_VERIFIED`, `fully_instantiated_whole_solver_kernel_certificate: NOT_CONSTRUCTED` or `empty_game_Lean: NOT_VERIFIED`.

The exact existing current local read-only command is:

```powershell
python -B build/lean_table_checker/accept_optimized_retro.py --check-only
```

It returned `PASS_READ_ONLY_FINITE_RETROGRADE_AUDIT` in 6.777 s during this audit. The `-B` flag prevents Python bytecode-cache writes in the research script directories. The command checks all acceptance-listed file hashes; it does not build or run the solver. Omitting `--check-only` invokes a materially different acceptance-assembly path that can build and write historical research outputs, so it should not be substituted in a reproduction paragraph about read-only checks.

The original native controllers fix paths such as `build/lean_table_checker`, the Windows Lean distribution, input subdirectories and retained run names; many use Windows Job, `msvcrt` locking and path-specific receipt equality. Several also provide resumable scheduling or creation of retained output. Their existence does not make the native campaign portable. A recipient needs exact inputs or reproducible exporters, parameterised output paths, rebuilt workers, hash/version contracts, retained partial outcomes, and a clean native replay on the target platform. The current public snapshot intentionally does not distribute all that material.

Evidence: [current review](evidence-catalogue.md#source-014), [status](../../research/2026-09-15/evidence/STATUS.json), [read-only implementation](evidence-catalogue.md#source-018), lines 20–25; [native synthetic runner](evidence-catalogue.md#source-019); [near-terminal controller](evidence-catalogue.md#source-020); [directory-slice runner](evidence-catalogue.md#source-021); [finite index probes](evidence-catalogue.md#source-022).

## 6. Release verification is separate from proof replay

No `tools/verify_release.py` exists in the verified v0.3.0 checkout. The actual frozen release instructions are in [SNAPSHOT.json](https://github.com/feierbuqiu/mahjong-achievement-game/releases/download/v0.3.0/SNAPSHOT.json). For downloaded release files in a new directory, the published procedures include:

```bash
gh release download v0.3.0 --repo feierbuqiu/mahjong-achievement-game
sha256sum --check SHA256SUMS
gh release verify v0.3.0 --repo feierbuqiu/mahjong-achievement-game
gh release verify-asset v0.3.0 mahjong-achievement-game-v0.3.0-source.zip --repo feierbuqiu/mahjong-achievement-game
git clone --branch main mahjong-achievement-game-v0.3.0.git.bundle mahjong-achievement-game-v0.3.0
cd mahjong-achievement-game-v0.3.0
sha256sum --check ../SOURCE_FILES.sha256
python3 tools/verify_repository.py
python3 research/2026-09-14/verify.py
```

Signature verification additionally requires an independently authenticated allowed-signers file; the frozen snapshot specifies `git verify-tag` and `ssh-keygen -Y verify` commands. An unauthenticated signer file fetched alongside the archive would not by itself establish identity. Release and asset attestations, signatures, checksums and source provenance authenticate bytes and origins; they do not prove the mathematical statements.

Live API metadata in this audit confirmed the immutable v0.3.0 release, target commit and six assets. It reported source ZIP SHA-256 `0fedb8a4d3905d0516c82cc5824e9c8d7ff1608e7eca8ab6e50b314a7056cd0b` and bundle SHA-256 `dc8af6a6a371e409d6606e571979a72ce9df4c81762d14981c0ce2ae9fa268ed`. This audit did not redownload those assets or repeat signature verification. The API observation and current local file/inventory checks are recorded separately from the earlier published download-verification receipt.

## 7. Preservation and remaining gaps

The original explicit-certificate STOP file remained present; its recorded hash is `a64764701465d7dcb476e41ed2b9ca8088ca89ffeff23b4861cb188d918d7a64`. The current status still marks the original certificate run and two-hour automation as PAUSED, and the full P/N replay remains paused. No cloud work, scheduler mutation, daemon start, historical table scan or native worker run occurred. All audit-created files are under `runs/lean_supplement_20260915/`.

For the paper, the principal delivery limitation is that the current 84-module model proof is locally replayable and has now been freshly replayed, but the verified public immutable snapshot remains older. The uncommitted September 15 package must be described as a draft until a specific public commit is independently observed. The complete later 24,655-state explicit-certificate registry, native input/runtime collection and historical table are also outside the published proof-source package. There is no reason to delay reporting the locally checked model theorem, but public reproducibility must be stated at the level actually available.

The source-only replay result, the native finite-instance receipts, the synthetic C++ tests and the historical full C++ reverse replay are four different forms of evidence. Keeping those distinctions is the essential reproducibility claim of the supplement.
