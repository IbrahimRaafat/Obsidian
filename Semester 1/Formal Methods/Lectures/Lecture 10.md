# Formal Methods for System Verification: Strong Equivalence in PEPA Models

## Equivalence Between Models
- **Definition:** Determines if two models can be considered indistinguishable in behavior.
- **Key Concept:** Bisimulation — a formally defined equivalence based on labeled transition systems.

---

## Bisimulation
- **Intuition:** Two agents are bisimilar if their externally observable behavior is identical.
- **Definition:** Two agents \( P, Q \) are strongly bisimilar if:
  1. For every transition \( P \xrightarrow{\alpha} P' \), there exists \( Q \xrightarrow{\alpha} Q' \) such that \( P' \sim Q' \).
  2. For every transition \( Q \xrightarrow{\alpha} Q' \), there exists \( P \xrightarrow{\alpha} P' \) such that \( P' \sim Q' \).

---

## Applications of Equivalence
1. **Entity-to-Entity Equivalence:**
   - **System-to-Model:** Validates models as faithful representations of systems.
   - **Model-to-Model:** Simplifies or compares models.
   - **State-to-State:** Reduces complexity by aggregating equivalent states.
2. **Process Algebra:** Simplifies expressions by treating equivalent states as identical.

---

## Strong Equivalence in PEPA
- **Definition:** Two components are strongly equivalent if:
  1. They exhibit the same activities.
  2. Their derivatives are strongly equivalent.
  3. Their apparent rates for all action types are identical.
- **Conditional Transition Rate:**
  - \( q(P_i, P_j, \alpha) = \sum_{(a, r) \in Act(P_i)} r \), for transitions \( P_i \xrightarrow{\alpha} P_j \).

---

## Properties of Strong Equivalence
- **Congruence:** Preserved under all PEPA combinators:
  - \( a.P_1 \sim a.P_2 \).
  - \( P_1 + Q \sim P_2 + Q \).
  - \( P_1 \|_L Q \sim P_2 \|_L Q \).
  - \( P/L \sim Q/L \).
- **Recursive Definitions:** Preserves equivalence under substitutions.

---

## Examples
### Example 1: Behavioral Equivalence
- Two systems performing infinitely many \( a \)-actions are equivalent despite differing structures.

### Example 2: Vending Machines
- Distinguishes systems accepting different coin sequences despite similar outputs.

### Example 3: Deadlocks
- Bisimulation detects deadlocks where trace equivalence fails.

### Example 4: Strong Equivalence in PEPA
- Models \( P_0 = (a, \lambda).P_1 + (a, 2\lambda).P_2 \) and \( Q_0 = (a, 3\lambda).Q_1 \) are strongly equivalent under the relation:
  - \( R = \{(P_0, Q_0), (P_1, Q_1), (P_2, Q_1)\} \).

---

## Aggregation Using Strong Equivalence
- **Lumpable Partition:** Induced by equivalence classes on derivative sets.
- **Result:** Aggregated Markov chains are constructed with states corresponding to equivalence classes.

---

## Compositional Reasoning
- Simplifies proofs by leveraging congruence properties of strong equivalence.
- **Example:** \( S = (a, \alpha).P_0 + R \sim T = (a, \alpha).Q_0 + R \), where \( P_0 \sim Q_0 \).

---

**Reference:** Formal Methods for System Verification, Sabina Rossi
