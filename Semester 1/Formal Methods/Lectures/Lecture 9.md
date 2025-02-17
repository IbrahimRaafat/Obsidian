# Formal Methods for System Verification: Tackling State Space Explosion in Markov Models

## State Space Explosion
- **Problem:** As the number of states in a Continuous Time Markov Chain (CTMC) increases, the size of the infinitesimal generator matrix \( Q \) and probability vector \( \pi \) becomes unmanageable.
- **Example:**
  - A system with \( N_P \) processors and \( N_R \) resources has \( 2^{N_P + N_R} \) states.
  - Example table of states:
    - \( N_P = 5, N_R = 5 \) → \( 1,048,576 \) states.

---

## Tackling State Space Explosion
- **Solution:** Aggregation through state-space reduction.
- **Method:** Group states into macro-states using equivalence relations, preserving the CTMC structure.

---

## Aggregation and Lumpability
- **Concept:** Aggregate states into equivalence classes, reducing the size of the state space while maintaining Markov properties.
- **Lumpability Conditions:**
  - **Strong Lumpability:** Ensures aggregated transition rates are consistent across equivalence classes.
  - **Exact Lumpability:** Aggregated rates into a class are the same for all states.
  - **Strict Lumpability:** Combines strong and exact lumpability.

---

## Aggregated CTMC
- **State Space:** Comprises equivalence classes \( S / \sim \), where \( \sim \) is the equivalence relation.
- **Infinitesimal Generator Matrix \( \tilde{Q} \):**
  - Transition rates \( q_{\tilde{k}\tilde{l}} \) computed using:
    \[
    q_{\tilde{k}\tilde{l}} = \frac{\sum_{i \in [k]} \pi_i q_{i[l]}}{\sum_{i \in [k]} \pi_i}
    \]
- **Equilibrium Distribution:** The steady-state probability of a macro-state is the sum of probabilities of its constituent states.

---

## Lumpability Types
1. **Strong Lumpability:**
   - Preserves Markov property.
   - Transition rates out of equivalence classes are identical.
2. **Exact Lumpability:**
   - Ensures equiprobability of states within equivalence classes in the steady state.
3. **Strict Lumpability:**
   - Combines properties of both strong and exact lumpability.

---

## Example 1: Strong Lumpability
- **CTMC:** Four states (\( S = \{1, 2, 3, 4\} \)).
- **Partition:** \( \{1, 3\}, \{2, 4\} \).
- **Result:** Strong lumpability exists but not exact lumpability.

---

## Example 2: Strict Lumpability
- **CTMC:** Five states (\( S = \{i_1, i_2, j_1, j_2, j_3\} \)).
- **Partition:** \( [i] = \{i_1, i_2\}, [j] = \{j_1, j_2, j_3\} \).
- **Result:** The equivalence relation is strictly lumpable.

---

## Performance with Aggregation
- **State Reduction:** Aggregation significantly reduces state space size while preserving performance insights.
- **Derived Measures:** Probabilities, rates, and rewards are calculated on aggregated models, saving computational resources.

**Reference:** Formal Methods for System Verification, Sabina Rossi
