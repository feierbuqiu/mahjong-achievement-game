import Mahjong.BlockPlanCheck
import Mahjong.SourceBlockGuard

set_option autoImplicit false

namespace Mahjong.BlockPlanFastSource
open PackedRules GroupCandidates BlockPlanCheck

def row (bank : Bank) (sourceView : SourceBlockGuard.View) (ctx : Context) (plan : Plan)
    (ids : Triple) (r : Nat) (sourceP : Bool) : Bool :=
  SourceBlockGuard.checkAddress sourceView ids r &&
    let p := packIds ctx ids
    if sourceP then (List.range 4).all (fun b =>
      (plan.rows b (planIndex p b)).all (fun e => !e.safe || !label bank p b e))
    else (List.range 4).any (fun b =>
      (plan.rows b (planIndex p b)).any (fun e => e.safe && label bank p b e))

def single (bank : Bank) (sourceView : SourceBlockGuard.View) (ctx : Context) (plan : Plan)
    (ids : Triple) (r b j : Nat) : Bool :=
  SourceBlockGuard.checkAddress sourceView ids r && decide (b < 4) &&
    let p := packIds ctx ids
    (plan.rows b (planIndex p b)).any (fun e => decide (e.j = j) && e.safe && label bank p b e)

theorem row_refines (bank : Bank) (source : IndexOperations.Data)
    (sourceChecked : IndexOperations.Checked source) (sourceView : SourceBlockGuard.View)
    (ctx : Context) (plan : Plan) (ids : Triple) (r : Nat) (sourceP : Bool)
    (prepared : SourceBlockGuard.check source ctx.sourceBlock sourceView = true)
    (accepted : row bank sourceView ctx plan ids r sourceP = true) :
    BlockPlanCheck.row bank source ctx plan ids r sourceP = true := by
  simp only [row,Bool.and_eq_true] at accepted
  simp only [BlockPlanCheck.row,Bool.and_eq_true]
  exact ⟨SourceBlockGuard.checkAddress_refines source sourceChecked ctx.sourceBlock
    sourceView ids r prepared accepted.1,accepted.2⟩

theorem single_refines (bank : Bank) (source : IndexOperations.Data)
    (sourceChecked : IndexOperations.Checked source) (sourceView : SourceBlockGuard.View)
    (ctx : Context) (plan : Plan) (ids : Triple) (r b j : Nat)
    (prepared : SourceBlockGuard.check source ctx.sourceBlock sourceView = true)
    (accepted : single bank sourceView ctx plan ids r b j = true) :
    BlockPlanCheck.single bank source ctx plan ids r b j = true := by
  simp only [single,Bool.and_eq_true] at accepted
  simp only [BlockPlanCheck.single,Bool.and_eq_true]
  exact ⟨⟨SourceBlockGuard.checkAddress_refines source sourceChecked ctx.sourceBlock
    sourceView ids r prepared accepted.1.1,accepted.1.2⟩,accepted.2⟩

end Mahjong.BlockPlanFastSource

#print axioms Mahjong.BlockPlanFastSource.row_refines
#print axioms Mahjong.BlockPlanFastSource.single_refines
