# Applied Probability for Computer Science

**Instructor**: Isadora Antoniano-Villalobos  
**Email**: [isadora.antoniano@unive.it](mailto:isadora.antoniano@unive.it)  
**Course**: Master in Computer Science, Ca’ Foscari University of Venice (2023/2024)

---

## Overview of Elementary Probability
- **Textbook Reference**:
  - *Baron*: Chapter 1 (panoramic view of probability).
  - Chapter 2 (course prerequisites).

---

## Key Concepts

### 1. Sample Space, Outcomes, and Events
- **Notation**:
  - \( \Omega \) or \( S \): Sample space.
  - \( \emptyset \): Empty set/event (\( \emptyset \subset \Omega \)).
  - \( A, B, E \): Events (\( E \subset \Omega \)).
  - \( \omega, s \): Individual outcomes (\( \omega \in \Omega \), \( \{\omega\} \subset \Omega \)).
  - \( P[E] \): Probability of event \( E \).
- **Example**: Rolling a die (\( \Omega = \{1, 2, 3, 4, 5, 6\} \)):
  - Outcomes: \( \{1\}, \{2\}, \dots \{6\} \).
  - Events: Even numbers, numbers less than 3, etc.

---

### 2. Sets and Set Operations
- **Operations**:
  - Complement: \( A^c \)
  - Union: \( A \cup B \)
  - Intersection: \( A \cap B \)
  - Difference: \( A \setminus B = A \cap B^c \)
- **De Morgan’s Laws**:
  - \( E_1 \cup \dots \cup E_n = \bar{E}_1 \cap \dots \cap \bar{E}_n \)
  - \( E_1 \cap \dots \cap E_n = \bar{E}_1 \cup \dots \cup \bar{E}_n \)
- **Partition of Sample Space**:
  - A collection of mutually exclusive, exhaustive events (\( \{B_1, B_2, \dots, B_k\} \)).
  - \( A = (A \cap B_1) \cup (A \cap B_2) \cup \dots (A \cap B_k) \).

---

### 3. Axiomatic Probability
- **Sigma-Algebra**:
  - Smallest: \( \{ \emptyset, \Omega \} \).
  - Largest: Power set \( 2^\Omega \) (for countable \( \Omega \)).
  - For uncountable \( \Omega \): Borel sigma-algebra (\( M = \mathcal{B} \)).
- **Rules**:
  - \( P[\emptyset] = 0 \).
  - \( P[A^c] = 1 - P[A] \).
  - \( P[A \cup B] = P[A] + P[B] - P[A \cap B] \).
  - Inclusion-Exclusion Formula and Bonferroni Inequalities.

---

### 4. Conditional Probability and Independence
- **Definitions**:
  - \( P[A|B] = \frac{P[A \cap B]}{P[B]} \).
  - Events \( A \) and \( B \) are independent if \( P[A|B] = P[A] \) or \( P[A \cap B] = P[A]P[B] \).
- **Example**: Reliability of a system with components operating independently.

---

### 5. Bayes Theorem
- **Formula**:
  - \( P[B|A] = \frac{P[A|B]P[B]}{P[A]} \), where:
    - \( P[A] = \sum_{j=1}^k P[A|B_j]P[B_j] \) (Law of Total Probability).
- **Example**: Diagnostics of computer programs with module error probabilities.

---

## Suggested Readings
- Baron Textbook:
  - Chapter 1: Overview of probability and statistics.
  - Chapter 2: Foundations of probability theory.

---

This summary provides a concise review of the lecture content, ready for your Obsidian vault. Let me know if you need additional customization!
