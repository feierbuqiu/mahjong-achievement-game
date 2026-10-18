module
public import Lean
public section

open Lean Elab Term

namespace Mahjong.CartesianNatLoaderV19

/-! An untrusted, bounded expression builder. It emits Nat data expressions,
not proofs. Any later equality is checked by the ordinary Lean kernel. -/

private meta def inputPrefix : String :=
  "build/lean_table_checker/acceleration_v19/cartesian_kernel_v19/inputs/"

private meta def frozenInput : String :=
  "runs/lean_table_checker/acceleration_20261018_v19/lane_dag_v19/lanedag_cover_8088ef796f744de1ba88d180942651ad/OPERATORS.json"

private meta def fileCap : Nat := 16777216
private meta def constantCap : Nat := 2097152
private meta def nodeCap : Nat := 5000
private meta def valueBitsCap : Nat := 16777216

private meta def fromExcept {α : Type} (result : Except String α) : TermElabM α :=
  match result with
  | .ok value => pure value
  | .error message => throwError "nat_dag input: {message}"

private meta def field (value : Json) (key : String) : TermElabM Json :=
  fromExcept (value.getObjVal? key)

private meta def natField (value : Json) (key : String) : TermElabM Nat := do
  fromExcept ((← field value key).getNat?)

private meta def stringField (value : Json) (key : String) : TermElabM String := do
  fromExcept ((← field value key).getStr?)

private meta def digit (c : UInt8) : Nat :=
  if c.toNat ≤ 57 then c.toNat - 48 else c.toNat - 87

/-- Balanced decoding is an implementation convenience, not a trusted theorem. -/
private meta def decodeHex (bytes : ByteArray) : Nat → Nat → Nat → Nat
  | 0, _, _ => 0
  | _ + 1, _, 0 => 0
  | _ + 1, first, 1 => digit bytes[first]!
  | fuel + 1, first, width + 2 =>
    let highWidth := (width + 2) / 2
    let lowWidth := width + 2 - highWidth
    (decodeHex bytes fuel first highWidth <<< (4 * lowWidth)) |||
      decodeHex bytes fuel (first + highWidth) lowWidth

private inductive Node where
  | literal (constant : Nat)
  | binary (operation : Name) (left right : Nat)
  | shift (operation : Name) (input bits : Nat)

private meta def Node.parents : Node → Array Nat
  | .literal _ => #[]
  | .binary _ left right => #[left,right]
  | .shift _ input _ => #[input]

private structure Dag where
  constants : Array Nat
  nodes : Array Node

private structure CachedDag where
  file : String
  bytes : UInt64
  modified : IO.FS.SystemTime
  dag : Dag

/-- A single bounded proposal cache, never a proof or checked result cache.
The external controller holds continuous read locks for the whole compile. -/
private meta initialize dagCache : IO.Ref (Option CachedDag) ← IO.mkRef none

private meta def allowedFilename (file : String) : Bool := Id.run do
  if file.contains '\\' || file.contains ':' ||
      (file.splitOn "/").any (fun s => s == "" || s == "." || s == "..") then
    return false
  if file == frozenInput then return false
  let basename := (file.splitOn "/").getLast!
  return file == inputPrefix ++ basename && basename.endsWith ".json" &&
    basename.toList.all (fun c => c.isAlphanum || c == '_' || c == '-' || c == '.')

private meta def load (file : String) : TermElabM Dag := do
  unless allowedFilename file do throwError "nat_dag rejected non-isolated workspace filename"
  let root ← IO.FS.realPath "."
  let actual ← IO.FS.realPath file
  let rootPrefix := root.toString.replace "\\" "/" ++ "/"
  unless (actual.toString.replace "\\" "/").startsWith rootPrefix do
    throwError "nat_dag real path escaped the workspace"
  let metadata ← actual.metadata
  unless metadata.type == .file do throwError "nat_dag requires an ordinary file"
  if metadata.byteSize.toNat > fileCap then throwError "nat_dag file exceeds 16MiB"
  if let some cached ← dagCache.get then
    if cached.file == actual.toString && cached.bytes == metadata.byteSize &&
        cached.modified == metadata.modified then
      return cached.dag
  let raw ← IO.FS.readBinFile actual
  if raw.size > fileCap || raw.size != metadata.byteSize.toNat then
    throwError "nat_dag actual file extent is invalid or changed"
  let some text := String.fromUTF8? raw | throwError "nat_dag JSON is not UTF8"
  let parsed ← fromExcept (Json.parse text)
  unless (← stringField parsed "schema") == "FLAT_NAT_MEMBER_NETWORK_OPERATOR_DAG_V19" do
    throwError "nat_dag schema mismatch"
  let constantJson ← fromExcept ((← field parsed "constants").getArr?)
  let nodeJson ← fromExcept ((← field parsed "nodes").getArr?)
  if nodeJson.isEmpty || nodeJson.size > nodeCap || constantJson.size > nodeCap then
    throwError "nat_dag node or constant count exceeds 5000"
  let mut constants : Array Nat := #[]
  let mut constantBytes := 0
  let mut bitLengths : Array Nat := #[]
  for i in [:constantJson.size] do
    let value := constantJson[i]!
    unless (← natField value "index") == i do throwError "nat_dag constant index is not canonical"
    let hex ← stringField value "nat_hex_be"
    let bytes := hex.toUTF8
    if bytes.isEmpty || (bytes.size > 1 && bytes[0]! == 48) then
      throwError "nat_dag constant hex is empty or noncanonical"
    for c in bytes do
      unless (48 ≤ c.toNat && c.toNat ≤ 57) || (97 ≤ c.toNat && c.toNat ≤ 102) do
        throwError "nat_dag constant must use lowercase hexadecimal digits"
    constantBytes := constantBytes + (bytes.size + 1) / 2
    if constantBytes > constantCap then throwError "nat_dag constant byte total exceeds 2MiB"
    let high := digit bytes[0]!
    let topBits := if high == 0 then 0 else if high < 2 then 1 else if high < 4 then 2 else if high < 8 then 3 else 4
    let bitLength := 4 * (bytes.size - 1) + topBits
    unless (← natField value "bit_length") == bitLength do
      throwError "nat_dag constant bit_length differs from its hex literal"
    constants := constants.push (decodeHex bytes 64 0 bytes.size)
    bitLengths := bitLengths.push bitLength
  let mut nodes : Array Node := #[]
  let mut widths : Array Nat := #[]
  for i in [:nodeJson.size] do
    let value := nodeJson[i]!
    let op ← stringField value "op"
    if op == "const" then
      let c ← natField value "constant"
      if c ≥ constants.size then throwError "nat_dag constant reference is outside its array"
      nodes := nodes.push (.literal c)
      widths := widths.push bitLengths[c]!
    else if op == "shr" || op == "shl" then
      let parent ← natField value "input"
      let bits ← natField value "bits"
      if parent ≥ i then throwError "nat_dag forward or self node reference"
      if bits > valueBitsCap then throwError "nat_dag shift exceeds the value extent guard"
      let width := if op == "shl" then widths[parent]! + bits else widths[parent]! - bits
      if width > valueBitsCap then throwError "nat_dag conservative intermediate extent exceeds 2MiB"
      nodes := nodes.push (.shift (if op == "shl" then ``Nat.shiftLeft else ``Nat.shiftRight) parent bits)
      widths := widths.push width
    else if op == "and" || op == "xor" || op == "or" then
      let left ← natField value "left"
      let right ← natField value "right"
      if left ≥ i || right ≥ i then throwError "nat_dag forward or self node reference"
      let width := if op == "and" then min widths[left]! widths[right]! else max widths[left]! widths[right]!
      nodes := nodes.push (.binary (if op == "and" then ``Nat.land else if op == "xor" then ``Nat.xor else ``Nat.lor) left right)
      widths := widths.push width
    else
      throwError "nat_dag unsupported operation: {op}"
  let dag := { constants, nodes : Dag }
  dagCache.set (some ⟨actual.toString, metadata.byteSize, metadata.modified, dag⟩)
  return dag

private meta def constantExpr (dag : Dag) (index : Nat) : Expr :=
  Lean.mkNatLit dag.constants[index]!

/-- Topologically ordered Nat lets. References are relative to the exact
preceding retained binding count, not to the original (possibly sparse) IDs. -/
private meta def build (dag : Dag) (output : Nat) : TermElabM Expr := do
  if output ≥ dag.nodes.size then throwError "nat_dag output index is outside its nodes"
  let mut needed := Array.replicate dag.nodes.size false
  needed := needed.set! output true
  for i in (List.range (output + 1)).reverse do
    if needed[i]! then
      for parent in (dag.nodes[i]?.getD (.literal 0)).parents do needed := needed.set! parent true
  let mut order : Array Nat := #[]
  let mut position := Array.replicate dag.nodes.size 0
  for i in [:output+1] do
    if needed[i]! then
      position := position.set! i order.size
      order := order.push i
  let mut values : Array Expr := #[]
  for current in [:order.size] do
    let node := (dag.nodes[order[current]!]?).getD (.literal 0)
    let reference := fun parent => Lean.mkBVar (current - 1 - position[parent]!)
    let value := match node with
      | .literal c => constantExpr dag c
      | .binary operation left right => Lean.mkApp2 (Lean.mkConst operation) (reference left) (reference right)
      | .shift operation input bits => Lean.mkApp2 (Lean.mkConst operation) (reference input) (Lean.mkNatLit bits)
    values := values.push value
  let mut expression := Lean.mkBVar (order.size - 1 - position[output]!)
  for current in (List.range order.size).reverse do
    expression := .letE (Name.mkSimple s!"dag{order[current]!}") (Lean.mkConst ``Nat) values[current]! expression true
  let type ← Lean.Meta.inferType expression
  unless type == Lean.mkConst ``Nat do throwError "nat_dag constructed a non-Nat expression"
  return expression

elab "cartesian_dag%" file:str output:num : term => do
  build (← load file.getString) output.getNat

/-- Independent literal access is useful for checking emitted DAG values; it
does not produce an equality proof or bypass ordinary kernel reduction. -/
elab "cartesian_nat%" file:str constant:num : term => do
  let dag ← load file.getString
  if constant.getNat ≥ dag.constants.size then throwError "nat_dag literal index is outside its constants"
  return constantExpr dag constant.getNat

theorem loader_has_no_semantic_premise : (0 : Nat) = 0 := rfl

end Mahjong.CartesianNatLoaderV19
#print axioms Mahjong.CartesianNatLoaderV19.loader_has_no_semantic_premise
