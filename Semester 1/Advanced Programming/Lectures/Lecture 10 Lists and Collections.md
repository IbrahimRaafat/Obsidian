# 10. Lists and Collections

**ADVANCED PROGRAMMING LANGUAGES**  
Fall 2024, CM 0632. MSc in Computer Science and Information Technology, Ca’ Foscari University of Venice

## Lists and Collections

We continue our discussion on data modeling and the mechanisms provided to support them in Scala. We start with **lists**, probably the most ubiquitous functional data structure, and then extend our analysis to generalized **collections**.

Like arrays, lists are **homogeneous**, meaning that the elements of a list all have the same type: `List[A]` is the type of lists whose elements have type `A`.

### Examples

```scala
val fruits: List[String] = List("apple", "orange", "pear")
val ints: List[Int] = List(1, 0, 4, 6)
val words: List[List[Char]] = List(List('a', 'n'), List('a', 'p', 'p', 'l', 'e'))
val empty: List[Nothing] = List()
```

- Lists in Scala are **immutable**.
- Lists are **covariant**: if `A` is a subtype of `B`, then `List[A]` is a subtype of `List[B]`.
- `Nothing` is the **bottom type** in Scala, meaning it is a subtype of every Scala type. The empty list `List()` is thus a `List[Nothing]`, which is a subtype of any `List[A]`.

---

## Constructing and Deconstructing Lists

All lists are built from two fundamental building blocks:

1. `Nil`: Represents the **empty list**.
2. `::`: The (infix) **constructor** that prepends an element to a list.

### Syntax

```scala
val fruits: List[String] = "apple" :: ("orange" :: ("pear" :: Nil))
val ints: List[Int] = 1 :: (0 :: (4 :: (6 :: Nil)))
val empty: List[Nothing] = Nil
```

### Associativity

The `::` operator is **right-associative**, so:

```scala
A :: B :: C  // Equivalent to A :: (B :: C)
```

### Pattern Matching on Lists

List patterns correspond directly to list expressions. For example:

```scala
val List(x, y, z) = fruits  // Binds x = "apple", y = "orange", z = "pear"
val x :: xs = ints          // Binds x = 1, xs = List(0, 4, 6)
```

---

## Immutability and Data Sharing

Scala lists are immutable, which means operations like prepending an element (`x :: xs`) do not copy the entire list but instead reuse the original list through **data sharing**. For example:

- Adding an element does not create a new copy of the existing list.
- Removing elements (e.g., via `tail`) simply returns a reference to the rest of the list.

This approach ensures efficiency without defensive copying.

---

## The Scala Collection Framework

Scala's collection framework generalizes lists to a broader concept of **collections**. It provides a uniform suite of operators for working with data at a high level, treating collections as primary building blocks.

### Advantages of Scala Collections

1. **Easy to Use**: Concise and expressive methods replace complex loops.
2. **Safe**: Static typing catches most errors at compile-time.
3. **Concise**: Many operations can be expressed in a single line.
4. **Fast**: Optimized implementations ensure performance.
5. **Parallelizable**: Collections can leverage multiple cores for parallel execution.
6. **Universal**: Consistent operations across all collection types.

---

## Mutable vs Immutable Collections

Scala collections are organized into three main packages:

- `scala.collection` (root collections: mutable or immutable)
- `scala.collection.immutable` (guaranteed immutable)
- `scala.collection.mutable` (supports in-place modification)

### Immutable Collections

Immutable collections **never change** after they are created. Operations like adding or removing elements return a **new collection**, leaving the original unchanged.

```scala
val xs = List(1, 2, 3)
val ys = xs :+ 4  // Adds 4 to the end, returns a new list
```

### Mutable Collections

Mutable collections support **in-place modifications** like adding or removing elements:

```scala
val buffer = scala.collection.mutable.ListBuffer[Int]()
buffer += 1  // Modifies the buffer in-place
```

### Default Behavior

By default, Scala imports immutable collections. For example:

```scala
val set = Set(1, 2, 3)  // Immutable set
```

---

## Collection Methods

Scala collections support a rich set of **methods**. These methods follow the **uniform return type principle**: the result of an operation matches the type of the original collection.

### Examples

```scala
List('a', 'b', 'c', 'd', 'e').drop(2)  // List[Char] = List(c, d, e)
Set('a', 'b', 'c', 'd', 'e').drop(2)   // Set[Char] = Set(c, d, e)
```

---

## Higher-Order Methods

Scala collections support **higher-order methods** for functional programming:

### Mapping: `map` and `flatMap`

- `map` applies a function to each element:
    
    ```scala
    def squares(ints: Set[Int]): Set[Int] = ints.map(n => n * n)
    squares(Set(2, 3, 4, 5))  // Set(4, 9, 16, 25)
    ```
    
- `flatMap` applies a function that returns collections and flattens the result:
    

def getWords(lines: Seq[String]): Seq[String] = lines.flatMap(line => line.split("\W+"))

val lines = List("the first line", "then comes a second one") getWords(lines) // List(the, first, line, then, comes, a, second, one)

````

### Filtering: `filter`, `partition`, `find`
```scala
val ints = Set(1, 3, 4, 5, 6, 8, 9)
val even = (x: Int) => x % 2 == 0

ints.filter(even)     // Set(4, 6, 8)
ints.partition(even)  // (Set(4, 6, 8), Set(1, 3, 5, 9))
````

### Grouping: `groupBy`

Partitions a collection based on a discriminating function:

```scala
val invoices = List(Invoice("A", 13.0), Invoice("A", 1.25))
val grouped = invoices.groupBy(inv => inv.client)
// Map("A" -> List(Invoice("A", 13.0), Invoice("A", 1.25)))
```

---

## Exercises

### Exercise 1: Basic List Functions

Implement the following:

1. `isEmpty[A]`: True if the list is empty.
2. `head[A]`: Returns the first element.
3. `tail[A]`: Returns the rest of the list.
4. `drop[A](n: Int)`: Drops the first `n` elements.
5. `length[A]`: Returns the length of the list.
6. `reverse[A]`: Reverses the list.
7. `split[A]`: Splits a list into two halves.

### Exercise 2: Mergesort

Implement a polymorphic `msort` function:

```scala
def msort[A](lt: (A, A) => Boolean, xs: List[A]): List[A] =
```

### Exercise 3: Word Scanner

Implement a word scanner:

```scala
def words(xs: List[Char]): List[List[Char]] =
```

---

**CREDITS**: Material is adapted from Chapter 14 of _Programming in Scala_ (5th Edition) by Martin Odersky, Lex Spoon, and Bill Venners, Artima Press, 2021.  
Additional resources: [Scala Collections Documentation](https://docs.scala-lang.org/overviews/collections-2.13/introduction.html).