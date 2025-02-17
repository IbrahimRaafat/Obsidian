# 5-B. Typed Systems

**ADVANCED PROGRAMMING LANGUAGES**  
Fall 2024, CM 0632. MSc in Computer Science and Information Technology, Ca’ Foscari University of Venice

## Introducing Types and Typed Systems

There is no universal agreement on a common definition for the notion of **type**. Instead of asking _What is a type?_, we may ask **why types are needed** in programming languages.

As noted by **Luca Cardelli** and **Peter Wegner** in their famous paper:

> “The road from untyped to typed universes has been followed many times in many different fields, and largely for the same reasons.”

### Untyped Universes

Untyped systems treat all values as belonging to a single class:

1. **Bit strings**: In computer memory, the only value is a memory word (bit string) that represents characters, numbers, pointers, etc.
2. **Lambda-calculus**: Everything is a function from values to values.
3. **Set theory**: Everything is represented as a set, including integers and functions.

For example, integers in set theory are represented as:

```text
0 = ∅
1 = {0}
2 = {0, 1}
3 = {0, 1, 2}
... and so on.
```

### Typed Domains

In practice, untyped domains naturally **decompose** into subsets with uniform behavior, which we call **types**.

Types can be viewed as:

- A **protective covering** that hides a value’s internal representation.
- A **constraint** on how values interact with operators and functions.

For example:

- Integers are atomic values with uniform behavior (e.g., arithmetic operations).
- Functions have internal representations but behave uniformly based on input/output types.

### Purpose of Type Systems

A **type system** imposes constraints to ensure **consistent interactions** between expressions:

1. **Type Binding**: Associates types with program components like constants and identifiers.
2. **Type Checking/Inference**: Ensures operators and functions are applied in a type-consistent way.

---

## Typed Arithmetic Expressions

We illustrate the basic concepts of type systems using a minimal language of **boolean** and **arithmetic expressions**.

### Syntax

The expressions of the language are defined as:

```text
M, N, P ∈ Exp
Const ::= numeric literals (0, 1, 2, ...)
        | boolean literals (true, false)
Exp ::= Const
     | M + N     // Addition
     | M = N     // Equality Test
     | if M then N else P  // Conditional
```

---

## Evaluation

Evaluation reduces expressions using **reduction rules**. Unlike the λ-calculus (which uses β-reduction), we define **δ-rules** for arithmetic and boolean operations.

### Numeric Reductions

1. Add numeric constants:
    
    ```text
    n + m → n + m   // n, m are numeric literals
    ```
    
2. Reduce complex expressions:
    
    ```text
    M + m → M' + m   if M → M'
    m + M → m + M'   if M → M'
    ```
    

### Boolean Reductions

1. Equality test:
    
    ```text
    a = b → false   // a ≠ b
    M = M → true
    ```
    
2. Reduce complex expressions:
    
    ```text
    M = N → M' = N   if M → M'
    N = M → N = M'   if M → M'
    ```
    

### Conditional Reductions

1. Simplify conditional expressions:
    
    ```text
    if true then M else N → M
    if false then M else N → N
    ```
    
2. Reduce guard:
    
    ```text
    if M then N else P → if M' then N else P   if M → M'
    ```
    

---

## Values, Stuck Terms, and Errors

- **Values**: Numeric constants (`0, 1, 2, ...`) and boolean constants (`true, false`).
- **Stuck Terms**: Normal forms that are not values (e.g., `4 + true`).

A stuck term indicates an **error** in computation, caused by applying operators inconsistently.

The **type system** distinguishes between terms that evaluate to numeric values, boolean values, or errors **statically**.

---

## The Typing Relation

The **typing relation** is formalized with judgments of the form `M : T` (read: _term `M` has type `T`_), defined inductively as follows:

### Typing Rules

1. **Axioms**:
    
    ```text
    true : Bool       false : Bool       n : Nat
    ```
    
2. **Addition**:
    
    ```text
    M : Nat   N : Nat
    -----------------
        M + N : Nat
    ```
    
3. **Equality**:
    
    ```text
    M : T   N : T
    -----------------
         M = N : Bool
    ```
    
4. **Conditionals**:
    
    ```text
    M : Bool   N : T   P : T
    ---------------------------
        if M then N else P : T
    ```
    

---

## Type Safety: Well-Typed Terms Don’t Go Wrong

The fundamental property of type systems is **safety** (soundness), summarized as:

> **Well-typed terms do not get stuck.**

### Theorems

1. **Progress**: If `M : T`, then `M` is either a value or can reduce to another term.
    
    ```text
    M : T ➞ M is a value  or  M → M'.
    ```
    
2. **Preservation**: If `M : T` and `M → N`, then `N : T`.
    
    ```text
    M : T  and  M → N ➞ N : T.
    ```
    

Together, **progress** and **preservation** ensure that well-typed terms do not evaluate to stuck terms.

---

## Proofs of Type System Properties

### Inversion Lemma

The **Inversion Lemma** states:

1. If `true : T`, then `T = Bool`.
2. If `M + N : T`, then `T = Nat`, `M : Nat`, and `N : Nat`.
3. If `M = N : T`, then `T = Bool`, `M : S`, and `N : S` for some `S`.
4. If `if M then N else P : T`, then `M : Bool`, `N : T`, and `P : T`.

### Canonical Forms Lemma

1. If `M` is a value and `M : Bool`, then `M` is either `true` or `false`.
2. If `M` is a value and `M : Nat`, then `M` is a numeric literal.

---

## Exercises

### Exercise 1: Subject Expansion

Does the opposite of **preservation** hold? If `M → N` and `N : T`, does `M : T`? If not, provide a counterexample.

### Exercise 2: Typing of Conditionals

Modify the typing rule for conditionals to make `if true then 0 else false` well-typed. Show that this change can allow a well-typed term to get stuck.

### Exercise 3: Typing of Equality

1. Modify the typing rule for equality to allow comparisons between terms of different types.
2. Would the modified system still be sound? Justify your answer or provide a counterexample.

---

**CREDITS**:

- First section adapted from Luca Cardelli and Peter Wegner’s paper _On Understanding Types, Data Abstraction, and Polymorphism_.
- Arithmetic expressions adapted from _Types and Programming Languages_ by Benjamin C. Pierce, MIT Press, 2001.  
    [Read the full resources here](http://lucacardelli.name/papers/onunderstanding.a4.pdf) and [TAPL](https://www.cis.upenn.edu/~bcpierce/tapl/).