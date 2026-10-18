import Mahjong.WeightedBlocks

set_option autoImplicit false

namespace Mahjong.CursorLayouts
open Ranking EnumerationBlocks GroupCandidates

theorem c2_zero : c2 0 = 0 := rfl

def allThree (x y z : Nat) : Triple :=
  if x+1 ≤ y then (x+1,y,z) else if y+1 ≤ z then (0,y+1,z) else (0,0,z+1)

theorem allThree_step (x y z : Nat) (xy : x ≤ y) (yz : y ≤ z) :
    let q := allThree x y z
    q.1 ≤ q.2.1 ∧ q.2.1 ≤ q.2.2 ∧ rank3 q.1 q.2.1 q.2.2 = rank3 x y z+1 := by
  simp only [allThree]
  split <;> try dsimp only
  · exact ⟨by omega,yz,by unfold rank3; omega⟩
  · rename_i nox
    have same : x = y := by omega
    subst x
    split <;> try dsimp only
    · have step := c2_succ y
      exact ⟨by omega,by omega,by simp only [rank3,Nat.zero_add]; omega⟩
    · rename_i noy
      have same : y = z := by omega
      subst y
      have step := c3_succ z
      have pair := c2_succ z
      exact ⟨by omega,by omega,by simp only [rank3,c2_zero,Nat.zero_add]; omega⟩

def firstTwo (a x y z : Nat) : Triple :=
  if x+1 ≤ y then (x+1,y,z) else if y+1 < a then (0,y+1,z) else (0,0,z+1)

theorem firstTwo_step (a x y z : Nat) (xy : x ≤ y) (ya : y < a) :
    let q := firstTwo a x y z
    q.1 ≤ q.2.1 ∧ q.2.1 < a ∧
      radix (c2 a) (rank2 q.1 q.2.1) q.2.2 = radix (c2 a) (rank2 x y) z+1 := by
  simp only [firstTwo]
  split <;> try dsimp only
  · exact ⟨by omega,ya,by simp only [radix,rank2]; omega⟩
  · rename_i nox
    have same : x = y := by omega
    subst x
    split <;> try dsimp only
    · have step := c2_succ y
      exact ⟨by omega,by omega,by simp only [radix,rank2,Nat.zero_add]; omega⟩
    · rename_i noy
      have endPoint : a = y+1 := by omega
      have step : c2 a = c2 y+(y+1) := by rw [endPoint,c2_succ]
      exact ⟨by omega,by omega,by simp only [radix,rank2,c2_zero,Nat.zero_add,Nat.mul_add,Nat.mul_one]; omega⟩

def lastTwo (a x y z : Nat) : Triple :=
  if x+1 < a then (x+1,y,z) else if y+1 ≤ z then (0,y+1,z) else (0,0,z+1)

theorem lastTwo_step (a x y z : Nat) (xa : x < a) (yz : y ≤ z) :
    let q := lastTwo a x y z
    q.1 < a ∧ q.2.1 ≤ q.2.2 ∧ radix a q.1 (rank2 q.2.1 q.2.2) = radix a x (rank2 y z)+1 := by
  simp only [lastTwo]
  split <;> try dsimp only
  · exact ⟨by omega,yz,by simp only [radix,rank2]; omega⟩
  · rename_i nox
    have carry : x+1 = a := by omega
    split <;> try dsimp only
    · exact ⟨by omega,by omega,by simp only [radix,rank2,Nat.zero_add,Nat.mul_add,Nat.mul_one]; omega⟩
    · rename_i noy
      have same : y = z := by omega
      subst y
      have step := c2_succ z
      simp only [radix,rank2,Nat.zero_add]
      rw [step]
      simp only [Nat.mul_add,Nat.mul_one]
      exact ⟨by omega,by omega,by omega⟩

def distinct (a b x y z : Nat) : Triple :=
  if x+1 < a then (x+1,y,z) else if y+1 < b then (0,y+1,z) else (0,0,z+1)

theorem distinct_step (a b x y z : Nat) (xa : x < a) (yb : y < b) :
    let q := distinct a b x y z
    q.1 < a ∧ q.2.1 < b ∧ radix a q.1 (radix b q.2.1 q.2.2) = radix a x (radix b y z)+1 := by
  simp only [distinct]
  split <;> try dsimp only
  · exact ⟨by omega,yb,by simp only [radix]; omega⟩
  · rename_i nox
    have carry : x+1 = a := by omega
    split <;> try dsimp only
    · exact ⟨by omega,by omega,by simp only [radix,Nat.zero_add,Nat.mul_add,Nat.mul_one]; omega⟩
    · rename_i noy
      have endPoint : y+1 = b := by omega
      have carried := congrArg (fun t => a*t) endPoint
      simp only [Nat.mul_add,Nat.mul_one] at carried
      exact ⟨by omega,by omega,by simp only [radix,Nat.zero_add,Nat.mul_add,Nat.mul_one]; omega⟩

theorem radix_second_lt (a b x y : Nat) (_pa : 0 < a) (bound : radix a x y < a*b) : y < b := by
  by_cases inside : y < b
  · exact inside
  · have mul := Nat.mul_le_mul_left a (show b ≤ y by omega)
    unfold radix at bound
    omega

theorem rank2_second_lt (x y n : Nat) (bound : rank2 x y < c2 n) : y < n := by
  by_cases inside : y < n
  · exact inside
  · have mono := c2_mono (a:=n) (b:=y) (by omega)
    unfold rank2 at bound
    omega

theorem rank3_third_lt (x y z n : Nat) (bound : rank3 x y z < c3 n) : z < n := by
  by_cases inside : z < n
  · exact inside
  · have mono := c3_mono (a:=n) (b:=z) (by omega)
    unfold rank3 at bound
    omega

def step (d : GroupInventory.Data) (a b c : Nat) (q : Triple) : Triple :=
  if a = c then allThree q.1 q.2.1 q.2.2
  else if a = b then firstTwo (d.size a) q.1 q.2.1 q.2.2
  else if b = c then lastTwo (d.size a) q.1 q.2.1 q.2.2
  else distinct (d.size a) (d.size b) q.1 q.2.1 q.2.2

theorem step_correct (d : GroupInventory.Data) (a b c x y z : Nat)
    (ab : a ≤ b) (bc : b ≤ c) (coords : Coordinates d a b c x y z)
    (interior : WeightedBlocks.rank d a b c x y z+1 < WeightedBlocks.size d a b c) :
    let q := step d a b c (x,y,z)
    Coordinates d a b c q.1 q.2.1 q.2.2 ∧
      WeightedBlocks.rank d a b c q.1 q.2.1 q.2.2 = WeightedBlocks.rank d a b c x y z+1 := by
  by_cases ac : a = c
  · have ba : b = a := by omega
    subst b; subst c
    have f := allThree_step x y z (coords.2.2.2.1 rfl) (coords.2.2.2.2 rfl)
    simp only [WeightedBlocks.rank,WeightedBlocks.size,↓reduceIte] at interior
    have hz := rank3_third_lt _ _ _ (d.size a) (by rw [f.2.2]; exact interior)
    simp only [step,WeightedBlocks.rank,↓reduceIte,Coordinates]
    exact ⟨⟨by omega,by omega,hz,fun _ => f.1,fun _ => f.2.1⟩,f.2.2⟩
  · by_cases same : a = b
    · subst b
      have f := firstTwo_step (d.size a) x y z (coords.2.2.2.1 rfl) coords.2.1
      simp only [WeightedBlocks.rank,WeightedBlocks.size,ac,↓reduceIte] at interior
      have pp := WeightedBlocks.c2_positive (d.size a) (by have h := coords.1; omega)
      have hz := radix_second_lt _ (d.size c) _ _ pp (by rw [f.2.2]; exact interior)
      simp only [step,WeightedBlocks.rank,ac,↓reduceIte,Coordinates]
      exact ⟨⟨by omega,f.2.1,hz,fun _ => f.1,fun h => False.elim h⟩,f.2.2⟩
    · by_cases same2 : b = c
      · subst c
        have f := lastTwo_step (d.size a) x y z coords.1 (coords.2.2.2.2 rfl)
        simp only [WeightedBlocks.rank,WeightedBlocks.size,same,↓reduceIte] at interior
        have pairBound := radix_second_lt (d.size a) (c2 (d.size b)) _ _ (by have h := coords.1; omega)
          (by rw [f.2.2]; exact interior)
        have hz := rank2_second_lt _ _ (d.size b) pairBound
        simp only [step,WeightedBlocks.rank,same,↓reduceIte,Coordinates]
        exact ⟨⟨f.1,by omega,hz,fun h => False.elim h,fun _ => f.2.1⟩,f.2.2⟩
      · have f := distinct_step (d.size a) (d.size b) x y z coords.1 coords.2.1
        simp only [WeightedBlocks.rank,WeightedBlocks.size,ac,same,same2,↓reduceIte] at interior
        have tail := radix_second_lt (d.size a) (d.size b*d.size c) _ _ (by have h := coords.1; omega)
          (by rw [f.2.2]; exact interior)
        have hz := radix_second_lt (d.size b) (d.size c) _ _ (by have h := coords.2.1; omega) tail
        simp only [step,WeightedBlocks.rank,ac,same,same2,↓reduceIte,Coordinates]
        exact ⟨⟨f.1,f.2.1,hz,fun h => False.elim h,fun h => False.elim h⟩,f.2.2⟩

def walk (d : GroupInventory.Data) (a b c : Nat) (q : Triple) : Nat → Triple
  | 0 => q
  | k+1 => step d a b c (walk d a b c q k)

theorem walk_correct (d : GroupInventory.Data) (a b c x y z k : Nat)
    (ab : a ≤ b) (bc : b ≤ c) (coords : Coordinates d a b c x y z)
    (inside : WeightedBlocks.rank d a b c x y z+k < WeightedBlocks.size d a b c) :
    let q := walk d a b c (x,y,z) k
    Coordinates d a b c q.1 q.2.1 q.2.2 ∧
      WeightedBlocks.rank d a b c q.1 q.2.1 q.2.2 = WeightedBlocks.rank d a b c x y z+k := by
  induction k with
  | zero => exact ⟨coords,by simp only [walk,Nat.add_zero]⟩
  | succ k ih =>
    have prev := ih (by omega)
    have next := step_correct d a b c _ _ _ ab bc prev.1 (by rw [prev.2]; omega)
    refine ⟨next.1,?_⟩
    have eq := next.2
    rw [prev.2] at eq
    have eta : ((walk d a b c (x,y,z) k).1,(walk d a b c (x,y,z) k).2.1,
        (walk d a b c (x,y,z) k).2.2) = walk d a b c (x,y,z) k := by
      cases walk d a b c (x,y,z) k with
      | mk x yz => cases yz; rfl
    rw [eta] at eq
    simpa only [walk,Nat.add_assoc] using eq

end Mahjong.CursorLayouts

#print axioms Mahjong.CursorLayouts.allThree_step
#print axioms Mahjong.CursorLayouts.firstTwo_step
#print axioms Mahjong.CursorLayouts.lastTwo_step
#print axioms Mahjong.CursorLayouts.distinct_step
#print axioms Mahjong.CursorLayouts.step_correct
#print axioms Mahjong.CursorLayouts.walk_correct
