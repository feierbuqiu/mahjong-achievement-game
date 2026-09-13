# Changelog

## Unreleased - 2026-09-13

- Publish closed original-game Lean proofs for three concrete nonempty positions
  with 20, 32, and 34 tiles. The empty-position theorem remains `NOT_VERIFIED`.
- Freeze 686 distinct Lean source modules, source provenance, and selected
  records of two successful kernel replays. Pin Lean 4.33.1 and add a portable
  clean replay command plus CI for the published nonempty proofs.
- Record the partial opening candidate graph and the work still needed to
  close its certificate. The signed v0.1.0 computational snapshot is unchanged.

## 0.1.0 - 2026-09-13

Initial English computational research publication.

- Empty-state P result and six N first-move orbits, with full forward
  computation and reverse replay covering 778,532,864,302 SAFE state orbits.
- Frozen core source, portable build helper, bounded smoke reproduction,
  historical fixtures, per-bucket hashes, and explicit evidence provenance.
- MIT License, citation metadata, contribution and research-integrity policies,
  signed publication, and automated repository/build checks.
- End-to-end Lean verification remains in progress. The full 97.32 GB table
  is retained outside Git and is reproducible from the supplied source.
