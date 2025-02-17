# 9. ADTs in Programming Languages

**ADVANCED PROGRAMMING LANGUAGES**  
Fall 2024, CM 0632. MSc in Computer Science and Information Technology, Ca’ Foscari University of Venice

## ADTs in Programming Languages

We complete the discussion on algebraic data types (ADTs) with a deeper dive into their implementation in different programming languages.

---

## Nominal vs Structural Type Systems

So far, we have adopted a purely **structural presentation** for datatypes, which introduces new type expressions based on their structure. However, programming languages often adopt **nominal typing**, where each compound type must be explicitly introduced by a **declaration**.

### Key Differences

1. **Nominal Type Systems**:
    
    - Types must be explicitly declared and referred to by name.
    - Each type name can only be declared once.
    - Run-time type tags are often associated with objects for testing, printing, and marshaling.
    - Recursive types are straightforward to define.
2. **Structural Type Systems**:
    
    - Types are defined by their structure.
    - No explicit declarations are required.
    - Recursive types are handled using recursive operators (e.g., μ or fix operators).

**Example Comparison**:

```text
IntPair  = {fst: Int, snd: Int}     // Structural Type
Address  = {city: String, street: String, number: Int}  
```

---

## Structural Typing in SML

**Standard ML (SML)** is an early functional language that adopts a purely structural type system.

- Record types in SML are structural, meaning types are interchangeable if their structure matches.
- Type aliases are optional and purely for readability.

**Examples**:

```sml
type IntPair = {fst: Int, snd: Int}  
val p1 : IntPair = {fst = 2, snd = 3}
val p2 : {snd: Int, fst: Int} = p1   // Valid due to structural typing
```

In the above example, `IntPair` is a shorthand for `{fst: Int, snd: Int}`. Since the structure matches, `p2` can accept `p1`.

---

## Nominal Typing in Haskell

**Haskell** adopts nominal typing, where types are declared explicitly using `data` declarations.

### Record Types

Haskell allows the definition of product types with **named fields**:

```haskell
data Pair = Pair { fst :: Int, snd :: Int }
data Address = Addr { city :: String, street :: String, number :: Int }

let p = Pair { fst = 5, snd = 3 }
let a = Addr { city = "Boston", street = "Worcester", number = 15 }
```

- `data` introduces a new type (`Pair` and `Address`).
- Data constructors (`Pair` and `Addr`) are used to build values of the respective types.
- Field labels (`fst`, `city`, etc.) are unique to the type.

### Variant Types

Variant types in Haskell allow defining **disjoint unions**:

```haskell
type Radius = Double
type Side = Double

data Shape = Circle Radius | Rectangle Side Side
data IntList = Empty | Cons Int IntList
```

- `Shape` is a variant type with two constructors: `Circle` and `Rectangle`.
- `IntList` is a recursive type representing lists of integers.

**Examples**:

```haskell
let a_circle = Circle 3.0
let a_list = Cons 5 (Cons 3 (Cons 4 Empty))
```

---

## Nominal Typing in Scala

**Scala** adopts a nominal approach for ADTs using **case classes** and **enumerations**.

### Record Types: Case Classes

Case classes are special classes with:

1. Automatically generated constructors.
2. Structural equality (instances are compared by value).
3. Built-in support for **pattern matching**.

**Example**:

```scala
case class Pair(fst: Int, snd: Int)
case class Address(city: String, street: String, number: Int)

val p = Pair(5, 3)
val a = Address("Boston", "Worcester", 15)
```

### Variant Types: Enums

Scala defines variant types using **enums** or systems of case classes.

**Using Enums**:

```scala
enum Shape:
  case Circle(radius: Double)
  case Rectangle(width: Double, height: Double)

enum IntList:
  case Empty
  case Cons(head: Int, tail: IntList)

val a_circle: Shape = Shape.Circle(3.0)
val a_list: IntList = IntList.Cons(5, IntList.Cons(3, IntList.Empty))
```

**Pattern Matching** in Scala simplifies working with ADTs:

```scala
def area(s: Shape): Double = s match {
  case Shape.Circle(r) => Math.PI * r * r
  case Shape.Rectangle(b, h) => b * h
}
```

Scala enums are syntactic sugar for case classes. They simplify variant type declarations while maintaining nominal typing.

---

## Object-Oriented Presentation in Scala

ADTs in Scala can also be represented using **traits** and **case classes** in an object-oriented style.

**Example**:

```scala
sealed trait Shape:
  def area: Double
  def scale(f: Double): Shape

case class Circle(radius: Double) extends Shape:
  def area: Double = Math.PI * radius * radius
  def scale(f: Double): Shape = Circle(radius * f)

case class Rectangle(base: Double, height: Double) extends Shape:
  def area: Double = base * height
  def scale(f: Double): Shape = Rectangle(base * f, height * f)
```

- The `sealed` keyword ensures that `Shape` cannot be extended outside the file.
- The object-oriented style combines data definitions and behavior (e.g., `area` and `scale` methods).

---

## Exercises

### Exercise 1: Compound Datatypes in Rust

Explore how ADTs are implemented in Rust:

1. How are **records** and **variants** represented in Rust?
2. How is **pattern matching** implemented?
3. Does Rust use a nominal or structural approach to typing?

### Exercise 2: Lambda Calculus Representation in Scala

Implement the abstract syntax of the Lambda Calculus using Scala. Define:

- A type `Lambda` representing variables, abstraction, and application.
- Hint: Use enums or case classes for representation.

### Exercise 3: Lambda Calculus Reduction

Write functions to simulate the reduction relation for the Lambda Calculus:

1. `fv`: Compute the free variables of a term.
2. `subst`: Substitute a variable with a term.
3. `reduce`: Perform beta-reduction.

### Exercise 4: Lambda Calculus Typing

Write a function `typecheck` to implement the typing relation for the Lambda Calculus:

- Input: Typing context, term.
- Output: Type of the term.

---

**CREDITS**: The discussion on nominal vs structural typing is taken from Chapter 19.3 of Prof. Benjamin Pierce’s _Types and Programming Languages_, MIT Press, 2001.  
The Scala examples are adapted from _Programming in Scala_ (5th Edition) by M. Odersky, L. Spoon, B. Venners, and F. Sommers, Artima Press, 2021.  
[Further Reading](https://www.cis.upenn.edu/~bcpierce/tapl/).