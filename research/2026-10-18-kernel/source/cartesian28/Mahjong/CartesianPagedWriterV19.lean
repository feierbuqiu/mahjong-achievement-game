module
public import Lean
public meta import Mahjong.NatDataWriterV19
meta import Mahjong.CartesianNatLoaderV19
public section
open Lean Elab Command

/-- Untrusted bounded input builder. The generic command avoids generating a
large separate elaborator program for every literal in each two-MiB page. -/
elab "write_cartesian_page%" leaf:str output:str file:str count:num : command => do
  let size := count.getNat
  if size == 0 || size > 5000 then throwError "Bounded nonempty Nat page required"
  let expressions ← liftTermElabM do
    let mut result : Array Expr := #[]
    for i in [:size] do
      let index : TSyntax `num := ⟨Syntax.mkNumLit (toString i)⟩
      let expression ← Term.elabTermAndSynthesize (← `(cartesian_nat% $file:str $index:num))
        (some (Lean.mkConst ``Nat))
      result := result.push (← Lean.instantiateMVars expression)
    return result
  let names := (List.range size).toArray.map (fun i => Name.mkSimple s!"v{i}")
  Mahjong.NatDataWriterV19.write (Name.mkStr `Mahjong leaf.getString)
    (System.FilePath.mk output.getString) (names.zip expressions)

theorem Mahjong.CartesianPagedWriterV19.marker : (0 : Nat) = 0 := rfl
#print axioms Mahjong.CartesianPagedWriterV19.marker
