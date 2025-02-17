# Applied Probability for Computer Science

**Instructor**: Isadora Antoniano-Villalobos  
**Email**: [isadora.antoniano@unive.it](mailto:isadora.antoniano@unive.it)  
**Course**: Master in Computer Science, Ca’ Foscari University of Venice (2023/2024)

---

## Overview of Common Distributions

### 1. Bernoulli Distribution
- **Definition**:
  - Single trial with success probability \( p \).
  - \( X \sim Bernoulli(p) \).
- **Mean**: \( E[X] = p \).  
- **Variance**: \( Var[X] = p(1 - p) \).

---

### 2. Binomial Distribution
- **Definition**:
  - Number of successes in \( n \) trials.
  - \( X \sim Binomial(n, p) \).
- **Properties**:
  - Mean: \( np \).
  - Variance: \( np(1 - p) \).
- **In R**:
  - `dbinom`, `pbinom`, `qbinom`, `rbinom`.

---

### 3. Multinomial Distribution
- **Definition**:
  - Generalization of binomial with \( k \) categories.
  - \( (X_1, \dots, X_k) \sim Multinomial(n, (p_1, \dots, p_k)) \).
- **Properties**:
  - \( E[X_i] = np_i \).
  - \( Var[X_i] = np_i(1 - p_i) \).
  - \( Cov[X_i, X_j] = -np_ip_j \) (\( i \neq j \)).

---

### 4. Geometric Distribution
- **Definition**:
  - Number of trials until the first success.
  - \( X \sim Geometric(p) \).
- **Memoryless Property**:
  - \( P[X > x + y | X > y] = P[X > x] \).
- **In R**:
  - `dgeom`, `pgeom`, `qgeom`, `rgeom`.

---

### 5. Hypergeometric Distribution
- **Definition**:
  - Number of successes in \( n \) draws without replacement.
  - \( X \sim Hypergeometric(M, N, n) \).
- **In R**:
  - `dhyper`, `phyper`, `qhyper`, `rhyper`.

---

### 6. Negative Binomial Distribution
- **Definition**:
  - Number of trials until \( k \) successes.
  - \( X \sim NB(k, p) \).
- **In R**:
  - `dnbinom`, `pnbinom`, `qnbinom`, `rnbinom`.

---

### 7. Uniform Distribution
- **Definition**:
  - Continuous distribution over \( (a, b) \).
  - \( X \sim U(a, b) \).
- **Standard Uniform**:
  - \( U(0, 1) \), \( f(x) = 1 \) for \( x \in (0, 1) \).
- **In R**:
  - `dunif`, `punif`, `qunif`, `runif`.

---

### 8. Normal Distribution
- **Definition**:
  - Symmetric, bell-shaped curve.
  - \( X \sim N(\mu, \sigma^2) \).
- **Standard Normal**:
  - \( Z \sim N(0, 1) \).
- **In R**:
  - `dnorm`, `pnorm`, `qnorm`, `rnorm`.

---

### 9. Poisson Distribution
- **Definition**:
  - Number of rare events in a fixed interval.
  - \( X \sim Poisson(\lambda) \).
- **Properties**:
  - \( E[X] = Var[X] = \lambda \).
- **Poisson Approximation**:
  - Approximates Binomial when \( n \) is large, \( p \) is small.
- **In R**:
  - `dpois`, `ppois`, `qpois`, `rpois`.

---

### 10. Exponential Distribution
- **Definition**:
  - Continuous distribution for time between events.
  - \( X \sim Exp(\lambda) \).
- **Memoryless Property**:
  - \( P[T > t + x | T > t] = P[T > x] \).
- **Relation to Poisson**:
  - Time between events in a Poisson process is exponential.
- **In R**:
  - `dexp`, `pexp`, `qexp`, `rexp`.

---

### 11. Gamma Distribution
- **Definition**:
  - Generalization of Exponential with \( \alpha \) steps.
  - \( X \sim Gamma(\alpha, \lambda) \).
- **In R**:
  - `dgamma`, `pgamma`, `qgamma`, `rgamma`.

---

This summary covers essential properties, formulas, and R functions for the common distributions discussed. Let me know if you need further details!
