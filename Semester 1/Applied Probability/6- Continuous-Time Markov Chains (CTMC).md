# Applied Probability for Computer Science

**Instructor**: Isadora Antoniano-Villalobos  
**Email**: [isadora.antoniano@unive.it](mailto:isadora.antoniano@unive.it)  
**Course**: Master in Computer Science, Ca’ Foscari University of Venice (2023/2024)

---

## Key Concepts

### 1. Continuous-Time Markov Chains (CTMC)
- **Definition**:
  - \( X(t) \): Family of random variables with a countable state space \( S \).
  - **Markov Property**: Future states depend only on the present state.
  - Transition probabilities: \( P[X(t) = j | X(s) = i] = p_{ij}(s, t) \).

---

## Transition Semigroup
- **Homogeneous CTMC**:
  - Transition probabilities depend only on \( t - s \).
  - \( p_{ij}(s, t) = p_{ij}(0, t-s) \).
- **Transition Matrix \( P_t \)**:
  - \( P_0 = I \) (identity matrix).
  - Rows sum to 1: Stochastic matrix.
  - Follows Chapman-Kolmogorov equations: \( P_{s+t} = P_sP_t \).

---

### 2. Generator Matrix \( G \)
- **Definition**:
  - \( g_{ij} \): Instantaneous transition rates.
  - \( g_{ii} = -\sum_{j \neq i} g_{ij} \) (rows sum to 0).
- **Approximation**:
  - \( p_{ij}(h) \approx g_{ij}h \), \( p_{ii}(h) \approx 1 + g_{ii}h \) for small \( h \).
- **Relation**:
  - \( P_t = e^{tG} \), where \( e^{tG} \) is the matrix exponential.

---

## Examples of CTMCs

### 1. Birth Process
- Transition rates: \( g_{n, n+1} = \lambda_n \), \( g_{n, n} = -\lambda_n \).
- Special Case: Poisson process (\( \lambda_n = \lambda \)).

### 2. Birth-Death Process
- Transition rates:
  - Birth: \( g_{n, n+1} = \lambda_n \).
  - Death: \( g_{n, n-1} = \mu_n \).
  - Diagonal: \( g_{n, n} = -(\lambda_n + \mu_n) \).

---

## Stationary Distribution
- **Definition**:
  - \( \pi \): Long-term probabilities satisfying \( \pi^TG = 0 \).
- **Global Balance Equations**:
  - Flux out of state \( i \) equals flux into \( i \):  
    \( \pi_i \sum_{j \neq i} g_{ij} = \sum_{j \neq i} \pi_j g_{ji} \).
- **Calculation**:
  - For finite \( S \), solve \( \pi^TG = 0 \) with \( \sum_i \pi_i = 1 \).

---

## Simulation of CTMC
- **Algorithm**:
  1. Initialize at state \( i_0 \).
  2. Sample holding time \( U_i \sim \text{Exp}(-g_{ii}) \).
  3. Transition to state \( j \neq i \) with probability \( \tilde{p}_{ij} = g_{ij} / -g_{ii} \).
  4. Repeat until time \( T \) is reached.

- **Example in R**:
  ```r
  library(expm)
  G <- matrix(c(-4, 2, 2, 1, -2, 1, 0.5, 1, -1.5), ncol=3, byrow=TRUE)
  P_tilde <- -G / diag(G)
  diag(P_tilde) <- 0
