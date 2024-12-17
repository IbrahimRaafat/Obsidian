# Applied Probability for Computer Science

**Instructor**: Isadora Antoniano-Villalobos  
**Email**: [isadora.antoniano@unive.it](mailto:isadora.antoniano@unive.it)  
**Course**: Master in Computer Science, Ca’ Foscari University of Venice (2023/2024)

---

## Key Concepts

### 1. Counting Processes
- **Definition**:
  - \( X(t) \in \mathbb{N} \), non-decreasing sample paths.
  - \( X(s) \leq X(t) \) for \( s \leq t \).
- Markov property applies: Transition probabilities depend on \( h \) (time increment) but not \( t \) (absolute time).

---

## Poisson Processes: 3 Definitions
1. **Definition 1**:
   - \( N(0) = 0 \).
   - Independent, stationary increments.
   - \( P[N(h) = 1] = \lambda h + o(h) \), \( P[N(h) \geq 2] = o(h) \).
2. **Definition 2**:
   - \( N(0) = 0 \).
   - Disjoint intervals have independent increments.
   - \( N(t+s) - N(s) \sim \text{Poisson}(\lambda t) \).
3. **Definition 3**:
   - \( N(0) = 0 \).
   - Interarrival times \( X_n = T_n - T_{n-1} \) are i.i.d. exponential \( \sim \text{Exp}(\lambda) \).

**Equivalence**: Definitions 1, 2, and 3 are mathematically equivalent.

---

### 2. Properties of the Poisson Process
- \( N(t) \sim \text{Poisson}(\lambda t) \).
- Interarrival times \( X_n \sim \text{Exp}(\lambda) \).
- Arrival times \( T_n = \sum_{i=1}^n X_i \sim \text{Gamma}(n, \lambda) \).
- Covariance:
  - \( \text{Cov}[N(t), N(s)] = \lambda \min(t, s) \).

---

## Key Operations on Poisson Processes

### 1. Superposition
- Combining independent Poisson processes \( N_1, N_2 \) with rates \( \lambda_1, \lambda_2 \):
  - \( N(t) = N_1(t) + N_2(t) \sim \text{Poisson}(\lambda_1 + \lambda_2) \).

### 2. Thinning
- Retaining arrivals with probability \( p \):
  - Resulting process \( \tilde{N} \sim \text{Poisson}(\lambda p) \).
  - Discarded arrivals form a separate Poisson process with rate \( \lambda(1-p) \).

---

## Examples
1. **Database Queries**:
   - Average arrival rate \( \lambda = 0.8 \) queries/sec.
   - Probability of exactly 1 query in the first second and 2 in the next 4 seconds:
     \( P = 0.075 \).

2. **Traffic Flow**:
   - Two roads feeding into a bridge with rates \( \lambda_1 = 10 \), \( \lambda_2 = 8 \).
   - Total process rate: \( \lambda = 18 \).
   - Probability of more than 100 vehicles in 5 minutes:
     \( P = 0.1349 \).

3. **Hospital Patients**:
   - Arrival rate \( \lambda = 15 \) patients/hour, 20% critical.
   - Probability of more than 10 critical patients in 4 hours:
     \( P = 0.6528 \).

---

## Poisson Process Simulation
- Paths are step functions, jumps occur at random times.
- Waiting times between jumps are exponentially distributed.
- **R Simulation File**: `L20-PoissonProcessSimulation.R` available on Moodle.

---

This summary condenses the main points of the lecture. Let me know if further adjustments are needed!
