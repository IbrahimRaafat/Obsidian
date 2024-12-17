# Formal Methods for System Verification: Structured Operational Semantics (SOS)

## Passive Activities
- **Definition:** A component is passive with respect to an action type if its activity rate is unspecified (\( > \)).
- **Behavior:**
  - The rate of shared activities is determined by cooperating components.
  - Incomplete models have passive components without shared activities.
- **Example:** Passive component with action type \( \alpha \):
  - Behaves as \( P \) with probability \( \frac{w_1}{w_1 + w_2} \).
  - Behaves as \( Q \) with probability \( \frac{w_2}{w_1 + w_2} \).
  - Represented as \( (\alpha, w_1>).P + (\alpha, w_2>).Q \).

---

## Apparent Rate
- **Definition:** Total rate at which a component performs activities of a specific type (\( \alpha \)).
- **Rules:**
  - \( r_\alpha((\beta, r).P) = r \) if \( \beta = \alpha \), else \( 0 \).
  - \( r_\alpha(P + Q) = r_\alpha(P) + r_\alpha(Q) \).
  - \( r_\alpha(P/L) = r_\alpha(P) \) if \( \alpha \notin L \), else \( 0 \).
  - \( r_\alpha(P \|_L Q) = \min(r_\alpha(P), r_\alpha(Q)) \) if \( \alpha \in L \), otherwise \( r_\alpha(P) + r_\alpha(Q) \).

---

## Current Action Types
- **Definition:** The set of action types enabled by a component.
- **Rules:**
  - \( A((\alpha, r).P) = \{\alpha\} \).
  - \( A(P + Q) = A(P) \cup A(Q) \).
  - \( A(P/L) = A(P) \setminus L \cup \{\tau\} \) if \( A(P) \cap L \neq \emptyset \).

---

## Dynamic Behavior
- **Labelled Transition System:**
  - Nodes represent model states.
  - Arcs represent actions causing state transitions.
  - Transitions follow the semantic rules of the PEPA language.

---

## Structured Operational Semantics (SOS)
- **Framework:** Plotkin-style "small-step" semantics where each transition represents a passage of time.
- **Rules for Operators:**
  - **Prefix:** \( (\alpha, r).P \xrightarrow{(\alpha,r)} P \).
  - **Choice:** \( P + Q \xrightarrow{(\alpha,r)} P' \) if \( P \xrightarrow{(\alpha,r)} P' \).
  - **Cooperation:** For \( P \|_L Q \), shared activities require synchronization:
    - \( r = \min(r_\alpha(P), r_\alpha(Q)) \).
  - **Hiding:** \( P/L \xrightarrow{(\tau,r)} P'/L \) if \( \alpha \in L \).

---

## Multi-way Cooperation
- **Definition:** Cooperation among multiple components on shared activities.
- **Examples:**
  - Three-way synchronization: \( ((\alpha, r).P \|_\alpha (\alpha, s).Q) \|_\alpha (\alpha, t).R \).

---

## Derivatives and Derivation Graph
- **Derivatives:**
  - A derivative of \( P \) represents a reachable state of the system.
  - Derivative set \( ds(P) \): All states reachable from \( P \).
- **Derivation Graph:**
  - Directed multigraph with nodes as states (\( ds(P) \)) and arcs as transitions.

---

## Labelled Multi-Transition System
- **Definition:** A triple \( (S, T, \{t \to\}) \) where:
  - \( S \): Set of states.
  - \( T \): Set of transition labels.
  - \( t \to \): Multi-relation representing transitions.

---

**Reference:** Formal Methods for System Verification, Sabina Rossi
