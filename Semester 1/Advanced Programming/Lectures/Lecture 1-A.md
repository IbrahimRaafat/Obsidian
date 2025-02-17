# 1-A. Introduction

## ADVANCED PROGRAMMING LANGUAGES  
Fall 2024, CM 0632. MSc in Computer Science and Information Technology, Ca’ Foscari University of Venice

### Introduction  
The course offers an in-depth analysis of the advanced concepts and techniques of modern programming languages together with an introduction to the foundational tools from programming language theory and type theoretic frameworks available to reason about and assess their design.

We will look at the principles underpinning the functional, object-oriented, and concurrent paradigms, with a specific focus on functional language features and functional programming style, and analyze their practice and implementation in mainstream programming languages.

Most of the development will focus on **Scala**, but we will draw also from other statically typed languages such as ML, Haskell, and Java as well as, occasionally, on dynamically typed languages like Python.

We start with an overview of the history and evolution of programming languages.

---

## Programming Language Evolution  
The earliest programming languages were developed with one simple goal in mind: to provide a vehicle through which one could control the behavior of computers. Not surprisingly, the early languages reflected the structure of the underlying machines fairly well.

Although at first blush that goal seems eminently reasonable, the viewpoint quickly changed for two very good reasons:

1. It became obvious that what was easy for a machine to compute was not necessarily easy for a human being to reason about.  
2. As the number of different kinds of machines increased, the need arose for a common language with which to program all of them.

From primitive assembly languages (a step up from raw machine code) grew a plethora of high-level programming languages, beginning with **FORTRAN** in the 1950s.

---

## Question: Who knows from which movie is this picture taken?  
**Answer:**  

---

The programming languages that followed FORTRAN and its success are best classified according to **paradigms**. These emerged around the 1970s–1980s with the advent of languages like **C, Simula, Smalltalk, ML, and Prolog**. These paradigms include:

- **Imperative**
- **Declarative** (Functional, Logical)
- **Object-Oriented**

The development of such paradigms was driven by the desire to find appropriate abstractions to express algorithms, encode and manipulate data structures in a principled way, and provide effective (formal) tools to reason about computations and program behavior.

The following picture (from [Reddit](https://www.reddit.com)) gives a sense of the extent of the diversity of paradigms and different languages created over time.  

---

## Technological Drivers Powering Programming Language Evolution  

### The Case of Object-Oriented Programming (OOP)  
In his renowned paper, *“The Free Lunch Is Over”*, Herb Sutter recalls that even though OOP was introduced back in the 1960s, object-orientation didn’t become popular until the 1990s:  

> "When the industry was driven by requirements to write larger and larger systems and OOP’s strengths in abstraction and dependency management made it a necessity for achieving large-scale software development that is economical, reliable, and repeatable."

It was the development of **Graphical User Interfaces (GUIs)** that popularized object-oriented programming, transitioning it from academia into mainstream applications.

[Read more](https://www.cs.utexas.edu/~lin/cs380p/Free_Lunch.pdf)  

---

## Catalysts for Change  

### Internet and the Web  
The advent of the **Internet** shifted programming language goals from **efficiency** to **portability and security**. This scenario gave rise to Java with its **JVM** (virtual machine bytecode).

The web also brought the popularity of **scripting languages** like **PHP, JavaScript, Python, and Ruby**. These languages offered:

- High-level declarative models enhancing productivity and prototyping.  
- Conciseness compared to strongly typed languages like **Java** or **C#**.  

---

### Multi-Core Hardware  
The emergence of **multi-core hardware** emphasized concurrent programming. Moore’s law remains valid because of advances like:

- CPU hyper-threading (many threads in a CPU)  
- Multi-core processors (many CPUs on a chip)

This shift has renewed interest in **functional programming languages** like Haskell, F#, and Scala due to their compatibility with parallel execution.

> **Side Note:**  
> Parallel and concurrent computing are distinct concepts:  
> - **Parallel computing** involves simultaneous computations on parallel hardware.  
> - **Concurrent computing** refers to computations that may execute in parallel or interleave on sequential hardware.

---

### Distributed and Cloud Computing  
The rise of **cloud computing** powered distributed programming. This shift led to the use of:

- **Sockets, RPCs**, and **RMI** in client-server systems.  
- Scalable, heterogeneous architectures for cloud-based applications.  

**Golang**, introduced by Google in 2007, is an example of a language designed to meet these technological challenges.

---

### Big Data  
Current trends in **AI and Big Data** require:  

- High-performance, **data-parallel processing**.  
- Programming abstractions for **scale-out computations** on parallel hardware.  

**X10**, developed by IBM, addresses these needs with its **place abstraction**, representing virtual computational nodes mapped to hardware processors.

**MapReduce** frameworks like **Apache Hadoop** and **Spark** offer further abstractions for big data applications, inspired by functional programming combinators like **map** and **reduce**.

---

## Credits  
The material on the technological drivers of programming language evolution is based on the paper [*An Evolutionary View of Programming Languages Abstractions*](https://arxiv.org/pdf/1507.07719.pdf) by Silvia Crafa.
