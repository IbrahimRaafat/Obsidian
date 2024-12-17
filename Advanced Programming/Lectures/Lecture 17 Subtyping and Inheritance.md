# 17. Subtyping and Inheritance

**ADVANCED PROGRAMMING LANGUAGES**  
Fall 2024, CM 0632. MSc in Computer Science and Information Technology, Ca’ Foscari University of Venice

## Subtyping and Inheritance

	In our last lecture, we observed that **subtyping** and **inheritance** are strongly related in nominal typing systems. More generally, they serve two very different purposes, associated with code-reuse mechanisms in object-oriented languages:

1. **Inheritance** and **class extension** enable reuse of implementation code:
    - Subclasses reuse unchanged fields and methods of the superclass.
2. **Subtyping** enables reuse of client code:
    - Clients can reuse existing code without changing it when new subtypes are added.

---

## Overriding and Dynamic Dispatch

A key mechanism enabling code reuse is **overriding**. It specializes behavior of methods while retaining parts of the original implementation. This is effective when combined with **dynamic dispatch**.

### Dynamic Dispatch

Dynamic dispatch ensures that a method call is resolved at runtime, based on the actual (dynamic) type of the object.

#### Example in Java:

```java
interface Shape {
    double area();
    Shape scale(double factor);
}

class Rectangle implements Shape {
    double base, height;
    Rectangle(double base, double height) {
        this.base = base; this.height = height;
    }
    public double area() { return base * height; }
    public Shape scale(double factor) {
        return new Rectangle(base * factor, height * factor);
    }
}

class Circle implements Shape {
    double radius;
    Circle(double radius) { this.radius = radius; }
    public double area() { return Math.PI * radius * radius; }
    public Shape scale(double factor) {
        return new Circle(radius * factor);
    }
}

static List<Double> area(List<Shape> shapes) {
    return shapes.map(s -> s.area());
}
```

Here, overriding ensures that calls to `area()` or `scale()` resolve dynamically to the appropriate subclass implementation.

---

## Java Interfaces and Default Methods

Java interfaces allow subtype-based code reuse through multiple interface implementation. Since Java 8, interfaces can include **default methods**, combining specifications with default behavior.

### Default Method Behavior:

- If a class overrides the method, the overridden implementation runs.
- If not, the default implementation in the interface is used.

#### Example:

```java
interface A {
    default void m() { System.out.println("Hi I’m interface A"); }
}

interface B {
    default void m() { System.out.println("Hi I’m interface B"); }
}

class C implements A, B {
    public void m() { A.super.m(); }  // Resolves ambiguity
}
```

Here, `C` resolves the conflict by explicitly referring to `A`'s implementation.

---

## Scala Traits

**Traits** in Scala generalize Java interfaces and provide flexible mechanisms for code reuse. They can:

1. Act as **specifications** (with abstract methods).
2. Serve as **class modifiers** (mixins adding behavior).

### Traits with Abstract and Concrete Methods

Traits can combine specifications with concrete methods:

```scala
sealed trait Shape {
    def area: Double
    def scale(f: Double): Shape
}

case class Circle(radius: Double) extends Shape {
    def area: Double = Math.PI * Math.pow(radius, 2)
    def scale(f: Double): Shape = Circle(radius * f)
}

case class Rectangle(base: Double, height: Double) extends Shape {
    def area: Double = base * height
    def scale(f: Double): Shape = Rectangle(base * f, height * f)
}
```

Here:

- `Shape` provides a shared specification for `area` and `scale`.
- Subclasses provide concrete implementations.

---

## Traits as Class Modifiers

Traits can modify or extend class behavior without inheritance:

```scala
abstract class Window(var p: Position, var s: Size) {
    def move(p: Position): Unit = this.p = p
    def resize(s: Size): Unit = this.s = s
}

trait MouseListener {
    def clickMouse: String = "Mouse clicked"
}

trait KeyListener {
    def typeKey(key: Char): String = s"Key $key typed"
}

class Button(label: String, p: Position, s: Size)
    extends Window(p, s) with MouseListener {
    override def clickMouse: String = s"Mouse clicked on $label"
}

val btn = new Button("Test", Position(50, 50), Size(10, 20))
println(btn.clickMouse)  // "Mouse clicked on Test"
```

Here:

- `MouseListener` and `KeyListener` are traits that provide reusable behavior.
- `Button` mixes in behavior dynamically.

---

## Linearization of Traits

When multiple traits are mixed in, Scala resolves method calls using **linearization**. The method invoked is determined by:

1. The **rightmost** trait in the mixin order.
2. Calls to `super` resolve to the next trait to the left.

#### Example:

```scala
trait A { def m(): String = "A" }
trait B extends A { override def m(): String = "B" }
trait C extends A { override def m(): String = "C" }

class D extends B with C
println((new D).m())  // "C"
```

Linearization resolves `m()` to `C`, as `C` is mixed in **after** `B`.

---

## Incremental Modification

Traits allow incremental modifications to classes:

```scala
abstract class Queue {
    def get(): Int
    def put(x: Int): Unit
}

trait Doubling extends Queue {
    abstract override def put(x: Int): Unit = super.put(2 * x)
}

class BasicQueue extends Queue {
    private val buf = scala.collection.mutable.ArrayBuffer[Int]()
    def get(): Int = buf.remove(0)
    def put(x: Int): Unit = buf += x
}

val queue = new BasicQueue with Doubling
queue.put(5)
println(queue.get())  // 10
```

Here:

- `Doubling` modifies the behavior of `put` without changing `BasicQueue`.

---

## Scala Type Hierarchy

Scala’s type hierarchy includes:

```text
Any
 |-- AnyVal (value types: Int, Boolean, Unit, etc.)
 |-- AnyRef (reference types: String, List, custom types)
  |-- Null
Nothing
```

- **Any**: The top type.
- **AnyVal**: Non-nullable value types.
- **AnyRef**: Reference types (equivalent to `Object` in Java).
- **Nothing**: The bottom type, subtype of all types.
- **Null**: Subtype of all reference types.

---

## Exercises

### Exercise 1: Java Default Methods

Write a Java program with two interfaces that include conflicting default methods. Resolve the conflict in a concrete class.

### Exercise 2: Scala Traits

1. Define a trait `Logging` that logs method calls.
2. Mix it into a `Calculator` class to log additions and subtractions.

### Exercise 3: Linearization

Given traits `A`, `B`, and `C` with methods overriding one another, determine the output for a concrete class mixing them in various orders.

---

**CREDITS**: Material adapted from Chapter 11 of _Programming in Scala_ by Martin Odersky, Lex Spoon, and Bill Venners.  
[Further Reading](https://docs.scala-lang.org/scala3/book/traits.html).