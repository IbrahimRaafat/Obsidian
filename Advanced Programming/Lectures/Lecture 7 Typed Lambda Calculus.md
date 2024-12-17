# 7. 

**ADVANCED PROGRAMMING LANGUAGES**  
Fall 2024, CM 0632. MSc in Computer Science and Information Technology, Ca’ Foscari University of Venice

## The Simply Typed Lambda Calculus

In our previous lecture, we introduced a simple static type system for arithmetic expressions. Now, we construct a similar type system for the **Lambda Calculus**: in the interest of brevity, we ignore most of the operators on integers and booleans and focus on the operators from the language of expressions.

In addition, we introduce a new primitive operator for recursion:

### Syntax

We start with the following extended syntax, which includes integers and booleans with their operators, conditionals, and a primitive version of the **fixpoint combinator**:

```text
M, N, P ::= x, y, z           // Variables
           λx@T .M         // Abstraction
           M N                // Application
           n, m, k            // Integers
           M + N              // Addition
           true, false        // Booleans
           M = N              // Equality Test
           if M then N else P // Conditional
           fix@T .M           // Recursion
```

### Fixpoint Operator

The evaluation of the `fix` operator provides a direct recursion mechanism:

```text
fix@T .M → M (fix@T .M)
```

### Types

The types of this language are defined as:

```text
S, T ::= Nat         // Natural Numbers
         Bool        // Booleans
         S → T     // Functions
```

---

## Typing Judgments

The **typing judgments**, of the form `Γ ⊳ M : T`, associate the type `T` to the term `M`.

- **Γ** (the typing context): A set of type bindings to qualify the types of the free variables in `M`.
- **Goal**: Assign types to terms in a way that guarantees type safety.

While we generally assign types to **closed expressions**, lambda abstractions require us to work with **type environments** as well.

---

## Typing Rules

We now introduce the typing rules for the simply typed lambda calculus:

### Variables

A variable has whatever type the context assigns to it:

```text
(T-Var)
Γ ⊳ x : T    if x : T ∈ Γ
```

### Abstraction

To assign a type to an abstraction `λx@T .M`, we assume the argument `x` has type `T` and check the body `M` under this assumption:

```text
(T-Abs)
Γ, x : T1 ⊳ M : T2
------------------------
Γ ⊳ λx@T1 .M : T1 → T2
```

### Application

To type an application `M N`, `M` must have a function type, and `N` must match the function's argument type:

```text
(T-App)
Γ ⊳ M : S → T    Γ ⊳ N : S
-----------------------------------
Γ ⊳ M N : T
```

### Recursion (Fixpoint Operator)

The `fix` operator requires a function type where the domain and codomain coincide:

```text
(T-Fix)
Γ ⊳ M : T → T
--------------------
Γ ⊳ fix@T .M : T
```

### Constants and Operators

The rules for constants and operators generalize the corresponding rules for arithmetic and boolean expressions:

1. **Constants**:
    
    ```text
    Γ ⊳ true : Bool    Γ ⊳ false : Bool    Γ ⊳ n : Nat
    ```
    
2. **Addition**:
    
    ```text
    Γ ⊳ M : Nat    Γ ⊳ N : Nat
    -------------------------------
    Γ ⊳ M + N : Nat
    ```
    
3. **Equality**:
    
    ```text
    Γ ⊳ M : T    Γ ⊳ N : T
    -------------------------
    Γ ⊳ M = N : Bool
    ```
    
4. **Conditionals**:
    
    ```text
    Γ ⊳ M : Bool    Γ ⊳ N : T    Γ ⊳ P : T
    ---------------------------------------
    Γ ⊳ if M then N else P : T
    ```
    

---

## Properties of the Typed Lambda Calculus

### Type Safety

The fundamental property of type systems is **type safety**, which ensures:

1. **Progress**: A well-typed term is either a value or can reduce further.
2. **Preservation**: If a well-typed term reduces, the resulting term is also well-typed.

Together, these properties ensure that **well-typed programs do not go wrong**.

### Canonical Forms

The **Canonical Forms Lemma** states:

1. If `v : Bool`, then `v` is either `true` or `false`.
2. If `v : Nat`, then `v` is a numeric constant.
3. If `v : S → T`, then `v` is a lambda abstraction `λx@S .M`.

### Substitution Lemma

If `Γ, x : S ⊳ M : T` and `Γ ⊳ N : S`, then `Γ ⊳ [N/x]M : T`.

### Progress Theorem

If `∅ ⊳ M : T` (M is closed and well-typed), then:

1. `M` is a value, or
2. There exists `M'` such that `M → M'`.

### Preservation Theorem

If `∅ ⊳ M : T` and `M → N`, then `∅ ⊳ N : T`.

---

## Exercises

### Exercise 1: Typing Recursive Functions

Using the `fix` operator, define a well-typed recursive function to compute the factorial of a natural number.

### Exercise 2: Typing Conditional Expressions

Prove that `if true then 0 else false` is not well-typed in the simply typed lambda calculus.

### Exercise 3: Substitution Lemma

Prove the substitution lemma: If `Γ, x : S ⊳ M : T` and `Γ ⊳ N : S`, then `Γ ⊳ [N/x]M : T`.

### Exercise 4: Preservation

Prove the preservation theorem for the simply typed lambda calculus.

---

**CREDITS**: The material is adapted from Chapter 9 of Prof. Benjamin Pierce's _Types and Programming Languages_, MIT Press, 2001.  
[Read the full book here](https://www.cis.upenn.edu/~bcpierce/tapl/).