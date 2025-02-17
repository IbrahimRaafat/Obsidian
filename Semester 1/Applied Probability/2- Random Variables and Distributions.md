# Applied Probability for Computer Science

**Instructor**: Isadora Antoniano-Villalobos  
**Email**: [isadora.antoniano@unive.it](mailto:isadora.antoniano@unive.it)  
**Course**: Master in Computer Science, Ca’ Foscari University of Venice (2023/2024)

---

## Key Concepts

### 1. Equally Likely Outcomes
- Probability for equally likely outcomes:
  \( P[\{\omega_i\}] = \frac{1}{n} \), where \( \Omega = \{\omega_1, \dots, \omega_n\} \).
- For any event \( E \subset \Omega \):  
  \( P[E] = \frac{|E|}{|\Omega|} \).

---

### 2. Random Variables
- **Definition**:
  - Domain: Sample space (\( \Omega \)).
  - Range/Support: Possible values (\( R, N, (0, \infty), (0, 1) \)).
- Types:
  1. **Discrete**: Takes a finite or countable number of values.
  2. **Continuous**: Has uncountable support; uses a probability density function (pdf).

---

### 3. Probability Distributions
- **Discrete Random Variables**:
  - Probability mass function (pmf): \( P(X = x) \geq 0 \), \( \sum_x P(X = x) = 1 \).
  - Example: Tossing 3 fair coins, \( X \): Number of heads.
- **Continuous Random Variables**:
  - Probability density function (pdf): \( f(x) \geq 0 \), \( \int_{-\infty}^\infty f(x) dx = 1 \).
  - \( P[X \in A] = \int_A f(x) dx \).
- Cumulative Distribution Function (cdf):
  - \( F(x) = P[X \leq x] \), non-decreasing, \( F(-\infty) = 0, F(\infty) = 1 \).

---

### 4. Joint Distributions
- For vectors \( (X, Y) \):
  - Joint pmf/pdf: \( P(x, y) = P[(X, Y) = (x, y)] \).
  - Independence (Continuous): \( f_{X,Y}(x, y) = f_X(x)f_Y(y) \).

---

## Properties of Distributions

### 1. Expectation (Mean)
- **Discrete**: \( E[X] = \sum_x xP(X = x) \).
- **Continuous**: \( E[X] = \int_{-\infty}^\infty xf(x) dx \).
- **Interpretation**: Center of gravity of the distribution.
- For \( Y = g(X) \):
  - \( E[g(X)] = \sum_x g(x)P(X = x) \) (discrete).
  - \( E[g(X)] = \int g(x)f(x) dx \) (continuous).

---

### 2. Variance and Standard Deviation
- Variance: \( \text{Var}[X] = E[X^2] - (E[X])^2 \).
- Standard deviation (\( \sigma \)): Square root of variance.

---

### 3. Covariance and Correlation
- Covariance: Measures dependence between \( X \) and \( Y \).
  - \( \text{Cov}[X, Y] = E[(X - \mu_X)(Y - \mu_Y)] \).
- Correlation (\( \rho \)):
  - \( |\rho| = 1 \): Perfect correlation (positively or negatively).
  - If \( X \) and \( Y \) are independent, \( \text{Cov}[X, Y] = 0 \) (but the converse isn't true).

---

### 4. Chebyshev’s Inequality
- Bounds the range of values a random variable can take:
  - \( P[|X - \mu| \geq \epsilon] \leq \frac{\sigma^2}{\epsilon^2} \).
- Larger variance increases the likelihood of extreme values.

---

## Suggested Readings
- Baron Textbook:
  - Chapter 3: Discrete Random Variables and Their Distributions.
  - Chapter 4: Continuous Distributions.

---

This summary is optimized for quick reference and review. Let me know if additional details are needed!
