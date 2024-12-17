# 22. Function Subtyping

**ADVANCED PROGRAMMING LANGUAGES**  
Fall 2024, CM 0632. MSc in Computer Science and Information Technology, Ca’ Foscari University of Venice

## Function Subtyping

In this lecture, we explore **function subtyping**, an essential concept in type systems for programming languages. Function subtyping introduces rules for when a function type `A → B` can be considered a subtype of another function type `A' → B'`.

Subtyping for functions must respect both the **input types** (domain) and the **output types** (codomain). This leads to a combination of **contravariance** for input types and **covariance** for output types.

---

## Function Types and Subtyping

A function type `A → B` consists of:

1. An **input type** `A` (domain)
2. An **output type** `B` (codomain)

The subtyping rule for function types is as follows:

```text
(S-Arrow)
A' ≤ A    B ≤ B'
----------------
A → B ≤ A' → B'
```

### Key Points:

- The input type `A` is **contravariant**: `A' ≤ A`.
- The output type `B` is **covariant**: `B ≤ B'`.

---

## Intuition Behind Function Subtyping

The rules for function subtyping may seem unintuitive at first glance, particularly the **contravariance** of the input types. Let’s explore why this rule ensures type safety.

### Contravariant Input Types

If a function `f` has type `A → B`:

- `A` represents the type of values that `f` can accept.
- A **subtype** `A' → B'` must accept at least as many values as `A → B`. This means that the input type `A'` must be **more general** (a supertype of `A`).

#### Example:

Suppose we have:

```scala
def f: Animal => Int
```

If `f` is used where a `Dog => Int` function is expected, this would be **unsound** because `f` may not handle all `Dog` inputs correctly. Thus, the input type must be contravariant.

### Covariant Output Types

If a function `f` has type `A → B`:

- `B` represents the type of values returned by `f`.
- A **subtype** `A' → B'` must produce values that can safely be used wherever values of type `B` are expected. This means that the output type `B'` must be **more specific** (a subtype of `B`).

#### Example:

Suppose we have:

```scala
def f: Animal => Dog
```

If `f` is used where an `Animal => Animal` function is expected, this is perfectly safe because `Dog` is a subtype of `Animal`. Thus, the output type must be covariant.

---

## Function Subtyping in Practice

### Scala Example

In Scala, function types respect the subtyping rule:

```scala
class Animal
class Dog extends Animal
class Puppy extends Dog

val f: Dog => Animal = (d: Dog) => new Animal
val g: Animal => Puppy = (a: Animal) => new Puppy

val h: Dog => Puppy = g  // Valid: contravariant input and covariant output
```

Here:

1. `g` has type `Animal => Puppy`.
2. `Dog => Puppy` is a subtype of `Animal => Puppy` because:
    - The input type `Dog` is more specific (contravariant).
    - The output type `Puppy` is more specific (covariant).

---

## Function Subtyping in Object-Oriented Languages

### Java Example

In Java, function subtyping is not directly supported, but similar principles apply when overriding methods.

#### Example:

```java
class Animal {}
class Dog extends Animal {}
class Puppy extends Dog {}

interface AnimalHandler {
    Animal handle(Dog d);
}

class PuppyHandler implements AnimalHandler {
    @Override
    public Puppy handle(Animal a) { return new Puppy(); }
}
```

This code would fail because Java does not allow contravariant inputs when overriding methods. Java restricts overriding to use the **exact** input types.

### Wildcards

To achieve function subtyping in Java, wildcards (`? super T` and `? extends T`) are used:

```java
Consumer<? super Dog> dogHandler = (Dog d) -> System.out.println("Handling a dog");
Function<Animal, ? extends Puppy> puppyFunction = (Animal a) -> new Puppy();
```

---

## Type Safety and Function Subtyping

Function subtyping preserves type safety in two ways:

1. **Contravariant inputs** ensure that a function can accept all values expected by its supertype.
2. **Covariant outputs** ensure that a function produces values that are compatible with the expected output type.

Without these rules, type errors could occur at runtime.

---

## Exercises

### Exercise 1: Subtyping Relationships

Given the types:

- `A`, `B`, `C`, where `A <: B <: C`
- `X`, `Y`, `Z`, where `Z <: Y <: X`

Determine the subtype relationships between the following function types:

1. `A → Z` and `B → Y`
2. `C → X` and `A → Z`
3. `B → Z` and `B → X`

### Exercise 2: Contravariance and Covariance

1. Explain why input types are contravariant and output types are covariant.
2. Write a Scala function demonstrating function subtyping using contravariant inputs and covariant outputs.

### Exercise 3: Function Subtyping in Java

Implement a Java interface and two classes to illustrate function subtyping using wildcards (`? super T` and `? extends T`).

---

**REFERENCES AND CREDITS**: This lecture is adapted from standard material on function subtyping, including _Types and Programming Languages_ by Benjamin Pierce and Scala documentation.  
[Further Reading](https://www.typescriptlang.org/docs/handbook/type-compatibility.html).