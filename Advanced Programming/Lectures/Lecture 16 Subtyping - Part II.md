# 16. Subtyping - Part II

**ADVANCED PROGRAMMING LANGUAGES**  
Fall 2024, CM 0632. MSc in Computer Science and Information Technology, Ca’ Foscari University of Venice

## Subtyping – Part II

---

## Algorithmic Typing and Subtyping

A significant novelty introduced by subtyping is that the system of axioms and inference rules for typing and subtyping is no longer **syntax-directed**. Specifically:

1. **Subsumption Rule** (`T-Sub`) applies to any term, offering an alternative to other typing rules.
2. **Transitivity Rule** (`S-Trans`) applies to any type, making it viable for any subtype derivation.

### Resolving Syntax-Directedness

The issue can be resolved as follows:

1. **Transitivity** (`S-Trans`) can be eliminated. Any derivation using `S-Trans` can be rewritten to avoid it.
2. **Subsumption** (`T-Sub`) can be combined with the typing rules for application.

By systematically rewriting derivations, we regain a syntax-directed system while maintaining soundness.

### New Typing Rule

We coalesce `T-Sub` and `T-App` into a single rule:

```text
(T-App-Alg)
Γ ⊢ M : U → T   Γ ⊢ N : S   S <: U
---------------------------------
Γ ⊢ M N : T
```

This rule subsumes `T-Sub` in the typing derivation of applications.

### Rearranging Subsumption

If `T-Sub` appears in a derivation above `T-Abs` or other rules, it can be moved **down the tree** to appear closer to the root:

```text
(T-Sub moved)
Γ, x : S ⊢ M : T   S <: U
--------------------------
Γ ⊢ λx.M : S → T
```

This approach eliminates redundant subsumption and simplifies the system.

---

## Soundness and Completeness of the Algorithmic System

With the new syntax-directed system:

- **Soundness**: If the algorithmic system derives `Γ ⊢ M : T`, then the original system also derives `Γ ⊢ M : T`.
- **Completeness**: If the original system derives `Γ ⊢ M : T`, then the algorithmic system derives `Γ ⊢ M : S` for some `S <: T`.

---

## Subtyping for Mutable Datatypes

### The Problem of Covariant Subtyping

For immutable datatypes, subtyping is covariant:

```text
(S-Arrow)
S₁ <: T₁    T₂ <: S₂
--------------------
T₁ → T₂ <: S₁ → S₂
```

However, for **mutable datatypes**, covariant subtyping can lead to **unsoundness**.

#### Example: Java Arrays

In Java, arrays have covariant subtyping:

```java
Point[] pts = new ColorPoint[10];
pts[0] = new Point(1, 2);  // Runtime error!
```

- `ColorPoint[] <: Point[]` allows passing a `ColorPoint[]` where a `Point[]` is expected.
- Assigning a `Point` to an array position breaks type safety.

### Safe Subtyping for Mutable References

To address this, mutable datatypes must be **invariant** in their component types:

```text
(Safe-Ref)
Ref(T) <: Ref(T)
```

Arrays behave like references, where variance rules combine contravariance and covariance:

- Reading: `Ref(T)` acts covariantly.
- Writing: `Ref(T)` acts contravariantly. This combined behavior forces invariance.

---

## Structural vs Nominal Subtyping

Subtyping systems can be classified into:

1. **Structural Typing**: Subtyping depends on the structure of types.
2. **Nominal Typing**: Subtyping is explicitly declared by the programmer.

### Structural Typing

In structural typing systems:

- Types are equivalent if they have the **same structure**.
- Subtypes are derived automatically based on structural rules.

**Example:**

```scala
class Triangle(base: Double, height: Double)
class Rectangle(base: Double, height: Double)
```

Here, `Triangle` and `Rectangle` are structurally equivalent because they have the same fields.

### Nominal Typing

In nominal typing systems:

- Types are equal **only** if they have the same name.
- Subtypes must be explicitly declared (e.g., `extends` or `implements`).

**Example:**

```scala
trait Shape {
  def area: Double
}

class Triangle extends Shape {
  def area: Double = (base * height) / 2
}

class Rectangle extends Shape {
  def area: Double = base * height
}
```

Here, `Triangle` and `Rectangle` are subtypes of `Shape` because it is explicitly declared.

### Tradeoffs

- **Nominal Typing**:
    - Advantages: Easier to reason about, supports runtime type checks, and recursive types.
    - Disadvantages: Requires explicit declarations.
- **Structural Typing**:
    - Advantages: More flexible, allows implicit subtyping.
    - Disadvantages: Harder to optimize and reason about.

---

## Exercises

### Exercise 1: Function Subtyping

Let `A`, `B`, `C`, and `B'` be types such that `B <: B'`. Determine the subtype relationships (if any) between the following pairs:

1. `A → (B → C)` and `A → (B' → C)`
2. `(A → B) → C` and `(A → B') → C`

### Exercise 2: Subsumption Rule

Show that the subsumption rule `T-Sub` permutes down with each of the following rules:

1. **Application** (`T-App`)
2. **Record Selection**

### Exercise 3: Mutable References

Explain why `Ref(T)` is invariant. Illustrate with an example involving a mutable reference type.

---

**CREDITS**: This lecture extensively draws on Chapter 15 of B.C. Pierce’s _Types and Programming Languages_.  
[Further Reading](https://www.dais.unive.it/~michele/APL/Function%20Subtyping%20no%20animation.pdf).