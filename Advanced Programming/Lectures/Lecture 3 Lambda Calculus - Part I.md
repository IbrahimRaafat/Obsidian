# 3. Lambda Calculus - Part I

**ADVANCED PROGRAMMING LANGUAGES**  
Fall 2024, CM 0632. MSc in Computer Science and Information Technology, Ca’ Foscari University of Venice

## The λ Calculus

The development of functional languages has been influenced by many sources, but none as fundamental as the work of **Alonzo Church** on the **λ calculus**.

The λ calculus is regarded as the first functional language. Though not originally conceived as a programming language, modern functional languages are nontrivial extensions of the λ calculus. Church's work aimed to define a syntax and rewrite rules for **transforming terms** to capture the computational behavior of functions.

### The Pure Untyped λ Calculus

#### Syntax

The pure untyped λ calculus uses **λ expressions** (or terms):

- **Variables**: `x`, `y`, `z`
- **Abstraction**: Anonymous functions written as `λx.M`
- **Application**: Applying one function to another, written as `M N`

An abstraction `λx.M` binds the variable `x`, so all occurrences of `x` in `M` are **bound** unless captured by another abstraction. Variables not bound are **free**.

#### Free Variables

The free variables of a term `M` are defined inductively:

- `fv(x) = {x}`
- `fv(M N) = fv(M) ∪ fv(N)`
- `fv(λx.M) = fv(M) - {x}`

### Function Application and Currying

Functions are **first-class values** in λ calculus, which allows:

- Using functions as arguments to other functions (**higher-order functions**).
- Functions to take one argument only. Multi-argument functions are represented using **currying**:

```scala
def add(a:Int, b:Int) = a + b          // (Int, Int) => Int
def addCurry(a:Int) = (b:Int) => a + b // Int => (Int => Int)

val x = add(3, 4)                      // x: Int
val f = addCurry(3)                    // f: Int => Int
val r = addCurry(3)(4)                 // r: Int
```

Function application in λ calculus is **left-associative**:

- `M N P` is interpreted as `((M N) P)`.
- Use parentheses explicitly to override: `M (N P)`.

### Substitution

Substitution replaces all **free occurrences** of a variable `x` in an expression `N` with another expression `M`, written as `[M/x]N`.

#### Rules for Substitution

- **Variable**: `[M/x]y = M` if `x = y`; otherwise `y`.
- **Application**: `[M/x](N P) = ([M/x]N)([M/x]P)`
- **Abstraction**:
    - If `x` is not free in `λx.N`: `[M/x](λx.N) = λx.N`
    - If `x` is free but no conflict: `[M/x](λy.N) = λy.[M/x]N`
    - If a conflict exists: rename bound variables to avoid clashes.

**Example**:

- `[M/x](λx.x) = λx.M`
- `[y/x](λz.x z) = λz.y z`

### α-Conversion, β-Reduction, and η-Conversion

The λ calculus defines three key equality laws:

1. **α-conversion (renaming)**: `λx.M = λy.[y/x]M`  
    The name of the parameter is irrelevant to the function's behavior.
2. **β-reduction (application)**: `(λx.M) N → [N/x]M`  
    Function application substitutes the argument into the function body.
3. **η-conversion**: `λx.(M x) = M` if `x ∉ fv(M)`  
    Functional behavior is unchanged if applying a function `M` directly.

Together, these laws form a theory of equality for the λ calculus, ensuring consistency.

### Reduction and Normal Form

- **Reduction**: Rewriting expressions based on **β-reduction** and **η-reduction**.
- **Redex**: A reducible expression, such as `(λx.M) N`.
- **Normal Form**: An expression with no redexes.

**Church-Rosser Theorem**: If `M` and `N` are reducible to the same term, they can both be reduced to a common normal form, ensuring uniqueness.

#### Evaluation Order

1. **Normal-Order Reduction**: Leftmost, outermost redex reduced first.
2. **Applicative-Order Reduction**: Leftmost, innermost redex reduced first.

**Example**:

```text
Normal-Order Reduction:
(\x.y)((\x.xx)(\x.xx)) -> y

Applicative-Order Reduction:
(\x.y)((\x.xx)(\x.xx)) -> (infinite loop)
```

Normal-order reduction always finds the normal form if it exists, while applicative-order reduction may fail for non-terminating expressions.

## Recursion in the λ Calculus

Self-application enables recursion in the λ calculus. For example:

- **Ω (Omega)**: `(\x.(x x))(\x.(x x))` generates infinite computation.

### The Y Combinator

The **Y combinator** enables recursion:

```text
Y ≡ λf.(λx.f(x x))(λx.f(x x))
```

For a recursive function `f`, define:

```text
fact = Y (λf. λn. if n = 0 then 1 else n * f(n - 1))
```

The Y combinator demonstrates that recursion can be achieved without explicitly defining recursive functions.

## The Church-Turing Thesis

The λ calculus, Turing machines, and general recursive functions were shown to define the **same class of computable functions**. This equivalence led to the **Church-Turing Thesis**:

> The concept of computability is accurately characterized by these models.

## Exercises

### Exercise 1: Variable Bindings

Fully parenthesize the following expressions, identify variable bindings, usage, and free variables:

1. `λa. z λz. a y`
2. `(\z.z) λb. b λa. a a`
3. `λa. λb.(λa.a) λb.a`
4. `x λx. λx. x (\x.x)`

### Exercise 2: Alpha Equivalence

Determine which of the following are α-equivalent:

1. `λx. y`, `λa. a x`
2. `λx. z`, `λb. b x`
3. `λa. y`, `λb. b a`

### Exercise 3: Reduction

Put the following expressions into normal form:

1. `((\z.z) (\q.q q)) (\s.s a)`
2. `(\z.z) (\z.z z) (\z.z q)`
3. `(\s.\q.s q q) (\a.a) b`
4. `(\s.\q.s q q) (\q.q) q`
5. `((\s.s s) (\q.q)) (\q.q)`

### Exercise 4: Recursion

Let **Y** be the recursion operator. Evaluate `(Y F)` using:

1. **Applicative order**.
2. **Normal order**.

---

**Credits**: Most of the material is sourced from Prof. Paul Hudak's paper. [Read the full paper here](https://dl.acm.org/doi/pdf/10.1145/72551.72554).