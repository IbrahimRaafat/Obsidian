---
annotation-target: "[[Lecture 3 Algebraic Structures]]"
---
# Algebraic Structures: Partial Orders, Lattices, and Related Concepts

## Introduction

Algebraic structures, such as partial orders and lattices, provide a mathematical foundation for reasoning about program execution, dependency resolution, and other computational properties. This document explains these concepts with examples.

---

## Partial Orders

A **partial order** is a relation RR on a set SS that satisfies the following properties:

- **Reflexive**: (a,a)∈R(a,a) \in R for all a∈Sa \in S
- **Antisymmetric**: If (a,b)∈R(a,b) \in R and (b,a)∈R(b,a) \in R, then a=ba = b
- **Transitive**: If (a,b)∈R(a,b) \in R and (b,c)∈R(b,c) \in R, then (a,c)∈R(a,c) \in R

A set SS with a partial order RR is called a **partially ordered set (poset)**, denoted (S,R)(S, R).

### Example

Let S={1,2,3}S = \{1, 2, 3\} and define the relation RR as "divisibility":

- 1≤21 \leq 2, 1≤31 \leq 3, 2≤32 \leq 3

This forms a **poset** because it satisfies reflexivity, antisymmetry, and transitivity.

---

## Comparability

Two elements a,ba, b in a poset are **comparable** if either a≤ba \leq b or b≤ab \leq a. If neither condition holds, they are **incomparable**.

### Example

Consider the subset {2,3,4}\{2, 3, 4\} with the divisibility relation:

- 2≤42 \leq 4 (since 2 divides 4)
- 33 and 44 are incomparable since neither divides the other.

---

## Total Orders

A poset (S,≤)(S, \leq) is **totally ordered** if every pair of elements is comparable.

### Example

The set of natural numbers N\mathbb{N} with the usual ≤\leq relation is a **total order**.

---

## Hasse Diagrams

A **Hasse Diagram** visually represents a poset:

- Elements are arranged so that if a≤ba \leq b, aa appears below bb.
- Edges indicate direct relations (transitive edges are omitted).

### Example

For S={1,2,3,6}S = \{1,2,3,6\} with divisibility relation:

```
   6
  / \
 2   3
  \ /
   1
```

---

## Extremal Elements

- **Maximal**: An element aa is maximal if there is no bb such that a<ba < b.
- **Minimal**: An element aa is minimal if there is no bb such that b<ab < a.
- **Maximum**: A unique greatest element in the poset.
- **Minimum**: A unique least element in the poset.

### Example

For {1,2,3,6}\{1,2,3,6\} with divisibility:

- Minimal: 11
- Maximal: 66

---

## Lattices

A **lattice** is a poset where every pair of elements has:

- A **least upper bound (lub)** (join)
- A **greatest lower bound (glb)** (meet)

### Example

For S={1,2,3,6}S = \{1,2,3,6\}, the **lub** and **glb** for 22 and 33 are:

- lub(2,3)=6lub(2,3) = 6 (smallest element greater than both)
- glb(2,3)=1glb(2,3) = 1 (largest element smaller than both)

A lattice is **complete** if every subset has a lub and glb.

---

## Functions on Partial Orders

A function f:P→Qf: P \to Q between posets is:

- **Monotone** if x≤y⇒f(x)≤f(y)x \leq y \Rightarrow f(x) \leq f(y)
- **Embedding** if x≤y⇔f(x)≤f(y)x \leq y \Leftrightarrow f(x) \leq f(y)
- **Isomorphism** if it is an embedding and surjective

### Example

Consider P={1,2,3,6}P = \{1,2,3,6\} with divisibility and Q={a,b,c,d}Q = \{a,b,c,d\} with order:

- f(1)=a,f(2)=b,f(3)=c,f(6)=df(1) = a, f(2) = b, f(3) = c, f(6) = d
- If $a≤ba \leq b$ in $QQ$ whenever $1≤21 \leq 2$ in PP, then ff is monotone.

---

## Fixpoints

A **fixpoint** of a function ff is an element xx such that f(x)=xf(x) = x.

### Example

For f(x)=x2f(x) = \frac{x}{2}:

- Fixpoints are x=0x = 0 (since 0/2=00/2 = 0).

By **Tarski’s Theorem**, if ff is monotone on a complete lattice, the least and greatest fixpoints exist.

---

## Conclusion

Partial orders and lattices help structure properties of programs and computations, enabling:

- Reasoning about dependencies
- Static analysis for correctness verification
- Efficient computational approximations

Understanding these concepts is fundamental to mathematical logic, formal verification, and computer science.