import Mahjong.HotWord
import Mahjong.FastBitRead
import Mahjong.BlockPlanCertifiedRow

set_option autoImplicit false

namespace Mahjong.HotBlockPlan
open PackedRules GroupCandidates BlockPlanCheck

structure HotEdge where
  j : Nat
  safe : Bool
  bits : ByteArray
  word : HotWord.Word

def ofEdge (bank : Bank) (e : Edge) : HotEdge :=
  ⟨e.j,e.safe,(bank.buckets e.targetHonor).bits,HotWord.ofView e.word⟩

@[inline] def labelABC (e : @& HotEdge) (a b c sourceBlock : Nat) : Bool :=
  FastBitRead.labelP64 e.bits (HotWord.childAddress e.word a b c sourceBlock e.j)

theorem label_ofEdge (bank : Bank) (p : Packed) (b : Nat) (e : Edge) :
    labelABC (ofEdge bank e) p.a p.b p.c b = BlockPlanCheck.label bank p b e := by
  simp only [labelABC,ofEdge,FastBitRead.labelP64_eq,HotWord.childAddress_eq,BlockPlanCheck.label]

/-- Borrow the list and every edge. No shared ownership is changed per edge. -/
def allEdges (es : @& List HotEdge) (a b c sourceBlock : Nat) : Bool :=
  match es with
  | [] => true
  | e::rest => (!e.safe || !labelABC e a b c sourceBlock) && allEdges rest a b c sourceBlock

def anyEdges (es : @& List HotEdge) (a b c sourceBlock : Nat) : Bool :=
  match es with
  | [] => false
  | e::rest => (e.safe && labelABC e a b c sourceBlock) || anyEdges rest a b c sourceBlock

def singleEdges (es : @& List HotEdge) (a b c sourceBlock j : Nat) : Bool :=
  match es with
  | [] => false
  | e::rest => (decide (e.j = j) && e.safe && labelABC e a b c sourceBlock) ||
      singleEdges rest a b c sourceBlock j

theorem allEdges_map (bank : Bank) (es : List Edge) (p : Packed) (b : Nat) :
    allEdges (es.map (ofEdge bank)) p.a p.b p.c b =
      es.all (fun e => !e.safe || !BlockPlanCheck.label bank p b e) := by
  induction es with
  | nil => rfl
  | cons e es ih =>
    simp only [List.map_cons,allEdges,List.all_cons]
    rw [label_ofEdge,ih]
    rfl

theorem anyEdges_map (bank : Bank) (es : List Edge) (p : Packed) (b : Nat) :
    anyEdges (es.map (ofEdge bank)) p.a p.b p.c b =
      es.any (fun e => e.safe && BlockPlanCheck.label bank p b e) := by
  induction es with
  | nil => rfl
  | cons e es ih =>
    simp only [List.map_cons,anyEdges,List.any_cons]
    rw [label_ofEdge,ih]
    rfl

theorem singleEdges_map (bank : Bank) (es : List Edge) (p : Packed) (b j : Nat) :
    singleEdges (es.map (ofEdge bank)) p.a p.b p.c b j =
      es.any (fun e => decide (e.j = j) && e.safe && BlockPlanCheck.label bank p b e) := by
  induction es with
  | nil => rfl
  | cons e es ih =>
    simp only [List.map_cons,singleEdges,List.any_cons]
    rw [label_ofEdge,ih]
    rfl

structure RowCache where
  first : Nat
  values : Array (List HotEdge)
  fallback : Nat → List HotEdge

@[noinline] def buildCache (first count : Nat) (f : Nat → List HotEdge) : RowCache :=
  ⟨first,Array.ofFn (fun i : Fin count => f (first+i.val)),f⟩

@[inline] def getCache (cache : @& RowCache) (i : Nat) : List HotEdge :=
  if h : cache.first ≤ i ∧ i-cache.first < cache.values.size then cache.values[i-cache.first]
  else cache.fallback i

theorem getCache_build (first count : Nat) (f : Nat → List HotEdge) (i : Nat) :
    getCache (buildCache first count f) i = f i := by
  by_cases h : first ≤ i ∧ i-first < count
  · have same : first+(i-first) = i := by omega
    simp [getCache,buildCache,h,same]
  · simp [getCache,buildCache,h]

structure Snapshot where
  numeric : Array RowCache
  honor : List HotEdge
  fallback : Nat → Nat → List HotEdge

@[noinline] def build (bank : Bank) (ctx : Context) (plan : Plan) : Snapshot :=
  let f := fun b i => (plan.rows b i).map (ofEdge bank)
  let g := groupData bank
  ⟨Array.ofFn (fun b : Fin 3 => buildCache (g.first (keyGet ctx.key b.val))
    (g.size (keyGet ctx.key b.val)) (f b.val)),f 3 0,f⟩

@[inline] def rows (snapshot : @& Snapshot) (b i : Nat) : List HotEdge :=
  if h : b < snapshot.numeric.size then getCache snapshot.numeric[b] i
  else if b = 3 ∧ i = 0 then snapshot.honor else snapshot.fallback b i

theorem rows_build (bank : Bank) (ctx : Context) (plan : Plan) (b i : Nat) :
    rows (build bank ctx plan) b i = (plan.rows b i).map (ofEdge bank) := by
  by_cases hb : b < 3
  · simp only [rows,build,Array.size_ofFn,hb,↓reduceDIte,Array.getElem_ofFn,getCache_build]
  · simp only [rows,build,Array.size_ofFn,hb,↓reduceDIte]
    split
    · rename_i h
      rcases h with ⟨rfl,rfl⟩
      rfl
    · rfl

/-- Scalar row loop: no Packed allocation or bank lookup on a child. -/
def row (snapshot : @& Snapshot) (sourceView : @& SourceBlockGuard.View)
    (ctx : @& Context) (ids : @& Triple) (r : Nat) (sourceP : Bool) : Bool :=
  SourceBlockGuard.checkAddress sourceView ids r &&
    if sourceP then
      allEdges (rows snapshot 0 ids.1) ids.1 ids.2.1 ids.2.2 0 &&
      allEdges (rows snapshot 1 ids.2.1) ids.1 ids.2.1 ids.2.2 1 &&
      allEdges (rows snapshot 2 ids.2.2) ids.1 ids.2.1 ids.2.2 2 &&
      allEdges (rows snapshot 3 0) ids.1 ids.2.1 ids.2.2 3
    else
      anyEdges (rows snapshot 0 ids.1) ids.1 ids.2.1 ids.2.2 0 ||
      anyEdges (rows snapshot 1 ids.2.1) ids.1 ids.2.1 ids.2.2 1 ||
      anyEdges (rows snapshot 2 ids.2.2) ids.1 ids.2.1 ids.2.2 2 ||
      anyEdges (rows snapshot 3 0) ids.1 ids.2.1 ids.2.2 3

def single (snapshot : @& Snapshot) (sourceView : @& SourceBlockGuard.View)
    (ctx : @& Context) (ids : @& Triple) (r b j : Nat) : Bool :=
  SourceBlockGuard.checkAddress sourceView ids r && decide (b < 4) &&
    singleEdges (rows snapshot b (if b < 3 then
      if b = 0 then ids.1 else if b = 1 then ids.2.1 else ids.2.2 else 0))
      ids.1 ids.2.1 ids.2.2 b j

theorem row_build (bank : Bank) (sourceView : SourceBlockGuard.View) (ctx : Context)
    (plan : Plan) (ids : Triple) (r : Nat) (sourceP : Bool) :
    row (build bank ctx plan) sourceView ctx ids r sourceP =
      BlockPlanFastSource.row bank sourceView ctx plan ids r sourceP := by
  have ap (b i : Nat) := allEdges_map bank (plan.rows b i) (packIds ctx ids) b
  have an (b i : Nat) := anyEdges_map bank (plan.rows b i) (packIds ctx ids) b
  simp only [packIds] at ap an
  simp only [row,rows_build]
  simp only [ap,an]
  simp [BlockPlanFastSource.row,packIds,planIndex,Packed.get,List.range_succ,Bool.and_assoc,Bool.or_assoc]

theorem single_build (bank : Bank) (sourceView : SourceBlockGuard.View) (ctx : Context)
    (plan : Plan) (ids : Triple) (r b j : Nat) :
    single (build bank ctx plan) sourceView ctx ids r b j =
      BlockPlanFastSource.single bank sourceView ctx plan ids r b j := by
  have eq (i : Nat) := singleEdges_map bank (plan.rows b i) (packIds ctx ids) b j
  simp only [packIds] at eq
  simp only [single,rows_build,eq,BlockPlanFastSource.single]
  by_cases h0 : b = 0
  · subst b
    rfl
  · by_cases h1 : b = 1
    · subst b
      rfl
    · by_cases h2 : b = 2
      · subst b
        rfl
      · have hb : ¬ b < 3 := by omega
        simp [planIndex,hb,packIds]

end Mahjong.HotBlockPlan

#print axioms Mahjong.HotBlockPlan.label_ofEdge
#print axioms Mahjong.HotBlockPlan.allEdges_map
#print axioms Mahjong.HotBlockPlan.anyEdges_map
#print axioms Mahjong.HotBlockPlan.singleEdges_map
#print axioms Mahjong.HotBlockPlan.getCache_build
#print axioms Mahjong.HotBlockPlan.rows_build
#print axioms Mahjong.HotBlockPlan.row_build
#print axioms Mahjong.HotBlockPlan.single_build
