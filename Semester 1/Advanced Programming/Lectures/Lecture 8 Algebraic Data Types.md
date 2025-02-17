# 8. Algebraic Data Types

**ADVANCED PROGRAMMING LANGUAGES**  
Fall 2024, CM 0632. MSc in Computer Science and Information Technology, Ca’ Foscari University of Venice

## Algebraic Data Types

With the development of the last few lectures, we have most of our language fundamentals in place: functions, primitive types, their reduction rules, and a sound type system. Now it’s time to look at **compound types** to account for richer representations of data structures, such as those available in practical programming languages.

We start with **tuples**, **records**, and **variants**, conventionally referred to as **algebraic data types (ADTs)**.

The two fundamental mechanisms that support data types are:

- **Constructors**: Create values of the datatype by assembling multiple components.
- **Selectors**: Extract the components assembled in the datatype.

As we will discuss shortly, algebraic refers to the **constructors** employed to assemble their components, reminiscent of the product and sum operators found in algebra.

---

## Datatype Constructors

Constructors are the fundamental mechanism to build datatypes: they are best understood as **functions** that inject values from one or more domains (types) into the domain of the datatype being defined.

Tuples, records, and variants are all created by corresponding constructors. We look at each of them below.

---

### Tuples

Tuples are familiar structures seen in mathematics. Formally, tuples are structural types built by an **n-ary constructor** that collects multiple components of respective types and injects them into a new compound value structured as an **n-tuple**.

#### Syntax and Typing

For each `n ∈ {0, 1, 2, ...}`, a tuple constructor creates an n-tuple:

```text
(T-Tuple)
Γ ⊢ (M₁, ..., Mₙ) : (T₁, ..., Tₙ)
Γ ⊢ M₁ : T₁  ...  Γ ⊢ Mₙ : Tₙ
```

#### Examples

```text
(true, false) : (Bool, Bool)
("aaa", true) : (String, Bool)
(1, 5, 2, 10) : (Int, Int, Int, Int)
(3, true, 2.3, "aaa") : (Int, Bool, Double, String)
```

#### Nested Tuples

Tuples can be nested, leading to different structures. For example:

```text
(T₁, T₂, T₃)
((T₁, T₂), T₃)
(T₁, (T₂, T₃))
```

While they may look similar, the above types are **distinct** due to their structural differences.

---

### Records

Records generalize tuples by associating each component (field) with a **label**. Formally, given a set of distinct labels `{ℓ₁, ..., ℓₙ}` and respective types `{T₁, ..., Tₙ}`, a record constructor collects the components and associates them with the corresponding labels.

#### Syntax and Typing

```text
(T-Rec)
Γ ⊢ {ℓ₁ = M₁, ..., ℓₙ = Mₙ} : {ℓ₁ : T₁, ..., ℓₙ : Tₙ}
Γ ⊢ M₁ : T₁  ...  Γ ⊢ Mₙ : Tₙ
```

#### Examples

```text
{fst = 5, snd = "hello"} : {fst : Int, snd : String}
{city = "Venice", zip = 30123} : {city : String, zip : Int}
```

**Key Property**: Since components are identified by their **labels**, their order is irrelevant. For example:

```text
{fst = 5, snd = "hello"} ≡ {snd = "hello", fst = 5}
```

---

### Variants

Variants define compound structures that may have **different, alternative shapes**. For example:

- A binary tree node can be either a **leaf** or an **interior node**.
- A list cell can be either **nil** or a **cons cell**.

#### Syntax

A variant type expresses a **disjoint union** of subdomains built using **constructors**. For example:

```text
Shape = ⟨ Circ(Double) ∣ Rect(Double, Double) ⟩
```

Here, `Shape` is a variant type composed of two subdomains:

- `Circ(Double)` represents a circle with a radius.
- `Rect(Double, Double)` represents a rectangle with width and height.

#### Typing Rule

Each variant value carries a **type tag** to identify its constructor:

```text
(T-Variant)
Γ ⊢ Cⱼ(M) @ ⟨C₁(T₁) ∣ ... ∣ Cₙ(Tₙ)⟩ : ⟨C₁(T₁) ∣ ... ∣ Cₙ(Tₙ)⟩
Γ ⊢ M : Tⱼ  (j ∈ {1..n})
```

#### Examples

```text
Circ(3.0) : ⟨Circ(Double) ∣ Rect(Double, Double)⟩
Rect(4.0, 5.0) : ⟨Circ(Double) ∣ Rect(Double, Double)⟩
```

---

## Pattern Matching: A Uniform Selection Mechanism

**Pattern matching** is a general mechanism for extracting datatype components by:

1. Determining **which constructor** built a value.
2. Extracting the components the constructor was applied to.

### Syntax

Matching expressions have the form:

```text
M match { case P₁ ⇒ N₁  ∣ ... ∣ case Pₙ ⇒ Nₙ }
```

Where:

- `M` is the term being matched.
- `P₁, ..., Pₙ` are patterns.
- `N₁, ..., Nₙ` are corresponding terms.

### Semantics

1. The term `M` is matched against each pattern `P₁, ..., Pₙ` sequentially.
2. If a match succeeds, the corresponding term `Nᵢ` is evaluated.
3. If no pattern matches, the expression becomes **stuck**.

#### Example in Scala

```scala
def area(s: Shape): Double = s match {
  case Circ(r) => Math.PI * r * r
  case Rect(b, h) => b * h
}
```

Here, the function `area` computes the area of a shape by matching the value `s` against the constructors `Circ` and `Rect`.

---

## Exercises

### Exercise 1: Reduction and Typing for Selectors

Assume we extend our presentation with specific operators for selecting components of tuples and records. Define:

1. Reduction rules for `fst` and `snd` selectors on pairs.
2. Typing rules for these selectors.

### Exercise 2: Option Types

Define an optional value type in Scala:

```text
OptionNat = ⟨ NaN ∣ Some(Nat) ⟩
```

1. Implement the type `OptionNat` in Scala.
2. Define a function `succ` that conservatively extends the successor function to `OptionNat`.

### Exercise 3: Finite Maps

Define a type `FiniteMap` representing finite mappings from natural numbers to optional values:

```text
FiniteMap = Nat → OptionNat
```

Implement the following:

1. `emptyMap`: Represents a map with an empty domain.
2. `extendMap`: Extends a finite map with a new mapping `n → v`.

---

**CREDITS**: The discussion on algebraic data types is adapted from Chapter 11 and Chapter 19.3 of Prof. Benjamin Pierce’s _Types and Programming Languages_, MIT Press, 2001.  
[Read the full book here](https://www.cis.upenn.edu/~bcpierce/tapl/).