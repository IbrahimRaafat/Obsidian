# 18. Type Parametrization

**ADVANCED PROGRAMMING LANGUAGES**  
Fall 2024, CM 0632. MSc in Computer Science and Information Technology, Ca’ Foscari University of Venice

## Type Parametrization and Subtyping

In this lecture, we look at **type parametrization**. While we have seen various examples of parametrization at work, it is now time for a deeper dive into the details.

### Type Parametrization Overview

Type parametrization allows us to **factor out the common structure** of different types into a single construction. We have seen this mechanism with polymorphic functions, but now we focus on **parametric types**.

For example, `Set[T]` abstracts over the common structure of sets while allowing different component types, represented by the type parameter `T`.

### Type Constructors

Parametric type definitions introduce **type operators**, not types. Type operators construct types by applying parameters. For instance:

```scala
trait List[A]
```

Here:

- `List` is a **type constructor**.
- Applying `List` to a type `A` produces a concrete type `List[A]`.

---

## Parametric Types: Functional Queues

We introduce a **parametric type** for implementing functional queues efficiently. Unlike a naive list-based queue, this implementation uses two lists:

1. `leading`: Contains elements at the front.
2. `trailing`: Contains elements at the back, in reverse order.

### Queue Invariant

The queue's content is represented as:

```text
leading ::: trailing.reverse
```

Operations maintain this invariant:

- Enqueue: Add elements to `trailing`.
- Dequeue: Extract elements from `leading`. If `leading` is empty, reverse `trailing` and swap the lists.

#### Queue Implementation

```scala
class Queue[A](private val leading: List[A], private val trailing: List[A]) {
  def this() = this(Nil, Nil)  // Auxiliary constructor

  protected def reorder: Queue[A] =
    if (leading.isEmpty) new Queue(trailing.reverse, Nil)
    else this

  def head: A = reorder.leading.head

  def dequeue: Queue[A] = {
    val q = reorder
    new Queue(q.leading.tail, q.trailing)
  }

  def enqueue(a: A): Queue[A] =
    new Queue(leading, a :: trailing)
}

object Queue {
  def apply[A](as: A*) = new Queue[A](as.toList, Nil)
}
```

### Key Features

- `leading` and `trailing` are **private** fields to hide implementation details.
- The `reorder` method ensures the invariant is preserved.
- The implementation is **purely functional**: operations return new queues without side effects.

---

## Variance Annotations: Parametric Types and Subtyping

### Invariance

In Scala, parametric types are **invariant** by default. This means that `Queue[A]` and `Queue[B]` are unrelated, even if `A <: B`.

#### Why Invariance for Mutable Types?

For mutable types, covariance or contravariance can break type safety. Consider a mutable cell:

```scala
class Cell[T](init: T) {
  private var current = init
  def get: T = current
  def set(x: T): Unit = current = x
}
```

If `Cell` were covariant (`Cell[+T]`), the following unsound situation could occur:

```scala
val c1 = new Cell(1)
val c2: Cell[Any] = c1  // Allowed if Cell is covariant
c2.set("abc")          // Violates type safety
val broken = c1.get + 2 // Error: attempting to add Int and String
```

---

## Soundness of Functional Queues

For purely functional types like `Queue`, covariance **seems** sound. However, even purely functional types can encounter unsoundness if parameters appear in contravariant positions. Consider:

```scala
class PowerQueue extends Queue[Double] {
  override def enqueue(a: Double) = super.enqueue(math.pow(a, 2))
}
```

If `Queue` were declared covariant (`Queue[+A]`), the following becomes problematic:

```scala
val q: Queue[Any] = new PowerQueue  // Allowed if Queue is covariant
q.enqueue("abc")                   // Unsafe
```

### Why It Breaks

The unsoundness stems from the **function subtyping rule**:

```text
A → Queue[A] <: B → Queue[B]  only if  B <: A
```

Here, `enqueue` takes an input type `A`, which is contravariant, so `Queue[+A]` must be rejected.

---

## Lower Bounds for Covariant Types

We can regain safe covariance for `Queue` by generalizing `enqueue` using a **lower bound**:

```scala
class Queue[+A] {
  def enqueue[U >: A](a: U): Queue[U] =
    new Queue[U](leading, a :: trailing)
}
```

Here:

- `U >: A` ensures that `enqueue` accepts any supertype of `A`.
- The return type `Queue[U]` reflects this generalization.

#### Example

```scala
class Point(val x: Double, val y: Double)
class ColorPoint(x: Double, y: Double, val c: String) extends Point(x, y)

val q0 = Queue(new ColorPoint(1, 2, "blue"), new ColorPoint(2, 5, "red"))
val q1 = q0.enqueue(new Point(0, 5))
val pt: Point = q1.head
```

Here, the lower bound allows us to safely add a `Point` to a `Queue[ColorPoint]`, producing a `Queue[Point]`.

---

## Contravariance and Upper Bounds

Contravariant types are common for **consumers** of values. For instance:

```scala
trait OutputChannel[-A] {
  def write(x: A): Unit
}
```

A contravariant `OutputChannel[String]` can safely substitute an `OutputChannel[AnyRef]` because a `String` is an `AnyRef`. However:

```scala
def last: A  // Illegal for contravariant A
```

The return type `A` appears in a **covariant position**, breaking soundness.

### Fix with Upper Bounds

We can fix the contravariant issue using an **upper bound**:

```scala
trait OutputChannel[-A] {
  def write(x: A): Unit
  def last[U <: A]: U
}
```

---

## Scala vs Java: Variance and Wildcards

Scala’s **variance annotations** (`+` and `-`) simplify type parametrization compared to Java’s **wildcards**.

### Example: Streams

Scala’s definition:

```scala
trait Stream[+A] {
  def filter(p: A => Boolean): Stream[A]
  def map[B](f: A => B): Stream[B]
}
```

Java’s equivalent:

```java
interface Stream<T> {
    Stream<T> filter(Predicate<? super T> p);
    <R> Stream<R> map(Function<? super T, ? extends R> f);
}
```

### Key Differences

1. **Simpler Syntax**: Scala uses variance annotations instead of wildcards.
2. **Lower and Upper Bounds**: Scala supports them naturally to handle contravariant and covariant cases.

---

## Exercises

### Exercise 1: Type Exploration

1. Determine the return types of `pointsOnLine` and `javaPointsOnLine`.
2. Rewrite `pointsOnLine` using lower bounds.

### Exercise 2: Comparing `map` Methods

Construct an example to compare the two versions of `map` (Scala vs Java).

---

**REFERENCES AND CREDITS**: Material adapted from _Programming in Scala_, Chapter 18, and inspired by S. Crafa’s lecture notes on advanced type systems.  
[Further Reading](http://lucacardelli.name/papers/onunderstanding.a4.pdf).