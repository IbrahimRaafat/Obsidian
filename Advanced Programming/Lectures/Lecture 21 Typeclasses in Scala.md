# 21. Typeclasses in Scala

**ADVANCED PROGRAMMING LANGUAGES**  
Fall 2024, CM 0632. MSc in Computer Science and Information Technology, Ca’ Foscari University of Venice

## Typeclasses in Scala

In our last lecture, we have shown three different mechanisms to write a function that can be applied to some types but not to others:

1. **Overloading**: Multiple function definitions exist for each type.
2. **Object-Oriented Programming (OOP)**: Define the function in a common supertype.
3. **Typeclasses**: Define a trait (typeclass) and write the function to work with types for which a specific instance of the typeclass is defined.

We have seen how typeclasses are implemented in **Haskell**. Here, we explore how typeclasses can be implemented in **Scala** using two approaches:

1. A direct **dictionary-based translation**, similar to Haskell's implementation.
2. A more powerful abstraction using Scala’s **contextual abstraction** mechanisms.

---

## Dictionary-Based Typeclass Implementation

We illustrate a **simple typeclass pattern** using traits to represent dictionaries, similar to Haskell's approach.

### Problem: Ordered Insert Function

The following code fails because `<=` is not universally defined:

```scala
// Does not compile

def insert[T](x: T, xs: List[T]): List[T] = 
  if (xs.isEmpty || x <= xs.head) x :: xs
  else xs.head :: insert(x, xs.tail)
```

### Solution: Define a Typeclass for Ordering

We define a trait `Ord` representing types that admit an ordering relation:

```scala
trait Ord[T]:
  def compare(x: T, y: T): Int
  def lteq(x: T, y: T): Boolean = compare(x, y) <= 0
  def lt(x: T, y: T): Boolean = compare(x, y) < 0
  def gteq(x: T, y: T): Boolean = compare(x, y) >= 0
  def gt(x: T, y: T): Boolean = compare(x, y) > 0
```

The `Ord` trait provides default implementations for comparison operations based on the `compare` method.

### Insert Function with Typeclass

We rewrite `insert` to accept an instance of `Ord`:

```scala
def insert[T](x: T, xs: List[T])(ord: Ord[T]): List[T] = 
  if (xs.isEmpty || ord.lteq(x, xs.head)) x :: xs
  else xs.head :: insert(x, xs.tail)(ord)
```

Here:

- `ord: Ord[T]` acts as a **dictionary** providing the ordering methods.
- The dictionary must be explicitly passed in recursive calls.

### Instances of `Ord` for Specific Types

We provide concrete implementations of `Ord` for `Int`, `Double`, and `String`:

```scala
case object IntOrd extends Ord[Int]:
  def compare(x: Int, y: Int): Int = x - y

case object DoubleOrd extends Ord[Double]:
  def compare(x: Double, y: Double): Int =
    if (x == y) 0 else if (x > y) 1 else -1

case object StringOrd extends Ord[String]:
  def compare(x: String, y: String): Int = x.compare(y)
```

### Usage

We call `insert` with the appropriate instance:

```scala
insert(7, List(1, 2, 4, 5))(IntOrd)
insert(5.6, List(3.2, 4.2, 1.3))(DoubleOrd)
insert("aa", List("aaa", "aab", "abc"))(StringOrd)
```

---

## Contextual Abstractions in Scala

Scala provides powerful **contextual abstractions** that simplify the use of typeclasses and dictionaries. This includes:

1. **Extension methods**
2. **Givens**
3. **Using clauses**
4. **Context bounds**

### Extension Methods

Extension methods allow adding methods to an existing type:

```scala
case class Circle(x: Double, y: Double, radius: Double)

extension (c: Circle)
  def circumference: Double = c.radius * math.Pi * 2

val circle = Circle(0, 0, 1)
println(circle.circumference)  // 6.283185...
```

### Givens and Using Clauses

Givens allow the compiler to provide implicit arguments automatically:

```scala
object Ord:
  given Ord[Int] with
    def compare(x: Int, y: Int): Int = x - y

  given Ord[String] with
    def compare(x: String, y: String): Int = x.compare(y)


def insert[T](x: T, xs: List[T])(using ord: Ord[T]): List[T] = 
  if (xs.isEmpty || ord.lteq(x, xs.head)) x :: xs
  else xs.head :: insert(x, xs.tail)

insert(7, List(1, 2, 4, 5))      // Compiler provides Ord[Int]
insert("a", List("b", "c"))     // Compiler provides Ord[String]
```

Here:

- `using ord: Ord[T]` signals that `Ord[T]` will be supplied automatically by the compiler.
- Givens in the `Ord` object provide the required instances.

### Summoned Parameters

We can summon typeclass instances explicitly using `summon`:

```scala
import scala.compiletime.summon

summon[Ord[Int]]
```

This allows accessing implicit instances directly when needed.

### Context Bounds

Context bounds provide syntactic sugar for typeclasses:

```scala
def insert[T: Ord](x: T, xs: List[T]): List[T] =
  if (xs.isEmpty || summon[Ord[T]].lteq(x, xs.head)) x :: xs
  else xs.head :: insert(x, xs.tail)
```

Here, `[T: Ord]` is equivalent to `(using Ord[T])`.

---

## Typeclass Derivation

Scala 3 supports automatic derivation of typeclass instances for algebraic data types:

### Example: `Eq` Typeclass

```scala
enum Tree[T] derives Eq:
  case Branch(left: Tree[T], right: Tree[T])
  case Leaf(elem: T)
```

The `derives Eq` clause automatically generates the `Eq` instance for `Tree[T]`.

### Generated Instance

The compiler generates the following given:

```scala
given [T: Eq]: Eq[Tree[T]] = Eq.derived
```

This makes equality checks for `Tree[T]` possible when `T` belongs to the `Eq` typeclass.

---

## Exercises

### Exercise 1: Typeclasses for Ordering

1. Define a `Min` typeclass with a method `min(a: T, b: T): T`.
2. Implement instances for `Int`, `Double`, and `String`.

### Exercise 2: Context Bounds

Refactor the `insert` function to use context bounds instead of `using` clauses.

### Exercise 3: Typeclass Derivation

1. Define an algebraic data type `Tree`.
2. Use `derives` to generate an instance of `Eq` for `Tree`.

---

**REFERENCES AND CREDITS**: This lecture is based on Chapters 21, 22, and 23 of _Programming in Scala_ and the Scala 3 documentation.  
[Further Reading](https://docs.scala-lang.org/scala3/reference/contextual/index.html).