---
annotation-target: "[[Lecture 3 Algebraic Structures]]"
---
# Partial Orderings: Definitions

## Explanation

A **partial order** is a relation \( R \) on a set \( S \) that satisfies the following three properties:

1. **Reflexive**  
   - Every element in \( S \) must be related to itself.  
   - Mathematically:  
     $$ \forall a \in S, (a, a) \in R $$

2. **Antisymmetric**  
   - If two elements \( a \) and \( b \) are related in both directions, then they must be equal.  
   - Mathematically:  
     $$ \forall a, b \in S, \quad (a, b) \in R \text{ and } (b, a) \in R \Rightarrow a = b $$

3. **Transitive**  
   - If \( a \) is related to \( b \) and \( b \) is related to \( c \), then \( a \) must also be related to \( c \).  
   - Mathematically:  
     $$ \forall a, b, c \in S, \quad (a, b) \in R \text{ and } (b, c) \in R \Rightarrow (a, c) \in R $$

## Partially Ordered Set (Poset)
- A set \( S \) with a partial ordering \( R \) is called a **partially ordered set** or **poset**.
- It is denoted as \( (S, R) \).
- In a **poset**, not all elements need to be comparable.

## Usage
- Partial orderings are useful for structuring elements that do not have a natural total order.
- Examples include:
  - **Hierarchies** (e.g., organization charts, family trees)
  - **Dependency relationships** (e.g., scheduling tasks, file system directories)
  - **Subset relations** (e.g., the set inclusion relation \( \subseteq \))
