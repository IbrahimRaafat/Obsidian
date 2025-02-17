# Formal Methods for System Verification: Stochastic Models in PEPA

## Deriving Markov Processes from PEPA Models
- **Steps:**
  1. Use the derivation graph of a PEPA model to generate a CTMC.
  2. Nodes represent states, and arcs represent transitions.
  3. Transition rates are derived from the sum of activity rates for arcs between nodes.

---

## Key Definitions
- **Sojourn Time:** Time spent in a state, exponentially distributed with a mean of \( \left(\sum_{a \in Act(P)} r_a\right)^{-1} \).
- **Exit Rate (\( q(P) \)):** Rate at which the system leaves state \( P \), calculated as \( \sum_{a \in Act(P)} r_a \).
- **Transition Rate (\( q(P_i, P_j) \)):** Sum of activity rates for transitions from \( P_i \) to \( P_j \).
- **Conditional Transition Rate (\( q(P_i, P_j, \alpha) \)):** Rate for transitions of type \( \alpha \).
- **Transition Probability (\( Pr(P_i, P_j) \)):** \( \frac{q(P_i, P_j)}{q(P_i)} \).
- **Infinitesimal Generator Matrix (Q):**
  - Off-diagonal: \( q_{ij} = q(P_i, P_j) \).
  - Diagonal: \( q_{ii} = -\sum_{j \neq i} q_{ij} \).

---

## Steady State Analysis
- **Steady State Distribution:** Solved using \( \pi Q = 0 \), with \( \sum \pi(P_i) = 1 \).
- **Interpretation:** \( \pi(P_i) \) is the proportion of time the system spends in state \( P_i \).

---

## PEPA Models with Cyclic Components
- **Cyclic Component:** A PEPA model is cyclic if its states form a closed loop.
- **Conditions:**
  - The initial component is cyclic.
  - Choice combinators occur only at the lowest level of a cyclic component.

---

## Deriving Performance Measures
- **Reward-Based Measures:** Rewards \( \rho_i \) are associated with states. Total reward \( R = \sum_i \rho_i \pi(P_i) \).
- **Examples:**
  - **Utilization:** Total time a resource is used.
  - **Throughput:** Number of completed activities per unit time.

---

## Example 1: Resource Usage
- **PEPA Model:**
  - \( Process \def (use, r_1).Process' \), \( Process' \def (task, r_2).Process \).
  - \( Resource \def (use, r_3).Resource' \), \( Resource' \def (update, r_4).Resource \).
  - \( System \def Process \|_{\{use\}} Resource \).
- **CTMC States:**
  - \( X_0, X_1, X_2, X_3 \) represent the system's behavior.
- **Performance Measures:**
  - Utilization \( U_{res} = 60.98\% \).
  - Throughput \( T_{use} = 0.975 \).

---

## Example 2: Faulty Component with Repairman
- **PEPA Model:**
  - \( Comp \def (error, \epsilon).(repair, \rho).Comp + (task, \mu).Comp \).
  - \( Res \def (task, >).(reset, r).Res \).
  - \( Repman \def (repair, >).Repman \).
  - \( System \def ((Comp || Comp) \|_{\{task\}} Res) \|_{\{repair\}} Repman \).
- **CTMC:** Derived from the derivation graph.
- **Performance Measures:**
  - Utilization \( U_{res} = \pi_0 + \pi_2 + \pi_3 \).
  - Throughput \( T_{task} = 2\mu\pi_0 + \mu\pi_2 + \mu\pi_3 \).

**Reference:** Formal Methods for System Verification, Sabina Rossi
