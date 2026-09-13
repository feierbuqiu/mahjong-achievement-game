> Archived evidence from the dated local research record. Historical progress and commands describe that record; current supported commands are in the repository reproduction guide. Links to retained attachments lead to their availability entries.

The same actual 24-P response graph and original 20-tile root have now passed a
grouped kernel check. The result is
`Mahjong.ResponseTableGrouped20.original_second_player_wins`, with no theorem
parameters, for physical counts `0110330311010110001010110000000000`.
The canonical row 23 remains `0001101010001101010110330310000000`.
This is a 20-tile result, not the empty-state theorem.

The extension is `build/lean_next/MahjongNext/ResponseGroups.lean`. It imports
the unchanged `MahjongNext.ResponseTable`. Its API is:

```lean
rows : ResponseTable.Tree → List ResponseTable.Row
checkRange (bounds : Nat → State) (tree : ResponseTable.Tree)
  (start count : Nat) : Bool

checkRange_append bounds tree start firstCount secondCount first second
checkDatabase_of_full_range bounds tree count covers checked
```

`rows` lists every actual tree row in order. A group checks a `drop`/`take`
slice of that list, while every `checkRow` still receives the same complete
tree for reference lookup. `checkRange_append` combines adjacent slices.
The final theorem additionally requires the covered prefix to be at least
the full row-list length. Thus a producer cannot skip rows merely by listing
some IDs, and missing or cyclic references retain the old checker's rejection
behavior. No ordering or uniqueness assumption was added.

For this sample the groups are `[0,8)`, `[8,16)`, `[16,24)`. Each separate
module proves its Boolean equality with `by decide +kernel`. The Root module
combines the opaque theorem results and checks complete coverage; it does not
reduce the full row checker again. Its final source, bound, and reference
semantics are those of the existing `checkDatabase_sound` theorem.

`make_grouped20.py` checks the frozen full-sample source SHA and copies only
the definition prefix before its `theorem checked`. The source data and
independently proved original SAFE anchor facts are reused. Neither the old
whole-table `checked` nor its `root_proved` or final strategy theorem is
imported. The old original-state definition and symmetry path are reproduced
and checked afresh. The exact import closure and hashes appear in the result.

The successful record is `grouped20_v3/result.json`:

| New module | Wall seconds | Peak private bytes |
| --- | ---: | ---: |
| ResponseGroups | 1.610 | 882,827,264 |
| Grouped20.Data | 5.344 | 967,983,104 |
| Grouped20.Group0 | 5.453 | 1,513,234,432 |
| Grouped20.Group1 | 5.156 | 1,479,602,176 |
| Grouped20.Group2 | 4.844 | 1,451,220,992 |
| Grouped20.Root | 1.562 | 907,796,480 |

All six processes exited successfully. Each ran Lean 4.33.1 with
`--trust=0 -M2048 -j1`, a 90-second wall limit, a sampled Windows-private limit
of 3,000,000,000 bytes, and no other owned Lean process in parallel. The total
was 23.969 seconds; peak private was 1,513,234,432 bytes. Eleven requested
axiom reports were present, with only `propext`, `Classical.choice`, and
`Quot.sound`. No `sorryAx`, new axiom, or `native_decide` is used in the
successful source chain.

The prior whole-table pass used 15.484 seconds and 2,246,823,936 peak private
bytes. These two observed runs support grouping as a lower-memory fallback;
they do not establish a general speedup. Each group still imports the whole
table, so very large data modules may need a separate representation change.
No whole 610-node proof or old foundation suite was rerun here.

`grouped20_v1` and `grouped20_v2` preserve two initial generic proof elaboration
failures (the Boolean conjunction rewrite API, then its final reflexivity
step). Each stopped before checking actual sample data. The actual 24-P
grouped checks ran once, in v3; all old frozen files remain unchanged.

For a fresh evidence directory, the bounded command from the research root
is:

```powershell
& '<user-home>/.cache/codex-runtimes/codex-primary-runtime/dependencies/python/python.exe' runs/lean_next/theory/groups/run_grouped20_check.py --output grouped20_new --max-seconds 90 --max-private-bytes 3000000000
```

The generator has already run and deliberately refuses to overwrite its
source directory. The runner also requires a new result directory. No further
run is required for this sample.

For an actual 50-row graph with several independently proved SAFE bounds,
the same API can be used unchanged: six groups of eight, then one group of
two; preserve the same `bounds` selector and full balanced tree in every
group. Combine the seven adjacent ranges and prove `rows.length ≤ 50`
before calling `checkDatabase_sound`. That 50-row application has not been
run in this evidence set.

Frozen hashes:

| Artifact | SHA-256 |
| --- | --- |
| ResponseGroups.lean | `709efae6e79fa2ed7d82eb0a272e00ed97e5b9118699e3c0886442b3b2901fe7` |
| ResponseGroups.olean | `8ef7a464c7dddee94321e65883c1ba32f62e51bed493e9a879be21fa8ec7c1ed` |
| Grouped20/Root.lean | `f2667a8b0742bf5469e8ce7f8cf462e9d83c50656e18f48f96ce068d266ef4d4` |
| Grouped20/Root.olean | `d3def7ae7ea89c61019b9e3d28f4baf7be1887a1a7797190ac79a2055cd85ed8` |
| grouped20_v3/result.json | `bc11e6ba876869c8195fc92893f0f39693c9299faeb29cf1005516b367c7d91c` |
