# Repository guidance

Read README.md, RESEARCH_STATUS.json, docs/RULES.md, docs/EVIDENCE.md, and
docs/REPRODUCIBILITY.md before changing research claims or algorithms.

- The published computational opening result is P (second-player win), with
  complete reverse replay. As of September 15, 2026, the maintainer will not
  undertake further end-to-end/full-scale Lean closure verification; the
  opening theorem is NOT_VERIFIED. v1.0.0 closes the maintainer's active phase
  and freezes the current public delivery. Further updates are expected only
  for substantive new results or necessary corrections. Read docs/PROJECT_STATUS.md
  and both English reports listed in papers/README.md; keep their evidence scopes separate.
  Read research/2026-09-15/README.md for current evidence and boundaries, and
  research/2026-09-14/README.md for hardware and full-scan benchmarks.
  Do not restart research jobs or provision compute without a new request.
  Bounded checks and replay of existing proofs remain appropriate for changes.
  Do not confuse historical UNKNOWN with current computational results.
- Keep the shared-pool rules, seven distinct pairs, all physical numeric
  additions, and the stated symmetry group unchanged unless explicitly asked.
- UNKNOWN/timeouts are never P. N does not mean SG=1. Static winning profiles
  alone do not establish future game equivalence.
- Preserve provenance and imported bytes. Explain transformations and update
  the publication manifests when an artifact legitimately changes.
- Put generated binaries, tables, logs, and checkpoints in build/ or runs/.
  Concurrent computations need separate output directories.
- Use English. Preserve original proper names and bibliographic titles in
  citations. Do not upload the Chinese manuscript. Never publish private keys,
  tokens, or personal workstation paths.
- Sign every commit. Use a topic branch and pull request after bootstrap;
  do not bypass signature or CI rules or force-push main.
- Do not spawn sub-agents unless the user explicitly authorizes delegation.
- Run the bounded checks relevant to a change. A green CI run is not a full
  table replay, an independent rules proof, or a Lean theorem.
