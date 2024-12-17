# Core Aspects of Programming Language Design

**Course:** Advanced Programming Languages  
**Semester:** Fall 2024  
**Course Code:** CM 0632  
**Program:** MSc in Computer Science and Information Technology  
**University:** Ca’ Foscari University of Venice  

---

## Core Aspects of PL Design

Advances in technology have powered programming language (PL) evolution. However, PL design is anchored to core aspects and principles:

1. **Computation Model (Paradigm):** Imperative, Functional, Logical, Object-Oriented, Concurrent.
2. **Data Abstraction Mechanisms:** For data representation.
3. **Typing Discipline:** To support program development.
4. **Memory Management:** Efficient use of computing resources.

The first design decision is whether the computation model is **imperative** or not.

---

## Imperative Programming

### Key Characteristics
- Imperative languages resemble high-level versions of the von Neumann computer:
  - **CPU**
  - **Store**
  - **Bus** connecting CPU and store.
- Programs manipulate an implicit state using commands (e.g., `assignment statements`).
- Emphasizes **how** a computation is performed rather than **what** the result is.

### Example: Factorial Program (Imperative Style)
```java
n := x;
a := 1;
while n > 0 do
    begin
        a := a * n;
        n := n - 1;
    end;
```
**Invariant Condition:** { `a * n! == x!` }
## Functional Programming

### Key Concepts

- Computations are expressed as **function applications** and **function compositions**.
- Programs avoid implicit state; instead, they rely on:
    - **Substitution** (replacing formal parameters with actual arguments).
    - **Rewriting** expressions to compute the result.

### Example: Factorial Program (Functional Style)

**Direct Definition:**

``` scala
def fact(n: Int): Int = if (n <= 1) then 1 else n * fact(n - 1)`
```

Optimized Tail-Recursive Version:

``` scala
def fact(n: Int): Int = {
    def factorial(n: Int, acc: Int): Int =
        if (n <= 1) acc else factorial(n - 1, n * acc)
    factorial(n, 1)
}
```

### Functional Programming Style

- Key features:
    - **Higher-order functions**
    - **Pattern Matching**
    - **Data Abstraction** & **Polymorphism**
- Encourages modular, side-effect-free programming.
## Transition: Imperative to Functional Style

### Example: Finding the Maximum Age

**Imperative (Java):**

``` java
int maxAge = -1; for (Person p : people) if (p.getGender() == MALE && p.getAge() > maxAge) maxAge = p.getAge();
```

**Functional Style (Java Streams):**
``` java
final int maxAge = people.stream()
                         .filter(p -> p.getGender() == MALE)
                         .mapToInt(p -> p.getAge())
                         .max();
```

## Benefits of Functional Programming

### Referential Transparency (RT)

- **Definition:** An expression `e` is RT if it can be replaced with its result without changing program behavior.
- **Advantages:**
    - Simplified reasoning (substitution model).
    - Inherent modularity.
    - Enables parallel execution and optimizations.

### Example: RT in Scala

**Immutable Strings:**

``` scala
"abc".reverse == "abc".reverse // true
```
**Mutable StringBuilder:**

``` scala
y.append("d") == y.append("d") // false
```

## Why Study Functional Programming?

1. **Improved Thinking:**
    - Mainstream languages → focus on **state**.
    - Functional programming → focus on **values**.
2. **Relevance to Modern Research:** Cutting-edge developments use functional programming.
3. **Future-Proofing:** Minimizing state becomes crucial in multi-core and parallel computing.

---

## Credits & Further Reading

- **Credits:** Iterator example by Silvia Crafa; referential transparency adapted from _Functional Programming in Scala_.
- **Further Reading:**
    - Goldberg, _Functional Programming Languages_, ACM Computing Surveys.
    - Hudak, _Evolution of Functional Programming Languages_, ACM Computing Surveys.
    - [Functional Programming in Scala - Manning Publications](https://www.manning.com/books/functional-programming-in-scala-second-edition)