# 2. Scala Overview

**ADVANCED PROGRAMMING LANGUAGES**  
Fall 2024, CM 0632. MSc in Computer Science and Information Technology, Ca’ Foscari University of Venice

## Functional Programming in Scala

Scala was created and developed by **Martin Odersky** at the **Ecole Polytechnique Federale de Lausanne (EPFL)**. It was officially released for the **Java platform** in early 2004 and for **.Net framework** in June 2004. Scala dropped .Net support in 2012. The name "Scala" is a combination of "scalable" and "language," signifying that it is designed to grow with the demands of its users.

Fully interoperable with **Java**, Scala is a strong, statically typed, general-purpose programming language that integrates **object-oriented** and **functional programming** within an elegant framework.

### Key Features

- Support for functional programming:
    - **Immutability**
    - **Higher-order polymorphic functions**
    - **Pattern matching**
    - **Lazy evaluation**
- **Expressive strong, static typing system**:
    - Rich algebraic data types
    - Parametric types with variance annotations
    - Type classes
- Code reuse mechanisms:
    - Traits and mixins that extend Java's classes and interfaces
- Rich libraries, tools, and APIs for application development across target domains.

Scala provides support for functional programming but is not a pure functional language. For this course, the focus will remain on Scala’s pure subset, leaving imperative features in the background.

## REPL

The **REPL** (Read-Eval-Print-Loop) is an interactive interpreter for Scala:

- Reads definitions and expressions
- Checks and infers types
- Executes and prints the result if there are no errors

### Examples

```scala
scala> 17 * 3
val res0: Int = 51

scala> val x = 13 * 2 + 5
val x: Int = 31

scala> val x: Int = "Hello"
-- [E007] Type Mismatch Error:
  | Found:    "Hello" : String
  | Required: Int
```

Identifiers introduced with `val` are **immutable**. New `val` definitions for the same identifier in REPL hide previous definitions, as each new definition opens a new scope.

### Expression Blocks and Local Bindings

```scala
scala> val amount = { val x = 5 * 20; x + 10 }
val amount: Int = 110

scala> val amount =
     |   val x = 5 * 20
     |   x + 10
val amount: Int = 110
```

The last expression in a block is the return value.

## Primitive Types

- **Booleans**: `true`, `false`, operators (`==`, `&&`, `||`, `!`)
- **Integers**: `0`, `1`, `2`, `-5`
- **Strings**: `"Hello World"`
- **Doubles**: `1.2`, `3.14159`

In Scala, all operators are methods. For example:

```scala
2 + 3  // Equivalent to 2.+(3)
```

## Tuples

Tuples can contain elements of different types:

```scala
scala> val triple = (4, 5, "Griffendor")
val triple: (Int, Int, String) = (4,5,Griffendor)
```

Access tuple elements using `_i` where `i` is the index:

```scala
triple._1  // 4
triple._2  // 5
triple._3  // "Griffendor"
```

## Lists

Lists are predefined and immutable in Scala:

```scala
scala> val listofthree = List(1, 2, 3)
listOfThree : List[Int] = List(1, 2, 3)

scala> val thrill = "Will" :: "fill" :: "until" :: Nil
```

### Common Operations

|Operation|Description|
|---|---|
|`List()` or `Nil`|Creates an empty list|
|`List("a", "b") ::: List("c", "d")`|Concatenates two lists|
|`thrill.head`|Returns the first element|
|`thrill.last`|Returns the last element|
|`thrill.map(s => s + "y")`|Adds "y" to each element|
|`thrill.mkString(", ")`|Joins elements into a string: "Will, fill, until"|

### Conditional Expressions

```scala
scala> val max = if (x > y) x else y
```

### Match Expressions

A match expression is similar to `switch` but more powerful:

```scala
val message = status match {
  case 200 => "ok"
  case 400 => "ERROR - we called the service incorrectly"
  case 500 => "ERROR - the service encountered an error"
}
```

## Loops and Comprehensions

Loops in Scala return a collection of values:

```scala
scala> for (x <- 1 to 7) yield "Day " ++ x.toString
```

With filtering:

```scala
scala> val threes = for (i <- 1 to 20 if i % 3 == 0) yield i
```

## Functions

### Basic Function

```scala
def max(x: Int, y: Int): Int = if (x > y) x else y
```

### Recursive and Tail-Recursive Functions

Tail-recursive functions optimize performance by reusing stack frames:

```scala
@annotation.tailrec
def tr_power(x: Int, n: Int, acc: Int): Int =
  if (n >= 1) tr_power(x, n-1, acc*x) else acc
```

## Higher-Order Functions

Functions can accept other functions as arguments:

```scala
def format(n: Int, name: String, f: Int => Int): String =
  "The %s of %d is %d".format(name, n, f(n))

def formatAbs(n: Int) = format(n, "abs", abs)
```

## Polymorphic Functions

Polymorphic functions operate on generic types:

```scala
def polyFindFirst[A](as: Array[A], key: A, p: A => Boolean): Int = {
  @annotation.tailrec
def loop(n: Int): Int =
    if (n >= as.length) -1
    else if (p(as(n))) n
    else loop(n + 1)
  loop(0)
}
```

## Exercises

1. **Tail recursive Fibonacci**
    - Write a tail-recursive Fibonacci function.
2. **Count Change**
    - Write a recursive function `count_change` to compute ways to make change.
3. **Higher-order formatting**
    - Use `format` to define `format_cube`.
4. **Find First Occurrence**
    - Define `findFirst` as an instance of `polyFindFirst`.
5. **Check Sorted List**
    - Write a function to check if a list is sorted using recursion and tail-recursion.