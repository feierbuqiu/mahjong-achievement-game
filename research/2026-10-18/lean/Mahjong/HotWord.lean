import Mahjong.BlockPlanCheck

set_option autoImplicit false

namespace Mahjong.HotWord
open PackedRules

/-- Cold specialization of the four already-proved word rank formulas. -/
structure Word where
  firstA : Nat
  firstB : Nat
  firstC : Nat
  sizeA : UInt64
  sizeB : UInt64
  stride : UInt64
  offset : UInt64
  mode : UInt8

def ofView (v : BlockWordAddress.View) : Word :=
  ⟨v.firstA,v.firstB,v.firstC,v.sizeA,v.sizeB,IndexWordArithmetic.wordC2 v.sizeA,v.offset,
    if v.a = v.c then 0 else if v.a = v.b then 1 else if v.b = v.c then 2 else 3⟩

@[inline] def addressABC (w : @& Word) (a b c : Nat) : UInt64 :=
  let x := UInt64.ofNat (a-w.firstA)
  let y := UInt64.ofNat (b-w.firstB)
  let z := UInt64.ofNat (c-w.firstC)
  w.offset + if w.mode = 0 then x+IndexWordArithmetic.wordC2 y+IndexWordArithmetic.wordC3 z
    else if w.mode = 1 then x+IndexWordArithmetic.wordC2 y+w.stride*z
    else if w.mode = 2 then x+w.sizeA*(y+IndexWordArithmetic.wordC2 z)
    else x+w.sizeA*(y+w.sizeB*z)

theorem address_ofView (v : BlockWordAddress.View) (a b c : Nat) :
    addressABC (ofView v) a b c = BlockWordAddress.address v (a,b,c) := by
  by_cases ac : v.a = v.c <;> by_cases ab : v.a = v.b <;> by_cases bc : v.b = v.c <;>
    simp_all [addressABC,ofView,BlockWordAddress.address,WordRank.within]

@[inline] def finish (w : @& Word) (a b c : Nat) : UInt64 :=
  if a > b then addressABC w b a c else addressABC w a b c

@[inline] def middle (w : @& Word) (a b c : Nat) : UInt64 :=
  if b > c then finish w a c b else finish w a b c

/-- Three comparisons, scalar continuation; no Packed or pair is constructed. -/
@[inline] def sortAddress (w : @& Word) (a b c : Nat) : UInt64 :=
  if a > b then middle w b a c else middle w a b c

theorem sortAddress_eq (w : Word) (p : Packed) :
    sortAddress w p.a p.b p.c =
      let q := SuitSorting.sort id p
      addressABC w q.a q.b q.c := by
  simp only [sortAddress,middle,finish,SuitSorting.sort,SuitSorting.compare01,
    SuitSorting.compare12,id_eq]
  split <;> simp_all
  all_goals split <;> simp_all
  all_goals split <;> simp_all
  all_goals omega

@[inline] def childAddress (w : @& Word) (a b c sourceBlock j : Nat) : UInt64 :=
  if sourceBlock = 0 then sortAddress w j b c
  else if sourceBlock = 1 then sortAddress w a j c
  else if sourceBlock = 2 then sortAddress w a b j
  else sortAddress w a b c

theorem childAddress_eq (v : BlockWordAddress.View) (p : Packed) (b j : Nat) :
    childAddress (ofView v) p.a p.b p.c b j =
      BlockWordAddress.address v (BlockPlanCheck.childNumeric p b j) := by
  have sort (q : Packed) : sortAddress (ofView v) q.a q.b q.c =
      BlockWordAddress.address v
        ((SuitSorting.sort id q).a,(SuitSorting.sort id q).b,(SuitSorting.sort id q).c) := by
    rw [sortAddress_eq]
    exact address_ofView v _ _ _
  by_cases h0 : b = 0
  · subst b
    simpa [childAddress,BlockPlanCheck.childNumeric,Packed.set] using sort ⟨j,p.b,p.c,p.h⟩
  · by_cases h1 : b = 1
    · subst b
      simpa [childAddress,BlockPlanCheck.childNumeric,Packed.set] using sort ⟨p.a,j,p.c,p.h⟩
    · by_cases h2 : b = 2
      · subst b
        simpa [childAddress,BlockPlanCheck.childNumeric,Packed.set] using sort ⟨p.a,p.b,j,p.h⟩
      · have big : ¬ b < 3 := by omega
        simpa [childAddress,BlockPlanCheck.childNumeric,h0,h1,h2,big] using sort p

end Mahjong.HotWord

#print axioms Mahjong.HotWord.address_ofView
#print axioms Mahjong.HotWord.sortAddress_eq
#print axioms Mahjong.HotWord.childAddress_eq
