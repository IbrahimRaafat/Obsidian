# 12. Higher Order - Part II

**ADVANCED PROGRAMMING LANGUAGES**  
Fall 2024, CM 0632. MSc in Computer Science and Information Technology, Ca’ Foscari University of Venice

## Designing Higher-Order Functions – Part II

We have illustrated the power of higher-order definitions as a tool to factor out the common patterns of **collection processing**. In this lecture, we look at further specific features of higher-order functions and their types.

---

## Paradigmatic Higher-Order Schemes

### Currying and Uncurrying

Functions of more than one argument may be defined in two different ways:

1. Passing all arguments at once, in a tuple.
2. Passing arguments one by one in a sequence.

#### Example:

```scala
def add(x: Int, y: Int): Int = x + y      // add: (Int, Int) => Int
def addc(x: Int)(y: Int): Int = x + y     // addc: Int => Int => Int
```

The two definitions are **isomorphic**. We can transform one into the other using two helper functions:

- `curry`: Transforms a tupled function into a curried function.
- `uncurry`: Transforms a curried function into a tupled function.

#### Definitions:

```scala
def curry[A, B, C](f: (A, B) => C): A => B => C =
  (x: A) => (y: B) => f(x, y)

def uncurry[A, B, C](f: A => B => C): (A, B) => C =
  (x: A, y: B) => f(x)(y)

val add = uncurry(addc)
val addc = curry(add)
```

---

### Function Composition

Function composition takes two functions as arguments and returns a new function that applies the first function to an input, then the second function to the result.

#### Definition:

```scala
def compose[A, B, C](f: A => B, g: B => C): A => C =
  (a: A) => g(f(a))
```

---

### Flipping Arguments

Flipping arguments takes a curried function of two arguments and returns a version with the arguments swapped.

#### Definition:

```scala
def flip[A, B, C](f: A => B => C): B => A => C =
  (b: B) => (a: A) => f(a)(b)
```

Flipping is useful when arguments appear in the wrong order for a higher-order function.

---

## Polymorphic Typing

Higher-order functions often go hand in hand with **polymorphic types**, which allow generalization over multiple types.

### Polymorphic Function Examples

```scala
def len[A](xs: List[A]): Int = xs.length

def len[A] = (xs: List[A]) => xs.length

def len = [A] => (xs: List[A]) => xs.length
```

#### Type Inference Example:

```scala
val someNumbers = List(1, 5, 17, -2, 14)
someNumbers.map(x => x + 1)  // Type of x is inferred as Int
```

---

## Functions vs Closures

Functions can have **free variables** bound by their **enclosing context**. When this happens, the result is a **closure**.

#### Example:

```scala
def addx(x: Int) = (y: Int) => x + y

val addThree = addx(3)
addThree(2)  // Returns 5
```

Here, `x` is a free variable in the function literal `(y: Int) => x + y`. The closure carries a reference to the context where `x` is defined.

### Static Scope

In statically scoped languages like Scala, the binding for free variables is determined by their **definition site**.

#### Example:

```scala
def showScope = {
  val x: Int = 3

  def f(y: Int) = x + y

  def show = {
    val x: Int = 4
    f(2) + x
  }
  show
}

showScope  // Returns 9
```

### Mutability in Closures

If a closure captures a mutable variable, changes to the variable **after** the closure is created are visible in the closure.

#### Example:

```scala
var more = 1
val addMore = (x: Int) => x + more

addMore(10)  // 11

more = 37
addMore(10)  // 47
```

Scala captures **variable references**, not values.

---

## Exercises

### Exercise 1: Function Repetition

Design the following functions:

1. `two`: Applies a function `f` twice.
2. `three`: Applies a function `f` three times.
3. `one` and `zero`: Apply `f` once and zero times, respectively.

### Exercise 2: Repeater Functions

Define a **repeater** as follows:

```scala
type Repeater[A] = (A => A) => (A => A)
```

Design the following:

1. `rep2nat`: Converts a repeater to its equivalent natural number.
    
    ```scala
    rep2nat(two)  // Returns 2
    ```
    
2. `repadd1`: Increments a repeater by 1.
3. `nat2rep`: Converts a natural number into its equivalent repeater.
4. `rep_plus` and `rep_prod`: Return repeaters representing the sum and product of two repeaters.

### Exercise 3: Arithmetic Operations

Write lifted functions:

1. `adder`: Adds results of two functions.
2. `multiplier`: Multiplies results of two functions.
3. `divider`: Divides results of two functions.

### Exercise 4: Generalized Lifter

Write a function `lifter` that takes a binary operator `op` and returns a lifted version:

```scala
def lifter(op: (Double, Double) => Double): (Int => Double, Int => Double) => (Int => Double)
```

### Exercise 5: Boolean Operators

Write a lifted version of the Boolean `&&` (and) operator:

```scala
def meet(f: Int => Boolean, g: Int => Boolean): Int => Boolean
```

Generalize `meet` to accept a list of predicates:

```scala
def Meet(predicates: List[Int => Boolean]): Int => Boolean
```

---

**CREDITS**: Material adapted from Chapter 16 of _Programming in Scala_ (5th Edition) by Martin Odersky, Lex Spoon, and Bill Venners.