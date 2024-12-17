# Applied Probability for Computer Science

**Instructor**: Isadora Antoniano-Villalobos  
**Email**: [isadora.antoniano@unive.it](mailto:isadora.antoniano@unive.it)  
**Course**: Master in Computer Science, Ca’ Foscari University of Venice (2023/2024)

---

## Key Concepts

### 1. Central Limit Theorem (CLT)
- For \( S_n = X_1 + X_2 + \dots + X_n \) where \( X_i \) are i.i.d:
  - \( E[S_n] = n\mu \), \( Var[S_n] = n\sigma^2 \).
  - \( S_n / n \) converges to the mean \( \mu \) as \( n \to \infty \).
  - \( S_n / \sqrt{n} \) follows a normal distribution for large \( n \).
- **Applications**:
  - Normal approximation to Binomial: \( S_n \sim N(np, np(1-p)) \) for large \( n \).

---

### 2. Law of Large Numbers (LLN)
- **Definition**:
  - For \( X_1, X_2, \dots, X_n \) i.i.d, the sample mean \( \bar{X} = S_n / n \) converges to the true mean \( \mu \) as \( n \to \infty \).

---

### 3. Stochastic Processes
- **Definition**:
  - A collection of random variables \( X(t) \) indexed by \( t \in T \) (time).
  - Two perspectives:
    1. Fix \( t \): Random variable \( X(t) \).
    2. Fix \( \omega \): Realization or trajectory \( X_\omega(t) \).

---

## Types of Stochastic Processes
1. **Continuous-Time, Continuous-Space**:
   - Examples: Stock prices, phase-shift keying in communication.
2. **Continuous-Time, Discrete-Space**:
   - Example: Number of users on a server at time \( t \).
3. **Discrete-Time, Continuous-Space**:
   - Example: Time taken for print jobs.
4. **Discrete-Time, Discrete-Space**:
   - Example: Number of pages in print jobs.

---

## Properties of Stochastic Processes

### Mean and Variance Functions
- For \( X(t) \):
  - \( \mu_X(t) = E[X(t)] \).
  - \( \sigma_X^2(t) = Var[X(t)] \).

---

### Autocovariance Function
- \( C_{XX}(t, s) = Cov[X(t), X(s)] \):
  - Measures the relationship between \( X(t) \) and \( X(s) \).
  - \( C_{XX}(t, s) > 0 \): Positive correlation.
  - \( C_{XX}(t, s) < 0 \): Negative correlation.
  - \( C_{XX}(t, s) = 0 \): No linear relationship, but not necessarily independence.

---

### Stationarity
- **Strict Stationarity**:
  - Joint distribution of \( X(t_1), X(t_2), \dots \) is time-invariant.
- **Weak Stationarity**:
  - Mean and autocovariance depend only on time differences \( \tau = |t-s| \).

---

### Markov Processes
- **Definition**:
  - Future depends only on the present, not the past:
    - \( P[\text{Future} | \text{Past, Present}] = P[\text{Future} | \text{Present}] \).
- **Examples**:
  - **Markov**: Number of internet connections.
  - **Non-Markov**: Stock prices (depend on trends in the past).
- **Markov Chains**:
  - Discrete-space processes satisfying the Markov property.
  - Focus: Continuous-Time Markov Chains (CTMC).

---

This summary highlights the essential points from the lecture, optimized for review and quick reference. Let me know if you need further refinements!
