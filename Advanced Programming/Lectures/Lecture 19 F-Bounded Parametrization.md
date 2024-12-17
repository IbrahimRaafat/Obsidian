# 19. F-Bounded Parametrization

**ADVANCED PROGRAMMING LANGUAGES**  
Fall 2024, CM 0632. MSc in Computer Science and Information Technology, Ca’ Foscari University of Venice

## F-Bounded Polymorphism

Our discussion on **variance annotation** has raised interesting questions about **type parametrization** and the interplay between parametrization and subtyping.

We now explore a powerful technique known as **F-bounded polymorphism**, a refinement of **bounded quantification** that allows type constraints to include references to the type variable itself.

---

## Bounded Quantification

Previously, bounded quantification was introduced to type-check functions that operate uniformly over all subtypes of a given type:

```scala
def scale2x[U <: Shape](s: U): Shape = s.scale(2.0)
```

Here:

- `U` is bounded to be a subtype of `Shape` (`U <: Shape`).
- The return type is `Shape`.

However, this approach lacks precision. For example, if `Circle` is a subtype of `Shape`, `scale2x` will return a `Shape` even when given a `Circle`. Ideally, we would want the result to retain the specific subtype (`Circle` in this case).

---

## Recursive Types and Bounded Quantification

The challenge arises when recursive types are involved. Let’s take a short detour on recursive types:

### Recursive Types

A **recursive type** is defined in terms of itself. For example:

```scala
trait Shape {
  def scale(f: Double): Shape
}
```

This corresponds to the recursive equation:

```text
Shape ≜ Rec T.{ scale: Double → T }
```

Here, `Shape` is defined as the solution (fixed point) of the equation.

### Subtyping and Recursive Types

The subtype relationship between recursive types depends on the **polarity** (variance) of the recursion:

- **Positive recursion**: Safe subtyping.
- **Negative recursion**: Subtyping breaks down.

#### Example: Positive Recursion

```scala
case class Circle(radius: Double) extends Shape {
  def scale(f: Double): Circle = Circle(radius * f)
}
```

- `Circle` can safely be considered a subtype of `Shape` because it preserves the **positive polarity** of the recursion.

#### Example: Negative Recursion

```scala
trait Comparable {
  def compare(that: Comparable): Boolean
}
```

- For a class `Rational` attempting to implement `compare`, subtyping fails because `compare` involves a **negative recursion**.

---

## F-Bounded Polymorphism to the Rescue

F-bounded polymorphism solves the precision issue of bounded quantification by allowing the bound to reference the type parameter itself.

### Definition

An **F-bounded type** has the form:

```text
[T <: F[T]]
```

Here:

- `F` is a type operator that describes the structure of the type, including recursive references to the type parameter `T`.
- `T` is constrained to be a subtype of `F[T]`.

### Example: Shapes with F-Bounded Polymorphism

We redefine `Shape` using F-bounded polymorphism:

```scala
trait Shape[A] {
  def scale(f: Double): A
}
```

Here:

- `A` is the specific subtype of `Shape`.
- The method `scale` returns the precise type `A`.

We can now write a more precise version of `scale2x`:

```scala
def scale2x[A <: Shape[A]](s: A): A = s.scale(2.0)
```

#### Subclass Example

```scala
case class Circle(radius: Double) extends Shape[Circle] {
  def scale(f: Double): Circle = Circle(radius * f)
}

val circle = Circle(2.0)
val circle2x = scale2x(circle)  // Returns Circle(4.0)
```

Here:

- `Circle` is defined as a subtype of `Shape[Circle]`.
- `scale2x` retains the precise type `Circle`.

---

## Comparables and Negative Recursion

F-bounded polymorphism also addresses issues with **negative recursion**. For example:

```scala
trait Comparable[A] {
  def compare(that: A): Boolean
}
```

Here:

- `A` is the specific type implementing `Comparable`.
- The `compare` method takes an argument of type `A`, preserving type precision.

### Subclass Example

```scala
class Rational(val num: Int, val den: Int) extends Comparable[Rational] {
  def compare(that: Rational): Boolean =
    this.num * that.den == that.num * this.den
}

val r1 = new Rational(1, 2)
val r2 = new Rational(2, 4)
r1.compare(r2)  // True
```

Here:

- `Rational` implements `Comparable[Rational]`.
- The method `compare` correctly takes arguments of type `Rational`.

---

## Key Benefits of F-Bounded Polymorphism

1. **Precision**: Methods return the most specific type possible.
2. **Compatibility**: Works seamlessly with recursive types.
3. **Flexibility**: Supports both positive and negative recursion patterns.

---

## Exercises

### Exercise 1: Recursive Types

Rewrite the following recursive type equations as non-recursive definitions:

1. `R1 ≜ Rec T.{ a: A, f: A → T }`
2. `R2 ≜ Rec T.{ a: A, b: B, f: C → T }`

### Exercise 2: Subtyping Relationships

Given the recursive types from Exercise 1, determine which types are in a subtype relationship. Provide derivations or counterexamples.

### Exercise 3: F-Bounded Polymorphism

Refactor the following trait to use F-bounded polymorphism:

```scala
trait IntSet {
  def union(set: IntSet): IntSet
}
```

Implement a `ListIntSet` class using the refactored trait.

### Exercise 4: Generic Union

Compare the following polymorphic functions:

```scala
def testUnion0[U <: IntSet](set1: U, set2: U): IntSet = set1.union(set2)

def testUnion1[U <: F_IntSet[U]](set1: U, set2: U): U = set1.union(set2)
```

1. Determine the return types.
2. Explain which version is more expressive and why.

---

**REFERENCES AND CREDITS**: This lecture is based on the seminal work on F-Bounded Polymorphism by P. Canning et al.  
[Further Reading](https://www.cs.utexas.edu/~wcook/papers/FBound89/CookFBound89.pdf).