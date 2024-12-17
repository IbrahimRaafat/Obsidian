# 20. Overloading and Typeclasses

**ADVANCED PROGRAMMING LANGUAGES**  
Fall 2024, CM 0632. MSc in Computer Science and Information Technology, Ca’ Foscari University of Venice

## Overloading and Constrained Polymorphism

In the past two lectures, we explored **type parametrization** for datatypes and the functions operating on them. Parametric polymorphism allows code to act generically, irrespective of specific types. In this lecture, we focus on **overloading** and **typeclasses**, two powerful mechanisms for constrained polymorphism.

---

## Overloading

### Parametric Polymorphism vs Overloading

- **Parametric Polymorphism**: A single implementation works for any type.
    
    ```scala
    def length[A](xs: List[A]): Int = xs.size
    ```
    
- **Overloading**: Multiple implementations exist for different types.
    
    ```scala
    def +(x: Int, y: Int): Int = x + y
    def +(x: Double, y: Double): Double = x + y
    ```
    

Here, `+` acts differently for `Int` and `Double` because the implementations depend on how integers and floating-point numbers are represented.

### Key Features of Overloading

1. A **single function symbol** has multiple implementations.
2. Each implementation has a **different type**.
3. **Overloading resolution** determines which implementation to use based on the type context.

#### Example

```scala
def square(x: Int): Int = x * x
def square(x: Double): Double = x * x

square(3)       // 9
square(3.14)    // 9.8596
```

Defining overloaded versions explicitly works, but it becomes inefficient when multiple types are involved (e.g., `Int`, `Double`, `Float`, `Short`, etc.).

---

## Limitations of Overloading

### Arithmetic Overloading

Overloading basic operations is manageable, but user-defined functions suffer from **representation dependency**. For instance:

```scala
def square(x: A): A = x * x  // Type Error: Cannot resolve `*` for arbitrary types.
```

The operator `*` is not universally defined, and we would need multiple versions for every supported type.

### Equality

Historically, equality has been implemented in three ways:

1. **Overloaded**: Separate implementations for each type (e.g., `Int`, `Char`).
2. **Fully Polymorphic**: Works for any type but can be unsafe.
    

def member[T](a: T, as: List[T]): Boolean = as.contains(a)

````
This approach allows equality on types where it may not make sense, such as functions.
3. **Constrained Polymorphic**: Equality is defined only for specific types using typeclasses (explored below).

---

## Typeclasses

### Qualified Types and Constrained Polymorphism
Typeclasses address the limitations of overloading by introducing **qualified types**. A qualified type constrains type variables to specific families of types.

For example, a typeclass for equality (`Eq`) can constrain type variables to types that admit equality.
```text
[T : Eq] ⇒ T → T → Bool
````

Here, `Eq` is a typeclass, and the type variable `T` must be an instance of `Eq`.

### Haskell Typeclasses

Haskell pioneered typeclasses as a mechanism for ad-hoc polymorphism. For instance:

```haskell
class Eq a where
  (==) :: a -> a -> Bool
```

This defines a typeclass `Eq` with a member function `==` for equality.

#### Example Instances:

```haskell
instance Eq Int where
  x == y = primEqInt x y

instance Eq Char where
  x == y = ord x == ord y

instance Eq a => Eq [a] where
  [] == [] = True
  (x:xs) == (y:ys) = x == y && xs == ys
```

Here:

1. `Eq Int` defines equality for integers.
2. `Eq Char` relies on character codes.
3. `Eq [a]` recursively defines equality for lists of elements where `a` is an `Eq` instance.

---

## Typeclasses in Scala

Scala realizes typeclasses through implicit parameters and traits.

### Example: Equality Typeclass

```scala
trait Eq[A] {
  def eq(a: A, b: A): Boolean
}

object EqInstances {
  implicit val intEq: Eq[Int] = new Eq[Int] {
    def eq(a: Int, b: Int): Boolean = a == b
  }

  implicit val stringEq: Eq[String] = new Eq[String] {
    def eq(a: String, b: String): Boolean = a == b
  }
}

object EqSyntax {
  implicit class EqOps[A](a: A) {
    def ===(b: A)(implicit eq: Eq[A]): Boolean = eq.eq(a, b)
  }
}

import EqInstances._
import EqSyntax._

println(3 === 3)         // true
println("hello" === "hi") // false
```

Here:

1. `Eq[A]` defines the equality typeclass.
2. `EqInstances` provides instances for `Int` and `String`.
3. `EqSyntax` introduces an extension method `===` that uses implicit resolution to find the correct `Eq` instance.

---

## Overloading vs Typeclasses vs OOP

### Overloading

- Static resolution.
- Fixed implementations at compile time.

### Typeclasses

- Flexible and extensible.
- New instances can be introduced without modifying existing code.

### Object-Oriented Programming (OOP)

- Dynamic dispatch at runtime.
- Methods are bound to objects through inheritance.

#### Comparison Example

Consider a function that depends on an operation `op`:

- **Overloading**:
    

def op(x: Int): Int = x + 1 def op(x: Double): Double = x + 1.0

````
- **Typeclasses**:
```scala
trait Op[A] {
def op(a: A): A
}

implicit val intOp: Op[Int] = (a: Int) => a + 1
implicit val doubleOp: Op[Double] = (a: Double) => a + 1.0

def operate[A](a: A)(implicit op: Op[A]): A = op.op(a)

operate(3)      // 4
operate(3.14)   // 4.14
````

- **OOP**:
    

trait Op { def op: Any }

class IntOp(val x: Int) extends Op { def op: Int = x + 1 }

val result = new IntOp(3).op

```

---

## Exercises

### Exercise 1: Overloading
Write overloaded versions of a `square` function for `Int`, `Double`, and `Float`.

### Exercise 2: Typeclasses
1. Define a `Show` typeclass for string representation.
2. Implement instances for `Int` and a custom `Person` class.
3. Add syntax for `show` as an extension method.

### Exercise 3: Comparing Approaches
Implement a `min` function using:
1. Overloading.
2. Typeclasses.
3. OOP with a `Comparable` trait.

---

**REFERENCES AND CREDITS**: This lecture is based on “How to make ad-hoc polymorphism less ad hoc” by Philip Wadler and Stephen Blott, POPL 1989.  
[Further Reading](https://dl.acm.org/doi/pdf/10.1145/75277.75283).

```