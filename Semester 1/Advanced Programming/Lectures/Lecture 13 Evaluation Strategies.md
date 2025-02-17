# 13. Evaluation Strategies

**ADVANCED PROGRAMMING LANGUAGES**  
Fall 2024, CM 0632. MSc in Computer Science and Information Technology, Ca’ Foscari University of Venice

## Evaluation Strategies

Evaluation strategies formalize the rules for evaluating expressions and specifically for determining when to evaluate the argument(s) of a function call. They are classified into two broad categories: **strict** and **non-strict** strategies.

### Strict Evaluation

Strict evaluation identifies a family of strategies where the arguments of a function are evaluated **before** the function is applied. This makes the function strict, as the result becomes undefined if any argument is undefined.

#### Examples of Strict Evaluation:

- **Call-by-Value**: Arguments are evaluated to a value before the function is applied. (e.g., C, Java, Python, ML, Scala)
- **Call-by-Reference**: Arguments are passed by reference. (e.g., C++)

### Non-Strict Evaluation

Non-strict evaluation refers to cases where functions are applied **without evaluating** the arguments at the call site. Arguments may remain unevaluated entirely or partially, depending on their usage.

#### Examples of Non-Strict Evaluation:

- **Call-by-Name**: Arguments are evaluated only when used within the function body. (e.g., Algol, Scala)
- **Call-by-Need (Lazy Evaluation)**: Arguments are evaluated once, and the result is cached for reuse. (e.g., Haskell)

---

## Evaluation Strategies vs Reduction Order in the Lambda Calculus

Evaluation strategies in programming languages are closely related to **reduction orders** in the lambda calculus.

Two main reduction orders arise:

1. **Applicative-Order**: Reduces the innermost, leftmost redex first.
2. **Normal-Order**: Reduces the outermost, leftmost redex first.

### Key Insight

- In **call-by-value** (applicative), arguments must be fully evaluated before applying the function.
- In **call-by-name** (normal), arguments are substituted directly into the function body, delaying evaluation.

---

## Call-By-Value (Applicative Reduction)

The **call-by-value** reduction relation ensures arguments are evaluated **before** function application:

#### Rules:

```text
(λx.M) v → [v/x]M        // Argument must be a value
M N → M' N    if M → M'
M N → M N'    if N → N'
```

Here:

- `v` is a value (e.g., constants, lambda abstractions).
- Reduction does not occur unless arguments are values.

---

## Call-By-Name (Normal Reduction)

The **call-by-name** relation delays argument evaluation:

#### Rules:

```text
(λx.M) N → [N/x]M        // Argument is substituted as-is
M N → M' N    if M → M'
```

Key difference: Arguments are passed unevaluated and only reduced when needed.

---

## Call-By-Value vs Call-By-Name

### Determinism

Both **call-by-value** and **call-by-name** strategies are deterministic:

- For each term `M`, at most one rule applies to reduce `M`.

### Convergence

Let `⇓CBV` and `⇓CBN` denote call-by-value and call-by-name convergence, respectively. We have:

- **CBN is more defined than CBV**: If `M ⇓CBV v`, then `M ⇓CBN v`.
- The converse does **not** hold, as some terms may converge under normal-order but diverge under applicative-order.

#### Example:

```text
Ω ≡ (λx.(x x))(λx.(x x))   // Diverges under CBV
(λx.λz.z) Ω ⇓CBN λz.z     // Converges under CBN
```

### Efficiency

- **Call-by-Value** evaluates each argument **exactly once**.
- **Call-by-Name** may evaluate the same argument **multiple times** if it occurs in the function body more than once.

#### Example:

```text
M ≡ (λx.x + x)(3 + 4)
```

- **CBV**: Evaluates `3 + 4` once, then applies the function.
- **CBN**: Evaluates `3 + 4` twice due to repeated use.

---

## Call-By-Need (Lazy Evaluation)

Call-by-need refines call-by-name by caching evaluated arguments, avoiding redundant computations.

### Key Property

- Arguments are **evaluated once**, and the result is reused.
- Used in languages like Haskell.

---

## Capturing Call-By-Name with Call-By-Value

Call-by-name semantics can be simulated in a call-by-value framework using **thunks**. A thunk is a delayed computation represented as a function.

### Transformation:

1. Replace an argument `N` with a thunk: `thunk[N] = λ_.N`.
2. Apply the thunk to a dummy argument to force evaluation.

#### Example:

```text
(λx.M) N →CBN [N/x]M
(λx.M) thunk[N] →CBV [thunk[N]/x]M
```

---

## Small-Step vs Big-Step Semantics

### Small-Step Semantics

Describes computation as a **step-by-step reduction**:

```text
M → M' → M'' → ... → v
```

### Big-Step Semantics

Describes the **entire evaluation** to a final value:

```text
M ⇓ v
```

### Agreement Between Small-Step and Big-Step

For a closed term `M`, small-step and big-step semantics agree:

```text
M →* v ⇐⇒ M ⇓ v
```

However, big-step semantics does not describe **nontermination** explicitly.

---

## Exercises

### Exercise 1: Small-Step Reduction

Using the recursion operator:

```text
def Y = λf.(λx. f(x x)) (λx. f(x x))
```

1. Evaluate `(Y F)` using **small-step call-by-value**.
2. Evaluate `(Y F)` using **small-step call-by-name**.

### Exercise 2: Recursive Addition

Given:

```text
def add = λf.λa.λb. if a = 0 then b else f (a-1) (b+1)
```

Evaluate `(Y add) 2 1` step by step.

### Exercise 3: Higher-Order Function

Given:

```text
H = λf.λn. if n = 1 then true else if n = 0 then false else not (f (n - 1))
```

1. Determine what `Y H` computes.
2. Compute `(Y H) 2` using call-by-name semantics.

### Exercise 4: Implement Reductions

Use Scala to define the following:

- `normal_small`: Small-step normal-order reduction.
- `applicative_small`: Small-step applicative-order reduction.
- `normal_big_step`: Big-step normal-order reduction.
- `applicative_big_step`: Big-step applicative-order reduction.

### Exercise 5: CBN to CBV Translation

Implement the call-by-name to call-by-value transformation in Scala or Haskell. Verify its correctness on example lambda terms.

---

**REFERENCES**: This lecture references work on evaluation strategies for the lambda calculus, including the encoding of call-by-name in call-by-value semantics as described by Olivier Danvy and John Hatcliff.  
[Read the full paper](https://www.brics.dk/RS/97/7/BRICS-RS-97-7.pdf).