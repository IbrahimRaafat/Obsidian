# 4. Pure λ Calculus - Part II

**ADVANCED PROGRAMMING LANGUAGES**  
Fall 2023, CM 0632. MSc in Computer Science and Information Technology, Ca’ Foscari University of Venice

## The Expressive Power of the Lambda Calculus

In the last lecture, we mentioned the **Church-Turing Thesis**, which posits that all models of computation, including the λ calculus, are equivalent in expressive power. Though unproven, the equivalence between λ calculus and other models of computation (e.g., Turing Machines) is widely accepted as a de facto proof.

Instead of focusing on these cross-encodings, we illustrate the expressive power of the λ calculus by encoding simple **data types** (booleans and numerals) and their **operators**.

---

## Church Booleans

We start with **Booleans** and conditional expressions.

### Definitions

- **True**: Returns the first argument.
- **False**: Returns the second argument.
- **Conditional**: Chooses between two expressions based on a condition.

```text
true  ≡ λx.λy.x
false ≡ λx.λy.y
cond  ≡ λx.λy.λz.(x y z)
```

### Logical Operators

Using these definitions, we can represent logical operators:

- **AND**: True only if both arguments are true.
- **OR**: True if at least one argument is true.
- **NOT**: Negates a Boolean value.

```text
and  ≡ λx.λy.(x y false)
or   ≡ λx.λy.(x true y)
not  ≡ λp.(p false true)
```

### Examples

- `and true false` ➞ `false`
- `or true false` ➞ `true`
- `not true` ➞ `false`

---

## Church Numerals

Church numerals encode **integers** in λ calculus. The key intuition is to represent numbers as **functions** applied a corresponding number of times.

### Definitions

Given a function `f` and an argument `x`:

```text
0  f x = x          // Applies f zero times
1  f x = f x        // Applies f once
2  f x = f (f x)    // Applies f twice
3  f x = f (f (f x))
... and so on.
```

Formally:

```text
0 ≡ λf.λx.x
1 ≡ λf.λx.(f x)
2 ≡ λf.λx.f (f x)
3 ≡ λf.λx.f (f (f x))
n ≡ λf.λx.(f x)^n
```

### Arithmetic Operators

#### Successor

The **successor** of a numeral `n` applies `f` one additional time:

```text
succ ≡ λn.λf.λx.f (n f x)
```

#### Addition

The **plus** operator combines two numerals `m` and `n` by applying `f` `m + n` times:

```text
plus ≡ λm.λn.λf.λx.m f (n f x)
```

#### Multiplication

The **mult** operator applies `n` to `f` `m` times:

```text
mult ≡ λm.λn.λf.λx.m (n f) x
```

### Examples

- `plus 3 4` ➞ `7`
- `mult 3 2` ➞ `6`

---

## Exercises

### Exercise 1: Practice with Definitions

Test the Church Boolean and Church numeral definitions. Verify the following:

1. `and (not true) (or false true) = false`
2. `plus 3 4 = 7`
3. `mult 3 2 = 6`

### Exercise 2: XOR Operator

Define the λ-calculus encoding for the **XOR** operator:

- `xor` returns true only when its two arguments have different values.

### Exercise 3: isZero Function

Write a λ-calculus term for `isZero`:

- `isZero n` returns `true` if `n` is `0`, otherwise it returns `false`.

### Exercise 4: Church Pairs

We encode **pairs** using the λ calculus:

#### Definitions

A pair stores two elements `a` and `b`:

```text
pair ≡ λfst.λsnd.λf.(f fst snd)
```

- **Selectors**:

```text
select-first  ≡ λfst.λsnd.fst
select-second ≡ λfst.λsnd.snd
```

- **General Selectors**:

```text
first  ≡ λp.(p select-first)
second ≡ λp.(p select-second)
```

#### Exercises

1. Verify that:
    - `first (pair a b) = a`
    - `second (pair a b) = b`
2. Define a new version `fun-pair` that takes five arguments (`f`, `g`, `x`, `y`) and creates a pair:
    - First element: `f(x)`
    - Second element: `g(y)`

### Exercise 5: More Booleans

1. Derive the **nand** operator (¬(P ∧ Q)) using:
    - Only `not`, `false`, and a conditional `x ? y : z`.
    - Convert your result into a λ-calculus expression.
2. Show that for the Boolean pair `(x, y) = (true, false)`:
    - `(nand x y)` evaluates to the same result as `(or (not x) (not y))`.

---

**CREDITS**: Most of the material is sourced from Prof. Paul Hudak's paper.