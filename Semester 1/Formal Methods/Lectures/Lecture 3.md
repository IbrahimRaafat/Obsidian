# Formal Methods for System Verification: Syntax of PEPA

## Overview of Stochastic Process Algebra
- **Purpose:** Models concurrency, timing, and probabilistic behavior in systems.
- **Features:**
  - Formal semantics to derive underlying Markov processes.
  - Compositional modeling, supporting modular design and reusability.

## Key Concepts in PEPA (Performance Evaluation Process Algebra)
- **Components:** Active units in the system.
- **Activities:** Actions performed by components, defined as \( (\alpha, r) \):
  - \( \alpha \): Action type.
  - \( r \): Activity rate (exponentially distributed duration).
- **Cooperation:** Interaction between components.

### Special Cases
- **Unknown Type (\( \tau \)):** Represents private or unimportant actions.
- **Activity Rate (\( > \)):** Unspecified rate.

## Syntax of PEPA
- **Sequential Components:**
  - \( S ::= (\alpha, r).S \ | \ S_1 + S_2 \ | \ A \)
- **Cooperating Components:**
  - \( C ::= C_1 \mathbin{\|_L} C_2 \ | \ C/L \ | \ S \)
- **Key Operators:**
  - **Prefix (\( (\alpha, r).S \)):** Component performs activity \( (\alpha, r) \) and transitions to \( S \).
  - **Choice (\( S_1 + S_2 \)):** Competing components; only one completes.
  - **Cooperation (\( C_1 \mathbin{\|_L} C_2 \)):** Components synchronize on actions in set \( L \).

## Informal Semantics
- **Timing Behavior:**
  - Activity durations follow exponential distributions, representing delays and uncertainty.
- **Competing Activities:**
  - Enabled activities set timers; the fastest completes while others are preempted.
- **Implicit Resources:**
  - Activity completion uses resources like bandwidth or CPU cycles.

### Cooperation Details
- **Shared Activities:** Enabled only when both components in \( L \) are ready.
- **Passive Components:** Activities with unspecified rates (\( > \)) do not contribute to work.
- **Parallel Composition:** \( C_1 || C_2 \) for independent execution.

### Hiding
- **Syntax:** \( C/L \) hides activities of type \( L \), replacing them with \( \tau \).
- **Effect:** Hidden activities are internal and cannot cooperate with others.

## Race Conditions
- **Definition:** When multiple activities compete, the fastest succeeds.
- **Probabilities:** Based on activity rates relative to the sum of all enabled rates.

## Example: Probabilistic Outcomes
- If an action \( \alpha \) with rate \( r \) leads to:
  - \( 1/3 \) probability of \( P \): \( (\alpha, r/3).P \)
  - \( 2/3 \) probability of \( Q \): \( (\alpha, 2r/3).Q \)

## Operator Precedence
1. **Hiding:** \( P/L \)
2. **Prefix:** \( (\alpha, r).P \)
3. **Cooperation:** \( P \mathbin{\|_L} Q \)
4. **Choice:** \( P + Q \)

### Example:
- \( P \mathbin{\|_L} Q \mathbin{\|_M} R \) associates left: \( (P \mathbin{\|_L} Q) \mathbin{\|_M} R \).

**Reference:** Formal Methods for System Verification, Sabina Rossi
	