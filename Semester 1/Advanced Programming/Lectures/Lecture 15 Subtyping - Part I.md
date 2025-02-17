# 15. Subtyping - Part I

**ADVANCED PROGRAMMING LANGUAGES**  
Fall 2024, CM 0632. MSc in Computer Science and Information Technology, Ca’ Foscari University of Venice

## Subtyping – Part I

After introducing typed systems, we have spent several past lectures studying various computational aspects distinctive of functional programming. Now we turn back to typing and address a further concept: **subtyping**, sometimes called subtype polymorphism.

Subtyping is a cross-cutting concept that relates to many language features in non-trivial ways. It is characteristically found in **object-oriented languages** and is often considered an essential feature of the object-oriented style. Though we will explore this connection in detail, subtyping is just as relevant to **functional languages** and to the **lambda calculus** in particular.

---

## Subsumption and the Substitution Principle

Without subtyping, the rules of the **simply typed lambda-calculus** can be annoyingly rigid. The type system’s insistence that the argument types exactly match the function domain type leads the type-checker to reject many programs that, to the programmer, seem obviously well-behaved.

### Example

Consider the typing rule for function application:

```text
(T-App)
Γ ⊢ M : S → T   Γ ⊢ N : S
-------------------------
Γ ⊢ M N : T
```

According to this rule, the well-behaved term:

```text
(λr : {x : Int}. r.x) {x = 0, y = 1}
```

is not typable because the argument type `{x : Int, y : Int}` does not **exactly match** the function’s domain `{x : Int}`.

However, the function only requires that its argument be a **record** with a field `x` and does not care about other fields.

### Refining with Subtyping

Subtyping refines the typing rules to accept terms like the above. We formalize this using the **safe substitution principle**:

> If `S` is a subtype of `T` (denoted `S <: T`), then any term of type `S` can safely be **substituted** in a context expecting a term of type `T`.

This principle introduces a new rule to connect typing and subtyping, commonly referred to as the **rule of subsumption**:

```text
(T-Sub)
Γ ⊢ M : S    S <: T
------------------
Γ ⊢ M : T
```

### Example with Subtyping

To type-check the earlier term:

1. If we define `{x : Int, y : Int} <: {x : Int}`, then the rule `(T-Sub)` allows:

```text
Γ ⊢ {x = 0, y = 1} : {x : Int}
```

2. The function application becomes valid:

```text
Γ ⊢ (λr : {x : Int}. r.x) {x = 0, y = 1} : Int
```

---

## The Subtype Relation

To preserve the **soundness** of the type system, the subtype relation `S <: T` must ensure the absence of runtime type errors. The relation is formalized using **inductive rules** of the form:

```text
S <: T
```

These rules satisfy two general principles:

1. **Reflexivity**:

```text
(S-Refl)
S <: S
```

2. **Transitivity**:

```text
(S-Trans)
S <: T    T <: U
----------------
S <: U
```

---

## Record Subtyping

### Width Subtyping

We consider `{x : Int, y : Int}` to be a subtype of `{x : Int}` if the former has **more fields** than the latter. The rule is formalized as:

```text
(S-Rec-W)
{ℓ₁ : T₁, ..., ℓₘ₊ₖ : Tₘ₊ₖ} <: {ℓ₁ : T₁, ..., ℓₘ : Tₘ}
```

- This rule states that a **longer record** can be safely used where a **shorter record** is expected.

### Intuition

A record type `{x : Int}` describes all records that contain at least the field `x` with type `Int`.

Examples:

```text
{x = 3} <: {x : Int}
{x = 3, y = 100} <: {x : Int}
{x = 3, y = 100, z = true} <: {x : Int, y : Int}
```

### Depth Subtyping

If fields of a record type are **immutable**, it is safe to allow their types to vary covariantly:

```text
(S-Rec)
{ℓ₁ : S₁, ..., ℓₘ : Sₘ} <: {ℓ₁ : T₁, ..., ℓₘ : Tₘ}  if  Sᵢ <: Tᵢ  (for i = 1, ..., m)
```

---

## Subtyping for Variant Types

The subtyping rules for **variant types** are the dual of record subtyping. While record supertypes have **fewer fields**, variant supertypes allow **more variants**:

### Rule for Variants

```text
(S-Variant)
⟨C₁(S₁), ..., Cₙ(Sₙ)⟩ <: ⟨C₁(T₁), ..., Cₙ₊ₖ(Tₙ₊ₖ)⟩   if   Sᵢ <: Tᵢ  (for i = 1, ..., n)
```

### Intuition

If a variant type `T` lists possible variants `{A, B, C}`, then adding more variants `{D, E}` produces a subtype.

---

## Function Subtyping

Functions play two roles:

1. **Producers**: A function produces a result.
2. **Consumers**: A function consumes input values.

### Covariance and Contravariance

- **Return Types**: Covariant (results can be more specific):

```text
S₂ <: T₂  ⟹  S₁ → S₂ <: S₁ → T₂
```

- **Argument Types**: Contravariant (inputs can be less specific):

```text
T₁ <: S₁  ⟹  S₁ → S₂ <: T₁ → S₂
```

### Combined Rule

```text
(S-Arrow)
S₁ <: T₁    T₂ <: S₂
--------------------
T₁ → T₂ <: S₁ → S₂
```

---

## Type Safety

Extending the typing rules with the subtype relation preserves **type safety**. The proof relies on:

1. **Progress**: A well-typed term is either a value or can be reduced.
2. **Preservation**: If a well-typed term reduces, the resulting term is also well-typed.

### Key Lemmas

1. **Inversion of Subtyping**: For each type constructor, the subtype relation has predictable forms.
2. **Canonical Forms**: Ensures that well-typed terms have the correct structure.
3. **Substitution**: Typing is preserved under substitution.

---

## Exercises

### Exercise 1: Subtype Derivation

Is there a type `T` such that the judgment:

```text
{x : Int, y : Int} <: T
```

is derivable? If so, is there more than one such `T`?

### Exercise 2: Function Subtyping

For which types does the following judgment hold?

```text
(S → T) <: (U → V)
```

### Exercise 3: Record Depth Subtyping

Determine whether the following holds:

```text
{x : S, y : T} <: {x : U, y : V}
```

---

**CREDITS**: This lecture draws almost verbatim from Chapter 15 of B.C. Pierce’s _Types and Programming Languages_.  
[Read more here](https://www.dais.unive.it/~michele/APL/Function%20Subtyping%20no%20animation.pdf).