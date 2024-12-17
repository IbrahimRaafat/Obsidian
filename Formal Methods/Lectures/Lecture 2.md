# Formal Methods for System Verification: Key Notions of Probability Theory

## Key Concepts in Probability
- **Random Experiment:** Outcome cannot be determined in advance.
- **Sample Space (S):** Set of all possible outcomes of an experiment.
- **Event:** Subset of a sample space; occurs if the experiment's outcome is in the subset.

### Examples:
- **Flipping Two Coins:** Sample space: S = {(H,H), (H,T), (T,H), (T,T)}.
- **Tossing Two Dice:** Sample space: S = {(i,j): i,j = 1,...,6}.
- **Transistor Lifetime:** Sample space: S = {x: 0 ≤ x < ∞}.

## Probability Mapping
- Function \( Pr \) maps events to real numbers \( R \), satisfying:
  - \( 0 \leq Pr(A) \leq 1 \).
  - \( Pr(S) = 1 \).
  - \( Pr(A \cup B) = Pr(A) + Pr(B) \) for mutually exclusive events.

### Properties:
- Union of non-exclusive events: \( Pr(A \cup B) = Pr(A) + Pr(B) - Pr(A \cap B) \).
- Complement: \( Pr(\neg A) = 1 - Pr(A) \).

## Conditional Probability
- \( Pr(A|B) = \frac{Pr(A \cap B)}{Pr(B)} \).
- Events A and B are **independent** if \( Pr(A|B) = Pr(A) \) or \( Pr(A \cap B) = Pr(A) \cdot Pr(B) \).

### Example: Tossing Two Dice
- If A is the event "sum is 8" and B is "first die shows 3," then \( Pr(A|B) = \frac{1}{6} \).

## Random Variables
- A function mapping outcomes to real numbers.
- **Discrete Random Variable:** Takes on finite/countable values.
- **Continuous Random Variable:** Takes on uncountable values.

### Example: Discrete Variable
- **Flipping Three Coins:** Random variable Y = number of heads.

### Example: Continuous Variable
- **Transistor Lifetime:** Values from \( 0 \) to \( \infty \).

## Probability Functions
- **Discrete Variables:** Probability mass function (PMF): \( p_X(x) = Pr(X = x) \).
- **Continuous Variables:** Probability density function (PDF): \( f_X(x) \), with \( Pr(X \in A) = \int_A f_X(x) dx \).

## Mean and Variance
- **Expected Value (Mean):**
  - Discrete: \( E[X] = \sum x \cdot p_X(x) \).
  - Continuous: \( E[X] = \int_{-\infty}^\infty x \cdot f_X(x) dx \).
- **Variance:**
  - \( Var(X) = E[X^2] - (E[X])^2 \).

## Exponential Distribution
- PDF: \( f_X(x) = \lambda e^{-\lambda x} \) for \( x > 0 \).
- **Properties:**
  - Mean: \( \mu = \frac{1}{\lambda} \).
  - Variance: \( \sigma^2 = \frac{1}{\lambda^2} \).
  - Memoryless: \( Pr(T > t + s | T > t) = Pr(T > s) \).

### Example: Laptop Lifespan
- **Mean Lifespan:** \( \mu = 5 \) years → \( \lambda = 0.2 \).
- **Probability it lasts <3 years:** \( Pr(X < 3) = 1 - e^{-0.6} \approx 0.4512 \).

## Key Takeaways
- Probability theory is foundational for modeling randomness in systems.
- Random variables and their properties help quantify uncertainty.
- Exponential distribution is widely used for modeling time between events due to its memoryless property.

**Reference:** Formal Methods for System Verification, Sabina Rossi
