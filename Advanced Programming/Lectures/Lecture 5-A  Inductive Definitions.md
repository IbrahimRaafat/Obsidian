# 5-A. Inductive Definitions

**ADVANCED PROGRAMMING LANGUAGES**  
Fall 2024, CM 0632. MSc in Computer Science and Information Technology, Ca’ Foscari University of Venice

## Inductive Definitions

An **inductive definition** introduces a set (often a set of tuples forming a relation) constructively. It consists of **rules** to derive **judgments** (assertions or statements) that establish relationships between objects.

Examples include:

- **Equality**: `M = N`
- **Typing**: `M : T` (term `M` has type `T`)
- **Evaluation**: `M → N` (term `M` reduces to `N`)
- **Membership**: `M ∈ S` (term `M` is in the set `S`)

### Structure of Inductive Rules

Inductive rules are written as:

```text
J₁, ..., Jₖ
---------
    J
```

Where:

- **Premises**: Judgments `J₁, ..., Jₖ` above the line.
    
- **Conclusion**: Judgment `J` below the line.
    
- **Axiom**: Rules with no premises (`k = 0`).
    
- **Inference Rule**: Rules with premises.
    

The rules define the **strongest judgment form** closed under the rules, meaning:

1. **Sufficiency**: Judgments can be derived by composing the rules.
2. **Necessity**: Judgments must have been derived by composing the rules.

---

## Derivations

A **derivation** of a judgment is a finite composition of rules starting with **axioms** and ending with the judgment. Derivations are represented as trees (upside-down), where each node corresponds to a rule and its children are derivations of the premises.

To show a judgment `J` holds, it is enough to find a derivation ending with `J`.

---

## Examples of Inductive Definitions

### 1. Inductively Defined Natural Numbers

The set of natural numbers can be inductively defined as follows:

```text
0 ∈ Nat                // Base Case
n ∈ Nat
-------------             // Inductive Step
succ(n) ∈ Nat
```

- `0` is a natural number.
- If `n` is a natural number, then `succ(n)` (successor of `n`) is also a natural number.

#### Example Derivation

The numeral `2` can be derived as follows:

```text
0 ∈ Nat
--------------  (Base)
succ(0) ∈ Nat
----------------------  (Inductive Step)
succ(succ(0)) ∈ Nat
```

### 2. Inductively Defined λ Terms

The syntax of **λ terms** can be defined inductively:

```text
x ∈ Lam                         // Variables
M ∈ Lam   N ∈ Lam
------------------                 // Application
   M N ∈ Lam
M ∈ Lam
------------------                 // Abstraction
λx.M ∈ Lam
```

### 3. Inductively Defined β-Reduction

The notion of **β-reduction** can be defined inductively:

#### Full β Reduction Rules

1. **Core Rule**:
    
    ```text
    (λx.M) N → [N/x]M
    ```
    
2. **Function Position**:
    
    ```text
    M → M'
    ----------------
    M N → M' N
    ```
    
3. **Argument Position**:
    
    ```text
    N → N'
    ----------------
    M N → M N'
    ```
    
4. **Inside Abstraction**:
    
    ```text
    M → M'
    ----------------
    λx.M → λx.M'
    ```
    

---

## The Principle of Rule Induction

**Rule induction** generalizes the familiar induction principle for natural numbers.

### Induction on Natural Numbers

To prove a property `P` holds for all natural numbers:

1. Prove `P(0)` (Base Case).
2. Prove `P(n) ➞ P(succ(n))` (Inductive Step).

### General Rule Induction

To prove a property `P` holds for judgments derived using inductive rules:

1. Show `P` holds for axioms.
2. Show `P` respects each inductive rule.

**Example for Natural Numbers**:

- Show `P(0)` holds.
- Show that if `P(n)` holds, then `P(succ(n))` holds.

**Example for λ Terms**:

- Show `P` holds for variables.
- Show that if `P(M)` holds, then `P(λx.M)` holds.
- Show that if `P(M)` and `P(N)` hold, then `P(M N)` holds.

### Example for β-Reduction

To prove a property `P` for all β-reduction steps:

1. Prove `P` holds for **(λx.M) N → [N/x]M`.
2. Prove that if `P(M → M')`, then `P(M N → M' N)`.
3. Prove that if `P(N → N')`, then `P(M N → M N')`.
4. Prove that if `P(M → M')`, then `P(λx.M → λx.M')`.

---

## Exercises

### Exercise 1: Expressions Defined Inductively

Express the syntax of an expression language with an inductive definition for the judgment `P(a)`.

---

### Exercise 2: Induction and the Induction Principle

The set `Q` of integers is defined inductively as:

```text
RULE1: 8 ∈ Q
RULE2: 5 ∈ Q
RULE3: If a ∈ Q and b ∈ Q, then a + b + 1 ∈ Q.
```

#### Tasks:

1. Identify which rules are axioms and which are inductive.
2. Derive `11 ∈ Q` and `20 ∈ Q`.
3. Write down the induction principle for `Q`.
4. Determine if `2 ∈ Q`. Justify your answer.

---

### Exercise 3: Induction and Reduction in λ-Calculus

#### Part 1: Y Combinator

Evaluate `(Y F)` using:

1. Applicative-order evaluation.
2. Normal-order evaluation.

#### Part 2: Recursive Addition

Using the **Y combinator**, define:

```text
add = λf.λa.λb.(if a = 0 then b else f (a - 1) (b + 1))
```

Show that `(Y add) 2 1 = 3`.

#### Part 3: Higher-Order Function

Given:

```text
H = λf.λn.(if n = 1 then true else if n = 0 then false else not (f (n - 1)))
```

1. Determine what `g`, the fixed point of `H`, computes.
2. Evaluate `(Y H)` using **call-by-name (CBN)** semantics.
3. Evaluate `(Y H) 2` using CBN semantics.

---

**CREDITS**: Material on induction and rule induction is sourced from Robert Harper’s _Practical Foundations of Programming Languages_ (Second Edition), Cambridge University Press, 2016.  
[Read the full book here](http://www.cs.cmu.edu/~rwh/pfpl/abbrev.pdf).