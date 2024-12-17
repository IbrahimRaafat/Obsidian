# Formal Methods for System Verification

## Key Concepts
- **Model Construction:** Models represent system behaviors and help investigate performance.
- **Discrete Event Systems:** State changes are triggered by discrete events (e.g., customer arrivals).
  - **Discrete vs. Continuous Time:**
    - **Discrete Time:** Focuses on specific intervals (e.g., clock ticks).
    - **Continuous Time:** Accounts for events as they occur, suitable for communication systems.

## Performance Modeling
- **Objective:** Understand and optimize system performance.
- **Applications:**
  - Capacity planning (e.g., server support for clients).
  - System tuning (e.g., minimizing robot idle time).
  - Sustainable energy planning (e.g., optimizing transmission radius).
  - Scalability and robustness analysis (e.g., handling DDoS attacks).
- **Challenges:**
  - Time representation, randomness, probabilities, scale, and resource sharing.

## Quantitative vs. Qualitative Modeling
- **Quantitative Modeling:** Focuses on explicit metrics like time and probability.
- **Qualitative Modeling:** Abstracts metrics, focusing on correctness (e.g., avoiding deadlocks).

## Process Algebras
- **Definition:** Frameworks modeling concurrent systems.
- **Examples:**
  - **CCS:** Calculus of Communicating Systems.
  - **CSP:** Communicating Sequential Processes.
  - **PEPA:** Performance Evaluation Process Algebra.
- **Use:** For performance modeling and system design integration.

## Integrated Analysis
- Combines qualitative and quantitative verification:
  - **Reachability Analysis:** Time to reach a specific state.
  - **Model Checking:** Verifying properties with probabilities.

## PEPA Project
- **Origin:** Started in Edinburgh (1991).
- **Objective:** Simplify complex systems with compositional modeling.
- **Output:** A stochastic process algebra for performance analysis.

## Practical Applications
- Balancing user needs (e.g., faster response times) and system constraints (e.g., resource utilization).
- Trade-offs in design and operation.

**Reference:** [PEPA Project Resources](http://www.dcs.ed.ac.uk/pepa/)
