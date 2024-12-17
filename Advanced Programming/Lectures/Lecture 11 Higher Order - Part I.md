# 11. Higher Order - Part I

**ADVANCED PROGRAMMING LANGUAGES**  
Fall 2024, CM 0632. MSc in Computer Science and Information Technology, Ca’ Foscari University of Venice

## Designing Higher-Order Functions

In the previous lectures, we practiced with various uses of **higher-order functions**. Now it’s time to look at how higher-order functions can be defined.

---

## Higher-Order Collection Processing

We start with the design of higher-order operations on collections, using **list processing** as a motivating context. Several patterns emerge repeatedly:

1. Transforming every element of a list.
2. Verifying whether a property holds for all elements of a list.
3. Extracting elements satisfying a condition.
4. Combining elements of a list.

In imperative languages, these patterns are typically expressed using idiomatic `for` or `while` loops. In **Scala**, as in all functional languages, they are expressed concisely with higher-order functions.

The same design applies to other collections in the framework.

---

## Polymorphic Functions and Function Types

One common feature of higher-order functions is that they have **polymorphic function types**. A polymorphic function type accepts **type parameters**, allowing the function to be reused across different types.

---

## Mapping

We start with two fundamental higher-order functions: `map` and `flatMap`.

### `map`

The `map` function takes a function `f` and a list `xs`, then applies `f` to each element of `xs`:

```scala
def map[A, B](xs: List[A], f: A => B): List[B] = xs match {
  case Nil => Nil
  case x :: xs => f(x) :: map(xs, f)
}

val ints = List(1, 2, 3, 4, 5)
val words = List("a", "word", "list")

map(ints, (x => x + 1))      // List(2, 3, 4, 5, 6)
map(words, (x => x.length))  // List(1, 4, 4)
map(words, (x => x.toList))  // List(List('a'), List('w','o','r','d'), List('l','i','s','t'))
```

### `flatMap`

The `flatMap` function applies a **list-valued function** `f` to each element of a list and concatenates the resulting lists:

```scala
def flatMap[A, B](xs: List[A], f: A => List[B]): List[B] = xs match {
  case Nil => Nil
  case x :: xs => f(x) ::: flatMap(xs, f)
}

flatMap(words, (x => x.toList)) // List('a', 'w', 'o', 'r', 'd', 'l', 'i', 's', 't')
```

---

## Filtering

The `filter` function extracts elements from a list that satisfy a **predicate** `p`:

```scala
def filter[A](xs: List[A], p: A => Boolean): List[A] = xs match {
  case Nil => Nil
  case x :: xs => if (p(x)) x :: filter(xs, p) else filter(xs, p)
}

filter(ints, (x => x % 2 == 0))     // List(2, 4)
filter(words, (x => x.length > 2))  // List("word", "list")
```

---

## Folding

### Introduction

Folding combines the elements of a list using an operator and an **initial value**. For example:

#### Sum

```scala
def sum: List[Int] => Int = {
  case Nil => 0
  case x :: xs => x + sum(xs)
}
```

#### Product

```scala
def prod: List[Int] => Int = {
  case Nil => 1
  case x :: xs => x * prod(xs)
}
```

### General Folding: `foldRight`

We abstract the recursion pattern into a general operation called `foldRight`:

```scala
def foldRight[A, B](as: List[A], b: B, f: (A, B) => B): B = as match {
  case Nil => b
  case a :: as => f(a, foldRight(as, b, f))
}
```

#### Examples

```scala
def sum(as: List[Int]): Int = foldRight(as, 0, (x, y) => x + y)
def prod(as: List[Int]): Int = foldRight(as, 1, (x, y) => x * y)
```

#### Other Functions

```scala
def length(as: List[Int]): Int = foldRight(as, 0, (_, y) => y + 1)
def append[A](as: List[A], bs: List[A]): List[A] = foldRight(as, bs, (x, y) => x :: y)
def reverse[A](as: List[A]): List[A] = foldRight(as, Nil, (x, y) => y ::: List(x))
```

---

### `foldLeft` vs `foldRight`

While `foldRight` processes a list from the **right**, there is a dual operation `foldLeft` that processes a list from the **left**:

```scala
def foldLeft[A, B](as: List[A], b: B, f: (B, A) => B): B = as match {
  case Nil => b
  case a :: as => foldLeft(as, f(b, a), f)
}
```

- `foldLeft` is **tail-recursive**, making it more efficient for large lists.

#### Example

```scala
def sum(as: List[Int]): Int = foldLeft(as, 0, (x, y) => x + y)
def prod(as: List[Int]): Int = foldLeft(as, 1, (x, y) => x * y)
```

---

## Reduce

The `reduce` method operates like `fold`, but does not require an initial value. The operation provided must be **associative** and **commutative** for parallel processing:

```scala
val sum = ints.reduce((x, y) => x + y)
val prod = ints.reduce((x, y) => x * y)
```

---

## Exercises

### Exercise 1: Function Pipeline

Define a function `pipe` that takes a list of functions and composes them:

```scala
def pipe[A](fs: List[A => A]): A => A = ???
```

### Exercise 2: Mapping a List of Functions

Define a function `mapfuns` that applies a list of functions to an input value:

```scala
def mapfuns[A, B](x: A, fs: List[A => B]): List[B] = ???
```

### Exercise 3: Quantifier Functions

Implement the following:

1. `forAll`: Checks if all elements satisfy a predicate.
2. `exists`: Checks if at least one element satisfies a predicate.
3. `existsOne`: Checks if exactly one element satisfies a predicate.

Rewrite `forAll` and `exists` using `foldLeft` and `foldRight`.

### Exercise 4: Quicksort

Implement the **quicksort** algorithm using the `filter` method:

```scala
def quicksort[A](xs: List[A])(lt: (A, A) => Boolean): List[A] = ???
```

### Exercise 5: List Operations

Write functions to:

1. Find strings of length greater than 3.
2. Add `1.0` to every element of a list of floats.
3. Concatenate strings with a separator.

Rewrite the above using `map`, `filter`, or `fold` as appropriate.

---

**CREDITS**: Material adapted from Chapter 15 of _Programming in Scala_ (5th Edition) by Martin Odersky, Lex Spoon, and Bill Venners. Quicksort example sourced from Haskell Wikibooks.  
[Further Reading](https://en.wikibooks.org/wiki/Haskell/Higher-order_functions).