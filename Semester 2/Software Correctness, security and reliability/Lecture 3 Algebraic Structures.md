---
annotation-target: "[[Lecture 3 Algebraic Structures]]"
---
# Partial Orderings: Definitions

## Explanation

A **partial order** is a relation RR on a set SS that satisfies the following three properties:

1. **Reflexive**
    
    - Every element in SS must be related to itself.
    - Mathematically:  
        ∀a∈S,(a,a)∈R\forall a \in S, (a, a) \in R
2. **Antisymmetric**
    
    - If two elements aa and bb are related in both directions, then they must be equal.
    - Mathematically:  
        ∀a,b∈S,(a,b)∈R and (b,a)∈R⇒a=b\forall a, b \in S, \quad (a, b) \in R \text{ and } (b, a) \in R \Rightarrow a = b
3. **Transitive**
    
    - If aa is related to bb and bb is related to cc, then aa must also be related to cc.
    - Mathematically:  
        ∀a,b,c∈S,(a,b)∈R and (b,c)∈R⇒(a,c)∈R\forall a, b, c \in S, \quad (a, b) \in R \text{ and } (b, c) \in R \Rightarrow (a, c) \in R

## Partially Ordered Set (Poset)

- A set SS with a partial ordering RR is called a **partially ordered set** or **poset**.
- It is denoted as (S,R)(S, R).
- In a **poset**, not all elements need to be comparable.

## Minimal and Maximal Elements

- **Minimal Element**: An element m∈Sm \in S is **minimal** if no element in SS is strictly smaller than mm, i.e., there is no x∈Sx \in S such that (x,m)∈R(x, m) \in R and x≠mx \neq m.
- **Maximal Element**: An element M∈SM \in S is **maximal** if no element in SS is strictly greater than MM, i.e., there is no x∈Sx \in S such that (M,x)∈R(M, x) \in R and x≠Mx \neq M.

### Example:

Consider the set S={1,2,3,4,5,6,12}S = \{1, 2, 3, 4, 5, 6, 12\} with the divisibility relation RR, where a≤ba \leq b if aa divides bb. The Hasse diagram looks like:

```
      12
     /  \
    6    4
   / \  /
  3   2
   \ /
    1
```

- **Minimal element**: 1 (no element divides it except itself).
- **Maximal element**: 12 (no element is divisible by it except itself).

## Minimum and Maximum Elements

- **Minimum Element (Least Element)**: An element m∈Sm \in S is the **minimum** if (m,x)∈R(m, x) \in R for all x∈Sx \in S. There can be at most one minimum element.
- **Maximum Element (Greatest Element)**: An element M∈SM \in S is the **maximum** if (x,M)∈R(x, M) \in R for all x∈Sx \in S. There can be at most one maximum element.

### Example:

Using the same Hasse diagram above:

- **Minimum element**: 1 (it is related to all other elements and sits at the bottom).
- **Maximum element**: 12 (it is at the top and is related to all below it).

## Greatest Lower Bound (GLB) and Least Upper Bound (LUB)

- **Greatest Lower Bound (GLB) or Infimum**: The **greatest lower bound** of a subset T⊆ST \subseteq S is the largest element in SS that is less than or equal to every element of TT. It is denoted as inf⁡(T)\inf(T).
- **Least Upper Bound (LUB) or Supremum**: The **least upper bound** of a subset T⊆ST \subseteq S is the smallest element in SS that is greater than or equal to every element of TT. It is denoted as sup⁡(T)\sup(T).

### Example:

Consider the subset T={2,3,6}T = \{2, 3, 6\} from the same poset:

- **GLB (greatest lower bound)**: 1 (largest element dividing all elements in TT).
- **LUB (least upper bound)**: 6 (smallest element divisible by all elements in TT).

## Lattice

A **lattice** is a poset (S,R)(S, R) where every pair of elements has both a **greatest lower bound (GLB)** and a **least upper bound (LUB)**.

### Example of a Lattice:

Consider the set S={1,2,3,6}S = \{1, 2, 3, 6\} with the divisibility relation. The Hasse diagram is:

```
    6
   / \
  2   3
   \ /
    1
```

- **GLB of (2,3)**: 1
- **LUB of (2,3)**: 6
- Every pair has a GLB and LUB, so this is a lattice.

### Example of a Non-Lattice:

Consider the set S={1,2,3,4,6}S = \{1, 2, 3, 4, 6\} with divisibility relation:

```
      6
     / \
    2   3
   /     \
  1       4
```

- **GLB of (2,3)**: 1
- **LUB of (2,3)**: **does not exist** because neither 4 nor 6 is the smallest upper bound.
- Since not every pair has a LUB, this is **not a lattice**.

## Usage

Partial orderings are useful for structuring elements that do not have a natural total order. Examples include:

- **Hierarchies** (e.g., organization charts, family trees)
- **Dependency relationships** (e.g., scheduling tasks, file system directories)
- **Subset relations** (e.g., the set inclusion relation ⊆\subseteq)