# 14. Lazy Evaluation

**ADVANCED PROGRAMMING LANGUAGES**  
Fall 2024, CM 0632. MSc in Computer Science and Information Technology, Ca’ Foscari University of Venice

## Lazy Evaluation

Having introduced the principles underpinning strict and non-strict evaluation strategies, we look at the practical application of **non-strict evaluation**.

We develop our analysis in the context of a strict language, like **Scala**, where lazy evaluation is implemented using **suspension (thunking)** and **forcing** mechanisms.

---

## Lazy Function Parameters

We start with **non-strict function parameters** and demonstrate the benefits of delayed argument evaluation, as seen in **call-by-name semantics**.

### Example: Assertion Framework

Consider a simple testing framework:

```scala
var assertionsEnabled = true  // Enable/Disable assertions

def assert(condition: () => Boolean) =
  if (assertionsEnabled && !condition()) then
    throw new AssertionError
```

Here:

- `condition` is a **thunked** parameter.
- The argument `() => <bool exp>` suspends the evaluation of `<bool exp>` until it is explicitly forced in the `assert` body.

### By-Name Parameters

Scala simplifies thunked function parameters using **by-name parameters**:

```scala
def assert(condition: => Boolean) =
  if (assertionsEnabled && !condition) then
    throw new AssertionError
```

- The `=>` syntax defines a by-name parameter.
- Arguments passed to `condition` are **not evaluated** until used within the function body.

#### Why Not Use `Boolean` Directly?

If `condition` were of type `Boolean`:

```scala
def assert(condition: Boolean) =
  if (assertionsEnabled && !condition) then ...
```

The argument `<bool exp>` would be evaluated **before** `assert` is invoked, defeating the purpose of lazy evaluation.

---

## Lazy Variables and Fields

### Lazy Variables

By-name parameters are only allowed for `def` functions. For **variables**, Scala provides `lazy val` declarations:

```scala
def summation(cond: Boolean, n: => Int): Int = {
  lazy val m: Int = n  // Lazy variable
  if (!cond) then -1 else (m * (m - 1)) / 2
}
```

Here:

- `n` is passed **by name** and evaluated **only when needed**.
- `lazy val m` caches the result of `n`, ensuring it is evaluated **at most once**.

---

## Lazy Data Structures

Lazy evaluation is particularly useful with **data structures** to avoid unnecessary computation.

### Problem with Lists

Cascaded operations on lists create **intermediate results**:

```scala
List(1, 2, 3, 4).map(_ + 10).filter(_ % 2 == 0).map(_ * 3)
```

Execution:

```text
List(1, 2, 3, 4) → List(11, 12, 13, 14) → List(12, 14) → List(36, 42)
```

Each transformation generates intermediate lists, causing inefficiency.

### Streams: Infinite Lazy Lists

A **stream** avoids intermediate results by creating elements **lazily**:

```scala
enum Stream[+A]:
  case Empty
  case Cons(hd: A, tl: () => Stream[A])
```

#### Example:

```scala
def numberStream: Stream[Int] = {
  def from(n: Int): Stream[Int] = Cons(n, () => from(n + 1))
  from(0)
}
```

- The tail `tl` is **thunked**, so elements are computed **on demand**.

#### Operations on Streams

We define methods to work with streams:

```scala
def take(n: Int): List[A] =
  if (n <= 0) Nil
  else this match
    case Empty => Nil
    case Cons(h, t) => h :: t().take(n - 1)

def map[B](f: A => B): Stream[B] = this match
  case Empty => Empty
  case Cons(h, t) => Cons(f(h), () => t().map(f))
```

---

## Smart Constructors

Explicit thunking in stream definitions is cumbersome. We simplify this with **smart constructors**:

```scala
object Stream:
  def cons[A](hd: A, tl: => Stream[A]): Stream[A] =
    Cons(hd, () => tl)

  def apply[A](as: A*): Stream[A] =
    if (as.isEmpty) Empty else cons(as.head, apply(as.tail: _*))
```

Example:

```scala
def numberStream: Stream[Int] = {
  def from(n: Int): Stream[Int] = Stream.cons(n, from(n + 1))
  from(0)
}
```

---

## Scala’s `LazyList`

Scala provides a built-in **LazyList** as a lazy alternative to `List`:

```scala
def from(n: Int): LazyList[Int] = {
  def loop(n: Int): LazyList[Int] = n #:: loop(n + 1)
  loop(n)
}
```

### Key Features:

- **By-name parameters**: Both head and tail are lazy.
- **Memoization**: Once evaluated, results are cached.

Example:

```scala
val ints = from(5)
ints.head         // 5
ints.tail.head    // 6
ints              // LazyList(5, 6, <not computed>)
```

---

## Exercises

### Exercise 1: Stream Unfold

Implement the function `unfold`:

```scala
def unfold[A, S](state: S)(f: S => Option[(A, S)]): Stream[A] = ???
```

1. Define `from: Int => Stream[Int]` using `unfold`.
2. Define `take: (Stream[A], Int) => Stream[A]` using `unfold`.

### Exercise 2: Alternating Stream

Write a stream `danThenDog` that alternates between the strings “dan.jpg” and “dog.jpg”.

### Exercise 3: Cycle List

Write a function `cycleList` that turns a list into an infinite stream. Test it with:

```scala
take(cycleList(List(1, 2, 3)), 10)
```

---

**CREDITS**: Material on by-name parameters is adapted from Chapter 9 of _Programming in Scala_. The discussion on lazy data structures is from Chapter 5 of _Functional Programming in Scala_.  
[Further Reading](https://docs.scala-lang.org/overviews/collections-2.13/lazy-lists.html).