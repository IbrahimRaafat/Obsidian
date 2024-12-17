# Formal Methods for System Verification: Continuous Time Markov Chains (CTMCs)

## Stochastic Processes
- **Definition:** A set of random variables \( \{X(t), t \in T\} \), where \( T \) is the parameter space (often time).
- **State Space:** Possible values of \( X(t) \), representing the states of the system.
- **Stationary Process:** The joint probability distribution does not change when shifted in time.
- **Markov Process:** Memoryless property where the future state depends only on the current state, not the past.

---

## Properties of Markov Processes
- **Time Homogeneous:** Transition probabilities depend only on time differences.
- **Irreducible:** All states are reachable from one another.
- **Positive Recurrent:** States are revisited infinitely often with finite expected return times (ergodic property).

---

## Continuous Time Markov Chains (CTMCs)
- **Transition Rate (\( q_{ij} \)):** Probability of moving from state \( x_i \) to \( x_j \) per unit time.
- **Sojourn Time:** Time spent in a state, exponentially distributed with mean \( 1/q_i \), where \( q_i = \sum_{j \neq i} q_{ij} \).
- **Infinitesimal Generator Matrix \( Q \):**
  - Diagonal entries: \( q_{ii} = -\sum_{j \neq i} q_{ij} \).
  - Off-diagonal entries: \( q_{ij} \), the transition rates.

---

## State Transition Diagrams
- Graphical representation of states and transitions.
- Nodes: States of the system.
- Arcs: Transition rates between states.
- Example: Mobile phone antenna states with transitions governed by \( \lambda \) (call arrivals) and \( \mu \) (call terminations).

---

## Steady-State Probability Distribution
- **Definition:** Long-term probabilities \( \pi_k \) where the system stabilizes.
- **Global Balance Equations:** \( \pi Q = 0 \) with \( \sum \pi_i = 1 \).
- **Solution Method:**
  - Transpose \( Q \) to form \( Q^T \).
  - Replace a row with normalization condition \( \sum \pi_i = 1 \).

---

## Example 1: Mobile Phone Antenna
- **State Space:** \( \{0, 1, 2, \dots, 6\} \).
- **Transitions:** New calls (\( \lambda \)) and terminated calls (\( \mu \)).
- **Steady-State Distribution:** Derived using global balance equations.

---

## Example 2: Single Processor System
- **States:**
  1. Processor executing in private memory.
  2. Processor accessing shared memory.
- **Generator Matrix:**
  \[
  Q = \begin{bmatrix}
  -\lambda & \lambda \\
  \mu & -\mu
  \end{bmatrix}
  \]
- **Steady-State Probabilities:** \( \pi = \left(\frac{\mu}{\mu + \lambda}, \frac{\lambda}{\mu + \lambda}\right) \).

---

## Example 3: Multi-Processor System
- **State Space:**
  1. Both processors in private memory.
  2. One processor in shared memory while the other waits or executes.
- **Generator Matrix:** Reflects different transition rates for each processor.
- **Steady-State Distribution:** Solved numerically for probabilities \( \pi \).

---

## Performance Measures
1. **State-Based Measures:**
   - Probability of being in a specific state or subset.
   - Example: Utilization \( U_{mem} = \pi_2 + \pi_3 + \pi_4 + \pi_5 \).
2. **Rate-Based Measures:**
   - Throughput: \( X_{mem} = (\mu_A (\pi_2 + \pi_4)) + (\mu_B (\pi_3 + \pi_5)) \).
3. **Other Measures:**
   - Response Time: \( W_{mem} = N_{mem} / X_{mem} \).

---

**Reference:** Formal Methods for System Verification, Sabina Rossi
