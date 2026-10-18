import Lean
import Lean.Replay

open Lean Elab Command

namespace MetadataEncodedSliceV19

/-- A bounded selector for unchanged original kernel declarations. The
selector is untrusted; the official replay and final cold kernel are decisive. -/
def collect (source base : Environment) (roots : List Name) (fuel : Nat) :
    Except String (Std.HashMap Name ConstantInfo) := Id.run do
  let mut todo := roots
  let mut found : Std.HashMap Name ConstantInfo := {}
  for _ in [:fuel] do
    match todo with
    | [] => return .ok found
    | name :: rest =>
      todo := rest
      if (base.toKernelEnv.find? name).isSome || found.contains name then
        continue
      let some ci := source.toKernelEnv.find? name
        | return .error s!"Original declaration unavailable: {name}"
      if ci.isUnsafe || ci.isPartial then
        return .error s!"Non-safe dependency: {name}"
      if ci.isAxiom && !([`propext, `Classical.choice, `Quot.sound].contains name) then
        return .error s!"Nonstandard dependency: {name}"
      found := found.insert name ci
      for dependency in ci.getUsedConstantsAsSet do
        todo := dependency :: todo
      if let .inductInfo info := ci then
        for sibling in info.all do
          todo := sibling :: todo
  return .error "Dependency-selection fuel exhausted"

def simpleV19Name : Name → Bool
  | .str .anonymous value =>
      value.endsWith "V19" && value.toList.all (fun c => c.isAlphanum || c == '_')
  | _ => false

elab "export_kernel_slice%" "[" roots:ident,* "]" "to" moduleName:ident : command => do
  let name := moduleName.getId
  unless simpleV19Name name do
    throwError "New simple V19 module name required"
  let targets := roots.getElems.toList.map (fun root => root.getId)
  if targets.isEmpty || targets.length > 64 then
    throwError "One to 64 explicit theorem roots required"
  let output : System.FilePath :=
    "build/lean_table_checker/acceleration_v19/metadata_pages_v19/local_encoded_v7/modules/" ++ name.toString ++ ".olean"
  for suffix in ["", ".private", ".server"] do
    if ← (System.FilePath.mk (output.toString ++ suffix)).pathExists then
      throwError "Never overwrite an existing proof slice"
  let source := (← getEnv)
  let imports := #[{ module := `Init.Data.Nat.Bitwise.Basic : Import }]
  let (_, importState) ← (Lean.importModulesCore imports).run
  let base ← Lean.finalizeImport importState imports {} 0 false false
    (level := .private) (isModule := true)
  let declarations ← match collect source base targets 2000000 with
    | .ok declarations => pure declarations
    | .error reason => throwError "Dependency selection: {reason}"
  let result ← Lean.Environment.replay declarations (base.setMainModule name)
  unless result.header.imports == imports do
    throwError "Unexpected output imports"
  for target in targets do
    let some original := source.toKernelEnv.find? target
      | throwError "Missing original root"
    let some checked := result.toKernelEnv.find? target
      | throwError "Root was not replayed"
    let identical := match original, checked with
      | .thmInfo a, .thmInfo b => a.name == b.name && a.type == b.type &&
          a.value == b.value && a.levelParams == b.levelParams && a.all == b.all
      | _, _ => false
    unless identical do
      throwError "Original root declaration changed"
  Lean.writeModule result output (writeIR := false)
  logInfo m!"OFFICIAL_KERNEL_SLICE declarations={declarations.size} roots={targets} original_roots_identical=true"

theorem exporter_is_not_a_proof_premise : (0 : Nat) = 0 := rfl

end MetadataEncodedSliceV19

#print axioms MetadataEncodedSliceV19.exporter_is_not_a_proof_premise
