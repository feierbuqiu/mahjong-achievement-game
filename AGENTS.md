# Repository guidance

Read README.md, RESEARCH_STATUS.json, docs/RULES.md, docs/EVIDENCE.md, and
docs/REPRODUCIBILITY.md before changing research claims or algorithms.

- The published computational opening result is P (second-player win), with
  complete reverse replay. End-to-end Lean verification is still in progress
  for this snapshot. Do not confuse historical UNKNOWN with current results.
- Keep the shared-pool rules, seven distinct pairs, all physical numeric
  additions, and the stated symmetry group unchanged unless explicitly asked.
- UNKNOWN/timeouts are never P. N does not mean SG=1. Static winning profiles
  alone do not establish future game equivalence.
- Preserve provenance and imported bytes. Explain transformations and update
  the publication manifests when an artifact legitimately changes.
- Put generated binaries, tables, logs, and checkpoints in build/ or runs/.
  Concurrent computations need separate output directories.
- Use English. Never publish private keys, tokens, or personal workstation paths.
- Sign every commit. Use a topic branch and pull request after bootstrap;
  do not bypass signature or CI rules or force-push main.
- Do not spawn sub-agents unless the user explicitly authorizes delegation.
- Run the bounded checks relevant to a change. A green CI run is not a full
  table replay, an independent rules proof, or a Lean theorem.
